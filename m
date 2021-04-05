Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A39B3540E7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Apr 2021 12:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234564AbhDEJZb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Apr 2021 05:25:31 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:36933 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234490AbhDEJZ2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Apr 2021 05:25:28 -0400
Received: by mail-io1-f71.google.com with SMTP id u23so10579222ioc.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Apr 2021 02:25:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=/h0l1kiHnvUC5+xcBFny0Tu5gXUTCmKpI5HP9RFWSy0=;
        b=MTN6mUroQ6T+2A1c4qQdlmo5XoxG6XlRXBuC/JBnfQd5jridkPBXfm7WImu3Llg/dk
         NNTZde/afvwS7cS0rSjoZHZ2ZaAdxwkuCAVMMeMeoKjshNoPzJyORvBtVKEhS2XYJpcU
         GZs8sln7slESJ77NJPYo7y0/cx1Wjqkz29lDDbvexlOTn6endxVazDSEDLpy1fxjImBt
         qbnZzRNpyTV5b2ESJdV+45t8PbHBGDK4K4pvQ6IFwrIFgs0p0X5MsZG+QtaStvw5sjua
         fusbFbD+6qLh+slfZptEKDiQaRxjhCaMiRlsOoeaj5tqRkrZ8bO9R+x3YNmhpfxbfhkL
         mXHA==
X-Gm-Message-State: AOAM532GfBqR7JRHQ01g/rgJC/PidO6O2COPuINFyGWnhXA5RIsOkUug
        jymMs5XC3ND8s7K7Nbyr3nGGxW5GDhA/qv3vfDivHPVokS5S
X-Google-Smtp-Source: ABdhPJwYwtwvL4fA3aNWNQFacciKArnUxDLqJM8elQ9/9YE7iIM2TIHiMB+HE7KUIfZJVnGObVi19BV0dWFz0tZw3Sfd9hlqLaO1
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2711:: with SMTP id m17mr22999525jav.115.1617614720284;
 Mon, 05 Apr 2021 02:25:20 -0700 (PDT)
Date:   Mon, 05 Apr 2021 02:25:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c93bd505bf3646ed@google.com>
Subject: [syzbot] WARNING in inc_nlink (2)
From:   syzbot <syzbot+1c8034b9f0e640f9ba45@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    57fbdb15 Merge tag 'scsi-fixes' of git://git.kernel.org/pu..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11e2ccfcd00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=71a75beb62b62a34
dashboard link: https://syzkaller.appspot.com/bug?extid=1c8034b9f0e640f9ba45
compiler:       Debian clang version 11.0.1-2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11bfd511d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17ff8c5ed00000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12b82fbed00000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11b82fbed00000
console output: https://syzkaller.appspot.com/x/log.txt?x=16b82fbed00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1c8034b9f0e640f9ba45@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 4
VFS: Found a V7 FS (block size = 512) on device loop0
------------[ cut here ]------------
WARNING: CPU: 1 PID: 8352 at fs/inode.c:362 inc_nlink+0x11e/0x130 fs/inode.c:362
Modules linked in:
CPU: 1 PID: 8352 Comm: syz-executor549 Not tainted 5.12.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:inc_nlink+0x11e/0x130 fs/inode.c:362
Code: ef ff e9 38 ff ff ff 44 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c 49 ff ff ff 4c 89 ef e8 fc 3f ef ff e9 3c ff ff ff e8 42 59 ab ff <0f> 0b eb 80 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 41 57 41 56
RSP: 0018:ffffc9000178fdf8 EFLAGS: 00010293
RAX: ffffffff81cdbf6e RBX: 1ffff110064a6810 RCX: ffff888015279c40
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff81cdbee8 R09: ffffc9000178fdc8
R10: fffff520002f1fbd R11: 0000000000000000 R12: dffffc0000000000
R13: ffff888032534080 R14: ffff888032534038 R15: 0000000000000000
FS:  0000000000ba9300(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb76c03c0e8 CR3: 0000000011cf3000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 inode_inc_link_count include/linux/fs.h:2297 [inline]
 sysv_mkdir+0x1d/0x120 fs/sysv/namei.c:119
 vfs_mkdir+0x45b/0x640 fs/namei.c:3817
 do_mkdirat+0x209/0x370 fs/namei.c:3842
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x443c29
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff53c97208 EFLAGS: 00000246 ORIG_RAX: 0000000000000053
RAX: ffffffffffffffda RBX: 00000000004004a0 RCX: 0000000000443c29
RDX: 00000000004021f3 RSI: 0000000000000023 RDI: 0000000020000080
RBP: 00000000004034c0 R08: 0000000000000000 R09: 0000000000000000
R10: 00007fff53c970d0 R11: 0000000000000246 R12: 0000000000403550
R13: 0000000000000000 R14: 00000000004b1018 R15: 00000000004004a0


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
