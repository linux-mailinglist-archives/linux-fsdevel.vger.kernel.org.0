Return-Path: <linux-fsdevel+bounces-20294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 364048D126D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 05:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAD1228382C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 03:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AF2182B3;
	Tue, 28 May 2024 03:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vfItW0BZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7573217C68;
	Tue, 28 May 2024 03:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716865707; cv=none; b=rafL2Y3VAyjtN8TqDF1wOYs+ROaz76pTv906eK4oBdHTp0ZZQbVCHWLs11CzYxJtN1X9i6mjUyLFWm09pSw1zaiLAL2NG4aryAfB82eWO389I0R2uRn6kAT8l3CBQU0dL17XZ4zYByegDzl+cg8yw/p7s+7voHh0SWikOCCF9Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716865707; c=relaxed/simple;
	bh=roCSdQxbUY29rDE38xzKqghaprNify5fn1VLno9bEVU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jiFXe/RlaMyTwvhdZvWrhOEiLMe33BCjWnhPy8KFVXXMtVK69CE+bgYH6JBhSvUBuyhGTGWXNSoHLpsW9W5o9ur2svKPTcViHzSbMUTaYkfJPqb85D6pVZ1XEehn8ikMBJZc1yD1QQseAKSVk6qVEUQJfaY75vj5EHWL3fBgmIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vfItW0BZ; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716865702; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=0Pw1BUiofgno3cSLLGLqrBjiIZ9UhCXpPdHKClzv11Q=;
	b=vfItW0BZML/SURhR9K3Fv/tGopu80c1gS0ykbC6ehSX2y3NGT4dO6gSwtEy6rUpNsSa0OV725kHX1sfJiF8E5fk05cGnjyb7L4SN2aDnm/V4qWCe8LifNCQ4MLYUItAyFoXXmN/u0v4dkRzuH08JxZlGO+h3nM8IZfJ1YKchyvE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R901e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W7O7xhR_1716865700;
Received: from 30.221.144.199(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W7O7xhR_1716865700)
          by smtp.aliyun-inc.com;
          Tue, 28 May 2024 11:08:21 +0800
Message-ID: <6a3c3035-b4c4-41d9-a7b0-65f72f479571@linux.alibaba.com>
Date: Tue, 28 May 2024 11:08:19 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/2] fuse: introduce fuse server recovery mechanism
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 winters.zc@antgroup.com
References: <20240524064030.4944-1-jefflexu@linux.alibaba.com>
 <CAJfpeguS3PBi-rNtnR2KH1ZS1t4s2HnB_pt4UvnN1orvkhpMew@mail.gmail.com>
 <858d23ec-ea81-45cb-9629-ace5d6c2f6d9@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <858d23ec-ea81-45cb-9629-ace5d6c2f6d9@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/28/24 10:45 AM, Jingbo Xu wrote:
> 
> 
> On 5/27/24 11:16 PM, Miklos Szeredi wrote:
>> On Fri, 24 May 2024 at 08:40, Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>
>>> 3. I don't know if a kernel based recovery mechanism is welcome on the
>>> community side.  Any comment is welcome.  Thanks!
>>
>> I'd prefer something external to fuse.
> 
> Okay, understood.
> 
>>
>> Maybe a kernel based fdstore (lifetime connected to that of the
>> container) would a useful service more generally?
> 
> Yeah I indeed had considered this, but I'm afraid VFS guys would be
> concerned about why we do this on kernel side rather than in user space.
> 
> I'm not sure what the VFS guys think about this and if the kernel side
> shall care about this.
> 

There was an RFC for kernel-side fdstore [1], though it's also
implemented upon FUSE.

[1]
https://lore.kernel.org/all/CA+a=Yy5rnqLqH2iR-ZY6AUkNJy48mroVV3Exmhmt-pfTi82kXA@mail.gmail.com/T/



-- 
Thanks,
Jingbo

