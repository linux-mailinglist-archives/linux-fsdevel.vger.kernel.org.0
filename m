Return-Path: <linux-fsdevel+bounces-14382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 553FF87B972
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 09:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3189B2189D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 08:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453CE6BB50;
	Thu, 14 Mar 2024 08:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Q6SN+s3y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1918EEC4;
	Thu, 14 Mar 2024 08:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710405860; cv=none; b=CvhC17+5WJx53JZmyxKj3EPjcRhFGefCIMNS4weqgMaD3h1Yk6NQQN3DLwNP4V4CpgvO4emy2IoUTOBjmr2RXCAi+vzK2BPw9bVF5hXej4uICXS0s5hAU9zJNg0S+oWHgnL3tpnaodes9eIaqN1hRAFydq/kFGP450SCHjWrTrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710405860; c=relaxed/simple;
	bh=+BX7gnL09c5lxHYhdPdiCZcTTqc7o9DwYCU15DVX9kY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FyXCHn2rPay2Lv8CvTq917mCXFWKseKmbMtNjq1flkRUoysK+VIUIjLaq8+M0hxsRTxcrO21RC2sbHOTR960xrMgORxV21cB3CjZMzhmmulfb1tZcqvrWPd4uRue0+WGfNhzYZvgPVL2jafuO4Q7F+KwSsZCMnSLeRceCk8nHvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Q6SN+s3y; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710405857;
	bh=+BX7gnL09c5lxHYhdPdiCZcTTqc7o9DwYCU15DVX9kY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q6SN+s3y4Cu4ar2ldP89W3O7Lw7mEHkWAUdl6vWphpO0XissCZeODmz+8Ogsa6BAb
	 WRl+OqGyNI/Ug+SuR2XvowOAOS3rIDmgVlopvj+FQ96O62xOfBKhVT79dDQ6pgtzLR
	 NEAM/Q8cMDgd9XjxqRqGgitDSIug8Ryz7wWLcu/ciapk2Edx8C6ZCsCDut6lx5EIob
	 lCXsb7D5kbrrGXkFk1CNzfUUF522ujk7Bb75Q1LVPpYzo3pdgWHbIIhaHfEsyyzWjx
	 aZu1gsLeJGAR0EKDZORhJUfkIzWAamSDFFMBbS9TrDq0NjGfD1QOOio+kHu6f5JVuN
	 rrXOmYLpNBlhA==
Received: from [100.90.194.27] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7DD54378105A;
	Thu, 14 Mar 2024 08:44:12 +0000 (UTC)
Message-ID: <aaa4561e-fd23-4b21-8963-7ba4cc99eed3@collabora.com>
Date: Thu, 14 Mar 2024 10:44:09 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 2/9] f2fs: Simplify the handling of cached insensitive
 names
Content-Language: en-US
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
 jaegeuk@kernel.org, chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
 jack@suse.cz, Gabriel Krisman Bertazi <krisman@collabora.com>
References: <20240305101608.67943-1-eugen.hristev@collabora.com>
 <20240305101608.67943-3-eugen.hristev@collabora.com>
 <87edcdk8li.fsf@mailhost.krisman.be>
