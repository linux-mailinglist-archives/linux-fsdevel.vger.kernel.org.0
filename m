Return-Path: <linux-fsdevel+bounces-9542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8752C8427C0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 16:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8D29B285E2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 15:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D38F823A7;
	Tue, 30 Jan 2024 15:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Y9S9PIym"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09B27A73C;
	Tue, 30 Jan 2024 15:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706627691; cv=none; b=GfV3K0ODvcz8MOiRViuhk+XHFnZ/vscuDbEKTVRTUJkjIIJQ4zHO85V00uk4jH8n50lh0Ngd1WimwiSzyQEExLpyjfTPrFTbAlJrGxtEjQWe/tAe6WonVd+NIwbo487aJtjIicZ4fHidCLqzfBcxdPGzEA+B0tb7ru/qKnRUVQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706627691; c=relaxed/simple;
	bh=h5FQ47qXuTnmiZi7uPNXxphsw2Z8nkL44QsJTo8DKRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IGxwmnImeFblo3j99SG8glcCxBgrL+YnGy03+yFPVfOS7LULs1I9Oot5bCFqmJ3pUv9qU8t062/xGy7+T+2+6jO86IBZ20aitpxxuoEU/i0mXfD7qBu7wQbQugWq/lXJ/su450L3f1Q6Zd7qnq5uO1LgdbWB8LW16ANSPF0kBOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Y9S9PIym; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1706627688;
	bh=h5FQ47qXuTnmiZi7uPNXxphsw2Z8nkL44QsJTo8DKRI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Y9S9PIymVF4suOMYwobbgiBkRbKBBpk+lSnLQgDi5x0UZQnEHvkB2GbNcpIsxHIl9
	 zt4Ov/FW+piBKUXcQsoIw1lRpiOvLwI3Srw9Iy6vOf+6/5Oc4fb+oNjV1FcCO//FNH
	 SiBzGEkDMAIX5xX1HV4RVe9HVq+ecKqbxt8MG03uhxg7sjyA7FTVxrDkdqL81qSJcB
	 3cDn/r7Y+FYLN8CLkAJ3X69mcH32qOpZwineik64Gbgyb3NBIAA7njWqW3bxsB23Hz
	 swS2z0WS2yz6PmT55k/kMJ8SBqkjnlxd38S6u0LS2R/uAD5DKpeZdGh7+BR12WcCV4
	 Nsu4VHJnlGPVQ==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TPTHD1wnPzVgJ;
	Tue, 30 Jan 2024 10:14:48 -0500 (EST)
Message-ID: <f84c48ec-2963-4754-9b6a-8eb0c473d7d0@efficios.com>
Date: Tue, 30 Jan 2024 10:14:48 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/7] Introduce cache_is_aliasing() to fix DAX
 regression
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
 linux-arch@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
 Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
References: <20240129210631.193493-1-mathieu.desnoyers@efficios.com>
 <65b8173160ec8_59028294b3@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <65b8173160ec8_59028294b3@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-01-29 16:22, Dan Williams wrote:
> Mathieu Desnoyers wrote:
>> This commit introduced in v5.13 prevents building FS_DAX on 32-bit ARM,
>> even on ARMv7 which does not have virtually aliased dcaches:
>>
>> commit d92576f1167c ("dax: does not work correctly with virtual aliasing caches")
>>
>> It used to work fine before: I have customers using dax over pmem on
>> ARMv7, but this regression will likely prevent them from upgrading their
>> kernel.
>>
>> The root of the issue here is the fact that DAX was never designed to
>> handle virtually aliased dcache (VIVT and VIPT with aliased dcache). It
>> touches the pages through their linear mapping, which is not consistent
>> with the userspace mappings on virtually aliased dcaches.
>>
>> This patch series introduces cache_is_aliasing() with new Kconfig
>> options:
>>
>>    * ARCH_HAS_CACHE_ALIASING
>>    * ARCH_HAS_CACHE_ALIASING_DYNAMIC
>>
>> and implements it for all architectures. The "DYNAMIC" implementation
>> implements cache_is_aliasing() as a runtime check, which is what is
>> needed on architectures like 32-bit ARMV6 and ARMV6K.
>>
>> With this we can basically narrow down the list of architectures which
>> are unsupported by DAX to those which are really affected.
>>
>> Feedback is welcome,
> 
> Hi Mathieu, this looks good overall, just some quibbling about the
> ordering.

Thanks for having a look !

> 
> I would introduce dax_is_supported() with the current overly broad
> interpretation of "!(ARM || MIPS || SPARC)" using IS_ENABLED(), then
> fixup the filesystems to use the new helper, and finally go back and
> convert dax_is_supported() to use cache_is_aliasing() internally.

Will do.

> 
> Separately, it is not clear to me why ARCH_HAS_CACHE_ALIASING_DYNAMIC
> needs to exist. As long as all paths that care are calling
> cache_is_aliasing() then whether it is dynamic or not is something only
> the compiler cares about. If those dynamic archs do not want to pay the
> .text size increase they can always do CONFIG_FS_DAX=n, right?

Good point. It will help reduce complexity and improve test coverage.

I also intend to rename "cache_is_aliasing()" to "dcache_is_aliasing()",
so if we introduce an "icache_is_aliasing()" in the future, it won't be
confusing. Having aliasing icache-dcache but not dcache-dcache seems to
be fairly common.

So basically:

If an arch selects ARCH_HAS_CACHE_ALIASING, it implements
dcache_is_aliasing() (for now), and eventually we can implement
icache_is_aliasing() as well.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


