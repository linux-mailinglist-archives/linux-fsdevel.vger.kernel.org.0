Return-Path: <linux-fsdevel+bounces-1889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0875C7DFC06
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 22:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D3B9B2136D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 21:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5F821A0F;
	Thu,  2 Nov 2023 21:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OgdoxEn5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50892219FA
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 21:34:06 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196881A5
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 14:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698960841; x=1730496841;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FGivpmstxb2Loz/XELLXHiCGGRE7wuRdfw0kP/d7Ct8=;
  b=OgdoxEn5hWMsOlm1D+Y1Jw/Pl1v11sAt2lUS/yre4OUAIo2jQ/XP4XQx
   urfELwKhIlmZarDHIaps4yEprOXZM5p/4bkAIP0EbjzkFfgp1dJu+7cVp
   abJrQosZ0RgDeHWVXlSN1k/EDiDFkli7RjoxPxTcObq5xyZimINeUSkfI
   7K1//fu5FcBG8VB5R+zrbcTmumkE31ziFckn6R2WScLdzq99yO6JhD9i/
   qOhkg2GfLqIOi6UwSr++xBrfci8uK1gqTMy5302CpU2LbdzdbbXZhoTzc
   /3QKHoPbBCLFUBLgqpi8hE6eKJDDZtepVMns3f1+v77JdTZtbCSEJ3XVn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="419928116"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="419928116"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 14:33:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="737890958"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="737890958"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga006.jf.intel.com with ESMTP; 02 Nov 2023 14:33:45 -0700
Received: from [10.249.131.152] (mwajdecz-MOBL.ger.corp.intel.com [10.249.131.152])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 0EF6F42B3B;
	Thu,  2 Nov 2023 21:33:43 +0000 (GMT)
Message-ID: <d5cf5159-a629-4df9-8629-30044090686d@intel.com>
Date: Thu, 2 Nov 2023 22:33:43 +0100
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
 <f6cd1d42-b901-40a9-9da6-004aaebfc4b9@intel.com>
 <ZUQOGl/IQ3MHOkCr@casper.infradead.org>
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
In-Reply-To: <ZUQOGl/IQ3MHOkCr@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 02.11.2023 22:01, Matthew Wilcox wrote:
> On Thu, Nov 02, 2023 at 09:58:07PM +0100, Michal Wajdeczko wrote:
>>> Why would using kunit be superior to the existing test suite?
>>
>> As said above IMO it's just a nice tool, that seems to be already used
>> around.  If you look for examples where kunit could win over existing
>> ida test suite, then maybe that kunit allows to run only specific test
>> cases or parametrize test cases or provide ready to use nicer diagnostic
>> messages on missed expectations.  It should also be easy (and can be
>> done in unified way) to replace some external functions to trigger
>> desired faults (like altering kzalloc() or xas_store() to force
>> different code paths during our alloc).
>>
>> But since I'm a guest here, knowing that there could be different
>> opinions on competing test suites, we can either drop this patch or
>> convert new test cases with 'group' variants to the old test_ida suite
>> (if that's really desired).
> 
> AFAIK, kunit can't be used to extract the in-kernel IDA code and run it
> in userspace like the current testsuite does (the current testsuite also
> runs in-kernel, except for the multithreaded tests).  So unless it has
> that functionality, it seems like a regression to convert the existing
> test-suite to kunit.

But there is no need extract anything as kunit tests run in kernel space
(or under QEMU/UML for convenience) so can access all in-kernel API.

[1] https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html

