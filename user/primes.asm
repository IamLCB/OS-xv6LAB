
user/_primes:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <pipeLine>:
#include "kernel/stat.h"
#include "user/user.h"

__attribute__((noreturn))

void pipeLine(int feed){
   0:	7139                	addi	sp,sp,-64
   2:	fc06                	sd	ra,56(sp)
   4:	f822                	sd	s0,48(sp)
   6:	f426                	sd	s1,40(sp)
   8:	0080                	addi	s0,sp,64
   a:	84aa                	mv	s1,a0
    int prime;
    if(read(feed, &prime, sizeof(prime)) == 0){
   c:	4611                	li	a2,4
   e:	fdc40593          	addi	a1,s0,-36
  12:	00000097          	auipc	ra,0x0
  16:	3d8080e7          	jalr	984(ra) # 3ea <read>
  1a:	e919                	bnez	a0,30 <pipeLine+0x30>
        // no more data to read
        close(feed);// close the read end
  1c:	8526                	mv	a0,s1
  1e:	00000097          	auipc	ra,0x0
  22:	3dc080e7          	jalr	988(ra) # 3fa <close>
        exit(1);
  26:	4505                	li	a0,1
  28:	00000097          	auipc	ra,0x0
  2c:	3aa080e7          	jalr	938(ra) # 3d2 <exit>
    }
    printf("prime %d\n", prime);
  30:	fdc42583          	lw	a1,-36(s0)
  34:	00001517          	auipc	a0,0x1
  38:	8c450513          	addi	a0,a0,-1852 # 8f8 <malloc+0x106>
  3c:	00000097          	auipc	ra,0x0
  40:	6fe080e7          	jalr	1790(ra) # 73a <printf>
    int cp[2]; // create a pipe
    pipe(cp);
  44:	fd040513          	addi	a0,s0,-48
  48:	00000097          	auipc	ra,0x0
  4c:	39a080e7          	jalr	922(ra) # 3e2 <pipe>
    if(fork() == 0){
  50:	00000097          	auipc	ra,0x0
  54:	37a080e7          	jalr	890(ra) # 3ca <fork>
  58:	ed09                	bnez	a0,72 <pipeLine+0x72>
        // child process
        close(cp[1]); // close the write end
  5a:	fd442503          	lw	a0,-44(s0)
  5e:	00000097          	auipc	ra,0x0
  62:	39c080e7          	jalr	924(ra) # 3fa <close>
        pipeLine(cp[0]); // read from the pipe
  66:	fd042503          	lw	a0,-48(s0)
  6a:	00000097          	auipc	ra,0x0
  6e:	f96080e7          	jalr	-106(ra) # 0 <pipeLine>
        close(cp[0]); // close the read end
        exit(0);
    }
    close(cp[0]); // close the read end
  72:	fd042503          	lw	a0,-48(s0)
  76:	00000097          	auipc	ra,0x0
  7a:	384080e7          	jalr	900(ra) # 3fa <close>
    int num;
    while(read(feed, &num, sizeof(num)) != 0){
  7e:	4611                	li	a2,4
  80:	fcc40593          	addi	a1,s0,-52
  84:	8526                	mv	a0,s1
  86:	00000097          	auipc	ra,0x0
  8a:	364080e7          	jalr	868(ra) # 3ea <read>
  8e:	c115                	beqz	a0,b2 <pipeLine+0xb2>
        if(num % prime != 0){
  90:	fcc42783          	lw	a5,-52(s0)
  94:	fdc42703          	lw	a4,-36(s0)
  98:	02e7e7bb          	remw	a5,a5,a4
  9c:	d3ed                	beqz	a5,7e <pipeLine+0x7e>
            // num is not divisible by prime
            write(cp[1], &num, sizeof(num)); // write to the pipe
  9e:	4611                	li	a2,4
  a0:	fcc40593          	addi	a1,s0,-52
  a4:	fd442503          	lw	a0,-44(s0)
  a8:	00000097          	auipc	ra,0x0
  ac:	34a080e7          	jalr	842(ra) # 3f2 <write>
  b0:	b7f9                	j	7e <pipeLine+0x7e>
        }
    }
    close(cp[1]); // close the write end
  b2:	fd442503          	lw	a0,-44(s0)
  b6:	00000097          	auipc	ra,0x0
  ba:	344080e7          	jalr	836(ra) # 3fa <close>
    wait(0); // wait for the child process to finish
  be:	4501                	li	a0,0
  c0:	00000097          	auipc	ra,0x0
  c4:	31a080e7          	jalr	794(ra) # 3da <wait>
    exit(0);
  c8:	4501                	li	a0,0
  ca:	00000097          	auipc	ra,0x0
  ce:	308080e7          	jalr	776(ra) # 3d2 <exit>

00000000000000d2 <main>:
}

