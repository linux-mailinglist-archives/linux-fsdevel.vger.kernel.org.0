Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1CE33FC94
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 02:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhCRBOX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Mar 2021 21:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbhCRBN6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Mar 2021 21:13:58 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26A1C06174A;
        Wed, 17 Mar 2021 18:13:57 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id x7-20020a17090a2b07b02900c0ea793940so4156328pjc.2;
        Wed, 17 Mar 2021 18:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fNdMzczkKUo9vETo8mrg1+O94VBE2XEQqnmUQshmkE4=;
        b=HPl4HwOLr/I9zn1/+omqUDDIx7OVcpGrw+CNbd+O+nKPxCQjq0dR4oRNCIozF5M0aS
         mjGXuh6+FBVjgPX/lGuD7EKpuewFl6xHdi3n03UA1CTGlQxD+qyyK1ylr5wkH4rDILmx
         z0HdZP4Ns+xCwiJFLCXMLQ/Zyi9lfBTHhevGMkBcioqMpA/Iz4kaTexb3zAqCZvzgVi7
         JL7Oh3veFiEGgUDb07njyYHej2ABTPWQqMeEpU8ZkvQNxpM+AFxjJtFDvofrxMdglVBY
         dMfl5xkcgtFRoRVeoY09xSCxXMhhaenNknxcPlgAYUmenLn9MucyfTEP2xYrn/2Mvsmg
         CGqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=fNdMzczkKUo9vETo8mrg1+O94VBE2XEQqnmUQshmkE4=;
        b=S0Iav629wsVT06CLuNSDlvcIz3fczrLWOfr6ONVM8ERmfgjkNRsgpWLLSnfnD0MrP8
         HKaUWm38m+cLbLM0W+vGBWntUFASmP3/Ks2sA+j7LyEg5RVwlac0twMYosTE7LkGa3IS
         RKAmpwP8mt+ApKoSdY6YPmaoy+K7CzE7nrSuDbo5rN6kL/rn4u7bgfDMPjM85vYjQSWA
         j98VjH8pn57fTbZvvt7VJEzGaBopU84KQn/WN4akfvqUU3mmYXzNkDGcpWwAj/0wbGQV
         dhKXYkQC2l4Ws3RgkyiCobLSMO62qbJmsbQ65lmE/RX6O8eb1OuI0kiEL/F8wk5f+Dcf
         pMnw==
X-Gm-Message-State: AOAM533A1ft80LytBJZUAs7PwRIGAewBg4CJfidXP3e52nXDH0bglWIC
        Av/BPzvJzMTd3lLx0NwxBrwi7Y45ikE=
X-Google-Smtp-Source: ABdhPJxvSpLxn2AUaIjJIf4QAY0eai4wAMjZggQF+awiY9dfI/RPYBBXDxCGGvNSxc73JPzh2HHq2Q==
X-Received: by 2002:a17:902:da81:b029:e5:de44:af5b with SMTP id j1-20020a170902da81b02900e5de44af5bmr7182638plx.27.1616030037123;
        Wed, 17 Mar 2021 18:13:57 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:8914:cdf:bafb:bf7b])
        by smtp.gmail.com with ESMTPSA id 22sm264464pjl.31.2021.03.17.18.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 18:13:55 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 17 Mar 2021 18:13:53 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        joaodias@google.com, surenb@google.com, cgoldswo@codeaurora.org,
        willy@infradead.org, mhocko@suse.com, david@redhat.com,
        vbabka@suse.cz, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] mm: disable LRU pagevec during the migration
 temporarily
Message-ID: <YFKpUSwd3XCiCeOk@google.com>
References: <20210310161429.399432-1-minchan@kernel.org>
 <20210310161429.399432-2-minchan@kernel.org>
 <20210317171316.d261de806203d8d99c6bf0ef@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317171316.d261de806203d8d99c6bf0ef@linux-foundation.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 17, 2021 at 05:13:16PM -0700, Andrew Morton wrote:
