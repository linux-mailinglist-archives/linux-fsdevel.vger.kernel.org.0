Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041036E8180
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 20:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjDSSwv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Apr 2023 14:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjDSSwu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Apr 2023 14:52:50 -0400
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038CF4682
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Apr 2023 11:52:48 -0700 (PDT)
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-32aff212197so302125ab.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Apr 2023 11:52:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681930367; x=1684522367;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vZQm9ajXkGotCE4OxQ7g7sW/rOm7TAAFTPwqwxq0WKc=;
        b=bO/YYzNz0hwEz4sfXqnPfXCev0LyduccaIGriz6CD+v/zxrvV/wsbjJlCOsWTmqr73
         hIrwEjBezzpj/oLX7fPNkG+0UALobqPvvr6dxnCE2DDvWvMoVvVR8eTfv3T+risbXO5w
         nkKcKXCzu8A4vbhBFShKPKm15rzLKn7pwlb7f8rTnwFK5qi82tMYsGkXVBoupsfFO8Ui
         xXZMZDg5Rw+UiVWf1fkh3kESeOX9JfPvwMyCPS98n+Ph3Bz/Q4a81TaV991OWs2N8lzD
         UJHzq8r87YyLJuBW5U5kmlFH02NtcKxgZ2ptnadDgcyzGv7s0mQ265F9krrOvfdShLbD
         wLkw==
X-Gm-Message-State: AAQBX9dthKxe3YKLXsm3IgcY4/s3RdxqA45tkmk9HppMxiua8Iz+Fe69
        lV/jmhFlixo4/kuJ2lUnIjJYjRi1HDoAhhwQZd+cuVVB1Ntj
X-Google-Smtp-Source: AKy350aloVDDl5G+HPKwo89i1D7agjSsVu6G7IrkD2bdBIsH+IvUhYRKiYoYh9s6nvo1ZrMxrK7m05j69InN0TR9Zv5spcF/Csse
MIME-Version: 1.0
X-Received: by 2002:a92:d482:0:b0:328:7b75:a5fe with SMTP id
 p2-20020a92d482000000b003287b75a5femr391854ilg.5.1681930367357; Wed, 19 Apr
 2023 11:52:47 -0700 (PDT)
Date:   Wed, 19 Apr 2023 11:52:47 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000015760b05f9b4eee9@google.com>
Subject: [syzbot] [ext4?] WARNING in ext4_iomap_overwrite_begin
From:   syzbot <syzbot+08106c4b7d60702dbc14@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
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

HEAD commit:    7a934f4bd7d6 Merge tag 'riscv-for-linus-6.3-rc7' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16d9b923c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=759d5e665e47a55
dashboard link: https://syzkaller.appspot.com/bug?extid=08106c4b7d60702dbc14
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ef1965f1c04f/disk-7a934f4b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1ac35470cc62/vmlinux-7a934f4b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b0021ea0d165/bzImage-7a934f4b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+08106c4b7d60702dbc14@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 30014 at fs/ext4/inode.c:3574 ext4_iomap_overwrite_begin+0x7d/0xa0
Modules linked in:
CPU: 1 PID: 30014 Comm: syz-executor.1 Not tainted 6.3.0-rc6-syzkaller-00173-g7a934f4bd7d6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
RIP: 0010:ext4_iomap_overwrite_begin+0x7d/0xa0 fs/ext4/inode.c:3574
Code: 2d 0f b7 1b bf 02 00 00 00 89 de e8 1d 15 52 ff 83 fb 02 75 10 e8 f3 11 52 ff 89 e8 5b 41 5c 41 5e 41 5f 5d c3 e8 e3 11 52 ff <0f> 0b eb ec 89 d9 80 e1 07 fe c1 38 c1 7c c8 48 89 df e8 3c d2 a7
RSP: 0018:ffffc9000a4cf0b0 EFLAGS: 00010293
RAX: ffffffff823864dd RBX: 0000000000000000 RCX: ffff88807d391d40
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000002
RBP: 00000000ffffff8b R08: ffffffff823864c3 R09: ffffed100f18877a
R10: 0000000000000000 R11: dffffc0000000001 R12: ffff88803d4fd2f0
R13: ffff88803d4fd2f0 R14: 0000000000010000 R15: 0000000000090000
FS:  00007fe681b6e700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2767115dc9 CR3: 000000002b556000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 iomap_iter+0x677/0xec0 fs/iomap/iter.c:91
 __iomap_dio_rw+0xd74/0x20d0 fs/iomap/direct-io.c:594
 iomap_dio_rw+0x46/0xa0 fs/iomap/direct-io.c:683
 ext4_dio_write_iter fs/ext4/file.c:597 [inline]
 ext4_file_write_iter+0x1509/0x1930 fs/ext4/file.c:708
 do_iter_write+0x6ea/0xc50 fs/read_write.c:861
 iter_file_splice_write+0x843/0xfe0 fs/splice.c:778
 do_splice_from fs/splice.c:856 [inline]
 direct_splice_actor+0xe7/0x1c0 fs/splice.c:1022
 splice_direct_to_actor+0x4c4/0xbd0 fs/splice.c:977
 do_splice_direct+0x283/0x3d0 fs/splice.c:1065
 do_sendfile+0x620/0xff0 fs/read_write.c:1255
 __do_sys_sendfile64 fs/read_write.c:1323 [inline]
 __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1309
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fe680e8c169
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe681b6e168 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007fe680fabf80 RCX: 00007fe680e8c169
RDX: 0000000000000000 RSI: 0000000000000005 RDI: 0000000000000005
RBP: 00007fe680ee7ca1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000008800000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc42fc2daf R14: 00007fe681b6e300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