int main (int argc, char *argv[]){
  d2:	7179                	addi	sp,sp,-48
  d4:	f406                	sd	ra,40(sp)
  d6:	f022                	sd	s0,32(sp)
  d8:	1800                	addi	s0,sp,48
   int p[2];
   pipe(p); // create a pipe
  da:	fd840513          	addi	a0,s0,-40
  de:	00000097          	auipc	ra,0x0
  e2:	304080e7          	jalr	772(ra) # 3e2 <pipe>
   if(fork() == 0){
  e6:	00000097          	auipc	ra,0x0
  ea:	2e4080e7          	jalr	740(ra) # 3ca <fork>
  ee:	ed11                	bnez	a0,10a <main+0x38>
  f0:	ec26                	sd	s1,24(sp)
    // child process
    close(p[1]); // close the write end
  f2:	fdc42503          	lw	a0,-36(s0)
  f6:	00000097          	auipc	ra,0x0
  fa:	304080e7          	jalr	772(ra) # 3fa <close>
    pipeLine(p[0]); // read from the pipe
  fe:	fd842503          	lw	a0,-40(s0)
 102:	00000097          	auipc	ra,0x0
 106:	efe080e7          	jalr	-258(ra) # 0 <pipeLine>
 10a:	ec26                	sd	s1,24(sp)
    close(p[0]); // close the read end
    exit(0);
   }
   else{
    // parent process
    close(p[0]); // close the read end
 10c:	fd842503          	lw	a0,-40(s0)
 110:	00000097          	auipc	ra,0x0
 114:	2ea080e7          	jalr	746(ra) # 3fa <close>
    for(int i = 2; i <= 35; i++){
 118:	4789                	li	a5,2
 11a:	fcf42a23          	sw	a5,-44(s0)
 11e:	02300493          	li	s1,35
        write(p[1], &i, sizeof(i)); // write to the pipe
 122:	4611                	li	a2,4
 124:	fd440593          	addi	a1,s0,-44
 128:	fdc42503          	lw	a0,-36(s0)
 12c:	00000097          	auipc	ra,0x0
 130:	2c6080e7          	jalr	710(ra) # 3f2 <write>
    for(int i = 2; i <= 35; i++){
 134:	fd442783          	lw	a5,-44(s0)
 138:	2785                	addiw	a5,a5,1
 13a:	0007871b          	sext.w	a4,a5
 13e:	fcf42a23          	sw	a5,-44(s0)
 142:	fee4d0e3          	bge	s1,a4,122 <main+0x50>
    }
    close(p[1]); // close the write end
 146:	fdc42503          	lw	a0,-36(s0)
 14a:	00000097          	auipc	ra,0x0
 14e:	2b0080e7          	jalr	688(ra) # 3fa <close>
    wait(0); // wait for the child process to finish
 152:	4501                	li	a0,0
 154:	00000097          	auipc	ra,0x0
 158:	286080e7          	jalr	646(ra) # 3da <wait>
    exit(0);
 15c:	4501                	li	a0,0
 15e:	00000097          	auipc	ra,0x0
 162:	274080e7          	jalr	628(ra) # 3d2 <exit>

0000000000000166 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 166:	1141                	addi	sp,sp,-16
 168:	e422                	sd	s0,8(sp)
 16a:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 16c:	87aa                	mv	a5,a0
 16e:	0585                	addi	a1,a1,1
 170:	0785                	addi	a5,a5,1
 172:	fff5c703          	lbu	a4,-1(a1)
 176:	fee78fa3          	sb	a4,-1(a5)
 17a:	fb75                	bnez	a4,16e <strcpy+0x8>
    ;
  return os;
}
 17c:	6422                	ld	s0,8(sp)
 17e:	0141                	addi	sp,sp,16
 180:	8082                	ret

0000000000000182 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 182:	1141                	addi	sp,sp,-16
 184:	e422                	sd	s0,8(sp)
 186:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 188:	00054783          	lbu	a5,0(a0)
 18c:	cb91                	beqz	a5,1a0 <strcmp+0x1e>
 18e:	0005c703          	lbu	a4,0(a1)
 192:	00f71763          	bne	a4,a5,1a0 <strcmp+0x1e>
    p++, q++;
 196:	0505                	addi	a0,a0,1
 198:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 19a:	00054783          	lbu	a5,0(a0)
 19e:	fbe5                	bnez	a5,18e <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 1a0:	0005c503          	lbu	a0,0(a1)
}
 1a4:	40a7853b          	subw	a0,a5,a0
 1a8:	6422                	ld	s0,8(sp)
 1aa:	0141                	addi	sp,sp,16
 1ac:	8082                	ret

00000000000001ae <strlen>:

uint
strlen(const char *s)
{
 1ae:	1141                	addi	sp,sp,-16
 1b0:	e422                	sd	s0,8(sp)
 1b2:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 1b4:	00054783          	lbu	a5,0(a0)
 1b8:	cf91                	beqz	a5,1d4 <strlen+0x26>
 1ba:	0505                	addi	a0,a0,1
 1bc:	87aa                	mv	a5,a0
 1be:	86be                	mv	a3,a5
 1c0:	0785                	addi	a5,a5,1
 1c2:	fff7c703          	lbu	a4,-1(a5)
 1c6:	ff65                	bnez	a4,1be <strlen+0x10>
 1c8:	40a6853b          	subw	a0,a3,a0
 1cc:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 1ce:	6422                	ld	s0,8(sp)
 1d0:	0141                	addi	sp,sp,16
 1d2:	8082                	ret
  for(n = 0; s[n]; n++)
 1d4:	4501                	li	a0,0
 1d6:	bfe5                	j	1ce <strlen+0x20>

00000000000001d8 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1d8:	1141                	addi	sp,sp,-16
 1da:	e422                	sd	s0,8(sp)
 1dc:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 1de:	ca19                	beqz	a2,1f4 <memset+0x1c>
 1e0:	87aa                	mv	a5,a0
 1e2:	1602                	slli	a2,a2,0x20
 1e4:	9201                	srli	a2,a2,0x20
 1e6:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 1ea:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 1ee:	0785                	addi	a5,a5,1
 1f0:	fee79de3          	bne	a5,a4,1ea <memset+0x12>
  }
  return dst;
}
 1f4:	6422                	ld	s0,8(sp)
 1f6:	0141                	addi	sp,sp,16
 1f8:	8082                	ret

00000000000001fa <strchr>:

char*
strchr(const char *s, char c)
{
 1fa:	1141                	addi	sp,sp,-16
 1fc:	e422                	sd	s0,8(sp)
 1fe:	0800                	addi	s0,sp,16
  for(; *s; s++)
 200:	00054783          	lbu	a5,0(a0)
 204:	cb99                	beqz	a5,21a <strchr+0x20>
    if(*s == c)
 206:	00f58763          	beq	a1,a5,214 <strchr+0x1a>
  for(; *s; s++)
 20a:	0505                	addi	a0,a0,1
 20c:	00054783          	lbu	a5,0(a0)
 210:	fbfd                	bnez	a5,206 <strchr+0xc>
      return (char*)s;
  return 0;
 212:	4501                	li	a0,0
}
 214:	6422                	ld	s0,8(sp)
 216:	0141                	addi	sp,sp,16
 218:	8082                	ret
  return 0;
 21a:	4501                	li	a0,0
 21c:	bfe5                	j	214 <strchr+0x1a>

