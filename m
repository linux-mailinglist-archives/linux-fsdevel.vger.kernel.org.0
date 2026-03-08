Return-Path: <linux-fsdevel+bounces-79712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOH9Nsw3rWlfzgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 08 Mar 2026 09:48:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4056E22F13C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 08 Mar 2026 09:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D11A30179C0
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Mar 2026 08:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6138635F17D;
	Sun,  8 Mar 2026 08:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/T8cHDe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09293469F6
	for <linux-fsdevel@vger.kernel.org>; Sun,  8 Mar 2026 08:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772959663; cv=pass; b=Nnw69DG+my9H2liWP0/VGm4VqvrHAZfzuupy0+LreQ2OK2HkxzwUJZlzwFYvriijNqiTbBuawEANtqEwCWhgEXAyceDyWfMeWX5DNZEUOq2R95JEWjITOw/DimCwnYuo19qadmm1Cmuosb3x4IxnPdTmw0akJcIibyscZf2aH6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772959663; c=relaxed/simple;
	bh=RyVH6bXcu8n6GoazqnaoCQndxoL83xuo+b5DOlxzxoY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=U8wUiG2Vk+sUQK19q8FfY3Myk8i8j0iXa2Db5ItZfrrnE0LbcUPzc/XNNDDoWYhKN/rLRjtBDeDo6ftiPYIfMhmD/r8j5+2mpnptmum9TMqAdKl6722AJUPZwFlFyk7gg3z3Q2DwvU0OL1iIs14kc4HS+unoj6Z69aUzsN0E1Rg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/T8cHDe; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ae50a33ff8so52410505ad.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Mar 2026 00:47:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772959661; cv=none;
        d=google.com; s=arc-20240605;
        b=Z8twf3AlGgQMISXZCZrlc+E+ZDwWoFJI6BtjnckkqCfzE5nbFFc+F/EuFlqttSHivo
         0hofyHG0DXjqVomUZY5qpViy5XytVHX7c9Kk876Z+VxaQc+b7GEhV+lcomCtlsdQbU65
         PGCO+WNd2aYxRz4snLbiM3oOmTTegpTetTVZ+xnHRhl/MhHJkvGYH4A1HxAmn+yiYpe0
         9/+p6MB3F8fjvHpbTWfca2aULhYdNFG84sGgDpTlDTH/R8dOJuJPBkNFGODmoYYYi30R
         SXA3w6bC5KllVkhnwM35H1kXPIBnUk2Pja1lGDNaJ85JZikJsbsZsiUF6Mli8rEvJsK6
         LF/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=kbc34QXFHMxAH0avhY2X5FADoKcSoTWHT7nVNO8z/Kk=;
        fh=H8zDBzAjZuif59Ofy0cGjbrQ6AJpBzmedOv8cbhDsjY=;
        b=X7oPLGUWh9y+38AwxHQ/T2wGTPL2f57+nFrQcWBSFPSLjTCqvg+du6b5D7Axdtk3h8
         2zXzbKNw0zMq+76Jjv4fAeruHi0hIDfSDaheHgRDRcZMmrrzcLkXaUccBY30Rmpww8Op
         4En7RkVy31R1VVmaTFwwKTszToGqWBy8yO0ezwWvvyDAW7Bq+txytAAx/wy9j0e99H0g
         DwJfVQ8ATNwqQWWtXMQFPAVRRF1njtSNtuZOILcjXFxkaM5so4h2enG7jLDchIhAGdgI
         vvVBRjy2N9cFU98LbPDO46RvuACDej/9JoPqRsgF+WekARxvuR+x8dJSfqH3yItCAPmM
         AEyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772959661; x=1773564461; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kbc34QXFHMxAH0avhY2X5FADoKcSoTWHT7nVNO8z/Kk=;
        b=P/T8cHDebvc2Ja4LU9ySSTVe416DRzWDAIIf1mhtJGv1EX+TwSzKUj6y+/tANUKQhR
         AU3du2Ls3sS7KUbF7PNdRn7pfr6LZpI9va5l4ym5AfKmuA3rIQsjxyk1tYE5A6Bn9ott
         IcsqJbkhPV2AJJZgCsqmjpgHjKylPxjdtDdoaXfon89jPJ/S9hj3IHDbs0d4+9wEru8k
         LmUsRor9fnoz7QFyIU6GChlSLpNKxhSdL0sOJFNts0dU+udX3RUlxJyuFpIXz0Likh7U
         pwFn1Ui2+audcblFAKwLIyQcIwub4u3v9gX/aQIrHvlPaMF0BJOMxdqm33BpAlRkPvce
         781A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772959661; x=1773564461;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kbc34QXFHMxAH0avhY2X5FADoKcSoTWHT7nVNO8z/Kk=;
        b=vDCS/L+t1EqPJqGOO73O/ndofKFvNXM6rpEKSeduTiOLmmLl42/zGeg2FdWI8HTlbJ
         TyVK0gdw2neY8NhAR107GYg0dP1pqesxxLyAx96KBFqLcBYalgRByMZexxfE70FRCMNk
         yjzJlQwBGnAm7txrdBg4idqXU/N1rYX/FFD35OOlllk7/kcjubWYd6ecUmmcqEYn4Q7C
         eeZppBQ3V/zBSfCLnAReNhgg4XLnZuUfu8RjtblLJM9usiz83DzHqIUj5OZg3VuIaPmK
         l+031u6Gfny+qD639FYM3PNsmZVGiWmbA7+NwBzclwOrzdY9uvtVJ4cnLBqigxDSPxAN
         ZsOA==
