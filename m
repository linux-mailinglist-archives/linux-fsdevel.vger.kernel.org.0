Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A4D733D2F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jun 2023 02:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345886AbjFQAeE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jun 2023 20:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234361AbjFQAeC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jun 2023 20:34:02 -0400
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBE73A9E
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jun 2023 17:33:57 -0700 (PDT)
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-33d93feefb5so11135915ab.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jun 2023 17:33:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686962037; x=1689554037;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GhDsowiwn7/lUjD4iBtZXoBf6gT4cGop3v5+h/m2ZEo=;
        b=ej3Ebi/WlvGBwzeqARV5YLvarfGo8ES3GJQNoilkJ2lGS015Zrhqh1JgaxTb8awm0Y
         nxAi3NDFQwGkhHbpEH0LeRDvW27NM0+R+K7o0P+8ZAR4IKILILVVb5NuCAdwGnzQI8Sl
         cy6KoZvq/84mBK8+JIW4mdFW75midDb6Q7NuO4PaZbQZNFjScXCrugEuoH7j/IbfmUkp
         Tiyqyr0uPEAzSOZUschUjs10OgmIi+a7rv3VCO6YKDCISKGY9xHZJ02GRUxGFnpR7gB7
         m6JN88p+7zsrXdOGDkx+5z3X0NgV7h1mdCx3TceuNZHTH5sO6HKIAFr4hjWmv39Jzbcy
         0O8g==
X-Gm-Message-State: AC+VfDw9Cpb4p/0ZtmWMbX5AAQIo9m8MHrtbjH6dKmT2cnI3EfrPjAde
        y7gezlF5fbnWR2/ZObtY4YTLiIx0IcrYl5S6mcVKRBWZxf8W
X-Google-Smtp-Source: ACHHUZ7Ky3sk53fVmNPGie1rxP0j6zXudWuXztYdPWawbmN1o9u+3Lfld1sCYj7qzfr4kJXF1CpdtHKc9n7mc/37iLLdbo8tVrfL
MIME-Version: 1.0
X-Received: by 2002:a92:d204:0:b0:338:bdd7:d439 with SMTP id
 y4-20020a92d204000000b00338bdd7d439mr671608ily.6.1686962036905; Fri, 16 Jun
 2023 17:33:56 -0700 (PDT)
Date:   Fri, 16 Jun 2023 17:33:56 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f59fa505fe48748f@google.com>
Subject: [syzbot] [ext4?] INFO: task hung in __writeback_inodes_sb_nr (6)
From:   syzbot <syzbot+38d04642cea49f3a3d2e@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    62d8779610bb Merge tag 'ext4_for_linus_stable' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1623de37280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ac246111fb601aec
dashboard link: https://syzkaller.appspot.com/bug?extid=38d04642cea49f3a3d2e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f2ffbf05c9a8/disk-62d87796.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4809ae14c9e7/vmlinux-62d87796.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9cd8b18ed845/bzImage-62d87796.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+38d04642cea49f3a3d2e@syzkaller.appspotmail.com

INFO: task syz-executor.2:687 blocked for more than 143 seconds.
      Not tainted 6.4.0-rc6-syzkaller-00049-g62d8779610bb #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.2  state:D stack:23232 pid:687   ppid:24312  flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5343 [inline]
 __schedule+0xc9a/0x5880 kernel/sched/core.c:6669
 schedule+0xde/0x1a0 kernel/sched/core.c:6745
 wb_wait_for_completion+0x182/0x240 fs/fs-writeback.c:192
 __writeback_inodes_sb_nr+0x1d7/0x280 fs/fs-writeback.c:2644
 try_to_writeback_inodes_sb+0x98/0xc0 fs/fs-writeback.c:2692
 ext4_nonda_switch+0x1aa/0x1f0 fs/ext4/inode.c:2864
 ext4_da_write_begin+0x172/0x8c0 fs/ext4/inode.c:2891
 generic_perform_write+0x256/0x570 mm/filemap.c:3929
 ext4_buffered_write_iter+0x15b/0x460 fs/ext4/file.c:289
 ext4_file_write_iter+0xbe0/0x1740 fs/ext4/file.c:710
 __kernel_write_iter+0x262/0x7a0 fs/read_write.c:517
 dump_emit_page fs/coredump.c:888 [inline]
 dump_user_range+0x23c/0x710 fs/coredump.c:915
 elf_core_dump+0x277e/0x36e0 fs/binfmt_elf.c:2142
 do_coredump+0x2f2b/0x4020 fs/coredump.c:764
 get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 arch_do_signal_or_restart+0x79/0x5c0 arch/x86/kernel/signal.c:306
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
 irqentry_exit_to_user_mode+0x9/0x40 kernel/entry/common.c:310
 asm_exc_general_protection+0x26/0x30 arch/x86/include/asm/idtentry.h:564
RIP: 0033:0x7fd6b008c391
RSP: 002b:0000000020000160 EFLAGS: 00010217
RAX: 0000000000000000 RBX: 00007fd6b01abf80 RCX: 00007fd6b008c389
RDX: 0000000020000180 RSI: 0000000020000160 RDI: 0000000002000000
RBP: 00007fd6b00d7493 R08: 0000000020000200 R09: 0000000020000200
R10: 00000000200001c0 R11: 0000000000000206 R12: 0000000000000000
R13: 00007ffddfff939f R14: 00007fd6b0dfd300 R15: 0000000000022000
 </TASK>
