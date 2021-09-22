Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C40C414CB1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Sep 2021 17:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbhIVPIh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 11:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbhIVPIg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 11:08:36 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D805C061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Sep 2021 08:07:06 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id a12so2145125qvz.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Sep 2021 08:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jquxLW4FijHNJV9XMN41LgyMRsCI/pVfpuzgC3iRpOQ=;
        b=bvUu8CJqcgCrHpo711SUodlSNU+whn+PHNlbSDhYqjSjFgsJDJKhVqqYieQkpvD4D5
         v2FGatFjIweuNDUImbNTgtqMeN5kS8Mem9lC4NLutvQM+tz99O+z8inVYx/kLNH6VqIb
         zO/DU6S22ch3H0pbIDftVwfM+Jj7oVFZFXSvyXEpvJ6sYZTGw6ZbDNax3ONHbCJIV8c1
         DAN3HyhnkxpeR51efE1ayvCpr/XKI+rjiNYogX4Z5SNH/Oal/YpPtrLzZ5q35mtmJFXY
         OOvZiAuNel01SJBeyzTiMJfXloUsvY8ApYKVgLCba4tp25Ofgx2LNqPCjJmWgsTwP76g
         l9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jquxLW4FijHNJV9XMN41LgyMRsCI/pVfpuzgC3iRpOQ=;
        b=gp3HZI3PwIjv1xK821eIZk68OamUsHCnouzBL9LsrYvgBUhNpEnQNUOyQ8tu8r08Vt
         DfjvwyxzUxungUtDlQuJaz31OxdG5F5+a/XNEXdYw8sDczWj1rUJvGystMQb0DLtoLV3
         0V1Zow7WJPeNJVlJwL4romWS5ES7WvdsagMHOwB237wd5mLCtRqgo1wch8Swc6+ceZFb
         XgaQ86neVhW8CsyKP9H5RXuEsU5SUte6e2wD7t7VGTvrKfnQ/u1j10ISB4xRGprSXJIc
         xgGCfRXCVZZqsniBfU/E+Dgvmfjo/jcqLNub35QOM9r/KfZhRhb8YKti3NRpQcmmtz4g
         YBwg==
X-Gm-Message-State: AOAM532BC/6f9hTuz3SCyIBtjwBStYm/OC6U200AE2CuBhmChh+/bPRb
        MxJkNVeI2gHSxTJHzwFrwsKmeg==
X-Google-Smtp-Source: ABdhPJw3vk+8XKjFfWdiSeZYRsPtPmEPF9fTuZxRCx+Cp7Z/0bikm07EI8gPgN1cdZXPaOU6deX3gg==
X-Received: by 2002:ad4:4705:: with SMTP id k5mr24423690qvz.55.1632323218426;
        Wed, 22 Sep 2021 08:06:58 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id j26sm1567616qtr.53.2021.09.22.08.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 08:06:57 -0700 (PDT)
Date:   Wed, 22 Sep 2021 11:08:58 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: Folios for 5.15 request - Was: re: Folio discussion recap -
Message-ID: <YUtHCle/giwHvLN1@cmpxchg.org>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YTu9HIu+wWWvZLxp@moria.home.lan>
 <YUfvK3h8w+MmirDF@casper.infradead.org>
 <YUo20TzAlqz8Tceg@cmpxchg.org>
 <YUpC3oV4II+u+lzQ@casper.infradead.org>
 <YUpKbWDYqRB6eBV+@moria.home.lan>
 <YUpNLtlbNwdjTko0@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUpNLtlbNwdjTko0@moria.home.lan>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 21, 2021 at 05:22:54PM -0400, Kent Overstreet wrote:
>  - it's become apparent that there haven't been any real objections to the code
>    that was queued up for 5.15. There _are_ very real discussions and points of
>    contention still to be decided and resolved for the work beyond file backed
>    pages, but those discussions were what derailed the more modest, and more
>    badly needed, work that affects everyone in filesystem land

Unfortunately, I think this is a result of me wanting to discuss a way
forward rather than a way back.

To clarify: I do very much object to the code as currently queued up,
and not just to a vague future direction.

The patches add and convert a lot of complicated code to provision for
a future we do not agree on. The indirections it adds, and the hybrid
state it leaves the tree in, make it directly more difficult to work
with and understand the MM code base. Stuff that isn't needed for
exposing folios to the filesystems.

As Willy has repeatedly expressed a take-it-or-leave-it attitude in
response to my feedback, I'm not excited about merging this now and
potentially leaving quite a bit of cleanup work to others if the
downstream discussion don't go to his liking.

