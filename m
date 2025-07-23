Return-Path: <linux-fsdevel+bounces-55879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F98B0F739
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 17:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE057AA4139
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 15:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8152E7645;
	Wed, 23 Jul 2025 15:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="08FJtUnl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85381F91C5;
	Wed, 23 Jul 2025 15:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753285020; cv=none; b=MXNEj9RffLwwbj8x5LvFsTXVChYC+XtG5BuVRLi0HKWtcmYg1DJPRioPUUgsGP1sw8wM3HwyAQZ8hVVniI+LnXSHn8trmoUtXKV0Hre5zOwZNGxx8CTIX8GoBvnDM0pA5VJ37qpDqbXVxsuUF/Hzx0Yap20ThVOdkhkOh0CUUkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753285020; c=relaxed/simple;
	bh=nJrciQ0W4LHd/KfLrUWAqookh+RqhvINSCMZ3GN8r1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qvzBDYkzg7uLbg21zsVniMCyYcUUO5l0bj/kIeGRRNJ2EaJQVvNhkVEmXf/q+dr6WmoPWhkilVOkTe5oln05zUivV5eC3bSFh44uEuCBm0gSWQKyJ6slz9LUgvdeIF86c/pOXf+nnFV5ofCZdhcGg5fCaTJOK7FpLXgijX/VUF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=08FJtUnl; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=zXfMX4jMPOxLxHOpwp9n8iGtzZyPibxzsWfQBEx2rpA=; b=08FJtUnlA26A9j91e51SK6apvV
	8+WtYRpXsBdh/3oBxs8rnXR3eZj77/XvzoWS+QYe98fmgFGJ+sH+eZTJKfBf1nutKeNy7LlHhXCaH
	bNXYp3rqaTO57vUA0DzgPpNh+nYVaBAOdGl9gZ6Y2yocfcpUYAkWZk64G2hJqbByM0lbc9I61zZXs
	9O9nKxNnk/rHlhcMAAC5tYCT+JxM32faU4rPirMicTJPTEP7+p2FUG1CzT9SZefK5PeLzGCemKBuZ
	KQH+Mac01z5b20IfR47QwgDXVKoLrHHYsgOmIf/zqTJzTv+EblvE0JihCGcGUq2A36+Uhp8g9oekG
	JIVtB4dWaH4eWEya+eDYnY9nMlW+MyjqeWoIyCus/zyd3oKQOh9QApvmdlW4eY/plCNrqa85D9Xwy
	Qt7cINLLYEt6SadDdiOZ1XBmym84xbfsdE5eIr5Yc3WqBHsjZbNeLPpmQvKfLsNyUYXb9FI2qniLK
	+B7lBMYlxHplWyIHMawyFL6f;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1uebWS-00GdeK-29;
	Wed, 23 Jul 2025 15:36:48 +0000
Message-ID: <8ae2444f-e33e-4d78-9349-429b32f129d5@samba.org>
Date: Wed, 23 Jul 2025 17:36:35 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] smb/server: add ksmbd_vfs_kern_path()
To: NeilBrown <neil@brown.name>, Namjae Jeon <linkinjeon@kernel.org>,
 Steve French <smfrench@gmail.com>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, Tom Talpey <tom@talpey.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250608234108.30250-1-neil@brown.name>
 <20250608234108.30250-5-neil@brown.name>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <20250608234108.30250-5-neil@brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Neil,

for me this reliable generates the following problem, just doing a simple:
mount -t cifs -ousername=root,password=test,noperm,vers=3.1.1,mfsymlinks,actimeo=0 //172.31.9.167/test /mnt/test/

