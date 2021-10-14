Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8356642D09A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 04:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhJNCpK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Oct 2021 22:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbhJNCpJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Oct 2021 22:45:09 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CAAC061570;
        Wed, 13 Oct 2021 19:43:05 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id s136so900086pgs.4;
        Wed, 13 Oct 2021 19:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=sHKifJk5izw/MqdmGV1qq+I/6lXT+WPrFdIs1Dw0M20=;
        b=EZgRyBvW0cM71TasvToj0/SUlAttH9nJ7Fp8SdLgthjhAesxH/cpvlJUohVVM3o/jT
         fY81dv0wu7A9R9YeR7HHyNEHElhWAqsHY/taqWIwLQReW3S4wIHxe9tmLjxBLRr67gE5
         CsT2u+/DNdt7VSKLxzqkyoxyt1MmGExz4z+yZpHV7eV8BnTc62ovi+1pHrBxvg3z8mAQ
         VbMreIvQPO40mtGWDCSAKvURN0WB9sJooS3CE1cut6zXqDlM1NRf9kk6hEfbEqsEF2le
         uT7WR0zwzwFSwk+8gADy+3eZGJiPrwiA1GB2zNYMm3pq4bU3tElqrMND5//H3le2bHo4
         VGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=sHKifJk5izw/MqdmGV1qq+I/6lXT+WPrFdIs1Dw0M20=;
        b=sSi5Mg4sBp8j1wBdoaHiOv0slAReEH9vGYK2urw7CCLL/8f2qmBZtr+mOn8V7Gjhde
         V8F0eIXICB70NV0rK2qiMbGzYi6RKAZ9V/9HZ32++Vl+hxWne0QoCPchrZIZ5gsLeva1
         F2d7y/6tl4ATA7VUEZyUMNSaWTMSsqCXF9Ewguuc1tejU8RlApmTiiEvxP31u7o5ns0L
         bYmIKlxUa/F9NX/SUI6SUlnzai7WQIYyg2e+BXqTH0UAnarpGC+Wshf0bxGDbfsyvxWd
         VnPlGzH6sFln60HjeHKqJhXM/22JSPL4RHmEfdpjombrKkllQmWlu9Q6F3rZIJZ6EYPC
         Mu9g==
X-Gm-Message-State: AOAM530j6bQot/h79FRkFtSnYTXG6yP2/8ThaeueIFxsXbKX4oGJ69+y
        VvsAy3LdbmunWyV0Y84XN/49lR7nLIGAlftIcBlp7Wu7aGGE
X-Google-Smtp-Source: ABdhPJzcHvo016O2aViLuHvM2yRZYYaITUYpLCPgO/d1R5ehTajzMnUiExuxc3v8O0lt4Smak0b/i6c6V2QBSiOmUaw=
X-Received: by 2002:a63:85c6:: with SMTP id u189mr2239610pgd.381.1634179384850;
 Wed, 13 Oct 2021 19:43:04 -0700 (PDT)
