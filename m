Return-Path: <linux-fsdevel+bounces-13918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9828757C5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 20:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1FA9B25717
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 19:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2040C137C52;
	Thu,  7 Mar 2024 19:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f3WrWocD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C35512DDB6;
	Thu,  7 Mar 2024 19:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709841557; cv=none; b=RzzNJ4ziSd3TND7sBxkvxCecHfzLqr1PJwJAIg4YcrcC4sxNY7IQgKbamJ61UI1F/3qziEKSkyh91y2hUHYUmUTFSYu/ktvXk24JQyVYkODyZKCli9M2FBvB9Ba3fckcdRpWBP8O3+xCrCyYBlSWUbKHGzsyypB8IrDMkCRLceQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709841557; c=relaxed/simple;
	bh=eH7ts0q5onZGbRT1w1B9IvPr7bH0ysYwVmxguJ8VLyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AIfnk2ezrTX/jOYQ1dH83HvGL7Yc/c2ZtErIdSx1tyi4tsEmKY4E/b/W5nNEE9WuJJykLfZ7UKYX0A3s1G2CbC/Y1FmsVR0Qql8ZUplgoQWCqFH+MQqXE0LNkT7zTAYeFrVEqZ4OpMXePD5PQDxPkSh6AGS/9EI3bdZGiONlYIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=f3WrWocD; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=KVaCyMJy+vYOeUyoSR5Mk9pa+MCPgO2uUL4D5SXL/4U=; b=f3WrWocD0YgDteVxzjrU8D0SOL
	i6nsddeuB7BsTF/6Bk57YSNGFwHs5xN7nLFK/8A0vEldbFtlRrqHlHBwZXKMbZ/V+lRULmFaGKkP2
	KmcmYY8ln1CsCtQzN+HNZBkzqQPvRHsl85eew0Cw+l1z7z8R+S0q+3mlnKAIzYdGPXeatqeje8nqo
	qqxpITt1bjw+UbEfM/hpcJ0+04WQ+YwWc0ItpZUX31hvtv3ihrmMw8UhN2jOiHLs/2uCP9xQpbGGV
	S31FHRUrFmwa1Qfe20oJaHcxYNP0lu42D9hN2gPZQGm4p5MY87QkeTQhqi1x2geuN6lbb+dW5nC9v
	APJHYROA==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riJtE-00000006Axx-2mZO;
	Thu, 07 Mar 2024 19:58:52 +0000
Message-ID: <299be3c9-4cf4-47ce-b53a-c9789af4f5ca@infradead.org>
Date: Thu, 7 Mar 2024 11:58:49 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 37/37] memprofiling: Documentation
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com,
 vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev,
 mgorman@suse.de, dave@stgolabs.net, willy@infradead.org,
 liam.howlett@oracle.com, penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net,
 void@manifault.com, peterz@infradead.org, juri.lelli@redhat.com,
 catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de, tglx@linutronix.de,
 mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
 peterx@redhat.com, david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org,
 masahiroy@kernel.org, nathan@kernel.org, dennis@kernel.org,
 jhubbard@nvidia.com, tj@kernel.org, muchun.song@linux.dev, rppt@kernel.org,
 paulmck@kernel.org, pasha.tatashin@soleen.com, yosryahmed@google.com,
 yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
 andreyknvl@gmail.com, keescook@chromium.org, ndesaulniers@google.com,
 vvvvvv@google.com, gregkh@linuxfoundation.org, ebiggers@google.com,
 ytcoode@gmail.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
 vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
 iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
 elver@google.com, dvyukov@google.com, shakeelb@google.com,
 songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com,
 rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
 kernel-team@android.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-modules@vger.kernel.org,
 kasan-dev@googlegroups.com, cgroups@vger.kernel.org
References: <20240306182440.2003814-1-surenb@google.com>
 <20240306182440.2003814-38-surenb@google.com>
 <10a95079-86e4-41bf-8e82-e387936c437d@infradead.org>
 <CAJuCfpFN3BLsFOWB0huA==LVa2pNYdnf7bT_VXgDtPuJOxvWSQ@mail.gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAJuCfpFN3BLsFOWB0huA==LVa2pNYdnf7bT_VXgDtPuJOxvWSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/7/24 08:51, Suren Baghdasaryan wrote:
> On Thu, Mar 7, 2024 at 3:19 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> Hi,
>> This includes some editing suggestions and some doc build fixes.
>>
>>

[snip]

>>
>>
>> Finally, there are a number of documentation build warnings in this patch.
>> I'm no ReST expert, but the attached patch fixes them for me.
> 
> Thanks Randy! I'll use your cleaned-up patch in the next submission.
> Cheers,
> Suren.

Hi Suren,

The patch did not include the grammar/punctuation changes, only the
doc build changes.

I can make a more complete patch if you like.

thanks.
-- 
#Randy

