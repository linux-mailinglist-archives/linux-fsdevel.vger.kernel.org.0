Return-Path: <linux-fsdevel+bounces-18025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CEA8B4DD7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 23:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC2DEB20D82
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 21:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8947FB660;
	Sun, 28 Apr 2024 21:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="hWtochC6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A4C389;
	Sun, 28 Apr 2024 21:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714338406; cv=none; b=H40kCCaNxlfLHGzmaWnVL0h6Jy2yFfzFMPNCPGN/eqFQQDttFOuc4KnrSJr3I5pMwsPZR7i0i5/rlfK1lslhzq11EUwB8reJGRB1fcKRHh8ZBZ4LQ1S5T+QVjVSoU8KrJ/kxiDCMCFMYFOoaTZE6DR6xBVzhUUZpsUGFqMI8mj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714338406; c=relaxed/simple;
	bh=qVoyDKva76pyHWAnpgXS+CNDH7/QfVHQPMFgQ33N1Q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+ova6HX/JBsOisqX76mgniQQFtaBbNlW7dQQC1rUBT465szq79H6KdFBgVwpAQgPHAvrrTAzzVGlUncboWlw8ksKDXmUvHfK6nTKNn5wNWwlgd7EANcV9Utkr7qv2t4lJ+LLwdQX7+qptnQoSXQr993dPjEp5y7JVgTH4euXFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=hWtochC6; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4VSJt66fNZz9swb;
	Sun, 28 Apr 2024 23:06:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1714338398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7yxstpfnkO3d6ouRSTqsWyefS+SUn2WUJo5CNc78Tx4=;
	b=hWtochC67R8d8LjON5739UYFSl2qdlo+HPeyQ93kCeiu27w1Hc5kL+WNPD3wkURNOl/BFr
	0AEX3XZygq/wqsMafbK7aJFuzVrgqcAtYLW4J63F9ClE5twZb3i/+vA6fb8YRMx5eLRFja
	Sw0QfZAGYZorDd6m5SwYqs2X+FxS6GleGpstNtaA4qOA2re3AplSgIKKvFygBLfccJFc7H
	O21RkqZHP7OR0vDmRJxJbLfvG7envg7eTtQSZ7EKlfmU8NZn6hVOfrVBAx9bs+J667iWHx
	DJejx6o/LhM10+X0A5pzYxvafEMWb+1J8U0GN6mQwPV4APY+1E+hVkkbspxBpg==
Date: Sun, 28 Apr 2024 21:06:34 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: willy@infradead.org, brauner@kernel.org, david@fromorbit.com,
	chandan.babu@oracle.com, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, hare@suse.de,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-xfs@vger.kernel.org, mcgrof@kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com, Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH v4 08/11] xfs: use kvmalloc for xattr buffers
Message-ID: <20240428210634.bkarwrwi6rdr6ywx@quentin>
References: <20240425113746.335530-1-kernel@pankajraghav.com>
 <20240425113746.335530-9-kernel@pankajraghav.com>
 <20240426151844.GH360919@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426151844.GH360919@frogsfrogsfrogs>

