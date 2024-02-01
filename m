Return-Path: <linux-fsdevel+bounces-9888-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A14EC845BF4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 16:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57C8029568E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 15:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CC7626CD;
	Thu,  1 Feb 2024 15:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="jQAlq7p5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3028626C9;
	Thu,  1 Feb 2024 15:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706802281; cv=none; b=RtZFE/prZ7MySR+TJtWBjZRfV7gWWThInUGoUmTlsWQt9E3z+dnL+s7Ok845okDvvs9/IdobvivvhG2Qzclw6vGLF3fUMWA+O8Iu6Y42vxBmL3ZF4qDrVQrdV3mjEG6kiShrTKvJ2xviR87Zl+fAHb/VqNG+u/Bf2sbEOuHvRCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706802281; c=relaxed/simple;
	bh=EljNSqSB9iVaTjOX0NliJSa73mINvXkzk5RZOGwGe/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OISiCtkosjZ02L3GMOcXR1CK3MlN+PEO/f2RqcZOFGxSqAQB0EpzPWS6BgAHe70wIwfOLFxMCXNOo3ZxrZcKWnSgNr1mCTZDUnxJW71hOgM57fZYg/9jf/tqbF0m4shVBHeR9ueLY2SnUCb9Awp31PNskQqIphL+wjdTC+1tpc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=jQAlq7p5; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1706802275;
	bh=EljNSqSB9iVaTjOX0NliJSa73mINvXkzk5RZOGwGe/o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jQAlq7p5Aki9VtnDZh8ca4Nxw/cE0yyURJAvjdBSGJXumay1z/Hord4yXay6x3QCC
	 k1CQbMx6g/A5i3aj4sqKkG4QuG8WMezkkoRV9N3LpLSczPSVx7ovus2tv0kgf54uEH
	 zMl3BkCbRhUb0xmqKXX20vrvVEdX8aYvuYDi5DByWSOhjk+p4oXvB0IXlDZ3bkEA2j
	 bemU0Z4BrTRKmwQQIEBwTd3LKgtOeRbZfMyu46OQTlF/ZhmVMR/rmGKsplTw742Uez
	 YfXAnM3zR7TLCZBCS1x5rPGvzDCplh/Cru2fgabUQvFZfIVOsD6rEaEJp/mRAyEBpm
	 pGdLaHNdxt7xA==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TQjrg1SwlzWlV;
	Thu,  1 Feb 2024 10:44:35 -0500 (EST)
