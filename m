Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4996E2C6E45
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Nov 2020 02:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731200AbgK1BrL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Nov 2020 20:47:11 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:48669 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731071AbgK1BoW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Nov 2020 20:44:22 -0500
Received: by mail-il1-f197.google.com with SMTP id o5so4981749ilh.15
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2020 17:44:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=pn/BIuU+GSZgzinsw5sgK0XloHmBIEs8/wikqAB55YI=;
        b=mubrUXkeA4J9yeziDR8DXHPJRNjCkzeUeig066TP1oaAAE8cESGt5lXizZWPN5UNpj
         fNAo9iFKrk5LNC5yZWOiO8gsbwJs16RCY6Kyi4b6j9gX1iHwqXsTQHvR1sfj0+FgVrdc
         wOZ90xgss/DNx0Cwo2WyxJdfV3ko+Nbds+9NEwGtuPWGIhi7gv+u3UXQuBub5LEK3lFG
         rREzDCqaXkyvQLhqKheTa4p+fsF/131OPzZfHTN/kGzxnSkoHNKENrbAmbmYQLdIO9AD
         Fdk9h9FcgrzCIsr4M6vlJCJr47JtsUfzq54dSg6UQ4FrQa881wasqu80uGK1CAAhBpY4
         FsAA==
X-Gm-Message-State: AOAM533xDlUCBeFQ9G3G3bvRJI3n5lq0+67woW5YCBektguXpAYbouWL
        vSxRCYjGgBDoqs7KKXv+M5MZC6zCrFFwqgykRlAo4iy7d+zp
X-Google-Smtp-Source: ABdhPJxtgaw7qrXNHOCpWNyyDHQBt0a9xfsLTP5HDvFsz8LGxBUuq1TRGKD4P1UFm341Y+9QMFC+DuInDlAtrAJcfnL7cADRvXCQ
MIME-Version: 1.0
X-Received: by 2002:a92:da01:: with SMTP id z1mr8885755ilm.214.1606527860242;
 Fri, 27 Nov 2020 17:44:20 -0800 (PST)
Date:   Fri, 27 Nov 2020 17:44:20 -0800
In-Reply-To: <00000000000010c66805b274dbd7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006e7ea105b520ea50@google.com>
Subject: Re: WARNING in try_to_wake_up
From:   syzbot <syzbot+dd74984384afdb86e904@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    99c710c4 Merge tag 'platform-drivers-x86-v5.10-2' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1780c563500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6d1e98d0b97781e4
dashboard link: https://syzkaller.appspot.com/bug?extid=dd74984384afdb86e904
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11e6161d500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1651b32d500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dd74984384afdb86e904@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 9857 at include/linux/cpumask.h:137 rcu_read_unlock include/linux/rcupdate.h:696 [inline]
WARNING: CPU: 1 PID: 9857 at include/linux/cpumask.h:137 ttwu_stat kernel/sched/core.c:2441 [inline]
WARNING: CPU: 1 PID: 9857 at include/linux/cpumask.h:137 try_to_wake_up+0xef6/0x1330 kernel/sched/core.c:2984
Modules linked in:
CPU: 1 PID: 9857 Comm: io_wq_manager Not tainted 5.10.0-rc5-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:cpu_max_bits_warn include/linux/cpumask.h:137 [inline]
RIP: 0010:cpumask_check include/linux/cpumask.h:144 [inline]
RIP: 0010:cpumask_check include/linux/cpumask.h:142 [inline]
RIP: 0010:cpumask_test_cpu include/linux/cpumask.h:367 [inline]
RIP: 0010:is_cpu_allowed kernel/sched/core.c:1705 [inline]
RIP: 0010:select_task_rq kernel/sched/core.c:2370 [inline]
RIP: 0010:try_to_wake_up+0xef6/0x1330 kernel/sched/core.c:2964
Code: 80 3d 93 2a 8c 0b 00 0f 84 f1 00 00 00 e8 82 80 10 00 48 c7 c6 d9 6d 4c 81 48 c7 c7 e0 77 33 8b e8 0f b7 09 00 e9 15 f9 ff ff <0f> 0b e9 65 f4 ff ff 4c 89 ff 48 89 4c 24 08 e8 b6 51 ff ff 48 8b
RSP: 0018:ffffc900009c7d50 EFLAGS: 00010002
RAX: dffffc0000000000 RBX: 1ffff92000138faf RCX: ffff88804825c438
RDX: 1ffff1100904b886 RSI: ffffffff83b63c9b RDI: 0000000000000006
RBP: ffff88804825c0c0 R08: ffff88804825c0d0 R09: ffffffff8cecc98f
R10: 0000000000000040 R11: 0000000000000000 R12: 0000000000000202
R13: ffff88804825c8f8 R14: 0000000000000008 R15: ffff88804825c430
FS:  0000000000000000(0000) GS:ffff88802cb00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000560a8007e384 CR3: 00000000133db000 CR4: 0000000000350ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 create_io_worker+0x590/0x8d0 fs/io-wq.c:720
 io_wq_manager+0x16b/0xb80 fs/io-wq.c:785
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

