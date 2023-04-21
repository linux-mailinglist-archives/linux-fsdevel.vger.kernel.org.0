Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85426EA754
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 11:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbjDUJm7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 05:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjDUJm5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 05:42:57 -0400
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D011731
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Apr 2023 02:42:53 -0700 (PDT)
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7606d443ba6so165251139f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Apr 2023 02:42:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682070173; x=1684662173;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k+doIkGbHNvgtytivfPKeTi3/jbopCxx03zDWuWc3N8=;
        b=ZlBbd9y18NZ+luqJvZYLaX1pZ5WpesfalOn+nZGB+wVi0+h77txneieWpLOfJ16Pmw
         KO5D9aIKAodbIptggQZIst85e2GikEiPTRH481lOJeAel4FnainnJSkvE9gIfynBVJQq
         q+wNpV/KCKrsFsXAO/juLOUnLnFKSP6tiW6JQvRZtXqJaDdXG2fHwiT6Sx3mLe8KGeNA
         ZJ66FXXLhaNH3tODuHUykCOkSjJ+3wunZXE1cIUtYM8U4EJukM4+xyy7wyQpnYCsQUjb
         m1MS9OAca9WiUBMHzn03oBNXQqYvBOge/ZpS6J1u4zrLQd06KpIYeUHvyEwGhpoWsOw4
         Yyhg==
X-Gm-Message-State: AAQBX9f8A4fnpS/ymxT2Q3EvwqoC/Q5vS4M3RWVKs+QX2NKZAopGsvyS
        XWjzmWuInnzu4WwYgbCpy2ek8t84c5hVIt8+xGeqTJPeO6pK
X-Google-Smtp-Source: AKy350YxYk8hdDG7weA1jFpdy9a5y7y3EYsoLH1J1NGHOq9nDCdM9s8BfniGgTBrZXjqmZ8J/lgYSFlmoLdr9+v17kt244uLqyXV
MIME-Version: 1.0
X-Received: by 2002:a02:a10a:0:b0:40d:691d:6b6b with SMTP id
 f10-20020a02a10a000000b0040d691d6b6bmr2220789jag.3.1682070172819; Fri, 21 Apr
 2023 02:42:52 -0700 (PDT)
Date:   Fri, 21 Apr 2023 02:42:52 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000236c3705f9d57bf9@google.com>
Subject: [syzbot] [fs?] possible deadlock in evdev_pass_values (2)
From:   syzbot <syzbot+13d3cb2a3dc61e6092f5@syzkaller.appspotmail.com>
To:     brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    789b4a41c247 Merge tag 'nfsd-6.3-6' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=118040dbc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=11869c60f54496a7
dashboard link: https://syzkaller.appspot.com/bug?extid=13d3cb2a3dc61e6092f5
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/90f29018f16a/disk-789b4a41.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ac188d8e85c0/vmlinux-789b4a41.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1d8c814b8041/bzImage-789b4a41.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+13d3cb2a3dc61e6092f5@syzkaller.appspotmail.com

=====================================================
WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
6.3.0-rc7-syzkaller-00060-g789b4a41c247 #0 Not tainted
-----------------------------------------------------
syz-executor.5/27899 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
ffffffff8c40a098 (tasklist_lock){.+.+}-{2:2}, at: send_sigio+0xaf/0x3b0 fs/fcntl.c:793

and this task is already holding:
ffff88802a901a30 (&f->f_owner.lock){...-}-{2:2}, at: send_sigio+0x28/0x3b0 fs/fcntl.c:779
which would create a new lock dependency:
 (&f->f_owner.lock){...-}-{2:2} -> (tasklist_lock){.+.+}-{2:2}

but this new dependency connects a SOFTIRQ-irq-safe lock:
 (&client->buffer_lock){..-.}-{2:2}

