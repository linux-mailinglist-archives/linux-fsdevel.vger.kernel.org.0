Return-Path: <linux-fsdevel+bounces-16322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F6789B07B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Apr 2024 12:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 631B91C20C2F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Apr 2024 10:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC991CFAF;
	Sun,  7 Apr 2024 10:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="Haca364Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE091171C2;
	Sun,  7 Apr 2024 10:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712486887; cv=none; b=IaCP+x1pR48eGEeisMCBjCDqqw3z7YnBDoX5hjpEnDgieQt/Sj41wJ90pFFLHI+OUNTrivMhGK5F0C9j2q/PBRaV3whfX18hqT/0vkk5e3LIyC+26eIDZhXpSLimD7hydaMYo3/BebCAO0H+dsC1Xi8xj4/cSUf+pIFcpnw1AR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712486887; c=relaxed/simple;
	bh=WND8nqTcqtozkSVRBjArMr9u2PcKBRM5bXkY7L2qFKE=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=J6fWN2t1vQRJ23dW+UtXo4J2azccj3VPBfoYudGAN2saOdxQnPqL7OBi09ySj2rrjY7Qa0CZH+JtvbmgN4iLZtTnH1FJRJpJOkCo0QhNqefNJx81KNGP16wNC0cF8kOoIjcjasFIIzs4pm3m7Y7cdH4eb2n4mlV+tGQuDMZlCoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=Haca364Q; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1712486882; x=1712746082;
	bh=ctndbIi1qNMHTZQx+z4WPGIuPrEjGdHDgyx+DX7ko64=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Haca364QpPCjNbR4xVAXDq/EZ4DZMie6arChYuh+7jxME1O2Z5KTSG5JoQwoYuYLk
	 cLBSsuKDtcVUhz5DbRl8JzTRodoHTwqxy7HDXVBcuHFwLifNQnrbGhvIUxhxe6B0tr
	 fdaIFp4emb0UG6zbB5SGt9xWlOklBG1/+xXbaLVUpZ2oSc6psBgIVSwtMY6BgXcPMu
	 0MGQzvP0kLzjf66c+pXobqJa5yUbYW6UOgeHY/Cg8zigrosXaVYlo+xhQDxceBiJvC
	 6rt2lCxE/hOsHlKvnCLxvu5/JTiePG9n/XRd8Kq9hGbdw2GLCJTT9ZTRDKpkuNhm9W
	 rqxHd+850hPAQ==
Date: Sun, 07 Apr 2024 10:47:54 +0000
To: syzbot+f3a09670f3d2a55b89b2@syzkaller.appspotmail.com
From: "xrivendell7@protonmail.com" <xrivendell7@protonmail.com>
Cc: dhowells@redhat.com, jlayton@kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, netfs@lists.linux.dev, syzkaller-bugs@googlegroups.com, samsun1006219@gmail.com
Subject: Re: [syzbot] [netfs?] divide error in netfs_submit_writethrough
Message-ID: <35BF4F4E-C41B-442A-B542-8DFE1846449C@protonmail.com>
Feedback-ID: 80993288:user:proton
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello, I reproduced this bug and comfired in the latest upstream with the s=
ame config with syzbot instance.

If you fix this issue, please add the following tag to the commit:
Reported-by: xingwei lee <xrivendell7@gmail.com>
Reported-by: yue sun <samsun1006219@gmail.com>

kernel version: upstream 39cd87c4eb2b893354f3b850f916353f2658ae6f
kernel config: https://syzkaller.appspot.com/text?tag=3DKernelConfig&x=3D8c=
2c72b264636e25 with KASAN enabled
compiler: Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.4=
0

BTW, I can only trigger this bug with repro.txt as follows:

