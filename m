Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64C0C81D07
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2019 15:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731042AbfHEN24 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Aug 2019 09:28:56 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36712 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730847AbfHEN2z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:28:55 -0400
Received: by mail-ed1-f65.google.com with SMTP id k21so78664633edq.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Aug 2019 06:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3drHMUL5Pk9jHUy3pA1iUoQlGejiIQvjd4pNDp+8XBU=;
        b=dIP7M4jYF7NOgVskzCarnMOatC6l4Eh4eyt+a2RnpIFWM+CmGKPApW29KhUqn7EvCZ
         /VQK4beQoU0lu0cvKEGL3MekMq4A9SeKU+Vnzhs0csmdOVX+sbHjvMrL6FwbPkd4N4x5
         5Y+lbiXf7q2U7TlxXSdWujk2wQ879+w0rcLxd2DIrUCEv2LqsYMyUnxw1EWP0UqA21TD
         pZG82PZ0kiFunLKLNnFj4FF626FwvoDsOEdsl1o8eFOlOevmDfYThHIOodb9cxFbxJrM
         W0Ti3c5XkcnutmDf3QkIjuXaT3t3SHOIw/Z27nGTqOpPjlYl8bP+SeJrHtpVEbEjAALS
         Eknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3drHMUL5Pk9jHUy3pA1iUoQlGejiIQvjd4pNDp+8XBU=;
        b=WZstR6mvKpGm/eG3Kl8IAzGZ8oTsFkcS71qOZI0LfRX2VB3ySOjxj1VQtwMQf0+S3V
         hvpoHFCtt1h0F6uu5dkl/8mvnEn7wsXsJwANE0aceqUrL4Y23FB9Yl2M3+noImGT63zr
         JDcfsdO0BKqDnilckZnZegV4VbtRvcZ/Yk02B2000PRTYasnCsC9y37yRc5ckUPbVAEu
         3Pho40QCRzFpmPgAGz6u7JLZ4835H8eVOCK+oOeyr4PcyQdR7E9Bb3ut6I6eUHj1HIa7
         ZjKq3qGKkWjO5SrsxGu8pb3tQ9bW0jJfbgzR6idOqISrpvoVsjo+lwsLsOZajUR+o5us
         M20A==
X-Gm-Message-State: APjAAAUIf6P7GZ4DA3cKirBrM1RvZguob8eOAHrL8FVvG1zAxNaqKdPJ
        eJpADl51r1upEkqbydMyloM=
X-Google-Smtp-Source: APXvYqyIDSJ+D50ro0fjvb+CMm3L+NsThIV0XpOc/kkmQpoaeC5mv92T0iKKqp9tttnC+I07duFZJQ==
X-Received: by 2002:a17:906:30d9:: with SMTP id b25mr113219736ejb.55.1565011732590;
        Mon, 05 Aug 2019 06:28:52 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id c24sm14299714ejb.33.2019.08.05.06.28.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 06:28:51 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id C01A91003C1; Mon,  5 Aug 2019 16:28:54 +0300 (+03)
Date:   Mon, 5 Aug 2019 16:28:54 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     William Kucharski <william.kucharski@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Bob Kasten <robert.a.kasten@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Chad Mynhier <chad.mynhier@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Johannes Weiner <jweiner@fb.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 2/2] mm,thp: Add experimental config option
 RO_EXEC_FILEMAP_HUGE_FAULT_THP
Message-ID: <20190805132854.5dnqkfaajmstpelm@box.shutemov.name>
References: <20190731082513.16957-1-william.kucharski@oracle.com>
 <20190731082513.16957-3-william.kucharski@oracle.com>
 <20190801123658.enpchkjkqt7cdkue@box>
 <c8d02a3b-e1ad-2b95-ce15-13d3ed4cca87@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8d02a3b-e1ad-2b95-ce15-13d3ed4cca87@oracle.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 03, 2019 at 04:27:51PM -0600, William Kucharski wrote:
