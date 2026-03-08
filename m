Return-Path: <linux-fsdevel+bounces-79711-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDQLFp83rWlfzgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79711-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 08 Mar 2026 09:47:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B189222F12D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 08 Mar 2026 09:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 424443017796
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Mar 2026 08:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A369835F165;
	Sun,  8 Mar 2026 08:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vt6Otth0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BCA299A8A
	for <linux-fsdevel@vger.kernel.org>; Sun,  8 Mar 2026 08:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772959610; cv=pass; b=ZAHJZrDKjj0HeZwmjinG0TOEfTAi3m+jZO6PCJDPi+qUytcjpVP8udmfrStLIHg8ims7iU5cH6f0kYue8N9+KUHcgVV8FpnvLhOrOAflq2cRpIaRmKkri75/02yR7ccfRaTUicqcbFMfQscNB1HE1GDhiHMmtf4cJKf0oUQIhMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772959610; c=relaxed/simple;
	bh=tf3r2elshvBw4G+Al7uwJdaiIQZQ357c/MjcC3Dy+xA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=qClHBVVWuZuO0sVgxdtEGoKT5IKYup5I7ojqUzdkpfZ+ZzGzdOH6z5AsS3wkQf2dcK6AEvoxinm8lDjltOAYTkSYa/OW5y3TIxXIlmn4ntl8JC1sSAKg2AWb7m0dt2xHrRpj9TYKPqXBEFSFs45kdGsINoEsKKqmy9lBGEgzHD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vt6Otth0; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3598b2318c2so4145623a91.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Mar 2026 00:46:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772959608; cv=none;
        d=google.com; s=arc-20240605;
        b=B0oPl4/scXxkF/upsgzLtplPQAv8s/NkjgNLfAftKYqLmVHTdLcdUh+SHBJhong8EP
         l0/Zxm+UAX5yaImB3+K5fBhY40lbBqWUnHNdvUYJmb/pE1jPmCN2vR05lTcG3jMIJOcD
         O3A1zUEq8bJkChphwlTowc0U8tuycPKWin0EEzCNndVbie6YPSNc9AaHbucn7Re7zMTS
         bkHFe4NxTfj8xqiJF8UC8dSHKRzf1DU2XiRY6//HPG10uzfYqx5LBOC9VIMEKscLp0Vq
         9tbWejQ9zGwXatPz8xDpiH2hrhxgECEnzpo8bCLT5NS2vmU5XV3nuy/FHd4WXkWRlbJo
         tQYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=rboZjTz549OhTV3wJrJuZovxI7ft6n2D/8l5VD3+xzc=;
        fh=GoJ+C71T95I9gU2lx4wlLenudvcgBc/o5zwDzFEUPlE=;
        b=GIVzNKKq3Zh8v+bkvDgv+jB43U8UljdMPOhxGTXkhS7lU5RRuhXI0IvoefnIJB1KBi
         tTI8W8RDBxhVrfS8byA4efeEDXRvn1SkSWfuTUZkqUwanEwZO7K0Y8s5oSaqQg9bk+f5
         CScaT/CYGherx3BJa/bBnEIGBZ1ujjrdtlumA43Pbrcv3iBYK9iommOc3q9JCOeK7VFn
         liVl5o5D1SUxHbegrjszxLBxvz7KDKwS+gaFmxdRhPBMzTlu5ID1ajoZ1mCyVCNXNQT4
         iFPJqu0iMsxQURLHa07I7BwEMeLmfnjlSq/FavPMTYJ8zFvnUTFtNdRTZXwTH3tgAh/N
         uq4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772959608; x=1773564408; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rboZjTz549OhTV3wJrJuZovxI7ft6n2D/8l5VD3+xzc=;
        b=Vt6Otth0H7X+l2K2S2u0gQMppj+AoaPXwdHto44xQuaW6+iy8JSAKGVtirTGG7PmQE
         Dq5kItnuWisIX1qIp/l21jeiCAbvy7L9U4kSM84xs5tPlsv77bx49M700sCiCBDeqXXZ
         E/W7lQbUDSVaycA5eNg9Lrk83keSuyHOZDmW7W/TCbMrjEyPBckl0qS3kyyssRw1SWVw
         PewtLoXFR696Fq4ez+R5ivvX/e0Q2piDopPjZWAgbg3KALkpLKYJTrxjD4gCz08/72Pc
         IAlwQJV/04lQobAB9yRZeYjD+u2qLkilMA0+K3YYkdL6hgJB0C63ZzMVQ3c4Mx4+UTNv
         PVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772959608; x=1773564408;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rboZjTz549OhTV3wJrJuZovxI7ft6n2D/8l5VD3+xzc=;
        b=hX/Uxh3fDyNcfD/xsU3khD5z3nbFAVZcXywrK3qGmWHBF+GJLUnETdyThLsb3Uw0tD
         t8+7Wh+RyUNEh0kHqOjhsjef7jaAHk5I1IQdxj7EPjTztatbI/rRy4Ubp+M6N9qPLA9x
         HletnZnkdgbfN+qxfC/Ha2MkOoZ6//8jjnNe3j45RQYyXoV/gMOZzwPWikdsfk7zvS60
         ZQ0R/1XBPhEVPZgRk5X5ivhbvHJ2qKkrjW1TfMr7h+zPeoBQQxtijIr7KWh5Yl4CcSIq
         1czMqEXz5ciXs6xxmNF9mPZlPxOgdqoK+atYZ0t+kzBKOhmEjIz4ea2/ZMFiwWXvmTGF
         nd+g==
