Return-Path: <linux-fsdevel+bounces-8916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D628883C136
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 12:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14A9A1C22955
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 11:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E917D2C6A0;
	Thu, 25 Jan 2024 11:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="deVqHq2H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C181BC46
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jan 2024 11:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706182993; cv=none; b=oqdu2HKeI2tsLiBwwmRCfmzb/nI3miFgPdPet+V2QCC60RVLWHb0X3ML5FxlPy/pPgVOrTSS0SasMP5e/RN96jw/YSb2ZGjNOZ6u8vcMAeXSLI6DXKmoHSMgSRtTdwcfsdTlBViBzKO9aFq7FFZZIYya6O7klKiK1ABWvj3KfPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706182993; c=relaxed/simple;
	bh=kzEhFgF2O6Y2JCCtYiBmXE6wkYk/VoEpyEZkWKdyvHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DMsLQOzeepKWFIoiYta5zsvzY5++/Qi3jGD2jVrFCLq9jh00Sqz+OMiMB6t+pg7U0xDAmolvpvm7dZ0mO3NWfsde1b81S6YeCG+++lA8FdbBJGDfsL5bFvRioDdPPu5PZv4bOv5znp+L9C8rqSw+sZMQx1KHC84oJfoPmItaMIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=deVqHq2H; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706182987; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=uPEytPH/UOp1KTFETMeN2Fac9soI1S7kOoiI6OqZWeE=;
	b=deVqHq2HbTvfJIynVtJ54oUMmA3jPZba7j7rT2LqTnGN+DnEfHePzfJK+IkhYWRqJea34nEAIdynynN2cGAQvOFkRMfWUbBKNgqIWDiQOrxptKdqq+xWPafSZriEISt1nNSZ40EKRWfeH/GfBhzx8/h0H8TufkZv6DeUXEX4ZaE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0W.KIHmY_1706182986;
Received: from 30.221.148.174(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W.KIHmY_1706182986)
          by smtp.aliyun-inc.com;
          Thu, 25 Jan 2024 19:43:07 +0800
Message-ID: <1611a0cc-6daa-4423-be27-eccca71e2fce@linux.alibaba.com>
Date: Thu, 25 Jan 2024 19:43:05 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] fuse: Introduce a new notification type for resend
 pending requests
Content-Language: en-US
To: Zhao Chen <winters.zc@antgroup.com>, linux-fsdevel@vger.kernel.org,
 Miklos Szeredi <miklos@szeredi.hu>
References: <20240109092443.519460-1-winters.zc@antgroup.com>
 <20240109092443.519460-2-winters.zc@antgroup.com>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240109092443.519460-2-winters.zc@antgroup.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Miklos,

On 1/9/24 5:24 PM, Zhao Chen wrote:
> When a FUSE daemon panics and failover, we aim to minimize the impact on
> applications by reusing the existing FUSE connection. During this process,
> another daemon is employed to preserve the FUSE connection's file
> descriptor. The new started FUSE Daemon will takeover the fd and continue
> to provide service.
> 
> However, it is possible for some inflight requests to be lost and never
> returned. As a result, applications awaiting replies would become stuck
> forever. To address this, we can resend these pending requests to the
> new started FUSE daemon.
> 
> This patch introduces a new notification type "FUSE_NOTIFY_RESEND", which
> can trigger resending of the pending requests, ensuring they are properly
> processed again.
> 
> Signed-off-by: Zhao Chen <winters.zc@antgroup.com>

The notification style is more helpful in the cloud native scenarios
comparing to the original fusectl mechanism.  Recent days we found the
original fusectl based "resend" interface is un-accessible inside a
non-privileged container in our internal use case, as fusectl is
designed as a singleton and has no ability for user namespace mounting.
The new notification styled interface seems extremely helpful in our case.

Thus may I ask if there is any potential modification as for the user
ABI of the resend feature?  I'd like to test and improve it if there's any.

Many thanks!


-- 
Thanks,
Jingbo

