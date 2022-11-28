Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3C263A59C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Nov 2022 11:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiK1KDu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Nov 2022 05:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiK1KDq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Nov 2022 05:03:46 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCAB52AE1
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Nov 2022 02:03:39 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id x10-20020a056e021bca00b00302b6c0a683so8558913ilv.23
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Nov 2022 02:03:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t3Z7tD0qeX6aZfKu8J+Pu+V9SU8w3xwQLICQ/IZYsLw=;
        b=WdPygN2ctQVWZbpSBsZN+pBFe61AIqoRH1TMO7W9kEpXF1MNEw9hSZDTk6TkFdxANZ
         ab3RzUYpjFSNLyOLYF0b3G5o01T1N9Nfky7rSojOMfOwx18TD5X3WVwL1qujqcDxzQw8
         17FajZBmJ16Zuh9m3OgpfrchzVTILxljUgYcwBY3oI929BStVeAMWONRJiE4j1w0/es4
         1VI3KFzXaUupytF5e19BzMlEnvssGn5O2BFQqbzm4EGXkIuoDhTaw/HphRInEb0XdC/q
         RIytLUVyGm35RWquNeM+Eu49jiUtGWcVHjvTaPJo9G9b5Fo49K48P3AoYHxs155cjyIe
         SO/g==
X-Gm-Message-State: ANoB5pmrzHljxYuCx/1wAGAaIxOedJJAENcXMVyDtZq/139FtvTfe1c1
        vT2RwW0pS7OJ6XbcIe/9wszfYQFYMspsH4pQOHrpb4zeiXv1
X-Google-Smtp-Source: AA0mqf6JuCYtFHLLS4RFlakMkxww1ZYJggnUkqrmDuT1eY/PB6+Gytg4KPQa6MO1p/QWC0kDA+quCQWo4F29eGZlWsSdj4LWFmwy
MIME-Version: 1.0
X-Received: by 2002:a5d:80ce:0:b0:6de:c30c:4d49 with SMTP id
 h14-20020a5d80ce000000b006dec30c4d49mr14681560ior.83.1669629819147; Mon, 28
 Nov 2022 02:03:39 -0800 (PST)
Date:   Mon, 28 Nov 2022 02:03:39 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000046def705ee84fc7a@google.com>
Subject: [syzbot] WARNING in hfsplus_ext_write_extent
From:   syzbot <syzbot+41264293e62d9074e4a8@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
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

HEAD commit:    faf68e3523c2 Merge tag 'kbuild-fixes-v6.1-4' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16eb5555880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d01b6e3197974dd
dashboard link: https://syzkaller.appspot.com/bug?extid=41264293e62d9074e4a8
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3bfa6577f378/disk-faf68e35.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7bf0af58cde3/vmlinux-faf68e35.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3e15d7d640b0/bzImage-faf68e35.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+41264293e62d9074e4a8@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(lock->magic != lock)
WARNING: CPU: 0 PID: 56 at kernel/locking/mutex.c:582 __mutex_lock_common+0x1bb0/0x26e0 kernel/locking/mutex.c:582
Modules linked in:
CPU: 0 PID: 56 Comm: kworker/u4:4 Not tainted 6.1.0-rc6-syzkaller-00315-gfaf68e3523c2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Workqueue: writeback wb_workfn
 (flush-7:3)

RIP: 0010:__mutex_lock_common+0x1bb0/0x26e0 kernel/locking/mutex.c:582
Code: 84 c0 0f 85 bd 08 00 00 83 3d 63 80 db 03 00 0f 85 6f e5 ff ff 48 c7 c7 a0 98 ed 8a 48 c7 c6 20 99 ed 8a 31 c0 e8 20 91 b7 f6 <0f> 0b e9 53 e5 ff ff e8 84 e5 65 f6 e9 5a fa ff ff 0f 0b e9 53 ef
RSP: 0018:ffffc900015771e0 EFLAGS: 00010246

RAX: 3dec4f730bdc4f00 RBX: ffff88806fda0190 RCX: ffff8880196b8000
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc90001577360 R08: ffffffff816e55cd R09: ffffed1017304f1c
R10: ffffed1017304f1c R11: 1ffff11017304f1b R12: dffffc0000000000
R13: 1ffff920002aee50 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2ddf1a1000 CR3: 000000004730f000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
 hfsplus_ext_write_extent+0x87/0x1e0 fs/hfsplus/extents.c:149
 hfsplus_write_inode+0x1e/0x5c0 fs/hfsplus/super.c:154
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
