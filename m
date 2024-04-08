Return-Path: <linux-fsdevel+bounces-16367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C10FC89C708
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 16:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0ACC1C2178A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 14:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365AF127B5A;
	Mon,  8 Apr 2024 14:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spawn.link header.i=@spawn.link header.b="FjTcWAKj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D291CD21;
	Mon,  8 Apr 2024 14:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712586422; cv=none; b=MABXY2vxbFxhmSc3nscxleVG3FonH3OJ4kch1fbzUGnRk3j5ExrDkrelzq3hXhzvhH0hth5eHVObNfDOivJW47AsYA3/zyIU/O7z0p9Wv48aBg7o8vyvPQt9bBitW86U83VEapvI60QqKQiBPUJYSLuk5FZveK/aYA7kmdHZxWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712586422; c=relaxed/simple;
	bh=rxVFR+tl2mqy5C+KQx6ENcTMnb0CNT7kB2Tov4/MpRo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tRBVwLGFrx8dq3tLTl7M0A7byT+sjved1TLVyNDBBtQOclW36JxM0gfmcVcBJyBo0YyEpYpydhF0GBWbAG1I2jhkSROUiJU+BtYz1ZcBtx/Hd1ceEjsqyORULc/5xMtALRP9GihZqVGNEFJeyRLsHF/JtVan0Bd9E9yRTbJJ/Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=spawn.link; spf=pass smtp.mailfrom=spawn.link; dkim=pass (2048-bit key) header.d=spawn.link header.i=@spawn.link header.b=FjTcWAKj; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=spawn.link
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spawn.link
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spawn.link;
	s=protonmail; t=1712586416; x=1712845616;
	bh=+5Fh0WwUiPmwp1z2/Cl7upCopJ5n83pXevljT6PBbkc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=FjTcWAKjU2UpdyqQGatEblHduf+EVHQOCjF/vjxIU3vcIMouKpOLFkPqSLzzN1qXc
	 jJSwPsk6ac9jMtiVAI/NS0MKv9M8N5vuEsCfF7sQcE8SLIi+A2RtcGKH00RAFJEOux
	 Iuv8ay/Dn4Et0DStZjb/Z/rk1CP0gZPEsRiTVgJWqMOepInOZzwg4fHnkr5yzLWDF9
	 DeTLOUZqI4HBMz9dzElk828BpyRaQB73TjjS+0XAj1IeCqPLzE1e7l/uIm15NQG88n
	 p3w8C9HKt8YM8Y5oj29BwmnUUu5+OaBH3ed+GM580jK8dt0wYRdfp4SWsAbULviYPR
	 yoe7NWEDFNhZw==