From: Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <87edcdk8li.fsf@mailhost.krisman.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/14/24 01:36, Gabriel Krisman Bertazi wrote:
> Eugen Hristev <eugen.hristev@collabora.com> writes:
> 
>> +void f2fs_free_casefolded_name(struct f2fs_filename *fname)
>> +{
>> +	unsigned char *buf = (unsigned char *)fname->cf_name.name;
>> +
>> +	kmem_cache_free(f2fs_cf_name_slab, buf);
>> +	fname->cf_name.name = NULL;
> 
> In my previous review, I mentioned you could drop the "if (buf)" check
> here *if and only if* you used kfree. By doing an unchecked kmem_cache_free
> like this, you will immediately hit an Oops in the first lookup (see below).
> 
> Please, make sure you actually stress test this patchset with fstests
> against both f2fs and ext4 before sending each new version.

I did run the xfstests, however, maybe I did not run the full suite, or maybe I am
running it in a wrong way ?
How are you running the kvm-xfstests with qemu ? Can you share your command
arguments please ?

Thanks

> 
> Thanks,
> 
> 
> [   74.202044] F2FS-fs (loop0): Using encoding defined by superblock: utf8-12.1.0 with flags 0x0
> [   74.206592] F2FS-fs (loop0): Found nat_bits in checkpoint
> [   74.221467] F2FS-fs (loop0): Mounted with checkpoint version = 3e684111
> FSTYP         -- f2fs
> PLATFORM      -- Linux/x86_64 sle15sp5 6.7.0-gf27274eae416 #8 SMP PREEMPT_DYNAMIC Thu Mar 14 00:22:47 CET 2024
> MKFS_OPTIONS  -- -O encrypt /dev/loop1
> MOUNT_OPTIONS -- -o acl,user_xattr /dev/loop1 /root/work/scratch
> 
> [   75.038385] F2FS-fs (loop1): Found nat_bits in checkpoint
> [   75.054311] F2FS-fs (loop1): Mounted with checkpoint version = 6b9fbccb
> [   75.176328] F2FS-fs (loop0): Using encoding defined by superblock: utf8-12.1.0 with flags 0x0
> [   75.179261] F2FS-fs (loop0): Found nat_bits in checkpoint
> [   75.194264] F2FS-fs (loop0): Mounted with checkpoint version = 3e684114
> f2fs/001 1s ... [   75.570867] run fstests f2fs/001 at 2024-03-14 00:24:33
> [   75.753604] BUG: unable to handle page fault for address: fffff14ad2000008
> [   75.754209] #PF: supervisor read access in kernel mode
> [   75.754647] #PF: error_code(0x0000) - not-present page
> [   75.755077] PGD 0 P4D 0 
> [   75.755300] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [   75.755683] CPU: 0 PID: 2740 Comm: xfs_io Not tainted 6.7.0-gf27274eae416 #8
> [   75.756266] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 2/2/2022
> [   75.756911] RIP: 0010:kmem_cache_free+0x6a/0x320
> [   75.757309] Code: 80 48 01 d8 0f 82 b4 02 00 00 48 c7 c2 00 00 00 80 48 2b 15 f8 c2 18 01 48 01 d0 48 c1 e8 0c 48 c1 e0 06 48 03 05 d6 c2 18 01 <48> 8b 50 08 49 89 c6 f6 c2 01 0f 85 ea 01 00 00 0f 1f 44 00 00 49
> [   75.758834] RSP: 0018:ffffa59bc231bb10 EFLAGS: 00010286
> [   75.759270] RAX: fffff14ad2000000 RBX: 0000000000000000 RCX: 0000000000000000
> [   75.759860] RDX: 0000620400000000 RSI: 0000000000000000 RDI: ffff9dfc80043600
> [   75.760450] RBP: ffffa59bc231bb30 R08: ffffa59bc231b9a0 R09: 00000000000003fa
> [   75.761037] R10: 00000000000fd024 R11: 0000000000000107 R12: ffff9dfc80043600
> [   75.761626] R13: ffffffff8404dc7a R14: 0000000000000000 R15: ffff9dfc8f1aa000
> [   75.762221] FS:  00007f9601efb780(0000) GS:ffff9dfcfbc00000(0000) knlGS:0000000000000000
> [   75.762888] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   75.763372] CR2: fffff14ad2000008 CR3: 0000000111750000 CR4: 0000000000750ef0
> [   75.763962] PKRU: 55555554
> [   75.764194] Call Trace:
> [   75.764435]  <TASK>
> [   75.764677]  ? __die_body+0x1a/0x60
> [   75.764982]  ? page_fault_oops+0x154/0x440
> [   75.765335]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   75.765760]  ? search_module_extables+0x46/0x70
> [   75.766149]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   75.766548]  ? fixup_exception+0x22/0x300
> [   75.766892]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   75.767292]  ? exc_page_fault+0xa6/0x140
> [   75.767633]  ? asm_exc_page_fault+0x22/0x30
> [   75.767995]  ? f2fs_free_filename+0x2a/0x40
> [   75.768362]  ? kmem_cache_free+0x6a/0x320
> [   75.768703]  ? f2fs_free_filename+0x2a/0x40
> [   75.769061]  f2fs_free_filename+0x2a/0x40
> [   75.769403]  f2fs_lookup+0x19f/0x380
> [   75.769712]  __lookup_slow+0x8b/0x130
> [   75.770034]  walk_component+0xfc/0x170
> [   75.770353]  path_lookupat+0x69/0x140
> [   75.770664]  filename_lookup+0xe1/0x1c0
> [   75.770991]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   75.771393]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   75.771792]  ? do_wp_page+0x3f6/0xbf0
> [   75.772109]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   75.772523]  ? preempt_count_add+0x70/0xa0
> [   75.772902]  ? vfs_statx+0x89/0x180
> [   75.773224]  vfs_statx+0x89/0x180
> [   75.773530]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   75.773939]  vfs_fstatat+0x80/0xa0
> [   75.774237]  __do_sys_newfstatat+0x26/0x60
> [   75.774595]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   75.775021]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   75.775448]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   75.775878]  ? do_user_addr_fault+0x563/0x7c0
> [   75.776273]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   75.776699]  do_syscall_64+0x50/0x110
> [   75.777028]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> [   75.777479] RIP: 0033:0x7f9601b07aea
> [   75.777793] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 41 89 ca b8 06 01 00 00 0f 05 <3d> 00 f0 ff ff 77 07 31 c0 c3 0f 1f 40 00 48 8b 15 01 23 0e 00 f7
> [   75.779391] RSP: 002b:00007ffc160eaae8 EFLAGS: 00000246 ORIG_RAX: 0000000000000106
> [   75.780050] RAX: ffffffffffffffda RBX: 0000000000000042 RCX: 00007f9601b07aea
> [   75.780663] RDX: 00007ffc160eab80 RSI: 00007ffc160ecb88 RDI: 00000000ffffff9c
> [   75.781278] RBP: 00007ffc160ead20 R08: 00007ffc160ead20 R09: 0000000000000000
> [   75.781902] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffc160eae70
> [   75.782532] R13: 00007ffc160ecb88 R14: 00007ffc160eae70 R15: 0000000000000020
> [   75.783150]  </TASK>
> [   75.783349] Modules linked in:
> [   75.783628] CR2: fffff14ad2000008
> [   75.783918] ---[ end trace 0000000000000000 ]---
> [   75.784315] RIP: 0010:kmem_cache_free+0x6a/0x320
> [   75.784718] Code: 80 48 01 d8 0f 82 b4 02 00 00 48 c7 c2 00 00 00 80 48 2b 15 f8 c2 18 01 48 01 d0 48 c1 e8 0c 48 c1 e0 06 48 03 05 d6 c2 18 01 <48> 8b 50 08 49 89 c6 f6 c2 01 0f 85 ea 01 00 00 0f 1f 44 00 00 49
> [   75.786294] RSP: 0018:ffffa59bc231bb10 EFLAGS: 00010286
> [   75.786747] RAX: fffff14ad2000000 RBX: 0000000000000000 RCX: 0000000000000000
> [   75.787369] RDX: 0000620400000000 RSI: 0000000000000000 RDI: ffff9dfc80043600
> [   75.788016] RBP: ffffa59bc231bb30 R08: ffffa59bc231b9a0 R09: 00000000000003fa
> [   75.788672] R10: 00000000000fd024 R11: 0000000000000107 R12: ffff9dfc80043600
> [   75.789296] R13: ffffffff8404dc7a R14: 0000000000000000 R15: ffff9dfc8f1aa000
> [   75.789938] FS:  00007f9601efb780(0000) GS:ffff9dfcfbc00000(0000) knlGS:0000000000000000
> [   75.790677] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   75.791212] CR2: fffff14ad2000008 CR3: 0000000111750000 CR4: 0000000000750ef0
> [   75.791862] PKRU: 55555554
> [   75.792112] Kernel panic - not syncing: Fatal exception
> [   75.792797] Kernel Offset: 0x2a00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> 
> 


