Return-Path: <linux-fsdevel+bounces-53050-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03753AE9495
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 05:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41AB57ABD76
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 03:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFADA1E501C;
	Thu, 26 Jun 2025 03:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GqoXvvKE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCA6282EB;
	Thu, 26 Jun 2025 03:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750908916; cv=none; b=FRNvvWBDL33kQPBoAYeJr/fXU/YzvYKLUslvd/wgRy+CIMiAZHsMa0XLjQUCmmaKXeezOJ1wRvX17kHF1LAuMYzZNb+etqR6p3vwpYSjDpHCZsF3FR3AQrJDCDi4856C9U6IEiFGFjvKefPdMV8/vN9NEh96BPwyDu++MSFKL88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750908916; c=relaxed/simple;
	bh=orbGFxw7oq8abSiPWHcCori/3Z1FkINWNXkk6JGT7+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQ8sQHf/aVQyhK/qvP6G5fAoErY9DzzZ+XjqG2g7C4bTXJ+GpBOsWqm7FRKX+YTNw0EwHR8Vk6pBOdH0g9hBs717ROFEU2wTUrI1XtLrcx/j2C/d7BLhfwNrwn4fSsxN/upDmruGGBxUwqpEBP5+tSg3F+qJstpPIjweqUPRYJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GqoXvvKE; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750908914; x=1782444914;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=orbGFxw7oq8abSiPWHcCori/3Z1FkINWNXkk6JGT7+g=;
  b=GqoXvvKEAFJLvcnXFi9a7XWsZRLkMSuNynKXQSgl9fBGtF1nK209r6Db
   t/9Dsp2ciArrKgTwefz0QVdojt8HOmDDYgFRJNnaBaen2p7fHuNKkOkbS
   OWdy9GAsFz2TYcrtqcqockEzLDqCX7LfIlKCeLq+9wzwb270FvxxxxXGy
   N7Dxoo53dWTVZIcJB7AtWut0S0RhrtwEUEnHqBHClIV2EwbhVJ2BNLd6H
   N8Lu2DIXeAi4l2RU+D5TtPIF2FAmHuvIpAANSt/wRwBy6NQEq3mwrb1P7
   AHkAAiB8E3Z0T8Q5zNciBwRXixnuPr/zOVshyqw8zZKBnjauF18seZeW1
   A==;
X-CSE-ConnectionGUID: +bU+jm0jSPiHa/i2updwwg==
X-CSE-MsgGUID: lkjOwVzMQiuxrELCMo+57A==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="64552003"
X-IronPort-AV: E=Sophos;i="6.16,266,1744095600"; 
   d="scan'208";a="64552003"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 20:35:13 -0700
X-CSE-ConnectionGUID: fRVmk8plS/CJiD3EwmUiWA==
X-CSE-MsgGUID: 2ExLHqArQ0u7FplQ7xiMcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,266,1744095600"; 
   d="scan'208";a="156787664"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.35.3])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 20:35:10 -0700
Date: Thu, 26 Jun 2025 11:35:06 +0800
From: "Lai, Yi" <yi1.lai@linux.intel.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	willy@infradead.org, adilger.kernel@dilger.ca, jack@suse.cz,
	yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com,
	yangerkun@huawei.com, yi1.lai@intel.com
Subject: Re: [PATCH v2 8/8] ext4: enable large folio for regular file
Message-ID: <aFy/6oD/AZeTjwAs@ly-workstation>
References: <20250512063319.3539411-1-yi.zhang@huaweicloud.com>
 <20250512063319.3539411-9-yi.zhang@huaweicloud.com>
 <aFuv+bNk4LyqaSNU@ly-workstation>
 <20250625131545.GD28249@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625131545.GD28249@mit.edu>

On Wed, Jun 25, 2025 at 09:15:45AM -0400, Theodore Ts'o wrote:
> It looks like this failure requires using madvise() with MADV_HWPOISON
> (which requires root) and MADV_PAGEOUT, and the stack trace is in deep
> in the an mm codepath:
> 
>    madvise_cold_or_pageout_pte_range+0x1cac/0x2800
>       reclaim_pages+0x393/0x560
>          reclaim_folio_list+0xe2/0x4c0
>             shrink_folio_list+0x44f/0x3d90
>                 unmap_poisoned_folio+0x130/0x500
>                     try_to_unmap+0x12f/0x140
>                        rmap_walk+0x16b/0x1f0
> 		       ...
> 
> The bisected commit is the one which enables using large folios, so
> while it's possible that this due to ext4 doing something not quite
> right when using large folios, it's also posible that this might be a
> bug in the folio/mm code paths.
> 
> Does this reproduce on other file systems, such as XFS?
>

