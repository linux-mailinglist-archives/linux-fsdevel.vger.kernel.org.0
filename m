Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0FC297FD2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Oct 2020 02:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1766626AbgJYBhd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Oct 2020 21:37:33 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:47505 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1766623AbgJYBhd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Oct 2020 21:37:33 -0400
Received: by mail-io1-f71.google.com with SMTP id d19so3547910iod.14
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Oct 2020 18:37:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=f7Hsyz4XtmVh+a7GNuOGhl5IPZeTTe87Hi0sltQL6Wk=;
        b=PPcsJe6vlXsN6lC2JXW85+KejcBkBQcme6WfEst5ncZrPe7k+v6nt1SUpq1PhFOLxW
         E0HnEEN0d3If/HUPh4ewLTQhhZzs0vGqil0EhRo7IZWSkbnPIWR2dRNHE8grfB4H2Du2
         n0U0FnECu2VBJ4ERsZP02iB6siZoGYkks0y0itRZsqvOgRpPwxoNEiF63731tRk1kJIC
         h0rmdQuzIkZL96rncJeF8l0YDVpVEqVfmz9UgsGFApSg9Y1NUv4EX9J69RqbHgwFMPvh
         9BVlvOvUFyGzNNQUYI2x00ZciwhBADrkho1w46R+bA1hs9FdahjfSXEv7CeEakAAKobV
         h20Q==
X-Gm-Message-State: AOAM530WLgQQsqmAtxT8E3iWANMbYvoDAB5EMDZ2uMSQJsMOR66apscm
        O2PurmBBrt9GJokSAOL+ODsRr/5tPRwCEzyI0A2I6DjEM3F0
X-Google-Smtp-Source: ABdhPJyVqg3CpdLKaBi8gq4rMXQsBc6w938eGBu6UJQVXU17DGoTxdyPCZy7R5qxV0ZH/L967mOIrRscgffuQhxSPmf7snKR2+3l
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2436:: with SMTP id g22mr6197592iob.79.1603589844811;
 Sat, 24 Oct 2020 18:37:24 -0700 (PDT)
Date:   Sat, 24 Oct 2020 18:37:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000010c66805b274dbd7@google.com>
Subject: WARNING in try_to_wake_up
From:   syzbot <syzbot+dd74984384afdb86e904@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d7691390 Merge tag 'block-5.10-2020-10-24' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=161d04b0500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=65e86ae741289c65
dashboard link: https://syzkaller.appspot.com/bug?extid=dd74984384afdb86e904
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dd74984384afdb86e904@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 2 PID: 19299 at include/linux/cpumask.h:137 ttwu_stat include/linux/rcupdate.h:779 [inline]
WARNING: CPU: 2 PID: 19299 at include/linux/cpumask.h:137 try_to_wake_up+0xd5e/0x1300 kernel/sched/core.c:2979
Modules linked in:
CPU: 2 PID: 19299 Comm: io_wq_manager Not tainted 5.9.0-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:cpu_max_bits_warn include/linux/cpumask.h:137 [inline]
RIP: 0010:cpumask_check include/linux/cpumask.h:144 [inline]
RIP: 0010:cpumask_check include/linux/cpumask.h:142 [inline]
RIP: 0010:cpumask_test_cpu include/linux/cpumask.h:367 [inline]
RIP: 0010:is_cpu_allowed kernel/sched/core.c:1705 [inline]
RIP: 0010:select_task_rq kernel/sched/core.c:2370 [inline]
RIP: 0010:try_to_wake_up+0xd5e/0x1300 kernel/sched/core.c:2964
Code: 70 02 00 00 65 ff 0d d1 97 b5 7e 4c 8d 75 40 0f 85 da f8 ff ff e8 61 ed b3 ff e9 d0 f8 ff ff 41 bd 01 00 00 00 e9 6e f3 ff ff <0f> 0b e9 2d f6 ff ff 48 8d bd 98 01 00 00 48 b8 00 00 00 00 00 fc
RSP: 0018:ffffc900014b7d50 EFLAGS: 00010002
RAX: dffffc0000000000 RBX: 1ffff92000296faf RCX: ffff88805e6e1330
RDX: 1ffff1100bcdc265 RSI: ffffffff83b4fecb RDI: 0000000000000006
RBP: ffff88805e6e0fc0 R08: 0000000000000008 R09: ffffffff8cecd34f
R10: 0000000000000040 R11: 0000000000000000 R12: 0000000000000206
R13: ffff88805e6e17f0 R14: ffff88805e6e1000 R15: ffff88805e6e1328
FS:  0000000000000000(0000) GS:ffff88802cc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000b60004 CR3: 0000000067ffb000 CR4: 0000000000350ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 create_io_worker+0x590/0x8d0 fs/io-wq.c:716
 io_wq_manager+0x16b/0xb80 fs/io-wq.c:781
 kthread+0x3af/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
