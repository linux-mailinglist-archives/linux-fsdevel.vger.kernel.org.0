Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30CD227F520
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Oct 2020 00:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731596AbgI3W3W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Sep 2020 18:29:22 -0400
Received: from mail-il1-f205.google.com ([209.85.166.205]:50224 "EHLO
        mail-il1-f205.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbgI3W3W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Sep 2020 18:29:22 -0400
Received: by mail-il1-f205.google.com with SMTP id u20so2798790ilk.17
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2020 15:29:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=+0VlvcNRUBLPwYY+/l3iWps8TddUUFMalUbSMxo1nMc=;
        b=WwVf4CLxHFKmzQZJVTan8Y5NT75iLz1xKg0Va9ssPHB8edr+9Y88C6XKf4NpuIUjBh
         MNiQ268YBS9kSKDXaezxexg8GKKXJcchMaSIUaYdu6RpLPTXV4wHXhqYIL2+gm6CL/v8
         9SPzA5Hj+yqK1yy/v4huPZTKEIz6UAvC2QlK9iRaX3ENuXmfw6kcPBFS0TEfU+yv1fCg
         LaHQHeIoP3mtA9nOh9W+duOTz+31WaGb8biReyFVpeKVBoKrO6tvSFsGDlonhA+2WJ9J
         5mM4d3wLjozfL6tY9HmAVKSDPHa5OBI4dvvqH2Ijwa4GCZUao6smx55Al9MySjJAuXPq
         2IPg==
X-Gm-Message-State: AOAM530vR3JjFDSR2JH35C/x7XOAsbEVa9/7yQ9kMYW9n3zc6uZ6PdMj
        oiXiWAG6Hjj8tWMulGnk5sD3TuHcsW6fCarz+DZOvEWyyAPB
X-Google-Smtp-Source: ABdhPJxQ53hwefKNF6WE9W0GG8xHlmhPERFSu7t/v13Oo8rcSYfID9pDQh/morvR5iOb+/sczzfKsSw84sYfzhDoi8jBLmnKOSv5
MIME-Version: 1.0
X-Received: by 2002:a92:de4b:: with SMTP id e11mr89152ilr.101.1601504961330;
 Wed, 30 Sep 2020 15:29:21 -0700 (PDT)
Date:   Wed, 30 Sep 2020 15:29:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000053864e05b08f6e58@google.com>
Subject: WARNING in kthread_park
From:   syzbot <syzbot+e7eea402700c6db193be@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d1d2220c Add linux-next specific files for 20200924
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15b1918d900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=254e028a642027c
dashboard link: https://syzkaller.appspot.com/bug?extid=e7eea402700c6db193be
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e7eea402700c6db193be@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 28162 at kernel/kthread.c:547 kthread_park+0x17c/0x1b0 kernel/kthread.c:547
Modules linked in:
CPU: 1 PID: 28162 Comm: syz-executor.3 Not tainted 5.9.0-rc6-next-20200924-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:kthread_park+0x17c/0x1b0 kernel/kthread.c:547
Code: 2a 04 27 00 0f 0b e9 fb fe ff ff e8 1e 04 27 00 0f 0b e8 17 04 27 00 41 bc da ff ff ff 5b 44 89 e0 5d 41 5c c3 e8 04 04 27 00 <0f> 0b 41 bc f0 ff ff ff eb be e8 f5 03 27 00 0f 0b eb b2 e8 bc 74
RSP: 0018:ffffc90017ebfd50 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888092c0ca00 RCX: ffffffff814e2ccf
RDX: ffff88804f30a040 RSI: ffffffff814e2d6c RDI: 0000000000000007
RBP: ffff88804f46c440 R08: 0000000000000000 R09: ffff888092c0ca07
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000000 R14: ffff888096f7d000 R15: 0000000000000000
FS:  0000000002a7e940(0000) GS:ffff8880ae500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000001590004 CR3: 000000020a32f000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 io_sq_thread_park fs/io_uring.c:7145 [inline]
 io_sq_thread_park fs/io_uring.c:7139 [inline]
 io_uring_flush+0x10a6/0x1640 fs/io_uring.c:8596
 filp_close+0xb4/0x170 fs/open.c:1276
 __close_fd+0x2f/0x50 fs/file.c:671
 __do_sys_close fs/open.c:1295 [inline]
 __se_sys_close fs/open.c:1293 [inline]
 __x64_sys_close+0x69/0x100 fs/open.c:1293
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x417901
Code: 75 14 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 a4 1a 00 00 c3 48 83 ec 08 e8 0a fc ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c 24 48 89 c2 e8 53 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007fffe4c281e0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 0000000000417901
RDX: 0000000000000000 RSI: ffffffff8840e309 RDI: 0000000000000003
RBP: 0000000000000001 R08: ffffffff8134e496 R09: 0000000092f8bb6d
R10: 00007fffe4c282d0 R11: 0000000000000293 R12: 000000000118d9c0
R13: 000000000118d9c0 R14: ffffffffffffffff R15: 000000000118cf4c


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
