Return-Path: <linux-fsdevel+bounces-4060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F36427FBFEE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 18:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63335B215E1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 17:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C680554FBC;
	Tue, 28 Nov 2023 17:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PffPnB1E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC46210DC
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Nov 2023 09:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701191040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=H1JRVgdLO3nk5MUhGAW8/rcAipEyZCuEtc1JuumPxqM=;
	b=PffPnB1EVfApAWhc7BH3Dr8GmfPUpvKUOBW7jHOsaJacaphSkN2/SqeFLmKPprh/piqaSH
	2RNKFK3IMEA2EadiMV7WPXOsw0Ww6RCszZ+7Xvzn618N5TSJrbD6xoLvxJWrAS9skqDEc8
	k8e/571TSCbt9UaQ2N7LTY5TBJcTkVw=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-H5X9EmxJOJqJLoC1MKFrwQ-1; Tue, 28 Nov 2023 12:03:56 -0500
X-MC-Unique: H5X9EmxJOJqJLoC1MKFrwQ-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2c8749e1c2dso48795431fa.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Nov 2023 09:03:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701191035; x=1701795835;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H1JRVgdLO3nk5MUhGAW8/rcAipEyZCuEtc1JuumPxqM=;
        b=dZiFEVlCqIqm3mvdCaIQe7/YFQE/dGw73QoijE+SUsDT64SVp5Jtn34l6ipAXnXBta
         a5QLGABeESZqCM23NWVC/dY4lDPDJC0Oms7qNSvHohoSj2VwWU8Aj5CyID45LXz2RSLf
         L8MkW0MSQorDFHr/4LzttFk1DB4BWo0wMpBEhFqv0ruF7xQTfV96jRRjFwRxXVmmKwYx
         nmbASoEBa59TvvA6psiYipZWYZ3IdUn1oScisYwhaYfPH8DFF3hpZQefg/BUED12IX89
         lLx/j18sJcu27Bg95HU5Pa91NnAWRVfHXK157zt9D+uYf6VV3RAlPgfs1ILYM1rwlZwb
         3BCw==
X-Gm-Message-State: AOJu0YxpIIyzAsEnxNVmktR+gaZ5HjO2oxVCMXP051hywoxr18BU5ZMP
	+zmlcq3c0Y/olbHGUjzfbxiYUe/d2+YQ28243Gqp7ZIfqFSkB8IhtSAqCM5MEHIfUWN1z+DIAIs
	plWQ1n7RwGFG61JhcZYD1Neofag==
X-Received: by 2002:a2e:a0cc:0:b0:2c9:af62:b960 with SMTP id f12-20020a2ea0cc000000b002c9af62b960mr1968897ljm.8.1701191035210;
        Tue, 28 Nov 2023 09:03:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjArWJW/lEoMMdj2KI7VcNWh+r8LI0fSmXxPsYdgo/R6AtT9oZhG7ey1ufhF3o/5pmEnD8zg==
X-Received: by 2002:a2e:a0cc:0:b0:2c9:af62:b960 with SMTP id f12-20020a2ea0cc000000b002c9af62b960mr1968858ljm.8.1701191034717;
        Tue, 28 Nov 2023 09:03:54 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:1d00:99ec:9656:7475:678d? (p200300cbc7081d0099ec96567475678d.dip0.t-ipconnect.de. [2003:cb:c708:1d00:99ec:9656:7475:678d])
        by smtp.gmail.com with ESMTPSA id d21-20020adf9b95000000b003316ad360c1sm15738401wrc.24.2023.11.28.09.03.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 09:03:54 -0800 (PST)
Message-ID: <2aafd53f-af1f-45f3-a08c-d11962254315@redhat.com>
Date: Tue, 28 Nov 2023 18:03:52 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 12/27] arm64: mte: Add tag storage pages to the
 MIGRATE_CMA migratetype
Content-Language: en-US
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
 maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
 yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
 vschneid@redhat.com, mhiramat@kernel.org, rppt@kernel.org, hughd@google.com,
 pcc@google.com, steven.price@arm.com, anshuman.khandual@arm.com,
 vincenzo.frascino@arm.com, eugenis@google.com, kcc@google.com,
 hyesoo.yu@samsung.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
