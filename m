Return-Path: <linux-fsdevel+bounces-20293-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D95D38D1235
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 04:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63C50284B7B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 02:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CFE101DE;
	Tue, 28 May 2024 02:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bHPVF7Sy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86A68825;
	Tue, 28 May 2024 02:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716864332; cv=none; b=WmK+DD3+pwPfg5KEv+x6/L4RqZa6F1/hHr6JTUyAHhcGlkvZ3Th+8YIl0b7E2m/TCknaM/SxNphJrOfyhTBTWdmjgSQMSrutpcp9IBZsn8DToWQGoEBIdhS//fnjW6nAbx5YaYsaUXKwxFTuJf+kw8kMTTgaGFL9SeULOEY/+Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716864332; c=relaxed/simple;
	bh=OIVxUrnZNpPnoECkut5yPsYFBy5FP4ur762+K4Myjrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cgdD7cIfc5Jkhm54+4jclJ72FEdsXw0S/KoP7/f3GwDr8ZgW7iWj22mEb3pAamOpZS6HqRy0rT+CT+5oGGxSr7akIHWWfwXBNqTh4Y46y7qTdJBpw8Ft4iGjH9tu+1OHYdR8oxvzli9V1lRv/0j5hDficrIYWeUb7N2wgtIGpjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bHPVF7Sy; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716864327; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=y5vCuS19atFnvgyZRxQSlYoJcjtChXdNZx0h0GPcBkw=;
	b=bHPVF7SyYvFsZ9dMS6pnIEBdRVCyLuLHhbxswVqM87yZxo9/U2X+ZOuFyClnjeDeQrKArltyBzsL5gIr8olKWBhWcOKubGlWlf8BnLq/CmzUKyK9UKQZgxbx1jW6IeWfMSRWKSZQItc6+uSVOeb8gkNd4ThXn1fym7Pi4U7unSY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W7OBsXz_1716864325;
Received: from 30.221.144.199(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W7OBsXz_1716864325)
          by smtp.aliyun-inc.com;
          Tue, 28 May 2024 10:45:26 +0800
Message-ID: <858d23ec-ea81-45cb-9629-ace5d6c2f6d9@linux.alibaba.com>
Date: Tue, 28 May 2024 10:45:25 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/2] fuse: introduce fuse server recovery mechanism
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 winters.zc@antgroup.com
References: <20240524064030.4944-1-jefflexu@linux.alibaba.com>
 <CAJfpeguS3PBi-rNtnR2KH1ZS1t4s2HnB_pt4UvnN1orvkhpMew@mail.gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <CAJfpeguS3PBi-rNtnR2KH1ZS1t4s2HnB_pt4UvnN1orvkhpMew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/27/24 11:16 PM, Miklos Szeredi wrote:
> On Fri, 24 May 2024 at 08:40, Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
> 
>> 3. I don't know if a kernel based recovery mechanism is welcome on the
>> community side.  Any comment is welcome.  Thanks!
> 
> I'd prefer something external to fuse.

Okay, understood.

> 
> Maybe a kernel based fdstore (lifetime connected to that of the
> container) would a useful service more generally?

Yeah I indeed had considered this, but I'm afraid VFS guys would be
concerned about why we do this on kernel side rather than in user space.

I'm not sure what the VFS guys think about this and if the kernel side
shall care about this.

Many thanks!


-- 
Thanks,
Jingbo

