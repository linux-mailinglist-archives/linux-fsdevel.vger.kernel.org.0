Return-Path: <linux-fsdevel+bounces-79713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJwRFkI4rWlfzgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 08 Mar 2026 09:50:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BEE22F163
	for <lists+linux-fsdevel@lfdr.de>; Sun, 08 Mar 2026 09:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35668301A393
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Mar 2026 08:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9644C3603D9;
	Sun,  8 Mar 2026 08:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIYbUibv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E604E311C07
	for <linux-fsdevel@vger.kernel.org>; Sun,  8 Mar 2026 08:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772959797; cv=pass; b=GvfXB+nPCPHQ695DG1S2Kt7+Ol5hUN1DRMxGQfN9yTbR3MH60w1WOVmUz9DeGOpsXYkItNgx0qsqQGLPko89tE78BraGUm+X6XL787td51+v1Aq0m0fmB+YGdRDjS+TOLFFdifgV4ft2nqMVbGUP3if4mCv5OwbQ8dUHRCzQY5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772959797; c=relaxed/simple;
	bh=lP6DiNEox1aPqtr1Iq/sPErZfEaAQKppzfv04uOaK9U=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=o54Hm38fdhjWLH6sFikIQWPi/OL7SvUdnBqpXBOLB/lAUQH8gDmZ+N8mVAOqDzXWiZMV5tx+S8/e+4yUV59SOiZ7zLXovNqoVJY6lOwgDgupR2j0eSmTxZmLhGHg0DRcHwtz3CyFfMAtc/NZL42FUwoz1081RNOb9pbf32NGQ6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LIYbUibv; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ae82df847bso13417505ad.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Mar 2026 00:49:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772959795; cv=none;
        d=google.com; s=arc-20240605;
        b=KC8lBxOIwEBkjebd/u2Jb/chU6WYlA6/LHHhTyAM0Y9cbnYMdSDOsFeZlOniW2Ycvo
         E7XMic/P2YyvgxswL73EEPiLjW0UtuU/yAwU75lPpBhgP3Pay2NE0HCsF2eXCYYyyW6s
         +aNwX0FQU6Owz6Nf8ice/pu7if2YALCZ1wysyU6ECWfUVqHG+AGzRaagRUa88V8pbPDy
         Rwt5/h9qUzLfSTbT3hXnBFJIfPjh/L/kDKHMaXAprzS4BEvNcY8hGnOklPbffRlCbVIm
         u2cYuCFM4qRS7SRGM4mZkK29wUtlH8oRbjw2g2ocJPWa8S0B6pY3rS9aVYLe+IOZkvQk
         F8fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=pc3YqqYFEuLpSqPyedSIxc4orm+adq/HCmUubnUSthY=;
        fh=QuU0TuJtA3b/j0DwPU8XBn04NNqmYshPNMEIbD6+/LE=;
        b=EjXbKjKeErVk1DKBD8wVRwhpbqbIvJDqL1fB0O929T8hJ9PIoEIpGBT7RwnVs8zpaX
         FY0+v4qTNlBFqt3IwUVY9/fcgHtpOAOVDkOk75MXd9Yzdw2oUCzkbwC4Nlaxw+EM3QT6
         kxJI5nRjl4PosHAvPbikzDhPTbraprPgME8DsI4p8FDuwF8p8tECOsGivV6hVLvx19Py
         A1oYvx8CBavf85M6kjDmZBYO4x1EoXTHXDesHQPF3rXHGi0QJGubISRxicTq404TPv20
         bt1ZxHw8b/MB0W8dOGHl1Og42C6uzUSEIiDN4ACIN0/kSpVHju5HOYSbZRqXvrWPCk+y
         XUpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772959795; x=1773564595; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pc3YqqYFEuLpSqPyedSIxc4orm+adq/HCmUubnUSthY=;
        b=LIYbUibvL92LziT4MnXHsWcVMS1rBL5/OAn3m6+tqR2MAZTsQ5VkDrsupYpGLLFOw4
         XiYClQsutU2c4Ss+a3DcSSUnH5S2aJLyc5MRT+vV1r1vjhPfKpVKTmJPCzAUmQX5NeAE
         4anamdOo9yHWfk3fJo0BagoWOLmjSXv38LeuwwUQ5ePRcA/Cpucb+dGkv90+vXHFWKuv
         DI+AThxlpZoysNpmYzMPXfBiynVPCp5RJXWAKRTtlgXrtcKnECjp2dA8WpeAnP9xwGMv
         QGCaGqQ93VbpYMChRlE7ncXLVWiU4urvKgBx/lGBb1mx7wgdl9m+eiWtbrnOpAjyjvhy
         mBZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772959795; x=1773564595;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pc3YqqYFEuLpSqPyedSIxc4orm+adq/HCmUubnUSthY=;
        b=ttJxDbVHjv+ZchkreM0Ol89rUiESxc/QJI6a2A818FEE9OzReKWC0t4JYTuLApy5wZ
         hXhtFVG+AS2HI13KN7WqIcBypPn6hSf33l/yb3d0/ICfysFAXxxQXs7lfXGU6hlqShA/
         2pVf4GGgr5SnuDcA+fyipK0HRbUCJjDcJ1YOK/rLik2fSt6Ydx6kZfhU2WF65ItefEZW
         U2rZGTqCZ+2QDM05paHL7UFYQPMw6j+kC2194/mOFye/RudclQdhu8NzoCWh7HQfaYIn
         Y96+2wEiHtZZVd0ZR6bNhbZBc2INfnUKjnqAo/3f1haw1OcI5EaR03plhpWZp8GtKJXB
         0MXA==
