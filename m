Return-Path: <linux-fsdevel+bounces-28500-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6400596B558
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 10:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 197B51F20623
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 08:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD461D1749;
	Wed,  4 Sep 2024 08:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJ/rg0pj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CEB1CDA20
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 08:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725439375; cv=none; b=jXGYF5QDaP3SegFxz1TxfLItGN02/kKf1gmX2hw/JAXjaDMwEe7WRy059f8cuyo7lc9WFXsltnNKXvkeEbv6KoHKQ74IREqRk2Yg1w/RghOr/I92wGKOPhnghc7LciU7W99TJLmyBleoUXRvtn2FpkW/RSMmzZDiX/M4LEZnisc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725439375; c=relaxed/simple;
	bh=xKZBluvkbAKSstSoxzBb+8HhTTN/uLkHKCKvOKCgba8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h96j++Wc0CXRLvwsKGyvcJWtyb+3BGKDi+x6iJsQeawkvJbsJ5tEAsKTCt8JruXgjXM0hNCRv/7e73nDbLuThvWplHJxBXytk74dPxCjhfAOYaCDxHm0aBiAxq6VPA+uFuhw3QRNLwG855DfgWZmeyrfoC1y4E9EJ468CCjSo7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJ/rg0pj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8793C4CEC2;
	Wed,  4 Sep 2024 08:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725439375;
	bh=xKZBluvkbAKSstSoxzBb+8HhTTN/uLkHKCKvOKCgba8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GJ/rg0pjGgFe19lnu75lwEA2U4JbVy0HAWzZOeAJSmMC2ijfc5sbhWt0CKKrSqTD1
	 uz7Rs+ozij0E5vScyRGOZ0S2MqaIGfJsdrPt2ft8OrjdLR+fK4OsPmu+OfkTTpDNr9
	 X2Rku+hUmVuJdvGijY1B3I32h5IvTrfijYagr65PSrJkwGXN25YjEraTEA38gedgSC
	 UCQEWYFceC32jXYKWMC+Tmb+NJ0caZHHeRI/2rnsOk4Axj76M9ZaiwspDaIsMtmSyw
	 J+4P57dJMd+Y9ZMRrhl2vJqTPBY1qo/Ct5EX5KkTCXpejNHeCInDvZD5vExuAkqSLp
	 ruycsBUeUvKfA==
Date: Wed, 4 Sep 2024 10:42:50 +0200
From: Christian Brauner <brauner@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, Jann Horn <jannh@google.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 00/15] slab: add struct kmem_cache_args
Message-ID: <20240904-stauraum-kennst-5769fa810706@brauner>
References: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
 <8d8da7d3-5a8f-4c79-84d2-90535324cdcd@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8d8da7d3-5a8f-4c79-84d2-90535324cdcd@suse.cz>

On Wed, Sep 04, 2024 at 10:25:32AM GMT, Vlastimil Babka wrote:
> On 9/3/24 16:20, Christian Brauner wrote:
> > Hey,
> > 
> > As discussed last week the various kmem_cache_*() functions should be
> > replaced by a unified function that is based around a struct, with only
> > the basic parameters passed separately.
> > 
> > Vlastimil already said that he would like to keep core parameters out
> > of the struct: name, object size, and flags. I personally don't care
> > much and would not object to moving everything into the struct but
> > that's a matter of taste and I yield that decision power to the
> > maintainer.
> > 
> > In the first version I pointed out that the choice of name is somewhat
> > forced as kmem_cache_create() is taken and the only way to reuse it
> > would be to replace all users in one go. Or to do a global
> > sed/kmem_cache_create()/kmem_cache_create2()/g. And then introduce
> > kmem_cache_setup(). That doesn't strike me as a viable option.
> > 
> > If we really cared about the *_create() suffix then an alternative might
> > be to do a sed/kmem_cache_setup()/kmem_cache_create()/g after every user
> > in the kernel is ported. I honestly don't think that's worth it but I
> > wanted to at least mention it to highlight the fact that this might lead
> > to a naming compromise.
> > 
> > However, I came up with an alternative using _Generic() to create a
> > compatibility layer that will call the correct variant of
> > kmem_cache_create() depending on whether struct kmem_cache_args is
> > passed or not. That compatibility layer can stay in place until we
> > updated all calls to be based on struct kmem_cache_args.
> > 
> > From a cursory grep (and not excluding Documentation mentions) we will
> > have to replace 44 kmem_cache_create_usercopy() calls and about 463
> > kmem_cache_create() calls which makes for a bit above 500 calls to port
> > to kmem_cache_setup(). That'll probably be good work for people getting
> > into kernel development.
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> 
> Besides the nits I replied to individual patches, LGTM and thanks for doing
> the work. You could add to all:
> 
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Too bad it's quite late for 6.12, right? It would have to be vfs tree anyway
> for that due to the kmem_cache_create_rcu() prerequisities. Otherwise I can

Imho, we can do it and Linus can always just tell us to go away and wait
for v6.13. But if you prefer to wait that's fine for me too.

And I don't even need to take it all through the vfs tree. I mean, I'm
happy to do it but the vfs.file branch in it's current form is stable.
So you could just 

git pull -S --no-ff git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs vfs.file

and note in the merge message that you're bringing in the branch as
prerequisites for the rework and then pull this series in.

My pull requests will go out latest on Friday before the final release.
If Linus merges it you can just send yours after.

> handle it in the slab tree after the merge window, for 6.13.
> 
> Also for any more postings please Cc the SLAB ALLOCATOR section, only a
> small subset of that is completely MIA :)

Sure.

