Return-Path: <linux-fsdevel+bounces-524-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 920FD7CC3FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 15:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E09F7B210B1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 13:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623E642C08;
	Tue, 17 Oct 2023 13:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217813D3AF
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Oct 2023 13:07:54 +0000 (UTC)
Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349A2F0
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Oct 2023 06:07:51 -0700 (PDT)
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-3af5b5d7ecbso8628585b6e.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Oct 2023 06:07:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697548070; x=1698152870;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TAQbavEeMVYTmWKnJI/Uc1RB8WpRiSnz2MEKLgYV7mw=;
        b=d66lUBT5syN50GoTF3yCVzaonmFOaA+q8uMjYrKjHHAo9Gbi8P2EQBVGPefBje7a2q
         rdONMCwBOhQAjWn4UUjArcJxvm5B0Jz/1/xnEsGLNuwLj3H+ZK/gBZ1Qm1djaxUDjqw+
         L4l/3usrzyo0tYGeg0W4R7amlG0sc0z20kllumH1LBXMwh/XKOyGw89RVFmmgWd5L2Or
         5QeftZTcrlbj87HT3LFSw38zwOpyPCxc7wRfxLMvZf61PzZAGuut3UTQ8zAxfk7AYG9Y
         UuVkr3swOpDhLzCBPfSLG4RORiI4pTh3lTdjdWIGRPS8867manQH1IBreih3cGDAWzpz
         z7HQ==
X-Gm-Message-State: AOJu0Yw3lGtqbFVfAE2LwiYo53nNHoLh2NbEeBKXpReJkeftnUsY0nRb
	LaFHDW5Mi08v5ouXq2Le+KrExI6eOwSMqxZ+mWnQPdfa1Flk
X-Google-Smtp-Source: AGHT+IFzydJqkIT8ul7IxJr7JRSHnIjDHeNWD3H0BOduba6sHvliMPjzzldXzZpjsMbLWIEyWD2zCo+3wYtsVx0nk01xxTix3fH8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:130f:b0:3a3:7087:bbfb with SMTP id
 y15-20020a056808130f00b003a37087bbfbmr919882oiv.6.1697548070548; Tue, 17 Oct
 2023 06:07:50 -0700 (PDT)
Date: Tue, 17 Oct 2023 06:07:50 -0700
In-Reply-To: <000000000000e40a2906072e9567@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bc00ea0607e9359d@google.com>
Subject: Re: [syzbot] [ext4?] possible deadlock in console_flush_all (2)
From: syzbot <syzbot+f78380e4eae53c64125c@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, bsegall@google.com, dvyukov@google.com, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nogikh@google.com, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
	SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzbot has found a reproducer for the following issue on:

HEAD commit:    213f891525c2 Merge tag 'probes-fixes-v6.6-rc6' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=154b2f55680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4471dbb58008c9f2
dashboard link: https://syzkaller.appspot.com/bug?extid=f78380e4eae53c64125c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1711f94d680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1267424d680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2865a8ce1485/disk-213f8915.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9250aaf914b2/vmlinux-213f8915.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a38e8bb73fa3/bzImage-213f8915.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/1f53082eac44/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f78380e4eae53c64125c@syzkaller.appspotmail.com

list_add corruption. next->prev should be prev (ffff8880b993d228), but was caff904900000000. (next=ffff8880783659f8).
======================================================
WARNING: possible circular locking dependency detected
6.6.0-rc6-syzkaller-00029-g213f891525c2 #0 Not tainted
------------------------------------------------------
syz-executor221/5041 is trying to acquire lock:
ffffffff8cab86c0 (console_owner){-...}-{0:0}, at: console_lock_spinning_enable kernel/printk/printk.c:1858 [inline]
ffffffff8cab86c0 (console_owner){-...}-{0:0}, at: console_emit_next_record kernel/printk/printk.c:2904 [inline]
ffffffff8cab86c0 (console_owner){-...}-{0:0}, at: console_flush_all+0x4ac/0xfb0 kernel/printk/printk.c:2966