[ 2213.234061] [   T1972] ==================================================================
[ 2213.234607] [   T1972] BUG: KASAN: slab-use-after-free in lookup_noperm_common+0x237/0x2b0
[ 2213.235122] [   T1972] Read of size 1 at addr ffff88801c95b326 by task kworker/2:0/1972
[ 2213.235635] [   T1972]
[ 2213.235806] [   T1972] CPU: 2 UID: 0 PID: 1972 Comm: kworker/2:0 Kdump: loaded Tainted: G        W  OE       6.16.0-rc7-metze-kasan.01+ #1 PREEMPT(voluntary)
[ 2213.235820] [   T1972] Tainted: [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[ 2213.235824] [   T1972] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
[ 2213.235829] [   T1972] Workqueue: ksmbd-io handle_ksmbd_work [ksmbd]
[ 2213.235871] [   T1972] Call Trace:
[ 2213.235875] [   T1972]  <TASK>
[ 2213.235880] [   T1972]  dump_stack_lvl+0x76/0xa0
[ 2213.235893] [   T1972]  print_report+0xd1/0x600
[ 2213.235909] [   T1972]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
[ 2213.235920] [   T1972]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 2213.235929] [   T1972]  ? kasan_complete_mode_report_info+0x72/0x210
[ 2213.235937] [   T1972]  kasan_report+0xe7/0x130
[ 2213.235944] [   T1972]  ? lookup_noperm_common+0x237/0x2b0
[ 2213.235952] [   T1972]  ? lookup_noperm_common+0x237/0x2b0
[ 2213.235963] [   T1972]  __asan_report_load1_noabort+0x14/0x30
[ 2213.235976] [   T1972]  lookup_noperm_common+0x237/0x2b0
[ 2213.235984] [   T1972]  lookup_noperm_unlocked+0x1d/0xa0
[ 2213.235991] [   T1972]  ? putname+0xfa/0x150
[ 2213.235998] [   T1972]  __ksmbd_vfs_kern_path+0x376/0xa80 [ksmbd]
[ 2213.236024] [   T1972]  ? local_clock+0x15/0x30
[ 2213.236039] [   T1972]  ? kasan_save_track+0x27/0x70
[ 2213.236047] [   T1972]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 2213.236054] [   T1972]  ? __entry_text_end+0x10257a/0x10257d
[ 2213.236066] [   T1972]  ? __pfx___ksmbd_vfs_kern_path+0x10/0x10 [ksmbd]
[ 2213.236097] [   T1972]  ? groups_alloc+0x41/0xe0
[ 2213.236106] [   T1972]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 2213.236114] [   T1972]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 2213.236122] [   T1972]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 2213.236128] [   T1972]  ? __kasan_check_write+0x14/0x30
[ 2213.236134] [   T1972]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 2213.236140] [   T1972]  ? __ksmbd_override_fsids+0x340/0x630 [ksmbd]
[ 2213.236188] [   T1972]  ? smb2_open+0x40b/0x9db0 [ksmbd]
[ 2213.236223] [   T1972]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 2213.236233] [   T1972]  ksmbd_vfs_kern_path+0x15/0x30 [ksmbd]
[ 2213.236260] [   T1972]  smb2_open+0x2de6/0x9db0 [ksmbd]
[ 2213.236292] [   T1972]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 2213.236299] [   T1972]  ? stack_depot_save_flags+0x28/0x840
[ 2213.236315] [   T1972]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 2213.236321] [   T1972]  ? enqueue_hrtimer+0x10b/0x230
[ 2213.236338] [   T1972]  ? ksm_scan_thread+0x480/0x59b0
[ 2213.236345] [   T1972]  ? ksm_scan_thread+0x480/0x59b0
[ 2213.236357] [   T1972]  ? __pfx_smb2_open+0x10/0x10 [ksmbd]
[ 2213.236401] [   T1972]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 2213.236407] [   T1972]  ? xas_load+0x19/0x300
[ 2213.236423] [   T1972]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 2213.236429] [   T1972]  ? __kasan_check_write+0x14/0x30
[ 2213.236435] [   T1972]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 2213.236441] [   T1972]  ? down_read_killable+0x120/0x290
[ 2213.236458] [   T1972]  handle_ksmbd_work+0x3fb/0xfe0 [ksmbd]
[ 2213.236489] [   T1972]  process_one_work+0x629/0xf80
[ 2213.236498] [   T1972]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 2213.236504] [   T1972]  ? __kasan_check_write+0x14/0x30
[ 2213.236526] [   T1972]  worker_thread+0x87f/0x1570
[ 2213.236534] [   T1972]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
[ 2213.236541] [   T1972]  ? __pfx_try_to_wake_up+0x10/0x10
[ 2213.236552] [   T1972]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 2213.236558] [   T1972]  ? kasan_print_address_stack_frame+0x227/0x280
[ 2213.236567] [   T1972]  ? __pfx_worker_thread+0x10/0x10
[ 2213.236581] [   T1972]  kthread+0x396/0x830
[ 2213.236589] [   T1972]  ? __pfx__raw_spin_lock_irq+0x10/0x10
[ 2213.236598] [   T1972]  ? __pfx_kthread+0x10/0x10
[ 2213.236604] [   T1972]  ? __kasan_check_write+0x14/0x30
[ 2213.236610] [   T1972]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 2213.236616] [   T1972]  ? recalc_sigpending+0x180/0x210
[ 2213.236624] [   T1972]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 2213.236630] [   T1972]  ? _raw_spin_unlock_irq+0xe/0x50
[ 2213.236643] [   T1972]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 2213.236649] [   T1972]  ? calculate_sigpending+0x84/0xb0
[ 2213.236656] [   T1972]  ? __pfx_kthread+0x10/0x10
[ 2213.236664] [   T1972]  ret_from_fork+0x2b8/0x3b0
[ 2213.236671] [   T1972]  ? __pfx_kthread+0x10/0x10
[ 2213.236679] [   T1972]  ret_from_fork_asm+0x1a/0x30
[ 2213.236694] [   T1972]  </TASK>
[ 2213.236704] [   T1972]
[ 2213.269993] [   T1972] Allocated by task 1972 on cpu 2 at 2213.234048s:
[ 2213.270550] [   T1972]  kasan_save_stack+0x39/0x70
[ 2213.270569] [   T1972]  kasan_save_track+0x18/0x70
[ 2213.270578] [   T1972]  kasan_save_alloc_info+0x37/0x60
[ 2213.270587] [   T1972]  __kasan_slab_alloc+0x9d/0xa0
[ 2213.270606] [   T1972]  kmem_cache_alloc_noprof+0x13c/0x3f0
[ 2213.270619] [   T1972]  getname_kernel+0x55/0x390
[ 2213.270629] [   T1972]  __ksmbd_vfs_kern_path+0x1cf/0xa80 [ksmbd]
[ 2213.270712] [   T1972]  ksmbd_vfs_kern_path+0x15/0x30 [ksmbd]
[ 2213.270747] [   T1972]  smb2_open+0x2de6/0x9db0 [ksmbd]
[ 2213.270784] [   T1972]  handle_ksmbd_work+0x3fb/0xfe0 [ksmbd]
[ 2213.270814] [   T1972]  process_one_work+0x629/0xf80
[ 2213.270826] [   T1972]  worker_thread+0x87f/0x1570
[ 2213.270835] [   T1972]  kthread+0x396/0x830
[ 2213.270852] [   T1972]  ret_from_fork+0x2b8/0x3b0
[ 2213.270862] [   T1972]  ret_from_fork_asm+0x1a/0x30
[ 2213.270873] [   T1972]
[ 2213.271183] [   T1972] Freed by task 1972 on cpu 2 at 2213.234058s:
[ 2213.271707] [   T1972]  kasan_save_stack+0x39/0x70
[ 2213.271716] [   T1972]  kasan_save_track+0x18/0x70
[ 2213.271724] [   T1972]  kasan_save_free_info+0x3b/0x60
[ 2213.271732] [   T1972]  __kasan_slab_free+0x52/0x80
[ 2213.271741] [   T1972]  kmem_cache_free+0x316/0x560
[ 2213.271750] [   T1972]  putname+0xfa/0x150
[ 2213.271768] [   T1972]  __ksmbd_vfs_kern_path+0x20b/0xa80 [ksmbd]
[ 2213.271795] [   T1972]  ksmbd_vfs_kern_path+0x15/0x30 [ksmbd]
[ 2213.271829] [   T1972]  smb2_open+0x2de6/0x9db0 [ksmbd]
[ 2213.271857] [   T1972]  handle_ksmbd_work+0x3fb/0xfe0 [ksmbd]
[ 2213.271891] [   T1972]  process_one_work+0x629/0xf80
[ 2213.271901] [   T1972]  worker_thread+0x87f/0x1570
[ 2213.271910] [   T1972]  kthread+0x396/0x830
[ 2213.271918] [   T1972]  ret_from_fork+0x2b8/0x3b0
[ 2213.271926] [   T1972]  ret_from_fork_asm+0x1a/0x30
[ 2213.271935] [   T1972]
[ 2213.272236] [   T1972] The buggy address belongs to the object at ffff88801c95b300
                            which belongs to the cache names_cache of size 4096
