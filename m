Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3597378ED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 04:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjFUCK0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 22:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjFUCKY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 22:10:24 -0400
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45250198E
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jun 2023 19:10:20 -0700 (PDT)
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-77e2b91f817so283805939f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jun 2023 19:10:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687313419; x=1689905419;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rGD1kCLK3UO9zPwdYoWf6HQp/ziO4UX3ezLXTcAFRPw=;
        b=V2TlRFWVrUxDMa/YFfIaymZyGuUyj4eT0Jiafew0vgz6ommFT8C+IFvhAMJBQksnhH
         CfUOlVg+lSrPLgN7F1T5Ssr//snJpwWQsfQ53FqZ7EEDc/INa2A4XQKQC6EU51U9O23/
         LChB8Fwrhc+DExa+IhuASBoR0vmr71KBDM+SzjSGnK2KRwmAqB5TxKqrQkZzd2dHU4kv
         6kMYUsWncDLtB46Bc9VIqX8THcn2CB1xHsCNloirYoO4T+nT1KMUspmLQb6fgpIkE8Ei
         Jb6raqBWcZsBp/0VF6E/ew91dfuBuPm7DPFJ8qsLfB9zX8ugCZZHS39Ta995lCJGO8Ns
         WOxA==
X-Gm-Message-State: AC+VfDwi4pI3XUGJ5cbumis/Dq4QZfC+raWNeRz5+GbZWs5Ql32w7MSA
        ynN38HP9hzvkmWB+HQ/DxW9/ifqeIzEG8wYP+WiS7aQrb+vH
X-Google-Smtp-Source: ACHHUZ7Q/9EbX1kpttT8CvsDCX0XJLKMo+55xXxHBXcmfVI6lQYBaxLthKvMTKRqa3PyMHoowWPyxe5UFkwIZ4MgJ8dvBHl3C/h0
MIME-Version: 1.0
X-Received: by 2002:a02:b041:0:b0:426:792a:ec72 with SMTP id
 q1-20020a02b041000000b00426792aec72mr2412676jah.0.1687313419583; Tue, 20 Jun
 2023 19:10:19 -0700 (PDT)
Date:   Tue, 20 Jun 2023 19:10:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ffcb2e05fe9a445c@google.com>
Subject: [syzbot] [xfs?] WARNING: Reset corrupted AGFL on AG NUM. NUM blocks
 leaked. Please unmount and run xfs_repair.
From:   syzbot <syzbot+9d0b0d54a8bd799f6ae4@syzkaller.appspotmail.com>
To:     david@fromorbit.com, dchinner@redhat.com, djwong@kernel.org,
        hch@lst.de, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    40f71e7cd3c6 Merge tag 'net-6.4-rc7' of git://git.kernel.o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=158b99d3280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7ff8f87c7ab0e04e
dashboard link: https://syzkaller.appspot.com/bug?extid=9d0b0d54a8bd799f6ae4
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16ab4537280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=148326ef280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2dc89d5fee38/disk-40f71e7c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0ced5a475218/vmlinux-40f71e7c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d543a4f69684/bzImage-40f71e7c.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/e2012b787a31/mount_0.gz

The issue was bisected to:

commit e0a8de7da35e5b22b44fa1013ccc0716e17b0c14
Author: Dave Chinner <dchinner@redhat.com>
Date:   Mon Jun 5 04:48:15 2023 +0000

    xfs: fix agf/agfl verification on v4 filesystems

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10bb665b280000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12bb665b280000
console output: https://syzkaller.appspot.com/x/log.txt?x=14bb665b280000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9d0b0d54a8bd799f6ae4@syzkaller.appspotmail.com
Fixes: e0a8de7da35e ("xfs: fix agf/agfl verification on v4 filesystems")

XFS (loop0): WARNING: Reset corrupted AGFL on AG 0. 4 blocks leaked. Please unmount and run xfs_repair.
XFS (loop0): Internal error !ino_ok at line 213 of file fs/xfs/libxfs/xfs_dir2.c.  Caller xfs_dir_ino_validate+0x2c/0x90 fs/xfs/libxfs/xfs_dir2.c:220
CPU: 1 PID: 46 Comm: kworker/u4:3 Not tainted 6.4.0-rc6-syzkaller-00195-g40f71e7cd3c6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Workqueue: xfs_iwalk-4998 xfs_pwork_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 xfs_error_report fs/xfs/xfs_error.c:384 [inline]
 xfs_corruption_error+0x11d/0x170 fs/xfs/xfs_error.c:401
 xfs_dir_ino_validate+0x5f/0x90 fs/xfs/libxfs/xfs_dir2.c:213
 xfs_dir2_sf_verify+0x487/0x990 fs/xfs/libxfs/xfs_dir2_sf.c:779
 xfs_ifork_verify_local_data fs/xfs/libxfs/xfs_inode_fork.c:706 [inline]
 xfs_iformat_data_fork+0x4bf/0x6d0 fs/xfs/libxfs/xfs_inode_fork.c:256
 xfs_inode_from_disk+0xbbf/0x1070 fs/xfs/libxfs/xfs_inode_buf.c:245
 xfs_iget_cache_miss fs/xfs/xfs_icache.c:639 [inline]
 xfs_iget+0xf08/0x3050 fs/xfs/xfs_icache.c:777
 xfs_qm_dqusage_adjust+0x228/0x670 fs/xfs/xfs_qm.c:1157
 xfs_iwalk_ag_recs+0x486/0x7c0 fs/xfs/xfs_iwalk.c:220
 xfs_iwalk_run_callbacks+0x25b/0x490 fs/xfs/xfs_iwalk.c:376
 xfs_iwalk_ag+0xad6/0xbd0 fs/xfs/xfs_iwalk.c:482
 xfs_iwalk_ag_work+0xfb/0x1b0 fs/xfs/xfs_iwalk.c:624
 xfs_pwork_work+0x7c/0x190 fs/xfs/xfs_pwork.c:47
 process_one_work+0x8a0/0x10e0 kernel/workqueue.c:2405
 worker_thread+0xa63/0x1210 kernel/workqueue.c:2552
 kthread+0x2b8/0x350 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
XFS (loop0): Corruption detected. Unmount and run xfs_repair
XFS (loop0): Invalid inode number 0x24
XFS (loop0): Metadata corruption detected at xfs_dir2_sf_verify+0x767/0x990 fs/xfs/libxfs/xfs_dir2_sf.c:774, inode 0x23 data fork
XFS (loop0): Unmount and run xfs_repair
XFS (loop0): First 32 bytes of corrupted metadata buffer:
00000000: 02 00 00 00 00 20 05 00 30 66 69 6c 65 30 01 00  ..... ..0file0..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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
