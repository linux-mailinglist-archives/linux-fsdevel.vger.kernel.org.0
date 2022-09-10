Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7BC5B44DA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Sep 2022 09:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiIJHGa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Sep 2022 03:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbiIJHG2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Sep 2022 03:06:28 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B968A50E2
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Sep 2022 00:06:27 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id h9-20020a056e021b8900b002f19c2a1836so2847362ili.23
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Sep 2022 00:06:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=XP1LI8NcKR+9TVUxI4qqPfuHZdM2tMsbF2kgKFjeSss=;
        b=UWTLTRoRw4it2H0O4bCrLFrLrjYP3klSlg21LhhhYqFOBSNsyBbXJ8V2qhdeIPfxAz
         EF+KobUXQwQsp7w++ZVdv1i1tyAkZxKLs3RE+cMkpbSa7DUzRSjvUmW429SlUz0LxiGi
         aYrzkD1M1acukxv4T+1kgntaDwg9xOcIKlNA1GQZsgKcsCzktivfrXclc9hWq+Q4j9E8
         P4isqMXuALI3vhGXprrYH3NbLehnR1UZDJ6XdEwZ35xoki5sVPtjOup+D0G1AHIS6W+v
         xvNWhlH3wirInUvaEFZlKiinyMCCbRmvXHrB2Is97RiHlI67359OuAUGJipUC45kUF+u
         Prcw==
X-Gm-Message-State: ACgBeo1Prgqg1mUrgeTbVXpLUYDTA5JfwQnR8yPyqZwfbhdr7Pb+NRo+
        NcqNXBDm+GHcIbhKc88BfLdjx7R9mMgGnBRROYMwKd4aiIMy
X-Google-Smtp-Source: AA6agR67gVP7MlrDhVaHS9c4FIkpzJwKgUpUNVTNDZdE0CQtoKI+V5pi0hvdqXsvcVXHYTh8cegg//vFgM8fXPsV5xMG8Bx2fsb4
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1493:b0:34c:d98:e49c with SMTP id
 j19-20020a056638149300b0034c0d98e49cmr8963836jak.86.1662793586979; Sat, 10
 Sep 2022 00:06:26 -0700 (PDT)
Date:   Sat, 10 Sep 2022 00:06:26 -0700
In-Reply-To: <0000000000002709ae05e5b6474c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001639b405e84d4d31@google.com>
Subject: Re: [syzbot] INFO: task hung in __filemap_get_folio
From:   syzbot <syzbot+0e9dc403e57033a74b1d@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    e47eb90a0a9a Add linux-next specific files for 20220901
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12e05825080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7933882276523081
dashboard link: https://syzkaller.appspot.com/bug?extid=0e9dc403e57033a74b1d
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=116a3953080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0e9dc403e57033a74b1d@syzkaller.appspotmail.com

INFO: task syz-executor.3:5563 blocked for more than 143 seconds.
      Not tainted 6.0.0-rc3-next-20220901-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.3  state:D
 stack:26944 pid:5563  ppid:3713   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5197 [inline]
 __schedule+0xae5/0x52c0 kernel/sched/core.c:6509
 schedule+0xda/0x1b0 kernel/sched/core.c:6585
 io_schedule+0xba/0x130 kernel/sched/core.c:8729
 folio_wait_bit_common+0x49f/0xa20 mm/filemap.c:1295
 __folio_lock mm/filemap.c:1658 [inline]
 folio_lock include/linux/pagemap.h:939 [inline]
 folio_lock include/linux/pagemap.h:935 [inline]
 __filemap_get_folio+0xc6d/0xed0 mm/filemap.c:1930
 truncate_inode_pages_range+0x37c/0x1510 mm/truncate.c:378
 ntfs_evict_inode+0x16/0xa0 fs/ntfs3/inode.c:1741
 evict+0x2ed/0x6b0 fs/inode.c:666
 iput_final fs/inode.c:1749 [inline]
 iput.part.0+0x55d/0x810 fs/inode.c:1775
 iput+0x58/0x70 fs/inode.c:1765
 ntfs_fill_super+0x2309/0x37f0 fs/ntfs3/super.c:1278
 get_tree_bdev+0x440/0x760 fs/super.c:1323
 vfs_get_tree+0x89/0x2f0 fs/super.c:1530
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x1326/0x1e20 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f62c488a8fa
RSP: 002b:00007fff05d56558 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007f62c488a8fa
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007fff05d565b0
RBP: 00007fff05d565f0 R08: 00007fff05d565f0 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000020000000
R13: 0000000020000100 R14: 00007fff05d565b0 R15: 000000002007aa80
 </TASK>
NMI backtrace for cpu 1
CPU: 1 PID: 28 Comm: khungtaskd Not tainted 6.0.0-rc3-next-20220901-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 nmi_cpu_backtrace.cold+0x46/0x14f lib/nmi_backtrace.c:111
 nmi_trigger_cpumask_backtrace+0x206/0x250 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:148 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:227 [inline]
 watchdog+0xcf7/0xfd0 kernel/hung_task.c:384
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 2973 Comm: udevd Not tainted 6.0.0-rc3-next-20220901-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
RIP: 0033:0x7f2aff58ebf8
Code: f8 c5 fa 7e 0f c5 fa 7e 16 c5 e9 74 d1 c5 f9 d7 c2 2d ff ff 00 00 0f 85 06 ff ff ff c3 0f 1f 44 00 00 c5 fa 6f 16 c5 e9 74 17 <c5> f9 d7 c2 2d ff ff 00 00 0f 85 e9 fe ff ff 48 8d 7c 17 f0 48 8d
RSP: 002b:00007fff5dda79e8 EFLAGS: 00000206
RAX: 0000000000000007 RBX: 000055e68d0e4a70 RCX: 0000000000000000
RDX: 000000000000001c RSI: 000055e68d0e44b4 RDI: 000055e68cdc2e44
RBP: 000055e68cdc3380 R08: 000000000000001c R09: 000000000000001c
R10: 0000000000000002 R11: 0000000000000020 R12: 0000000000003a94
R13: 0000000000000703 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f2aff8ae840 GS:  0000000000000000

