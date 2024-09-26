Return-Path: <linux-fsdevel+bounces-30160-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBC69872BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 13:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2700B2220E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 11:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B677718CBE0;
	Thu, 26 Sep 2024 11:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="S8YB934G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC361B960;
	Thu, 26 Sep 2024 11:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727349819; cv=none; b=bydnVgYUJnLL0xb0SWiUTwTezxC4+XLAlB96EVh2h/wk6O3u4VJIZ9MYOaIzIXC+tkhFmHys+BJFlsAEP5U1D/2ugRzPqJtruFDVgmVagMD983oX756SkpNnCtb86MqeTYnwDht3C/4IxA5e1Kt0Z4FAJfHUZzFSigWLk0P12NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727349819; c=relaxed/simple;
	bh=4uSInfRnITG59DSZsLFHyPVKqII85qLvRJfFkEJyfBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZTYMejfLn757sdbpZxCe1M+L6lHYK6mwoBOb3BHtFWjQJL9nZJ1ogzom8EKeXm7GyDrUex62VfrJhCLZjXK8TUDOd9U4CIzeC4j2y0aj/j+M+kgVHMjlS3M6EKl7nvlGrzksu3CsgEb+G+wawIhnNFJpbsQrJ0dYIb0KvL/gpRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=S8YB934G; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727349808; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=52Hd22cyMQE0xicpF+br1DfVt8GaUc6LS4cJaudJCdk=;
	b=S8YB934GS2UYCT3i1ugXs6Wx2zPU0p9cYvaWhYOoFPGHVz4TApPr/mxtBNy5cXvfvGr1is1GyWQP/Wq1hpNLr0XYNxpqxCPzV2DK/21AauFiqxua+rEHbM+2YvWc4xDJ6g2rn0bgnwgmpbEiXJR1bS9TsbMwsWbDvQY5KVQKQuI=
Received: from 30.221.129.247(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WFnG64q_1727349806)
          by smtp.aliyun-inc.com;
          Thu, 26 Sep 2024 19:23:27 +0800
Message-ID: <ec17a30e-c63a-4615-8784-69aef2bb2bae@linux.alibaba.com>
Date: Thu, 26 Sep 2024 19:23:26 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/24] erofs: add Errno in Rust
To: Ariel Miculas <amiculas@cisco.com>
Cc: Benno Lossin <benno.lossin@proton.me>, rust-for-linux@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Al Viro <viro@zeniv.linux.org.uk>, Gary Guo <gary@garyguo.net>,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
References: <239b5d1d-64a7-4620-9075-dc645d2bab74@proton.me>
 <20240925154831.6fe4ig4dny2h7lpw@amiculas-l-PF3FCGJH>
 <80cd0899-f14c-42f4-a0aa-3b8fa3717443@linux.alibaba.com>
 <20240925214518.fvig2n6cop3sliqy@amiculas-l-PF3FCGJH>
 <be7a42b2-ae52-4d51-9b0c-ed0304db3bdf@linux.alibaba.com>
 <0ca4a948-589a-4e2c-9269-827efb3fb9ef@linux.alibaba.com>
 <20240926081007.6amk4xfuo6l4jhsc@amiculas-l-PF3FCGJH>
 <54bf7cc6-a62a-44e9-9ff0-ca2e334d364f@linux.alibaba.com>
 <20240926095140.fej2mys5dee4aar2@amiculas-l-PF3FCGJH>
 <5f5e006b-d13b-45a5-835d-57a64d450a1a@linux.alibaba.com>
 <20240926110151.52cuuidfpjtgwnjd@amiculas-l-PF3FCGJH>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240926110151.52cuuidfpjtgwnjd@amiculas-l-PF3FCGJH>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/9/26 19:01, Ariel Miculas via Linux-erofs wrote:
> On 24/09/26 06:46, Gao Xiang wrote:

...

