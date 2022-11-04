Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2397D619558
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Nov 2022 12:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbiKDL3G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Nov 2022 07:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbiKDL3F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Nov 2022 07:29:05 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAC6B31;
        Fri,  4 Nov 2022 04:29:03 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so7937452pji.1;
        Fri, 04 Nov 2022 04:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d8zoflul3/5nzAwVIPjTKyVZVS//BM2IExdOadXNTBw=;
        b=GL84DXuS9o++wd7EABU4SkToq/vlPqpmJ/pC3igMUB6k53Ouu7HSopOZ72k4Cyxu5Q
         0aLfHjLpS4ObyxVzLnqyT1TfZlkWa74kmve7b9lAHMeyFbAg9+Y52HkqgVg8Rvji3WxR
         09exotGIydX4TN5kXkeh5i2AhIWP9Exbh2z2M4U1EhaI5BFXeV6KpTNAj6WZ5nv7iuEN
         xXvGoJPNyE+7W71hKhHAGpIgJf58AXObbq5vHAttGPAzb3okE0niL+rOjIgvPAZ6RKrh
         RQKot9NNEQaOp9KEDGSZnv2/T5ZLOqn7mZTdH4ZH1jSndxQUbTOSQrtwV3/9j0artDBG
         ePkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d8zoflul3/5nzAwVIPjTKyVZVS//BM2IExdOadXNTBw=;
        b=dNaLaJQeDAsyE5cS+yFP0mzMjyNmgJ/t+3ZNURMkkuz2xrpKAUDXl5Ki/tYKy5zh0Z
         hVVPOqPYp3IfFsGMCMpohZHdVu5J8HyRsc+kE/iNpll7mF59snv3xYdFZZB0JBB/uISL
         HWLfhYn7lJ3Nbtukd1EFfIRZJ67oXhqxUt/kQzX4TXQHjBTf364MSzZJePscHx5IrF4k
         SjlCujXLai5hi1HvoiKrCAlbLxJVXfC5H8Zl8hBAsF8m7V9htUBOMc7uuPxemUzdNpi9
         /AagsRIx7qO5gG3EWIRWFvZeDOX+l+S/5mYFNFaLgIxAnB4fQ42ovprNHNhy+/5XLGhH
         TuDQ==
X-Gm-Message-State: ACrzQf3O+qPx66gp3CXtCXQ6LBTkIneoMzWH1tVQK9o30vTb1KqBo7A6
        6oU1xPjlSQFYV7KrgPSDEro=
X-Google-Smtp-Source: AMsMyM51BcHqdL0MVHLlMIN4RMCo2fjL20Ipd0IC9Xag+gEoU2YBzT28d6F6aL90uv1K6uTOtDeoiw==
X-Received: by 2002:a17:90a:d901:b0:213:dc98:8b0d with SMTP id c1-20020a17090ad90100b00213dc988b0dmr28251302pjv.11.1667561342925;
        Fri, 04 Nov 2022 04:29:02 -0700 (PDT)
Received: from localhost ([2406:7400:63:f20b:f6ca:e236:f59f:8c18])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090322cf00b00176d347e9a7sm2390867plg.233.2022.11.04.04.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 04:29:02 -0700 (PDT)
Date:   Fri, 4 Nov 2022 16:58:56 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Aravinda Herle <araherle@in.ibm.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [RFC 2/2] iomap: Support subpage size dirty tracking to improve
 write performance
Message-ID: <20221104112856.hcfanfbrvw6atuev@riteshh-domain>
References: <cover.1666928993.git.ritesh.list@gmail.com>
 <886076cfa6f547d22765c522177d33cf621013d2.1666928993.git.ritesh.list@gmail.com>
 <20221028210422.GC3600936@dread.disaster.area>
 <Y19EXLfn8APg3adO@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y19EXLfn8APg3adO@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks everyone for comments / review. Since there are many sub-threads, I will
try and follow up slowly with all the comments/questions raised. 

As for now, I would like to continue the discussion on the current design to
understand what sort of problems lies in maintaining bitmaps within iomap_page 
structure (which is the current design). More on that below...

On 22/10/31 03:43AM, Matthew Wilcox wrote:
> On Sat, Oct 29, 2022 at 08:04:22AM +1100, Dave Chinner wrote:
> > To me, this is a fundamental architecture change in the way iomap
> > interfaces with the page cache and filesystems. Folio based dirty
> > tracking is top down, whilst filesystem block based dirty tracking
> > *needs* to be bottom up.
> > 
> > The bottom up approach is what bufferheads do, and it requires a
> > much bigger change that just adding dirty region tracking to the
> > iomap write and writeback paths.
> 
> I agree that bufferheads do bottom-up dirty tracking, but I don't think
> that what Ritesh is doing here is bottom-up dirty tracking.  Buffer
> heads expose an API to dirty a block, which necessarily goes bottom-up.
> There's no API here to dirty a block.  Instead there's an API to dirty
> a range of a folio, so we're still top-down; we're just keeping track
> of it in a more precise way.

