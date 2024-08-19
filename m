Return-Path: <linux-fsdevel+bounces-26219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B939956257
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 06:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1F0A1F224B0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 04:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA29E13BC25;
	Mon, 19 Aug 2024 04:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KpeTuXhY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010C98801;
	Mon, 19 Aug 2024 04:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724040487; cv=none; b=n81ZpMlSag8myUzpSV8sRRRaT1GT/c/O1P1tzjFIyH5MScn1akf1gAZTantaoz3siizHgOx8RqUwl+VZl3SNO23or63KuLXKKYvBA4dQsT/UyJTBWn9XxTnRo2RYIOe+KK/V5K71uqXTwfl2A+aowExAhnHDnvIqmLo00Xq1dX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724040487; c=relaxed/simple;
	bh=EdjsfFNyq71mMomOZiIHYI68CMDH/Zb5Vog4ryMsat8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QZ1t7NbtwsyJOer/RptgXv2rVi5Ix8Ydtnkfbh/9V+HE8RsIr1wkWnQodMVVjsBsdCIIKUL2doJnUCbe6Fm1EmDzFBJhZvxMnkuLGqQVPLtMUwWbp7uj88H4hxr5HNt5ChdDwQ1JKiisVA1wGoK6T1HfYM7iWwkHiabrH1i28xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KpeTuXhY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D453CC32782;
	Mon, 19 Aug 2024 04:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724040486;
	bh=EdjsfFNyq71mMomOZiIHYI68CMDH/Zb5Vog4ryMsat8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KpeTuXhYkmanBaAwFma2Go5u0uQDbGwUcEd4/G7VugViYxmzDwFK2F8n5YVo/jjIS
	 AuK+oCUT2B26M8NBeUbsZgu6cfg10dQLgq26uHAmvb9UEyvz/rnfQaNSXmnoCHAl4v
	 o5HFeINmu8aa0AkMmCDhK18EIhqo9OFDoUbJGZL5BqBXnNlQOeX+8BXruEG4SKWi9t
	 cY3awa+Ke42wAImV8Lumj3Pg9XHfjMeZ/kYFJy/fQMQjfatLYa9pPfY+ED/bDafOzz
	 F0OSwQY2oD++gomMxUeRrFuK2uI7g+BH6zrc8uv2jnXtbAZdhgrth+r6UXVPNV9Anw
	 nx3pua7c+5Psw==
Message-ID: <55ca393e-e2e9-45ef-8eb0-050d79c92987@kernel.org>
Date: Mon, 19 Aug 2024 13:08:04 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] zonefs: add support for FS_IOC_GETFSSYSFSPATH
To: Liao Chen <liaochen4@huawei.com>, linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, naohiro.aota@wdc.com, jth@kernel.org
References: <20240809013627.3546649-1-liaochen4@huawei.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240809013627.3546649-1-liaochen4@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/9/24 10:36, Liao Chen wrote:
> FS_IOC_GETFSSYSFSPATH ioctl expects sysfs sub-path of a filesystem, the
> format can be "$FSTYP/$SYSFS_IDENTIFIER" under /sys/fs, it can helps to
> standardizes exporting sysfs datas across filesystems.
> 
> This patch wires up FS_IOC_GETFSSYSFSPATH for zonefs, it will output
> "zonefs/<dev>".
> 
> Signed-off-by: Liao Chen <liaochen4@huawei.com>
> ---
>  fs/zonefs/super.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> index faf1eb87895d..e180daa39578 100644
> --- a/fs/zonefs/super.c
> +++ b/fs/zonefs/super.c
> @@ -1262,6 +1262,7 @@ static int zonefs_fill_super(struct super_block *sb, struct fs_context *fc)
>  	sb->s_maxbytes = 0;
>  	sb->s_op = &zonefs_sops;
>  	sb->s_time_gran	= 1;
> +	super_set_sysfs_name_id(sb);

Can you resend the patch with this call moved to the beginning of
zonefs_sysfs_register() in fs/zonefs/sysfs.c ?
Thanks.

>  
>  	/*
>  	 * The block size is set to the device zone write granularity to ensure

-- 
Damien Le Moal
Western Digital Research


