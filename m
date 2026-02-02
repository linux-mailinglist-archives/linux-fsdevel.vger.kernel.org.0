Return-Path: <linux-fsdevel+bounces-76027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAdwDldCgGmK5QIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 07:21:11 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CB4C89A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 07:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5096A301051B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 06:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEF62F60CC;
	Mon,  2 Feb 2026 06:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOY2wCfg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF332EB856
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Feb 2026 06:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770013264; cv=pass; b=ZKiMutKo2iAKY9N/IX/DoR384nv1RrDyjYOruDydZ/sqprKPZnb4KdPpXMOb4MyE9c8DUpfClCT12YDMUMpBHN0ErlRh0zNPlKjk71NFD+wKQw34C0XGfQh6UJFO2TVpBxrjhAqLxR+0WghAyeqYsqGwiZhImEEO49lHDUjI36M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770013264; c=relaxed/simple;
	bh=f4ZU9PMlAR3PQAOmGqaEUmZDxjGNPImUk6SzNhbZ2a4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Bmwrv5Ly5nHWd+X1te8qbrjVwM0ahP4w9BBobqSuEIkDjzGU7buf3iWXhPUG7qG6n/DP6uvToqDE6n1DkNd2WtyVDS+d3zBXaUAIv5CY/NF5oI2RrUkhUJYvbtWFQ/iU1+z0TqGvLR6xOb0IVwUME0qasQ5J/2qZu2jLZ5LPyQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bOY2wCfg; arc=pass smtp.client-ip=209.85.219.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-8947e6ffd30so49354086d6.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Feb 2026 22:21:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770013262; cv=none;
        d=google.com; s=arc-20240605;
        b=LCXvAmLTxB7kJD5VZfLwokDqhiSLqdJhz0n4fXzSxo7zNU64PkdQMhXUiPw9eD/BKC
         d6vLKR6wj4iW/ZTp2IrThRetuQrnid/sxEYQ9fc/KLB2heVK/qLI/aipQxTcFt0hcDjw
         yW52EUILHV71T6yQfDGLgk078OrU5LuygDIMjNIuMKjNqlx0UrGoG1qvVkwPeQyhx1TX
         f8+v6aMdeorEqL9N2DU3HaB5tLb2lOTTyp6FEEBhTWnNsnROk80yRZApocbbyFrtiJ4V
         kQeZHgswq7Jn1+DkJLw7sXoB1aHFhJhHFnwoTY2wDCsADjFh//LX4lqQLGjh+SFU11sC
         BmOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=SDLXRhkACUlRTr33K5zCU7rNMCIsE+1uXoK+L/CDrNA=;
        fh=6dIx+S148HKjQOLUEcdEPoaCjb78TgLI9UggcudNQJc=;
        b=FZgqMSg6a69Uu2S0A2vy0QWoCqbrduVmjxSFw3+TmI4o+uQWRdvcfPnZq7V2Ik5MU1
         Wun7jm4NX20sKJQUB4fx83R6AaaUMdYfy3gMbj4DfHxgj9xZHxPSMZrAJSPXJDgQ9Msq
         Zxp/8Lo+51y/Y9l4RLnC2thjXMJGgw1PtKAaYxnBAHu04ydpfnGGJf0fpr1oKaBcPt85
         a5qkCMJVj1QZ65GNcnSVIkhyn/1WTluaEHNAnuteuK1aGfhJN0jMJRL3qWMKuC7PBsn0
         eRd5LH0+wGJ/YLXo9k59PeRs06TvIRr1DKLjTW8u7EC/Kbr7kOoqw6XzVqgwy0Sk/DUb
         h50g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770013262; x=1770618062; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SDLXRhkACUlRTr33K5zCU7rNMCIsE+1uXoK+L/CDrNA=;
        b=bOY2wCfgvq+Gqj11trHmo7NtjXzYddjsGsK8mqvJv+cjg+tqW9YeLzJorTEUuI66YR
         Tl7wrhm8e3/qTBB+Wtmqkx+VRuWheyqad6vSiAwQkhdKYHP9zDA8tsbxIBYwktJ6soJV
         LfzOJknXF6Gxka50qeknhb+06hPe4ZpwK2+6w8uFJFgTN+1HIU8wcCMw7iZWd69Woqvs
         q04sWAxzlPJXzrWAM3aRsxfmvpKT0bJJi4go4X5JavCgZlGw3yhVhGS/kP1b39ft916W
         wKdKXO4jhglCi0D1ITsSXevNnNeh2frNjBBKwpa+cLt590KWcgOaKLDUllqPzmF1GWDn
         z78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770013262; x=1770618062;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SDLXRhkACUlRTr33K5zCU7rNMCIsE+1uXoK+L/CDrNA=;
        b=bRL/kR96vH6CwPqTVDfyiKorspmfzYvhqgiTsNqGOz4wR3MM1vubXc1HoQM9Y7TcZp
         q+NCy07FCYqHOg+I3ua1iBEkVBszP4eNgwsd0GrOmR/skXcnRWE3tQ0jolaXSE8JnwGM
         +fL8P+6pPfyE65NmweCNKdu5vlehxhZJ0dErBl/Wo8eMMHOXD/JtWzgXreh56NmTSHOW
         d9YvFznGeNcBCXw3D/4lrBWZ98RkJfJ9mSwFa9oZyuFU/6gkIpC+1LIl49XNs0aDy6wT
         Q/rKJ1sVPjbhh28DxFGTu2qqgRI49Hxg+lcv9wo9bRqujVAiY+KH6O68zICRnIrU8XNq
         Z2vA==
