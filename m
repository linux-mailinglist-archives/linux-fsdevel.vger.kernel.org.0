Return-Path: <linux-fsdevel+bounces-71662-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C65FCCBCD6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 13:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57625302EF4D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 12:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A0732E6B0;
	Thu, 18 Dec 2025 12:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="NOxzU/SP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2827191
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 12:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766061334; cv=none; b=a0JCElLHo5kSRBa/gfa60eUJtcC2fI6FnXb7rLRlYY0mZjDpFaTO/TLUic0vl1bMkhNeQXbOEsJg/BC1Q79eSME3CykKo1DrqVbCTdrs6EJuDkkcAGK/t8hQDN+THU06VJxRwh/rJmZLj65wk46U4aVzHSMUPxT29lkD3KNdPOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766061334; c=relaxed/simple;
	bh=hmWK4FheZfb+xRDxVkR2evsKgs8D0Peli2PP3RVhcn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jxfbiTo44/FN0HAdbTG3Z1aEhx7Usv3BivRhZEum5TszWRj454qh2AC4ztIdGizMKN/fiiOfTrlsGjKzxZhIbcoilqsnWjfbfpEIRtsVjtNQfqVtq3xdFg7SYCMhzL0sMVJHmAYS0BueU+CwX+LbVGpinfBCrhNS8iv4a+7/CoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=NOxzU/SP; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ZFBxp5MOw97Nf+c/rxPJuAp2FIVJBTRNqQaC19WgyrI=;
	b=NOxzU/SPRCeHd3OXW/hFR+ax30IpXgORRB9qdnwUlMWg9JAjFm+GpoFeXnAEBwNjSaQ8GZJQN
	bgoCS5RyO4wLulOnkIYlVQD8BkTWfpgSqVPqjD3VYnl1eP+n9aNHA6lc4VBt36NORJtLX3AxAQX
	rao7VueXCmFWmePiuiUjnn0=
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4dX96W24wYzpSvn;
	Thu, 18 Dec 2025 20:32:35 +0800 (CST)
Received: from kwepemr500001.china.huawei.com (unknown [7.202.194.229])
	by mail.maildlp.com (Postfix) with ESMTPS id 6585D180BCD;
	Thu, 18 Dec 2025 20:35:21 +0800 (CST)
Received: from [10.174.179.179] (10.174.179.179) by
 kwepemr500001.china.huawei.com (7.202.194.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 18 Dec 2025 20:35:20 +0800
Message-ID: <51703066-abe5-4d85-8f6e-25bf0e4f470f@huawei.com>
Date: Thu, 18 Dec 2025 20:35:19 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] memory leak of xa_node in collapse_file() when
 rollbacks
To: "David Hildenbrand (Red Hat)" <david@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>,
	<ziy@nvidia.com>, <lorenzo.stoakes@oracle.com>,
	<baolin.wang@linux.alibaba.com>, <Liam.Howlett@oracle.com>,
	<npache@redhat.com>, <ryan.roberts@arm.com>, <dev.jain@arm.com>,
	<baohua@kernel.org>, <lance.yang@linux.dev>, <linux-mm@kvack.org>,
	<linux-fsdevel@vger.kernel.org>
CC: Kefeng Wang <wangkefeng.wang@huawei.com>
References: <86834731-02ba-43ea-9def-8b8ca156ec4a@huawei.com>
 <32e4658f-d23b-4bae-9053-acdd5277bb17@kernel.org>
From: Jinjiang Tu <tujinjiang@huawei.com>
In-Reply-To: <32e4658f-d23b-4bae-9053-acdd5277bb17@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemr500001.china.huawei.com (7.202.194.229)


