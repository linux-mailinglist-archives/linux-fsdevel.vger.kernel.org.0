Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F264240AC1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Aug 2020 17:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgHJPq0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Aug 2020 11:46:26 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:33089 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbgHJPqZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:46:25 -0400
Received: by mail-il1-f197.google.com with SMTP id m9so8182157ili.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2020 08:46:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=SHAexMyW7z201Yxw9hnQ8uPlGiip1/BeDLnLE7U9rJo=;
        b=Dol6Ec4sGl+oNvBKZdVayPWN0tXoN2CRaODpNEsmwWfuyf+XYUfhA9D9Bq4F9K2stf
         DiCk4sZUJ8k7tM6A/UPS/mNLs+cNbP8V1XFWErMeRSkVsx62aHgnY/cTmjogjFhnQRP9
         bR0L00o6lZglO6mGKtx9CsEV3kS/nhAaVd9m80e/vTYhRKXPxUGAupxsMNIZ2XKinSA3
         NkLtppMF8FM52E6W5UDKv6l6M3XU4iUdxI8EN953i4Op/DlxVzsuGjf1BLYZF8nC9Zvi
         D/gkJgEDHheLCsDAZlInDJ+6wj45F+1kXEm7MAm/bfao0RdsG0YmvBNJwx6xic/0aZMh
         ALRQ==
X-Gm-Message-State: AOAM531M16/Gj9I9G0/AKJpX9OrgAELOkT3iKYzQxMe0LvmHTOIsF+eJ
        DVCEpfoYBpBLuc/QSRfK9zllUl2vTxHOVKZbmF8x6N/F3TNI
X-Google-Smtp-Source: ABdhPJwp+HLP3iQxO3liiiRpmTkJSrG5YWUlMOGePiAkgtJDyFSg+uttF8UMfBG3ecCN/S84Pv15S0aZzzwuNWMJOAckDOjPiSjG
MIME-Version: 1.0
X-Received: by 2002:a92:d9d1:: with SMTP id n17mr17253665ilq.182.1597074385031;
 Mon, 10 Aug 2020 08:46:25 -0700 (PDT)
Date:   Mon, 10 Aug 2020 08:46:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000066583105ac87dbf4@google.com>
Subject: BUG: unable to handle kernel NULL pointer dereference in loop_rw_iter
From:   syzbot <syzbot+1abbd16e49910f6bbe45@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    9420f1ce Merge tag 'pinctrl-v5.9-1' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13662f62900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=72cf85e4237850c8
dashboard link: https://syzkaller.appspot.com/bug?extid=1abbd16e49910f6bbe45
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15929006900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15e196aa900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1abbd16e49910f6bbe45@syzkaller.appspotmail.com

BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor instruction fetch in kernel mode
#PF: error_code(0x0010) - not-present page
PGD a652e067 P4D a652e067 PUD a652f067 PMD 0 
Oops: 0010 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 7461 Comm: io_wqe_worker-0 Not tainted 5.8.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:0x0
Code: Bad RIP value.
RSP: 0018:ffffc9000804f910 EFLAGS: 00010246
RAX: 1ffffffff10b0b9b RBX: dffffc0000000000 RCX: ffff88808962e1c8
RDX: 000000000000003c RSI: 0000000020000740 RDI: ffff88809fb2dcc0
RBP: 0000000020000740 R08: ffffc9000804fa28 R09: ffff8880a7639c0f
R10: 0000000000000000 R11: 0000000000000000 R12: ffffc9000804fa28
R13: ffffffff88585cc0 R14: 000000000000003c R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 000000008e2a7000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 loop_rw_iter.part.0+0x26e/0x450 fs/io_uring.c:2850
 loop_rw_iter fs/io_uring.c:2829 [inline]
 io_write+0x6a2/0x7a0 fs/io_uring.c:3190
 io_issue_sqe+0x1b0/0x60d0 fs/io_uring.c:5530
 io_wq_submit_work+0x183/0x3d0 fs/io_uring.c:5775
 io_worker_handle_work+0xa45/0x13f0 fs/io-wq.c:527
 io_wqe_worker+0xbf0/0x10e0 fs/io-wq.c:569
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
Modules linked in:
CR2: 0000000000000000
---[ end trace 97e511c5a98da2fe ]---
RIP: 0010:0x0
Code: Bad RIP value.
RSP: 0018:ffffc9000804f910 EFLAGS: 00010246
RAX: 1ffffffff10b0b9b RBX: dffffc0000000000 RCX: ffff88808962e1c8
RDX: 000000000000003c RSI: 0000000020000740 RDI: ffff88809fb2dcc0
RBP: 0000000020000740 R08: ffffc9000804fa28 R09: ffff8880a7639c0f
R10: 0000000000000000 R11: 0000000000000000 R12: ffffc9000804fa28
R13: ffffffff88585cc0 R14: 000000000000003c R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f84c3b15028 CR3: 000000008e2a7000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
