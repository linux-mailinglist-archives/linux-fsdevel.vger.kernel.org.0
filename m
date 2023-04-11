Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EADDD6DD347
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 08:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjDKGrk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 02:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjDKGrj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 02:47:39 -0400
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AB01FC1
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Apr 2023 23:47:36 -0700 (PDT)
Received: by mail-io1-f79.google.com with SMTP id g19-20020a056602243300b00758e7dbd0dbso4995272iob.16
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Apr 2023 23:47:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681195656; x=1683787656;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t0+L91n2dh8XpNcdDIiasQ/kBtXvv2t09DbzRtTFuLE=;
        b=Od2iowh8sv8IuCWW2CgY1SIW9M6NxxxK7YRH8bPCQvgrI1Yp3K8it+S5vHF/AUQgZA
         e0q+a6Zaa/qwmQrXZYNgui+c13wFLFpG9s44MtVdqMheSN+YYv8iVzEiBEufXvfoGfTP
         Ad/AStAYWH39igPGU4lnTSr86MjKnEgyza6VDGcA7mVzztqvO4yfrSoUvZZOQJe7ADLY
         KrZcDSNUWue74gCiKNIiMk/H2ChcBDfSc3eoDcNsXmi4FxoGhk4C1dSsfZzH5a0dhNMN
         MI1t/c+ruXAgX6ZtADDqawqbnKHTG+A+2E+S9OIgmJyGgbGED2Y4UVDL/Q3KPts9EFDr
         s0XQ==
X-Gm-Message-State: AAQBX9c/KTwaqM55n+O+Z0HqThLue8EQ2ckUHepkZhTYHewL1DmsRaDY
        tsJlLh9QtI6Jf8GDwnY9iXrTkrZfwMp9wzIHHW2voIGay/a5
X-Google-Smtp-Source: AKy350bfWJntDqNIVyx7xzI7nakcpj5Hti4YhlMS+6memh1XKTrz5B0CfRrgjBdiYM4ljjJ46PI4MMakabgyOZFvi4w00eTZUGqi
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:96c:b0:326:4af5:28b5 with SMTP id
 q12-20020a056e02096c00b003264af528b5mr12103738ilt.3.1681195655888; Mon, 10
 Apr 2023 23:47:35 -0700 (PDT)
Date:   Mon, 10 Apr 2023 23:47:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000de083b05f909dd53@google.com>
Subject: [syzbot] [btrfs?] WARNING: refcount bug in btrfs_evict_inode
From:   syzbot <syzbot+1d4df08e85265d1ee63d@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.1 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    99ddf2254feb Merge tag 'trace-v6.3-rc5' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13ed5eddc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5666fa6aca264e42
dashboard link: https://syzkaller.appspot.com/bug?extid=1d4df08e85265d1ee63d
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/907a43450c5c/disk-99ddf225.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a142637e5396/vmlinux-99ddf225.xz
kernel image: https://storage.googleapis.com/syzbot-assets/447736ad6200/bzImage-99ddf225.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1d4df08e85265d1ee63d@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 0 PID: 5092 at lib/refcount.c:28 refcount_warn_saturate+0x144/0x1b0 lib/refcount.c:28
Modules linked in:
CPU: 0 PID: 5092 Comm: syz-executor.3 Not tainted 6.3.0-rc5-syzkaller-00032-g99ddf2254feb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
RIP: 0010:refcount_warn_saturate+0x144/0x1b0 lib/refcount.c:28
Code: 0a 01 48 c7 c7 e0 be 37 8b e8 08 72 22 fd 0f 0b eb a9 e8 8f 5a 5a fd c6 05 7a 19 0f 0a 01 48 c7 c7 40 bf 37 8b e8 ec 71 22 fd <0f> 0b eb 8d e8 73 5a 5a fd c6 05 5b 19 0f 0a 01 48 c7 c7 80 be 37
RSP: 0018:ffffc900041ff9c8 EFLAGS: 00010246
RAX: 5ddc86e7f0714d00 RBX: ffff88802aa43ab8 RCX: ffff88807c5457c0
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000003 R08: ffffffff81527c82 R09: fffff5200083feb1
R10: 0000000000000000 R11: dffffc0000000001 R12: dffffc0000000000
R13: 1ffff9200083ff50 R14: ffff888037c1dd70 R15: 1ffff11006f83c40
FS:  00005555556a6400(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fecb9181690 CR3: 000000002d624000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_evict_inode+0x6f4/0x1090 fs/btrfs/inode.c:5398
 evict+0x2a4/0x620 fs/inode.c:665
 dispose_list fs/inode.c:698 [inline]
 evict_inodes+0x5f8/0x690 fs/inode.c:748
 generic_shutdown_super+0x98/0x340 fs/super.c:479
 kill_anon_super+0x3b/0x60 fs/super.c:1107
 btrfs_kill_super+0x41/0x50 fs/btrfs/super.c:2133
 deactivate_locked_super+0xa4/0x110 fs/super.c:331
 cleanup_mnt+0x426/0x4c0 fs/namespace.c:1177
 task_work_run+0x24a/0x300 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop+0xd9/0x100 kernel/entry/common.c:171
 exit_to_user_mode_prepare+0xb1/0x140 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x64/0x280 kernel/entry/common.c:297
 do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fdd1e48d5d7
Code: ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffda94ec348 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fdd1e48d5d7
RDX: 00007ffda94ec41a RSI: 000000000000000a RDI: 00007ffda94ec410
RBP: 00007ffda94ec410 R08: 00000000ffffffff R09: 00007ffda94ec1e0
R10: 00005555556a78b3 R11: 0000000000000246 R12: 00007fdd1e4e6cdc
R13: 00007ffda94ed4d0 R14: 00005555556a7810 R15: 00007ffda94ed510
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
