Return-Path: <linux-fsdevel+bounces-79710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAYZN/42rWkdzgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 08 Mar 2026 09:44:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B2F22F0FE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 08 Mar 2026 09:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28E903018D7C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Mar 2026 08:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D6833556E;
	Sun,  8 Mar 2026 08:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gecIMrCJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD0A28150F
	for <linux-fsdevel@vger.kernel.org>; Sun,  8 Mar 2026 08:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772959480; cv=pass; b=uVNu88GnwhSG8VVEPAV5GyDTJoBOv84kaU0x7Jlt5qmq2xLLx1e5uH7y3660UIGeASV9vg54OwyBD7hgH4Pxeaf5xr8/XcQmlT95GIoKcnuy73lv2gC45Z2gcPkMUpbA+PHHaGapjP0f1SPOpAAUD+3Hy9tXa7fLgTmpNX9QAR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772959480; c=relaxed/simple;
	bh=RF7nDUfFXIWL1Dm7bgHpB00o/Pna7WuJIyZYtjxuVSM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=hjNB17nEihJA1WrvIzII4vr6Ga2IDfqGmqPmW5yc57ZBbr8+kJL8RpSfWVjk71GwwLzhBRCuypzjZLg4Y+bgEaSaD89uWaVUgg2iifI+glT435Q9MYX13r9Wr5ipSfHDfOc6bZ9hlnF1ExI0s91v1yzBlncPCAReNBA/y9TCetc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gecIMrCJ; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3598b95ad7dso5277017a91.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Mar 2026 00:44:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772959479; cv=none;
        d=google.com; s=arc-20240605;
        b=Nnu4sdmpFNIzpT5gqWPuWc2qT/LdnntsKbEeTwgwps46pY/ZY7s5f+4DeXS0fGIAXQ
         e1yDQGxGiUPw/EeVozehDSFOisyCXTrzjq5udMZYGlnj8RTZtPr/gQfF1NlacriuS9Sw
         bwy3VgeTyxjN3MFtDI3PjAa97u0TGSUnU5KpQpD5TlyvMnTG7ZOi98Nl9BYBP4H71g47
         /9594ZcNmirkK17258bbt2PzM6jbVYtwj0QXYHPSMTmJ93HTZAW9IE3m6UpEjYNjOpAQ
         S1aAugXZkzezcYrxrTezlut5frig70Uz5BoJeLvneca7+OxoaaTCiPE6SPrO/Z+GcFoZ
         v3wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Kt8FzZjzubAcdQdJP/yMmlI1a0NcKoWvCND518FqFxs=;
        fh=GoJ+C71T95I9gU2lx4wlLenudvcgBc/o5zwDzFEUPlE=;
        b=SfjR73xqwqotudSORqZDqTo9/AmWKTsFwfMg5GcX6YR7/tJywaMCQ2ZVmUB9PVNFlQ
         iI9+JRxaleFtvL1muLsZrhAbwwf6peG1NYQ6X7pGM0XkkiXXuPX4LaauUqUbjOMnxxDF
         K+iLqL7B2BbkiG/X1rXlZds/UkaE0sCpxyaF7z3qA1Za7hxKTpbDATNdWIn02m8aNJaP
         984m2puT0wX022iJGzjvKCaM2gAaWhAFoAaOx3WgFF/rPBIPxWJGNJHd3bZLDrPAjlKX
         xN122GtLb3pp93CumIcDrjU+jQSBOIj+Y+lNqHDySwExig/bLBpRxXoya9dlpVQwbp0+
         N6dg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772959479; x=1773564279; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Kt8FzZjzubAcdQdJP/yMmlI1a0NcKoWvCND518FqFxs=;
        b=gecIMrCJoTLybyIuBuM/Nsx8IUYMkLFxsJpCd2XKTzoQoKZgnYn6Ats/WBxinHTyCh
         crrp4viuaYMYcuCETRRO5BrY9YL2thdLiGyUQ4h9CqYGwigx99sTu63MUCT33zMcmY3Z
         7ViZtL8HWEO2fQBAErKp7PhwK2GU7ughgqhGYmvwnwbcDjVV5Prj46NScDKCno/zwGIY
         HaIIQsMyqaZEpA//iTjOoNAzQ0OaxmWhI21mfg7JFyhBhMMw7K7bGHE8Zw90n1cddiQY
         D1smNL1HI5s+S0VocubKwcX58pul/sYcfjSgdP8kduEkAlQnTdyLP5uHaT/ctZsWv9lX
         BdqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772959479; x=1773564279;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kt8FzZjzubAcdQdJP/yMmlI1a0NcKoWvCND518FqFxs=;
        b=V14rGjKWRIdtugGkJzjZtZCsRMGW7qUSESitlOeTrMT/KO5nOfhg3nR19y3BKMKsfb
         Jxoef00m3wJfw4tng7apT8XD8bY6kTtzmMoMmU8ITwmkuueTOqvQwumYAk2+Q6DlEEaT
         x2j2rlYWr5yWD5bOLavppFBUUx7OlMA1ZGHhuFCfGtp7Qf5NRg+KPmlxKGoXvSfSRliF
         wY81Fb2j++Hy+uRKlytS/e5MJJxm+VHFU0UTTY5qLSFxNtpmIPRnyRTVogoYdZKD+Ssx
         uKCNEPPJkndHnwDf7mLXjJBeLXq5m+aAFPCYd6cKlEjAou5h7kdSqjjOK6O0GiQKcFqR
         Xefg==
