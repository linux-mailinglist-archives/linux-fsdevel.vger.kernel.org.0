Return-Path: <linux-fsdevel+bounces-1876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DC17DFA79
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 19:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CE2DB21301
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 18:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6312F21347;
	Thu,  2 Nov 2023 18:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lQNCK41L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79071DDD6
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 18:58:25 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17AFF12D
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 11:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698951501; x=1730487501;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=S1EJNjbcruDU81My+BDll3mM3wOvqhD4Wrg+6R/BDTw=;
  b=lQNCK41Le+HvpHh8fx/XGioaDoLYhK85dE1kqcgvLBqM8ZVs0WppY9kh
   Aeb6K6V5xGMfYK3cV4RUl05aapLZLlczji3F6wqJsM4hHpES+f5e53j8W
   pEH6nzKPRloNR4oacVQvGuU21qUSmmhhbETHixsO06pXpyyha0xhwy8nC
   q2Nr6C9DEAk2k1HetG8hEepDyUO/2kBPYrQz5E9txL7aAw6aRrDqh9aNI
   mfVVm6ol8xeEAMLxANkZeS4NyZJrU07b9A/S/K8ZRQKyZgDaPn3WkZ/bQ
   Omccsal9kCOhtGyWivrduioTDG4qlWvkq4KOsPDCC84VPgcRvs3DZkWm6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="455273112"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="455273112"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 11:58:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="765018568"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="765018568"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga007.fm.intel.com with ESMTP; 02 Nov 2023 11:58:18 -0700
Received: from [10.249.131.152] (mwajdecz-MOBL.ger.corp.intel.com [10.249.131.152])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id ECE1A340D8;
	Thu,  2 Nov 2023 18:58:16 +0000 (GMT)
Message-ID: <e7637a99-ca4f-460a-8ee5-9583790be567@intel.com>
Date: Thu, 2 Nov 2023 19:58:16 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ida: Add kunit based tests for new IDA functions
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org
References: <20231102153455.1252-1-michal.wajdeczko@intel.com>
 <20231102153455.1252-4-michal.wajdeczko@intel.com>
 <ZUPfzKMIToSe+X5q@casper.infradead.org>
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
In-Reply-To: <ZUPfzKMIToSe+X5q@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 02.11.2023 18:43, Matthew Wilcox wrote:
> On Thu, Nov 02, 2023 at 04:34:55PM +0100, Michal Wajdeczko wrote:
>> New functionality of the IDA (contiguous IDs allocations) requires
>> some validation coverage.  Add KUnit tests for simple scenarios:
>>  - counting single ID at different locations
>>  - counting different sets of IDs
>>  - ID allocation start at requested position
>>  - different contiguous ID allocations are supported
>>
>> More advanced tests for subtle corner cases may come later.
> 
> Why are you using kunit instead of extending the existing test-cases?

I just assumed (maybe wrong) that kunit is preferred these days as some
other components are even converting their existing test code to kunit.

But also I might be biased as I was working recently with kunit and just
found it helpful in fast test development.  Note that to run these new
IDA tests, anyone who cares just need a single command line:

$ ./tools/testing/kunit/kunit.py run "ida.*"

But if you feel that having two places with IDA tests is wrong, we can
still convert old tests to kunit (either as follow up or prerequisite)
to this patch (well, already did that locally when started working on
these improvements)

