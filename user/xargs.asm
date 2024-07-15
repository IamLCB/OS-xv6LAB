
user/_xargs:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <getOneLine>:
#include "user/user.h"
#include <stddef.h>

// Function to read one line from standard input
int getOneLine(char *buf)
{
   0:	7139                	addi	sp,sp,-64
   2:	fc06                	sd	ra,56(sp)
   4:	f822                	sd	s0,48(sp)
   6:	f426                	sd	s1,40(sp)
   8:	f04a                	sd	s2,32(sp)
   a:	ec4e                	sd	s3,24(sp)
   c:	0080                	addi	s0,sp,64
   e:	89aa                	mv	s3,a0
    char ch;
    char *str = buf;
    while (read(0, &ch, 1) == 1 && ch != '\n')
  10:	84aa                	mv	s1,a0
  12:	4929                	li	s2,10
  14:	a021                	j	1c <getOneLine+0x1c>
        *buf++ = ch;
  16:	0485                	addi	s1,s1,1
  18:	fef48fa3          	sb	a5,-1(s1)
    while (read(0, &ch, 1) == 1 && ch != '\n')
  1c:	4605                	li	a2,1
  1e:	fcf40593          	addi	a1,s0,-49
  22:	4501                	li	a0,0
  24:	00000097          	auipc	ra,0x0
  28:	3a2080e7          	jalr	930(ra) # 3c6 <read>
  2c:	4785                	li	a5,1
  2e:	00f51663          	bne	a0,a5,3a <getOneLine+0x3a>
  32:	fcf44783          	lbu	a5,-49(s0)
  36:	ff2790e3          	bne	a5,s2,16 <getOneLine+0x16>
    *buf = 0; // Null-terminate the string
  3a:	00048023          	sb	zero,0(s1)
    return strlen(str);
  3e:	854e                	mv	a0,s3
  40:	00000097          	auipc	ra,0x0
  44:	14a080e7          	jalr	330(ra) # 18a <strlen>
}
  48:	2501                	sext.w	a0,a0
  4a:	70e2                	ld	ra,56(sp)
  4c:	7442                	ld	s0,48(sp)
  4e:	74a2                	ld	s1,40(sp)
  50:	7902                	ld	s2,32(sp)
  52:	69e2                	ld	s3,24(sp)
  54:	6121                	addi	sp,sp,64
  56:	8082                	ret

0000000000000058 <main>:

int main(int argc, char **argv)
{
  58:	7125                	addi	sp,sp,-416
  5a:	ef06                	sd	ra,408(sp)
  5c:	eb22                	sd	s0,400(sp)
  5e:	e34a                	sd	s2,384(sp)
  60:	1300                	addi	s0,sp,416
  62:	892e                	mv	s2,a1
    if (argc < 2)
  64:	4785                	li	a5,1
  66:	04a7dd63          	bge	a5,a0,c0 <main+0x68>
  6a:	e726                	sd	s1,392(sp)
  6c:	00858713          	addi	a4,a1,8
  70:	ee040793          	addi	a5,s0,-288
  74:	ffe5061b          	addiw	a2,a0,-2
  78:	02061693          	slli	a3,a2,0x20
  7c:	01d6d613          	srli	a2,a3,0x1d
  80:	ee840693          	addi	a3,s0,-280
  84:	9636                	add	a2,a2,a3
    }

    char *args[MAXARG];
    for (int i = 1; i < argc; i++)
    {
        args[i - 1] = argv[i];
  86:	6314                	ld	a3,0(a4)
  88:	e394                	sd	a3,0(a5)
    for (int i = 1; i < argc; i++)
  8a:	0721                	addi	a4,a4,8
  8c:	07a1                	addi	a5,a5,8
  8e:	fec79ce3          	bne	a5,a2,86 <main+0x2e>
    }
    args[argc - 1] = NULL; // Ensure the array is properly null-terminated
  92:	fff5049b          	addiw	s1,a0,-1
  96:	00349793          	slli	a5,s1,0x3
  9a:	1781                	addi	a5,a5,-32
  9c:	97a2                	add	a5,a5,s0
  9e:	f007b023          	sd	zero,-256(a5)

    char buf[MAXPATH] = {0};
  a2:	08000613          	li	a2,128
  a6:	4581                	li	a1,0
  a8:	e6040513          	addi	a0,s0,-416
  ac:	00000097          	auipc	ra,0x0
  b0:	108080e7          	jalr	264(ra) # 1b4 <memset>
    while (getOneLine(buf) > 0)
    {                         // Check if line length is greater than zero
        args[argc - 1] = buf; // Set the last command argument to the input line
  b4:	048e                	slli	s1,s1,0x3
  b6:	fe048793          	addi	a5,s1,-32
  ba:	008784b3          	add	s1,a5,s0
    while (getOneLine(buf) > 0)
  be:	a83d                	j	fc <main+0xa4>
  c0:	e726                	sd	s1,392(sp)
        fprintf(2, "Usage: %s command [args...]\n", argv[0]); // Provide more helpful error message
  c2:	6190                	ld	a2,0(a1)
  c4:	00001597          	auipc	a1,0x1
  c8:	80c58593          	addi	a1,a1,-2036 # 8d0 <malloc+0x102>
  cc:	4509                	li	a0,2
  ce:	00000097          	auipc	ra,0x0
  d2:	61a080e7          	jalr	1562(ra) # 6e8 <fprintf>
        exit(1);
  d6:	4505                	li	a0,1
  d8:	00000097          	auipc	ra,0x0
  dc:	2d6080e7          	jalr	726(ra) # 3ae <exit>
        if (fork() == 0)
        {
            exec(argv[1], args); // Execute the command in the child process
            exit(0);
        }
        wait(0);                 // Parent waits for the child to finish
  e0:	4501                	li	a0,0
  e2:	00000097          	auipc	ra,0x0
  e6:	2d4080e7          	jalr	724(ra) # 3b6 <wait>
        memset(buf, 0, MAXPATH); // Clear the buffer for the next input
  ea:	08000613          	li	a2,128
  ee:	4581                	li	a1,0
  f0:	e6040513          	addi	a0,s0,-416
  f4:	00000097          	auipc	ra,0x0
  f8:	0c0080e7          	jalr	192(ra) # 1b4 <memset>
    while (getOneLine(buf) > 0)
  fc:	e6040513          	addi	a0,s0,-416
 100:	00000097          	auipc	ra,0x0
 104:	f00080e7          	jalr	-256(ra) # 0 <getOneLine>
 108:	02a05863          	blez	a0,138 <main+0xe0>
        args[argc - 1] = buf; // Set the last command argument to the input line
 10c:	e6040793          	addi	a5,s0,-416
 110:	f0f4b023          	sd	a5,-256(s1)
        if (fork() == 0)
 114:	00000097          	auipc	ra,0x0
 118:	292080e7          	jalr	658(ra) # 3a6 <fork>
 11c:	f171                	bnez	a0,e0 <main+0x88>
            exec(argv[1], args); // Execute the command in the child process
 11e:	ee040593          	addi	a1,s0,-288
 122:	00893503          	ld	a0,8(s2)
 126:	00000097          	auipc	ra,0x0
 12a:	2c0080e7          	jalr	704(ra) # 3e6 <exec>
            exit(0);
 12e:	4501                	li	a0,0
 130:	00000097          	auipc	ra,0x0
 134:	27e080e7          	jalr	638(ra) # 3ae <exit>
    }
    exit(0);
 138:	4501                	li	a0,0
 13a:	00000097          	auipc	ra,0x0
 13e:	274080e7          	jalr	628(ra) # 3ae <exit>

