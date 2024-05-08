Return-Path: <linux-fsdevel+bounces-19083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E49D8BFBF9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 13:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFB361C21786
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 11:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F654823CA;
	Wed,  8 May 2024 11:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="sBAyeqeU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108828174F;
	Wed,  8 May 2024 11:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715167701; cv=none; b=A9of4x4FUjTdEfaRZzD8mz7VDKTC/UJm7YSg6DAEK1qG5eyv0/JDK64MVsDkpRs+z3PEbgCy1YEZF1Zmgq9Drhv7xWs+4KCcWV6a3wtxyxQy+6jzvxVeVjgk6bsIQEj7XrR0+OTzICoaJ/1T6CWBDZKJBJHJnd18bAbiBcbjtXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715167701; c=relaxed/simple;
	bh=RqrS+4cObvr9V80MKpU5viXNMbhNONvo8GIhTJff5Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VR+wwO5AacwW8htjOZMHqqEv6jRbpKHHz2BK8PwWVFOcSK8+nPCltWEq0S9xdDQBndsJXT4rqGN95IsklmqwPaQ6ukLclAwNgWaoktAjh5/n3Ya+CzstDrx6qV0ffoYZ9wZHHWOCj5wr+7EQF0HdaR79g9h45kvxCwx0WjPhPfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=sBAyeqeU; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4VZCZ82xbQz9sQj;
	Wed,  8 May 2024 13:28:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1715167696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GmBxRb8dEBcO7WysWH5PMmHhfDBaYYsSfX6W/AbeUX4=;
	b=sBAyeqeUlFS4QzwYGuKS+yNEungmnNd5/z2vu87H1euUwSdm+GZvtR8x5mv5GcQ6Gmt4RK
	YiGy/9ezRQVznGYXBXRcrdyzIUHoJ0dpc8SNdsjrCMRZbDkuIp/uBHrWlX97IvLh6XN4oQ
	ud4mPP7Yq89sg38zIJ694p9nvdcwAR3lJmHNfVDowuS6JGahGgfhblNadmgLOWi7bn2T+v
	QJEArdbRHEdQr6dvc1NnC4MM3MloY3qJot7Bui0hu/BQ/+X1PPkRDdXjFulyygJIP8SD8T
	EpQf9xGujtM7HvPyPPLufcounzLAEB237NcoTsipuzQFh1QO+3twDhpBfUXRzQ==
Date: Wed, 8 May 2024 11:28:11 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>, akpm@linux-foundation.org,
	willy@infradead.org, brauner@kernel.org, david@fromorbit.com,
	chandan.babu@oracle.com, hare@suse.de, ritesh.list@gmail.com,
	ziy@nvidia.com, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com
Subject: Re: [PATCH v5 10/11] xfs: make the calculation generic in
 xfs_sb_validate_fsb_count()
Message-ID: <20240508112811.lkmlfauztegncj6t@quentin>
References: <20240503095353.3798063-1-mcgrof@kernel.org>
 <20240503095353.3798063-11-mcgrof@kernel.org>
 <b3a3e9c1-91ca-4c7f-81a7-03f905ee0bd8@oracle.com>
 <20240507211310.GW360919@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507211310.GW360919@frogsfrogsfrogs>
X-Rspamd-Queue-Id: 4VZCZ82xbQz9sQj

On Tue, May 07, 2024 at 02:13:10PM -0700, Darrick J. Wong wrote:
> On Tue, May 07, 2024 at 09:40:58AM +0100, John Garry wrote:
> > On 03/05/2024 10:53, Luis Chamberlain wrote:
> > > From: Pankaj Raghav <p.raghav@samsung.com>
> > > 
> > > Instead of assuming that PAGE_SHIFT is always higher than the blocklog,
> > > make the calculation generic so that page cache count can be calculated
> > > correctly for LBS.
> > > 
> > > Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> > > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > > ---
> > >   fs/xfs/xfs_mount.c | 9 ++++++++-
> > >   1 file changed, 8 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
> > > index df370eb5dc15..56d71282972a 100644
> > > --- a/fs/xfs/xfs_mount.c
> > > +++ b/fs/xfs/xfs_mount.c
> > > @@ -133,9 +133,16 @@ xfs_sb_validate_fsb_count(
> > >   {
> > >   	ASSERT(PAGE_SHIFT >= sbp->sb_blocklog);
> > >   	ASSERT(sbp->sb_blocklog >= BBSHIFT);
> > > +	uint64_t max_index;
> > > +	uint64_t max_bytes;
> 
> Extra nit: the  ^ indentation of the names should have tabs, like the
> other xfs functions.
Thanks John and Darrick, I will fold it in the next series.

> 
> --D
> 
> > nit: any other XFS code which I have seen puts the declarations before any
> > ASSERT() calls
> > 
> > > +
> > > +	if (check_shl_overflow(nblocks, sbp->sb_blocklog, &max_bytes))
> > > +		return -EFBIG;
> > >   	/* Limited by ULONG_MAX of page cache index */
> > > -	if (nblocks >> (PAGE_SHIFT - sbp->sb_blocklog) > ULONG_MAX)
> > > +	max_index = max_bytes >> PAGE_SHIFT;
> > > +
> > > +	if (max_index > ULONG_MAX)
> > >   		return -EFBIG;
> > >   	return 0;
> > >   }
> > 
> > 

-- 
Pankaj Raghav