but task is already holding lock:
ffff8880b993c718 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:558

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (&rq->__lock){-.-.}-{2:2}:
       _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
       raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:558
       raw_spin_rq_lock kernel/sched/sched.h:1372 [inline]
       rq_lock kernel/sched/sched.h:1681 [inline]
       task_fork_fair+0x70/0x240 kernel/sched/fair.c:12416
       sched_cgroup_fork+0x3cf/0x510 kernel/sched/core.c:4816
       copy_process+0x45ec/0x73f0 kernel/fork.c:2609
       kernel_clone+0xfd/0x920 kernel/fork.c:2909
       user_mode_thread+0xb4/0xf0 kernel/fork.c:2987
       rest_init+0x27/0x2b0 init/main.c:691
       arch_call_rest_init+0x13/0x30 init/main.c:823
       start_kernel+0x39f/0x480 init/main.c:1068
       x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:556
       x86_64_start_kernel+0xb2/0xc0 arch/x86/kernel/head64.c:537
       secondary_startup_64_no_verify+0x166/0x16b

-> #3 (&p->pi_lock){-.-.}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x3a/0x50 kernel/locking/spinlock.c:162
       class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:518 [inline]
       try_to_wake_up+0xb0/0x15b0 kernel/sched/core.c:4230
       __wake_up_common+0x140/0x5a0 kernel/sched/wait.c:107
       __wake_up_common_lock+0xd6/0x140 kernel/sched/wait.c:138
       tty_port_default_wakeup+0x2a/0x40 drivers/tty/tty_port.c:69
       serial8250_tx_chars+0x542/0xf60 drivers/tty/serial/8250/8250_port.c:1843
       serial8250_handle_irq+0x606/0xbe0 drivers/tty/serial/8250/8250_port.c:1950
       serial8250_default_handle_irq+0x94/0x210 drivers/tty/serial/8250/8250_port.c:1970
       serial8250_interrupt+0xfc/0x200 drivers/tty/serial/8250/8250_core.c:127
       __handle_irq_event_percpu+0x22a/0x740 kernel/irq/handle.c:158
       handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
       handle_irq_event+0xab/0x1e0 kernel/irq/handle.c:210
       handle_edge_irq+0x261/0xcf0 kernel/irq/chip.c:831
       generic_handle_irq_desc include/linux/irqdesc.h:161 [inline]
       handle_irq arch/x86/kernel/irq.c:238 [inline]
       __common_interrupt+0xdb/0x240 arch/x86/kernel/irq.c:257
       common_interrupt+0xa9/0xd0 arch/x86/kernel/irq.c:247
       asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:636
       native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
       arch_safe_halt arch/x86/include/asm/irqflags.h:86 [inline]
       acpi_safe_halt+0x1b/0x20 drivers/acpi/processor_idle.c:112
       acpi_idle_enter+0xc5/0x160 drivers/acpi/processor_idle.c:707
       cpuidle_enter_state+0x82/0x500 drivers/cpuidle/cpuidle.c:267
       cpuidle_enter+0x4e/0xa0 drivers/cpuidle/cpuidle.c:388
       cpuidle_idle_call kernel/sched/idle.c:215 [inline]
       do_idle+0x315/0x3f0 kernel/sched/idle.c:282
       cpu_startup_entry+0x50/0x60 kernel/sched/idle.c:380
       rest_init+0x16f/0x2b0 init/main.c:726
       arch_call_rest_init+0x13/0x30 init/main.c:823
       start_kernel+0x39f/0x480 init/main.c:1068
       x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:556
       x86_64_start_kernel+0xb2/0xc0 arch/x86/kernel/head64.c:537
       secondary_startup_64_no_verify+0x166/0x16b

