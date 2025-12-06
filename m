Return-Path: <linux-fsdevel+bounces-70926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC513CA9EBB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 06 Dec 2025 03:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4F4431E37B5
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Dec 2025 02:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86CA26ED5D;
	Sat,  6 Dec 2025 02:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Crq6iyRi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6014625BEE8;
	Sat,  6 Dec 2025 02:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764988091; cv=none; b=HcaQ+qgTHFBFWpI7/ihUIeTi7FaG7aW6PNEoKGOvDYlWGKH4a02qiswRUTPbMZ1SEpIk+hawwIhNBXw/0QPLPUjfCOMS9ePI9s0sLI6tB+f6cKe2JBBFnGRPft9R5C9sL6GsBDZBWMIejE1hzY1NE4EA/5cK8T0OD7L4R9iCzIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764988091; c=relaxed/simple;
	bh=qCZEWa+DKyy8KYenOv/x7uV14sTRS8Syy/wQ3QV1OKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQ8f02kcNUZbkfrrEPhsFtlRT+zRbcRK15cbjGbqQLJcP4g6ckrPH/wNqexdOYQH4jXFDsZKrZqPGyMj4VVTN2cNco+Bqu68zV3iPg4EjxKfU4KUWAOfoFBaRNWfJm5WadRtDCb9W295W5AYK3ABEW1udgTtDte4oDju3IKMLjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Crq6iyRi; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IDYOPb3REsC3QIqCP+9+BF/zrMySVnC+/cEOjg5w2Hc=; b=Crq6iyRip/8LyNRQBIABzx3six
	5kVNGZjptZ2ic7MYDL7nbwsLtx0lXKj9UUU5HywLmfftJTIxGOBe+1lYYQTzIGxyBJnsM0AuZgL9c
	fqGvUPjsoUcdSTTFNpz6DL6iXLpVwWWGohPo6NjzHp4HCa8dTyQSAwa/gm5zNyOMsmVKSW2q+AgXW
	SpNqQtz+mMiRBmAamz/vsKVTTimUt1Gm5ul7BDfzZQn1wK32hhKyhYH33dV5OCeo/XYsNJVyYGuPP
	d2CISG/JbqvMMWEhYUS4TIK1YEm3F7JFja9rMLrScpR6dfTbViYXgg3xn8thJm9NdJJsCBgc3d44X
	nxc7aMQQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vRi26-00000004fFH-40Ms;
	Sat, 06 Dec 2025 02:28:27 +0000
Date: Sat, 6 Dec 2025 02:28:26 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] fuse update for 6.19
Message-ID: <20251206022826.GP1712166@ZenIV>
References: <CAJfpegunwB28WKqxNWCQyd5zrMfSif_YmBFp+_m-ZsDap9+G7Q@mail.gmail.com>
 <CAHk-=wht097GMgEuH870PU4dMfBCinZ5_qvxpqK2Q9PP=QRdTA@mail.gmail.com>
 <20251206014242.GO1712166@ZenIV>
 <CAHk-=wg8KJbcPuoRBFmD9c42awaeb4anXsC4evEOj0_QVKg0QQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg8KJbcPuoRBFmD9c42awaeb4anXsC4evEOj0_QVKg0QQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Dec 05, 2025 at 05:52:51PM -0800, Linus Torvalds wrote:
> On Fri, 5 Dec 2025 at 17:42, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > Far more interesting question, IMO, is what's to prevent memory
> > pressure from evicting the damn argument right under us.
> 
> That was my first reaction, but look at the 'fuse_dentry_prune()' logic.
> 
> So if the dentry is removed by the VFS layer, it should be removed here too.

Sure, ->d_prune() would take it out of the rbtree, but what if it hits
                                rb_erase(&fd->node, &dentry_hash[i].tree);
                                RB_CLEAR_NODE(&fd->node);
                                spin_unlock(&dentry_hash[i].lock);
... right here, when we are not holding any locks anymore?
                                d_dispose_if_unused(fd->dentry, &dispose);
                                cond_resched();
                                spin_lock(&dentry_hash[i].lock);