X-Gm-Message-State: AOJu0YyUwoT8GDj6JhAquuN60442z/QDpXSsOCcdx3iJRCIb8BxjuYjY
	SqpZdfGjq2p8EykRSON8MyHBTNEtG8XcoeF91OS542sfkmr3GG2OsjficxnHm1ad26siMlOpddX
	8YAmgLXi2WOQ9+FXUPqrL7UbCizGd4Woup6qM2GnLhA==
X-Gm-Gg: ATEYQzwk0jgS0HzxbXYyFAo4MoF/anNo2uEReLyJpE2+46AjRF7Xr0ghjCRxZOXhFf1
	gaAB18tD/TH6mL5OjDNYf5hPlx9ReKRmIYcazKqBsI1uj6IYLsQEc0bkQYiXEvCZ9uEtLqxPd81
	U28z8b7sd8xI7n1Mf2Oqk39ZbbxXYzd+n3uoplmEZVz1TPvZEF/oBmaSaw7NY8TZozVj5dyLPZ6
	XONYeqqNoWB29R7RXZxgFaVs4KLeYWZQ1sYwxj0dQPqnIjR+RfRrA1m69TEZByf5clCl/ceWuir
	skWmnU/0ku65q1x5
X-Received: by 2002:a17:90b:5587:b0:33b:be31:8194 with SMTP id
 98e67ed59e1d1-359be3adbb0mr7026766a91.34.1772959478528; Sun, 08 Mar 2026
 00:44:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?7KO87ZiV7KCV?= <jhj140711@gmail.com>
Date: Sun, 8 Mar 2026 17:44:27 +0900
X-Gm-Features: AaiRm50sblLA-OXHYDBfisWHHyeRokZHe-dzh79vM5465dyytf3tGlOC8sA5VhE
Message-ID: <CAP_j_b8JGqP2_=5bZ2Jepv1tBBb08wcjY5tJ5f=QAtDj+QdZoQ@mail.gmail.com>
Subject: [BUG] adfs: mount-time null-ptr-deref in range [0x10-0x17] in adfs_read_map()
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 43B2F22F0FE
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
	TAGGED_FROM(0.00)[bounces-79710-lists,linux-fsdevel=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.927];
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
Case ID: case-20260306T142346Z-30e0

Root cause:
The boot-block mount path accepts a disc record with `nzones==0`
because `adfs_validate_bblk()` only gates on `adfs_checkbblk()` and
`adfs_checkdiscrecord()`, and `adfs_checkdiscrecord()` never enforces
a nonzero zone count. `adfs_read_map()` then computes `nzones =
dr->nzones | dr->nzones_high << 8`, calls `kmalloc_objs(*dm, nzones)`
with zero, gets a `ZERO_SIZE_PTR` rather than `NULL`, and immediately
passes it to `adfs_map_layout()`, which writes `dm[0]` and later
`dm[nzones - 1]`, causing a mount-time kernel null/low-address
dereference.

Observed crash: mount-time null-ptr-deref in range
[0x0000000000000010-0x0000000000000017] in adfs_read_map()

