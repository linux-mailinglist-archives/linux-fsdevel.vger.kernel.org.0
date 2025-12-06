Return-Path: <linux-fsdevel+bounces-70934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F86CAA093
	for <lists+linux-fsdevel@lfdr.de>; Sat, 06 Dec 2025 05:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95DD83178ACC
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Dec 2025 04:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B54255E43;
	Sat,  6 Dec 2025 04:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="lSiaH9sh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE472192F9;
	Sat,  6 Dec 2025 04:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764994945; cv=none; b=Z9cz7ZDRRq2NCluDHHZL26O6hCoO9rPZMrvASAut3wv6/+U9SkQc0yXcDV8k+cSYuelzAyF7BOSV1lbF+gZaSKjO1aiosq911LIKLHHabviAjob5ItUZPSlyto/dla5dVG1GnxOfT86X7AB0jtgnYERfT9BlGGpGLYj0YycdHhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764994945; c=relaxed/simple;
	bh=pCbMboxZYjhhcrM3xA90sANtIGOWLvOhxKOGkPMr6Hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hGhwLTQfw2kefWu6YlpmFB5pmN/wP2CKXqfSMwuwauyMr7bu4WWHae1exfoKGpxw9/u1978AtbGQOq4iQBKJ//2/Ms5i7J5uSHZM5eSpovWD1kylE1LyxO93Z4nieOz0DRmPEUjjbgCYGJncP6yMOKvRxk3VsvFGrEZHQ0rZNF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=lSiaH9sh; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gDskK8AhaF+xMtpa6AyKk7gX1LXGeQ0NLecgfvGs5gk=; b=lSiaH9sha386ItclxiB2k/jwYr
	mJ+2NIQQ7b0Lf/UsjE4y1BUZHXqAR+zxPPUlMJ2XrKx13JzwpAgG8S68Fhpcs6Eo1CgiBH4tExXue
	TCj0LxMhMKsuFku2L8d9Bbd5/WHQMOvNn0tnABVNrBYU8UTVt1CPao0yt1pv1vG39BbCYn0wyzq8P
	qQ8iCLDVZGuFa+USndCCI+zL3r1n/icU4wsEiDTq21dBLs6wK++AMz2virIbD14k8CfS8eM36zb23
	OkXp8tDnI0GuZbMoIF0+THxUhhZr368/lD/wIEWedKaVANd9215DEAa/hG7nQYiexzw5gzKHJMOKY
	VVKWccsQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vRjog-0000000753z-1Gfb;
	Sat, 06 Dec 2025 04:22:42 +0000
Date: Sat, 6 Dec 2025 04:22:42 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] fuse update for 6.19
Message-ID: <20251206042242.GS1712166@ZenIV>
References: <CAJfpegunwB28WKqxNWCQyd5zrMfSif_YmBFp+_m-ZsDap9+G7Q@mail.gmail.com>
 <CAHk-=wht097GMgEuH870PU4dMfBCinZ5_qvxpqK2Q9PP=QRdTA@mail.gmail.com>
 <20251206014242.GO1712166@ZenIV>
 <CAHk-=wg8KJbcPuoRBFmD9c42awaeb4anXsC4evEOj0_QVKg0QQ@mail.gmail.com>
 <20251206022826.GP1712166@ZenIV>
 <CAHk-=wgBU3MQniRBmbKi2yj0fRrWQjViViNvNJ6sqjEB-3r4XA@mail.gmail.com>
 <20251206035403.GR1712166@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251206035403.GR1712166@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Dec 06, 2025 at 03:54:03AM +0000, Al Viro wrote:
> On Fri, Dec 05, 2025 at 07:29:13PM -0800, Linus Torvalds wrote:
> > On Fri, 5 Dec 2025 at 18:28, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > Sure, ->d_prune() would take it out of the rbtree, but what if it hits
> > 
> > Ahh.
> > 
> > Maybe increase the d_count before releasing that rbtree lock?
> > 
> > Or yeah, maybe moving it to d_release. Miklos?
> 
> Moving it to ->d_release() would be my preference, TBH.  Then
> we could simply dget() the sucker under the lock and follow
> that with existing dput_to_list() after dropping the lock...

s/dget/grab ->d_lock, increment ->d_count if not negative,
drop ->d_lock/ - we need to deal with the possibility of
the victim just going into __dentry_kill() as we find it.

And yes, it would be better off with something like
lockref_get_if_zero(struct lockref *lockref)
{
	bool retval = false;
	CMPXCHG_LOOP(
		new.count++;
		if (old_count != 0)
			return false;
	,
		return true;
	);
	spin_lock(&lockref->lock);
	if (lockref->count == 0)
		lockref->count = 1;
		retval = true;
	}
	spin_unlock(&lockref->lock);
	return retval;
}

with
		while (node) {
			fd = rb_entry(node, struct fuse_dentry, node);
			if (!time_after64(get_jiffies_64(), fd->time))
				break;
			rb_erase(&fd->node, &dentry_hash[i].tree);
			RB_CLEAR_NODE(&fd->node);
			if (lockref_get_if_zero(&dentry->d_lockref))
				dput_to_list(dentry);
			if (need_resched()) {
				spin_unlock(&dentry_hash[i].lock);
				schedule();
				spin_lock(&dentry_hash[i].lock);
			}
			node = rb_first(&dentry_hash[i].tree);
		}
in that loop.  Actually... a couple of questions:
	* why do we call shrink_dentry_list() separately for each hash
bucket?  Easier to gather everything and call it once...
	* what's the point of rbtree there?  What's wrong with plain
hlist?  Folks?

