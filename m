Return-Path: <linux-fsdevel+bounces-10431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C87B084B0F5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 10:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9B1F1C22681
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 09:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E3E12BF3C;
	Tue,  6 Feb 2024 09:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="DLgBKBHD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250FE74E2A
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 09:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707211229; cv=none; b=AvzJxDaTq7dBMeO2kXNR9ijTHv0cbfg+tL7OIuHyMsDp2OD78Th2IQovcHdR6ck058MklRhUXMUFmyznQEwMumMmgu8Ho3Z1hL+fHaN/F2vhuuigI2RTZPqDtTTaC1tTPZon5WpqMqME/PKnRS58nSyTuo1rHe2ou55a1qeNsh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707211229; c=relaxed/simple;
	bh=WcV+drEAFlEBLjkBdaAy7M6n7QQ4ddxMH9TpObcNbyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eQnxEaAp/kl0HK5pgy5hbyBCbRw+8XvdyAhcl8yDLYvTShVidpcsBHVUkjwmjXe3dKpC+Rb9NF7BeVlgusP6E+MtPFwd+3zYlKj9hBT7QT+rFEdBMCZRvFPBYLUowUlYVEW5XRE1q+o4G5K+kk36uQpMlgMzRQ1Fm8Jl3JJMgnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=DLgBKBHD; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707211217; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=gdlq29gqUkslbkCV7qd07ey+SwGYfs+h2zdzs+xTQmQ=;
	b=DLgBKBHDqN/NAHdIz5dGnkqfrPVgkxjsk1hJOMaYvT5SXA20QEw/FjRe0tuJQUtQl0/VTIj6uwqRHYgX9RpBu76R0LdjS8rlj6wsKlaqiX4gWWWxeTufAWjuttbxRqOBuwa4e3KF0EZK7oosviGE/Lk/FwPzMXcPouD8Sqfw2Rc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W0D0bbG_1707211216;
Received: from 30.221.145.131(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W0D0bbG_1707211216)
          by smtp.aliyun-inc.com;
          Tue, 06 Feb 2024 17:20:17 +0800
Message-ID: <2d0d6581-14de-46c4-a664-f6e193ab2518@linux.alibaba.com>
Date: Tue, 6 Feb 2024 17:20:15 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] fuse: Create helper function if DIO write needs
 exclusive lock
To: Bernd Schubert <bschubert@ddn.com>, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, dsingh@ddn.com,
 Amir Goldstein <amir73il@gmail.com>
References: <20240131230827.207552-1-bschubert@ddn.com>
 <20240131230827.207552-3-bschubert@ddn.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240131230827.207552-3-bschubert@ddn.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/1/24 7:08 AM, Bernd Schubert wrote:
> @@ -1591,10 +1616,10 @@ static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  	else {
>  		inode_lock_shared(inode);
>  
> -		/* A race with truncate might have come up as the decision for
> -		 * the lock type was done without holding the lock, check again.
> +		/*
> +		 * Previous check was without any lock and might have raced.
>  		 */
> -		if (fuse_direct_write_extending_i_size(iocb, from)) {
> +		if (fuse_dio_wr_exclusive_lock(iocb, from)) {
			^

The overall is good.  Maybe fuse_io_past_eof() is better to make it a
solely cleanup or refactoring.  Actually it's already changed back to
fuse_io_past_eof() in patch 3/5.


-- 
Thanks,
Jingbo

