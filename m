Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F2B612D5E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Oct 2022 23:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiJ3WbZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Oct 2022 18:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiJ3WbX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Oct 2022 18:31:23 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FA0BCBE
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Oct 2022 15:31:21 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id l6so8965879pjj.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Oct 2022 15:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DcwXybMvqdXOor16e3YOdpHDY36S0rZaFBu3vo1BsYg=;
        b=nURrHN0WTStv5+iv5nasW9NQx9y2AI9zaUCRdpTFH5RRS9vga3RXOa+F2nbR40Kk3a
         qpnoe92IfStv64wG3Taztq5i7j5CxCXeoIKhY0UG0S4IcFo6o1O9ekC9aQCR3u0ovYgO
         8sfLqrITsyJL41Fqumr11hi489kC3p+VdnTw1oX3TvFYIrM5wFSBrJwfzBWN0YyY5zhw
         +L7/lDiBV9ZsUPSu/OLBPrLguzs0CcvdpxNsGdpE/EPgR0QDz+Aa1SGJvWyF6b+N0efB
         zchHcCEzPQIdDQajfPAL4LW38mTIW2dE0zskmH/Rh4Jgtczc70xThGk6AhITcQGDuUK7
         rbng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DcwXybMvqdXOor16e3YOdpHDY36S0rZaFBu3vo1BsYg=;
        b=NQB/N4fGTXeUVxi3viCWIpdFkGD/i28wTrPtd8GRwLKhaaY126FKh8OsXeGJwdKho7
         VIOCIYKZg1JIHIxZZDK5+2TpLDIV39x8sy1hlLqSpX3DyLu9fu8lta5HR03MtheOzSBU
         +h//HQtY/ItwGi1Ukp+Hb2ac8piRo+E3ttie8wuj2fz8rG45/HGQWHwRQaQjpyTfPs9C
         AJAqFF2iRBST9L5+1rIt/we7lYYWEy/dQNFu7GzkO5XOvi0y9eRK+1VhjKDhq/DuDTT0
         mI/ao3xwNggANLsWpIt3ilBxSRqcUAOt7xwW/CUeiGzLGD/wkueB/lsA3yC0+gg+VIcV
         2zLw==
X-Gm-Message-State: ACrzQf0mE++LkO2+Ff2qPm/+UgTXDl/muTCW+LlBMz+ESYLBRstGrvhm
        HNa6TzIy+FqLa+0ig57FEFaMyA==
X-Google-Smtp-Source: AMsMyM4uiOrf1wuITMCG2UeFrH+tKYrm7QAW8vTIyxYNp0dnKO3gozR1AAMaMAargty2uEzrYw196A==
X-Received: by 2002:a17:903:2283:b0:187:21f6:fde2 with SMTP id b3-20020a170903228300b0018721f6fde2mr2040462plh.49.1667169080710;
        Sun, 30 Oct 2022 15:31:20 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au. [49.181.106.210])
        by smtp.gmail.com with ESMTPSA id h15-20020a170902680f00b00186cf82717fsm3112996plk.165.2022.10.30.15.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 15:31:20 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1opGpp-008MMR-7w; Mon, 31 Oct 2022 09:31:17 +1100
Date:   Mon, 31 Oct 2022 09:31:17 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [RFC 2/2] iomap: Support subpage size dirty tracking to improve
 write performance
Message-ID: <20221030223117.GI3600936@dread.disaster.area>
References: <cover.1666928993.git.ritesh.list@gmail.com>
 <886076cfa6f547d22765c522177d33cf621013d2.1666928993.git.ritesh.list@gmail.com>
 <20221028210422.GC3600936@dread.disaster.area>
 <20221030032758.wpryf2rer7uppq7x@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221030032758.wpryf2rer7uppq7x@riteshh-domain>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Oct 30, 2022 at 08:57:58AM +0530, Ritesh Harjani (IBM) wrote:
> On 22/10/29 08:04AM, Dave Chinner wrote:
> > On Fri, Oct 28, 2022 at 10:00:33AM +0530, Ritesh Harjani (IBM) wrote:
> > > On a 64k pagesize platforms (specially Power and/or aarch64) with 4k
> > > filesystem blocksize, this patch should improve the performance by doing
> > > only the subpage dirty data write.
> > > 
> > > This should also reduce the write amplification since we can now track
> > > subpage dirty status within state bitmaps. Earlier we had to
> > > write the entire 64k page even if only a part of it (e.g. 4k) was
> > > updated.
> > > 
> > > Performance testing of below fio workload reveals ~16x performance
> > > improvement on nvme with XFS (4k blocksize) on Power (64K pagesize)
> > > FIO reported write bw scores improved from around ~28 MBps to ~452 MBps.
> > > 
> > > <test_randwrite.fio>
> > > [global]
> > > 	ioengine=psync
> > > 	rw=randwrite
> > > 	overwrite=1
> > > 	pre_read=1
> > > 	direct=0
> > > 	bs=4k
> > > 	size=1G
> > > 	dir=./
> > > 	numjobs=8
> > > 	fdatasync=1
> > > 	runtime=60
> > > 	iodepth=64
> > > 	group_reporting=1
> > > 
> > > [fio-run]
> > > 
> > > Reported-by: Aravinda Herle <araherle@in.ibm.com>
> > > Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > 
> > To me, this is a fundamental architecture change in the way iomap
> > interfaces with the page cache and filesystems. Folio based dirty
> > tracking is top down, whilst filesystem block based dirty tracking
> > *needs* to be bottom up.
> > 
> > The bottom up approach is what bufferheads do, and it requires a
> > much bigger change that just adding dirty region tracking to the
> > iomap write and writeback paths.
> > 
> > That is, moving to tracking dirty regions on a filesystem block
> > boundary brings back all the coherency problems we had with
> > trying to keep bufferhead dirty state coherent with page dirty
> > state. This was one of the major simplifications that the iomap
> > infrastructure brought to the table - all the dirty tracking is done
> 
> Sure, but then with simplified iomap design these optimization in the 
> workload that I mentioned are also lost :(

Yes, we knew that when we first started planning to get rid of
bufferheads from XFS. That was, what, 7 years ago we started down
that path, and it's been that way in production systems since at
least 4.19.

> > by the page cache, and the filesystem has nothing to do with it at
> > all....
> > 
> > IF we are going to change this, then there needs to be clear rules
> > on how iomap dirty state is kept coherent with the folio dirty
> > state, and there need to be checks placed everywhere to ensure that
> > the rules are followed and enforced.
> 
> Sure.
> 
> > 
> > So what are the rules? If the folio is dirty, it must have at least one
> > dirty region? If the folio is clean, can it have dirty regions?
> > 
> > What happens to the dirty regions when truncate zeros part of a page
> > beyond EOF? If the iomap regions are clean, do they need to be
> > dirtied? If the regions are dirtied, do they need to be cleaned?
> > Does this hold for all trailing filesystem blocks in the (multipage)
> > folio, of just the one that spans the new EOF?
> > 
> > What happens with direct extent manipulation like fallocate()
> > operations? These invalidate the parts of the page cache over the
> > range we are punching, shifting, etc, without interacting directly
> > with iomap, so do we now have to ensure that the sub-folio dirty
> > regions are also invalidated correctly? i.e. do functions like
> > xfs_flush_unmap_range() need to become iomap infrastructure so that
> > they can update sub-folio dirty ranges correctly?
> > 
> > What about the
> > folio_mark_dirty()/filemap_dirty_folio()/.folio_dirty()
> > infrastructure? iomap currently treats this as top down, so it
> > doesn't actually call back into iomap to mark filesystem blocks
> > dirty. This would need to be rearchitected to match
> > block_dirty_folio() where the bufferheads on the page are marked
> > dirty before the folio is marked dirty by external operations....
> 
> Sure thanks for clearly listing out all of the paths. 
> Let me carefully review these paths to check on, how does adding a state 
> bitmap to iomap_page for dirty tracking is handled in every case which you 
> mentioned above. I would like to ensure, that we have reviewed all the 
> paths and functionally + theoritically this approach at least works fine.
> (Mainly I wanted to go over the truncate & fallocate paths that you listed above).

I'm kinda pointing it out all this as the reasons why we don't want
to go down this path again - per-filesystem block dirty tracking was
the single largest source of data corruption bugs in XFS back in the
days of bufferheads...

I really, really don't want the iomap infrastructure to head back in
that direction - we know it leads to on-going data corruption pain
because that's where we came from to get here.

I would much prefer we move to a different model for semi-random
sub-page writes. That was also Willy's suggestion - async
write-through caching (so the page never goes through a dirty state
for sub-page writes) is a much better model for modern high
performance storage systems than the existing buffered writeback
model....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