... which became SOFTIRQ-irq-safe at:
  lock_acquire kernel/locking/lockdep.c:5669 [inline]
  lock_acquire+0x1af/0x520 kernel/locking/lockdep.c:5634
  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
  _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
  spin_lock include/linux/spinlock.h:350 [inline]
  evdev_pass_values.part.0+0xf6/0x960 drivers/input/evdev.c:261
  evdev_pass_values drivers/input/evdev.c:253 [inline]
  evdev_events+0x3b4/0x430 drivers/input/evdev.c:306
  input_to_handler+0x2a0/0x4c0 drivers/input/input.c:129
  input_pass_values.part.0+0x230/0x760 drivers/input/input.c:161
  input_pass_values drivers/input/input.c:148 [inline]
  input_event_dispose+0x5cf/0x730 drivers/input/input.c:376
  input_handle_event+0x120/0xe70 drivers/input/input.c:404
  input_event drivers/input/input.c:433 [inline]
  input_event+0x83/0xa0 drivers/input/input.c:425
  input_sync include/linux/input.h:450 [inline]
  hidinput_report_event+0xb2/0x100 drivers/hid/hid-input.c:1716
  hid_report_raw_event+0x35a/0x1220 drivers/hid/hid-core.c:2016
  hid_input_report+0x341/0x440 drivers/hid/hid-core.c:2083
  hid_irq_in+0x357/0x840 drivers/hid/usbhid/hid-core.c:284
  __usb_hcd_giveback_urb+0x2b6/0x5c0 drivers/usb/core/hcd.c:1671
  usb_hcd_giveback_urb+0x384/0x430 drivers/usb/core/hcd.c:1754
  dummy_timer+0x13b6/0x3400 drivers/usb/gadget/udc/dummy_hcd.c:1988
  call_timer_fn+0x1a0/0x580 kernel/time/timer.c:1700
  expire_timers+0x29b/0x4b0 kernel/time/timer.c:1751
  __run_timers kernel/time/timer.c:2022 [inline]
  __run_timers kernel/time/timer.c:1995 [inline]
  run_timer_softirq+0x326/0x910 kernel/time/timer.c:2035
  __do_softirq+0x1d4/0x905 kernel/softirq.c:571
  invoke_softirq kernel/softirq.c:445 [inline]
  __irq_exit_rcu+0x114/0x190 kernel/softirq.c:650
  irq_exit_rcu+0x9/0x20 kernel/softirq.c:662
  sysvec_apic_timer_interrupt+0x97/0xc0 arch/x86/kernel/apic/apic.c:1107
  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
  native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
  arch_safe_halt arch/x86/include/asm/irqflags.h:86 [inline]
  acpi_safe_halt+0x40/0x50 drivers/acpi/processor_idle.c:112
  acpi_idle_do_entry+0x53/0x70 drivers/acpi/processor_idle.c:573
  acpi_idle_enter+0x173/0x290 drivers/acpi/processor_idle.c:711
  cpuidle_enter_state+0xd3/0x6f0 drivers/cpuidle/cpuidle.c:267
  cpuidle_enter+0x4e/0xa0 drivers/cpuidle/cpuidle.c:388
  cpuidle_idle_call kernel/sched/idle.c:215 [inline]
  do_idle+0x305/0x3e0 kernel/sched/idle.c:282
  cpu_startup_entry+0x18/0x20 kernel/sched/idle.c:379
  rest_init+0x16d/0x2b0 init/main.c:736
  arch_call_rest_init+0x13/0x30 init/main.c:898
  start_kernel+0x35a/0x4d0 init/main.c:1152
  secondary_startup_64_no_verify+0xce/0xdb

to a SOFTIRQ-irq-unsafe lock:
 (tasklist_lock){.+.+}-{2:2}

... which became SOFTIRQ-irq-unsafe at:
...
  lock_acquire kernel/locking/lockdep.c:5669 [inline]
  lock_acquire+0x1af/0x520 kernel/locking/lockdep.c:5634
  __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
  _raw_read_lock+0x5f/0x70 kernel/locking/spinlock.c:228
  do_wait+0x283/0xc30 kernel/exit.c:1602
  kernel_wait+0xa0/0x150 kernel/exit.c:1792
  call_usermodehelper_exec_sync kernel/umh.c:137 [inline]
  call_usermodehelper_exec_work+0xf9/0x180 kernel/umh.c:164
  process_one_work+0x991/0x15c0 kernel/workqueue.c:2390
  worker_thread+0x669/0x1090 kernel/workqueue.c:2537
  kthread+0x2e8/0x3a0 kernel/kthread.c:376
  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

other info that might help us debug this:

Chain exists of:
  &client->buffer_lock --> &f->f_owner.lock --> tasklist_lock

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(tasklist_lock);
                               local_irq_disable();
                               lock(&client->buffer_lock);
                               lock(&f->f_owner.lock);
  <Interrupt>
    lock(&client->buffer_lock);

 *** DEADLOCK ***