0000000000000142 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 142:	1141                	addi	sp,sp,-16
 144:	e422                	sd	s0,8(sp)
 146:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 148:	87aa                	mv	a5,a0
 14a:	0585                	addi	a1,a1,1
 14c:	0785                	addi	a5,a5,1
 14e:	fff5c703          	lbu	a4,-1(a1)
 152:	fee78fa3          	sb	a4,-1(a5)
 156:	fb75                	bnez	a4,14a <strcpy+0x8>
    ;
  return os;
}
 158:	6422                	ld	s0,8(sp)
 15a:	0141                	addi	sp,sp,16
 15c:	8082                	ret

000000000000015e <strcmp>:

int
strcmp(const char *p, const char *q)
{
 15e:	1141                	addi	sp,sp,-16
 160:	e422                	sd	s0,8(sp)
 162:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 164:	00054783          	lbu	a5,0(a0)
 168:	cb91                	beqz	a5,17c <strcmp+0x1e>
 16a:	0005c703          	lbu	a4,0(a1)
 16e:	00f71763          	bne	a4,a5,17c <strcmp+0x1e>
    p++, q++;
 172:	0505                	addi	a0,a0,1
 174:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 176:	00054783          	lbu	a5,0(a0)
 17a:	fbe5                	bnez	a5,16a <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 17c:	0005c503          	lbu	a0,0(a1)
}
 180:	40a7853b          	subw	a0,a5,a0
 184:	6422                	ld	s0,8(sp)
 186:	0141                	addi	sp,sp,16
 188:	8082                	ret

000000000000018a <strlen>:

uint
strlen(const char *s)
{
 18a:	1141                	addi	sp,sp,-16
 18c:	e422                	sd	s0,8(sp)
 18e:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 190:	00054783          	lbu	a5,0(a0)
 194:	cf91                	beqz	a5,1b0 <strlen+0x26>
 196:	0505                	addi	a0,a0,1
 198:	87aa                	mv	a5,a0
 19a:	86be                	mv	a3,a5
 19c:	0785                	addi	a5,a5,1
 19e:	fff7c703          	lbu	a4,-1(a5)
 1a2:	ff65                	bnez	a4,19a <strlen+0x10>
 1a4:	40a6853b          	subw	a0,a3,a0
 1a8:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 1aa:	6422                	ld	s0,8(sp)
 1ac:	0141                	addi	sp,sp,16
 1ae:	8082                	ret
  for(n = 0; s[n]; n++)
 1b0:	4501                	li	a0,0
 1b2:	bfe5                	j	1aa <strlen+0x20>

00000000000001b4 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1b4:	1141                	addi	sp,sp,-16
 1b6:	e422                	sd	s0,8(sp)
 1b8:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 1ba:	ca19                	beqz	a2,1d0 <memset+0x1c>
 1bc:	87aa                	mv	a5,a0
 1be:	1602                	slli	a2,a2,0x20
 1c0:	9201                	srli	a2,a2,0x20
 1c2:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 1c6:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 1ca:	0785                	addi	a5,a5,1
 1cc:	fee79de3          	bne	a5,a4,1c6 <memset+0x12>
  }
  return dst;
}
 1d0:	6422                	ld	s0,8(sp)
 1d2:	0141                	addi	sp,sp,16
 1d4:	8082                	ret

00000000000001d6 <strchr>:

char*
strchr(const char *s, char c)
{
 1d6:	1141                	addi	sp,sp,-16
 1d8:	e422                	sd	s0,8(sp)
 1da:	0800                	addi	s0,sp,16
  for(; *s; s++)
 1dc:	00054783          	lbu	a5,0(a0)
 1e0:	cb99                	beqz	a5,1f6 <strchr+0x20>
    if(*s == c)
 1e2:	00f58763          	beq	a1,a5,1f0 <strchr+0x1a>
  for(; *s; s++)
 1e6:	0505                	addi	a0,a0,1
 1e8:	00054783          	lbu	a5,0(a0)
 1ec:	fbfd                	bnez	a5,1e2 <strchr+0xc>
      return (char*)s;
  return 0;
 1ee:	4501                	li	a0,0
}
 1f0:	6422                	ld	s0,8(sp)
 1f2:	0141                	addi	sp,sp,16
 1f4:	8082                	ret
  return 0;
 1f6:	4501                	li	a0,0
 1f8:	bfe5                	j	1f0 <strchr+0x1a>

