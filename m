Return-Path: <linux-fsdevel+bounces-36717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C50D69E8891
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 00:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 864502810AF
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Dec 2024 23:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735E2192D95;
	Sun,  8 Dec 2024 23:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBOuYUYH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFCF46B8;
	Sun,  8 Dec 2024 23:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733699860; cv=none; b=ssFMLjWQ8UDx0MkEZ5xO3jo7UQpECRKBt5rxU1O0l2fFVgsmKQKks19FMU4mDE8FkdCf76ze+pFkNHT39kRTBuxsWN/A6mIh89jzkmIwTAqDvwh4FX9rMUwxr/yexU1J1JqiuOshvnCE4lBZKjosx+uxduvl+Z8qvdLeiOx1tEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733699860; c=relaxed/simple;
	bh=/L8g8tO4RPOphjeNT9uNxulIqwN2aVNs0eV1HPY/3Fg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D60nfcIPupxjs0/7NgXlIMAB1dtreOB8Mk+ediURHB1XQLGT9tTd3VDPQ6Y953MLZB5ibwdC1gkB7qVetsEhwXy45ReJsPb8Im0hH0FV8M5VlMF1YRmCs7vCIOZq8GLWCPqRfmXZn78JKSRhHYplXFUoyl+9cQXHDA7PFtg+bVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBOuYUYH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC3EC4CED2;
	Sun,  8 Dec 2024 23:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733699860;
	bh=/L8g8tO4RPOphjeNT9uNxulIqwN2aVNs0eV1HPY/3Fg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mBOuYUYHh56oiJKTO96bGTJDqewWDia+lKa3+i7rxhJq+CRppjaFQZyMCE/TV0zzp
	 uuU0GzPAQkF1w2luvafc+CsRAJGVVRySde2P0Q1lHK0VHY8huoRDrbFZsPCVm/uyoa
	 8z/eiH42e/iceRxmHQvAtERqEbOFcGHfkhCaj0iiBr+d7A6xOxSqlvOPsdnFrz/be2
	 8DqysO753xmLC5MKafyAhaICqfypfsJreRVyAqWClE17QDkKFTLwYIEJ2vmrCxOXUn
	 feUFwWvg8eLHdTTIuVW1G6VWrbfRZwlCBh1ZyrsyZ5Cxcf68REicYLccqI3mBr+Bv6
	 xWyJogunZGr/g==
Message-ID: <901d37b0-d4c3-4ad2-b768-fc87d28c5a20@kernel.org>
Date: Mon, 9 Dec 2024 08:17:38 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] zonefs: Fix the wrong format specifier
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: naohiro.aota@wdc.com, jth@kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241111054126.2929-1-zhujun2@cmss.chinamobile.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241111054126.2929-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/24 14:41, Zhu Jun wrote:
> The format specifier of "signed int" in snprintf() should be "%d", not
> "%u".

My apologies for the late reply.

A better fix is to make f "unsigned int" as that is consistent with
g_nr_zones and the fact that up to "unsigned int" total number of zones are
allowed for a zoned device.

Can you send a v2 ? Also please add a Fixes tag.

> 
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
> ---
>  fs/zonefs/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> index faf1eb87895d..43c2f4a59b50 100644
> --- a/fs/zonefs/super.c
> +++ b/fs/zonefs/super.c
> @@ -811,7 +811,7 @@ static int zonefs_readdir_zgroup(struct file *file,
>  	for (f = ctx->pos - 2; f < zgroup->g_nr_zones; f++) {
>  		z = &zgroup->g_zones[f];
>  		ino = z->z_sector >> sbi->s_zone_sectors_shift;
> -		fname_len = snprintf(fname, ZONEFS_NAME_MAX - 1, "%u", f);
> +		fname_len = snprintf(fname, ZONEFS_NAME_MAX - 1, "%d", f);
>  		if (!dir_emit(ctx, fname, fname_len, ino, DT_REG))
>  			break;
>  		ctx->pos++;


-- 
Damien Le Moal
Western Digital Research

