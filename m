Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C1E4E81B9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Mar 2022 16:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbiCZPF7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Mar 2022 11:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiCZPF5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Mar 2022 11:05:57 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435E31EEF6
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Mar 2022 08:04:20 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id f7-20020a056602088700b00645ebbe277cso6975958ioz.22
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Mar 2022 08:04:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=EYEZxr3xgNJFrDST+od/u3rZ+S63Fdq6kvjuDpHy6dY=;
        b=X3O8EfVAOedCQyBjkI8vhDQJ8owLRSF6YlIhg5eMMj+z/Z29xfyo/qlc/a1HyNrs31
         BDN8xMQLBnG0nOgYhsolBxJo9eHSR9jFHYI6xvgxziYv0rbfiswqBbLBagNNPDKoyEx4
         5L78RrK3ToB9gPQOTM8YMrpL7t2LFMLRXGr5s+w1uikUU3rRwPTQ7r+isbwSaS+L9hOj
         5dOIGoU7MkzUKsUTsvyY1BFeu1rRhSYXeVJG4BPiblLVvzrH5Nv6x1Yf74GfP2dpjbD6
         Yhubrju4GlUl/tXcX9DtG1K/AzQaqYb36EKnQf3fif+PpsHrTEhH1DLvuwkFEHxq10kB
         S+/g==
X-Gm-Message-State: AOAM533xmWBLg+SHOKQ2NFjoEaMmabBZWOpRy+ERIdFzkOD94EtKYUe+
        p6zvA97uJ3uCIwnevQcO/YqSl3x29cYiBcwPiAQdgV1PD/Dm
X-Google-Smtp-Source: ABdhPJwQxwbCI6pbXOEyJFxDsCns7Me89ZFWgsWFBdW6hq4uSvgbQ4DnHeLx4gIDxFUJgR8gwdip3XRGK5S0I1viXlhhIRBElN7k
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20e9:b0:2c1:d845:1290 with SMTP id
 q9-20020a056e0220e900b002c1d8451290mr1795589ilv.226.1648307059608; Sat, 26
 Mar 2022 08:04:19 -0700 (PDT)
Date:   Sat, 26 Mar 2022 08:04:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c4d02e05db206428@google.com>
Subject: [syzbot] BUG: scheduling while atomic: syz-executor/ADDR (2)
From:   syzbot <syzbot+baf0286916837266ff0e@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    cb7cbaae7fd9 Merge tag 'drm-next-2022-03-25' of git://anon..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=135a5bed700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9e6050011f4821d6
dashboard link: https://syzkaller.appspot.com/bug?extid=baf0286916837266ff0e
compiler:       aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+baf0286916837266ff0e@syzkaller.appspotmail.com

BUG: scheduling while atomic: syz-executor.1/23656/0x00000101
Modules linked in:
CPU: 1 PID: 23656 Comm: syz-executor.1 Not tainted 5.17.0-syzkaller-10734-gcb7cbaae7fd9 #0
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace.part.0+0xcc/0xe0 arch/arm64/kernel/stacktrace.c:184
 dump_backtrace arch/arm64/kernel/stacktrace.c:190 [inline]
 show_stack+0x18/0x6c arch/arm64/kernel/stacktrace.c:191
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x68/0x84 lib/dump_stack.c:106
 dump_stack+0x18/0x34 lib/dump_stack.c:113
 __schedule_bug+0x60/0x80 kernel/sched/core.c:5617
 schedule_debug kernel/sched/core.c:5644 [inline]
 __schedule+0x74c/0x7f0 kernel/sched/core.c:6273
 schedule+0x54/0xd0 kernel/sched/core.c:6454
 rwsem_down_write_slowpath+0x29c/0x5a0 kernel/locking/rwsem.c:1142
 __down_write_common kernel/locking/rwsem.c:1259 [inline]
 __down_write_common kernel/locking/rwsem.c:1256 [inline]
 __down_write kernel/locking/rwsem.c:1268 [inline]
 down_write+0x58/0x64 kernel/locking/rwsem.c:1515
 inode_lock include/linux/fs.h:778 [inline]
 simple_recursive_removal+0x124/0x270 fs/libfs.c:288
 debugfs_remove fs/debugfs/inode.c:732 [inline]
 debugfs_remove+0x5c/0x80 fs/debugfs/inode.c:726
 blk_release_queue+0x7c/0xf0 block/blk-sysfs.c:784
 kobject_cleanup lib/kobject.c:705 [inline]
 kobject_release lib/kobject.c:736 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x98/0x114 lib/kobject.c:753
 blk_put_queue+0x14/0x20 block/blk-core.c:270
 blkg_free.part.0+0x54/0x80 block/blk-cgroup.c:86
 blkg_free block/blk-cgroup.c:78 [inline]
 __blkg_release+0x44/0x70 block/blk-cgroup.c:102
 rcu_do_batch kernel/rcu/tree.c:2535 [inline]
 rcu_core+0x324/0x590 kernel/rcu/tree.c:2786
 rcu_core_si+0x10/0x20 kernel/rcu/tree.c:2803
 _stext+0x124/0x2a0
 do_softirq_own_stack include/asm-generic/softirq_stack.h:10 [inline]
 invoke_softirq kernel/softirq.c:439 [inline]
 __irq_exit_rcu+0xe4/0x100 kernel/softirq.c:637
 irq_exit_rcu+0x10/0x1c kernel/softirq.c:649
 __el1_irq arch/arm64/kernel/entry-common.c:459 [inline]
 el1_interrupt+0x38/0x64 arch/arm64/kernel/entry-common.c:473
 el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:478
 el1h_64_irq+0x64/0x68 arch/arm64/kernel/entry.S:577
 walk_stackframe arch/arm64/kernel/stacktrace.c:153 [inline]
 arch_stack_walk+0x68/0x280 arch/arm64/kernel/stacktrace.c:211
 stack_trace_save+0x50/0x80 kernel/stacktrace.c:122
 kasan_save_stack+0x2c/0x5c mm/kasan/common.c:38
 kasan_set_track+0x2c/0x40 mm/kasan/common.c:45
 kasan_set_free_info+0x20/0x30 mm/kasan/tags.c:36
 ____kasan_slab_free.constprop.0+0x190/0x1e4 mm/kasan/common.c:366
 __kasan_slab_free+0x10/0x1c mm/kasan/common.c:374
 kasan_slab_free include/linux/kasan.h:200 [inline]
 slab_free_hook mm/slub.c:1728 [inline]
 slab_free_freelist_hook+0xc4/0x230 mm/slub.c:1754
 slab_free mm/slub.c:3510 [inline]
 kmem_cache_free+0xb0/0x3d4 mm/slub.c:3527
 put_io_context+0xbc/0xe0 block/blk-ioc.c:213
 exit_io_context+0xdc/0xf0 block/blk-ioc.c:229
 do_exit+0x52c/0x930 kernel/exit.c:827
 do_group_exit+0x34/0xa0 kernel/exit.c:924
 __do_sys_exit_group kernel/exit.c:935 [inline]
 __se_sys_exit_group kernel/exit.c:933 [inline]
 __arm64_sys_exit_group+0x18/0x20 kernel/exit.c:933
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xec arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x6c/0x84 arch/arm64/kernel/syscall.c:181
 el0_svc+0x44/0xb0 arch/arm64/kernel/entry-common.c:616
 el0t_64_sync_handler+0x1a4/0x1b0 arch/arm64/kernel/entry-common.c:634
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:581


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