Message-ID: <f1d14941-2d22-452a-99e6-42db806b6d7f@efficios.com>
Date: Thu, 1 Feb 2024 10:44:35 -0500
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
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <65bac71a9659b_37ad29428@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-01-31 17:18, Dan Williams wrote:
> Mathieu Desnoyers wrote:
>> On 2024-01-31 16:02, Dan Williams wrote:
>>> Mathieu Desnoyers wrote:
>>>> Replace the following fs/Kconfig:FS_DAX dependency:
>>>>
>>>>     depends on !(ARM || MIPS || SPARC)
>>>>
>>>> By a runtime check within alloc_dax().
>>>>
>>>> This is done in preparation for its use by each filesystem supporting
>>>> the "dax" mount option to validate whether DAX is indeed supported.
>>>>
>>>> This is done in preparation for using cpu_dcache_is_aliasing() in a
>>>> following change which will properly support architectures which detect
>>>> data cache aliasing at runtime.
>>>>
>>>> Fixes: d92576f1167c ("dax: does not work correctly with virtual aliasing caches")
>>>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>>>> Cc: linux-mm@kvack.org
>>>> Cc: linux-arch@vger.kernel.org
>>>> Cc: Dan Williams <dan.j.williams@intel.com>
>>>> Cc: Vishal Verma <vishal.l.verma@intel.com>
>>>> Cc: Dave Jiang <dave.jiang@intel.com>
>>>> Cc: Matthew Wilcox <willy@infradead.org>
>>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>>> Cc: Russell King <linux@armlinux.org.uk>
>>>> Cc: nvdimm@lists.linux.dev
>>>> Cc: linux-cxl@vger.kernel.org
>>>> Cc: linux-fsdevel@vger.kernel.org
>>>> Cc: dm-devel@lists.linux.dev
>>>> ---
>>>>    drivers/dax/super.c | 6 ++++++
>>>>    fs/Kconfig          | 1 -
>>>>    2 files changed, 6 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
>>>> index 0da9232ea175..e9f397b8a5a3 100644
>>>> --- a/drivers/dax/super.c
>>>> +++ b/drivers/dax/super.c
>>>> @@ -445,6 +445,12 @@ struct dax_device *alloc_dax(void *private, const struct dax_operations *ops)
>>>>    	dev_t devt;
>>>>    	int minor;
>>>>    
>>>> +	/* Unavailable on architectures with virtually aliased data caches. */
>>>> +	if (IS_ENABLED(CONFIG_ARM) ||
>>>> +	    IS_ENABLED(CONFIG_MIPS) ||
>>>> +	    IS_ENABLED(CONFIG_SPARC))
>>>> +		return NULL;
>>>
>>> This function returns ERR_PTR(), not NULL on failure.
>>
>> Except that it returns NULL in the CONFIG_DAX=n case as you
>> noticed below.
>>
>>>
>>> ...and I notice this mistake is also made in include/linux/dax.h in the
>>> CONFIG_DAX=n case. That function also mentions:
>>>
>>>       static inline struct dax_device *alloc_dax(void *private,
>>>                       const struct dax_operations *ops)
>>>       {
>>>               /*
>>>                * Callers should check IS_ENABLED(CONFIG_DAX) to know if this
>>>                * NULL is an error or expected.
>>>                */
>>>               return NULL;
>>>       }
>>>
>>> ...and none of the callers validate the result, but now runtime
>>> validation is necessary. I.e. it is not enough to check
>>> IS_ENABLED(CONFIG_DAX) it also needs to check cpu_dcache_is_aliasing().
>>
>> If the callers select DAX in their Kconfig, then they don't have to
>> explicitly check for IS_ENABLED(CONFIG_DAX). Things change for the
>> introduced runtime check though.
>>
>>>
>>> With that, there are a few more fixup places needed, pmem_attach_disk(),
>>> dcssblk_add_store(), and virtio_fs_setup_dax().
>>
>> Which approach should we take then ? Should we:
>>
>> A) Keep returning NULL from alloc_dax() for both
>>      cpu_dcache_is_aliasing() and CONFIG_DAX=n, and use IS_ERR_OR_NULL()
>>      in the caller. If we do this, then the callers need to somehow
>>      translate this NULL into a negative error value, or
>>
>> B) Replace this NULL return value in both cases by a ERR_PTR() (which
>>      error value should we return ?).
>>
>> I would favor approach B) which appears more robust and introduces
>> fewer changes. If we go for that approach do we still need to change
>> the callers ?
> 
> I agree approach B is the way to go, but that still requires these
> fixups, feel free to steal these hunks and split them into patches:
> 
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> ...but note they are compile-tested only. They assume that alloc_dax()
> returns ERR_PTR(-EOPNOTSUPP) when the arch support is missing, and I
> wrote them quickly so I might have missed something.

The change for -EOPNOTSUPP in header and implementation would look like
this (more questions below):

