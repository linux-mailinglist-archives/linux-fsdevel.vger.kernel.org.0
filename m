Return-Path: <linux-fsdevel+bounces-20424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C788D31DF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 10:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F37CB288637
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 08:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F1F16D323;
	Wed, 29 May 2024 08:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VT9CDmMF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328DC169ADE;
	Wed, 29 May 2024 08:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716972174; cv=none; b=JQY9QEiuTDF22zvt/Vz8yGuI4oXUrmew7FSeyuMQ5c+cPxyrJSt3RpjyEYr4ZqJbxTnqVOQuWV2IYbN3Rtlf7BZejyrdt49dByT7frWQs6qoAiA6iuwg/ke8Cm7RUkYCX0YIu19Pb0QueGPXymiE2A7LIVwaGaDKlywpDwcbsFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716972174; c=relaxed/simple;
	bh=dozG0uhTg6br9/HN6Z88jrmhk6JccvKwrlY2nxHhs54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JuIVkBWl8mccClVXSaE7Y09PooHToLLvmWHYH1W9O8cZ5sJd/41RLQNoI5nGC+dEDlbUcFDUZ+s/Mys5lSQ2wdAhaaOY39B5yGIYvnQH8MB5VknYLOZLYkmtk0q6atgmZgQP+vGYd1Mb4MJc25/CRd+xo67m5nzeW8z3c6/TWQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VT9CDmMF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C1A1C4AF09;
	Wed, 29 May 2024 08:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716972173;
	bh=dozG0uhTg6br9/HN6Z88jrmhk6JccvKwrlY2nxHhs54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VT9CDmMFIqK6PoAV/3D2ey8mjcw4J6OqlT2p0xpDVZ75EDMtDrwQLyQDHBMJqpnk5
	 SBG1WJ7vXFppgRibq+WRvG3c3MmQbnt6UBo8wp1qcZBiGLmHkK4Khv5gEP5B9JXv7r
	 z5Kan3lA0qSq+T9fnKFRYHBuaiYSgEmiFTJmrPpFm/+rvHV7yP5L9/qHbfNMIsUe+/
	 /5ZGbPk/DH/KGKgfLq27YtBjG2yaCNcWz+fY+RL0rGkqs7p/iTIZQovlRhqVPrfKJ4
	 dPuZPub3yBBuYtRnTA633SlkDhd0ANg1ZBNqFWPejZdChLSIkQb6W4b2DoUhgBunQF
	 6+ImrFpn8GZYg==
Date: Wed, 29 May 2024 10:42:48 +0200
From: Christian Brauner <brauner@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, kent.overstreet@linux.dev, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, adilger@dilger.ca, 
	ebiggers@kernel.org
Subject: Re: [PATCH] statx: Update offset commentary for struct statx
Message-ID: <20240529-ballkontakt-vergibt-b7f8c960eed5@brauner>
References: <20240529081725.3769290-1-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240529081725.3769290-1-john.g.garry@oracle.com>

On Wed, May 29, 2024 at 08:17:25AM +0000, John Garry wrote:
> In commit 2a82bb02941f ("statx: stx_subvol"), a new member was added to
> struct statx, but the offset comment was not correct. Update it.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> 
> diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
> index 67626d535316..95770941ee2c 100644
> --- a/include/uapi/linux/stat.h
> +++ b/include/uapi/linux/stat.h
> @@ -126,8 +126,8 @@ struct statx {
>  	__u64	stx_mnt_id;
>  	__u32	stx_dio_mem_align;	/* Memory buffer alignment for direct I/O */
>  	__u32	stx_dio_offset_align;	/* File offset alignment for direct I/O */
> -	__u64	stx_subvol;	/* Subvolume identifier */
>  	/* 0xa0 */
> +	__u64	stx_subvol;	/* Subvolume identifier */
>  	__u64	__spare3[11];	/* Spare space for future expansion */
>  	/* 0x100 */
>  };
> -- 
> 2.31.1
> 

Thanks, applied.
But note that your patch format seems to have tripped b4. I had to apply
it manually.

