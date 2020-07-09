Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF6721ABD2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jul 2020 01:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgGIXyZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jul 2020 19:54:25 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:40447 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgGIXyW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jul 2020 19:54:22 -0400
Received: by mail-io1-f70.google.com with SMTP id f25so2416963ioh.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jul 2020 16:54:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=pA1D2YOMFQkwPaYBnQ/rdy34gVd9ksQzg2H5D68cGj4=;
        b=S86iKR4A1ZIc8AVXiczALth6boIetL5HCZoYmHJG8hdaWDphDFlcKtrQcGGRq7uc7B
         Ewjtu/K5Fc51B/9H9t/dRn+oOlhFHihSAG4uHAv7ktJOOIvl4M+NGDFmXJ5V1Mj0vRRL
         qcKlW05jIcC9BFdG6nPjUoPeRvIeGKMNb2hyGOT5/J1Kz17zf6BySgNOj0jNTWxslHGp
         m6QkfyBiLHzUygZtpuFUbx3AMp/NbE8V3NxWKYgMM4J7z0zoYHLfaqwiX+e0Cqo7s1EK
         81Jx3XyXvkqRf6+ndbRVodTMd8FAxbyxrF6IPWkU8zCvkTe6O7tApI6tY//x7uyaD2fT
         kTDg==
X-Gm-Message-State: AOAM532SVmyz1r5HTeyj56HyzMw6MbtCuFtkVsIuKRc9oqTbcTD169o8
        SUELk/0c79ypke9qj1O9h+xn9ZoNQNDWMSOVnes7q4f8mMLX
X-Google-Smtp-Source: ABdhPJyDBO+jkuWfL+7LMleucW9jdEcd8VeOHm+EKp/lw736s7ukAPPxvJQFi0BD+kjXzh2UDSYTIBBdv5u5leLGKGilZyM1BvKn
MIME-Version: 1.0
X-Received: by 2002:a92:dc0f:: with SMTP id t15mr44091781iln.218.1594338859494;
 Thu, 09 Jul 2020 16:54:19 -0700 (PDT)
Date:   Thu, 09 Jul 2020 16:54:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005f350105aa0af108@google.com>
Subject: WARNING in __kernel_write
From:   syzbot <syzbot+e6f77e16ff68b2434a2c@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    89032636 Add linux-next specific files for 20200708
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15c4af2f100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=64a250ebabc6c320
dashboard link: https://syzkaller.appspot.com/bug?extid=e6f77e16ff68b2434a2c
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15898b97100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14463a47100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e6f77e16ff68b2434a2c@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 12 at fs/read_write.c:528 __kernel_write+0x828/0x9b0 fs/read_write.c:528
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.8.0-rc4-next-20200708-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events p9_write_work
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 panic+0x2e3/0x75c kernel/panic.c:231
 __warn.cold+0x20/0x45 kernel/panic.c:600
 report_bug+0x1bd/0x210 lib/bug.c:198
 handle_bug+0x38/0x90 arch/x86/kernel/traps.c:234
 exc_invalid_op+0x13/0x40 arch/x86/kernel/traps.c:254
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:542
RIP: 0010:__kernel_write+0x828/0x9b0 fs/read_write.c:528
Code: 01 89 c6 89 04 24 e8 d7 90 b5 ff 8b 04 24 85 c0 0f 84 c7 fa ff ff e9 b9 fa ff ff e8 42 94 b5 ff e9 e9 fe ff ff e8 38 94 b5 ff <0f> 0b 49 c7 c5 f7 ff ff ff e9 0e ff ff ff 4c 89 f7 e8 d2 48 f5 ff
RSP: 0018:ffffc90000d2fb18 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 1ffff920001a5f67 RCX: ffffffff81be629e
RDX: ffff8880a95f4300 RSI: ffffffff81be69f8 RDI: 0000000000000005
RBP: ffff888094301158 R08: 0000000000000001 R09: ffff8880a95f4bd0
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888094301040
R13: 0000000000000000 R14: ffff8880943010c4 R15: 0000000000080001
 kernel_write fs/read_write.c:569 [inline]
 kernel_write+0xe2/0x200 fs/read_write.c:559
 p9_fd_write net/9p/trans_fd.c:424 [inline]
 p9_write_work+0x25e/0xca0 net/9p/trans_fd.c:475
 process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
