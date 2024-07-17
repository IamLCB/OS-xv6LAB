#include "kernel/types.h"
#include "kernel/fcntl.h"
#include "kernel/fs.h"
#include "kernel/stat.h"
#include "user/user.h"

#define MAX_PATH_LEN 256
typedef enum
{
    false,
    true
} bool;

// Function to check if the filename matches the target file
// This function extracts the last component of the directory path
// and compares it with the target filename.
bool match(const char *dirs, const char *file)
{
    const char *p = dirs + strlen(dirs);
    char formated_dirs[MAX_PATH_LEN];
    while (*p != '/') // Find the last '/' in the path
        p--;
    strcpy(formated_dirs, ++p);          // Copy the filename after the last '/'
    return !strcmp(formated_dirs, file); // Compare with the target filename
}

// Recursive function to find the target file in the directory tree
// This function traverses the directory structure and searches for the file.
void find(const char *dir, const char *file)
{
    int fd;
    if ((fd = open(dir, O_RDONLY)) < 0)
    { // Open the directory
        fprintf(2, "find: cannot open %s\n", dir);
        return;
    }

    struct stat st;
    if (fstat(fd, &st) < 0)
    { // Get directory status
        fprintf(2, "find: cannot stat %s\n", dir);
        close(fd);
        return;
    }

    if (st.type != T_DIR)
    { // If it's not a directory, return
        close(fd);
        return;
    }

    char dirs[MAX_PATH_LEN]; // Buffer to store the directory path
    struct dirent de;
    strcpy(dirs, dir); // Copy the current directory path
    char *p = dirs + strlen(dirs);
    *p++ = '/'; // Append '/' to the directory path

    // Read directory entries
    while (read(fd, &de, sizeof(de)) == sizeof(de))
    {
        // Skip empty entries and '.' and '..' directories
        if (de.inum == 0 || !strcmp(de.name, ".") || !strcmp(de.name, ".."))
            continue;

        // Copy the directory entry name to the path buffer
        memmove(p, de.name, DIRSIZ);
        p[DIRSIZ] = 0;

        if (stat(dirs, &st) < 0)
        { // Get entry status
            fprintf(2, "find: cannot stat %s\n", dirs);
            continue;
        }

        if (st.type == T_FILE && match(dirs, file))
        {                         // If it's a file and matches
            printf("%s\n", dirs); // Print the file path
        }
        else if (st.type == T_DIR)
        {                     // If it's a directory
            find(dirs, file); // Recur into the directory
        }
    }

    close(fd); // Close the directory
}

int main(int argc, char **argv)
{
    if (argc != 3)
    { // Check for correct number of arguments
        fprintf(2, "Usage: find [dir] [file]\n");
        exit(1);
    }
    find(argv[1], argv[2]); // Call the find function with the provided arguments
    exit(0);
}