X-Gm-Message-State: AOJu0YxMcQkE4qyFu1fXsmvG5VcWY9P4rkJ3tcO1i/PGqvPUziJwLi2z
	hk4xd+WEDYEGIy9Mz7gbizhgNQ6Mzl8utuIyt3bhC8YnUA38VZu+MvKz4SOlZldjFhTOnFufKyS
	dtGAobskEk0WVelJ1nD6H2UCC5jBOE+/wbuFgx69dig==
X-Gm-Gg: ATEYQzzq/97PofMpstU7DOw0LyAigDn0Ta4PkuMOfpEHcx/pKAqr3iKgXdmvEAL7Y3q
	k4cIs356gMyzogig3Vxz4hpgqeOZdLw/kSqaHAJv29YKSJPAdSdv1250pBKv/iPnI4+iHFkzaDY
	NC3MOTqYwUaXTMe8ZJKrhKd1kXcqAn0Xib/2ERnUKwjOpfWQkxryXFowqoE5E2K6WBW2YVexXYV
	EZXzghOqLe2JiAUBI4fCeoKZgFC0u2ppvr4YMwlPmE/DAIHNbbjypY5a0P2n/7xKeiPU7wcTyrS
	o82euw==
X-Received: by 2002:a17:903:b0b:b0:2a9:451b:422 with SMTP id
 d9443c01a7336-2ae823829b1mr69536825ad.14.1772959660901; Sun, 08 Mar 2026
 00:47:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?7KO87ZiV7KCV?= <jhj140711@gmail.com>
Date: Sun, 8 Mar 2026 17:47:29 +0900
X-Gm-Features: AaiRm53ePyDFAmRi2RGlkPxcH_Xl52aHXyVe0p31hcn0Gb2eDZLePvzaTY2XeMc
Message-ID: <CAP_j_b8n1dqBXh4x2Bi+0R8KfuKDK01Wbr79m-nT-4JbTHaruA@mail.gmail.com>
Subject: [BUG] freevxfs: slab-out-of-bounds in vxfs_immed_read_folio+0x10f/0x280
 during read()
To: linux-fsdevel@vger.kernel.org, hch@infradead.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 4056E22F13C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79712-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhj140711@gmail.com,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.913];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello,

I am reporting a filesystem bug reproduced on current mainline with
KASAN enabled.

Target file: fs/freevxfs/vxfs_immed.c
Subsystem: fs/freevxfs
Git head: 5ee8dbf54602dc340d6235b1d6aa17c0f283f48c
Kernel release: 7.0.0-rc2+
Case ID: case-20260307T231103Z-fae2

Root cause:
`vxfs_immed_read_folio()` in `fs/freevxfs/vxfs_immed.c` treats
immediate-data inodes as if they contained full folios: it computes
`src = vip->vii_immed.vi_immed + folio_pos(folio)` and unconditionally
copies `PAGE_SIZE` chunks into page cache. But
`fs/freevxfs/vxfs_inode.h` fixes `VXFS_NIMMED` at 96 bytes, and the
in-memory `vii_immed` storage is only that large. `dip2vip_cpy()` also
copies attacker-controlled on-disk `vdi_size` directly into
`inode->i_size` with no `VXFS_ORG_IMMED` clamp, so crafted images can
make the out-of-bounds read user-visible and request farther folios.

