Return-Path: <linux-fsdevel+bounces-13928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1116B8758DE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 21:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42B461C213A5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 20:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC43E13A865;
	Thu,  7 Mar 2024 20:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TOvuaa/3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA2241C60;
	Thu,  7 Mar 2024 20:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709844814; cv=none; b=SbthuC0hIbJk5ULBMM73nHqznkMageQiKXSgNG8B8we7RiUiJyyzqhu+zTmlQdl91/mCCmWAcOe0ck+vMPyPUGe7AFE+Y3DXD7ZUel3GNya5wUUXoAWdkZsvLw04WevsOHylRP/7N54c1gIFnqIpJX0xL8MNJB8/YXpyt5shmh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709844814; c=relaxed/simple;
	bh=zg0CO3XEyVe8+ghF9U9lAFrlk+J130/oBgEnLCNFpxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UMod/kNMMLh6EsPAzXly5odvvb2UQGA9+ucjiYucD+Bdb/kVIJSzQhF9AXx67L9jzFHK8xM+WoDQZs5uHKcM88ajEvUZjgt6n0UMfcRypr5tHLNY4yxawAHk55i8t9RkKsb2sV2ZJFnsTLIYYHIaz79xt82AJ7YkoDzGERiApew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TOvuaa/3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=p08jq4TIBI4zazg51JnXnjGH5Lu+du6lZuf9B2Rz4QQ=; b=TOvuaa/3wlEt4HaASAp9xkKucG
	+PY7MI+cX1hSmkmfFLvtR4JkMMdWfcVn8YtHQDGiMS3PJt7AA09NmwT0+GjU4w7EvTcYU989bq3lA
	Sh6H3anq6UeJdG7s5+p9HZ3DirzhzdP4JpB9MphGl6IsZAH4dOfsdtbzZJkSRJLswWFYPpauuyfXA
	Sfzyecd0rAcXOKsin/ZW2uEow+r/lYb/9BCfKH8o5Krry/ndFvOqVqSjHrnsABA9QpX6LO/lLNPn5
	mwcOKE/wR1613yI+3HUvjJwhhHwu/dOn5jZGJybhQAfPSWpxxpf3MHsWmV/YP2TEMLCSl1X1YJmQp
	aZy2ZdFg==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riKjl-00000006Lv6-1biU;
	Thu, 07 Mar 2024 20:53:09 +0000
Message-ID: <25a03dba-8d6b-4072-beae-7ea477fccbcb@infradead.org>
Date: Thu, 7 Mar 2024 12:53:06 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 37/37] memprofiling: Documentation
Content-Language: en-US
To: John Hubbard <jhubbard@nvidia.com>,
 Kent Overstreet <kent.overstreet@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
 mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org,
 roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net,
 willy@infradead.org, liam.howlett@oracle.com,
 penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com,
 peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com,
 will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com,
 david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
 nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev,
 rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com,
 yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com,
 hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org,
 ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org,
 ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
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
 <hsyclfp3ketwzkebjjrucpb56gmalixdgl6uld3oym3rvssyar@fmjlbpdkrczv>
 <f12e83ef-5881-4df8-87ae-86f8ca5a6ab4@infradead.org>
 <72bbe76c-fcf9-47c2-b583-63d5ad77b3c3@nvidia.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <72bbe76c-fcf9-47c2-b583-63d5ad77b3c3@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/7/24 12:15, John Hubbard wrote:
> On 3/7/24 12:03, Randy Dunlap wrote:
>> On 3/7/24 10:17, Kent Overstreet wrote:
>>> On Wed, Mar 06, 2024 at 07:18:57PM -0800, Randy Dunlap wrote:
> ...
>>>>> +- i.e. iterating over them to print them in debugfs/procfs.
>>>>
>>>>    i.e., iterating
>>>
>>> i.e. latin id est, that is: grammatically my version is fine
>>>
>>
>> Some of my web search hits say that a comma is required after "i.e.".
>> At least one of them says that it is optional.
>> And one says that it is not required in British English.
>>
>> But writing it with "that is":
>>
>>
>> hence code tagging) and then finding and operating on them at runtime
>> - that is iterating over them to print them in debugfs/procfs.
>>
>> is not good IMO. But it's your document.
>>
> 
> Technical writing often benefits from a small amount redundancy. Short
> sentences and repetition of terms are helpful to most readers. And this
> also stays out of the more advanced grammatical constructs, as a side
> effect.
> 
> So, for example, something *approximately* like this, see what you
> think:
> 
> Memory allocation profiling is based upon code tagging. Code tagging is
> a library for declaring static structs (typically by associating a file
> and line number with a descriptive string), and then finding and
> operating on those structs at runtime. Memory allocation profiling's
> runtime operation is simply: print the structs via debugfs/procfs.

Works for me.  Thanks.

-- 
#Randy

