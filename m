Return-Path: <linux-fsdevel+bounces-73487-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 567CED1ACAC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 19:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 881B6305FFD0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 18:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD25932A3F1;
	Tue, 13 Jan 2026 18:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3Xw3kcn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414ED2FD660;
	Tue, 13 Jan 2026 18:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768327616; cv=none; b=CzDJ5atlc/iOu+DQDktxqgpWaGrNHlv84p5cIq4K84xqSLNivMNFXBF/wjFhEY73/hScIB8Mhi3CKhH4b7HNgnpaVmvozD0Whn+ccALpJ4AWuleMVacPuc7mwih8OBTKPcaKEILp26vReI1nwNROylfDhCNWrTcrDPFhg/0j0tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768327616; c=relaxed/simple;
	bh=NnuO0NeL8+O9vrkIz06fdgk0GLLm35yhgWcOYWLJ13k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xg/Ejw3QyisA2MS2Gz7Vz/2znbDuAEEZUBMDp6c5kQ6tkMAjRYwXfApYeIgS+3gZYV7vlbaL9nzO71fOKhWrUccDq3lCQIgp0ru1eBLkPotiQm82IldDPNuLIrGIeLsNpFCS59rvawVY892RxJIlL2G60NCpjYubpKua2FVVu8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3Xw3kcn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9256C116C6;
	Tue, 13 Jan 2026 18:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768327615;
	bh=NnuO0NeL8+O9vrkIz06fdgk0GLLm35yhgWcOYWLJ13k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j3Xw3kcnrlrBjTj8NmFz1vGLdi1uEjiB/Nd5mKN9xPdb7uQZzlCI2d93X1RHFCYeN
	 JgL1hyYpOGjAhalYR2fYuGGL0975Rjtb2BTXNl48W8vst8yEvk3DcUuR7Y4/ndphxY
	 4cjVf58pf/NbGkFTfVRcmiFLMwgFFXBnJC5zG9/ZO6EiFg9MQxkBvaUcP5MqaDuEOF
	 7KwuFz2+Jof9ij9IQwJFbIiD48iQqeI8KzsXmD69YpxYdPTAmCTwckXpiTIKgoQAoR
	 7Ee0lEzqPh7qBpddLdvBequkMxX57G22D5ZaE1xY96kRtcWOZYvttlwGo41rSmxDdS
	 l8P+4e3EzU3rQ==
Date: Tue, 13 Jan 2026 10:06:55 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
	ebiggers@kernel.org, linux-fsdevel@vger.kernel.org,
	aalbersh@kernel.org, david@fromorbit.com, hch@lst.de
Subject: Re: [PATCH v2 13/22] xfs: introduce XFS_FSVERITY_REGION_START
 constant
Message-ID: <20260113180655.GY15551@frogsfrogsfrogs>
References: <cover.1768229271.patch-series@thinky>
 <qwtd222f5dtszwvacl5ywnommg2xftdtunco2eq4sni4pyyps7@ritrh57jm2eg>
 <20260112224631.GO15551@frogsfrogsfrogs>
 <5ax7476dl472kpg3djnlojoxo2k4pmfbzwzsw4mo4jnaoqumeh@t3l4aesjfhwz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ax7476dl472kpg3djnlojoxo2k4pmfbzwzsw4mo4jnaoqumeh@t3l4aesjfhwz>

On Tue, Jan 13, 2026 at 01:23:06PM +0100, Andrey Albershteyn wrote:
> On 2026-01-12 14:46:31, Darrick J. Wong wrote:
> > On Mon, Jan 12, 2026 at 03:51:25PM +0100, Andrey Albershteyn wrote:
> > > This constant defines location of fsverity metadata in page cache of
> > > an inode.
> > > 
> > > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > > ---
> > >  fs/xfs/libxfs/xfs_fs.h | 22 ++++++++++++++++++++++
> > >  1 file changed, 22 insertions(+), 0 deletions(-)
> > > 
> > > diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
> > > index 12463ba766..b73458a7c2 100644
> > > --- a/fs/xfs/libxfs/xfs_fs.h
> > > +++ b/fs/xfs/libxfs/xfs_fs.h
> > > @@ -1106,4 +1106,26 @@
> > >  #define BBTOB(bbs)	((bbs) << BBSHIFT)
> > >  #endif
> > >  
> > > +/* Merkle tree location in page cache. We take memory region from the inode's
> > 
> > Dumb nit: new line after opening the multiline comment.
> > 
> > /*
> >  * Merkle tree location in page cache...
> > 
> > also, isn't (1U<<53) the location of the Merkle tree ondisk in addition
> > to its location in the page cache?
> 
> yes, it's file offset
> 
> > 
> > That occurs to me, what happens on 32-bit systems where the pagecache
> > can only address up to 16T of data?  Maybe we just don't allow fsverity
> > on 32-bit xfs.
> 
> hmm right, check in begin_enable() will be probably enough

I think that would probably be more of a mount-time prohibition?

Which would be worse -- any fsverity filesystem refuses to mount on
32-bit; or it mounts but none of the fsverity files are readable?

Alternately I guess for 32-bit you could cheat in ->iomap_begin
by loading the fsverity artifacts into the pagecache at 1<<39 instead of
1<<53, provided the file is smaller than 1<<39 bytes.  Writing the
fsverity metadata would perform the reverse translation.

(Or again we just don't allow mounting of fsverity on 32-bit kernels.)

--D

> > > + * address space for Merkle tree.
> > > + *
> > > + * At maximum of 8 levels with 128 hashes per block (32 bytes SHA-256) maximum
> > > + * tree size is ((128^8 − 1)/(128 − 1)) = 567*10^12 blocks. This should fit in 53
> > > + * bits address space.
> > > + *
> > > + * At this Merkle tree size we can cover 295EB large file. This is much larger
> > > + * than the currently supported file size.
> > > + *
> > > + * For sha512 the largest file we can cover ends at 1 << 50 offset, this is also
> > > + * good.
> > > + *
> > > + * The metadata is stored on disk as follows:
> > > + *
> > > + *	[merkle tree...][descriptor.............desc_size]
> > > + *	^ (1 << 53)     ^ (block border)                 ^ (end of the block)
> > > + *	                ^--------------------------------^
> > > + *	                Can be FS_VERITY_MAX_DESCRIPTOR_SIZE
> > > + */
> > > +#define XFS_FSVERITY_REGION_START (1ULL << 53)
> > 
> > Is this in fsblocks or in bytes?  I think the comment should state that
> > explicitly.
> 
> sure, will add it
> 
> -- 
> - Andrey
> 
> 

