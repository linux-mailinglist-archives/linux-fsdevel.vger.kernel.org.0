Return-Path: <linux-fsdevel+bounces-72666-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45688CFF1D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 18:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05A3931CA9A1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 16:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041323502A0;
	Wed,  7 Jan 2026 16:08:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4781347BB5
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jan 2026 16:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767802080; cv=none; b=K2fpsXaaNf+9wFjtGOCCC9+qTnTR/hBOqjCbjuoL0cKEfepSgpqm91hE7AK91SILM6Sz853vHcQ2dXIk0SrjjolzmLx634OBO40460CDGSEGX7CtkwshJdFt31WueBvpNUf0hgYk2uTNDQLzKWBDy1BaWZ8TtW0CYKZx3EHfnUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767802080; c=relaxed/simple;
	bh=Il744ou4Bbhex/RR/r/iQqA2E6JbVCBGIgq6pQPUh7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0qKOS75usdwdRmq+YXBpGyLsd+IFfU/LGMRNHL5UYxPXUVonoHqHdIuRmMhIDybZVK5n04XSTpmyWNdRbyYeTZsLk7Xcba7Ep/eCVbxv1ylJqQy/Fuz2T5gfNcOX3EJDFc52yIrm+g1hiRL78MJtNwz3I2gQguh4yfH1rdL7Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7cac8243bcdso1377346a34.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jan 2026 08:07:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767802072; x=1768406872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ztuyHqvH+Zcr3H/x/ieAA7hTz5runAUjr98Mj8r7tAY=;
        b=NHl3KUfIIeiQCXnZj/Fimhbptb6Sxr0pTYLuTgEkTyJX2BU66nggPrvB2QLobOctt9
         EOSy9cPkSCCQkPxPykOg6eLnLQIPJvxMIQMNtlinNLRfkthGl3wljeYaC0CMoYjXN0Hn
         2iuQb2Ss7bAOva3/VgWSmx/OQHZ+JfH95qZ1RLn3zKubYatkVU1KmeQaaPXwxxEaB9x5
         2cYqxpjjGdbYqfk+eRID6q2oS8Lm7MKx5fbSzt+ewxTgHtjZk15pnUjDfFdsP9jj6Nqf
         Cx6FkSjvcdYrolAD61MV9kllqOD/lB6R2U/9LcEZ44ZPeMgOx7GlPGa1zKvdB2hN/Brg
         RBpA==
X-Forwarded-Encrypted: i=1; AJvYcCVilENz3NYeVWTGXrqSVzR2zNYcq8hhHXyVgi4gialbb7ufmsa22H8lXWCdHWj/V1xYNYCwezsf6BGN1JXJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2Wj2JSF/EAj/QcW7p+gM5/Y6LFk3meVEzzEeb0D0OVt+0wc5O
	ct00Fmm09a6paBrjOif9gCmLXT7Qm7p5BvyGo5N3pJKjxQjuR5joWobb
X-Gm-Gg: AY/fxX4jyMpzZYTc43EAvDtwVoBvKzFAkLiNaKg6FZqeXQO7d7hr49iHDkcbmExVAJf
	4CRGmGIXpbbfVW9A83plTO94wsU0KvYTlZmCb9QaI23PN7I1VRWX+96Z1PuGMckUdlETrDtoQt2
	LUnRqIxo73qGG+KSXipn8mbcoDwaGEwspUs5nT/VBHsr+xwXJ528uSJTeQ/Ls71z7BcXEq1pOud
	YJr9rKX7NQ7UBEgKN++z/g4/wNqLITOIs4aVWzGnZ8d3UnXw+fuUitXsodSXFP3Vijg1vim4Z2Y
	DxJx3A0pI7bxxitr+d2byihM0FgM/qYBKYxcZl+95ePdXHHZibZ+0qg0kq+Sre+nEhuH+Vq44ct
	NRj/gx7QYyQwo7fXadcLDNO/iZUphJNZROKRcPL/Mfa5ArKqiCMGlmMw3LqTEW0oa/2a+5L5iZP
	/1uSSgUCJnt9sMSQ==
X-Google-Smtp-Source: AGHT+IFnX0D1TMmfwY0VTrnMwRJfCwDwr4D1qzu0Rq4hhSosaZ/MGXrUhp8ZpOrpp2j5Uvt0PyIUtA==
X-Received: by 2002:a05:6830:4424:b0:790:710f:60e3 with SMTP id 46e09a7af769-7ce50b57d91mr1707842a34.23.1767802072186;
        Wed, 07 Jan 2026 08:07:52 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff:5c::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce47801d63sm3540936a34.6.2026.01.07.08.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 08:07:51 -0800 (PST)
Date: Wed, 7 Jan 2026 08:07:50 -0800
From: Breno Leitao <leitao@debian.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jlayton@kernel.org, rostedt@goodmis.org, kernel-team@meta.com
Subject: Re: [PATCH] fs/namei: Remove redundant DCACHE_MANAGED_DENTRY check
 in __follow_mount_rcu