> 
> 
> On 8/1/19 6:36 AM, Kirill A. Shutemov wrote:
> 
> > >   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > > -#define HPAGE_PMD_SHIFT PMD_SHIFT
> > > -#define HPAGE_PMD_SIZE	((1UL) << HPAGE_PMD_SHIFT)
> > > -#define HPAGE_PMD_MASK	(~(HPAGE_PMD_SIZE - 1))
> > > -
> > > -#define HPAGE_PUD_SHIFT PUD_SHIFT
> > > -#define HPAGE_PUD_SIZE	((1UL) << HPAGE_PUD_SHIFT)
> > > -#define HPAGE_PUD_MASK	(~(HPAGE_PUD_SIZE - 1))
> > > +#define HPAGE_PMD_SHIFT		PMD_SHIFT
> > > +#define HPAGE_PMD_SIZE		((1UL) << HPAGE_PMD_SHIFT)
> > > +#define HPAGE_PMD_OFFSET	(HPAGE_PMD_SIZE - 1)
> > > +#define HPAGE_PMD_MASK		(~(HPAGE_PMD_OFFSET))
> > > +
> > > +#define HPAGE_PUD_SHIFT		PUD_SHIFT
> > > +#define HPAGE_PUD_SIZE		((1UL) << HPAGE_PUD_SHIFT)
> > > +#define HPAGE_PUD_OFFSET	(HPAGE_PUD_SIZE - 1)
> > > +#define HPAGE_PUD_MASK		(~(HPAGE_PUD_OFFSET))
> > 
> > OFFSET vs MASK semantics can be confusing without reading the definition.
> > We don't have anything similar for base page size, right (PAGE_OFFSET is
> > completely different thing :P)?
> 
> I came up with the OFFSET definitions, the MASK definitions already existed
> in huge_mm.h, e.g.:
> 
> #define HPAGE_PUD_MASK	(~(HPAGE_PUD_SIZE - 1))
> 
> Is there different terminology you'd prefer to see me use here to clarify
> this?

My point is that maybe we should just use ~HPAGE_P?D_MASK in code. The new
HPAGE_P?D_OFFSET doesn't add much for readability in my opinion.

