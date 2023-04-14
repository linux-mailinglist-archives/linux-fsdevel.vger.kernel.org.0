Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FD56E1FC1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 11:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjDNJuu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 05:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjDNJut (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 05:50:49 -0400
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C5D72AA
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Apr 2023 02:50:48 -0700 (PDT)
Received: by mail-il1-f205.google.com with SMTP id g2-20020a92c7c2000000b003263d81730aso302900ilk.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Apr 2023 02:50:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681465847; x=1684057847;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DY605WH554hKt7hprnlFZyoAVgwrKuT8eXNUVBGngv8=;
        b=P0s9Xd23fU6x/v8ez/7721W9yI958tRjtcG+7qC8Xf9jEyEOU73CsBUeAwsjqWtj5v
         Q+oNkiiZ2FjMdMK6SfHo9ZkHNdtT6we83QZJBe5C9MwG0+M5AV1qIypS9dSNbcg1T21T
         Q2zWJ2YPRQ1oDhY9OKgiilZHemhJ/wqT92qNzYGjp9VBvjhZej4X3Y+M3nDsvI6KpctV
         ozCOPCBKZK3dx1EgUokJwWWFCiWKqS7/C35dJ6T5XnbCzMYBnK7C2fVzk8zy4Zk6gl8o
         XLmqW2A4xtJ0iQP+TCnKOmAHN6jsrQyYwjZVbQaklvnHFDQrS/JewPQmvjgkDdBPSYSj
         WwYg==
X-Gm-Message-State: AAQBX9c0gReVFG8yx7QRM8o2T+BHmblN5rTrozLv9Mlv+xsuRrh2+x7w
        oyur5JqiuiZPXMLfW53fmHBwNuYISJZGxqufuECN5oBnsS7mBzn6VA==
X-Google-Smtp-Source: AKy350YRh87egnBd4E6o4WRsks2zFji5B+tPPiokHRqawLgCL2QyDU+flfXTO09+mmOeA4xwBKeXbpUyCik4HGUZ3frRwtahUTKH
MIME-Version: 1.0
X-Received: by 2002:a02:b007:0:b0:40f:7c3d:2b12 with SMTP id
 p7-20020a02b007000000b0040f7c3d2b12mr490413jah.0.1681465847370; Fri, 14 Apr
 2023 02:50:47 -0700 (PDT)
Date:   Fri, 14 Apr 2023 02:50:47 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000088e26d05f948c634@google.com>
Subject: [syzbot] [reiserfs?] KASAN: null-ptr-deref Read in __wait_on_buffer
From:   syzbot <syzbot+f91110fac7f22eb6284f@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    09a9639e56c0 Linux 6.3-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12ad32adc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c21559e740385326
dashboard link: https://syzkaller.appspot.com/bug?extid=f91110fac7f22eb6284f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/723a785e56e6/disk-09a9639e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/140da8057460/vmlinux-09a9639e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d73b2f2c297c/bzImage-09a9639e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f91110fac7f22eb6284f@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:72 [inline]
BUG: KASAN: null-ptr-deref in _test_bit_acquire include/asm-generic/bitops/instrumented-non-atomic.h:153 [inline]
BUG: KASAN: null-ptr-deref in wait_on_bit_io include/linux/wait_bit.h:99 [inline]
BUG: KASAN: null-ptr-deref in __wait_on_buffer+0x31/0x70 fs/buffer.c:123
Read of size 8 at addr 0000000000000000 by task syz-executor.2/5538

CPU: 1 PID: 5538 Comm: syz-executor.2 Not tainted 6.3.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_report mm/kasan/report.c:433 [inline]
 kasan_report+0xec/0x130 mm/kasan/report.c:536
 check_region_inline mm/kasan/generic.c:181 [inline]
 kasan_check_range+0x141/0x190 mm/kasan/generic.c:187
 instrument_atomic_read include/linux/instrumented.h:72 [inline]
 _test_bit_acquire include/asm-generic/bitops/instrumented-non-atomic.h:153 [inline]
 wait_on_bit_io include/linux/wait_bit.h:99 [inline]
 __wait_on_buffer+0x31/0x70 fs/buffer.c:123
 flush_commit_list.isra.0+0xdd6/0x1e70 fs/reiserfs/journal.c:1072
 do_journal_end+0x3714/0x4af0 fs/reiserfs/journal.c:4302
 do_journal_release fs/reiserfs/journal.c:1917 [inline]
 journal_release+0x149/0x630 fs/reiserfs/journal.c:1971
 reiserfs_put_super+0xe4/0x5c0 fs/reiserfs/super.c:616
 generic_shutdown_super+0x158/0x480 fs/super.c:500
 kill_block_super+0x9b/0xf0 fs/super.c:1407
 deactivate_locked_super+0x98/0x160 fs/super.c:331
 deactivate_super+0xb1/0xd0 fs/super.c:362
 cleanup_mnt+0x2ae/0x3d0 fs/namespace.c:1177
 task_work_run+0x16f/0x270 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xad3/0x2960 kernel/exit.c:869
 __do_sys_exit kernel/exit.c:986 [inline]
 __se_sys_exit kernel/exit.c:984 [inline]
 __x64_sys_exit+0x42/0x50 kernel/exit.c:984
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fee0e88c169
Code: Unable to access opcode bytes at 0x7fee0e88c13f.
RSP: 002b:00007fee0f592118 EFLAGS: 00000246 ORIG_RAX: 000000000000003c
RAX: ffffffffffffffda RBX: 00007fee0e9abf80 RCX: 00007fee0e88c169
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007fee0e8e7ca1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc0cf63b9f R14: 00007fee0f592300 R15: 0000000000022000
 </TASK>
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