5 locks held by syz-executor.5/27899:
 #0: ffffffff8c978ef0 (file_rwsem){.+.+}-{0:0}, at: break_lease include/linux/filelock.h:360 [inline]
 #0: ffffffff8c978ef0 (file_rwsem){.+.+}-{0:0}, at: break_lease include/linux/filelock.h:350 [inline]
 #0: ffffffff8c978ef0 (file_rwsem){.+.+}-{0:0}, at: do_dentry_open+0x65e/0x13f0 fs/open.c:911
 #1: ffff88801d8dcbc8 (&ctx->flc_lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:350 [inline]
 #1: ffff88801d8dcbc8 (&ctx->flc_lock){+.+.}-{2:2}, at: __break_lease+0x20c/0x12d0 fs/locks.c:1494
 #2: ffffffff8c7955c0 (rcu_read_lock){....}-{1:2}, at: kill_fasync+0x45/0x4f0 fs/fcntl.c:1016
 #3: ffff88807bdf6c90 (&new->fa_lock){....}-{2:2}, at: kill_fasync_rcu fs/fcntl.c:997 [inline]
 #3: ffff88807bdf6c90 (&new->fa_lock){....}-{2:2}, at: kill_fasync fs/fcntl.c:1018 [inline]
 #3: ffff88807bdf6c90 (&new->fa_lock){....}-{2:2}, at: kill_fasync+0x139/0x4f0 fs/fcntl.c:1011
 #4: ffff88802a901a30 (&f->f_owner.lock){...-}-{2:2}, at: send_sigio+0x28/0x3b0 fs/fcntl.c:779

