Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B240639458
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Nov 2022 09:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiKZIGy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Nov 2022 03:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiKZIGu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Nov 2022 03:06:50 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1877E2870D
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Nov 2022 00:06:48 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id a14-20020a921a0e000000b00302a8ffa8e5so4295752ila.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Nov 2022 00:06:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E1A4AISBldY6qXgzJxpm60uW0wD8JljyitpizBqwB7k=;
        b=NovCYgRUqAVJs+BtTzAn0Sgy+azU7+r6PCDS+oHIoesQQxjQ+jGyOQQL0TTRQ9i0zB
         O2HyS3x8nxSdPP5UHIjFrqA/s4o/jQWEhQLQhW8VyJIqb0A7664ip0ObuUKXW0O4L0ZY
         kLcC4cF9hXNbU2DxDcnUr+kzhZ0HB8ZIHLwC+CL3WM5UwRj/+o4BITiwKc0YHgs8v4C2
         6WWADEvnmciD+GsgEpTTGK9wPNvs9V00V1xxe8Q03YGQRd9GLSo2Zlh3mwOAyVQwPJB5
         yIBxkEf9RFhRxuY/kFZqrm1YLa1hmv1wa15D1Zgha5tmoQjvO0ui3Z6yDPm6DTJ3JBzL
         fE9w==
X-Gm-Message-State: ANoB5plOH091omCaxm4r+ctlDBcIYgjeWpsadDzBgwu8yxIH5WuaNTbD
        G0T9qtfn5w+xHfJTDB2CdnOJMFXSUYTwn+BfBTm45+I53dz2
X-Google-Smtp-Source: AA0mqf5KJxjONv/z3ydt8/FFm+3mwQXHwuCK9jNyACtdgRLwRXglts3GwFePpMrVXCSd0Y9FHj5kd5V/pTr4kcICbtY6Gb663DcE
MIME-Version: 1.0
X-Received: by 2002:a02:cc4d:0:b0:373:2fc2:96d7 with SMTP id
 i13-20020a02cc4d000000b003732fc296d7mr14233452jaq.177.1669450007352; Sat, 26
 Nov 2022 00:06:47 -0800 (PST)
Date:   Sat, 26 Nov 2022 00:06:47 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a89dcd05ee5b1e2c@google.com>
Subject: [syzbot] WARNING in hfsplus_cat_write_inode
From:   syzbot <syzbot+4913dca2ea6e4d43f3f1@syzkaller.appspotmail.com>
To:     damien.lemoal@opensource.wdc.com, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
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

HEAD commit:    08ad43d554ba Merge tag 'net-6.1-rc7' of git://git.kernel.o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1555a205880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d01b6e3197974dd
dashboard link: https://syzkaller.appspot.com/bug?extid=4913dca2ea6e4d43f3f1
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10708b9b880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10127353880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e40e255b7cf8/disk-08ad43d5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dfabe238c5ee/vmlinux-08ad43d5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2bcb24a7bbed/bzImage-08ad43d5.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/1bda20b6bc4d/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4913dca2ea6e4d43f3f1@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 33 at fs/hfsplus/inode.c:616 hfsplus_cat_write_inode+0xb13/0xfe0
Modules linked in:
CPU: 1 PID: 33 Comm: kworker/u4:2 Not tainted 6.1.0-rc6-syzkaller-00176-g08ad43d554ba #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Workqueue: writeback wb_workfn (flush-7:0)
RIP: 0010:hfsplus_cat_write_inode+0xb13/0xfe0 fs/hfsplus/inode.c:616
Code: 00 0f 85 df 04 00 00 44 89 f0 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 e8 f9 99 2f ff 0f 0b e9 d1 f7 ff ff e8 ed 99 2f ff <0f> 0b e9 7f fa ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 13 f6 ff
RSP: 0000:ffffc90000aa7120 EFLAGS: 00010293
RAX: ffffffff825afe83 RBX: 0000000000000058 RCX: ffff8880182f9d40
RDX: 0000000000000000 RSI: 0000000000000058 RDI: 00000000000000f8
RBP: ffffc90000aa74d0 R08: ffffffff825af8f8 R09: ffffed100e907461
R10: ffffed100e907461 R11: 1ffff1100e907460 R12: dffffc0000000000
R13: ffffc90000aa71e0 R14: ffffc90000aa7180 R15: ffff88807483a300
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffdc37c3b60 CR3: 000000002762c000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 write_inode fs/fs-writeback.c:1440 [inline]
 __writeback_single_inode+0x4d6/0x670 fs/fs-writeback.c:1652
 writeback_sb_inodes+0xb3b/0x18f0 fs/fs-writeback.c:1878
 wb_writeback+0x41f/0x7b0 fs/fs-writeback.c:2052
 wb_do_writeback fs/fs-writeback.c:2195 [inline]
 wb_workfn+0x3cb/0xef0 fs/fs-writeback.c:2235
 process_one_work+0x877/0xdb0 kernel/workqueue.c:2289
 worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
