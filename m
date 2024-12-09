Return-Path: <linux-fsdevel+bounces-36724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 192619E8A81
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 05:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEBEF280123
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 04:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBEB15B14B;
	Mon,  9 Dec 2024 04:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XM+MOMAV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456EE1C6A3;
	Mon,  9 Dec 2024 04:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733719640; cv=none; b=kvrrduyJYTSDy8jyeRthTT0sgfqIa2AlMttcNwxLjtag9o7S4SOwoF7RZc8sSnon6bAMWpXPZODIrUV6SmszUeg1SyrytimfUmGxp3CgwTNT4s5K4ldLHpJvtphG6aOQTPc0zeZDi/LkaKAdsRnZKYZ/L0B5hpfSppzTaU2sWgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733719640; c=relaxed/simple;
	bh=SIA4uxp9ob+blYbO6Dk+g5hTVKAc2LqIuzMK0f/Pszg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oYlmeri10iL356l5NsFAKv8NUfwwhKDnTxfSOYNbtSPh+hwL/dDF+rFaz/xQX/Jcw41tuFIJ+KRnTqTCqnX7pwwR302fNoelrSB1JSv3UF/V6UY56hmcCsGZwl4vfPTaSUbEcFbezOPaM/7iUjVMh0D7yPL92EenQ4DDKhjggmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XM+MOMAV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EDCCC4CED1;
	Mon,  9 Dec 2024 04:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733719639;
	bh=SIA4uxp9ob+blYbO6Dk+g5hTVKAc2LqIuzMK0f/Pszg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XM+MOMAVIXst8aAkZnslYa8SPU9DnkM4o5Z9R+s/Lef2UwwoqL6wM648DKJuvv0P3
	 VhBFwhGEmvz2MyGSwE5oyXIbrBNgZPmJmOBGhgUbXETefmHbgLjKLq04gis5GmMWJX
	 CiD/2YBNiw7KCurya8nKpXOvQ/zXWhg7OZrBDYyrlk0U1Sx/Qg3NPucIB9M2wBJ63P
	 N01Zx9xcHRv3uON3nT2KiPCO/c98bMeYPLnUa13p1mr8bjjBqcVpWoWUUtCFu3sQsZ
	 9IODuDZnFT5nWkBnLnP1q2pG3FYDtadB2t78EW0ekvGDIEwNjP9qy9cpvmGr6Mm14m
	 2eX+rT3ehkXfg==
Message-ID: <3e8f3f35-a80a-4505-b82d-9ac3f4a90785@kernel.org>
Date: Mon, 9 Dec 2024 13:47:18 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] zonefs: Fix the wrong format specifier
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241209025242.2995-1-zhujun2@cmss.chinamobile.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241209025242.2995-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/9/24 11:52, Zhu Jun wrote:
> Change f to unsigned int to resolve the mismatch in format specifiers for
> snprintf(), where %u should be used for unsigned integers instead of %d
> 
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>

The patch title is now wrong... And you forgot to add a Fixes tag.
Will fix that when applying. Thanks.

> ---
> Changes:
> v2:
> A better fix is to make f "unsigned int" as that is consistent with
> g_nr_zones and the fact that up to "unsigned int" total number of zones are
> allowed for a zoned device.
> 
> Can you send a v2 ? Also please add a Fixes tag.
> 
>  fs/zonefs/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> index faf1eb878..695da258a 100644
> --- a/fs/zonefs/super.c
> +++ b/fs/zonefs/super.c
> @@ -791,7 +791,7 @@ static int zonefs_readdir_zgroup(struct file *file,
>  	int fname_len;
>  	char *fname;
>  	ino_t ino;
> -	int f;
> +	unsigned int f;
>  
>  	/*
>  	 * The size of zone group directories is equal to the number


-- 
Damien Le Moal
Western Digital Research

