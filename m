Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7B45BC3C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2019 10:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504028AbfIXIGJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Sep 2019 04:06:09 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:56941 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503939AbfIXIGI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Sep 2019 04:06:08 -0400
Received: by mail-io1-f71.google.com with SMTP id a22so1719767ioq.23
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Sep 2019 01:06:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=GqvdOrn4bCaeW46Vp64HQvAmLWjeyXNtcqKXSxDqmzs=;
        b=eNFblSF73E+theftr6EbRZiTSP7yCpOdez9LeCGOrKg0QKlZIW6LW8FihhFMdFLm5i
         f90bjudVF3Zawv4rMy0/FdA9lGfvFmlpD870C3vXXNxwnP2PMomlM14edesfeKYbRhZ+
         15sfPItcFELSEgse3cx9I2b6viL1Wr9IEcGJ+sG4xIZBVUpivI0okCczpuTpnMEagOWE
         5maKMH2jBmEduhDg0H5stfba7JOdO0EKXjmSSmOO9U9/LWTUAwIrMMFXHxi2ZxOwf2id
         eQliaGLEOe2NXjxwMWbwMTLONT2cMjFygj550L3rTVIL1P7W67c0KIa+J6DscC7u4NoO
         b6fQ==
X-Gm-Message-State: APjAAAXDQVgbCj6H+JmHHLYU9qUuciHb37EbQ/KQXAsEULMVfrSdExQw
        CCqKq2xhkA7Lcf8jvCAVu0XFay8MvWlu2V4zuL/e9Mnh0HRe
X-Google-Smtp-Source: APXvYqzIhHdkXtvQLhH4qAE1kLzCbK7ohlK3BMtaG1Dqfyi9RSEyEPN+s8ld70cRrLhV7laCs8bexrhU4xFuMTLrlokyFczbjnYx
MIME-Version: 1.0
X-Received: by 2002:a5d:85da:: with SMTP id e26mr2184470ios.101.1569312366485;
 Tue, 24 Sep 2019 01:06:06 -0700 (PDT)
Date:   Tue, 24 Sep 2019 01:06:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000025669e05934802d6@google.com>
Subject: WARNING in mark_lock (2)
From:   syzbot <syzbot+ef8a7c8214359d969c69@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    b41dae06 Merge tag 'xfs-5.4-merge-7' of git://git.kernel.o..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16b6d8e9600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dfcf592db22b9132
dashboard link: https://syzkaller.appspot.com/bug?extid=ef8a7c8214359d969c69
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+ef8a7c8214359d969c69@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 1 PID: 20740 at kernel/locking/lockdep.c:167 hlock_class  
kernel/locking/lockdep.c:167 [inline]
WARNING: CPU: 1 PID: 20740 at kernel/locking/lockdep.c:167 hlock_class  
kernel/locking/lockdep.c:156 [inline]
WARNING: CPU: 1 PID: 20740 at kernel/locking/lockdep.c:167  
mark_lock+0x22b/0x1220 kernel/locking/lockdep.c:3643
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 20740 Comm: kworker/u4:10 Not tainted 5.3.0+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: writeback wb_workfn (flush-8:0)
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  panic+0x2dc/0x755 kernel/panic.c:219
  __warn.cold+0x20/0x4c kernel/panic.c:576
  report_bug+0x263/0x2b0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:272
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:291
  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1028
RIP: 0010:hlock_class kernel/locking/lockdep.c:167 [inline]
RIP: 0010:hlock_class kernel/locking/lockdep.c:156 [inline]
RIP: 0010:mark_lock+0x22b/0x1220 kernel/locking/lockdep.c:3643
Code: d0 7c 08 84 d2 0f 85 a8 0e 00 00 44 8b 1d 9d 6d 6e 08 45 85 db 75 b6  
48 c7 c6 a0 26 ac 87 48 c7 c7 e0 26 ac 87 e8 2d 79 eb ff <0f> 0b 31 db e9  
aa fe ff ff 48 c7 c7 e0 60 ae 8a e8 30 8e 54 00 e9
RSP: 0018:ffff88805d72f8d8 EFLAGS: 00010086
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff815c26d6 RDI: ffffed100bae5f0d
RBP: ffff88805d72f928 R08: ffff88806aefa480 R09: fffffbfff11f40b9
R10: fffffbfff11f40b8 R11: ffffffff88fa05c3 R12: 0000000000000008
R13: ffff88806aefad68 R14: 0000000000000000 R15: 00000000000c095a
  mark_usage kernel/locking/lockdep.c:3592 [inline]
  __lock_acquire+0x538/0x4e70 kernel/locking/lockdep.c:3909
  lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4487
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0x95/0xcd kernel/locking/spinlock.c:159
  __wake_up_common_lock+0xc8/0x150 kernel/sched/wait.c:122
  __wake_up+0xe/0x10 kernel/sched/wait.c:142
  finish_writeback_work.isra.0+0xf6/0x120 fs/fs-writeback.c:168
  wb_do_writeback fs/fs-writeback.c:2030 [inline]
  wb_workfn+0x34f/0x11e0 fs/fs-writeback.c:2070
  process_one_work+0x9af/0x1740 kernel/workqueue.c:2269
  worker_thread+0x98/0xe40 kernel/workqueue.c:2415
  kthread+0x361/0x430 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