000000000000021e <gets>:

char*
gets(char *buf, int max)
{
 21e:	711d                	addi	sp,sp,-96
 220:	ec86                	sd	ra,88(sp)
 222:	e8a2                	sd	s0,80(sp)
 224:	e4a6                	sd	s1,72(sp)
 226:	e0ca                	sd	s2,64(sp)
 228:	fc4e                	sd	s3,56(sp)
 22a:	f852                	sd	s4,48(sp)
 22c:	f456                	sd	s5,40(sp)
 22e:	f05a                	sd	s6,32(sp)
 230:	ec5e                	sd	s7,24(sp)
 232:	1080                	addi	s0,sp,96
 234:	8baa                	mv	s7,a0
 236:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 238:	892a                	mv	s2,a0
 23a:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 23c:	4aa9                	li	s5,10
 23e:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 240:	89a6                	mv	s3,s1
 242:	2485                	addiw	s1,s1,1
 244:	0344d863          	bge	s1,s4,274 <gets+0x56>
    cc = read(0, &c, 1);
 248:	4605                	li	a2,1
 24a:	faf40593          	addi	a1,s0,-81
 24e:	4501                	li	a0,0
 250:	00000097          	auipc	ra,0x0
 254:	19a080e7          	jalr	410(ra) # 3ea <read>
    if(cc < 1)
 258:	00a05e63          	blez	a0,274 <gets+0x56>
    buf[i++] = c;
 25c:	faf44783          	lbu	a5,-81(s0)
 260:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 264:	01578763          	beq	a5,s5,272 <gets+0x54>
 268:	0905                	addi	s2,s2,1
 26a:	fd679be3          	bne	a5,s6,240 <gets+0x22>
    buf[i++] = c;
 26e:	89a6                	mv	s3,s1
 270:	a011                	j	274 <gets+0x56>
 272:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 274:	99de                	add	s3,s3,s7
 276:	00098023          	sb	zero,0(s3)
  return buf;
}
 27a:	855e                	mv	a0,s7
 27c:	60e6                	ld	ra,88(sp)
 27e:	6446                	ld	s0,80(sp)
 280:	64a6                	ld	s1,72(sp)
 282:	6906                	ld	s2,64(sp)
 284:	79e2                	ld	s3,56(sp)
 286:	7a42                	ld	s4,48(sp)
 288:	7aa2                	ld	s5,40(sp)
 28a:	7b02                	ld	s6,32(sp)
 28c:	6be2                	ld	s7,24(sp)
 28e:	6125                	addi	sp,sp,96
 290:	8082                	ret

0000000000000292 <stat>:

int
stat(const char *n, struct stat *st)
{
 292:	1101                	addi	sp,sp,-32
 294:	ec06                	sd	ra,24(sp)
 296:	e822                	sd	s0,16(sp)
 298:	e04a                	sd	s2,0(sp)
 29a:	1000                	addi	s0,sp,32
 29c:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 29e:	4581                	li	a1,0
 2a0:	00000097          	auipc	ra,0x0
 2a4:	172080e7          	jalr	370(ra) # 412 <open>
  if(fd < 0)
 2a8:	02054663          	bltz	a0,2d4 <stat+0x42>
 2ac:	e426                	sd	s1,8(sp)
 2ae:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 2b0:	85ca                	mv	a1,s2
 2b2:	00000097          	auipc	ra,0x0
 2b6:	178080e7          	jalr	376(ra) # 42a <fstat>
 2ba:	892a                	mv	s2,a0
  close(fd);
 2bc:	8526                	mv	a0,s1
 2be:	00000097          	auipc	ra,0x0
 2c2:	13c080e7          	jalr	316(ra) # 3fa <close>
  return r;
 2c6:	64a2                	ld	s1,8(sp)
}
 2c8:	854a                	mv	a0,s2
 2ca:	60e2                	ld	ra,24(sp)
 2cc:	6442                	ld	s0,16(sp)
 2ce:	6902                	ld	s2,0(sp)
 2d0:	6105                	addi	sp,sp,32
 2d2:	8082                	ret
    return -1;
 2d4:	597d                	li	s2,-1
 2d6:	bfcd                	j	2c8 <stat+0x36>

00000000000002d8 <atoi>:

int
atoi(const char *s)
{
 2d8:	1141                	addi	sp,sp,-16
 2da:	e422                	sd	s0,8(sp)
 2dc:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2de:	00054683          	lbu	a3,0(a0)
 2e2:	fd06879b          	addiw	a5,a3,-48
 2e6:	0ff7f793          	zext.b	a5,a5
 2ea:	4625                	li	a2,9
 2ec:	02f66863          	bltu	a2,a5,31c <atoi+0x44>
 2f0:	872a                	mv	a4,a0
  n = 0;
 2f2:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 2f4:	0705                	addi	a4,a4,1
 2f6:	0025179b          	slliw	a5,a0,0x2
 2fa:	9fa9                	addw	a5,a5,a0
 2fc:	0017979b          	slliw	a5,a5,0x1
 300:	9fb5                	addw	a5,a5,a3
 302:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 306:	00074683          	lbu	a3,0(a4)
 30a:	fd06879b          	addiw	a5,a3,-48
 30e:	0ff7f793          	zext.b	a5,a5
 312:	fef671e3          	bgeu	a2,a5,2f4 <atoi+0x1c>
  return n;
}
 316:	6422                	ld	s0,8(sp)
 318:	0141                	addi	sp,sp,16
 31a:	8082                	ret
  n = 0;
 31c:	4501                	li	a0,0
 31e:	bfe5                	j	316 <atoi+0x3e>

