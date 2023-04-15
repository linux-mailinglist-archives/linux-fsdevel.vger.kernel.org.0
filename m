Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADBCF6E3015
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Apr 2023 11:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjDOJbp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Apr 2023 05:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjDOJbo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Apr 2023 05:31:44 -0400
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9A53C13
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Apr 2023 02:31:43 -0700 (PDT)
Received: by mail-il1-f208.google.com with SMTP id d20-20020a056e020c1400b003261821bf26so5536828ile.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Apr 2023 02:31:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681551103; x=1684143103;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sQWY3p8eNhIUMjpqZ712oTMmutyZYotMgmBqh/S/Tic=;
        b=YT80IFluY+kDZuVqHqcbSByICFvtNc8nkMFowadN7TVOi11arlPaCp99J6drp44EHq
         iJPhCcTnWU0aYvj1CFeguQwVKe5RWQQO6qpasgbzFjnJ8MOWQX1JjYl+O1IZIktJ/FUO
         vmnCJmV1zOnPcKQYnuZUg7/vTcFzY5bIjoAVRQKR0Qm3NWUJf67T8S2tTS7n6nGhF6uP
         XXLXjYmLLTL7eKGfdoHbnNismxZJRs4uc7GjTQgDO0kJzkr8qX1Rrqz7yFW7gTpwtR/L
         zr/m5F7GxXrurzaIrxCmDJ1VRyxeqy1PgFZ/cFcpR0FtkMdA4HpO2bHmYhxW3fKfosrq
         qswQ==
X-Gm-Message-State: AAQBX9ee0m0CCz+3cjQYGvj/J+G2NB3q0QSXB99YsXvE78eR1e78l9Zb
        jFaec7cSPx9tpR61YDx4hQEJLtc+T/Uw+vYdITxUK9WT1rTSwsknDg==
X-Google-Smtp-Source: AKy350bDKViPVFB5V4Rguz0ij4tDbQlW7qW7YQRJ6WRetGv4+9qvK2JGZ0REdn56TwnUfzHuIqwbWniGlNMn9ClJ6s1q3o1ZV8Wh
MIME-Version: 1.0
X-Received: by 2002:a05:6638:42cc:b0:3ec:46d4:e15 with SMTP id
 bm12-20020a05663842cc00b003ec46d40e15mr6393826jab.3.1681551102867; Sat, 15
 Apr 2023 02:31:42 -0700 (PDT)
Date:   Sat, 15 Apr 2023 02:31:42 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002882fb05f95ca0c2@google.com>
Subject: [syzbot] [hfs?] WARNING in check_flush_dependency (2)
From:   syzbot <syzbot+f60c5689d74d066ddd1a@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

HEAD commit:    0d3eb744aed4 Merge tag 'urgent-rcu.2023.04.07a' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=132ae59bc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c21559e740385326
dashboard link: https://syzkaller.appspot.com/bug?extid=f60c5689d74d066ddd1a
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a02928003efa/disk-0d3eb744.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7839447005a4/vmlinux-0d3eb744.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d26ab3184148/bzImage-0d3eb744.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f60c5689d74d066ddd1a@syzkaller.appspotmail.com

------------[ cut here ]------------
workqueue: WQ_MEM_RECLAIM dio/loop3:dio_aio_complete_work is flushing !WQ_MEM_RECLAIM events_long:flush_mdb
WARNING: CPU: 1 PID: 5167 at kernel/workqueue.c:2729 check_flush_dependency+0x29b/0x3f0 kernel/workqueue.c:2729
Modules linked in:
CPU: 1 PID: 5167 Comm: kworker/1:4 Not tainted 6.3.0-rc6-syzkaller-00016-g0d3eb744aed4 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
Workqueue: dio/loop3 dio_aio_complete_work
RIP: 0010:check_flush_dependency+0x29b/0x3f0 kernel/workqueue.c:2729
Code: 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 3f 01 00 00 48 8b 53 18 49 8d b6 60 01 00 00 4d 89 e0 48 c7 c7 c0 67 4b 8a e8 75 e3 f8 ff <0f> 0b e9 e8 fd ff ff e8 19 5e 30 00 65 4c 8b 2c 25 80 b8 03 00 4c
RSP: 0018:ffffc9000478fa60 EFLAGS: 00010086
RAX: 0000000000000000 RBX: ffff88802a40f500 RCX: 0000000000000000
RDX: ffff8880213357c0 RSI: ffffffff814b6237 RDI: 0000000000000001
RBP: ffff888012471400 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff82502670
R13: 0000000000000000 R14: ffff88802b3cf400 R15: ffffc9000478fb00
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020710000 CR3: 000000003c040000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 start_flush_work kernel/workqueue.c:3133 [inline]
 __flush_work+0x281/0xb60 kernel/workqueue.c:3173
 hfs_file_fsync+0x108/0x1a0 fs/hfs/inode.c:683
 vfs_fsync_range+0x13e/0x230 fs/sync.c:188
 generic_write_sync include/linux/fs.h:2452 [inline]
 dio_complete+0x796/0xa80 fs/direct-io.c:309
 process_one_work+0x991/0x15c0 kernel/workqueue.c:2390
 worker_thread+0x669/0x1090 kernel/workqueue.c:2537
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
