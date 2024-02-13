Return-Path: <linux-fsdevel+bounces-11438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C888853D33
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 22:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFDE31C25FB5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 21:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA7B61678;
	Tue, 13 Feb 2024 21:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="0svSCnOw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6084501B;
	Tue, 13 Feb 2024 21:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707859931; cv=none; b=LowKG+GctFfnEsz+u1xz31CQhwRwLOpGLrJE1okE9T6TLjlEu7u7wL20Kt7KlU4jalwFMtflqBKWmgVLgT9tM+gWR3LG0JQDBSI+XSJZqm8OPxj4wt3lzx6Z5aAI+z29MdTdCY07lC2719RiKct7ioucLrsXAvKFYA77BCOzU30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707859931; c=relaxed/simple;
	bh=UAyr1xBbVIB/DUm7ctIrHB4W2osza9OAKUDcRPbzViA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k6bqwgxRHCaLTQs2dYYBrxYLRoz3tgjFYjrlEStO2UDdFpADzOBvC7uFb+7IVYHCCrZwiO06W/QZ6snhNNii7O5SL/Ln6yqN2jrnqbhNL8JsjIble6NtXGCL+mwUVlzREm71taGkX9KYfPP1Q4qpFoYlfPGsl2zIHvlITBcL9RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=0svSCnOw; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4TZF056B7cz9sq5;
	Tue, 13 Feb 2024 22:32:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1707859925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SqfwDLtYqZ4YXjfJ2o5OE5yS66S2VvSjmgmc52Til+A=;
	b=0svSCnOwg9+TLKRVdZO3GM1vAQEP8qcoMdwMPzywRhFTm6ciAv/y+bs9rov5029K9a9h6H
	O9bUtcbYcRsbJfeX98f0iztvh0pB5Vchn/xzbBKUgc5T2z7xCpxNrWd2yxfgcGnjCootlJ
	2cErrMI2Z78Sb67Cyg8L758Sk/1Je6bzP/3VkGOBUv7MvfNXTjk+h/KxZQzUSfuSQlwTh/
	NbXHPZfCoDzNDOPjfwk4PN+br0WErcQ8AoKv1N9/Y9mA3r6znSHor39N6rdoEQbaWORKIA
	1Ne1R2MIAUwb1UEeH2fb7K84qsFbCkJSPWavauvSoeYnIchz3x6GxL3hcycIuQ==
Date: Tue, 13 Feb 2024 22:32:03 +0100
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	mcgrof@kernel.org, gost.dev@samsung.com, akpm@linux-foundation.org, 
	kbusch@kernel.org, chandan.babu@oracle.com, p.raghav@samsung.com, 
	linux-kernel@vger.kernel.org, hare@suse.de, willy@infradead.org, linux-mm@kvack.org, 
	david@fromorbit.com, Dave Chinner <dchinner@redhat.com>
Subject: Re: [RFC v2 11/14] xfs: expose block size in stat
Message-ID: <guvwws55osfm3jy6j6izwpw7ruqlwpxep7qg5ygpape5cusvtf@c3btfmbb4yep>
References: <20240213093713.1753368-1-kernel@pankajraghav.com>
 <20240213093713.1753368-12-kernel@pankajraghav.com>
 <20240213162704.GQ6184@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213162704.GQ6184@frogsfrogsfrogs>
X-Rspamd-Queue-Id: 4TZF056B7cz9sq5

> > diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> > index a0d77f5f512e..8791a9d80897 100644
> > --- a/fs/xfs/xfs_iops.c
> > +++ b/fs/xfs/xfs_iops.c
> > @@ -515,6 +515,8 @@ xfs_stat_blksize(
> >  	struct xfs_inode	*ip)
> >  {
> >  	struct xfs_mount	*mp = ip->i_mount;
> > +	unsigned long	default_size = max_t(unsigned long, PAGE_SIZE,
> > +					     mp->m_sb.sb_blocksize);
> 
> Nit: wonky indentation, but...
> 
> >  
> >  	/*
> >  	 * If the file blocks are being allocated from a realtime volume, then
> > @@ -543,7 +545,7 @@ xfs_stat_blksize(
> >  			return 1U << mp->m_allocsize_log;
> >  	}
> >  
> > -	return PAGE_SIZE;
> > +	return default_size;
> 
> ...why not return max_t(...) directly here?

Sounds good. I will add this change.
> 
> --D
> 
> >  }
> >  
> >  STATIC int
> > -- 
> > 2.43.0
> > 
> > 