[ 2213.273326] [   T1972] The buggy address is located 38 bytes inside of
                            freed 4096-byte region [ffff88801c95b300, ffff88801c95c300)
[ 2213.274374] [   T1972]
[ 2213.274671] [   T1972] The buggy address belongs to the physical page:
[ 2213.275233] [   T1972] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1c958
[ 2213.275249] [   T1972] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[ 2213.275259] [   T1972] anon flags: 0xfffffc0000040(head|node=0|zone=1|lastcpupid=0x1fffff)
[ 2213.275270] [   T1972] page_type: f5(slab)
[ 2213.275280] [   T1972] raw: 000fffffc0000040 ffff888001367c80 0000000000000000 dead000000000001
[ 2213.275289] [   T1972] raw: 0000000000000000 0000000080070007 00000000f5000000 0000000000000000
[ 2213.275304] [   T1972] head: 000fffffc0000040 ffff888001367c80 0000000000000000 dead000000000001
[ 2213.275316] [   T1972] head: 0000000000000000 0000000080070007 00000000f5000000 0000000000000000
[ 2213.275326] [   T1972] head: 000fffffc0000003 ffffea0000725601 00000000ffffffff 00000000ffffffff
[ 2213.275334] [   T1972] head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
[ 2213.275341] [   T1972] page dumped because: kasan: bad access detected
[ 2213.275348] [   T1972]
[ 2213.275652] [   T1972] Memory state around the buggy address:
[ 2213.276139] [   T1972]  ffff88801c95b200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[ 2213.276920] [   T1972]  ffff88801c95b280: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[ 2213.277700] [   T1972] >ffff88801c95b300: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 2213.278482] [   T1972]                                ^
[ 2213.278933] [   T1972]  ffff88801c95b380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 2213.279723] [   T1972]  ffff88801c95b400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 2213.280496] [   T1972] ==================================================================
[ 2213.281383] [   T1972] Kernel panic - not syncing: KASAN: panic_on_warn set ...
[ 2213.281988] [   T1972] CPU: 2 UID: 0 PID: 1972 Comm: kworker/2:0 Kdump: loaded Tainted: G        W  OE       6.16.0-rc7-metze-kasan.01+ #1 PREEMPT(voluntary)
[ 2213.283165] [   T1972] Tainted: [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[ 2213.283749] [   T1972] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
[ 2213.284595] [   T1972] Workqueue: ksmbd-io handle_ksmbd_work [ksmbd]
[ 2213.285146] [   T1972] Call Trace:
[ 2213.285510] [   T1972]  <TASK>
[ 2213.285840] [   T1972]  dump_stack_lvl+0x27/0xa0
[ 2213.286276] [   T1972]  dump_stack+0x10/0x20
[ 2213.286700] [   T1972]  panic+0x538/0x610
[ 2213.287098] [   T1972]  ? __pfx_panic+0x10/0x10
[ 2213.287719] [   T1972]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 2213.288223] [   T1972]  ? vprintk_default+0x1d/0x30
[ 2213.288682] [   T1972]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 2213.289181] [   T1972]  ? sysvec_apic_timer_interrupt+0xa6/0xd0
[ 2213.289697] [   T1972]  ? asm_sysvec_apic_timer_interrupt+0x1b/0x20
[ 2213.290228] [   T1972]  check_panic_on_warn+0x6f/0x90
[ 2213.290691] [   T1972]  end_report+0xe6/0x100
[ 2213.291101] [   T1972]  kasan_report+0xf9/0x130
[ 2213.291537] [   T1972]  ? lookup_noperm_common+0x237/0x2b0
[ 2213.292013] [   T1972]  ? lookup_noperm_common+0x237/0x2b0
[ 2213.292524] [   T1972]  __asan_report_load1_noabort+0x14/0x30
[ 2213.293014] [   T1972]  lookup_noperm_common+0x237/0x2b0
[ 2213.293498] [   T1972]  lookup_noperm_unlocked+0x1d/0xa0
[ 2213.293961] [   T1972]  ? putname+0xfa/0x150
[ 2213.294397] [   T1972]  __ksmbd_vfs_kern_path+0x376/0xa80 [ksmbd]
[ 2213.294935] [   T1972]  ? local_clock+0x15/0x30
[ 2213.295361] [   T1972]  ? kasan_save_track+0x27/0x70
[ 2213.295823] [   T1972]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 2213.296328] [   T1972]  ? __entry_text_end+0x10257a/0x10257d
[ 2213.296822] [   T1972]  ? __pfx___ksmbd_vfs_kern_path+0x10/0x10 [ksmbd]
[ 2213.297389] [   T1972]  ? groups_alloc+0x41/0xe0
[ 2213.297829] [   T1972]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 2213.298318] [   T1972]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 2213.298808] [   T1972]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 2213.299322] [   T1972]  ? __kasan_check_write+0x14/0x30
[ 2213.299790] [   T1972]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 2213.300277] [   T1972]  ? __ksmbd_override_fsids+0x340/0x630 [ksmbd]
[ 2213.300839] [   T1972]  ? smb2_open+0x40b/0x9db0 [ksmbd]
[ 2213.301333] [   T1972]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 2213.301834] [   T1972]  ksmbd_vfs_kern_path+0x15/0x30 [ksmbd]
[ 2213.302358] [   T1972]  smb2_open+0x2de6/0x9db0 [ksmbd]
[ 2213.302841] [   T1972]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 2213.303332] [   T1972]  ? stack_depot_save_flags+0x28/0x840
[ 2213.303829] [   T1972]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 2213.304323] [   T1972]  ? enqueue_hrtimer+0x10b/0x230
[ 2213.304786] [   T1972]  ? ksm_scan_thread+0x480/0x59b0
[ 2213.305238] [   T1972]  ? ksm_scan_thread+0x480/0x59b0
[ 2213.305702] [   T1972]  ? __pfx_smb2_open+0x10/0x10 [ksmbd]
[ 2213.306225] [   T1972]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 2213.306718] [   T1972]  ? xas_load+0x19/0x300
[ 2213.307141] [   T1972]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 2213.307846] [   T1972]  ? __kasan_check_write+0x14/0x30
[ 2213.308330] [   T1972]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 2213.308834] [   T1972]  ? down_read_killable+0x120/0x290
[ 2213.309319] [   T1972]  handle_ksmbd_work+0x3fb/0xfe0 [ksmbd]
[ 2213.309853] [   T1972]  process_one_work+0x629/0xf80
[ 2213.310308] [   T1972]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 2213.310800] [   T1972]  ? __kasan_check_write+0x14/0x30
[ 2213.311262] [   T1972]  worker_thread+0x87f/0x1570
[ 2213.311700] [   T1972]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
[ 2213.312204] [   T1972]  ? __pfx_try_to_wake_up+0x10/0x10
[ 2213.312691] [   T1972]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 2213.313183] [   T1972]  ? kasan_print_address_stack_frame+0x227/0x280
[ 2213.313728] [   T1972]  ? __pfx_worker_thread+0x10/0x10
[ 2213.314192] [   T1972]  kthread+0x396/0x830
[ 2213.314599] [   T1972]  ? __pfx__raw_spin_lock_irq+0x10/0x10
[ 2213.315097] [   T1972]  ? __pfx_kthread+0x10/0x10
[ 2213.315536] [   T1972]  ? __kasan_check_write+0x14/0x30
[ 2213.315993] [   T1972]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 2213.316485] [   T1972]  ? recalc_sigpending+0x180/0x210
[ 2213.316954] [   T1972]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 2213.317455] [   T1972]  ? _raw_spin_unlock_irq+0xe/0x50
[ 2213.317921] [   T1972]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 2213.318409] [   T1972]  ? calculate_sigpending+0x84/0xb0
[ 2213.318883] [   T1972]  ? __pfx_kthread+0x10/0x10
[ 2213.319311] [   T1972]  ret_from_fork+0x2b8/0x3b0
[ 2213.319750] [   T1972]  ? __pfx_kthread+0x10/0x10
[ 2213.320188] [   T1972]  ret_from_fork_asm+0x1a/0x30
[ 2213.320656] [   T1972]  </TASK>

Can you please have a look?

Thanks!
metze

