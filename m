Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2335E7DD8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 17:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbiIWPFJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 11:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiIWPFH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 11:05:07 -0400
X-Greylist: delayed 327 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 23 Sep 2022 08:05:00 PDT
Received: from mta-102a.earthlink-vadesecure.net (mta-102a.earthlink-vadesecure.net [51.81.61.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAB452FE3;
        Fri, 23 Sep 2022 08:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; bh=N+Y2Asvd9JPiLkBH1FxZjhC7Kvt1Am28CEudYX
 K+k9M=; c=relaxed/relaxed; d=earthlink.net; h=from:reply-to:subject:
 date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:
 references:list-id:list-help:list-unsubscribe:list-subscribe:list-post:
 list-owner:list-archive; q=dns/txt; s=dk12062016; t=1663945138;
 x=1664549938; b=QzIpgTeRhzk+oXAG0w2wXTk3knt7B6hPDgYBU9ZvjKI0wg8sqPEQWaq
 gYfzosQZ/cIs1/vwH3hunDFSzEloIxot7aQ6GlAMW3axqZdwRDbcZgLWVdJHrFVwc5fXxuU
 Pcsfdc8kPelR3ruy9zezXHbqo+aZEcZpKPDyspB1RJOfBlzMphkoI/s6yyuXpGEZUmN0HQu
 xtqzMM2an+D6o9ulXwtv6R/ro4om2RpGMUnUA33qDOTFfeYCLUxojgy5vz8vrg8My0jkRLx
 xUACYrUDkw91O3ZAOmZbMVrAhRXehF3V0zflpsm1oL41wD5r7q4pCMkHy/qEE4K+tId4gYL
 H1g==
Received: from FRANKSTHINKPAD ([76.105.143.216])
 by smtp.earthlink-vadesecure.net ESMTP vsel1nmtao02p with ngmta
 id 22c3a592-17178548f48eb86d; Fri, 23 Sep 2022 14:58:57 +0000
From:   "Frank Filz" <ffilzlnx@mindspring.com>
To:     "'Jeff Layton'" <jlayton@kernel.org>,
        "'Trond Myklebust'" <trondmy@hammerspace.com>, <jack@suse.cz>
Cc:     <zohar@linux.ibm.com>, <djwong@kernel.org>, <brauner@kernel.org>,
        <linux-xfs@vger.kernel.org>, <bfields@fieldses.org>,
        <linux-api@vger.kernel.org>, <neilb@suse.de>,
        <david@fromorbit.com>, <fweimer@redhat.com>,
        <linux-kernel@vger.kernel.org>, <chuck.lever@oracle.com>,
        <linux-man@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
        <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
        <viro@zeniv.linux.org.uk>, <xiubli@redhat.com>,
        <linux-fsdevel@vger.kernel.org>, <adilger.kernel@dilger.ca>,
        <lczerner@redhat.com>, <ceph-devel@vger.kernel.org>,
        <linux-btrfs@vger.kernel.org>
References: <24005713ad25370d64ab5bd0db0b2e4fcb902c1c.camel@kernel.org>         <20220918235344.GH3600936@dread.disaster.area>         <87fb43b117472c0a4c688c37a925ac51738c8826.camel@kernel.org>         <20220920001645.GN3600936@dread.disaster.area>         <5832424c328ea427b5c6ecdaa6dd53f3b99c20a0.camel@kernel.org>         <20220921000032.GR3600936@dread.disaster.area>         <93b6d9f7cf997245bb68409eeb195f9400e55cd0.camel@kernel.org>         <20220921214124.GS3600936@dread.disaster.area>         <e04e349170bc227b330556556d0592a53692b5b5.camel@kernel.org>         <1ef261e3ff1fa7fcd0d75ed755931aacb8062de2.camel@kernel.org>         <20220923095653.5c63i2jgv52j3zqp@quack3>         <2d41c08e1fd96d55c794c3b4cd43a51a0494bfcf.camel@hammerspace.com> <baf852dfb57aaf5a670bc88236f8d62c99668fcc.camel@kernel.org>
In-Reply-To: <baf852dfb57aaf5a670bc88236f8d62c99668fcc.camel@kernel.org>
Subject: RE: [man-pages RFC PATCH v4] statx, inode: document the new STATX_INO_VERSION field
Date:   Fri, 23 Sep 2022 07:58:55 -0700
Message-ID: <01ae01d8cf5d$023474d0$069d5e70$@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQFW5LMVvccUT9xKG5h5MPweA5KIXgISgRYwAs1S4t4CKHGUMgGdhacVAWuMxX0CYnVaogHQtV08AvqrgvECS3OfOAJ2umjmAsymCyIDAUdIdq4SdV6g
Content-Language: en-us
Authentication-Results: earthlink-vadesecure.net;
 auth=pass smtp.auth=ffilzlnx@mindspring.com smtp.mailfrom=ffilzlnx@mindspring.com;
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> -----Original Message-----
> From: Jeff Layton [mailto:jlayton@kernel.org]
> Sent: Friday, September 23, 2022 6:50 AM
> To: Trond Myklebust <trondmy@hammerspace.com>; jack@suse.cz
> Cc: zohar@linux.ibm.com; djwong@kernel.org; brauner@kernel.org; linux-
> xfs@vger.kernel.org; bfields@fieldses.org; linux-api@vger.kernel.org;
> neilb@suse.de; david@fromorbit.com; fweimer@redhat.com; linux-
> kernel@vger.kernel.org; chuck.lever@oracle.com; linux-man@vger.kernel.org;
> linux-nfs@vger.kernel.org; linux-ext4@vger.kernel.org; tytso@mit.edu;
> viro@zeniv.linux.org.uk; xiubli@redhat.com; linux-fsdevel@vger.kernel.org;
> adilger.kernel@dilger.ca; lczerner@redhat.com; ceph-devel@vger.kernel.org;
> linux-btrfs@vger.kernel.org
> Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
> STATX_INO_VERSION field
> 
> On Fri, 2022-09-23 at 13:44 +0000, Trond Myklebust wrote:
> > On Fri, 2022-09-23 at 11:56 +0200, Jan Kara wrote:
> > > On Thu 22-09-22 16:18:02, Jeff Layton wrote:
> > > > On Thu, 2022-09-22 at 06:18 -0400, Jeff Layton wrote:
> > > > > On Thu, 2022-09-22 at 07:41 +1000, Dave Chinner wrote:
> > > > > > e.g. The NFS server can track the i_version values when the
> > > > > > NFSD syncs/commits a given inode. The nfsd can sample
> > > > > > i_version it when calls ->commit_metadata or flushed data on
> > > > > > the inode, and then when it peeks at i_version when gathering
> > > > > > post-op attrs (or any other getattr op) it can decide that
> > > > > > there is too much in-memory change (e.g. 10,000 counts since
> > > > > > last sync) and sync the inode.
> > > > > >
> > > > > > i.e. the NFS server can trivially cap the maximum number of
> > > > > > uncommitted NFS change attr bumps it allows to build up in
> > > > > > memory.
> > > > > > At that point, the NFS server has a bound "maximum write count"
> > > > > > that
> > > > > > can be used in conjunction with the xattr based crash counter
> > > > > > to determine how the change_attr is bumped by the crash
> > > > > > counter.
> > > > >
> > > > > Well, not "trivially". This is the bit where we have to grow
> > > > > struct inode (or the fs-specific inode), as we'll need to know
> > > > > what the latest on-disk value is for the inode.
> > > > >
> > > > > I'm leaning toward doing this on the query side. Basically, when
> > > > > nfsd goes to query the i_version, it'll check the delta between
> > > > > the current version and the latest one on disk. If it's bigger
> > > > > than X then we'd just return NFS4ERR_DELAY to the client.
> > > > >
> > > > > If the delta is >X/2, maybe it can kick off a workqueue job or
> > > > > something that calls write_inode with WB_SYNC_ALL to try to get
> > > > > the thing onto the platter ASAP.
> > > >
> > > > Still looking at this bit too. Probably we can just kick off a
> > > > WB_SYNC_NONE filemap_fdatawrite at that point and hope for the
> > > > best?
> > >
> > > "Hope" is not a great assurance regarding data integrity ;) Anyway,
> > > it depends on how you imagine the "i_version on disk" is going to be
> > > maintained. It could be maintained by NFSD inside
> > > commit_inode_metadata() -
> > > fetch current i_version value before asking filesystem for the sync
> > > and by the time commit_metadata() returns we know that value is on
> > > disk. If we detect the current - on_disk is > X/2, we call
> > > commit_inode_metadata() and we are done. It is not even *that*
> > > expensive because usually filesystems optimize away unnecessary IO
> > > when the inode didn't change since last time it got synced.
> > >
> >
> > Note that these approaches requiring 3rd party help in order to track
> > i_version integrity across filesystem crashes all make the idea of
> > adding i_version to statx() a no-go.
> >
> > It is one thing for knfsd to add specialised machinery for integrity
> > checking, but if all applications need to do so, then they are highly
> > unlikely to want to adopt this attribute.
> >
> >
> 
> Absolutely. That is the downside of this approach, but the priority here
has
> always been to improve nfsd. If we don't get the ability to present this
info via
> statx, then so be it. Later on, I suppose we can move that handling into
the
> kernel in some fashion if we decide it's worthwhile.
> 
> That said, not having this in statx makes it more difficult to test
i_version
> behavior. Maybe we can add a generic ioctl for that in the interim?

Having i_version in statx would be really nice for nfs-ganesha. I would
consider doing the extra integrity stuff or we may in some cases be able to
rely on the filesystem, but in any case, i_version would be an improvement
over using ctime or mtime for a change attribute.

Frank

