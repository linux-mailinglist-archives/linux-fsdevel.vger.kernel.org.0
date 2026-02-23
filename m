Return-Path: <linux-fsdevel+bounces-78014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +O+ZI1zZnGkFLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:49:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED51517E904
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC3033135639
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 22:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCB934EF0D;
	Mon, 23 Feb 2026 22:46:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C918037A48B
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 22:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771886784; cv=none; b=XPB2W5WuUA+DJVklP5DXw+BcreALI69FlFl/YRu6A3VUELuuGhY4nL1zBLGnvUwb2INF3gK+HV/8B2Mqcq1leUXU9mpAMhZcTqiEy9iuNxk8M7ftU3lbNRP9/5tuI1r8HTYT+pP8/V+TvmWxt5QtaFK+Dnuh0t1Rs4SiX6SCArc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771886784; c=relaxed/simple;
	bh=13o9NLgEoCqP1Ap4uH7/98T21xg3s3Va0L2pJz6B81I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fY3fflRafQGlxwTvNOTYdwpYTZR0fqt1Fh4Qt5cXhT2Nt+FPThKk2fFFFSpLCIYWbigY5EnK0vmjL8OLntc7zGmRG5XeF3sOrXh5LqlQqnlz2TYUpXuZRnJmGQrZW6L6t5I/27zdcUgRvxmi7IIbJcRRvFbBPrDCBIaN9YFWNkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7d4cb5810a0so30043048a34.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 14:46:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771886782; x=1772491582;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LT2GNLj/B8FRg8+Ky+lFSbSt8ypScGiesJFENKjpHXM=;
        b=aaMPgqn6Xx5k5xESpdFm3fA7shYFTlY9utSQ9+o1819lnZxneME3rIsSH57Wbs3Eei
         ioO4piJ1F/Z1BcOsgK/CwsSaK8UkgPwjINzbXqn8ru7sMlPYfi3JT6LEd6fyqNyKm192
         bbd1liruTM4To7SZyydqoYkR9Kl4RQ0XQLYPGemkR89Hyd2x/AckAp/liYQyPi55tnu4
         GcK7/5RhlrpxuZ5hNjhmJsyTId6oPpXBJgWaLLcK7ySrx+7wG1tr5laLGZF/4Qsmo/FA
         QjObyXzuqyzaLpFvBGsEksdpsex/QFErfkisxWDs6vbiupOjHwNf388vN/mC05X9AKKA
         iagQ==
X-Forwarded-Encrypted: i=1; AJvYcCVx/b257tD26aTt/enHxuGOcI/I9b/DUxB7BKTKs2Vys73uKpxJcbOJdoVjA58/BT4Xve9d0A5sWh6wydFE@vger.kernel.org
X-Gm-Message-State: AOJu0YxsrvXDtxazz4Zur5cbV+DBdoOJZOHgoOH2xm6FoAzKojfi1jJl
	FQxDmxc0Fx8Lehm2Yyn2CWK88O4wMYCdJaH6IqStkJ1ohW/Lxq2oD4qHmoNTgwwxVZq2zrE9PW/
	sWWnZmTeLwAEJR++0VEFUZOkmNICRfWzyPh4wIPD7nFxbq5F960LtdVU0BAE=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:cb17:0:b0:679:ddf5:5ef7 with SMTP id
 006d021491bc7-679ddf55fb8mr429250eaf.44.1771886781841; Mon, 23 Feb 2026
 14:46:21 -0800 (PST)
Date: Mon, 23 Feb 2026 14:46:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <699cd8bd.050a0220.247d23.0339.GAE@google.com>
Subject: [syzbot] [input?] possible deadlock in input_repeat_key
From: syzbot <syzbot+422e601066bf071a9f8e@syzkaller.appspotmail.com>
To: amir73il@gmail.com, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=665cbf0979cda6c5];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78014-lists,linux-fsdevel=lfdr.de,422e601066bf071a9f8e];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,suse.cz,vger.kernel.org,googlegroups.com];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlegroups.com:email,syzkaller.appspot.com:url,goo.gl:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email,storage.googleapis.com:url];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: ED51517E904
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    a95f71ad3e2e Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17db0152580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=665cbf0979cda6c5
dashboard link: https://syzkaller.appspot.com/bug?extid=422e601066bf071a9f8e
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3abe9dfc8715/disk-a95f71ad.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0a4dab480d10/vmlinux-a95f71ad.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d2eecb72d9bd/bzImage-a95f71ad.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+422e601066bf071a9f8e@syzkaller.appspotmail.com