INFO: task syz-executor.4:740 blocked for more than 143 seconds.
      Not tainted 6.4.0-rc6-syzkaller-00049-g62d8779610bb #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.4  state:D stack:23248 pid:740   ppid:542    flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5343 [inline]
 __schedule+0xc9a/0x5880 kernel/sched/core.c:6669
 schedule+0xde/0x1a0 kernel/sched/core.c:6745
 wb_wait_for_completion+0x182/0x240 fs/fs-writeback.c:192
 __writeback_inodes_sb_nr+0x1d7/0x280 fs/fs-writeback.c:2644
 try_to_writeback_inodes_sb+0x98/0xc0 fs/fs-writeback.c:2692
 ext4_nonda_switch+0x1aa/0x1f0 fs/ext4/inode.c:2864
 ext4_da_write_begin+0x172/0x8c0 fs/ext4/inode.c:2891
 generic_perform_write+0x256/0x570 mm/filemap.c:3929
 ext4_buffered_write_iter+0x15b/0x460 fs/ext4/file.c:289
 ext4_file_write_iter+0xbe0/0x1740 fs/ext4/file.c:710
 __kernel_write_iter+0x262/0x7a0 fs/read_write.c:517
 dump_emit_page fs/coredump.c:888 [inline]
 dump_user_range+0x23c/0x710 fs/coredump.c:915
 elf_core_dump+0x277e/0x36e0 fs/binfmt_elf.c:2142
 do_coredump+0x2f2b/0x4020 fs/coredump.c:764
 get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 arch_do_signal_or_restart+0x79/0x5c0 arch/x86/kernel/signal.c:306
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
 irqentry_exit_to_user_mode+0x9/0x40 kernel/entry/common.c:310
 asm_exc_general_protection+0x26/0x30 arch/x86/include/asm/idtentry.h:564
RIP: 0033:0x7fbf7328c391
RSP: 002b:0000000020000160 EFLAGS: 00010217
RAX: 0000000000000000 RBX: 00007fbf733ac050 RCX: 00007fbf7328c389
RDX: 0000000020000180 RSI: 0000000020000160 RDI: 0000000002000000
RBP: 00007fbf732d7493 R08: 0000000020000200 R09: 0000000020000200
R10: 00000000200001c0 R11: 0000000000000206 R12: 0000000000000000
R13: 00007ffc83f3088f R14: 00007fbf74061300 R15: 0000000000022000
 </TASK>
INFO: task syz-executor.4:885 blocked for more than 145 seconds.
      Not tainted 6.4.0-rc6-syzkaller-00049-g62d8779610bb #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.4  state:D stack:23824 pid:885   ppid:542    flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5343 [inline]
 __schedule+0xc9a/0x5880 kernel/sched/core.c:6669
 schedule+0xde/0x1a0 kernel/sched/core.c:6745
 wb_wait_for_completion+0x182/0x240 fs/fs-writeback.c:192
 __writeback_inodes_sb_nr+0x1d7/0x280 fs/fs-writeback.c:2644
 try_to_writeback_inodes_sb+0x98/0xc0 fs/fs-writeback.c:2692
 ext4_nonda_switch+0x1aa/0x1f0 fs/ext4/inode.c:2864
 ext4_da_write_begin+0x172/0x8c0 fs/ext4/inode.c:2891
 generic_perform_write+0x256/0x570 mm/filemap.c:3929
 ext4_buffered_write_iter+0x15b/0x460 fs/ext4/file.c:289
 ext4_file_write_iter+0xbe0/0x1740 fs/ext4/file.c:710
 __kernel_write_iter+0x262/0x7a0 fs/read_write.c:517
 dump_emit_page fs/coredump.c:888 [inline]
 dump_user_range+0x23c/0x710 fs/coredump.c:915
 elf_core_dump+0x277e/0x36e0 fs/binfmt_elf.c:2142
 do_coredump+0x2f2b/0x4020 fs/coredump.c:764
 get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 arch_do_signal_or_restart+0x79/0x5c0 arch/x86/kernel/signal.c:306
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
 irqentry_exit_to_user_mode+0x9/0x40 kernel/entry/common.c:310
 asm_exc_general_protection+0x26/0x30 arch/x86/include/asm/idtentry.h:564
RIP: 0033:0x7fbf7328c391
RSP: 002b:0000000020000160 EFLAGS: 00010217
RAX: 0000000000000000 RBX: 00007fbf733abf80 RCX: 00007fbf7328c389
RDX: 0000000020000180 RSI: 0000000020000160 RDI: 0000000002000000
RBP: 00007fbf732d7493 R08: 0000000020000200 R09: 0000000020000200
R10: 00000000200001c0 R11: 0000000000000206 R12: 0000000000000000
R13: 00007ffc83f3088f R14: 00007fbf74082300 R15: 0000000000022000
 </TASK>
INFO: task syz-executor.4:908 blocked for more than 146 seconds.
      Not tainted 6.4.0-rc6-syzkaller-00049-g62d8779610bb #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.4  state:D stack:23944 pid:908   ppid:542    flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5343 [inline]
 __schedule+0xc9a/0x5880 kernel/sched/core.c:6669
 schedule+0xde/0x1a0 kernel/sched/core.c:6745
 wb_wait_for_completion+0x182/0x240 fs/fs-writeback.c:192
 __writeback_inodes_sb_nr+0x1d7/0x280 fs/fs-writeback.c:2644
 try_to_writeback_inodes_sb+0x98/0xc0 fs/fs-writeback.c:2692
 ext4_nonda_switch+0x1aa/0x1f0 fs/ext4/inode.c:2864
 ext4_da_write_begin+0x172/0x8c0 fs/ext4/inode.c:2891
 generic_perform_write+0x256/0x570 mm/filemap.c:3929
 ext4_buffered_write_iter+0x15b/0x460 fs/ext4/file.c:289
 ext4_file_write_iter+0xbe0/0x1740 fs/ext4/file.c:710
 __kernel_write_iter+0x262/0x7a0 fs/read_write.c:517
 dump_emit_page fs/coredump.c:888 [inline]
 dump_user_range+0x23c/0x710 fs/coredump.c:915
 elf_core_dump+0x277e/0x36e0 fs/binfmt_elf.c:2142
 do_coredump+0x2f2b/0x4020 fs/coredump.c:764
 get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 arch_do_signal_or_restart+0x79/0x5c0 arch/x86/kernel/signal.c:306
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
 irqentry_exit_to_user_mode+0x9/0x40 kernel/entry/common.c:310
 asm_exc_general_protection+0x26/0x30 arch/x86/include/asm/idtentry.h:564
