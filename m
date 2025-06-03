Return-Path: <linux-fsdevel+bounces-50544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8C8ACD065
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 01:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD22118961AB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 23:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA43253F31;
	Tue,  3 Jun 2025 23:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XwOwgqHl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66230253931;
	Tue,  3 Jun 2025 23:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748994557; cv=none; b=UeYmBA83fCLTIqJ9p5+ffHtNiuhb19fDx9Y7x0LNLJTc2IvN94EJXgVl5ITezcNi/KXzETq7FZodEeXcAuRqlFsFAVkdKioziBteS35SeO1VECUpxMGWmaod/lZcpmrwDxFpqCCAZlok1ZCude3r80YO3yPNJYlLmpLI+dGG3Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748994557; c=relaxed/simple;
	bh=4y4pzl9CuxCiq6dgSTlZ7ItA/CFbTQ/kEM2fLcmPg6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e7xcBA44lQ8Hm8f97KGtrEXfwWStqZ5mt079QuvkcyH6A9C6zcTRflskwzEyg+rzj8YZPY5MLjmkdVAZc57NvkFKirZYdWjO8cTrUYD9TXksDB5NdJ5ruJOILftA3UDE8fcGhR3db1COY7lr6yNTeaGaARPZUbTYnSR1LRHt1Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XwOwgqHl; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748994555; x=1780530555;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4y4pzl9CuxCiq6dgSTlZ7ItA/CFbTQ/kEM2fLcmPg6g=;
  b=XwOwgqHlng6cqsjLqRWeCzU4UA6AX+FeCPg4UuNGUv5c26Sz75WhMCDK
   CsEK3gvvnIcJ6bMPdK/KGINb6heK6jhXcOsO0S1Z4arZsyLPg5PdA7KMd
   rffsxFxygoqNLYWCQQU6q5KTIWnhXvovBpbmbrkNCjS9o3zfTwsEzspIm
   Q8/GRAvutTvoox9S4cpXvjB4cCvmt+qoDSveUEDt0iKmTgC5i9t/LQjcw
   B7sQNRb9PV6njZ3N/veg0xPQi0x1+d9gl678g11sLfez6vtZiSselc/9e
   pIYsQlk6xPhmw48s9mtdrW8hz8XcPq7BB1fO/FAY/izkjFOgRnDz82pL9
   g==;
X-CSE-ConnectionGUID: gJFt5jdMTs+mnO0cMB/Gbg==
X-CSE-MsgGUID: oU6hMN5pRIuRpVB/Jr7jSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="76442558"
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="76442558"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 16:49:14 -0700
X-CSE-ConnectionGUID: pi5f9+UJTeyetJIh++UAaQ==
X-CSE-MsgGUID: 4FQxYE5tSVmkhuvv1TJwLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="145624252"
Received: from iherna2-mobl4.amr.corp.intel.com (HELO [10.125.110.198]) ([10.125.110.198])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 16:49:13 -0700
Message-ID: <3464d8cb-e53c-4e6b-b810-49e51c98e902@intel.com>
Date: Tue, 3 Jun 2025 16:49:10 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/7] cxl/region: Avoid null pointer dereference in
 is_cxl_region()
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
References: <20250603221949.53272-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250603221949.53272-2-Smita.KoralahalliChannabasappa@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250603221949.53272-2-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/3/25 3:19 PM, Smita Koralahalli wrote:
> Add a NULL check in is_cxl_region() to prevent potential null pointer
> dereference if a caller passes a NULL device. This change ensures the
> function safely returns false instead of triggering undefined behavior
> when dev is NULL.

Don't think this change is necessary. The code paths should not be hitting any NULL region devices unless it's a programming error.

> 
> Co-developed-by: Nathan Fontenot <Nathan.Fontenot@amd.com>
> Signed-off-by: Nathan Fontenot <Nathan.Fontenot@amd.com>
> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
>  drivers/cxl/core/region.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index c3f4dc244df7..109b8a98c4c7 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2333,7 +2333,7 @@ const struct device_type cxl_region_type = {
>  
>  bool is_cxl_region(struct device *dev)
>  {
> -	return dev->type == &cxl_region_type;
> +	return dev && dev->type == &cxl_region_type;
>  }
>  EXPORT_SYMBOL_NS_GPL(is_cxl_region, "CXL");
>  