KASAN excerpt:
[  144.659016][    T1] CPA  protect  Rodata RO: 0xff1100007364e000 -
0xff1100007364efff PFN 7364e req 8000000000000123 prevent
0000000000000002
[  144.659565][    T1] CPA  protect  Rodata RO: 0xffffffffab64f000 -
0xffffffffab64ffff PFN 7364f req 8000000000000123 prevent
0000000000000002
[  144.660563][    T1] CPA  protect  Rodata RO: 0xff1100007364f000 -
0xff1100007364ffff PFN 7364f req 8000000000000123 prevent
0000000000000002
[  144.668921][    T1] Testing CPA: again
[  145.133922][    T1] debug: unmapping init [mem
0xffffffffa9396000-0xffffffffa93fffff]
[  145.136886][    T1] debug: unmapping init [mem
0xffffffffab650000-0xffffffffab7fffff]
[  157.130123][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[  157.132907][    T1] rodata_test: all tests were successful
[  157.134666][    T1] Run /init as init process
[kaudit] guest init start
[kaudit] guest init start
+ '[' -x /poc/serial-mark ]
+ /poc/serial-mark '[kaudit] run.sh start\n'
[kaudit] run.sh start\n[  158.284872][  T145] serial-mark (145) used
greatest stack depth: 8 bytes left
+ echo '[kaudit] trigger command: /poc/poc-bin'
[kaudit] trigger command: /poc/poc-bin
+ /poc/poc-bin
[  158.729491][  T146] loop0: detected capacity change from 0 to 8
mounting /tmp/adfs-nzones0.img via /dev/loop0; expect crash in adfs_map_layout()
[  158.823801][  T146] Oops: general protection fault, probably for
non-canonical address 0xdffffc0000000002: 0000 [#1] SMP
DEBUG_PAGEALLOC KASAN NOPTI
[  158.824306][  T146] KASAN: null-ptr-deref in range
[0x0000000000000010-0x0000000000000017]
[  158.824306][  T146] CPU: 0 UID: 0 PID: 146 Comm: poc-bin Tainted: G
       W       T   7.0.0-rc2+ #4 PREEMPT(lazy)
f57869d565a4551be95743026afd79a1bf2712c7
[  158.824306][  T146] Tainted: [W]=WARN, [T]=RANDSTRUCT
[  158.824306][  T146] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.15.0-1 04/01/2014
[  158.824306][  T146] RIP: 0010:adfs_read_map+0x420/0xbc0
[  158.824306][  T146] Code: 07 83 c0 01 38 d0 7c 08 84 d2 0f 85 7f 05
00 00 0f b7 45 0a 48 8b 54 24 10 41 29 c7 48 c1 ea 03 48 b8 00 00 00
00 00 fc ff df <80> 3c 02 00 44 89 7c 24 08 0f 85 12 07 00 00 48 8b 44
24 10 48 8d
[  158.824306][  T146] RSP: 0018:ffa00000014a7658 EFLAGS: 00000202
[  158.824306][  T146] RAX: dffffc0000000000 RBX: 0000000000000000
RCX: 0000000000000000
[  158.824306][  T146] RDX: 0000000000000002 RSI: 0000000000000000
RDI: 0000000000000000
[  158.824306][  T146] RBP: ff11000006345dc0 R08: 0000000000000000
R09: 0000000000000000
[  158.824306][  T146] R10: 0000000000000000 R11: 0000000000000000
R12: ff11000004f04000
[  158.824306][  T146] R13: ff11000006345dca R14: 0000000000000000
R15: 0000000000002000
[  158.824306][  T146] FS:  00000000004ce3c0(0000)
GS:ff110000ab608000(0000) knlGS:0000000000000000
[  158.824306][  T146] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  158.824306][  T146] CR2: 00000000004c91a0 CR3: 000000000b0af000
CR4: 00000000007516f0
[  158.824306][  T146] PKRU: 55555554
[  158.824306][  T146] Call Trace:
[  158.824306][  T146]  <TASK>
[  158.824306][  T146]  adfs_probe+0x3b7/0x540
[  158.824306][  T146]  ? __pfx_adfs_validate_bblk+0x40/0x40
[  158.824306][  T146]  ? __pfx_adfs_probe+0x40/0x40
[  158.824306][  T146]  ? shrinker_debugfs_rename+0x1bb/0x2c0
[  158.824306][  T146]  adfs_fill_super+0x179/0x640
[  158.824306][  T146]  ? __pfx_adfs_fill_super+0x40/0x40
[  158.824306][  T146]  ? kfree_const+0x5a/0x80
[  158.824306][  T146]  ? shrinker_debugfs_rename+0x1c0/0x2c0
[  158.824306][  T146]  ? __pfx_shrinker_debugfs_rename+0x40/0x40
[  158.824306][  T146]  ? __pfx_snprintf+0x40/0x40
[  158.824306][  T146]  ? tracer_preempt_on+0x44/0x5c0
[  158.824306][  T146]  ? _raw_spin_unlock+0x2d/0x80
[  158.824306][  T146]  ? set_blocksize+0x384/0x480
[  158.824306][  T146]  ? sb_set_blocksize+0x1b1/0x340
[  158.824306][  T146]  ? setup_bdev_super+0x431/0x900
[  158.824306][  T146]  ? __pfx_super_s_dev_set+0x40/0x40
[  158.824306][  T146]  get_tree_bdev_flags+0x3aa/0x680
[  158.824306][  T146]  ? __pfx_adfs_fill_super+0x40/0x40
[  158.824306][  T146]  ? __pfx_get_tree_bdev_flags+0x40/0x40
[  158.824306][  T146]  ? rcu_is_watching+0x12/0x100
[  158.824306][  T146]  ? cap_capable+0x142/0x380
[  158.824306][  T146]  vfs_get_tree+0x98/0x380
[  158.824306][  T146]  fc_mount+0x1f/0x240
[  158.824306][  T146]  do_new_mount+0x3d6/0x700
[  158.824306][  T146]  ? __pfx_do_new_mount+0x40/0x40
[  158.824306][  T146]  ? cap_capable+0x142/0x380
[  158.824306][  T146]  ? bpf_lsm_capable+0xe/0x40
[  158.824306][  T146]  ? security_capable+0x307/0x380
[  158.824306][  T146]  path_mount+0x4bb/0x1500
[  158.824306][  T146]  ? kmem_cache_free+0x169/0x7c0
[  158.824306][  T146]  ? putname+0xb9/0x140
[  158.824306][  T146]  ? __pfx_path_mount+0x40/0x40
[  158.824306][  T146]  ? putname+0xb9/0x140
[  158.824306][  T146]  __x64_sys_mount+0x2a8/0x340
[  158.824306][  T146]  ? __pfx___x64_sys_mount+0x40/0x40
[  158.824306][  T146]  ? tracer_hardirqs_on+0x3c9/0x5c0
[  158.824306][  T146]  ? do_syscall_64+0xa7/0x940
[  158.824306][  T146]  do_syscall_64+0x141/0x940
[  158.824306][  T146]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  158.824306][  T146] RIP: 0033:0x44a10e
[  158.824306][  T146] Code: 48 c7 c0 ff ff ff ff eb aa e8 0e 06 00 00
66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 f3 0f 1e fa 49 89 ca b8 a5
00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8
64 89 01 48
[  158.824306][  T146] RSP: 002b:00007fffa4a988c8 EFLAGS: 00000202
ORIG_RAX: 00000000000000a5
[  158.824306][  T146] RAX: ffffffffffffffda RBX: 0000000000000000
RCX: 000000000044a10e
[  158.824306][  T146] RDX: 00000000004980f6 RSI: 000000000049802d
RDI: 00007fffa4a98970
[  158.824306][  T146] RBP: 0000000000000003 R08: 00000000004af4bd
R09: 746365707865203b
[  158.824306][  T146] R10: 0000000000000001 R11: 0000000000000202
R12: 00007fffa4a98970
[  158.824306][  T146] R13: 000000000049806e R14: 00007fffa4a988e0
R15: 0000000000000004
[  158.824306][  T146]  </TASK>
[  158.824306][  T146] Modules linked in:
[  158.854456][  T146] ---[ end trace 0000000000000000 ]---
[  158.855680][  T146] RIP: 0010:adfs_read_map+0x420/0xbc0
[  158.856500][  T146] Code: 07 83 c0 01 38 d0 7c 08 84 d2 0f 85 7f 05
00 00 0f b7 45 0a 48 8b 54 24 10 41 29 c7 48 c1 ea 03 48 b8 00 00 00
00 00 fc ff df <80> 3c 02 00 44 89 7c 24 08 0f 85 12 07 00 00 48 8b 44
24 10 48 8d
[  158.857115][  T146] RSP: 0018:ffa00000014a7658 EFLAGS: 00000202
[  158.857587][  T146] RAX: dffffc0000000000 RBX: 0000000000000000
RCX: 0000000000000000
[  158.857962][  T146] RDX: 0000000000000002 RSI: 0000000000000000
RDI: 0000000000000000
[  158.858320][  T146] RBP: ff11000006345dc0 R08: 0000000000000000
R09: 0000000000000000
[  158.858701][  T146] R10: 0000000000000000 R11: 0000000000000000
R12: ff11000004f04000
[  158.859091][  T146] R13: ff11000006345dca R14: 0000000000000000
R15: 0000000000002000
[  158.859473][  T146] FS:  00000000004ce3c0(0000)
GS:ff110000ab608000(0000) knlGS:0000000000000000
[  158.859883][  T146] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  158.860567][  T146] CR2: 00000000004c91a0 CR3: 000000000b0af000
CR4: 00000000007516f0
[  158.860946][  T146] PKRU: 55555554

