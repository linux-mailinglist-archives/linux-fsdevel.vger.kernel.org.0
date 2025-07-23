Return-Path: <linux-fsdevel+bounces-55795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B1DB0EE5F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 11:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7052189EA27
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 09:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B062874EA;
	Wed, 23 Jul 2025 09:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="PEAbKjiW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCAF28688D;
	Wed, 23 Jul 2025 09:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753262698; cv=none; b=GnjsbCHDm3HUNZcLNyQ1tQWhOiWenbZ97gpEk4ZiMoOcXDzSJxB1x9bXKSIUEfqQgwkV+W+ikz8ObkoZe1W8AB9mDNhJ8wTmlfj235iFaaIkKrlBHdpc27Sl9gzpSEeXM0EzZQZEisEGkCtf5CFyXNGireawGmaUup8tsggaX0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753262698; c=relaxed/simple;
	bh=miti0fBWg9l4CTRUeAOI1spPURaA2m4Iuf5wjnsIqho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e3/H+x18XS9tX7Hoq7DjNPFKu+f3CkwLKcfzTEGxf5Fhyiukbuw7sw7KsfPgymEtu+9u8c5NLJ6g5u6UhlVxOoUhJADACT+Nq++yqRsOxWH9rrKenb7ccSoVV12tM6tkyVq1Y0lS53xuK95k7/4wbqi+29GFDsf7UHEO7q4+V0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=PEAbKjiW; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4bn7yC4Zvzz9tkl;
	Wed, 23 Jul 2025 11:24:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1753262691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iJbmUAH3vRKxe2rKHTAfLf2Cof6kOw4q34nGIRQ3JMU=;
	b=PEAbKjiWzHtfkjreRjIVdaxfqTNLVSCaWcofOgAwQ9HpHjX8H/Tj9E21Q948J/hUE9/egN
	wLPM3ig7M27l+9V4qf5jOOyxE4spDW6RIWPHTlmpMaMZLiYyC1K3kcBzumGnQ+Vzpg8W3j
	bkW4ymZn2X9cJhhfZhI9NZ6l0kVBn37qBEfWZYRc+G0xLl/aMnz0GZIoGSJlsLLVMw+jbF
	WyglR6/veImYAxH86w/9901c5yN4TvGRgYV3yeaKQNKIN+pm7PKTEFJeldveA1wEFVRxzf
	ucF4/Dyu4hGTzwNOYdHjnewbs547GIpF9QhI6hj13zkRCZX4N2MoOzR/qB8NNg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of kernel@pankajraghav.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=kernel@pankajraghav.com
Date: Wed, 23 Jul 2025 11:24:42 +0200
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: David Hildenbrand <david@redhat.com>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>, Dev Jain <dev.jain@arm.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	willy@infradead.org, x86@kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org, 
	gost.dev@samsung.com, hch@lst.de, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [RFC 2/4] mm: add static huge zero folio
Message-ID: <fd7yh3ndu7rvo46sc5hg34ihgy4suer5lwl4llixbn2uhko3b3@vc46kzdyjdi4>
References: <20250722094215.448132-1-kernel@pankajraghav.com>
 <20250722094215.448132-3-kernel@pankajraghav.com>
 <3d935889-fcda-4345-bd57-6c7a84458493@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d935889-fcda-4345-bd57-6c7a84458493@redhat.com>
X-Rspamd-Queue-Id: 4bn7yC4Zvzz9tkl