Observed crash: slab-out-of-bounds in
vxfs_immed_read_folio+0x10f/0x280 during read()

KASAN excerpt:
[   65.544683][    T1] Testing CPA: again
[   65.586489][    T1] debug: unmapping init [mem
0xffffffffb6127000-0xffffffffb61fffff]
[   65.587399][    T1] debug: unmapping init [mem
0xffffffffb8362000-0xffffffffb83fffff]
[   67.526716][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[   67.529487][    T1] rodata_test: all tests were successful
[   67.530930][    T1] Run /init as init process
[kaudit] guest init start
[kaudit] guest init start
+ mkdir -p /proc
[   68.106626][  T143] mkdir (143) used greatest stack depth: 8 bytes left
+ mount -t proc proc /proc
+ '[' -w /proc/sys/kernel/panic_on_warn ]
+ echo 1
+ '[' -w /proc/sys/kernel/panic_on_oops ]
+ echo 1
+ exec /poc/poc-bin
[   68.695530][  T142] loop0: detected capacity change from 0 to 64
mounting /tmp/vxfs-immed-oob.img via /dev/loop0
page0 trigger on /mnt/vxfs-poc/poc
[   68.787776][  T142]
==================================================================
[   68.788266][  T142] BUG: KASAN: slab-out-of-bounds in
vxfs_immed_read_folio+0x10f/0x280
[   68.788449][  T142] Read of size 4096 at addr ff11000006bef098 by
task poc-bin/142
[   68.788570][  T142]
[   68.788761][  T142] CPU: 0 UID: 0 PID: 142 Comm: poc-bin Tainted: G
       W       T   7.0.0-rc2+ #15 PREEMPT(lazy)
