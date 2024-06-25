Return-Path: <linux-fsdevel+bounces-22425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBE3916FE0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 20:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F09F31C2361B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 18:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FACE17BB3C;
	Tue, 25 Jun 2024 18:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="vSe2sDHF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63682158D84;
	Tue, 25 Jun 2024 18:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719338850; cv=none; b=E++q1ubZAbGhOG6ChlGrTiv8MfmIYFBD+DDLE4LCjk6VxUP/WBe6DjIk39sN2LkMjME+Y98mR3EQHzaKvuOiM7pt/j8YU0sLfqv0NN/Uq/7fKHIiCf0ITy7MPY8PmdSRI3GCpLqO63XziPVwPTtEzlDHk72N5tc5VsKe8HpIwUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719338850; c=relaxed/simple;
	bh=nGkQ2sVVVsXNW3MPE20jh/XVZFKZnSfNcTCAJh7RbC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jc+pGuhlTGuxVSASAI4yO15lrPHI7AA/WEDBOXq882IuabqhGAXq9M3X8qVxj+uecSYdN+ot9Y2BKVfmfI87TIZ+nd0JGVtUqnhp6fEEaKf7dHxG+T8OquWul5oQ7u/iM86ED5yangt1IjiCrwmdxipYH/59k0UszFAiGs4NdvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=vSe2sDHF; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4W7t8X471xz9spX;
	Tue, 25 Jun 2024 20:07:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1719338844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LzWBYB2Gv7p9oshvlsKyQsodiqzS1M8ZSWboiFntUYM=;
	b=vSe2sDHFQLJAI2F32jwY/9aqW9fO4IhYAUQw8hSEDq5R4aIt2It3K61jhJC1EglU9M0AY7
	JkUsyCIpukvFE6g2oRaAh7ds1J6Smwu7sqcsWIEFUCSlB/aGvUVYQb5usf6/K3mS+FJbr5
	AibDi6KTwCI91f40QVKQOK0EmVAQVHFllW3mu1F3drbhzmOnGRSrqLxqJFQKMhngLinij4
	32n1Ui7nKfS64z7gewXlECNAqCkcWnEpvkK25pf2RfaPwCqacsv2eNd36TSq2m6eY//NTG
	XUQuuNd7VPpcGss4hSidOh5HOagE5Dl5P8cvLm+V/PRuIpquJDdTD8Xvpvo+6Q==
Date: Tue, 25 Jun 2024 18:07:20 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: david@fromorbit.com, willy@infradead.org, chandan.babu@oracle.com,
	djwong@kernel.org, brauner@kernel.org, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, yang@os.amperecomputing.com,
	linux-mm@kvack.org, john.g.garry@oracle.com,
	linux-fsdevel@vger.kernel.org, hare@suse.de, p.raghav@samsung.com,
	mcgrof@kernel.org, gost.dev@samsung.com, cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org, hch@lst.de, Zi Yan <zi.yan@sent.com>,
	Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH v8 07/10] xfs: use kvmalloc for xattr buffers
Message-ID: <20240625180720.ali2zno6f62u3pi7@quentin>
References: <20240625114420.719014-1-kernel@pankajraghav.com>
 <20240625114420.719014-8-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625114420.719014-8-kernel@pankajraghav.com>