-> #2 (&tty->write_wait){-.-.}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x3a/0x50 kernel/locking/spinlock.c:162
       __wake_up_common_lock+0xbb/0x140 kernel/sched/wait.c:137
       tty_port_default_wakeup+0x2a/0x40 drivers/tty/tty_port.c:69
       serial8250_tx_chars+0x542/0xf60 drivers/tty/serial/8250/8250_port.c:1843
       serial8250_handle_irq+0x606/0xbe0 drivers/tty/serial/8250/8250_port.c:1950
       serial8250_default_handle_irq+0x94/0x210 drivers/tty/serial/8250/8250_port.c:1970
       serial8250_interrupt+0xfc/0x200 drivers/tty/serial/8250/8250_core.c:127
       __handle_irq_event_percpu+0x22a/0x740 kernel/irq/handle.c:158
       handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
       handle_irq_event+0xab/0x1e0 kernel/irq/handle.c:210
       handle_edge_irq+0x261/0xcf0 kernel/irq/chip.c:831
       generic_handle_irq_desc include/linux/irqdesc.h:161 [inline]
       handle_irq arch/x86/kernel/irq.c:238 [inline]
       __common_interrupt+0xdb/0x240 arch/x86/kernel/irq.c:257
       common_interrupt+0xa9/0xd0 arch/x86/kernel/irq.c:247
       asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:636
       native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
       arch_safe_halt arch/x86/include/asm/irqflags.h:86 [inline]
       acpi_safe_halt+0x1b/0x20 drivers/acpi/processor_idle.c:112
       acpi_idle_enter+0xc5/0x160 drivers/acpi/processor_idle.c:707
       cpuidle_enter_state+0x82/0x500 drivers/cpuidle/cpuidle.c:267
       cpuidle_enter+0x4e/0xa0 drivers/cpuidle/cpuidle.c:388
       cpuidle_idle_call kernel/sched/idle.c:215 [inline]
       do_idle+0x315/0x3f0 kernel/sched/idle.c:282
       cpu_startup_entry+0x50/0x60 kernel/sched/idle.c:380
       rest_init+0x16f/0x2b0 init/main.c:726
       arch_call_rest_init+0x13/0x30 init/main.c:823
       start_kernel+0x39f/0x480 init/main.c:1068
       x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:556
       x86_64_start_kernel+0xb2/0xc0 arch/x86/kernel/head64.c:537
       secondary_startup_64_no_verify+0x166/0x16b

-> #1 (&port_lock_key){-.-.}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x3a/0x50 kernel/locking/spinlock.c:162
       serial8250_console_write+0x57e/0x1060 drivers/tty/serial/8250/8250_port.c:3411
       console_emit_next_record kernel/printk/printk.c:2910 [inline]
       console_flush_all+0x4eb/0xfb0 kernel/printk/printk.c:2966
       console_unlock+0x10c/0x260 kernel/printk/printk.c:3035
       vprintk_emit+0x17f/0x5f0 kernel/printk/printk.c:2307
       vprintk+0x7b/0x90 kernel/printk/printk_safe.c:45
       _printk+0xc8/0x100 kernel/printk/printk.c:2332
       register_console+0xa67/0x10d0 kernel/printk/printk.c:3524
       univ8250_console_init+0x35/0x50 drivers/tty/serial/8250/8250_core.c:717
       console_init+0xba/0x5c0 kernel/printk/printk.c:3667
       start_kernel+0x25a/0x480 init/main.c:1004
       x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:556
       x86_64_start_kernel+0xb2/0xc0 arch/x86/kernel/head64.c:537
       secondary_startup_64_no_verify+0x166/0x16b

