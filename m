Return-Path: <linux-fsdevel+bounces-16341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDA389B7A7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 08:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1EC51C21578
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 06:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C0A1B94D;
	Mon,  8 Apr 2024 06:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b="EMK1a7eN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B5D182C5;
	Mon,  8 Apr 2024 06:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.144.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712557930; cv=none; b=kyzqqHrvFsUeBZhD4FpekhebRqzuG+DDCN834F7yLlPHYSeYbmj2Qs47gU6XrIliD7rZsbCrr3COCrBd66ha80Ug/V8UDAqXO56MrCyLHM2Op1mMJRCy82f0Ez3S48Pjyj7P/dY8RIMdOn4RXDhISva57mNxlJREyg6LcG33Jxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712557930; c=relaxed/simple;
	bh=XwwgQRyoQELf3dRyU9eU2MR58r2rYRarWDZETjS7DEM=;
	h=MIME-Version:Date:From:To:Cc:Subject:Message-ID:Content-Type; b=Qe8ecqMZwRGnSrAgylzkMT8PMDfD2zdffevK4EBV4KZ/hyCIyTwl9K/twsy+s3eQ/HI0n8Yn7VgZ2mxVN0nu5PKNLVZYr5Qv8vA1EK3p5Q6AUAgVsK8BzDmwRUYe7NPiqVerNOdKfOowozfT+HqVMGGRoLBkHfOXh7Wo8mlJRvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me; spf=pass smtp.mailfrom=dorminy.me; dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b=EMK1a7eN; arc=none smtp.client-ip=71.19.144.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dorminy.me
