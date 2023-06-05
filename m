Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D184721CAD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 05:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbjFEDxG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Jun 2023 23:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjFEDxE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Jun 2023 23:53:04 -0400
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7923ABD
        for <linux-fsdevel@vger.kernel.org>; Sun,  4 Jun 2023 20:53:03 -0700 (PDT)
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-33b4cbdd21aso41881155ab.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 04 Jun 2023 20:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685937183; x=1688529183;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=heg9naicJ0m/vz+NA9tT+yaLHLKfezTG0elobdW9XM0=;
        b=TQgwb0Hw2ddiF7jh3q11dCKsnc0pMTeB9PZ4g8jdltzHFiLb0jD9ZXIYEImCXV+Hy2
         3U+Z0coL5EQbfy7rwQZBMT9RW/oaMiMAIcu1yXyRSQ2bw95YjvmD8eDX8VOzIZxkGsqH
         oKp/1SWUpe0rXwAx3XIKf8bzbOfJm8Ze4/vCge75XFUmQlG/jqnxWuqUsj2wgJsf2Czs
         JGdvC4N49+BbNy+BBYv9VR0eI3rRBq8elDClS3cpDk9K8qurnD+JkPgrnIXA1ycXxbtd
         ZJSyeIDFc3kxYPC8QFvVSKSsbSSvFFYUWYJWguReDBuE07wPj2oAWm6pT9dcBFH++GkP
         XaKA==
X-Gm-Message-State: AC+VfDxzcC30urhiR2UJTIAkvR2nbYpLuJGV06I/J/oYjFO3xGmscAY2
        HiNA24lJyMQUZiDLX0tXnO7mCxSajFCl+/b1OIkMcRg9vf6f
X-Google-Smtp-Source: ACHHUZ4Ox28z1NEMvzQNGurRUJ8MDdpqTw8eQrpe/ttMA9Ivul/hlnY1FklybLmLQeRfl08ByWruVk6XFjNmaQ/Sn6lvR7uaBXsE
MIME-Version: 1.0
X-Received: by 2002:a92:c0c7:0:b0:331:3c0d:5a20 with SMTP id
 t7-20020a92c0c7000000b003313c0d5a20mr6797723ilf.0.1685937182823; Sun, 04 Jun
 2023 20:53:02 -0700 (PDT)
Date:   Sun, 04 Jun 2023 20:53:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e55d2005fd59d6c9@google.com>
Subject: [syzbot] [ext4?] WARNING: locking bug in ext4_move_extents
From:   syzbot <syzbot+7f4a6f7f7051474e40ad@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
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

HEAD commit:    9561de3a55be Linux 6.4-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14df9d7d280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7474de833c217bf4
dashboard link: https://syzkaller.appspot.com/bug?extid=7f4a6f7f7051474e40ad
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/661f38eebc53/disk-9561de3a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d6c5afef083c/vmlinux-9561de3a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7506eac4fc9d/bzImage-9561de3a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7f4a6f7f7051474e40ad@syzkaller.appspotmail.com

------------[ cut here ]------------
Looking for class "&ei->i_data_sem" with key init_once.__key.780, but found a different class "&ei->i_data_sem" with the same key
WARNING: CPU: 0 PID: 15140 at kernel/locking/lockdep.c:941 look_up_lock_class+0xc2/0x140 kernel/locking/lockdep.c:938
Modules linked in:
CPU: 0 PID: 15140 Comm: syz-executor.2 Not tainted 6.4.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
RIP: 0010:look_up_lock_class+0xc2/0x140 kernel/locking/lockdep.c:938
Code: 8b 16 48 c7 c0 60 91 1e 90 48 39 c2 74 46 f6 05 5d 02 92 03 01 75 3d c6 05 54 02 92 03 01 48 c7 c7 a0 ae ea 8a e8 de 8a a3 f6 <0f> 0b eb 26 e8 f5 d0 80 f9 48 c7 c7 e0 ad ea 8a 89 de e8 37 ca fd
RSP: 0018:ffffc9000356f410 EFLAGS: 00010046
RAX: 9c96f62a5d44cf00 RBX: ffffffff9009a460 RCX: 0000000000040000
RDX: ffffc9000cf9f000 RSI: 0000000000004e87 RDI: 0000000000004e88
RBP: ffffc9000356f518 R08: ffffffff81530142 R09: ffffed1017305163
R10: 0000000000000000 R11: dffffc0000000001 R12: 0000000000000001
R13: 1ffff920006ade90 R14: ffff888074763488 R15: ffffffff91cac681
FS:  00007fe07ba3e700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2d523000 CR3: 0000000021c7c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 register_lock_class+0x104/0x990 kernel/locking/lockdep.c:1290
 __lock_acquire+0xd3/0x2070 kernel/locking/lockdep.c:4965
 lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5705
 down_write_nested+0x3d/0x50 kernel/locking/rwsem.c:1689
 ext4_move_extents+0x37d/0xe40 fs/ext4/move_extent.c:621
 __ext4_ioctl fs/ext4/ioctl.c:1352 [inline]
 ext4_ioctl+0x3870/0x5b60 fs/ext4/ioctl.c:1608
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xf1/0x160 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fe07ac8c169
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe07ba3e168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fe07adac120 RCX: 00007fe07ac8c169
RDX: 0000000020000280 RSI: 00000000c028660f RDI: 0000000000000007
RBP: 00007fe07ace7ca1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe5c49953f R14: 00007fe07ba3e300 R15: 0000000000022000
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
