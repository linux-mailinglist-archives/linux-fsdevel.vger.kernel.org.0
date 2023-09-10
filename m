Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B72B799EB7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Sep 2023 16:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242422AbjIJOwD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Sep 2023 10:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbjIJOwC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Sep 2023 10:52:02 -0400
Received: from mail-pg1-f208.google.com (mail-pg1-f208.google.com [209.85.215.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C748D138
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Sep 2023 07:51:57 -0700 (PDT)
Received: by mail-pg1-f208.google.com with SMTP id 41be03b00d2f7-570096d89b1so3903038a12.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Sep 2023 07:51:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694357517; x=1694962317;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E0Ojb7OTdTxEQDiHU7hYHayp+pPl3jVJoq88mfYTEN8=;
        b=WoK9Hp3rnNebSIM3eVSld/gpzGfdYWc8ByKKObiMGJJ/JTbBjpGk3CUMii0m0poOQb
         cgyzv7OR7ld15OF/nTh+9mDRv6FqPVkKvMsnWWvDGjuLyEq5NcRpgfpUQXIz8312A2AA
         buZIYW540Np+UZtPb6IKM9kNlYS5+c5SSyI98arBzHQOYIP5tll/Fzi8dLwWabynQZMg
         4E28yzVajtYfftCLxcr9FIo1cK5lluntcpL+qMyLhEOE+4CuRbviIVxiU2edykExddNe
         qDLiemJx7l1QCj/ZlLODd++EkITmntrM0ftg6uVxXATiYysHjFiJJ2ySSP9gJBPkrMWW
         oZ+w==
X-Gm-Message-State: AOJu0Yzw3kTonOx4fTloCwMupQtBKqyItEM5D885L3rEKgNMvf0SXM+n
        N+e78XzXGhDkttPDuZrtX2AkgN0EDnqgUPlo3mWXHooD7nSn
X-Google-Smtp-Source: AGHT+IFh6a/vcy8cJxeKhskfFjYE4tPogtEHr8dc2FhFADHhUxC3+m2MDBYvv0OTG7lT4yeqaauzsu/kZMjiQFLLL2BJjscY8lSt
MIME-Version: 1.0
X-Received: by 2002:a17:903:18e:b0:1c3:8976:e816 with SMTP id
 z14-20020a170903018e00b001c38976e816mr2601941plg.2.1694357517285; Sun, 10 Sep
 2023 07:51:57 -0700 (PDT)
Date:   Sun, 10 Sep 2023 07:51:57 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f0bfe70605025941@google.com>
Subject: [syzbot] [gfs2?] kernel BUG in gfs2_quota_cleanup
From:   syzbot <syzbot+3b6e67ac2b646da57862@syzkaller.appspotmail.com>
To:     agruenba@redhat.com, gfs2@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        rpeterso@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    65d6e954e378 Merge tag 'gfs2-v6.5-rc5-fixes' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=150b1d58680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cbf8b29a87b8a830
dashboard link: https://syzkaller.appspot.com/bug?extid=3b6e67ac2b646da57862
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a239a86394dd/disk-65d6e954.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1d7af042d4c5/vmlinux-65d6e954.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cdb5df52c1e3/bzImage-65d6e954.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3b6e67ac2b646da57862@syzkaller.appspotmail.com

RBP: 00007ffd0d57a210 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffd0d57b2d0
R13: 00007fbf640c73b9 R14: 00000000002ca96c R15: 0000000000000003
 </TASK>
------------[ cut here ]------------
kernel BUG at fs/gfs2/quota.c:1485!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 5074 Comm: syz-executor.4 Not tainted 6.5.0-syzkaller-11938-g65d6e954e378 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:gfs2_quota_cleanup+0x5cc/0x6e0 fs/gfs2/quota.c:1485
Code: ff e8 e8 3b e1 fd e8 73 40 e1 fd 49 8d b7 70 12 00 00 89 ea 48 c7 c7 a0 16 da 8a e8 be 5b c4 fd e9 1b fe ff ff e8 54 40 e1 fd <0f> 0b 4c 89 e7 e8 2a 3d 36 fe e9 ef fd ff ff e8 40 3d 36 fe e9 14
RSP: 0018:ffffc900038bfaf0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff888076948200 RSI: ffffffff83a5622c RDI: 0000000000000007
RBP: dffffc0000000000 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000001 R11: 000000000008c8e8 R12: 0000000000000000
R13: 0000000000000000 R14: ffffc900038bfb40 R15: ffff888036950000
FS:  0000555556145480(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f68df122866 CR3: 000000003214a000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 gfs2_make_fs_ro+0x11e/0x350 fs/gfs2/super.c:574
 gfs2_put_super+0x66a/0x760 fs/gfs2/super.c:606
 generic_shutdown_super+0x161/0x3c0 fs/super.c:693
 kill_block_super+0x3b/0x70 fs/super.c:1646
 gfs2_kill_sb+0x361/0x410 fs/gfs2/ops_fstype.c:1811
 deactivate_locked_super+0x9a/0x170 fs/super.c:481
 deactivate_super+0xde/0x100 fs/super.c:514
 cleanup_mnt+0x222/0x3d0 fs/namespace.c:1254
 task_work_run+0x14d/0x240 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x210/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x1d/0x60 kernel/entry/common.c:296
 do_syscall_64+0x44/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fbf6407de17
Code: b0 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 b0 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffd0d57a158 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fbf6407de17
RDX: 0000000000000000 RSI: 000000000000000a RDI: 00007ffd0d57a210
RBP: 00007ffd0d57a210 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffd0d57b2d0
R13: 00007fbf640c73b9 R14: 00000000002ca96c R15: 0000000000000003
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:gfs2_quota_cleanup+0x5cc/0x6e0 fs/gfs2/quota.c:1485
Code: ff e8 e8 3b e1 fd e8 73 40 e1 fd 49 8d b7 70 12 00 00 89 ea 48 c7 c7 a0 16 da 8a e8 be 5b c4 fd e9 1b fe ff ff e8 54 40 e1 fd <0f> 0b 4c 89 e7 e8 2a 3d 36 fe e9 ef fd ff ff e8 40 3d 36 fe e9 14
RSP: 0018:ffffc900038bfaf0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff888076948200 RSI: ffffffff83a5622c RDI: 0000000000000007
RBP: dffffc0000000000 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000001 R11: 000000000008c8e8 R12: 0000000000000000
R13: 0000000000000000 R14: ffffc900038bfb40 R15: ffff888036950000
FS:  0000555556145480(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f68df122866 CR3: 000000003214a000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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
