Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3EA95BD8AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Sep 2022 02:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiITAQz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 20:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiITAQx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 20:16:53 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6483E45040;
        Mon, 19 Sep 2022 17:16:52 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-183-60.pa.nsw.optusnet.com.au [49.180.183.60])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 26A048AA16C;
        Tue, 20 Sep 2022 10:16:47 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oaQwP-009ndF-PX; Tue, 20 Sep 2022 10:16:45 +1000
Date:   Tue, 20 Sep 2022 10:16:45 +1000
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
Message-ID: <20220920001645.GN3600936@dread.disaster.area>
References: <0646410b6d2a5d19d3315f339b2928dfa9f2d922.camel@hammerspace.com>
 <34e91540c92ad6980256f6b44115cf993695d5e1.camel@kernel.org>
 <871f9c5153ddfe760854ca31ee36b84655959b83.camel@hammerspace.com>
 <e8922bc821a40f5a3f0a1301583288ed19b6891b.camel@kernel.org>
 <166328063547.15759.12797959071252871549@noble.neil.brown.name>
 <YyQdmLpiAMvl5EkU@mit.edu>
 <7027d1c2923053fe763e9218d10ce8634b56e81d.camel@kernel.org>
 <24005713ad25370d64ab5bd0db0b2e4fcb902c1c.camel@kernel.org>
 <20220918235344.GH3600936@dread.disaster.area>
 <87fb43b117472c0a4c688c37a925ac51738c8826.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fb43b117472c0a4c688c37a925ac51738c8826.camel@kernel.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=63290673
        a=mj5ET7k2jFntY++HerHxfg==:117 a=mj5ET7k2jFntY++HerHxfg==:17
        a=kj9zAlcOel0A:10 a=xOM3xZuef0cA:10 a=7-415B0cAAAA:8
        a=PBuYFrC3Npbnkw49Qb4A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 19, 2022 at 09:13:00AM -0400, Jeff Layton wrote:
> On Mon, 2022-09-19 at 09:53 +1000, Dave Chinner wrote:
> > On Fri, Sep 16, 2022 at 11:11:34AM -0400, Jeff Layton wrote:
> > > On Fri, 2022-09-16 at 07:36 -0400, Jeff Layton wrote:
> > > > On Fri, 2022-09-16 at 02:54 -0400, Theodore Ts'o wrote:
> > > > > On Fri, Sep 16, 2022 at 08:23:55AM +1000, NeilBrown wrote:
> > > > > > > > If the answer is that 'all values change', then why store the crash
> > > > > > > > counter in the inode at all? Why not just add it as an offset when
> > > > > > > > you're generating the user-visible change attribute?
> > > > > > > > 
> > > > > > > > i.e. statx.change_attr = inode->i_version + (crash counter * offset)
> > > > > 
> > > > > I had suggested just hashing the crash counter with the file system's
> > > > > on-disk i_version number, which is essentially what you are suggested.
> > > > > 
> > > > > > > Yes, if we plan to ensure that all the change attrs change after a
> > > > > > > crash, we can do that.
> > > > > > > 
> > > > > > > So what would make sense for an offset? Maybe 2**12? One would hope that
> > > > > > > there wouldn't be more than 4k increments before one of them made it to
> > > > > > > disk. OTOH, maybe that can happen with teeny-tiny writes.
> > > > > > 
> > > > > > Leave it up the to filesystem to decide.  The VFS and/or NFSD should
> > > > > > have not have part in calculating the i_version.  It should be entirely
> > > > > > in the filesystem - though support code could be provided if common
> > > > > > patterns exist across filesystems.
> > > > > 
> > > > > Oh, *heck* no.  This parameter is for the NFS implementation to
> > > > > decide, because it's NFS's caching algorithms which are at stake here.
> > > > > 
> > > > > As a the file system maintainer, I had offered to make an on-disk
> > > > > "crash counter" which would get updated when the journal had gotten
> > > > > replayed, in addition to the on-disk i_version number.  This will be
> > > > > available for the Linux implementation of NFSD to use, but that's up
> > > > > to *you* to decide how you want to use them.
> > > > > 
> > > > > I was perfectly happy with hashing the crash counter and the i_version
> > > > > because I had assumed that not *that* much stuff was going to be
> > > > > cached, and so invalidating all of the caches in the unusual case
> > > > > where there was a crash was acceptable.  After all it's a !@#?!@
> > > > > cache.  Caches sometimmes get invalidated.  "That is the order of
> > > > > things." (as Ramata'Klan once said in "Rocks and Shoals")
> > > > > 
> > > > > But if people expect that multiple TB's of data is going to be stored;
> > > > > that cache invalidation is unacceptable; and that a itsy-weeny chance
> > > > > of false negative failures which might cause data corruption might be
> > > > > acceptable tradeoff, hey, that's for the system which is providing
> > > > > caching semantics to determine.
> > > > > 
> > > > > PLEASE don't put this tradeoff on the file system authors; I would
> > > > > much prefer to leave this tradeoff in the hands of the system which is
> > > > > trying to do the caching.
> > > > > 
> > > > 
> > > > Yeah, if we were designing this from scratch, I might agree with leaving
> > > > more up to the filesystem, but the existing users all have pretty much
> > > > the same needs. I'm going to plan to try to keep most of this in the
> > > > common infrastructure defined in iversion.h.
> > > > 
> > > > Ted, for the ext4 crash counter, what wordsize were you thinking? I
> > > > doubt we'll be able to use much more than 32 bits so a larger integer is
> > > > probably not worthwhile. There are several holes in struct super_block
> > > > (at least on x86_64), so adding this field to the generic structure
> > > > needn't grow it.
> > > 
> > > That said, now that I've taken a swipe at implementing this, I need more
> > > information than just the crash counter. We need to multiply the crash
> > > counter with a reasonable estimate of the maximum number of individual
> > > writes that could occur between an i_version being incremented and that
> > > value making it to the backing store.
> > > 
> > > IOW, given a write that bumps the i_version to X, how many more write
> > > calls could race in before X makes it to the platter? I took a SWAG and
> > > said 4k in an earlier email, but I don't really have a way to know, and
> > > that could vary wildly with different filesystems and storage.
> > > 
> > > What I'd like to see is this in struct super_block:
> > > 
> > > 	u32		s_version_offset;
> > 
> > 	u64		s_version_salt;
> > 
> 
> IDK...it _is_ an offset since we're folding it in with addition, and it
> has a real meaning. Filesystems do need to be cognizant of that fact, I
> think.
> 
> Also does anyone have a preference on doing this vs. a get_version_salt
> or get_version_offset sb operation? I figured the value should be mostly
> static so it'd be nice to avoid an operation for it.
> 
> > > ...and then individual filesystems can calculate:
> > > 
> > > 	crash_counter * max_number_of_writes
> > > 
> > > and put the correct value in there at mount time.
> > 
> > Other filesystems might not have a crash counter but have other
> > information that can be substituted, like a mount counter or a
> > global change sequence number that is guaranteed to increment from
> > one mount to the next. 
> > 
> 
> The problem there is that you're going to cause the invalidation of all
> of the NFS client's cached regular files, even on clean server reboots.
> That's not a desirable outcome.