00000000000001fa <gets>:

char*
gets(char *buf, int max)
{
 1fa:	711d                	addi	sp,sp,-96
 1fc:	ec86                	sd	ra,88(sp)
 1fe:	e8a2                	sd	s0,80(sp)
 200:	e4a6                	sd	s1,72(sp)
 202:	e0ca                	sd	s2,64(sp)
 204:	fc4e                	sd	s3,56(sp)
 206:	f852                	sd	s4,48(sp)
 208:	f456                	sd	s5,40(sp)
 20a:	f05a                	sd	s6,32(sp)
 20c:	ec5e                	sd	s7,24(sp)
 20e:	1080                	addi	s0,sp,96
 210:	8baa                	mv	s7,a0
 212:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 214:	892a                	mv	s2,a0
 216:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 218:	4aa9                	li	s5,10
 21a:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 21c:	89a6                	mv	s3,s1
 21e:	2485                	addiw	s1,s1,1
 220:	0344d863          	bge	s1,s4,250 <gets+0x56>
    cc = read(0, &c, 1);
 224:	4605                	li	a2,1
 226:	faf40593          	addi	a1,s0,-81
 22a:	4501                	li	a0,0
 22c:	00000097          	auipc	ra,0x0
 230:	19a080e7          	jalr	410(ra) # 3c6 <read>
    if(cc < 1)
 234:	00a05e63          	blez	a0,250 <gets+0x56>
    buf[i++] = c;
 238:	faf44783          	lbu	a5,-81(s0)
 23c:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 240:	01578763          	beq	a5,s5,24e <gets+0x54>
 244:	0905                	addi	s2,s2,1
 246:	fd679be3          	bne	a5,s6,21c <gets+0x22>
    buf[i++] = c;
 24a:	89a6                	mv	s3,s1
 24c:	a011                	j	250 <gets+0x56>
 24e:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 250:	99de                	add	s3,s3,s7
 252:	00098023          	sb	zero,0(s3)
  return buf;
}
 256:	855e                	mv	a0,s7
 258:	60e6                	ld	ra,88(sp)
 25a:	6446                	ld	s0,80(sp)
 25c:	64a6                	ld	s1,72(sp)
 25e:	6906                	ld	s2,64(sp)
 260:	79e2                	ld	s3,56(sp)
 262:	7a42                	ld	s4,48(sp)
 264:	7aa2                	ld	s5,40(sp)
 266:	7b02                	ld	s6,32(sp)
 268:	6be2                	ld	s7,24(sp)
 26a:	6125                	addi	sp,sp,96
 26c:	8082                	ret

000000000000026e <stat>:

int
stat(const char *n, struct stat *st)
{
 26e:	1101                	addi	sp,sp,-32
 270:	ec06                	sd	ra,24(sp)
 272:	e822                	sd	s0,16(sp)
 274:	e04a                	sd	s2,0(sp)
 276:	1000                	addi	s0,sp,32
 278:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 27a:	4581                	li	a1,0
 27c:	00000097          	auipc	ra,0x0
 280:	172080e7          	jalr	370(ra) # 3ee <open>
  if(fd < 0)
 284:	02054663          	bltz	a0,2b0 <stat+0x42>
 288:	e426                	sd	s1,8(sp)
 28a:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 28c:	85ca                	mv	a1,s2
 28e:	00000097          	auipc	ra,0x0
 292:	178080e7          	jalr	376(ra) # 406 <fstat>
 296:	892a                	mv	s2,a0
  close(fd);
 298:	8526                	mv	a0,s1
 29a:	00000097          	auipc	ra,0x0
 29e:	13c080e7          	jalr	316(ra) # 3d6 <close>
  return r;
 2a2:	64a2                	ld	s1,8(sp)
}
 2a4:	854a                	mv	a0,s2
 2a6:	60e2                	ld	ra,24(sp)
 2a8:	6442                	ld	s0,16(sp)
 2aa:	6902                	ld	s2,0(sp)
 2ac:	6105                	addi	sp,sp,32
 2ae:	8082                	ret
    return -1;
 2b0:	597d                	li	s2,-1
 2b2:	bfcd                	j	2a4 <stat+0x36>

00000000000002b4 <atoi>:

int
atoi(const char *s)
{
 2b4:	1141                	addi	sp,sp,-16
 2b6:	e422                	sd	s0,8(sp)
 2b8:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2ba:	00054683          	lbu	a3,0(a0)
 2be:	fd06879b          	addiw	a5,a3,-48
 2c2:	0ff7f793          	zext.b	a5,a5
 2c6:	4625                	li	a2,9
 2c8:	02f66863          	bltu	a2,a5,2f8 <atoi+0x44>
 2cc:	872a                	mv	a4,a0
  n = 0;
 2ce:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 2d0:	0705                	addi	a4,a4,1
 2d2:	0025179b          	slliw	a5,a0,0x2
 2d6:	9fa9                	addw	a5,a5,a0
 2d8:	0017979b          	slliw	a5,a5,0x1
 2dc:	9fb5                	addw	a5,a5,a3
 2de:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2e2:	00074683          	lbu	a3,0(a4)
 2e6:	fd06879b          	addiw	a5,a3,-48
 2ea:	0ff7f793          	zext.b	a5,a5
 2ee:	fef671e3          	bgeu	a2,a5,2d0 <atoi+0x1c>
  return n;
}
 2f2:	6422                	ld	s0,8(sp)
 2f4:	0141                	addi	sp,sp,16
 2f6:	8082                	ret
  n = 0;
 2f8:	4501                	li	a0,0
 2fa:	bfe5                	j	2f2 <atoi+0x3e>

