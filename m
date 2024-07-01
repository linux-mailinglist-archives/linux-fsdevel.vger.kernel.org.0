Return-Path: <linux-fsdevel+bounces-22896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAAB91E883
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 21:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 057801F26092
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 19:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5F316F836;
	Mon,  1 Jul 2024 19:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b="LN9sEMtb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D1A15DBD6
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jul 2024 19:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.144.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719861740; cv=none; b=BUnmQ+/t9B4bW3b4bU8ItR01loTfy2eHN1NF9NuCjkMnbgz4w9m1qezIr3AOYv1rzmiD1WCARYUub6YUZS7KJrVhO8e6oVue4V74yqGEwgXhPpQqxbCOkubkrezFJC2+XEIg51uz29l0oJxADl20lP8uEAyBwidZQu4yttFF27A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719861740; c=relaxed/simple;
	bh=sUuE0doCKychW2I1tqsDl/nVAuzxPbu6u2L3woOOBCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cqDut7W9Xq+soMfMr4VkYZ90Sz5E2DHgJVTqUGXp5M6btqhXMfS96bf7bR3JtYr+BniGPTBePdsGRa09BM0GOzxapG6RXMz1zMVBZK37KOwlKT/xi6cGGOq6Xg1OCMCcAXmC21wZWUsfdHIn7kejfqpK1AruLj7NYzMB2QtYvsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me; spf=pass smtp.mailfrom=dorminy.me; dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b=LN9sEMtb; arc=none smtp.client-ip=71.19.144.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dorminy.me
Received: from authenticated-user (box.fidei.email [71.19.144.250])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by box.fidei.email (Postfix) with ESMTPSA id 5B0038049F;
	Mon,  1 Jul 2024 15:15:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
	t=1719861328; bh=sUuE0doCKychW2I1tqsDl/nVAuzxPbu6u2L3woOOBCk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LN9sEMtbkK3m8+7s7nzX0L6Ym0/yBS9LXPghUY+LWm7nfHBKORb3MzwKSfm6Yz9GO
	 AHuZbWbMkRlVUDSaRhO4rfWywtOshNRspmnyBa5j/D2fsYMLfQOGzMbujyQylPAV7e
	 3Z6EAF9Tkh9KZYxLgE81s7v8kftnN0Rw4WShHtA4G2QvuFHLYN6RI97j58ykUIAUEh
	 LAj2eH/PSEWR608Ns4aJxmjwF/3UZlxMnJSK3MHobLRRiMKgSR3+5wM+78GsYaOGj9
	 eIDlvNndKSdQxnEkxzPElMGot7g8Tb7qcQSvtVSgqsHR0yD+0SzI82O4Yd8j67pUlj
	 MU9Nl5uQjBiSw==
Message-ID: <8142b5da-db91-4f3e-ac63-6a476bc4f413@dorminy.me>
Date: Mon, 1 Jul 2024 15:15:25 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] fuse: Enable dynamic configuration of FUSE_MAX_MAX_PAGES
To: Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, osandov@osandov.com,
 laoji.jx@alibaba-inc.com, kernel-team@meta.com
References: <20240628001355.243805-1-joannelkoong@gmail.com>
 <20240628180305.GA413049@perftesting>
 <CAJnrk1YAt-dRUMYdS8TyyiXYG32nNBc_gTE0FeP0=XCZF3-pQA@mail.gmail.com>
Content-Language: en-US
From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <CAJnrk1YAt-dRUMYdS8TyyiXYG32nNBc_gTE0FeP0=XCZF3-pQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/1/24 12:48 PM, Joanne Koong wrote:
> On Fri, Jun 28, 2024 at 11:03 AM Josef Bacik <josef@toxicpanda.com> wrote:
>>
>> On Thu, Jun 27, 2024 at 05:13:55PM -0700, Joanne Koong wrote:
>>> Introduce the capability to dynamically configure the FUSE_MAX_MAX_PAGES
>>> limit through a sysctl. This enhancement allows system administrators to
>>> adjust the value based on system-specific requirements.
>>>
>>> This removes the previous static limit of 256 max pages, which limits
>>> the max write size of a request to 1 MiB (on 4096 pagesize systems).
>>> Having the ability to up the max write size beyond 1 MiB allows for the
>>> perf improvements detailed in this thread [1].
>>>
>>> $ sysctl -a | grep fuse_max_max_pages
>>> fs.fuse.fuse_max_max_pages = 256
>>>
>>> $ sysctl -n fs.fuse.fuse_max_max_pages
>>> 256
>>>
>>> $ echo 1024 | sudo tee /proc/sys/fs/fuse/fuse_max_max_pages
>>> 1024
>>>
>>> $ sysctl -n fs.fuse.fuse_max_max_pages
>>> 1024
>>>
>>> [1] https://lore.kernel.org/linux-fsdevel/20240124070512.52207-1-jefflexu@linux.alibaba.com/T/#u
>>>
>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>>
>> Overall the change is great, and I see why you named it the way you did, but I
>> think may be 'fuse_max_pages_limit' may be a better name?  The original constant
>> name wasn't great, but it was fine in its context.  I think having it as an
>> interface we should name it something less silly.
> 
> 'fuse_max_pages_limit' sounds great to me. I'll submit v2 with this rename.
> 

Whatever-it's-called might make sense to be in bytes, since max_read, 
max_write are the values visible to a userspace fuse server and are in 
bytes.

Additionally, the sysctl should probably disallow values at or above 
1<<16 pages -- fuse_init_out expects that max_pages fits in a u16, and 
there are a couple of places where fc->max_pages << PAGE_SHIFT is 
expected to fit in a u32. fc->max_pages is constrained by max_max_pages 
at present so this is true but would not be true if max_max_pages is 
only constrained by being a uint.

