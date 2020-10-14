Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D118F28E055
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Oct 2020 14:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbgJNMMS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 08:12:18 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:39598 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbgJNMMS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 08:12:18 -0400
Received: by mail-il1-f200.google.com with SMTP id r10so2233110ilq.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2020 05:12:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=zg+I8d7ndikJ7TpxgGlYT9fzJHpVC4H6Dh85V9obOeM=;
        b=uIO5faYGNCPlHeaGER7XTMZD7Q8+Z9+UMEWDUMun8DlJmw8RyVKbSkndOSQdH78lkD
         sLAnIyT248bMQrn8n71Es7C1ajT+qwNEMwcmkDXeykVOmh3yVOccOgo77nGlgvcaU5ZP
         yrvGpQ+qyCdGMaw09cY2Yh0kQS6uu41k9Hg59fEBBJIg7klQ6NgiCVQN2g2Uh8sH4QqT
         XVLlqEEgVxRe7kjgddaAmkJf6cuu6Tvo8e5Jj0Meu5brpXSuMe1UjUiTGjh0kx+DQIjL
         NyqF72TiwAkkTlGxNcXlIEOIxAg3XBv7m1pbzq5ejbCqSfnxeKRA6xs08hkCSggbXtyS
         AkyA==
X-Gm-Message-State: AOAM531x45gFpMzGtb3+mTQUkA3lzXp4RWMu6FjQLC6C1vzhlcvArOVl
        Kq60n2O1UHqzo+5wYgumTzrQEKNNBZEGOb35Jp9jejnSFGXf
X-Google-Smtp-Source: ABdhPJzRW7x0/xlervt4O2pE68CaIIdEKA1VQFrZob2AbSmj39suHSe9DEIiaQwntmUbHW3aGq5XiLTagbrw77a+fKZ0sJf2cLXK
MIME-Version: 1.0
X-Received: by 2002:a92:c88e:: with SMTP id w14mr3290219ilo.185.1602677536914;
 Wed, 14 Oct 2020 05:12:16 -0700 (PDT)
Date:   Wed, 14 Oct 2020 05:12:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004702c605b1a0717e@google.com>
Subject: WARNING in cleanup_mnt (2)
From:   syzbot <syzbot+428c51fcb8f9e5a84850@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    bbf5c979 Linux 5.9
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15498ffb900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3d8333c88fe898d7
dashboard link: https://syzkaller.appspot.com/bug?extid=428c51fcb8f9e5a84850
compiler:       gcc (GCC) 10.1.0-syz 20200507
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+428c51fcb8f9e5a84850@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 30737 at fs/namespace.c:1109 cleanup_mnt+0x409/0x530 fs/namespace.c:1109
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 30737 Comm: syz-executor.3 Not tainted 5.9.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fd lib/dump_stack.c:118
 panic+0x382/0x7fb kernel/panic.c:231
 __warn.cold+0x20/0x4b kernel/panic.c:600
 report_bug+0x1bd/0x210 lib/bug.c:198
 handle_bug+0x38/0x90 arch/x86/kernel/traps.c:234
 exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:254
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:536
RIP: 0010:cleanup_mnt+0x409/0x530 fs/namespace.c:1109
Code: 8a e8 9b c0 0c 02 49 8d 7c 24 38 48 c7 c6 80 4a ca 81 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e 41 5f e9 ec 9c 98 ff e8 f7 9f ab ff <0f> 0b e9 0a fd ff ff e8 eb 9f ab ff 4c 89 e7 e8 43 03 06 00 e9 2f
RSP: 0018:ffffc900163afac0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: ffffffff81ca9c21
RDX: ffff88809201a2c0 RSI: ffffffff81ca9f19 RDI: 0000000000000005
RBP: 0000000000000040 R08: 0000000000000000 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880889c0540
R13: 000000000000042b R14: 0000000000000007 R15: 0000000000000002
 task_work_run+0xdd/0x190 kernel/task_work.c:141
 exit_task_work include/linux/task_work.h:25 [inline]
 do_exit+0xb7d/0x29f0 kernel/exit.c:806
 do_group_exit+0x125/0x310 kernel/exit.c:903
 get_signal+0x428/0x1f00 kernel/signal.c:2757
 arch_do_signal+0x82/0x2520 arch/x86/kernel/signal.c:811
 exit_to_user_mode_loop kernel/entry/common.c:161 [inline]
 exit_to_user_mode_prepare+0x1ae/0x200 kernel/entry/common.c:192
 syscall_exit_to_user_mode+0x7e/0x2e0 kernel/entry/common.c:267
 __do_fast_syscall_32+0x6c/0x90 arch/x86/entry/common.c:138
 do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:160
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7f06549
Code: Bad RIP value.
RSP: 002b:00000000090bfbfc EFLAGS: 00000212 ORIG_RAX: 0000000000000006
RAX: 0000000000000000 RBX: 0000000000000004 RCX: 0000000000000000
RDX: 0000000000000005 RSI: 0000000008bab680 RDI: 0000000008bab680
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
