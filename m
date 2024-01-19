Return-Path: <linux-fsdevel+bounces-8282-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1659183232B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 02:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAB31281F83
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 01:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F068138F;
	Fri, 19 Jan 2024 01:52:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C2B1362
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jan 2024 01:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705629150; cv=none; b=OZ0tQ1z8ddXWzaL+2oNjIC3JdH8JNx9FqWmH53Jx00NvNOWAIvqYeC/5ETrk9dhP1YDKDY5mq//VAYgsKSIhXHi+jXZZtz+GD36HvYkY7n6Ao/US7cLb3hK6CxXmpqsJSGItZCB7uQIVDX1VD+KYbtlB/CjkpcpU39UdwRYiEHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705629150; c=relaxed/simple;
	bh=KKAckyFHILR6vGPJE8IIJu6rlRnjNzDvOA7mk1PirOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XaImE8oM3xdBAjm3k553oYAJNDO+DfgVr6wXY2R/XfBKaTomccbdwJ8Jtt/sPrYdNdbrFv7EoKwB18vxr32vSbc1JJF20oi6PMzmw1soSaiN4Vz0ZX2gdg5owwDv8UWyttDFi/AR1mHSa/12G5J8kXynGWMyk3jS0BjR4rKpwKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; arc=none smtp.client-ip=139.138.61.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="125367652"
X-IronPort-AV: E=Sophos;i="6.05,203,1701097200"; 
   d="scan'208";a="125367652"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 10:52:19 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 274CDD64B3
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jan 2024 10:52:17 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 16337D8B77
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jan 2024 10:52:16 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 9AA1F20081308
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jan 2024 10:52:15 +0900 (JST)
Received: from [10.193.128.195] (unknown [10.193.128.195])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id B5F391A0072;
	Fri, 19 Jan 2024 09:52:14 +0800 (CST)
Message-ID: <777a7472-4eb1-4152-a648-2da5bfd39d16@fujitsu.com>
Date: Fri, 19 Jan 2024 09:52:14 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fsdax: cleanup tracepoints
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
 dan.j.williams@intel.com, willy@infradead.org, ira.weiny@intel.com
References: <20240104104925.3496797-1-ruansy.fnst@fujitsu.com>
 <20240104122647.ynowpqfmhrvftfss@quack3>
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <20240104122647.ynowpqfmhrvftfss@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28128.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28128.003
X-TMASE-Result: 10--8.087500-10.000000
X-TMASE-MatchedRID: mZljRXDwq+6PvrMjLFD6eHchRkqzj/bEC/ExpXrHizwlr4zMriiW6Qc1
	kKhUHbFIo8Py93uwvr+bvdUVlY5ZkOkXbVjiLTkdvTzgeOt8UBJpeZ1cXZibx7cIt210bWgI6Ch
	K9oqyX+Qi+t+0AiFaYvL3NxFKQpq19IaoJGJ/0IvTCZHfjFFBz0fLPdsHmQbnqU5CNByvM6UHzY
	bIalkde90atarVue7jCXCP8eg7wMI1jBhMSgBKwZ4CIKY/Hg3AWQy9YC5qGvwCwwGD+AF1Ue52O
	dZcC6tPJ0RPnyOnrZJR+Gx7dNGeLJ8u0LcbU3GBLhx6qKRbj2b5pTj8Mu3F7bz4GVkvLBAaJkGI
	ggAHozDJWwCFatBBoymZPCsmJrgD+EqL+Loa93tlJCOsB4awXOVV62x4Nv+CWHt/4pqKiNrUEwC
	0VA4Efc/9za0y1DHl
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0


在 2024/1/4 20:26, Jan Kara 写道:
> On Thu 04-01-24 18:49:25, Shiyang Ruan wrote:
>> Restore the tracepoint that was accidentally deleted before, and rename
>> to dax_insert_entry().  Also, since we are using XArray, rename
>> 'radix_entry' to 'xa_entry'.
>>
>> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> 
> Looks good. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Thank you~


To nvdimm list:
Could this be merged?  Or any other comment?


--
Thanks
Ruan.

