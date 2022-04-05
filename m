Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01CE34F54CE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 07:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiDFFOv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 01:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1841063AbiDFBPD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Apr 2022 21:15:03 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751CA27FF2
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Apr 2022 16:08:19 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id s4-20020a92c5c4000000b002c7884b8608so557126ilt.21
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Apr 2022 16:08:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=A+mWdme+YYmhASEFhasCrli2+Kgbv+ASyCSwll2CXxM=;
        b=qBKIgTWU0fkImCUPpJIBdcM0+WMetUlKdZMgHg6tUEu2AEobqDrL6Ji7k0HK6HKsxd
         kxkQPlQhm6gEXe9Ul+WzBz/M9ZNFP2Oh27QsuOvIB2jnoQWtbWJ3XwmHSGHna5Sshozt
         i4xJWnCrOKkk22+6rb8xqNLK5+a5nCCGmg4fl7dtg0M+iCcx7pVB/TWubpEVP7mWBLX0
         12efMWAa+BSDJPt9VX2acEnVJi/nLpBN0DG39GNdhFJVLkC7piNGncNsY264AHpopTRu
         xVBJhzSjjkrvcsVIbRGJoAklF3Q6P8IDPspYNu69Gm6h6EyI1z7c6lPBS5qWci6RqDSd
         pqQQ==
X-Gm-Message-State: AOAM53258wtFN6fjBWXmU4x7Trg1Qpc5wm3APhJC04mJCYSy8kEU6ApF
        2wUbi2dg/Q/oGd7ah9NheOCS/4uw1TEzOVgPFZR4IoSjEGad
X-Google-Smtp-Source: ABdhPJyQfcW7dv/4UxyJRY3K9j+CZkqD2d1U1thU2nJ0YZIB6bnq1bpvwBGkxCCxpwBqHumD71RRS4jq3qiIYbhEOzNtRCyLlzof
MIME-Version: 1.0
X-Received: by 2002:a05:6602:29ca:b0:649:558a:f003 with SMTP id
 z10-20020a05660229ca00b00649558af003mr2863525ioq.160.1649200098763; Tue, 05
 Apr 2022 16:08:18 -0700 (PDT)
Date:   Tue, 05 Apr 2022 16:08:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000cede205dbf052bc@google.com>
Subject: [syzbot] general protection fault in simple_recursive_removal (2)
From:   syzbot <syzbot+17404da5afdf21e8d612@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ce4c854ee868 Merge tag 'for-5.18-rc1-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15339f9b700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=595bcd2109a73f9c
dashboard link: https://syzkaller.appspot.com/bug?extid=17404da5afdf21e8d612
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16e820b0f00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+17404da5afdf21e8d612@syzkaller.appspotmail.com

sd 1:0:0:1: [sdb] Test Unit Ready failed: Result: hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK
general protection fault, probably for non-canonical address 0xdffffc000000002a: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000150-0x0000000000000157]
CPU: 1 PID: 3660 Comm: udevd Not tainted 5.18.0-rc1-syzkaller-00009-gce4c854ee868 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__lock_acquire+0xd85/0x56c0 kernel/locking/lockdep.c:4899
Code: 1a 0e 41 be 01 00 00 00 0f 86 c8 00 00 00 89 05 21 8d 1a 0e e9 bd 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 da 48 c1 ea 03 <80> 3c 02 00 0f 85 15 31 00 00 48 81 3b 20 d4 22 8f 0f 84 4f f3 ff
RSP: 0018:ffffc90003e7f9f0 EFLAGS: 00010012
RAX: dffffc0000000000 RBX: 0000000000000150 RCX: 0000000000000000
RDX: 000000000000002a RSI: 0000000000000000 RDI: 0000000000000150
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
R13: ffff88801b90d700 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f9eb648e840(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffdb4657128 CR3: 0000000075f97000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 lock_acquire kernel/locking/lockdep.c:5641 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5606
 down_write+0x90/0x150 kernel/locking/rwsem.c:1514
 inode_lock include/linux/fs.h:748 [inline]
 simple_recursive_removal+0x171/0x830 fs/libfs.c:276
 debugfs_remove fs/debugfs/inode.c:742 [inline]
 debugfs_remove+0x59/0x80 fs/debugfs/inode.c:736
 blk_mq_debugfs_unregister_queue_rqos+0x34/0x70 block/blk-mq-debugfs.c:840
 rq_qos_exit+0x1e/0xf0 block/blk-rq-qos.c:297
 disk_release_mq block/genhd.c:1142 [inline]
 disk_release+0x191/0x420 block/genhd.c:1168
 device_release+0x9f/0x240 drivers/base/core.c:2229
 kobject_cleanup lib/kobject.c:705 [inline]
 kobject_release lib/kobject.c:736 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1c8/0x540 lib/kobject.c:753
 put_device+0x1b/0x30 drivers/base/core.c:3512
 blkdev_close+0x64/0x80 block/fops.c:512
 __fput+0x277/0x9d0 fs/file_table.c:317
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:169 [inline]
 exit_to_user_mode_prepare+0x23c/0x250 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:294
 do_syscall_64+0x42/0x80 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f9eb65a9fc3
Code: 48 ff ff ff b8 ff ff ff ff e9 3e ff ff ff 66 0f 1f 84 00 00 00 00 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c 24 0c e8
RSP: 002b:00007ffdb465f5d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 00007f9eb648e6a8 RCX: 00007f9eb65a9fc3
RDX: 000000000000001c RSI: 00007ffdb465edd8 RDI: 0000000000000008
RBP: 000055bf88f240c0 R08: 0000000000000007 R09: 000055bf88f36110
R10: 00007f9eb6638fc0 R11: 0000000000000246 R12: 0000000000000002
R13: 000055bf88f34760 R14: 0000000000000008 R15: 000055bf88efe910
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__lock_acquire+0xd85/0x56c0 kernel/locking/lockdep.c:4899
Code: 1a 0e 41 be 01 00 00 00 0f 86 c8 00 00 00 89 05 21 8d 1a 0e e9 bd 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 da 48 c1 ea 03 <80> 3c 02 00 0f 85 15 31 00 00 48 81 3b 20 d4 22 8f 0f 84 4f f3 ff
RSP: 0018:ffffc90003e7f9f0 EFLAGS: 00010012
RAX: dffffc0000000000 RBX: 0000000000000150 RCX: 0000000000000000
RDX: 000000000000002a RSI: 0000000000000000 RDI: 0000000000000150
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
R13: ffff88801b90d700 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f9eb648e840(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffdb4657128 CR3: 0000000075f97000 CR4: 0000000000350ee0
----------------
Code disassembly (best guess):
   0:	1a 0e                	sbb    (%rsi),%cl
   2:	41 be 01 00 00 00    	mov    $0x1,%r14d
   8:	0f 86 c8 00 00 00    	jbe    0xd6
   e:	89 05 21 8d 1a 0e    	mov    %eax,0xe1a8d21(%rip)        # 0xe1a8d35
  14:	e9 bd 00 00 00       	jmpq   0xd6
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 da             	mov    %rbx,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 15 31 00 00    	jne    0x3149
  34:	48 81 3b 20 d4 22 8f 	cmpq   $0xffffffff8f22d420,(%rbx)
  3b:	0f                   	.byte 0xf
  3c:	84 4f f3             	test   %cl,-0xd(%rdi)
  3f:	ff                   	.byte 0xff


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
