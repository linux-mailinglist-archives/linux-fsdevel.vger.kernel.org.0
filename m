Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62462671577
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 08:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjARHx7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 02:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjARHxY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 02:53:24 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58CB5086E
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jan 2023 23:25:45 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id r6-20020a92cd86000000b00304b2d1c2d7so24597684ilb.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jan 2023 23:25:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ivgSV92Oi5FVoR/20XuBNu6r+IAr4WImSCana9ynsY=;
        b=I5CfAubsvCuO6+uvlc+ojqYtv2dPPHQGrq8GWHuq9g38EKubVk3hA+ebwX/5YrZO6+
         Yjq9y3jqQ/2o4la+m4WaDvpSMsZfGZ4gqfSqhRShaiDkt/Al171JVwPf827z1r0Le2K3
         wy9HjWW/CG2jQ9isUyhWMYi+q/43p6fOgvqDjo1mTD/miRZBgkzkgNQiqnTWq/3tkC89
         1uK+LRH8evKji9AjghdPOdNfyfoCuyq2HKD1gB+VI2fk2wWHXxVAU8nfjcLgn2GnLwod
         C8PHypCATNNzHtnDFGRhZVER6xd5ChXqkNWkzuPuNXJfUsFsVT8qMidKIhkdixk+tUoH
         3BGw==
X-Gm-Message-State: AFqh2kqxJdsTq0pGQyaGuCwAcEHSk0bqczxfUlPHVk1oXYW2FGaRIWDf
        Jbw3PAhln01yEvhY3MwawURTZNm03pE3975GR11ChIrFiyD7
X-Google-Smtp-Source: AMrXdXt6lgjLD0Ps+TN8wHiJN5ww/dcUgTz95e2zkLSvx9rOTXnsnCOgRq6z8Rx3SxuqKFYOGfIQDEibrl/r7rrpC9C8JPFgZLOU
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:106:b0:30f:12c9:f765 with SMTP id
 t6-20020a056e02010600b0030f12c9f765mr797992ilm.187.1674026745134; Tue, 17 Jan
 2023 23:25:45 -0800 (PST)
Date:   Tue, 17 Jan 2023 23:25:45 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007d069905f284b9d9@google.com>
Subject: [syzbot] [hfsplus?] kernel BUG in hfsplus_bnode_put
From:   syzbot <syzbot+005d2a9ecd9fbf525f6a@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, fmdefrancesco@gmail.com,
        ira.weiny@intel.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, slava@dubeyko.com,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d9fc1511728c Merge tag 'net-6.2-rc4' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10d0e102480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ebc110f9741920ed
dashboard link: https://syzkaller.appspot.com/bug?extid=005d2a9ecd9fbf525f6a
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b6279846a2e7/disk-d9fc1511.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8fb1b3c8ac10/vmlinux-d9fc1511.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c6f486ee1f67/bzImage-d9fc1511.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+005d2a9ecd9fbf525f6a@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/hfsplus/bnode.c:618!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 15519 Comm: syz-executor.3 Not tainted 6.2.0-rc3-syzkaller-00165-gd9fc1511728c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:hfsplus_bnode_put+0x637/0x640 fs/hfsplus/bnode.c:618
Code: 00 81 ff e9 af fd ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c de fd ff ff 48 89 df e8 63 ff 80 ff e9 d1 fd ff ff e8 d9 55 2b ff <0f> 0b e8 d2 55 2b ff 0f 0b 55 41 57 41 56 41 54 53 41 89 f7 49 89
RSP: 0018:ffffc9000644f0b0 EFLAGS: 00010283
RAX: ffffffff82608627 RBX: ffff888075b89880 RCX: 0000000000040000
RDX: ffffc90015209000 RSI: 0000000000002ec3 RDI: 0000000000002ec4
RBP: 0000000000000000 R08: ffffffff82608066 R09: ffffed100eb71311
R10: ffffed100eb71311 R11: 1ffff1100eb71310 R12: ffff888075b89800
R13: ffff88807c450000 R14: dffffc0000000000 R15: 1ffff1100eb71300
FS:  00007f0a28019700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fddfd293000 CR3: 0000000021031000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 hfsplus_bmap_alloc+0x580/0x610 fs/hfsplus/btree.c:414
 hfs_bnode_split+0xc3/0x10c0 fs/hfsplus/brec.c:245
 hfsplus_brec_insert+0x36c/0xd70 fs/hfsplus/brec.c:100
 hfsplus_create_cat+0x583/0xa20 fs/hfsplus/catalog.c:308
 hfsplus_mknod+0x165/0x290 fs/hfsplus/dir.c:494
 lookup_open fs/namei.c:3413 [inline]
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x12ac/0x2dd0 fs/namei.c:3711
 do_filp_open+0x264/0x4f0 fs/namei.c:3741
 do_sys_openat2+0x124/0x4e0 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_openat fs/open.c:1342 [inline]
 __se_sys_openat fs/open.c:1337 [inline]
 __x64_sys_openat+0x243/0x290 fs/open.c:1337
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0a2728c0c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0a28019168 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f0a273abf80 RCX: 00007f0a2728c0c9
RDX: 000000000000275a RSI: 0000000020000040 RDI: ffffffffffffff9c
RBP: 00007f0a272e7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe38bdd94f R14: 00007f0a28019300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:hfsplus_bnode_put+0x637/0x640 fs/hfsplus/bnode.c:618
Code: 00 81 ff e9 af fd ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c de fd ff ff 48 89 df e8 63 ff 80 ff e9 d1 fd ff ff e8 d9 55 2b ff <0f> 0b e8 d2 55 2b ff 0f 0b 55 41 57 41 56 41 54 53 41 89 f7 49 89
RSP: 0018:ffffc9000644f0b0 EFLAGS: 00010283
RAX: ffffffff82608627 RBX: ffff888075b89880 RCX: 0000000000040000
RDX: ffffc90015209000 RSI: 0000000000002ec3 RDI: 0000000000002ec4
RBP: 0000000000000000 R08: ffffffff82608066 R09: ffffed100eb71311
R10: ffffed100eb71311 R11: 1ffff1100eb71310 R12: ffff888075b89800
R13: ffff88807c450000 R14: dffffc0000000000 R15: 1ffff1100eb71300
FS:  00007f0a28019700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f15b1770000 CR3: 0000000021031000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
