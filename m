Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35145EC1C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 13:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbiI0LqB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 07:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbiI0Lp7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:45:59 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BCAB6D1F
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Sep 2022 04:45:57 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id e9-20020a6b7309000000b006a27af93e45so5623635ioh.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Sep 2022 04:45:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=Y2eyFs2gf59OAWxQZbFbHTprkTJOtZrJl7Ob4nZ0PJ8=;
        b=byC+si3PG7P6+nfOsEbF/BWMvH+6XmEr9bXshM4Ej/faQDOjz5I7RliBtfyX3tlPw9
         zSp32FJAyVoKaVcoG5QCVGcMMKPekadzife8t6YDwwcT2OLfxoyOev9zOnUr7sjIo6qf
         156snKjjHax7d5SbZ/rQxsMZRcgLtxu3XnY7LtNFcMzrV0IpGsSJHnS7tEHM6HT8N2jN
         Pm1Jg0gdIryNXApcdGqR23Dx8AJFk/kndUqobDRYHIn/t7x4fJPtQ3WCCD0ZHcunnjeA
         l/rzcjlr3IX4PfBlylfT/H70ZF/d40RDisNWM9Z12VSv0f4ABvhMNuzs6Y4UBhHS0Z5E
         hoVA==
X-Gm-Message-State: ACrzQf3fKNz7y6fRwEFFGQbUJBERAoY3jLtLxIUpAS/dQr62MAEtkReV
        rcJSKdGTOcD1N2hB1w/gbp7TqFXWfd+IgRHdHS30egxZpiVk
X-Google-Smtp-Source: AMsMyM79r4WB+EuZiuqGtiyp5m2far53bxUFnPfjt/+PkWFbQhB/zFP5g/ea3tZDsRq/7jEqr2kBKBPQIdSOqakEX68NQpmxAIMy
MIME-Version: 1.0
X-Received: by 2002:a92:cdae:0:b0:2f5:8aea:654d with SMTP id
 g14-20020a92cdae000000b002f58aea654dmr12637038ild.135.1664279156726; Tue, 27
 Sep 2022 04:45:56 -0700 (PDT)
Date:   Tue, 27 Sep 2022 04:45:56 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f1a26f05e9a72f57@google.com>
Subject: [syzbot] WARNING in brelse
From:   syzbot <syzbot+2a0fbd1cb355de983130@syzkaller.appspotmail.com>
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

HEAD commit:    f76349cf4145 Linux 6.0-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=135e956c880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba0d23aa7e1ffaf5
dashboard link: https://syzkaller.appspot.com/bug?extid=2a0fbd1cb355de983130
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1702ee9c880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15ee7d40880000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2a0fbd1cb355de983130@syzkaller.appspotmail.com

------------[ cut here ]------------
VFS: brelse: Trying to free free buffer
WARNING: CPU: 1 PID: 3609 at fs/buffer.c:1145 __brelse fs/buffer.c:1145 [inline]
WARNING: CPU: 1 PID: 3609 at fs/buffer.c:1145 brelse+0x78/0xa0 include/linux/buffer_head.h:327
Modules linked in:
CPU: 1 PID: 3609 Comm: udevd Not tainted 6.0.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
RIP: 0010:__brelse fs/buffer.c:1145 [inline]
RIP: 0010:brelse+0x78/0xa0 include/linux/buffer_head.h:327
Code: df be 04 00 00 00 e8 b7 18 e1 ff f0 ff 0b eb 1c e8 8d 2a 8e ff eb 15 e8 86 2a 8e ff 48 c7 c7 a0 99 9d 8a 31 c0 e8 58 b7 56 ff <0f> 0b 5b 5d c3 89 d9 80 e1 07 80 c1 03 38 c1 7c af 48 89 df e8 bf
RSP: 0018:ffffc90003a5fac8 EFLAGS: 00010046
RAX: 78e8d475b9f8e400 RBX: ffff888073d6bee0 RCX: ffff88801c409d80
RDX: 0000000000000000 RSI: 0000000080000002 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff816bd40d R09: ffffed1017364f14
R10: ffffed1017364f14 R11: 1ffff11017364f13 R12: ffff8880b9b3acc0
R13: 0000000000000002 R14: ffff8880b9b35cf8 R15: dffffc0000000000
FS:  00007f6829c96840(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f23cc13e0a8 CR3: 000000001e07f000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __invalidate_bh_lrus+0x37/0x3c0 fs/buffer.c:1391
 invalidate_bh_lru+0x66/0xb0 fs/buffer.c:1404
 smp_call_function_many_cond+0xe88/0x16a0 kernel/smp.c:979
 on_each_cpu_cond_mask+0x3b/0x80 kernel/smp.c:1154
 kill_bdev block/bdev.c:74 [inline]
 blkdev_flush_mapping+0x149/0x2c0 block/bdev.c:661
 blkdev_put_whole block/bdev.c:692 [inline]
 blkdev_put+0x4a5/0x730 block/bdev.c:952
 blkdev_close+0x55/0x80 block/fops.c:499
 __fput+0x3b9/0x820 fs/file_table.c:320
 task_work_run+0x146/0x1c0 kernel/task_work.c:177
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop+0x124/0x150 kernel/entry/common.c:169
 exit_to_user_mode_prepare+0xb2/0x140 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x26/0x60 kernel/entry/common.c:294
 do_syscall_64+0x49/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f6829925fc3
Code: 48 ff ff ff b8 ff ff ff ff e9 3e ff ff ff 66 0f 1f 84 00 00 00 00 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c 24 0c e8
RSP: 002b:00007ffd3b4cbbd8 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 00007f6829c966a8 RCX: 00007f6829925fc3
RDX: 000000000000001c RSI: 00007ffd3b4cb3d8 RDI: 0000000000000008
RBP: 000055da4dfde0b0 R08: 0000000000000007 R09: 000055da4dfefc00
R10: 00007f68299b4fc0 R11: 0000000000000246 R12: 0000000000000002
R13: 000055da4dfd8740 R14: 0000000000000008 R15: 000055da4dfb5910
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