> On Wed, 10 Mar 2021 08:14:28 -0800 Minchan Kim <minchan@kernel.org> wrote:
> 
> > LRU pagevec holds refcount of pages until the pagevec are drained.
> > It could prevent migration since the refcount of the page is greater
> > than the expection in migration logic. To mitigate the issue,
> > callers of migrate_pages drains LRU pagevec via migrate_prep or
> > lru_add_drain_all before migrate_pages call.
> > 
> > However, it's not enough because pages coming into pagevec after the
> > draining call still could stay at the pagevec so it could keep
> > preventing page migration. Since some callers of migrate_pages have
> > retrial logic with LRU draining, the page would migrate at next trail
> > but it is still fragile in that it doesn't close the fundamental race
> > between upcoming LRU pages into pagvec and migration so the migration
> > failure could cause contiguous memory allocation failure in the end.
> > 
> > To close the race, this patch disables lru caches(i.e, pagevec)
> > during ongoing migration until migrate is done.
> > 
> > Since it's really hard to reproduce, I measured how many times
> > migrate_pages retried with force mode(it is about a fallback to a
> > sync migration) with below debug code.
> > 
> > int migrate_pages(struct list_head *from, new_page_t get_new_page,
> > 			..
> > 			..
> > 
> > if (rc && reason == MR_CONTIG_RANGE && pass > 2) {
> >        printk(KERN_ERR, "pfn 0x%lx reason %d\n", page_to_pfn(page), rc);
> >        dump_page(page, "fail to migrate");
> > }
> > 
> > The test was repeating android apps launching with cma allocation
> > in background every five seconds. Total cma allocation count was
> > about 500 during the testing. With this patch, the dump_page count
> > was reduced from 400 to 30.
> > 
> > The new interface is also useful for memory hotplug which currently
> > drains lru pcp caches after each migration failure. This is rather
> > suboptimal as it has to disrupt others running during the operation.
> > With the new interface the operation happens only once. This is also in
> > line with pcp allocator cache which are disabled for the offlining as
> > well.
> > 
> 
> This is really a rather ugly thing, particularly from a maintainability
> point of view.  Are you sure you found all the sites which need the

If you meant maintainability concern as "need pair but might miss",
we have lots of examples on such API(zone_pcp_disable, inc_tlb_flush,
kmap_atomic and so on) so I don't think you meant it.

If you meant how user could decide whether they should use 
lru_add_drain_all or lru_cache_disable/enable pair, we had already
carried the concept by migrate_prep. IOW, if someone want to increase
migration success ratio at the cost of drainning overhead,
they could use the lru_cache_disable instead of lru_add_drain_all.

Personally, I prefered migrate_prep/finish since it could include
other stuffs(e.g., zone_pcp_disable) as well as lru_cache_disable
but reviewerd didn't like to wrap it.

I realized by your comment. During the trasition from v2 to v3,
I missed a site which was most important site for me. :(

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f1f0ee08628f..39775c8f8c90 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8470,7 +8470,7 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
                .gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
        };

-       lru_add_drain_all();
+       lru_cache_disable();

        while (pfn < end || !list_empty(&cc->migratepages)) {
                if (fatal_signal_pending(current)) {
@@ -8498,6 +8498,9 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
                ret = migrate_pages(&cc->migratepages, alloc_migration_target,
                                NULL, (unsigned long)&mtc, cc->mode, MR_CONTIG_RANGE);
        }
+
+       lru_cache_enable();
+
        if (ret < 0) {
                putback_movable_pages(&cc->migratepages);
                return ret;

However, it was just my mistake during patch stacking and didn't
comes from semantic PoV.

Do you see still any concern? Otherwise, I will submit the fix, again.

> enable/disable?  How do we prevent new ones from creeping in which need

> the same treatment?  Is there some way of adding a runtime check which
> will trip if a conversion was missed?

Are you concerning losing the pair? or places we should use
lru_cache_disable, not lru_cache_drain_all?
As I mentioned, I just replaced all of migrate_prep places with
lru_cache_disable except the mistake above.

> 
> > ...
> >
> > +bool lru_cache_disabled(void)
> > +{
> > +	return atomic_read(&lru_disable_count);
> > +}
> > +
> > +void lru_cache_enable(void)
> > +{
> > +	atomic_dec(&lru_disable_count);
> > +}
> > +
> > +/*
> > + * lru_cache_disable() needs to be called before we start compiling
> > + * a list of pages to be migrated using isolate_lru_page().
> > + * It drains pages on LRU cache and then disable on all cpus until
> > + * lru_cache_enable is called.
> > + *
> > + * Must be paired with a call to lru_cache_enable().
> > + */
> > +void lru_cache_disable(void)
> > +{
> > +	atomic_inc(&lru_disable_count);
> > +#ifdef CONFIG_SMP
> > +	/*
> > +	 * lru_add_drain_all in the force mode will schedule draining on
> > +	 * all online CPUs so any calls of lru_cache_disabled wrapped by
> > +	 * local_lock or preemption disabled would be ordered by that.
> > +	 * The atomic operation doesn't need to have stronger ordering
> > +	 * requirements because that is enforeced by the scheduling
> > +	 * guarantees.
> > +	 */
> > +	__lru_add_drain_all(true);
> > +#else
> > +	lru_add_drain();
> > +#endif
> > +}
> 
> I guess at least the first two of these functions should be inlined.

Sure. Let me respin with fixing missing piece above once we get some
direction.
