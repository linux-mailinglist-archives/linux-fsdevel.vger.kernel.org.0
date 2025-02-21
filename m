Return-Path: <linux-fsdevel+bounces-42214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6538A3EF0D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 09:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCFE97A3FC3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 08:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9562010E3;
	Fri, 21 Feb 2025 08:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DU92QVKI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20881433BE;
	Fri, 21 Feb 2025 08:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740127829; cv=none; b=seILYsmFXdFPwmHxkZc/c6KWSjGv2EKSmmlPL5NzNGNwWzvGhw9w561oDBMBUUS9fyx7vqR+wF4H5ngMFcuS49i9usVhkN5uId7QHZh5t5hZc7l4hAyHJ7TGL7TBvzcG++KWFn7N7D9UM5ZCBwdjXw15BuJ1LQ03XkAiJ1Enfkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740127829; c=relaxed/simple;
	bh=axQi25O4nTiog6gbJDtb/nAnfcR7uVFto49NXDcOyws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SVKlLfZ/hA02HZRN7Lns6oTsIY6hh09WPR/LGndPmi8rDK4SDtMXjAPh/RuaTZIrQcxYBvV93b0U2tLQ3ile6lImpDDWJrFR3oP+MYWJLeHcC54bUjb0fgob2nXj9Nd0othwHYNfh60p0AmL8hEPDguv1QgAqIu8wzN2vbj6Sns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DU92QVKI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 491D8C4CED6;
	Fri, 21 Feb 2025 08:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740127828;
	bh=axQi25O4nTiog6gbJDtb/nAnfcR7uVFto49NXDcOyws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DU92QVKIXIRvKkuf0Oavi/6oyYKG3Gtbdn+QZ2+yTWXwNtJfg9sfQbI4HS9RIwLPY
	 P10cLbjArgzUpGJ3F2MiUtOL2S2y4/lPVUC7kYUQRB+Gs+j9Y1h4jtL3AQJmj+DJYD
	 QpmcA0BynA5BtrpDvdXabz/8aV7ghoRYL5yE1rOHGAQ8gVbsD8hfhYxgGjEsZaBMtf
	 GzV08g++FLQwR24KzgZ5p6Kg8KdCsJXmViV55muo/m98P604Ew3bIEDLKGNDneZpJh
	 hU6ma4y+9TNut/025BpGrS1UR2P3XVW8dydOR0AdP2p07yuJ6jxvPvQ1yjscN2BrIg
	 /TYVKh9/WBMUw==
Date: Fri, 21 Feb 2025 09:50:23 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Ruiwu Chen <rwchen404@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, kees@kernel.org
Subject: Re: [PATCH] drop_caches: re-enable message after disabling
Message-ID: <virvi6vh663p5ypdjr2v2fr3o77w5st3cagr4fe6z7nhhqehc6@xb7nqlop6nct>
References: <20250216100514.3948-1-rwchen404@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250216100514.3948-1-rwchen404@gmail.com>

On Sun, Feb 16, 2025 at 06:05:14PM +0800, Ruiwu Chen wrote:
> When 'echo 4 > /proc/sys/vm/drop_caches' the message is disabled,
> but there is no interface to enable the message, only by restarting
> the way, so I want to add the 'echo 0 > /proc/sys/vm/drop_caches'
> way to enabled the message again.
> 
> Signed-off-by: Ruiwu Chen <rwchen404@gmail.com>
> ---
>  fs/drop_caches.c | 7 +++++--
>  kernel/sysctl.c  | 2 +-
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/drop_caches.c b/fs/drop_caches.c
> index d45ef541d848..c90cfaf9756d 100644
> --- a/fs/drop_caches.c
> +++ b/fs/drop_caches.c
> @@ -57,7 +57,7 @@ int drop_caches_sysctl_handler(const struct ctl_table *table, int write,
>  	if (ret)
>  		return ret;
>  	if (write) {
> -		static int stfu;
> +		static bool stfu;
>  
>  		if (sysctl_drop_caches & 1) {
>  			lru_add_drain_all();
> @@ -73,7 +73,10 @@ int drop_caches_sysctl_handler(const struct ctl_table *table, int write,
>  				current->comm, task_pid_nr(current),
>  				sysctl_drop_caches);
>  		}
> -		stfu |= sysctl_drop_caches & 4;
> +		if (sysctl_drop_caches == 0)
> +			stfu = false;
> +		else if (sysctl_drop_caches == 4)
> +			stfu = true;
>  	}
>  	return 0;
>  }
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index cb57da499ebb..f2e06e074724 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -2088,7 +2088,7 @@ static const struct ctl_table vm_table[] = {
>  		.maxlen		= sizeof(int),
>  		.mode		= 0200,
>  		.proc_handler	= drop_caches_sysctl_handler,
> -		.extra1		= SYSCTL_ONE,
> +		.extra1		= SYSCTL_ZERO,
>  		.extra2		= SYSCTL_FOUR,
>  	},
>  	{
> -- 
> 2.27.0
> 

All this has changed with Kaixiong's move of the vm_table.

Please rebase this on top of sysctl-next [1] and send a V2

Best

[1] https://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git/log/?h=sysctl-next

-- 

Joel Granados