-> #0 (console_owner){-...}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3868 [inline]
       __lock_acquire+0x2e3d/0x5de0 kernel/locking/lockdep.c:5136
       lock_acquire kernel/locking/lockdep.c:5753 [inline]
       lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5718
       console_lock_spinning_enable kernel/printk/printk.c:1858 [inline]
       console_emit_next_record kernel/printk/printk.c:2904 [inline]
       console_flush_all+0x4c1/0xfb0 kernel/printk/printk.c:2966
       console_unlock+0x10c/0x260 kernel/printk/printk.c:3035
       vprintk_emit+0x17f/0x5f0 kernel/printk/printk.c:2307
       vprintk+0x7b/0x90 kernel/printk/printk_safe.c:45
       _printk+0xc8/0x100 kernel/printk/printk.c:2332
       __list_add_valid_or_report+0xa2/0x100 lib/list_debug.c:29
       __list_add_valid include/linux/list.h:88 [inline]
       __list_add include/linux/list.h:150 [inline]
       list_add include/linux/list.h:169 [inline]
       account_entity_enqueue kernel/sched/fair.c:3534 [inline]
       enqueue_entity+0x97b/0x1490 kernel/sched/fair.c:5117
       enqueue_task_fair+0x15b/0xbc0 kernel/sched/fair.c:6536
       enqueue_task kernel/sched/core.c:2102 [inline]
       activate_task kernel/sched/core.c:2132 [inline]
       ttwu_do_activate+0x214/0xd90 kernel/sched/core.c:3787
       ttwu_queue kernel/sched/core.c:4029 [inline]
       try_to_wake_up+0x8e7/0x15b0 kernel/sched/core.c:4346
       autoremove_wake_function+0x16/0x150 kernel/sched/wait.c:424
       __wake_up_common+0x140/0x5a0 kernel/sched/wait.c:107
       __wake_up_common_lock+0xd6/0x140 kernel/sched/wait.c:138
       wake_up_klogd_work_func kernel/printk/printk.c:3840 [inline]
       wake_up_klogd_work_func+0x90/0xa0 kernel/printk/printk.c:3829
       irq_work_single+0x1b5/0x260 kernel/irq_work.c:221
       irq_work_run_list kernel/irq_work.c:252 [inline]
       irq_work_run_list+0x92/0xc0 kernel/irq_work.c:235
       update_process_times+0x1d5/0x220 kernel/time/timer.c:2074
       tick_sched_handle+0x8e/0x170 kernel/time/tick-sched.c:254
       tick_sched_timer+0xe9/0x110 kernel/time/tick-sched.c:1492
       __run_hrtimer kernel/time/hrtimer.c:1688 [inline]
       __hrtimer_run_queues+0x647/0xc10 kernel/time/hrtimer.c:1752
       hrtimer_interrupt+0x31b/0x800 kernel/time/hrtimer.c:1814
       local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1063 [inline]
       __sysvec_apic_timer_interrupt+0x105/0x3f0 arch/x86/kernel/apic/apic.c:1080
       sysvec_apic_timer_interrupt+0x8e/0xc0 arch/x86/kernel/apic/apic.c:1074
       asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
       memmove+0x50/0x1b0 arch/x86/lib/memmove_64.S:70
       ext4_ext_rm_leaf fs/ext4/extents.c:2736 [inline]
       ext4_ext_remove_space+0x1dd1/0x4390 fs/ext4/extents.c:2958
       ext4_punch_hole+0xe10/0x1040 fs/ext4/inode.c:4011
       ext4_fallocate+0xe21/0x3c30 fs/ext4/extents.c:4706
       vfs_fallocate+0x46c/0xe80 fs/open.c:324
       ioctl_preallocate+0x1a4/0x220 fs/ioctl.c:291
       file_ioctl fs/ioctl.c:334 [inline]
       do_vfs_ioctl+0x158c/0x1920 fs/ioctl.c:850
       __do_sys_ioctl fs/ioctl.c:869 [inline]
       __se_sys_ioctl fs/ioctl.c:857 [inline]
       __x64_sys_ioctl+0x112/0x210 fs/ioctl.c:857
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

Chain exists of:
  console_owner --> &p->pi_lock --> &rq->__lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&rq->__lock);
                               lock(&p->pi_lock);
                               lock(&rq->__lock);
  lock(console_owner);

 *** DEADLOCK ***

