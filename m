Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09B4671E4A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 14:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjARNnc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 08:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbjARNnD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 08:43:03 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010E67ED65
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jan 2023 05:12:54 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id t3-20020a6bc303000000b006f7844c6298so21430626iof.23
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jan 2023 05:12:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r4aNU8xVDYxDXUkg59eqAOVcZHqKOxVVQoxHNQ0r1d0=;
        b=Qd/JwXSYHeNHU/1rnDKLrEi70QyVQ9yhitiKR38EZ6oec6q6ceb9g5y7jaZg2aZvRS
         P1XNp23vXxzq5BpOEQ/T2LgKfVofcJ8srz2koxQAkAMqk2/p94/QRAlpR93EkrwJE90q
         glIk3sox5Y4BhaaFNiVRkGomlQbgBSE2LhojKWWwKAIa0c71vinGDXF36QfwAZDrvn3C
         fXU+UbL2LmCnSryIHJr8Rtmb4kxRoDkdG/Vme4ii8jE2Tt4YMdk3rPQMTV/B0x8txUin
         lz0gGGZA21j0Zr+d68PO4GFF8GTndxorNolABjhBD3wsDx7aBrbNuq2U8CLQrv+YTTJM
         0v1A==
X-Gm-Message-State: AFqh2krXH4YaujkbbBO5Qtg7UbVp4bvjLW7LGh8TWyF4/dVl4yncrHCY
        twINryxgA0B0jui3MxY3UJ0T//iAHe0JXuUiPLYbYzIUwvCZ
X-Google-Smtp-Source: AMrXdXvl5KJXpM7tKYwStUJf4hYlckUCvbwhEBVKoxV82ELax5KNfE01G6rJEl8fnjfrxhuh3ktQ7XEjLqmkt0vEK2ZgK7QuucpA
MIME-Version: 1.0
X-Received: by 2002:a92:c565:0:b0:302:ebf5:a7ae with SMTP id
 b5-20020a92c565000000b00302ebf5a7aemr831622ilj.34.1674047573447; Wed, 18 Jan
 2023 05:12:53 -0800 (PST)
Date:   Wed, 18 Jan 2023 05:12:53 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f3da9505f28992f4@google.com>
Subject: [syzbot] general protection fault in s_show
From:   syzbot <syzbot+a0258de3c9175e61a024@syzkaller.appspotmail.com>
To:     adobriyan@gmail.com, akpm@linux-foundation.org, brauner@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        muchun.song@linux.dev, roman.gushchin@linux.dev,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    9ce08dd7ea24 Add linux-next specific files for 20230117
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=118b99ca480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=35b17571659142bd
dashboard link: https://syzkaller.appspot.com/bug?extid=a0258de3c9175e61a024
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16e960de480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13c99296480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5dc082154a67/disk-9ce08dd7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c4232ae45260/vmlinux-9ce08dd7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bb484ac2d045/bzImage-9ce08dd7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a0258de3c9175e61a024@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
CPU: 1 PID: 5094 Comm: syz-executor205 Not tainted 6.2.0-rc4-next-20230117-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
RIP: 0010:s_show+0x6d/0xa90 mm/vmalloc.c:4243
Code: 74 24 08 49 8b 5e 10 48 85 db 0f 84 1b 05 00 00 e8 48 98 bf ff 48 8d 7b 10 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 35 09 00 00 48 8d 7b 08 4c 8b 43 10 48 b8 00 00
RSP: 0018:ffffc90003d1f9d8 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000002 RSI: ffffffff81c23c18 RDI: 0000000000000010
RBP: ffff888021a736f0 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000007c07 R14: ffff888028ca8980 R15: ffffffff8a589ba0
FS:  0000555555e67300(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f609a0d8130 CR3: 000000007779b000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 traverse.part.0+0xcf/0x5f0 fs/seq_file.c:111
 traverse fs/seq_file.c:101 [inline]
 seq_read_iter+0x913/0x1280 fs/seq_file.c:195
 proc_reg_read_iter+0x1ff/0x2d0 fs/proc/inode.c:305
 call_read_iter include/linux/fs.h:1846 [inline]
 do_iter_readv_writev+0x2e0/0x3b0 fs/read_write.c:733
 do_iter_read+0x2f2/0x750 fs/read_write.c:796
 vfs_readv+0xe5/0x150 fs/read_write.c:916
 do_preadv fs/read_write.c:1008 [inline]
 __do_sys_preadv fs/read_write.c:1058 [inline]
 __se_sys_preadv fs/read_write.c:1053 [inline]
 __x64_sys_preadv+0x22f/0x310 fs/read_write.c:1053
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f609a067e19
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe66bc5d68 EFLAGS: 00000246 ORIG_RAX: 0000000000000127
RAX: ffffffffffffffda RBX: 00000000000f4240 RCX: 00007f609a067e19
RDX: 0000000000000001 RSI: 00000000200020c0 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
R10: 00000000ffff7fff R11: 0000000000000246 R12: 000000000000f33b
R13: 00007ffe66bc5d7c R14: 00007ffe66bc5d90 R15: 00007ffe66bc5d80
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:s_show+0x6d/0xa90 mm/vmalloc.c:4243
Code: 74 24 08 49 8b 5e 10 48 85 db 0f 84 1b 05 00 00 e8 48 98 bf ff 48 8d 7b 10 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 35 09 00 00 48 8d 7b 08 4c 8b 43 10 48 b8 00 00
RSP: 0018:ffffc90003d1f9d8 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000002 RSI: ffffffff81c23c18 RDI: 0000000000000010
RBP: ffff888021a736f0 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000007c07 R14: ffff888028ca8980 R15: ffffffff8a589ba0
FS:  0000555555e67300(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f609a0d8130 CR3: 000000007779b000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	24 08                	and    $0x8,%al
   2:	49 8b 5e 10          	mov    0x10(%r14),%rbx
   6:	48 85 db             	test   %rbx,%rbx
   9:	0f 84 1b 05 00 00    	je     0x52a
   f:	e8 48 98 bf ff       	callq  0xffbf985c
  14:	48 8d 7b 10          	lea    0x10(%rbx),%rdi
  18:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  1f:	fc ff df
  22:	48 89 fa             	mov    %rdi,%rdx
  25:	48 c1 ea 03          	shr    $0x3,%rdx
* 29:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2d:	0f 85 35 09 00 00    	jne    0x968
  33:	48 8d 7b 08          	lea    0x8(%rbx),%rdi
  37:	4c 8b 43 10          	mov    0x10(%rbx),%r8
  3b:	48                   	rex.W
  3c:	b8                   	.byte 0xb8


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
