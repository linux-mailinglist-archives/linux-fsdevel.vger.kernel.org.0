Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3D673D717
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 07:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjFZFML (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 01:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjFZFMK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 01:12:10 -0400
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD3411C
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Jun 2023 22:12:09 -0700 (PDT)
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-77e3208a8cbso176746439f.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Jun 2023 22:12:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687756328; x=1690348328;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ojb7kuTKJ18/8e1gtXeaa7XjyqwxGsX0VX1WGna9B+8=;
        b=Y2FELsWz2IQ0zNELMxuZFHx6MDXRASdikVeDdjRA7JOvmLAyVMpYygM3zDZkyh2y2x
         mk3bB+UqbtYbxUhJSpiMdDaC8KXW5So16O6QxWhzpiFizpHlHPuGxLY/cpMrzziREpFE
         7NcyL56tmX3ZgHDjsY22jxxXe6+E7IhGkWWhOPe+B8sF/FU3FpelDhKNjICpJib7zD6m
         Y4Y+lxwJs2LEDvofDDxMoIpd6VqGnIZIHCwWJ4f+t+xmiBHJyLscQHLjKQdgWGzKIckM
         //M7vQMdsMxkiGAY1uCYWrdRpj0ujWgzNlyoxgDRUClm6pgPRB1YJfbzAO6Ig4zd0qec
         7HEQ==
X-Gm-Message-State: AC+VfDyhmXqVYUGOZyFFtT4WLrIMWN35fPtYk/Ee77ujcr3FKyCE3KfI
        yTCdcVk4RJuAEzA63CeC+ETCSig/YydA8nM5ji5fMtAsYsVr
X-Google-Smtp-Source: ACHHUZ6zna+P9pQSuzjChjv9oSj/1mVil2IGnrtDaf9QAW2R/UmAwrXdOKHJ1zU4OU57/HMQ0VeOZRODjeUfO6zmwbmfc7b6Ka+e
MIME-Version: 1.0
X-Received: by 2002:a92:c607:0:b0:345:6ce1:d252 with SMTP id
 p7-20020a92c607000000b003456ce1d252mr2171523ilm.0.1687756328515; Sun, 25 Jun
 2023 22:12:08 -0700 (PDT)
Date:   Sun, 25 Jun 2023 22:12:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006dbf1305ff0164a9@google.com>
Subject: [syzbot] [btrfs?] WARNING: refcount bug in __btrfs_release_delayed_node
From:   syzbot <syzbot+2bf8c3b6bedb88990d40@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    45a3e24f65e9 Linux 6.4-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12c15540a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2cbd298d0aff1140
dashboard link: https://syzkaller.appspot.com/bug?extid=2bf8c3b6bedb88990d40
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/872a8054b07c/disk-45a3e24f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/329227d8d5e9/vmlinux-45a3e24f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e6e7d7b9074e/bzImage-45a3e24f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2bf8c3b6bedb88990d40@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 1 PID: 5056 at lib/refcount.c:28 refcount_warn_saturate+0x107/0x1f0 lib/refcount.c:28
Modules linked in:
CPU: 1 PID: 5056 Comm: syz-executor.4 Not tainted 6.4.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
RIP: 0010:refcount_warn_saturate+0x107/0x1f0 lib/refcount.c:28
Code: 1d c4 8b 51 0a 31 ff 89 de e8 f5 ef 70 fd 84 db 75 a3 e8 0c f4 70 fd 48 c7 c7 c0 d6 a6 8a c6 05 a4 8b 51 0a 01 e8 49 af 38 fd <0f> 0b eb 87 e8 f0 f3 70 fd 0f b6 1d 8d 8b 51 0a 31 ff 89 de e8 c0
RSP: 0018:ffffc900042cfa60 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff8880286bbb80 RSI: ffffffff814c03b7 RDI: 0000000000000001
RBP: ffff8880275112f8 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000082828 R12: ffff88802b4cf300
R13: ffff8880275112f8 R14: ffff888027511308 R15: ffff8880275111c8
FS:  0000555556773400(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcf1bad56be CR3: 000000003f591000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 __refcount_sub_and_test include/linux/refcount.h:283 [inline]
 __refcount_dec_and_test include/linux/refcount.h:315 [inline]
 refcount_dec_and_test include/linux/refcount.h:333 [inline]
 __btrfs_release_delayed_node.part.0+0xb3b/0xf50 fs/btrfs/delayed-inode.c:263
 __btrfs_release_delayed_node fs/btrfs/delayed-inode.c:251 [inline]
 btrfs_release_delayed_node fs/btrfs/delayed-inode.c:281 [inline]
 btrfs_remove_delayed_node+0x52/0x60 fs/btrfs/delayed-inode.c:1285
 btrfs_evict_inode+0x4f4/0xe50 fs/btrfs/inode.c:5336
 evict+0x2ed/0x6b0 fs/inode.c:665
 dispose_list+0x117/0x1e0 fs/inode.c:698
 evict_inodes+0x345/0x440 fs/inode.c:748
 generic_shutdown_super+0xaf/0x480 fs/super.c:479
 kill_anon_super+0x3a/0x60 fs/super.c:1107
 btrfs_kill_super+0x3c/0x50 fs/btrfs/super.c:2144
 deactivate_locked_super+0x98/0x160 fs/super.c:331
 deactivate_super+0xb1/0xd0 fs/super.c:362
 cleanup_mnt+0x2ae/0x3d0 fs/namespace.c:1177
 task_work_run+0x16f/0x270 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x210/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:297
 do_syscall_64+0x46/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f4b5f28d7f7
Code: ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd5b600188 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f4b5f28d7f7
RDX: 00007ffd5b60025c RSI: 000000000000000a RDI: 00007ffd5b600250
RBP: 00007ffd5b600250 R08: 00000000ffffffff R09: 00007ffd5b600020
R10: 0000555556774893 R11: 0000000000000246 R12: 00007f4b5f2d643b
R13: 00007ffd5b601310 R14: 0000555556774810 R15: 00007ffd5b601350
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