9 locks held by syz-executor221/5041:
 #0: ffff88807e30e410 (sb_writers#4){.+.+}-{0:0}, at: ioctl_preallocate+0x1a4/0x220 fs/ioctl.c:291
 #1: ffff888077854a00 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:802 [inline]
 #1: ffff888077854a00 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_punch_hole+0x1bd/0x1040 fs/ext4/inode.c:3916
 #2: ffff888077854ba0 (mapping.invalidate_lock){++++}-{3:3}, at: filemap_invalidate_lock include/linux/fs.h:847 [inline]
 #2: ffff888077854ba0 (mapping.invalidate_lock){++++}-{3:3}, at: ext4_punch_hole+0x370/0x1040 fs/ext4/inode.c:3963
 #3: ffff888077854888 (&ei->i_data_sem){++++}-{3:3}, at: ext4_punch_hole+0xd94/0x1040 fs/ext4/inode.c:4004
 #4: ffffffff8cb98958 (log_wait.lock){-...}-{2:2}, at: __wake_up_common_lock+0xbb/0x140 kernel/sched/wait.c:137
 #5: ffff88807eea0a00 (&p->pi_lock){-.-.}-{2:2}, at: class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:518 [inline]
 #5: ffff88807eea0a00 (&p->pi_lock){-.-.}-{2:2}, at: try_to_wake_up+0xb0/0x15b0 kernel/sched/core.c:4230
 #6: ffff8880b993c718 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:558
 #7: ffffffff8cb98b00 (console_lock){+.+.}-{0:0}, at: console_trylock_spinning kernel/printk/printk.c:1927 [inline]
 #7: ffffffff8cb98b00 (console_lock){+.+.}-{0:0}, at: vprintk_emit+0x162/0x5f0 kernel/printk/printk.c:2306
 #8: ffffffff8cb98b70 (console_srcu){....}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:303 [inline]
 #8: ffffffff8cb98b70 (console_srcu){....}-{0:0}, at: srcu_read_lock_nmisafe include/linux/srcu.h:232 [inline]
 #8: ffffffff8cb98b70 (console_srcu){....}-{0:0}, at: console_srcu_read_lock kernel/printk/printk.c:292 [inline]
 #8: ffffffff8cb98b70 (console_srcu){....}-{0:0}, at: console_flush_all+0x12d/0xfb0 kernel/printk/printk.c:2958

