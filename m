Return-Path: <linux-fsdevel+bounces-29748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F220997D60E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 15:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A38A71F23028
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 13:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4701714AF;
	Fri, 20 Sep 2024 13:16:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8760E1422AB
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Sep 2024 13:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726838187; cv=none; b=qnwTWL5v7OdzDetWd+tQsMv+nElMCy5CHlc9S3MzaqnEb+mHN4bmkh2eGgygs0ceXuF4RLq3lsZf1PL3FC7RXGFrFhHkgPdGn7zZtT5Bvnr9EH9eII/veM7sII4I6rgkXLMKw8Haux+/7F7a0+JnmYF4GB414H8IJrLYS46fFNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726838187; c=relaxed/simple;
	bh=okUjgVsKWjXDD4KtYjXmbqdxsEusw4MAXbNyDwlOkeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b0jIoJ6zPVXIlJhzEsF9DdYAY5FatO+K1hw8n91xq379ZJpz1MwcJ6omCPpP76zlAdkU0e6UuK6Q+BiasTFCaFmY/wmwXWoOeBiffY1kf8m5KLM2mWKaDTEqvOjAd3ejmm+v/0033D+H16Q2U0Wwp7/XWmeNV/QkaUojaYDzkjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4D1C1007;
	Fri, 20 Sep 2024 06:16:53 -0700 (PDT)
Received: from [10.1.28.24] (e122027.cambridge.arm.com [10.1.28.24])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C61073F66E;
	Fri, 20 Sep 2024 06:16:22 -0700 (PDT)
Message-ID: <249807b3-305c-40c8-bd58-1154309223d7@arm.com>
Date: Fri, 20 Sep 2024 14:16:20 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panthor: Add FOP_UNSIGNED_OFFSET to fop_flags
To: Liviu Dudau <liviu.dudau@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Christian Brauner <brauner@kernel.org>, dri-devel@lists.freedesktop.org,
 Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
References: <20240920102802.2483367-1-liviu.dudau@arm.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20240920102802.2483367-1-liviu.dudau@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/09/2024 11:28, Liviu Dudau wrote:
> Since 641bb4394f40 ("fs: move FMODE_UNSIGNED_OFFSET to fop_flags")
> the FMODE_UNSIGNED_OFFSET flag has been moved to fop_flags and renamed,
> but the patch failed to make the changes for the panthor driver.
> When user space opens the render node the WARN() added by the patch
> gets triggered.
> 
> Fixes: 641bb4394f40 ("fs: move FMODE_UNSIGNED_OFFSET to fop_flags")
> Cc: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panthor/panthor_drv.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
> index 34182f67136c1..c520f156e2d73 100644
> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> @@ -1383,6 +1383,7 @@ static const struct file_operations panthor_drm_driver_fops = {
>  	.read = drm_read,
>  	.llseek = noop_llseek,
>  	.mmap = panthor_mmap,
> +	.fop_flags = FOP_UNSIGNED_OFFSET,
>  };
>  
>  #ifdef CONFIG_DEBUG_FS