Here is the roughly annotated pull request:

      mm: Convert get_page_unless_zero() to return bool
      mm: Introduce struct folio
      mm: Add folio_pgdat(), folio_zone() and folio_zonenum()

      mm/vmstat: Add functions to account folio statistics

		Used internally and not *really* needed for filesystem
		folios... There are a couple of callsites in
		mm/page-writeback.c so I suppose it's ok.

      mm/debug: Add VM_BUG_ON_FOLIO() and VM_WARN_ON_ONCE_FOLIO()
      mm: Add folio reference count functions
      mm: Add folio_put()
      mm: Add folio_get()
      mm: Add folio_try_get_rcu()
      mm: Add folio flag manipulation functions

      mm/lru: Add folio LRU functions

		The LRU code is used by anon and file and not needed
		for the filesystem API.

		And as discussed, there is generally no ambiguity of
		tail pages on the LRU list.

      mm: Handle per-folio private data
      mm/filemap: Add folio_index(), folio_file_page() and folio_contains()
      mm/filemap: Add folio_next_index()
      mm/filemap: Add folio_pos() and folio_file_pos()
      mm/util: Add folio_mapping() and folio_file_mapping()
      mm/filemap: Add folio_unlock()
      mm/filemap: Add folio_lock()
      mm/filemap: Add folio_lock_killable()
      mm/filemap: Add __folio_lock_async()
      mm/filemap: Add folio_wait_locked()
      mm/filemap: Add __folio_lock_or_retry()

      mm/swap: Add folio_rotate_reclaimable()

		More LRU code, although this one is only used by
		page-writeback... I suppose.

      mm/filemap: Add folio_end_writeback()
      mm/writeback: Add folio_wait_writeback()
      mm/writeback: Add folio_wait_stable()
      mm/filemap: Add folio_wait_bit()
      mm/filemap: Add folio_wake_bit()
      mm/filemap: Convert page wait queues to be folios
      mm/filemap: Add folio private_2 functions
      fs/netfs: Add folio fscache functions
      mm: Add folio_mapped()
      mm: Add folio_nid()

      mm/memcg: Remove 'page' parameter to mem_cgroup_charge_statistics()
      mm/memcg: Use the node id in mem_cgroup_update_tree()
      mm/memcg: Remove soft_limit_tree_node()
      mm/memcg: Convert memcg_check_events to take a node ID

		These are nice cleanups, unrelated to folios. Ack.

      mm/memcg: Add folio_memcg() and related functions
      mm/memcg: Convert commit_charge() to take a folio
      mm/memcg: Convert mem_cgroup_charge() to take a folio
      mm/memcg: Convert uncharge_page() to uncharge_folio()
      mm/memcg: Convert mem_cgroup_uncharge() to take a folio
      mm/memcg: Convert mem_cgroup_migrate() to take folios
      mm/memcg: Convert mem_cgroup_track_foreign_dirty_slowpath() to folio
      mm/memcg: Add folio_memcg_lock() and folio_memcg_unlock()
      mm/memcg: Convert mem_cgroup_move_account() to use a folio
      mm/memcg: Add folio_lruvec()
      mm/memcg: Add folio_lruvec_lock() and similar functions
      mm/memcg: Add folio_lruvec_relock_irq() and folio_lruvec_relock_irqsave()
      mm/workingset: Convert workingset_activation to take a folio	

		This is all anon+file stuff, not needed for filesystem
		folios.

		As per the other email, no conceptual entry point for
		tail pages into either subsystem, so no ambiguity
		around the necessity of any compound_head() calls,
		directly or indirectly. It's easy to rule out
		wholesale, so there is no justification for
		incrementally annotating every single use of the page.

		NAK.

      mm: Add folio_pfn()
      mm: Add folio_raw_mapping()
      mm: Add flush_dcache_folio()
      mm: Add kmap_local_folio()
      mm: Add arch_make_folio_accessible()

      mm: Add folio_young and folio_idle
      mm/swap: Add folio_activate()
      mm/swap: Add folio_mark_accessed()

		This is anon+file aging stuff, not needed.

      mm/rmap: Add folio_mkclean()

      mm/migrate: Add folio_migrate_mapping()
      mm/migrate: Add folio_migrate_flags()
      mm/migrate: Add folio_migrate_copy()

		More anon+file conversion, not needed.

      mm/writeback: Rename __add_wb_stat() to wb_stat_mod()
      flex_proportions: Allow N events instead of 1
      mm/writeback: Change __wb_writeout_inc() to __wb_writeout_add()
      mm/writeback: Add __folio_end_writeback()
      mm/writeback: Add folio_start_writeback()
      mm/writeback: Add folio_mark_dirty()
      mm/writeback: Add __folio_mark_dirty()
      mm/writeback: Convert tracing writeback_page_template to folios
      mm/writeback: Add filemap_dirty_folio()
      mm/writeback: Add folio_account_cleaned()
      mm/writeback: Add folio_cancel_dirty()
      mm/writeback: Add folio_clear_dirty_for_io()
      mm/writeback: Add folio_account_redirty()
      mm/writeback: Add folio_redirty_for_writepage()
      mm/filemap: Add i_blocks_per_folio()
      mm/filemap: Add folio_mkwrite_check_truncate()
      mm/filemap: Add readahead_folio()

      mm/workingset: Convert workingset_refault() to take a folio

		Anon+file, not needed. NAK.

      mm: Add folio_evictable()
      mm/lru: Convert __pagevec_lru_add_fn to take a folio
      mm/lru: Add folio_add_lru()

		LRU code, not needed.

      mm/page_alloc: Add folio allocation functions
      mm/filemap: Add filemap_alloc_folio
      mm/filemap: Add filemap_add_folio()
      mm/filemap: Convert mapping_get_entry to return a folio
      mm/filemap: Add filemap_get_folio
      mm/filemap: Add FGP_STABLE
      mm/writeback: Add folio_write_one

I'm counting about a thousand of lines of contentious LOC that clearly
aren't necessary for exposing folios to the filesystems.

The rest of these are pagecache and writeback. It's still a ton of
(internal) code converted to folios that has conceptually little to no
ambiguity about head and tail pages.

As per the other email I still think it would have been good to have a
high-level discussion about the *legitimate* entry points and data
structures that will continue to deal with tail pages down the
line. To scope the actual problem that is being addressed by this
inverted/whitelist approach - so we don't annotate the entire world
just to box in a handful of page table walkers...

But oh well. Not a hill I care to die on at this point...