On Fri, Apr 26, 2024 at 08:18:44AM -0700, Darrick J. Wong wrote:
> On Thu, Apr 25, 2024 at 01:37:43PM +0200, Pankaj Raghav (Samsung) wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > Pankaj Raghav reported that when filesystem block size is larger
> > than page size, the xattr code can use kmalloc() for high order
> > allocations. This triggers a useless warning in the allocator as it
> > is a __GFP_NOFAIL allocation here:
> > 
> > static inline
> > struct page *rmqueue(struct zone *preferred_zone,
> >                         struct zone *zone, unsigned int order,
> >                         gfp_t gfp_flags, unsigned int alloc_flags,
> >                         int migratetype)
> > {
> >         struct page *page;
> > 
> >         /*
> >          * We most definitely don't want callers attempting to
> >          * allocate greater than order-1 page units with __GFP_NOFAIL.
> >          */
> > >>>>    WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
> > ...
> > 
> > Fix this by changing all these call sites to use kvmalloc(), which
> > will strip the NOFAIL from the kmalloc attempt and if that fails
> > will do a __GFP_NOFAIL vmalloc().
> > 
> > This is not an issue that productions systems will see as
> > filesystems with block size > page size cannot be mounted by the
> > kernel; Pankaj is developing this functionality right now.
> > 
> > Reported-by: Pankaj Raghav <kernel@pankajraghav.com>
> > Fixes: f078d4ea8276 ("xfs: convert kmem_alloc() to kmalloc()")
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> 
> Didn't this already go in for-next?

I don't think so. I think Christoph suggested to have it in the LBS
series and see if MM folks can fix the issue upstream.[1]

[1] https://www.spinics.net/lists/linux-xfs/msg83130.html
> 
> If not,
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> 
> --D
> 
> > ---
> >  fs/xfs/libxfs/xfs_attr_leaf.c | 15 ++++++---------
> >  1 file changed, 6 insertions(+), 9 deletions(-)
> > 
> > diff --git a/fs/xfs/libxfs/xfs_attr_leaf.c b/fs/xfs/libxfs/xfs_attr_leaf.c
> > index ac904cc1a97b..969abc6efd70 100644
> > --- a/fs/xfs/libxfs/xfs_attr_leaf.c
> > +++ b/fs/xfs/libxfs/xfs_attr_leaf.c
> > @@ -1059,10 +1059,7 @@ xfs_attr3_leaf_to_shortform(
> >  
> >  	trace_xfs_attr_leaf_to_sf(args);
> >  
> > -	tmpbuffer = kmalloc(args->geo->blksize, GFP_KERNEL | __GFP_NOFAIL);
> > -	if (!tmpbuffer)
> > -		return -ENOMEM;
> > -
> > +	tmpbuffer = kvmalloc(args->geo->blksize, GFP_KERNEL | __GFP_NOFAIL);
> >  	memcpy(tmpbuffer, bp->b_addr, args->geo->blksize);
> >  
> >  	leaf = (xfs_attr_leafblock_t *)tmpbuffer;
> > @@ -1125,7 +1122,7 @@ xfs_attr3_leaf_to_shortform(
> >  	error = 0;
> >  
> >  out:
> > -	kfree(tmpbuffer);
> > +	kvfree(tmpbuffer);
> >  	return error;
> >  }
> >  
> > @@ -1533,7 +1530,7 @@ xfs_attr3_leaf_compact(
> >  
> >  	trace_xfs_attr_leaf_compact(args);
> >  
> > -	tmpbuffer = kmalloc(args->geo->blksize, GFP_KERNEL | __GFP_NOFAIL);
> > +	tmpbuffer = kvmalloc(args->geo->blksize, GFP_KERNEL | __GFP_NOFAIL);
> >  	memcpy(tmpbuffer, bp->b_addr, args->geo->blksize);
> >  	memset(bp->b_addr, 0, args->geo->blksize);
> >  	leaf_src = (xfs_attr_leafblock_t *)tmpbuffer;
> > @@ -1571,7 +1568,7 @@ xfs_attr3_leaf_compact(
> >  	 */
> >  	xfs_trans_log_buf(trans, bp, 0, args->geo->blksize - 1);
> >  
> > -	kfree(tmpbuffer);
> > +	kvfree(tmpbuffer);
> >  }
> >  
> >  /*
> > @@ -2250,7 +2247,7 @@ xfs_attr3_leaf_unbalance(
> >  		struct xfs_attr_leafblock *tmp_leaf;
> >  		struct xfs_attr3_icleaf_hdr tmphdr;
> >  
> > -		tmp_leaf = kzalloc(state->args->geo->blksize,
> > +		tmp_leaf = kvzalloc(state->args->geo->blksize,
> >  				GFP_KERNEL | __GFP_NOFAIL);
> >  
> >  		/*
> > @@ -2291,7 +2288,7 @@ xfs_attr3_leaf_unbalance(
> >  		}
> >  		memcpy(save_leaf, tmp_leaf, state->args->geo->blksize);
> >  		savehdr = tmphdr; /* struct copy */
> > -		kfree(tmp_leaf);
> > +		kvfree(tmp_leaf);
> >  	}
> >  
> >  	xfs_attr3_leaf_hdr_to_disk(state->args->geo, save_leaf, &savehdr);
> > -- 
> > 2.34.1
> > 
> > 

