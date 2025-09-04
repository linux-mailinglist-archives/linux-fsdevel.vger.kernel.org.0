Return-Path: <linux-fsdevel+bounces-60290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F4AB44528
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 20:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C2AE1CC06B6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 18:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE213431E3;
	Thu,  4 Sep 2025 18:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jaw00GqV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92351341AB6;
	Thu,  4 Sep 2025 18:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757009660; cv=none; b=Yipl0miklET8xJEJNjmwHom6BvrZJCeZY4W/tpMdYi6xJN/JPEux9AyGuBqpNGNYQEyJh4nA30Bc04UXPgO7XgReroxCK8D8H0AX+9TCAGhn6n05oM/U1pI2SwpKULV7FZ+tItylhYb2UHKa/6j6wHQWt4TzC19GgarQHd4T4fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757009660; c=relaxed/simple;
	bh=snRYZy8sFUcGEZgJH9P6mgJNhGmYsmCzIsOzo2eyGW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a2vJ1HFSMVfjnV5Q3S1EfvMKOvmPNVjNTlcFJdghqHtpv90zkvCuVYiHgApaY8+yZ5o4P5JBNxX/oblS6Sf41J940ZpOdi1/x/8N8xhhfJ/ZTxb3LpP24l13w/dSzdVpEAMrdACUpMMAjzRxzta9834/9ZWoSBcNoH99kUiF+7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jaw00GqV; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757009658; x=1788545658;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=snRYZy8sFUcGEZgJH9P6mgJNhGmYsmCzIsOzo2eyGW4=;
  b=Jaw00GqVNWfQlgJBQsYhi5N2jGUlLg0p0hbxuHBUiIRPyLlMvnvjRK/V
   F897XlXnTAh0IGECbRrzjkPNGMgJbH5JqdDTFbvyp3wZieXP5pB4MwV0k
   Q7aIzW9KY0Rnwb8Cbv/qDoIetRTRr4jij45zSuF+nFN3SSnwhY63iu6BY
   wfdUAAjQPsEhNXNdGadRohmT9ty1bSDi7dK73HmcqgI2+rHS0dj0YF9+n
   4rvNm2FHgjc08RtV4HzG9aj1AlDpKEacMKHI0krCSs71BUHBaQtQeB98G
   25mfyhqaXxmtC+QlY5GcaNZ4GQbWKLc5yy4qyWHCpd8yJ7uIQ3CtwCyU8
   w==;
X-CSE-ConnectionGUID: bQP0YyE1T3KLRj1fus8YTw==
X-CSE-MsgGUID: avdgIM2GRH+ixkTYZGfj6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="76814956"
X-IronPort-AV: E=Sophos;i="6.18,239,1751266800"; 
   d="scan'208";a="76814956"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 11:14:18 -0700
X-CSE-ConnectionGUID: uXWQ13oQTYOxPlfW1q2Xow==
X-CSE-MsgGUID: vt+G3bBGQMSvNLBiSWtcYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,239,1751266800"; 
   d="scan'208";a="176300742"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.110.24]) ([10.125.110.24])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 11:14:16 -0700
Message-ID: <14d94e89-8342-4bd7-9c53-a3b46e22caa7@intel.com>
Date: Thu, 4 Sep 2025 11:14:15 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] dax/hmem: Reintroduce Soft Reserved ranges back into
 the iomem tree
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-pm@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Matthew Wilcox
 <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>,
 Pavel Machek <pavel@kernel.org>, Li Ming <ming.li@zohomail.com>,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 Ying Huang <huang.ying.caritas@gmail.com>,
 Yao Xingtao <yaoxt.fnst@fujitsu.com>, Peter Zijlstra <peterz@infradead.org>,
 Greg KH <gregkh@linuxfoundation.org>,
 Nathan Fontenot <nathan.fontenot@amd.com>,
 Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
 Benjamin Cheatham <benjamin.cheatham@amd.com>,
 PradeepVineshReddy Kodamati <PradeepVineshReddy.Kodamati@amd.com>,
 Zhijian Li <lizhijian@fujitsu.com>
References: <20250822034202.26896-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250822034202.26896-6-Smita.KoralahalliChannabasappa@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250822034202.26896-6-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/21/25 8:42 PM, Smita Koralahalli wrote:
> Reworked from a patch by Alison Schofield <alison.schofield@intel.com>
> 
> Reintroduce Soft Reserved range into the iomem_resource tree for dax_hmem
> to consume.
> 
> This restores visibility in /proc/iomem for ranges actively in use, while
> avoiding the early-boot conflicts that occurred when Soft Reserved was
> published into iomem before CXL window and region discovery.
> 
> Link: https://lore.kernel.org/linux-cxl/29312c0765224ae76862d59a17748c8188fb95f1.1692638817.git.alison.schofield@intel.com/
> Co-developed-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/dax/hmem/hmem.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
> index 90978518e5f4..24a6e7e3d916 100644
> --- a/drivers/dax/hmem/hmem.c
> +++ b/drivers/dax/hmem/hmem.c
> @@ -93,6 +93,40 @@ static void process_defer_work(struct work_struct *_work)
>  	walk_hmem_resources(&pdev->dev, handle_deferred_cxl);
>  }
>  
> +static void remove_soft_reserved(void *data)
> +{
> +	struct resource *r = data;
> +
> +	remove_resource(r);
> +	kfree(r);
> +}
> +
> +static int add_soft_reserve_into_iomem(struct device *host,
> +				       const struct resource *res)
> +{
> +	struct resource *soft = kzalloc(sizeof(*soft), GFP_KERNEL);
> +	int rc;
> +
> +	if (!soft)
> +		return -ENOMEM;
> +
> +	*soft = DEFINE_RES_NAMED_DESC(res->start, (res->end - res->start + 1),
> +				      "Soft Reserved", IORESOURCE_MEM,
> +				      IORES_DESC_SOFT_RESERVED);
> +
> +	rc = insert_resource(&iomem_resource, soft);
> +	if (rc) {
> +		kfree(soft);
> +		return rc;
> +	}
> +
> +	rc = devm_add_action_or_reset(host, remove_soft_reserved, soft);
> +	if (rc)
> +		return rc;
> +
> +	return 0;
> +}
> +
>  static int hmem_register_device(struct device *host, int target_nid,
>  				const struct resource *res)
>  {
> @@ -125,6 +159,10 @@ static int hmem_register_device(struct device *host, int target_nid,
>  					    IORES_DESC_SOFT_RESERVED);
>  	if (rc != REGION_INTERSECTS)
>  		return 0;
> +
> +	rc = add_soft_reserve_into_iomem(host, res);
> +	if (rc)
> +		return rc;
>  #else
>  	rc = region_intersects(res->start, resource_size(res), IORESOURCE_MEM,
>  			       IORES_DESC_SOFT_RESERVED);


