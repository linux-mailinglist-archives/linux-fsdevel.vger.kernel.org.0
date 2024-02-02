Return-Path: <linux-fsdevel+bounces-10079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B29698479A5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 20:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40840289564
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 19:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9752C80601;
	Fri,  2 Feb 2024 19:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="vuoQB1le"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC8215E5AE;
	Fri,  2 Feb 2024 19:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706902152; cv=none; b=CW9IUT8prQznoqyWEoVXa/26XSlx9ByNQFSdwgM1QxhdbRB00Zyj3+Fjzaazky0gSnAnxv5/FaYcgzQ+ucxLtc8GKEVs4r+TEd5jSRgO8T5OBATvlAugZM20DXH/jaLiFR90JX/5t+TjBcNfuZCLcqq+thFbny2iZ6UI3jLN8fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706902152; c=relaxed/simple;
	bh=P5L94LQ6Hg9uW7husBFpiivZAxhm5usar4GO4ypUsik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OtQ3WydL2Wk6zuPCX4umYA+OAsphlVmRAgKQO3C6RSZV4I6fF1hUMQcDg6cZ64R0K4TgMI5GDgOOcm2kk9y1PDrYjk0DFIVEgCCJuQIZlT+vKq7/HJxyG9aCTupBfoaXzuvgxI61orzwDQ1l3X62oZqINd4jLWmyy4F0sJjJzD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=vuoQB1le; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1706902144;
	bh=P5L94LQ6Hg9uW7husBFpiivZAxhm5usar4GO4ypUsik=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vuoQB1lekXlbjADkCcvYIvisuIDfVtul+Mv7g1QhfkY+Dn8Kqp5EqVVFl6WgUeCME
	 W9MsuJgQBpNHIHIEZrM7HtgrA80tGoe3cEBvkf6bFPPH93r8ERPxoEGcU19Vj0+0N6
	 vvtibcNd6X2uUGqTdNGHLALH2lWeui4gSATNqcr9uoTDeHeflu3Bh9HHFnnUzjxPdr
	 2UeI6iLMjX38nTDhl/OfOu57xWLk8+a9WU2pcnEYgkgUyO9CpJPcbBkMD7EXg1Ghaj
	 DFKnWfrxihPS7a21/dHY3lcOn/pX72Zc1QAG/Xba2Jl3NCt0qpKoejnR54b+IqXJUn
	 nbll165jXqVbA==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TRQnD3vfJzXHG;
	Fri,  2 Feb 2024 14:29:04 -0500 (EST)
Message-ID: <6bdf6085-101d-47ef-86f4-87936622345a@efficios.com>
Date: Fri, 2 Feb 2024 14:29:05 -0500
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
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <65bd284165177_2d43c29443@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-02-02 12:37, Dan Williams wrote:
> Mathieu Desnoyers wrote:
[...]
>>
> 
>> The alternative route I intend to take is to audit all callers
>> of alloc_dax() and make sure they all save the alloc_dax() return
>> value in a struct dax_device * local variable first for the sake
>> of checking for IS_ERR(). This will leave the xyz->dax_dev pointer
>> initialized to NULL in the error case and simplify the rest of
>> error checking.
> 
> I could maybe get on board with that, but it needs a comment somewhere
> about the asymmetric subtlety.

Is this "somewhere" at every alloc_dax() call site, or do you have
something else in mind ?

