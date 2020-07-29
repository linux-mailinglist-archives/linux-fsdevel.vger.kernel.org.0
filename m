Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3102326CA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jul 2020 23:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgG2Ve0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jul 2020 17:34:26 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:54571 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbgG2VeW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jul 2020 17:34:22 -0400
Received: by mail-io1-f70.google.com with SMTP id z25so9267186ioh.21
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2020 14:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=SBci7a5McQ4HLstQc3jrus8wwIympT0MXoOHI9RYxPM=;
        b=C8zHkyqi29hnwvYEegfZHFYKiKzp1OFVe2jP2Co98MMjPcBqc/p8QoST+6BpMAom6/
         lgzaZRcCNm6+vgTYmCfuf15QO+X67XqeilPiRe3API0BGUTBjQHF6Qoy4DiB2GWIwkjd
         3NaWzdc23WMacOvI9NACmL/a7VL9NxyR9wA+gFVB98fBbXp0Q1oXBRz2krpHWe7PZJ/N
         ZI2g6c2bGb6Sxk8Ob3o10tqnmQabVUQbliIbNur+q5bTZTxPUy+izaGFDc0dBSNRtAi3
         OYzne70BlvbAzBRn5t/JGtvY+PY3yFx7pKKYXZ+YybyR8lVjYV9FXKLYobYTAPx41oDN
         hwHA==
X-Gm-Message-State: AOAM531fk3y1joW/3hgJa8yglncb76CZIPbMYV4Mb41flyrwyYndGcwP
        QogrpbKURzPqZ+CfceOXZ/79R7pcv8j256WVHxn/9lZFNdm6
X-Google-Smtp-Source: ABdhPJzhWG6qKoEvK5UQnZJrfoEPA690PyPZfKLPaeZUtrOmC+VXn9PLvCylYCQfXHYTqiIjB9yXAhS8qwhyQSSq3pm5jhE5dA3/
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c01:: with SMTP id w1mr36279869iov.130.1596058462261;
 Wed, 29 Jul 2020 14:34:22 -0700 (PDT)
Date:   Wed, 29 Jul 2020 14:34:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000af1b3b05ab9b51c2@google.com>
Subject: kernel BUG at arch/x86/mm/physaddr.c:LINE! (6)
From:   syzbot <syzbot+dfb45ba0aafa4329fd19@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    23ee3e4e Merge tag 'pci-v5.8-fixes-2' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16c45f78900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f87a5e4232fdb267
dashboard link: https://syzkaller.appspot.com/bug?extid=dfb45ba0aafa4329fd19
compiler:       gcc (GCC) 10.1.0-syz 20200507
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dfb45ba0aafa4329fd19@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at arch/x86/mm/physaddr.c:28!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 15249 Comm: syz-executor.4 Not tainted 5.8.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__phys_addr+0xa7/0x110 arch/x86/mm/physaddr.c:28
Code: 61 7a 09 4c 89 e3 31 ff 48 d3 eb 48 89 de e8 90 60 3f 00 48 85 db 75 0d e8 e6 63 3f 00 4c 89 e0 5b 5d 41 5c c3 e8 d9 63 3f 00 <0f> 0b e8 d2 63 3f 00 48 c7 c0 10 10 a8 89 48 ba 00 00 00 00 00 fc
RSP: 0018:ffffc90015be7c18 EFLAGS: 00010216
RAX: 0000000000003629 RBX: 0000000000077000 RCX: ffffc900116ea000
RDX: 0000000000040000 RSI: ffffffff813458b7 RDI: 0000000000000006
RBP: 0000000080077000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000080077000 R11: 0000000000000000 R12: 0000778000077000
R13: ffffc90015be7c70 R14: 0000000000000000 R15: 0000000000000286
FS:  0000000000000000(0000) GS:ffff8880ae700000(0063) knlGS:00000000f5db6b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 000055bcdd3fe588 CR3: 0000000070105000 CR4: 00000000001426e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 virt_to_head_page include/linux/mm.h:841 [inline]
 qlink_to_cache mm/kasan/quarantine.c:128 [inline]
 qlist_free_all+0xbb/0x140 mm/kasan/quarantine.c:164
 quarantine_reduce+0x17e/0x200 mm/kasan/quarantine.c:260
 __kasan_kmalloc.constprop.0+0x9e/0xd0 mm/kasan/common.c:475
 slab_post_alloc_hook mm/slab.h:586 [inline]
 slab_alloc mm/slab.c:3320 [inline]
 kmem_cache_alloc+0x12c/0x3b0 mm/slab.c:3484
 __d_alloc+0x2a/0x920 fs/dcache.c:1709
 d_alloc_pseudo+0x19/0x70 fs/dcache.c:1838
 alloc_file_pseudo+0xc6/0x250 fs/file_table.c:226
 sock_alloc_file+0x4f/0x190 net/socket.c:411
 sock_map_fd net/socket.c:435 [inline]
 __sys_socket+0x13d/0x200 net/socket.c:1525
 __do_sys_socket net/socket.c:1530 [inline]
 __se_sys_socket net/socket.c:1528 [inline]
 __ia32_sys_socket+0x6f/0xb0 net/socket.c:1528
 do_syscall_32_irqs_on+0x3f/0x60 arch/x86/entry/common.c:428
 __do_fast_syscall_32 arch/x86/entry/common.c:475 [inline]
 do_fast_syscall_32+0x7f/0x120 arch/x86/entry/common.c:503
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7fbb569
Code: Bad RIP value.
RSP: 002b:00000000f5db60cc EFLAGS: 00000296 ORIG_RAX: 0000000000000167
RAX: ffffffffffffffda RBX: 000000000000000a RCX: 0000000000000001
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