> 
> 								Honza
> 
>> ---
>>   fs/dax.c                      |  2 ++
>>   include/trace/events/fs_dax.h | 47 +++++++++++++++++------------------
>>   2 files changed, 25 insertions(+), 24 deletions(-)
>>
>> diff --git a/fs/dax.c b/fs/dax.c
>> index 3380b43cb6bb..7e7aabec91d8 100644
>> --- a/fs/dax.c
>> +++ b/fs/dax.c
>> @@ -1684,6 +1684,8 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
>>   	if (dax_fault_is_synchronous(iter, vmf->vma))
>>   		return dax_fault_synchronous_pfnp(pfnp, pfn);
>>   
>> +	trace_dax_insert_entry(iter->inode, vmf, *entry);
>> +
>>   	/* insert PMD pfn */
>>   	if (pmd)
>>   		return vmf_insert_pfn_pmd(vmf, pfn, write);
>> diff --git a/include/trace/events/fs_dax.h b/include/trace/events/fs_dax.h
>> index 97b09fcf7e52..2ec2dcc8f66a 100644
>> --- a/include/trace/events/fs_dax.h
>> +++ b/include/trace/events/fs_dax.h
>> @@ -62,15 +62,14 @@ DEFINE_PMD_FAULT_EVENT(dax_pmd_fault_done);
>>   
>>   DECLARE_EVENT_CLASS(dax_pmd_load_hole_class,
>>   	TP_PROTO(struct inode *inode, struct vm_fault *vmf,
>> -		struct page *zero_page,
>> -		void *radix_entry),
>> -	TP_ARGS(inode, vmf, zero_page, radix_entry),
>> +		struct page *zero_page, void *xa_entry),
>> +	TP_ARGS(inode, vmf, zero_page, xa_entry),
>>   	TP_STRUCT__entry(
>>   		__field(unsigned long, ino)
>>   		__field(unsigned long, vm_flags)
>>   		__field(unsigned long, address)
>>   		__field(struct page *, zero_page)
>> -		__field(void *, radix_entry)
>> +		__field(void *, xa_entry)
>>   		__field(dev_t, dev)
>>   	),
>>   	TP_fast_assign(
>> @@ -79,40 +78,40 @@ DECLARE_EVENT_CLASS(dax_pmd_load_hole_class,
>>   		__entry->vm_flags = vmf->vma->vm_flags;
>>   		__entry->address = vmf->address;
>>   		__entry->zero_page = zero_page;
>> -		__entry->radix_entry = radix_entry;
>> +		__entry->xa_entry = xa_entry;
>>   	),
>>   	TP_printk("dev %d:%d ino %#lx %s address %#lx zero_page %p "
>> -			"radix_entry %#lx",
>> +			"xa_entry %#lx",
>>   		MAJOR(__entry->dev),
>>   		MINOR(__entry->dev),
>>   		__entry->ino,
>>   		__entry->vm_flags & VM_SHARED ? "shared" : "private",
>>   		__entry->address,
>>   		__entry->zero_page,
>> -		(unsigned long)__entry->radix_entry
>> +		(unsigned long)__entry->xa_entry
>>   	)
>>   )
>>   
>>   #define DEFINE_PMD_LOAD_HOLE_EVENT(name) \
>>   DEFINE_EVENT(dax_pmd_load_hole_class, name, \
>>   	TP_PROTO(struct inode *inode, struct vm_fault *vmf, \
>> -		struct page *zero_page, void *radix_entry), \
>> -	TP_ARGS(inode, vmf, zero_page, radix_entry))
>> +		struct page *zero_page, void *xa_entry), \
>> +	TP_ARGS(inode, vmf, zero_page, xa_entry))
>>   
>>   DEFINE_PMD_LOAD_HOLE_EVENT(dax_pmd_load_hole);
>>   DEFINE_PMD_LOAD_HOLE_EVENT(dax_pmd_load_hole_fallback);
>>   
>>   DECLARE_EVENT_CLASS(dax_pmd_insert_mapping_class,
>>   	TP_PROTO(struct inode *inode, struct vm_fault *vmf,
>> -		long length, pfn_t pfn, void *radix_entry),
>> -	TP_ARGS(inode, vmf, length, pfn, radix_entry),
>> +		long length, pfn_t pfn, void *xa_entry),
>> +	TP_ARGS(inode, vmf, length, pfn, xa_entry),
>>   	TP_STRUCT__entry(
>>   		__field(unsigned long, ino)
>>   		__field(unsigned long, vm_flags)
>>   		__field(unsigned long, address)
>>   		__field(long, length)
>>   		__field(u64, pfn_val)
>> -		__field(void *, radix_entry)
>> +		__field(void *, xa_entry)
>>   		__field(dev_t, dev)
>>   		__field(int, write)
>>   	),
>> @@ -124,10 +123,10 @@ DECLARE_EVENT_CLASS(dax_pmd_insert_mapping_class,
>>   		__entry->write = vmf->flags & FAULT_FLAG_WRITE;
>>   		__entry->length = length;
>>   		__entry->pfn_val = pfn.val;
>> -		__entry->radix_entry = radix_entry;
>> +		__entry->xa_entry = xa_entry;
>>   	),
>>   	TP_printk("dev %d:%d ino %#lx %s %s address %#lx length %#lx "
>> -			"pfn %#llx %s radix_entry %#lx",
>> +			"pfn %#llx %s xa_entry %#lx",
>>   		MAJOR(__entry->dev),
>>   		MINOR(__entry->dev),
>>   		__entry->ino,
>> @@ -138,15 +137,15 @@ DECLARE_EVENT_CLASS(dax_pmd_insert_mapping_class,
>>   		__entry->pfn_val & ~PFN_FLAGS_MASK,
>>   		__print_flags_u64(__entry->pfn_val & PFN_FLAGS_MASK, "|",
>>   			PFN_FLAGS_TRACE),
>> -		(unsigned long)__entry->radix_entry
>> +		(unsigned long)__entry->xa_entry
>>   	)
>>   )
>>   
>>   #define DEFINE_PMD_INSERT_MAPPING_EVENT(name) \
>>   DEFINE_EVENT(dax_pmd_insert_mapping_class, name, \
>>   	TP_PROTO(struct inode *inode, struct vm_fault *vmf, \
>> -		long length, pfn_t pfn, void *radix_entry), \
>> -	TP_ARGS(inode, vmf, length, pfn, radix_entry))
>> +		long length, pfn_t pfn, void *xa_entry), \
>> +	TP_ARGS(inode, vmf, length, pfn, xa_entry))
>>   
>>   DEFINE_PMD_INSERT_MAPPING_EVENT(dax_pmd_insert_mapping);
>>   
>> @@ -194,14 +193,14 @@ DEFINE_PTE_FAULT_EVENT(dax_load_hole);
>>   DEFINE_PTE_FAULT_EVENT(dax_insert_pfn_mkwrite_no_entry);
>>   DEFINE_PTE_FAULT_EVENT(dax_insert_pfn_mkwrite);
>>   
>> -TRACE_EVENT(dax_insert_mapping,
>> -	TP_PROTO(struct inode *inode, struct vm_fault *vmf, void *radix_entry),
>> -	TP_ARGS(inode, vmf, radix_entry),
>> +TRACE_EVENT(dax_insert_entry,
>> +	TP_PROTO(struct inode *inode, struct vm_fault *vmf, void *xa_entry),
>> +	TP_ARGS(inode, vmf, xa_entry),
>>   	TP_STRUCT__entry(
>>   		__field(unsigned long, ino)
>>   		__field(unsigned long, vm_flags)
>>   		__field(unsigned long, address)
>> -		__field(void *, radix_entry)
>> +		__field(void *, xa_entry)
>>   		__field(dev_t, dev)
>>   		__field(int, write)
>>   	),
>> @@ -211,16 +210,16 @@ TRACE_EVENT(dax_insert_mapping,
>>   		__entry->vm_flags = vmf->vma->vm_flags;
>>   		__entry->address = vmf->address;
>>   		__entry->write = vmf->flags & FAULT_FLAG_WRITE;
>> -		__entry->radix_entry = radix_entry;
>> +		__entry->xa_entry = xa_entry;
>>   	),
>> -	TP_printk("dev %d:%d ino %#lx %s %s address %#lx radix_entry %#lx",
>> +	TP_printk("dev %d:%d ino %#lx %s %s address %#lx xa_entry %#lx",
>>   		MAJOR(__entry->dev),
>>   		MINOR(__entry->dev),
>>   		__entry->ino,
>>   		__entry->vm_flags & VM_SHARED ? "shared" : "private",
>>   		__entry->write ? "write" : "read",
>>   		__entry->address,
>> -		(unsigned long)__entry->radix_entry
>> +		(unsigned long)__entry->xa_entry
>>   	)
>>   )
>>   
>> -- 
>> 2.34.1
>>