diff --git a/include/linux/dax.h b/include/linux/dax.h
index b463502b16e1..df2d52b8a245 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -86,11 +86,7 @@ static inline void *dax_holder(struct dax_device *dax_dev)
  static inline struct dax_device *alloc_dax(void *private,
  		const struct dax_operations *ops)
  {
-	/*
-	 * Callers should check IS_ENABLED(CONFIG_DAX) to know if this
-	 * NULL is an error or expected.
-	 */
-	return NULL;
+	return ERR_PTR(-EOPNOTSUPP);
  }
  static inline void put_dax(struct dax_device *dax_dev)
  {
diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 8c3a6e8e6334..c1cf6f0bbe12 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -448,7 +448,7 @@ struct dax_device *alloc_dax(void *private, const struct dax_operations *ops)
  
  	/* Unavailable on architectures with virtually aliased data caches. */
  	if (cpu_dcache_is_aliasing())
-		return NULL;
+		return ERR_PTR(-EOPNOTSUPP);
  
  	if (WARN_ON_ONCE(ops && !ops->zero_page_range))
  		return ERR_PTR(-EINVAL);

> 
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index f4b635526345..254d3b1e420e 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -322,7 +322,7 @@ EXPORT_SYMBOL_GPL(dax_alive);
>    */
>   void kill_dax(struct dax_device *dax_dev)
>   {
> -	if (!dax_dev)
> +	if (IS_ERR_OR_NULL(dax_dev))

I am tempted to just leave the "if (!dax_dev)" check here, because
many other functions of this API are only protected by a NULL
pointer check. I would hate to forget to convert one check in this
change, and I don't think it simplifies anything.

The alternative route I intend to take is to audit all callers
of alloc_dax() and make sure they all save the alloc_dax() return
value in a struct dax_device * local variable first for the sake
of checking for IS_ERR(). This will leave the xyz->dax_dev pointer
initialized to NULL in the error case and simplify the rest of
error checking.


>   		return;
>   
>   	if (dax_dev->holder_data != NULL)
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index 4e8fdcb3f1c8..b69c9e442cf4 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -560,17 +560,19 @@ static int pmem_attach_disk(struct device *dev,
>   	dax_dev = alloc_dax(pmem, &pmem_dax_ops);
>   	if (IS_ERR(dax_dev)) {
>   		rc = PTR_ERR(dax_dev);
> -		goto out;
> +		if (rc != -EOPNOTSUPP)
> +			goto out;

If I compare the before / after this change, if previously
pmem_attach_disk() was called in a configuration with FS_DAX=n, it would
result in a NULL pointer dereference.

This would be an error handling fix all by itself. Do we really want
to return successfully if dax is unsupported, or should we return
an error here ?


> +	} else {
> +		set_dax_nocache(dax_dev);
> +		set_dax_nomc(dax_dev);
> +		if (is_nvdimm_sync(nd_region))
> +			set_dax_synchronous(dax_dev);
> +		rc = dax_add_host(dax_dev, disk);
> +		if (rc)
> +			goto out_cleanup_dax;
> +		dax_write_cache(dax_dev, nvdimm_has_cache(nd_region));
> +		pmem->dax_dev = dax_dev;
>   	}
> -	set_dax_nocache(dax_dev);
> -	set_dax_nomc(dax_dev);
> -	if (is_nvdimm_sync(nd_region))
> -		set_dax_synchronous(dax_dev);
> -	rc = dax_add_host(dax_dev, disk);
> -	if (rc)
> -		goto out_cleanup_dax;
> -	dax_write_cache(dax_dev, nvdimm_has_cache(nd_region));
> -	pmem->dax_dev = dax_dev;
>   
>   	rc = device_add_disk(dev, disk, pmem_attribute_groups);
>   	if (rc)
> diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
> index 4b7ecd4fd431..f911e58a24dd 100644
> --- a/drivers/s390/block/dcssblk.c
> +++ b/drivers/s390/block/dcssblk.c
> @@ -681,12 +681,14 @@ dcssblk_add_store(struct device *dev, struct device_attribute *attr, const char
>   	if (IS_ERR(dev_info->dax_dev)) {
>   		rc = PTR_ERR(dev_info->dax_dev);
>   		dev_info->dax_dev = NULL;
> -		goto put_dev;
> +		if (rc != -EOPNOTSUPP)
> +			goto put_dev;

config DCSSBLK selects FS_DAX_LIMITED and DAX.

I'm not sure what selecting DAX is trying to achieve here, because the
Kconfig option is "FS_DAX".

So depending on the real motivation behind this select, we may want to
consider failure rather than success in the -EOPNOTSUPP case.

> +	} else {
> +		set_dax_synchronous(dev_info->dax_dev);
> +		rc = dax_add_host(dev_info->dax_dev, dev_info->gd);
> +		if (rc)
> +			goto out_dax;
>   	}
> -	set_dax_synchronous(dev_info->dax_dev);
> -	rc = dax_add_host(dev_info->dax_dev, dev_info->gd);
> -	if (rc)
> -		goto out_dax;
>   
>   	get_device(&dev_info->dev);
>   	rc = device_add_disk(&dev_info->dev, dev_info->gd, NULL);

My own changes, if we want failure on -EOPNOTSUPP:

diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index 4b7ecd4fd431..f363c1d51d9a 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -549,6 +549,7 @@ dcssblk_add_store(struct device *dev, struct device_attribute *attr, const char
  	int rc, i, j, num_of_segments;
  	struct dcssblk_dev_info *dev_info;
  	struct segment_info *seg_info, *temp;
+	struct dax_device *dax_dev;
  	char *local_buf;
  	unsigned long seg_byte_size;
  
@@ -677,13 +678,13 @@ dcssblk_add_store(struct device *dev, struct device_attribute *attr, const char
  	if (rc)
  		goto put_dev;
  
-	dev_info->dax_dev = alloc_dax(dev_info, &dcssblk_dax_ops);
-	if (IS_ERR(dev_info->dax_dev)) {
-		rc = PTR_ERR(dev_info->dax_dev);
-		dev_info->dax_dev = NULL;
+	dax_dev = alloc_dax(dev_info, &dcssblk_dax_ops);
+	if (IS_ERR(dax_dev)) {
+		rc = PTR_ERR(dax_dev);
  		goto put_dev;
  	}
-	set_dax_synchronous(dev_info->dax_dev);
+	set_dax_synchronous(dax_dev);
+	dev_info->dax_dev = dax_dev;
  	rc = dax_add_host(dev_info->dax_dev, dev_info->gd);
  	if (rc)
  		goto out_dax;


> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 5f1be1da92ce..11053a70f5ab 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -16,6 +16,7 @@
>   #include <linux/fs_context.h>
>   #include <linux/fs_parser.h>
>   #include <linux/highmem.h>
> +#include <linux/cleanup.h>
>   #include <linux/uio.h>
>   #include "fuse_i.h"
>   
> @@ -795,8 +796,11 @@ static void virtio_fs_cleanup_dax(void *data)
>   	put_dax(dax_dev);
>   }
>   
> +DEFINE_FREE(cleanup_dax, struct dax_dev *, if (!IS_ERR_OR_NULL(_T)) virtio_fs_cleanup_dax(_T))
> +
>   static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)

So either I'm completely missing how ownership works in this function, or
we should be really concerned about the fact that it does no actual
cleanup of anything on any error.

I would be tempted to first refactor this function without using cleanup.h
so those fixes can be easily backported to older kernels (?)

Here what I'm seeing so far:

- devm_release_mem_region() is never called after devm_request_mem_region(). Not
   on error, neither on teardown,
- pgmap is never freed on error after devm_kzalloc.

>   {
> +	struct dax_device *dax_dev __free(cleanup_dax) = NULL;
>   	struct virtio_shm_region cache_reg;
>   	struct dev_pagemap *pgmap;
>   	bool have_cache;
> @@ -804,6 +808,15 @@ static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
>   	if (!IS_ENABLED(CONFIG_FUSE_DAX))
>   		return 0;
>   
> +	dax_dev = alloc_dax(fs, &virtio_fs_dax_ops);
> +	if (IS_ERR(dax_dev)) {
> +		int rc = PTR_ERR(dax_dev);
> +
> +		if (rc == -EOPNOTSUPP)
> +			return 0;
> +		return rc;
> +	}

What is gained by moving this allocation here ?

> +
>   	/* Get cache region */
>   	have_cache = virtio_get_shm_region(vdev, &cache_reg,
>   					   (u8)VIRTIO_FS_SHMCAP_ID_CACHE);
> @@ -849,10 +862,7 @@ static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
>   	dev_dbg(&vdev->dev, "%s: window kaddr 0x%px phys_addr 0x%llx len 0x%llx\n",
>   		__func__, fs->window_kaddr, cache_reg.addr, cache_reg.len);
>   
> -	fs->dax_dev = alloc_dax(fs, &virtio_fs_dax_ops);
> -	if (IS_ERR(fs->dax_dev))
> -		return PTR_ERR(fs->dax_dev);
> -
> +	fs->dax_dev = no_free_ptr(dax_dev);
>   	return devm_add_action_or_reset(&vdev->dev, virtio_fs_cleanup_dax,
>   					fs->dax_dev);
>   }

In addition I have:

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index f90743a94da9..86de91b35f4d 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2054,6 +2054,7 @@ static void cleanup_mapped_device(struct mapped_device *md)
  static struct mapped_device *alloc_dev(int minor)
  {
  	int r, numa_node_id = dm_get_numa_node();
+	struct dax_device *dax_dev;
  	struct mapped_device *md;
  	void *old_md;
  
@@ -2122,16 +2123,13 @@ static struct mapped_device *alloc_dev(int minor)
  	md->disk->private_data = md;
  	sprintf(md->disk->disk_name, "dm-%d", minor);
  
-	if (IS_ENABLED(CONFIG_FS_DAX)) {
-		md->dax_dev = alloc_dax(md, &dm_dax_ops);
-		if (IS_ERR(md->dax_dev)) {
-			md->dax_dev = NULL;
-		} else {
-			set_dax_nocache(md->dax_dev);
-			set_dax_nomc(md->dax_dev);
-			if (dax_add_host(md->dax_dev, md->disk))
-				goto bad;
-		}
+	dax_dev = alloc_dax(md, &dm_dax_ops);
+	if (!IS_ERR(dax_dev)) {
+		set_dax_nocache(dax_dev);
+		set_dax_nomc(dax_dev);
+		md->dax_dev = dax_dev;
+		if (dax_add_host(dax_dev, md->disk))
+			goto bad;
  	}
  
  	format_dev_t(md->name, MKDEV(_major, minor));

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


