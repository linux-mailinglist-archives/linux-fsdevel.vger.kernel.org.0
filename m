Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C71419DE1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 20:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235932AbhI0SLb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 14:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235696AbhI0SLb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 14:11:31 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086DCC061575;
        Mon, 27 Sep 2021 11:09:53 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id 138so37444256qko.10;
        Mon, 27 Sep 2021 11:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+74FrA4BDR4sTJKoxyTfHdDlbMZ+846PN+NihhHFxi0=;
        b=ehqZSv84Rwon47h2I0MSn10EHh/0KJhBFRXdP4VtV752eOgbQ79oPe6vtf+VQJoWle
         +ydDV4ul489wNqir+HG4YHEMIRjJI/UVe5SZFbITA+FlrtEmsw4zVN8mhplSw5cYa2A2
         ct6+4/ODfOmLqJivvh5cBSns8xn++DGyOjgvA0+W6mrsbTdNAgxLZ1MDlvlQgmZ1R+Bc
         m08dNZcbay20EVIB1D8zCPTspjhjs3Wyk7n1wZK8lHRiCQAXdlGn28mSuBTkdDqHMel6
         6aVhG7lI8MpaEgL6ILOphjfwAWmkNIfSOeod3dLX2MkRQOsaKLaiyFP2O1DRpnt2+azN
         7skA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+74FrA4BDR4sTJKoxyTfHdDlbMZ+846PN+NihhHFxi0=;
        b=dC3EzRssthnYDE30865WKG8uWPQ8fHlklfCuVCeMDGZ14tjzyytvfMJIDOYA7N4dH0
         C6sHAgO8+lFNQYHIrMRZ+waP2n/HC3mxBTVe3Z6MxBDOFCv1GLlgQOTjN6IKzZubffgQ
         uvwhp5m7+NUcF+0TnaZTKiykGtiMHpiqw0UHCZNLACKoyOPo+NLOwhkADCOXV4RFF8of
         hfek2zxsQx1uRJ3OOirU6QpAnbl8xUNWk1Dck3ZNWjFCrD7cprKkBZPrNUiEKAAGDBJk
         KTCZwawnIkxcemuHpy4GtFU8K2THjroGfy2Pjc7E3y/CM656REVFPZ7ItJg9sHyrBZRx
         5R/A==
X-Gm-Message-State: AOAM531tEmhzrIB9E7IJ9Qq33HSn1MOGZRkmimtpz5W9JfLOLYi8dsKo
        BJm5N5HxeHSkxNANsPuYPQ==
X-Google-Smtp-Source: ABdhPJwx4bWT5tiU3pyWgUXRe+OIrjlTHS1HE/IWluKnSpeJEqJ0TWg/NzCTSWGffa5gaQFvucXuIQ==
X-Received: by 2002:a37:4593:: with SMTP id s141mr1302331qka.368.1632766192215;
        Mon, 27 Sep 2021 11:09:52 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id o21sm11266790qtt.12.2021.09.27.11.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 11:09:51 -0700 (PDT)
Date:   Mon, 27 Sep 2021 14:09:49 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: Struct page proposal
Message-ID: <YVII7eM7P42riwoI@moria.home.lan>
References: <YUvWm6G16+ib+Wnb@moria.home.lan>
 <bc22b4d0-ba63-4559-88d9-a510da233cad@suse.cz>
 <YVIH5j5xkPafvNds@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVIH5j5xkPafvNds@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 27, 2021 at 07:05:26PM +0100, Matthew Wilcox wrote:
> On Mon, Sep 27, 2021 at 07:48:15PM +0200, Vlastimil Babka wrote:
> > On 9/23/21 03:21, Kent Overstreet wrote:
> > > So if we have this:
> > > 
> > > struct page {
> > > 	unsigned long	allocator;
> > > 	unsigned long	allocatee;
> > > };
> > > 
> > > The allocator field would be used for either a pointer to slab/slub's state, if
> > > it's a slab page, or if it's a buddy allocator page it'd encode the order of the
> > > allocation - like compound order today, and probably whether or not the
> > > (compound group of) pages is free.
> > 
> > The "free page in buddy allocator" case will be interesting to implement.
> > What the buddy allocator uses today is:
> > 
> > - PageBuddy - determine if page is free; a page_type (part of mapcount
> > field) today, could be a bit in "allocator" field that would have to be 0 in
> > all other "page is allocated" contexts.
> > - nid/zid - to prevent merging accross node/zone boundaries, now part of
> > page flags
> > - buddy order
> > - a list_head (reusing the "lru") to hold the struct page on the appropriate
> > free list, which has to be double-linked so page can be taken from the
> > middle of the list instantly
> > 
> > Won't be easy to cram all that into two unsigned long's, or even a single
> > one. We should avoid storing anything in the free page itself. Allocating
> > some external structures to track free pages is going to have funny
> > bootstrap problems. Probably a major redesign would be needed...
> 
> Wait, why do we want to avoid using the memory that we're allocating?

The issue is where to stick the state for free pages. If that doesn't fit in two
ulongs, then we'd need a separate allocation, which means slab needs to be up
and running before free pages are initialized.