>>
>>>
>>>>
>>>> 	                Total Size (MiB)	Average layer size (MiB)	Saved / 766.1MiB
>>>> Compressed OCI (tar.gz)	282.5	28.3	63%
>>>> Uncompressed OCI (tar)	766.1	76.6	0%
>>>> Uncomprssed EROFS	109.5	11.0	86%
>>>> EROFS (DEFLATE,9,32k)	46.4	4.6	94%
>>>> EROFS (LZ4HC,12,64k)	54.2	5.4	93%
>>>>
>>>> I don't know which compression algorithm are you using (maybe Zstd?),
>>>> but from the result is
>>>>     EROFS (LZ4HC,12,64k)  54.2
>>>>     PuzzleFS compressed   53?
>>>>     EROFS (DEFLATE,9,32k) 46.4
>>>>
>>>> I could reran with EROFS + Zstd, but it should be smaller. This feature
>>>> has been supported since Linux 6.1, thanks.
>>>
>>> The average layer size is very impressive for EROFS, great work.
>>> However, if we multiply the average layer size by 10, we get the total
>>> size (5.4 MiB * 10 ~ 54.2 MiB), whereas for PuzzleFS, we see that while
>>> the average layer size is 30 MIB (for the compressed case), the unified
>>> size is only 53 MiB. So this tells me there's blob sharing between the
>>> different versions of Ubuntu Jammy with PuzzleFS, but there's no sharing
>>> with EROFS (what I'm talking about is deduplication across the multiple
>>> versions of Ubuntu Jammy and not within one single version).
>>
>> Don't make me wrong, I don't think you got the point.
>>
>> First, what you asked was `I'm referring specifically to this
>> comment: "EROFS already supports variable-sized chunks + CDC"`,
>> so I clearly answered with the result of compressed data global
>> deduplication with CDC.
>>
>> Here both EROFS and Squashfs compresses 10 Ubuntu images into
>> one image for fair comparsion to show the benefit of CDC, so
> 
> It might be a fair comparison, but that's not how container images are
> distributed. You're trying to argue that I should just use EROFS and I'm

First, OCI layer is just distributed like what I said.

For example, I could introduce some common blobs to keep
chunks as chunk dictionary.   And then the each image
will be just some index, and all data will be
deduplicated.  That is also what Nydus works.

> showing you that EROFS doesn't currently support the functionality
> provided by PuzzleFS: the deduplication across multiple images.

No, EROFS supports external devices/blobs to keep a lot of
chunks too (as dictionary to share data among images), but
clearly it has the upper limit.

But PuzzleFS just treat each individual chunk as a seperate
file, that will cause unavoidable "open arbitary number of
files on reading, even in page fault context".

> 
>> I believe they basically equal to your `Unified size`s, so
>> the result is
>>
>> 			Your unified size
>> 	EROFS (LZ4HC,12,64k)  54.2
>> 	PuzzleFS compressed   53?
>> 	EROFS (DEFLATE,9,32k) 46.4
>>
>> That is why I used your 53 unified size to show EROFS is much
>> smaller than PuzzleFS.
>>
>> The reason why EROFS and SquashFS doesn't have the `Total Size`s
>> is just because we cannot store every individual chunk into some
>> seperate file.
> 
> Well storing individual chunks into separate files is the entire point
> of PuzzleFS.
> 
>>
>> Currently, I have seen no reason to open arbitary kernel files
>> (maybe hundreds due to large folio feature at once) in the page
>> fault context.  If I modified `mkfs.erofs` tool, I could give
>> some similar numbers, but I don't want to waste time now due
>> to `open arbitary kernel files in the page fault context`.
>>
>> As I said, if PuzzleFS finally upstream some work to open kernel
>> files in page fault context, I will definitely work out the same
>> feature for EROFS soon, but currently I don't do that just
>> because it's very controversal and no in-tree kernel filesystem
>> does that.
> 
> The PuzzleFS kernel filesystem driver is still in an early POC stage, so
> there's still a lot more work to be done.

I suggest that you could just ask FS/MM folks about this ("open
kernel files when reading in the page fault") first.

If they say "no", I suggest please don't waste on this anymore.

Thanks,
Gao Xiang