> 
>>
>>
>>>    		return;
>>>    
>>>    	if (dax_dev->holder_data != NULL)
>>> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
>>> index 4e8fdcb3f1c8..b69c9e442cf4 100644
>>> --- a/drivers/nvdimm/pmem.c
>>> +++ b/drivers/nvdimm/pmem.c
>>> @@ -560,17 +560,19 @@ static int pmem_attach_disk(struct device *dev,
>>>    	dax_dev = alloc_dax(pmem, &pmem_dax_ops);
>>>    	if (IS_ERR(dax_dev)) {
>>>    		rc = PTR_ERR(dax_dev);
>>> -		goto out;
>>> +		if (rc != -EOPNOTSUPP)
>>> +			goto out;
>>
>> If I compare the before / after this change, if previously
>> pmem_attach_disk() was called in a configuration with FS_DAX=n, it would
>> result in a NULL pointer dereference.
> 
> No, alloc_dax() only returns NULL CONFIG_DAX=n case, not the
> CONFIG_FS_DAX=n case.

Indeed, I was wrong there.

> So that means that pmem devices on ARM have been
> possible without FS_DAX. So, in order for alloc_dax() returning
> ERR_PTR(-EOPNOTSUPP) to not regress pmem device availability this error
> path needs to be changed.
Good point. We're moving the depends on !(ARM || MIPS |PARC) from FS_DAX
Kconfig to a runtime check in alloc_dax(), which is used whenever DAX=y,
which includes configurations that had FS_DAX=n previously.

I'll change the error path in pmem_attack_disk to treat -EOPNOTSUPP
alloc_dax() return value as non-fatal.

> 
>> This would be an error handling fix all by itself. Do we really want
>> to return successfully if dax is unsupported, or should we return
>> an error here ?
> 
> Per above, there is no error handling fix, and pmem block device
> available should not depend on alloc_dax() succeeding.

I agree on treating alloc_dax() failure as non-fatal. There is
however one error handling fix to nvdimm/pmem which I plan to
introduce as an initial patch before this change:

     nvdimm/pmem: Fix leak on dax_add_host() failure
     
     Fix a leak on dax_add_host() error, where "goto out_cleanup_dax" is done
     before setting pmem->dax_dev, which therefore issues the two following
     calls on NULL pointers:
     
     out_cleanup_dax:
             kill_dax(pmem->dax_dev);
             put_dax(pmem->dax_dev);
     
     Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 4e8fdcb3f1c8..9fe358090720 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -566,12 +566,11 @@ static int pmem_attach_disk(struct device *dev,
  	set_dax_nomc(dax_dev);
  	if (is_nvdimm_sync(nd_region))
  		set_dax_synchronous(dax_dev);
+	pmem->dax_dev = dax_dev;
  	rc = dax_add_host(dax_dev, disk);
  	if (rc)
  		goto out_cleanup_dax;
  	dax_write_cache(dax_dev, nvdimm_has_cache(nd_region));
-	pmem->dax_dev = dax_dev;
-
  	rc = device_add_disk(dev, disk, pmem_attribute_groups);
  	if (rc)
  		goto out_remove_host;

> 
> The real question is what to do about device-dax. I *think* it is not
> affected by cpu_dcache aliasing because it never accesses user mappings
> through a kernel alias. I doubt device-dax is in use on these platforms,
> but we might need another fixup for that if someone screams about the
> alloc_dax() behavior change making them lose device-dax access.

By "device-dax", I understand you mean drivers/dax/Kconfig:DEV_DAX.

Based on your analysis, is alloc_dax() still the right spot where
to place this runtime check ? Which call sites are responsible
for invoking alloc_dax() for device-dax ?

If we know which call sites do not intend to use the kernel linear
mapping, we could introduce a flag (or a new variant of the alloc_dax()
API) that would either enforce or skip the check.

[...]

>>
>> Here what I'm seeing so far:
>>
>> - devm_release_mem_region() is never called after devm_request_mem_region(). Not
>>     on error, neither on teardown,
> 
> devm_release_mem_region() is called from virtio_fs_probe() context. That

I guess you mean "devm_request_mem_region()" here.

> means that when virtio_fs_probe() returns an error the driver core will
> automatically call devm_request_mem_region().

And "devm_release_mem_region()" here.

> 
>> - pgmap is never freed on error after devm_kzalloc.
> 
> That is what the "devm_" in devm_kzalloc() does, free the memory on
> driver-probe failure, or after the driver remove callback is invoked.

Got it.

> 
>>
>>>    {
>>> +	struct dax_device *dax_dev __free(cleanup_dax) = NULL;
>>>    	struct virtio_shm_region cache_reg;
>>>    	struct dev_pagemap *pgmap;
>>>    	bool have_cache;
>>> @@ -804,6 +808,15 @@ static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
>>>    	if (!IS_ENABLED(CONFIG_FUSE_DAX))
>>>    		return 0;
>>>    
>>> +	dax_dev = alloc_dax(fs, &virtio_fs_dax_ops);
>>> +	if (IS_ERR(dax_dev)) {
>>> +		int rc = PTR_ERR(dax_dev);
>>> +
>>> +		if (rc == -EOPNOTSUPP)
>>> +			return 0;
>>> +		return rc;
>>> +	}
>>
>> What is gained by moving this allocation here ?
> 
> The gain is to fail early in virtio_fs_setup_dax() since the fundamental
> dependency of alloc_dax() success is not met. For example why let the
> setup progress to devm_memremap_pages() when alloc_dax() is going to
> return ERR_PTR(-EOPNOTSUPP).

What I don't know is whether there is a dependency requiring to do
devm_request_mem_region(), devm_kzalloc(), devm_memremap_pages()
before calling alloc_dax() ?

Those 3 calls are used to populate:

         fs->window_phys_addr = (phys_addr_t) cache_reg.addr;
         fs->window_len = (phys_addr_t) cache_reg.len;

and then alloc_dax() takes "fs" as private data parameter. So it's
unclear to me whether we can swap the invocation order. I suspect
that it is not an issue because it is only used to populate
dax_dev->private, but I prefer to confirm this with you just to be
on the safe side.

[...]

Thanks,

Mathieu



-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