X-Gm-Message-State: AOJu0YzKDzDEqGyM9H946SrCMzibBp0Khn8jsht+6lyd2LRe6DodLTq+
	bWEZ5uxaHjQOQgPuOukKzymdTF1PWF8HaHwRN8N+VjaDXh45fxM8maTQwLx07XNbClQkzcp19d6
	8Vu3FKIbwTpjOuov9YcmN+07F85qCkCgCeB+qZJ4kZA==
X-Gm-Gg: ATEYQzzHiNnc2BZtSja27AOyYnYH/o5KdATDn9MyWGlulgNJtBwO7LSS6zSy6rYvg+G
	PBuRO4aMabqMG291q1b4w29K+esR5fzrL1yGxZtHNbbXpkQXwGryLt6xYkD3klzC+s+7mSxGaEY
	LhV0GmigNS5FzhkYvqxWYviatInFy572kXvjZg9Zz/ezdyhp7D1/3itYJG/DfQDz5gxtxtcuV70
	8HoOA5aEHoKkAkl0aTwVElG1rAfCbtHkNaZXemE400slZ7NpMuh8BYIHQQWOZrXrYbp4U11OP4+
	+k4lZ1kYdWphHB2u
X-Received: by 2002:a17:90b:5544:b0:359:8d70:c4ed with SMTP id
 98e67ed59e1d1-359be28e0d6mr6998119a91.7.1772959607976; Sun, 08 Mar 2026
 00:46:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?7KO87ZiV7KCV?= <jhj140711@gmail.com>
Date: Sun, 8 Mar 2026 17:46:36 +0900
X-Gm-Features: AaiRm508yl2DeuTh2jlLtpaZ9DCXY4efN1fS5xLhGU2p8mJQezas-gIlTsI-Mak
Message-ID: <CAP_j_b-z_LowEExS-yAKsCPdzjRjr-md=57ETosyUHopMV=_jg@mail.gmail.com>
Subject: [BUG] adfs: use-after-free in _find_next_bit+0xe2/0x140 during getdents64()
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: B189222F12D
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
	TAGGED_FROM(0.00)[bounces-79711-lists,linux-fsdevel=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.914];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

Hello,

I am reporting a filesystem bug reproduced on current mainline with
KASAN enabled.

Target file: fs/adfs/map.c
Subsystem: fs/adfs
Git head: 5ee8dbf54602dc340d6235b1d6aa17c0f283f48c
Kernel release: 7.0.0-rc2+
Case ID: case-20260306T142346Z-211f

Root cause:
`fs/adfs/super.c:324-335` accepts a DR0 image whenever the disc record
passes the shallow `adfs_checkdiscrecord()` checks and `nzones==1`.
`fs/adfs/map.c:356-385` then reads exactly one map sector from block
0, but `adfs_map_layout()` overwrites `dm[0].dm_endbit` with `512 +
(adfs_disc_size(dr) >> dr->log2bpmb)` for the one-zone case
(`fs/adfs/map.c:329-331`) and never checks that this fits inside the
single loaded buffer (`sb->s_blocksize * 8` bits). Later map walkers
trust that oversized bound while reading `dm->dm_bh->b_data`,
producing a live-buffer out-of-bounds read during post-mount map
traversal. For this one-zone path, `disc_size/log2bpmb` is the
decisive inflator; `zone_spare` is not required for the final
`dm_endbit` overwrite.

Observed crash: use-after-free in _find_next_bit+0xe2/0x140 during getdents64()

