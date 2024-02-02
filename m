Return-Path: <linux-fsdevel+bounces-10085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99728847A36
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 21:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD41E1C2521E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 20:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA309839EE;
	Fri,  2 Feb 2024 20:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="CmeX23S7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBA18063D;
	Fri,  2 Feb 2024 20:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706904173; cv=none; b=JU14UIVwl/G439CznFolw6zaD538QPlAJtsyY8gHUR/TaK7pm56nmpH0vMZ645c5x+vcJC/t8dKck28rhGClZ/O1ViGJIO4JIRrqtKyAtrSAieP6Wu33O4kntCkBtdc3gLwoc6s5/HWGUeCg7XhQIgwLHb1YONm1C47vovnUT14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706904173; c=relaxed/simple;
	bh=U8Zpp8rzADjQWv8sp6Upen6MRmo/xdz9mIdCpg1d5d0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=csWED/iUkVLgKMo3dkaS6gzbbj8Oy81z5jKrH+/JrtVPrljiQPlZ+argUlXJFUNFCRKoHUNwVCrY65xTIsIZhKCeNKRQrStc5T0RgomzZslmDL0Cu9oJoa2vXPDIgu7vlvngfhhztr/hj1mgHdMBW6mGzjirJngOnGoy4Q3ngI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=CmeX23S7; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1706904169;
	bh=U8Zpp8rzADjQWv8sp6Upen6MRmo/xdz9mIdCpg1d5d0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CmeX23S7NWtLpK+eiIZsvdsXqvq9a2C5GT5UEfoNFmLT74sYFVEQYiZUHTkWR1s/m
	 gE82fXfKp38/4XUPZ133OnCLiaZxfY/nGJ6r0uws4ITe4unBEgeis7VnRH87RkvfNS
	 CcXWaHj/JViXRsjCr9gB0Kbmj/OOP3ohi6cBPEyDlOEOgnW+3JyO9rjllrj3yXQGPc
	 f0IHPPF5Zw5Vp2HS8EdN/Ls7v6O3dLmXNVMB4dlwr35GzKBiARWFnFxE8DWOSwJZyn
	 zCFGR0OSgygAMI3MXZqpWjLzzYzG+W4swDPmIV6cDvsnrXfRR85+F+SRNfRKdnRGZT
	 ypkpPgzZlqG2A==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TRRX86Fj7zWgY;
	Fri,  2 Feb 2024 15:02:48 -0500 (EST)
Message-ID: <5e838147-524c-40e5-b106-e388bf4e549b@efficios.com>
Date: Fri, 2 Feb 2024 15:02:50 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 2/4] dax: Check for data cache aliasing at runtime
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Dave Chinner <david@fromorbit.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
 linux-arch@vger.kernel.org, Vishal Verma <vishal.l.verma@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>,
 Russell King <linux@armlinux.org.uk>, nvdimm@lists.linux.dev,
 linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 dm-devel@lists.linux.dev
References: <20240131162533.247710-1-mathieu.desnoyers@efficios.com>
 <20240131162533.247710-3-mathieu.desnoyers@efficios.com>
 <65bab567665f3_37ad2943c@dwillia2-xfh.jf.intel.com.notmuch>
 <0a38176b-c453-4be0-be83-f3e1bb897973@efficios.com>
 <65bac71a9659b_37ad29428@dwillia2-xfh.jf.intel.com.notmuch>
 <f1d14941-2d22-452a-99e6-42db806b6d7f@efficios.com>
 <65bd284165177_2d43c29443@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <6bdf6085-101d-47ef-86f4-87936622345a@efficios.com>
 <65bd457460fb1_719322942@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <65bd457460fb1_719322942@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-02-02 14:41, Dan Williams wrote:
> Mathieu Desnoyers wrote:
>> On 2024-02-02 12:37, Dan Williams wrote:
>>> Mathieu Desnoyers wrote:
>> [...]
>>>>
>>>
>>>> The alternative route I intend to take is to audit all callers
>>>> of alloc_dax() and make sure they all save the alloc_dax() return
>>>> value in a struct dax_device * local variable first for the sake
>>>> of checking for IS_ERR(). This will leave the xyz->dax_dev pointer
>>>> initialized to NULL in the error case and simplify the rest of
>>>> error checking.
>>>
>>> I could maybe get on board with that, but it needs a comment somewhere
>>> about the asymmetric subtlety.
>>
>> Is this "somewhere" at every alloc_dax() call site, or do you have
>> something else in mind ?
> 
> At least kill_dax() should mention the asymmetry I think.

Here is what I intend to add:

  * Note, because alloc_dax() returns an ERR_PTR() on error, callers
  * typically store its result into a local variable in order to check
  * the result. Therefore, care must be taken to populate the struct
  * device dax_dev field make sure the dax_dev is not leaked.

> 
>>> The real question is what to do about device-dax. I *think* it is not
>>> affected by cpu_dcache aliasing because it never accesses user mappings
>>> through a kernel alias. I doubt device-dax is in use on these platforms,
>>> but we might need another fixup for that if someone screams about the
>>> alloc_dax() behavior change making them lose device-dax access.
>>
>> By "device-dax", I understand you mean drivers/dax/Kconfig:DEV_DAX.
>>
>> Based on your analysis, is alloc_dax() still the right spot where
>> to place this runtime check ? Which call sites are responsible
>> for invoking alloc_dax() for device-dax ?
> 
> That is in devm_create_dev_dax().
> 
>> If we know which call sites do not intend to use the kernel linear
>> mapping, we could introduce a flag (or a new variant of the alloc_dax()
>> API) that would either enforce or skip the check.
> 
> Hmmm, it looks like there is already a natural flag for that. If
> alloc_dax() is passed a NULL operations pointer it means there are no
> kernel usages of the aliased mapping. That actually fits rather nicely.

Good, I was reaching the same conclusion when I received your reply.
I'll do that. It ends up being:

         /*
          * Unavailable on architectures with virtually aliased data caches,
          * except for device-dax (NULL operations pointer), which does
          * not use aliased mappings from the kernel.
          */
         if (ops && cpu_dcache_is_aliasing())
                 return ERR_PTR(-EOPNOTSUPP);

> 
> [..]
>>>>> @@ -804,6 +808,15 @@ static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
>>>>>     	if (!IS_ENABLED(CONFIG_FUSE_DAX))
>>>>>     		return 0;
>>>>>     
>>>>> +	dax_dev = alloc_dax(fs, &virtio_fs_dax_ops);
>>>>> +	if (IS_ERR(dax_dev)) {
>>>>> +		int rc = PTR_ERR(dax_dev);
>>>>> +
>>>>> +		if (rc == -EOPNOTSUPP)
>>>>> +			return 0;
>>>>> +		return rc;
>>>>> +	}
>>>>
>>>> What is gained by moving this allocation here ?
>>>
>>> The gain is to fail early in virtio_fs_setup_dax() since the fundamental
>>> dependency of alloc_dax() success is not met. For example why let the
>>> setup progress to devm_memremap_pages() when alloc_dax() is going to
>>> return ERR_PTR(-EOPNOTSUPP).
>>
>> What I don't know is whether there is a dependency requiring to do
>> devm_request_mem_region(), devm_kzalloc(), devm_memremap_pages()
>> before calling alloc_dax() ?
>>
>> Those 3 calls are used to populate:
>>
>>           fs->window_phys_addr = (phys_addr_t) cache_reg.addr;
>>           fs->window_len = (phys_addr_t) cache_reg.len;
>>
>> and then alloc_dax() takes "fs" as private data parameter. So it's
>> unclear to me whether we can swap the invocation order. I suspect
>> that it is not an issue because it is only used to populate
>> dax_dev->private, but I prefer to confirm this with you just to be
>> on the safe side.
> 
> Thanks for that. All of those need to be done before the fs goes live
> later in virtio_device_ready(), but before that point nothing should be
> calling into virtio_fs_dax_ops, so as far as I can see it is safe to
> change the order.

Sounds good, I'll do that.

I will soon be ready to send out a RFC v4, which is still only
compiled-tested. Do you happen to have some kind of test suite
you can use to automate some of the runtime testing ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


