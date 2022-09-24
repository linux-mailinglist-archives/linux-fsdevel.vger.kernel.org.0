Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412295E8F7C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Sep 2022 21:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbiIXTQi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Sep 2022 15:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbiIXTQh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Sep 2022 15:16:37 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F265AA39
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Sep 2022 12:16:36 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id b9-20020a6be709000000b006a469cf388eso737590ioh.19
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Sep 2022 12:16:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=/PgO9NTe3l1pRzuQBnf2Ov83XnHyKmhM4tc6u6+9iG0=;
        b=cqvkDDWzqVG47CGolbkn4laKfHb+vO928zsdk/jetcSnkO9RIL3CkQOZ04/qYSakTk
         8e3wNdPWcondaRqONWcdQo7BqGpitWHUcwgCA5Unt+jnHmSmIft3D0hBrTIH1HRc2N36
         Z3hWPptEc0SKr2xObJ8eoaSe+RbzDyljwXnk1/y3PVnp+fnEoSo/ovT1EPTUet4mCuXJ
         eU56RgK/8zmdWFz6bB7Zy+2cgCvPfZbpuKSZh8+fnBTavCec0td4hkEd75rLsTmifIno
         smvJnEEYXIMdKzi5AOT8pHb8VO/wgEsGEY+kGeWQMZkIe4UdlE6/0AZ8sZx0DcuMQzJT
         lUDw==
X-Gm-Message-State: ACrzQf3huve4rBzZFsqtniQULe2v1cxTAg6B7inKrC/gPq8EfJhLQMIK
        Wgk0JtKLm+tmA8eIskiJML9hikxTnIp7mdwvpObRMG7SCNCm
X-Google-Smtp-Source: AMsMyM6Wt5aurPQUufTG4eqCSshOWqOZ1FwVA4LaEwkZ6fqYAfTZbQ9ZQh+st8Jr/66+Y6onIAlmvEss19QkoYVYm3S0BEikA1zK
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2691:b0:35a:a26f:bb2 with SMTP id
 o17-20020a056638269100b0035aa26f0bb2mr7419016jat.18.1664046996247; Sat, 24
 Sep 2022 12:16:36 -0700 (PDT)
Date:   Sat, 24 Sep 2022 12:16:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000019db4e05e9712237@google.com>
Subject: [syzbot] kernel panic: stack is corrupted in lock_acquire (2)
From:   syzbot <syzbot+db99576f362a5c1e9f7a@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3db61221f4e8 Merge tag 'io_uring-6.0-2022-09-23' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=109646e4880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c221af36f6d1d811
dashboard link: https://syzkaller.appspot.com/bug?extid=db99576f362a5c1e9f7a
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+db99576f362a5c1e9f7a@syzkaller.appspotmail.com

Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: lock_acquire+0x3b6/0x3c0
CPU: 0 PID: 17384 Comm: syz-executor.0 Not tainted 6.0.0-rc6-syzkaller-00291-g3db61221f4e8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 panic+0x2d6/0x715 kernel/panic.c:274
 __stack_chk_fail+0x12/0x20 kernel/panic.c:706
 lock_acquire+0x3b6/0x3c0
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:349 [inline]
 inode_wait_for_writeback+0x89/0x2c0 fs/fs-writeback.c:1472
 evict+0x277/0x620 fs/inode.c:662
 ntfs_fill_super+0x3af3/0x42a0 fs/ntfs3/super.c:1190
 get_tree_bdev+0x400/0x620 fs/super.c:1323
 vfs_get_tree+0x88/0x270 fs/super.c:1530
 do_new_mount+0x289/0xad0 fs/namespace.c:3040
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f40c2c8bb9a
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f40c3d21f88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007f40c2c8bb9a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f40c3d21fe0
RBP: 00007f40c3d22020 R08: 00007f40c3d22020 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000020000000
R13: 0000000020000100 R14: 00007f40c3d21fe0 R15: 000000002007aa80
 </TASK>
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
