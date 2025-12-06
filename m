Return-Path: <linux-fsdevel+bounces-70923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F628CA9DD3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 06 Dec 2025 02:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A6CC23027842
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Dec 2025 01:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B601B6527;
	Sat,  6 Dec 2025 01:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="KCB+000q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F423B8D79;
	Sat,  6 Dec 2025 01:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764985345; cv=none; b=PgaG6aSh9tvvfhIswo5P030SWftGzDZ7Zvr72nFrP+V3oQCPRXWcaknVW5W4V5zcV7WipWzW/TdMdZ2oIWN6mQx6rKyM0mbT2yjOAFicS9LA/lM9c7Q3qx7PSG7okX431eCxCD4zpInGJvrWx8WveILCqgFWtE7+jR318N/nUqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764985345; c=relaxed/simple;
	bh=+n7bGtjOTDMxtbxzsvhiqH3/c7G2OMnFiJFUUyrYJ6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0KF/SIlIxaV5gcu6zhxddKUnm/DQaIVySeVj7juK2vRfY4HKb7WgE8rs7Wsw2DpFj4LtTfZhGJdp6EMWAHkLUviYuBlzOV1jHJKjMVY0P0rQHGlR4bJRu3rAy3EdZUplBImJry2z+CJiGPmELFfIqbx0ZNudP2MMyC32KG3Qog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=KCB+000q; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=B94G77EOJG4mIZdNAYxDXCVKOl+ujbjYrYep1WfO+wQ=; b=KCB+000qhNijYgJqlKY0z+a+hU
	sf/7QvZOUi+7nlHe/KbFk/8N+3QjZX0vEEtuuwtGuhvWCvoGVjfIfsQ2ItSSHR+1cPls1YbvU6aBe
	hJ2LYNtSGsdxIOQiMmcgsACb54mGzi6X2x8mOVQu04pCcpXvSN/5KrgKAUVM3Tn9yB4BacyiPI4CX
	7S9WgM9g45eJlU6YhCODh5ErL8l0ljDPF8V+Q5ksbJx3rzGARkxMFrPKg1fJsFCW5FzuCUdMuaP7/
	nKEOpJ2jYMfYom8uN63srUzmrWF1RD8/g15WHZsySrHQwFACPbrMYr0jKpLWZg/8+++nHAq+YjxZC
	bR6J9hhg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vRhJq-00000004BXn-34wy;
	Sat, 06 Dec 2025 01:42:42 +0000
Date: Sat, 6 Dec 2025 01:42:42 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] fuse update for 6.19
Message-ID: <20251206014242.GO1712166@ZenIV>
References: <CAJfpegunwB28WKqxNWCQyd5zrMfSif_YmBFp+_m-ZsDap9+G7Q@mail.gmail.com>
 <CAHk-=wht097GMgEuH870PU4dMfBCinZ5_qvxpqK2Q9PP=QRdTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wht097GMgEuH870PU4dMfBCinZ5_qvxpqK2Q9PP=QRdTA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Dec 05, 2025 at 03:47:50PM -0800, Linus Torvalds wrote:
> On Thu, 4 Dec 2025 at 00:25, Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > The stale dentry cleanup has a patch touching dcache.c: this extracts
> > a helper from d_prune_aliases() that puts the unused dentry on a
> > dispose list.  Export this and shrink_dentry_list() to modules.
> 
> Is that
> 
>         spin_lock(&dentry->d_lock);
>         if (!dentry->d_lockref.count)
>                 to_shrink_list(dentry, dispose);
>         spin_unlock(&dentry->d_lock);
> 
> thing possibly hot, and count might be commonly non-zero?
> 
> Because it's possible that we could just make it a lockref operation
> where we atomically don't take the lock if the count is non-zero so
> that we don't unnecessarily move cachelines around...
> 
> IOW, some kind of "lockref_lock_if_zero()" pattern?
> 
> I have no idea what the fuse dentry lifetime patterns might be, maybe
> this is a complete non-issue...

Far more interesting question, IMO, is what's to prevent memory
pressure from evicting the damn argument right under us.

AFAICS, fuse_dentry_tree_work() calls that thing with no locks held.
The one and only reason why that's OK in d_prune_aliases() is ->i_lock
held over that thing - that's enough to prevent eviction.  I don't
see anything to serve the same purpose here.