X-Gm-Message-State: AOJu0Yy4wpl1qSVaWCAObtfmsjp5h4MwBlmmo0fMU4yY/J9bdTJgw7c5
	xDaGvJdHR60otRy+3ausj6v7Dp3H4BBk/h1DsmGpoN3Y0xxuBBk8s0fuCaqfCUkdyoT+QyFDaPi
	qRSOQSGhUnefNrq0n7KzhdAiIoktptXoqHXg3XC4+9A==
X-Gm-Gg: ATEYQzxntjr7r3TP129qLHq6odRYjdecQmIxf++IT7s2zVls1vORyVkYAI3eUHxtP0u
	U38gNcb4LqN/HT4Qc8y9z6jmMdB5C4Bh6If5u4d9uj1zxteJG7HJYG7n9ztfR3ujhnlbrFmYlC4
	C6zXGplGQqrhsTmOfOAtykxvEcKjfusy7KBJBWw8nrUgzS/QC6oRTWgZW2MRRX/pHjYcafkVyQX
	z7TFsMud2SAHmBdeKlBomGd0pRheP0nMFGTmY4lTQ2LVWa54Oqm0MjQRyQ6oLXTh9sUrzaxuOvY
	qshOlA==
X-Received: by 2002:a05:6300:492:b0:398:7d6e:27f1 with SMTP id
 adf61e73a8af0-3987d6e4e98mr1607883637.9.1772959794955; Sun, 08 Mar 2026
 00:49:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?7KO87ZiV7KCV?= <jhj140711@gmail.com>
Date: Sun, 8 Mar 2026 17:49:44 +0900
X-Gm-Features: AaiRm53RBAt6IhcODhFII-9BzYzBDZVv8fwd8woXyLKlU4hJLKweHEn-G9b1Ofg
Message-ID: <CAP_j_b-tEMgu=RLxJfs_j6W312qZWLFTDOrgxKzi9gKk1zgBhw@mail.gmail.com>
Subject: [BUG] efs: out-of-bounds in efs_symlink_read_folio+0x1b8/0x440 during readlink()
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, brauner@kernel.org, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: A6BEE22F163
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
	TAGGED_FROM(0.00)[bounces-79713-lists,linux-fsdevel=lfdr.de];
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
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.913];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,run.sh:url]
X-Rspamd-Action: no action

Hello,

I am reporting a filesystem bug reproduced on current mainline with
KASAN enabled.

Target file: fs/efs/symlink.c
Subsystem: fs/efs
Git head: 5ee8dbf54602dc340d6235b1d6aa17c0f283f48c
Kernel release: 7.0.0-rc2+
Case ID: case-20260307T185409Z-093c

Root cause:
`fs/efs/inode.c` copies the on-disk `efs_dinode.di_size` field into
`inode->i_size`, and `fs/efs/symlink.c` narrows that value back to
signed `efs_block_t` with `efs_block_t size = inode->i_size;`. Because
`efs_block_t` is `int32_t`, any crafted symlink size >= `0x80000000`
becomes negative, bypasses the `size > 2 * EFS_BLOCKSIZE` guard, and
is then used as both a `memcpy()` length and the index for
`link[size]`, causing synchronous out-of-bounds memory access while
filling the symlink folio.