Message-ID: <yhleevo3p4d7tlvmc4b27di3mndhnv7dmnlrupgrtjy23ehqok@whlvpgy4kqrv>
References: <20260105-dcache-v1-1-f0d904b4a7c2@debian.org>
 <h6gfebegbbtqdjefr52kqdvfjlnpq4euzrq25mw4mdkapa2cfq@dy73qj5go474>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <h6gfebegbbtqdjefr52kqdvfjlnpq4euzrq25mw4mdkapa2cfq@dy73qj5go474>

Hello Mateusz,

On Wed, Jan 07, 2026 at 03:44:27PM +0100, Mateusz Guzik wrote:
> On Mon, Jan 05, 2026 at 07:10:27AM -0800, Breno Leitao wrote:
> > The check for DCACHE_MANAGED_DENTRY at the start of __follow_mount_rcu()
> > is redundant because the only caller (handle_mounts) already verifies
> > d_managed(dentry) before calling this function, so, dentry in
> > __follow_mount_rcu() has always DCACHE_MANAGED_DENTRY set.
> > 
> > This early-out optimization never fires in practice - but it is marking
> > as likely().
> > 
> > This was detected with branch profiling, which shows 100% misprediction
> > in this likely.
> > 
> > Remove the whole if clause instead of removing the likely, given we
> > know for sure that dentry is not DCACHE_MANAGED_DENTRY.
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  fs/namei.c | 3 ---
> >  1 file changed, 3 deletions(-)
> > 
> > diff --git a/fs/namei.c b/fs/namei.c
> > index bf0f66f0e9b9..774a2f5b0a10 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -1623,9 +1623,6 @@ static bool __follow_mount_rcu(struct nameidata *nd, struct path *path)
> >  	struct dentry *dentry = path->dentry;
> >  	unsigned int flags = dentry->d_flags;
> >  
> > -	if (likely(!(flags & DCACHE_MANAGED_DENTRY)))
> > -		return true;
> > -
> 
> This makes me very uneasy.
> 
> You are seeing 100% misses on this one because you are never racing
> against someone mounting and umounting on the dentry as you are doing
> the lookup.

I'm still learning VFS internals, so please bear with me.

If I understand correctly, the current code checks the same condition
twice in succession:

handle_mounts() {
	if (!d_managed(dentry))                       /* dentry->d_flags & DCACHE_MANAGED_DENTRY */
		return 0;
	__follow_mount_rcu() {                       /* Something changes here */
		unsigned int flags = dentry->d_flags;
		if (!(flags & DCACHE_MANAGED_DENTRY))
			return

Is your concern that DCACHE_MANAGED_DENTRY could be cleared between
these two checks?

> As in it is possible that by the time __follow_mount_rcu is invoked,
> DCACHE_MANAGED_DENTRY is no longer set and with the check removed the
> rest of the routine keeps executing.

I see, but couldn't the same race occur after the second check as
well?

In other words, whether we have one check or two, DCACHE_MANAGED_DENTRY
could still be unset immediately after the final check, leading to the
same situation.

> AFAICS this turns harmless as is anyway, but I don't think that's safe
> to rely on future-wise and more imporantly it is trivially avoidable.
> 
> I did not do it at the time because there are no d_ macros which operate
> on already read flags and I could not be bothered to add them. In
> retrospect a bad call, should have went with it and kept the open-coded
> DCACHE_MANAGED_DENTRY check.
> 
> something like this:
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index bf0f66f0e9b9..c6279f8023cf 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1618,13 +1618,11 @@ EXPORT_SYMBOL(follow_down);
>   * Try to skip to top of mountpoint pile in rcuwalk mode.  Fail if
>   * we meet a managed dentry that would need blocking.
>   */
> -static bool __follow_mount_rcu(struct nameidata *nd, struct path *path)
> +static bool __follow_mount_rcu(struct nameidata *nd, struct path *path, int flags)
>  {
>  	struct dentry *dentry = path->dentry;
> -	unsigned int flags = dentry->d_flags;
>  
> -	if (likely(!(flags & DCACHE_MANAGED_DENTRY)))
> -		return true;
> +	VFS_BUG_ON(!(flags & DCACHE_MANAGED_DENTRY));
>  
>  	if (unlikely(nd->flags & LOOKUP_NO_XDEV))
>  		return false;
> @@ -1672,9 +1670,10 @@ static inline int handle_mounts(struct nameidata *nd, struct dentry *dentry,
>  	path->dentry = dentry;
>  	if (nd->flags & LOOKUP_RCU) {
>  		unsigned int seq = nd->next_seq;
> -		if (likely(!d_managed(dentry)))
> +		unsigned int flags = READ_ONCE(dentry->d_flags);
> +		if (likely(!(dentry->d_flags & DCACHE_MANAGED_DENTRY)))

Minor nit: should this be "if (likely(!(flags & DCACHE_MANAGED_DENTRY)))?"
Otherwise you're reading d_flags twice but passing the stale value to
__follow_mount_rcu().

If I understand your intent correctly, you want to read the flags once
and consistently use that snapshot throughout. Is that right?

Thanks for your review,
--breno

