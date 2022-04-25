Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240F950D75B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Apr 2022 05:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240170AbiDYDKf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Apr 2022 23:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbiDYDKc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Apr 2022 23:10:32 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E531A804
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Apr 2022 20:07:29 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id c25-20020a5d9399000000b00652e2b23358so10662294iol.6
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Apr 2022 20:07:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=5M9dPHoval3Wy6UB/Gd+urugmgoizrKVcq67CoExOE0=;
        b=3OBlpEexKhrtOl4eaiXHnsYPTi5MzrB66RIxeFJYONCluLQgZS7Jwns9zVci0dT3gW
         qxSoatKBMjdmuioxgzWFRSGU7XMV7+00c8BCNffCTvXkBfe9LPtz15Ehog0gYI7Za89f
         VbSwlz2wQRUFe3Vlo7ElAQLAF3FWBfP2GW8QQTb9DvIO7+oBbWLmVlZ9lWFoHB/OSA1z
         mGO3RUk3qevyDEF30iVYSqBkOsHnmrqduExtQnIxMXOYiN6BSapFr0blA1THnyVelYRx
         kSjjAb1bE9fzttF8fv+dcJL4s9PMKhY8SrUf7hBPmKyXJ1uwIn0hA0Os+rg9qWXblR27
         jvnw==
X-Gm-Message-State: AOAM532gWaDBbYH9F/7zyyfHLDMB0Y05aVVk/lberpsHzkLBCtBPl9qb
        tg6tLAEzSPvvRiwDiTIgQ8JQsmeoqgXEQjj44dzR9dq6V2rd
X-Google-Smtp-Source: ABdhPJw9GqJ9giy8XNcygVT8n+KE+/7AxbKKKhmlLzzHusOzGPc5RjtXFKH6MRetm1IlB6aaI/uWD+hNiJ2J+k6fGTS0iB/VNfaA
MIME-Version: 1.0
X-Received: by 2002:a02:878b:0:b0:326:8050:4706 with SMTP id
 t11-20020a02878b000000b0032680504706mr6902470jai.311.1650856048655; Sun, 24
 Apr 2022 20:07:28 -0700 (PDT)
Date:   Sun, 24 Apr 2022 20:07:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005b04fa05dd71e0e0@google.com>
Subject: [syzbot] KASAN: out-of-bounds Write in end_buffer_read_sync
From:   syzbot <syzbot+3f7f291a3d327486073c@syzkaller.appspotmail.com>
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

HEAD commit:    22da5264abf4 Merge tag '5.18-rc3-ksmbd-fixes' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1230fd64f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6bc13fa21dd76a9b
dashboard link: https://syzkaller.appspot.com/bug?extid=3f7f291a3d327486073c
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3f7f291a3d327486073c@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: out-of-bounds in instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
BUG: KASAN: out-of-bounds in atomic_dec include/linux/atomic/atomic-instrumented.h:257 [inline]
BUG: KASAN: out-of-bounds in put_bh include/linux/buffer_head.h:284 [inline]
BUG: KASAN: out-of-bounds in end_buffer_read_sync+0x24/0x30 fs/buffer.c:160
Write of size 4 at addr ffffc9000302f9d8 by task ksoftirqd/2/28

CPU: 2 PID: 28 Comm: ksoftirqd/2 Not tainted 5.18.0-rc3-syzkaller-00235-g22da5264abf4 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0xf/0x467 mm/kasan/report.c:313
 print_report mm/kasan/report.c:429 [inline]
 kasan_report.cold+0xf4/0x1c6 mm/kasan/report.c:491
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0x13d/0x180 mm/kasan/generic.c:189
 instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
 atomic_dec include/linux/atomic/atomic-instrumented.h:257 [inline]
 put_bh include/linux/buffer_head.h:284 [inline]
 end_buffer_read_sync+0x24/0x30 fs/buffer.c:160
 end_bio_bh_io_sync+0xda/0x130 fs/buffer.c:2999
 bio_endio+0x5fe/0x780 block/bio.c:1541
 req_bio_endio block/blk-mq.c:686 [inline]
 blk_update_request+0x401/0x1310 block/blk-mq.c:815
 blk_mq_end_request+0x4b/0x80 block/blk-mq.c:941
 lo_complete_rq+0x1c2/0x280 drivers/block/loop.c:369
 blk_complete_reqs+0xad/0xe0 block/blk-mq.c:1012
 __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
 run_ksoftirqd kernel/softirq.c:921 [inline]
 run_ksoftirqd+0x2d/0x60 kernel/softirq.c:913
 smpboot_thread_fn+0x645/0x9c0 kernel/smpboot.c:164
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298
 </TASK>

