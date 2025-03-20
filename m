Return-Path: <linux-fsdevel+bounces-44499-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11886A69D5B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 01:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E37228A0886
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 00:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157631C3C1D;
	Thu, 20 Mar 2025 00:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NQvs21Sl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D941A5BA4;
	Thu, 20 Mar 2025 00:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742431409; cv=none; b=dJWxIwimwQoJPZdk/hhGpecd2WD3jlK/vrrAX0R762CnVBI6GeyU3HfDot1+qBzgmCTvduNL9wZNBYvAzMzNGi02i65hO5Ks5NtCw/LL8j5SCS9R8KuyYdEvSrcMGDKg60wuWRm8OgvlyDAiXdPHUxbxjyewTvPZsC/HHOcQAx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742431409; c=relaxed/simple;
	bh=N3JrfAe74zWYWntEAoMu3hgiVC7VPDt3/pmat94gSFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uLC/C4XreEau9cQnp1UOU7czWlU7NaKf4L3Cass0Re6uXJuy1iTzpaHPoTP1HRRhSWucxtH2Z7iRPWo9RAYuutpGqg/0HW/UBRNZK7avYmhlM3GjnIAsZhO67TykGDNqrlQZUzoeQNSqKMP+SgPjOO7TvMicBDbHJpL+f9yXSjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NQvs21Sl; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1742431403; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=d3PXrSZdoQRecHWJ8cdn3KiUu+yDTdxd+xT5ZNIbX74=;
	b=NQvs21SlDuo2WVnMaQBo79GlAJZeXKj2mzn1yrrFlSQwAlM9A2/KfcHO4WzlIk3GHTpuLHKNmHF3sim4BcJFT3xfsmSRo4Rc0tt8YkoUzA4Zog8krQuFf5Jpr9Oa2DqdKr0q1V21zehSOHWljW8R3d7ayM5agzGZThHP0/AFPs0=
Received: from 30.134.66.95(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WS6e9xm_1742431400 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 20 Mar 2025 08:43:21 +0800
Message-ID: <51a347ce-84d4-4698-a492-61eac2f4318e@linux.alibaba.com>
Date: Thu, 20 Mar 2025 08:43:20 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/8] staging: apfs: init APFS filesystem support
To: Ethan Carter Edwards <ethan@ethancedwards.com>, brauner@kernel.org,
 tytso@mit.edu, jack@suse.cz, viro@zeniv.linux.org.uk
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 ernesto.mnd.fernandez@gmail.com, dan.carpenter@linaro.org,
 sven@svenpeter.dev, ernesto@corellium.com, gargaditya08@live.com,
 willy@infradead.org, asahi@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-staging@lists.linux.dev
References: <20250319-apfs-v2-0-475de2e25782@ethancedwards.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250319-apfs-v2-0-475de2e25782@ethancedwards.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/3/20 08:13, Ethan Carter Edwards wrote:
> Hello everyone,
> 
> In series 2, I have fixed the formatting with clang-format of the lzfse
> library and fixed the comments to use linux kernel styles. I also
> removed my Copyright from files where it was not appropriate.
> Additionally, I removed the encode.c files as they were unused and
> not compiled into the final module They should be easy enough to add
> back if needed. I also rebased on Linus's tree, just in case.
> Nothing broke! ;)
> 
> I am holding off on adding Ernesto's Co-developed-by and Signed-off-by
> tags until I get a better grasp of where this module is headed. I hope
> to here back from Christian and the LSFMMBPF folks sometime in the next
> few weeks.
> 
> I understand the jury is still out on supporting both reading and
> writing. As it stands, I have configured the code to support
> reading/writing on mount, but upstream auto-rw is configurable via a
> CONFIG option. Some people have expressed that they want the module
> upstreamed even if only read is supported. I will stay tuned and make
> changes as needed.
> 
> Additionally, I realize that staging/ may not be the correct location
> for the driver. However, I am basing my upstream process off of the
> erofs process. They started in staging. I understand that the correct
> tree and dir will be discussed as next weeks LSFMMBPF summit,
> so I will wait on their feedback before making any moves.

I don't know why erofs is related to your case here:

  - erofs is not a project based on reserve engineering from the
    beginning; it was a real productizied project initially designed
    for Android and got wider adoption for various use cases now;

  - It was a story 6 years ago (I've been actively working on this
    project more than 7 years and it sacrificed my extra free time and
    some other possibility), more recent fses instead directly land
    into "fs/" and it seems the preferred way.  But, nevertheless,
    there is also some fs like ntfs3 directly into "fs/" and got some
    dispute;

  - I have no idea if you have enough professional experience to
    resolve apfs-specific issues properly and in time.  I think it's
    a basic requirement for a kernel subsystem upstream maintainer now
    that you introduced this;

  - And you'd better to keep relatively active during the entire Linux
    kernel lifetime even that is not related to your ongoing work
    rather than dump and leave.

Thanks,
Gao Xiang

