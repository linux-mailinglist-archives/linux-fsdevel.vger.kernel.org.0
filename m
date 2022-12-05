Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEE964390A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Dec 2022 00:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbiLEXEn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Dec 2022 18:04:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234088AbiLEXEO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Dec 2022 18:04:14 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12831E718
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Dec 2022 15:04:12 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id v3so11812709pgh.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Dec 2022 15:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EMxgvk2yFo8Rbo93eUfFPWH3YMgPyr5c5rnRRAyyLVQ=;
        b=iOrSXyGTxznYf60vxpgZw1BUGdPVNNnMlULWbDKMC/irJbL/DtCnl3UE6To5r3i0l7
         cBucxsHbsUsdJdGcFE4d82oijuHcHOqR+xhnFPOq0V2wdAC2GeDLMz/hiHnnM9mqqqtP
         PLka0Va0yo9KktVSFPbzPYQBWMMSZBgkOu+uWLMI2lxVX83AvcNKwrJuNq02j/0M6Ifq
         qZwwzMUcXXwV3+yKx0oEYc5qd1ddbGHf3Wpv7XvB4ctfZTc7PmpAu5k1fEG/aL15KyHB
         cT0wsUcmslmk1OebxljI2vMc9KmCx+lK941ay7frIZgQuyyOclqJqhWcLEm4nH1VbCf5
         NRYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMxgvk2yFo8Rbo93eUfFPWH3YMgPyr5c5rnRRAyyLVQ=;
        b=VT+/nAyQVU5TwOZv5nQnY9RyTIZXMTuFz0FkXGAPSAy8w5ht6poAouYD9LrogVLur5
         y0hmWhY8I/9bzeVdXCT2DmrXFRSfKjM3mLN+0sRIqBJOJPCA5VK3k1IO+0y1aEq2mF+l
         GBHLiOLqKiJg4O4D9haDc1LoHZmU/+SH4/Y8EHUrS5odbwOx2AqvOlZ2PMCJNktfLm5R
         A0cLpubQDAGzwtMsn0C1Y85mGWOgfyyXG+VpMSbGh04NvrCjDCB5sCqdZSPPKabI4jR7
         8SOn33QdWgvZrCG2mxjaxPfI/hh7bjvGzmvD4TK1qD1cIyKZ47AGVRt2F44tvPOjN9Ik
         K6Cg==
X-Gm-Message-State: ANoB5pkkfA3QXdDEo/nmdVSo/0fNMsBdYQf3lOuU5CyJKVwCToLbOl4J
        H75Lek6Y0QvlEU4mTeTJoT2QtQ==
X-Google-Smtp-Source: AA0mqf5eDxwr9JDrHbPttLGwszxyGTK5GHFn8edQbmPwIKgeDp4Nde0sxZFhRR/hZfKvOlnUTyuXfw==
X-Received: by 2002:a63:d48:0:b0:474:6739:6a09 with SMTP id 8-20020a630d48000000b0047467396a09mr66392507pgn.292.1670281452243;
        Mon, 05 Dec 2022 15:04:12 -0800 (PST)
Received: from dread.disaster.area (pa49-181-54-199.pa.nsw.optusnet.com.au. [49.181.54.199])
        by smtp.gmail.com with ESMTPSA id b15-20020a170902d50f00b00174f61a7d09sm11120251plg.247.2022.12.05.15.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 15:04:11 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1p2KVM-004y9z-6R; Tue, 06 Dec 2022 10:04:08 +1100
Date:   Tue, 6 Dec 2022 10:04:08 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Subject: Re: [RFC v2 0/3] Turn iomap_page_ops into iomap_folio_ops
Message-ID: <20221205230408.GQ3600936@dread.disaster.area>
References: <20221201160619.1247788-1-agruenba@redhat.com>
 <20221201180957.1268079-1-agruenba@redhat.com>
 <20221201212956.GO3600936@dread.disaster.area>
 <CAHc6FU6u9A0S-EwyB6vq89XPj1rucL8U0oqq__OzB1d0evM-yA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU6u9A0S-EwyB6vq89XPj1rucL8U0oqq__OzB1d0evM-yA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 02, 2022 at 02:54:00AM +0100, Andreas Gruenbacher wrote:
> On Thu, Dec 1, 2022 at 10:30 PM Dave Chinner <david@fromorbit.com> wrote:
> > On Thu, Dec 01, 2022 at 07:09:54PM +0100, Andreas Gruenbacher wrote:
> > > Hi again,
> > >
> > > [Same thing, but with the patches split correctly this time.]
> > >
> > > we're seeing a race between journaled data writes and the shrinker on
> > > gfs2.  What's happening is that gfs2_iomap_page_done() is called after
> > > the page has been unlocked, so try_to_free_buffers() can come in and
> > > free the buffers while gfs2_iomap_page_done() is trying to add them to
> > > the transaction.  Not good.
> > >
> > > This is a proposal to change iomap_page_ops so that page_prepare()
> > > prepares the write and grabs the locked page, and page_done() unlocks
> > > and puts that page again.  While at it, this also converts the hooks
> > > from pages to folios.
> > >
> > > To move the pagecache_isize_extended() call in iomap_write_end() out of
> > > the way, a new folio_may_straddle_isize() helper is introduced that
> > > takes a locked folio.  That is then used when the inode size is updated,
> > > before the folio is unlocked.
> > >
> > > I've also converted the other applicable folio_may_straddle_isize()
> > > users, namely generic_write_end(), ext4_write_end(), and
> > > ext4_journalled_write_end().
> > >
> > > Any thoughts?
> >
> > I doubt that moving page cache operations from the iomap core to
> > filesystem specific callouts will be acceptible. I recently proposed
> > patches that added page cache walking to an XFS iomap callout to fix
> > a data corruption, but they were NAKd on the basis that iomap is
> > supposed to completely abstract away the folio and page cache
> > manipulations from the filesystem.
> 
> Right. The resulting code is really quite disgusting, for a
> fundamentalist dream of abstraction.
> 
> > This patchset seems to be doing the same thing - moving page cache
> > and folio management directly in filesystem specific callouts. Hence
> > I'm going to assume that the same architectural demarcation is
> > going to apply here, too...
> >
> > FYI, there is already significant change committed to the iomap
> > write path in the current XFS tree as a result of the changes I
> > mention - there is stale IOMAP detection which adds a new page ops
> > method and adds new error paths with a locked folio in
> > iomap_write_begin().
> 
> That would have belonged on the iomap-for-next branch rather than in
> the middle of a bunch of xfs commits.

Damned if you do, damned if you don't.

There were non-trivial cross dependencies between XFS and iomap in
that patch set.  The initial IOMAP_F_STALE infrastructure needed XFS
changes first, otherwise it could deadlock at ENOSPC on write page
faults. i.e. the iomap change in isolation broke stuff, so we're
forced to either carry XFs changes in iomap or iomap changes in XFS
so that there are no regressions in a given tree.

Then we had to move XFS functionality to iomap to fix another data
corruption that the IOMAP_F_STALE infrastructure exposed in XFS via
generic/346. Once the code was moved, then we could build it up into
the page cache scanning functionality in iomap. And only then could
we add the XFS IOMAP_F_STALE validation to XFS to solve the original
data corruption that started all this off.

IOWs, there were so many cross dependencies between XFs and iomap
that it was largely impossible to break it up into two separate sets
of indpendent patches that didn't cause regressions in one or the
other tree. And in the end, we'd still have to merge the iomap tree
into XFS or vice versa to actually test that the data corruption fix
worked.

In situations like this, we commonly take the entire series into one
of the two trees rather than make a whole lot more work for
ourselves by trying to separate them out. And in this case, because
it was XFS data corruption and race conditions that needed fixing,
it made sense to take it through the XFS tree so that it gets
coverage from all the XFS testing that happens - the iomap tree gets
a lot less early coverage than the XFS tree...

> > And this other data corruption (and performance) fix for handling
> > zeroing over unwritten extents properly:
> >
> > https://lore.kernel.org/linux-xfs/20221201005214.3836105-1-david@fromorbit.com/
> >
> > changes the way folios are looked up and instantiated in the page
> > cache in iomap_write_begin(). It also adds new error conditions that
> > need to be returned to callers so to implement conditional "folio
> > must be present and dirty" page cache zeroing from
> > iomap_zero_iter(). Those semantics would also have to be supported
> > by gfs2, and that greatly complicates modifying and testing iomap
> > core changes.
> >
> > To avoid all this, can we simple move the ->page_done() callout in
> > the error path and iomap_write_end() to before we unlock the folio?
> > You've already done that for pagecache_isize_extended(), and I can't
> > see anything obvious in the gfs2 ->page_done callout that
> > would cause issues if it is called with a locked dirty folio...
> 
> Yes, I guess we can do that once pagecache_isize_extended() is
> replaced by folio_may_straddle_isize().
> 
> Can people please scrutinize the math in folio_may_straddle_isize() in
> particular?

I'll look at it more closely in the next couple of days.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
