Return-Path: <linux-fsdevel+bounces-11580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D60854F00
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 17:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01AC4B2E397
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 16:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681E560BB3;
	Wed, 14 Feb 2024 16:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="uqz1HZg4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B32160861;
	Wed, 14 Feb 2024 16:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707928564; cv=none; b=gBwFB1PvJRWBWEWI5OQiOZf6HmXX+0WprZRlew8x1FmVpcFdSjDjRich2SP/i0vetjKvKBegqZrrV+4KqSmRP8XYyftYaAclokNOvdlvD1FCzT4e/C5YqNcM2/bRq//e+6LlWToOksrM2viua3OMer1NEWkZpdDohAkf1Us/VP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707928564; c=relaxed/simple;
	bh=X++txwDNmpSgWtg4YWDrsaZpu20Evuv6ULqOI+MAA4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=trvsnwbmuznUVtQ7O+i4txv2eRpNYbO3iEHi1yV9nL8eGhpPWMmiwfNr3rJ4EEeViK5FDgfRnTlgbCwcLMxnjasBz8u4NYaBkv9dOF5Nwf/QTb1MQNyt+e2Vob3yJZngW7yDBCx+y3a8AAnfcCCKNhn1q13Ce0FfP6LuYj83UDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=uqz1HZg4; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4TZkMs4fClz9srB;
	Wed, 14 Feb 2024 17:35:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1707928553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZsfovuJLzdrxRa6MGc34FOslobJjKQvkqoVmuE4JFsY=;
	b=uqz1HZg4B1Wfl18CTY+bqw7WLjhJdrSZYhgK7tFyfV+vYT8pyHYw4mIXFv5BwVACA0khwK
	AWW7+aUsZvYeOGnP6EdaZIRVm68I7V7PQKOEywEHpqoBpqa/fJdxwvI2Zkcl9kXppjIwCY
	HpAz+RkIsoh2M2ud0Not3jgDBoZdFgHQVILWbZZxzrvyUZmtC5buSBAPaPhCgjs3f4K93I
	fACz64Y4i0WjPEiM3Wqus4gq6xdPLtptrCAcXmZsi2jaICOxGHc2b1mQWpzSr4mKOJ6r4P
	3rHAiM8M21FNtOhxuqkkoXdlcfpFYfEGjXsrjBf/U22LpORo0GyiGGQD1UJn/Q==
Date: Wed, 14 Feb 2024 17:35:49 +0100
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	mcgrof@kernel.org, gost.dev@samsung.com, akpm@linux-foundation.org, 
	kbusch@kernel.org, djwong@kernel.org, chandan.babu@oracle.com, p.raghav@samsung.com, 
	linux-kernel@vger.kernel.org, hare@suse.de, willy@infradead.org, linux-mm@kvack.org
Subject: Re: [RFC v2 14/14] xfs: enable block size larger than page size
 support
Message-ID: <n45xfink7g4fhdrnp4i7tp6tsebvncxicbe4hooswtwwydlakd@4zviowhp53rs>
References: <20240213093713.1753368-1-kernel@pankajraghav.com>
 <20240213093713.1753368-15-kernel@pankajraghav.com>
 <ZcvgSSbIqm4N6TVJ@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcvgSSbIqm4N6TVJ@dread.disaster.area>
X-Rspamd-Queue-Id: 4TZkMs4fClz9srB

> >  	struct xfs_inode	*ip;
> > +	int			min_order = 0;
> >  
> >  	/*
> >  	 * XXX: If this didn't occur in transactions, we could drop GFP_NOFAIL
> > @@ -88,7 +89,8 @@ xfs_inode_alloc(
> >  	/* VFS doesn't initialise i_mode or i_state! */
> >  	VFS_I(ip)->i_mode = 0;
> >  	VFS_I(ip)->i_state = 0;
> > -	mapping_set_large_folios(VFS_I(ip)->i_mapping);
> > +	min_order = max(min_order, ilog2(mp->m_sb.sb_blocksize) - PAGE_SHIFT);
> > +	mapping_set_folio_orders(VFS_I(ip)->i_mapping, min_order, MAX_PAGECACHE_ORDER);
> 
> That's pretty nasty. You're using max() to hide underflow in the
> subtraction to clamp the value to zero. And you don't need ilog2()
> because we have the log of the block size in the superblock already.
> 
> 	int			min_order = 0;
> 	.....
> 	if (mp->m_sb.sb_blocksize > PAGE_SIZE)
> 		min_order = mp->m_sb.sb_blocklog - PAGE_SHIFT;
how is it underflowing if I am comparing two values of type int?

> 
> But, really why recalculate this -constant- on every inode
> allocation?  That's a very hot path, so this should be set in the
> M_IGEO(mp) structure (mp->m_ino_geo) at mount time and then the code
> is simply:
> 
> 	mapping_set_folio_orders(VFS_I(ip)->i_mapping,
> 			M_IGEO(mp)->min_folio_order, MAX_PAGECACHE_ORDER);
> 

That is a good idea. I will add this change in the next revision.

> We already access the M_IGEO(mp) structure every inode allocation,
> so there's little in way of additional cost here....
> 
> > diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> > index 5a2512d20bd0..6a3f0f6727eb 100644
> > --- a/fs/xfs/xfs_super.c
> > +++ b/fs/xfs/xfs_super.c
> > @@ -1625,13 +1625,11 @@ xfs_fs_fill_super(
> >  		goto out_free_sb;
> >  	}
> >  
> > -	/*
> > -	 * Until this is fixed only page-sized or smaller data blocks work.
> > -	 */
> > -	if (mp->m_sb.sb_blocksize > PAGE_SIZE) {
> > +	if (!IS_ENABLED(CONFIG_XFS_LBS) && mp->m_sb.sb_blocksize > PAGE_SIZE) {
> >  		xfs_warn(mp,
> >  		"File system with blocksize %d bytes. "
> > -		"Only pagesize (%ld) or less will currently work.",
> > +		"Only pagesize (%ld) or less will currently work. "
> > +		"Enable Experimental CONFIG_XFS_LBS for this support",
> >  				mp->m_sb.sb_blocksize, PAGE_SIZE);
> >  		error = -ENOSYS;
> >  		goto out_free_sb;
> 
> This should just issue a warning if bs > ps.
> 
> 	if (mp->m_sb.sb_blocksize > PAGE_SIZE) {
>   		xfs_warn(mp,
> "EXPERIMENTAL: Filesystem with Large Block Size (%d bytes) enabled.",
> 			mp->m_sb.sb_blocksize);
> 	}

Yes! Luis already told me to add a warning here but I missed it before
sending the patches out.

> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com

