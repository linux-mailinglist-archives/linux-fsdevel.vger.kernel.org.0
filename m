Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 084F242D04E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 04:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhJNCWT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Oct 2021 22:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbhJNCWT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Oct 2021 22:22:19 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B319C061570;
        Wed, 13 Oct 2021 19:20:15 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id ls18-20020a17090b351200b001a00250584aso5823687pjb.4;
        Wed, 13 Oct 2021 19:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=yb83CiruD/OyUdvlseX1vGxUjmYxTTNgEzuztV5H3gM=;
        b=jXVubrfCYaT2ryYmxi10BNhuXdHSehRGDX12BPbvH1pj69i7GPF9KooTe0/6HqJZBD
         raeSZRGeMvValK+qPxnrai43RzNl7rYcBHrtGjvcpP5gKNyWzSF5vmYT8SOIL0grFJB2
         YBBy0DlvwDsx7pelJ93STk5KN6tdFcrKFaTHf8RX82rfPDFZzKsieHI5tFg9NrDTgcfK
         F8uEnqPgFKr610SGDEzJdvMV76K1F99O5WX3y7dDgksZHCRK6idc5qWZebzrGFqhaajC
         1lKh5zt7bkTBUKybvSvKsTjaeoJpXZWB3H2TsW6lI3FlJ1cACOFVZUdAeASvMbZPbv+D
         0AGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=yb83CiruD/OyUdvlseX1vGxUjmYxTTNgEzuztV5H3gM=;
        b=CtmY1t/D0iGX+ZiRqEAGB72n/ECfImzzNK0ESHRza+cclQCJmHDM4lfwVkZVZxtifC
         Z8uQHL+OSSNzenbYdTJV7S90Cy29vLuD4GENQ6qhaXdRWVFYLydNJbFjM/gDwUiovlBq
         1halL+ZYHKbaPQdyfOMrDs0wbjhcSclUJe5dV+KWbVHwystT2wwXBqj9BNXkm7dTG4NQ
         BEVqrdud4dZwhJJCgROfhFOEzfhVAzTocAm6WSRO9zvPogEGO9b2CyGXn1nIAFsMA6ip
         wPZ3XsL6v76aFQ4QA2f/V+GklDfUPRceLtYrTfHtzAqrcJ8qHfI77P0GhaGqFfU8eEYt
         mJjw==
X-Gm-Message-State: AOAM533XBh0dWdC3jG6BMbu0bLM8EtRtcJri83f5cKykc3IUSCmV8tg5
        NToVxbUxO7d5i3E1TFofN0+8x9D4r2I7F1XLlklr1tclSmb7
X-Google-Smtp-Source: ABdhPJwsjrbQZ11J6RKc08obwrjX5aeG5lyFmFTgAhAZWe+HEdXV7LgSDftDFJZmUfR95HOZ5BfB7bSg1ypVgcGMsqs=
X-Received: by 2002:a17:90b:17ce:: with SMTP id me14mr3341518pjb.112.1634178014295;
 Wed, 13 Oct 2021 19:20:14 -0700 (PDT)