the dependencies between SOFTIRQ-irq-safe lock and the holding lock:
  -> (&client->buffer_lock){..-.}-{2:2} {
     IN-SOFTIRQ-W at:
                        lock_acquire kernel/locking/lockdep.c:5669 [inline]
                        lock_acquire+0x1af/0x520 kernel/locking/lockdep.c:5634
                        __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
                        _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
                        spin_lock include/linux/spinlock.h:350 [inline]
                        evdev_pass_values.part.0+0xf6/0x960 drivers/input/evdev.c:261
                        evdev_pass_values drivers/input/evdev.c:253 [inline]
                        evdev_events+0x3b4/0x430 drivers/input/evdev.c:306
                        input_to_handler+0x2a0/0x4c0 drivers/input/input.c:129
                        input_pass_values.part.0+0x230/0x760 drivers/input/input.c:161
                        input_pass_values drivers/input/input.c:148 [inline]
                        input_event_dispose+0x5cf/0x730 drivers/input/input.c:376
                        input_handle_event+0x120/0xe70 drivers/input/input.c:404
                        input_event drivers/input/input.c:433 [inline]
                        input_event+0x83/0xa0 drivers/input/input.c:425
                        input_sync include/linux/input.h:450 [inline]
                        hidinput_report_event+0xb2/0x100 drivers/hid/hid-input.c:1716
                        hid_report_raw_event+0x35a/0x1220 drivers/hid/hid-core.c:2016
                        hid_input_report+0x341/0x440 drivers/hid/hid-core.c:2083
                        hid_irq_in+0x357/0x840 drivers/hid/usbhid/hid-core.c:284
                        __usb_hcd_giveback_urb+0x2b6/0x5c0 drivers/usb/core/hcd.c:1671
                        usb_hcd_giveback_urb+0x384/0x430 drivers/usb/core/hcd.c:1754
                        dummy_timer+0x13b6/0x3400 drivers/usb/gadget/udc/dummy_hcd.c:1988
                        call_timer_fn+0x1a0/0x580 kernel/time/timer.c:1700
                        expire_timers+0x29b/0x4b0 kernel/time/timer.c:1751
                        __run_timers kernel/time/timer.c:2022 [inline]
                        __run_timers kernel/time/timer.c:1995 [inline]
                        run_timer_softirq+0x326/0x910 kernel/time/timer.c:2035
                        __do_softirq+0x1d4/0x905 kernel/softirq.c:571
                        invoke_softirq kernel/softirq.c:445 [inline]
                        __irq_exit_rcu+0x114/0x190 kernel/softirq.c:650
                        irq_exit_rcu+0x9/0x20 kernel/softirq.c:662
                        sysvec_apic_timer_interrupt+0x97/0xc0 arch/x86/kernel/apic/apic.c:1107
                        asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
                        native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
                        arch_safe_halt arch/x86/include/asm/irqflags.h:86 [inline]
                        acpi_safe_halt+0x40/0x50 drivers/acpi/processor_idle.c:112
                        acpi_idle_do_entry+0x53/0x70 drivers/acpi/processor_idle.c:573
                        acpi_idle_enter+0x173/0x290 drivers/acpi/processor_idle.c:711
                        cpuidle_enter_state+0xd3/0x6f0 drivers/cpuidle/cpuidle.c:267
                        cpuidle_enter+0x4e/0xa0 drivers/cpuidle/cpuidle.c:388
                        cpuidle_idle_call kernel/sched/idle.c:215 [inline]
                        do_idle+0x305/0x3e0 kernel/sched/idle.c:282
                        cpu_startup_entry+0x18/0x20 kernel/sched/idle.c:379
                        rest_init+0x16d/0x2b0 init/main.c:736
                        arch_call_rest_init+0x13/0x30 init/main.c:898
                        start_kernel+0x35a/0x4d0 init/main.c:1152
                        secondary_startup_64_no_verify+0xce/0xdb
     INITIAL USE at:
                       lock_acquire kernel/locking/lockdep.c:5669 [inline]
                       lock_acquire+0x1af/0x520 kernel/locking/lockdep.c:5634
                       __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
                       _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
                       spin_lock include/linux/spinlock.h:350 [inline]
                       evdev_pass_values.part.0+0xf6/0x960 drivers/input/evdev.c:261
                       evdev_pass_values drivers/input/evdev.c:253 [inline]
                       evdev_events+0x3b4/0x430 drivers/input/evdev.c:306
                       input_to_handler+0x2a0/0x4c0 drivers/input/input.c:129
                       input_pass_values.part.0+0x230/0x760 drivers/input/input.c:161
                       input_pass_values drivers/input/input.c:148 [inline]
                       input_event_dispose+0x5cf/0x730 drivers/input/input.c:376
                       input_handle_event+0x120/0xe70 drivers/input/input.c:404
                       input_inject_event+0x1c7/0x390 drivers/input/input.c:463
                       evdev_write+0x434/0x760 drivers/input/evdev.c:530
                       vfs_write+0x2db/0xe10 fs/read_write.c:582
                       ksys_write+0x1ec/0x250 fs/read_write.c:637
                       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
                       entry_SYSCALL_64_after_hwframe+0x63/0xcd
   }
   ... key      at: [<ffffffff920bef20>] __key.3+0x0/0x40
 -> (&new->fa_lock){....}-{2:2} {
    INITIAL USE at:
                     lock_acquire kernel/locking/lockdep.c:5669 [inline]
                     lock_acquire+0x1af/0x520 kernel/locking/lockdep.c:5634
                     __raw_write_lock_irq include/linux/rwlock_api_smp.h:195 [inline]
                     _raw_write_lock_irq+0x36/0x50 kernel/locking/spinlock.c:326
                     fasync_remove_entry+0xba/0x1f0 fs/fcntl.c:874
                     fasync_helper+0xa2/0xb0 fs/fcntl.c:977
                     tun_chr_fasync+0x54/0x170 drivers/net/tun.c:3419
                     __fput+0x8c2/0xa90 fs/file_table.c:318
                     task_work_run+0x16f/0x270 kernel/task_work.c:179
                     resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
                     exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
                     exit_to_user_mode_prepare+0x210/0x240 kernel/entry/common.c:204
                     __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
                     syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:297
                     do_syscall_64+0x46/0xb0 arch/x86/entry/common.c:86
                     entry_SYSCALL_64_after_hwframe+0x63/0xcd
    INITIAL READ USE at:
                          lock_acquire kernel/locking/lockdep.c:5669 [inline]
                          lock_acquire+0x1af/0x520 kernel/locking/lockdep.c:5634
                          __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
                          _raw_read_lock_irqsave+0x74/0x90 kernel/locking/spinlock.c:236
                          kill_fasync_rcu fs/fcntl.c:997 [inline]
                          kill_fasync fs/fcntl.c:1018 [inline]
                          kill_fasync+0x139/0x4f0 fs/fcntl.c:1011
                          sock_wake_async+0xd6/0x160 net/socket.c:1449
                          sk_wake_async include/net/sock.h:2518 [inline]
                          sk_wake_async+0x108/0x2f0 include/net/sock.h:2514
                          tcp_rcv_state_process+0x2faf/0x4a10 net/ipv4/tcp_input.c:6571
                          tcp_v6_do_rcv+0x400/0x15c0 net/ipv6/tcp_ipv6.c:1512
                          sk_backlog_rcv include/net/sock.h:1113 [inline]
                          __release_sock+0x133/0x3b0 net/core/sock.c:2922
                          release_sock+0x58/0x1b0 net/core/sock.c:3489
                          inet_wait_for_connect net/ipv4/af_inet.c:596 [inline]
                          __inet_stream_connect+0x757/0xed0 net/ipv4/af_inet.c:688
                          tcp_sendmsg_fastopen+0x3c4/0x710 net/ipv4/tcp.c:1201
                          tcp_sendmsg_locked+0x1a0b/0x2950 net/ipv4/tcp.c:1249
                          tcp_sendmsg+0x2f/0x50 net/ipv4/tcp.c:1484
                          inet6_sendmsg+0x9d/0xe0 net/ipv6/af_inet6.c:651
                          sock_sendmsg_nosec net/socket.c:724 [inline]
                          sock_sendmsg+0xde/0x190 net/socket.c:747
                          __sys_sendto+0x23a/0x340 net/socket.c:2142
                          __do_sys_sendto net/socket.c:2154 [inline]
                          __se_sys_sendto net/socket.c:2150 [inline]
                          __x64_sys_sendto+0xe1/0x1b0 net/socket.c:2150
                          do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                          do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
                          entry_SYSCALL_64_after_hwframe+0x63/0xcd
  }
  ... key      at: [<ffffffff91e17f20>] __key.0+0x0/0x40
  ... acquired at:
   __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
   _raw_read_lock_irqsave+0x74/0x90 kernel/locking/spinlock.c:236
   kill_fasync_rcu fs/fcntl.c:997 [inline]
   kill_fasync fs/fcntl.c:1018 [inline]
   kill_fasync+0x139/0x4f0 fs/fcntl.c:1011
   __pass_event drivers/input/evdev.c:240 [inline]
   evdev_pass_values.part.0+0x667/0x960 drivers/input/evdev.c:278
   evdev_pass_values drivers/input/evdev.c:253 [inline]
   evdev_events+0x3b4/0x430 drivers/input/evdev.c:306
   input_to_handler+0x2a0/0x4c0 drivers/input/input.c:129
   input_pass_values.part.0+0x230/0x760 drivers/input/input.c:161
   input_pass_values drivers/input/input.c:148 [inline]
   input_event_dispose+0x5cf/0x730 drivers/input/input.c:376
   input_handle_event+0x120/0xe70 drivers/input/input.c:404
   input_inject_event+0x1c7/0x390 drivers/input/input.c:463
   evdev_write+0x434/0x760 drivers/input/evdev.c:530
   vfs_write+0x2db/0xe10 fs/read_write.c:582
   ksys_write+0x1ec/0x250 fs/read_write.c:637
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> (&f->f_owner.lock){...-}-{2:2} {
   IN-SOFTIRQ-R at:
                    lock_acquire kernel/locking/lockdep.c:5669 [inline]
                    lock_acquire+0x1af/0x520 kernel/locking/lockdep.c:5634
                    __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
                    _raw_read_lock_irqsave+0x49/0x90 kernel/locking/spinlock.c:236
                    send_sigurg+0x22/0xbd0 fs/fcntl.c:818
                    sk_send_sigurg+0x7a/0x370 net/core/sock.c:3351
                    tcp_check_urg net/ipv4/tcp_input.c:5626 [inline]
                    tcp_urg+0x38e/0xb40 net/ipv4/tcp_input.c:5667
                    tcp_rcv_established+0x817/0x1f80 net/ipv4/tcp_input.c:6014
                    tcp_v4_do_rcv+0x663/0x9d0 net/ipv4/tcp_ipv4.c:1721
                    tcp_v4_rcv+0x2eac/0x3280 net/ipv4/tcp_ipv4.c:2143
                    ip_protocol_deliver_rcu+0x9f/0x480 net/ipv4/ip_input.c:205
                    ip_local_deliver_finish+0x2ec/0x520 net/ipv4/ip_input.c:233
                    NF_HOOK include/linux/netfilter.h:302 [inline]
                    NF_HOOK include/linux/netfilter.h:296 [inline]
                    ip_local_deliver+0x1ae/0x200 net/ipv4/ip_input.c:254
                    dst_input include/net/dst.h:454 [inline]
                    ip_rcv_finish+0x1cf/0x2f0 net/ipv4/ip_input.c:449
                    NF_HOOK include/linux/netfilter.h:302 [inline]
                    NF_HOOK include/linux/netfilter.h:296 [inline]
                    ip_rcv+0xae/0xd0 net/ipv4/ip_input.c:569
                    __netif_receive_skb_one_core+0x114/0x180 net/core/dev.c:5480
                    __netif_receive_skb+0x1f/0x1c0 net/core/dev.c:5594
                    process_backlog+0x239/0x800 net/core/dev.c:5922
                    __napi_poll+0xb7/0x6f0 net/core/dev.c:6483
                    napi_poll net/core/dev.c:6550 [inline]
                    net_rx_action+0x9c2/0xd80 net/core/dev.c:6660
                    __do_softirq+0x1d4/0x905 kernel/softirq.c:571
                    run_ksoftirqd kernel/softirq.c:934 [inline]
                    run_ksoftirqd+0x31/0x60 kernel/softirq.c:926
                    smpboot_thread_fn+0x659/0x9e0 kernel/smpboot.c:164
                    kthread+0x2e8/0x3a0 kernel/kthread.c:376
                    ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
   INITIAL USE at:
                   lock_acquire kernel/locking/lockdep.c:5669 [inline]
                   lock_acquire+0x1af/0x520 kernel/locking/lockdep.c:5634
                   __raw_write_lock_irq include/linux/rwlock_api_smp.h:195 [inline]
                   _raw_write_lock_irq+0x36/0x50 kernel/locking/spinlock.c:326
                   f_modown+0x2a/0x390 fs/fcntl.c:92
                   __f_setown fs/fcntl.c:111 [inline]
                   f_setown_ex fs/fcntl.c:201 [inline]
                   do_fcntl+0xb39/0x1240 fs/fcntl.c:384
                   __do_sys_fcntl fs/fcntl.c:455 [inline]
                   __se_sys_fcntl fs/fcntl.c:440 [inline]
                   __x64_sys_fcntl+0x163/0x1d0 fs/fcntl.c:440
                   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                   do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
                   entry_SYSCALL_64_after_hwframe+0x63/0xcd
   INITIAL READ USE at:
                        lock_acquire kernel/locking/lockdep.c:5669 [inline]
                        lock_acquire+0x1af/0x520 kernel/locking/lockdep.c:5634
                        __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
                        _raw_read_lock_irqsave+0x74/0x90 kernel/locking/spinlock.c:236
                        send_sigurg+0x22/0xbd0 fs/fcntl.c:818
                        sk_send_sigurg+0x7a/0x370 net/core/sock.c:3351
                        tcp_check_urg net/ipv4/tcp_input.c:5626 [inline]
                        tcp_urg+0x38e/0xb40 net/ipv4/tcp_input.c:5667
                        tcp_rcv_established+0x817/0x1f80 net/ipv4/tcp_input.c:6014
                        tcp_v4_do_rcv+0x663/0x9d0 net/ipv4/tcp_ipv4.c:1721
                        sk_backlog_rcv include/net/sock.h:1113 [inline]
                        __release_sock+0x133/0x3b0 net/core/sock.c:2922
                        release_sock+0x58/0x1b0 net/core/sock.c:3489
                        sk_stream_wait_memory+0x72f/0xf30 net/core/stream.c:145
                        tcp_sendmsg_locked+0x944/0x2950 net/ipv4/tcp.c:1446
                        tcp_sendmsg+0x2f/0x50 net/ipv4/tcp.c:1484
                        inet_sendmsg+0x9d/0xe0 net/ipv4/af_inet.c:825
                        sock_sendmsg_nosec net/socket.c:724 [inline]
                        sock_sendmsg+0xde/0x190 net/socket.c:747
                        __sys_sendto+0x23a/0x340 net/socket.c:2142
                        __do_sys_sendto net/socket.c:2154 [inline]
                        __se_sys_sendto net/socket.c:2150 [inline]
                        __x64_sys_sendto+0xe1/0x1b0 net/socket.c:2150
                        do_syscall_x64 arch/x86/entry/common.c:50 [inline]
                        do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
                        entry_SYSCALL_64_after_hwframe+0x63/0xcd
 }
 ... key      at: [<ffffffff91e17100>] __key.5+0x0/0x40
 ... acquired at:
   __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
   _raw_read_lock_irqsave+0x74/0x90 kernel/locking/spinlock.c:236
   send_sigio+0x28/0x3b0 fs/fcntl.c:779
   kill_fasync_rcu fs/fcntl.c:1004 [inline]
   kill_fasync fs/fcntl.c:1018 [inline]
   kill_fasync+0x1fb/0x4f0 fs/fcntl.c:1011
   sock_wake_async+0xd6/0x160 net/socket.c:1449
   sk_wake_async include/net/sock.h:2518 [inline]
   sk_wake_async+0x108/0x2f0 include/net/sock.h:2514
   tcp_rcv_state_process+0x2faf/0x4a10 net/ipv4/tcp_input.c:6571
   tcp_v6_do_rcv+0x400/0x15c0 net/ipv6/tcp_ipv6.c:1512
   sk_backlog_rcv include/net/sock.h:1113 [inline]
   __release_sock+0x133/0x3b0 net/core/sock.c:2922
   release_sock+0x58/0x1b0 net/core/sock.c:3489
   inet_wait_for_connect net/ipv4/af_inet.c:596 [inline]
   __inet_stream_connect+0x757/0xed0 net/ipv4/af_inet.c:688
   tcp_sendmsg_fastopen+0x3c4/0x710 net/ipv4/tcp.c:1201
   tcp_sendmsg_locked+0x1a0b/0x2950 net/ipv4/tcp.c:1249
   tcp_sendmsg+0x2f/0x50 net/ipv4/tcp.c:1484
   inet6_sendmsg+0x9d/0xe0 net/ipv6/af_inet6.c:651
   sock_sendmsg_nosec net/socket.c:724 [inline]
   sock_sendmsg+0xde/0x190 net/socket.c:747
   __sys_sendto+0x23a/0x340 net/socket.c:2142
   __do_sys_sendto net/socket.c:2154 [inline]
   __se_sys_sendto net/socket.c:2150 [inline]
   __x64_sys_sendto+0xe1/0x1b0 net/socket.c:2150
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x63/0xcd


