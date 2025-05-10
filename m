Return-Path: <linux-fsdevel+bounces-48675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89905AB24DF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 May 2025 19:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D67121BA1814
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 May 2025 17:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D363E24BBEC;
	Sat, 10 May 2025 17:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="G3tlCJfG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C5B1C4609;
	Sat, 10 May 2025 17:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746899291; cv=none; b=nmVHh3lIQC3E/1A/m87f2W6PnNwou9FVmrIXKpPSsNazbdjrTivHczYQv/jLw15W0zhGYp4DGZngJLnwD399WgNS41t91dHnZNBP2dkhXILKOL+jAbTniJbCZG0Y3OI4KQjgXUYEnUFe9imcHVlDxMNvhAJmT59P/nNZGF8BBk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746899291; c=relaxed/simple;
	bh=kUcCYZpGhDJuM0PTGBl3uRYLyZgIWmlE2IQoydwC+S4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YGrecaw1j4swtmbYJc0Rj1vvMSjHgwTIGiJhBS9dro5Ck/czHUwAKQkq1cd6QRzlLw/tRuuH79qGsuNE4vuIGsqi1FjhYdbTdn64GNBUkby6vr6IJjhH0JaAovlzoEUU4TukzEsmGhQlSLEZwYSWY4zMZiRB293GnWK0vqSI6EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=G3tlCJfG; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=goUj4uTlrWULdr0JG01jm/v04D1+T1nfYQPlEzafaUQ=; b=G3tlCJfGytToS8LQrZKmPFYuKT
	kd38RvglH2yCEorb3ldkOhZVSS6uNvxY+7FS8C2toSRhiNVG5R9HSHJ+58KGLSBni2HsOjMmYxb3A
	k9oN67wLIdbRcODSLXO4aMFlirJuZwbL//U78COHa8N0LyZs9h7co7CT9E6f2Ya+LjfN+58O9tPAl
	iXKsymbQiUVnlYxT5uSxevGfeAQVmBpTPNFEvfsJ1xxxwIYlYoWvcIWaFxdfJ57X28eo/wAPPs6Xt
	IKE1zPnByOyGcKWAopYeuXy4QVQInMaOs2VAqEFZz8afl/F1ZGrsFqaAyZzmoEH4LIK1XWwQt5Qyd
	MhU5ZCnA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDoIu-00000002izj-2OIw;
	Sat, 10 May 2025 17:48:04 +0000
Date: Sat, 10 May 2025 18:48:04 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: I Hsin Cheng <richard120310@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] fs: Fix typo in comment of link_path_walk()
Message-ID: <20250510174804.GZ2023217@ZenIV>
References: <20250510104632.480749-1-richard120310@gmail.com>
 <20250510120835.GY2023217@ZenIV>
 <aB9KHNNBzWxMJ2_j@vaxr-BM6660-BM6360>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aB9KHNNBzWxMJ2_j@vaxr-BM6660-BM6360>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, May 10, 2025 at 08:44:12PM +0800, I Hsin Cheng wrote:
> On Sat, May 10, 2025 at 01:08:35PM +0100, Al Viro wrote:
> > On Sat, May 10, 2025 at 06:46:32PM +0800, I Hsin Cheng wrote:
> > > Fix "NUL" to "NULL".
> > > 
> > > Fixes: 200e9ef7ab51 ("vfs: split up name hashing in link_path_walk() into helper function")
> > 
> > Not a typo.  And think for a second about the meaning of
> > so "fixed" sentence - NUL and '/' are mutually exclusive
> > alternatives; both are characters.  NULL is a pointer and
> > makes no sense whatsoever in that context.
> 
> Ohh thanks for the head up. I'll keep this in mind, really big thanks!

FWIW, the logics could be cleaner; what happens there is that having
consumed a pathname component, we want to find two things:
	* was it the last one?
	* if not, where does the next one start?
If the next character is the end of string (NUL, zero byte), everything's
obvious - it was the last component.  If not, the next character must
be '/' (anything else would've been a part of component we've just read
through), and usually that would mean that there are other components
coming after it.  However, there might be more than one slash (/usr//bin
means the same thing as /usr/bin), so we need to skip however many slashes
there might be in order to find the beginning of the next component.
What's more, /usr/bin/ is also valid and means the same thing as /usr/bin,
so it's still possible that component we've read was the last one - we
won't know until we skip all slashes and see if we've reached the end
of string.

A possible way to clarify that might be something like

/* given a pointer just past the end of component find the next one */
static inline const char *next_component(const char *s)
{
	if (!*s)		// end of string
		return NULL;
	// the only other thing possible here is '/'; skip it, along with
	// any extra slashes (if any - rare, but legal) right after it.
	do {
		s++;
	} while (unlikely(*s == '/'));
	if (unlikely(!*s))	// slash(es), then end of string
		return NULL;
	return s;		// beginning of the next component
}

with
		name = next_component(name);
		if (!name) {
			/* we are at the end of... */
                        if (!depth) {
				/* ... the pathname or trailing symlink; done */
                                nd->dir_vfsuid = i_uid_into_vfsuid(idmap, nd->inode);
                                nd->dir_mode = nd->inode->i_mode;
                                nd->flags &= ~LOOKUP_PARENT;
                                return 0;
                        }
                        /* ... the last component of nested symlink */
                        name = nd->stack[--depth].name;
                        link = walk_component(nd, 0);
		} else {
			/* not the last component */
			link = walk_component(nd, WALK_MORE);
		}

in the corresponding place in link_path_walk().  Not sure if it's better
that way, to be honest - taking that chunk into an inline helper would
force reader to go looking for the definition of that helper and that
just might be more disruptive than the current variant.  Hell knows...

