Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D61F22F8020
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 16:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbhAOP55 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 10:57:57 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:46920 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbhAOP55 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 10:57:57 -0500
Received: by mail-io1-f72.google.com with SMTP id a2so15507202iod.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Jan 2021 07:57:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=qXTsRqj7cYBPnxmeCt1odzuPUDY733T/RjyDjuaCrrw=;
        b=IGg/t/Bw5hXsNMUAvwpKkmOV6ekxklT2t7GXBGh4Pe4FCh9rumqmby3jeB0oyCjTsB
         HcKIhzhwGXxKCBQhL3sahpFjtgKyOjByof8+19OGNcJh0DKLUV+fma/pfvQYryPFT1Ah
         lYc13qUFzBbE9W5ppCYQ4wvc/RICwMXTRAO6FbQIZS7Fopiwjh0NAhmdthCyOnXsHwyX
         o2o1MMVItJ5HOwuY6ZVniQG9bPN+8YmLRu59E+v0UqONsw4XzF71e5BMmKhQWYufaEIZ
         i2eYomteB2hyJDJ2o7Q+xEgMzJwJsieIwioVf2A6rzQVy24Z8v+pre9y0twh2JTo+r5M
         stOQ==
X-Gm-Message-State: AOAM530XUEcUH4t2YhwnHWl4VYAO7IncDVmv5KUuwqVNnwI5kCDminVK
        O5DGACgq0HFpJvRlYuuOIzp0tdy2uywf9YzFCIGacJHYG/c5
X-Google-Smtp-Source: ABdhPJyiD+fNvl8B4MqhdsVY5CPSjGxhADrupCbq/JwTVNG534yL9FLVKHRq3zE42Lw65OP5ZQc2zHtsdBYRUsWLILoZC8q+BzQ8
MIME-Version: 1.0
X-Received: by 2002:a02:2544:: with SMTP id g65mr1543741jag.91.1610726236762;
 Fri, 15 Jan 2021 07:57:16 -0800 (PST)
Date:   Fri, 15 Jan 2021 07:57:16 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002c365205b8f26d09@google.com>
Subject: WARNING in io_uring_flush
From:   syzbot <syzbot+a32b546d58dde07875a1@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    14662050 Merge tag 'linux-kselftest-fixes-5.11-rc4' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11a09ed0d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c066f800cf2824be
dashboard link: https://syzkaller.appspot.com/bug?extid=a32b546d58dde07875a1
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a32b546d58dde07875a1@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 11100 at fs/io_uring.c:9096 io_uring_flush+0x326/0x3a0 fs/io_uring.c:9096
Modules linked in:
CPU: 1 PID: 11100 Comm: syz-executor.3 Not tainted 5.11.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:io_uring_flush+0x326/0x3a0 fs/io_uring.c:9096
Code: e9 58 fe ff ff e8 6a 21 9b ff 49 c7 84 24 a0 00 00 00 00 00 00 00 e9 aa fe ff ff e8 44 9c dd ff e9 91 fd ff ff e8 4a 21 9b ff <0f> 0b e9 51 ff ff ff e8 3e 9c dd ff e9 06 fd ff ff 4c 89 f7 e8 31
RSP: 0018:ffffc90000fd7aa0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff8880758de140 RSI: ffffffff81d7aac6 RDI: 0000000000000003
RBP: ffff8880264d8500 R08: 0000000000000000 R09: 0000000028eda801
R10: ffffffff81d7aa15 R11: 0000000000000000 R12: ffff888035f73000
R13: ffff888028eda801 R14: ffff888035f73040 R15: ffff888035f730d0
FS:  0000000000000000(0000) GS:ffff8880b9f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f16cd441710 CR3: 000000006924f000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 filp_close+0xb4/0x170 fs/open.c:1280
 close_files fs/file.c:401 [inline]
 put_files_struct fs/file.c:416 [inline]
 put_files_struct+0x1cc/0x350 fs/file.c:413
 exit_files+0x7e/0xa0 fs/file.c:433
 do_exit+0xc22/0x2ae0 kernel/exit.c:820
 do_group_exit+0x125/0x310 kernel/exit.c:922
 get_signal+0x3e9/0x20a0 kernel/signal.c:2770
 arch_do_signal_or_restart+0x2a8/0x1eb0 arch/x86/kernel/signal.c:811
 handle_signal_work kernel/entry/common.c:147 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x148/0x250 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:302
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45e219
Code: Unable to access opcode bytes at RIP 0x45e1ef.
RSP: 002b:00007f49d69f3c68 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffe0 RBX: 0000000000000006 RCX: 000000000045e219
RDX: ffffffffffffffef RSI: 0000000020d7cfcb RDI: 0000000000000007
RBP: 000000000119bfd8 R08: 0000000000000000 R09: 00000000ffffffd8
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000119bf8c
R13: 00007fff13b97d2f R14: 00007f49d69f49c0 R15: 000000000119bf8c


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
