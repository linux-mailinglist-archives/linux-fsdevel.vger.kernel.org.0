Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBCC5EA75B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Sep 2022 15:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234208AbiIZNeW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 09:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235453AbiIZNdb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 09:33:31 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67BD792F9
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 04:55:53 -0700 (PDT)
Received: by mail-qt1-f198.google.com with SMTP id e8-20020ac85988000000b0035c39dd5eb9so4567484qte.16
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 04:55:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=dIfXRWyQ7i217EgVRacoDrHCk3S/Q3VlvlvvT96zRCQ=;
        b=lmhHySwzw/ZeP42otu1p2+vZn0XHXk8FyVeRPNwjMMKa5nbQuK1lD8xnw7aW1MmC89
         wWhRhwopvKUNMEI0j+xmFxSPoHuq+9osto6cap5ZTemHaEcDIztT7NxLfte/ZQO1K7Tq
         L7aUtySJR3biZOGoL3hyW4KiUBcTD6EvCY1pibGnwvbrBQtVypNUjYE3V6M8Oy2Pijd3
         qHOY0C17vFa1b10RlwDEPf/tEwi2wiY6CEeiQS0Q3nhUAMY/Lqr7dXFycxFNtDkKnVH7
         9cR38Qr0L35QIV8YL8KL2ArbUFQRddUzR0r1/17GHpwXvcqaNxoH1/BE6URd492BTK+A
         3COA==
X-Gm-Message-State: ACrzQf1sU4RBBlza4m0z/vwswQvgp0x1X90c7EzUhzUpiwRybAP/GVvC
        xy3brZjtU+qWAoOX36dEf0j5YDZigWbVt9ELBSjiav1hl0Ja
X-Google-Smtp-Source: AMsMyM7rNXR6GqR0/10JkeeckFH9T+UYlBTlIOsxii7FQMkwK3v8BYDBCInZRfHQbM3JHxrLL7sSlpR6MCdQn4ysK9cBKoFcgEal
MIME-Version: 1.0
X-Received: by 2002:a05:6638:d0b:b0:35a:9936:a922 with SMTP id
 q11-20020a0566380d0b00b0035a9936a922mr11664955jaj.169.1664192795757; Mon, 26
 Sep 2022 04:46:35 -0700 (PDT)
Date:   Mon, 26 Sep 2022 04:46:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006dd10705e99314a8@google.com>
Subject: [syzbot] WARNING: lock held when returning to user space in alloc_super
From:   syzbot <syzbot+7379d1edb09dff51e4a6@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f76349cf4145 Linux 6.0-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=122d6188880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba0d23aa7e1ffaf5
dashboard link: https://syzkaller.appspot.com/bug?extid=7379d1edb09dff51e4a6
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7379d1edb09dff51e4a6@syzkaller.appspotmail.com

================================================
WARNING: lock held when returning to user space!
6.0.0-rc7-syzkaller #0 Not tainted
------------------------------------------------
syz-executor.2/11590 is leaving the kernel with locks still held!
2 locks held by syz-executor.2/11590:
 #0: ffff888073cb60e0 (&type->s_umount_key#64/1){+.+.}-{3:3}, at: alloc_super+0x212/0x920 fs/super.c:228
 #1: ffff88802d1df8f0 (&sb->s_type->i_lock_key#40){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:349 [inline]
 #1: ffff88802d1df8f0 (&sb->s_type->i_lock_key#40){+.+.}-{2:2}, at: _atomic_dec_and_lock+0x9d/0x110 lib/dec_and_lock.c:28
BUG: scheduling while atomic: syz-executor.2/11590/0x00000002
INFO: lockdep is turned off.
Modules linked in:
Preemption disabled at:
[<0000000000000000>] 0x0
Kernel panic - not syncing: scheduling while atomic
CPU: 1 PID: 11590 Comm: syz-executor.2 Not tainted 6.0.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 panic+0x2d6/0x715 kernel/panic.c:274
 __schedule_bug+0x1ff/0x250 kernel/sched/core.c:5724
 schedule_debug+0x1d3/0x3c0 kernel/sched/core.c:5753
 __schedule+0xfb/0xdf0 kernel/sched/core.c:6388
 schedule+0xcb/0x190 kernel/sched/core.c:6570
 exit_to_user_mode_loop+0xe5/0x150 kernel/entry/common.c:157
 exit_to_user_mode_prepare+0xb2/0x140 kernel/entry/common.c:201
 irqentry_exit_to_user_mode+0x5/0x30 kernel/entry/common.c:307
 exc_general_protection+0x298/0x430 arch/x86/kernel/traps.c:719
 asm_exc_general_protection+0x22/0x30 arch/x86/include/asm/idtentry.h:564
 </TASK>
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