RIP: 0033:0x7fbf7328c391
RSP: 002b:0000000020000280 EFLAGS: 00010217
RAX: 0000000000000000 RBX: 00007fbf733abf80 RCX: 00007fbf7328c389
RDX: 00000000200002c0 RSI: 0000000020000280 RDI: 0000000000000200
RBP: 00007fbf732d7493 R08: 0000000020000340 R09: 0000000020000340
R10: 0000000020000300 R11: 0000000000000206 R12: 0000000000000000
R13: 00007ffc83f3088f R14: 00007fbf74082300 R15: 0000000000022000
 </TASK>
INFO: task syz-executor.4:936 blocked for more than 147 seconds.
      Not tainted 6.4.0-rc6-syzkaller-00049-g62d8779610bb #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.4  state:D stack:23944 pid:936   ppid:542    flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5343 [inline]
 __schedule+0xc9a/0x5880 kernel/sched/core.c:6669
 schedule+0xde/0x1a0 kernel/sched/core.c:6745
 wb_wait_for_completion+0x182/0x240 fs/fs-writeback.c:192
 __writeback_inodes_sb_nr+0x1d7/0x280 fs/fs-writeback.c:2644
 try_to_writeback_inodes_sb+0x98/0xc0 fs/fs-writeback.c:2692
 ext4_nonda_switch+0x1aa/0x1f0 fs/ext4/inode.c:2864
 ext4_da_write_begin+0x172/0x8c0 fs/ext4/inode.c:2891
 generic_perform_write+0x256/0x570 mm/filemap.c:3929
 ext4_buffered_write_iter+0x15b/0x460 fs/ext4/file.c:289
 ext4_file_write_iter+0xbe0/0x1740 fs/ext4/file.c:710
 __kernel_write_iter+0x262/0x7a0 fs/read_write.c:517
 dump_emit_page fs/coredump.c:888 [inline]
 dump_user_range+0x23c/0x710 fs/coredump.c:915
 elf_core_dump+0x277e/0x36e0 fs/binfmt_elf.c:2142
 do_coredump+0x2f2b/0x4020 fs/coredump.c:764
 get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 arch_do_signal_or_restart+0x79/0x5c0 arch/x86/kernel/signal.c:306
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
 irqentry_exit_to_user_mode+0x9/0x40 kernel/entry/common.c:310
 asm_exc_general_protection+0x26/0x30 arch/x86/include/asm/idtentry.h:564
RIP: 0033:0x7fbf7328c391
RSP: 002b:0000000020000160 EFLAGS: 00010217
RAX: 0000000000000000 RBX: 00007fbf733abf80 RCX: 00007fbf7328c389
RDX: 0000000020000180 RSI: 0000000020000160 RDI: 0000000002000000
RBP: 00007fbf732d7493 R08: 0000000020000200 R09: 0000000020000200
R10: 00000000200001c0 R11: 0000000000000206 R12: 0000000000000000
R13: 00007ffc83f3088f R14: 00007fbf74082300 R15: 0000000000022000
 </TASK>
INFO: task syz-executor.2:971 blocked for more than 147 seconds.
      Not tainted 6.4.0-rc6-syzkaller-00049-g62d8779610bb #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.2  state:D stack:22928 pid:971   ppid:24312  flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5343 [inline]
 __schedule+0xc9a/0x5880 kernel/sched/core.c:6669
 schedule+0xde/0x1a0 kernel/sched/core.c:6745
 wb_wait_for_completion+0x182/0x240 fs/fs-writeback.c:192
 __writeback_inodes_sb_nr+0x1d7/0x280 fs/fs-writeback.c:2644
 try_to_writeback_inodes_sb+0x98/0xc0 fs/fs-writeback.c:2692
 ext4_nonda_switch+0x1aa/0x1f0 fs/ext4/inode.c:2864
 ext4_da_write_begin+0x172/0x8c0 fs/ext4/inode.c:2891
 generic_perform_write+0x256/0x570 mm/filemap.c:3929
 ext4_buffered_write_iter+0x15b/0x460 fs/ext4/file.c:289
 ext4_file_write_iter+0xbe0/0x1740 fs/ext4/file.c:710
 __kernel_write_iter+0x262/0x7a0 fs/read_write.c:517
 dump_emit_page fs/coredump.c:888 [inline]
 dump_user_range+0x23c/0x710 fs/coredump.c:915
 elf_core_dump+0x277e/0x36e0 fs/binfmt_elf.c:2142
 do_coredump+0x2f2b/0x4020 fs/coredump.c:764
 get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 arch_do_signal_or_restart+0x79/0x5c0 arch/x86/kernel/signal.c:306
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
 irqentry_exit_to_user_mode+0x9/0x40 kernel/entry/common.c:310
 asm_exc_general_protection+0x26/0x30 arch/x86/include/asm/idtentry.h:564
RIP: 0033:0x7fd6b008c391
RSP: 002b:0000000020000280 EFLAGS: 00010217
RAX: 0000000000000000 RBX: 00007fd6b01abf80 RCX: 00007fd6b008c389
RDX: 00000000200002c0 RSI: 0000000020000280 RDI: 0000000000000200
RBP: 00007fd6b00d7493 R08: 0000000020000340 R09: 0000000020000340
R10: 0000000020000300 R11: 0000000000000206 R12: 0000000000000000
R13: 00007ffddfff939f R14: 00007fd6b0dfd300 R15: 0000000000022000
 </TASK>
