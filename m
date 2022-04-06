Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3934F548D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 07:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349058AbiDFFP2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 01:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiDFEzL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 00:55:11 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748EC1C7C1A
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Apr 2022 17:45:27 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id d19-20020a0566022bf300b00645eba5c992so618943ioy.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Apr 2022 17:45:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=K8hWI48Li8trbK+jUlQuleE3ZHhh2wmLyXeEDXW43vw=;
        b=zfDrEfODlGFp0VY/5yKfEs20IkuVvnLvfqCT7I082MRkSlLCvymVSYwfa+mR7ZnF/E
         GAv0B/0ng1VR0BHeOYVl/1F2OnmAKwrhaCSMiWB0hR2U8h5jNj8T/zk77y76R36DeOuH
         kK1AkY/MyIVaSk8Z4hq1M/wu4HGYhWRhhcpWAxAc8/g3p2W+wPIK4LIgBd+eLFPS0x92
         Bk921Mhxspe85efuW8HZrxMZq1DUlRoLB1/vX+cgUEygmQaynFb8ibcgVvYXPJWeXmM1
         R2tCVA5Ztdt6lm1MBHuHdQ1XqvlgYp+0L07XTiA1Gi0nEcyfmpp0Zz1/e/8ANQPdc23l
         vvQw==
X-Gm-Message-State: AOAM531hymJjTtb6ATc/QMf0aSEdhGaXu5k4seByK4oQngTxJ5NpNIhW
        D2LZqbiIGL9DXs5wbk5X4xeM8VgcIHEk1MO88F4fc6bR7WtU
X-Google-Smtp-Source: ABdhPJzwKvT+DPbOFb3e0/wxaOlCTgDcZf2KDM+dO7ftVXxNA8V5tTN2Jhg99YnAA0syhK/cF4tivFBSAouXsHOie8j/ulxusMxn
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d03:b0:2c7:e33f:2557 with SMTP id
 i3-20020a056e021d0300b002c7e33f2557mr3225518ila.15.1649205926868; Tue, 05 Apr
 2022 17:45:26 -0700 (PDT)
Date:   Tue, 05 Apr 2022 17:45:26 -0700
In-Reply-To: <0000000000000cede205dbf052bc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006ebdf405dbf1ad65@google.com>
Subject: Re: [syzbot] general protection fault in simple_recursive_removal (2)
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    ce4c854ee868 Merge tag 'for-5.18-rc1-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16258680f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=595bcd2109a73f9c
dashboard link: https://syzkaller.appspot.com/bug?extid=17404da5afdf21e8d612
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13b7765b700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16de6637700000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+17404da5afdf21e8d612@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc000000002a: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000150-0x0000000000000157]
CPU: 1 PID: 3623 Comm: udevd Not tainted 5.18.0-rc1-syzkaller-00009-gce4c854ee868 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__lock_acquire+0xd85/0x56c0 kernel/locking/lockdep.c:4899
Code: 1a 0e 41 be 01 00 00 00 0f 86 c8 00 00 00 89 05 21 8d 1a 0e e9 bd 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 da 48 c1 ea 03 <80> 3c 02 00 0f 85 15 31 00 00 48 81 3b 20 d4 22 8f 0f 84 4f f3 ff
RSP: 0018:ffffc90003b5f9f0 EFLAGS: 00010002
RAX: dffffc0000000000 RBX: 0000000000000150 RCX: 0000000000000000
RDX: 000000000000002a RSI: 0000000000000000 RDI: 0000000000000150
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
R13: ffff888079c50000 R14: 0000000000000000 R15: 0000000000000000
FS:  00007faa8035a840(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000561474c18580 CR3: 0000000019f83000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
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
RIP: 0033:0x7faa7ff25fc3
Code: 48 ff ff ff b8 ff ff ff ff e9 3e ff ff ff 66 0f 1f 84 00 00 00 00 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c 24 0c e8
RSP: 002b:00007fff33290db8 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 00007faa8035a6a8 RCX: 00007faa7ff25fc3
RDX: 000000000000001c RSI: 00007fff332905b8 RDI: 0000000000000008
RBP: 0000561474c196f0 R08: 0000000000000007 R09: 0000561474c22c30
R10: 00007faa7ffb4fc0 R11: 0000000000000246 R12: 0000000000000002
R13: 0000561474bf8aa0 R14: 0000000000000008 R15: 0000561474bef910
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__lock_acquire+0xd85/0x56c0 kernel/locking/lockdep.c:4899
Code: 1a 0e 41 be 01 00 00 00 0f 86 c8 00 00 00 89 05 21 8d 1a 0e e9 bd 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 da 48 c1 ea 03 <80> 3c 02 00 0f 85 15 31 00 00 48 81 3b 20 d4 22 8f 0f 84 4f f3 ff
RSP: 0018:ffffc90003b5f9f0 EFLAGS: 00010002

RAX: dffffc0000000000 RBX: 0000000000000150 RCX: 0000000000000000
RDX: 000000000000002a RSI: 0000000000000000 RDI: 0000000000000150
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
R13: ffff888079c50000 R14: 0000000000000000 R15: 0000000000000000
FS:  00007faa8035a840(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000561474c18580 CR3: 0000000019f83000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
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

