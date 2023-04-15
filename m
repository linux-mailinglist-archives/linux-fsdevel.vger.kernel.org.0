Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5BD6E3488
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Apr 2023 01:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjDOX6t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Apr 2023 19:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjDOX6s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Apr 2023 19:58:48 -0400
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D47211D
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Apr 2023 16:58:47 -0700 (PDT)
Received: by mail-io1-f77.google.com with SMTP id e19-20020a5d85d3000000b00760cc8eb5b7so1249536ios.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Apr 2023 16:58:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681603126; x=1684195126;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c153sb/QMnPW91qspM9YxOE68EwMG8qT4V3TFYwA0FE=;
        b=ErYJ8fvkkhM0OemwGdstS89ysyfjsSW3hFl/3wXlR/pjpMSA50a4ZmjO0v41Vt68MC
         B/vc0S3rLMgPiBo8fHC7Qzo02cuu2iOAFV3ULbMDyAiF4hBxiHwTt6y7Fvcdd1oHyG+o
         h32qlnX5ecnclqAdMZB2D37UMaax23IXyBQKeG/MPvx5V9ocpuKftm9WacIC7VoY5G+V
         ublMq1QG0djS3OiPNkfi+cAmUsY4R3aN8GMoqh53W5p7R6hLCA5Zjr/UR04op975N9gM
         HI7DlQmDugkGDmBNncU9thwp3ccDqB5sVF6zyUiG7l5UAgSuGAs/H6gs16fzQ16E9adv
         OsDw==
X-Gm-Message-State: AAQBX9cQxhHfF/OmbAZaPXZrlj3Ynv0p13LCZSCBTeGaNmLQhzf+Q3mn
        6UGRlTHLKZkJAigEfUpqSANOHezKgSqWB/mCO9kqcoS/5atV
X-Google-Smtp-Source: AKy350ahZwPwX5Ro9o+Dzdb8/iY5JsLHzOCf6Awr2TfcgEU47VSpY39a33OsXf6yV7ulszBoXDIIgFwccYx6mnzavael2uXeirXQ
MIME-Version: 1.0
X-Received: by 2002:a02:6286:0:b0:40f:78ee:d54f with SMTP id
 d128-20020a026286000000b0040f78eed54fmr2679040jac.1.1681603126484; Sat, 15
 Apr 2023 16:58:46 -0700 (PDT)
Date:   Sat, 15 Apr 2023 16:58:46 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000001e57305f968bd16@google.com>
Subject: [syzbot] [udf?] WARNING in udf_free_blocks
From:   syzbot <syzbot+80d8e23d89e3b1222382@syzkaller.appspotmail.com>
To:     jack@suse.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e62252bc55b6 Merge tag 'pci-v6.3-fixes-2' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=138a91cfc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=759d5e665e47a55
dashboard link: https://syzkaller.appspot.com/bug?extid=80d8e23d89e3b1222382
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c93bfdacd206/disk-e62252bc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ef07a6bc5904/vmlinux-e62252bc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3da9fbe1f1c4/bzImage-e62252bc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+80d8e23d89e3b1222382@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 8399 at fs/udf/udfdecl.h:123 udf_add_free_space fs/udf/balloc.c:125 [inline]
WARNING: CPU: 1 PID: 8399 at fs/udf/udfdecl.h:123 udf_table_free_blocks fs/udf/balloc.c:407 [inline]
WARNING: CPU: 1 PID: 8399 at fs/udf/udfdecl.h:123 udf_free_blocks+0x1d56/0x23c0 fs/udf/balloc.c:685
Modules linked in:
CPU: 1 PID: 8399 Comm: syz-executor.0 Not tainted 6.3.0-rc6-syzkaller-00034-ge62252bc55b6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
RIP: 0010:udf_updated_lvid fs/udf/udfdecl.h:121 [inline]
RIP: 0010:udf_add_free_space fs/udf/balloc.c:125 [inline]
RIP: 0010:udf_table_free_blocks fs/udf/balloc.c:407 [inline]
RIP: 0010:udf_free_blocks+0x1d56/0x23c0 fs/udf/balloc.c:685
Code: 00 00 e8 2d df e5 fe 48 8b 9c 24 70 01 00 00 48 85 db 74 07 e8 6b 1e 90 fe eb b7 e8 64 1e 90 fe e9 4a e7 ff ff e8 5a 1e 90 fe <0f> 0b e9 47 ef ff ff 89 d9 80 e1 07 fe c1 38 c1 0f 8c 74 e3 ff ff
RSP: 0018:ffffc90012bf68e0 EFLAGS: 00010287
RAX: ffffffff82fa4a86 RBX: 0000000063746800 RCX: 0000000000040000
RDX: ffffc90004262000 RSI: 0000000000001527 RDI: 0000000000001528
RBP: ffffc90012bf6af0 R08: ffffffff82fa39c7 R09: fffffbfff1ca68fe
R10: 0000000000000000 R11: dffffc0000000001 R12: ffff88802b8c0cc0
R13: dffffc0000000000 R14: ffff88803acaa01c R15: ffff88807609a000
FS:  00007f37337fe700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f372b4dd718 CR3: 000000002ae2c000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 udf_discard_prealloc+0x560/0x870 fs/udf/truncate.c:151
 udf_map_block+0x3ce/0x4ff0 fs/udf/inode.c:448
 __udf_get_block+0x126/0x410 fs/udf/inode.c:464
 __block_write_begin_int+0x548/0x1a50 fs/buffer.c:2034
 __block_write_begin fs/buffer.c:2084 [inline]
 block_write_begin+0x9c/0x1f0 fs/buffer.c:2145
 udf_write_begin+0x10a/0x190 fs/udf/inode.c:265
 generic_perform_write+0x300/0x5e0 mm/filemap.c:3926
 __generic_file_write_iter+0x17a/0x400 mm/filemap.c:4054
 udf_file_write_iter+0x2fc/0x660 fs/udf/file.c:115
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
RIP: 0033:0x7f3734c8c169
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f37337fe168 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f3734dabf80 RCX: 00007f3734c8c169
RDX: 0000000000000000 RSI: 000000000000000a RDI: 0000000000000005
RBP: 00007f3734ce7ca1 R08: 0000000000000000 R09: 0000000000000000
R10: 000080001d00c0d0 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffdc4fc832f R14: 00007f37337fe300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
