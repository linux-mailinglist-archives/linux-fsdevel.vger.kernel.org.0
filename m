Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4B630AB5B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Feb 2021 16:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbhBAPbQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Feb 2021 10:31:16 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:49379 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbhBAPas (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Feb 2021 10:30:48 -0500
Received: by mail-il1-f198.google.com with SMTP id q3so14018338ilv.16
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Feb 2021 07:30:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=MA6Z5qApv5SIuE3llf4F8q/viDLzlg0JU+HdpHHeyso=;
        b=uA3qgcJCA0v33q5jOigZA5b5NlLFPHF3Xe60MRYP9UzMkI+4N0CfXWVcfpW4Ecu+4c
         Aj+vUlWxwkK3oiSKECRNQUwWEWIK3rvMXHI6hvsVct4IC5FUj8kNSDxni+k5EE5KzSG8
         NLnOGkqeLSb9yAhrZIvYNe4PO5CCuvFlp9j6xF32WmhKlx84vAoTLhUo21+L4gfmUasB
         wc7pdZrPZ96y9g61fvKk6wv1IOAs2mVnI1ory5ywpA2kbQdLEfnCFvpuDCDwfFX0xh35
         /XufKMkr7BoRQ2a4eGRmuQ3GQfjXM8JjcJbTdYn83K/41jLq0BQMyBIwak9Oq25BJpjY
         rO2A==
X-Gm-Message-State: AOAM533EcU6WoykA2oV3GZJH6y0IolCI9flU5TFVbZ7pm9jGE5FU/zbp
        96va/LPUOZugGbh64ZT7lwhqt5jof7ZPiga+jKpUVlWYc6OG
X-Google-Smtp-Source: ABdhPJxCf+7yJqjthz7S5x5o6J84v259czgNQNJjfsHZTMyGF8zbDMy+jFBCR4O0Suh43taSoStbM6sCfnBG20uy8NpBR0Nno281
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa5:: with SMTP id l5mr12605106ilv.278.1612193406830;
 Mon, 01 Feb 2021 07:30:06 -0800 (PST)
Date:   Mon, 01 Feb 2021 07:30:06 -0800
In-Reply-To: <39ebb181-6760-cdfd-88f8-5578ad4d7c85@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000052e4f305ba4807ca@google.com>
Subject: Re: WARNING in io_disable_sqo_submit
From:   syzbot <syzbot+2f5d1785dc624932da78@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, hdanton@sina.com,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in io_uring_cancel_task_requests

------------[ cut here ]------------
WARNING: CPU: 1 PID: 10843 at fs/io_uring.c:9039 io_uring_cancel_task_requests+0xe55/0x10c0 fs/io_uring.c:9039
Modules linked in:
CPU: 1 PID: 10843 Comm: syz-executor.3 Not tainted 5.11.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:io_uring_cancel_task_requests+0xe55/0x10c0 fs/io_uring.c:9039
Code: 00 00 e9 1c fe ff ff 48 8b 7c 24 18 e8 14 21 db ff e9 f2 fc ff ff 48 8b 7c 24 18 e8 05 21 db ff e9 64 f2 ff ff e8 9b a0 98 ff <0f> 0b e9 ed f2 ff ff e8 ff 20 db ff e9 c8 f5 ff ff 4c 89 ef e8 72
RSP: 0018:ffffc9000cc37950 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888027fcc000 RCX: 0000000000000000
RDX: ffff888045a1a040 RSI: ffffffff81da2255 RDI: ffff888027fcc0d0
RBP: ffff888027fcc0e8 R08: 0000000000000000 R09: ffff888045a1a047
R10: ffffffff81da14cf R11: 0000000000000000 R12: ffff888027fcc000
R13: ffff888045a1a040 R14: ffff88802e748000 R15: ffff88803ca86018
FS:  0000000000000000(0000) GS:ffff8880b9e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f09d5e60d40 CR3: 0000000028319000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 io_uring_flush+0x47b/0x6e0 fs/io_uring.c:9224
 filp_close+0xb4/0x170 fs/open.c:1286
 close_files fs/file.c:403 [inline]
 put_files_struct fs/file.c:418 [inline]
 put_files_struct+0x1cc/0x350 fs/file.c:415
 exit_files+0x7e/0xa0 fs/file.c:435
 do_exit+0xc22/0x2ae0 kernel/exit.c:820
 do_group_exit+0x125/0x310 kernel/exit.c:922
 get_signal+0x427/0x20f0 kernel/signal.c:2773
 arch_do_signal_or_restart+0x2a8/0x1eb0 arch/x86/kernel/signal.c:811
 handle_signal_work kernel/entry/common.c:147 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x148/0x250 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:302
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x465b09
Code: Unable to access opcode bytes at RIP 0x465adf.
RSP: 002b:00007f21a56f2108 EFLAGS: 00000202 ORIG_RAX: 00000000000001a9
RAX: 0000000000000004 RBX: 000000000056c0b0 RCX: 0000000000465b09
RDX: 00000000206d4000 RSI: 00000000200002c0 RDI: 0000000000000187
RBP: 00000000200002c0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
R13: 00000000206d4000 R14: 0000000000000000 R15: 0000000020ee7000


Tested on:

commit:         1d538571 io_uring: check kthread parked flag before sqthre..
git tree:       git://git.kernel.dk/linux-block for-5.12/io_uring
console output: https://syzkaller.appspot.com/x/log.txt?x=14532690d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe3e1032f57d6d25
dashboard link: https://syzkaller.appspot.com/bug?extid=2f5d1785dc624932da78
compiler:       