KASAN excerpt:
[   83.536813][  T158] ADFS-fs error (device loop0):
adfs_dir_read_buffers: dir 000200 failed read at offset 0, mapped
block 0x00013d02
getdents64: Input/output error
[   83.202718][  T142] sh (142): drop_caches: 3
[   83.497412][  T158] kobject: 'loop0' (ff11000001433798): kobject_uevent_env
[   83.497586][  T158] kobject: 'loop0' (ff11000001433798):
kobject_uevent_env: uevent_suppress caused the event to drop!
[   83.499843][  T158] loop0: detected capacity change from 0 to 8
[   83.500351][  T158] kobject: 'loop0' (ff11000001433798): kobject_uevent_env
[   83.500422][  T158] kobject: 'loop0' (ff11000001433798):
kobject_uevent_env: uevent_suppress caused the event to drop!
[   83.500473][  T158] kobject: 'loop0' (ff11000001433798): kobject_uevent_env
[   83.501083][  T158] kobject: 'loop0' (ff11000001433798):
fill_kobj_path: path = '/devices/virtual/block/loop0'
[   83.536813][  T158] ADFS-fs error (device loop0):
adfs_dir_read_buffers: dir 000200 failed read at offset 0, mapped
block 0x00013d02
[   83.589296][  T158] kobject: 'loop0' (ff11000001433798): kobject_uevent_env
[   83.591287][  T158] kobject: 'loop0' (ff11000001433798):
fill_kobj_path: path = '/devices/virtual/block/loop0'
[   83.591744][  T158] kobject: 'loop0' (ff11000001433798): kobject_uevent_env
[   83.592497][  T158] kobject: 'loop0' (ff11000001433798):
fill_kobj_path: path = '/devices/virtual/block/loop0'
[*] attempt 3/128
[   84.603537][  T142] sh (142): drop_caches: 3
image=/tmp/adfs-dmendbit.img disc_size=1073741824 dm_endbit=2097664
bits (262208 bytes max)
[   84.901503][  T167] loop0: detected capacity change from 0 to 8
[   84.943773][  T167]
==================================================================
[   84.944056][  T167] BUG: KASAN: use-after-free in _find_next_bit+0xe2/0x140
[   84.944056][  T167] Read of size 8 at addr ff1100005b909000 by task
poc-bin/167
[   84.944056][  T167]
[   84.944056][  T167] CPU: 0 UID: 0 PID: 167 Comm: poc-bin Tainted: G
       W       T   7.0.0-rc2+ #5 PREEMPT(lazy)