MIME-Version: 1.0
References: <CACkBjsaYSfxKQUUhv2BdU8JTcHL1WP_c039iJ9CvmG5vMMHR4A@mail.gmail.com>
In-Reply-To: <CACkBjsaYSfxKQUUhv2BdU8JTcHL1WP_c039iJ9CvmG5vMMHR4A@mail.gmail.com>
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Thu, 14 Oct 2021 10:42:53 +0800
Message-ID: <CACkBjsau_-kjBKUJG2kOZcFzVuxr+VZOL3dgu6k8Brm+EbXVFA@mail.gmail.com>
Subject: Re: general protection fault in __block_write_begin_int
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hao Sun <sunhao.th@gmail.com> =E4=BA=8E2021=E5=B9=B49=E6=9C=8820=E6=97=A5=
=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=888:58=E5=86=99=E9=81=93=EF=BC=9A
>
> Hello,
>
> When using Healer to fuzz the latest Linux kernel, the following crash
> was triggered.
>
> HEAD commit: 4357f03d6611 Merge tag 'pm-5.15-rc2
> git tree: upstream
> console output:
> https://drive.google.com/file/d/1r4iaWNbcFSZEw3dpTM2tbE3sPZbaXQ_Y/view?us=
p=3Dsharing
> kernel config: https://drive.google.com/file/d/1HKZtF_s3l6PL3OoQbNq_ei9Cd=
Bus-Tz0/view?usp=3Dsharing
> C reproducer: https://drive.google.com/file/d/13JjyIW6yKhM9QIYvC3IfDXAtjw=
_2Rrmt/view?usp=3Dsharing
> Syzlang reproducer:
> https://drive.google.com/file/d/1sxTq_kx4Yw8nD06mQQ7Ah_cCEg75yalF/view?us=
p=3Dsharing
>
> If you fix this issue, please add the following tag to the commit:
> Reported-by: Hao Sun <sunhao.th@gmail.com>
>
> general protection fault, probably for non-canonical address
> 0xdead000000000200: 0000 [#1] PREEMPT SMP
> CPU: 2 PID: 11649 Comm: syz-executor Not tainted 5.15.0-rc1+ #19
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> RIP: 0010:__block_write_begin_int+0xde/0xae0 fs/buffer.c:1973
> Code: 00 00 0f 87 65 06 00 00 e8 df bd d6 ff 45 85 e4 0f 85 5e 06 00
> 00 e8 d1 bd d6 ff 48 8b 45 18 31 d2 48 89 ef 41 bc 0c 00 00 00 <48> 8b
> 00 48 89 c6 48 89 44 24 20 e8 02 a4 ff ff 4c 8b 7d 20 48 8b
> RSP: 0018:ffffc9000ab13980 EFLAGS: 00010246
> RAX: dead000000000200 RBX: ffffea0004568000 RCX: ffffc900025b9000
> RDX: 0000000000000000 RSI: ffffffff8160d34f RDI: ffffea0004568040
> RBP: ffffea0004568040 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 000000000000000c
> R13: ffffc9000ab13aa0 R14: ffffffff821f8f70 R15: 0000000000000000
> FS:  00007f39bbe26700(0000) GS:ffff88807dd00000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000100000001 CR3: 000000010b767000 CR4: 0000000000750ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>  __block_write_begin fs/buffer.c:2056 [inline]
>  block_write_begin+0x58/0x150 fs/buffer.c:2116
>  generic_perform_write+0xce/0x220 mm/filemap.c:3770
>  __generic_file_write_iter+0x20d/0x240 mm/filemap.c:3897
>  blkdev_write_iter+0xed/0x1d0 block/fops.c:518
>  call_write_iter include/linux/fs.h:2163 [inline]
>  do_iter_readv_writev+0x1e8/0x2b0 fs/read_write.c:729
>  do_iter_write+0xaf/0x250 fs/read_write.c:855
>  vfs_iter_write+0x38/0x60 fs/read_write.c:896
>  iter_file_splice_write+0x2d8/0x450 fs/splice.c:689
>  do_splice_from fs/splice.c:767 [inline]
>  direct_splice_actor+0x4a/0x80 fs/splice.c:936
>  splice_direct_to_actor+0x123/0x2d0 fs/splice.c:891
>  do_splice_direct+0xc3/0x110 fs/splice.c:979
>  do_sendfile+0x338/0x740 fs/read_write.c:1249
>  __do_sys_sendfile64 fs/read_write.c:1314 [inline]
>  __se_sys_sendfile64 fs/read_write.c:1300 [inline]
>  __x64_sys_sendfile64+0xc7/0xe0 fs/read_write.c:1300
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x46ae99
> Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f39bbe25c48 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
> RAX: ffffffffffffffda RBX: 000000000078c158 RCX: 000000000046ae99
> RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000006
> RBP: 00000000004e4809 R08: 0000000000000000 R09: 0000000000000000
> R10: 00000000464e681a R11: 0000000000000246 R12: 000000000078c158
> R13: 0000000000000000 R14: 000000000078c158 R15: 00007ffeddcbc7a0
> Modules linked in:
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> ---[ end trace 39bb45a4a4cd76d5 ]---
> RIP: 0010:__block_write_begin_int+0xde/0xae0 fs/buffer.c:1973
> Code: 00 00 0f 87 65 06 00 00 e8 df bd d6 ff 45 85 e4 0f 85 5e 06 00
> 00 e8 d1 bd d6 ff 48 8b 45 18 31 d2 48 89 ef 41 bc 0c 00 00 00 <48> 8b
> 00 48 89 c6 48 89 44 24 20 e8 02 a4 ff ff 4c 8b 7d 20 48 8b
> RSP: 0018:ffffc9000ab13980 EFLAGS: 00010246
> RAX: dead000000000200 RBX: ffffea0004568000 RCX: ffffc900025b9000
> RDX: 0000000000000000 RSI: ffffffff8160d34f RDI: ffffea0004568040
> RBP: ffffea0004568040 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 000000000000000c
> R13: ffffc9000ab13aa0 R14: ffffffff821f8f70 R15: 0000000000000000
> FS:  00007f39bbe26700(0000) GS:ffff88807dd00000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f81b40af020 CR3: 000000010b767000 CR4: 0000000000750ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> ----------------
> Code disassembly (best guess):
>    0:   00 00                   add    %al,(%rax)
>    2:   0f 87 65 06 00 00       ja     0x66d
>    8:   e8 df bd d6 ff          callq  0xffd6bdec
>    d:   45 85 e4                test   %r12d,%r12d
>   10:   0f 85 5e 06 00 00       jne    0x674
>   16:   e8 d1 bd d6 ff          callq  0xffd6bdec
>   1b:   48 8b 45 18             mov    0x18(%rbp),%rax
>   1f:   31 d2                   xor    %edx,%edx
>   21:   48 89 ef                mov    %rbp,%rdi
>   24:   41 bc 0c 00 00 00       mov    $0xc,%r12d
> * 2a:   48 8b 00                mov    (%rax),%rax <-- trapping instructi=
on
>   2d:   48 89 c6                mov    %rax,%rsi
>   30:   48 89 44 24 20          mov    %rax,0x20(%rsp)
>   35:   e8 02 a4 ff ff          callq  0xffffa43c
>   3a:   4c 8b 7d 20             mov    0x20(%rbp),%r15
>   3e:   48                      rex.W
>   3f:   8b                      .byte 0x8b

Hi,

This issue can still be triggered repeatedly on the latest kernel.

HEAD commit: 64570fbc14f8 Linux 5.15-rc5
git tree: upstream
kernel config: https://drive.google.com/file/d/1em3xgUIMNN_-LUUdySzwN-UDPc3=
qiiKD/view?usp=3Dsharing

general protection fault, probably for non-canonical address
0xfbd59c0000000040: 0000 [#1] PREEMPT SMP KASAN
KASAN: maybe wild-memory-access in range [0xdead000000000200-0xdead00000000=
0207]
CPU: 2 PID: 14120 Comm: syz-executor Not tainted 5.15.0-rc5 #3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:__block_write_begin_int+0xd2/0x1f00 fs/buffer.c:1977
Code: 24 20 48 c1 e8 03 40 0f b6 ed 42 80 3c 20 00 0f 85 46 1b 00 00
48 b8 00 00 00 00 00 fc ff df 49 8b 5e 18 48 89 da 48 c1 ea 03 <80> 3c
02 00 0f 85 42 1d 00 00 48 8b 03 48 89 44 24 30 49 8d 46 08
RSP: 0018:ffffc900039073e0 EFLAGS: 00010212
RAX: dffffc0000000000 RBX: dead000000000200 RCX: 0000000000040000
RDX: 1bd5a00000000040 RSI: ffff888018df8000 RDI: ffffea0000d80058
RBP: 0000000000000000 R08: ffffffff81daac78 R09: 0000000000000000
R10: 0000000000000007 R11: fffff940001b0000 R12: dffffc0000000000
R13: 0000000000000000 R14: ffffea0000d80040 R15: 0000000000000000
FS:  00007f9c5537f700(0000) GS:ffff888063f00000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055792ede6d38 CR3: 00000000204a1000 CR4: 0000000000350ee0
Call Trace:
 __block_write_begin fs/buffer.c:2060 [inline]
 block_write_begin+0x58/0x2e0 fs/buffer.c:2120
 generic_perform_write+0x1fe/0x510 mm/filemap.c:3770
 __generic_file_write_iter+0x24e/0x640 mm/filemap.c:3897
 blkdev_write_iter+0x2a7/0x560 block/fops.c:519
 call_write_iter include/linux/fs.h:2163 [inline]
 do_iter_readv_writev+0x47b/0x750 fs/read_write.c:729
 do_iter_write fs/read_write.c:855 [inline]
 do_iter_write+0x18b/0x700 fs/read_write.c:836
 vfs_iter_write+0x70/0xa0 fs/read_write.c:896
 iter_file_splice_write+0x723/0xbf0 fs/splice.c:689
 do_splice_from fs/splice.c:767 [inline]
 direct_splice_actor+0x110/0x180 fs/splice.c:936
 splice_direct_to_actor+0x34b/0x8c0 fs/splice.c:891
 do_splice_direct+0x1b3/0x280 fs/splice.c:979
 do_sendfile+0xab6/0x1240 fs/read_write.c:1249
 __do_sys_sendfile64 fs/read_write.c:1314 [inline]
 __se_sys_sendfile64 fs/read_write.c:1300 [inline]
 __x64_sys_sendfile64+0x1cc/0x210 fs/read_write.c:1300
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f9c57e16c4d
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9c5537ec58 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f9c57f3d0a0 RCX: 00007f9c57e16c4d
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007f9c57e8fd80 R08: 0000000000000000 R09: 0000000000000000
R10: 00008400fffffffb R11: 0000000000000246 R12: 00007f9c57f3d0a0
R13: 00007ffdb9a5a15f R14: 00007ffdb9a5a300 R15: 00007f9c5537edc0
Modules linked in:
Dumping ftrace buffer:
   (ftrace buffer empty)
---[ end trace 5c2419f5104d23a1 ]---
RIP: 0010:__block_write_begin_int+0xd2/0x1f00 fs/buffer.c:1977
Code: 24 20 48 c1 e8 03 40 0f b6 ed 42 80 3c 20 00 0f 85 46 1b 00 00
48 b8 00 00 00 00 00 fc ff df 49 8b 5e 18 48 89 da 48 c1 ea 03 <80> 3c
02 00 0f 85 42 1d 00 00 48 8b 03 48 89 44 24 30 49 8d 46 08
RSP: 0018:ffffc900039073e0 EFLAGS: 00010212
RAX: dffffc0000000000 RBX: dead000000000200 RCX: 0000000000040000
RDX: 1bd5a00000000040 RSI: ffff888018df8000 RDI: ffffea0000d80058
RBP: 0000000000000000 R08: ffffffff81daac78 R09: 0000000000000000
R10: 0000000000000007 R11: fffff940001b0000 R12: dffffc0000000000
R13: 0000000000000000 R14: ffffea0000d80040 R15: 0000000000000000
FS:  00007f9c5537f700(0000) GS:ffff888063f00000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055792ede6d38 CR3: 00000000204a1000 CR4: 0000000000350ee0
----------------
Code disassembly (best guess):
   0: 24 20                and    $0x20,%al
   2: 48 c1 e8 03          shr    $0x3,%rax
   6: 40 0f b6 ed          movzbl %bpl,%ebp
   a: 42 80 3c 20 00        cmpb   $0x0,(%rax,%r12,1)
   f: 0f 85 46 1b 00 00    jne    0x1b5b
  15: 48 b8 00 00 00 00 00 movabs $0xdffffc0000000000,%rax
  1c: fc ff df
  1f: 49 8b 5e 18          mov    0x18(%r14),%rbx
  23: 48 89 da              mov    %rbx,%rdx
  26: 48 c1 ea 03          shr    $0x3,%rdx
* 2a: 80 3c 02 00          cmpb   $0x0,(%rdx,%rax,1) <-- trapping instructi=
on
  2e: 0f 85 42 1d 00 00    jne    0x1d76
  34: 48 8b 03              mov    (%rbx),%rax
  37: 48 89 44 24 30        mov    %rax,0x30(%rsp)
  3c: 49 8d 46 08          lea    0x8(%r14),%rax