INFO: task syz-executor.2:983 blocked for more than 148 seconds.
      Not tainted 6.4.0-rc6-syzkaller-00049-g62d8779610bb #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.2  state:D stack:23776 pid:983   ppid:24312  flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5343 [inline]
 __schedule+0xc9a/0x5880 kernel/sched/core.c:6669
 schedule+0xde/0x1a0 kernel/sched/core.c:6745
 wb_wait_for_completion+0x182/0x240 fs/fs-writeback.c:192
 __writeback_inodes_sb_nr+0x1d7/0x280 fs/fs-writeback.c:2644
 try_to_writeback_inodes_sb+0x98/0xc0 fs/fs-writeback.c:2692
 ext4_nonda_switch+0x1aa/0x1f0 fs/ext4/inode.c:2864
 ext4_da_write_begin+0x172/0x8c0 fs/ext4/inode.c:2891
 generic_perform_write+0x256/0x570 mm/filemap.c:3929
 ext4_buffered_write_iter+0x15b/0x460 fs/ext4/file.c:289
 ext4_file_write_iter+0xbe0/0x1740 fs/ext4/file.c:710
 __kernel_write_iter+0x262/0x7a0 fs/read_write.c:517
 dump_emit_page fs/coredump.c:888 [inline]
 dump_user_range+0x23c/0x710 fs/coredump.c:915
 elf_core_dump+0x277e/0x36e0 fs/binfmt_elf.c:2142
 do_coredump+0x2f2b/0x4020 fs/coredump.c:764
 get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 arch_do_signal_or_restart+0x79/0x5c0 arch/x86/kernel/signal.c:306
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
 irqentry_exit_to_user_mode+0x9/0x40 kernel/entry/common.c:310
 asm_exc_general_protection+0x26/0x30 arch/x86/include/asm/idtentry.h:564
RIP: 0033:0x7fd6b008c391
RSP: 002b:0000000020000160 EFLAGS: 00010217
RAX: 0000000000000000 RBX: 00007fd6b01abf80 RCX: 00007fd6b008c389
RDX: 0000000020000180 RSI: 0000000020000160 RDI: 0000000002000000
RBP: 00007fd6b00d7493 R08: 0000000020000200 R09: 0000000020000200
R10: 00000000200001c0 R11: 0000000000000206 R12: 0000000000000000
R13: 00007ffddfff939f R14: 00007fd6b0dfd300 R15: 0000000000022000
 </TASK>
INFO: task syz-executor.2:997 blocked for more than 148 seconds.
      Not tainted 6.4.0-rc6-syzkaller-00049-g62d8779610bb #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.2  state:D stack:23744 pid:997   ppid:24312  flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5343 [inline]
 __schedule+0xc9a/0x5880 kernel/sched/core.c:6669
 schedule+0xde/0x1a0 kernel/sched/core.c:6745
 wb_wait_for_completion+0x182/0x240 fs/fs-writeback.c:192
 __writeback_inodes_sb_nr+0x1d7/0x280 fs/fs-writeback.c:2644
 try_to_writeback_inodes_sb+0x98/0xc0 fs/fs-writeback.c:2692
 ext4_nonda_switch+0x1aa/0x1f0 fs/ext4/inode.c:2864
 ext4_da_write_begin+0x172/0x8c0 fs/ext4/inode.c:2891
 generic_perform_write+0x256/0x570 mm/filemap.c:3929
 ext4_buffered_write_iter+0x15b/0x460 fs/ext4/file.c:289
 ext4_file_write_iter+0xbe0/0x1740 fs/ext4/file.c:710
 __kernel_write_iter+0x262/0x7a0 fs/read_write.c:517
 dump_emit_page fs/coredump.c:888 [inline]
 dump_user_range+0x23c/0x710 fs/coredump.c:915
 elf_core_dump+0x277e/0x36e0 fs/binfmt_elf.c:2142
 do_coredump+0x2f2b/0x4020 fs/coredump.c:764
 get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 arch_do_signal_or_restart+0x79/0x5c0 arch/x86/kernel/signal.c:306
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
 irqentry_exit_to_user_mode+0x9/0x40 kernel/entry/common.c:310
 asm_exc_general_protection+0x26/0x30 arch/x86/include/asm/idtentry.h:564
RIP: 0033:0x7fd6b008c391
RSP: 002b:0000000020000280 EFLAGS: 00010217
RAX: 0000000000000000 RBX: 00007fd6b01abf80 RCX: 00007fd6b008c389
RDX: 00000000200002c0 RSI: 0000000020000280 RDI: 0000000000000200
RBP: 00007fd6b00d7493 R08: 0000000020000340 R09: 0000000020000340
R10: 0000000020000300 R11: 0000000000000206 R12: 0000000000000000
R13: 00007ffddfff939f R14: 00007fd6b0dfd300 R15: 0000000000022000
 </TASK>

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/13:
 #0: ffffffff8c7984b0 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x31/0xd80 kernel/rcu/tasks.h:518
1 lock held by rcu_tasks_trace/14:
 #0: ffffffff8c7981b0 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x31/0xd80 kernel/rcu/tasks.h:518
1 lock held by khungtaskd/28:
 #0: ffffffff8c7990c0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x340 kernel/locking/lockdep.c:6559
3 locks held by kworker/u4:3/46:
 #0: ffff888145672138 ((wq_completion)writeback){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888145672138 ((wq_completion)writeback){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888145672138 ((wq_completion)writeback){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1324 [inline]
 #0: ffff888145672138 ((wq_completion)writeback){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:643 [inline]
 #0: ffff888145672138 ((wq_completion)writeback){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:670 [inline]
 #0: ffff888145672138 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x883/0x15e0 kernel/workqueue.c:2376
 #1: ffffc90000b77db0 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x8b7/0x15e0 kernel/workqueue.c:2380
 #2: ffff88802c31eb98 (&sbi->s_writepages_rwsem){.+.+}-{0:0}, at: do_writepages+0x1a8/0x640 mm/page-writeback.c:2551
2 locks held by getty/4753:
 #0: ffff88802aec0098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x26/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc900015802f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xef4/0x13e0 drivers/tty/n_tty.c:2176
3 locks held by syz-executor.2/24312:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: do_unlinkat+0x190/0x680 fs/namei.c:4374
 #1: ffff88803fe02c00 (&type->i_mutex_dir_key#3/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:810 [inline]
 #1: ffff88803fe02c00 (&type->i_mutex_dir_key#3/1){+.+.}-{3:3}, at: do_unlinkat+0x280/0x680 fs/namei.c:4378
 #2: ffff888083300400 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #2: ffff888083300400 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: vfs_unlink+0xd9/0x930 fs/namei.c:4316
3 locks held by syz-executor.2/687:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 #1: ffff888082afd400 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #1: ffff888082afd400 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb0/0x460 fs/ext4/file.c:283
 #2: ffff88802c31c0e0 (&type->s_umount_key#32){++++}-{3:3}, at: try_to_writeback_inodes_sb+0x21/0xc0 fs/fs-writeback.c:2689
