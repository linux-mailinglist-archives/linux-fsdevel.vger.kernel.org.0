Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A0D71FA27
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jun 2023 08:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbjFBGfb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 02:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbjFBGfF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 02:35:05 -0400
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55519EB
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Jun 2023 23:34:50 -0700 (PDT)
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-7776dd75224so67775639f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Jun 2023 23:34:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685687689; x=1688279689;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5b7iEhBjTo1Ves8ZzP/4rVoIwOo9NZWo7v0xLyd34nY=;
        b=BK2dG6AxQOB/500hKUAoDE3JcvRr6xlKQAPYwQdDfWoDNWrTAGXYl9s0ogK/jfYNsw
         WJtQYPVTWb2ruNljt5aGtQWoXPCLq0yM+M9f/uoQy4sx3/zFabugPkTWk3BPPsVpifk2
         nV7ZFVyrDwP87N3Y5mbjwi+SdDWWfjQgMi1v6J9ff3f/8T+g50jdFE/eOqH3k61mC+/V
         Sxuegw6KYehmi49u9cDvHZffcEV45blgozQ/0d16LmeNz0PYdXALSBjb6/BD4sGCxBjM
         ECCXCwV32lunUsEhk1QGH7pqNn4rv4xJcrsYP5SXSfQi1d2u/HyJB5OnNc9+bdIMRLja
         wxfA==
X-Gm-Message-State: AC+VfDwM1hQdJyG6omeJR6yonnK66Dq70JtkKW6l7n49/qM1DZSbFlBd
        V7Z1usuZtigkfHy+iHsQZ28IszAXq/NywLeJuLSJORqhE/fe
X-Google-Smtp-Source: ACHHUZ7n80/krafk/iHXl8GT2tMFWJPpPId2uOH4QdAV+7RopdhyK7JjhpenFpRjMCJTb92MkSSycrM6KMMUTvsyL6XJYE5luN3/
MIME-Version: 1.0
X-Received: by 2002:a02:630a:0:b0:416:7e77:bb5f with SMTP id
 j10-20020a02630a000000b004167e77bb5fmr4576946jac.0.1685687689687; Thu, 01 Jun
 2023 23:34:49 -0700 (PDT)
Date:   Thu, 01 Jun 2023 23:34:49 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f23a0505fd1fbfc1@google.com>
Subject: [syzbot] [xfs?] WARNING in xfs_buf_get_map
From:   syzbot <syzbot+f1b6cf577de987741ca4@syzkaller.appspotmail.com>
To:     djwong@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    715abedee4cd Add linux-next specific files for 20230515
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=171fe7bd280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6a2745d066dda0ec
dashboard link: https://syzkaller.appspot.com/bug?extid=f1b6cf577de987741ca4
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=115992ed280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12fae015280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d4d1d06b34b8/disk-715abede.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3ef33a86fdc8/vmlinux-715abede.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e0006b413ed1/bzImage-715abede.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/d857490c5037/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f1b6cf577de987741ca4@syzkaller.appspotmail.com

XFS (loop0): Ending clean mount
XFS (loop0): Quotacheck needed: Please wait.
XFS (loop0): Quotacheck: Done.
XFS (loop0): xfs_buf_map_verify: daddr 0x7ffffffffff0 out of range, EOFS 0x8000
------------[ cut here ]------------
WARNING: CPU: 1 PID: 5005 at fs/xfs/xfs_buf.c:535 xfs_buf_map_verify fs/xfs/xfs_buf.c:532 [inline]
WARNING: CPU: 1 PID: 5005 at fs/xfs/xfs_buf.c:535 xfs_buf_get_map+0x1db3/0x2fd0 fs/xfs/xfs_buf.c:688
Modules linked in:
CPU: 1 PID: 5005 Comm: syz-executor273 Not tainted 6.4.0-rc2-next-20230515-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
RIP: 0010:xfs_buf_map_verify fs/xfs/xfs_buf.c:535 [inline]
RIP: 0010:xfs_buf_get_map+0x1db3/0x2fd0 fs/xfs/xfs_buf.c:688
Code: eb 75 fe 48 8b b5 50 ff ff ff 49 89 d9 4d 89 f8 48 c7 c1 e0 81 8b 8a 48 c7 c2 40 7e 8b 8a 48 c7 c7 a0 7e 8b 8a e8 7d 22 06 00 <0f> 0b 41 bd 8b ff ff ff e9 cf ee ff ff e8 4b eb 75 fe 4c 89 e7 e8
RSP: 0018:ffffc90003a0f560 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000008000 RCX: 0000000000000000
RDX: ffff888028141dc0 RSI: ffffffff83145c36 RDI: 0000000000000005
RBP: ffffc90003a0f6a8 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000ffffffea R11: 0000000000000001 R12: 0000000000000001
R13: 0000000000000003 R14: dffffc0000000000 R15: 00007ffffffffff0
FS:  000055555688d300(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000066c7e0 CR3: 0000000076741000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 xfs_trans_get_buf_map+0x298/0x710 fs/xfs/xfs_trans_buf.c:156
 xfs_trans_get_buf fs/xfs/xfs_trans.h:189 [inline]
 xfs_dquot_disk_alloc+0x859/0xb80 fs/xfs/xfs_dquot.c:346
 xfs_qm_dqread+0x4dd/0x570 fs/xfs/xfs_dquot.c:665
 xfs_qm_dqget+0x141/0x4b0 fs/xfs/xfs_dquot.c:869
 xfs_qm_vop_dqalloc+0x5f2/0xe70 fs/xfs/xfs_qm.c:1724
 xfs_setattr_nonsize+0xab1/0xd30 fs/xfs/xfs_iops.c:702
 xfs_vn_setattr+0x1fb/0x260 fs/xfs/xfs_iops.c:1023
 notify_change+0xb2c/0x1180 fs/attr.c:483
 chown_common+0x57f/0x650 fs/open.c:774
 vfs_fchown fs/open.c:842 [inline]
 vfs_fchown fs/open.c:834 [inline]
 ksys_fchown+0x115/0x170 fs/open.c:853
 __do_sys_fchown fs/open.c:861 [inline]
 __se_sys_fchown fs/open.c:859 [inline]
 __x64_sys_fchown+0x73/0xb0 fs/open.c:859
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fd290b4b969
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff36598308 EFLAGS: 00000246 ORIG_RAX: 000000000000005d
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fd290b4b969
RDX: 000000000000ee00 RSI: 0000000000000000 RDI: 0000000000000006
RBP: 00007fd290b0b200 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fd290b0b290
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