The buggy address belongs to the virtual mapping at
 [ffffc90003028000, ffffc90003031000) created by:
 kernel_clone+0xe7/0xab0 kernel/fork.c:2639

------------[ cut here ]------------
kernel BUG at mm/vmalloc.c:660!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 2 PID: 28 Comm: ksoftirqd/2 Not tainted 5.18.0-rc3-syzkaller-00235-g22da5264abf4 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
RIP: 0010:vmalloc_to_page+0x46e/0x4f0 mm/vmalloc.c:660
Code: c1 ff 4d 31 fc 4d 21 f4 49 c1 ec 0c 4c 01 e3 49 bc 00 00 00 00 00 ea ff ff 48 c1 e3 06 49 01 dc e9 35 ff ff ff e8 c2 d5 c1 ff <0f> 0b e8 bb d5 c1 ff 0f 0b 45 31 e4 e9 1f ff ff ff e8 ac d5 c1 ff
RSP: 0018:ffffc90000777be8 EFLAGS: 00010046
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000100
RDX: ffff888011aac0c0 RSI: ffffffff81b68f6e RDI: 0000000000000003
RBP: ffffffff8ba8e000 R08: 00001ffffffffffe R09: 0000000000000001
R10: ffffffff81b68b86 R11: 0000000000000000 R12: 0000370000000000
R13: 0000000000000000 R14: ffff888011aac0c0 R15: ffff888022c8f688
FS:  0000000000000000(0000) GS:ffff88802cc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffbb1d08922 CR3: 000000006e266000 CR4: 0000000000150ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 print_address_description.constprop.0.cold+0x2ce/0x467 mm/kasan/report.c:350
 print_report mm/kasan/report.c:429 [inline]
 kasan_report.cold+0xf4/0x1c6 mm/kasan/report.c:491
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0x13d/0x180 mm/kasan/generic.c:189
 instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
 atomic_dec include/linux/atomic/atomic-instrumented.h:257 [inline]
 put_bh include/linux/buffer_head.h:284 [inline]
 end_buffer_read_sync+0x24/0x30 fs/buffer.c:160
 end_bio_bh_io_sync+0xda/0x130 fs/buffer.c:2999
 bio_endio+0x5fe/0x780 block/bio.c:1541
 req_bio_endio block/blk-mq.c:686 [inline]
 blk_update_request+0x401/0x1310 block/blk-mq.c:815
 blk_mq_end_request+0x4b/0x80 block/blk-mq.c:941
 lo_complete_rq+0x1c2/0x280 drivers/block/loop.c:369
 blk_complete_reqs+0xad/0xe0 block/blk-mq.c:1012
 __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
 run_ksoftirqd kernel/softirq.c:921 [inline]
 run_ksoftirqd+0x2d/0x60 kernel/softirq.c:913
 smpboot_thread_fn+0x645/0x9c0 kernel/smpboot.c:164
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:vmalloc_to_page+0x46e/0x4f0 mm/vmalloc.c:660
Code: c1 ff 4d 31 fc 4d 21 f4 49 c1 ec 0c 4c 01 e3 49 bc 00 00 00 00 00 ea ff ff 48 c1 e3 06 49 01 dc e9 35 ff ff ff e8 c2 d5 c1 ff <0f> 0b e8 bb d5 c1 ff 0f 0b 45 31 e4 e9 1f ff ff ff e8 ac d5 c1 ff
RSP: 0018:ffffc90000777be8 EFLAGS: 00010046
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000100
RDX: ffff888011aac0c0 RSI: ffffffff81b68f6e RDI: 0000000000000003
RBP: ffffffff8ba8e000 R08: 00001ffffffffffe R09: 0000000000000001
R10: ffffffff81b68b86 R11: 0000000000000000 R12: 0000370000000000
R13: 0000000000000000 R14: ffff888011aac0c0 R15: ffff888022c8f688
FS:  0000000000000000(0000) GS:ffff88802cc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffbb1d08922 CR3: 000000006e266000 CR4: 0000000000150ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
