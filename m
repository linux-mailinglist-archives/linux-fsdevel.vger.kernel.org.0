Return-Path: <linux-fsdevel+bounces-20296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA658D1329
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 06:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B77812846D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 04:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C9F182B3;
	Tue, 28 May 2024 04:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="G22W+gZa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8818418E25;
	Tue, 28 May 2024 04:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716868975; cv=none; b=uwRTypTMHeuHNF2GQY+KsaCULlccgTZyzLQ98M8XitwP7saCxYq5fLw6RUXenaI5pYPXFFqyERT5IdVAKlWlARF7IjJszxtpN1M3Y57o6ODVIFTLjCSDMN8ZqrLO05RaKPca2HvWTwCs19DYU0Sv3SGkBUU2ezNOc2XZ8rlJB1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716868975; c=relaxed/simple;
	bh=RUryWDZM8/CxUIrss5UeEa11d04TB5ISYy47F+40c0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hR7Os1E1C8St044+1Do3m2dtK5ZxI39MzfbQuphwqh1nc8eR82/q8IlqR5sTHnmzpHkvSa8ufkoKQ4DRFmLFaJ3L/kH7w2cMARKdoY9zQ2X06olodTYMmsCOtMeZYxruxRnbxBsK7wxkgmCqbydwCz6hciOYxaFYbVWHYY+9vSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=G22W+gZa; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716868969; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Ufbccdg7n9u75JgmNDr4YagbSZ/oALnqCYROgJ4t6Ks=;
	b=G22W+gZaqt6axuVFxTgBZS047Swa+2n8LDbTYPYY7FF8N/f7MO9AMCIIIGHVklA8Cims+rm7Ej7hntpejd100Cnufwfa2vbr+it7s1YB2RHqMFX/iAO6RhTlML2uYpCXAa63vP9hYHsPX0TsL3xHagNnR8V3BXxzaTjx+XRyRTg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W7OKPNz_1716868966;
Received: from 30.97.48.200(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W7OKPNz_1716868966)
          by smtp.aliyun-inc.com;
          Tue, 28 May 2024 12:02:48 +0800
Message-ID: <ce886be9-41d3-47b6-82e9-57d8f1f3421f@linux.alibaba.com>
Date: Tue, 28 May 2024 12:02:46 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/2] fuse: introduce fuse server recovery mechanism
To: Jingbo Xu <jefflexu@linux.alibaba.com>, Miklos Szeredi
 <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 winters.zc@antgroup.com
References: <20240524064030.4944-1-jefflexu@linux.alibaba.com>
 <CAJfpeguS3PBi-rNtnR2KH1ZS1t4s2HnB_pt4UvnN1orvkhpMew@mail.gmail.com>
 <858d23ec-ea81-45cb-9629-ace5d6c2f6d9@linux.alibaba.com>
 <6a3c3035-b4c4-41d9-a7b0-65f72f479571@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <6a3c3035-b4c4-41d9-a7b0-65f72f479571@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/5/28 11:08, Jingbo Xu wrote:
> 
> 
> On 5/28/24 10:45 AM, Jingbo Xu wrote:
>>
>>
>> On 5/27/24 11:16 PM, Miklos Szeredi wrote:
>>> On Fri, 24 May 2024 at 08:40, Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>>
>>>> 3. I don't know if a kernel based recovery mechanism is welcome on the
>>>> community side.  Any comment is welcome.  Thanks!
>>>
>>> I'd prefer something external to fuse.
>>
>> Okay, understood.
>>
>>>
>>> Maybe a kernel based fdstore (lifetime connected to that of the
>>> container) would a useful service more generally?
>>
>> Yeah I indeed had considered this, but I'm afraid VFS guys would be
>> concerned about why we do this on kernel side rather than in user space.

Just from my own perspective, even if it's in FUSE, the concern is
almost the same.

I wonder if on-demand cachefiles can keep fds too in the future
(thus e.g. daemonless feature could even be implemented entirely
with kernel fdstore) but it still has the same concern or it's
a source of duplication.

Thanks,
Gao Xiang

>>
>> I'm not sure what the VFS guys think about this and if the kernel side
>> shall care about this.
>>
> 
> There was an RFC for kernel-side fdstore [1], though it's also
> implemented upon FUSE.
> 
> [1]
> https://lore.kernel.org/all/CA+a=Yy5rnqLqH2iR-ZY6AUkNJy48mroVV3Exmhmt-pfTi82kXA@mail.gmail.com/T/
> 
> 
> 