在 2025/12/18 19:51, David Hildenbrand (Red Hat) 写道:
> On 12/18/25 12:45, Jinjiang Tu wrote:
>> I encountered a memory leak issue caused by xas_create_range().
>>
>> collapse_file() calls xas_create_range() to pre-create all slots needed.
>> If collapse_file() finally fails, these pre-created slots are empty 
>> nodes
>> and aren't destroyed.
>>
>> I can reproduce it with following steps.
>> 1) create file /tmp/test_madvise_collapse and ftruncate to 4MB size, 
>> and then mmap the file
>> 2) memset for the first 2MB
>> 3) madvise(MADV_COLLAPSE) for the second 2MB
>> 4) unlink the file
>>
>> in 3), collapse_file() calls xas_create_range() to expand xarray 
>> depth, and fails to collapse
>> due to the whole 2M region is empty, the code is as following:
>>
>> collapse_file()
>>     for (index = start; index < end;) {
>>         xas_set(&xas, index);
>>         folio = xas_load(&xas);
>>
>>         VM_BUG_ON(index != xas.xa_index);
>>         if (is_shmem) {
>>             if (!folio) {
>>                 /*
>>                  * Stop if extent has been truncated or
>>                  * hole-punched, and is now completely
>>                  * empty.
>>                  */
>>                 if (index == start) {
>>                     if (!xas_next_entry(&xas, end - 1)) {
>>                         result = SCAN_TRUNCATED;
>>                         goto xa_locked;
>>                     }
>>                 }
>>                 ...
>>             }
>>
>>
>> collapse_file() rollback path doesn't destroy the pre-created empty 
>> nodes.
>>
>> When the file is deleted, shmem_evict_inode()->shmem_truncate_range() 
>> traverses
>> all entries and calls xas_store(xas, NULL) to delete, if the leaf 
>> xa_node that
>> stores deleted entry becomes emtry, xas_store() will automatically 
>> delete the empty
>> node and delete it's  parent is empty too, until parent node isn't 
>> empty. shmem_evict_inode()
>> won't traverse the empty nodes created by xas_create_range() due to 
>> these nodes doesn't store
>> any entries. As a result, these empty nodes are leaked.
>>
>> At first, I tried to destory the empty nodes when collapse_file() 
>> goes to rollback path. However,
>> collapse_file() only holds xarray lock and may release the lock, so 
>> we couldn't prevent concurrent
>> call of collapse_file(), so the deleted empty nodes may be needed by 
>> other collapse_file() calls.
>>
>> IIUC, xas_create_range() is used to guarantee the xas_store(&xas, 
>> new_folio); succeeds. Could we
>> remove xas_create_range() call and just rollback when we fail to 
>> xas_store?
>
> Hi,
>
> thanks for the report.
>
> Is that what [1] is fixing?
>
> [1] 
> https://lore.kernel.org/linux-mm/20251204142625.1763372-1-shardul.b@mpiricsoftware.com/ 
>
>
the allocation stack of the leaked xa_node is as follows:

unreferenced object 0xffff0000d4d9fd98 (size 576):
   comm "test_filemap", pid 8220, jiffies 4294957272 (age 659.036s)
   hex dump (first 32 bytes):
     00 08 00 00 00 00 00 00 88 54 75 dc 00 00 ff ff  .........Tu.....
     a0 7d db d6 00 00 ff ff b0 fd d9 d4 00 00 ff ff  .}..............
   backtrace:
     kmemleak_alloc+0xb8/0xd8
     kmem_cache_alloc_lru+0x308/0x558
     xas_alloc+0xb4/0xd0
     xas_create+0xf4/0x1f8
     xas_create_range+0xd0/0x158
     collapse_file+0x13c/0x11e0
     hpage_collapse_scan_file+0x1e0/0x488
     madvise_collapse+0x174/0x650
     madvise_vma_behavior+0x334/0x520
     do_madvise+0x1bc/0x388
     __arm64_sys_madvise+0x2c/0x48
     invoke_syscall+0x50/0x128
     el0_svc_common.constprop.0+0xc8/0xf0
     do_el0_svc+0x24/0x38
     el0_svc+0x44/0x200
     el0t_64_sync_handler+0x100/0x130

it is allocated by xas_create_range(), not xas_nomem(). So it isn't the same issue.