Stop saying "anything less than perfect is unacceptible". I *know*
that changing the salt on every mount might result in less than
perfect results, but the fact is that a -false negative- is a data
corruption event, whilst a false positive is not. False positives
may not be desirable, but false negatives are *not acceptible at
all*.

XFS can give you a guarantee of no false negatives right now with no
on-disk format changes necessary, but it comes with the downside of
false positives. That's not the end of the world, and it gives NFS
the functionality it needs immediately and allows us time to add
purpose-built on-disk functionality that gives NFS exactly what it
wants. The reality is that this purpose-built on-disk change will
take years to roll out to production systems, whilst using what we
have now is just a kernel patch and upgrade away....

Changing on-disk metadata formats takes time, no matter how simple
the change, and this timeframe is not something the NFS server
actually controls.

But there is a way for the NFS server to define and control it's own
on-disk persistent metadata: *extended attributes*.

How about we set a "crash" extended attribute on the root of an NFS
export when the filesystem is exported, and then remove it when the
filesystem is unexported.

This gives the NFS server it's own persistent attribute that tells
it whether the filesystem was *unexported* cleanly. If the exportfs
code calls syncfs() before the xattr is removed, then it guarantees
that everything the NFS clients have written and modified will be
exactly present the next time the filesystem is exported. If the
"crash" xattr is present when the filesystem is exported, then it
wasn't cleanly synced before it was taken out of service, and so
something may have been lost and the "crash counter" needs to be
bumped.

Yes, the "crash counter" is held in another xattr, so that it is
persistent across crash and mount/unmount cycles. If the crash
xattr is present, the NFSD reads, bumps and writes the crash counter
xattr, and uses the new value for the life of that export. If the
crash xattr is not present, then is just reads the counter xattr and
uses it unchanged.

IOWs, the NFS server can define it's own on-disk persistent metadata
using xattrs, and you don't need local filesystems to be modified at
all. You can add the crash epoch into the change attr that is sent
to NFS clients without having to change the VFS i_version
implementation at all.

This whole problem is solvable entirely within the NFS server code,
and we don't need to change local filesystems at all. NFS can
control the persistence and format of the xattrs it uses, and it
does not need new custom on-disk format changes from every
filesystem to support this new application requirement.

At this point, NFS server developers don't need to care what the
underlying filesystem format provides - the xattrs provide the crash
detection and enumeration the NFS server functionality requires.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
