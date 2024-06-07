Return-Path: <linux-fsdevel+bounces-21274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6049C900D25
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 22:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DB641C21B98
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 20:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A572154BFC;
	Fri,  7 Jun 2024 20:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="0CerIIJO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B455213E04F;
	Fri,  7 Jun 2024 20:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717793169; cv=none; b=osbbtweoJnF7EqY40wdXiiK6pVbYwUYn9tSKJzVAK+d5roDGZb5mNHbGFxBLyxLnDh9mBnkcGVGihQNtnITuetxXqgT24neZwXZs/14UGVGtR1GRDMSS+XLKFVWesoHNysThGCcr+GM8P79rVDmjJPaPNzES5SBaE38G3ji1tMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717793169; c=relaxed/simple;
	bh=6BVzj3qh2Mv5XAwPAz+fAtU5sQPKfffASaDwumP+ZJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bph641zhCEvXXFsXF3v3PHEatRYV59fi20zY52l9iS5IVKPXvx/f5eT/0YG6j/63r8E1n266HLHuvtlmoJ3v/wzA8zl+CvwdyDam6+s8rcZ7tcuHb/a+gRK1Gvhc/uuLpf2sgKCa3AAHKVrahtCGEfCHsCyzhV6pd0BRSCNfdGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=0CerIIJO; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4VwtWp1Fnrz9sdB;
	Fri,  7 Jun 2024 22:45:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1717793158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F+CsyygnqyIZppE2kuEE0dMrpi3Kb0fFXtIf8csIUsc=;
	b=0CerIIJO76D4qaq2U+ap75V3Xmmgwbnq8MsQR/5VN4bigHS8rckc9wzrnA4/H5dbmsI8Zh
	9I1e/wTe04B0VACuXXOHKZmVTD3HYKSCrJhJ8EKCid2ynzOOOhQfRZg6bqFmB6Ae2niqeu
	QUX2J2v5nU9QXqP6+6dtAqO0YnkgDRKueWHnPjC3AAF7Y60/CX74Fg4evPXnlBvn9Y0cU6
	HcEny3zKyT7k5l9Tlu+ozF1BdU0dz7BPBP7tYNN2Z6ovBSnj3tlsCD8iSlD/LdV87IVbbC
	HqjjkvJxZ/23VUv4sEOEm6WBfBpxGBsXlBO9bz/yJCmyanWDuXZOJ9NACFI2Hg==
Date: Fri, 7 Jun 2024 20:45:52 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Zi Yan <ziy@nvidia.com>, david@fromorbit.com, djwong@kernel.org,
	chandan.babu@oracle.com, brauner@kernel.org,
	akpm@linux-foundation.org, mcgrof@kernel.org, linux-mm@kvack.org,
	hare@suse.de, linux-kernel@vger.kernel.org,
	yang@os.amperecomputing.com, linux-xfs@vger.kernel.org,
	p.raghav@samsung.com, linux-fsdevel@vger.kernel.org, hch@lst.de,
	gost.dev@samsung.com, cl@os.amperecomputing.com,
	john.g.garry@oracle.com, kirill.shutemov@linux.intel.com
Subject: Re: [PATCH v7 05/11] mm: split a folio in minimum folio order chunks
Message-ID: <20240607204552.7bmjf36bsupeznkq@quentin>
References: <20240607145902.1137853-1-kernel@pankajraghav.com>
 <20240607145902.1137853-6-kernel@pankajraghav.com>
 <75CCE180-EC90-4BDC-B5D8-0ED1B710BE49@nvidia.com>
 <ZmM9BBzU4ySqvxjV@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmM9BBzU4ySqvxjV@casper.infradead.org>

On Fri, Jun 07, 2024 at 06:01:56PM +0100, Matthew Wilcox wrote:
> On Fri, Jun 07, 2024 at 12:58:33PM -0400, Zi Yan wrote:
> > > +int split_folio_to_list(struct folio *folio, struct list_head *list)
> > > +{
> > > +	unsigned int min_order = 0;
> > > +
> > > +	if (!folio_test_anon(folio)) {
> > > +		if (!folio->mapping) {
> > > +			count_vm_event(THP_SPLIT_PAGE_FAILED);
> > 
> > You should only increase this counter when the input folio is a THP, namely
> > folio_test_pmd_mappable(folio) is true. For other large folios, we will
> > need a separate counter. Something like MTHP_STAT_FILE_SPLIT_FAILED.
> > See enum mthp_stat_item in include/linux/huge_mm.h.
> 
> Also, why should this count as a split failure?  If we see a NULL
> mapping, the folio has been truncated and so no longer needs to be
> split.  I understand we currently count it as a failure, but I
> don't think we should.

I also thought about this. Because if the folio was under writeback, we
don't account it as a failure but we do it if it was truncated?

I can remove the accounting that we added as a part of this series in
the next version but address the upstream changes [1] in a separate
standalone patch?
I prefer to address these kind of open discussion upstream changes
separately so that we don't delay this series.

Let me know what you think. CCing Kirill as he made those changes.

[1]
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 399a4f5125c7..21f2dd5eb4c5 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3152,10 +3152,8 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
                mapping = folio->mapping;
 
                /* Truncated ? */
-               if (!mapping) {
+               if (!mapping)
                        ret = -EBUSY;
-                       goto out;
-               }
 

