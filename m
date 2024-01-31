Return-Path: <linux-fsdevel+bounces-9666-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A8F8442C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 16:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 806331F2247B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 15:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6493C128397;
	Wed, 31 Jan 2024 15:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="mi4L/ndK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554D75A7A1;
	Wed, 31 Jan 2024 15:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706714066; cv=none; b=VdcUegdY4RbRmQVzpUylEt1fjUoiqdJtfCrvOwjezDh0e5UKuD+9WyDrD10tJ3qL3xEGoE8foBPZEa0VLp2oeEGG7GrVOE34cY76Whzq3WGwjNh6CrYnJSVNpKdEWifhEILLXXzUnZdZL1fmP5ik9/eIZ2LiSSzDVM+gQOWVe3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706714066; c=relaxed/simple;
	bh=LN6ptRJUKoEZK47ZsEQ7EYUHNkUE/4Zcp52rPav6Q98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WNWebp6RuunbDWaQAzJz+jpBDSCYJ4f8dFV8/F/h+rdoTmJBcHJ/wyq3AP/TM3kWCXu0vdNRGAHeUDVH8VONglHwKVyW/Hr2YTPxiynTYCYOY6fqNm0DkD1evUZcIQsDeGQC18nA+sxQfjlPP4CBdybbi/LaeTWgvMKClFgxeho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=mi4L/ndK; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1706714063;
	bh=LN6ptRJUKoEZK47ZsEQ7EYUHNkUE/4Zcp52rPav6Q98=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mi4L/ndKJYIE2tvied3UllOOolXpuP+5XJkhxDlpOjXFz9eVyM+OxizFpTHo7dlzc
	 H92J3JjtdsfeHnmpa2eKx7E0S/kfA1pLWmUg8qwt2zujs81BZ5WdFEMDRsLuuT05C5
	 Lz6Q/JxTiSnCL5+MxcTDJHK8LWWfz+qSgMcfBMHfvCXvTCzzNPycjZ690RDkMf9hml
	 vWVYO3IT3UJHXyg/GBxWp4DfG7Rq/AxQl3X0cVo/fOTDc8xkQ5m7R015zRazXmurV/
	 BqLAtP/1E63aNpekcxTtzLBTvH50ikczfmB43w1kTs//Lck6MZ4zUuK9jWW8iwjWUz
	 IJT94AyP2XvQw==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TQ5DH1bjkzVrT;
	Wed, 31 Jan 2024 10:14:23 -0500 (EST)
Message-ID: <654c13fd-8c54-48e7-921b-1503e37f1455@efficios.com>
Date: Wed, 31 Jan 2024 10:14:22 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 8/8] dax: Fix incorrect list of dcache aliasing
 architectures
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>,
 Dave Chinner <david@fromorbit.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang
 <dave.jiang@intel.com>, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
 linux-arch@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>,
 nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20240130165255.212591-1-mathieu.desnoyers@efficios.com>
 <20240130165255.212591-9-mathieu.desnoyers@efficios.com>
 <Zbm2eS/AMlmhm8EW@dread.disaster.area>
 <65b9babf6b3de_5a9dd294de@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <65b9babf6b3de_5a9dd294de@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-01-30 22:13, Dan Williams wrote:
> Dave Chinner wrote:
>> On Tue, Jan 30, 2024 at 11:52:55AM -0500, Mathieu Desnoyers wrote:
>>> commit d92576f1167c ("dax: does not work correctly with virtual aliasing caches")
>>> prevents DAX from building on architectures with virtually aliased
>>> dcache with:
>>>
>>>    depends on !(ARM || MIPS || SPARC)
>>>
>>> This check is too broad (e.g. recent ARMv7 don't have virtually aliased
>>> dcaches), and also misses many other architectures with virtually
>>> aliased dcache.
>>>
>>> This is a regression introduced in the v5.13 Linux kernel where the
>>> dax mount option is removed for 32-bit ARMv7 boards which have no dcache
>>> aliasing, and therefore should work fine with FS_DAX.
>>>
>>> This was turned into the following implementation of dax_is_supported()
>>> by a preparatory change:
>>>
>>>          return !IS_ENABLED(CONFIG_ARM) &&
>>>                 !IS_ENABLED(CONFIG_MIPS) &&
>>>                 !IS_ENABLED(CONFIG_SPARC);
>>>
>>> Use dcache_is_aliasing() instead to figure out whether the environment
>>> has aliasing dcaches.
>>>
>>> Fixes: d92576f1167c ("dax: does not work correctly with virtual aliasing caches")
>>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>>> Cc: linux-mm@kvack.org
>>> Cc: linux-arch@vger.kernel.org
>>> Cc: Dan Williams <dan.j.williams@intel.com>
>>> Cc: Vishal Verma <vishal.l.verma@intel.com>
>>> Cc: Dave Jiang <dave.jiang@intel.com>
>>> Cc: Matthew Wilcox <willy@infradead.org>
>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>> Cc: Russell King <linux@armlinux.org.uk>
>>> Cc: nvdimm@lists.linux.dev
>>> Cc: linux-cxl@vger.kernel.org
>>> Cc: linux-fsdevel@vger.kernel.org
>>> ---
>>>   include/linux/dax.h | 5 ++---
>>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/include/linux/dax.h b/include/linux/dax.h
>>> index cfc8cd4a3eae..f59e604662e4 100644
>>> --- a/include/linux/dax.h
>>> +++ b/include/linux/dax.h
>>> @@ -5,6 +5,7 @@
>>>   #include <linux/fs.h>
>>>   #include <linux/mm.h>
>>>   #include <linux/radix-tree.h>
>>> +#include <linux/cacheinfo.h>
>>>   
>>>   typedef unsigned long dax_entry_t;
>>>   
>>> @@ -80,9 +81,7 @@ static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
>>>   }
>>>   static inline bool dax_is_supported(void)
>>>   {
>>> -	return !IS_ENABLED(CONFIG_ARM) &&
>>> -	       !IS_ENABLED(CONFIG_MIPS) &&
>>> -	       !IS_ENABLED(CONFIG_SPARC);
>>> +	return !dcache_is_aliasing();
>>
>> Yeah, if this is just a one liner should go into
>> fs_dax_get_by_bdev(), similar to the blk_queue_dax() check at the
>> start of the function.
>>
>> I also noticed that device mapper uses fs_dax_get_by_bdev() to
>> determine if it can support DAX, but this patch set does not address
>> that case. Hence it really seems to me like fs_dax_get_by_bdev() is
>> the right place to put this check.
> 
> Oh, good catch. Yes, I agree this can definitely be pushed down, but
> then I think it should be pushed down all the way to make alloc_dax()
> fail. That will need some additional fixups like:
> 
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 8dcabf84d866..a35e60e62440 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -2126,12 +2126,12 @@ static struct mapped_device *alloc_dev(int minor)
>                  md->dax_dev = alloc_dax(md, &dm_dax_ops);
>                  if (IS_ERR(md->dax_dev)) {
>                          md->dax_dev = NULL;
> -                       goto bad;
> +               } else {
> +                       set_dax_nocache(md->dax_dev);
> +                       set_dax_nomc(md->dax_dev);
> +                       if (dax_add_host(md->dax_dev, md->disk))
> +                               goto bad;
>                  }
> -               set_dax_nocache(md->dax_dev);
> -               set_dax_nomc(md->dax_dev);
> -               if (dax_add_host(md->dax_dev, md->disk))
> -                       goto bad;
>          }
>   
>          format_dev_t(md->name, MKDEV(_major, minor));
> 
> ...to make it not fatal to fail to register the dax_dev.

I've had a quick look at other users of alloc_dax() and
alloc_dax_region(), and so far I figure that all of those
really want to bail out on alloc_dax failure. Is dm.c the
only special-case we need to fix to make it non-fatal ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


