Return-Path: <linux-fsdevel+bounces-24077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18223939088
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 16:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 477371C216A8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 14:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EF516DC36;
	Mon, 22 Jul 2024 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="PXuQRyta"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2245A16D4EC;
	Mon, 22 Jul 2024 14:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721658099; cv=none; b=ctPLJtnkocIN3sZFAodWoJJV10dm+0AR6OFbVhZA+qhLENixvBl7k6EJJ8EjDqJzhp/BpUdLefslIDYPGqK06Zc466lgxPJciSgTT2jzMIXx5wdFrJUFHQPlUAgiHdWKSSnRu9rdgFtZvnntslL3JyZuc0jozo/Tt3AGLf46dBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721658099; c=relaxed/simple;
	bh=sl205zFYdqQiVyBmG5IrUVs0e9Z9VV8yMDF4pspuGXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sPnmk9FdoF0IGtH2nj6cc847PQF3UTd32/jnbdGqWCvqdKHpJcdnLZERomOaLoiiu89BhBa3B+xuVDSTnSIRtwvHGU+d1DCkfoeiQR8XrBz03+lGih9LbiBoi0vkmESGV7FfwI806LO+u2KCwYHR3MBk8rWVfRVl5wHFQ84ufgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=PXuQRyta; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4WSMfz5qRFz9stk;
	Mon, 22 Jul 2024 16:12:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1721657547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y5Xo3wX+uawUJqw7uA4WLjrLhTEALsLM/1oRvrJDUlk=;
	b=PXuQRytaUpGN7kf+yu98HpPlESNqnRQU/ex7u+sGLE06XGC9p8gwH1AoB3UQzjDxZYONAi
	l4rjOuDXiUIv1rRzRPPCiqoFKcmL98MYAPtd4gD8FTo6FzhhvI/jG/RgPy9LK/CGaKupYK
	Wu/52h6Y+pLTMg/iuyIL5CzGqEH6S6muUB/Y95kyFtw6UWygorgEyNidQjFJlOA0TYXn8G
	FqYivrOu2AV4sBmnR4lf45MW5rTOYBhAoTcbWLJ4J10KQupuIYBSCo7/wwtCJzL44GpYrS
	s1+ErgPmNvpenxQcvT3EARhkfVyZGNMBXPLrPBUdVXHTqQvK4Vyzky7ghMlEtQ==
Date: Mon, 22 Jul 2024 14:12:20 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: david@fromorbit.com, willy@infradead.org, chandan.babu@oracle.com,
	brauner@kernel.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, yang@os.amperecomputing.com,
	linux-mm@kvack.org, john.g.garry@oracle.com,
	linux-fsdevel@vger.kernel.org, hare@suse.de, p.raghav@samsung.com,
	mcgrof@kernel.org, gost.dev@samsung.com, cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org, ryan.roberts@arm.com, hch@lst.de,
	Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v10 10/10] xfs: enable block size larger than page size
 support
Message-ID: <20240722141220.yfxb7jder7mqwgod@quentin>
References: <20240715094457.452836-1-kernel@pankajraghav.com>
 <20240715094457.452836-11-kernel@pankajraghav.com>
 <20240715164632.GV612460@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715164632.GV612460@frogsfrogsfrogs>
X-Rspamd-Queue-Id: 4WSMfz5qRFz9stk

> > +
> > +		if (mp->m_sb.sb_blocksize > max_folio_size) {
> > +			xfs_warn(mp,
> > +"block size (%u bytes) not supported; maximum folio size supported in "\
> > +"the page cache is (%ld bytes). Check MAX_PAGECACHE_ORDER (%d)",
> > +			mp->m_sb.sb_blocksize, max_folio_size,
> > +			MAX_PAGECACHE_ORDER);
> > +			error = -ENOSYS;
> > +			goto out_free_sb;
> 
> Nit: Continuation lines should be indented, not lined up with the next
> statement:
> 
> 			xfs_warn(mp,
> "block size (%u bytes) not supported; maximum folio size supported in "\
> "the page cache is (%ld bytes). Check MAX_PAGECACHE_ORDER (%d)",
> 					mp->m_sb.sb_blocksize,
> 					max_folio_size,
> 					MAX_PAGECACHE_ORDER);
> 			error = -ENOSYS;
> 			goto out_free_sb;

@Darrick: As willy pointed out, the error message is a bit long here.
Can we make as follows:

"block size (%u bytes) not supported; Only block size (%ld) or less is supported "\
                                        mp->m_sb.sb_blocksize,
                                        max_folio_size);

This is similar to the previous error and it is more concise IMO.

> 
> With that fixed,
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> 
> --D
> 