0000000000000320 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 320:	1141                	addi	sp,sp,-16
 322:	e422                	sd	s0,8(sp)
 324:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 326:	02b57463          	bgeu	a0,a1,34e <memmove+0x2e>
    while(n-- > 0)
 32a:	00c05f63          	blez	a2,348 <memmove+0x28>
 32e:	1602                	slli	a2,a2,0x20
 330:	9201                	srli	a2,a2,0x20
 332:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 336:	872a                	mv	a4,a0
      *dst++ = *src++;
 338:	0585                	addi	a1,a1,1
 33a:	0705                	addi	a4,a4,1
 33c:	fff5c683          	lbu	a3,-1(a1)
 340:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 344:	fef71ae3          	bne	a4,a5,338 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 348:	6422                	ld	s0,8(sp)
 34a:	0141                	addi	sp,sp,16
 34c:	8082                	ret
    dst += n;
 34e:	00c50733          	add	a4,a0,a2
    src += n;
 352:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 354:	fec05ae3          	blez	a2,348 <memmove+0x28>
 358:	fff6079b          	addiw	a5,a2,-1
 35c:	1782                	slli	a5,a5,0x20
 35e:	9381                	srli	a5,a5,0x20
 360:	fff7c793          	not	a5,a5
 364:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 366:	15fd                	addi	a1,a1,-1
 368:	177d                	addi	a4,a4,-1
 36a:	0005c683          	lbu	a3,0(a1)
 36e:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 372:	fee79ae3          	bne	a5,a4,366 <memmove+0x46>
 376:	bfc9                	j	348 <memmove+0x28>

0000000000000378 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 378:	1141                	addi	sp,sp,-16
 37a:	e422                	sd	s0,8(sp)
 37c:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 37e:	ca05                	beqz	a2,3ae <memcmp+0x36>
 380:	fff6069b          	addiw	a3,a2,-1
 384:	1682                	slli	a3,a3,0x20
 386:	9281                	srli	a3,a3,0x20
 388:	0685                	addi	a3,a3,1
 38a:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 38c:	00054783          	lbu	a5,0(a0)
 390:	0005c703          	lbu	a4,0(a1)
 394:	00e79863          	bne	a5,a4,3a4 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 398:	0505                	addi	a0,a0,1
    p2++;
 39a:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 39c:	fed518e3          	bne	a0,a3,38c <memcmp+0x14>
  }
  return 0;
 3a0:	4501                	li	a0,0
 3a2:	a019                	j	3a8 <memcmp+0x30>
      return *p1 - *p2;
 3a4:	40e7853b          	subw	a0,a5,a4
}
 3a8:	6422                	ld	s0,8(sp)
 3aa:	0141                	addi	sp,sp,16
 3ac:	8082                	ret
  return 0;
 3ae:	4501                	li	a0,0
 3b0:	bfe5                	j	3a8 <memcmp+0x30>

00000000000003b2 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 3b2:	1141                	addi	sp,sp,-16
 3b4:	e406                	sd	ra,8(sp)
 3b6:	e022                	sd	s0,0(sp)
 3b8:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 3ba:	00000097          	auipc	ra,0x0
 3be:	f66080e7          	jalr	-154(ra) # 320 <memmove>
}
 3c2:	60a2                	ld	ra,8(sp)
 3c4:	6402                	ld	s0,0(sp)
 3c6:	0141                	addi	sp,sp,16
 3c8:	8082                	ret

00000000000003ca <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3ca:	4885                	li	a7,1
 ecall
 3cc:	00000073          	ecall
 ret
 3d0:	8082                	ret

00000000000003d2 <exit>:
.global exit
exit:
 li a7, SYS_exit
 3d2:	4889                	li	a7,2
 ecall
 3d4:	00000073          	ecall
 ret
 3d8:	8082                	ret

00000000000003da <wait>:
.global wait
wait:
 li a7, SYS_wait
 3da:	488d                	li	a7,3
 ecall
 3dc:	00000073          	ecall
 ret
 3e0:	8082                	ret

00000000000003e2 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3e2:	4891                	li	a7,4
 ecall
 3e4:	00000073          	ecall
 ret
 3e8:	8082                	ret

00000000000003ea <read>:
.global read
read:
 li a7, SYS_read
 3ea:	4895                	li	a7,5
 ecall
 3ec:	00000073          	ecall
 ret
 3f0:	8082                	ret

00000000000003f2 <write>:
.global write
write:
 li a7, SYS_write
 3f2:	48c1                	li	a7,16
 ecall
 3f4:	00000073          	ecall
 ret
 3f8:	8082                	ret

00000000000003fa <close>:
.global close
close:
 li a7, SYS_close
 3fa:	48d5                	li	a7,21
 ecall
 3fc:	00000073          	ecall
 ret
 400:	8082                	ret

0000000000000402 <kill>:
.global kill
kill:
 li a7, SYS_kill
 402:	4899                	li	a7,6
 ecall
 404:	00000073          	ecall
 ret
 408:	8082                	ret

000000000000040a <exec>:
.global exec
exec:
 li a7, SYS_exec
 40a:	489d                	li	a7,7
 ecall
 40c:	00000073          	ecall
 ret
 410:	8082                	ret

0000000000000412 <open>:
.global open
open:
 li a7, SYS_open
 412:	48bd                	li	a7,15
 ecall
 414:	00000073          	ecall
 ret
 418:	8082                	ret

000000000000041a <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 41a:	48c5                	li	a7,17
 ecall
 41c:	00000073          	ecall
 ret
 420:	8082                	ret

0000000000000422 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 422:	48c9                	li	a7,18
 ecall
 424:	00000073          	ecall
 ret
 428:	8082                	ret

000000000000042a <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 42a:	48a1                	li	a7,8
 ecall
 42c:	00000073          	ecall
 ret
 430:	8082                	ret

0000000000000432 <link>:
.global link
link:
 li a7, SYS_link
 432:	48cd                	li	a7,19
 ecall
 434:	00000073          	ecall
 ret
 438:	8082                	ret