6e12b13d3c2183834abd1baad25d91178d82fdff
[   68.788885][  T142] Tainted: [W]=WARN, [T]=RANDSTRUCT
[   68.788897][  T142] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.15.0-1 04/01/2014
[   68.788952][  T142] Call Trace:
[   68.788983][  T142]  <TASK>
[   68.789023][  T142]  dump_stack_lvl+0x95/0x100
[   68.789067][  T142]  print_address_description.constprop.0+0x2c/0x3c0
[   68.789097][  T142]  ? vxfs_immed_read_folio+0x10f/0x280
[   68.789119][  T142]  print_report+0xb4/0x280
[   68.789140][  T142]  ? kasan_addr_to_slab+0x27/0x80
[   68.789160][  T142]  ? vxfs_immed_read_folio+0x10f/0x280
[   68.789176][  T142]  kasan_report+0xcf/0x140
[   68.789200][  T142]  ? vxfs_immed_read_folio+0x10f/0x280
[   68.789233][  T142]  kasan_check_range+0x3b/0x200
[   68.789253][  T142]  __asan_memcpy+0x24/0x80
[   68.789273][  T142]  vxfs_immed_read_folio+0x10f/0x280
[   68.789303][  T142]  read_pages+0x85c/0xd40
[   68.789325][  T142]  ? __folio_batch_add_and_move+0x4dd/0xb40
[   68.789358][  T142]  ? __pfx_read_pages+0x40/0x40
[   68.789402][  T142]  page_cache_ra_unbounded+0x45b/0xac0
[   68.789451][  T142]  do_page_cache_ra+0xdf/0x140
[   68.789511][  T142]  filemap_get_pages+0x307/0xc80
[   68.789557][  T142]  ? __pfx_filemap_get_pages+0x40/0x40
[   68.789611][  T142]  filemap_read+0x319/0xb40
[   68.789663][  T142]  ? __pfx_filemap_read+0x40/0x40
[   68.789743][  T142]  ? rw_verify_area+0x370/0x580
[   68.789812][  T142]  vfs_read+0x76e/0xd40
[   68.789849][  T142]  ? __pfx_vfs_read+0x40/0x40
[   68.789907][  T142]  __x64_sys_pread64+0x19f/0x200
[   68.789929][  T142]  ? __pfx___x64_sys_pread64+0x40/0x40
[   68.789954][  T142]  ? do_syscall_64+0xa7/0xf40
[   68.789984][  T142]  do_syscall_64+0x141/0xf40
[   68.790042][  T142]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   68.790109][  T142] RIP: 0033:0x4483aa
[   68.790300][  T142] Code: 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00
00 90 f3 0f 1e fa 49 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 15 b8 11
00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 5e c3 0f 1f 44 00 00 48 83 ec 28
48 89 54 24
[   68.790324][  T142] RSP: 002b:00007ffffe4f32e8 EFLAGS: 00000246
ORIG_RAX: 0000000000000011
[   68.790372][  T142] RAX: ffffffffffffffda RBX: 0000000000000004
RCX: 00000000004483aa
[   68.790387][  T142] RDX: 0000000000000020 RSI: 00007ffffe4f32f0
RDI: 0000000000000003
[   68.790399][  T142] RBP: 0000000000000003 R08: 0000000000000000
R09: 0000000000000000
[   68.790410][  T142] R10: 0000000000000000 R11: 0000000000000246
R12: 0000000000499102
[   68.790422][  T142] R13: 0000000000000000 R14: 00007ffffe4f32f0
R15: 0000000000000000
[   68.790492][  T142]  </TASK>
[   68.790541][  T142]
[   68.793900][  T142] Allocated by task 142 on cpu 0 at 68.780092s:
[   68.794124][  T142]  kasan_save_stack+0x29/0x80
[   68.794308][  T142]  kasan_save_track+0x17/0x80
[   68.794402][  T142]  __kasan_slab_alloc+0x97/0xc0
[   68.794502][  T142]  kmem_cache_alloc_lru_noprof+0x264/0x7c0
[   68.794600][  T142]  vxfs_alloc_inode+0x23/0x80
[   68.794694][  T142]  alloc_inode+0x73/0x240
[   68.794782][  T142]  iget_locked+0x18e/0x640
[   68.794879][  T142]  vxfs_iget+0x1e/0x540
[   68.794965][  T142]  vxfs_lookup+0x200/0x280
[   68.795053][  T142]  lookup_open.isra.0+0x59d/0x1240
[   68.795147][  T142]  open_last_lookups+0xc5a/0x1880
[   68.795242][  T142]  path_openat+0x144/0x5c0
[   68.795330][  T142]  do_file_open+0x1db/0x440
[   68.795420][  T142]  do_sys_openat2+0xcf/0x1c0
[   68.795916][  T142]  __x64_sys_openat+0x127/0x200
[   68.796011][  T142]  do_syscall_64+0x141/0xf40
[   68.796108][  T142]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   68.796228][  T142]
[   68.796342][  T142] The buggy address belongs to the object at
ff11000006beeb58
[   68.796342][  T142]  which belongs to the cache vxfs_inode of size 1440
[   68.796657][  T142] The buggy address is located 1344 bytes inside of
[   68.796657][  T142]  allocated 1440-byte region [ff11000006beeb58,
ff11000006bef0f8)
[   68.796813][  T142]
[   68.796928][  T142] The buggy address belongs to the physical page:
[   68.797412][  T142] page: refcount:0 mapcount:0
mapping:0000000000000000 index:0xff11000006bec008 pfn:0x6bec
[   68.797731][  T142] head: order:2 mapcount:0 entire_mapcount:0
nr_pages_mapped:-1 pincount:0
[   68.797929][  T142] flags:
0xfffffc0000240(workingset|head|node=0|zone=1|lastcpupid=0x1fffff)
[   68.798284][  T142] page_type: f5(slab)
[   68.798611][  T142] raw: 000fffffc0000240 ff110000056656c0
ff11000005fc86d0 ff11000005fc86d0
[   68.798740][  T142] raw: ff11000006bec008 00000008000a0005
00000000f5000000 0000000000000000
[   68.798903][  T142] head: 000fffffc0000240 ff110000056656c0
ff11000005fc86d0 ff11000005fc86d0
[   68.799014][  T142] head: ff11000006bec008 00000008000a0005
00000000f5000000 0000000000000000
[   68.799123][  T142] head: 000fffffc0000002 ffd40000001afb01
ffd40000ffffffff 00000000ffffffff

