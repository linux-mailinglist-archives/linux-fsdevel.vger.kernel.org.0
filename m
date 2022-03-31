Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2EB4ED371
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 07:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiCaFsy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 01:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiCaFsx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 01:48:53 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BF3158D93
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Mar 2022 22:47:06 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id e4so24291388oif.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Mar 2022 22:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cd8FXs0SUHHHShQeIo71F8NT68NeMdM7PCHA4k8w2kY=;
        b=faOLTN/PcaeFtYSEaXGEuUQFrA/Rb6qM808Pl72RMKEHVzFjjJTXVW3mDyWMvyrCEb
         dM8MR9s3jRXga7ehM3rUP/IAr+oaDwGIOhhoM5rBiQX7GqXQOn1pHCVcPwyTYwABmNdQ
         YmkY90JYYeLJB4txoRPTuhS5WsNSCgNyY1srTYmbQdJ+IDp6ySzzUUmcPgRg/YZdEWU2
         rEY9YVuwhxgrGYvs7IV1Jx/4aKmc+ulsSWD/WG7VeFBn3R1BUnL5aSiQPePfG1IQ+XnJ
         ke0Dqq4nsH8bpbSbh4owr6wbG2/VZeTFulbxPwuy4LRlTGumglGtym9NdZa7fHqVBSzq
         JVjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cd8FXs0SUHHHShQeIo71F8NT68NeMdM7PCHA4k8w2kY=;
        b=CaXcHS6ItlbPnv1g5cstA7aZjeHpBXCMNyfvcRgu41440Z2fwgz9k5+cnMlZfseZZo
         /Z6UIiFaUJEOPg6ltigfAsZ/Z3zZqTTHYHj16L2n5YgHsnDojieKyDH9e2SUhhWGjEAA
         Xkmtq0kHz2k0Z0nHfy00DOIVdYz87/uPTr7htggkdlvJEd56k1pvlmqJ+RZFOvt2Ku+3
         JJnQ/g0xCjbCKO3C73Yh/EQHDl6uNqA0KG0LzUcu0NUmeUZCIIS1PMriLM0I88ojDN8M
         K/pRmcbAy1KG+kx6iEHoTtlNOQdqIk5RQQnF04M4t9PsmNqk37gNBjru1QlumCLJEUwa
         yRnw==
X-Gm-Message-State: AOAM530V+HgGMvyvNv+uXduhQlUSR8QM3+SBT8wHGSCAVN0z9Uwu8a/7
        fYBnJl84JBydwphEtJsKThxvtXvMKeSYroOtUgrlYA==
X-Google-Smtp-Source: ABdhPJx/ihLJwcQTI82+SBKrUE0mhLn7mZ6yQYg6LSzv4Iqryihos0bRPyNE3Q69HBqkMHcjHJW7MFSGg5DClSlt67k=
X-Received: by 2002:a05:6808:16a4:b0:2f7:1fd1:f48 with SMTP id
 bb36-20020a05680816a400b002f71fd10f48mr2021655oib.163.1648705625840; Wed, 30
 Mar 2022 22:47:05 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000b4802405db731170@google.com>
In-Reply-To: <000000000000b4802405db731170@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 31 Mar 2022 07:46:54 +0200
Message-ID: <CACT4Y+Yw3agMNYeWB2QMHfnFtQKbq0T3iQK6YMmGapF2kjBp=Q@mail.gmail.com>
Subject: Re: [syzbot] BUG: scheduling while atomic: syz-fuzzer/NUM/ADDR
To:     syzbot <syzbot+4631483f85171c561f39@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 30 Mar 2022 at 19:42, syzbot
<syzbot+4631483f85171c561f39@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    f022814633e1 Merge tag 'trace-v5.18-1' of git://git.kernel..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1511883d700000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2f78c0e92b7fea54
> dashboard link: https://syzkaller.appspot.com/bug?extid=4631483f85171c561f39
> compiler:       aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: arm64

The same as:
#syz dup: BUG: scheduling while atomic in simple_recursive_removal

This only happens on arm32/64 instances.


> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+4631483f85171c561f39@syzkaller.appspotmail.com
>
> BUG: scheduling while atomic: syz-fuzzer/2188/0x00000101
> Modules linked in:
> CPU: 0 PID: 2188 Comm: syz-fuzzer Not tainted 5.17.0-syzkaller-11138-gf022814633e1 #0
> Hardware name: linux,dummy-virt (DT)
> Call trace:
>  dump_backtrace.part.0+0xcc/0xe0 arch/arm64/kernel/stacktrace.c:184
>  dump_backtrace arch/arm64/kernel/stacktrace.c:190 [inline]
>  show_stack+0x18/0x6c arch/arm64/kernel/stacktrace.c:191
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x68/0x84 lib/dump_stack.c:106
>  dump_stack+0x18/0x34 lib/dump_stack.c:113
>  __schedule_bug+0x60/0x80 kernel/sched/core.c:5617
>  schedule_debug kernel/sched/core.c:5644 [inline]
>  __schedule+0x74c/0x7f0 kernel/sched/core.c:6273
>  schedule+0x54/0xd0 kernel/sched/core.c:6454
>  rwsem_down_write_slowpath+0x29c/0x5a0 kernel/locking/rwsem.c:1142
>  __down_write_common kernel/locking/rwsem.c:1259 [inline]
>  __down_write_common kernel/locking/rwsem.c:1256 [inline]
>  __down_write kernel/locking/rwsem.c:1268 [inline]
>  down_write+0x58/0x64 kernel/locking/rwsem.c:1515
>  inode_lock include/linux/fs.h:777 [inline]
>  simple_recursive_removal+0x124/0x270 fs/libfs.c:288
>  debugfs_remove fs/debugfs/inode.c:732 [inline]
>  debugfs_remove+0x5c/0x80 fs/debugfs/inode.c:726
>  blk_release_queue+0x7c/0xf0 block/blk-sysfs.c:784
>  kobject_cleanup lib/kobject.c:705 [inline]
>  kobject_release lib/kobject.c:736 [inline]
>  kref_put include/linux/kref.h:65 [inline]
>  kobject_put+0x98/0x114 lib/kobject.c:753
>  blk_put_queue+0x14/0x20 block/blk-core.c:270
>  blkg_free.part.0+0x54/0x80 block/blk-cgroup.c:86
>  blkg_free block/blk-cgroup.c:78 [inline]
>  __blkg_release+0x44/0x70 block/blk-cgroup.c:102
>  rcu_do_batch kernel/rcu/tree.c:2535 [inline]
>  rcu_core+0x324/0x590 kernel/rcu/tree.c:2786
>  rcu_core_si+0x10/0x20 kernel/rcu/tree.c:2803
>  _stext+0x124/0x2a0
>  do_softirq_own_stack include/asm-generic/softirq_stack.h:10 [inline]
>  invoke_softirq kernel/softirq.c:439 [inline]
>  __irq_exit_rcu+0xe4/0x100 kernel/softirq.c:637
>  irq_exit_rcu+0x10/0x1c kernel/softirq.c:649
>  el0_interrupt+0x6c/0x104 arch/arm64/kernel/entry-common.c:693
>  __el0_irq_handler_common+0x18/0x2c arch/arm64/kernel/entry-common.c:700
>  el0t_64_irq_handler+0x10/0x20 arch/arm64/kernel/entry-common.c:705
>  el0t_64_irq+0x198/0x19c arch/arm64/kernel/entry.S:582
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 13 at kernel/rcu/tree.c:2592 rcu_do_batch kernel/rcu/tree.c:2592 [inline]
> WARNING: CPU: 0 PID: 13 at kernel/rcu/tree.c:2592 rcu_core+0x4d4/0x590 kernel/rcu/tree.c:2786
> Modules linked in:
> CPU: 0 PID: 13 Comm: ksoftirqd/0 Tainted: G        W         5.17.0-syzkaller-11138-gf022814633e1 #0
> Hardware name: linux,dummy-virt (DT)
> pstate: a04000c9 (NzCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : rcu_do_batch kernel/rcu/tree.c:2592 [inline]
> pc : rcu_core+0x4d4/0x590 kernel/rcu/tree.c:2786
> lr : rcu_do_batch kernel/rcu/tree.c:2572 [inline]
> lr : rcu_core+0x38c/0x590 kernel/rcu/tree.c:2786
> sp : ffff80000a69bd00
> x29: ffff80000a69bd00 x28: ffff800008121498 x27: 0000000000000000
> x26: 000000000000000a x25: fffffffffffffffd x24: ffff80000a69bd60
> x23: ffff80000a36cc00 x22: ffff00007fbc39b8 x21: 0000000000000000
> x20: ffff00007fbc3940 x19: 0000000000000000 x18: 0000000000000014
> x17: ffff800075981000 x16: ffff800008004000 x15: 000002fbb92ae146
> x14: 00000000000000c7 x13: 00000000000000c7 x12: ffff800009e7d710
> x11: ffff80000a25fee8 x10: ffff800075981000 x9 : 5759a1e949bd4693
> x8 : ffff8000080102a0 x7 : ffff80000a69b9e4 x6 : 00000000002e47d8
> x5 : f1ff00002157a500 x4 : ffff00007fbc75a0 x3 : 00000000002e47e0
> x2 : 0000000000002710 x1 : ffffffffffffd8f0 x0 : 0000000000000001
> Call trace:
>  rcu_do_batch kernel/rcu/tree.c:2592 [inline]
>  rcu_core+0x4d4/0x590 kernel/rcu/tree.c:2786
>  rcu_core_si+0x10/0x20 kernel/rcu/tree.c:2803
>  _stext+0x124/0x2a0
>  run_ksoftirqd+0x4c/0x60 kernel/softirq.c:921
>  smpboot_thread_fn+0x23c/0x270 kernel/smpboot.c:164
>  kthread+0x108/0x10c kernel/kthread.c:376
>  ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:867
> ---[ end trace 0000000000000000 ]---
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000b4802405db731170%40google.com.