stack backtrace:
CPU: 0 PID: 5041 Comm: syz-executor221 Not tainted 6.6.0-rc6-syzkaller-00029-g213f891525c2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 check_noncircular+0x311/0x3f0 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3868 [inline]
 __lock_acquire+0x2e3d/0x5de0 kernel/locking/lockdep.c:5136
 lock_acquire kernel/locking/lockdep.c:5753 [inline]
 lock_acquire+0x1ae/0x510 kernel/locking/lockdep.c:5718
 console_lock_spinning_enable kernel/printk/printk.c:1858 [inline]
 console_emit_next_record kernel/printk/printk.c:2904 [inline]
 console_flush_all+0x4c1/0xfb0 kernel/printk/printk.c:2966
 console_unlock+0x10c/0x260 kernel/printk/printk.c:3035
 vprintk_emit+0x17f/0x5f0 kernel/printk/printk.c:2307
 vprintk+0x7b/0x90 kernel/printk/printk_safe.c:45
 _printk+0xc8/0x100 kernel/printk/printk.c:2332
 __list_add_valid_or_report+0xa2/0x100 lib/list_debug.c:29
 __list_add_valid include/linux/list.h:88 [inline]
 __list_add include/linux/list.h:150 [inline]
 list_add include/linux/list.h:169 [inline]
 account_entity_enqueue kernel/sched/fair.c:3534 [inline]
 enqueue_entity+0x97b/0x1490 kernel/sched/fair.c:5117
 enqueue_task_fair+0x15b/0xbc0 kernel/sched/fair.c:6536
 enqueue_task kernel/sched/core.c:2102 [inline]
 activate_task kernel/sched/core.c:2132 [inline]
 ttwu_do_activate+0x214/0xd90 kernel/sched/core.c:3787
 ttwu_queue kernel/sched/core.c:4029 [inline]
 try_to_wake_up+0x8e7/0x15b0 kernel/sched/core.c:4346
 autoremove_wake_function+0x16/0x150 kernel/sched/wait.c:424
 __wake_up_common+0x140/0x5a0 kernel/sched/wait.c:107
 __wake_up_common_lock+0xd6/0x140 kernel/sched/wait.c:138
 wake_up_klogd_work_func kernel/printk/printk.c:3840 [inline]
 wake_up_klogd_work_func+0x90/0xa0 kernel/printk/printk.c:3829
 irq_work_single+0x1b5/0x260 kernel/irq_work.c:221
 irq_work_run_list kernel/irq_work.c:252 [inline]
 irq_work_run_list+0x92/0xc0 kernel/irq_work.c:235
 update_process_times+0x1d5/0x220 kernel/time/timer.c:2074
 tick_sched_handle+0x8e/0x170 kernel/time/tick-sched.c:254
 tick_sched_timer+0xe9/0x110 kernel/time/tick-sched.c:1492
 __run_hrtimer kernel/time/hrtimer.c:1688 [inline]
 __hrtimer_run_queues+0x647/0xc10 kernel/time/hrtimer.c:1752
 hrtimer_interrupt+0x31b/0x800 kernel/time/hrtimer.c:1814
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1063 [inline]
 __sysvec_apic_timer_interrupt+0x105/0x3f0 arch/x86/kernel/apic/apic.c:1080
 sysvec_apic_timer_interrupt+0x8e/0xc0 arch/x86/kernel/apic/apic.c:1074
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0010:memmove+0x50/0x1b0 arch/x86/lib/memmove_64.S:71
Code: 0f 1f 44 00 00 48 81 fa a8 02 00 00 72 05 40 38 fe 74 47 48 83 ea 20 48 83 ea 20 4c 8b 1e 4c 8b 56 08 4c 8b 4e 10 4c 8b 46 18 <48> 8d 76 20 4c 89 1f 4c 89 57 08 4c 89 4f 10 4c 89 47 18 48 8d 7f
RSP: 0018:ffffc9000431f800 EFLAGS: 00000286
RAX: ffff88807723c078 RBX: ffff88807723c002 RCX: 0000000000000000
RDX: fffffffffec10288 RSI: ffff88807862bd44 RDI: ffff88807862bd38
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff88807723c07c
R13: ffff88807e30c000 R14: dffffc0000000000 R15: dffffc0000000000
 ext4_ext_rm_leaf fs/ext4/extents.c:2736 [inline]
 ext4_ext_remove_space+0x1dd1/0x4390 fs/ext4/extents.c:2958
 ext4_punch_hole+0xe10/0x1040 fs/ext4/inode.c:4011
 ext4_fallocate+0xe21/0x3c30 fs/ext4/extents.c:4706
 vfs_fallocate+0x46c/0xe80 fs/open.c:324
 ioctl_preallocate+0x1a4/0x220 fs/ioctl.c:291
 file_ioctl fs/ioctl.c:334 [inline]
 do_vfs_ioctl+0x158c/0x1920 fs/ioctl.c:850
 __do_sys_ioctl fs/ioctl.c:869 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x112/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7ff93a3c62d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff93a361218 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ff93a44d6d8 RCX: 00007ff93a3c62d9
