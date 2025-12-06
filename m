Return-Path: <linux-fsdevel+bounces-70931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EED6ECA9F79
	for <lists+linux-fsdevel@lfdr.de>; Sat, 06 Dec 2025 04:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6DE230AD6AE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Dec 2025 03:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A8E296BCD;
	Sat,  6 Dec 2025 03:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="pGLoFvrt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02C825C809;
	Sat,  6 Dec 2025 03:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764990625; cv=none; b=ldZC9mFySZjHpA4wBEQZsQ4QaFasGa2vN3AgJn0HuX5M915b7PdyuRkIl6WSPRTuXV2nwYSnJHlAf9evjTmsEj+XYbfxogF+eZspCPKbbxC/nVuzHFdY7DkyPMsaB2Keu92/l1vZLNouk0aieXteqfGY9X+c+J8HLoFRkXGp5M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764990625; c=relaxed/simple;
	bh=P16d0O5MHnthzEBH207y0zYurodEqmEbhGuyCTinR/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gzOOTKMm7PIDEQJuRorjg7m8gzhpBJCghmjF6kPyTIDQXQFdzzU0UqRAsBIpEv5CJxoW933L0O55kbqGP/K+4wJq94QgsGNRRyKsapAdPpdZ7L14vXNTCTMvcLuZk0Wyk3V9GQOk9Fot40uu6D7uWnglZWrkuUDk1ZNUOko1XQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=pGLoFvrt; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RJ9hhFfjO2TAFpC58us8Dx8MqMT1C2R+KM2QmzUCCbY=; b=pGLoFvrt/wFFEOIuP4M/+I5evp
	7YG40zb4TcPli1xSlbFrRwKrTs7gB85wC87YAJAzJh8+qvWvPou9OuA28xYzTm2sAhs9CC8S+MlE+
	z8hbSGXI4A6o42k+Fv0yIF/OX8YR87TZH2SIxeghN73anihC0TX7Qijyt8zG260lm8eQ3Yp1l9+Io
	pNNTk7zQ1NEDRdoX75eouTHW9f5AsgvTPgMLgMte+CYkKJmhONwUPWuD3wABz856mK/oI6erVkGDu
	sv/2O4Ciy0EEX7XXgcYoDp9rM6ns/rLYB5MidmX4E8bJf5W1ItxbQhpdqtastxXZbCNwtrbX0YeXy
	ydNcOzGQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vRigz-00000005X3i-1dSj;
	Sat, 06 Dec 2025 03:10:41 +0000
Date: Sat, 6 Dec 2025 03:10:41 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] fuse update for 6.19
Message-ID: <20251206031041.GQ1712166@ZenIV>
References: <CAJfpegunwB28WKqxNWCQyd5zrMfSif_YmBFp+_m-ZsDap9+G7Q@mail.gmail.com>
 <CAHk-=wht097GMgEuH870PU4dMfBCinZ5_qvxpqK2Q9PP=QRdTA@mail.gmail.com>
 <20251206014242.GO1712166@ZenIV>
 <CAHk-=wg8KJbcPuoRBFmD9c42awaeb4anXsC4evEOj0_QVKg0QQ@mail.gmail.com>
 <20251206022826.GP1712166@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251206022826.GP1712166@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Dec 06, 2025 at 02:28:26AM +0000, Al Viro wrote:
> On Fri, Dec 05, 2025 at 05:52:51PM -0800, Linus Torvalds wrote:
> > On Fri, 5 Dec 2025 at 17:42, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > Far more interesting question, IMO, is what's to prevent memory
> > > pressure from evicting the damn argument right under us.
> > 
> > That was my first reaction, but look at the 'fuse_dentry_prune()' logic.
> > 
> > So if the dentry is removed by the VFS layer, it should be removed here too.
> 
> Sure, ->d_prune() would take it out of the rbtree, but what if it hits
>                                 rb_erase(&fd->node, &dentry_hash[i].tree);
>                                 RB_CLEAR_NODE(&fd->node);
>                                 spin_unlock(&dentry_hash[i].lock);
> ... right here, when we are not holding any locks anymore?
>                                 d_dispose_if_unused(fd->dentry, &dispose);
>                                 cond_resched();
>                                 spin_lock(&dentry_hash[i].lock);

... and with what fuse_dentry_prune() is doing, we can't grab ->d_lock
or bump ->d_count before dropping dentry_hash[...].lock.  ->d_release()
is the one called outside of ->d_lock; ->d_prune() is under it, so we'd
get AB-BA deadlock if we tried to do that kind of stuff.

Moving the eviction to ->d_release() might be doable; then we'd have
fuse locks outside of ->d_lock and could call that thing under those.

I'll need to poke around some more, but TBH I don't like that primitive -
it's really easy to fuck up and conditions for its safe use are, AFAICS,
never spelled out.

