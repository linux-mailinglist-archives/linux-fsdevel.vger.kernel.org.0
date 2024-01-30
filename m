Return-Path: <linux-fsdevel+bounces-9520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05209842325
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 12:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D1841F23816
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 11:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3F467736;
	Tue, 30 Jan 2024 11:33:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C921467729;
	Tue, 30 Jan 2024 11:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706614404; cv=none; b=vBzUC+BEpEn4n84TB1XHk6ndbtuKx/8SUpu0Y01pRWorOAz2MHe/TaYGCHCcw8zlqI7uCvheXTfC2ba0zBXQTl7/rcQaSo6afq1KPpE/PfJ4fluH/nWc4SBj+Coz+4JZJ2RRJZFx0CS/RVM64Y8qgnlQnEvR371rAH9vTKcw4E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706614404; c=relaxed/simple;
	bh=iYeZRBQMYetEM+TK5yHlgX6GcwqR9jGOdY9NNlijHeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JnNG0P5FvhwG3Cd6UOqZaR8H4RrXt5Ai5rtYR5pcSG1+OUDNtl8fG1Sudeydh9SonyCekVNIRJS0kshi/87l9HhXQWOxWAioaM63XfDFHOs6gGscT2BLoqO2eg62Gv8jgQjLdFf6wwaVijkgzkpI/vUeWWztgrI+psLwdgIjdTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 121DBDA7;
	Tue, 30 Jan 2024 03:34:03 -0800 (PST)
Received: from raptor (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA3D43F5A1;
	Tue, 30 Jan 2024 03:33:13 -0800 (PST)
Date: Tue, 30 Jan 2024 11:33:07 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
	maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, mhiramat@kernel.org,
	rppt@kernel.org, hughd@google.com, pcc@google.com,
	steven.price@arm.com, vincenzo.frascino@arm.com, david@redhat.com,
	eugenis@google.com, kcc@google.com, hyesoo.yu@samsung.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v3 09/35] mm: cma: Introduce cma_remove_mem()
Message-ID: <ZbjecxWRUrBfOEdn@raptor>
References: <20240125164256.4147-1-alexandru.elisei@arm.com>
 <20240125164256.4147-10-alexandru.elisei@arm.com>
 <830691cf-cb96-443e-b6eb-2adfe2edd587@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <830691cf-cb96-443e-b6eb-2adfe2edd587@arm.com>

Hi,

I really appreciate the feedback you have given me so far. I believe the
commit message isn't clear enough and there has been a confusion.

A CMA user adds a CMA area to the cma_areas array with
cma_declare_contiguous_nid() or cma_init_reserved_mem().
init_cma_reserved_pageblock() then iterates over the array and activates
all cma areas.

The function cma_remove_mem() is intended to be used to remove a cma area
from the cma_areas array **before** the area has been activated.

Usecase: a driver (in this case, the arm64 dynamic tag storage code)
manages several cma areas. The driver successfully adds the first area to
the cma_areas array. When the driver tries to adds the second area, the
function fails. Without cma_remove_mem(), the driver has no way to prevent
the first area from being freed to the page allocator. cma_remove_mem() is
about providing a means to do cleanup in case of error.

Does that make more sense now?

Ok Tue, Jan 30, 2024 at 11:20:56AM +0530, Anshuman Khandual wrote:
> 
> 
> On 1/25/24 22:12, Alexandru Elisei wrote:
> > Memory is added to CMA with cma_declare_contiguous_nid() and
> > cma_init_reserved_mem(). This memory is then put on the MIGRATE_CMA list in
> > cma_init_reserved_areas(), where the page allocator can make use of it.
> 
> cma_declare_contiguous_nid() reserves memory in memblock and marks the

You forgot about about cma_init_reserved_mem() which does the same thing,
but yes, you are right.

> for subsequent CMA usage, where as cma_init_reserved_areas() activates
> these memory areas through init_cma_reserved_pageblock(). Standard page
> allocator only receives these memory via free_reserved_page() - only if

I don't think that's correct. init_cma_reserved_pageblock() clears the
PG_reserved page flag, sets the migratetype to MIGRATE_CMA and then frees
the page. After that, the page is available to the standard page allocator
to use for allocation. Otherwise, what would be the point of the
MIGRATE_CMA migratetype?

> the page block activation fails.

For the sake of having a complete picture, I'll add that that only happens
if cma->reserve_pages_on_error is false. If the CMA user sets the field to
'true' (with cma_reserve_pages_on_error()), then the pages in the CMA
region are kept PG_reserved if activation fails.