MIME-Version: 1.0
References: <CACkBjsaa83BmJ-m9bXzmxHcJjjbrhTfiaN6Oo_v2nTkk8Q-mDA@mail.gmail.com>
In-Reply-To: <CACkBjsaa83BmJ-m9bXzmxHcJjjbrhTfiaN6Oo_v2nTkk8Q-mDA@mail.gmail.com>
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Thu, 14 Oct 2021 10:20:03 +0800
Message-ID: <CACkBjsaM_TMu9Tg+04NNLV-B3ViKz0w-rGxmC4Qqt6zVMX2hwQ@mail.gmail.com>
Subject: Re: INFO: task hung in deactivate_super
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hao Sun <sunhao.th@gmail.com> =E4=BA=8E2021=E5=B9=B49=E6=9C=8820=E6=97=A5=
=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=889:05=E5=86=99=E9=81=93=EF=BC=9A
>
> Hello,
>
> When using Healer to fuzz the latest Linux kernel, the following crash
> was triggered.
>
> HEAD commit: 4357f03d6611 Merge tag 'pm-5.15-rc2
> git tree: upstream
> console output:
> https://drive.google.com/file/d/1gXBYGICW_aFSK8X-6NYECS6iIfHI66Nw/view?us=
p=3Dsharing
> kernel config: https://drive.google.com/file/d/1HKZtF_s3l6PL3OoQbNq_ei9Cd=
Bus-Tz0/view?usp=3Dsharing
>
> Sorry, I don't have a reproducer for this crash, hope the symbolized
> report can help.
> If you fix this issue, please add the following tag to the commit:
> Reported-by: Hao Sun <sunhao.th@gmail.com>
>
> INFO: task syz-executor:31998 blocked for more than 143 seconds.
>       Not tainted 5.15.0-rc1+ #19
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz-executor    state:D stack:11144 pid:31998 ppid:     1 flags:0x00=
004004
> Call Trace:
>  context_switch kernel/sched/core.c:4940 [inline]
>  __schedule+0x323/0xae0 kernel/sched/core.c:6287
>  schedule+0x36/0xe0 kernel/sched/core.c:6366
>  rwsem_down_write_slowpath kernel/locking/rwsem.c:1107 [inline]
>  __down_write_common.part.13+0x356/0x7a0 kernel/locking/rwsem.c:1262
>  deactivate_super+0x4b/0x80 fs/super.c:365
>  cleanup_mnt+0x138/0x1b0 fs/namespace.c:1137
>  task_work_run+0x86/0xd0 kernel/task_work.c:164
>  tracehook_notify_resume include/linux/tracehook.h:189 [inline]
>  exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
>  exit_to_user_mode_prepare+0x271/0x280 kernel/entry/common.c:209
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
>  syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:302
>  do_syscall_64+0x40/0xb0 arch/x86/entry/common.c:86
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x46c777
> RSP: 002b:00007ffd324c9358 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000000046c777
> RDX: 0000000000404e22 RSI: 0000000000000002 RDI: 00007ffd324c9420
> RBP: 00007ffd324c9420 R08: 00000000025e5033 R09: 000000000000000b
> R10: 00000000fffffffb R11: 0000000000000246 R12: 00000000004e38c6
> R13: 00007ffd324ca4d0 R14: 00007ffd324ca4cc R15: 0000000000000004
> INFO: task syz-executor:1024 blocked for more than 143 seconds.
>       Not tainted 5.15.0-rc1+ #19
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz-executor    state:D stack:12440 pid: 1024 ppid: 31998 flags:0x00=
004000
> Call Trace:
>  context_switch kernel/sched/core.c:4940 [inline]
>  __schedule+0x323/0xae0 kernel/sched/core.c:6287
>  schedule+0x36/0xe0 kernel/sched/core.c:6366
>  wait_current_trans+0x122/0x1a0 fs/btrfs/transaction.c:534
>  start_transaction+0x3b5/0x970 fs/btrfs/transaction.c:681
>  btrfs_attach_transaction_barrier+0x21/0x60 fs/btrfs/transaction.c:837
>  btrfs_sync_fs+0x7e/0x430 fs/btrfs/super.c:1401
>  sync_fs_one_sb+0x40/0x50 fs/sync.c:81
>  iterate_supers+0xa7/0x130 fs/super.c:695
>  ksys_sync+0x60/0xc0 fs/sync.c:116
>  __do_sys_sync+0xa/0x10 fs/sync.c:125
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x200003ca
> RSP: 002b:00007eff022caba8 EFLAGS: 00000a83 ORIG_RAX: 00000000000000a2
> RAX: ffffffffffffffda RBX: 0000000000000009 RCX: 00000000200003ca
> RDX: 0000000000004c01 RSI: 0000000000000003 RDI: 0000000000400000
> RBP: 00000000000000eb R08: 0000000000000005 R09: 0000000000000006
> R10: 0000000000000007 R11: 0000000000000a83 R12: 000000000000000b
> R13: 000000000000000c R14: 000000000000000d R15: 00007ffd324ca3a0
> INFO: task syz-executor:1054 blocked for more than 143 seconds.
>       Not tainted 5.15.0-rc1+ #19
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz-executor    state:D stack:12440 pid: 1054 ppid: 31998 flags:0x00=
004000
> Call Trace:
>  context_switch kernel/sched/core.c:4940 [inline]
>  __schedule+0x323/0xae0 kernel/sched/core.c:6287
>  schedule+0x36/0xe0 kernel/sched/core.c:6366
>  wait_current_trans+0x122/0x1a0 fs/btrfs/transaction.c:534
>  start_transaction+0x3b5/0x970 fs/btrfs/transaction.c:681
>  btrfs_attach_transaction_barrier+0x21/0x60 fs/btrfs/transaction.c:837
>  btrfs_sync_fs+0x7e/0x430 fs/btrfs/super.c:1401
>  sync_fs_one_sb+0x40/0x50 fs/sync.c:81
>  iterate_supers+0xa7/0x130 fs/super.c:695
>  ksys_sync+0x60/0xc0 fs/sync.c:116
>  __do_sys_sync+0xa/0x10 fs/sync.c:125
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x200003ca
> RSP: 002b:00007eff022caba8 EFLAGS: 00000a83 ORIG_RAX: 00000000000000a2
> RAX: ffffffffffffffda RBX: 0000000000000009 RCX: 00000000200003ca
> RDX: 0000000000004c01 RSI: 0000000000000003 RDI: 0000000000400000
> RBP: 00000000000000eb R08: 0000000000000005 R09: 0000000000000006
> R10: 0000000000000007 R11: 0000000000000a83 R12: 000000000000000b
> R13: 000000000000000c R14: 000000000000000d R15: 00007ffd324ca3a0
> INFO: task syz-executor:1654 blocked for more than 143 seconds.
>       Not tainted 5.15.0-rc1+ #19
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz-executor    state:D stack:12488 pid: 1654 ppid: 31998 flags:0x00=
004000
> Call Trace:
>  context_switch kernel/sched/core.c:4940 [inline]
>  __schedule+0x323/0xae0 kernel/sched/core.c:6287
>  schedule+0x36/0xe0 kernel/sched/core.c:6366
>  rwsem_down_write_slowpath kernel/locking/rwsem.c:1107 [inline]
>  __down_write_common.part.13+0x356/0x7a0 kernel/locking/rwsem.c:1262
>  __btrfs_tree_lock+0x2e/0x1a0 fs/btrfs/locking.c:112
>  btrfs_init_new_buffer fs/btrfs/extent-tree.c:4740 [inline]
>  btrfs_alloc_tree_block+0x19c/0x670 fs/btrfs/extent-tree.c:4818
>  __btrfs_cow_block+0x16f/0x820 fs/btrfs/ctree.c:415
>  btrfs_cow_block+0x12a/0x300 fs/btrfs/ctree.c:570
>  btrfs_search_slot+0x6b0/0xee0 fs/btrfs/ctree.c:1768
>  btrfs_update_root+0x6b/0x470 fs/btrfs/root-tree.c:134
>  commit_fs_roots+0x151/0x220 fs/btrfs/transaction.c:1373
>  btrfs_commit_transaction+0x443/0x1450 fs/btrfs/transaction.c:2265
>  btrfs_sync_fs+0x9a/0x430 fs/btrfs/super.c:1426
>  sync_fs_one_sb+0x40/0x50 fs/sync.c:81
>  iterate_supers+0xa7/0x130 fs/super.c:695
>  ksys_sync+0x60/0xc0 fs/sync.c:116
>  __do_sys_sync+0xa/0x10 fs/sync.c:125
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x2000030a
> RSP: 002b:00007eff022caba8 EFLAGS: 00000a83 ORIG_RAX: 00000000000000a2
> RAX: ffffffffffffffda RBX: 0000000000000009 RCX: 000000002000030a
> RDX: 0000000000004c01 RSI: 0000000000000003 RDI: 0000000000400000
> RBP: 00000000000000ab R08: 0000000000000005 R09: 0000000000000006
> R10: 0000000000000007 R11: 0000000000000a83 R12: 000000000000000b
> R13: 000000000000000c R14: 000000000000000d R15: 00007ffd324ca3a0
> INFO: lockdep is turned off.
> NMI backtrace for cpu 3
> CPU: 3 PID: 39 Comm: khungtaskd Not tainted 5.15.0-rc1+ #19
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> Call Trace:
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x8d/0xcf lib/dump_stack.c:106
>  nmi_cpu_backtrace+0x1e9/0x210 lib/nmi_backtrace.c:105
>  nmi_trigger_cpumask_backtrace+0x120/0x180 lib/nmi_backtrace.c:62
>  trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
>  check_hung_uninterruptible_tasks kernel/hung_task.c:210 [inline]
>  watchdog+0x4e1/0x980 kernel/hung_task.c:295
>  kthread+0x178/0x1b0 kernel/kthread.c:319
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
> Sending NMI from CPU 3 to CPUs 0-2:
> NMI backtrace for cpu 2 skipped: idling at native_safe_halt
> arch/x86/include/asm/irqflags.h:51 [inline]
> NMI backtrace for cpu 2 skipped: idling at arch_safe_halt
> arch/x86/include/asm/irqflags.h:89 [inline]
> NMI backtrace for cpu 2 skipped: idling at default_idle+0xb/0x10
> arch/x86/kernel/process.c:716
> NMI backtrace for cpu 0 skipped: idling at native_safe_halt
> arch/x86/include/asm/irqflags.h:51 [inline]
> NMI backtrace for cpu 0 skipped: idling at arch_safe_halt
> arch/x86/include/asm/irqflags.h:89 [inline]
> NMI backtrace for cpu 0 skipped: idling at default_idle+0xb/0x10
> arch/x86/kernel/process.c:716
> NMI backtrace for cpu 1
> CPU: 1 PID: 3015 Comm: systemd-journal Not tainted 5.15.0-rc1+ #19
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> RIP: 0010:lookup_object lib/debugobjects.c:196 [inline]
> RIP: 0010:debug_object_activate+0xdb/0x230 lib/debugobjects.c:663
> Code: 88 4c 89 f7 e8 86 16 fb 01 48 8b 9b 00 81 81 88 48 85 db 74 65
> 4c 3b 63 18 74 20 48 8b 1b ba 01 00 00 00 48 85 db 75 0a eb 52 <48> 8b
> 1b 48 85 db 74 4a 83 c2 01 4c 3b 63 18 75 ef 8b 53 10 83 fa
> RSP: 0018:ffffc9000087fe20 EFLAGS: 00000087
> RAX: 0000000000000206 RBX: ffff888008c50d98 RCX: 0000000000000000
> RDX: 0000000000000008 RSI: 0000000000000000 RDI: ffffffff888cc108
> RBP: ffffc9000087fe80 R08: 0000000000000001 R09: 0000000000000000
> R10: ffffc9000087fea0 R11: 0000000000000000 R12: ffff88810eb33000
> R13: ffffffff8482f6a0 R14: ffffffff888cc108 R15: ffffffff8736e2d0
> FS:  00007f839bff48c0(0000) GS:ffff88813dc00000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f8396a2c008 CR3: 0000000104716000 CR4: 0000000000750ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>  debug_rcu_head_queue kernel/rcu/rcu.h:176 [inline]
>  __call_rcu kernel/rcu/tree.c:2971 [inline]
>  call_rcu+0x2c/0x320 kernel/rcu/tree.c:3067
>  task_work_run+0x86/0xd0 kernel/task_work.c:164
>  tracehook_notify_resume include/linux/tracehook.h:189 [inline]
>  exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
>  exit_to_user_mode_prepare+0x271/0x280 kernel/entry/common.c:209
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
>  syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:302
>  do_syscall_64+0x40/0xb0 arch/x86/entry/common.c:86
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7f839b58485d
> Code: bb 20 00 00 75 10 b8 02 00 00 00 0f 05 48 3d 01 f0 ff ff 73 31
> c3 48 83 ec 08 e8 1e f6 ff ff 48 89 04 24 b8 02 00 00 00 0f 05 <48> 8b
> 3c 24 48 89 c2 e8 67 f6 ff ff 48 89 d0 48 83 c4 08 48 3d 01
> RSP: 002b:00007ffd9a511330 EFLAGS: 00000293 ORIG_RAX: 0000000000000002
> RAX: fffffffffffffffe RBX: 00007ffd9a511640 RCX: 00007f839b58485d
> RDX: 00000000000001a0 RSI: 0000000000080042 RDI: 0000564967919cd0
> RBP: 000000000000000d R08: 000000000000ffc0 R09: 00000000ffffffff
> R10: 0000000000000069 R11: 0000000000000293 R12: 00000000ffffffff
> R13: 000056496790e040 R14: 00007ffd9a511600 R15: 0000564967911e80
> ----------------
> Code disassembly (best guess):
>    0:   88 4c 89 f7             mov    %cl,-0x9(%rcx,%rcx,4)
>    4:   e8 86 16 fb 01          callq  0x1fb168f
>    9:   48 8b 9b 00 81 81 88    mov    -0x777e7f00(%rbx),%rbx
>   10:   48 85 db                test   %rbx,%rbx
>   13:   74 65                   je     0x7a
>   15:   4c 3b 63 18             cmp    0x18(%rbx),%r12
>   19:   74 20                   je     0x3b
>   1b:   48 8b 1b                mov    (%rbx),%rbx
>   1e:   ba 01 00 00 00          mov    $0x1,%edx
>   23:   48 85 db                test   %rbx,%rbx
>   26:   75 0a                   jne    0x32
>   28:   eb 52                   jmp    0x7c
> * 2a:   48 8b 1b                mov    (%rbx),%rbx <-- trapping instructi=
on
>   2d:   48 85 db                test   %rbx,%rbx
>   30:   74 4a                   je     0x7c
>   32:   83 c2 01                add    $0x1,%edx
>   35:   4c 3b 63 18             cmp    0x18(%rbx),%r12
>   39:   75 ef                   jne    0x2a
>   3b:   8b 53 10                mov    0x10(%rbx),%edx
>   3e:   83                      .byte 0x83
>   3f:   fa                      cli