Indeed, this issue can also be reproduced on XFS file system. Thanks for the advice. I will conduct cross-filesystem validation next time when I encounter ext4 issue.

[  395.888267] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASI
[  395.888767] KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
[  395.889150] CPU: 2 UID: 0 PID: 7420 Comm: repro Not tainted 6.16.0-rc3-86731a2a651e #1 PREEMPT(voluntary)
[  395.889620] Hardware name: Red Hat KVM/RHEL, BIOS edk2-20241117-3.el9 11/17/2024
[  395.889967] RIP: 0010:try_to_unmap_one+0x4ef/0x3860
[  395.890230] Code: f5 a5 ff 48 8b 9d 78 ff ff ff 49 8d 46 18 48 89 85 70 fe ff ff 48 85 db 0f 84 96 1a 00 00 e8 c8 f58
[  395.891081] RSP: 0018:ff1100011869ebc0 EFLAGS: 00010246
[  395.891337] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff81e1a1a1
[  395.891676] RDX: ff11000130330000 RSI: ffffffff81e186c8 RDI: 0000000000000005
[  395.892018] RBP: ff1100011869ed90 R08: 0000000000000001 R09: ffe21c00230d3d3b
[  395.892356] R10: 0000000000000000 R11: ff11000130330e58 R12: 0000000020e00000
[  395.892691] R13: ffd40000043c8000 R14: ffd40000043c8000 R15: dffffc0000000000
[  395.893043] FS:  00007fbd34523740(0000) GS:ff110004a4e62000(0000) knlGS:0000000000000000
[  395.893437] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  395.893718] CR2: 0000000021000000 CR3: 000000010f8bf004 CR4: 0000000000771ef0
[  395.894060] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  395.894398] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[  395.894732] PKRU: 55555554
[  395.894868] Call Trace:
[  395.894991]  <TASK>
[  395.895109]  ? __pfx_try_to_unmap_one+0x10/0x10
[  395.895337]  __rmap_walk_file+0x2a5/0x4a0
[  395.895538]  rmap_walk+0x16b/0x1f0
[  395.895706]  try_to_unmap+0x12f/0x140
[  395.895853]  ? __pfx_try_to_unmap+0x10/0x10
[  395.896061]  ? __pfx_try_to_unmap_one+0x10/0x10
[  395.896284]  ? __pfx_folio_not_mapped+0x10/0x10
[  395.896504]  ? __pfx_folio_lock_anon_vma_read+0x10/0x10
[  395.896758]  ? __sanitizer_cov_trace_const_cmp8+0x1c/0x30
[  395.897025]  unmap_poisoned_folio+0x130/0x500
[  395.897251]  shrink_folio_list+0x44f/0x3d90
[  395.897476]  ? __pfx_shrink_folio_list+0x10/0x10
[  395.897719]  ? is_bpf_text_address+0x94/0x1b0
[  395.897941]  ? debug_smp_processor_id+0x20/0x30
[  395.898172]  ? is_bpf_text_address+0x9e/0x1b0
[  395.898387]  ? kernel_text_address+0xd3/0xe0
[  395.898604]  ? __kernel_text_address+0x16/0x50
[  395.898827]  ? unwind_get_return_address+0x65/0xb0
[  395.899066]  ? __pfx_stack_trace_consume_entry+0x10/0x10
[  395.899326]  ? arch_stack_walk+0xa1/0xf0
[  395.899530]  reclaim_folio_list+0xe2/0x4c0
[  395.899733]  ? check_path.constprop.0+0x28/0x50
[  395.899963]  ? __pfx_reclaim_folio_list+0x10/0x10
[  395.900198]  ? folio_isolate_lru+0x38c/0x590
[  395.900412]  reclaim_pages+0x393/0x560
[  395.900606]  ? __pfx_reclaim_pages+0x10/0x10
[  395.900824]  ? do_raw_spin_unlock+0x15c/0x210
[  395.901044]  madvise_cold_or_pageout_pte_range+0x1cac/0x2800
[  395.901326]  ? __pfx_madvise_cold_or_pageout_pte_range+0x10/0x10
[  395.901631]  ? lock_is_held_type+0xef/0x150
[  395.901852]  ? __pfx_madvise_cold_or_pageout_pte_range+0x10/0x10
[  395.902158]  walk_pgd_range+0xe2d/0x2420
[  395.902373]  ? __pfx_walk_pgd_range+0x10/0x10
[  395.902593]  __walk_page_range+0x177/0x810
[  395.902799]  ? find_vma+0xc4/0x140
[  395.902977]  ? __pfx_find_vma+0x10/0x10
[  395.903176]  ? __this_cpu_preempt_check+0x21/0x30
[  395.903401]  ? __sanitizer_cov_trace_const_cmp8+0x1c/0x30
[  395.903667]  walk_page_range_mm+0x39f/0x770
[  395.903877]  ? __pfx_walk_page_range_mm+0x10/0x10
[  395.904109]  ? __this_cpu_preempt_check+0x21/0x30
[  395.904340]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[  395.904606]  ? mlock_drain_local+0x27f/0x4b0
[  395.904826]  walk_page_range+0x70/0xa0
[  395.905013]  ? __kasan_check_write+0x18/0x20
[  395.905227]  madvise_do_behavior+0x13e3/0x35f0
[  395.905453]  ? copy_vma_and_data+0x353/0x7d0
[  395.905674]  ? __pfx_madvise_do_behavior+0x10/0x10
[  395.905922]  ? __pfx_arch_get_unmapped_area_topdown+0x10/0x10
[  395.906219]  ? __this_cpu_preempt_check+0x21/0x30
[  395.906455]  ? lock_is_held_type+0xef/0x150
[  395.906665]  ? __lock_acquire+0x412/0x22a0
[  395.906875]  ? __this_cpu_preempt_check+0x21/0x30
[  395.907105]  ? lock_acquire+0x180/0x310
[  395.907306]  ? __pfx_down_read+0x10/0x10
[  395.907503]  ? __lock_acquire+0x412/0x22a0
[  395.907707]  ? __pfx___do_sys_mremap+0x10/0x10
[  395.907929]  ? __sanitizer_cov_trace_switch+0x58/0xa0
[  395.908186]  do_madvise+0x193/0x2b0
[  395.908363]  ? do_madvise+0x193/0x2b0
[  395.908550]  ? __pfx_do_madvise+0x10/0x10
[  395.908801]  ? __this_cpu_preempt_check+0x21/0x30
[  395.909036]  ? seqcount_lockdep_reader_access.constprop.0+0xb4/0xd0
[  395.909335]  ? lockdep_hardirqs_on+0x89/0x110
[  395.909556]  ? trace_hardirqs_on+0x51/0x60
[  395.909763]  ? seqcount_lockdep_reader_access.constprop.0+0xc0/0xd0
[  395.910073]  ? __sanitizer_cov_trace_cmp4+0x1a/0x20
[  395.910332]  ? ktime_get_coarse_real_ts64+0xad/0xf0
[  395.910578]  ? __audit_syscall_entry+0x39c/0x500
[  395.910812]  __x64_sys_madvise+0xb2/0x120
[  395.911016]  ? syscall_trace_enter+0x14d/0x280
[  395.911240]  x64_sys_call+0x19ac/0x2150
[  395.911431]  do_syscall_64+0x6d/0x2e0
[  395.911619]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  395.911865] RIP: 0033:0x7fbd3430756d
[  395.912046] Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d8
[  395.912905] RSP: 002b:00007ffe6486ec48 EFLAGS: 00000217 ORIG_RAX: 000000000000001c
[  395.913267] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fbd3430756d
[  395.913603] RDX: 0000000000000015 RSI: 0000000000c00000 RDI: 0000000020400000
[  395.913941] RBP: 00007ffe6486ec60 R08: 00007ffe6486ec60 R09: 00007ffe6486ec60
[  395.914280] R10: 0000000020fc6000 R11: 0000000000000217 R12: 00007ffe6486edb8
[  395.914629] R13: 00000000004018e5 R14: 0000000000403e08 R15: 00007fbd3456a000
[  395.914989]  </TASK>
[  395.915111] Modules linked in:
[  395.915296] ---[ end trace 0000000000000000 ]---

FYI, there is ongoing discussion in terms of folio/mm domain - https://lore.kernel.org/all/20250611074643.250837-1-tujinjiang@huawei.com/T/

Regards,
Yi Lai

 
>      	  	       	     	  	   	- Ted