3 locks held by syz-executor.4/740:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 #1: ffff88808724c000 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #1: ffff88808724c000 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb0/0x460 fs/ext4/file.c:283
 #2: ffff88802c31c0e0 (&type->s_umount_key#32){++++}-{3:3}, at: try_to_writeback_inodes_sb+0x21/0xc0 fs/fs-writeback.c:2689
3 locks held by syz-executor.4/885:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 #1: ffff888046cf0400 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #1: ffff888046cf0400 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb0/0x460 fs/ext4/file.c:283
 #2: ffff88802c31c0e0 (&type->s_umount_key#32){++++}-{3:3}, at: try_to_writeback_inodes_sb+0x21/0xc0 fs/fs-writeback.c:2689
3 locks held by syz-executor.4/908:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 #1: ffff88805471a200 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #1: ffff88805471a200 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb0/0x460 fs/ext4/file.c:283
 #2: ffff88802c31c0e0 (&type->s_umount_key#32){++++}-{3:3}, at: try_to_writeback_inodes_sb+0x21/0xc0 fs/fs-writeback.c:2689
3 locks held by syz-executor.4/936:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 #1: ffff888050412c00 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #1: ffff888050412c00 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb0/0x460 fs/ext4/file.c:283
 #2: ffff88802c31c0e0 (&type->s_umount_key#32){++++}-{3:3}, at: try_to_writeback_inodes_sb+0x21/0xc0 fs/fs-writeback.c:2689
3 locks held by syz-executor.2/971:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 #1: ffff8880874e5e00 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #1: ffff8880874e5e00 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb0/0x460 fs/ext4/file.c:283
 #2: ffff88802c31c0e0 (&type->s_umount_key#32){++++}-{3:3}, at: try_to_writeback_inodes_sb+0x21/0xc0 fs/fs-writeback.c:2689
3 locks held by syz-executor.2/983:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 #1: ffff88808724b600 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #1: ffff88808724b600 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb0/0x460 fs/ext4/file.c:283
 #2: ffff88802c31c0e0 (&type->s_umount_key#32){++++}-{3:3}, at: try_to_writeback_inodes_sb+0x21/0xc0 fs/fs-writeback.c:2689
3 locks held by syz-executor.2/997:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 #1: ffff888082afca00 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #1: ffff888082afca00 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb0/0x460 fs/ext4/file.c:283
 #2: ffff88802c31c0e0 (&type->s_umount_key#32){++++}-{3:3}, at: try_to_writeback_inodes_sb+0x21/0xc0 fs/fs-writeback.c:2689
1 lock held by syz-executor.0/5907:
 #0: ffff8880546eac00 (&type->i_mutex_dir_key#3){++++}-{3:3}, at: iterate_dir+0xd1/0x6f0 fs/readdir.c:55
1 lock held by syz-executor.1/7188:
 #0: ffff888082aeb600 (&type->i_mutex_dir_key#3){++++}-{3:3}, at: iterate_dir+0xd1/0x6f0 fs/readdir.c:55
1 lock held by syz-executor.0/7562:
 #0: ffff88802c31eb98 (&sbi->s_writepages_rwsem){.+.+}-{0:0}, at: do_writepages+0x1a8/0x640 mm/page-writeback.c:2551
1 lock held by syz-executor.0/7739:
 #0: ffff88802c31eb98 (&sbi->s_writepages_rwsem){.+.+}-{0:0}, at: do_writepages+0x1a8/0x640 mm/page-writeback.c:2551
1 lock held by syz-executor.0/7802:
 #0: ffff88802c31eb98 (&sbi->s_writepages_rwsem){.+.+}-{0:0}, at: do_writepages+0x1a8/0x640 mm/page-writeback.c:2551
1 lock held by syz-executor.1/7812:
 #0: ffff88802c31eb98 (&sbi->s_writepages_rwsem){.+.+}-{0:0}, at: do_writepages+0x1a8/0x640 mm/page-writeback.c:2551
1 lock held by syz-executor.0/7827:
 #0: ffff88802c31eb98 (&sbi->s_writepages_rwsem){.+.+}-{0:0}, at: do_writepages+0x1a8/0x640 mm/page-writeback.c:2551
1 lock held by syz-executor.0/7838:
 #0: ffff88802c31eb98 (&sbi->s_writepages_rwsem){.+.+}-{0:0}, at: do_writepages+0x1a8/0x640 mm/page-writeback.c:2551
1 lock held by syz-executor.1/7856:
 #0: ffff88802c31eb98 (&sbi->s_writepages_rwsem){.+.+}-{0:0}, at: do_writepages+0x1a8/0x640 mm/page-writeback.c:2551
1 lock held by syz-executor.2/7858:
 #0: ffff88802c31eb98 (&sbi->s_writepages_rwsem){.+.+}-{0:0}, at: do_writepages+0x1a8/0x640 mm/page-writeback.c:2551
1 lock held by syz-executor.5/8636:
 #0: ffff888082aec000 (&type->i_mutex_dir_key#3){++++}-{3:3}, at: iterate_dir+0xd1/0x6f0 fs/readdir.c:55
1 lock held by syz-executor.5/8731:
 #0: ffff88802c31eb98 (&sbi->s_writepages_rwsem){.+.+}-{0:0}, at: do_writepages+0x1a8/0x640 mm/page-writeback.c:2551
1 lock held by syz-executor.5/8734:
 #0: ffff88802c31eb98 (&sbi->s_writepages_rwsem){.+.+}-{0:0}, at: do_writepages+0x1a8/0x640 mm/page-writeback.c:2551
