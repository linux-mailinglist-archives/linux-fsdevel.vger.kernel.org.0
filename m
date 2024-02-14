Return-Path: <linux-fsdevel+bounces-11582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDD9854ECC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 17:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A24B31F251B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 16:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4F660272;
	Wed, 14 Feb 2024 16:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="VEyoFOYw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274E617FD;
	Wed, 14 Feb 2024 16:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707928835; cv=none; b=A7NcO26AwdR0g+UDzOOhlKFZKksrLK3xCj6cp3vqR4vTHFtRlBFQc2W88HeAJbtFaBN+2zVHRL7o6LolYwZn+9ZrhOtwkMRklVXk2+s22NsjffKUkE+ikzQx7KwoPgBCuphfAmQPExSByzIRhUYyx8PSXSbqoqpIdaLtwyBAdak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707928835; c=relaxed/simple;
	bh=jeFLilcEYFYDO83Syr44St+JVPp0lVSnDifND7iey2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lXE3/bP/tDBj8ZZO/Sm42ETwDz3Y1oKHJ/p/APggXz4riH4A2I8QkkfKlJlrIhF82YAnbwFKYzbJdtzTPsGmMpys00RwAZjRSQSri+u3ggxtwAmDq28tzWHmSeeDtI5/2sbmxn7dWgmT7KgisFoK/WS6RoXk4FC6ung5C1t8BWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=VEyoFOYw; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4TZkTB0Qm6z9sZq;
	Wed, 14 Feb 2024 17:40:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1707928830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/9YHWSbadLnJWGEqHTooBoi7E54ANCQ9igquOTCLUds=;
	b=VEyoFOYwpHKy9ZK2Xd71CGUCOFK4ZJpTi4cZWFN5uoYVxe6TPUV62Pu6R+tX3mlY55vKZk
	LkWylql3iXvZrkerovzWe4GsQH8T5gJy5BThVq4LIzg5QaKmsHqi1OloCARGkkt46MLoSL
	UiqphhAZ6CXQOss30tc0OXaxkMz/0+aLvBR4fpLdsm17fR6XThEFuDBgznkRJyVfTAtpyo
	KXDlY0PgEVWDvuyg5lNT0k5KvzNb1pJa18mxSzY6QC79T/SGcYfIROUCok9Aswxes5HE2q
	AZqBJeZgvZmqw8A54qIiBzfOQKm2cbuXL9dtFf8Wfv82SWuWbECu8C7P621jhw==
Date: Wed, 14 Feb 2024 17:40:26 +0100
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	mcgrof@kernel.org, gost.dev@samsung.com, akpm@linux-foundation.org, 
	kbusch@kernel.org, chandan.babu@oracle.com, p.raghav@samsung.com, 
	linux-kernel@vger.kernel.org, hare@suse.de, willy@infradead.org, linux-mm@kvack.org, 
	david@fromorbit.com
Subject: Re: [RFC v2 14/14] xfs: enable block size larger than page size
 support
Message-ID: <xxbm5jyzf67xewpougs4xkyzk5xeoo56btdd2sjfv2dv2modx5@djdub3f7nx3a>
References: <20240213093713.1753368-1-kernel@pankajraghav.com>
 <20240213093713.1753368-15-kernel@pankajraghav.com>
 <20240213162007.GO6184@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213162007.GO6184@frogsfrogsfrogs>
X-Rspamd-Queue-Id: 4TZkTB0Qm6z9sZq

> > @@ -323,7 +326,8 @@ xfs_reinit_inode(
> >  	inode->i_rdev = dev;
> >  	inode->i_uid = uid;
> >  	inode->i_gid = gid;
> > -	mapping_set_large_folios(inode->i_mapping);
> > +	min_order = max(min_order, ilog2(mp->m_sb.sb_blocksize) - PAGE_SHIFT);
> > +	mapping_set_folio_orders(inode->i_mapping, min_order, MAX_PAGECACHE_ORDER);
> 
> Twice now I've seen this, which makes me think "refactor this into a
> single function."
> 
> But then, this is really just:
> 
> 	mapping_set_folio_orders(inode->i_mapping,
> 			max(0, inode->i_sb->s_blocksize_bits - PAGE_SHIFT),
> 			MAX_PAGECACHE_ORDER);
> 
> Can we make that a generic inode_set_pagecache_orders helper?

Chinner suggested an alternative to stuff the min_order value in
mp->m_ino_geo. Then it will just be a call to:

mapping_set_folio_orders(VFS_I(ip)->i_mapping,
			M_IGEO(mp)->min_folio_order, MAX_PAGECACHE_ORDER);
> 
> >  	return error;
> >  }
> >  
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
> 
> Please log a warning about the EXPERIMENTAL bs>ps feature being used
> on this mount for the CONFIG_XFS_LBS=y case.
> 
Yes! I will do it as a part of the next revision.