We are still top-down is what I think too. Thanks.

So IIUC, the bottom up approach here means that the I/O could be done using the
underlying buffer_heads without the page/folio knowing about it. 
This creats some sort of coherency problems due to which we needed to mark 
the folio clean in case of no dirty buffers attached to the folio. 
Now since the I/O can be done by using block buffer heads without involving VM, 
and later marking the folio clean, hence we call this as bottom up dirty tracking.

(There are some comments about it in try_to_free_buffers(), __folio_cancel_dirty(),
& buffer_busy() too)

Now since we are not doing anything like above, hence we still follow the
top-down approach.

Please correct if above is not true or if I am missing anything.

> 
> It's a legitimate complaint that there's now state that needs to be
> kept in sync with the page cache.  More below ...

Yes.. I would too like to understand more about this. 


> 
> > That is, moving to tracking dirty regions on a filesystem block
> > boundary brings back all the coherency problems we had with
> > trying to keep bufferhead dirty state coherent with page dirty
> > state. This was one of the major simplifications that the iomap
> > infrastructure brought to the table - all the dirty tracking is done
> > by the page cache, and the filesystem has nothing to do with it at
> > all....
> > 
> > IF we are going to change this, then there needs to be clear rules
> > on how iomap dirty state is kept coherent with the folio dirty
> > state, and there need to be checks placed everywhere to ensure that
> > the rules are followed and enforced.
> > 
> > So what are the rules? If the folio is dirty, it must have at least one
> > dirty region? If the folio is clean, can it have dirty regions?
> 
> If there is any dirty region, the folio must be marked dirty (otherwise
> we'll never know that it needs to be written back).  

Yes. That is my understanding too.

> The interesting question (as your paragraph below hints) is whether removing the dirty
> part of a folio from a file marks the folio clean.  I believe that's
> optional, but it's probably worth doing.

So in the current design, writeback path will anyway call
clear_page_dirty_for_io() before calling iomap_do_writepage() in which we will
clear the dirty bits from iop->state for writing.

But what about folio_cancel_dirty()? Is that what you are referring too here?

> 
> > What happens to the dirty regions when truncate zeros part of a page
> > beyond EOF? If the iomap regions are clean, do they need to be
> > dirtied? If the regions are dirtied, do they need to be cleaned?
> > Does this hold for all trailing filesystem blocks in the (multipage)
> > folio, of just the one that spans the new EOF?

So this is handled the same way. There are no changes in above.
If there is a truncate which zeroes part of page beyond EOF, we don't do any I/O
for that straddle range beyond EOF. We only make that region zero in memory 
and limit the end_pos until i_size. This is taken care in iomap_do_writepage().

> > 
> > What happens with direct extent manipulation like fallocate()
> > operations? These invalidate the parts of the page cache over the
> > range we are punching, shifting, etc, without interacting directly
> > with iomap, so do we now have to ensure that the sub-folio dirty
> > regions are also invalidated correctly? i.e. do functions like
> > xfs_flush_unmap_range() need to become iomap infrastructure so that
> > they can update sub-folio dirty ranges correctly?
> 
> I'm slightly confused by this question.  As I understand the various
> fallocate operations, they start by kicking out all the folios affected
> by the operation (generally from the start of the operation to EOF),
> so we'd writeback the (dirty part of) folios which are dirty, then
> invalidate the folios in cache.  I'm not sure there's going to be
> much difference.

So I looked into this part.

For operations of file fallocate like hole punch, zero range or collapse,
XFS calls xfs_flush_unmap_range() which make calls to 
filemap_write_and_wait_range() followed by truncate_pagecache_range().
This should writeback all dirty ranges in the affected region followed by
unmap, folio_invalidate and then finally removing given folio from page cache. 
In folio_invalidate() we call aops->invalidate_folio == iomap_invalidate_folio()

So I think if we are tracking dirty state bitmap within iop we should unset the 
dirty bits for the given range here in iomap_invalidate_folio().
(This is not currently done in this patch).
Although the above will be the right thing to do theoretically, but I am not
sure of what operation could cause any problem even in case when we don't unset
the bits?

My understanding is no operation directly on file can sneak in between
filemap_write_and_wait_range() & truncate_pagecache_range(), which can make the
folio dirty. (since we have taken the inode->i_rwsem write lock). 
And for mmap write fault path (which could sneak in), in that we anyway mark the 
entire page as dirty, so for that the entire page is anyway going to be written out.

Any idea on what operations would require us to clear the dirty bits for the given 
subpage range in iomap_invalidate_folio() for it's correctness?

(Is it that folio_mark_dirty "external operations"... More on that below)

> 
> > What about the
> > folio_mark_dirty()/filemap_dirty_folio()/.folio_dirty()
> > infrastructure? iomap currently treats this as top down, so it
> > doesn't actually call back into iomap to mark filesystem blocks
> > dirty. This would need to be rearchitected to match
> > block_dirty_folio() where the bufferheads on the page are marked
> > dirty before the folio is marked dirty by external operations....

What are these "external operations"... continuing below

> 
> Yes.  This is also going to be a performance problem.  Marking a folio as
> dirty is no longer just setting the bit in struct folio and the xarray
> but also setting all the bits in iop->state.  

On setting the bits part, bitmap_** apis should generally optimize for cases 
when setting more than one bit though.

> Depending on the size
> of the folio, and the fs blocksize, this could be quite a lot of bits.
> eg a 2MB folio with a 1k block size is 2048 bits (256 bytes, 6 cachelines
> (it dirties the spinlock in cacheline 0, then the bitmap occupies 3 full
> cachelines and 2 partial ones)).

ok. the "state_lock" spinlock and "state[]" bitmaps within struct "iop_page".

> 
> I don't see the necessary churn from filemap_dirty_folio() to
> iomap_dirty_folio() as being a huge deal, but it's definitely a missing
> piece from this RFC.

Yes, this is what I am currently investigating. So what are those 
"external operations" which would require us to call into iomap to mark
all the bitmaps as dirty from within folio_mark_dirty()? 

I did look into callers of folio_mark_dirty(). But I am unable to put my head
around such operations, which can show me the coherency problem here.
i.e. why do we need to mark iomap_set_range_dirty() when calling
folio_mark_dirty().

So... when do we mark the dirty bitmaps of iop->state?

At two places - 
1. In case when the file_write_iter operation is called. This will call into
   iomap_write_iter -> iomap_write_end(). At this place before marking the
   folio as dirty, we will mark iomap_set_range_dirty() followed by
   filemap_dirty_folio().

2. Another case is VM write fault path. i.e. iomap_page_mkwrite(). 
   This will call iomap_folio_mkwrite_iter() for the given folio. In this we
   mark the entire range of the folio as dirty by calling iomap_set_range_dirty() 
   followed by folio_mark_dirty()

Now when do we clear these dirty bitmaps? 
1. We clear these bitmaps at the time of writeback. When writeback calls into
   iomap_writepage_map() for every folio. In this before submitting the
   ioend/bio, we will call iomap_clear_range_dirty() followed by
   folio_start_writeback().

Any idea which path can help me understand the reason on why should we mark 
iomap_set_range_dirty() when folio_mark_dirty() is called by "external operations". 
Some of such operations which I was investigating were - 
-> I couldn't find any in truncate/fallocate/hole punch/etc. 
-> process_vm_writev?
-> add_to_swap -> folio_mark_dirty()?
-> migrate?

And as I understand we are doing this to maintain coherency between say... if any
folio is marked as dirty, then it's corresponding iop->state bitmaps should also
be marked dirty. 

And then shoud be same for folio_cancel_dirty() too?

> 
> > The easy part of this problem is tracking dirty state on a
> > filesystem block boundaries. The *hard part* maintaining coherency
> > with the page cache, and none of that has been done yet. I'd prefer
> > that we deal with this problem once and for all at the page cache
> > level because multi-page folios mean even when the filesystem block
> > is the same as PAGE_SIZE, we have this sub-folio block granularity
> > tracking issue.
> > 

On the multi-folio / large folio thing. I will try and check more about it. 

So I could see the checks like "whether mapping supports large folio or not"
in iomap_write_begin(). But I am not sure the current status of that. 
(because even though we calculate "len" in iomap_write_begin() based on whether
mapping supports large folio or not, but we never pass "len" more than PAGE_SIZE
currently to iomap_write_begin() from iomap_write_iter(). 
Though it is true for iomap_zero_iter()).
So, I will spend sometime reading more on what FS operations does support 
large folio and it's current status to do more testing with large folio support.


- ritesh

> > As it is, we already have the capability for the mapping tree to
> > have multiple indexes pointing to the same folio - perhaps it's time
> > to start thinking about using filesystem blocks as the mapping tree
> > index rather than PAGE_SIZE chunks, so that the page cache can then
> > track dirty state on filesystem block boundaries natively and
> > this whole problem goes away. We have to solve this sub-folio dirty
> > tracking problem for multi-page folios anyway, so it seems to me
> > that we should solve the sub-page block size dirty tracking problem
> > the same way....
> 
> That's an interesting proposal.  From the page cache's point of
> view right now, there is only one dirty bit per folio, not per page.
> Anything you see contrary to that is old code that needs to be converted.
> So even indexing the page cache by block offset rather than page offset
> wouldn't help.
> 
> We have a number of people looking at the analogous problem for network
> filesystems right now.  Dave Howells' netfs infrastructure is trying
> to solve the problem for everyone (and he's been looking at iomap as
> inspiration for what he's doing).  I'm kind of hoping we end up with one
> unified solution that can be used for all filesystems that want sub-folio
> dirty tracking.  His solution is a bit more complex than I really want
> to see, at least partially because he's trying to track dirtiness at
> byte granularity, no matter how much pain that causes to the server.