> > > +#ifdef CONFIG_RO_EXEC_FILEMAP_HUGE_FAULT_THP
> > > +extern vm_fault_t filemap_huge_fault(struct vm_fault *vmf,
> > > +			enum page_entry_size pe_size);
> > > +#endif
> > > +
> > 
> > No need for #ifdef here.
> 
> I wanted to avoid referencing an extern that wouldn't exist if the config
> option wasn't set; I can remove it.
> 
> 
> > > +
> > > +#ifndef	CONFIG_RO_EXEC_FILEMAP_HUGE_FAULT_THP
> > >   	if (PageSwapBacked(page)) {
> > >   		__mod_node_page_state(page_pgdat(page), NR_SHMEM, -nr);
> > >   		if (PageTransHuge(page))
> > > @@ -206,6 +208,13 @@ static void unaccount_page_cache_page(struct address_space *mapping,
> > >   	} else {
> > >   		VM_BUG_ON_PAGE(PageTransHuge(page), page);
> > >   	}
> > > +#else
> > > +	if (PageSwapBacked(page))
> > > +		__mod_node_page_state(page_pgdat(page), NR_SHMEM, -nr);
> > > +
> > > +	if (PageTransHuge(page))
> > > +		__dec_node_page_state(page, NR_SHMEM_THPS);
> > > +#endif
> > 
> > Again, no need for #ifdef: the new definition should be fine for
> > everybody.
> 
> OK, I can do that; I didn't want to unnecessarily eliminate the
> VM_BUG_ON_PAGE(PageTransHuge(page)) call for everyone given this
> is CONFIG experimental code.

If you bring the feature, you bring the feature. Just drop these VM_BUGs.

> > PageCompound() and PageTransCompound() are the same thing if THP is
> > enabled at compile time.
> 
> > PageHuge() check here is looking out of place. I don't thing we can ever
> > will see hugetlb pages here.
> 
> What I'm trying to do is sanity check that what the cache contains is a THP
> page. I added the PageHuge() check simply because PageTransCompound() is
> true for both THP and hugetlbfs pages, and there's no routine that returns
> true JUST for THP pages; perhaps there should be?

I'm not sure. It will be costly comparing to PageTransCompound/Huge as we
need to check more than flags.

To exclude hugetlb pages here, use VM_BUG_ON_PAGE(PageHuge(page), page).
It will allow to catch wrong usage of the function.

> 
> > > +		 *	+ the enbry is a page page with an order other than
> > 
> > Typo.
> 
> Thanks, fixed.
> 
> > 
> > > +		 *	  HPAGE_PMD_ORDER
> > 
> > If you see unexpected page order in page cache, something went horribly
> > wrong, right?
> 
> This routine's main function other than validation is to make sure the page
> cache has not been polluted between when we go out to read the large page
> and when the page is added to the cache (more on that coming up.) For
> example, the way I was able to tell readahead() was polluting future
> possible THP mappings is because after a buffered read I would typically see
> 52 (the readahead size) PAGESIZE pages for the next 2M range in the page
> cache.

My point is that you should only see compound pages here if they are
HPAGE_PMD_ORDER, shouldn't you? Any other order of compound page would be
unexpected to say the least.

> > > +		 *	+ the page's index is not what we expect it to be
> > 
> > Same here.
> 
> Same rationale.
> 
> > 
> > > +		 *	+ the page is not up-to-date
> > > +		 *	+ the page is unlocked
> > 
> > Confused here.
> 
> These should never be true, but I wanted to double check for them anyway. I
> can eliminate the checks if we are satisfied these states can "never" happen
> for a cached page.
> > Do you expect caller to lock page before the check? If so, state it in the
> > comment for the function.
> 
> It's my understanding that pages in the page cache should be locked, so I
> wanted to check for that.

No. They are get locked temporary for some operation, but not all the
time.

> This routine is validating entries we find in the page cache to see whether
> they are conflicts or valid cached THP pages.
> 
> > Wow. That's unreadable. Can we rewrite it something like (commenting each
> > check):
> 
> I can definitely break it down into multiple checks; it is a bit dense, thus
> the comment but you're correct, it will read better if broken down more.
> 
> 
> > You also need to check that VMA alignment is suitable for huge pages.
> > See transhuge_vma_suitable().
> 
> I don't really care if the start of the VMA is suitable, just whether I can map
> the current faulting page with a THP. As far as I know, there's nothing wrong
> with mapping all the pages before the VMA hits a properly aligned bound with
> PAGESIZE pages and then aligned chunks in the middle with THP.

You cannot map any paged as huge into wrongly aligned VMA.

THP's ->index must be aligned to HPAGE_PMD_NR, so if the combination VMA's
->vm_start and ->vm_pgoff doesn't allow for this, you must fallback to
mapping the page with PTEs. I don't see it handled properly here.

