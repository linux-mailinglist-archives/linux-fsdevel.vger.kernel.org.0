Return-Path: <linux-fsdevel+bounces-62672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3714CB9C432
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 23:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4F1F323EBF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 21:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93DD287505;
	Wed, 24 Sep 2025 21:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="aWsBifpe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECB811185;
	Wed, 24 Sep 2025 21:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758748932; cv=none; b=RkAYD4Sv8cvPxSz2zvRsQBSo90PpkFLOfocgTGpZMMPqQ5cWKWTznejBH205wJGnHQX9zUhQzSEnRQ12vTDsQ0E5dIxiX9X8DXZBHrk482NfFbxN70EMTo9k75+4aIElyc1AdK1Hua4x0FY7N8JVeA88x7Do2Ng91apa3SPtYrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758748932; c=relaxed/simple;
	bh=FVOwREu1YrMuD4UC8pi0A+VDAALTewZsII/41fs9MnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=no5Be29Hlma/w02NuozKQzOW4+BE7n4Fzpgku36O26aJJVjOzIXXCKhF+xRKHbNdXsYx5MGzJNxPNm2e522kFMH5UGwJmSYcMsSu2rBhaUmGzqCTqmXEtTzYg6d9XrwoR9ls/Dj2/LE6VJVN/nVoXyJ+ev3HU5J9jcU9ar1Z3iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=aWsBifpe; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bb9OUBUC8HoTDeqzOapom6idqxLTPUmtt5z1Cb49IOo=; b=aWsBifpeyHE1US5onTri/T8Uu6
	vWSouJmMtd2bhGIeT6zgYZNNX0y+1imyh9tx3gpJ8CSvEMs6H8Rbb9IalNweKTvuHBaHAofJ+dwO+
	WW0wcdtnk1waW4D9Ptf/4lMEU3sKbgDCszDNb7Y+ECPbVcabeJs4mpRDxkr0rpLvvUIVRZPvd+Zx2
	duptQv41ZhmCQo8ShXdfhCAFVqYTLZgfrNtifEk2M5iTOkHl8NeZpTTxf4LuIprimRnV3qYLRJeCG
	L39TghwLIaNrOkS5quU5+AZHCdAvP1lvRNwlBCo5iiPW6hHiNOq5GUUoQpL/Hnh8CLXj+CjvLNzN6
	lNjJFb7Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1WwB-0000000BgD4-3dyS;
	Wed, 24 Sep 2025 21:22:07 +0000
Date: Wed, 24 Sep 2025 22:22:07 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Kriish Sharma <kriish.sharma2006@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, david.hunter.linux@gmail.com,
	skhan@linuxfoundation.org
Subject: Re: [PATCH] fs: doc: describe 'pinned' parameter in do_lock_mount()
Message-ID: <20250924212207.GV39973@ZenIV>
References: <20250924193611.673838-1-kriish.sharma2006@gmail.com>
 <20250924205730.GU39973@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924205730.GU39973@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Sep 24, 2025 at 09:57:30PM +0100, Al Viro wrote:
> On Wed, Sep 24, 2025 at 07:36:11PM +0000, Kriish Sharma wrote:
> > The kernel-doc comment for do_lock_mount() was missing a description
> > for the 'pinned' parameter:
> > 
> >   Warning: fs/namespace.c:2772 function parameter 'pinned' not described
> >   in 'do_lock_mount'
> > 
> > This patch adds a short description:
> > 
> >   @pinned: receives the pinned mountpoint
> > 
> > to fix the warning and improve documentation clarity.
> 
> Sigh...  There we go again...
> 	1.  It does not improve documentation clarity - it adds
> a misleading line to an opaque chunk of text that does not match
> what the function *does*.
> 	2.  In -next both the calling conventions and the comment
> are both changed, hopefully making it more readable.
> 	3.  Essentially the same patch has already been posted and
> discussed.
> 
> NAKed-by: Al Viro <viro@zeniv.linux.org.uk>

PS: as for the clarity, I'd like to point out that with your patch
applied nothing in the comments explains what is *done* to that
argument - it's not even mentioned there.  Incidentally, "receives"
normally implies an IN argument; this is an OUT one (function set the
environment for mounting something at given location and stores the
resulting context in caller-supplied structure).

Comment quality needs to be improved and these warnings actually
do catch some of the stale (and generally incomprehensible) ones.
Unfortunately, it's easy to fool the heuristics without doing
anything about the underlying problem, in effect hiding it.

Folks, please don't do that - this is not an improvement.  If you
spot something of that sort and want to take a pass at fixing it,
more power to you, but the main criteria here would be "does that
text make it easier to understand the function in question and/or
the rules for using it".  If it's genuinely hard to figure out,
don't hesitate to ask.

