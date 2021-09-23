Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B32CA4157C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 07:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbhIWFQw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 01:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhIWFQv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 01:16:51 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C46C061574;
        Wed, 22 Sep 2021 22:15:20 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id 194so17803795qkj.11;
        Wed, 22 Sep 2021 22:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TUxG+8asl1LF162nI/DmuTVqX3GA2culfN0NPUVwaHA=;
        b=nSAm+4wX3yNrL3K00/p5t4TICNSzDnFSKHWeyZbVuyO5jNmzaXpRmdETzPJQ05ywiT
         V2HU7sve6Muqfd8tU2jxcBjKxWU6X1zdsDtW6Y2qNdnI9Sa9KkyMrBEYO2s2gBlRUBci
         nDRcynM0OBtPQQ81C5ZXL4vTAuCFWp1iDcJAVZ85Mmb7r/PvnAe7sQZ7BGmJUiMcssGy
         li9bQX9L9XhB2z7out3SfCaKJKhp2gs9NHoXdTWIJPTL0fnfqBrPOtSAZbLF/EXpcVGh
         nbZMHZFWY7RhDSTNA9uPtES95L9mtNjPH3jrDr4v8QOH9aJEjI1BGcSCpUGZgBbFLC4b
         Wz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TUxG+8asl1LF162nI/DmuTVqX3GA2culfN0NPUVwaHA=;
        b=tNqyZEd0SiKtKgCntol24fTl4fFcTAbp3Qaq2/TSYjkK2leDRN8ChlRNG8dhxDYmI8
         1etqvJYhVmo29On2GHnRE4W3TfvAaICFniQb1sWxbyFGJ+qdvJy0YiKRz4p5Otuy2c3z
         egX1k0rkyCTpIVYlPuFANfjvJuM2vDCd1qBGALjpolCXiZonykDPLRqqyeeAoqW6SsO6
         ODqeFZGKR0hlPoJ9ztsdZKPirw5D3cSg84WxFnQAOiP23IqORaAKSjqUN5X/zfLsWQUI
         UI+Sa2NLBUpnh2xmB3OnSV6Boe2z/qr8nZzk7USNzd1QU/jrebP9MGt0xH0RmCCEDU12
         VQkw==
X-Gm-Message-State: AOAM531QtVYIimEiogV8wT6cXN7dkCdlY9wpRss5xgGn7Furj1+KKXsn
        SbyUFgbT/wcWT3XOa+X3HgRpDOFmHqF6
X-Google-Smtp-Source: ABdhPJxHllBoLtERI9n4b7VpnLh1zzHM1qYX2ydaHqiUXOEkmOq6sUfGkAAYHxXWp7mMtkowGMTrfg==
X-Received: by 2002:a37:397:: with SMTP id 145mr3062824qkd.332.1632374119898;
        Wed, 22 Sep 2021 22:15:19 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id s12sm3359314qkm.116.2021.09.22.22.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 22:15:18 -0700 (PDT)
Date:   Thu, 23 Sep 2021 01:15:16 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: Struct page proposal
Message-ID: <YUwNZFPGDj4Pkspx@moria.home.lan>
References: <YUvWm6G16+ib+Wnb@moria.home.lan>
 <YUvzINep9m7G0ust@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUvzINep9m7G0ust@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 23, 2021 at 04:23:12AM +0100, Matthew Wilcox wrote:
> On Wed, Sep 22, 2021 at 09:21:31PM -0400, Kent Overstreet wrote:
> > The fundamental reason for struct page is that we need memory to be self
> > describing, without any context - we need to be able to go from a generic
> > untyped struct page and figure out what it contains: handling physical memory
> > failure is the most prominent example, but migration and compaction are more
> > common. We need to be able to ask the thing that owns a page of memory "hey,
> > stop using this and move your stuff here".
> 
> Yup, and another thing we need is to take any page mapped to userspace
> and mark it as dirty (whatever that means for the owner of the page).

Yeah so that leads into another discussion, which is that pages have a public
interface that can be called by outside code - via page->mapping->a_ops - but
it's not particularly clear or documented anywhere that I've seen what that
interface is. We have stuff in a_ops that is definitely _not_ part of the public
interface and is really more for internal filesystem use - write_begin,
write_end, .readpage - like half of a_ops, really. It would be nice if as part
of these cleanups we could separate out the actual public interface and nail it
down and document it better.

Most if not all the stuff in a_ops that's for internal fs use really doesn't
need to be in an ops struct, they could be passed to the filemap.c functions
that use them - this would be a style improvement, it makes it clearer when you
pass a function pointer directly to the function that's going to use it (e.g.
passing write_begin and write _end to generic_file_buffered_read).

> We can also allocate a far larger structure.  eg, we might decide that
> a file page looks like this:

Yes! At the same time we should be trying to come up with cleanups that just
completele delete some of these things, but just having the freedom to not have
to care about shaving every single byte and laying things out in a sane way so
we can see at a glance what there is is going to make those cleanups that much
easier.

> (compiling that list reminds me that we'll need to sort out mapcount
> on subpages when it comes time to do this.  ask me if you don't know
> what i'm talking about here.)

I am curious why we would ever need a mapcount for just part of a page, tell me
more.

> I think we /can/ do all this.  I don't know that it's the right thing to
> do.  And I really mean that.  I genuinely don't know that "allocate
> file pages from slab" will solve any problems at all.  And I kind of
> don't want to investigate that until later.

The idea isn't "allocate file pages from slab", it's "do all allocations < 64k
(or whatever we decide) from slab" - because if you look at enough profiles
there are plenty of workloads where this really is a real world issue, and if we
can regigger things so that code outside mm/ literally does not care whether it
uses slab or alloc_pages(), why not do it? It's the cleanest approach.

> By the way, another way we could do this is to put the 'allocator'
> field into the allocatee's data structure.  eg the first word
> in struct folio could point to the struct slab that contains it.
> 
> > Other notes & potential issues:
> >  - page->compound_dtor needs to die
> 
> The reason we have it right now is that the last person to call
> put_page() may not be the one who allocated it.  _maybe_ we can do
> all-of-the-dtor-stuff when the person who allocates it frees it, and
> have put_page() only free the memory.  TBD.

We have it because hugepages and transhuge pages are "special" and special in
different ways. They should probably just be bits in the internal allocator
state, and hopefully compound_page_dtor and transhuge_dtor can just be deleted
(the hugepage dtor actually does do real things involving the hugepage reserve).

> Something we don't have to talk about right now is that there's no reason
> several non-contiguous pages can't have the same 'allocatee' value.
> I'm thinking that every page allocated to a given vmalloc allocation
> would point to the same vm_struct.  So I'm thinking that the way all of
> the above would work is we'd allocate a "struct folio" from slab, then
> pass the (tagged) pointer to alloc_pages().  alloc_pages() would fill
> in the 'allocatee' pointer for each of the struct pages with whatever
> pointer it is given.

There's also vmap to think about. What restrictions, if any, are there on what
kinds of pages can be passed to vmap()? I see it used in a lot of driver code,
and I wonder if I even dare ask what for.

> There's probably a bunch of holes in the above handwaving, but I'm
> pretty confident we can fill them.

Fun times!
