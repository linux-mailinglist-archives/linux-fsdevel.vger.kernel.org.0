Return-Path: <linux-fsdevel+bounces-25050-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A73A29485CF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 01:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A23728363F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 23:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBA116DEB6;
	Mon,  5 Aug 2024 23:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VfAacJqV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C4414A0AD;
	Mon,  5 Aug 2024 23:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722899900; cv=none; b=Sg/SICTWGLokws3RbWsjz2IAjZXnf7qNDceUJKzEw6XZNsm0kN5jP2yicwVp2lHAdEHXrXnxTzV611Bb1BVFHpqB0bSSKDRUlviR5X4Xa/4YSphj+P8PRNm7cvEznL5hAnmevpiCq9avVwmNbTyHwHUG1Tx66Z4Ap+P2mAt/oHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722899900; c=relaxed/simple;
	bh=IFGzE21ZyH//2gmVx0dwM7TDd8v+Q6ceMcKC81kje1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Csw6BnNPwUo7LQS6Ghwj3jFVjsG6JsOePNC25YPnR/jS2sD41B5Af353L9miU8BJ7gX8MhZAwob1KRyesQ3jYATUq51SUQr3tMK1kQ0HEpt9MrtkGfYhkk0n4nO3AXQCx5R/qdqIuaNCi4dGSFpfPE4KHQVM2qOxVyc5mV7QD50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VfAacJqV; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722899899; x=1754435899;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=IFGzE21ZyH//2gmVx0dwM7TDd8v+Q6ceMcKC81kje1w=;
  b=VfAacJqV0P+jRc15J3OlnicbHZWYJbmAAFqWIj6OAz4ZEM2v/vqHC9XI
   SZKWQ4WlbZP3ZU00a/WN1npttz++UUxKJxX9LRekeMvQr7A1ES7OkTc0T
   1L7VMkDPMLizwYf5zG+vfrFU/hHkBPglY4lH9DOZXlsJI6msDshBfsSL9
   X9JUKOY6uZUSHHTOjLcl0raVCb7HdjK6F7v2h7/nNJC014vVtS1cm3Vfk
   9SNgEpGvarxY3vWJBtWhtiKpEX2j4NfIkPi97/Mcd2119fBhYXwXu7lOp
   9WFGJ6wNfW1IDgafrBxDDC6gCJsTbMbRiuSmXClwqZJg3KPHuQQUQuNBS
   A==;
X-CSE-ConnectionGUID: BhfE/Z2TQeG7XgGRJgq6dQ==
X-CSE-MsgGUID: NovqGFpESdOP9cKwJKpVOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="21011998"
X-IronPort-AV: E=Sophos;i="6.09,266,1716274800"; 
   d="scan'208";a="21011998"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 16:18:18 -0700
X-CSE-ConnectionGUID: TpBiu6NtSne5XrkUYvFpxg==
X-CSE-MsgGUID: PkPWffSyRRu33VPD7UPchw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,266,1716274800"; 
   d="scan'208";a="56241077"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.75.106])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 16:18:15 -0700
Date: Mon, 5 Aug 2024 16:18:13 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Sourav Panda <souravpanda@google.com>, corbet@lwn.net,
	gregkh@linuxfoundation.org, rafael@kernel.org,
	akpm@linux-foundation.org, mike.kravetz@oracle.com,
	muchun.song@linux.dev, rppt@kernel.org, david@redhat.com,
	rdunlap@infradead.org, chenlinxuan@uniontech.com,
	yang.yang29@zte.com.cn, tomas.mudrunka@gmail.com,
	bhelgaas@google.com, ivan@cloudflare.com, yosryahmed@google.com,
	hannes@cmpxchg.org, shakeelb@google.com,
	kirill.shutemov@linux.intel.com, wangkefeng.wang@huawei.com,
	adobriyan@gmail.com, vbabka@suse.cz, Liam.Howlett@oracle.com,
	surenb@google.com, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, willy@infradead.org, weixugc@google.com,
	David Rientjes <rientjes@google.com>, nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org, yi.zhang@redhat.com
Subject: Re: [PATCH v13] mm: report per-page metadata information
Message-ID: <ZrFdtYCgmj/7xnP3@aschofie-mobl2>
References: <20240605222751.1406125-1-souravpanda@google.com>
 <Zq0tPd2h6alFz8XF@aschofie-mobl2>
 <CA+CK2bAfgamzFos1M-6AtozEDwRPJzARJOmccfZ=uzKyJ7w=kQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bAfgamzFos1M-6AtozEDwRPJzARJOmccfZ=uzKyJ7w=kQ@mail.gmail.com>

