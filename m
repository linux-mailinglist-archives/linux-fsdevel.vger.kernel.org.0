Return-Path: <linux-fsdevel+bounces-24295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF91C93CEB4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 09:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70E2D280352
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 07:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5C33B182;
	Fri, 26 Jul 2024 07:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lEYGlUQ7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A70225D7;
	Fri, 26 Jul 2024 07:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721978205; cv=none; b=I98Ko44MJ/nzlVNqvA5JS2gUqlRx1WN6pLAQ7Ug6GVuZM3Tcgv/G4Y4YiZeHX2HILG/WviCJInzWW5b7+firSEiYOuDy8ydFiOhJDQFaH2XWGlwnufg/8ADwHFx9n4xPIUpEyJCSnLysu32t+PhGPMcLdW7gEK4npNm5gbMutdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721978205; c=relaxed/simple;
	bh=R7s/9DscrxObnvN82uqAsd/AYHOJu2ni1j6Otc9szoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sj734HELvTtDUlLkAMdBre7XcqIFNEzQuLnTvEEkn5fzr0WXO8qt1l9DL9hl3FxFoJ2lOP0gDAHBbAhwABPbQRQFFVdCBKV7XoWsXAuZ3OuStz20xt93rwLRPX5X00/FzP/0WMGTTfl+Z4fV/N4iBRcG5CfxbpbjnixIELQy4cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lEYGlUQ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B707C4AF0A;
	Fri, 26 Jul 2024 07:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721978204;
	bh=R7s/9DscrxObnvN82uqAsd/AYHOJu2ni1j6Otc9szoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lEYGlUQ7D8cCOeBG2TBxwFNtepcGHtMTZzKr0I/4ssKMT4pU2p1zsc0iXXwzPijEL
	 gLP4Z6MlYYMTGLK8nx7ylrYwigbj4E2PMNo0uO2zh9Tw61p7youli5+Rq78mdXDMFa
	 R7BZkoDpqa35Rmm1VTHhzW6K5NHv1pb+zJBzsK4+9jJ+I/DCfl1XK+qRypXWREUh6g
	 CRA3SzytsSrksKDQdCvT0B5WKba4aAzom5hjTV5h9YEPn1ilZLApMWHAFH1SENfmr+
	 8XcUJ0kSde6oSZ/JiPTE9VUXPR5jiSlSa+T38BH+fsy2bjo6LCDu2xYFHO9mIxqqSe
	 qX7Tyw5ZtMWeA==
Date: Fri, 26 Jul 2024 09:16:40 +0200
From: Christian Brauner <brauner@kernel.org>
To: Youling Tang <youling.tang@linux.dev>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Youling Tang <tangyouling@kylinos.cn>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] fs/direct-io: Remove linux/prefetch.h include
Message-ID: <20240726-resozialisieren-ratschlag-f83eda1f95ef@brauner>
References: <20240603014834.45294-1-youling.tang@linux.dev>
 <20240603111844.l4g2yk5q6z23cz3n@quack3>
 <cfce353d-e5b0-47be-9a02-be4558d4dc33@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cfce353d-e5b0-47be-9a02-be4558d4dc33@linux.dev>

On Wed, Jul 24, 2024 at 03:33:38PM GMT, Youling Tang wrote:
> Hi,
> 
> On 03/06/2024 19:18, Jan Kara wrote:
> > On Mon 03-06-24 09:48:34, Youling Tang wrote:
> > > From: Youling Tang <tangyouling@kylinos.cn>
> > > 
> > > After commit c22198e78d52 ("direct-io: remove random prefetches"), Nothing
> > > in this file needs anything from `linux/prefetch.h`.
> > > 
> > > Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
> Sorry to bother you, but do we still need this patch?

It's in the vfs.misc pile for next merge window.

