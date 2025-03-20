Return-Path: <linux-fsdevel+bounces-44582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C85C5A6A7D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 15:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C44613AC263
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 13:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E69A223327;
	Thu, 20 Mar 2025 13:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDqOQMo+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DDC2222D7;
	Thu, 20 Mar 2025 13:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742479113; cv=none; b=ax2p4xI3ZZhzKGtojtWUU60/DzECuiGtoc0No90ywSqU1V6x9s4edaoXQK3VUol3MOzonHiYJq4Ckqmd45qP4yT80MiNBcK6bYf596QER8DEUea7ygnwEZnt/r7X4htlCWsb6oxHcykzV9hFa2UMGeG3xB9H+6nR+Shww707N3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742479113; c=relaxed/simple;
	bh=T1yVm1IgHaMGsHLCrPjoLrJLVpoT4G+2SEBmLWxuXoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubxYL+3/A0/POG1sdBOxyHrsbXSlpuTUbdg69/AP+SqHGMsaDXYF2632KpK36ibH8JaEx7MV3KCFP3NSijPCZSoF4NON+1WZc0HxYj3zbdBdAEfSOGjKqc4MlqpHOZDna7PGhDjjNMS7a5ASBfjnQEBNwDTRnAS0IXQ70fg+Oaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDqOQMo+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3CDFC4CEDD;
	Thu, 20 Mar 2025 13:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742479112;
	bh=T1yVm1IgHaMGsHLCrPjoLrJLVpoT4G+2SEBmLWxuXoA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IDqOQMo+edJbIHlcgmvb82JlMDUgOt5hg3B8PYj0PaaJAMRzxE35hRSp0Wy+snHF/
	 yxcA0lYqkrLwt9GVv5StPBWWWM0IBD/1lmlq/WpN1C+5eP5+xO8lbKICuqoOI4kN16
	 K4Kxnjd9nlNzKE9aq3ri7eDYR+bJ9Hdk9LvBtdM1AGbmaq2h1taZCqD27c97iqSRuQ
	 UzaZvgmczRPTI2HJyvwk8hmsYoBG9Sd2WK85GPqlnQlG4nLoKi/8dT1oTvuZzU4TLa
	 IBbkLYteSUIhRAzD7lXet19IG7KIkPX8qYfM6RUQu7Y0RVg3PjEZsmpPv4OWHwAs1R
	 POcqmJP0z06Zg==
Date: Thu, 20 Mar 2025 14:58:28 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fs: sort out stale commentary about races between fd
 alloc and dup2()
Message-ID: <20250320-befund-wegnehmen-048d8b9cd252@brauner>
References: <20250320104922.1925198-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250320104922.1925198-1-mjguzik@gmail.com>

On Thu, Mar 20, 2025 at 11:49:22AM +0100, Mateusz Guzik wrote:
> Userspace may be trying to dup2() over a fd which is allocated but not
> yet populated.
> 
> Commentary about it is split in 2 parts (and both warrant changes):
> 
> 1. in dup2()
> 
> It claims the issue is only relevant for shared descriptor tables which
> is of no concern for POSIX (but then is POSIX of concern to anyone
> today?), which I presume predates standarized threading.
> 
> The comment also mentions the following systems:
> - OpenBSD installing a larval file -- they moved away from it, file is
> installed late and EBUSY is returned on conflict
> - FreeBSD returning EBADF -- reworked to install the file early like
> OpenBSD used to do
> - NetBSD "deadlocks in amusing ways" -- their solution looks
> Solaris-inspired (not a compliment) and I would not be particularly
> surprised if it indeed deadlocked, in amusing ways or otherwise
> 
> I don't believe mentioning any of these adds anything and the statement
> about the issue not being POSIX-relevant is outdated.
> 
> dup2 description in POSIX still does not mention the problem.
> 
> 2. above fd_install()
> 
> <quote>
> > We need to detect this and fput() the struct file we are about to
> > overwrite in this case.
> >
> > It should never happen - if we allow dup2() do it, _really_ bad things
> > will follow.
> </quote>
> 
> I have difficulty parsing it. The first sentence would suggest
> fd_install() tries to detect and recover from the race (it does not),
> the next one claims the race needs to be dealt with (it is, by dup2()).
> 
> Given that fd_install() does not suffer the burden, this patch removes
> the above and instead expands on the race in dup2() commentary.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
> 
> This contains the new commentary from:
> https://lore.kernel.org/linux-fsdevel/20250320102637.1924183-1-mjguzik@gmail.com/T/#u
> 
> and obsoletes this guy hanging out in -next:
> ommit ec052fae814d467d6aa7e591b4b24531b87e65ec

This is already upstream as of v6.14-rc1. So please make it a diff on
top. ;)