RDX: 0000000020000080 RSI: 000000004030582b RDI: 0000000000000004
RBP: 00007ff93a44d6d0 R08: 00007ffd0d4db467 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ff93a41a578
R13: 0000000000000006 R14: 00007ffd0d4db380 R15: 6f6f6c2f7665642f
 </TASK>
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:29!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5041 Comm: syz-executor221 Not tainted 6.6.0-rc6-syzkaller-00029-g213f891525c2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
RIP: 0010:__list_add_valid_or_report+0xa2/0x100 lib/list_debug.c:29
Code: c7 c7 20 2d e9 8a e8 3d 31 3f fd 0f 0b 48 c7 c7 c0 2d e9 8a e8 2f 31 3f fd 0f 0b 48 89 d9 48 c7 c7 20 2e e9 8a e8 1e 31 3f fd <0f> 0b 48 89 f1 48 c7 c7 a0 2e e9 8a 48 89 de e8 0a 31 3f fd 0f 0b
RSP: 0018:ffffc900000079c0 EFLAGS: 00010086
RAX: 0000000000000075 RBX: ffff8880783659f8 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff816b8952 RDI: 0000000000000005
RBP: ffff88807eea00b8 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080010004 R11: 0000000000000001 R12: ffff88807eea0120
R13: ffff88807eea3c00 R14: ffff8880b993c820 R15: ffff8880b993d228
FS:  00007ff93a3616c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002002b000 CR3: 0000000020467000 CR4: 0000000000350ef0
Call Trace:
 <IRQ>
 __list_add_valid include/linux/list.h:88 [inline]
 __list_add include/linux/list.h:150 [inline]
 list_add include/linux/list.h:169 [inline]
 account_entity_enqueue kernel/sched/fair.c:3534 [inline]
 enqueue_entity+0x97b/0x1490 kernel/sched/fair.c:5117
 enqueue_task_fair+0x15b/0xbc0 kernel/sched/fair.c:6536
 enqueue_task kernel/sched/core.c:2102 [inline]
 activate_task kernel/sched/core.c:2132 [inline]
 ttwu_do_activate+0x214/0xd90 kernel/sched/core.c:3787
 ttwu_queue kernel/sched/core.c:4029 [inline]
 try_to_wake_up+0x8e7/0x15b0 kernel/sched/core.c:4346
 autoremove_wake_function+0x16/0x150 kernel/sched/wait.c:424
 __wake_up_common+0x140/0x5a0 kernel/sched/wait.c:107
 __wake_up_common_lock+0xd6/0x140 kernel/sched/wait.c:138
 wake_up_klogd_work_func kernel/printk/printk.c:3840 [inline]
 wake_up_klogd_work_func+0x90/0xa0 kernel/printk/printk.c:3829
 irq_work_single+0x1b5/0x260 kernel/irq_work.c:221
 irq_work_run_list kernel/irq_work.c:252 [inline]
 irq_work_run_list+0x92/0xc0 kernel/irq_work.c:235
 update_process_times+0x1d5/0x220 kernel/time/timer.c:2074
 tick_sched_handle+0x8e/0x170 kernel/time/tick-sched.c:254
 tick_sched_timer+0xe9/0x110 kernel/time/tick-sched.c:1492
 __run_hrtimer kernel/time/hrtimer.c:1688 [inline]
 __hrtimer_run_queues+0x647/0xc10 kernel/time/hrtimer.c:1752
 hrtimer_interrupt+0x31b/0x800 kernel/time/hrtimer.c:1814
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1063 [inline]
 __sysvec_apic_timer_interrupt+0x105/0x3f0 arch/x86/kernel/apic/apic.c:1080
 sysvec_apic_timer_interrupt+0x8e/0xc0 arch/x86/kernel/apic/apic.c:1074
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0010:memmove+0x50/0x1b0 arch/x86/lib/memmove_64.S:71
Code: 0f 1f 44 00 00 48 81 fa a8 02 00 00 72 05 40 38 fe 74 47 48 83 ea 20 48 83 ea 20 4c 8b 1e 4c 8b 56 08 4c 8b 4e 10 4c 8b 46 18 <48> 8d 76 20 4c 89 1f 4c 89 57 08 4c 89 4f 10 4c 89 47 18 48 8d 7f
RSP: 0018:ffffc9000431f800 EFLAGS: 00000286
RAX: ffff88807723c078 RBX: ffff88807723c002 RCX: 0000000000000000
RDX: fffffffffec10288 RSI: ffff88807862bd44 RDI: ffff88807862bd38
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff88807723c07c
R13: ffff88807e30c000 R14: dffffc0000000000 R15: dffffc0000000000
 ext4_ext_rm_leaf fs/ext4/extents.c:2736 [inline]
 ext4_ext_remove_space+0x1dd1/0x4390 fs/ext4/extents.c:2958
 ext4_punch_hole+0xe10/0x1040 fs/ext4/inode.c:4011
 ext4_fallocate+0xe21/0x3c30 fs/ext4/extents.c:4706
 vfs_fallocate+0x46c/0xe80 fs/open.c:324
 ioctl_preallocate+0x1a4/0x220 fs/ioctl.c:291
 file_ioctl fs/ioctl.c:334 [inline]
 do_vfs_ioctl+0x158c/0x1920 fs/ioctl.c:850
 __do_sys_ioctl fs/ioctl.c:869 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x112/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7ff93a3c62d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff93a361218 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ff93a44d6d8 RCX: 00007ff93a3c62d9
