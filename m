Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546555BF19C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 02:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbiIUAAs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Sep 2022 20:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbiIUAAn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Sep 2022 20:00:43 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A0F34A137;
        Tue, 20 Sep 2022 17:00:40 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au [49.181.106.210])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 7ED8A8A99A0;
        Wed, 21 Sep 2022 10:00:34 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oanAG-00AByJ-Lc; Wed, 21 Sep 2022 10:00:32 +1000
Date:   Wed, 21 Sep 2022 10:00:32 +1000
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
Message-ID: <20220921000032.GR3600936@dread.disaster.area>
References: <871f9c5153ddfe760854ca31ee36b84655959b83.camel@hammerspace.com>
 <e8922bc821a40f5a3f0a1301583288ed19b6891b.camel@kernel.org>
 <166328063547.15759.12797959071252871549@noble.neil.brown.name>
 <YyQdmLpiAMvl5EkU@mit.edu>
 <7027d1c2923053fe763e9218d10ce8634b56e81d.camel@kernel.org>
 <24005713ad25370d64ab5bd0db0b2e4fcb902c1c.camel@kernel.org>
 <20220918235344.GH3600936@dread.disaster.area>
 <87fb43b117472c0a4c688c37a925ac51738c8826.camel@kernel.org>
 <20220920001645.GN3600936@dread.disaster.area>
 <5832424c328ea427b5c6ecdaa6dd53f3b99c20a0.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5832424c328ea427b5c6ecdaa6dd53f3b99c20a0.camel@kernel.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=OJNEYQWB c=1 sm=1 tr=0 ts=632a5426
        a=j6JUzzrSC7wlfFge/rmVbg==:117 a=j6JUzzrSC7wlfFge/rmVbg==:17
        a=kj9zAlcOel0A:10 a=xOM3xZuef0cA:10 a=7-415B0cAAAA:8
        a=4ZEok6cz2qKiNJG-cq0A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 20, 2022 at 06:26:05AM -0400, Jeff Layton wrote:
> On Tue, 2022-09-20 at 10:16 +1000, Dave Chinner wrote:
> > IOWs, the NFS server can define it's own on-disk persistent metadata
> > using xattrs, and you don't need local filesystems to be modified at
> > all. You can add the crash epoch into the change attr that is sent
> > to NFS clients without having to change the VFS i_version
> > implementation at all.
> > 
> > This whole problem is solvable entirely within the NFS server code,
> > and we don't need to change local filesystems at all. NFS can
> > control the persistence and format of the xattrs it uses, and it
> > does not need new custom on-disk format changes from every
> > filesystem to support this new application requirement.
> > 
> > At this point, NFS server developers don't need to care what the
> > underlying filesystem format provides - the xattrs provide the crash
> > detection and enumeration the NFS server functionality requires.
> > 
> 
> Doesn't the filesystem already detect when it's been mounted after an
> unclean shutdown?

Not every filesystem will be able to guarantee unclean shutdown
detection at the next mount. That's the whole problem - NFS
developers are asking for something that cannot be provided as
generic functionality by individual filesystems, so the NFS server
application is going to have to work around any filesytem that
cannot provide the information it needs.

e.g. ext4 has it journal replayed by the userspace tools prior
to mount, so when it then gets mounted by the kernel it's seen as a
clean mount.

If we shut an XFS filesystem down due to a filesystem corruption or
failed IO to the journal code, the kernel might not be able to
replay the journal on mount (i.e. it is corrupt).  We then run
xfs_repair, and that fixes the corruption issue and -cleans the
log-. When we next mount the filesystem, it results in a _clean
mount_, and the kernel filesystem code can not signal to NFS that an
unclean mount occurred and so it should bump it's crash counter.

IOWs, this whole "filesystems need to tell NFS about crashes"
propagates all the way through *every filesystem tool chain*, not
just the kernel mount code. And we most certainly don't control
every 3rd party application that walks around in the filesystem on
disk format, and so there are -zero- guarantees that the kernel
filesystem mount code can give that an unclean shutdown occurred
prior to the current mount.

And then for niche NFS server applications (like transparent
fail-over between HA NFS servers) there are even more rigid
constraints on NFS change attributes. And you're asking local
filesystems to know about these application constraints and bake
them into their on-disk format again.

This whole discussion has come about because we baked certain
behaviour for NFS into the on-disk format many, many years ago, and
it's only now that it is considered inadequate for *new* NFS
application related functionality (e.g. fscache integration and
cache validity across server side mount cycles).

We've learnt a valuable lesson from this: don't bake application
specific persistent metadata requirements into the on-disk format
because when the application needs to change, it requires every
filesystem that supports taht application level functionality
to change their on-disk formats...

> I'm not sure what good we'll get out of bolting this
> scheme onto the NFS server, when the filesystem could just as easily
> give us this info.

The xattr scheme guarantees the correct application behaviour that the NFS
server requires, all at the NFS application level without requiring
local filesystems to support the NFS requirements in their on-disk
format. THe NFS server controls the format and versioning of it's
on-disk persistent metadata (i.e. the xattrs it uses) and so any
changes to the application level requirements of that functionality
are now completely under the control of the application.

i.e. the application gets to manage version control, backwards and
forwards compatibility of it's persistent metadata, etc. What you
are asking is that every local filesystem takes responsibility for
managing the long term persistent metadata that only NFS requires.
It's more complex to do this at the filesystem level, and we have to
replicate the same work for every filesystem that is going to
support this on-disk functionality.

Using xattrs means the functionality is implemented once, it's
common across all local filesystems, and no exportable filesystem
needs to know anything about it as it's all self-contained in the
NFS server code. THe code is smaller, easier to maintain, consistent
across all systems, easy to test, etc.

It also can be implemented and rolled out *immediately* to all
existing supported NFS server implementations, without having to
wait months/years (or never!) for local filesystem on-disk format
changes to roll out to production systems.

Asking individual filesystems to implement application specific
persistent metadata is a *last resort* and should only be done if
correctness or performance cannot be obtained in any other way.

So, yeah, the only sane direction to take here is to use xattrs to
store this NFS application level information. It's less work for
everyone, and in the long term it means when the NFS application
requirements change again, we don't need to modify the on-disk
format of multiple local filesystems.

> In any case, the main problem at this point is not so much in detecting
> when there has been an unclean shutdown, but rather what to do when
> there is one. We need to to advance the presented change attributes
> beyond the largest possible one that may have been handed out prior to
> the crash. 

Sure, but you're missing my point: by using xattrs for detection,
you don't need to involve anything to do with local filesystems at
all.

> How do we determine what that offset should be? Your last email
> suggested that there really is no limit to the number of i_version bumps
> that can happen in memory before one of them makes it to disk. What can
> we do to address that?

<shrug>

I'm just pointing out problems I see when defining this as behaviour
for on-disk format purposes. If we define it as part of the on-disk
format, then we have to be concerned about how it may be used
outside the scope of just the NFS server application. 

However, If NFS keeps this metadata and functionaly entirely
contained at the application level via xattrs, I really don't care
what algorithm NFS developers decides to use for their crash
sequencing. It's not my concern at this point, and that's precisely
why NFS should be using xattrs for this NFS specific functionality.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
