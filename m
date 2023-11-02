Return-Path: <linux-fsdevel+bounces-1885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E317DFBC2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 21:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A44D4281D9E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 20:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B4E2030A;
	Thu,  2 Nov 2023 20:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D+USQ1aE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92301D680
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 20:58:15 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85EA188
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 13:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698958690; x=1730494690;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1C/AQSnEuuI6cyEqVns76JG4T3RYmDTRULz5rYjgx1A=;
  b=D+USQ1aEbgKJ9xfA2ANHyCAlfI0tTbS6vm6NGg/b4Rv2gYhl2gw/Uy/m
   zXwBZkrB62qVJ1wkXWSPDQpLDZXb2GuA4sJZVCZLXYP4/of37gJSHfdrf
   PNdXUkABlJc8qgMoFYxGdxcJGhqUQ4mhmtwcsVldgKjKltb6eGuDKuh46
   dIhVEsYeQpFLXNO6J4OPNhPHZrfBNx7WDVQx2ulcpWEibF0SHF95aeMTD
   HQAm6GNsHD5iNGRRlWlUY01THeC0AwG4zVvwpl66bLleKJIem8jVqhNzV
   ocRPF2AElvUpv+QA4pC6a/NxbnaUiY3/5BNSv2CkH1riOKvRH5OZlSqcL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="368163371"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="368163371"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 13:58:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="9140321"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa001.jf.intel.com with ESMTP; 02 Nov 2023 13:58:09 -0700
Received: from [10.249.131.152] (mwajdecz-MOBL.ger.corp.intel.com [10.249.131.152])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id B8B9042B3D;
	Thu,  2 Nov 2023 20:58:07 +0000 (GMT)
Message-ID: <f6cd1d42-b901-40a9-9da6-004aaebfc4b9@intel.com>
Date: Thu, 2 Nov 2023 21:58:07 +0100
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
 <e7637a99-ca4f-460a-8ee5-9583790be567@intel.com>
 <ZUP0mbMqtCaQIQGX@casper.infradead.org>
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
In-Reply-To: <ZUP0mbMqtCaQIQGX@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 02.11.2023 20:12, Matthew Wilcox wrote:
> On Thu, Nov 02, 2023 at 07:58:16PM +0100, Michal Wajdeczko wrote:
>> On 02.11.2023 18:43, Matthew Wilcox wrote:
>>> On Thu, Nov 02, 2023 at 04:34:55PM +0100, Michal Wajdeczko wrote:
>>>> New functionality of the IDA (contiguous IDs allocations) requires
>>>> some validation coverage.  Add KUnit tests for simple scenarios:
>>>>  - counting single ID at different locations
>>>>  - counting different sets of IDs
>>>>  - ID allocation start at requested position
>>>>  - different contiguous ID allocations are supported
>>>>
>>>> More advanced tests for subtle corner cases may come later.
>>>
>>> Why are you using kunit instead of extending the existing test-cases?
>>
>> I just assumed (maybe wrong) that kunit is preferred these days as some
>> other components are even converting their existing test code to kunit.
>>
>> But also I might be biased as I was working recently with kunit and just
>> found it helpful in fast test development.  Note that to run these new
>> IDA tests, anyone who cares just need a single command line:
>>
>> $ ./tools/testing/kunit/kunit.py run "ida.*"
>>
>> But if you feel that having two places with IDA tests is wrong, we can
>> still convert old tests to kunit (either as follow up or prerequisite)
>> to this patch (well, already did that locally when started working on
>> these improvements)
> 
> Why would using kunit be superior to the existing test suite?

As said above IMO it's just a nice tool, that seems to be already used
around.  If you look for examples where kunit could win over existing
ida test suite, then maybe that kunit allows to run only specific test
cases or parametrize test cases or provide ready to use nicer diagnostic
messages on missed expectations.  It should also be easy (and can be
done in unified way) to replace some external functions to trigger
desired faults (like altering kzalloc() or xas_store() to force
different code paths during our alloc).

But since I'm a guest here, knowing that there could be different
opinions on competing test suites, we can either drop this patch or
convert new test cases with 'group' variants to the old test_ida suite
(if that's really desired).