> 
> > 
> > If a device manages multiple CMA areas, and there's an error when one of
> > the areas is added to CMA, there is no mechanism for the device to prevent
> 
> What kind of error ? init_cma_reserved_pageblock() fails ? But that will
> not happen until cma_init_reserved_areas().

I think I haven't been clear enough. When I say that "an area is added
to CMA", I mean that the memory region is added to cma_areas array, via
cma_declare_contiguous_nid() or cma_init_reserved_mem(). There are several
ways in which either function can fail.

> 
> > the rest of the areas, which were added before the error occured, from
> > being later added to the MIGRATE_CMA list.
> 
> Why is this mechanism required ? cma_init_reserved_areas() scans over all
> CMA areas and try and activate each of them sequentially. Why is not this
> sufficient ?

This patch is about removing a struct cma from the cma_areas array after it
has been added to the array, with cma_declare_contiguous_nid() or
cma_init_reserved_mem(), to prevent the area from being activated in
cma_init_reserved_areas(). Sorry for the confusion.

I'll add a check in cma_remove_mem() to fail if the cma area has been
activated, and a comment to the function to explain its usage.

> 
> > 
> > Add cma_remove_mem() which allows a previously reserved CMA area to be
> > removed and thus it cannot be used by the page allocator.
> 
> Successfully activated CMA areas do not get used by the buddy allocator.

I don't believe that is correct, see above.

> 
> > 
> > Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> > ---
> > 
> > Changes since rfc v2:
> > 
> > * New patch.
> > 
> >  include/linux/cma.h |  1 +
> >  mm/cma.c            | 30 +++++++++++++++++++++++++++++-
> >  2 files changed, 30 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/cma.h b/include/linux/cma.h
> > index e32559da6942..787cbec1702e 100644
> > --- a/include/linux/cma.h
> > +++ b/include/linux/cma.h
> > @@ -48,6 +48,7 @@ extern int cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
> >  					unsigned int order_per_bit,
> >  					const char *name,
> >  					struct cma **res_cma);
> > +extern void cma_remove_mem(struct cma **res_cma);
> >  extern struct page *cma_alloc(struct cma *cma, unsigned long count, unsigned int align,
> >  			      bool no_warn);
> >  extern int cma_alloc_range(struct cma *cma, unsigned long start, unsigned long count,
> > diff --git a/mm/cma.c b/mm/cma.c
> > index 4a0f68b9443b..2881bab12b01 100644
> > --- a/mm/cma.c
> > +++ b/mm/cma.c
> > @@ -147,8 +147,12 @@ static int __init cma_init_reserved_areas(void)
> >  {
> >  	int i;
> >  
> > -	for (i = 0; i < cma_area_count; i++)
> > +	for (i = 0; i < cma_area_count; i++) {
> > +		/* Region was removed. */
> > +		if (!cma_areas[i].count)
> > +			continue;
> 
> Skip previously added CMA area (now zeroed out) ?

Yes, that's what I meant with the comment "Region was removed". Do you
think I should reword the comment?

> 
> >  		cma_activate_area(&cma_areas[i]);
> > +	}
> >  
> >  	return 0;
> >  }
> 
> cma_init_reserved_areas() gets called via core_initcall(). Some how
> platform/device needs to call cma_remove_mem() before core_initcall()
> gets called ? This might be time sensitive.

I don't understand your point.

> 
> > @@ -216,6 +220,30 @@ int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
> >  	return 0;
> >  }
> >  
> > +/**
> > + * cma_remove_mem() - remove cma area
> > + * @res_cma: Pointer to the cma region.
> > + *
> > + * This function removes a cma region created with cma_init_reserved_mem(). The
> > + * ->count is set to 0.
> > + */
> > +void __init cma_remove_mem(struct cma **res_cma)
> > +{
> > +	struct cma *cma;
> > +
> > +	if (WARN_ON_ONCE(!res_cma || !(*res_cma)))
> > +		return;
> > +
> > +	cma = *res_cma;
> > +	if (WARN_ON_ONCE(!cma->count))
> > +		return;
> > +
> > +	totalcma_pages -= cma->count;
> > +	cma->count = 0;
> > +
> > +	*res_cma = NULL;
> > +}
> > +
> >  /**
> >   * cma_declare_contiguous_nid() - reserve custom contiguous area
> >   * @base: Base address of the reserved area optional, use 0 for any
> 
> But first please do explain what are the errors device or platform might

cma_declare_contiguous_nid() and cma_init_reserved_mem() can fail in a
number of ways, the code should be self documenting.

> see on a previously marked CMA area so that removing them on way becomes
> necessary preventing their activation via cma_init_reserved_areas().

I've described how the function is supposed to be used at the top of my
reply.

Thanks,
Alex

