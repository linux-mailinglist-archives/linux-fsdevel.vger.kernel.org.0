Return-Path: <linux-fsdevel+bounces-49676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54273AC0CDF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 15:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C6F44A4F05
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 13:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB8F28BABD;
	Thu, 22 May 2025 13:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="HrGq0kn0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035BB221D9E;
	Thu, 22 May 2025 13:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747920875; cv=none; b=j1mr/GtcvzG4UOPTAaiyBY2grBpLjdMoqCCamHluM83bfv95hOdsX6Qdbt8J3HVqUlWOtPBtPLeRzI1YAmZMfU0naI5oYvYHzWoLLTyKpipBwNcP8LEcPrM6n2jUJLvpQcdSzCpBZJdHfyexOVwmR4At+UegOcCm9fJzThRNauc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747920875; c=relaxed/simple;
	bh=8GZdBTOYVGwbZLvXBpdpHobZi2bZ9UpNg9GvNcbl24g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OUkAkZU8NEyBJMx1qylukteA18142FlKyAAnXoQyz+q0/boWM/aQLFHX56E9zIxJp81lGPl1UKHMdfX4EotbvzIwxFaPLpE44D8lXMFS4vgoAqSJ4zc8dfj7pjWpgq58pbTSfG1nEZnf7h0Li11eau4gWsWHfC7x3KVyomONLyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=HrGq0kn0; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4b38Qs0sDSz9sr6;
	Thu, 22 May 2025 15:34:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1747920869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HglpUfe4kmsfzDLqBmD4mwNcQaYbHQqEm+gYK0kZUv4=;
	b=HrGq0kn0IswTMrElT71G4ZbK3lUndY7xUDOTKbv2J80oqPrjLnUqLn3Fi7gSIsFWizXlKH
	lET7rBNAo32lcL2lchoPLdDYG+yTQcX9pqm55XyS7dPpHzVrlyZqtrDpaUuKLtT1qjJ/xH
	BQbXyJbjAWLxsFsUCsyzxVRP/SqXyQ/KFyesfs/5enWVN0YbWPTYoZ0Nu4V+IiNx/vGBwJ
	yKGuzIficxnnHqOVo1Sva0+r3cY2I9dM5TP/N9SXqnh6OX7LG57zDJsnErFsM5TldjywJC
	q9PHiKQsrqg4H2Qgzwx+X0ivgfrDH7WwWNm15hdk33MI9vgZ6a0Yb0Jq7m0sIQ==
Date: Thu, 22 May 2025 15:34:17 +0200
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: David Hildenbrand <david@redhat.com>
Cc: Mike Rapoport <rppt@kernel.org>, Pankaj Raghav <p.raghav@samsung.com>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Ryan Roberts <ryan.roberts@arm.com>, Michal Hocko <mhocko@suse.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>, Dev Jain <dev.jain@arm.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Zi Yan <ziy@nvidia.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	"Darrick J . Wong" <djwong@kernel.org>, gost.dev@samsung.com, hch@lst.de, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, willy@infradead.org, x86@kernel.org, mcgrof@kernel.org
Subject: Re: [RFC v2 0/2] add THP_HUGE_ZERO_PAGE_ALWAYS config option
Message-ID: <b3ceg4gdg5exbugyarudabfuaowvqfqgrzo62hoexxhvvfwjs7@4dbrig7wm7ds>
References: <20250522090243.758943-1-p.raghav@samsung.com>
 <aC8LGDwJXvlDl866@kernel.org>
 <6lhepdol4nlnht7elb7jx7ot5hhckiegyyl6zeap2hmltdwb5t@ywsaklwnakuh>
 <6894a8b1-a1a7-4a35-8193-68df3340f0ad@redhat.com>
 <625s5hffr3iz35uv4hts4sxpprwwuxxpbsmbvasy24cthlsj6x@tg2zqm6v2wqm>
 <eab4b461-9717-47df-8d56-c303c3f6012d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eab4b461-9717-47df-8d56-c303c3f6012d@redhat.com>

On Thu, May 22, 2025 at 02:50:20PM +0200, David Hildenbrand wrote:
> On 22.05.25 14:34, Pankaj Raghav (Samsung) wrote:
> > Hi David,
> > 
> > > >    config ARCH_WANTS_THP_SWAP
> > > >           def_bool n
> > > > -config ARCH_WANTS_THP_ZERO_PAGE_ALWAYS
> > > > +config ARCH_WANTS_HUGE_ZERO_PAGE_ALWAYS
> > > >           def_bool n
> > > > +config HUGE_ZERO_PAGE_ALWAYS
> > > 
> > > Likely something like
> > > 
> > > PMD_ZERO_PAGE
> > > 
> > > Will be a lot clearer.
> > 
> > Sounds much better :)
> 
> And maybe something like
> 
> "STATIC_PMD_ZERO_PAGE"
> 
> would be even clearer.
> 
> The other one would be the dynamic one.

Got it.
So if I understand correctly, we are going to have two huge zero pages,
- one that is always allocated statically.
- the existing dynamic will still be there for the existing users.

> 
> > 
> > > 
> > > > +       def_bool y> +       depends on HUGETLB_PAGE &&
> > > ARCH_WANTS_HUGE_ZERO_PAGE_ALWAYS
> > > 
> > > I suspect it should then also be independent of HUGETLB_PAGE?
> > 
> > You are right. So we don't depend on any of these features.
> > 
> > > 
> > > > +       help
> > > > +         Typically huge_zero_folio, which is a huge page of zeroes, is allocated
> > > > +         on demand and deallocated when not in use. This option will always
> > > > +         allocate huge_zero_folio for zeroing and it is never deallocated.
> > > > +         Not suitable for memory constrained systems.
> > > 
> > > I assume that code then has to live in mm/memory.c ?
> > 
> > Hmm, then huge_zero_folio should have always been in mm/memory.c to
> > begin with?
> > 
> 
> It's complicated. Only do_huge_pmd_anonymous_page() (and fsdax) really uses
> it, and it may only get mapped into a process under certain conditions
> (related to THP / PMD handling).
> 
Got it.
> > 
> > So IIUC your comment, we should move the huge_zero_page_init() in the
> > first patch to mm/memory.c and the existing shrinker code can be a part
> > where they already are?
> 
> Good question. At least the "static" part can easily be moved over. Maybe
> the dynamic part as well.
> 
> Worth trying it out and seeing how it looks :)

Challenge accepted ;) Thanks for the comments David.

--
Pankaj