00000000000002fc <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2fc:	1141                	addi	sp,sp,-16
 2fe:	e422                	sd	s0,8(sp)
 300:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 302:	02b57463          	bgeu	a0,a1,32a <memmove+0x2e>
    while(n-- > 0)
 306:	00c05f63          	blez	a2,324 <memmove+0x28>
 30a:	1602                	slli	a2,a2,0x20
 30c:	9201                	srli	a2,a2,0x20
 30e:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 312:	872a                	mv	a4,a0
      *dst++ = *src++;
 314:	0585                	addi	a1,a1,1
 316:	0705                	addi	a4,a4,1
 318:	fff5c683          	lbu	a3,-1(a1)
 31c:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 320:	fef71ae3          	bne	a4,a5,314 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 324:	6422                	ld	s0,8(sp)
 326:	0141                	addi	sp,sp,16
 328:	8082                	ret
    dst += n;
 32a:	00c50733          	add	a4,a0,a2
    src += n;
 32e:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 330:	fec05ae3          	blez	a2,324 <memmove+0x28>
 334:	fff6079b          	addiw	a5,a2,-1
 338:	1782                	slli	a5,a5,0x20
 33a:	9381                	srli	a5,a5,0x20
 33c:	fff7c793          	not	a5,a5
 340:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 342:	15fd                	addi	a1,a1,-1
 344:	177d                	addi	a4,a4,-1
 346:	0005c683          	lbu	a3,0(a1)
 34a:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 34e:	fee79ae3          	bne	a5,a4,342 <memmove+0x46>
 352:	bfc9                	j	324 <memmove+0x28>

0000000000000354 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 354:	1141                	addi	sp,sp,-16
 356:	e422                	sd	s0,8(sp)
 358:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 35a:	ca05                	beqz	a2,38a <memcmp+0x36>
 35c:	fff6069b          	addiw	a3,a2,-1
 360:	1682                	slli	a3,a3,0x20
 362:	9281                	srli	a3,a3,0x20
 364:	0685                	addi	a3,a3,1
 366:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 368:	00054783          	lbu	a5,0(a0)
 36c:	0005c703          	lbu	a4,0(a1)
 370:	00e79863          	bne	a5,a4,380 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 374:	0505                	addi	a0,a0,1
    p2++;
 376:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 378:	fed518e3          	bne	a0,a3,368 <memcmp+0x14>
  }
  return 0;
 37c:	4501                	li	a0,0
 37e:	a019                	j	384 <memcmp+0x30>
      return *p1 - *p2;
 380:	40e7853b          	subw	a0,a5,a4
}
 384:	6422                	ld	s0,8(sp)
 386:	0141                	addi	sp,sp,16
 388:	8082                	ret
  return 0;
 38a:	4501                	li	a0,0
 38c:	bfe5                	j	384 <memcmp+0x30>

000000000000038e <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 38e:	1141                	addi	sp,sp,-16
 390:	e406                	sd	ra,8(sp)
 392:	e022                	sd	s0,0(sp)
 394:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 396:	00000097          	auipc	ra,0x0
 39a:	f66080e7          	jalr	-154(ra) # 2fc <memmove>
}
 39e:	60a2                	ld	ra,8(sp)
 3a0:	6402                	ld	s0,0(sp)
 3a2:	0141                	addi	sp,sp,16
 3a4:	8082                	ret

00000000000003a6 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3a6:	4885                	li	a7,1
 ecall
 3a8:	00000073          	ecall
 ret
 3ac:	8082                	ret

00000000000003ae <exit>:
.global exit
exit:
 li a7, SYS_exit
 3ae:	4889                	li	a7,2
 ecall
 3b0:	00000073          	ecall
 ret
 3b4:	8082                	ret

00000000000003b6 <wait>:
.global wait
wait:
 li a7, SYS_wait
 3b6:	488d                	li	a7,3
 ecall
 3b8:	00000073          	ecall
 ret
 3bc:	8082                	ret

00000000000003be <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3be:	4891                	li	a7,4
 ecall
 3c0:	00000073          	ecall
 ret
 3c4:	8082                	ret

00000000000003c6 <read>:
.global read
read:
 li a7, SYS_read
 3c6:	4895                	li	a7,5
 ecall
 3c8:	00000073          	ecall
 ret
 3cc:	8082                	ret

00000000000003ce <write>:
.global write
write:
 li a7, SYS_write
 3ce:	48c1                	li	a7,16
 ecall
 3d0:	00000073          	ecall
 ret
 3d4:	8082                	ret

00000000000003d6 <close>:
.global close
close:
 li a7, SYS_close
 3d6:	48d5                	li	a7,21
 ecall
 3d8:	00000073          	ecall
 ret
 3dc:	8082                	ret

00000000000003de <kill>:
.global kill
kill:
 li a7, SYS_kill
 3de:	4899                	li	a7,6
 ecall
 3e0:	00000073          	ecall
 ret
 3e4:	8082                	ret

00000000000003e6 <exec>:
.global exec
exec:
 li a7, SYS_exec
 3e6:	489d                	li	a7,7
 ecall
 3e8:	00000073          	ecall
 ret
 3ec:	8082                	ret

00000000000003ee <open>:
.global open
open:
 li a7, SYS_open
 3ee:	48bd                	li	a7,15
 ecall
 3f0:	00000073          	ecall
 ret
 3f4:	8082                	ret

00000000000003f6 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3f6:	48c5                	li	a7,17
 ecall
 3f8:	00000073          	ecall
 ret
 3fc:	8082                	ret

00000000000003fe <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3fe:	48c9                	li	a7,18
 ecall
 400:	00000073          	ecall
 ret
 404:	8082                	ret

0000000000000406 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 406:	48a1                	li	a7,8
 ecall
 408:	00000073          	ecall
 ret
 40c:	8082                	ret

000000000000040e <link>:
.global link
link:
 li a7, SYS_link
 40e:	48cd                	li	a7,19
 ecall
 410:	00000073          	ecall
 ret
 414:	8082                	ret

0000000000000416 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 416:	48d1                	li	a7,20
 ecall
 418:	00000073          	ecall
 ret
 41c:	8082                	ret

