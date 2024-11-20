Return-Path: <linux-fsdevel+bounces-35358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8936A9D42B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 20:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F8D92814CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 19:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E0E1BC097;
	Wed, 20 Nov 2024 19:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LASiGZnG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC65158A13;
	Wed, 20 Nov 2024 19:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732132403; cv=none; b=FsrqQy+S2jFA+IFJmadTchfdgBheoVPqqcgwz6msWWe+Nt6pj8v03xYBhX1lZzV5py+3D3z81+y1fBAq0TZuyGdNH6jHGyee4mdN9KwG0I/Yatf/Iiip+l3TrbfBN7Wpx26ZJtA8kf+JWJ5uX3e4bKM/rjP5B3+gBJKRqgYBtGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732132403; c=relaxed/simple;
	bh=l9vFcmIOARYEeiElffp9ka1rRq/PA8iJrYSAWfNNmdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nxbSspKbjFFskgYQ1mZpnim2caghq0iLkC842aLQxpYGt2iXRQYopqUi9phB9FmG/eDP1xtKLU/bmYWwRDdW3CAHWrC/GpZnfRNm6qV5eYBIQkj7kazIPekda1uYYyI02wEVKvwogCnWS6Qq1sn9NocoBepJfCzNkzS9m+bbQYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LASiGZnG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 840ACC4CECD;
	Wed, 20 Nov 2024 19:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732132403;
	bh=l9vFcmIOARYEeiElffp9ka1rRq/PA8iJrYSAWfNNmdo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LASiGZnG6Q1j0BLvMxB8PuWJB5gv4P0Ga3AXUvr7dj8r7BWkt7Phtec1IOJEtKkdL
	 Tge3l0Izr0vpx4Tqi5Xp6a11AJG44JJ89XxrWH7gAYHgmieJFr5oGz02284n7HkalS
	 jb6jGOWSchDyBTCGFbimCpXHvqqBImSa4Z2HxRy5yw2lSv8oZofoy2LvR5hSkjcvDC
	 OOaDfvLuVE5eMmbMlvK6Tc4clPsUOGY7TQnfoLbpz6mNfpMJ3lVAfThus8pfdQFEsd
	 RwKk8smGSyorrHCP1DGLNwwfxl5c/GBYkQbqW9cbwhaQXoPmY3x2Ynf89y1bv5PsgW
	 qvxzbX+jKHCiQ==
Date: Wed, 20 Nov 2024 20:53:19 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] vfs netfs
Message-ID: <20241120-zwinkert-lahmlegen-a634a009244f@brauner>
References: <20241115-vfs-netfs-7df3b2479ea4@brauner>
 <CAHk-=wjCHJc--j0mLyOsWQ1Qhk0f5zq+sBdiK7wp9wmFHV=Q2g@mail.gmail.com>
 <20241120-abermals-inkrafttreten-8b838a76833f@brauner>
 <CAHk-=wicQOQ1mkZqtX0eEWOxBG9Dih+b3DvmGnyY2oVe2vn8RQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wicQOQ1mkZqtX0eEWOxBG9Dih+b3DvmGnyY2oVe2vn8RQ@mail.gmail.com>

On Wed, Nov 20, 2024 at 09:09:44AM -0800, Linus Torvalds wrote:
> On Wed, 20 Nov 2024 at 00:49, Christian Brauner <brauner@kernel.org> wrote:
> >
> > The base of the branch is definitely v6.12-rc1. The branch is simply
> > vfs.netfs with vfs-6.13.netfs tag. And the branch looks perfectly fine.
> 
> The branch looks fine, it was just the pull request that contained old
> stale commits that you had already sent me.
> 
> > I think the issue was that I sent you the fixes tag you mention below
> > that contained some fixes that were in vfs.netfs. So afterwards I just
> > didn't rebase vfs.netfs but merged two other series on top of it with
> > v6.12-rc1 as parent. And I think that might've somehow confused the git
> > request-pull call.
> 
> Oh, you shouldn't rebase. But it also sounds like you are actually

I don't as I'm well aware how much you dislike that. Here I had a bunch
of fixes and I usually carry them on a separate branch and have another
feature branch for new stuff. But in this case I ended up using the
branch for some hot fixes instead of carrying them on the separate
vfs.fixes branch. But when I pulled in the features I should have
reset/rebased the branch.

> tracking the bases for your branches manually. You shouldn't do that
> either.
> 
> All you need to do is fetch from upstream, so that git sees what I
> have, and then when you do the pull request, you tell it not the base
> of the branch, but just what upstream has. git will then figure out
> the base from that.

Yeah, that's what I do. I do a git fetch upstream and then just point
git request-pull to that and then things work fine.

Anyway, thanks for pointing it out and sorry for the confusion.

