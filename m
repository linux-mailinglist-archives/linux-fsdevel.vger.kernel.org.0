Return-Path: <linux-fsdevel+bounces-50543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42556ACD05D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 01:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26D5918953F1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 23:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B80C253931;
	Tue,  3 Jun 2025 23:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jjwb9hcc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70628494;
	Tue,  3 Jun 2025 23:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748994366; cv=none; b=Rn7m/PsO1qidz65SeiVyTIeW3xbCiVmH8hWwTxFmi4Cf4NERagkG3mS/xf8gQt88Ixxb+W/2aDR/RaK86OkIiKDk9sEoPaogiEUbl6Xm/GpxKBi7vlcGiWKc73dxKCjSNfCVGLBB8zhuBzXy7l9P9rXenxQK4xatGxEUbvFV85I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748994366; c=relaxed/simple;
	bh=hWWpMUvDb6toLCS0hdHRob1Q0A+Js+9lzm2MfMkdnK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jyUFH2ZPRrjO8r++/gzvhhRqlx0j/UpxQvqBFgK2IwtHEGLUML0Sgi28Dpsc+nz72AMxEHsv2B1RKototfb3XGa0XGgMNnQSI6zZfAn3XmsSXE6DuJmydhTx5JaOfTf3jof7XjAbzc1kBnSB8hmbMx9W/CLyAf6fXkIR93sLhis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jjwb9hcc; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748994364; x=1780530364;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hWWpMUvDb6toLCS0hdHRob1Q0A+Js+9lzm2MfMkdnK4=;
  b=Jjwb9hccybRjJR2Alawxj0QMKeVFgKRuWjYZQ1w48XqNKLDJqKcGWT1f
   9nEzQ4ZzeLMuwFtTgkshdVY5IM7jgVvGN/V6HUyF886ujsZz63w+D+vCj
   fs9mbkVwRvC/pEP5iG74tu3v0vI1aLYmqMYTq878/aYLq1Blp3spCs6kA
   /KZ4TfirpT/71TTQ19J65+aPNxLf1yoX0AmKNORQKXRWhOYyhNTqsXdFk
   HU9sqdieb67m3jWkbSgNjwSZURcZM6OSKHK8MYti6zvJzHweUwM6CHTFU
   9ku8dqXQNo4LIq2sdb8Xlc29jUaB/pkKPyoFwy0FLbt5kRPFWuHW+sclg
   g==;
X-CSE-ConnectionGUID: c2gr3eAEQH+c7dq5xhIQuA==
X-CSE-MsgGUID: udVRmbfIS62ABNQlk91WSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="54846570"
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="54846570"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 16:46:03 -0700
X-CSE-ConnectionGUID: MLAtfLerR4SDyGyLL661vw==
X-CSE-MsgGUID: gaYgkeulTGSxHFyWpRQaMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="144894636"
Received: from iherna2-mobl4.amr.corp.intel.com (HELO [10.125.110.198]) ([10.125.110.198])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 16:46:01 -0700
Message-ID: <d9435456-9ae8-4fbe-a67b-e557e2787b0c@intel.com>
Date: Tue, 3 Jun 2025 16:45:58 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] cxl/acpi: Add background worker to wait for
 cxl_pci and cxl_mem probe
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
 <20250603221949.53272-5-Smita.KoralahalliChannabasappa@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250603221949.53272-5-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/3/25 3:19 PM, Smita Koralahalli wrote:
> Introduce a waitqueue mechanism to coordinate initialization between the
> cxl_pci and cxl_mem drivers.
> 
> Launch a background worker from cxl_acpi_probe() that waits for both
> drivers to complete initialization before invoking wait_for_device_probe().
> Without this, the probe completion wait could begin prematurely, before
> the drivers are present, leading to missed updates.
> 
> Co-developed-by: Nathan Fontenot <Nathan.Fontenot@amd.com>
> Signed-off-by: Nathan Fontenot <Nathan.Fontenot@amd.com>
> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
>  drivers/cxl/acpi.c         | 23 +++++++++++++++++++++++
>  drivers/cxl/core/suspend.c | 21 +++++++++++++++++++++
>  drivers/cxl/cxl.h          |  2 ++
>  3 files changed, 46 insertions(+)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index cb14829bb9be..978f63b32b41 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -813,6 +813,24 @@ static int pair_cxl_resource(struct device *dev, void *data)
>  	return 0;
>  }
>  
> +static void cxl_softreserv_mem_work_fn(struct work_struct *work)
> +{
> +	/* Wait for cxl_pci and cxl_mem drivers to load */
> +	cxl_wait_for_pci_mem();
> +
> +	/*
> +	 * Wait for the driver probe routines to complete after cxl_pci
> +	 * and cxl_mem drivers are loaded.
> +	 */
> +	wait_for_device_probe();
> +}
> +static DECLARE_WORK(cxl_sr_work, cxl_softreserv_mem_work_fn);
> +
> +static void cxl_softreserv_mem_update(void)
> +{
> +	schedule_work(&cxl_sr_work);
> +}
> +
>  static int cxl_acpi_probe(struct platform_device *pdev)
>  {
>  	int rc;
> @@ -887,6 +905,10 @@ static int cxl_acpi_probe(struct platform_device *pdev)
>  
>  	/* In case PCI is scanned before ACPI re-trigger memdev attach */
>  	cxl_bus_rescan();
> +
> +	/* Update SOFT RESERVE resources that intersect with CXL regions */
> +	cxl_softreserv_mem_update();
> +
>  	return 0;
>  }
>  
> @@ -918,6 +940,7 @@ static int __init cxl_acpi_init(void)
>  
>  static void __exit cxl_acpi_exit(void)
>  {
> +	cancel_work_sync(&cxl_sr_work);
>  	platform_driver_unregister(&cxl_acpi_driver);
>  	cxl_bus_drain();
>  }
> diff --git a/drivers/cxl/core/suspend.c b/drivers/cxl/core/suspend.c
> index 72818a2c8ec8..c0d8f70aed56 100644
> --- a/drivers/cxl/core/suspend.c
> +++ b/drivers/cxl/core/suspend.c
> @@ -2,12 +2,15 @@
>  /* Copyright(c) 2022 Intel Corporation. All rights reserved. */
>  #include <linux/atomic.h>
>  #include <linux/export.h>
> +#include <linux/wait.h>
>  #include "cxlmem.h"
>  #include "cxlpci.h"
>  
>  static atomic_t mem_active;
>  static atomic_t pci_loaded;
>  
> +static DECLARE_WAIT_QUEUE_HEAD(cxl_wait_queue);
> +
>  bool cxl_mem_active(void)
>  {
>  	if (IS_ENABLED(CONFIG_CXL_MEM))
> @@ -19,6 +22,7 @@ bool cxl_mem_active(void)
>  void cxl_mem_active_inc(void)
>  {
>  	atomic_inc(&mem_active);
> +	wake_up(&cxl_wait_queue);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_mem_active_inc, "CXL");
>  
> @@ -28,8 +32,25 @@ void cxl_mem_active_dec(void)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_mem_active_dec, "CXL");
>  
> +static bool cxl_pci_loaded(void)
> +{
> +	if (IS_ENABLED(CONFIG_CXL_PCI))
> +		return atomic_read(&pci_loaded) != 0;
> +
> +	return false;
> +}
> +
>  void mark_cxl_pci_loaded(void)
>  {
>  	atomic_inc(&pci_loaded);
> +	wake_up(&cxl_wait_queue);
>  }
>  EXPORT_SYMBOL_NS_GPL(mark_cxl_pci_loaded, "CXL");
> +
> +void cxl_wait_for_pci_mem(void)
> +{
> +	if (!wait_event_timeout(cxl_wait_queue, cxl_pci_loaded() &&
> +				cxl_mem_active(), 30 * HZ))

I'm trying to understand why cxl_pci_loaded() is needed. cxl_mem_active() goes above 0 when a cxl_mem_probe() instance succeeds. cxl_mem_probe() being triggered implies that an instance of cxl_pci_probe() has been called since cxl_mem_probe() is triggered from devm_cxl_add_memdev() with memdev being added and cxl_mem driver also have been loaded. So does cxl_mem_active() not imply cxl_pci_loaded() and makes it unnecessary?

DJ


> +		pr_debug("Timeout waiting for cxl_pci or cxl_mem probing\n");
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_wait_for_pci_mem, "CXL");
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index a9ab46eb0610..1ba7d39c2991 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -902,6 +902,8 @@ void cxl_coordinates_combine(struct access_coordinate *out,
>  
>  bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
>  
> +void cxl_wait_for_pci_mem(void);
> +
>  /*
>   * Unit test builds overrides this to __weak, find the 'strong' version
>   * of these symbols in tools/testing/cxl/.


