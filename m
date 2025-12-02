Return-Path: <linux-fsdevel+bounces-70492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B675EC9D577
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 00:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14EC93A81CA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 23:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D062FB97B;
	Tue,  2 Dec 2025 23:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e1lLoUn7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4283214A64;
	Tue,  2 Dec 2025 23:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764718283; cv=none; b=CDAMXdOQNT4nAl3rbljOamo3V9cthGUBD2r4xgslvwuc9gXmmLX2SSsho0vtCEV5i6PnoA0faCuB61Jj1/KRJ4i16UkxCQQFilYmcp2BIXftngodHXjw+6UQ8f0JMOFXIimE7A5BkdagsKIc1Zx/TgGQjsFdDCKAJcJ6+SprO7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764718283; c=relaxed/simple;
	bh=zQjx4mUAXC22XKY/wIc/wTGlHU/bOIqIwQPht7wj8TI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EAFc4ovVe7RvcuRtkkoylcH/Swf8lh9214SVhlVsCgQ8wBmYsewvwtuFTmeFxDEN96f29qV68Gqg19tow6qRENOVbOgI2l3ncu6eqe5sN/7PnANnFeJ/OoMA27svT+PvrzIIZLRROdnnXMqgFmUNNmi0VugmlXpJH1xUgApCZL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e1lLoUn7; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764718280; x=1796254280;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zQjx4mUAXC22XKY/wIc/wTGlHU/bOIqIwQPht7wj8TI=;
  b=e1lLoUn7PFmVvDgiXr94K+n5S+7lCCPXCYSNQXxGHAAxY+QdaaRYD7dO
   unNbQ1SqcTRoN1OA2Uf5ZKjORg590dDMuS9T79uINT2rQMw7aVOdU6rwK
   00u1BnmD/qWm3olbVtXYkoszdoRHGB9pfZBAkwSzumZGBAQd4Gh0RG10a
   2DLgi1uIa/LWV3XcRidPgjNAMfD53GXqwuI4VuMqAEpCUILuV9izvzxUm
   3ScNWwElMZiEVHVRbquumgTUunvxU2Qfhg9Pn5cGlDmv2BtpVUlNF35GG
   8Tr0RH4jrsrQzDKH5r0jTcSOXyva4Br83cDMHeUoRCwnhxbHXbY7ZoFMT
   Q==;
X-CSE-ConnectionGUID: 8NwH/lQrTkOpChqxqAIXcA==
X-CSE-MsgGUID: SE98brFRTYWZ0L/pOCKM5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="66593869"
X-IronPort-AV: E=Sophos;i="6.20,244,1758610800"; 
   d="scan'208";a="66593869"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 15:31:19 -0800
X-CSE-ConnectionGUID: TlqQlGRXQ6OcrKTthdL4Ow==
X-CSE-MsgGUID: +hU311ACS3mBVhpxQZiTjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,244,1758610800"; 
   d="scan'208";a="195304144"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.111.202]) ([10.125.111.202])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 15:31:17 -0800
Message-ID: <8d8c706e-6863-4054-b5c0-a37f566f0e7a@intel.com>
Date: Tue, 2 Dec 2025 16:31:16 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/9] dax/hmem, e820, resource: Defer Soft Reserved
 insertion until hmem is ready
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-pm@vger.kernel.org
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>,
 Pavel Machek <pavel@kernel.org>, Li Ming <ming.li@zohomail.com>,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 Ying Huang <huang.ying.caritas@gmail.com>,
 Yao Xingtao <yaoxt.fnst@fujitsu.com>, Peter Zijlstra <peterz@infradead.org>,
 Greg KH <gregkh@linuxfoundation.org>,
 Nathan Fontenot <nathan.fontenot@amd.com>,
 Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
 Benjamin Cheatham <benjamin.cheatham@amd.com>,
 Zhijian Li <lizhijian@fujitsu.com>, Borislav Petkov <bp@alien8.de>,
 Ard Biesheuvel <ardb@kernel.org>
References: <20251120031925.87762-1-Smita.KoralahalliChannabasappa@amd.com>
 <20251120031925.87762-2-Smita.KoralahalliChannabasappa@amd.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251120031925.87762-2-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/19/25 8:19 PM, Smita Koralahalli wrote:
> From: Dan Williams <dan.j.williams@intel.com>
> 
> Insert Soft Reserved memory into a dedicated soft_reserve_resource tree
> instead of the iomem_resource tree at boot. Delay publishing these ranges
> into the iomem hierarchy until ownership is resolved and the HMEM path
> is ready to consume them.
> 
> Publishing Soft Reserved ranges into iomem too early conflicts with CXL
> hotplug and prevents region assembly when those ranges overlap CXL
> windows.
> 
> Follow up patches will reinsert Soft Reserved ranges into iomem after CXL
> window publication is complete and HMEM is ready to claim the memory. This
> provides a cleaner handoff between EFI-defined memory ranges and CXL
> resource management without trimming or deleting resources later.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>

With changes requested from Dan,
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  arch/x86/kernel/e820.c    |  2 +-
>  drivers/cxl/acpi.c        |  2 +-
>  drivers/dax/hmem/device.c |  4 +-
>  drivers/dax/hmem/hmem.c   |  7 ++-
>  include/linux/ioport.h    | 13 +++++-
>  kernel/resource.c         | 92 +++++++++++++++++++++++++++++++++------
>  6 files changed, 100 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> index c3acbd26408b..c32f144f0e4a 100644
> --- a/arch/x86/kernel/e820.c
> +++ b/arch/x86/kernel/e820.c
> @@ -1153,7 +1153,7 @@ void __init e820__reserve_resources_late(void)
>  	res = e820_res;
>  	for (i = 0; i < e820_table->nr_entries; i++) {
>  		if (!res->parent && res->end)
> -			insert_resource_expand_to_fit(&iomem_resource, res);
> +			insert_resource_expand_to_fit(res);
>  		res++;
>  	}
>  
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index bd2e282ca93a..b37858f797be 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -847,7 +847,7 @@ static int add_cxl_resources(struct resource *cxl_res)
>  		 */
>  		cxl_set_public_resource(res, new);
>  
> -		insert_resource_expand_to_fit(&iomem_resource, new);
> +		__insert_resource_expand_to_fit(&iomem_resource, new);
>  
>  		next = res->sibling;
>  		while (next && resource_overlaps(new, next)) {
> diff --git a/drivers/dax/hmem/device.c b/drivers/dax/hmem/device.c
> index f9e1a76a04a9..22732b729017 100644
> --- a/drivers/dax/hmem/device.c
> +++ b/drivers/dax/hmem/device.c
> @@ -83,8 +83,8 @@ static __init int hmem_register_one(struct resource *res, void *data)
>  
>  static __init int hmem_init(void)
>  {
> -	walk_iomem_res_desc(IORES_DESC_SOFT_RESERVED,
> -			IORESOURCE_MEM, 0, -1, NULL, hmem_register_one);
> +	walk_soft_reserve_res_desc(IORES_DESC_SOFT_RESERVED, IORESOURCE_MEM, 0,
> +				   -1, NULL, hmem_register_one);
>  	return 0;
>  }
>  
> diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
> index c18451a37e4f..48f4642f4bb8 100644
> --- a/drivers/dax/hmem/hmem.c
> +++ b/drivers/dax/hmem/hmem.c
> @@ -73,11 +73,14 @@ static int hmem_register_device(struct device *host, int target_nid,
>  		return 0;
>  	}
>  
> -	rc = region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
> -			       IORES_DESC_SOFT_RESERVED);
> +	rc = region_intersects_soft_reserve(res->start, resource_size(res),
> +					    IORESOURCE_MEM,
> +					    IORES_DESC_SOFT_RESERVED);
>  	if (rc != REGION_INTERSECTS)
>  		return 0;
>  
> +	/* TODO: Add Soft-Reserved memory back to iomem */
> +
>  	id = memregion_alloc(GFP_KERNEL);
>  	if (id < 0) {
>  		dev_err(host, "memregion allocation failure for %pr\n", res);
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index e8b2d6aa4013..e20226870a81 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -232,6 +232,9 @@ struct resource_constraint {
>  /* PC/ISA/whatever - the normal PC address spaces: IO and memory */
>  extern struct resource ioport_resource;
>  extern struct resource iomem_resource;
> +#ifdef CONFIG_EFI_SOFT_RESERVE
> +extern struct resource soft_reserve_resource;
> +#endif
>  
>  extern struct resource *request_resource_conflict(struct resource *root, struct resource *new);
>  extern int request_resource(struct resource *root, struct resource *new);
> @@ -242,7 +245,8 @@ extern void reserve_region_with_split(struct resource *root,
>  			     const char *name);
>  extern struct resource *insert_resource_conflict(struct resource *parent, struct resource *new);
>  extern int insert_resource(struct resource *parent, struct resource *new);
> -extern void insert_resource_expand_to_fit(struct resource *root, struct resource *new);
> +extern void __insert_resource_expand_to_fit(struct resource *root, struct resource *new);
> +extern void insert_resource_expand_to_fit(struct resource *new);
>  extern int remove_resource(struct resource *old);
>  extern void arch_remove_reservations(struct resource *avail);
>  extern int allocate_resource(struct resource *root, struct resource *new,
> @@ -409,6 +413,13 @@ walk_system_ram_res_rev(u64 start, u64 end, void *arg,
>  extern int
>  walk_iomem_res_desc(unsigned long desc, unsigned long flags, u64 start, u64 end,
>  		    void *arg, int (*func)(struct resource *, void *));
> +extern int
> +walk_soft_reserve_res_desc(unsigned long desc, unsigned long flags,
> +			   u64 start, u64 end, void *arg,
> +			   int (*func)(struct resource *, void *));
> +extern int
> +region_intersects_soft_reserve(resource_size_t start, size_t size,
> +			       unsigned long flags, unsigned long desc);
>  
>  struct resource *devm_request_free_mem_region(struct device *dev,
>  		struct resource *base, unsigned long size);
> diff --git a/kernel/resource.c b/kernel/resource.c
> index b9fa2a4ce089..208eaafcc681 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -321,13 +321,14 @@ static bool is_type_match(struct resource *p, unsigned long flags, unsigned long
>  }
>  
>  /**
> - * find_next_iomem_res - Finds the lowest iomem resource that covers part of
> - *			 [@start..@end].
> + * find_next_res - Finds the lowest resource that covers part of
> + *		   [@start..@end].
>   *
>   * If a resource is found, returns 0 and @*res is overwritten with the part
>   * of the resource that's within [@start..@end]; if none is found, returns
>   * -ENODEV.  Returns -EINVAL for invalid parameters.
>   *
> + * @parent:	resource tree root to search
>   * @start:	start address of the resource searched for
>   * @end:	end address of same resource
>   * @flags:	flags which the resource must have
> @@ -337,9 +338,9 @@ static bool is_type_match(struct resource *p, unsigned long flags, unsigned long
>   * The caller must specify @start, @end, @flags, and @desc
>   * (which may be IORES_DESC_NONE).
>   */
> -static int find_next_iomem_res(resource_size_t start, resource_size_t end,
> -			       unsigned long flags, unsigned long desc,
> -			       struct resource *res)
> +static int find_next_res(struct resource *parent, resource_size_t start,
> +			 resource_size_t end, unsigned long flags,
> +			 unsigned long desc, struct resource *res)
>  {
>  	struct resource *p;
>  
> @@ -351,7 +352,7 @@ static int find_next_iomem_res(resource_size_t start, resource_size_t end,
>  
>  	read_lock(&resource_lock);
>  
> -	for_each_resource(&iomem_resource, p, false) {
> +	for_each_resource(parent, p, false) {
>  		/* If we passed the resource we are looking for, stop */
>  		if (p->start > end) {
>  			p = NULL;
> @@ -382,16 +383,23 @@ static int find_next_iomem_res(resource_size_t start, resource_size_t end,
>  	return p ? 0 : -ENODEV;
>  }
>  
> -static int __walk_iomem_res_desc(resource_size_t start, resource_size_t end,
> -				 unsigned long flags, unsigned long desc,
> -				 void *arg,
> -				 int (*func)(struct resource *, void *))
> +static int find_next_iomem_res(resource_size_t start, resource_size_t end,
> +			       unsigned long flags, unsigned long desc,
> +			       struct resource *res)
> +{
> +	return find_next_res(&iomem_resource, start, end, flags, desc, res);
> +}
> +
> +static int walk_res_desc(struct resource *parent, resource_size_t start,
> +			 resource_size_t end, unsigned long flags,
> +			 unsigned long desc, void *arg,
> +			 int (*func)(struct resource *, void *))
>  {
>  	struct resource res;
>  	int ret = -EINVAL;
>  
>  	while (start < end &&
> -	       !find_next_iomem_res(start, end, flags, desc, &res)) {
> +	       !find_next_res(parent, start, end, flags, desc, &res)) {
>  		ret = (*func)(&res, arg);
>  		if (ret)
>  			break;
> @@ -402,6 +410,15 @@ static int __walk_iomem_res_desc(resource_size_t start, resource_size_t end,
>  	return ret;
>  }
>  
> +static int __walk_iomem_res_desc(resource_size_t start, resource_size_t end,
> +				 unsigned long flags, unsigned long desc,
> +				 void *arg,
> +				 int (*func)(struct resource *, void *))
> +{
> +	return walk_res_desc(&iomem_resource, start, end, flags, desc, arg, func);
> +}
> +
> +
>  /**
>   * walk_iomem_res_desc - Walks through iomem resources and calls func()
>   *			 with matching resource ranges.
> @@ -426,6 +443,26 @@ int walk_iomem_res_desc(unsigned long desc, unsigned long flags, u64 start,
>  }
>  EXPORT_SYMBOL_GPL(walk_iomem_res_desc);
>  
> +#ifdef CONFIG_EFI_SOFT_RESERVE
> +struct resource soft_reserve_resource = {
> +	.name	= "Soft Reserved",
> +	.start	= 0,
> +	.end	= -1,
> +	.desc	= IORES_DESC_SOFT_RESERVED,
> +	.flags	= IORESOURCE_MEM,
> +};
> +EXPORT_SYMBOL_GPL(soft_reserve_resource);
> +
> +int walk_soft_reserve_res_desc(unsigned long desc, unsigned long flags,
> +			       u64 start, u64 end, void *arg,
> +			       int (*func)(struct resource *, void *))
> +{
> +	return walk_res_desc(&soft_reserve_resource, start, end, flags, desc,
> +			     arg, func);
> +}
> +EXPORT_SYMBOL_GPL(walk_soft_reserve_res_desc);
> +#endif
> +
>  /*
>   * This function calls the @func callback against all memory ranges of type
>   * System RAM which are marked as IORESOURCE_SYSTEM_RAM and IORESOUCE_BUSY.
> @@ -648,6 +685,22 @@ int region_intersects(resource_size_t start, size_t size, unsigned long flags,
>  }
>  EXPORT_SYMBOL_GPL(region_intersects);
>  
> +#ifdef CONFIG_EFI_SOFT_RESERVE
> +int region_intersects_soft_reserve(resource_size_t start, size_t size,
> +				   unsigned long flags, unsigned long desc)
> +{
> +	int ret;
> +
> +	read_lock(&resource_lock);
> +	ret = __region_intersects(&soft_reserve_resource, start, size, flags,
> +				  desc);
> +	read_unlock(&resource_lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(region_intersects_soft_reserve);
> +#endif
> +
>  void __weak arch_remove_reservations(struct resource *avail)
>  {
>  }
> @@ -966,7 +1019,7 @@ EXPORT_SYMBOL_GPL(insert_resource);
>   * Insert a resource into the resource tree, possibly expanding it in order
>   * to make it encompass any conflicting resources.
>   */
> -void insert_resource_expand_to_fit(struct resource *root, struct resource *new)
> +void __insert_resource_expand_to_fit(struct resource *root, struct resource *new)
>  {
>  	if (new->parent)
>  		return;
> @@ -997,7 +1050,20 @@ void insert_resource_expand_to_fit(struct resource *root, struct resource *new)
>   * to use this interface. The former are built-in and only the latter,
>   * CXL, is a module.
>   */
> -EXPORT_SYMBOL_NS_GPL(insert_resource_expand_to_fit, "CXL");
> +EXPORT_SYMBOL_NS_GPL(__insert_resource_expand_to_fit, "CXL");
> +
> +void insert_resource_expand_to_fit(struct resource *new)
> +{
> +	struct resource *root = &iomem_resource;
> +
> +#ifdef CONFIG_EFI_SOFT_RESERVE
> +	if (new->desc == IORES_DESC_SOFT_RESERVED)
> +		root = &soft_reserve_resource;
> +#endif
> +
> +	__insert_resource_expand_to_fit(root, new);
> +}
> +EXPORT_SYMBOL_GPL(insert_resource_expand_to_fit);
>  
>  /**
>   * remove_resource - Remove a resource in the resource tree


