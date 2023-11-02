Return-Path: <linux-fsdevel+bounces-1877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CC77DFAA6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 20:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F1EF1C20DE7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 19:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA7F21353;
	Thu,  2 Nov 2023 19:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cY1YTy37"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38971BDF0
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 19:06:23 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA41D51
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 12:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698951952; x=1730487952;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RDNnmlsti8vpMnUnL0mWcjibbSZIoRXjuRkNEC4SyVY=;
  b=cY1YTy37uXhp55izokV0KemUu31EeP5VcyMTAFv7g2tgLGV/EFRqURDP
   nc/tpZTuvt5teokoub+1SCd2NFgQLDowFzWXqDN/ZfXL6ZEz7acwEgFJl
   CUC3fB0Tv/B2Nl9a1lxZqaEiV+/8VxP891E0lcDGfQK1Fm9AqgBMjnsAk
   RKjJo+uBzqGzwFIVd8l1UsomeEu7NXAj0bkgJxzFBjP4tbK0XqVagpg9z
   sBSVq0UaSxZQawQkJ1Zm5Xuez+JdlVu+/70vGKF7jy+CnSfTxUjW7PI0x
   RbX5MPiDQyY9DbGneWyQIo93ggf82+uKotAK4DsGost7y+UPGDig9O5HJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="388609155"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="388609155"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 12:05:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="761366564"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="761366564"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga002.jf.intel.com with ESMTP; 02 Nov 2023 12:05:50 -0700
Received: from [10.249.131.152] (mwajdecz-MOBL.ger.corp.intel.com [10.249.131.152])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 2D71039C92;
	Thu,  2 Nov 2023 19:05:49 +0000 (GMT)
Message-ID: <56aa6550-858f-4152-92e3-2c5273eb3e96@intel.com>
Date: Thu, 2 Nov 2023 20:05:48 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ida: Introduce ida_weight()
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org
References: <20231102153455.1252-1-michal.wajdeczko@intel.com>
 <20231102153455.1252-2-michal.wajdeczko@intel.com>
 <ZUPgaAN71ERvQ5/F@casper.infradead.org>
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
In-Reply-To: <ZUPgaAN71ERvQ5/F@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 02.11.2023 18:46, Matthew Wilcox wrote:
> On Thu, Nov 02, 2023 at 04:34:53PM +0100, Michal Wajdeczko wrote:
>> Add helper function that will calculate number of allocated IDs
>> in the IDA.  This might be helpful both for drivers to estimate
>> saturation of used IDs and for testing the IDA implementation.
> 
> Since you take & release the lock, the value is already somewhat racy.
> So why use the lock at all?  Wouldn't the RCU read lock be a better
> approach?

I just followed pattern from ida_destroy() above.
But rcu_read_lock() might be sufficient I guess.

> 
> Also, does it make sense to specify it over a particular range rather
> than over the whole IDA?

But then implementation wont look that nice and easy ;)
Anyway, I assume that this can be extended in the future if desired.