> > > +	if (unlikely(!(PageCompound(new_page)))) {
> > 
> > How can it happen?
> 
> That check was already removed for a pending v4, thanks. I wasn't sure if
> __page_cache_alloc() could ever erroneously return a non-compound page so
> I wanted to check for it.
> 
> > > +	__SetPageLocked(new_page);
> > 
> > Again?
> 
> This is the page that content was just read to; readpage() will unlock the page
> when it is done with I/O, but the page needs to be locked before it's inserted
> into the page cache.

Then you must to lock the page properly with lock_page().

__SetPageLocked() is fine for just allocated pages that was not exposed
anywhere. After ->readpage() it's not the case and it's not safe to use
__SetPageLocked() for them.

> > > +	/* did it get truncated? */
> > > +	if (unlikely(new_page->mapping != mapping)) {
> > 
> > Hm. IIRC this path only reachable for just allocated page that is not
> > exposed to anybody yet. How can it be truncated?
> 
> Matthew advised I duplicate the similar routine from filemap_fault(), but
> that may be because of the normal way pages get added to the cache, which I
> may need to modify my code to do.
> 
> > > +	ret = alloc_set_pte(vmf, NULL, hugepage);
> > 
> > It has to be
> > 
> > 	ret = alloc_set_pte(vmf, vmf->memcg, hugepage);
> > 
> > right?
> 
> I can make that change; originally alloc_set_pte() didn't use the second
> parameter at all when mapping a read-only page.
> 
> Even now, if the page isn't writable, it would only be dereferenced by a
> VM_BUG_ON_PAGE() call if it's COW.

Please do change this. It has to be future-proof.

> > It looks backwards to me. I believe the page must be in page cache
> > *before* it got mapped.
> > 
> > I expect all sorts of weird bug due to races when the page is mapped but
> > not visible via syscalls.
> 
> You may be correct.
> 
> My original thinking on this was that as a THP is going to be rarer and more
> valuable to the system, I didn't want to add it to the page cache until its
> contents had been fully read and it was mapped. Talking with Matthew it
> seems I may need to change to do things the same way as PAGESIZE pages,
> where the page is added to the cache prior to the readpage() call and we
> rely upon PageUptodate to see if the reads were successful.
> 
> My thinking had been if any part of reading a large page and mapping it had
> failed, the code could just put_page() the newly allocated page and fallback
> to mapping the page with PAGESIZE pages rather than add a THP to the cache.

I think it's must change. We should not allow inconsistent view on page
cache.

> > > +#ifndef CONFIG_RO_EXEC_FILEMAP_HUGE_FAULT_THP
> > 
> > IS_ENABLED()?
> > 
> > >   	if (!IS_DAX(filp->f_mapping->host) || !IS_ENABLED(CONFIG_FS_DAX_PMD))
> > >   		goto out;
> > > +#endif
> 
> This code short-circuits the address generation routine if the memory isn't DAX,
> and if this code is enabled I need it not to goto out but rather fall through to
> __thp_get_unmapped_area().
> 
> > > +	if ((prot & PROT_READ) && (prot & PROT_EXEC) &&
> > > +		(!(prot & PROT_WRITE)) && (flags & MAP_PRIVATE) &&
> > 
> > Why require PROT_EXEC && PROT_READ. You only must ask for !PROT_WRITE.
> > 
> > And how do you protect against mprotect() later? Should you ask for
> > ro-file instead?
> 
> My original goal was to only map program TEXT with THP, which means only
> RO EXEC code, not just any non-writable address space.
> 
> If mprotect() is called, wouldn't the pages be COWed to PAGESIZE pages the
> first time the area was written to? I may be way off on this assumption.

Okay, fair enough. COW will happen for private mappings.

But for private mappings you don't need to enforce even RO. All permission
mask should be fine.

> > All size considerations are already handled by thp_get_unmapped_area(). No
> > need to duplicate it here.
> 
> Thanks, I'll remove them.
> 
> > You might want to add thp_ro_get_unmapped_area() that would check file for
> > RO, before going for THP-suitable mapping.
> 
> Once again, the question is whether we want to make this just RO or RO + EXEC
> to maintain my goal of just mapping program TEXT via THP. I'm willing to
> hear arguments either way.

It think the goal is to make feature useful and therefore we need to make
it available for widest possible set of people.

I think is should be allowed for RO (based on how file was opened, not on
PROT_*) + SHARED and for any PRIVATE mappings.

> > 
> > > +		addr = thp_get_unmapped_area(file, addr, len, pgoff, flags);
> > > +
> > > +		if (addr && (!(addr & HPAGE_PMD_OFFSET)))
> > > +			vm_maywrite = 0;
> > 
> > Oh. That's way too hacky. Better to ask for RO file instead.
> 
> I did that because the existing code just blindly sets VM_MAYWRITE and I
> obviously didn't want to, so making it a variable allowed me to shut it off
> if it was a THP mapping.

I think touching VM_MAYWRITE here is wrong. It should reflect what file
under the mapping allows.

-- 
 Kirill A. Shutemov
