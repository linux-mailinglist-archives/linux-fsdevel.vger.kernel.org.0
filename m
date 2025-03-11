Return-Path: <linux-fsdevel+bounces-43682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DADB2A5B78D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 04:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25ECA16EB74
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 03:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9DF1EA7FC;
	Tue, 11 Mar 2025 03:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j85LexJZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67EA1BDCF;
	Tue, 11 Mar 2025 03:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741665182; cv=none; b=e24ShVqVzUaTGBYt/w9VB9rhQxYJslRJMhJemqTfprOHhCufP+PWCyGv8Pz+g0FCPVkAw42keRfraY6rxfzg3WGzQAc9AiIr7motrJ3hog42UP2yOmRbM3bszqSBZtjqvSTTx1Y8dKqM64a8NnCUzifDI3B9aP2YpiCkb/9Hh+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741665182; c=relaxed/simple;
	bh=wObK4ozB9xEfsSUgCdEnIAqZpRvq5VixWqJ1cPi+P6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMeT/efYCmDke3k4kRpMQ8iwPC/OfVbIW6CtYqkqe6iLCoC7lGvI4v3L7N+jZLJ8veBG+4vtu8cUaRTyiZ54AVNDfsNGIvr7Q4aOXXb6lF71y9U70jn5LIM94wwnHMrzSdl4xbPew5jdiBSB1AllArtgBvBZMOx6IaTH/0K2DhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j85LexJZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB2DC4CEE9;
	Tue, 11 Mar 2025 03:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741665182;
	bh=wObK4ozB9xEfsSUgCdEnIAqZpRvq5VixWqJ1cPi+P6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j85LexJZ3mYodlt37OpRskxSH76n84hGTJXSOwTei3UGQyf1tyQ1Rz4vME1aUNiqv
	 IUR+qE3cvpSyFd03iEWmCHGg/1IvIJgW8tWVk/oAEDaJEOskYyoSVmX78eXrNRGbo1
	 PKmUregEcl9dcNtlZYeReDQ+wZbEPvCMHKpnPvuxXGqcE03kCI2O0u1G5sLFVfKS2C
	 6q8/eB/fR/gDF8SaxLrYt1+jUNsUaREch6ABR60WsTzGSesIabOefQlUOI0uZGGycY
	 7JugE+NZDnotSa95kLMevfhRzX50ubwiABVzI1yFeJc1Wbglip5tUy4+c/KLltivVD
	 rJxFJeNcGUBZw==
Date: Mon, 10 Mar 2025 20:53:00 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Ruiwu Chen <rwchen404@gmail.com>
Cc: corbet@lwn.net, joel.granados@kernel.org, keescook@chromium.org,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
	zachwade.k@gmail.com
Subject: Re: [PATCH v2] drop_caches: re-enable message after disabling
Message-ID: <Z8-znMyjTx0kw4-l@bombadil.infradead.org>
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

The way these flags are designed are bits in a flag. If you want to
disable the flag, it'll be disabled. If you want it added it must be
added as a flag. So what I did was just remove the or logic as that
just keeps it on forever. With XOR you end up where if you had it
enabled and then want to enable it again, you disable it.

1 xor 1 = 0

The simple variable setting just always sets it and puts the burden on
the operators to read the existing setting if they don't want to disable
prior settings.

  Luis