Observed crash: out-of-bounds in efs_symlink_read_folio+0x1b8/0x440
during readlink()

KASAN excerpt:
[   68.942491][    T1] CPA  protect  Rodata RO: 0xffffffffac95e000 -
0xffffffffac95efff PFN 1ff5e req 8000000000000123 prevent
0000000000000002
[   68.942669][    T1] CPA  protect  Rodata RO: 0xff1100001ff5e000 -
0xff1100001ff5efff PFN 1ff5e req 8000000000000123 prevent
0000000000000002
[   68.943342][    T1] Testing CPA: again
[   68.990028][    T1] debug: unmapping init [mem
0xffffffffaa71e000-0xffffffffaa7fffff]
[   68.991190][    T1] debug: unmapping init [mem
0xffffffffac95f000-0xffffffffac9fffff]
[   71.381565][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[   71.382779][    T1] rodata_test: all tests were successful
[   71.384395][    T1] Run /init as init process
[kaudit] guest init start
[kaudit] guest init start
+ '[' -x /poc/serial-mark ]
+ /poc/serial-mark '[kaudit] run.sh start\n'
[kaudit] run.sh start\n[   72.070980][  T143] serial-mark (143) used
greatest stack depth: 8 bytes left
+ echo '[kaudit] trigger command: /poc/poc-bin'
[kaudit] trigger command: /poc/poc-bin
+ /poc/poc-bin
[   72.382567][  T144] loop0: detected capacity change from 0 to 5
[*] crafted EFS image at /tmp/efs-symlink.img
[*] attached /dev/loop0 and invoking readlink(/mnt/efs/poc)
[   72.452535][  T144]
==================================================================
[   72.452929][  T144] BUG: KASAN: out-of-bounds in
efs_symlink_read_folio+0x1b8/0x440
[   72.453107][  T144] Read of size 18446744073709551615 at addr
ff11000018906800 by task poc-bin/144
[   72.453251][  T144]
[   72.453457][  T144] CPU: 0 UID: 0 PID: 144 Comm: poc-bin Tainted: G
       W       T   7.0.0-rc2+ #14 PREEMPT(lazy)