the dependencies between the lock to be acquired
 and SOFTIRQ-irq-unsafe lock:
-> (tasklist_lock){.+.+}-{2:2} {
   HARDIRQ-ON-R at:
                    lock_acquire kernel/locking/lockdep.c:5669 [inline]
                    lock_acquire+0x1af/0x520 kernel/locking/lockdep.c:5634
                    __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
                    _raw_read_lock+0x5f/0x70 kernel/locking/spinlock.c:228
                    do_wait+0x283/0xc30 kernel/exit.c:1602
                    kernel_wait+0xa0/0x150 kernel/exit.c:1792
                    call_usermodehelper_exec_sync kernel/umh.c:137 [inline]
                    call_usermodehelper_exec_work+0xf9/0x180 kernel/umh.c:164
                    process_one_work+0x991/0x15c0 kernel/workqueue.c:2390
                    worker_thread+0x669/0x1090 kernel/workqueue.c:2537
                    kthread+0x2e8/0x3a0 kernel/kthread.c:376
                    ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
   SOFTIRQ-ON-R at:
                    lock_acquire kernel/locking/lockdep.c:5669 [inline]
                    lock_acquire+0x1af/0x520 kernel/locking/lockdep.c:5634
                    __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
                    _raw_read_lock+0x5f/0x70 kernel/locking/spinlock.c:228
                    do_wait+0x283/0xc30 kernel/exit.c:1602
                    kernel_wait+0xa0/0x150 kernel/exit.c:1792
                    call_usermodehelper_exec_sync kernel/umh.c:137 [inline]
                    call_usermodehelper_exec_work+0xf9/0x180 kernel/umh.c:164
                    process_one_work+0x991/0x15c0 kernel/workqueue.c:2390
                    worker_thread+0x669/0x1090 kernel/workqueue.c:2537
                    kthread+0x2e8/0x3a0 kernel/kthread.c:376
                    ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
   INITIAL USE at:
                   lock_acquire kernel/locking/lockdep.c:5669 [inline]
                   lock_acquire+0x1af/0x520 kernel/locking/lockdep.c:5634
                   __raw_write_lock_irq include/linux/rwlock_api_smp.h:195 [inline]
                   _raw_write_lock_irq+0x36/0x50 kernel/locking/spinlock.c:326
                   copy_process+0x47e5/0x7590 kernel/fork.c:2401
                   kernel_clone+0xeb/0x890 kernel/fork.c:2682
                   user_mode_thread+0xb1/0xf0 kernel/fork.c:2758
                   rest_init+0x27/0x2b0 init/main.c:701
                   arch_call_rest_init+0x13/0x30 init/main.c:898
                   start_kernel+0x35a/0x4d0 init/main.c:1152
                   secondary_startup_64_no_verify+0xce/0xdb
   INITIAL READ USE at:
                        lock_acquire kernel/locking/lockdep.c:5669 [inline]
                        lock_acquire+0x1af/0x520 kernel/locking/lockdep.c:5634
                        __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
                        _raw_read_lock+0x5f/0x70 kernel/locking/spinlock.c:228
                        do_wait+0x283/0xc30 kernel/exit.c:1602
                        kernel_wait+0xa0/0x150 kernel/exit.c:1792
                        call_usermodehelper_exec_sync kernel/umh.c:137 [inline]
                        call_usermodehelper_exec_work+0xf9/0x180 kernel/umh.c:164
                        process_one_work+0x991/0x15c0 kernel/workqueue.c:2390
                        worker_thread+0x669/0x1090 kernel/workqueue.c:2537
                        kthread+0x2e8/0x3a0 kernel/kthread.c:376
                        ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 }
 ... key      at: [<ffffffff8c40a098>] tasklist_lock+0x18/0x40
 ... acquired at:
   lock_acquire kernel/locking/lockdep.c:5669 [inline]
   lock_acquire+0x1af/0x520 kernel/locking/lockdep.c:5634
   __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
   _raw_read_lock+0x5f/0x70 kernel/locking/spinlock.c:228
   send_sigio+0xaf/0x3b0 fs/fcntl.c:793
   kill_fasync_rcu fs/fcntl.c:1004 [inline]
   kill_fasync fs/fcntl.c:1018 [inline]
   kill_fasync+0x1fb/0x4f0 fs/fcntl.c:1011
   lease_break_callback+0x23/0x30 fs/locks.c:522
   __break_lease+0x3db/0x12d0 fs/locks.c:1522
   break_lease include/linux/filelock.h:360 [inline]
   break_lease include/linux/filelock.h:350 [inline]
   do_dentry_open+0x65e/0x13f0 fs/open.c:911
   do_open fs/namei.c:3560 [inline]
   path_openat+0x1baa/0x2750 fs/namei.c:3715
   do_filp_open+0x1ba/0x410 fs/namei.c:3742
   do_sys_openat2+0x16d/0x4c0 fs/open.c:1348
   do_sys_open fs/open.c:1364 [inline]
   __do_sys_open fs/open.c:1372 [inline]
   __se_sys_open fs/open.c:1368 [inline]
   __x64_sys_open+0x11d/0x1c0 fs/open.c:1368
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x63/0xcd