000000000000043a <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 43a:	48d1                	li	a7,20
 ecall
 43c:	00000073          	ecall
 ret
 440:	8082                	ret

0000000000000442 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 442:	48a5                	li	a7,9
 ecall
 444:	00000073          	ecall
 ret
 448:	8082                	ret

000000000000044a <dup>:
.global dup
dup:
 li a7, SYS_dup
 44a:	48a9                	li	a7,10
 ecall
 44c:	00000073          	ecall
 ret
 450:	8082                	ret

0000000000000452 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 452:	48ad                	li	a7,11
 ecall
 454:	00000073          	ecall
 ret
 458:	8082                	ret

000000000000045a <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 45a:	48b1                	li	a7,12
 ecall
 45c:	00000073          	ecall
 ret
 460:	8082                	ret

0000000000000462 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 462:	48b5                	li	a7,13
 ecall
 464:	00000073          	ecall
 ret
 468:	8082                	ret

000000000000046a <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 46a:	48b9                	li	a7,14
 ecall
 46c:	00000073          	ecall
 ret
 470:	8082                	ret

0000000000000472 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 472:	1101                	addi	sp,sp,-32
 474:	ec06                	sd	ra,24(sp)
 476:	e822                	sd	s0,16(sp)
 478:	1000                	addi	s0,sp,32
 47a:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 47e:	4605                	li	a2,1
 480:	fef40593          	addi	a1,s0,-17
 484:	00000097          	auipc	ra,0x0
 488:	f6e080e7          	jalr	-146(ra) # 3f2 <write>
}
 48c:	60e2                	ld	ra,24(sp)
 48e:	6442                	ld	s0,16(sp)
 490:	6105                	addi	sp,sp,32
 492:	8082                	ret

0000000000000494 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 494:	7139                	addi	sp,sp,-64
 496:	fc06                	sd	ra,56(sp)
 498:	f822                	sd	s0,48(sp)
 49a:	f426                	sd	s1,40(sp)
 49c:	0080                	addi	s0,sp,64
 49e:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4a0:	c299                	beqz	a3,4a6 <printint+0x12>
 4a2:	0805cb63          	bltz	a1,538 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4a6:	2581                	sext.w	a1,a1
  neg = 0;
 4a8:	4881                	li	a7,0
 4aa:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 4ae:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 4b0:	2601                	sext.w	a2,a2
 4b2:	00000517          	auipc	a0,0x0
 4b6:	4b650513          	addi	a0,a0,1206 # 968 <digits>
 4ba:	883a                	mv	a6,a4
 4bc:	2705                	addiw	a4,a4,1
 4be:	02c5f7bb          	remuw	a5,a1,a2
 4c2:	1782                	slli	a5,a5,0x20
 4c4:	9381                	srli	a5,a5,0x20
 4c6:	97aa                	add	a5,a5,a0
 4c8:	0007c783          	lbu	a5,0(a5)
 4cc:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 4d0:	0005879b          	sext.w	a5,a1
 4d4:	02c5d5bb          	divuw	a1,a1,a2
 4d8:	0685                	addi	a3,a3,1
 4da:	fec7f0e3          	bgeu	a5,a2,4ba <printint+0x26>
  if(neg)
 4de:	00088c63          	beqz	a7,4f6 <printint+0x62>
    buf[i++] = '-';
 4e2:	fd070793          	addi	a5,a4,-48
 4e6:	00878733          	add	a4,a5,s0
 4ea:	02d00793          	li	a5,45
 4ee:	fef70823          	sb	a5,-16(a4)
 4f2:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 4f6:	02e05c63          	blez	a4,52e <printint+0x9a>
 4fa:	f04a                	sd	s2,32(sp)
 4fc:	ec4e                	sd	s3,24(sp)
 4fe:	fc040793          	addi	a5,s0,-64
 502:	00e78933          	add	s2,a5,a4
 506:	fff78993          	addi	s3,a5,-1
 50a:	99ba                	add	s3,s3,a4
 50c:	377d                	addiw	a4,a4,-1
 50e:	1702                	slli	a4,a4,0x20
 510:	9301                	srli	a4,a4,0x20
 512:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 516:	fff94583          	lbu	a1,-1(s2)
 51a:	8526                	mv	a0,s1
 51c:	00000097          	auipc	ra,0x0
 520:	f56080e7          	jalr	-170(ra) # 472 <putc>
  while(--i >= 0)
 524:	197d                	addi	s2,s2,-1
 526:	ff3918e3          	bne	s2,s3,516 <printint+0x82>
 52a:	7902                	ld	s2,32(sp)
 52c:	69e2                	ld	s3,24(sp)
}
 52e:	70e2                	ld	ra,56(sp)
 530:	7442                	ld	s0,48(sp)
 532:	74a2                	ld	s1,40(sp)
 534:	6121                	addi	sp,sp,64
 536:	8082                	ret
    x = -xx;
 538:	40b005bb          	negw	a1,a1
    neg = 1;
 53c:	4885                	li	a7,1
    x = -xx;
 53e:	b7b5                	j	4aa <printint+0x16>