References: <20231119165721.9849-1-alexandru.elisei@arm.com>
 <20231119165721.9849-13-alexandru.elisei@arm.com>
 <c49cd89d-41cf-495b-9b96-4434ab407967@redhat.com> <ZWSvMYMjFLFZ-abv@raptor>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZWSvMYMjFLFZ-abv@raptor>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.11.23 16:01, Alexandru Elisei wrote:
> Hi David,
> 
> On Fri, Nov 24, 2023 at 08:40:55PM +0100, David Hildenbrand wrote:
>> On 19.11.23 17:57, Alexandru Elisei wrote:
>>> Add the MTE tag storage pages to the MIGRATE_CMA migratetype, which allows
>>> the page allocator to manage them like regular pages.
>>>
>>> Ths migratype lends the pages some very desirable properties:
>>>
>>> * They cannot be longterm pinned, meaning they will always be migratable.
>>>
>>> * The pages can be allocated explicitely by using their PFN (with
>>>     alloc_contig_range()) when they are needed to store tags.
>>>
>>> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
>>> ---
>>>    arch/arm64/Kconfig                  |  1 +
>>>    arch/arm64/kernel/mte_tag_storage.c | 68 +++++++++++++++++++++++++++++
>>>    include/linux/mmzone.h              |  5 +++
>>>    mm/internal.h                       |  3 --
>>>    4 files changed, 74 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>> index fe8276fdc7a8..047487046e8f 100644
>>> --- a/arch/arm64/Kconfig
>>> +++ b/arch/arm64/Kconfig
>>> @@ -2065,6 +2065,7 @@ config ARM64_MTE
>>>    if ARM64_MTE
>>>    config ARM64_MTE_TAG_STORAGE
>>>    	bool "Dynamic MTE tag storage management"
>>> +	select CONFIG_CMA
>>>    	help
>>>    	  Adds support for dynamic management of the memory used by the hardware
>>>    	  for storing MTE tags. This memory, unlike normal memory, cannot be
>>> diff --git a/arch/arm64/kernel/mte_tag_storage.c b/arch/arm64/kernel/mte_tag_storage.c
>>> index fa6267ef8392..427f4f1909f3 100644
>>> --- a/arch/arm64/kernel/mte_tag_storage.c
>>> +++ b/arch/arm64/kernel/mte_tag_storage.c
>>> @@ -5,10 +5,12 @@
>>>     * Copyright (C) 2023 ARM Ltd.
>>>     */
>>> +#include <linux/cma.h>
>>>    #include <linux/memblock.h>
>>>    #include <linux/mm.h>
>>>    #include <linux/of_device.h>
>>>    #include <linux/of_fdt.h>
>>> +#include <linux/pageblock-flags.h>
>>>    #include <linux/range.h>
>>>    #include <linux/string.h>
>>>    #include <linux/xarray.h>
>>> @@ -189,6 +191,14 @@ static int __init fdt_init_tag_storage(unsigned long node, const char *uname,
>>>    		return ret;
>>>    	}
>>> +	/* Pages are managed in pageblock_nr_pages chunks */
>>> +	if (!IS_ALIGNED(tag_range->start | range_len(tag_range), pageblock_nr_pages)) {
>>> +		pr_err("Tag storage region 0x%llx-0x%llx not aligned to pageblock size 0x%llx",
>>> +		       PFN_PHYS(tag_range->start), PFN_PHYS(tag_range->end),
>>> +		       PFN_PHYS(pageblock_nr_pages));
>>> +		return -EINVAL;
>>> +	}
>>> +
>>>    	ret = tag_storage_get_memory_node(node, &mem_node);
>>>    	if (ret)
>>>    		return ret;
>>> @@ -254,3 +264,61 @@ void __init mte_tag_storage_init(void)
>>>    		pr_info("MTE tag storage region management disabled");
>>>    	}
>>>    }
>>> +
>>> +static int __init mte_tag_storage_activate_regions(void)
>>> +{
>>> +	phys_addr_t dram_start, dram_end;
>>> +	struct range *tag_range;
>>> +	unsigned long pfn;
>>> +	int i, ret;
>>> +
>>> +	if (num_tag_regions == 0)
>>> +		return 0;
>>> +
>>> +	dram_start = memblock_start_of_DRAM();
>>> +	dram_end = memblock_end_of_DRAM();
>>> +
>>> +	for (i = 0; i < num_tag_regions; i++) {
>>> +		tag_range = &tag_regions[i].tag_range;
>>> +		/*
>>> +		 * Tag storage region was clipped by arm64_bootmem_init()
>>> +		 * enforcing addressing limits.
>>> +		 */
>>> +		if (PFN_PHYS(tag_range->start) < dram_start ||
>>> +				PFN_PHYS(tag_range->end) >= dram_end) {
>>> +			pr_err("Tag storage region 0x%llx-0x%llx outside addressable memory",
>>> +			       PFN_PHYS(tag_range->start), PFN_PHYS(tag_range->end));
>>> +			ret = -EINVAL;
>>> +			goto out_disabled;
>>> +		}
>>> +	}
>>> +
>>> +	/*
>>> +	 * MTE disabled, tag storage pages can be used like any other pages. The
>>> +	 * only restriction is that the pages cannot be used by kexec because
>>> +	 * the memory remains marked as reserved in the memblock allocator.
>>> +	 */
>>> +	if (!system_supports_mte()) {
>>> +		for (i = 0; i< num_tag_regions; i++) {
>>> +			tag_range = &tag_regions[i].tag_range;
>>> +			for (pfn = tag_range->start; pfn <= tag_range->end; pfn++)
>>> +				free_reserved_page(pfn_to_page(pfn));
>>> +		}
>>> +		ret = 0;
>>> +		goto out_disabled;
>>> +	}
>>> +
>>> +	for (i = 0; i < num_tag_regions; i++) {
>>> +		tag_range = &tag_regions[i].tag_range;
>>> +		for (pfn = tag_range->start; pfn <= tag_range->end; pfn += pageblock_nr_pages)
>>> +			init_cma_reserved_pageblock(pfn_to_page(pfn));
>>> +		totalcma_pages += range_len(tag_range);
>>> +	}
>>
>> You shouldn't be doing that manually in arm code. Likely you want some cma.c
>> helper for something like that.
> 
> If you referring to the last loop (the one that does
> ini_cma_reserved_pageblock()), indeed, there's already a function which
> does that, cma_init_reserved_areas() -> cma_activate_area().
> 
>>
>> But, can you elaborate on why you took this hacky (sorry) approach as
>> documented in the cover letter:
> 
> No worries, it is indeed a bit hacky :)
> 
>>
>> "The arm64 code manages this memory directly instead of using
>> cma_declare_contiguous/cma_alloc for performance reasons."
>>
>> What is the exact problem?
> 
> I am referring to the performance degredation that is fixed in patch #26,
> "arm64: mte: Fast track reserving tag storage when the block is free" [1].
> The issue is that alloc_contig_range() -> __alloc_contig_migrate_range()
> calls lru_cache_disable(), which IPIs all the CPUs in the system, and that
> leads to a 10-20% performance degradation on Chrome. It has been observed
> that most of the time the tag storage pages are free, and the
> lru_cache_disable() calls are unnecessary.

This sounds like something eventually worth integrating into 
CMA/alloc_contig_range(). Like, a fast path to check if we are only 
allocating something small (e.g., falls within a single pageblock), and 
if the page is free.

> 
> The performance degradation is almost entirely eliminated by having the code
> take the tag storage page directly from the free list if it's free, instead
> of calling alloc_contig_range().
> 
> Do you believe it would be better to use the cma code, and modify it to use
> this fast path to take the page drectly from the buddy allocator?

That sounds reasonable yes. Do you see any blockers for that?

> 
> I can definitely try to integrate the code with cma_alloc(), but I think
> keeping the fast path for reserving tag storage is extremely desirable,
> since it makes such a huge difference to performance.

Yes, but let's try finding a way to optimize common code, to eventually 
improve some CMA cases as well? :)

-- 
Cheers,

David / dhildenb