Date: Mon, 08 Apr 2024 14:26:53 +0000
To: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>, Jingbo Xu <jefflexu@linux.alibaba.com>
From: Antonio SJ Musumeci <trapexit@spawn.link>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, zhangjiachen.jaycee@bytedance.com
Subject: Re: [PATCH] fuse: increase FUSE_MAX_MAX_PAGES limit
Message-ID: <af555e3c-cd00-4bf4-b774-8099517bf559@spawn.link>
In-Reply-To: <b4d801a442c71d064a6b2212d8d6f661@dorminy.me>
References: <b4d801a442c71d064a6b2212d8d6f661@dorminy.me>
Feedback-ID: 55718373:user:proton
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/8/24 01:32, Sweet Tea Dorminy wrote:
>=20
> On 2024-01-26 01:29, Jingbo Xu wrote:
>> On 1/24/24 8:47 PM, Jingbo Xu wrote:
>>>
>>>
>>> On 1/24/24 8:23 PM, Miklos Szeredi wrote:
>>>> On Wed, 24 Jan 2024 at 08:05, Jingbo Xu <jefflexu@linux.alibaba.com>
>>>> wrote:
>>>>>
>>>>> From: Xu Ji <laoji.jx@alibaba-inc.com>
>>>>>
>>>>> Increase FUSE_MAX_MAX_PAGES limit, so that the maximum data size of
>>>>> a
>>>>> single request is increased.
>>>>
>>>> The only worry is about where this memory is getting accounted to.
>>>> This needs to be thought through, since the we are increasing the
>>>> possible memory that an unprivileged user is allowed to pin.
>>
>> Apart from the request size, the maximum number of background requests,
>> i.e. max_background (12 by default, and configurable by the fuse
>> daemon), also limits the size of the memory that an unprivileged user
>> can pin.  But yes, it indeed increases the number proportionally by
>> increasing the maximum request size.
>>
>>
>>>
>>>> It would be interesting to
>>>> see the how the number of pages per request affects performance and
>>>> why.
>>>
>>> To be honest, I'm not sure the root cause of the performance boost in
>>> bytedance's case.
>>>
>>> While in our internal use scenario, the optimal IO size of the backend
>>> store at the fuse server side is, e.g. 4MB, and thus if the maximum
>>> throughput can not be achieved with current 256 pages per request. IOW
>>> the backend store, e.g. a distributed parallel filesystem, get optimal
>>> performance when the data is aligned at 4MB boundary.  I can ask my
>>> folk
>>> who implements the fuse server to give more background info and the
>>> exact performance statistics.
>>
>> Here are more details about our internal use case:
>>
>> We have a fuse server used in our internal cloud scenarios, while the
>> backend store is actually a distributed filesystem.  That is, the fuse
>> server actually plays as the client of the remote distributed
>> filesystem.  The fuse server forwards the fuse requests to the remote
>> backing store through network, while the remote distributed filesystem
>> handles the IO requests, e.g. process the data from/to the persistent
>> store.
>>
>> Then it comes the details of the remote distributed filesystem when it
>> process the requested data with the persistent store.
>>
>> [1] The remote distributed filesystem uses, e.g. a 8+3 mode, EC
>> (ErasureCode), where each fixed sized user data is split and stored as
>> 8
>> data blocks plus 3 extra parity blocks. For example, with 512 bytes
>> block size, for each 4MB user data, it's split and stored as 8 (512
>> bytes) data blocks with 3 (512 bytes) parity blocks.
>>
>> It also utilize the stripe technology to boost the performance, for
>> example, there are 8 data disks and 3 parity disks in the above 8+3
>> mode
>> example, in which each stripe consists of 8 data blocks and 3 parity
>> blocks.
>>
>> [2] To avoid data corruption on power off, the remote distributed
>> filesystem commit a O_SYNC write right away once a write (fuse) request
>> received.  Since the EC described above, when the write fuse request is
>> not aligned on 4MB (the stripe size) boundary, say it's 1MB in size,
>> the
>> other 3MB is read from the persistent store first, then compute the
>> extra 3 parity blocks with the complete 4MB stripe, and finally write
>> the 8 data blocks and 3 parity blocks down.
>>
>>
>> Thus the write amplification is un-neglectable and is the performance
>> bottleneck when the fuse request size is less than the stripe size.
>>
>> Here are some simple performance statistics with varying request size.
>> With 4MB stripe size, there's ~3x bandwidth improvement when the
>> maximum
>> request size is increased from 256KB to 3.9MB, and another ~20%
>> improvement when the request size is increased to 4MB from 3.9MB.
>=20
> To add my own performance statistics in a microbenchmark:
>=20
> Tested on both small VM and large hardware, with suitably large
> FUSE_MAX_MAX_PAGES, using a simple fuse filesystem whose write handlers
> did basically nothing but read the data buffers (memcmp() each 8 bytes
> of data provided against a variable), I ran fio with 128M blocksize,
> end_fsync=3D1, psync IO engine, times each of 4 parallel jobs. Throughput
> was as follows over variable write_size in MB/s.
>=20
> write_size  machine1 machine2
> 32M=091071=096425
> 16M=091002=096445
> 8M=09890=096443
> 4M=09713=096342
> 2M=09557=096290
> 1M=09404=096201
> 512K=09268=096041
> 256K=09156=095782
>=20
> Even on the fast machine, increasing the buffer size to 8M is worth 3.9%
> over keeping it at 1M, and is worth over 2x on the small VM. We are
> striving to reduce the ingestion speed in particular as we have seen
> that as a limiting factor on some machines, and there's a clear plateau
> reached around 8M. While most fuse servers would likely not benefit from
> this, and others would benefit from fuse passthrough instead, it does
> seem like a performance win.
>=20
> Perhaps, in analogy to soft and hard limits on pipe size,
> FUSE_MAX_MAX_PAGES could be increased and treated as the maximum
> possible hard limit for max_write; and the default hard limit could stay
> at 1M, thereby allowing folks to opt into the new behavior if they care
> about the performance more than the memory?
>=20
> Sweet Tea

As I recall the concern about increased message sizes is that it gives a=20
process the ability to allocate non-insignificant amounts of kernel=20
memory. Perhaps the limits could be expanded only if the server has=20
SYS_ADMIN cap.