0000000000000540 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 540:	715d                	addi	sp,sp,-80
 542:	e486                	sd	ra,72(sp)
 544:	e0a2                	sd	s0,64(sp)
 546:	f84a                	sd	s2,48(sp)
 548:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 54a:	0005c903          	lbu	s2,0(a1)
 54e:	1a090a63          	beqz	s2,702 <vprintf+0x1c2>
 552:	fc26                	sd	s1,56(sp)
 554:	f44e                	sd	s3,40(sp)
 556:	f052                	sd	s4,32(sp)
 558:	ec56                	sd	s5,24(sp)
 55a:	e85a                	sd	s6,16(sp)
 55c:	e45e                	sd	s7,8(sp)
 55e:	8aaa                	mv	s5,a0
 560:	8bb2                	mv	s7,a2
 562:	00158493          	addi	s1,a1,1
  state = 0;
 566:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 568:	02500a13          	li	s4,37
 56c:	4b55                	li	s6,21
 56e:	a839                	j	58c <vprintf+0x4c>
        putc(fd, c);
 570:	85ca                	mv	a1,s2
 572:	8556                	mv	a0,s5
 574:	00000097          	auipc	ra,0x0
 578:	efe080e7          	jalr	-258(ra) # 472 <putc>
 57c:	a019                	j	582 <vprintf+0x42>
    } else if(state == '%'){
 57e:	01498d63          	beq	s3,s4,598 <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 582:	0485                	addi	s1,s1,1
 584:	fff4c903          	lbu	s2,-1(s1)
 588:	16090763          	beqz	s2,6f6 <vprintf+0x1b6>
    if(state == 0){
 58c:	fe0999e3          	bnez	s3,57e <vprintf+0x3e>
      if(c == '%'){
 590:	ff4910e3          	bne	s2,s4,570 <vprintf+0x30>
        state = '%';
 594:	89d2                	mv	s3,s4
 596:	b7f5                	j	582 <vprintf+0x42>
      if(c == 'd'){
 598:	13490463          	beq	s2,s4,6c0 <vprintf+0x180>
 59c:	f9d9079b          	addiw	a5,s2,-99
 5a0:	0ff7f793          	zext.b	a5,a5
 5a4:	12fb6763          	bltu	s6,a5,6d2 <vprintf+0x192>
 5a8:	f9d9079b          	addiw	a5,s2,-99
 5ac:	0ff7f713          	zext.b	a4,a5
 5b0:	12eb6163          	bltu	s6,a4,6d2 <vprintf+0x192>
 5b4:	00271793          	slli	a5,a4,0x2
 5b8:	00000717          	auipc	a4,0x0
 5bc:	35870713          	addi	a4,a4,856 # 910 <malloc+0x11e>
 5c0:	97ba                	add	a5,a5,a4
 5c2:	439c                	lw	a5,0(a5)
 5c4:	97ba                	add	a5,a5,a4
 5c6:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 5c8:	008b8913          	addi	s2,s7,8
 5cc:	4685                	li	a3,1
 5ce:	4629                	li	a2,10
 5d0:	000ba583          	lw	a1,0(s7)
 5d4:	8556                	mv	a0,s5
 5d6:	00000097          	auipc	ra,0x0
 5da:	ebe080e7          	jalr	-322(ra) # 494 <printint>
 5de:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5e0:	4981                	li	s3,0
 5e2:	b745                	j	582 <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5e4:	008b8913          	addi	s2,s7,8
 5e8:	4681                	li	a3,0
 5ea:	4629                	li	a2,10
 5ec:	000ba583          	lw	a1,0(s7)
 5f0:	8556                	mv	a0,s5
 5f2:	00000097          	auipc	ra,0x0
 5f6:	ea2080e7          	jalr	-350(ra) # 494 <printint>
 5fa:	8bca                	mv	s7,s2
      state = 0;
 5fc:	4981                	li	s3,0
 5fe:	b751                	j	582 <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 600:	008b8913          	addi	s2,s7,8
 604:	4681                	li	a3,0
 606:	4641                	li	a2,16
 608:	000ba583          	lw	a1,0(s7)
 60c:	8556                	mv	a0,s5
 60e:	00000097          	auipc	ra,0x0
 612:	e86080e7          	jalr	-378(ra) # 494 <printint>
 616:	8bca                	mv	s7,s2
      state = 0;
 618:	4981                	li	s3,0
 61a:	b7a5                	j	582 <vprintf+0x42>
 61c:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 61e:	008b8c13          	addi	s8,s7,8
 622:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 626:	03000593          	li	a1,48
 62a:	8556                	mv	a0,s5
 62c:	00000097          	auipc	ra,0x0
 630:	e46080e7          	jalr	-442(ra) # 472 <putc>
  putc(fd, 'x');
 634:	07800593          	li	a1,120
 638:	8556                	mv	a0,s5
 63a:	00000097          	auipc	ra,0x0
 63e:	e38080e7          	jalr	-456(ra) # 472 <putc>
 642:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 644:	00000b97          	auipc	s7,0x0
 648:	324b8b93          	addi	s7,s7,804 # 968 <digits>
 64c:	03c9d793          	srli	a5,s3,0x3c
 650:	97de                	add	a5,a5,s7
 652:	0007c583          	lbu	a1,0(a5)
 656:	8556                	mv	a0,s5
 658:	00000097          	auipc	ra,0x0
 65c:	e1a080e7          	jalr	-486(ra) # 472 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 660:	0992                	slli	s3,s3,0x4
 662:	397d                	addiw	s2,s2,-1
 664:	fe0914e3          	bnez	s2,64c <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 668:	8be2                	mv	s7,s8
      state = 0;
 66a:	4981                	li	s3,0
 66c:	6c02                	ld	s8,0(sp)
 66e:	bf11                	j	582 <vprintf+0x42>
        s = va_arg(ap, char*);
 670:	008b8993          	addi	s3,s7,8
 674:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 678:	02090163          	beqz	s2,69a <vprintf+0x15a>
        while(*s != 0){
 67c:	00094583          	lbu	a1,0(s2)
 680:	c9a5                	beqz	a1,6f0 <vprintf+0x1b0>
          putc(fd, *s);
 682:	8556                	mv	a0,s5
 684:	00000097          	auipc	ra,0x0
 688:	dee080e7          	jalr	-530(ra) # 472 <putc>
          s++;
 68c:	0905                	addi	s2,s2,1
        while(*s != 0){
 68e:	00094583          	lbu	a1,0(s2)
 692:	f9e5                	bnez	a1,682 <vprintf+0x142>
        s = va_arg(ap, char*);
 694:	8bce                	mv	s7,s3
      state = 0;
 696:	4981                	li	s3,0
 698:	b5ed                	j	582 <vprintf+0x42>
          s = "(null)";
 69a:	00000917          	auipc	s2,0x0
 69e:	26e90913          	addi	s2,s2,622 # 908 <malloc+0x116>
        while(*s != 0){
 6a2:	02800593          	li	a1,40
 6a6:	bff1                	j	682 <vprintf+0x142>
        putc(fd, va_arg(ap, uint));
 6a8:	008b8913          	addi	s2,s7,8
 6ac:	000bc583          	lbu	a1,0(s7)
 6b0:	8556                	mv	a0,s5
 6b2:	00000097          	auipc	ra,0x0
 6b6:	dc0080e7          	jalr	-576(ra) # 472 <putc>
 6ba:	8bca                	mv	s7,s2
      state = 0;
 6bc:	4981                	li	s3,0
 6be:	b5d1                	j	582 <vprintf+0x42>
        putc(fd, c);
 6c0:	02500593          	li	a1,37
 6c4:	8556                	mv	a0,s5
 6c6:	00000097          	auipc	ra,0x0
 6ca:	dac080e7          	jalr	-596(ra) # 472 <putc>
      state = 0;
 6ce:	4981                	li	s3,0
 6d0:	bd4d                	j	582 <vprintf+0x42>
        putc(fd, '%');
 6d2:	02500593          	li	a1,37
 6d6:	8556                	mv	a0,s5
 6d8:	00000097          	auipc	ra,0x0
 6dc:	d9a080e7          	jalr	-614(ra) # 472 <putc>
        putc(fd, c);
 6e0:	85ca                	mv	a1,s2
 6e2:	8556                	mv	a0,s5
 6e4:	00000097          	auipc	ra,0x0
 6e8:	d8e080e7          	jalr	-626(ra) # 472 <putc>
      state = 0;
 6ec:	4981                	li	s3,0
 6ee:	bd51                	j	582 <vprintf+0x42>
        s = va_arg(ap, char*);
 6f0:	8bce                	mv	s7,s3
      state = 0;
 6f2:	4981                	li	s3,0
 6f4:	b579                	j	582 <vprintf+0x42>
 6f6:	74e2                	ld	s1,56(sp)
 6f8:	79a2                	ld	s3,40(sp)
 6fa:	7a02                	ld	s4,32(sp)
 6fc:	6ae2                	ld	s5,24(sp)
 6fe:	6b42                	ld	s6,16(sp)
 700:	6ba2                	ld	s7,8(sp)
    }
  }
}
 702:	60a6                	ld	ra,72(sp)
 704:	6406                	ld	s0,64(sp)
 706:	7942                	ld	s2,48(sp)
 708:	6161                	addi	sp,sp,80
 70a:	8082                	ret

000000000000070c <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 70c:	715d                	addi	sp,sp,-80
 70e:	ec06                	sd	ra,24(sp)
 710:	e822                	sd	s0,16(sp)
 712:	1000                	addi	s0,sp,32
 714:	e010                	sd	a2,0(s0)
 716:	e414                	sd	a3,8(s0)
 718:	e818                	sd	a4,16(s0)
 71a:	ec1c                	sd	a5,24(s0)
 71c:	03043023          	sd	a6,32(s0)
 720:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 724:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 728:	8622                	mv	a2,s0
 72a:	00000097          	auipc	ra,0x0
 72e:	e16080e7          	jalr	-490(ra) # 540 <vprintf>
}
 732:	60e2                	ld	ra,24(sp)
 734:	6442                	ld	s0,16(sp)
 736:	6161                	addi	sp,sp,80
 738:	8082                	ret

000000000000073a <printf>:

void
printf(const char *fmt, ...)
{
 73a:	711d                	addi	sp,sp,-96
 73c:	ec06                	sd	ra,24(sp)
 73e:	e822                	sd	s0,16(sp)
 740:	1000                	addi	s0,sp,32
 742:	e40c                	sd	a1,8(s0)
 744:	e810                	sd	a2,16(s0)
 746:	ec14                	sd	a3,24(s0)
 748:	f018                	sd	a4,32(s0)
 74a:	f41c                	sd	a5,40(s0)
 74c:	03043823          	sd	a6,48(s0)
 750:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 754:	00840613          	addi	a2,s0,8
 758:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 75c:	85aa                	mv	a1,a0
 75e:	4505                	li	a0,1
 760:	00000097          	auipc	ra,0x0
 764:	de0080e7          	jalr	-544(ra) # 540 <vprintf>
}
 768:	60e2                	ld	ra,24(sp)
 76a:	6442                	ld	s0,16(sp)
 76c:	6125                	addi	sp,sp,96
 76e:	8082                	ret

0000000000000770 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 770:	1141                	addi	sp,sp,-16
 772:	e422                	sd	s0,8(sp)
 774:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 776:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 77a:	00000797          	auipc	a5,0x0
 77e:	5e67b783          	ld	a5,1510(a5) # d60 <freep>
 782:	a02d                	j	7ac <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 784:	4618                	lw	a4,8(a2)
 786:	9f2d                	addw	a4,a4,a1
 788:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 78c:	6398                	ld	a4,0(a5)
 78e:	6310                	ld	a2,0(a4)
 790:	a83d                	j	7ce <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 792:	ff852703          	lw	a4,-8(a0)
 796:	9f31                	addw	a4,a4,a2
 798:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 79a:	ff053683          	ld	a3,-16(a0)
 79e:	a091                	j	7e2 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7a0:	6398                	ld	a4,0(a5)
 7a2:	00e7e463          	bltu	a5,a4,7aa <free+0x3a>
 7a6:	00e6ea63          	bltu	a3,a4,7ba <free+0x4a>
{
 7aa:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7ac:	fed7fae3          	bgeu	a5,a3,7a0 <free+0x30>
 7b0:	6398                	ld	a4,0(a5)
 7b2:	00e6e463          	bltu	a3,a4,7ba <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7b6:	fee7eae3          	bltu	a5,a4,7aa <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 7ba:	ff852583          	lw	a1,-8(a0)
 7be:	6390                	ld	a2,0(a5)
 7c0:	02059813          	slli	a6,a1,0x20
 7c4:	01c85713          	srli	a4,a6,0x1c
 7c8:	9736                	add	a4,a4,a3
 7ca:	fae60de3          	beq	a2,a4,784 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 7ce:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 7d2:	4790                	lw	a2,8(a5)
 7d4:	02061593          	slli	a1,a2,0x20
 7d8:	01c5d713          	srli	a4,a1,0x1c
 7dc:	973e                	add	a4,a4,a5
 7de:	fae68ae3          	beq	a3,a4,792 <free+0x22>
    p->s.ptr = bp->s.ptr;
 7e2:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 7e4:	00000717          	auipc	a4,0x0
 7e8:	56f73e23          	sd	a5,1404(a4) # d60 <freep>
}
 7ec:	6422                	ld	s0,8(sp)
 7ee:	0141                	addi	sp,sp,16
 7f0:	8082                	ret

00000000000007f2 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7f2:	7139                	addi	sp,sp,-64
 7f4:	fc06                	sd	ra,56(sp)
 7f6:	f822                	sd	s0,48(sp)
 7f8:	f426                	sd	s1,40(sp)
 7fa:	ec4e                	sd	s3,24(sp)
 7fc:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7fe:	02051493          	slli	s1,a0,0x20
 802:	9081                	srli	s1,s1,0x20
 804:	04bd                	addi	s1,s1,15
 806:	8091                	srli	s1,s1,0x4
 808:	0014899b          	addiw	s3,s1,1
 80c:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 80e:	00000517          	auipc	a0,0x0
 812:	55253503          	ld	a0,1362(a0) # d60 <freep>
 816:	c915                	beqz	a0,84a <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 818:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 81a:	4798                	lw	a4,8(a5)
 81c:	08977e63          	bgeu	a4,s1,8b8 <malloc+0xc6>
 820:	f04a                	sd	s2,32(sp)
 822:	e852                	sd	s4,16(sp)
 824:	e456                	sd	s5,8(sp)
 826:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 828:	8a4e                	mv	s4,s3
 82a:	0009871b          	sext.w	a4,s3
 82e:	6685                	lui	a3,0x1
 830:	00d77363          	bgeu	a4,a3,836 <malloc+0x44>
 834:	6a05                	lui	s4,0x1
 836:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 83a:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 83e:	00000917          	auipc	s2,0x0
 842:	52290913          	addi	s2,s2,1314 # d60 <freep>
  if(p == (char*)-1)
 846:	5afd                	li	s5,-1
 848:	a091                	j	88c <malloc+0x9a>
 84a:	f04a                	sd	s2,32(sp)
 84c:	e852                	sd	s4,16(sp)
 84e:	e456                	sd	s5,8(sp)
 850:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 852:	00000797          	auipc	a5,0x0
 856:	51678793          	addi	a5,a5,1302 # d68 <base>
 85a:	00000717          	auipc	a4,0x0
 85e:	50f73323          	sd	a5,1286(a4) # d60 <freep>
 862:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 864:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 868:	b7c1                	j	828 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 86a:	6398                	ld	a4,0(a5)
 86c:	e118                	sd	a4,0(a0)
 86e:	a08d                	j	8d0 <malloc+0xde>
  hp->s.size = nu;
 870:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 874:	0541                	addi	a0,a0,16
 876:	00000097          	auipc	ra,0x0
 87a:	efa080e7          	jalr	-262(ra) # 770 <free>
  return freep;
 87e:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 882:	c13d                	beqz	a0,8e8 <malloc+0xf6>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 884:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 886:	4798                	lw	a4,8(a5)
 888:	02977463          	bgeu	a4,s1,8b0 <malloc+0xbe>
    if(p == freep)
 88c:	00093703          	ld	a4,0(s2)
 890:	853e                	mv	a0,a5
 892:	fef719e3          	bne	a4,a5,884 <malloc+0x92>
  p = sbrk(nu * sizeof(Header));
 896:	8552                	mv	a0,s4
 898:	00000097          	auipc	ra,0x0
 89c:	bc2080e7          	jalr	-1086(ra) # 45a <sbrk>
  if(p == (char*)-1)
 8a0:	fd5518e3          	bne	a0,s5,870 <malloc+0x7e>
        return 0;
 8a4:	4501                	li	a0,0
 8a6:	7902                	ld	s2,32(sp)
 8a8:	6a42                	ld	s4,16(sp)
 8aa:	6aa2                	ld	s5,8(sp)
 8ac:	6b02                	ld	s6,0(sp)
 8ae:	a03d                	j	8dc <malloc+0xea>
 8b0:	7902                	ld	s2,32(sp)
 8b2:	6a42                	ld	s4,16(sp)
 8b4:	6aa2                	ld	s5,8(sp)
 8b6:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 8b8:	fae489e3          	beq	s1,a4,86a <malloc+0x78>
        p->s.size -= nunits;
 8bc:	4137073b          	subw	a4,a4,s3
 8c0:	c798                	sw	a4,8(a5)
        p += p->s.size;
 8c2:	02071693          	slli	a3,a4,0x20
 8c6:	01c6d713          	srli	a4,a3,0x1c
 8ca:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 8cc:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 8d0:	00000717          	auipc	a4,0x0
 8d4:	48a73823          	sd	a0,1168(a4) # d60 <freep>
      return (void*)(p + 1);
 8d8:	01078513          	addi	a0,a5,16
  }
}
 8dc:	70e2                	ld	ra,56(sp)
 8de:	7442                	ld	s0,48(sp)
 8e0:	74a2                	ld	s1,40(sp)
 8e2:	69e2                	ld	s3,24(sp)
 8e4:	6121                	addi	sp,sp,64
 8e6:	8082                	ret
 8e8:	7902                	ld	s2,32(sp)
 8ea:	6a42                	ld	s4,16(sp)
 8ec:	6aa2                	ld	s5,8(sp)
 8ee:	6b02                	ld	s6,0(sp)
 8f0:	b7f5                	j	8dc <malloc+0xea>