stack backtrace:
CPU: 0 PID: 27899 Comm: syz-executor.5 Not tainted 6.3.0-rc7-syzkaller-00060-g789b4a41c247 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_bad_irq_dependency kernel/locking/lockdep.c:2612 [inline]
 check_irq_usage+0x114e/0x1a40 kernel/locking/lockdep.c:2851
 check_prev_add kernel/locking/lockdep.c:3102 [inline]
 check_prevs_add kernel/locking/lockdep.c:3217 [inline]
 validate_chain kernel/locking/lockdep.c:3832 [inline]
 __lock_acquire+0x2edf/0x5d40 kernel/locking/lockdep.c:5056
 lock_acquire kernel/locking/lockdep.c:5669 [inline]
 lock_acquire+0x1af/0x520 kernel/locking/lockdep.c:5634
 __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
 _raw_read_lock+0x5f/0x70 kernel/locking/spinlock.c:228
 send_sigio+0xaf/0x3b0 fs/fcntl.c:793
 kill_fasync_rcu fs/fcntl.c:1004 [inline]
 kill_fasync fs/fcntl.c:1018 [inline]
 kill_fasync+0x1fb/0x4f0 fs/fcntl.c:1011
 lease_break_callback+0x23/0x30 fs/locks.c:522
 __break_lease+0x3db/0x12d0 fs/locks.c:1522
 break_lease include/linux/filelock.h:360 [inline]
 break_lease include/linux/filelock.h:350 [inline]
 do_dentry_open+0x65e/0x13f0 fs/open.c:911
 do_open fs/namei.c:3560 [inline]
 path_openat+0x1baa/0x2750 fs/namei.c:3715
 do_filp_open+0x1ba/0x410 fs/namei.c:3742
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1348
 do_sys_open fs/open.c:1364 [inline]
 __do_sys_open fs/open.c:1372 [inline]
 __se_sys_open fs/open.c:1368 [inline]
 __x64_sys_open+0x11d/0x1c0 fs/open.c:1368
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fe01088c169
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe0115c8168 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007fe0109abf80 RCX: 00007fe01088c169
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000200
RBP: 00007fe0108e7ca1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fe010acfb1f R14: 00007fe0115c8300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