RDX: 0000000020000080 RSI: 000000004030582b RDI: 0000000000000004
RBP: 00007ff93a44d6d0 R08: 00007ffd0d4db467 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ff93a41a578
R13: 0000000000000006 R14: 00007ffd0d4db380 R15: 6f6f6c2f7665642f
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_add_valid_or_report+0xa2/0x100 lib/list_debug.c:29
Code: c7 c7 20 2d e9 8a e8 3d 31 3f fd 0f 0b 48 c7 c7 c0 2d e9 8a e8 2f 31 3f fd 0f 0b 48 89 d9 48 c7 c7 20 2e e9 8a e8 1e 31 3f fd <0f> 0b 48 89 f1 48 c7 c7 a0 2e e9 8a 48 89 de e8 0a 31 3f fd 0f 0b
RSP: 0018:ffffc900000079c0 EFLAGS: 00010086
RAX: 0000000000000075 RBX: ffff8880783659f8 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff816b8952 RDI: 0000000000000005
RBP: ffff88807eea00b8 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080010004 R11: 0000000000000001 R12: ffff88807eea0120
R13: ffff88807eea3c00 R14: ffff8880b993c820 R15: ffff8880b993d228
FS:  00007ff93a3616c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002002b000 CR3: 0000000020467000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess):
   0:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   5:	48 81 fa a8 02 00 00 	cmp    $0x2a8,%rdx
   c:	72 05                	jb     0x13
   e:	40 38 fe             	cmp    %dil,%sil
  11:	74 47                	je     0x5a
  13:	48 83 ea 20          	sub    $0x20,%rdx
  17:	48 83 ea 20          	sub    $0x20,%rdx
  1b:	4c 8b 1e             	mov    (%rsi),%r11
  1e:	4c 8b 56 08          	mov    0x8(%rsi),%r10
  22:	4c 8b 4e 10          	mov    0x10(%rsi),%r9
  26:	4c 8b 46 18          	mov    0x18(%rsi),%r8
* 2a:	48 8d 76 20          	lea    0x20(%rsi),%rsi <-- trapping instruction
  2e:	4c 89 1f             	mov    %r11,(%rdi)
  31:	4c 89 57 08          	mov    %r10,0x8(%rdi)
  35:	4c 89 4f 10          	mov    %r9,0x10(%rdi)
  39:	4c 89 47 18          	mov    %r8,0x18(%rdi)
  3d:	48                   	rex.W
  3e:	8d                   	.byte 0x8d
  3f:	7f                   	.byte 0x7f


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