Received: from authenticated-user (box.fidei.email [71.19.144.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.fidei.email (Postfix) with ESMTPSA id B640382891;
	Mon,  8 Apr 2024 02:32:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
	t=1712557922; bh=XwwgQRyoQELf3dRyU9eU2MR58r2rYRarWDZETjS7DEM=;
	h=Date:From:To:Cc:Subject:From;
	b=EMK1a7eNjICT7tH9Glwsje0GM4Pu38lDpYoFwVNR104pzhtJLlpTjmD4iSVqbPVLW
	 kLbY+IdGBrSSfvBJlmo+8PmM5OOINM3krlzgykHiZxQCpsp2BUyDYvZCyEl2acutUc
	 cJu67FA9lJwduBWfXVjqJplGt6jhQvJBpgJsw8MVvqOQ1OjQv8N5I19O6tBhQBn9PG
	 FFHK9Q0wmSuqYZBHg/fGDNLewmHDTalfnhY/tc5qwHio8KIpwqN/VYzD0qkp5zxv5j
	 c9pTxxEwp1669OZJ/RNxP9jf5HADgM36U+w0AuW1GzopoiWWgByf93c49qWp/U6sif
	 YlEOXhCypQX2g==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 08 Apr 2024 02:32:02 -0400
From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, zhangjiachen.jaycee@bytedance.com
Subject: Re: [PATCH] fuse: increase FUSE_MAX_MAX_PAGES limit
Message-ID: <b4d801a442c71d064a6b2212d8d6f661@dorminy.me>
X-Sender: sweettea-kernel@dorminy.me
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit


On 2024-01-26 01:29, Jingbo Xu wrote:
> On 1/24/24 8:47 PM, Jingbo Xu wrote:
>> 
>> 
>> On 1/24/24 8:23 PM, Miklos Szeredi wrote:
>>> On Wed, 24 Jan 2024 at 08:05, Jingbo Xu <jefflexu@linux.alibaba.com> 
>>> wrote:
>>>> 
>>>> From: Xu Ji <laoji.jx@alibaba-inc.com>
>>>> 
>>>> Increase FUSE_MAX_MAX_PAGES limit, so that the maximum data size of 
>>>> a
>>>> single request is increased.
>>> 
>>> The only worry is about where this memory is getting accounted to.
>>> This needs to be thought through, since the we are increasing the
>>> possible memory that an unprivileged user is allowed to pin.
> 
> Apart from the request size, the maximum number of background requests,
> i.e. max_background (12 by default, and configurable by the fuse
> daemon), also limits the size of the memory that an unprivileged user
> can pin.  But yes, it indeed increases the number proportionally by
> increasing the maximum request size.
> 
> 
>> 
>>> 
>>> 
>>> 
>>>> 
>>>> This optimizes the write performance especially when the optimal IO 
>>>> size
>>>> of the backend store at the fuse daemon side is greater than the 
>>>> original
>>>> maximum request size (i.e. 1MB with 256 FUSE_MAX_MAX_PAGES and
>>>> 4096 PAGE_SIZE).
>>>> 
>>>> Be noted that this only increases the upper limit of the maximum 
>>>> request
>>>> size, while the real maximum request size relies on the FUSE_INIT
>>>> negotiation with the fuse daemon.
>>>> 
>>>> Signed-off-by: Xu Ji <laoji.jx@alibaba-inc.com>
>>>> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
>>>> ---
>>>> I'm not sure if 1024 is adequate for FUSE_MAX_MAX_PAGES, as the
>>>> Bytedance floks seems to had increased the maximum request size to 
>>>> 8M
>>>> and saw a ~20% performance boost.
>>> 
>>> The 20% is against the 256 pages, I guess.
>> 
>> Yeah I guess so.
>> 
>> 
>>> It would be interesting to
>>> see the how the number of pages per request affects performance and
>>> why.
>> 
>> To be honest, I'm not sure the root cause of the performance boost in
>> bytedance's case.
>> 
>> While in our internal use scenario, the optimal IO size of the backend
>> store at the fuse server side is, e.g. 4MB, and thus if the maximum
>> throughput can not be achieved with current 256 pages per request. IOW
>> the backend store, e.g. a distributed parallel filesystem, get optimal
>> performance when the data is aligned at 4MB boundary.  I can ask my 
>> folk
>> who implements the fuse server to give more background info and the
>> exact performance statistics.
> 
> Here are more details about our internal use case:
> 
> We have a fuse server used in our internal cloud scenarios, while the
> backend store is actually a distributed filesystem.  That is, the fuse
> server actually plays as the client of the remote distributed
> filesystem.  The fuse server forwards the fuse requests to the remote
> backing store through network, while the remote distributed filesystem
> handles the IO requests, e.g. process the data from/to the persistent 
> store.
> 
> Then it comes the details of the remote distributed filesystem when it
> process the requested data with the persistent store.
> 
> [1] The remote distributed filesystem uses, e.g. a 8+3 mode, EC
> (ErasureCode), where each fixed sized user data is split and stored as 
> 8
> data blocks plus 3 extra parity blocks. For example, with 512 bytes
> block size, for each 4MB user data, it's split and stored as 8 (512
> bytes) data blocks with 3 (512 bytes) parity blocks.
> 
> It also utilize the stripe technology to boost the performance, for
> example, there are 8 data disks and 3 parity disks in the above 8+3 
> mode
> example, in which each stripe consists of 8 data blocks and 3 parity
> blocks.
> 
> [2] To avoid data corruption on power off, the remote distributed
> filesystem commit a O_SYNC write right away once a write (fuse) request
> received.  Since the EC described above, when the write fuse request is
> not aligned on 4MB (the stripe size) boundary, say it's 1MB in size, 
> the
> other 3MB is read from the persistent store first, then compute the
> extra 3 parity blocks with the complete 4MB stripe, and finally write
> the 8 data blocks and 3 parity blocks down.
> 
> 
> Thus the write amplification is un-neglectable and is the performance
> bottleneck when the fuse request size is less than the stripe size.
> 
> Here are some simple performance statistics with varying request size.
> With 4MB stripe size, there's ~3x bandwidth improvement when the 
> maximum
> request size is increased from 256KB to 3.9MB, and another ~20%
> improvement when the request size is increased to 4MB from 3.9MB.

To add my own performance statistics in a microbenchmark:

Tested on both small VM and large hardware, with suitably large 
FUSE_MAX_MAX_PAGES, using a simple fuse filesystem whose write handlers 
did basically nothing but read the data buffers (memcmp() each 8 bytes 
of data provided against a variable), I ran fio with 128M blocksize, 
end_fsync=1, psync IO engine, times each of 4 parallel jobs. Throughput 
was as follows over variable write_size in MB/s.

write_size  machine1 machine2
32M	1071	6425
16M	1002	6445
8M	890	6443
4M	713	6342
2M	557	6290
1M	404	6201
512K	268	6041
256K	156	5782

Even on the fast machine, increasing the buffer size to 8M is worth 3.9% 
over keeping it at 1M, and is worth over 2x on the small VM. We are 
striving to reduce the ingestion speed in particular as we have seen 
that as a limiting factor on some machines, and there's a clear plateau 
reached around 8M. While most fuse servers would likely not benefit from 
this, and others would benefit from fuse passthrough instead, it does 
seem like a performance win.

Perhaps, in analogy to soft and hard limits on pipe size, 
FUSE_MAX_MAX_PAGES could be increased and treated as the maximum 
possible hard limit for max_write; and the default hard limit could stay 
at 1M, thereby allowing folks to opt into the new behavior if they care 
about the performance more than the memory?

Sweet Tea

