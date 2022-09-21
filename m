Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8735E5551
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 23:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbiIUVld (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 17:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiIUVlb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 17:41:31 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 02665A61F1;
        Wed, 21 Sep 2022 14:41:29 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au [49.181.106.210])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id CD09A1100972;
        Thu, 22 Sep 2022 07:41:25 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ob7TA-00AY5T-EA; Thu, 22 Sep 2022 07:41:24 +1000
Date:   Thu, 22 Sep 2022 07:41:24 +1000
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
Message-ID: <20220921214124.GS3600936@dread.disaster.area>
References: <166328063547.15759.12797959071252871549@noble.neil.brown.name>
 <YyQdmLpiAMvl5EkU@mit.edu>
 <7027d1c2923053fe763e9218d10ce8634b56e81d.camel@kernel.org>
 <24005713ad25370d64ab5bd0db0b2e4fcb902c1c.camel@kernel.org>
 <20220918235344.GH3600936@dread.disaster.area>
 <87fb43b117472c0a4c688c37a925ac51738c8826.camel@kernel.org>
 <20220920001645.GN3600936@dread.disaster.area>
 <5832424c328ea427b5c6ecdaa6dd53f3b99c20a0.camel@kernel.org>
 <20220921000032.GR3600936@dread.disaster.area>
 <93b6d9f7cf997245bb68409eeb195f9400e55cd0.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93b6d9f7cf997245bb68409eeb195f9400e55cd0.camel@kernel.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=OJNEYQWB c=1 sm=1 tr=0 ts=632b8509
        a=j6JUzzrSC7wlfFge/rmVbg==:117 a=j6JUzzrSC7wlfFge/rmVbg==:17
        a=kj9zAlcOel0A:10 a=xOM3xZuef0cA:10 a=7-415B0cAAAA:8
        a=8pfsZ2Olh1enfcy7SOgA:9 a=CjuIK1q_8ugA:10 a=Fg_2k2EkwPauNWe-Eirz:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 21, 2022 at 06:33:28AM -0400, Jeff Layton wrote:
> On Wed, 2022-09-21 at 10:00 +1000, Dave Chinner wrote:
> > > How do we determine what that offset should be? Your last email
> > > suggested that there really is no limit to the number of i_version bumps
> > > that can happen in memory before one of them makes it to disk. What can
> > > we do to address that?
> > 
> > <shrug>
> > 
> > I'm just pointing out problems I see when defining this as behaviour
> > for on-disk format purposes. If we define it as part of the on-disk
> > format, then we have to be concerned about how it may be used
> > outside the scope of just the NFS server application. 
> > 
> > However, If NFS keeps this metadata and functionaly entirely
> > contained at the application level via xattrs, I really don't care
> > what algorithm NFS developers decides to use for their crash
> > sequencing. It's not my concern at this point, and that's precisely
> > why NFS should be using xattrs for this NFS specific functionality.
> > 
> 
> I get it: you'd rather not have to deal with what you see as an NFS
> problem, but I don't get how what you're proposing solves anything. We
> might be able to use that scheme to detect crashes, but that's only part
> of the problem (and it's a relatively simple part of the problem to
> solve, really).
> 
> Maybe you can clarify it for me:
> 
> Suppose we go with what you're saying and store some information in
> xattrs that allows us to detect crashes in some fashion. The server
> crashes and comes back up and we detect that there was a crash earlier.
> 
> What does nfsd need to do now to ensure that it doesn't hand out a
> duplicate change attribute? 

As I've already stated, the NFS server can hold the persistent NFS
crash counter value in a second xattr that it bumps whenever it
detects a crash and hence we take the local filesystem completely
out of the equation.  How the crash counter is then used by the nfsd
to fold it into the NFS protocol change attribute is a nfsd problem,
not a local filesystem problem.

If you're worried about maximum number of writes outstanding vs
i_version bumps that are held in memory, then *bound the maximum
number of uncommitted i_version changes that the NFS server will
allow to build up in memory*. By moving the crash counter to being a
NFS server only function, the NFS server controls the entire
algorithm and it doesn't have to care about external 3rd party
considerations like local filesystems have to.

e.g. The NFS server can track the i_version values when the NFSD
syncs/commits a given inode. The nfsd can sample i_version it when
calls ->commit_metadata or flushed data on the inode, and then when
it peeks at i_version when gathering post-op attrs (or any other
getattr op) it can decide that there is too much in-memory change
(e.g. 10,000 counts since last sync) and sync the inode.

i.e. the NFS server can trivially cap the maximum number of
uncommitted NFS change attr bumps it allows to build up in memory.
At that point, the NFS server has a bound "maximum write count" that
can be used in conjunction with the xattr based crash counter to
determine how the change_attr is bumped by the crash counter.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
