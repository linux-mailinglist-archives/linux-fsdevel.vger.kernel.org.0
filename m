Return-Path: <linux-fsdevel+bounces-19841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22ACE8CA3D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 23:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 238121C213DB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 21:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937E4139598;
	Mon, 20 May 2024 21:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Mx/dE3SV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBCD1369BA
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2024 21:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716241110; cv=none; b=Cx3r+2Sd+3Hgoj8s+nGqpELnvp9EuYlBYhdK0Zm+KmL/WzhJ7CJIEnk5zS+7nQzS3IhxZf3KWApgP5rG9/l0fo/2/kLRzKwpP4yIMmr8VCuVULVyfK+gAOhfhr9lgvlILvwD6142yUjePvdecUeokNazPs4KIo3W7JqN5ucKhH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716241110; c=relaxed/simple;
	bh=fF2VZ0xR5HB/I1cWWHGXI3gbNNCgBPogeoKdxNWEUwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BAdcoH9SaxwIBENHwNBbs15Uc4yXBPMrAAovgCdTCtNz/ACdGWUXl0a8Gh6tRybIItt0grGPDKwxqO+0JSA5HaU8dE5ATd1UGX0hKUE4iERdcEISJNZZ/tK0HpNpq67nzgl+opYf5avq3clPxW4x/8P/0L6h7uF8e4mCwXQ/K14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Mx/dE3SV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=k4pvx45nzJiEVFJOMNku/4hNqxYDmnJcae+7Fi28+PE=; b=Mx/dE3SVGjTOYagySa9StjySNa
	CoLtOFfCQNVXETNAIpa31DG99iURJn0Ze1xusNOZIg5Myplq162pYQ91Mh6OOXslzAIS83b/o/u4C
	GyhuOetGfpKYd6ggrSCnx+sGjfZnnxR1qWnobXT/Asaos48vroKIYtyz1iJnqN+hqkgwtcZBrZLIZ
	oSvhDqAjgl1csoutViRAQJ5Fo7mWZJMbr41yf4xgMgrLE5XTq6wp1YkmHklb4OTwapYgtlhQ0RKfl
	lMIuojwxsaAr5A+ZRcldMUli99kH5vyBPJAf7Zt1eHc/oNE3mUU9J8sIwslzwXpEZH/E1gRriyj7U
	UNq0ka8g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9Ai1-0000000GP60-0OS6;
	Mon, 20 May 2024 21:38:17 +0000
Date: Mon, 20 May 2024 22:38:16 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: A fs-next branch
Message-ID: <ZkvCyB1-WpxH7512@casper.infradead.org>
References: <ZkPsYPX2gzWpy2Sw@casper.infradead.org>
 <20240520132326.52392f8d@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520132326.52392f8d@canb.auug.org.au>

On Mon, May 20, 2024 at 01:23:26PM +1000, Stephen Rothwell wrote:
> Hi Willy,
> 
> Sorry for the slow response.

No problem; I figure you get one week off every ten weeks or so ...

> On Tue, 14 May 2024 23:57:36 +0100 Matthew Wilcox <willy@infradead.org> wrote:
> >
> > At LSFMM we're talking about the need to do more integrated testing with
> > the various fs trees, the fs infrastructure and the vfs.  We'd like to
> > avoid that testing be blocked by a bad patch in, say, a graphics driver.
> > 
> > A solution we're kicking around would be for linux-next to include a
> > 'fs-next' branch which contains the trees which have opted into this
> > new branch.  Would this be tremendously disruptive to your workflow or
> > would this be an easy addition?
> 
> How would this be different from what happens at the moment with all
> the separate file system trees and the various "vfs" trees?  I can
> include any tree.

As I understand the structure of linux-next right now, you merge one
tree after another in some order which isn't relevant to me, so I have no
idea what it is.  What we're asking for is that we end up with a branch
in your tree called fs-next that is:

 - Linus's tree as of that day
 - plus the vfs trees
 - plus xfs, btrfs, ext4, nfs, cifs, ...

but not, eg, graphics, i2c, tip, networking, etc

How we get that branch is really up to you; if you want to start by
merging all the filesystem trees, tag that, then continue merging all the
other trees, that would work.  If you want to merge all the filesystem
trees to fs-next, then merge the fs-next tree at some point in your list
of trees, that would work too.

Also, I don't think we care if it's a branch or a tag.  Just something
we can call fs-next to all test against and submit patches against.
The important thing is that we get your resolution of any conflicts.

There was debate about whether we wanted to include mm-stable in this
tree, and I think that debate will continue, but I don't think it'll be
a big difference to you whether we ask you to include it or not?