ccfb407f8ed1d19667324f70fc2e5f4a9b6173f6
[   84.944056][  T167] Tainted: [W]=WARN, [T]=RANDSTRUCT
[   84.944056][  T167] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.15.0-1 04/01/2014
[   84.944056][  T167] Call Trace:
[   84.944056][  T167]  <TASK>
[   84.944056][  T167]  dump_stack_lvl+0x95/0x100
[   84.944056][  T167]  print_address_description.constprop.0+0x2c/0x3c0
[   84.944056][  T167]  ? _find_next_bit+0xe2/0x140
[   84.944056][  T167]  print_report+0xb4/0x280
[   84.944056][  T167]  ? kasan_addr_to_slab+0x27/0x80
[   84.944056][  T167]  ? kasan_complete_mode_report_info+0xa3/0xc0
[   84.944056][  T167]  kasan_report+0x9b/0x100
[   84.944056][  T167]  ? _find_next_bit+0xe2/0x140
[   84.944056][  T167]  _find_next_bit+0xe2/0x140
[   84.944056][  T167]  ? find_held_lock+0x32/0xc0
[   84.944056][  T167]  scan_map+0x2ac/0x4c0
[   84.944056][  T167]  ? adfs_map_lookup+0x11d/0x340
[   84.944056][  T167]  adfs_map_lookup+0x12e/0x340
[   84.944056][  T167]  adfs_dir_read_buffers+0x282/0x5c0
[   84.944056][  T167]  adfs_f_read+0x76/0x3c0
[   84.944056][  T167]  ? __down_read_trylock+0x1de/0x480
[   84.944056][  T167]  adfs_dir_read_inode+0x15f/0x2c0
[   84.944056][  T167]  adfs_iterate+0x127/0x480
[   84.944056][  T167]  ? __pfx_adfs_iterate+0x40/0x40
[   84.944056][  T167]  ? iterate_dir+0x152/0xa80
[   84.944056][  T167]  ? down_read_killable+0x116/0x380
[   84.944056][  T167]  ? __pfx_down_read_killable+0x40/0x40
[   84.944056][  T167]  ? selinux_file_permission+0x3c2/0x500
[   84.944056][  T167]  iterate_dir+0x238/0xa80
[   84.944056][  T167]  ? fdget_pos+0x24e/0x340
[   84.944056][  T167]  __x64_sys_getdents64+0x132/0x240
[   84.944056][  T167]  ? __pfx___x64_sys_getdents64+0x40/0x40
[   84.944056][  T167]  ? __pfx_filldir64+0x40/0x40
[   84.944056][  T167]  do_syscall_64+0x141/0xf40
[   84.944056][  T167]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   84.944056][  T167] RIP: 0033:0x448dcd
[   84.944056][  T167] Code: 02 b8 ff ff ff ff eb b8 0f 1f 44 00 00 f3
0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b
4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8
64 89 01 48
[   84.944056][  T167] RSP: 002b:00007fff97d52248 EFLAGS: 00000246
ORIG_RAX: 00000000000000d9
[   84.944056][  T167] RAX: ffffffffffffffda RBX: 0000000000000005
RCX: 0000000000448dcd
[   84.944056][  T167] RDX: 0000000000002000 RSI: 00007fff97d52390
RDI: 0000000000000003
[   84.944056][  T167] RBP: 0000000000000003 R08: 00007fff97d520e0
R09: 0000000000000000
[   84.944056][  T167] R10: 00000000004b04dd R11: 0000000000000246
R12: 000000000049900f
[   84.944056][  T167] R13: 00007fff97d52390 R14: 000000000049907f
R15: 00007fff97d52350
[   84.944056][  T167]  </TASK>
[   84.944056][  T167]
[   84.944056][  T167] The buggy address belongs to the physical page:
[   84.944056][  T167] page: refcount:0 mapcount:0
mapping:0000000000000000 index:0x215 pfn:0x5b909
[   84.944056][  T167] flags: 0xfffffc0000000(node=0|zone=1|lastcpupid=0x1fffff)
[   84.944056][  T167] raw: 000fffffc0000000 ffd40000016e5148
ffd40000016e3e88 0000000000000000
[   84.944056][  T167] raw: 0000000000000215 0000000000000000
00000000ffffffff 0000000000000000
[   84.944056][  T167] page dumped because: kasan: bad access detected
[   84.944056][  T167]
[   84.944056][  T167] Memory state around the buggy address:
[   84.944056][  T167]  ff1100005b908f00: 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00
[   84.944056][  T167]  ff1100005b908f80: 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00
[   84.944056][  T167] >ff1100005b909000: ff ff ff ff ff ff ff ff ff
ff ff ff ff ff ff ff
[   84.944056][  T167]                    ^
[   84.944056][  T167]  ff1100005b909080: ff ff ff ff ff ff ff ff ff
ff ff ff ff ff ff ff
[   84.944056][  T167]  ff1100005b909100: ff ff ff ff ff ff ff ff ff
ff ff ff ff ff ff ff
[   84.944056][  T167]
==================================================================
[   84.957085][  T167] Disabling lock debugging due to kernel taint
[   84.957940][  T167] BUG: unable to handle page fault for address:
ff1100005b909000
[   84.958241][  T167] #PF: supervisor read access in kernel mode
[   84.958369][  T167] #PF: error_code(0x0000) - not-present page
[   84.958604][  T167] PGD 6b201067 P4D 6b202067 PUD 6b205067 PMD
7f831067 PTE 800fffffa46f6020
[   84.959193][  T167] Oops: Oops: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN NOPTI
[   84.959358][  T167] CPU: 0 UID: 0 PID: 167 Comm: poc-bin Tainted: G
   B   W       T   7.0.0-rc2+ #5 PREEMPT(lazy)
ccfb407f8ed1d19667324f70fc2e5f4a9b6173f6
[   84.959559][  T167] Tainted: [B]=BAD_PAGE, [W]=WARN, [T]=RANDSTRUCT
[   84.959692][  T167] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.15.0-1 04/01/2014
[   84.959835][  T167] RIP: 0010:_find_next_bit+0xa3/0x140
[   84.959990][  T167] Code: df 4a 8d 6c 2d 08 eb 14 48 83 c3 01 48 83
c5 08 48 89 da 48 c1 e2 06 48 39 d0 76 2a 48 89 ea 48 c1 ea 03 42 80
3c 22 00 75 33 <48> 8b 55 00 48 85 d2 74 d5 48 c1 e3 06 f3 48 0f bc d2
48 01 d3 48
[   84.960216][  T167] RSP: 0018:ffa00000014e78c8 EFLAGS: 00000246
[   84.960354][  T167] RAX: 0000000000200200 RBX: 0000000000000200
RCX: 0000000000000000
[   84.960499][  T167] RDX: 0000000000000000 RSI: 0000000000000000
RDI: 0000000000000000
[   84.960645][  T167] RBP: ff1100005b909000 R08: 0000000000000000
R09: 0000000000000000
[   84.960781][  T167] R10: 0000000000000000 R11: 0000000000000000
R12: dffffc0000000000
[   84.960914][  T167] R13: 0000000000000040 R14: dffffc0000000000
R15: ff1100005b908000

