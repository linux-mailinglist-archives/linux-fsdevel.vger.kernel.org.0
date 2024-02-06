Return-Path: <linux-fsdevel+bounces-10464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C68E484B693
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 14:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 360F7B21EE7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 13:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EBC13172E;
	Tue,  6 Feb 2024 13:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DT4MeaOk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7943A1D556;
	Tue,  6 Feb 2024 13:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707226759; cv=none; b=Le2eWqUAmbR9AqEUPTH9OH9xxjqL4vJvsjU/8hfmm1et8bPSW7UsS6gRgp856uMl4NvdgwKJpFq++318uvBVV6b3P0TWJnxgbvAxMFjLElFf3I4O6h/RHhFQPzLpzY2x/DNd+C2RqkJhD7M550x4mqTzYUqCX7TegC7Ujkk7up4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707226759; c=relaxed/simple;
	bh=iQNTh9paAZlobYZ5hHz0MBgHd2PmVmHYrXHFg9QVJ+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bm3i9ctNEOfKg6pEidzLFVfusVNPEkxIGYaLj4jqaIEbb1UjjSzAkYvC/Ekw05I6CprQR7ehMoQuopgqFOA2URSQ5h3T0NlmkJNIW3upfc2Wtn9L36x/3y3Iobu+WZXD/Er4a4++Y17cTf6gocghp+kCXarDzlei7Edj30VFxeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DT4MeaOk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A64C433C7;
	Tue,  6 Feb 2024 13:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707226759;
	bh=iQNTh9paAZlobYZ5hHz0MBgHd2PmVmHYrXHFg9QVJ+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DT4MeaOk6DkeBY2k/sCgV5H1P93RNEmETfMfCPrHJPc2obANsvgP8tOI+KwLDI2lJ
	 k06cP7RXLrzlAjHEhS+t1jhJ8CNdD6G1QGlpecDkMeki7/7Ee6B9E+0fMsPXs956hH
	 j1b8YZX208fI6cpe5rDhlB7nqUNqnEkMDRisMD+9HI7Bb3LZBAsrMum64kHwaM7EmN
	 mQDu3WrGNEnbKctd4CXp35B7crTAKG/g25qCpmecYPQoPeP2oQcuQ3dUP9ZTJV/x2N
	 nb9Tz2Z/pBd9em8Oeeq/+YA46/QpKTS9fhCzobnr1ZfzZmODtfxewcHUMrQygWGPl2
	 jj2f1RPVMzk2g==
Date: Tue, 6 Feb 2024 14:39:13 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 00/34] Open block devices as files
Message-ID: <20240206-zersplittern-unqualifiziert-c449ed7a4b5f@brauner>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240205-biotechnologie-korallen-d2b3a7138ec0@brauner>
 <20240205141911.vbuqvjdbjw5pq2wc@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240205141911.vbuqvjdbjw5pq2wc@quack3>

On Mon, Feb 05, 2024 at 03:19:11PM +0100, Jan Kara wrote:
> Hi!
> 
> On Mon 05-02-24 12:55:18, Christian Brauner wrote:
> > On Tue, Jan 23, 2024 at 02:26:17PM +0100, Christian Brauner wrote:
> > > Hey Christoph,
> > > Hey Jan,
> > > Hey Jens,
> > > 
> > > This opens block devices as files. Instead of introducing a separate
> > > indirection into bdev_open_by_*() vis struct bdev_handle we can just
> > > make bdev_file_open_by_*() return a struct file. Opening and closing a
> > > block device from setup_bdev_super() and in all other places just
> > > becomes equivalent to opening and closing a file.
> > > 
> > > This has held up in xfstests and in blktests so far and it seems stable
> > > and clean. The equivalence of opening and closing block devices to
> > > regular files is a win in and of itself imho. Added to that is the
> > > ability to do away with struct bdev_handle completely and make various
> > > low-level helpers private to the block layer.
> > > 
> > > All places were we currently stash a struct bdev_handle we just stash a
> > > file and use an accessor such as file_bdev() akin to I_BDEV() to get to
> > > the block device.
> > > 
> > > It's now also possible to use file->f_mapping as a replacement for
> > > bdev->bd_inode->i_mapping and file->f_inode or file->f_mapping->host as
> > > an alternative to bdev->bd_inode allowing us to significantly reduce or
> > > even fully remove bdev->bd_inode in follow-up patches.
> > > 
> > > In addition, we could get rid of sb->s_bdev and various other places
> > > that stash the block device directly and instead stash the block device
> > > file. Again, this is follow-up work.
> > > 
> > > Thanks!
> > > Christian
> > > 
> > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > ---
> > 
> > With all fixes applied I've moved this into vfs.super on vfs/vfs.git so
> > this gets some exposure in -next asap. Please let me know if you have
> > quarrels with that.
> 
> No quarrels really. I went through the patches and all of them look fine to
> me to feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> I have just noticed that in "bdev: make struct bdev_handle private to the
> block layer" in bdev_open() we are still leaking the handle in case of
> error. This is however temporary (until the end of the series when we get
> rid of handles altogether) so whatever.

Can you double-check what's in vfs.super right now? I thought I fixed
this up. I'll check too!