Hi,

This issue can still be triggered on the latest Linux kernel.

HEAD commit: 64570fbc14f8 Linux 5.15-rc5
git tree: upstream
console output:
https://drive.google.com/file/d/1IhuYkuMmGhbV4djMSLMpKrTr2y8PIec-/view?usp=
=3Dsharing
kerne config: https://drive.google.com/file/d/1em3xgUIMNN_-LUUdySzwN-UDPc3q=
iiKD/view?usp=3Dsharing

INFO: task syz-executor:14246 blocked for more than 143 seconds.
      Not tainted 5.15.0-rc5 #3
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:24560 pid:14246 ppid:     1 flags:0x0000=
4004
Call Trace:
 context_switch kernel/sched/core.c:4940 [inline]
 __schedule+0xcd9/0x2530 kernel/sched/core.c:6287
 schedule+0xd3/0x270 kernel/sched/core.c:6366
 rwsem_down_write_slowpath+0x81f/0x1300 kernel/locking/rwsem.c:1107
 __down_write_common kernel/locking/rwsem.c:1262 [inline]
 __down_write_common kernel/locking/rwsem.c:1259 [inline]
 __down_write kernel/locking/rwsem.c:1271 [inline]
 down_write+0x137/0x150 kernel/locking/rwsem.c:1518
 deactivate_super fs/super.c:365 [inline]
 deactivate_super+0xa5/0xd0 fs/super.c:362
 cleanup_mnt+0x347/0x4b0 fs/namespace.c:1137
 task_work_run+0xe0/0x1a0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
 exit_to_user_mode_prepare+0x28d/0x2a0 kernel/entry/common.c:207
 __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:300
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fb06085c56b
RSP: 002b:00007ffe39884938 EFLAGS: 00000207 ORIG_RAX: 0000000000000054
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fb06085c56b
RDX: 0000000000010140 RSI: 0000000000000000 RDI: 00007ffe39885b10
RBP: 0000000000000065 R08: 0000000000000000 R09: 000000000000007c
R10: 00007fb060962540 R11: 0000000000000207 R12: 00007fb0608d4e46
R13: 00007ffe39885b10 R14: 0000555556623e90 R15: 00007ffe39886bac
INFO: task syz-executor:15874 blocked for more than 143 seconds.
      Not tainted 5.15.0-rc5 #3
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:25408 pid:15874 ppid: 14246 flags:0x0000=
4000
Call Trace:
 context_switch kernel/sched/core.c:4940 [inline]
 __schedule+0xcd9/0x2530 kernel/sched/core.c:6287
 schedule+0xd3/0x270 kernel/sched/core.c:6366
 rwsem_down_read_slowpath+0x4ee/0x9d0 kernel/locking/rwsem.c:993
 __down_read_common kernel/locking/rwsem.c:1214 [inline]
 __down_read kernel/locking/rwsem.c:1223 [inline]
 down_read+0xe4/0x440 kernel/locking/rwsem.c:1466
 iterate_supers+0xdb/0x290 fs/super.c:693
 ksys_sync+0x86/0x150 fs/sync.c:114
 __do_sys_sync+0xa/0x10 fs/sync.c:125
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x2000280a
RSP: 002b:00007fb05dd82bb8 EFLAGS: 00000a83 ORIG_RAX: 00000000000000a2
RAX: ffffffffffffffda RBX: 0000000000000009 RCX: 000000002000280a
RDX: 0000000000004c01 RSI: 0000000000000003 RDI: 0000000000400000
RBP: 00000000000000ab R08: 0000000000000005 R09: 0000000000000006
R10: 0000000000000007 R11: 0000000000000a83 R12: 000000000000000b
R13: 000000000000000c R14: 000000000000000d R15: 00007fb05dd82dc0
INFO: task syz-executor:17598 blocked for more than 143 seconds.
      Not tainted 5.15.0-rc5 #3
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:25408 pid:17598 ppid: 14246 flags:0x0000=
0000
Call Trace:
 context_switch kernel/sched/core.c:4940 [inline]
 __schedule+0xcd9/0x2530 kernel/sched/core.c:6287
 schedule+0xd3/0x270 kernel/sched/core.c:6366
 rwsem_down_read_slowpath+0x4ee/0x9d0 kernel/locking/rwsem.c:993
 __down_read_common kernel/locking/rwsem.c:1214 [inline]
 __down_read kernel/locking/rwsem.c:1223 [inline]
 down_read+0xe4/0x440 kernel/locking/rwsem.c:1466
 iterate_supers+0xdb/0x290 fs/super.c:693
 ksys_sync+0x86/0x150 fs/sync.c:114
 __do_sys_sync+0xa/0x10 fs/sync.c:125
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x20002a0a
RSP: 002b:00007fb05ddc4bb8 EFLAGS: 00000a83 ORIG_RAX: 00000000000000a2
RAX: ffffffffffffffda RBX: 0000000000000009 RCX: 0000000020002a0a
RDX: 0000000000004c01 RSI: 0000000000000003 RDI: 0000000000400000
RBP: 00000000000000ab R08: 0000000000000005 R09: 0000000000000006
R10: 0000000000000007 R11: 0000000000000a83 R12: 000000000000000b
R13: 000000000000000c R14: 000000000000000d R15: 00007fb05ddc4dc0
INFO: lockdep is turned off.
NMI backtrace for cpu 0
CPU: 0 PID: 39 Comm: khungtaskd Not tainted 5.15.0-rc5 #3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 nmi_cpu_backtrace.cold+0x47/0x144 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x1e1/0x220 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:210 [inline]
 watchdog+0xcc8/0x1010 kernel/hung_task.c:295
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
Sending NMI from CPU 0 to CPUs 1-3:
NMI backtrace for cpu 3
CPU: 3 PID: 3023 Comm: systemd-journal Not tainted 5.15.0-rc5 #3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:__need_reclaim mm/page_alloc.c:4528 [inline]
RIP: 0010:__need_reclaim mm/page_alloc.c:4521 [inline]
RIP: 0010:fs_reclaim_release+0x6c/0xf0 mm/page_alloc.c:4568
Code: 10 75 6a f6 c7 04 74 4f 65 48 8b 2c 25 40 f0 01 00 48 8d 7d 2c
48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 0f b6 14 02 <48> 89
f8 83 e0 07 83 c0 03 38 d0 7c 04 84 d2 75 67 8b 45 2c 89 da
RSP: 0018:ffffc900017cfd00 EFLAGS: 00000213
RAX: dffffc0000000000 RBX: 0000000000000cc0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff88801d47392c
RBP: ffff88801d473900 R08: 0000000000000000 R09: fffffbfff1adb0b3
R10: ffffffff8d6d8597 R11: fffffbfff1adb0b2 R12: 0000000000000cc0
R13: 0000000000000cc0 R14: 0000000000000000 R15: ffffffff8d6db588
FS:  00007fd0fa8c68c0(0000) GS:ffff888135d00000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd0f819e090 CR3: 000000001d673000 CR4: 0000000000350ee0
Call Trace:
 might_alloc include/linux/sched/mm.h:199 [inline]
 slab_pre_alloc_hook mm/slab.h:492 [inline]
 slab_alloc_node mm/slub.c:3120 [inline]
 slab_alloc mm/slub.c:3214 [inline]
 kmem_cache_alloc+0x4a/0x340 mm/slub.c:3219
 getname_flags fs/namei.c:138 [inline]
 getname_flags+0xd2/0x5b0 fs/namei.c:128
 do_sys_openat2+0x448/0x9a0 fs/open.c:1194
 do_sys_open+0xc3/0x140 fs/open.c:1216
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fd0f9e56840
Code: 73 01 c3 48 8b 0d 68 77 20 00 f7 d8 64 89 01 48 83 c8 ff c3 66
0f 1f 44 00 00 83 3d 89 bb 20 00 00 75 10 b8 02 00 00 00 0f 05 <48> 3d
01 f0 ff ff 73 31 c3 48 83 ec 08 e8 1e f6 ff ff 48 89 04 24
RSP: 002b:00007ffdbea7bc28 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007ffdbea7bf30 RCX: 00007fd0f9e56840
RDX: 00000000000001a0 RSI: 0000000000080042 RDI: 000055b183b03360
RBP: 000000000000000d R08: 0000000000000000 R09: 00000000ffffffff
R10: 0000000000000069 R11: 0000000000000246 R12: 00000000ffffffff
R13: 000055b183af8040 R14: 00007ffdbea7bef0 R15: 000055b183b06790
NMI backtrace for cpu 2
CPU: 2 PID: 7274 Comm: kworker/u8:3 Not tainted 5.15.0-rc5 #3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Workqueue: bat_events batadv_nc_worker
RIP: 0010:__sanitizer_cov_trace_pc+0x1a/0x40 kernel/kcov.c:197
Code: 00 c3 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 65 48 8b 0c 25
40 f0 01 00 bf 02 00 00 00 48 89 ce 4c 8b 04 24 e8 76 ff ff ff <84> c0
74 20 48 8b 91 20 15 00 00 8b 89 1c 15 00 00 48 8b 02 48 83
RSP: 0018:ffffc900087afcd8 EFLAGS: 00000293
RAX: 0000000000000000 RBX: ffff888031e32a00 RCX: ffff888108be3900
RDX: 0000000000000000 RSI: ffff888108be3900 RDI: 0000000000000002
RBP: ffff888014918c80 R08: ffffffff88d155e4 R09: 00000000000001a9
R10: 0000000000000004 R11: fffffbfff1adb0b2 R12: 0000000000000001
R13: 00000000000001a9 R14: dffffc0000000000 R15: ffff8881161fcd48
FS:  0000000000000000(0000) GS:ffff888063f00000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555556d59e88 CR3: 000000001b967000 CR4: 0000000000350ee0
Call Trace:
 rcu_lock_acquire include/linux/rcupdate.h:267 [inline]
 rcu_read_lock include/linux/rcupdate.h:687 [inline]
 batadv_nc_purge_orig_hash net/batman-adv/network-coding.c:410 [inline]
 batadv_nc_worker+0xf4/0x770 net/batman-adv/network-coding.c:721
 process_one_work+0x9df/0x16d0 kernel/workqueue.c:2297
 worker_thread+0x90/0xed0 kernel/workqueue.c:2444
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
NMI backtrace for cpu 1 skipped: idling at native_safe_halt
arch/x86/include/asm/irqflags.h:51 [inline]
NMI backtrace for cpu 1 skipped: idling at arch_safe_halt
arch/x86/include/asm/irqflags.h:89 [inline]
NMI backtrace for cpu 1 skipped: idling at default_idle+0xb/0x10
arch/x86/kernel/process.c:716
----------------
Code disassembly (best guess):
   0: 10 75 6a              adc    %dh,0x6a(%rbp)
   3: f6 c7 04              test   $0x4,%bh
   6: 74 4f                je     0x57
   8: 65 48 8b 2c 25 40 f0 mov    %gs:0x1f040,%rbp
   f: 01 00
  11: 48 8d 7d 2c          lea    0x2c(%rbp),%rdi
  15: 48 b8 00 00 00 00 00 movabs $0xdffffc0000000000,%rax
  1c: fc ff df
  1f: 48 89 fa              mov    %rdi,%rdx
  22: 48 c1 ea 03          shr    $0x3,%rdx
  26: 0f b6 14 02          movzbl (%rdx,%rax,1),%edx
* 2a: 48 89 f8              mov    %rdi,%rax <-- trapping instruction
  2d: 83 e0 07              and    $0x7,%eax
  30: 83 c0 03              add    $0x3,%eax
  33: 38 d0                cmp    %dl,%al
  35: 7c 04                jl     0x3b
  37: 84 d2                test   %dl,%dl
  39: 75 67                jne    0xa2
  3b: 8b 45 2c              mov    0x2c(%rbp),%eax
  3e: 89 da                mov    %ebx,%edx%
