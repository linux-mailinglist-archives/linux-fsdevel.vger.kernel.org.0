Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6BA76E3EF7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 07:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjDQFez (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 01:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjDQFew (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 01:34:52 -0400
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6664F35B7
        for <linux-fsdevel@vger.kernel.org>; Sun, 16 Apr 2023 22:34:45 -0700 (PDT)
Received: by mail-il1-f208.google.com with SMTP id j14-20020a056e02154e00b0032ad2b5392fso1507840ilu.9
        for <linux-fsdevel@vger.kernel.org>; Sun, 16 Apr 2023 22:34:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681709684; x=1684301684;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4mgl0iZLcTdWd+tfMeHZVb9M8iD5ML58BVHDGKAeGLo=;
        b=dYGcV23cRi2YdiWuca2pa+SiogtmWMjDYNQ/fgW3z5CC+Y8hRKowOl+FCZWTPsSkqZ
         Vx8dgYpF3NtqhbnbxkFRXfzc5XnlyoJFPg5SQBqsW89D0jYp6nWeJaoBFKLFzcS95622
         mhi1lx7EATiwNXhF6yIMDZ12Hb5GZpIfdD2MHx2w6mD8aOLsAjzOjcCn2dtZyMzPi125
         ProDlko4bFgckROGxUu48CDyQB1CFxo+bcjpu9jXlS07a0oeC+FCF7KyBgUiYwWOZiq1
         /5RW7ZKnVJOvLzFyCUEYfyp6/EFTI36KwR1bNL4z/XlE2uJm2EBFAXmzcv9I+nozCttS
         l0qA==
X-Gm-Message-State: AAQBX9fseFJWbNOyFnVGEt+gktmTDW/gy7J6Q1ERPb1iTBgYQ+HpU80k
        voCaZqWLpAzPgDeg8QcQ9f3hSJWMNeJIhnL/tKSrFgTr/tkrRPhD3w==
X-Google-Smtp-Source: AKy350Zb/xJjWaIBLmQjjBiYWDrZXrBGGgoCEjchA9t5OwcUkc99mCJUgSDW83l267KyejjaJ8qqWYwMz9PW6C4QGZSQZHNZ7dnp
MIME-Version: 1.0
X-Received: by 2002:a02:8481:0:b0:40f:a8e9:96ab with SMTP id
 f1-20020a028481000000b0040fa8e996abmr521317jai.5.1681709684551; Sun, 16 Apr
 2023 22:34:44 -0700 (PDT)
Date:   Sun, 16 Apr 2023 22:34:44 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005cf71b05f9818cc2@google.com>
Subject: [syzbot] [hfs?] KASAN: wild-memory-access Read in hfsplus_bnode_dump
From:   syzbot <syzbot+f687659f3c2acfa34201@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    0d3eb744aed4 Merge tag 'urgent-rcu.2023.04.07a' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1662e1c3c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=759d5e665e47a55
dashboard link: https://syzkaller.appspot.com/bug?extid=f687659f3c2acfa34201
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0b9db4c3a583/disk-0d3eb744.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/462736705e85/vmlinux-0d3eb744.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8932ee360b94/bzImage-0d3eb744.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f687659f3c2acfa34201@syzkaller.appspotmail.com

loop2: detected capacity change from 0 to 1024
hfsplus: request for non-existent node 64 in B*Tree
hfsplus: request for non-existent node 64 in B*Tree
==================================================================
BUG: KASAN: wild-memory-access in memcpy_from_page include/linux/highmem.h:391 [inline]
BUG: KASAN: wild-memory-access in hfsplus_bnode_read fs/hfsplus/bnode.c:32 [inline]
BUG: KASAN: wild-memory-access in hfsplus_bnode_read_u16 fs/hfsplus/bnode.c:45 [inline]
BUG: KASAN: wild-memory-access in hfsplus_bnode_dump+0x403/0xba0 fs/hfsplus/bnode.c:305
Read of size 2 at addr 000508800000103e by task syz-executor.2/9009

CPU: 0 PID: 9009 Comm: syz-executor.2 Not tainted 6.3.0-rc6-syzkaller-00016-g0d3eb744aed4 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_report+0xe6/0x540 mm/kasan/report.c:433
 kasan_report+0x176/0x1b0 mm/kasan/report.c:536
 kasan_check_range+0x283/0x290 mm/kasan/generic.c:187
 __asan_memcpy+0x29/0x70 mm/kasan/shadow.c:105
 memcpy_from_page include/linux/highmem.h:391 [inline]
 hfsplus_bnode_read fs/hfsplus/bnode.c:32 [inline]
 hfsplus_bnode_read_u16 fs/hfsplus/bnode.c:45 [inline]
 hfsplus_bnode_dump+0x403/0xba0 fs/hfsplus/bnode.c:305
 hfsplus_brec_remove+0x42c/0x4f0 fs/hfsplus/brec.c:229
 __hfsplus_delete_attr+0x275/0x450 fs/hfsplus/attributes.c:299
 hfsplus_delete_all_attrs+0x26b/0x3c0 fs/hfsplus/attributes.c:378
 hfsplus_delete_cat+0xb87/0xfc0 fs/hfsplus/catalog.c:425
 hfsplus_unlink+0x363/0x7f0 fs/hfsplus/dir.c:385
 vfs_unlink+0x35d/0x5f0 fs/namei.c:4250
 do_unlinkat+0x4a1/0x940 fs/namei.c:4316
 __do_sys_unlink fs/namei.c:4364 [inline]
 __se_sys_unlink fs/namei.c:4362 [inline]
 __x64_sys_unlink+0x49/0x50 fs/namei.c:4362
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f603de8c169
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f603eb66168 EFLAGS: 00000246 ORIG_RAX: 0000000000000057
RAX: ffffffffffffffda RBX: 00007f603dfabf80 RCX: 00007f603de8c169
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000000
RBP: 00007f603dee7ca1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff75f7975f R14: 00007f603eb66300 R15: 0000000000022000
 </TASK>
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
