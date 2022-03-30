Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9CD4ECAD7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 19:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiC3RjJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 13:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349355AbiC3RjI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 13:39:08 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD352C6808
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Mar 2022 10:37:22 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id g16-20020a05660226d000b00638d8e1828bso14886957ioo.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Mar 2022 10:37:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=PH06CLYLNtDuJaUnGCG4ZMntweeLF8hwfojOH0wrh9c=;
        b=DAoiD+MP8a3aNUWeCAspoGy+Ef8+TL5s9H9Q1Hvh8iJqx5uHdxod9dPmipw17iYLYV
         Tc852Tc+KggqJPN5cSRK2xBzsdsohmLj4FV5v8dYOvx3/tlfZ8SenV6hvKV1HCKcyE+G
         mncTPy0dlV5oD3J6Ipb3B7eO8Td/ZnpHQ9Zqnc8mVgRsH2vWnEXcsXdZfFeBBqgmfvkZ
         Lw8aEKLa817k5JH24GqIak8rqW1hp9rhWGYZhoybtfqdHlQ9yezxgTh9uqnBhnnv60U/
         VlyixCGmewEjwYWqJIeiFHlj3RU/egvfZ29/A5BzGf42324VdPhlN166TmFqZN0sVlwZ
         3K6Q==
X-Gm-Message-State: AOAM532eAfKosB5CFpZScWwM2EtzekNw87uujLUfrbLZrDe3DU4eTcLe
        dY+848ZeyPiBRKx20puCgHT8nR56L+UQA1udqLhzEWZ7Hxhy
X-Google-Smtp-Source: ABdhPJw7Tr8nja4VuZqAAahGQuc2mos7zYzH9Fqn2+fSTiKylJOd2r8BbaRiIdC80dgpqVJQDK5umunEXktzF+kw+mur/NDqEyCX
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c4e:b0:648:c654:fb0c with SMTP id
 x14-20020a0566022c4e00b00648c654fb0cmr12553577iov.137.1648661842190; Wed, 30
 Mar 2022 10:37:22 -0700 (PDT)
Date:   Wed, 30 Mar 2022 10:37:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007564ac05db72ff58@google.com>
Subject: [syzbot] BUG: scheduling while atomic in simple_recursive_removal
From:   syzbot <syzbot+2778a29e60b4982065a0@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
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

HEAD commit:    d888c83fcec7 fs: fix fd table size alignment properly
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=103e7b53700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cadd7063134e07bc
dashboard link: https://syzkaller.appspot.com/bug?extid=2778a29e60b4982065a0
compiler:       aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2778a29e60b4982065a0@syzkaller.appspotmail.com

BUG: scheduling while atomic: syz-executor.0/2197/0x00000101
Modules linked in:
CPU: 0 PID: 2197 Comm: syz-executor.0 Not tainted 5.17.0-syzkaller-13034-gd888c83fcec7 #0
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
 inode_lock include/linux/fs.h:777 [inline]
 simple_recursive_removal+0x124/0x270 fs/libfs.c:288
 debugfs_remove fs/debugfs/inode.c:742 [inline]
 debugfs_remove+0x5c/0x80 fs/debugfs/inode.c:736
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
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:436 [inline]
 ____kasan_kmalloc mm/kasan/common.c:515 [inline]
 ____kasan_kmalloc mm/kasan/common.c:474 [inline]
 __kasan_kmalloc+0xb0/0xd0 mm/kasan/common.c:524
 kasan_kmalloc include/linux/kasan.h:234 [inline]
 kmem_cache_alloc_node_trace include/linux/slab.h:488 [inline]
 kmalloc_node include/linux/slab.h:599 [inline]
 kzalloc_node include/linux/slab.h:725 [inline]
 __get_vm_area_node.constprop.0+0xf8/0x224 mm/vmalloc.c:2459
 __vmalloc_node_range+0xa4/0x5c0 mm/vmalloc.c:3132
 __vmalloc_node mm/vmalloc.c:3237 [inline]
 vzalloc+0x74/0x90 mm/vmalloc.c:3307
 do_ip6t_get_ctl+0x290/0x4d0 net/ipv6/netfilter/ip6_tables.c:817
 nf_getsockopt+0x60/0x8c net/netfilter/nf_sockopt.c:116
 ipv6_getsockopt+0x140/0x1c4 net/ipv6/ipv6_sockglue.c:1504
 tcp_getsockopt+0x20/0x50 net/ipv4/tcp.c:4295
 sock_common_getsockopt+0x1c/0x30 net/core/sock.c:3478
 __sys_getsockopt+0xa4/0x214 net/socket.c:2224
 __do_sys_getsockopt net/socket.c:2239 [inline]
 __se_sys_getsockopt net/socket.c:2236 [inline]
 __arm64_sys_getsockopt+0x28/0x3c net/socket.c:2236
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