X-Forwarded-Encrypted: i=1; AJvYcCUFfKCbqC0ZiHP9roW8gUOy+8LBj4FAk/S7LwT6HUDsjSCKuAUDEdEijp5RcV+cRyMurT4BJro0QUJ+OElp@vger.kernel.org
X-Gm-Message-State: AOJu0Yw09FwlE71jqHGf3PumDRKC4jj8wXoLqXBY3X6UriGQ0gNtePxH
	OE6jv/5FdE195qJ3uFIbqtlGKArDCKLyZrBQ1oBLZzXQmeN///JMdefMCrUJYwD2TQbi4kZEJQs
	PLD1YcDgTMEnijRB6w7ZqQ6Dmxawkh0I=
X-Gm-Gg: AZuq6aLN4gRZKA7hn+z8nk0po86pSa2P6R2w41IXFspKes3PID6FLBGjtRSbUrmSOWJ
	Bqt8jkzn6ZsnJvFXYHSo+R6K62wAzlawEKko+sZBbKeXUaBSxk4ZNqZS7lQgDrcsq2+2ZCp96eh
	IUMGjAy4Q4WoW8AfhWoOWxvQxkirFAlj6BO6o0AZ8ur9zzVem03Sj0jB+lu6m4Yz3/Ehu4+QOe+
	WgcNooLhJDadgokxTlOqCk4emsYeV4LdzVRtOCk6YJFT3ZKu5J527Sox9x27oMoh2Pyqv4op2tH
	ejhoG6AMTN+fogQKBXIVO9oa
X-Received: by 2002:a05:6214:2306:b0:895:9df:ce78 with SMTP id
 6a1803df08f44-89509dfdc34mr36498546d6.12.1770013262129; Sun, 01 Feb 2026
 22:21:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?5p2O6b6Z5YW0?= <coregee2000@gmail.com>