2 locks held by syz-executor.5/8877:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 #1: ffff8880870e4000 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #1: ffff8880870e4000 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb0/0x460 fs/ext4/file.c:283
2 locks held by syz-executor.0/8885:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 #1: ffff888082f0f200 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #1: ffff888082f0f200 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb0/0x460 fs/ext4/file.c:283
2 locks held by syz-executor.1/8886:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 #1: ffff888082f0de00 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #1: ffff888082f0de00 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb0/0x460 fs/ext4/file.c:283
2 locks held by syz-executor.2/8888:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 #1: ffff888082f0a200 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #1: ffff888082f0a200 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb0/0x460 fs/ext4/file.c:283
2 locks held by syz-executor.1/8889:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 #1: ffff888082f0e800 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #1: ffff888082f0e800 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb0/0x460 fs/ext4/file.c:283
2 locks held by syz-executor.5/8890:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 #1: ffff8880870e6800 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #1: ffff8880870e6800 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb0/0x460 fs/ext4/file.c:283
2 locks held by syz-executor.0/8891:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 #1: ffff8880870e5400 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #1: ffff8880870e5400 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb0/0x460 fs/ext4/file.c:283
2 locks held by syz-executor.1/8907:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 #1: ffff888082aed400 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #1: ffff888082aed400 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb0/0x460 fs/ext4/file.c:283
2 locks held by syz-executor.1/8911:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 #1: ffff88803cddb600 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #1: ffff88803cddb600 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb0/0x460 fs/ext4/file.c:283
2 locks held by syz-executor.2/8912:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 #1: ffff888082ae8e00 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #1: ffff888082ae8e00 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb0/0x460 fs/ext4/file.c:283
2 locks held by syz-executor.5/8918:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 #1: ffff8880826e9800 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #1: ffff8880826e9800 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb0/0x460 fs/ext4/file.c:283
2 locks held by syz-executor.0/8919:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 #1: ffff88803cddca00 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #1: ffff88803cddca00 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb0/0x460 fs/ext4/file.c:283
2 locks held by syz-executor.0/8923:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 #1: ffff8880826eca00 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #1: ffff8880826eca00 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb0/0x460 fs/ext4/file.c:283
2 locks held by syz-executor.5/8924:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 #1: ffff8880826ec000 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #1: ffff8880826ec000 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb0/0x460 fs/ext4/file.c:283
3 locks held by syz-executor.2/8938:
 #0: ffff88802c31eb98 (&sbi->s_writepages_rwsem){.+.+}-{0:0}, at: do_writepages+0x1a8/0x640 mm/page-writeback.c:2551
 #1: ffff88814be58990 (jbd2_handle){++++}-{0:0}, at: start_this_handle+0xfb4/0x14e0 fs/jbd2/transaction.c:461
 #2: ffff888078e9f088 (&ei->i_data_sem){++++}-{3:3}, at: ext4_map_blocks+0x707/0x18d0 fs/ext4/inode.c:616
2 locks held by syz-executor.1/8942:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 #1: ffff888078e9de00 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #1: ffff888078e9de00 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb0/0x460 fs/ext4/file.c:283
1 lock held by syz-executor.4/8955:
 #0: ffff8880546eb600 (&type->i_mutex_dir_key#3){++++}-{3:3}, at: iterate_dir+0xd1/0x6f0 fs/readdir.c:55
1 lock held by syz-executor.0/9094:
 #0: ffff88802c31eb98 (&sbi->s_writepages_rwsem){.+.+}-{0:0}, at: do_writepages+0x1a8/0x640 mm/page-writeback.c:2551
1 lock held by syz-executor.0/9096:
 #0: ffff88802c31eb98 (&sbi->s_writepages_rwsem){.+.+}-{0:0}, at: do_writepages+0x1a8/0x640 mm/page-writeback.c:2551
1 lock held by syz-executor.3/9157:
 #0: ffff88803444e800 (&type->i_mutex_dir_key#3){++++}-{3:3}, at: iterate_dir+0xd1/0x6f0 fs/readdir.c:55
2 locks held by syz-executor.3/9599:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 #1: ffff88802fd5d400 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #1: ffff88802fd5d400 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb0/0x460 fs/ext4/file.c:283
2 locks held by syz-executor.3/9600:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 #1: ffff88802fd5ca00 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #1: ffff88802fd5ca00 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb0/0x460 fs/ext4/file.c:283
2 locks held by syz-executor.2/9619:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 #1: ffff88803e361800 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #1: ffff88803e361800 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb0/0x460 fs/ext4/file.c:283
2 locks held by syz-executor.5/9625:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 #1: ffff888046cf3600 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #1: ffff888046cf3600 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb0/0x460 fs/ext4/file.c:283
1 lock held by syz-executor.1/9626:
 #0: ffff88802c31eb98 (&sbi->s_writepages_rwsem){.+.+}-{0:0}, at: do_writepages+0x1a8/0x640 mm/page-writeback.c:2551
2 locks held by syz-executor.3/9627:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 #1: ffff88803ce98e00 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #1: ffff88803ce98e00 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb0/0x460 fs/ext4/file.c:283
2 locks held by syz-executor.4/9629:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 #1: ffff888046cf7200 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #1: ffff888046cf7200 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb0/0x460 fs/ext4/file.c:283
2 locks held by syz-executor.3/9635:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 #1: ffff88805471c000 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #1: ffff88805471c000 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb0/0x460 fs/ext4/file.c:283
2 locks held by syz-executor.5/9637:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 #1: ffff888046cf2c00 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #1: ffff888046cf2c00 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb0/0x460 fs/ext4/file.c:283
2 locks held by syz-executor.0/9640:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 #1: ffff88805471d400 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #1: ffff88805471d400 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb0/0x460 fs/ext4/file.c:283
1 lock held by syz-executor.2/9785:
 #0: ffff88802c31eb98 (&sbi->s_writepages_rwsem){.+.+}-{0:0}, at: do_writepages+0x1a8/0x640 mm/page-writeback.c:2551
1 lock held by syz-executor.0/9790:
 #0: ffff88802c31eb98 (&sbi->s_writepages_rwsem){.+.+}-{0:0}, at: do_writepages+0x1a8/0x640 mm/page-writeback.c:2551
1 lock held by syz-executor.1/9795:
 #0: ffff88802c31eb98 (&sbi->s_writepages_rwsem){.+.+}-{0:0}, at: do_writepages+0x1a8/0x640 mm/page-writeback.c:2551
1 lock held by syz-executor.1/9796:
 #0: ffff88802c31eb98 (&sbi->s_writepages_rwsem){.+.+}-{0:0}, at: do_writepages+0x1a8/0x640 mm/page-writeback.c:2551
