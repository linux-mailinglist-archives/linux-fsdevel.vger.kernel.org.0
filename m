Return-Path: <linux-fsdevel+bounces-77589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJfqFt/glWk4VwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 16:55:11 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4813157832
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 16:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E8BE301FD71
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 15:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835CC343D78;
	Wed, 18 Feb 2026 15:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ub9SIhN5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBA7342503;
	Wed, 18 Feb 2026 15:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771430096; cv=none; b=uC1DDBJkNR/pXJJR+E5Pf8SQOFZQ/UoMtR64WLBalox+dRf9/nFTLyUu5aw7aHdnDi1s54xWbD0MNI6fHBXEUPRpsiaxQWsLhSrsqXBwv8azG+qxflgT7M4Zz1mtZ7l+kmMaSwUdm7hk2TsTk9SxpLDUUk/r0QeHUUACbESkBZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771430096; c=relaxed/simple;
	bh=kTv3K3ud2hLhI5t3kyCmZBewgwlDVTPQUj5rUJN56eU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EEZDKqJdUgEZUmulovTVDuBajFgYhgKN45DkapjEVJTho0Hvjf1T8cjY9IKbL1RuoBlkzSv4cZcYpqww+8ImGLnsBj3yVSHsLhtPpY3BkpeaO+pyDXJo0rRwzQUOeDT5REI/XqeZ06K2SsOvhHeFd0NPnC7D3WnkrhIny/FgcjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ub9SIhN5; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771430095; x=1802966095;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kTv3K3ud2hLhI5t3kyCmZBewgwlDVTPQUj5rUJN56eU=;
  b=Ub9SIhN5deUsNbQY5qLbHJLGhStuHfTFInaOmevelw29XHfn7dTKlBiE
   LQ8rJYTjZcYRV8MEVFf7t0R3SCgYCx4Se4Bah2JVrBRE2F2IVWEdXYLST
   QViImn6XIxD03LYwaedcQ7aAEuSt6tptVtAN6YfN3CgamJ6ql5azikecS
   i2ooQTx8xtk01CW0pLwJNdfsRvYEhclBDuMXwI4a1EZhz5ZltjhJMHxu1
   rPI1xGJJH8zllZJnE19MGcCEPppcLgtIa40JzEGR0N/vgdi7DjqLbm/O7
   CGDjj6J22qDxKitFl8/GfY1P7U2Ol7cwMpawVvd2rJfCeyUX5snAcv0HP
   Q==;
X-CSE-ConnectionGUID: McjdlSYlRxWvRXMxhAG9EA==
X-CSE-MsgGUID: cZOCraYeTuW4JbXPCKZZTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="76343955"
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; 
   d="scan'208";a="76343955"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 07:54:54 -0800
X-CSE-ConnectionGUID: 9CQtLE12Rja5b/SwPKnC+g==
X-CSE-MsgGUID: dbkJ0sNaRkWA4L+dD2eDpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; 
   d="scan'208";a="212312601"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.109.212]) ([10.125.109.212])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 07:54:51 -0800
Message-ID: <d2f6eb24-e320-4a90-9af3-dd637fa5ab7b@intel.com>
Date: Wed, 18 Feb 2026 08:54:50 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/9] dax/cxl, hmem: Initialize hmem early and defer
 dax_cxl binding
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-pm@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nathan Fontenot <nathan.fontenot@amd.com>,
 Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
 Benjamin Cheatham <benjamin.cheatham@amd.com>,
 Zhijian Li <lizhijian@fujitsu.com>, Borislav Petkov <bp@alien8.de>,
 Tomasz Wolski <tomasz.wolski@fujitsu.com>
References: <20260210064501.157591-1-Smita.KoralahalliChannabasappa@amd.com>
 <20260210064501.157591-5-Smita.KoralahalliChannabasappa@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260210064501.157591-5-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77589-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,huawei.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.jiang@intel.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:email,amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B4813157832
X-Rspamd-Action: no action



On 2/9/26 11:44 PM, Smita Koralahalli wrote:
> From: Dan Williams <dan.j.williams@intel.com>
> 
> Move hmem/ earlier in the dax Makefile so that hmem_init() runs before
> dax_cxl.
> 
> In addition, defer registration of the dax_cxl driver to a workqueue
> instead of using module_cxl_driver(). This ensures that dax_hmem has
> an opportunity to initialize and register its deferred callback and make
> ownership decisions before dax_cxl begins probing and claiming Soft
> Reserved ranges.
> 
> Mark the dax_cxl driver as PROBE_PREFER_ASYNCHRONOUS so its probe runs
> out of line from other synchronous probing avoiding ordering
> dependencies while coordinating ownership decisions with dax_hmem.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/dax/Makefile |  3 +--
>  drivers/dax/cxl.c    | 27 ++++++++++++++++++++++++++-
>  2 files changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dax/Makefile b/drivers/dax/Makefile
> index 5ed5c39857c8..70e996bf1526 100644
> --- a/drivers/dax/Makefile
> +++ b/drivers/dax/Makefile
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> +obj-y += hmem/
>  obj-$(CONFIG_DAX) += dax.o
>  obj-$(CONFIG_DEV_DAX) += device_dax.o
>  obj-$(CONFIG_DEV_DAX_KMEM) += kmem.o
> @@ -10,5 +11,3 @@ dax-y += bus.o
>  device_dax-y := device.o
>  dax_pmem-y := pmem.o
>  dax_cxl-y := cxl.o
> -
> -obj-y += hmem/
> diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
> index 13cd94d32ff7..a2136adfa186 100644
> --- a/drivers/dax/cxl.c
> +++ b/drivers/dax/cxl.c
> @@ -38,10 +38,35 @@ static struct cxl_driver cxl_dax_region_driver = {
>  	.id = CXL_DEVICE_DAX_REGION,
>  	.drv = {
>  		.suppress_bind_attrs = true,
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>  	},
>  };
>  
> -module_cxl_driver(cxl_dax_region_driver);
> +static void cxl_dax_region_driver_register(struct work_struct *work)
> +{
> +	cxl_driver_register(&cxl_dax_region_driver);
> +}
> +
> +static DECLARE_WORK(cxl_dax_region_driver_work, cxl_dax_region_driver_register);
> +
> +static int __init cxl_dax_region_init(void)
> +{
> +	/*
> +	 * Need to resolve a race with dax_hmem wanting to drive regions
> +	 * instead of CXL
> +	 */
> +	queue_work(system_long_wq, &cxl_dax_region_driver_work);
> +	return 0;
> +}
> +module_init(cxl_dax_region_init);
> +
> +static void __exit cxl_dax_region_exit(void)
> +{
> +	flush_work(&cxl_dax_region_driver_work);
> +	cxl_driver_unregister(&cxl_dax_region_driver);
> +}
> +module_exit(cxl_dax_region_exit);
> +
>  MODULE_ALIAS_CXL(CXL_DEVICE_DAX_REGION);
>  MODULE_DESCRIPTION("CXL DAX: direct access to CXL regions");
>  MODULE_LICENSE("GPL");