On Wed, Jul 23, 2025 at 11:06:05AM +0200, David Hildenbrand wrote:
> On 22.07.25 11:42, Pankaj Raghav (Samsung) wrote:
> > From: Pankaj Raghav <p.raghav@samsung.com>
> > 
> > There are many places in the kernel where we need to zeroout larger
> > chunks but the maximum segment we can zeroout at a time by ZERO_PAGE
> > is limited by PAGE_SIZE.
> > 
> > This is especially annoying in block devices and filesystems where we
> > attach multiple ZERO_PAGEs to the bio in different bvecs. With multipage
> > bvec support in block layer, it is much more efficient to send out
> > larger zero pages as a part of single bvec.
> > 
> > This concern was raised during the review of adding LBS support to
> > XFS[1][2].
> > 
> > Usually huge_zero_folio is allocated on demand, and it will be
> > deallocated by the shrinker if there are no users of it left. At moment,
> > huge_zero_folio infrastructure refcount is tied to the process lifetime
> > that created it. This might not work for bio layer as the completions
> > can be async and the process that created the huge_zero_folio might no
> > longer be alive. And, one of the main point that came during discussion
> > is to have something bigger than zero page as a drop-in replacement.
> > 
> > Add a config option STATIC_HUGE_ZERO_FOLIO that will always allocate
> > the huge_zero_folio, and it will never drop the reference. This makes
> > using the huge_zero_folio without having to pass any mm struct and does
> > not tie the lifetime of the zero folio to anything, making it a drop-in
> > replacement for ZERO_PAGE.
> > 
> > If STATIC_PMD_ZERO_PAGE config option is enabled, then
> > mm_get_huge_zero_folio() will simply return this page instead of
> > dynamically allocating a new PMD page.
> > 
> > This option can waste memory in small systems or systems with 64k base
> > page size. So make it an opt-in and also add an option from individual
> > architecture so that we don't enable this feature for larger base page
> > size systems.
> > 
> > [1] https://lore.kernel.org/linux-xfs/20231027051847.GA7885@lst.de/
> > [2] https://lore.kernel.org/linux-xfs/ZitIK5OnR7ZNY0IG@infradead.org/
> > 
> > Co-Developed-by: David Hildenbrand <david@redhat.com>
> 
> "Co-developed-by:"
> 
> And must be followed by
> 
> Signed-of-by: David Hildenbrand <david@redhat.com>

Sounds good. Actually, I didn't want to add your sign-off without
your consent. But I will add it to the patch :)

