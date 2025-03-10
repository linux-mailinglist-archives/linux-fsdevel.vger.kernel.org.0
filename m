Return-Path: <linux-fsdevel+bounces-43844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 337EAA5E694
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 22:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A92D73B57D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 21:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8F01F09B5;
	Wed, 12 Mar 2025 21:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NkauvbMZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B661F09A8;
	Wed, 12 Mar 2025 21:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741814630; cv=none; b=CkWiwL6iRH3wCvQlgniO3Dw4V5YVULDdd6jjDNawdiUiVx6Pv2pTmYtimsRFjvLwQC+B43mrdzyNyauC8KKNch48qfNSAz+en+ivI8EWQs/qK9qNoy5J+q4bto6O9wfaB03/iD3RaRXtMGwAfBFOBOwX/txU+Ly0sCmLOiDYQmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741814630; c=relaxed/simple;
	bh=xHL+MXLk8oTL6JktnRTqQNOjTVW4eIBGCZKvQxz6iNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MjMA08nci0HnhBE/W+MeXDc57M6Mw1XUS5nQoI8ZQvAPGTk6viP9/fK6Rn8LmDL+fmexc0QpedvReTLIJ19uAIkh0c5h9M7XaP8hS+mOa9C1XopTVFhzYf5Ogp3hsgtsXMKGE95+ALs4cCb/sviw1+WSi1HUo9F3XKBH8kNgLiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NkauvbMZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8012C4CEDD;
	Wed, 12 Mar 2025 21:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741814630;
	bh=xHL+MXLk8oTL6JktnRTqQNOjTVW4eIBGCZKvQxz6iNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NkauvbMZ7KhZaA+uaw5PFaE1H57K5JMNxYkinpXh1jtBfCQESM1QsyXChyy0F/VPx
	 7/xjhVS9cFep4gRdypc2UpPx9qG8M+1BGsoHa7IEth/nKJ55rk0sypINr8RzoSEjJY
	 LqT4Ab9IbHdSHj9hy+3gG5CiGCBlYOyQJrMMSqrRw7bUxgaMFXBPNBGg8qGZ7PbeKo
	 d1+7vPvFYrs4tLZ+USMobqnzooFZPzbXFeEsOQocWk9PrGhpF5H84QX6zDpqh3YJAs
	 7wxGPZw+uLS7zSvifegFb9kSjgVD/nWYWjgKjbAEd+DbOlWKfjUisgqw+TXvfwqlxi
	 bPSb1iQTshuFQ==
Date: Mon, 10 Mar 2025 14:51:11 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Ruiwu Chen <rwchen404@gmail.com>
Cc: mcgrof@kernel.org, corbet@lwn.net, keescook@chromium.org, 
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	viro@zeniv.linux.org.uk, zachwade.k@gmail.com
Subject: Re: [PATCH v2] drop_caches: re-enable message after disabling
Message-ID: <zaiqpjvkekhgipcs7smqhbb7hqt5dcneyoyndycofjepitxznf@q22hsykugpme>
References: <Z7tZTCsQop1Oxk_O@bombadil.infradead.org>
 <20250308080549.14464-1-rwchen404@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250308080549.14464-1-rwchen404@gmail.com>

On Sat, Mar 08, 2025 at 04:05:49PM +0800, Ruiwu Chen wrote:
> >> When 'echo 4 > /proc/sys/vm/drop_caches' the message is disabled,
> >> but there is no interface to enable the message, only by restarting
> >> the way, so add the 'echo 0 > /proc/sys/vm/drop_caches' way to
> >> enabled the message again.
> >> 
> >> Signed-off-by: Ruiwu Chen <rwchen404@gmail.com>
> >
> > You are overcomplicating things, if you just want to re-enable messages
> > you can just use:
> >
> > -		stfu |= sysctl_drop_caches & 4;
> > +		stfu = sysctl_drop_caches & 4;
> >
> > The bool is there as 4 is intended as a bit flag, you can can figure
> > out what values you want and just append 4 to it to get the expected
> > result.
> >
> >  Luis
> 
> Is that what you mean ?
> 
> -               stfu |= sysctl_drop_caches & 4;
> +               stfu ^= sysctl_drop_caches & 4;
> 
> 'echo 4 > /sys/kernel/vm/drop_caches' can disable or open messages,
> This is what I originally thought, but there is uncertainty that when different operators execute the command,
> It is not possible to determine whether this time is enabled or turned on unless you operate it twice.

So can you use ^= or not? And what does operate it twice mean?

Best
> 
> Ruiwu
> 
> >
> >> ---
> >> v2: - updated Documentation/ to note this new API.
> >>     - renamed the variable.
...
> >> @@ -85,7 +88,7 @@ static const struct ctl_table drop_caches_table[] = {
> >>  		.maxlen		= sizeof(int),
> >>  		.mode		= 0200,
> >>  		.proc_handler	= drop_caches_sysctl_handler,
> >> -		.extra1		= SYSCTL_ONE,
> >> +		.extra1		= SYSCTL_ZERO,
> >>  		.extra2		= SYSCTL_FOUR,
> >>  	},
> >>  };
> >> -- 
> >> 2.27.0
> >> 

-- 

Joel Granados