1 lock held by syz-executor.0/9797:
 #0: ffff88802c31eb98 (&sbi->s_writepages_rwsem){.+.+}-{0:0}, at: do_writepages+0x1a8/0x640 mm/page-writeback.c:2551
1 lock held by syz-executor.0/9806:
 #0: ffff88802c31eb98 (&sbi->s_writepages_rwsem){.+.+}-{0:0}, at: do_writepages+0x1a8/0x640 mm/page-writeback.c:2551
1 lock held by syz-executor.0/9807:
 #0: ffff88802c31eb98 (&sbi->s_writepages_rwsem){.+.+}-{0:0}, at: do_writepages+0x1a8/0x640 mm/page-writeback.c:2551
1 lock held by syz-executor.1/9815:
 #0: ffff88802c31eb98 (&sbi->s_writepages_rwsem){.+.+}-{0:0}, at: do_writepages+0x1a8/0x640 mm/page-writeback.c:2551
1 lock held by syz-executor.1/9819:
 #0: ffff88802c31eb98 (&sbi->s_writepages_rwsem){.+.+}-{0:0}, at: do_writepages+0x1a8/0x640 mm/page-writeback.c:2551
1 lock held by syz-executor.2/9829:
 #0: ffff88802c31eb98 (&sbi->s_writepages_rwsem){.+.+}-{0:0}, at: do_writepages+0x1a8/0x640 mm/page-writeback.c:2551
1 lock held by syz-executor.1/9847:
 #0: ffff88802c31eb98 (&sbi->s_writepages_rwsem){.+.+}-{0:0}, at: do_writepages+0x1a8/0x640 mm/page-writeback.c:2551
1 lock held by syz-executor.2/9852:
 #0: ffff88802c31eb98 (&sbi->s_writepages_rwsem){.+.+}-{0:0}, at: do_writepages+0x1a8/0x640 mm/page-writeback.c:2551
2 locks held by syz-executor.4/9858:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 #1: ffff888087255400 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #1: ffff888087255400 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb0/0x460 fs/ext4/file.c:283
2 locks held by syz-executor.4/9861:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 #1: ffff88803e364a00 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #1: ffff88803e364a00 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb0/0x460 fs/ext4/file.c:283
2 locks held by syz-executor.3/9863:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 #1: ffff88803e367200 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #1: ffff88803e367200 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb0/0x460 fs/ext4/file.c:283
2 locks held by syz-executor.3/9866:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 #1: ffff88802fd5ac00 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #1: ffff88802fd5ac00 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb0/0x460 fs/ext4/file.c:283
2 locks held by syz-executor.5/9869:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 #1: ffff88802fd5a200 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #1: ffff88802fd5a200 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb0/0x460 fs/ext4/file.c:283
2 locks held by syz-executor.4/9873:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 #1: ffff888082afc000 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #1: ffff888082afc000 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb0/0x460 fs/ext4/file.c:283
2 locks held by syz-executor.5/9875:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 #1: ffff88803450ac00 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #1: ffff88803450ac00 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb0/0x460 fs/ext4/file.c:283
2 locks held by syz-executor.4/9879:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 #1: ffff888082af8e00 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #1: ffff888082af8e00 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb0/0x460 fs/ext4/file.c:283
2 locks held by syz-executor.0/9883:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 #1: ffff888082b4b600 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #1: ffff888082b4b600 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb0/0x460 fs/ext4/file.c:283
2 locks held by syz-executor.1/9884:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 #1: ffff888082b4ac00 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #1: ffff888082b4ac00 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb0/0x460 fs/ext4/file.c:283
2 locks held by syz-executor.3/9888:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 #1: ffff888082b48400 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #1: ffff888082b48400 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb0/0x460 fs/ext4/file.c:283
2 locks held by syz-executor.1/9889:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 #1: ffff888082b4d400 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #1: ffff888082b4d400 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb0/0x460 fs/ext4/file.c:283
2 locks held by syz-executor.0/9891:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 #1: ffff888082afac00 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #1: ffff888082afac00 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb0/0x460 fs/ext4/file.c:283
2 locks held by syz-executor.3/9894:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 #1: ffff888082b4a200 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #1: ffff888082b4a200 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb0/0x460 fs/ext4/file.c:283
2 locks held by syz-executor.3/9899:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 #1: ffff8880546eca00 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #1: ffff8880546eca00 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb0/0x460 fs/ext4/file.c:283
2 locks held by syz-executor.4/9905:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 #1: ffff8880546e8400 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #1: ffff8880546e8400 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb0/0x460 fs/ext4/file.c:283
2 locks held by syz-executor.0/9906:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 #1: ffff88803fe01800 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #1: ffff88803fe01800 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb0/0x460 fs/ext4/file.c:283
2 locks held by syz-executor.1/9911:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 #1: ffff88803fe00400 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #1: ffff88803fe00400 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb0/0x460 fs/ext4/file.c:283
2 locks held by syz-executor.2/9912:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 #1: ffff8880546e9800 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #1: ffff8880546e9800 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb0/0x460 fs/ext4/file.c:283
2 locks held by syz-executor.4/9930:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 #1: ffff888033322c00 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #1: ffff888033322c00 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb0/0x460 fs/ext4/file.c:283
2 locks held by syz-executor.2/9931:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 #1: ffff888083300400 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #1: ffff888083300400 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb0/0x460 fs/ext4/file.c:283
2 locks held by syz-executor.3/9937:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 #1: ffff888033326800 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #1: ffff888033326800 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb0/0x460 fs/ext4/file.c:283
2 locks held by syz-executor.0/9938:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 #1: ffff888033325400 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #1: ffff888033325400 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb0/0x460 fs/ext4/file.c:283
2 locks held by syz-executor.1/9939:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 #1: ffff8880874e6800 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #1: ffff8880874e6800 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb0/0x460 fs/ext4/file.c:283
2 locks held by syz-executor.5/9940:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: get_signal+0x1c02/0x25b0 kernel/signal.c:2862
 #1: ffff8880874e0400 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #1: ffff8880874e0400 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xb0/0x460 fs/ext4/file.c:283