000000000000041e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 41e:	48a5                	li	a7,9
 ecall
 420:	00000073          	ecall
 ret
 424:	8082                	ret

0000000000000426 <dup>:
.global dup
dup:
 li a7, SYS_dup
 426:	48a9                	li	a7,10
 ecall
 428:	00000073          	ecall
 ret
 42c:	8082                	ret

000000000000042e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 42e:	48ad                	li	a7,11
 ecall
 430:	00000073          	ecall
 ret
 434:	8082                	ret

0000000000000436 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 436:	48b1                	li	a7,12
 ecall
 438:	00000073          	ecall
 ret
 43c:	8082                	ret

000000000000043e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 43e:	48b5                	li	a7,13
 ecall
 440:	00000073          	ecall
 ret
 444:	8082                	ret

0000000000000446 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 446:	48b9                	li	a7,14
 ecall
 448:	00000073          	ecall
 ret
 44c:	8082                	ret

000000000000044e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 44e:	1101                	addi	sp,sp,-32
 450:	ec06                	sd	ra,24(sp)
 452:	e822                	sd	s0,16(sp)
 454:	1000                	addi	s0,sp,32
 456:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 45a:	4605                	li	a2,1
 45c:	fef40593          	addi	a1,s0,-17
 460:	00000097          	auipc	ra,0x0
 464:	f6e080e7          	jalr	-146(ra) # 3ce <write>
}
 468:	60e2                	ld	ra,24(sp)
 46a:	6442                	ld	s0,16(sp)
 46c:	6105                	addi	sp,sp,32
 46e:	8082                	ret

0000000000000470 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 470:	7139                	addi	sp,sp,-64
 472:	fc06                	sd	ra,56(sp)
 474:	f822                	sd	s0,48(sp)
 476:	f426                	sd	s1,40(sp)
 478:	0080                	addi	s0,sp,64
 47a:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 47c:	c299                	beqz	a3,482 <printint+0x12>
 47e:	0805cb63          	bltz	a1,514 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 482:	2581                	sext.w	a1,a1
  neg = 0;
 484:	4881                	li	a7,0
 486:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 48a:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 48c:	2601                	sext.w	a2,a2
 48e:	00000517          	auipc	a0,0x0
 492:	4c250513          	addi	a0,a0,1218 # 950 <digits>
 496:	883a                	mv	a6,a4
 498:	2705                	addiw	a4,a4,1
 49a:	02c5f7bb          	remuw	a5,a1,a2
 49e:	1782                	slli	a5,a5,0x20
 4a0:	9381                	srli	a5,a5,0x20
 4a2:	97aa                	add	a5,a5,a0
 4a4:	0007c783          	lbu	a5,0(a5)
 4a8:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 4ac:	0005879b          	sext.w	a5,a1
 4b0:	02c5d5bb          	divuw	a1,a1,a2
 4b4:	0685                	addi	a3,a3,1
 4b6:	fec7f0e3          	bgeu	a5,a2,496 <printint+0x26>
  if(neg)
 4ba:	00088c63          	beqz	a7,4d2 <printint+0x62>
    buf[i++] = '-';
 4be:	fd070793          	addi	a5,a4,-48
 4c2:	00878733          	add	a4,a5,s0
 4c6:	02d00793          	li	a5,45
 4ca:	fef70823          	sb	a5,-16(a4)
 4ce:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 4d2:	02e05c63          	blez	a4,50a <printint+0x9a>
 4d6:	f04a                	sd	s2,32(sp)
 4d8:	ec4e                	sd	s3,24(sp)
 4da:	fc040793          	addi	a5,s0,-64
 4de:	00e78933          	add	s2,a5,a4
 4e2:	fff78993          	addi	s3,a5,-1
 4e6:	99ba                	add	s3,s3,a4
 4e8:	377d                	addiw	a4,a4,-1
 4ea:	1702                	slli	a4,a4,0x20
 4ec:	9301                	srli	a4,a4,0x20
 4ee:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 4f2:	fff94583          	lbu	a1,-1(s2)
 4f6:	8526                	mv	a0,s1
 4f8:	00000097          	auipc	ra,0x0
 4fc:	f56080e7          	jalr	-170(ra) # 44e <putc>
  while(--i >= 0)
 500:	197d                	addi	s2,s2,-1
 502:	ff3918e3          	bne	s2,s3,4f2 <printint+0x82>
 506:	7902                	ld	s2,32(sp)
 508:	69e2                	ld	s3,24(sp)
}
 50a:	70e2                	ld	ra,56(sp)
 50c:	7442                	ld	s0,48(sp)
 50e:	74a2                	ld	s1,40(sp)
 510:	6121                	addi	sp,sp,64
 512:	8082                	ret
    x = -xx;
 514:	40b005bb          	negw	a1,a1
    neg = 1;
 518:	4885                	li	a7,1
    x = -xx;
 51a:	b7b5                	j	486 <printint+0x16>

