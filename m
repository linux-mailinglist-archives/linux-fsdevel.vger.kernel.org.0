Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEAB03DC1AF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jul 2021 01:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbhG3Xsc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 19:48:32 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:38749 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234037AbhG3Xsb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 19:48:31 -0400
Received: by mail-il1-f198.google.com with SMTP id h27-20020a056e021d9bb02902021736bb95so5793879ila.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jul 2021 16:48:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=XOreqIcoTN1CtO7Rz4sC/ft2790hKcx+mUxiRxZRZCU=;
        b=sqnNVWAaXXyqpdjebNp4LfqMOgEjbepF6MZZ+3YadzmPgEN9cR+RGX6U33u1IW+sfm
         s19BHUbp6zsyicCljUqG9hDkFPuW9tou4iQ9AbXywaVelfBsQlAhrmRcrk7RiD3rlrOs
         0zD6uZXEdkcnEkxArBHqYdQLAtT7QKcPXzlEoEGE187fJdu8ZFkzFC+LgFDIVC8EZtMY
         lYxm7xkrugc/pwjYXiunm9Ox82u6uohjO7To0QJENS9nAI+C7uURlYd4LeNpkPuqhuPa
         5sAUYuc4uL9+0a9S4LgAMsPNi07Afj4Colfswf9G1dSaS75YD4BiutpHqZ670LgSrnId
         AGCA==
X-Gm-Message-State: AOAM530SD6ZS+kyo1pMx9sh8jE7eRsB/dDZd6knnsswrEp8nCBN4sL4g
        apy6AqrVRVu0i1FfZwYaEab+yUMUUv6l8+iJPCJ70BgFo12e
X-Google-Smtp-Source: ABdhPJzTEADX6ZN4Z6+YdAIXInK+cyRyXLX6x1dyM7YnnZMD8vZl09oNarbHWppt9RORDy6snaHPuMUp9NvxnrGuTbgzUwMgvl1C
MIME-Version: 1.0
X-Received: by 2002:a05:6638:418f:: with SMTP id az15mr4146349jab.8.1627688905321;
 Fri, 30 Jul 2021 16:48:25 -0700 (PDT)
Date:   Fri, 30 Jul 2021 16:48:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000001b19a05c85fdb77@google.com>
Subject: [syzbot] WARNING in fuse_get_tree
From:   syzbot <syzbot+afacc3ce1215afa24615@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    2265c5286967 Add linux-next specific files for 20210726
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=102c92b6300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=531dbd796dcea4b4
dashboard link: https://syzkaller.appspot.com/bug?extid=afacc3ce1215afa24615
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14d97fca300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=174a53f8300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+afacc3ce1215afa24615@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 8483 at fs/fuse/inode.c:1595 fuse_get_tree+0x2eb/0x3f0 fs/fuse/inode.c:1595
Modules linked in:
CPU: 1 PID: 8483 Comm: syz-executor536 Not tainted 5.14.0-rc3-next-20210726-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:fuse_get_tree+0x2eb/0x3f0 fs/fuse/inode.c:1595
Code: df 48 8b 85 78 03 00 00 48 89 f9 48 c1 e9 03 80 3c 11 00 0f 85 e8 00 00 00 4c 8b ad 80 03 00 00 4c 39 e8 74 29 e8 05 25 c8 fe <0f> 0b 48 b8 00 00 00 00 00 fc ff df 4c 89 fa 48 c1 ea 03 80 3c 02
RSP: 0018:ffffc9000d6e7d40 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff8880269e6780 RCX: 0000000000000000
RDX: ffff888035118000 RSI: ffffffff82ada24b RDI: ffff8880169b6028
RBP: ffff8880360d3800 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff82ada0de R11: 0000000000000000 R12: ffff88802ada7c00
R13: ffff8880145fe800 R14: ffff8880269e6788 R15: ffff8880360d3b78
FS:  0000000000b25300(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4fd309fc08 CR3: 0000000027619000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 vfs_get_tree+0x89/0x2f0 fs/super.c:1498
 do_new_mount fs/namespace.c:2905 [inline]
 path_mount+0x132a/0x1fa0 fs/namespace.c:3235
 do_mount fs/namespace.c:3248 [inline]
 __do_sys_mount fs/namespace.c:3456 [inline]
 __se_sys_mount fs/namespace.c:3433 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3433
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x43f329
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcdd911e98 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 000000000043f329
RDX: 0000000020002100 RSI: 00000000200020c0 RDI: 0000000000000000
RBP: 0000000000403080 R08: 0000000020002140 R09: 0000000000400488
R10: 0000000000004000 R11: 0000000000000246 R12: 0000000000403110
R13: 0000000000000000 R14: 00000000004ad018 R15: 0000000000400488


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