On Mon, Aug 05, 2024 at 02:40:48PM -0400, Pasha Tatashin wrote:
> On Fri, Aug 2, 2024 at 3:02 PM Alison Schofield
> <alison.schofield@intel.com> wrote:
> >
> > ++ nvdimm, linux-cxl, Yu Zhang
> >
> > On Wed, Jun 05, 2024 at 10:27:51PM +0000, Sourav Panda wrote:
> > > Today, we do not have any observability of per-page metadata
> > > and how much it takes away from the machine capacity. Thus,
> > > we want to describe the amount of memory that is going towards
> > > per-page metadata, which can vary depending on build
> > > configuration, machine architecture, and system use.
> > >
> > > This patch adds 2 fields to /proc/vmstat that can used as shown
> > > below:
> > >
> > > Accounting per-page metadata allocated by boot-allocator:
> > >       /proc/vmstat:nr_memmap_boot * PAGE_SIZE
> > >
> > > Accounting per-page metadata allocated by buddy-allocator:
> > >       /proc/vmstat:nr_memmap * PAGE_SIZE
> > >
> > > Accounting total Perpage metadata allocated on the machine:
> > >       (/proc/vmstat:nr_memmap_boot +
> > >        /proc/vmstat:nr_memmap) * PAGE_SIZE
> > >
> > > Utility for userspace:
> > >
> > > Observability: Describe the amount of memory overhead that is
> > > going to per-page metadata on the system at any given time since
> > > this overhead is not currently observable.
> > >
> > > Debugging: Tracking the changes or absolute value in struct pages
> > > can help detect anomalies as they can be correlated with other
> > > metrics in the machine (e.g., memtotal, number of huge pages,
> > > etc).
> > >
> > > page_ext overheads: Some kernel features such as page_owner
> > > page_table_check that use page_ext can be optionally enabled via
> > > kernel parameters. Having the total per-page metadata information
> > > helps users precisely measure impact. Furthermore, page-metadata
> > > metrics will reflect the amount of struct pages reliquished
> > > (or overhead reduced) when hugetlbfs pages are reserved which
> > > will vary depending on whether hugetlb vmemmap optimization is
> > > enabled or not.
> > >
> > > For background and results see:
> > > lore.kernel.org/all/20240220214558.3377482-1-souravpanda@google.com
> > >
> > > Acked-by: David Rientjes <rientjes@google.com>
> > > Signed-off-by: Sourav Panda <souravpanda@google.com>
> > > Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> >
> > This patch is leading to Oops in 6.11-rc1 when CONFIG_MEMORY_HOTPLUG
> > is enabled. Folks hitting it have had success with reverting this patch.
> > Disabling CONFIG_MEMORY_HOTPLUG is not a long term solution.
> >
> > Reported here:
> > https://lore.kernel.org/linux-cxl/CAHj4cs9Ax1=CoJkgBGP_+sNu6-6=6v=_L-ZBZY0bVLD3wUWZQg@mail.gmail.com/
> 
> Thank you for the heads up. Can you please attach a full config file,
> also was anyone able to reproduce this problem in qemu with emulated
> nvdimm?
> 
> Pasha

Hi Pasha,

This hits every time when boot with a CXL enabled kernel and the cxl-test
module loaded.  After boot, modprobe -r cxl-test emits the TRACE appended
below. Seems to be the same failing signature as in ndctl case above.

Applying the diff below works for the cxl-test unload failure. It moves the
state update to before freeing the page. I saw a note in the patch review
history about this:
	"v8:  Declined changing  placement of metrics after attempting"

Hope it's as simple as this :)


diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 829112b0a914..39c9050f8780 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -188,8 +188,8 @@ static inline void free_vmemmap_page(struct page *page)
                free_bootmem_page(page);
                mod_node_page_state(page_pgdat(page), NR_MEMMAP_BOOT, -1);
        } else {
-               __free_page(page);
                mod_node_page_state(page_pgdat(page), NR_MEMMAP, -1);
+               __free_page(page);
        }
 }

