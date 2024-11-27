Return-Path: <linux-fsdevel+bounces-36021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 322C19DAB2F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 16:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED16B281BFB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 15:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CAB20012E;
	Wed, 27 Nov 2024 15:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Bl7j3sxv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A5E1FF7D0
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Nov 2024 15:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732723018; cv=none; b=MCAlCszsMKkyJhzEoST6Ju4oerX2jCFvBB7zZMHYAI1auwefxIlya9oDNcnPR3NvHTPFmrFgTBYYhhFr6rM/zIFLJVMij87F6ptI/r874GVF2B9i3w9Buzr1rwuSggB9s1HUddJjEFo6xSwigWtQ9X8TFdMlYbx/soF37FjvqU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732723018; c=relaxed/simple;
	bh=VULP0c/UXVeU/rl4djhkV98I8PEdlz4LOa/39XWMk+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dFr0JmnanbYtkd+yok2ZyWVJuu2YfrKeHJZXNp7t3DsImCsqe40ScwJEISog0XrcohoPTQQz8T7bFVuMqNYPWg4A9SKDsAkEGoUXpgukywKG+GjqcVH3C2ukUGzN+oJ6aWg54J3m9VuU5UyuV54Z4C4tK9utLzwZeOScod2fJMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Bl7j3sxv; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 27 Nov 2024 07:56:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732723012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JXkvhyRqjP6lFRcbs3O1whsWhqpK6V6h80IkMO3VZE4=;
	b=Bl7j3sxv0V2NiNUhH3xmo3hfAJC9OZ4fOxyl1Tn8q50JDOH+B4LgRj6fGVPNkldTybsTTe
	DiaCZeon4sNpeLH1I+FYSOk9kZmQBvsAuGUvAu+kJSE9C/ytpJmLssg7bu/hNZl69Q+x0L
	uvLmioGNMB2JkQegGESSSAjS9+smQuY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Russ Weight <russ.weight@linux.dev>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: gregkh@linuxfoundation.org, dakr@redhat.com, song@kernel.org,
	mricon@kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] firmware_loader: minor spelling fixes
Message-ID: <20241127155637.uerxkjtcwptaiiyk@4VRSMR2-DT.corp.robot.car>
References: <20241127012012.2860726-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241127012012.2860726-1-mcgrof@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Tue, Nov 26, 2024 at 05:20:12PM -0800, Luis R. Rodriguez wrote:
> From: Luis Chamberlain <mcgrof@kernel.org>
> 
> Run codespell on the *.[ch] files for the firmware loader.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Reviewed-by: Russ Weight <russ.weight@linux.dev>

> ---
> 
> This is intended to help kick test our CI as we explore some area of it.
> 
>  drivers/base/firmware_loader/main.c         | 2 +-
>  drivers/base/firmware_loader/sysfs_upload.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
> index 324a9a3c087a..1aa509756d3e 100644
> --- a/drivers/base/firmware_loader/main.c
> +++ b/drivers/base/firmware_loader/main.c
> @@ -1528,7 +1528,7 @@ static void __device_uncache_fw_images(void)
>   * device_cache_fw_images() - cache devices' firmware
>   *
>   * If one device called request_firmware or its nowait version
> - * successfully before, the firmware names are recored into the
> + * successfully before, the firmware names are recorded into the
>   * device's devres link list, so device_cache_fw_images can call
>   * cache_firmware() to cache these firmwares for the device,
>   * then the device driver can load its firmwares easily at
> diff --git a/drivers/base/firmware_loader/sysfs_upload.c b/drivers/base/firmware_loader/sysfs_upload.c
> index 829270067d16..7a838b30d8eb 100644
> --- a/drivers/base/firmware_loader/sysfs_upload.c
> +++ b/drivers/base/firmware_loader/sysfs_upload.c
> @@ -209,7 +209,7 @@ static void fw_upload_main(struct work_struct *work)
>  	/*
>  	 * Note: fwlp->remaining_size is left unmodified here to provide
>  	 * additional information on errors. It will be reinitialized when
> -	 * the next firmeware upload begins.
> +	 * the next firmware upload begins.
>  	 */
>  	mutex_lock(&fw_lock);
>  	fw_free_paged_buf(fw_sysfs->fw_priv);
> -- 
> 2.45.2
> 