000000000000051c <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 51c:	715d                	addi	sp,sp,-80
 51e:	e486                	sd	ra,72(sp)
 520:	e0a2                	sd	s0,64(sp)
 522:	f84a                	sd	s2,48(sp)
 524:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 526:	0005c903          	lbu	s2,0(a1)
 52a:	1a090a63          	beqz	s2,6de <vprintf+0x1c2>
 52e:	fc26                	sd	s1,56(sp)
 530:	f44e                	sd	s3,40(sp)
 532:	f052                	sd	s4,32(sp)
 534:	ec56                	sd	s5,24(sp)
 536:	e85a                	sd	s6,16(sp)
 538:	e45e                	sd	s7,8(sp)
 53a:	8aaa                	mv	s5,a0
 53c:	8bb2                	mv	s7,a2
 53e:	00158493          	addi	s1,a1,1
  state = 0;
 542:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 544:	02500a13          	li	s4,37
 548:	4b55                	li	s6,21
 54a:	a839                	j	568 <vprintf+0x4c>
        putc(fd, c);
 54c:	85ca                	mv	a1,s2
 54e:	8556                	mv	a0,s5
 550:	00000097          	auipc	ra,0x0
 554:	efe080e7          	jalr	-258(ra) # 44e <putc>
 558:	a019                	j	55e <vprintf+0x42>
    } else if(state == '%'){
 55a:	01498d63          	beq	s3,s4,574 <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 55e:	0485                	addi	s1,s1,1
 560:	fff4c903          	lbu	s2,-1(s1)
 564:	16090763          	beqz	s2,6d2 <vprintf+0x1b6>
    if(state == 0){
 568:	fe0999e3          	bnez	s3,55a <vprintf+0x3e>
      if(c == '%'){
 56c:	ff4910e3          	bne	s2,s4,54c <vprintf+0x30>
        state = '%';
 570:	89d2                	mv	s3,s4
 572:	b7f5                	j	55e <vprintf+0x42>
      if(c == 'd'){
 574:	13490463          	beq	s2,s4,69c <vprintf+0x180>
 578:	f9d9079b          	addiw	a5,s2,-99
 57c:	0ff7f793          	zext.b	a5,a5
 580:	12fb6763          	bltu	s6,a5,6ae <vprintf+0x192>
 584:	f9d9079b          	addiw	a5,s2,-99
 588:	0ff7f713          	zext.b	a4,a5
 58c:	12eb6163          	bltu	s6,a4,6ae <vprintf+0x192>
 590:	00271793          	slli	a5,a4,0x2
 594:	00000717          	auipc	a4,0x0
 598:	36470713          	addi	a4,a4,868 # 8f8 <malloc+0x12a>
 59c:	97ba                	add	a5,a5,a4
 59e:	439c                	lw	a5,0(a5)
 5a0:	97ba                	add	a5,a5,a4
 5a2:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 5a4:	008b8913          	addi	s2,s7,8
 5a8:	4685                	li	a3,1
 5aa:	4629                	li	a2,10
 5ac:	000ba583          	lw	a1,0(s7)
 5b0:	8556                	mv	a0,s5
 5b2:	00000097          	auipc	ra,0x0
 5b6:	ebe080e7          	jalr	-322(ra) # 470 <printint>
 5ba:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5bc:	4981                	li	s3,0
 5be:	b745                	j	55e <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5c0:	008b8913          	addi	s2,s7,8
 5c4:	4681                	li	a3,0
 5c6:	4629                	li	a2,10
 5c8:	000ba583          	lw	a1,0(s7)
 5cc:	8556                	mv	a0,s5
 5ce:	00000097          	auipc	ra,0x0
 5d2:	ea2080e7          	jalr	-350(ra) # 470 <printint>
 5d6:	8bca                	mv	s7,s2
      state = 0;
 5d8:	4981                	li	s3,0
 5da:	b751                	j	55e <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 5dc:	008b8913          	addi	s2,s7,8
 5e0:	4681                	li	a3,0
 5e2:	4641                	li	a2,16
 5e4:	000ba583          	lw	a1,0(s7)
 5e8:	8556                	mv	a0,s5
 5ea:	00000097          	auipc	ra,0x0
 5ee:	e86080e7          	jalr	-378(ra) # 470 <printint>
 5f2:	8bca                	mv	s7,s2
      state = 0;
 5f4:	4981                	li	s3,0
 5f6:	b7a5                	j	55e <vprintf+0x42>
 5f8:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 5fa:	008b8c13          	addi	s8,s7,8
 5fe:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 602:	03000593          	li	a1,48
 606:	8556                	mv	a0,s5
 608:	00000097          	auipc	ra,0x0
 60c:	e46080e7          	jalr	-442(ra) # 44e <putc>
  putc(fd, 'x');
 610:	07800593          	li	a1,120
 614:	8556                	mv	a0,s5
 616:	00000097          	auipc	ra,0x0
 61a:	e38080e7          	jalr	-456(ra) # 44e <putc>
 61e:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 620:	00000b97          	auipc	s7,0x0
 624:	330b8b93          	addi	s7,s7,816 # 950 <digits>
 628:	03c9d793          	srli	a5,s3,0x3c
 62c:	97de                	add	a5,a5,s7
 62e:	0007c583          	lbu	a1,0(a5)
 632:	8556                	mv	a0,s5
 634:	00000097          	auipc	ra,0x0
 638:	e1a080e7          	jalr	-486(ra) # 44e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 63c:	0992                	slli	s3,s3,0x4
 63e:	397d                	addiw	s2,s2,-1
 640:	fe0914e3          	bnez	s2,628 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 644:	8be2                	mv	s7,s8
      state = 0;
 646:	4981                	li	s3,0
 648:	6c02                	ld	s8,0(sp)
 64a:	bf11                	j	55e <vprintf+0x42>
        s = va_arg(ap, char*);
 64c:	008b8993          	addi	s3,s7,8
 650:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 654:	02090163          	beqz	s2,676 <vprintf+0x15a>
        while(*s != 0){
 658:	00094583          	lbu	a1,0(s2)
 65c:	c9a5                	beqz	a1,6cc <vprintf+0x1b0>
          putc(fd, *s);
 65e:	8556                	mv	a0,s5
 660:	00000097          	auipc	ra,0x0
 664:	dee080e7          	jalr	-530(ra) # 44e <putc>
          s++;
 668:	0905                	addi	s2,s2,1
        while(*s != 0){
 66a:	00094583          	lbu	a1,0(s2)
 66e:	f9e5                	bnez	a1,65e <vprintf+0x142>
        s = va_arg(ap, char*);
 670:	8bce                	mv	s7,s3
      state = 0;
 672:	4981                	li	s3,0
 674:	b5ed                	j	55e <vprintf+0x42>
          s = "(null)";
 676:	00000917          	auipc	s2,0x0
 67a:	27a90913          	addi	s2,s2,634 # 8f0 <malloc+0x122>
        while(*s != 0){
 67e:	02800593          	li	a1,40
 682:	bff1                	j	65e <vprintf+0x142>
        putc(fd, va_arg(ap, uint));
 684:	008b8913          	addi	s2,s7,8
 688:	000bc583          	lbu	a1,0(s7)
 68c:	8556                	mv	a0,s5
 68e:	00000097          	auipc	ra,0x0
 692:	dc0080e7          	jalr	-576(ra) # 44e <putc>
 696:	8bca                	mv	s7,s2
      state = 0;
 698:	4981                	li	s3,0
 69a:	b5d1                	j	55e <vprintf+0x42>
        putc(fd, c);
 69c:	02500593          	li	a1,37
 6a0:	8556                	mv	a0,s5
 6a2:	00000097          	auipc	ra,0x0
 6a6:	dac080e7          	jalr	-596(ra) # 44e <putc>
      state = 0;
 6aa:	4981                	li	s3,0
 6ac:	bd4d                	j	55e <vprintf+0x42>
        putc(fd, '%');
 6ae:	02500593          	li	a1,37
 6b2:	8556                	mv	a0,s5
 6b4:	00000097          	auipc	ra,0x0
 6b8:	d9a080e7          	jalr	-614(ra) # 44e <putc>
        putc(fd, c);
 6bc:	85ca                	mv	a1,s2
 6be:	8556                	mv	a0,s5
 6c0:	00000097          	auipc	ra,0x0
 6c4:	d8e080e7          	jalr	-626(ra) # 44e <putc>
      state = 0;
 6c8:	4981                	li	s3,0
 6ca:	bd51                	j	55e <vprintf+0x42>
        s = va_arg(ap, char*);
 6cc:	8bce                	mv	s7,s3
      state = 0;
 6ce:	4981                	li	s3,0
 6d0:	b579                	j	55e <vprintf+0x42>
 6d2:	74e2                	ld	s1,56(sp)
 6d4:	79a2                	ld	s3,40(sp)
 6d6:	7a02                	ld	s4,32(sp)
 6d8:	6ae2                	ld	s5,24(sp)
 6da:	6b42                	ld	s6,16(sp)
 6dc:	6ba2                	ld	s7,8(sp)
    }
  }
}
 6de:	60a6                	ld	ra,72(sp)
 6e0:	6406                	ld	s0,64(sp)
 6e2:	7942                	ld	s2,48(sp)
 6e4:	6161                	addi	sp,sp,80
 6e6:	8082                	ret

00000000000006e8 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 6e8:	715d                	addi	sp,sp,-80
 6ea:	ec06                	sd	ra,24(sp)
 6ec:	e822                	sd	s0,16(sp)
 6ee:	1000                	addi	s0,sp,32
 6f0:	e010                	sd	a2,0(s0)
 6f2:	e414                	sd	a3,8(s0)
 6f4:	e818                	sd	a4,16(s0)
 6f6:	ec1c                	sd	a5,24(s0)
 6f8:	03043023          	sd	a6,32(s0)
 6fc:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 700:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 704:	8622                	mv	a2,s0
 706:	00000097          	auipc	ra,0x0
 70a:	e16080e7          	jalr	-490(ra) # 51c <vprintf>
}
 70e:	60e2                	ld	ra,24(sp)
 710:	6442                	ld	s0,16(sp)
 712:	6161                	addi	sp,sp,80
 714:	8082                	ret

0000000000000716 <printf>:

void
printf(const char *fmt, ...)
{
 716:	711d                	addi	sp,sp,-96
 718:	ec06                	sd	ra,24(sp)
 71a:	e822                	sd	s0,16(sp)
 71c:	1000                	addi	s0,sp,32
 71e:	e40c                	sd	a1,8(s0)
 720:	e810                	sd	a2,16(s0)
 722:	ec14                	sd	a3,24(s0)
 724:	f018                	sd	a4,32(s0)
 726:	f41c                	sd	a5,40(s0)
 728:	03043823          	sd	a6,48(s0)
 72c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 730:	00840613          	addi	a2,s0,8
 734:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 738:	85aa                	mv	a1,a0
 73a:	4505                	li	a0,1
 73c:	00000097          	auipc	ra,0x0
 740:	de0080e7          	jalr	-544(ra) # 51c <vprintf>
}
 744:	60e2                	ld	ra,24(sp)
 746:	6442                	ld	s0,16(sp)
 748:	6125                	addi	sp,sp,96
 74a:	8082                	ret

000000000000074c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 74c:	1141                	addi	sp,sp,-16
 74e:	e422                	sd	s0,8(sp)
 750:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 752:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 756:	00000797          	auipc	a5,0x0
 75a:	6027b783          	ld	a5,1538(a5) # d58 <freep>
 75e:	a02d                	j	788 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 760:	4618                	lw	a4,8(a2)
 762:	9f2d                	addw	a4,a4,a1
 764:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 768:	6398                	ld	a4,0(a5)
 76a:	6310                	ld	a2,0(a4)
 76c:	a83d                	j	7aa <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 76e:	ff852703          	lw	a4,-8(a0)
 772:	9f31                	addw	a4,a4,a2
 774:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 776:	ff053683          	ld	a3,-16(a0)
 77a:	a091                	j	7be <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 77c:	6398                	ld	a4,0(a5)
 77e:	00e7e463          	bltu	a5,a4,786 <free+0x3a>
 782:	00e6ea63          	bltu	a3,a4,796 <free+0x4a>
{
 786:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 788:	fed7fae3          	bgeu	a5,a3,77c <free+0x30>
 78c:	6398                	ld	a4,0(a5)
 78e:	00e6e463          	bltu	a3,a4,796 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 792:	fee7eae3          	bltu	a5,a4,786 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 796:	ff852583          	lw	a1,-8(a0)
 79a:	6390                	ld	a2,0(a5)
 79c:	02059813          	slli	a6,a1,0x20
 7a0:	01c85713          	srli	a4,a6,0x1c
 7a4:	9736                	add	a4,a4,a3
 7a6:	fae60de3          	beq	a2,a4,760 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 7aa:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 7ae:	4790                	lw	a2,8(a5)
 7b0:	02061593          	slli	a1,a2,0x20
 7b4:	01c5d713          	srli	a4,a1,0x1c
 7b8:	973e                	add	a4,a4,a5
 7ba:	fae68ae3          	beq	a3,a4,76e <free+0x22>
    p->s.ptr = bp->s.ptr;
 7be:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 7c0:	00000717          	auipc	a4,0x0
 7c4:	58f73c23          	sd	a5,1432(a4) # d58 <freep>
}
 7c8:	6422                	ld	s0,8(sp)
 7ca:	0141                	addi	sp,sp,16
 7cc:	8082                	ret

00000000000007ce <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7ce:	7139                	addi	sp,sp,-64
 7d0:	fc06                	sd	ra,56(sp)
 7d2:	f822                	sd	s0,48(sp)
 7d4:	f426                	sd	s1,40(sp)
 7d6:	ec4e                	sd	s3,24(sp)
 7d8:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7da:	02051493          	slli	s1,a0,0x20
 7de:	9081                	srli	s1,s1,0x20
 7e0:	04bd                	addi	s1,s1,15
 7e2:	8091                	srli	s1,s1,0x4
 7e4:	0014899b          	addiw	s3,s1,1
 7e8:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 7ea:	00000517          	auipc	a0,0x0
 7ee:	56e53503          	ld	a0,1390(a0) # d58 <freep>
 7f2:	c915                	beqz	a0,826 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7f4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 7f6:	4798                	lw	a4,8(a5)
 7f8:	08977e63          	bgeu	a4,s1,894 <malloc+0xc6>
 7fc:	f04a                	sd	s2,32(sp)
 7fe:	e852                	sd	s4,16(sp)
 800:	e456                	sd	s5,8(sp)
 802:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 804:	8a4e                	mv	s4,s3
 806:	0009871b          	sext.w	a4,s3
 80a:	6685                	lui	a3,0x1
 80c:	00d77363          	bgeu	a4,a3,812 <malloc+0x44>
 810:	6a05                	lui	s4,0x1
 812:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 816:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 81a:	00000917          	auipc	s2,0x0
 81e:	53e90913          	addi	s2,s2,1342 # d58 <freep>
  if(p == (char*)-1)
 822:	5afd                	li	s5,-1
 824:	a091                	j	868 <malloc+0x9a>
 826:	f04a                	sd	s2,32(sp)
 828:	e852                	sd	s4,16(sp)
 82a:	e456                	sd	s5,8(sp)
 82c:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 82e:	00000797          	auipc	a5,0x0
 832:	53278793          	addi	a5,a5,1330 # d60 <base>
 836:	00000717          	auipc	a4,0x0
 83a:	52f73123          	sd	a5,1314(a4) # d58 <freep>
 83e:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 840:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 844:	b7c1                	j	804 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 846:	6398                	ld	a4,0(a5)
 848:	e118                	sd	a4,0(a0)
 84a:	a08d                	j	8ac <malloc+0xde>
  hp->s.size = nu;
 84c:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 850:	0541                	addi	a0,a0,16
 852:	00000097          	auipc	ra,0x0
 856:	efa080e7          	jalr	-262(ra) # 74c <free>
  return freep;
 85a:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 85e:	c13d                	beqz	a0,8c4 <malloc+0xf6>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 860:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 862:	4798                	lw	a4,8(a5)
 864:	02977463          	bgeu	a4,s1,88c <malloc+0xbe>
    if(p == freep)
 868:	00093703          	ld	a4,0(s2)
 86c:	853e                	mv	a0,a5
 86e:	fef719e3          	bne	a4,a5,860 <malloc+0x92>
  p = sbrk(nu * sizeof(Header));
 872:	8552                	mv	a0,s4
 874:	00000097          	auipc	ra,0x0
 878:	bc2080e7          	jalr	-1086(ra) # 436 <sbrk>
  if(p == (char*)-1)
 87c:	fd5518e3          	bne	a0,s5,84c <malloc+0x7e>
        return 0;
 880:	4501                	li	a0,0
 882:	7902                	ld	s2,32(sp)
 884:	6a42                	ld	s4,16(sp)
 886:	6aa2                	ld	s5,8(sp)
 888:	6b02                	ld	s6,0(sp)
 88a:	a03d                	j	8b8 <malloc+0xea>
 88c:	7902                	ld	s2,32(sp)
 88e:	6a42                	ld	s4,16(sp)
 890:	6aa2                	ld	s5,8(sp)
 892:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 894:	fae489e3          	beq	s1,a4,846 <malloc+0x78>
        p->s.size -= nunits;
 898:	4137073b          	subw	a4,a4,s3
 89c:	c798                	sw	a4,8(a5)
        p += p->s.size;
 89e:	02071693          	slli	a3,a4,0x20
 8a2:	01c6d713          	srli	a4,a3,0x1c
 8a6:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 8a8:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 8ac:	00000717          	auipc	a4,0x0
 8b0:	4aa73623          	sd	a0,1196(a4) # d58 <freep>
      return (void*)(p + 1);
 8b4:	01078513          	addi	a0,a5,16
  }
}
 8b8:	70e2                	ld	ra,56(sp)
 8ba:	7442                	ld	s0,48(sp)
 8bc:	74a2                	ld	s1,40(sp)
 8be:	69e2                	ld	s3,24(sp)
 8c0:	6121                	addi	sp,sp,64
 8c2:	8082                	ret
 8c4:	7902                	ld	s2,32(sp)
 8c6:	6a42                	ld	s4,16(sp)
 8c8:	6aa2                	ld	s5,8(sp)
 8ca:	6b02                	ld	s6,0(sp)
 8cc:	b7f5                	j	8b8 <malloc+0xea>