e3b9bc880e916193e5a1a669fc7b8172bdbeb62e
[   72.453583][  T144] Tainted: [W]=WARN, [T]=RANDSTRUCT
[   72.453596][  T144] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.15.0-1 04/01/2014
[   72.453642][  T144] Call Trace:
[   72.453673][  T144]  <TASK>
[   72.453696][  T144]  dump_stack_lvl+0x95/0x100
[   72.453735][  T144]  print_address_description.constprop.0+0x2c/0x3c0
[   72.453762][  T144]  ? efs_symlink_read_folio+0x1b8/0x440
[   72.453788][  T144]  print_report+0xb4/0x280
[   72.453809][  T144]  ? kasan_addr_to_slab+0x27/0x80
[   72.453824][  T144]  ? kasan_complete_mode_report_info+0xa3/0xc0
[   72.453842][  T144]  ? efs_symlink_read_folio+0x1b8/0x440
[   72.453855][  T144]  kasan_report+0xcf/0x140
[   72.453876][  T144]  ? efs_symlink_read_folio+0x1b8/0x440
[   72.453906][  T144]  kasan_check_range+0x3b/0x200
[   72.453923][  T144]  __asan_memcpy+0x24/0x80
[   72.453942][  T144]  efs_symlink_read_folio+0x1b8/0x440
[   72.453960][  T144]  ? __pfx_efs_symlink_read_folio+0x40/0x40
[   72.453976][  T144]  filemap_read_folio+0xba/0x280
[   72.453999][  T144]  ? __pfx_filemap_read_folio+0x40/0x40
[   72.454014][  T144]  ? __filemap_get_folio_mpol+0x55/0x800
[   72.454042][  T144]  do_read_cache_folio+0x1eb/0x500
[   72.454056][  T144]  ? __pfx_efs_symlink_read_folio+0x40/0x40
[   72.454081][  T144]  __page_get_link.isra.0+0x26/0x340
[   72.454103][  T144]  page_get_link+0x40/0x100
[   72.454121][  T144]  vfs_readlink+0x1de/0x400
[   72.454139][  T144]  ? __pfx_vfs_readlink+0x40/0x40
[   72.454159][  T144]  ? touch_atime+0x91/0x640
[   72.454182][  T144]  do_readlinkat+0x1c1/0x300
[   72.454203][  T144]  ? __pfx_do_readlinkat+0x40/0x40
[   72.454235][  T144]  __x64_sys_readlink+0x78/0xc0
[   72.454251][  T144]  do_syscall_64+0x141/0xf40
[   72.454308][  T144]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   72.454362][  T144] RIP: 0033:0x448d5b
[   72.454767][  T144] Code: 0c 00 00 00 ba 0c 00 00 00 e9 7e fd ff ff
64 c7 03 22 00 00 00 ba 22 00 00 00 e9 6d fd ff ff f3 0f 1e fa b8 59
00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8
64 89 01 48
[   72.454792][  T144] RSP: 002b:00007fff8fdb1568 EFLAGS: 00000246
ORIG_RAX: 0000000000000059
[   72.454834][  T144] RAX: ffffffffffffffda RBX: 00007fff8fdb2798
RCX: 0000000000448d5b
[   72.454847][  T144] RDX: 0000000000000fff RSI: 00007fff8fdb1570
RDI: 000000000049905e
[   72.454857][  T144] RBP: 0000000000499004 R08: 00000000004b05fd
R09: 0000000000000000
[   72.454867][  T144] R10: 0000000000000001 R11: 0000000000000246
R12: 000000000049913c
[   72.454877][  T144] R13: 0000000000499136 R14: 00000000004c37d0
R15: 0000000000000001
[   72.454941][  T144]  </TASK>
[   72.454985][  T144]
[   72.457889][  T144] The buggy address belongs to the physical page:
[   72.458294][  T144] page: refcount:3 mapcount:0
mapping:ff11000001430a18 index:0x0 pfn:0x18906
[   72.458491][  T144] memcg:ff11000001c90040
[   72.458780][  T144] aops:def_blk_aops ino:700000 dentry name(?):""
[   72.458971][  T144] flags:
0xfffffc6004204(referenced|workingset|private|node=0|zone=1|lastcpupid=0x1fffff)
[   72.459605][  T144] raw: 000fffffc6004204 0000000000000000
dead000000000122 ff11000001430a18
[   72.459730][  T144] raw: 0000000000000000 ff11000006a83948
00000003ffffffff ff11000001c90040
[   72.459901][  T144] page dumped because: kasan: bad access detected
[   72.460006][  T144]
[   72.460097][  T144] Memory state around the buggy address:
[   72.460355][  T144]  ff11000018906700: 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00
[   72.460507][  T144]  ff11000018906780: 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00
[   72.460631][  T144] >ff11000018906800: 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00
[   72.460747][  T144]                    ^
[   72.460930][  T144]  ff11000018906880: 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00
[   72.461032][  T144]  ff11000018906900: 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00
[   72.461174][  T144]
==================================================================
[   72.461592][  T144] Disabling lock debugging due to kernel taint
[   72.461796][  T144]
==================================================================
[   72.462033][  T144] BUG: KASAN: slab-out-of-bounds in
efs_symlink_read_folio+0x309/0x440
[   72.462162][  T144] Write of size 1 at addr ff11000005f60fff by
task poc-bin/144
[   72.462261][  T144]
[   72.462347][  T144] CPU: 0 UID: 0 PID: 144 Comm: poc-bin Tainted: G
   B   W       T   7.0.0-rc2+ #14 PREEMPT(lazy)
e3b9bc880e916193e5a1a669fc7b8172bdbeb62e
[   72.462391][  T144] Tainted: [B]=BAD_PAGE, [W]=WARN, [T]=RANDSTRUCT
[   72.462401][  T144] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.15.0-1 04/01/2014
[   72.462415][  T144] Call Trace:
[   72.462464][  T144]  <TASK>
[   72.462493][  T144]  dump_stack_lvl+0x95/0x100
[   72.462525][  T144]  print_address_description.constprop.0+0x2c/0x3c0
[   72.462553][  T144]  ? efs_symlink_read_folio+0x309/0x440
[   72.462571][  T144]  print_report+0xb4/0x280
[   72.462590][  T144]  ? kasan_addr_to_slab+0x27/0x80
[   72.462606][  T144]  ? kasan_complete_mode_report_info+0x32/0xc0
[   72.462623][  T144]  ? efs_symlink_read_folio+0x309/0x440

