Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B5D5B64FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Sep 2022 03:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiIMBP3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 21:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiIMBP0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 21:15:26 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A643C1658D;
        Mon, 12 Sep 2022 18:15:24 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-149-49.pa.vic.optusnet.com.au [49.186.149.49])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 912241100506;
        Tue, 13 Sep 2022 11:15:20 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oXuWE-0073aR-ME; Tue, 13 Sep 2022 11:15:18 +1000
Date:   Tue, 13 Sep 2022 11:15:18 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "xiubli@redhat.com" <xiubli@redhat.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-man@vger.kernel.org" <linux-man@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jack@suse.cz" <jack@suse.cz>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "lczerner@redhat.com" <lczerner@redhat.com>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
Message-ID: <20220913011518.GE3600936@dread.disaster.area>
References: <91e31d20d66d6f47fe12c80c34b1cffdfc202b6a.camel@hammerspace.com>
 <166268467103.30452.1687952324107257676@noble.neil.brown.name>
 <166268566751.30452.13562507405746100242@noble.neil.brown.name>
 <29a6c2e78284e7947ddedf71e5cb9436c9330910.camel@hammerspace.com>
 <8d638cb3c63b0d2da8679b5288d1622fdb387f83.camel@hammerspace.com>
 <166270570118.30452.16939807179630112340@noble.neil.brown.name>
 <33d058be862ccc0ccaf959f2841a7e506e51fd1f.camel@kernel.org>
 <166285038617.30452.11636397081493278357@noble.neil.brown.name>
 <2e34a7d4e1a3474d80ee0402ed3bc0f18792443a.camel@kernel.org>
 <166302538820.30452.7783524836504548113@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166302538820.30452.7783524836504548113@noble.neil.brown.name>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=631fd9aa
        a=XTRC1Ovx3SkpaCW1YxGVGA==:117 a=XTRC1Ovx3SkpaCW1YxGVGA==:17
        a=kj9zAlcOel0A:10 a=xOM3xZuef0cA:10 a=7-415B0cAAAA:8
        a=l1P_Ky_A2ZjqpwNTm_4A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 13, 2022 at 09:29:48AM +1000, NeilBrown wrote:
> On Mon, 12 Sep 2022, Jeff Layton wrote:
> > On Sun, 2022-09-11 at 08:53 +1000, NeilBrown wrote:
> > > This could be expensive.
> > > 
> > > There is not currently any locking around O_DIRECT writes.  You cannot
> > > synchronise with them.
> > > 
> > 
> > AFAICT, DIO write() implementations in btrfs, ext4, and xfs all hold
> > inode_lock_shared across the I/O. That was why patch #8 takes the
> > inode_lock (exclusive) across the getattr.
> 
> Looking at ext4_dio_write_iter() it certain does take
> inode_lock_shared() before starting the write and in some cases it
> requests, using IOMAP_DIO_FORCE_WAIT, that imap_dio_rw() should wait for
> the write to complete.  But not in all cases.
> So I don't think it always holds the shared lock across all direct IO.

To serialise against dio writes, one must:

	// Lock the inode exclusively to block new DIO submissions
	inode_lock(inode);

	// Wait for all in flight DIO reads and writes to complete
	inode_dio_wait(inode);

This is how truncate, fallocate, etc serialise against AIO+DIO which
do not hold the inode lock across the entire IO. These have to
serialise aginst DIO reads, too, because we can't have IO in
progress over a range of the file that we are about to free....

> > Taking inode_lock_shared is sufficient to block out buffered and DAX
> > writes. DIO writes sometimes only take the shared lock (e.g. when the
> > data is already properly aligned). If we want to ensure the getattr
> > doesn't run while _any_ writes are running, we'd need the exclusive
> > lock.
> 
> But the exclusive lock is bad for scalability.

Serilisation against DIO is -expensive- and -slow-. It's not a
solution for what is supposed to be a fast unlocked read-only
operation like statx().

> > Maybe that's overkill, though it seems like we could have a race like
> > this without taking inode_lock across the getattr:
> > 
> > reader				writer
> > -----------------------------------------------------------------
> > 				i_version++
> > getattr
> > read
> > 				DIO write to backing store
> > 
> 
> This is why I keep saying that the i_version increment must be after the
> write, not before it.

Sure, but that ignores the reason why we actually need to bump
i_version *before* we submit a DIO write. DIO write invalidates the
page cache over the range of the write, so any racing read will
re-populate the page cache during the DIO write.

Hence buffered reads can return before the DIO write has completed,
and the contents of the read can contain, none, some or all of the
contents of the DIO write. Hence i_version has to be incremented
before the DIO write is submitted so that racing getattrs will
indicate that the local caches have been invalidated and that data
needs to be refetched.

But, yes, to actually be safe here, we *also* should be bumping
i_version on DIO write on DIO write completion so that racing
i_version and data reads that occur *after* the initial i_version
bump are invalidated immediately.

IOWs, to avoid getattr/read races missing stale data invalidations
during DIO writes, we really need to bump i_version both _before and
after_ DIO write submission.

It's corner cases like this where "i_version should only be bumped
when ctime changes" fails completely. i.e. there are concurrent IO
situations which can only really be handled correctly by bumping
i_version whenever either in-memory and/or on-disk persistent data/
metadata state changes occur.....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