Date: Mon, 2 Feb 2026 14:20:50 +0800
X-Gm-Features: AZwV_Qi5qn6zGo-j-Et5-o9B7T2Kq2RXM4xyjMnrUyp9HzYe1lO_cApxJJmCD2I
Message-ID: <CAHPqNmyHRaGj0fn+2FvvaJYi4WYOVmai6XX3bRCwbAZoj_GwWg@mail.gmail.com>
Subject: [Kernel Bug] KASAN: slab-use-after-free Read in filemap_free_folio
To: syzkaller@googlegroups.com, willy@infradead.org, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-76027-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[coregee2000@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 91CB4C89A6
X-Rspamd-Action: no action

Dear Linux kernel developers and maintainers,

We would like to report a new kernel bug found by our tool. KASAN:
slab-use-after-free Read in filemap_free_folio. Details are as
follows.

Kernel commit: v6.18.2
Kernel config: see attachment
report: see attachment

We are currently analyzing the root cause and  working on a
reproducible PoC. We will provide further updates in this thread as
soon as we have more information.

Best regards,
Longxing Li

==================================================================
BUG: KASAN: slab-use-after-free in filemap_free_folio+0x147/0x170
mm/filemap.c:234
Read of size 8 at addr ffff88805e6535a8 by task kworker/u9:28/46327

CPU: 1 UID: 0 PID: 46327 Comm: kworker/u9:28 Not tainted 6.18.2 #1 PREEMPT(full)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: ext4-rsv-conversion ext4_end_io_rsv_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xcd/0x630 mm/kasan/report.c:482
 kasan_report+0xe0/0x110 mm/kasan/report.c:595
 filemap_free_folio+0x147/0x170 mm/filemap.c:234
 folio_unmap_invalidate+0x514/0x850 mm/truncate.c:653
 filemap_end_dropbehind+0x17f/0x1d0 mm/filemap.c:1616
 folio_end_dropbehind mm/filemap.c:1637 [inline]
 folio_end_dropbehind+0xbe/0xe0 mm/filemap.c:1624
 folio_end_writeback+0xe4/0x1f0 mm/filemap.c:1695
 ext4_finish_bio+0x78f/0xa20 fs/ext4/page-io.c:144
 ext4_release_io_end+0x119/0x3a0 fs/ext4/page-io.c:159
 ext4_end_io_end+0x13e/0x4a0 fs/ext4/page-io.c:210
 ext4_do_flush_completed_IO fs/ext4/page-io.c:290 [inline]
 ext4_end_io_rsv_work+0x205/0x380 fs/ext4/page-io.c:305
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3263
 process_scheduled_works kernel/workqueue.c:3346 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3427
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x675/0x7d0 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 49607:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:56
 kasan_save_track+0x14/0x30 mm/kasan/common.c:77
 unpoison_slab_object mm/kasan/common.c:342 [inline]
 __kasan_slab_alloc+0x89/0x90 mm/kasan/common.c:368
 kasan_slab_alloc include/linux/kasan.h:252 [inline]
 slab_post_alloc_hook mm/slub.c:4978 [inline]
 slab_alloc_node mm/slub.c:5288 [inline]
 kmem_cache_alloc_lru_noprof+0x254/0x6e0 mm/slub.c:5307
 ext4_alloc_inode+0x28/0x610 fs/ext4/super.c:1393
 alloc_inode+0x64/0x240 fs/inode.c:346
 new_inode+0x22/0x1c0 fs/inode.c:1145
 __ext4_new_inode+0x392/0x4f00 fs/ext4/ialloc.c:961
 ext4_create+0x303/0x550 fs/ext4/namei.c:2822
 lookup_open.isra.0+0x11d3/0x1580 fs/namei.c:3796
 open_last_lookups fs/namei.c:3895 [inline]
 path_openat+0x893/0x2cb0 fs/namei.c:4131
 do_filp_open+0x20b/0x470 fs/namei.c:4161
 do_sys_openat2+0x11b/0x1d0 fs/open.c:1437
 do_sys_open fs/open.c:1452 [inline]
 __do_sys_openat fs/open.c:1468 [inline]
 __se_sys_openat fs/open.c:1463 [inline]
 __x64_sys_openat+0x174/0x210 fs/open.c:1463
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 49611:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:56
 kasan_save_track+0x14/0x30 mm/kasan/common.c:77
 __kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:587
 kasan_save_free_info mm/kasan/kasan.h:406 [inline]
 poison_slab_object mm/kasan/common.c:252 [inline]
 __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:284
 kasan_slab_free include/linux/kasan.h:234 [inline]
 slab_free_hook mm/slub.c:2543 [inline]
 slab_free mm/slub.c:6642 [inline]
 kmem_cache_free+0x2d4/0x6c0 mm/slub.c:6752
 i_callback+0x46/0x70 fs/inode.c:325
 rcu_do_batch kernel/rcu/tree.c:2605 [inline]
 rcu_core+0x79c/0x1530 kernel/rcu/tree.c:2861
 handle_softirqs+0x219/0x8e0 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0x109/0x170 kernel/softirq.c:723
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:739
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1052 [inline]
 sysvec_apic_timer_interrupt+0xa4/0xc0 arch/x86/kernel/apic/apic.c:1052
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697

Last potentially related work creation:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:56
 kasan_record_aux_stack+0xa7/0xc0 mm/kasan/generic.c:559
 __call_rcu_common.constprop.0+0xa5/0xa10 kernel/rcu/tree.c:3123
 destroy_inode+0x12c/0x1b0 fs/inode.c:401
 evict+0x5b4/0x920 fs/inode.c:834
 iput_final fs/inode.c:1914 [inline]
 iput.part.0+0x6a9/0xb00 fs/inode.c:1966
 iput+0x35/0x40 fs/inode.c:1929
 do_unlinkat+0x518/0x6a0 fs/namei.c:4744
 __do_sys_unlink fs/namei.c:4783 [inline]
 __se_sys_unlink fs/namei.c:4781 [inline]
 __x64_sys_unlink+0xc5/0x110 fs/namei.c:4781
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Second to last potentially related work creation:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:56
 kasan_record_aux_stack+0xa7/0xc0 mm/kasan/generic.c:559
 insert_work+0x36/0x230 kernel/workqueue.c:2186
 __queue_work+0x97e/0x1160 kernel/workqueue.c:2341
 queue_work_on+0x15f/0x1f0 kernel/workqueue.c:2392
 queue_work include/linux/workqueue.h:669 [inline]
 ext4_add_complete_io fs/ext4/page-io.c:266 [inline]
 ext4_put_io_end_defer fs/ext4/page-io.c:325 [inline]
 ext4_put_io_end_defer+0x398/0x460 fs/ext4/page-io.c:321
 ext4_end_bio+0x2bc/0x580 fs/ext4/page-io.c:385
 bio_endio+0x713/0x860 block/bio.c:1672
 blk_update_request+0x93e/0x15f0 block/blk-mq.c:999
 scsi_end_request+0x7c/0x9c0 drivers/scsi/scsi_lib.c:637
 scsi_io_completion+0x17d/0x14c0 drivers/scsi/scsi_lib.c:1078
 scsi_complete+0x124/0x250 drivers/scsi/scsi_lib.c:1547
 blk_complete_reqs+0xb1/0xf0 block/blk-mq.c:1236
 handle_softirqs+0x219/0x8e0 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0x109/0x170 kernel/softirq.c:723
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:739
 instr_sysvec_call_function_single arch/x86/kernel/smp.c:266 [inline]
 sysvec_call_function_single+0x57/0xc0 arch/x86/kernel/smp.c:266
 asm_sysvec_call_function_single+0x1a/0x20 arch/x86/include/asm/idtentry.h:704

The buggy address belongs to the object at ffff88805e652fd0
 which belongs to the cache ext4_inode_cache of size 2320
The buggy address is located 1496 bytes inside of
 freed 2320-byte region [ffff88805e652fd0, ffff88805e6538e0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x5e650
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff8880268b4801
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff888101bc3a00 ffffea0001822400 dead000000000002
raw: 0000000000000000 00000000000d000d 00000000f5000000 ffff8880268b4801
head: 00fff00000000040 ffff888101bc3a00 ffffea0001822400 dead000000000002
head: 0000000000000000 00000000000d000d 00000000f5000000 ffff8880268b4801
head: 00fff00000000003 ffffea0001799401 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Reclaimable, gfp_mask
0xd2050(__GFP_RECLAIMABLE|__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC),
pid 15633, tgid 15633 (syz-executor.7), ts 460463106471, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1af/0x220 mm/page_alloc.c:1845
 prep_new_page mm/page_alloc.c:1853 [inline]
 get_page_from_freelist+0x10a3/0x3a30 mm/page_alloc.c:3879
 __alloc_frozen_pages_noprof+0x25f/0x2470 mm/page_alloc.c:5178
 alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:3059 [inline]
 allocate_slab mm/slub.c:3232 [inline]
 new_slab+0x24a/0x360 mm/slub.c:3286
 ___slab_alloc+0xd79/0x1a50 mm/slub.c:4655
 __slab_alloc.constprop.0+0x63/0x110 mm/slub.c:4778
 __slab_alloc_node mm/slub.c:4854 [inline]
 slab_alloc_node mm/slub.c:5276 [inline]
 kmem_cache_alloc_lru_noprof+0x443/0x6e0 mm/slub.c:5307
 ext4_alloc_inode+0x28/0x610 fs/ext4/super.c:1393
 alloc_inode+0x64/0x240 fs/inode.c:346
 new_inode+0x22/0x1c0 fs/inode.c:1145
 __ext4_new_inode+0x392/0x4f00 fs/ext4/ialloc.c:961
 ext4_symlink+0x462/0xde0 fs/ext4/namei.c:3388
 vfs_symlink fs/namei.c:4817 [inline]
 vfs_symlink+0x403/0x680 fs/namei.c:4801
 do_symlinkat+0x261/0x310 fs/namei.c:4843
 __do_sys_symlinkat fs/namei.c:4859 [inline]
 __se_sys_symlinkat fs/namei.c:4856 [inline]
 __x64_sys_symlinkat+0x93/0xc0 fs/namei.c:4856
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88805e653480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88805e653500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88805e653580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                  ^
 ffff88805e653600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88805e653680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

https://drive.google.com/file/d/1ZjRNEOf0XFYtFl5UZ7dvpJpzmPhje8it/view?usp=drive_link

https://drive.google.com/file/d/1ShZndTsP1CZuwyZmbuZ-e5nHEdPjeIVX/view?usp=drive_link