3 locks held by syz-executor.4/9942:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: do_unlinkat+0x190/0x680 fs/namei.c:4374
 #1: ffff8880546eb600 (&type->i_mutex_dir_key#3/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:810 [inline]
 #1: ffff8880546eb600 (&type->i_mutex_dir_key#3/1){+.+.}-{3:3}, at: do_unlinkat+0x280/0x680 fs/namei.c:4378
 #2: ffff888033322c00 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #2: ffff888033322c00 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: vfs_unlink+0xd9/0x930 fs/namei.c:4316
3 locks held by syz-executor.1/9943:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: do_unlinkat+0x190/0x680 fs/namei.c:4374
 #1: ffff888082aeb600 (&type->i_mutex_dir_key#3/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:810 [inline]
 #1: ffff888082aeb600 (&type->i_mutex_dir_key#3/1){+.+.}-{3:3}, at: do_unlinkat+0x280/0x680 fs/namei.c:4378
 #2: ffff8880874e6800 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #2: ffff8880874e6800 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: vfs_unlink+0xd9/0x930 fs/namei.c:4316
3 locks held by syz-executor.3/9945:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: do_unlinkat+0x190/0x680 fs/namei.c:4374
 #1: ffff88803444e800 (&type->i_mutex_dir_key#3/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:810 [inline]
 #1: ffff88803444e800 (&type->i_mutex_dir_key#3/1){+.+.}-{3:3}, at: do_unlinkat+0x280/0x680 fs/namei.c:4378
 #2: ffff888033326800 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #2: ffff888033326800 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: vfs_unlink+0xd9/0x930 fs/namei.c:4316
3 locks held by syz-executor.0/9948:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: do_unlinkat+0x190/0x680 fs/namei.c:4374
 #1: ffff8880546eac00 (&type->i_mutex_dir_key#3/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:810 [inline]
 #1: ffff8880546eac00 (&type->i_mutex_dir_key#3/1){+.+.}-{3:3}, at: do_unlinkat+0x280/0x680 fs/namei.c:4378
 #2: ffff888033325400 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #2: ffff888033325400 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: vfs_unlink+0xd9/0x930 fs/namei.c:4316
3 locks held by syz-executor.5/9949:
 #0: ffff88802c31c460 (sb_writers#4){.+.+}-{0:0}, at: do_unlinkat+0x190/0x680 fs/namei.c:4374
 #1: ffff888082aec000 (&type->i_mutex_dir_key#3/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:810 [inline]
 #1: ffff888082aec000 (&type->i_mutex_dir_key#3/1){+.+.}-{3:3}, at: do_unlinkat+0x280/0x680 fs/namei.c:4378
 #2: ffff8880874e0400 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #2: ffff8880874e0400 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: vfs_unlink+0xd9/0x930 fs/namei.c:4316

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 28 Comm: khungtaskd Not tainted 6.4.0-rc6-syzkaller-00049-g62d8779610bb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x29c/0x350 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x2a4/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:148 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xe16/0x1090 kernel/hung_task.c:379
 kthread+0x344/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 68 Comm: kworker/u4:4 Not tainted 6.4.0-rc6-syzkaller-00049-g62d8779610bb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Workqueue: phy90 ieee80211_iface_work
RIP: 0010:lookup_chain_cache kernel/locking/lockdep.c:3740 [inline]
RIP: 0010:lookup_chain_cache_add kernel/locking/lockdep.c:3760 [inline]
RIP: 0010:validate_chain kernel/locking/lockdep.c:3815 [inline]
RIP: 0010:__lock_acquire+0x19cb/0x5f30 kernel/locking/lockdep.c:5088
Code: 08 49 c1 ec 2f 84 c0 4e 8d 2c e5 60 2c 41 91 0f 84 c2 03 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 ea 48 c1 ea 03 80 3c 02 00 <0f> 85 53 3d 00 00 4a 8b 1c e5 60 2c 41 91 48 85 db 74 63 48 83 eb
RSP: 0018:ffffc900020af840 EFLAGS: 00000046
RAX: dffffc0000000000 RBX: 0000000000000001 RCX: ffffffff81659797
RDX: 1ffffffff228d43e RSI: 0000000000000008 RDI: ffffffff9152ad00
RBP: ffff888019af8000 R08: 0000000000000000 R09: ffffffff9152ad07
R10: fffffbfff22a55a0 R11: 0000000000094001 R12: 000000000000aeb2
R13: ffffffff9146a1f0 R14: 0000000000000000 R15: ffff888019af8b18
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555556a55848 CR3: 000000002994d000 CR4: 0000000000350ef0
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 lock_acquire kernel/locking/lockdep.c:5705 [inline]
 lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5670
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x3d/0x60 kernel/locking/spinlock.c:162
 __debug_check_no_obj_freed lib/debugobjects.c:1011 [inline]
 debug_check_no_obj_freed+0xcb/0x420 lib/debugobjects.c:1054
 slab_free_hook mm/slub.c:1756 [inline]
 slab_free_freelist_hook+0xeb/0x1c0 mm/slub.c:1807
 slab_free mm/slub.c:3786 [inline]
 kmem_cache_free+0xe9/0x480 mm/slub.c:3808
 skb_kfree_head net/core/skbuff.c:903 [inline]
 skb_kfree_head net/core/skbuff.c:899 [inline]
 skb_free_head+0x17f/0x1b0 net/core/skbuff.c:918
 skb_release_data+0x598/0x820 net/core/skbuff.c:948
 skb_release_all net/core/skbuff.c:1014 [inline]
 __kfree_skb net/core/skbuff.c:1028 [inline]
 kfree_skb_reason+0x179/0x3c0 net/core/skbuff.c:1064
 kfree_skb include/linux/skbuff.h:1236 [inline]
 ieee80211_iface_work+0x357/0xd70 net/mac80211/iface.c:1650
 process_one_work+0x99a/0x15e0 kernel/workqueue.c:2405
 worker_thread+0x67d/0x10c0 kernel/workqueue.c:2552
 kthread+0x344/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
