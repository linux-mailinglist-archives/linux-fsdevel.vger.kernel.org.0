Return-Path: <linux-fsdevel+bounces-42215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3785DA3EF2E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 09:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 867CE703612
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 08:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6203F201116;
	Fri, 21 Feb 2025 08:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCu+YRl4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9CB20124F;
	Fri, 21 Feb 2025 08:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740127932; cv=none; b=uZjjsbdpXM4qjQt8eayCHZydQesvsYZ4KGLdVWDEbjyuyRfwSs/fhMexHmMivdEbQrvsU3hiZC5gzEjyUaaEwTvkrlrnW94O+8rc2GeWKBjWLF1j42AxjexHIH1sdq3j3faz9iLDaruMB48UPpzi0qg8oXqbrcH/00vtbRDuWvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740127932; c=relaxed/simple;
	bh=wTULhV7AF701PwVTRWQO7EcuUWBSLUkVy6JxQGePYE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Om637xumBeg4CC5IGhSHMChOvq3dKSa+8wlbtdWHDULplJxuVsQ26ahZbqWSFdNzPjGfN4ieXSmi1epwG5yil9+gn2b/bQ/X7gZd+mbnCg/yf8+G+QGMEmH0JeqYPGCqFFHDH7q7qqxnQ1rXb5TmrWOSgLTRGHuVIbmKLEUAEdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCu+YRl4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A2CC4CED6;
	Fri, 21 Feb 2025 08:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740127932;
	bh=wTULhV7AF701PwVTRWQO7EcuUWBSLUkVy6JxQGePYE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BCu+YRl4uiJv2Ywav8lAxlrY+/ebW9nCGAB5+ohL3p86ptH7qmeaCltMiqNWIwMzP
	 MsWf4h7S/6qkHzuHOO2auyc4JMpsVLc4YyziXt1DVkVrpk5x7ui69I5xhPCvTGH5ol
	 lWCNoEOdtDlphJZuZ+1YGLzmWkKkpgC6Q7CSmAjTlHC2wwwZH60CHaUQ0mqFoMHHla
	 MloEOX8XH3MSjsCQAOibQaxzyrBhufpdzL0/8CaTwL4VCaQ/fXUv7C7882IodbskAX
	 e/MrGgZVGOnOwa3SBYAMgDfQv2xHPrA+fONjngpp45E6HP2/3McnJJXUjb5lgP8AdW
	 fMpvVnLRX9izA==
Date: Fri, 21 Feb 2025 09:52:06 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Ruiwu Chen <rwchen404@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, kees@kernel.org, 
	zachwade.k@gmail.com
Subject: Re: [PATCH] drop_caches: re-enable message after disabling
Message-ID: <gaudctcql2i4k5wjlkk2fb7z3fitjs2yyhcr5obcxxbizrnvkb@soswsw25g437>
References: <20250216101729.2332-1-rwchen404@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250216101729.2332-1-rwchen404@gmail.com>

On Sun, Feb 16, 2025 at 06:17:29PM +0800, Ruiwu Chen wrote:
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

note that vm_table will no longer exist in the next version. Please
rebase this on top of sysctl-next

Best
>  	},
>  	{
> -- 
> 2.27.0
> 

-- 

Joel Granados

