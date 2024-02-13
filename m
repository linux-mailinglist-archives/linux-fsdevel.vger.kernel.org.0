Return-Path: <linux-fsdevel+bounces-11450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA85853D92
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 22:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D68ED1F2917F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 21:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D6C62156;
	Tue, 13 Feb 2024 21:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="HqlWUR4g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D8D6168A;
	Tue, 13 Feb 2024 21:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707860906; cv=none; b=iADhwU6UhHX4X1Q/37Sv2/cdDD1I0RTqTzt47/+h2kzgPjn1touEAGAAybXQUyUXiWpZJTnD5rmPqtu2nOGc4ZyWPh3iVNGI7U2q3P4Ss016effBtWkfBpd0JwZQaevqKhkIcBfqEUc6MZQ038NRJroeYiH/Sq3VLmMhb18Wlb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707860906; c=relaxed/simple;
	bh=g5PCXNzre28HuGxlZsmb2rJHQpZqaEBlsB606bfc8TQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qPFAQUwiUHLl2WaORgB4TGd8OOqpVk5g7Uwkp+s1e5graks4lVJpTZRAu8CRBQ8KlhndOb4is8TGkVjwXQSXrzllMYTWVR4P8ZZxCUazcTCez1n0sbNzUhgXA5iKhdGqEuy8XbyvFihCaMn/pt4Nxow6I16+w9PfBg/zQkzSVBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=HqlWUR4g; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4TZFLr2xxcz9sqN;
	Tue, 13 Feb 2024 22:48:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1707860900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ykCSvbVtFiBVrhtTjWwOXRXS55nDdON2NLoOZ7/jR0k=;
	b=HqlWUR4gmP/sxc5ye4ZUTrM2ExyOkJkm3RuSuV1a77+pECRbnN/ZT1pTS4qIRA+rt5Zz7p
	mJZFFe3c293kPAzY1SO+qtu+iBCAoRSb3zRsUNPAXgAli0xwBYd7WySIyesvDcToHAtPle
	UuMchaXNerqQ051JhHBe3qAvyZJiaTv6dVgkyFjkUgBJlZDiP1gn6SJQHvfOuW+Vyv86+6
	g2BJr7UxqDb9xKPp5ZxVDuEWuwYXuzUezcmKMc4PCUSca5Ygzta2DWXlyq7Nf8Wi7lOS0/
	GjZov4SgAG0ybT0iS1jv4Tskpmdawpi9smZXcWOfLxZZFAWizWijGBEKOMz7UQ==
Date: Tue, 13 Feb 2024 22:48:17 +0100
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	mcgrof@kernel.org, gost.dev@samsung.com, akpm@linux-foundation.org, 
	kbusch@kernel.org, chandan.babu@oracle.com, p.raghav@samsung.com, 
	linux-kernel@vger.kernel.org, hare@suse.de, willy@infradead.org, linux-mm@kvack.org, 
	david@fromorbit.com
Subject: Re: [RFC v2 12/14] xfs: make the calculation generic in
 xfs_sb_validate_fsb_count()
Message-ID: <loupixsa7jfjuhry2vm7o6j4k3qsdq6yvupcrbbum2m3hpuxau@5n72zpj5vrjh>
References: <20240213093713.1753368-1-kernel@pankajraghav.com>
 <20240213093713.1753368-13-kernel@pankajraghav.com>
 <20240213162611.GP6184@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213162611.GP6184@frogsfrogsfrogs>

On Tue, Feb 13, 2024 at 08:26:11AM -0800, Darrick J. Wong wrote:
> On Tue, Feb 13, 2024 at 10:37:11AM +0100, Pankaj Raghav (Samsung) wrote:
> > From: Pankaj Raghav <p.raghav@samsung.com>
> > 
> > Instead of assuming that PAGE_SHIFT is always higher than the blocklog,
> > make the calculation generic so that page cache count can be calculated
> > correctly for LBS.
> > 
> > Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> > ---
> >  fs/xfs/xfs_mount.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
> > index aabb25dc3efa..bfbaaecaf668 100644
> > --- a/fs/xfs/xfs_mount.c
> > +++ b/fs/xfs/xfs_mount.c
> > @@ -133,9 +133,13 @@ xfs_sb_validate_fsb_count(
> >  {
> >  	ASSERT(PAGE_SHIFT >= sbp->sb_blocklog);
> >  	ASSERT(sbp->sb_blocklog >= BBSHIFT);
> > +	unsigned long mapping_count;
> 
> Nit: indenting
> 
> 	unsigned long		mapping_count;

I will add this in the next revision.
> 
> > +	uint64_t bytes = nblocks << sbp->sb_blocklog;
> 
> What happens if someone feeds us a garbage fs with sb_blocklog > 64?
> Or did we check that previously, so an overflow isn't possible?
> 
I was thinking of possibility of an overflow but at the moment the 
blocklog is capped at 16 (65536 bytes) right? mkfs refuses any block
sizes more than 64k. And we have check for this in xfs_validate_sb_common()
in the kernel, which will catch it before this happens?

> > +
> > +	mapping_count = bytes >> PAGE_SHIFT;
> 
> Does this result in truncation when unsigned long is 32 bits?

Ah, good point. So it is better to use uint64_t for mapping_count as
well to be on the safe side?

> 
> --D
> 
> >  
> >  	/* Limited by ULONG_MAX of page cache index */
> > -	if (nblocks >> (PAGE_SHIFT - sbp->sb_blocklog) > ULONG_MAX)
> > +	if (mapping_count > ULONG_MAX)
> >  		return -EFBIG;
> >  	return 0;
> >  }
> > -- 
> > 2.43.0
> > 
> > 

