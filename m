Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38D35BC0B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Sep 2022 01:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiIRXxx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Sep 2022 19:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiIRXxw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Sep 2022 19:53:52 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A6D2D13CD7;
        Sun, 18 Sep 2022 16:53:50 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-149-49.pa.vic.optusnet.com.au [49.186.149.49])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id B1B9B8A9D52;
        Mon, 19 Sep 2022 09:53:46 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oa46a-009Oeo-7b; Mon, 19 Sep 2022 09:53:44 +1000
Date:   Mon, 19 Sep 2022 09:53:44 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, NeilBrown <neilb@suse.de>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-man@vger.kernel.org" <linux-man@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "xiubli@redhat.com" <xiubli@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "lczerner@redhat.com" <lczerner@redhat.com>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
Message-ID: <20220918235344.GH3600936@dread.disaster.area>
References: <577b6d8a7243aeee37eaa4bbb00c90799586bc48.camel@hammerspace.com>
 <1a968b8e87f054e360877c9ab8cdfc4cfdfc8740.camel@kernel.org>
 <0646410b6d2a5d19d3315f339b2928dfa9f2d922.camel@hammerspace.com>
 <34e91540c92ad6980256f6b44115cf993695d5e1.camel@kernel.org>
 <871f9c5153ddfe760854ca31ee36b84655959b83.camel@hammerspace.com>
 <e8922bc821a40f5a3f0a1301583288ed19b6891b.camel@kernel.org>
 <166328063547.15759.12797959071252871549@noble.neil.brown.name>
 <YyQdmLpiAMvl5EkU@mit.edu>
 <7027d1c2923053fe763e9218d10ce8634b56e81d.camel@kernel.org>
 <24005713ad25370d64ab5bd0db0b2e4fcb902c1c.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24005713ad25370d64ab5bd0db0b2e4fcb902c1c.camel@kernel.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=6327af8e
        a=XTRC1Ovx3SkpaCW1YxGVGA==:117 a=XTRC1Ovx3SkpaCW1YxGVGA==:17
        a=kj9zAlcOel0A:10 a=xOM3xZuef0cA:10 a=7-415B0cAAAA:8
        a=OM9ssF-cS7fGoRW40zoA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 16, 2022 at 11:11:34AM -0400, Jeff Layton wrote:
> On Fri, 2022-09-16 at 07:36 -0400, Jeff Layton wrote:
> > On Fri, 2022-09-16 at 02:54 -0400, Theodore Ts'o wrote:
> > > On Fri, Sep 16, 2022 at 08:23:55AM +1000, NeilBrown wrote:
> > > > > > If the answer is that 'all values change', then why store the crash
> > > > > > counter in the inode at all? Why not just add it as an offset when
> > > > > > you're generating the user-visible change attribute?
> > > > > > 
> > > > > > i.e. statx.change_attr = inode->i_version + (crash counter * offset)
> > > 
> > > I had suggested just hashing the crash counter with the file system's
> > > on-disk i_version number, which is essentially what you are suggested.
> > > 
> > > > > Yes, if we plan to ensure that all the change attrs change after a
> > > > > crash, we can do that.
> > > > > 
> > > > > So what would make sense for an offset? Maybe 2**12? One would hope that
> > > > > there wouldn't be more than 4k increments before one of them made it to
> > > > > disk. OTOH, maybe that can happen with teeny-tiny writes.
> > > > 
> > > > Leave it up the to filesystem to decide.  The VFS and/or NFSD should
> > > > have not have part in calculating the i_version.  It should be entirely
> > > > in the filesystem - though support code could be provided if common
> > > > patterns exist across filesystems.
> > > 
> > > Oh, *heck* no.  This parameter is for the NFS implementation to
> > > decide, because it's NFS's caching algorithms which are at stake here.
> > > 
> > > As a the file system maintainer, I had offered to make an on-disk
> > > "crash counter" which would get updated when the journal had gotten
> > > replayed, in addition to the on-disk i_version number.  This will be
> > > available for the Linux implementation of NFSD to use, but that's up
> > > to *you* to decide how you want to use them.
> > > 
> > > I was perfectly happy with hashing the crash counter and the i_version
> > > because I had assumed that not *that* much stuff was going to be
> > > cached, and so invalidating all of the caches in the unusual case
> > > where there was a crash was acceptable.  After all it's a !@#?!@
> > > cache.  Caches sometimmes get invalidated.  "That is the order of
> > > things." (as Ramata'Klan once said in "Rocks and Shoals")
> > > 
> > > But if people expect that multiple TB's of data is going to be stored;
> > > that cache invalidation is unacceptable; and that a itsy-weeny chance
> > > of false negative failures which might cause data corruption might be
> > > acceptable tradeoff, hey, that's for the system which is providing
> > > caching semantics to determine.
> > > 
> > > PLEASE don't put this tradeoff on the file system authors; I would
> > > much prefer to leave this tradeoff in the hands of the system which is
> > > trying to do the caching.
> > > 
> > 
> > Yeah, if we were designing this from scratch, I might agree with leaving
> > more up to the filesystem, but the existing users all have pretty much
> > the same needs. I'm going to plan to try to keep most of this in the
> > common infrastructure defined in iversion.h.
> > 
> > Ted, for the ext4 crash counter, what wordsize were you thinking? I
> > doubt we'll be able to use much more than 32 bits so a larger integer is
> > probably not worthwhile. There are several holes in struct super_block
> > (at least on x86_64), so adding this field to the generic structure
> > needn't grow it.
> 
> That said, now that I've taken a swipe at implementing this, I need more
> information than just the crash counter. We need to multiply the crash
> counter with a reasonable estimate of the maximum number of individual
> writes that could occur between an i_version being incremented and that
> value making it to the backing store.
> 
> IOW, given a write that bumps the i_version to X, how many more write
> calls could race in before X makes it to the platter? I took a SWAG and
> said 4k in an earlier email, but I don't really have a way to know, and
> that could vary wildly with different filesystems and storage.
> 
> What I'd like to see is this in struct super_block:
> 
> 	u32		s_version_offset;

	u64		s_version_salt;

> ...and then individual filesystems can calculate:
> 
> 	crash_counter * max_number_of_writes
> 
> and put the correct value in there at mount time.

Other filesystems might not have a crash counter but have other
information that can be substituted, like a mount counter or a
global change sequence number that is guaranteed to increment from
one mount to the next. 

Further, have you thought about what "max number of writes" might
be in ten years time? e.g.  what happens if a filesysetm as "max
number of writes" being greater than 2^32? I mean, we already have
machines out there running Linux with 64-128TB of physical RAM, so
it's already practical to hold > 2^32 individual writes to a single
inode that each bump i_version in memory....

So when we consider this sort of scale, the "crash counter * max
writes" scheme largely falls apart because "max writes" is a really
large number to begin with. We're going to be stuck with whatever
algorithm is decided on for the foreseeable future, so we must
recognise that _we've already overrun 32 bit counter schemes_ in
terms of tracking "i_version changes in memory vs what we have on
disk".

Hence I really think that we should be leaving the implementation of
the salt value to the individual filesysetms as different
filesytsems are aimed at different use cases and so may not
necessarily have to all care about the same things (like 2^32 bit
max write overruns).  All the high level VFS code then needs to do
is add the two together:

	statx.change_attr = inode->i_version + sb->s_version_salt;

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