root@syzkaller:~/linux_amd64# ./syz-execprog -repeat 0 ../6c9-0.txt
TITLE: divide error in netfs_submit_writethrough
divide error: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 PID: 12946 Comm: syz-executor Not tainted 6.9.0-rc2-00413-gf2f80ac80=
987-dirty #25
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc38 0=
4/01/2014
RIP: 0010:netfs_submit_writethrough+0x20e/0x290 fs/netfs/output.c:427
Code: fc ff df 48 89 fa 48 c1 ea 03 0f b6 14 02 48 89 f8 83 e0 07 83 c0 03 =
38 d0 7c 04 84 d2 75 1a 8b 8b 0c 01 00 00 48 89 e8 31 d2 <48> ff
RSP: 0018:ffffc9000f88f760 EFLAGS: 00010246
RAX: 0000000000001000 RBX: ffff8880564c2c00 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff823ceef6 RDI: ffff8880564c2d0c
RBP: 0000000000001000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000003 R12: 0000000000000000
R13: ffff88806caa0008 R14: ffff8880564c2d20 R15: 0000000000000000
FS: 00007f5d8dfa06c0(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002000f000 CR3: 0000000059e98000 CR4: 0000000000750ef0
PKRU: 55555554
Call Trace:
<TASK>
netfs_advance_writethrough+0x14a/0x180 fs/netfs/output.c:449
netfs_perform_write+0x1c70/0x27e0 fs/netfs/buffered_write.c:385
netfs_buffered_write_iter_locked+0x232/0x2f0 fs/netfs/buffered_write.c:454
netfs_file_write_iter+0x1f3/0x480 fs/netfs/buffered_write.c:493
v9fs_file_write_iter+0xa8/0x110 fs/9p/vfs_file.c:407
call_write_iter include/linux/fs.h:2110 [inline]
do_iter_readv_writev+0x53a/0x7c0 fs/read_write.c:741
vfs_writev+0x386/0xe10 fs/read_write.c:971
do_pwritev+0x1c1/0x280 fs/read_write.c:1072
__do_sys_pwritev2 fs/read_write.c:1131 [inline]
__se_sys_pwritev2 fs/read_write.c:1122 [inline]
__x64_sys_pwritev2+0xf6/0x160 fs/read_write.c:1122
do_syscall_x64 arch/x86/entry/common.c:52 [inline]
do_syscall_64+0xd5/0x260 arch/x86/entry/common.c:83
entry_SYSCALL_64_after_hwframe+0x72/0x7a
RIP: 0033:0x7f5d8e4a5559
Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 =
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 38
RSP: 002b:00007f5d8df9fd58 EFLAGS: 00000246 ORIG_RAX: 0000000000000148
RAX: ffffffffffffffda RBX: 00000000004bbf80 RCX: 00007f5d8e4a5559
RDX: 0000000000000001 RSI: 0000000020000780 RDI: 0000000000000007
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000016
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000004bbf8c
R13: 000000000000000b R14: 00000000004bbf80 R15: 00007f5d8df80000
</TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:netfs_submit_writethrough+0x20e/0x290 fs/netfs/output.c:427
Code: fc ff df 48 89 fa 48 c1 ea 03 0f b6 14 02 48 89 f8 83 e0 07 83 c0 03 =
38 d0 7c 04 84 d2 75 1a 8b 8b 0c 01 00 00 48 89 e8 31 d2 <48> ff
RSP: 0018:ffffc9000f88f760 EFLAGS: 00010246
RAX: 0000000000001000 RBX: ffff8880564c2c00 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff823ceef6 RDI: ffff8880564c2d0c
RBP: 0000000000001000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000003 R12: 0000000000000000
R13: ffff88806caa0008 R14: ffff8880564c2d20 R15: 0000000000000000
FS: 00007f5d8dfa06c0(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002000f000 CR3: 0000000059e98000 CR4: 0000000000750ef0
PKRU: 55555554
----------------
Code disassembly (best guess), 2 bytes skipped:
0: df 48 89 fisttps -0x77(%rax)
3: fa cli
4: 48 c1 ea 03 shr $0x3,%rdx
8: 0f b6 14 02 movzbl (%rdx,%rax,1),%edx
c: 48 89 f8 mov %rdi,%rax
f: 83 e0 07 and $0x7,%eax
12: 83 c0 03 add $0x3,%eax
15: 38 d0 cmp %dl,%al
17: 7c 04 jl 0x1d
19: 84 d2 test %dl,%dl
1b: 75 1a jne 0x37
1d: 8b 8b 0c 01 00 00 mov 0x10c(%rbx),%ecx
23: 48 89 e8 mov %rbp,%rax
26: 31 d2 xor %edx,%edx
* 28: 48 rex.W <-- trapping instruction
29: ff .byte 0xff
TITLE: kernel panic: Fatal exception
CORRUPTED: true (report format is marked as corrupted)
MAINTAINERS (TO): []
MAINTAINERS (CC): []
CPU: 0 PID: 12946 Comm: syz-executor Not tainted 6.9.0-rc2-00413-gf2f80ac80=
987-dirty #25
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc38 0=
4/01/2014
RIP: 0010:netfs_submit_writethrough+0x20e/0x290 fs/netfs/output.c:427
Code: fc ff df 48 89 fa 48 c1 ea 03 0f b6 14 02 48 89 f8 83 e0 07 83 c0 03 =
38 d0 7c 04 84 d2 75 1a 8b 8b 0c 01 00 00 48 89 e8 31 d2 <48> ff
RSP: 0018:ffffc9000f88f760 EFLAGS: 00010246
RAX: 0000000000001000 RBX: ffff8880564c2c00 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff823ceef6 RDI: ffff8880564c2d0c
RBP: 0000000000001000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000003 R12: 0000000000000000
R13: ffff88806caa0008 R14: ffff8880564c2d20 R15: 0000000000000000
FS: 00007f5d8dfa06c0(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002000f000 CR3: 0000000059e98000 CR4: 0000000000750ef0
PKRU: 55555554
Call Trace:
<TASK>
netfs_advance_writethrough+0x14a/0x180 fs/netfs/output.c:449
netfs_perform_write+0x1c70/0x27e0 fs/netfs/buffered_write.c:385
netfs_buffered_write_iter_locked+0x232/0x2f0 fs/netfs/buffered_write.c:454
netfs_file_write_iter+0x1f3/0x480 fs/netfs/buffered_write.c:493
v9fs_file_write_iter+0xa8/0x110 fs/9p/vfs_file.c:407
call_write_iter include/linux/fs.h:2110 [inline]
do_iter_readv_writev+0x53a/0x7c0 fs/read_write.c:741
vfs_writev+0x386/0xe10 fs/read_write.c:971
do_pwritev+0x1c1/0x280 fs/read_write.c:1072
__do_sys_pwritev2 fs/read_write.c:1131 [inline]
__se_sys_pwritev2 fs/read_write.c:1122 [inline]
__x64_sys_pwritev2+0xf6/0x160 fs/read_write.c:1122
do_syscall_x64 arch/x86/entry/common.c:52 [inline]
do_syscall_64+0xd5/0x260 arch/x86/entry/common.c:83
entry_SYSCALL_64_after_hwframe+0x72/0x7a
RIP: 0033:0x7f5d8e4a5559
Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 =
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 38
RSP: 002b:00007f5d8df9fd58 EFLAGS: 00000246 ORIG_RAX: 0000000000000148
RAX: ffffffffffffffda RBX: 00000000004bbf80 RCX: 00007f5d8e4a5559
RDX: 0000000000000001 RSI: 0000000020000780 RDI: 0000000000000007
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000016
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000004bbf8c
R13: 000000000000000b R14: 00000000004bbf80 R15: 00007f5d8df80000
</TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:netfs_submit_writethrough+0x20e/0x290 fs/netfs/output.c:427
Code: fc ff df 48 89 fa 48 c1 ea 03 0f b6 14 02 48 89 f8 83 e0 07 83 c0 03 =
38 d0 7c 04 84 d2 75 1a 8b 8b 0c 01 00 00 48 89 e8 31 d2 <48> ff
RSP: 0018:ffffc9000f88f760 EFLAGS: 00010246
RAX: 0000000000001000 RBX: ffff8880564c2c00 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff823ceef6 RDI: ffff8880564c2d0c
RBP: 0000000000001000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000003 R12: 0000000000000000
R13: ffff88806caa0008 R14: ffff8880564c2d20 R15: 0000000000000000
FS: 00007f5d8dfa06c0(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002000f000 CR3: 0000000059e98000 CR4: 0000000000750ef0
PKRU: 55555554
Kernel panic - not syncing: Fatal exception
Kernel Offset: disabled
Rebooting in 86400 seconds..


=3D* repro.c =3D*
#define _GNU_SOURCE

#include <endian.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <unistd.h>

#ifndef __NR_pwritev2
#define __NR_pwritev2 328
#endif

uint64_t r[4] =3D {0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffff=
ff,
                 0xffffffffffffffff};

int main(void) {
  syscall(__NR_mmap, /*addr=3D*/0x1ffff000ul, /*len=3D*/0x1000ul, /*prot=3D=
*/0ul,
          /*flags=3D*/0x32ul, /*fd=3D*/-1, /*offset=3D*/0ul);
  syscall(__NR_mmap, /*addr=3D*/0x20000000ul, /*len=3D*/0x1000000ul, /*prot=
=3D*/7ul,
          /*flags=3D*/0x32ul, /*fd=3D*/-1, /*offset=3D*/0ul);
  syscall(__NR_mmap, /*addr=3D*/0x21000000ul, /*len=3D*/0x1000ul, /*prot=3D=
*/0ul,
          /*flags=3D*/0x32ul, /*fd=3D*/-1, /*offset=3D*/0ul);
  intptr_t res =3D 0;
  memcpy((void*)0x20000240, "./file0\000", 8);
  syscall(__NR_creat, /*file=3D*/0x20000240ul, /*mode=3D*/0ul);
  res =3D syscall(__NR_pipe2, /*pipefd=3D*/0x20001900ul, /*flags=3D*/0ul);
  if (res !=3D -1) {
    r[0] =3D *(uint32_t*)0x20001900;
    r[1] =3D *(uint32_t*)0x20001904;
  }
  memcpy((void*)0x20000480,
         "\x15\x00\x00\x00\x65\xff\xff\x01\x80\x00\x00\x08\x00\x39\x50\x32\=
x30"
         "\x30\x30",
         19);
  syscall(__NR_write, /*fd=3D*/r[1], /*data=3D*/0x20000480ul, /*size=3D*/0x=
15ul);
  res =3D syscall(__NR_dup, /*oldfd=3D*/r[1]);
  if (res !=3D -1)
    r[2] =3D res;
  *(uint32_t*)0x20000100 =3D 0x18;
  *(uint32_t*)0x20000104 =3D 0;
  *(uint64_t*)0x20000108 =3D 0;
  *(uint64_t*)0x20000110 =3D 0;
  syscall(__NR_write, /*fd=3D*/r[2], /*arg=3D*/0x20000100ul, /*len=3D*/0x18=
ul);
  *(uint32_t*)0x200000c0 =3D 0x14c;
  *(uint32_t*)0x200000c4 =3D 5;
  *(uint64_t*)0x200000c8 =3D 0;
  *(uint64_t*)0x200000d0 =3D 0;
  *(uint64_t*)0x200000d8 =3D 0;
  *(uint64_t*)0x200000e0 =3D 0;
  *(uint32_t*)0x200000e8 =3D 0;
  *(uint32_t*)0x200000ec =3D 0;
  syscall(__NR_write, /*fd=3D*/r[2], /*arg=3D*/0x200000c0ul, /*len=3D*/0x13=
7ul);
  memcpy((void*)0x20000080, "./file0\000", 8);
  memcpy((void*)0x20000040, "9p\000", 3);
  memcpy((void*)0x20000280, "trans=3Dfd,", 9);
  memcpy((void*)0x20000289, "rfdno", 5);
  *(uint8_t*)0x2000028e =3D 0x3d;
  sprintf((char*)0x2000028f, "0x%016llx", (long long)r[0]);
  *(uint8_t*)0x200002a1 =3D 0x2c;
  memcpy((void*)0x200002a2, "wfdno", 5);
  *(uint8_t*)0x200002a7 =3D 0x3d;
  sprintf((char*)0x200002a8, "0x%016llx", (long long)r[2]);
  *(uint8_t*)0x200002ba =3D 0x2c;
  memcpy((void*)0x200002bb, "cache=3Dmmap", 10);
  *(uint8_t*)0x200002c5 =3D 0x2c;
  *(uint8_t*)0x200002c6 =3D 0x6b;
  syscall(__NR_mount, /*src=3D*/0ul, /*dst=3D*/0x20000080ul, /*type=3D*/0x2=
0000040ul,
          /*flags=3D*/0ul, /*opts=3D*/0x20000280ul);
  memcpy((void*)0x20000140, "./file0\000", 8);
  syscall(__NR_chmod, /*file=3D*/0x20000140ul, /*mode=3D*/0ul);
  memcpy((void*)0x20000300, "./file0\000", 8);
  res =3D syscall(__NR_creat, /*file=3D*/0x20000300ul, /*mode=3D*/0ul);
  if (res !=3D -1)
    r[3] =3D res;
  *(uint64_t*)0x20000780 =3D 0x20000180;
  memset((void*)0x20000180, 142, 1);
  *(uint64_t*)0x20000788 =3D 0xfdef;
  syscall(__NR_pwritev2, /*fd=3D*/r[3], /*vec=3D*/0x20000780ul, /*vlen=3D*/=
1ul,
          /*off_low=3D*/0, /*off_high=3D*/0, /*flags=3D*/0x16ul);
  return 0;
}

remember to run it syz-execprog -repeat 0 ./repro.txt

=3D* repro.txt =3D*
creat(&(0x7f0000000240)=3D'./file0\x00', 0x0)
pipe2$9p(&(0x7f0000001900)=3D{<r0=3D>0xffffffffffffffff, <r1=3D>0xfffffffff=
fffffff}, 0x0)
write$P9_RVERSION(r1, &(0x7f0000000480)=3DANY=3D[@ANYBLOB=3D"1500000065ffff=
018000000800395032303030"], 0x15)
r2 =3D dup(r1)
write$FUSE_BMAP(r2, &(0x7f0000000100)=3D{0x18}, 0x18)
write$FUSE_NOTIFY_RETRIEVE(r2, &(0x7f00000000c0)=3D{0x14c}, 0x137)
mount$9p_fd(0x0, &(0x7f0000000080)=3D'./file0\x00', &(0x7f0000000040), 0x0,=
 &(0x7f0000000280)=3D{'trans=3Dfd,', {'rfdno', 0x3d, r0}, 0x2c, {'wfdno', 0=
x3d, r2}, 0x2c, {[{@cache_mmap}], [], 0x6b}})
chmod(&(0x7f0000000140)=3D'./file0\x00', 0x0)
r3 =3D creat(&(0x7f0000000300)=3D'./file0\x00', 0x0)
pwritev2(r3, &(0x7f0000000780)=3D[{&(0x7f0000000180)=3D"8e", 0xfdef}], 0x1,=
 0x0, 0x0, 0x16)

and see also in https://gist.github.com/xrivendell7/8a65b0e5c5109d1ce87acfd=
56f713544

I hope it helps.
Best regards

