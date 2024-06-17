Return-Path: <linux-fsdevel+bounces-21831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D6B90B5D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 18:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 799C0281272
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 16:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AA5DF4D;
	Mon, 17 Jun 2024 16:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="iAQnuvoL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25031D9511;
	Mon, 17 Jun 2024 16:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718640594; cv=none; b=oAY5EjDgnPUlnpH+KYilIr79qCxA/s/MwLI2iVuX37b1lxtwGR4iS9iEoUh7dicybN/byAA5RFe4hbY9A5ILkuCtljUPx5WnpRXxR4WRregxglDIylDeIdJu/4eCcfBTQc3kgsUSQW9wU/QEycavgIvWJ0nwdcOfu7OTrDt6rl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718640594; c=relaxed/simple;
	bh=QlfJ70u2Wi7LleuJicNvtfvXzL7+E99lv8MRZrSVKR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4ux8HWHH1pYzOtgPjEBvQ21xNHdMqg5IblHcZoWY0q0Gc+ZmGmub0dXMdnCG1q2/1iLBXR7/yruwOEdornocF4QY1QlOwJgrm+QRPw3fSiOBZax+JNq2CJEdExIAordZDHsfgKE8L4K1uPuphGRaC7dC0zfUldLKFOvRLm/p94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=iAQnuvoL; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4W2vwR4pMXz9sTr;
	Mon, 17 Jun 2024 18:09:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1718640583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=REOd4xGqWzBzFhAFswjKmpm8iEKvSL4/tKnq1vydLTA=;
	b=iAQnuvoLmSElAeAjhjfiIaHZexRTvjZegkZcSJ9eYDpr05M5HTEWGMlmm7r9KvsaN6cvya
	dvm7Nqg2opfsECU6ySm5+pRyuCzW3Vie4s7JVMy0PWEczowRhmNDdi9eHsbPRbyAlnfZhp
	m7cviQDmpB/IaU4VAdiPRzvhqlu9EJ/0Mnds+X5ESMzQ0C71pp1sJ+EuMjSNYJSl599a9C
	jkonE4yjDlceYx77FOHI1U+dTIFyc+NPl/QmuuAEpepMzewjh4bvAXlBHgvIf+ocGuYbip
	l40pGiq3z+wZE8QoV+C0H+tTCJwT3HrMxZBiSQwjYUYteO1j7V+gs3N8clsrRw==
Date: Mon, 17 Jun 2024 16:09:37 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Christoph Hellwig <hch@lst.de>
Cc: david@fromorbit.com, djwong@kernel.org, chandan.babu@oracle.com,
	brauner@kernel.org, akpm@linux-foundation.org, willy@infradead.org,
	mcgrof@kernel.org, linux-mm@kvack.org, hare@suse.de,
	linux-kernel@vger.kernel.org, yang@os.amperecomputing.com,
	Zi Yan <zi.yan@sent.com>, linux-xfs@vger.kernel.org,
	p.raghav@samsung.com, linux-fsdevel@vger.kernel.org,
	gost.dev@samsung.com, cl@os.amperecomputing.com,
	john.g.garry@oracle.com
Subject: Re: [PATCH v7 10/11] xfs: make the calculation generic in
 xfs_sb_validate_fsb_count()
Message-ID: <20240617160937.o65vhvtzr5u5iy2o@quentin>
References: <20240607145902.1137853-1-kernel@pankajraghav.com>
 <20240607145902.1137853-11-kernel@pankajraghav.com>
 <20240613084545.GB23371@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613084545.GB23371@lst.de>

On Thu, Jun 13, 2024 at 10:45:45AM +0200, Christoph Hellwig wrote:
> > +	uint64_t		max_index;
> > +	uint64_t		max_bytes;
> > +
> >  	ASSERT(PAGE_SHIFT >= sbp->sb_blocklog);
> >  	ASSERT(sbp->sb_blocklog >= BBSHIFT);
> >  
> > +	if (check_shl_overflow(nblocks, sbp->sb_blocklog, &max_bytes))
> > +		return -EFBIG;
> > +
> >  	/* Limited by ULONG_MAX of page cache index */
> > -	if (nblocks >> (PAGE_SHIFT - sbp->sb_blocklog) > ULONG_MAX)
> > +	max_index = max_bytes >> PAGE_SHIFT;
> > +
> > +	if (max_index > ULONG_MAX)
> 
> Do we really need the max_index variable for a single user here?
> Or do you plan to add more uses of it later (can't really think of one
> though)?

Yeah, we could just inline it:

diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index a99454208807..c6933440f806 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -132,7 +132,6 @@ xfs_sb_validate_fsb_count(
        xfs_sb_t        *sbp,
        uint64_t        nblocks)
 {
-       uint64_t                max_index;
        uint64_t                max_bytes;
 
        ASSERT(sbp->sb_blocklog >= BBSHIFT);
@@ -141,9 +140,7 @@ xfs_sb_validate_fsb_count(
                return -EFBIG;
 
        /* Limited by ULONG_MAX of page cache index */
-       max_index = max_bytes >> PAGE_SHIFT;
-
-       if (max_index > ULONG_MAX)
+       if (max_bytes >> PAGE_SHIFT > ULONG_MAX)
                return -EFBIG;
        return 0;
 }

> 