On Tue, Jun 25, 2024 at 11:44:17AM +0000, Pankaj Raghav (Samsung) wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Pankaj Raghav reported that when filesystem block size is larger
> than page size, the xattr code can use kmalloc() for high order
> allocations. This triggers a useless warning in the allocator as it
> is a __GFP_NOFAIL allocation here:
> 
> static inline
> struct page *rmqueue(struct zone *preferred_zone,
>                         struct zone *zone, unsigned int order,
>                         gfp_t gfp_flags, unsigned int alloc_flags,
>                         int migratetype)
> {
>         struct page *page;
> 
>         /*
>          * We most definitely don't want callers attempting to
>          * allocate greater than order-1 page units with __GFP_NOFAIL.
>          */
> >>>>    WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
> ...
> 
> Fix this by changing all these call sites to use kvmalloc(), which
> will strip the NOFAIL from the kmalloc attempt and if that fails
> will do a __GFP_NOFAIL vmalloc().
> 
> This is not an issue that productions systems will see as
> filesystems with block size > page size cannot be mounted by the
> kernel; Pankaj is developing this functionality right now.
> 
> Reported-by: Pankaj Raghav <kernel@pankajraghav.com>
> Fixes: f078d4ea8276 ("xfs: convert kmem_alloc() to kmalloc()")
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>

@Chandan: As we discussed today, do you want to pick this up for 6.11?
Then I can drop it from my patch series.

> ---
>  fs/xfs/libxfs/xfs_attr_leaf.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_attr_leaf.c b/fs/xfs/libxfs/xfs_attr_leaf.c
> index b9e98950eb3d..09f4cb061a6e 100644
> --- a/fs/xfs/libxfs/xfs_attr_leaf.c
> +++ b/fs/xfs/libxfs/xfs_attr_leaf.c
> @@ -1138,10 +1138,7 @@ xfs_attr3_leaf_to_shortform(
>  
>  	trace_xfs_attr_leaf_to_sf(args);
>  
> -	tmpbuffer = kmalloc(args->geo->blksize, GFP_KERNEL | __GFP_NOFAIL);
> -	if (!tmpbuffer)
> -		return -ENOMEM;
> -
> +	tmpbuffer = kvmalloc(args->geo->blksize, GFP_KERNEL | __GFP_NOFAIL);
>  	memcpy(tmpbuffer, bp->b_addr, args->geo->blksize);
>  
>  	leaf = (xfs_attr_leafblock_t *)tmpbuffer;
> @@ -1205,7 +1202,7 @@ xfs_attr3_leaf_to_shortform(
>  	error = 0;
>  
>  out:
> -	kfree(tmpbuffer);
> +	kvfree(tmpbuffer);
>  	return error;
>  }
>  
> @@ -1613,7 +1610,7 @@ xfs_attr3_leaf_compact(
>  
>  	trace_xfs_attr_leaf_compact(args);
>  
> -	tmpbuffer = kmalloc(args->geo->blksize, GFP_KERNEL | __GFP_NOFAIL);
> +	tmpbuffer = kvmalloc(args->geo->blksize, GFP_KERNEL | __GFP_NOFAIL);
>  	memcpy(tmpbuffer, bp->b_addr, args->geo->blksize);
>  	memset(bp->b_addr, 0, args->geo->blksize);
>  	leaf_src = (xfs_attr_leafblock_t *)tmpbuffer;
> @@ -1651,7 +1648,7 @@ xfs_attr3_leaf_compact(
>  	 */
>  	xfs_trans_log_buf(trans, bp, 0, args->geo->blksize - 1);
>  
> -	kfree(tmpbuffer);
> +	kvfree(tmpbuffer);
>  }
>  
>  /*
> @@ -2330,7 +2327,7 @@ xfs_attr3_leaf_unbalance(
>  		struct xfs_attr_leafblock *tmp_leaf;
>  		struct xfs_attr3_icleaf_hdr tmphdr;
>  
> -		tmp_leaf = kzalloc(state->args->geo->blksize,
> +		tmp_leaf = kvzalloc(state->args->geo->blksize,
>  				GFP_KERNEL | __GFP_NOFAIL);
>  
>  		/*
> @@ -2371,7 +2368,7 @@ xfs_attr3_leaf_unbalance(
>  		}
>  		memcpy(save_leaf, tmp_leaf, state->args->geo->blksize);
>  		savehdr = tmphdr; /* struct copy */
> -		kfree(tmp_leaf);
> +		kvfree(tmp_leaf);
>  	}
>  
>  	xfs_attr3_leaf_hdr_to_disk(state->args->geo, save_leaf, &savehdr);
> -- 
> 2.44.1
> 

