Return-Path: <linux-fsdevel+bounces-16093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88465897DED
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 04:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 181471F283E7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 02:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BE52032B;
	Thu,  4 Apr 2024 02:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DOYOq1kt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F74EEEB2;
	Thu,  4 Apr 2024 02:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712199359; cv=none; b=mSiz+APlstW1ljXZskE8dV+mg/iOxpb6u7p1+aCINou+Wy/MMTqUKqo0Z73Dp+3HUt1ZYevStMNpWVylHKEFhIjXVyJiiXAz6V9wDZVxDFEWd+cFL8kJL/R1V03jjnJ3TNGfCNxhV6AizvhvQUbDqn4FhHNFlbBkF5GuVJcSENc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712199359; c=relaxed/simple;
	bh=woQPwN94SfTkVo2nkrzwmeNCeR1tcNFP0GrDX8U1n6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oOO6hyjDrgYEyeqM6WiNg0nyVqPu4f/vz4XKFWPHMz52UQcdoxzDazSOxB3oMqBMcUMfT9xHtWHAHrFelZi4N6L4fTB5JuVDDJyWtG6G12VxXrEr2PKDTX5Gcy88ddmGjA+XXOnAq17cq/5d5nbGonlnwxcRHSIDi4brBAW34r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DOYOq1kt; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=b2H16tqCkJ6i90mQLPDpV1ZsYZDW4KEWWz9R9e+0Oig=; b=DOYOq1ktip9OrPqyMbwDoNqDtq
	VB6HauYA/GGMAstDHOFp3X/FsrrMKv6YfXGD+QUD67yFNWCAcxzrPxwIanfV6S3L97X/TEZcue6x1
	DEi6bN9guWRaHhck/D7JnDVcfH/ggNwDsVGjKVdBzXBBK0zM3jPjOcv259vAlag3vudS0kmURSzoM
	aJYzWCso5E+7of2Er2nfWcoIvHsHbXLcHILwObAIYPaSB1QJuojxjuRFiDBF8ddzqHDVt2GWbVL/+
	xR+0t7YyOlbaQgK6MbdXjKGC7weqzQ++wCpmLrtM1OisyiYiLNHGQ3qfa4nDy1kb8yHh9fC1vn6Yz
	GUTgK+bw==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsDGA-000000012Up-3OOS;
	Thu, 04 Apr 2024 02:55:27 +0000
Message-ID: <5a349108-afd9-4290-acb6-8ec176a80a84@infradead.org>
Date: Wed, 3 Apr 2024 19:55:22 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/37] fix missing vmalloc.h includes
To: Kent Overstreet <kent.overstreet@linux.dev>,
 David Hildenbrand <david@redhat.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
 mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org,
 roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net,
 willy@infradead.org, liam.howlett@oracle.com,
 penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com,
 peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com,
 will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com,
 axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, dennis@kernel.org,
 jhubbard@nvidia.com, tj@kernel.org, muchun.song@linux.dev, rppt@kernel.org,
 paulmck@kernel.org, pasha.tatashin@soleen.com, yosryahmed@google.com,
 yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
 andreyknvl@gmail.com, keescook@chromium.org, ndesaulniers@google.com,
 vvvvvv@google.com, gregkh@linuxfoundation.org, ebiggers@google.com,
 ytcoode@gmail.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
 vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
 iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
 elver@google.com, dvyukov@google.com, songmuchun@bytedance.com,
 jbaron@akamai.com, aliceryhl@google.com, rientjes@google.com,
 minchan@google.com, kaleshsingh@google.com, kernel-team@android.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arch@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
 cgroups@vger.kernel.org
References: <20240321163705.3067592-1-surenb@google.com>
 <20240321163705.3067592-2-surenb@google.com>
 <20240403211240.GA307137@dev-arch.thelio-3990X>
 <4qk7f3ra5lrqhtvmipmacgzo5qwnugrfxn5dd3j4wubzwqvmv4@vzdhpalbmob3>
 <9e2d09f8-2234-42f3-8481-87bbd9ad4def@redhat.com>
 <qyyo6mjctqm734utdjen4ozhoo3t4ikswzjfjnemp7olwdgyt4@qifwishdzul4>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <qyyo6mjctqm734utdjen4ozhoo3t4ikswzjfjnemp7olwdgyt4@qifwishdzul4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/3/24 3:57 PM, Kent Overstreet wrote:
> On Wed, Apr 03, 2024 at 11:48:12PM +0200, David Hildenbrand wrote:
>> On 03.04.24 23:41, Kent Overstreet wrote:
>>> On Wed, Apr 03, 2024 at 02:12:40PM -0700, Nathan Chancellor wrote:
>>>> On Thu, Mar 21, 2024 at 09:36:23AM -0700, Suren Baghdasaryan wrote:
>>>>> From: Kent Overstreet <kent.overstreet@linux.dev>
>>>>>
>>>>> The next patch drops vmalloc.h from a system header in order to fix
>>>>> a circular dependency; this adds it to all the files that were pulling
>>>>> it in implicitly.
>>>>>
>>>>> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
>>>>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>>>>> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>>>>
>>>> I bisected an error that I see when building ARCH=loongarch allmodconfig
>>>> to commit 302519d9e80a ("asm-generic/io.h: kill vmalloc.h dependency")
>>>> in -next, which tells me that this patch likely needs to contain
>>>> something along the following lines, as LoongArch was getting
>>>> include/linux/sizes.h transitively through the vmalloc.h include in
>>>> include/asm-generic/io.h.
>>>
>>> gcc doesn't appear to be packaged for loongarch for debian (most other
>>> cross compilers are), so that's going to make it hard for me to test
>>> anything...
>>
>> The latest cross-compilers from Arnd [1] include a 13.2.0 one for
>> loongarch64 that works for me. Just in case you haven't heard of Arnds work
>> before and want to give it a shot.
>>
>> [1] https://mirrors.edge.kernel.org/pub/tools/crosstool/
> 
> Thanks for the pointer - but something seems to be busted with the
> loongarch build, if I'm not mistaken; one of the included headers
> references loongarch-def.h, but that's not included.
> 

That file is part of gcc plugins. If you disable CONFIG_GCC_PLUGINS,
it should build without having that issue. Of course, there may be other
unrelated issues....


-- 
#Randy

