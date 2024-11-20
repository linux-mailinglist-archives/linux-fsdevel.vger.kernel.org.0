Return-Path: <linux-fsdevel+bounces-35282-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4C29D35E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 09:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A8F8B233C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 08:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C5E19B3EE;
	Wed, 20 Nov 2024 08:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/3ci7cq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A83A199E8B;
	Wed, 20 Nov 2024 08:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732092596; cv=none; b=EA1Im9E2CtarP27AZW5RJnKt9iXEw3ipNd83SM6NeXefWJ/nNjmMmXkP9jA7Z6Wki8PaF/9Ke/E6h0wTVA+p4b8ODfJVrAgiRK1UnPxqHrXicR/8cZnYx9vQUgOddDSpNqBlHX8ZyQ7+fRyPwKmCYUJieaDvoOuBxLPsH15QLhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732092596; c=relaxed/simple;
	bh=17yvpj13rJwUj4YlCynfsDAg0/81R7EvqIs+Q1YFiig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pKaZT8mZfc9af/EF6D9KO7vxRAX8Vv695xGzzFNoCeqf76R84GFW6Aae96q/IKczKtaNff/dROlkCrOWf5EFXMMMM3d/RLz4Zdu3aHM9DxQjdcYmFaT9kvKej5JZXzxHBcdm4krHm7+p2C4Hpl7AczvXw5cJVBRB1D6eOU/0HsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/3ci7cq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90001C4CECD;
	Wed, 20 Nov 2024 08:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732092595;
	bh=17yvpj13rJwUj4YlCynfsDAg0/81R7EvqIs+Q1YFiig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g/3ci7cq9nIOI9kexjaDHIx+ZsChbHM8JjOiuJkd+/NiDhHWB0NrsGyspopnxZ0fH
	 TqjrXHh76Nbq/rrTSHDakCzXr94/TG+TdJDOLZPCmAWIAU79a57if0gso14Eox6oW1
	 yFSB0yg0Fq/4ZPFQ2Hg3HRL7XOHU2j77Cqt5Ww69+S7PxcINF6ocEGgiPtEWXIb+lI
	 3CMibvqaUvGWkwgBrk1AroUzrwzX5Gafsmg5HCO42Alv/lHglNXFJiWUFqpHoShh6F
	 TRDqOFfvOp05yCgTH/AZd21yjwORcIPKbZQ9mefU+RWl1i5T9ehii41wrktNxKYkAj
	 +8FOJxr1NgTSw==
Date: Wed, 20 Nov 2024 09:49:51 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] vfs netfs
Message-ID: <20241120-abermals-inkrafttreten-8b838a76833f@brauner>
References: <20241115-vfs-netfs-7df3b2479ea4@brauner>
 <CAHk-=wjCHJc--j0mLyOsWQ1Qhk0f5zq+sBdiK7wp9wmFHV=Q2g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjCHJc--j0mLyOsWQ1Qhk0f5zq+sBdiK7wp9wmFHV=Q2g@mail.gmail.com>

On Mon, Nov 18, 2024 at 10:29:42AM -0800, Linus Torvalds wrote:
> On Fri, 15 Nov 2024 at 06:00, Christian Brauner <brauner@kernel.org> wrote:
> >
> > A pidfs patch ended up in the branch and I didn't notice it. I decided
> > to leave it in here instead of rebasing the whole branch.
> 
> What happened here?

The base of the branch is definitely v6.12-rc1. The branch is simply
vfs.netfs with vfs-6.13.netfs tag. And the branch looks perfectly fine.

I think the issue was that I sent you the fixes tag you mention below
that contained some fixes that were in vfs.netfs. So afterwards I just
didn't rebase vfs.netfs but merged two other series on top of it with
v6.12-rc1 as parent. And I think that might've somehow confused the git
request-pull call.

Rebasing would've been the cleaner thing here since I had a long time
until the merge window. But other than that it doesn't look like I did
something that was actively wrong? But I might just be missing
something.

> 
> Not only isn't there a pidfs patch in here, it also doesn't have the
> afs patches you claim it has, because all of those came in long ago in
> commit a5f24c795513: "Pull vfs fixes from Christian Brauner".
> 
> So I've pulled this, but your pull request was all wonky because you
> used some odd base commit.
> 
>               Linus

