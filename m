Return-Path: <linux-fsdevel+bounces-22417-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D128916EFD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 19:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 582B3284D20
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 17:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF35B176AD1;
	Tue, 25 Jun 2024 17:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="NbFLQKnc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFAE1487E9;
	Tue, 25 Jun 2024 17:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336043; cv=none; b=e6UuLcInAeLXvUnEjef3AZmo8UrPIbDcYgP4+E8+3nZE9brf3ijlYWlvUszk+mZmJ0hst87VwjFA0H5iBHIO/zs/ESYPYhdZTaosaJylEyKmBhainRtMhw/eJ9qlfM/mFI23x+Y6rao3xEL+zis0dd6dEjQLN0l0wzaMmzvlkwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336043; c=relaxed/simple;
	bh=TLiCDBlNhJeY858vWS6sfaY2ITG/SSXEtUs2hIiC62w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SdMKEzcXUEWRvvYmY6N3Pyyns4nhrTMXX/BQ3OY2YSl0/vw3fJfZQizx0XP7rDOfzpSgg/DEhbeqPpNEDAHBRV9diwXHnFV70z6w5aoq6naKCl83LVQepogpEiN82RIU/pmndlHdB/kS8VHWKpA9jZVcp3iGo58yF5MJaky0scE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=NbFLQKnc; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4W7s6Y0nJ7z9shY;
	Tue, 25 Jun 2024 19:20:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1719336037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5sRWgIsDN9rxxK/fFSv124QkLdHj/Xm1vNPLxyytvHg=;
	b=NbFLQKncW0PDy/nuxq7Qj2mWHIOZmfmzKWUYbHxAcG3KETJdt8sa33BCfGHmXSfOVFQvrM
	1qnBIvI0tOS8yRKFcipEMRuyw0/KogZXNqLFqc6sfg9vopGxoci7uTq/CJrAQ9JVv94qiM
	+LtspHT+K83wtDVVyPr1lNFdnPtRD5+JAXMHK3C3tBdD0iXynEpTbKlXxUWE4mBcVHNlIV
	4W/FqcDOHE0GDo4ISYViERy9biN5rKmRS+4mUMu52duVNFbvqHjheOPBlgbxzug6RQYg6B
	I3ezacJV7fsESDZtPNmZ+YHrFifPplxNiTu309eyBx8Vpr9i+iA/oX4nb0i1Kw==
Date: Tue, 25 Jun 2024 17:20:31 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Zi Yan <ziy@nvidia.com>
Cc: david@fromorbit.com, willy@infradead.org, chandan.babu@oracle.com,
	djwong@kernel.org, brauner@kernel.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, yang@os.amperecomputing.com,
	linux-mm@kvack.org, john.g.garry@oracle.com,
	linux-fsdevel@vger.kernel.org, hare@suse.de, p.raghav@samsung.com,
	mcgrof@kernel.org, gost.dev@samsung.com, cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org, hch@lst.de, Zi Yan <zi.yan@sent.com>
Subject: Re: [PATCH v8 04/10] mm: split a folio in minimum folio order chunks
Message-ID: <20240625172031.y5yyukeudinescxk@quentin>
References: <20240625114420.719014-1-kernel@pankajraghav.com>
 <20240625114420.719014-5-kernel@pankajraghav.com>
 <D296GAEAQVJB.3FXBQ0WEUJ384@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D296GAEAQVJB.3FXBQ0WEUJ384@nvidia.com>

On Tue, Jun 25, 2024 at 10:45:09AM -0400, Zi Yan wrote:
> On Tue Jun 25, 2024 at 7:44 AM EDT, Pankaj Raghav (Samsung) wrote:
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
> > Reviewed-by: Hannes Reinecke <hare@suse.de>
> > ---
> > There was a discussion about whether we need to consider truncation of
> > folio to be considered a split failure or not [1]. The new code has
> > retained the existing behaviour of returning a failure if the folio was
> > truncated. I think we need to have a separate discussion whethere or not
> > to consider it as a failure.
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
> Regardless this folio split is from a truncation or not, you should not
> count every folio split as a THP_SPLIT_PAGE_FAILED. Since not every
> folio is a THP. You need to do:
> 
> if (folio_test_pmd_mappable(folio))
> 	count_vm_event(THP_SPLIT_PAGE_FAILED);
> 
> See commit 835c3a25aa37 ("mm: huge_memory: add the missing
> folio_test_pmd_mappable() for THP split statistics")

You are right, I will change that. I didn't notice this commit. 

> 	
> > +			return -EBUSY;
> > +		}
> > +		min_order = mapping_min_folio_order(folio->mapping);
> > +	}
> > +
> > +	return split_huge_page_to_list_to_order(&folio->page, list, min_order);
> > +}
> > +
> 
> -- 
> Best Regards,
> Yan, Zi
> 



