Return-Path: <linux-fsdevel+bounces-19587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6868C78C9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 16:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B927B22F46
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 14:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D67214B97F;
	Thu, 16 May 2024 14:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="B72fBIQ8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24BA14B968;
	Thu, 16 May 2024 14:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715871406; cv=none; b=ZvIFfhBMaLSJFevApxooDN8pp+HlE1h4/5Et1qygueB9I7KBRW4lpfM72TLNLtWICPw7uZWIluzIZOfHBg/qLTsBI8icmmEjkojA9ABVlHCGnJE4RXFgY2nTM8d4XMoVZcfHqd5ZONhH+XwjZzPG/zKHiJfi9om6You3me+dY6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715871406; c=relaxed/simple;
	bh=FQIsGZHRViih+j0fUK4oEQQuGHGNIDIod/z1v85Fj9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUtUKcUlABjX3Yyfpi6j0bxQAQvXLbNZs3GLrSKNvECfBtPDtgDqxUwoMd9yJ1whQ8l27nnKBDP+jNPE7epuNJoRBhLR6mEFc6luDTFYiexV423qzhgLmERTFjdAiowiNXjt4Of9W8sl5AQf0f6GhMgV3fsRI6zTK3USPPDOAmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=B72fBIQ8; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4VgCpq2pVlz9sHh;
	Thu, 16 May 2024 16:56:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1715871395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=74eMllLeh342ZIjZuqoRqLepm4NGxHaCMq2b5Z56hmY=;
	b=B72fBIQ8PVUvw1AVhC0pKD9aEicC5puPM1tGp23gLm7PmFibCx+DESumNdKhfYUKTvF4J5
	EK7FGC2VF8bn8cdZuDeBiJjPrg97a/IR+mGXUukEMIDp5X4pyYB+vR3MRqEFfkhZ5kUoHv
	V5kcxfmRdmhdnb+M/mLqrQM/wtX9yreZM6BqCfYKjxrS5t2P/dXfv1MnTUPVckPuokmIKb
	I1ppxLTGTh3spgDX/zmpzfVBEnDtxjFHGCOYAdNtrJYCJF2foq9sRRFCMU0eeUsLeSBN9Q
	4rAlIg85Xp/YrbGgHyxdCseoXiWOpL3MzPGnVB1/KG1Bcup/Cw1FjCcDjO99QA==
Date: Thu, 16 May 2024 14:56:16 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, akpm@linux-foundation.org,
	djwong@kernel.org, brauner@kernel.org, david@fromorbit.com,
	chandan.babu@oracle.com, hare@suse.de, ritesh.list@gmail.com,
	john.g.garry@oracle.com, ziy@nvidia.com,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, p.raghav@samsung.com
Subject: Re: [PATCH v5 05/11] mm: split a folio in minimum folio order chunks
Message-ID: <20240516145616.z3gz5d6awy7n3drx@quentin>
References: <20240503095353.3798063-1-mcgrof@kernel.org>
 <20240503095353.3798063-6-mcgrof@kernel.org>
 <ZkTVlOQXxfa2VHXo@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZkTVlOQXxfa2VHXo@casper.infradead.org>

On Wed, May 15, 2024 at 04:32:36PM +0100, Matthew Wilcox wrote:
> On Fri, May 03, 2024 at 02:53:47AM -0700, Luis Chamberlain wrote:
> > +int split_folio_to_list(struct folio *folio, struct list_head *list);
> 
> ...
> 
> > +static inline int split_folio_to_list(struct page *page, struct list_head *list)
> > +{
> 
> Type mismatch.  Surprised the build bots didn't whine yet.

Good catch. As we always enabled CONFIG_THP, we didn't detect this
issue.

> 
> >  
> > +		min_order = mapping_min_folio_order(folio->mapping);
> > +		if (new_order < min_order) {
> > +			VM_WARN_ONCE(1, "Cannot split mapped folio below min-order: %u",
> > +				     min_order);
> > +			ret = -EINVAL;
> > +			goto out;
> > +		}
> 
> Wouldn't we prefer this as:
> 
> 		if (VM_WARN_ONCE(new_order < min_order,
> 				"Cannot split mapped folio below min-order: %u",
> 				min_order) {
> 			ret = -EINVAL;
> 			goto out;
> 		}
> 
I don't think so:
#define VM_WARN_ONCE(cond, format...) (void)WARN_ONCE(cond, format)

So we get a build error as follows:
In file included from ./include/linux/mm.h:6,
                 from mm/huge_memory.c:8:
mm/huge_memory.c: In function ‘split_huge_page_to_list_to_order’:
./include/linux/mmdebug.h:93:39: error: void value not ignored as it ought to be
   93 | #define VM_WARN_ONCE(cond, format...) (void)WARN_ONCE(cond, format)
      |                                       ^
mm/huge_memory.c:3158:21: note: in expansion of macro ‘VM_WARN_ONCE’
 3158 |                 if (VM_WARN_ONCE(new_order < min_order,


