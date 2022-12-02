Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804C463FEB2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Dec 2022 04:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbiLBDSw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Dec 2022 22:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbiLBDSr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Dec 2022 22:18:47 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F296BBBC5
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Dec 2022 19:18:46 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id f3-20020a5ec703000000b006dfc19c6378so3458289iop.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Dec 2022 19:18:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=51Uw8V+fBBN3CHWYY7EQPBQRkvt38PkhptDSZMrtUUM=;
        b=HZIWc7AW6BhI2KvUzNBF+bbo0qolhNcsthicETHnUDuEJKqol1XP95WJU9Y0GMawHp
         LBttYVly5gPnvQenSP6vB291KaQ8f/kdRxiJFKTjWIKE0np+V24CkxM59qmxJ+WFvP9t
         axUPRQRCKSSnTWgNn/V67c6105Zef6KjK0AocfIxluye9h0TzENJQRU/tMJa9thyCNKX
         Islf9GR9xq5HcUJYAOKNFkW65kMndwuvPRLWhlV1TvvsUnJXtx/jtwq/PkpavHPFvXGz
         zMn4hgPUb4koq3PUbV4qgB9nEZ0RW3Oj8UKAyQEyGMMzZx4XmvslqRPfNKvaK+Dn6p/a
         oohQ==
X-Gm-Message-State: ANoB5pm/YL8s7VVQYrUh68DqWfxd+6IfiAq++tz+65tO1lEvkxQh7NQq
        Es3j0ym7WrGTnCaQ3sXLYiQv4zSzetvQ+QEi9dNFyPeOTcjU
X-Google-Smtp-Source: AA0mqf6LZtmzLCMIJ5ylMiWPRXlBu6WbOk4zrZcIw1vU5R0nfo8FEp/6HrKiTQkbcDXk2kZJczQx0k79FdgAgoSDYcjLZMcKf1W1
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2184:b0:6bd:4e36:f4d6 with SMTP id
 b4-20020a056602218400b006bd4e36f4d6mr23872816iob.137.1669951125508; Thu, 01
 Dec 2022 19:18:45 -0800 (PST)
Date:   Thu, 01 Dec 2022 19:18:45 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a0d7f305eecfcbb9@google.com>
Subject: [syzbot] WARNING in path_openat
From:   syzbot <syzbot+be8872fcb764bf9fea73@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    cf562a45a0d5 Merge tag 'pull-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1673fbc9880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d01b6e3197974dd
dashboard link: https://syzkaller.appspot.com/bug?extid=be8872fcb764bf9fea73
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6a92dc058341/disk-cf562a45.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c320c2307225/vmlinux-cf562a45.xz
kernel image: https://storage.googleapis.com/syzbot-assets/00049e41b3c5/bzImage-cf562a45.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+be8872fcb764bf9fea73@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_RWSEMS_WARN_ON((rwsem_owner(sem) != current) && !rwsem_test_oflags(sem, RWSEM_NONSPINNABLE)): count = 0x0, magic = 0xffff8880471d2810, owner = 0x0, curr 0xffff88802277d7c0, list empty
WARNING: CPU: 0 PID: 16685 at kernel/locking/rwsem.c:1361 __up_write kernel/locking/rwsem.c:1360 [inline]
WARNING: CPU: 0 PID: 16685 at kernel/locking/rwsem.c:1361 up_write+0x4f9/0x580 kernel/locking/rwsem.c:1615
Modules linked in:
CPU: 0 PID: 16685 Comm: syz-executor.0 Not tainted 6.1.0-rc6-syzkaller-00375-gcf562a45a0d5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:__up_write kernel/locking/rwsem.c:1360 [inline]
RIP: 0010:up_write+0x4f9/0x580 kernel/locking/rwsem.c:1615
Code: c7 40 a3 ed 8a 48 c7 c6 e0 a5 ed 8a 48 8b 54 24 28 48 8b 4c 24 18 4d 89 e0 4c 8b 4c 24 30 31 c0 53 e8 1b 83 e8 ff 48 83 c4 08 <0f> 0b e9 6b fd ff ff 48 c7 c1 98 24 76 8e 80 e1 07 80 c1 03 38 c1
RSP: 0018:ffffc9000599f840 EFLAGS: 00010292
RAX: 98ee50892e908100 RBX: ffffffff8aeda420 RCX: 0000000000040000
RDX: ffffc90003f31000 RSI: 0000000000017f88 RDI: 0000000000017f89
RBP: ffffc9000599f910 R08: ffffffff816e560d R09: fffff52000b33ec1
R10: fffff52000b33ec1 R11: 1ffff92000b33ec0 R12: 0000000000000000
R13: ffff8880471d2810 R14: 1ffff92000b33f10 R15: dffffc0000000000
FS:  00007f50de06a700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb16bd60000 CR3: 0000000051e09000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 inode_unlock include/linux/fs.h:761 [inline]
 open_last_lookups fs/namei.c:3485 [inline]
 path_openat+0x1523/0x2df0 fs/namei.c:3711
 do_filp_open+0x264/0x4f0 fs/namei.c:3741
 do_sys_openat2+0x124/0x4e0 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_open fs/open.c:1334 [inline]
 __se_sys_open fs/open.c:1330 [inline]
 __x64_sys_open+0x221/0x270 fs/open.c:1330
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f50dd28c0d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f50de06a168 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007f50dd3ac050 RCX: 00007f50dd28c0d9
RDX: 0000000000000000 RSI: 0000000000903c40 RDI: 0000000020000040
RBP: 00007f50dd2e7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd1167814f R14: 00007f50de06a300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
