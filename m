Return-Path: <linux-fsdevel+bounces-21273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E14900CF1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 22:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89A6A28A71D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 20:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997A4154C05;
	Fri,  7 Jun 2024 20:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="fByf2Gpr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D4514E2FF;
	Fri,  7 Jun 2024 20:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717792239; cv=none; b=gnM5yfokh5xi4+kGhS+kkZRln2cgJGNAO/hiXRUd55qWNoiegIve0ixnJKNrb4wIuwlIyPSYiJN7eBnA+shXF62q9ybGD6G+4MI68BQ1af6YaqfDj3POtq9VWjkFYQB2RC2HbL6/Lepr/Hp/YDrW+dhE/YAdGhzF556W4h7BeMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717792239; c=relaxed/simple;
	bh=qTB7GJxp/BAurCOzmcWyP5VlAdBqLtL22rzuMxd5mic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ACLlc1gk1gU+R7/7TB8v60ajlTXwtAhLinAMmtjHVJXy+FDV3BRgmtuvmndimBWrXrP5XntobtZJA4APFSJp700EtdKCwgqRJYxzEDauk49rHb2EwUVMQyjH18Pj5vZLWlUZ3AzHFGCTGY7B0EdHSyXiyMdv/52dA79RkzZhgxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=fByf2Gpr; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4VwtB06wNcz9sjn;
	Fri,  7 Jun 2024 22:30:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1717792233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zayrHH/z5RIcd0P8fXfRYa45JHnjwR22LFwlmddRB1I=;
	b=fByf2GprKvSs9RDKyKm8QidRaXMK/eMvdvXxEJgsugRtXHziRyz7h1fpXuOJF08fQFThPU
	VYKrDF8P/uUWJ/IkwJyGDQAPcE7I5dE/vKK6VToCwmy5gEW59Ly1setDhG6tHesTY99V+2
	ZCFtAAcvM0sbIQ3GmwTuw7g+jegI+VRHhG3147VOjBsZTKWR9cQR3PffAd7M3zAhDsjrIf
	vXZQYhEIUx7V2foDlryJPwA2vbXkicc0z5poVHJu4pZdiHTmZC/TOicmvU/u8uoQOqQGNU
	xMIk0wR0n/9aXVxymhi6ixRI26bcZB9FlUCwrjn5gL5004atn+lqv6c913eFDw==
Date: Fri, 7 Jun 2024 20:30:26 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Zi Yan <ziy@nvidia.com>
Cc: david@fromorbit.com, djwong@kernel.org, chandan.babu@oracle.com,
	brauner@kernel.org, akpm@linux-foundation.org, willy@infradead.org,
	mcgrof@kernel.org, linux-mm@kvack.org, hare@suse.de,
	linux-kernel@vger.kernel.org, yang@os.amperecomputing.com,
	linux-xfs@vger.kernel.org, p.raghav@samsung.com,
	linux-fsdevel@vger.kernel.org, hch@lst.de, gost.dev@samsung.com,
	cl@os.amperecomputing.com, john.g.garry@oracle.com
Subject: Re: [PATCH v7 05/11] mm: split a folio in minimum folio order chunks
Message-ID: <20240607203026.zj3akxdjeykchnnf@quentin>
References: <20240607145902.1137853-1-kernel@pankajraghav.com>
 <20240607145902.1137853-6-kernel@pankajraghav.com>
 <75CCE180-EC90-4BDC-B5D8-0ED1B710BE49@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75CCE180-EC90-4BDC-B5D8-0ED1B710BE49@nvidia.com>

On Fri, Jun 07, 2024 at 12:58:33PM -0400, Zi Yan wrote:
> Hi Pankaj,
> 
> Can you use ziy@nvidia.com instead of zi.yan@sent.com? Since I just use the latter
> to send patches. Thanks.

Got it!

> 
> On 7 Jun 2024, at 10:58, Pankaj Raghav (Samsung) wrote:
> 
> > From: Luis Chamberlain <mcgrof@kernel.org>
> >
> > split_folio() and split_folio_to_list() assume order 0, to support
> > minorder for non-anonymous folios, we must expand these to check the
> > folio mapping order and use that.
> >
> > Set new_order to be at least minimum folio order if it is set in
> > split_huge_page_to_list() so that we can maintain minimum folio order
> > requirement in the page cache.
> >
> > Update the debugfs write files used for testing to ensure the order
> > is respected as well. We simply enforce the min order when a file
> > mapping is used.
> >
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> > ---
> >  include/linux/huge_mm.h | 14 ++++++++---
> >  mm/huge_memory.c        | 55 ++++++++++++++++++++++++++++++++++++++---
> >  2 files changed, 61 insertions(+), 8 deletions(-)
> >
> 
> <snip>
> 
> >
> > +int split_folio_to_list(struct folio *folio, struct list_head *list)
> > +{
> > +	unsigned int min_order = 0;
> > +
> > +	if (!folio_test_anon(folio)) {
> > +		if (!folio->mapping) {
> > +			count_vm_event(THP_SPLIT_PAGE_FAILED);
> 
> You should only increase this counter when the input folio is a THP, namely
> folio_test_pmd_mappable(folio) is true. For other large folios, we will
> need a separate counter. Something like MTHP_STAT_FILE_SPLIT_FAILED.
> See enum mthp_stat_item in include/linux/huge_mm.h.
> 
Hmm, but we don't have mTHP support for non-anonymous memory right? In
that case it won't be applicable for file backed memory? 

I am not an expert there so correct me if I am wrong.

--
Regards,
Pankaj