> 
> As mentioned to the cover letter: spaces vs. tabs.
> 
> > Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> > ---
> >   arch/x86/Kconfig        |  1 +
> >   include/linux/huge_mm.h | 16 ++++++++++++++++
> >   mm/Kconfig              | 12 ++++++++++++
> >   mm/huge_memory.c        | 28 ++++++++++++++++++++++++++++
> >   4 files changed, 57 insertions(+)
> > 
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 0ce86e14ab5e..8e2aa1887309 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -153,6 +153,7 @@ config X86
> >   	select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP	if X86_64
> >   	select ARCH_WANT_HUGETLB_VMEMMAP_PREINIT if X86_64
> >   	select ARCH_WANTS_THP_SWAP		if X86_64
> > +	select ARCH_WANTS_STATIC_HUGE_ZERO_FOLIO if X86_64
> >   	select ARCH_HAS_PARANOID_L1D_FLUSH
> >   	select ARCH_WANT_IRQS_OFF_ACTIVATE_MM
> >   	select BUILDTIME_TABLE_SORT
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index 7748489fde1b..0ddd9c78f9f4 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -476,6 +476,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf);
> >   extern struct folio *huge_zero_folio;
> >   extern unsigned long huge_zero_pfn;
> > +extern atomic_t huge_zero_folio_is_static;
> >   static inline bool is_huge_zero_folio(const struct folio *folio)
> >   {
> > @@ -494,6 +495,16 @@ static inline bool is_huge_zero_pmd(pmd_t pmd)
> >   struct folio *mm_get_huge_zero_folio(struct mm_struct *mm);
> >   void mm_put_huge_zero_folio(struct mm_struct *mm);
> > +struct folio *__get_static_huge_zero_folio(void);
> > +
> > +static inline struct folio *get_static_huge_zero_folio(void)
> > +{
> > +       if (!IS_ENABLED(CONFIG_STATIC_HUGE_ZERO_FOLIO))
> > +               return NULL;
> > +       if (likely(atomic_read(&huge_zero_folio_is_static)))
> > +               return huge_zero_folio;
> > +       return __get_static_huge_zero_folio();> +}
> >   static inline bool thp_migration_supported(void)
> >   {
> > @@ -685,6 +696,11 @@ static inline int change_huge_pud(struct mmu_gather *tlb,
> >   {
> >   	return 0;
> >   }
> > +
> > +static inline struct folio *get_static_huge_zero_folio(void)
> > +{
> > +       return NULL;
> > +}
> >   #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> >   static inline int split_folio_to_list_to_order(struct folio *folio,
> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index 0287e8d94aea..14721171846f 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -835,6 +835,18 @@ config ARCH_WANT_GENERAL_HUGETLB
> >   config ARCH_WANTS_THP_SWAP
> >   	def_bool n
> > +config ARCH_WANTS_STATIC_HUGE_ZERO_FOLIO
> > +	def_bool n
> > +
> > +config STATIC_HUGE_ZERO_FOLIO
> > +	bool "Allocate a PMD sized folio for zeroing"
> > +	depends on ARCH_WANTS_STATIC_HUGE_ZERO_FOLIO
> > +	help
> > +	  Typically huge_zero_folio, which is a PMD page of zeroes, is allocated
> > +	  on demand and deallocated when not in use. This option will
> > +	  allocate huge_zero_folio but it will never free it.
> > +	  Not suitable for memory constrained systems.
> 
> Maybe something like
> 
> "
> Without this config enabled, the huge zero folio is allocated on demand and
> freed under memory pressure once no longer in use. To detect remaining users
> reliably, references to the huge zero folio must be tracked precisely, so it
> is commonly only available for mapping it into user page tables.
> 
> With this config enabled, the huge zero folio can also be used for other
> purposes that do not implement precise reference counting: it is still
> allocated on demand, but never freed, allowing for more wide-spread use,
> for example, when performing I/O similar to the traditional shared
> zeropage."
> 
> Not suitable for memory constrained systems.
> "

Sounds much better! I will add it.

> 
> Should we make it clear that this is currently limited to THP configs?
> 
> depends on TRANSPARENT_HUGEPAGE

You are right. As we use the existing infrastructure, we do become
dependent on THP.
> 
> > +
> >   config MM_ID
> >   	def_bool n
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 5d8365d1d3e9..6c890a1482f3 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -75,6 +75,8 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
> >   static bool split_underused_thp = true;
> >   static atomic_t huge_zero_refcount;
> > +static atomic_t huge_zero_static_fail_count __read_mostly;
> > +atomic_t huge_zero_folio_is_static __read_mostly;
> >   struct folio *huge_zero_folio __read_mostly;
> >   unsigned long huge_zero_pfn __read_mostly = ~0UL;
> >   unsigned long huge_anon_orders_always __read_mostly;
> > @@ -266,6 +268,32 @@ void mm_put_huge_zero_folio(struct mm_struct *mm)
> >   		put_huge_zero_page();
> >   }
> > +#ifdef CONFIG_STATIC_HUGE_ZERO_FOLIO
> > +struct folio *__get_static_huge_zero_folio(void)
> 
> Do we want to play safe and have a
> 
> if (unlikely(!slab_is_available()))
> 	return NULL;
> 
Yes, sounds good.

> > +{
> > +       /*
> > +        * If we failed to allocate a huge zero folio multiple times,
> > +        * just refrain from trying.
> > +        */
> 
> Hmmm, I wonder if we want to retry "some time later" again. Meaning, we'd
> base it on the jiffies, maybe?
> 
> See print_bad_pte() for an example.

That is a good idea. I was thinking somethign like that while I was
making the changes. This seems more logical.

> 
> > +       if (atomic_read(&huge_zero_static_fail_count) > 2)
> > +               return NULL;
> > +
> 
> We could make some smart decision regarding totalram_pages() and just
> disable it. A bit tricky, we can do that as a follow-up.
> 

oooh. Yeah, I will add it in my todos to make this as a follow up :)


Thanks for all your comments David! Can I send it next series as a normal patch
series instead of an RFC? It looks like this series is shaping up nicely.

--
Pankaj

