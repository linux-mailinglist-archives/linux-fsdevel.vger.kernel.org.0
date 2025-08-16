Return-Path: <linux-fsdevel+bounces-58068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C2BB28977
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Aug 2025 02:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5D405E2158
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Aug 2025 00:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CA842AA5;
	Sat, 16 Aug 2025 00:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="THg/Zb8g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E964233EC
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Aug 2025 00:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755305702; cv=none; b=U82Sw3ceiin3ZzxgQZf+tMlCC23X1fU+DlHZMKuuamnplzWvzB7jpxu7A0OtZtipgM4EEF+XOCvdDa1Yw9wX6iBbZqv+242lUilswDRmOdRc/6Bos4eUtjFYQhHl/XS7isPEENIQxDWiLEIvFH0vtpdVpaNJ0Vt+Yih9c/fJcyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755305702; c=relaxed/simple;
	bh=kG2L5bJsoxC0Ffza7DJsiVMljsQB++iXOo0zqkUVC/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nivfCa5It7xxO5S7T+Gllblg6Do9+tZ2PDUB50SxiLwLksveGof0Pj+6FzRkC6UCs4ICd9WiHOvKbhw406lE+CUUKeakomP19pLVCUAzKHZB7yDoOy26G1/zSZe78pRnhExYneH4mLMQ0MToqRmpmKm1imh4vpRa4LB6Ay7IB7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=THg/Zb8g; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 15 Aug 2025 17:54:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755305698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vpht9Z/NW8bqai5iUGyZE+rsgB2/DI1OX+Eo1OgSMVQ=;
	b=THg/Zb8g/2b4tI1LVAVWezbgLz8U4BuiryQ8VrBsAGugrz9b3Ys0zyKjJ/qEDTByL3cvqf
	384II3c0911gcInJ470+mwjpq1b24t8dFFVBTsD9cLMiXW/4h51L65txCc/k9dAYFk9WC2
	ryWlK29pESM799dFW181Y6BjqFfa9+4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, kernel-team@fb.com, wqu@suse.com, willy@infradead.org
Subject: Re: [PATCH v2 2/3] mm: add vmstat for cgroup uncharged pages
Message-ID: <ivlw4c26cxua6bqzg5zyqsc4xffj3ljkjils4j4c3elhmekwoj@ujlq2q2zvomn>
References: <cover.1755300815.git.boris@bur.io>
 <a0b3856a4f86bcd684c715469c8a1cb2000bcbe2.1755300815.git.boris@bur.io>
 <ztt2lhdpzfb3ddvgtqqwzuvdmlz4i5l6ijnwizyky4tv62dncz@taho2tjmqjkc>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ztt2lhdpzfb3ddvgtqqwzuvdmlz4i5l6ijnwizyky4tv62dncz@taho2tjmqjkc>
X-Migadu-Flow: FLOW_OUT

On Fri, Aug 15, 2025 at 05:48:33PM -0700, Shakeel Butt wrote:
> On Fri, Aug 15, 2025 at 04:40:32PM -0700, Boris Burkov wrote:
> > Uncharged pages are tricky to track by their essential "uncharged"
> > nature. To maintain good accounting, introduce a vmstat counter tracking
> > all uncharged pages. Since this is only meaningful when cgroups are
> > configured, only expose the counter when CONFIG_MEMCG is set.
> > 
> > Confirmed that these work as expected at a high level by mounting a
> > btrfs using AS_UNCHARGED for metadata pages, and seeing the counter rise
> > with fs usage then go back to a minimal level after drop_caches and
> > finally down to 0 after unmounting the fs.
> > 
> > Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> >  include/linux/mmzone.h |  3 +++
> >  mm/filemap.c           | 17 +++++++++++++++++
> >  mm/vmstat.c            |  3 +++
> >  3 files changed, 23 insertions(+)
> > 
> > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > index 0c5da9141983..f6d885c97e99 100644
> > --- a/include/linux/mmzone.h
> > +++ b/include/linux/mmzone.h
> > @@ -245,6 +245,9 @@ enum node_stat_item {
> >  	NR_HUGETLB,
> >  #endif
> >  	NR_BALLOON_PAGES,
> > +#ifdef CONFIG_MEMCG
> > +	NR_UNCHARGED_FILE_PAGES,
> > +#endif
> >  	NR_VM_NODE_STAT_ITEMS
> >  };
> >  
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index 6046e7f27709..cd5af44a838c 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -146,6 +146,19 @@ static void page_cache_delete(struct address_space *mapping,
> >  	mapping->nrpages -= nr;
> >  }
> >  
> > +#ifdef CONFIG_MEMCG
> > +static void filemap_mod_uncharged_vmstat(struct folio *folio, int sign)
> > +{
> > +	long nr = folio_nr_pages(folio) * sign;
> > +
> > +	lruvec_stat_mod_folio(folio, NR_UNCHARGED_FILE_PAGES, nr);
> 
> Since we 

*never*

> expect to add this metric to memory.stat, I think we should use
> mod_node_page_state() instead here.
> 
> With that you can add:
> 
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> 

