Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98CB7B30C4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 12:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbjI2Knl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 06:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbjI2Knj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 06:43:39 -0400
Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F159D1AC
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Sep 2023 03:43:37 -0700 (PDT)
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-57b66da7116so21451771eaf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Sep 2023 03:43:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695984217; x=1696589017;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k0ftxZRR5u+Fvflo+SQNZa7Ogy6FSoMC45kKGa40Oj0=;
        b=WruNW1Mnr72sEonLZwg0/HQpT6EFew613wBnyzb3bV1LdIQ8CjPj3He/+9Wj4PjpzL
         Fusb2E5pfo6BzRksZ8qwuWlGCyVFP5k5dJzFlasRliyzIRAfy2uNKXo3NxMID68A7Gjn
         o5RM0rFEt6Sk8TibnDHJjJXkoOFhkBKqd+u76pY1uqlur0/He3U4OTGwE6v6S1BoFVhl
         KD3FKGCAoEzVkRMjBmYkIYSAgtOwEPqtFs5LZ0l+d/+9ZgaGWjyRrNk7vgWeoCdcT9/h
         79wJ3RRCsJn5w+o/vdkw8LT1Bg8BihepQTHyRsNPXMxCkuprsA5HGwlPtA6fsi5MvTgZ
         L95A==
X-Gm-Message-State: AOJu0YwrgTdnOU7RDuesAIKR2rqiWM1VhfgFIA1ho68f+EXUdq2GBTVB
        WQBHtw2ssy7FqIVofXAdpEfTwhfkVrAh0RRwilIuZWcfZO+w
X-Google-Smtp-Source: AGHT+IH4SU/YcrZppsDmDzIoAB+uZ0KZRE8blWJFXuH26oF5tBSz3yDBf4aQ0vtzx+us5clXTRW+zOJRamP298VftAUO7CE3c4Cv
MIME-Version: 1.0
X-Received: by 2002:a4a:2c0f:0:b0:57b:7849:1a4d with SMTP id
 o15-20020a4a2c0f000000b0057b78491a4dmr1191984ooo.0.1695984217191; Fri, 29 Sep
 2023 03:43:37 -0700 (PDT)
Date:   Fri, 29 Sep 2023 03:43:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cf826706067d18fd@google.com>
Subject: [syzbot] [btrfs?] WARNING in btrfs_release_global_block_rsv
From:   syzbot <syzbot+10e8dae9863cb83db623@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    8a511e7efc5a Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=133af832680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d594086f139d167
dashboard link: https://syzkaller.appspot.com/bug?extid=10e8dae9863cb83db623
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/943dcd094ce2/disk-8a511e7e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8647d59633ee/vmlinux-8a511e7e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9c6b0fed6523/bzImage-8a511e7e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+10e8dae9863cb83db623@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5077 at fs/btrfs/block-rsv.c:451 btrfs_release_global_block_rsv+0x279/0x2e0 fs/btrfs/block-rsv.c:451
Modules linked in:
CPU: 0 PID: 5077 Comm: syz-executor.0 Not tainted 6.6.0-rc2-syzkaller-00414-g8a511e7efc5a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
RIP: 0010:btrfs_release_global_block_rsv+0x279/0x2e0 fs/btrfs/block-rsv.c:451
Code: ff e8 bb ff ef fd 0f 0b e9 c9 fe ff ff e8 af ff ef fd 0f 0b e9 fe fe ff ff e8 a3 ff ef fd 0f 0b e9 33 ff ff ff e8 97 ff ef fd <0f> 0b e9 68 ff ff ff e8 8b ff ef fd 0f 0b 5b 5d e9 82 ff ef fd e8
RSP: 0018:ffffc90003c7fb78 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88807a310000 RCX: 0000000000000000
RDX: ffff888026559dc0 RSI: ffffffff8397c729 RDI: 0000000000000007
RBP: 000000000000e000 R08: 0000000000000007 R09: 0000000000000000
R10: 000000000000e000 R11: 0000000000000001 R12: dffffc0000000000
R13: 0000000000000001 R14: ffff888067b4a160 R15: ffff888067b4a000
FS:  000055555730c480(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005557ad94b4e8 CR3: 000000003865f000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 btrfs_free_block_groups+0xbb6/0x13d0 fs/btrfs/block-group.c:4380
 close_ctree+0x8c4/0xdd0 fs/btrfs/disk-io.c:4413
 generic_shutdown_super+0x161/0x3c0 fs/super.c:693
 kill_anon_super+0x3a/0x60 fs/super.c:1292
 btrfs_kill_super+0x3b/0x50 fs/btrfs/super.c:2144
 deactivate_locked_super+0x9a/0x170 fs/super.c:481
 deactivate_super+0xde/0x100 fs/super.c:514
 cleanup_mnt+0x222/0x3d0 fs/namespace.c:1254
 task_work_run+0x14d/0x240 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x215/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x1d/0x60 kernel/entry/common.c:296
 do_syscall_64+0x44/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7faf3687de17
Code: b0 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 b0 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffe2bf9fec8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007faf3687de17
RDX: 0000000000000000 RSI: 000000000000000a RDI: 00007ffe2bf9ff80
RBP: 00007ffe2bf9ff80 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffe2bfa1040
R13: 00007faf368c73b9 R14: 00000000001a2e26 R15: 0000000000000018
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