=====================================================
WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
syzkaller #0 Tainted: G             L     
-----------------------------------------------------
syz.0.6889/23959 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
ffff88805533cf30 (&new->fa_lock){....}-{3:3}, at: kill_fasync_rcu fs/fcntl.c:1135 [inline]
ffff88805533cf30 (&new->fa_lock){....}-{3:3}, at: kill_fasync+0x199/0x4d0 fs/fcntl.c:1159

and this task is already holding:
ffff88802bb32230 (&dev->event_lock#2){..-.}-{3:3}, at: class_spinlock_irqsave_constructor include/linux/spinlock.h:618 [inline]
ffff88802bb32230 (&dev->event_lock#2){..-.}-{3:3}, at: input_inject_event+0xa5/0x340 drivers/input/input.c:419
which would create a new lock dependency:
 (&dev->event_lock#2){..-.}-{3:3} -> (&new->fa_lock){....}-{3:3}

but this new dependency connects a SOFTIRQ-irq-safe lock:
 (&dev->event_lock#2){..-.}-{3:3}

... which became SOFTIRQ-irq-safe at:
  lock_acquire+0xf0/0x2e0 kernel/locking/lockdep.c:5868
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:132 [inline]
  _raw_spin_lock_irqsave+0x40/0x60 kernel/locking/spinlock.c:162
  class_spinlock_irqsave_constructor include/linux/spinlock.h:618 [inline]
  input_repeat_key+0x33/0x680 drivers/input/input.c:2220
  call_timer_fn+0x192/0x640 kernel/time/timer.c:1748
  expire_timers kernel/time/timer.c:1799 [inline]
  __run_timers kernel/time/timer.c:2373 [inline]
  __run_timer_base+0x652/0x8b0 kernel/time/timer.c:2385
  run_timer_base kernel/time/timer.c:2394 [inline]
  run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2404
  handle_softirqs+0x22a/0x870 kernel/softirq.c:622
  __do_softirq kernel/softirq.c:656 [inline]
  invoke_softirq kernel/softirq.c:496 [inline]
  __irq_exit_rcu+0x5f/0x150 kernel/softirq.c:723
  irq_exit_rcu+0x9/0x30 kernel/softirq.c:739
  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1056 [inline]
  sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1056
  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
  rcu_is_watching+0x70/0xb0 kernel/rcu/tree.c:754
  rcu_read_lock_held_common kernel/rcu/update.c:109 [inline]
  rcu_read_lock_held+0x15/0x50 kernel/rcu/update.c:349
  mas_root lib/maple_tree.c:780 [inline]
  mas_start+0x1e9/0x560 lib/maple_tree.c:1200
  mas_state_walk lib/maple_tree.c:3291 [inline]
  mas_walk+0x8b/0x2e0 lib/maple_tree.c:4599
  lock_vma_under_rcu+0x1bd/0x500 mm/mmap_lock.c:304
  do_user_addr_fault+0x2d8/0x1340 arch/x86/mm/fault.c:1325
  handle_page_fault arch/x86/mm/fault.c:1474 [inline]
  exc_page_fault+0x6a/0xc0 arch/x86/mm/fault.c:1527
  asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:618

to a SOFTIRQ-irq-unsafe lock:
 (tasklist_lock){.+.+}-{3:3}

... which became SOFTIRQ-irq-unsafe at:
...
  lock_acquire+0xf0/0x2e0 kernel/locking/lockdep.c:5868
  __raw_read_lock include/linux/rwlock_api_smp.h:161 [inline]
  _raw_read_lock+0x36/0x50 kernel/locking/spinlock.c:228
  __do_wait+0xde/0x740 kernel/exit.c:1672
  do_wait+0x1e7/0x540 kernel/exit.c:1716
  kernel_wait+0xd6/0x1c0 kernel/exit.c:1892
  call_usermodehelper_exec_sync kernel/umh.c:136 [inline]
  call_usermodehelper_exec_work+0xbe/0x230 kernel/umh.c:163
  process_one_work kernel/workqueue.c:3275 [inline]
  process_scheduled_works+0xb02/0x1830 kernel/workqueue.c:3358
  worker_thread+0xa50/0xfc0 kernel/workqueue.c:3439
  kthread+0x388/0x470 kernel/kthread.c:467
  ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

other info that might help us debug this:

Chain exists of:
  &dev->event_lock#2 --> &new->fa_lock --> tasklist_lock

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(tasklist_lock);
                               local_irq_disable();
                               lock(&dev->event_lock#2);
                               lock(&new->fa_lock);
  <Interrupt>
    lock(&dev->event_lock#2);

 *** DEADLOCK ***

6 locks held by syz.0.6889/23959:
 #0: ffff88802bc7c118 (&evdev->mutex){+.+.}-{4:4}, at: evdev_write+0x1ae/0x4c0 drivers/input/evdev.c:511
 #1: ffff88802bb32230 (&dev->event_lock#2){..-.}-{3:3}, at: class_spinlock_irqsave_constructor include/linux/spinlock.h:618 [inline]
 #1: ffff88802bb32230 (&dev->event_lock#2){..-.}-{3:3}, at: input_inject_event+0xa5/0x340 drivers/input/input.c:419
 #2: ffffffff8e7602e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:312 [inline]
 #2: ffffffff8e7602e0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:850 [inline]
 #2: ffffffff8e7602e0 (rcu_read_lock){....}-{1:3}, at: class_rcu_constructor include/linux/rcupdate.h:1193 [inline]
 #2: ffffffff8e7602e0 (rcu_read_lock){....}-{1:3}, at: input_inject_event+0xb6/0x340 drivers/input/input.c:420
 #3: ffffffff8e7602e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:312 [inline]
 #3: ffffffff8e7602e0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:850 [inline]
 #3: ffffffff8e7602e0 (rcu_read_lock){....}-{1:3}, at: class_rcu_constructor include/linux/rcupdate.h:1193 [inline]
 #3: ffffffff8e7602e0 (rcu_read_lock){....}-{1:3}, at: input_pass_values+0x8d/0x890 drivers/input/input.c:119
 #4: ffffffff8e7602e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:312 [inline]
 #4: ffffffff8e7602e0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:850 [inline]
 #4: ffffffff8e7602e0 (rcu_read_lock){....}-{1:3}, at: mousedev_notify_readers+0x2c/0xc00 drivers/input/mousedev.c:269
 #5: ffffffff8e7602e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:312 [inline]
 #5: ffffffff8e7602e0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:850 [inline]
 #5: ffffffff8e7602e0 (rcu_read_lock){....}-{1:3}, at: kill_fasync+0x53/0x4d0 fs/fcntl.c:1158

the dependencies between SOFTIRQ-irq-safe lock and the holding lock:
-> (&dev->event_lock#2){..-.}-{3:3} {
   IN-SOFTIRQ-W at:
                    lock_acquire+0xf0/0x2e0 kernel/locking/lockdep.c:5868
                    __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:132 [inline]
                    _raw_spin_lock_irqsave+0x40/0x60 kernel/locking/spinlock.c:162
                    class_spinlock_irqsave_constructor include/linux/spinlock.h:618 [inline]
                    input_repeat_key+0x33/0x680 drivers/input/input.c:2220
                    call_timer_fn+0x192/0x640 kernel/time/timer.c:1748
                    expire_timers kernel/time/timer.c:1799 [inline]
                    __run_timers kernel/time/timer.c:2373 [inline]
                    __run_timer_base+0x652/0x8b0 kernel/time/timer.c:2385
                    run_timer_base kernel/time/timer.c:2394 [inline]
                    run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2404
                    handle_softirqs+0x22a/0x870 kernel/softirq.c:622
                    __do_softirq kernel/softirq.c:656 [inline]
                    invoke_softirq kernel/softirq.c:496 [inline]
                    __irq_exit_rcu+0x5f/0x150 kernel/softirq.c:723
                    irq_exit_rcu+0x9/0x30 kernel/softirq.c:739
                    instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1056 [inline]
                    sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1056
                    asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
                    rcu_is_watching+0x70/0xb0 kernel/rcu/tree.c:754
                    rcu_read_lock_held_common kernel/rcu/update.c:109 [inline]
                    rcu_read_lock_held+0x15/0x50 kernel/rcu/update.c:349
                    mas_root lib/maple_tree.c:780 [inline]
                    mas_start+0x1e9/0x560 lib/maple_tree.c:1200
                    mas_state_walk lib/maple_tree.c:3291 [inline]
                    mas_walk+0x8b/0x2e0 lib/maple_tree.c:4599
                    lock_vma_under_rcu+0x1bd/0x500 mm/mmap_lock.c:304
                    do_user_addr_fault+0x2d8/0x1340 arch/x86/mm/fault.c:1325
                    handle_page_fault arch/x86/mm/fault.c:1474 [inline]
                    exc_page_fault+0x6a/0xc0 arch/x86/mm/fault.c:1527
                    asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:618
   INITIAL USE at:
                   lock_acquire+0xf0/0x2e0 kernel/locking/lockdep.c:5868
                   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:132 [inline]
                   _raw_spin_lock_irqsave+0x40/0x60 kernel/locking/spinlock.c:162
                   class_spinlock_irqsave_constructor include/linux/spinlock.h:618 [inline]
                   input_inject_event+0xa5/0x340 drivers/input/input.c:419
                   kbd_led_trigger_activate+0xbc/0x100 drivers/tty/vt/keyboard.c:1021
                   led_trigger_set+0x535/0x960 drivers/leds/led-triggers.c:220
                   led_match_default_trigger drivers/leds/led-triggers.c:277 [inline]
                   led_trigger_set_default+0x260/0x2a0 drivers/leds/led-triggers.c:300
                   led_classdev_register_ext+0x787/0x9c0 drivers/leds/led-class.c:578
                   led_classdev_register include/linux/leds.h:274 [inline]
                   input_leds_connect+0x517/0x790 drivers/input/input-leds.c:145
                   input_attach_handler drivers/input/input.c:994 [inline]
                   input_register_device+0xd00/0x1160 drivers/input/input.c:2378
                   atkbd_connect+0x731/0xa50 drivers/input/keyboard/atkbd.c:1340
                   serio_connect_driver drivers/input/serio/serio.c:44 [inline]
                   serio_driver_probe+0x82/0xd0 drivers/input/serio/serio.c:748
                   call_driver_probe drivers/base/dd.c:-1 [inline]
                   really_probe+0x267/0xaf0 drivers/base/dd.c:661
                   __driver_probe_device+0x18c/0x320 drivers/base/dd.c:803
                   driver_probe_device+0x4f/0x240 drivers/base/dd.c:833
                   __driver_attach+0x3e7/0x710 drivers/base/dd.c:1227
                   bus_for_each_dev+0x23b/0x2c0 drivers/base/bus.c:383
                   serio_attach_driver drivers/input/serio/serio.c:777 [inline]
                   serio_handle_event+0x20a/0xdd0 drivers/input/serio/serio.c:214
                   process_one_work kernel/workqueue.c:3275 [inline]
                   process_scheduled_works+0xb02/0x1830 kernel/workqueue.c:3358
                   worker_thread+0xa50/0xfc0 kernel/workqueue.c:3439
                   kthread+0x388/0x470 kernel/kthread.c:467
                   ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
                   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 }
 ... key      at: [<ffffffff9a6053c0>] input_allocate_device.__key.7+0x0/0x20

the dependencies between the lock to be acquired
 and SOFTIRQ-irq-unsafe lock:
  -> (tasklist_lock){.+.+}-{3:3} {
     HARDIRQ-ON-R at:
                        lock_acquire+0xf0/0x2e0 kernel/locking/lockdep.c:5868
                        __raw_read_lock include/linux/rwlock_api_smp.h:161 [inline]
                        _raw_read_lock+0x36/0x50 kernel/locking/spinlock.c:228
                        __do_wait+0xde/0x740 kernel/exit.c:1672
                        do_wait+0x1e7/0x540 kernel/exit.c:1716
                        kernel_wait+0xd6/0x1c0 kernel/exit.c:1892
                        call_usermodehelper_exec_sync kernel/umh.c:136 [inline]
                        call_usermodehelper_exec_work+0xbe/0x230 kernel/umh.c:163
                        process_one_work kernel/workqueue.c:3275 [inline]
                        process_scheduled_works+0xb02/0x1830 kernel/workqueue.c:3358
                        worker_thread+0xa50/0xfc0 kernel/workqueue.c:3439
                        kthread+0x388/0x470 kernel/kthread.c:467
                        ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
                        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
     SOFTIRQ-ON-R at:
                        lock_acquire+0xf0/0x2e0 kernel/locking/lockdep.c:5868
                        __raw_read_lock include/linux/rwlock_api_smp.h:161 [inline]
                        _raw_read_lock+0x36/0x50 kernel/locking/spinlock.c:228
                        __do_wait+0xde/0x740 kernel/exit.c:1672
                        do_wait+0x1e7/0x540 kernel/exit.c:1716
                        kernel_wait+0xd6/0x1c0 kernel/exit.c:1892
                        call_usermodehelper_exec_sync kernel/umh.c:136 [inline]
                        call_usermodehelper_exec_work+0xbe/0x230 kernel/umh.c:163
                        process_one_work kernel/workqueue.c:3275 [inline]
                        process_scheduled_works+0xb02/0x1830 kernel/workqueue.c:3358
                        worker_thread+0xa50/0xfc0 kernel/workqueue.c:3439
                        kthread+0x388/0x470 kernel/kthread.c:467
                        ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
                        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
     INITIAL USE at:
                       lock_acquire+0xf0/0x2e0 kernel/locking/lockdep.c:5868
                       __raw_write_lock_irq include/linux/rwlock_api_smp.h:211 [inline]
                       _raw_write_lock_irq+0x3d/0x50 kernel/locking/spinlock.c:326
                       copy_process+0x247a/0x3cf0 kernel/fork.c:2369
                       kernel_clone+0x248/0x8e0 kernel/fork.c:2654
                       user_mode_thread+0x110/0x180 kernel/fork.c:2730
                       rest_init+0x23/0x300 init/main.c:725
                       start_kernel+0x385/0x3d0 init/main.c:1210
                       x86_64_start_reservations+0x24/0x30 arch/x86/kernel/head64.c:310
                       x86_64_start_kernel+0x143/0x1c0 arch/x86/kernel/head64.c:291
                       common_startup_64+0x13e/0x147
     INITIAL READ USE at:
                            lock_acquire+0xf0/0x2e0 kernel/locking/lockdep.c:5868
                            __raw_read_lock include/linux/rwlock_api_smp.h:161 [inline]
                            _raw_read_lock+0x36/0x50 kernel/locking/spinlock.c:228
                            __do_wait+0xde/0x740 kernel/exit.c:1672
                            do_wait+0x1e7/0x540 kernel/exit.c:1716
                            kernel_wait+0xd6/0x1c0 kernel/exit.c:1892
                            call_usermodehelper_exec_sync kernel/umh.c:136 [inline]
                            call_usermodehelper_exec_work+0xbe/0x230 kernel/umh.c:163
                            process_one_work kernel/workqueue.c:3275 [inline]
                            process_scheduled_works+0xb02/0x1830 kernel/workqueue.c:3358
                            worker_thread+0xa50/0xfc0 kernel/workqueue.c:3439
                            kthread+0x388/0x470 kernel/kthread.c:467
                            ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
                            ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
   }
   ... key      at: [<ffffffff8e40c058>] tasklist_lock+0x18/0x40
   ... acquired at:
   __raw_read_lock include/linux/rwlock_api_smp.h:161 [inline]
   _raw_read_lock+0x36/0x50 kernel/locking/spinlock.c:228
   send_sigio+0x101/0x370 fs/fcntl.c:932
   kill_fasync_rcu fs/fcntl.c:1144 [inline]
   kill_fasync+0x24d/0x4d0 fs/fcntl.c:1159
   sock_wake_async+0x137/0x160 net/socket.c:-1
   sk_wake_async_rcu include/net/sock.h:2579 [inline]
   sock_def_readable+0x3c1/0x580 net/core/sock.c:3613
   unix_stream_sendmsg+0x8a3/0xe80 net/unix/af_unix.c:2480
   sock_sendmsg_nosec net/socket.c:727 [inline]
   __sock_sendmsg net/socket.c:742 [inline]
   ____sys_sendmsg+0xa68/0xad0 net/socket.c:2592
   ___sys_sendmsg+0x2a5/0x360 net/socket.c:2646
   __sys_sendmsg net/socket.c:2678 [inline]
   __do_sys_sendmsg net/socket.c:2683 [inline]
   __se_sys_sendmsg net/socket.c:2681 [inline]
   __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2681
   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
   do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

 -> (&f_owner->lock){....}-{3:3} {
    INITIAL USE at:
                     lock_acquire+0xf0/0x2e0 kernel/locking/lockdep.c:5868
                     __raw_write_lock_irq include/linux/rwlock_api_smp.h:211 [inline]
                     _raw_write_lock_irq+0x3d/0x50 kernel/locking/spinlock.c:326
                     __f_setown+0x67/0x370 fs/fcntl.c:136
                     fcntl_dirnotify+0x3f9/0x6a0 fs/notify/dnotify/dnotify.c:369
                     do_fcntl+0x77e/0x1a20 fs/fcntl.c:538
                     __do_sys_fcntl fs/fcntl.c:602 [inline]
                     __se_sys_fcntl+0xc8/0x150 fs/fcntl.c:587
                     do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
                     do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
                     entry_SYSCALL_64_after_hwframe+0x77/0x7f
    INITIAL READ USE at:
                          lock_acquire+0xf0/0x2e0 kernel/locking/lockdep.c:5868
                          __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:172 [inline]
                          _raw_read_lock_irqsave+0x48/0x60 kernel/locking/spinlock.c:236
                          send_sigio+0x38/0x370 fs/fcntl.c:918
                          kill_fasync_rcu fs/fcntl.c:1144 [inline]
                          kill_fasync+0x24d/0x4d0 fs/fcntl.c:1159
                          sock_wake_async+0x137/0x160 net/socket.c:-1
                          sk_wake_async_rcu include/net/sock.h:2579 [inline]
                          sock_def_readable+0x3c1/0x580 net/core/sock.c:3613
                          unix_stream_sendmsg+0x8a3/0xe80 net/unix/af_unix.c:2480
                          sock_sendmsg_nosec net/socket.c:727 [inline]
                          __sock_sendmsg net/socket.c:742 [inline]
                          ____sys_sendmsg+0xa68/0xad0 net/socket.c:2592
                          ___sys_sendmsg+0x2a5/0x360 net/socket.c:2646
                          __sys_sendmsg net/socket.c:2678 [inline]
                          __do_sys_sendmsg net/socket.c:2683 [inline]
                          __se_sys_sendmsg net/socket.c:2681 [inline]
                          __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2681
                          do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
                          do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
                          entry_SYSCALL_64_after_hwframe+0x77/0x7f
  }
  ... key      at: [<ffffffff9a2e6160>] file_f_owner_allocate.__key+0x0/0x20
  ... acquired at:
   __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:172 [inline]
   _raw_read_lock_irqsave+0x48/0x60 kernel/locking/spinlock.c:236
   send_sigio+0x38/0x370 fs/fcntl.c:918
   kill_fasync_rcu fs/fcntl.c:1144 [inline]
   kill_fasync+0x24d/0x4d0 fs/fcntl.c:1159
   sock_wake_async+0x137/0x160 net/socket.c:-1
   sk_wake_async_rcu include/net/sock.h:2579 [inline]
   sock_def_readable+0x3c1/0x580 net/core/sock.c:3613
   unix_stream_sendmsg+0x8a3/0xe80 net/unix/af_unix.c:2480
   sock_sendmsg_nosec net/socket.c:727 [inline]
   __sock_sendmsg net/socket.c:742 [inline]
   ____sys_sendmsg+0xa68/0xad0 net/socket.c:2592
   ___sys_sendmsg+0x2a5/0x360 net/socket.c:2646
   __sys_sendmsg net/socket.c:2678 [inline]
   __do_sys_sendmsg net/socket.c:2683 [inline]
   __se_sys_sendmsg net/socket.c:2681 [inline]
   __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2681
   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
   do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> (&new->fa_lock){....}-{3:3} {
   INITIAL USE at:
                   lock_acquire+0xf0/0x2e0 kernel/locking/lockdep.c:5868
                   __raw_write_lock_irq include/linux/rwlock_api_smp.h:211 [inline]
                   _raw_write_lock_irq+0x3d/0x50 kernel/locking/spinlock.c:326
                   fasync_remove_entry+0xf1/0x1c0 fs/fcntl.c:1012
                   sock_fasync+0x85/0xf0 net/socket.c:1480
                   __fput+0x8a5/0xa70 fs/file_table.c:466
                   task_work_run+0x1d9/0x270 kernel/task_work.c:233
                   resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
                   __exit_to_user_mode_loop kernel/entry/common.c:67 [inline]
                   exit_to_user_mode_loop+0xed/0x480 kernel/entry/common.c:98
                   __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
                   syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
                   syscall_exit_to_user_mode include/linux/entry-common.h:325 [inline]
                   do_syscall_64+0x32d/0xf80 arch/x86/entry/syscall_64.c:100
                   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   INITIAL READ USE at:
                        lock_acquire+0xf0/0x2e0 kernel/locking/lockdep.c:5868
                        __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:172 [inline]
                        _raw_read_lock_irqsave+0x48/0x60 kernel/locking/spinlock.c:236
                        kill_fasync_rcu fs/fcntl.c:1135 [inline]
                        kill_fasync+0x199/0x4d0 fs/fcntl.c:1159
                        sock_wake_async+0x137/0x160 net/socket.c:-1
                        sk_wake_async_rcu include/net/sock.h:2579 [inline]
                        sock_def_readable+0x3c1/0x580 net/core/sock.c:3613
                        unix_stream_sendmsg+0x8a3/0xe80 net/unix/af_unix.c:2480
                        sock_sendmsg_nosec net/socket.c:727 [inline]
                        __sock_sendmsg net/socket.c:742 [inline]
                        ____sys_sendmsg+0xa68/0xad0 net/socket.c:2592
                        ___sys_sendmsg+0x2a5/0x360 net/socket.c:2646
                        __sys_sendmsg net/socket.c:2678 [inline]
                        __do_sys_sendmsg net/socket.c:2683 [inline]
                        __se_sys_sendmsg net/socket.c:2681 [inline]
                        __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2681
                        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
                        do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
                        entry_SYSCALL_64_after_hwframe+0x77/0x7f
 }
 ... key      at: [<ffffffff9a2e6180>] fasync_insert_entry.__key+0x0/0x20
 ... acquired at:
   __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:172 [inline]
   _raw_read_lock_irqsave+0x48/0x60 kernel/locking/spinlock.c:236
   kill_fasync_rcu fs/fcntl.c:1135 [inline]
   kill_fasync+0x199/0x4d0 fs/fcntl.c:1159
   mousedev_notify_readers+0x6f1/0xc00 drivers/input/mousedev.c:309
   mousedev_event+0x602/0x1320 drivers/input/mousedev.c:394
   input_handle_events_default+0xd4/0x1a0 drivers/input/input.c:2541
   input_pass_values+0x288/0x890 drivers/input/input.c:128
   input_event_dispose+0x330/0x6b0 drivers/input/input.c:342
   input_inject_event+0x1dd/0x340 drivers/input/input.c:424
   evdev_write+0x325/0x4c0 drivers/input/evdev.c:528
   vfs_write+0x29a/0xb90 fs/read_write.c:686
   ksys_write+0x150/0x270 fs/read_write.c:740
   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
   do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
   entry_SYSCALL_64_after_hwframe+0x77/0x7f


stack backtrace:
CPU: 1 UID: 0 PID: 23959 Comm: syz.0.6889 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_bad_irq_dependency kernel/locking/lockdep.c:2616 [inline]
 check_irq_usage kernel/locking/lockdep.c:2857 [inline]
 check_prev_add kernel/locking/lockdep.c:3169 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain kernel/locking/lockdep.c:3908 [inline]
 __lock_acquire+0x2a94/0x2cf0 kernel/locking/lockdep.c:5237
 lock_acquire+0xf0/0x2e0 kernel/locking/lockdep.c:5868
 __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:172 [inline]
 _raw_read_lock_irqsave+0x48/0x60 kernel/locking/spinlock.c:236
 kill_fasync_rcu fs/fcntl.c:1135 [inline]
 kill_fasync+0x199/0x4d0 fs/fcntl.c:1159
 mousedev_notify_readers+0x6f1/0xc00 drivers/input/mousedev.c:309
 mousedev_event+0x602/0x1320 drivers/input/mousedev.c:394
 input_handle_events_default+0xd4/0x1a0 drivers/input/input.c:2541
 input_pass_values+0x288/0x890 drivers/input/input.c:128
 input_event_dispose+0x330/0x6b0 drivers/input/input.c:342
 input_inject_event+0x1dd/0x340 drivers/input/input.c:424
 evdev_write+0x325/0x4c0 drivers/input/evdev.c:528
 vfs_write+0x29a/0xb90 fs/read_write.c:686
 ksys_write+0x150/0x270 fs/read_write.c:740
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1f91b9c629
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1f92b1f028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f1f91e15fa0 RCX: 00007f1f91b9c629
RDX: 0000000000000918 RSI: 0000200000000040 RDI: 0000000000000004
RBP: 00007f1f91c32b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f1f91e16038 R14: 00007f1f91e15fa0 R15: 00007f1f91f3fa48
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