Failure trace
[   94.158105] BUG: unable to handle page fault for address: 0000000000004200
[   94.159953] #PF: supervisor read access in kernel mode
[   94.161132] #PF: error_code(0x0000) - not-present page
[   94.162300] PGD 0 P4D 0 
[   94.162915] Oops: Oops: 0000 [#1] PREEMPT SMP PTI
[   94.164006] CPU: 0 UID: 0 PID: 1076 Comm: modprobe Tainted: G           O     N 6.11.0-rc1 #197
[   94.165966] Tainted: [O]=OOT_MODULE, [N]=TEST
[   94.166973] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
[   94.168768] RIP: 0010:mod_node_page_state+0x6/0x90
[   94.169877] Code: 82 e9 ec fd ff ff 31 c9 e9 de fd ff ff 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 55 41 89 f2 89 d0 <4c> 8b 8f 00 42 00 00 83 ee 05 c1 f8 0c 83 fe 02 4f 8d 44 11 01 0f
[   94.172849] RSP: 0018:ffffc90002a4b760 EFLAGS: 00010287
[   94.173645] RAX: 00000000fffffe00 RBX: ffffea03c0800000 RCX: 0000000000000000
[   94.174762] RDX: fffffffffffffe00 RSI: 000000000000002d RDI: 0000000000000000
[   94.175862] RBP: ffffc90002a4b7b0 R08: 0000000000000000 R09: 0000000000000000
[   94.176973] R10: 000000000000002d R11: 0000000000080000 R12: ffff888012688040
[   94.178078] R13: 0000000000200000 R14: ffffea03c0a00000 R15: ffff88812df6ce40
[   94.179200] FS:  00007f9d9ea91740(0000) GS:ffff888077200000(0000) knlGS:0000000000000000
[   94.180257] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   94.180888] CR2: 0000000000004200 CR3: 0000000129886000 CR4: 00000000000006f0
[   94.181687] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   94.182487] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   94.183278] Call Trace:
[   94.183572]  <TASK>
[   94.183825]  ? show_regs+0x5f/0x70
[   94.184217]  ? __die+0x1f/0x70
[   94.184556]  ? page_fault_oops+0x14b/0x450
[   94.185017]  ? mod_node_page_state+0x6/0x90
[   94.185479]  ? search_exception_tables+0x5b/0x60
[   94.185997]  ? fixup_exception+0x22/0x300
[   94.186449]  ? kernelmode_fixup_or_oops.constprop.0+0x5a/0x70
[   94.187088]  ? __bad_area_nosemaphore+0x166/0x230
[   94.187601]  ? up_read+0x1d/0x30
[   94.187973]  ? bad_area_nosemaphore+0x11/0x20
[   94.188452]  ? do_user_addr_fault+0x2cb/0x6b0
[   94.188940]  ? __pfx_do_flush_tlb_all+0x10/0x10
[   94.189445]  ? exc_page_fault+0x6e/0x220
[   94.189857]  ? asm_exc_page_fault+0x27/0x30
[   94.190212]  ? mod_node_page_state+0x6/0x90
[   94.190566]  ? section_deactivate+0x242/0x290
[   94.190946]  sparse_remove_section+0x4d/0x70
[   94.191312]  __remove_pages+0x59/0x90
[   94.191623]  arch_remove_memory+0x1a/0x50
[   94.192224]  try_remove_memory+0xe9/0x150
[   94.192858]  remove_memory+0x1d/0x30
[   94.193457]  dev_dax_kmem_remove+0x9d/0x140 [kmem]
[   94.194140]  dax_bus_remove+0x1d/0x30
[   94.194723]  device_remove+0x3e/0x70
[   94.195283]  device_release_driver_internal+0x1ae/0x220
[   94.195980]  device_release_driver+0xd/0x20
[   94.196590]  bus_remove_device+0xd7/0x140
[   94.197189]  device_del+0x15b/0x3a0
[   94.197746]  unregister_dev_dax+0x6c/0xd0
[   94.198335]  devm_action_release+0x10/0x20
[   94.198945]  devres_release_all+0xa8/0xe0
[   94.199536]  device_unbind_cleanup+0xd/0x70
[   94.200138]  device_release_driver_internal+0x1d3/0x220
[   94.200809]  device_release_driver+0xd/0x20
[   94.201396]  bus_remove_device+0xd7/0x140
[   94.201977]  device_del+0x15b/0x3a0
[   94.202484]  device_unregister+0x12/0x60
[   94.203044]  cxlr_dax_unregister+0x9/0x10 [cxl_core]
[   94.203712]  devm_action_release+0x10/0x20
[   94.204249]  devres_release_all+0xa8/0xe0
[   94.204780]  device_unbind_cleanup+0xd/0x70
[   94.205327]  device_release_driver_internal+0x1d3/0x220
[   94.205960]  device_release_driver+0xd/0x20
[   94.206485]  bus_remove_device+0xd7/0x140
[   94.207011]  device_del+0x15b/0x3a0
[   94.207486]  unregister_region+0x2b/0x80 [cxl_core]
[   94.208092]  devm_action_release+0x10/0x20
[   94.208624]  devres_release_all+0xa8/0xe0
[   94.209130]  device_unbind_cleanup+0xd/0x70
[   94.209666]  device_release_driver_internal+0x1d3/0x220
[   94.210274]  device_release_driver+0xd/0x20
[   94.210812]  bus_remove_device+0xd7/0x140
[   94.211326]  device_del+0x15b/0x3a0
[   94.211807]  ? __this_cpu_preempt_check+0x13/0x20
[   94.212384]  ? lock_release+0x133/0x290
[   94.212896]  ? __x64_sys_delete_module+0x171/0x260
[   94.213474]  platform_device_del.part.0+0x13/0x80
[   94.214046]  platform_device_unregister+0x1b/0x40
[   94.214602]  cxl_test_exit+0x1a/0xcb0 [cxl_test]
[   94.215164]  __x64_sys_delete_module+0x182/0x260
[   94.215720]  ? __fput+0x1b5/0x2e0
[   94.216176]  ? debug_smp_processor_id+0x17/0x20
[   94.216735]  x64_sys_call+0xcc/0x1f30
[   94.217206]  do_syscall_64+0x47/0x110
[   94.217691]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   94.218265] RIP: 0033:0x7f9d9e3128cb
[   94.218745] Code: 73 01 c3 48 8b 0d 55 55 0e 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 25 55 0e 00 f7 d8 64 89 01 48
[   94.220590] RSP: 002b:00007ffd8ca73a88 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
[   94.221403] RAX: ffffffffffffffda RBX: 0000564e9737f9f0 RCX: 00007f9d9e3128cb
[   94.222176] RDX: 0000000000000000 RSI: 0000000000000800 RDI: 0000564e9737fa58
[   94.222960] RBP: 0000564e9737fa58 R08: 1999999999999999 R09: 0000000000000000
[   94.223772] R10: 00007f9d9e39dac0 R11: 0000000000000206 R12: 0000000000000001
[   94.224538] R13: 0000000000000000 R14: 00007ffd8ca75dc8 R15: 0000564e9737f480
[   94.225314]  </TASK>
[   94.225721] Modules linked in: kmem device_dax dax_cxl cxl_pci cxl_mock_mem(ON) cxl_test(ON-) cxl_mem(ON) cxl_pmem(ON) cxl_port(ON) cxl_acpi(ON) cxl_mock(ON) cxl_core(ON) libnvdimm
[   94.227422] CR2: 0000000000004200
[   94.227977] ---[ end trace 0000000000000000 ]---
[   94.228585] RIP: 0010:mod_node_page_state+0x6/0x90
[   94.229523] Code: 82 e9 ec fd ff ff 31 c9 e9 de fd ff ff 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 55 41 89 f2 89 d0 <4c> 8b 8f 00 42 00 00 83 ee 05 c1 f8 0c 83 fe 02 4f 8d 44 11 01 0f
[   94.232041] RSP: 0018:ffffc90002a4b760 EFLAGS: 00010287
[   94.232891] RAX: 00000000fffffe00 RBX: ffffea03c0800000 RCX: 0000000000000000
[   94.233921] RDX: fffffffffffffe00 RSI: 000000000000002d RDI: 0000000000000000
[   94.234898] RBP: ffffc90002a4b7b0 R08: 0000000000000000 R09: 0000000000000000
[   94.235908] R10: 000000000000002d R11: 0000000000080000 R12: ffff888012688040
[   94.237077] R13: 0000000000200000 R14: ffffea03c0a00000 R15: ffff88812df6ce40
[   94.237922] FS:  00007f9d9ea91740(0000) GS:ffff888077200000(0000) knlGS:0000000000000000
[   94.238844] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   94.239584] CR2: 0000000000004200 CR3: 0000000129886000 CR4: 00000000000006f0
[   94.240566] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   94.241787] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400





