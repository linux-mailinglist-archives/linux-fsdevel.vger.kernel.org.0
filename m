Return-Path: <linux-fsdevel+bounces-28773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D3496E294
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 21:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8070C1C22D2F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 19:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C83817B51A;
	Thu,  5 Sep 2024 19:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b="HFbszo9u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8670814F9F9
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Sep 2024 19:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.144.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725562951; cv=none; b=DYHHqSXXSlGCHZl+WNqsxvYKt0MacBW3XxWAr5qQ/p/baRrExHx68rR8xcSb/pr+27B/G3XPPJOOzQWCrKU4FssDVVIlVscL1TInIe1mEWcdgodwIcdrJyzhebRJdKRtn+vQJ2SK5M83Jc4Nq9qWLpPO4Y4VD72GzstODLL6Rio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725562951; c=relaxed/simple;
	bh=x3l9uTAS5ElkXYqksWNPCB7meLdSlx6r2HFJzc3SQC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=svthMJ1BS2ZSScsDX4kLs1Qsu7VfPfphu1jjZdS5pcJPJ+bEuZw/91hVtlM28JTOvvUKwS43VuHKqEbQ9Xi+P3/dAfi0vpyYzE3tmz46DWmNCqDo0P+s9fTXdGUfDdVqm4i7sUG7Uz2TUTKWm8/y9UrkawlQo+s8UekfyyELKIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me; spf=pass smtp.mailfrom=dorminy.me; dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b=HFbszo9u; arc=none smtp.client-ip=71.19.144.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dorminy.me
Received: from authenticated-user (box.fidei.email [71.19.144.250])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by box.fidei.email (Postfix) with ESMTPSA id 60A1B8169E;
	Thu,  5 Sep 2024 14:53:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
	t=1725562412; bh=x3l9uTAS5ElkXYqksWNPCB7meLdSlx6r2HFJzc3SQC0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HFbszo9uRaa/nfXX29sct8Rt6FGBxkWSH7QsJajuFd2wEAbezta63GPDgf4vL+Hs7
	 u2rW/DbZc1/JHuiMll1RU1/DqKRWzC5O4uHEXzmGVPCpsfzRktI/5S0LWkp9L1m8BQ
	 KlHY1UF8bWZ56H21JWi6bghc5WS6Cg7lCuSraXLo+b0F/Q5T2FOPSiD4wd/iwxuxYm
	 f2o+cMQNpd+tnUI6+6dOeFge2Ye/72zYx4o5wERrEwdrgItgb1PhO4HqnHL4ojLlZa
	 z5+jOe9bAvczYbwQJ4Y+60zbUV8JzuOa6KWfX7/XowWXBEyqlk9B2K+dRwW+/qu8DC
	 o53X6apjCWz7Q==
Message-ID: <8a3d772c-04e7-49de-9598-6d3c6543bdd9@dorminy.me>
Date: Thu, 5 Sep 2024 14:53:31 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 RESEND] fuse: Enable dynamic configuration of fuse max
 pages limit (FUSE_MAX_MAX_PAGES)
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com, bernd.schubert@fastmail.fm, kernel-team@meta.com
References: <20240905174541.392785-1-joannelkoong@gmail.com>
Content-Language: en-US
From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <20240905174541.392785-1-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/5/24 1:45 PM, Joanne Koong wrote:
> Introduce the capability to dynamically configure the fuse max pages
> limit (formerly #defined as FUSE_MAX_MAX_PAGES) through a sysctl.
> This enhancement allows system administrators to adjust the value
> based on system-specific requirements.
> 
> This removes the previous static limit of 256 max pages, which limits
> the max write size of a request to 1 MiB (on 4096 pagesize systems).
> Having the ability to up the max write size beyond 1 MiB allows for the
> perf improvements detailed in this thread [1].
> 
> $ sysctl -a | grep max_pages_limit
> fs.fuse.max_pages_limit = 256
> 
> $ sysctl -n fs.fuse.max_pages_limit
> 256
> 
> $ echo 1024 | sudo tee /proc/sys/fs/fuse/max_pages_limit
> 1024
> 
> $ sysctl -n fs.fuse.max_pages_limit
> 1024
> 
> $ echo 65536 | sudo tee /proc/sys/fs/fuse/max_pages_limit
> tee: /proc/sys/fs/fuse/max_pages_limit: Invalid argument
> 
> $ echo 0 | sudo tee /proc/sys/fs/fuse/max_pages_limit
> tee: /proc/sys/fs/fuse/max_pages_limit: Invalid argument
> 
> $ echo 65535 | sudo tee /proc/sys/fs/fuse/max_pages_limit
> 65535
> 
> $ sysctl -n fs.fuse.max_pages_limit
> 65535
> 
> v2 (original):
> https://lore.kernel.org/linux-fsdevel/20240702014627.4068146-1-joannelkoong@gmail.com/
> 
> v1:
> https://lore.kernel.org/linux-fsdevel/20240628001355.243805-1-joannelkoong@gmail.com/
> 
> Changes from v1:
> - Rename fuse_max_max_pages to fuse_max_pages_limit internally
> - Rename /proc/sys/fs/fuse/fuse_max_max_pages to
>    /proc/sys/fs/fuse/max_pages_limit
> - Restrict fuse max_pages_limit sysctl values to between 1 and 65535
>    (inclusive)
> 
> [1] https://lore.kernel.org/linux-fsdevel/20240124070512.52207-1-jefflexu@linux.alibaba.com/T/#u
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

Thanks for doing this!!

