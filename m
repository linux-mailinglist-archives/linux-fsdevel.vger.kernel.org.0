Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B63970B501
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 08:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbjEVG0y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 02:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbjEVG0x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 02:26:53 -0400
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE65B103
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 May 2023 23:26:49 -0700 (PDT)
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7741ff634beso286207939f.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 May 2023 23:26:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684736809; x=1687328809;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BtI+GvYH5ZsFWofDYCzflgfz0uNn7VqRyIjfs5bm+zU=;
        b=P9weFR5MWu6mqm/U8MfAiuEEgIMfIuIxZt/cNV/jwY1HzXyoHJRLkeVUwR39SfegO/
         5V8nlTiu8h35XJtJNSrp+mrr/iQB/4MDrNXza/UhHKwoXISbfHiivhKGxOnCH4ZlfD9S
         S2jd16aHG7XfOHZo2J2fZOv1+MwGoLfWa+oKa0vQw34K2BZIeHjQZDO3nSwrcqMYlTNT
         HNLl5JgkzSd/N/txAnJN1Qh22HC8RZnjP6J5EJUWhhZNpiaOVENJkCtx096bF3grUEcm
         awirMWAm4Evw0QXZDIphi9JGlh0LxMEvFzpb+A0eRzvgEFBUxu8EVOGB/Pi3fOlV2vym
         tSYA==
X-Gm-Message-State: AC+VfDz1uUmMApCO2PxAphh1E4JPHRboif24LQ1w7p4UYAohWXhH8ywf
        0HpbwDD4gs9fgmx8xC5IOWgcd0r/WTz+p9jh5UlXeSFEKnHZ
X-Google-Smtp-Source: ACHHUZ5g5t2f3MeZDCiz7f0ns0TKviVI4U7PwjJMtK3e8hPzQeo/Jumh50ZfBpPKm3gJrqbOPbB3eUZ+ofTcCgIxfmfWSl/nlNp0
MIME-Version: 1.0
X-Received: by 2002:a02:b11a:0:b0:41a:f21d:752 with SMTP id
 r26-20020a02b11a000000b0041af21d0752mr729323jah.4.1684736808969; Sun, 21 May
 2023 23:26:48 -0700 (PDT)
Date:   Sun, 21 May 2023 23:26:48 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000009ee1005fc425b4b@google.com>
Subject: [syzbot] [btrfs?] WARNING in btrfs_split_ordered_extent
From:   syzbot <syzbot+ee90502d5c8fd1d0dd93@syzkaller.appspotmail.com>
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

HEAD commit:    e2065b8c1b01 Merge tag '6.4-rc2-ksmbd-server-fixes' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11bfcf86280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bda401fa9c6b4502
dashboard link: https://syzkaller.appspot.com/bug?extid=ee90502d5c8fd1d0dd93
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/738631cdfb7d/disk-e2065b8c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0b5c143f1c5e/vmlinux-e2065b8c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8fd7bb0bb108/bzImage-e2065b8c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ee90502d5c8fd1d0dd93@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 25629 at fs/btrfs/ordered-data.c:1138 btrfs_split_ordered_extent+0x628/0x840
Modules linked in:
CPU: 1 PID: 25629 Comm: syz-executor.3 Not tainted 6.4.0-rc2-syzkaller-00338-ge2065b8c1b01 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/28/2023
RIP: 0010:btrfs_split_ordered_extent+0x628/0x840 fs/btrfs/ordered-data.c:1138
Code: fe 48 c7 c7 20 92 2a 8b 48 c7 c6 a0 8d 2a 8b ba 6c 04 00 00 e8 a9 52 1d 07 e8 04 62 fb fd 0f 0b e9 21 fb ff ff e8 f8 61 fb fd <0f> 0b bb ea ff ff ff eb b0 e8 ea 61 fb fd 0f 0b bb ea ff ff ff eb
RSP: 0018:ffffc90005586dd8 EFLAGS: 00010246
RAX: ffffffff83901aa8 RBX: 0000000000010000 RCX: 0000000000040000
RDX: ffffc9000b999000 RSI: 000000000003ffff RDI: 0000000000040000
RBP: 1ffff1100ec235e1 R08: ffffffff83901672 R09: fffffbfff1cab8b6
R10: 0000000000000000 R11: dffffc0000000001 R12: dffffc0000000000
R13: ffff88807611af08 R14: 0000000000001000 R15: 00000000000a0000
FS:  00007f90dfaa6700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005621df2bfc70 CR3: 0000000020f04000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_extract_ordered_extent+0x12c/0xb00 fs/btrfs/inode.c:2625
 btrfs_dio_submit_io+0x239/0x340 fs/btrfs/inode.c:7737
 iomap_dio_submit_bio fs/iomap/direct-io.c:75 [inline]
 iomap_dio_bio_iter+0xe15/0x1430 fs/iomap/direct-io.c:355
 __iomap_dio_rw+0x12c3/0x22e0 fs/iomap/direct-io.c:598
 btrfs_dio_write+0xb6/0x100 fs/btrfs/inode.c:7770
 btrfs_direct_write fs/btrfs/file.c:1529 [inline]
 btrfs_do_write_iter+0x870/0x1270 fs/btrfs/file.c:1674
 do_iter_write+0x7b1/0xcb0 fs/read_write.c:860
 iter_file_splice_write+0x843/0xfe0 fs/splice.c:795
 do_splice_from fs/splice.c:873 [inline]
 direct_splice_actor+0xe7/0x1c0 fs/splice.c:1039
 splice_direct_to_actor+0x4c4/0xbd0 fs/splice.c:994
 do_splice_direct+0x283/0x3d0 fs/splice.c:1082
 do_sendfile+0x620/0xff0 fs/read_write.c:1254
 __do_sys_sendfile64 fs/read_write.c:1322 [inline]
 __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1308
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f90dec8c169
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f90dfaa6168 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f90dedac050 RCX: 00007f90dec8c169
RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000004
RBP: 00007f90dece7ca1 R08: 0000000000000000 R09: 0000000000000000
R10: 000080001d00c0d0 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc28d1208f R14: 00007f90dfaa6300 R15: 0000000000022000
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
