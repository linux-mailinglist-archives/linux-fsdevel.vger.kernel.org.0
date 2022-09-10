Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3E95B4639
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Sep 2022 14:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiIJMjO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Sep 2022 08:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiIJMjN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Sep 2022 08:39:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED5050733;
        Sat, 10 Sep 2022 05:39:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6DE86B8015A;
        Sat, 10 Sep 2022 12:39:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F262CC433C1;
        Sat, 10 Sep 2022 12:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662813549;
        bh=YEIyo7RacOHHBv5MZ/Zxo+peFx28TliU4poZd6BIhFw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=OURJ3wvvhgmeJoQrcI7pZXVVcl8CFcVGSjg1lTrXevGd51Q4niTWjzEVQef7pwvrZ
         495e/ViX+gkvMLYNvZ/WCRZKxCD9/Vyg7mzuKam82hHXXqk8w15agsJmN8Lj7Jrydt
         pdMI+NttabnrETc2QH+DGeSCKbUBNRQIcQy1IGB6nyT8ols7VOPv+x7AyJsRIfL2ir
         sCsk1ls1jalCKHUnEB0nqr5Rhfl9hXWwKOILNQr+e4fv2R76WrmXbaeZ6SHWyEB8gf
         /yPmA40rLjEl6qRKlaQvRg01G1k04HI0qq2xj2g8NdnuLkstPVaKIDSlzBb/F8y1O7
         CZJMOvB1INsxg==
Message-ID: <33d058be862ccc0ccaf959f2841a7e506e51fd1f.camel@kernel.org>
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>,
        Trond Myklebust <trondmy@hammerspace.com>
Cc:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "xiubli@redhat.com" <xiubli@redhat.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
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
Date:   Sat, 10 Sep 2022 08:39:05 -0400
In-Reply-To: <166270570118.30452.16939807179630112340@noble.neil.brown.name>
References: <20220907111606.18831-1-jlayton@kernel.org>
         , <166255065346.30452.6121947305075322036@noble.neil.brown.name>
         , <79aaf122743a295ddab9525d9847ac767a3942aa.camel@kernel.org>
         , <20220907125211.GB17729@fieldses.org>
         , <771650a814ab1ff4dc5473d679936b747d9b6cf5.camel@kernel.org>
         , <20220907135153.qvgibskeuz427abw@quack3>
         , <166259786233.30452.5417306132987966849@noble.neil.brown.name>
         , <20220908083326.3xsanzk7hy3ff4qs@quack3>, <YxoIjV50xXKiLdL9@mit.edu>
         , <02928a8c5718590bea5739b13d6b6ebe66cac577.camel@kernel.org>
         , <166267775728.30452.17640919701924887771@noble.neil.brown.name>
         , <91e31d20d66d6f47fe12c80c34b1cffdfc202b6a.camel@hammerspace.com>
         , <166268467103.30452.1687952324107257676@noble.neil.brown.name>
         , <166268566751.30452.13562507405746100242@noble.neil.brown.name>
         , <29a6c2e78284e7947ddedf71e5cb9436c9330910.camel@hammerspace.com>
         , <8d638cb3c63b0d2da8679b5288d1622fdb387f83.camel@hammerspace.com>
         <166270570118.30452.16939807179630112340@noble.neil.brown.name>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2022-09-09 at 16:41 +1000, NeilBrown wrote:
> > On Fri, 09 Sep 2022, Trond Myklebust wrote:
> > > > On Fri, 2022-09-09 at 01:10 +0000, Trond Myklebust wrote:
> > > > > > On Fri, 2022-09-09 at 11:07 +1000, NeilBrown wrote:
> > > > > > > > On Fri, 09 Sep 2022, NeilBrown wrote:
> > > > > > > > > > On Fri, 09 Sep 2022, Trond Myklebust wrote:
> > > > > > > > > >=20
> > > > > > > > > > > >=20
> > > > > > > > > > > > IOW: the minimal condition needs to be that for all=
 cases
> > > > > > > > > > > > below,
> > > > > > > > > > > > the
> > > > > > > > > > > > application reads 'state B' as having occurred if a=
ny data was
> > > > > > > > > > > > committed to disk before the crash.
> > > > > > > > > > > >=20
> > > > > > > > > > > > Application=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0Filesystem
> > > > > > > > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > > > > > > > > > > > read change attr <- 'state A'
> > > > > > > > > > > > read data <- 'state A'
> > > > > > > > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0write =
data -> 'state B'
> > > > > > > > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0<crash=
>+<reboot>
> > > > > > > > > > > > read change attr <- 'state B'
> > > > > > > > > >=20
> > > > > > > > > > The important thing here is to not see 'state A'.=A0 Se=
eing 'state
> > > > > > > > > > C'
> > > > > > > > > > should be acceptable.=A0 Worst case we could merge in w=
all-clock
> > > > > > > > > > time
> > > > > > > > > > of
> > > > > > > > > > system boot, but the filesystem should be able to be mo=
re helpful
> > > > > > > > > > than
> > > > > > > > > > that.
> > > > > > > > > >=20
> > > > > > > >=20
> > > > > > > > Actually, without the crash+reboot it would still be accept=
able to
> > > > > > > > see
> > > > > > > > "state A" at the end there - but preferably not for long.
> > > > > > > > From the NFS perspective, the changeid needs to update by t=
he time
> > > > > > > > of
> > > > > > > > a
> > > > > > > > close or unlock (so it is visible to open or lock), but bef=
ore that
> > > > > > > > it
> > > > > > > > is just best-effort.
> > > > > >=20
> > > > > > Nope. That will inevitably lead to data corruption, since the
> > > > > > application might decide to use the data from state A instead o=
f
> > > > > > revalidating it.
> > > > > >=20
> > > >=20
> > > > The point is, NFS is not the only potential use case for change
> > > > attributes. We wouldn't be bothering to discuss statx() if it was.
> >=20
> > My understanding is that it was primarily a desire to add fstests to
> > exercise the i_version which motivated the statx extension.
> > Obviously we should prepare for other uses though.
> >=20

Mainly. Also, userland nfs servers might also like this for obvious
reasons. For now though, in the v5 set, I've backed off on trying to
expose this to userland in favor of trying to just clean up the internal
implementation.

I'd still like to expose this via statx if possible, but I don't want to
get too bogged down in interface design just now as we have Real Bugs to
fix. That patchset should make it simple to expose it later though.

> > > >=20
> > > > I could be using O_DIRECT, and all the tricks in order to ensure
> > > > that
> > > > my stock broker application (to choose one example) has access
> > > > to the
> > > > absolute very latest prices when I'm trying to execute a trade.
> > > > When the filesystem then says 'the prices haven't changed since
> > > > your
> > > > last read because the change attribute on the database file is
> > > > the
> > > > same' in response to a statx() request with the
> > > > AT_STATX_FORCE_SYNC
> > > > flag set, then why shouldn't my application be able to assume it
> > > > can
> > > > serve those prices right out of memory instead of having to go
> > > > to disk?
> >=20
> > I would think that such an application would be using inotify rather
> > than having to poll.  But certainly we should have a clear statement
> > of
> > quality-of-service parameters in the documentation.
> > If we agree that perfect atomicity is what we want to promise, and
> > that
> > the cost to the filesystem and the statx call is acceptable, then so
> > be it.
> >=20
> > My point wasn't to say that atomicity is bad.  It was that:
> > =A0- if the i_version change is visible before the change itself is
> > =A0=A0=A0visible, then that is a correctness problem.
> > =A0- if the i_version change is only visible some time after the
> > change
> > =A0=A0=A0itself is visible, then that is a quality-of-service issue.
> > I cannot see any room for debating the first.  I do see some room to
> > debate the second.
> >=20
> > Cached writes, directory ops, and attribute changes are, I think,
> > easy
> > enough to provide truly atomic i_version updates with the change
> > being
> > visible.
> >=20
> > Changes to a shared memory-mapped files is probably the hardest to
> > provide timely i_version updates for.  We might want to document an
> > explicit exception for those.  Alternately each request for
> > i_version
> > would need to find all pages that are writable, remap them read-only
> > to
> > catch future writes, then update i_version if any were writable
> > (i.e.
> > ->mkwrite had been called).  That is the only way I can think of to
> > provide atomicity.
> >=20

I don't think we really want to make i_version bumps that expensive.
Documenting that you can't expect perfect consistency vs. mmap with NFS
seems like the best thing to do. We do our best, but that sort of
synchronization requires real locking.

> > O_DIRECT writes are a little easier than mmapped files.  I suspect we
> > should update the i_version once the device reports that the write is
> > complete, but a parallel reader could have seem some of the write befor=
e
> > that moment.  True atomicity could only be provided by taking some
> > exclusive lock that blocked all O_DIRECT writes.  Jeff seems to be
> > suggesting this, but I doubt the stock broker application would be
> > willing to make the call in that case.  I don't think I would either.

Well, only blocked for long enough to run the getattr. Granted, with a
slow underlying filesystem that can take a while.

To summarize, there are two main uses for the change attr in NFSv4:

1/ to provide change_info4 for directory morphing operations (CREATE,
LINK, OPEN, REMOVE, and RENAME). It turns out that this is already
atomic in the current nfsd code (AFAICT) by virtue of the fact that we
hold the i_rwsem exclusively over these operations. The change attr is
also queried pre and post while the lock is held, so that should ensure
that we get true atomicity for this.

2/ as an adjunct for the ctime when fetching attributes to validate
caches. We don't expect perfect consistency between read (and readlike)
operations and GETATTR, even when they're in the same compound.

IOW, a READ+GETATTR compound can legally give you a short (or zero-
length) read, and then the getattr indicates a size that is larger than
where the READ data stops, due to a write or truncate racing in after
the read.

Ideally, the attributes in the GETATTR reply should be consistent
between themselves though. IOW, all of the attrs should accurately
represent the state of the file at a single point in time.
change+size+times+etc. should all be consistent with one another.

I think we get all of this by taking the inode_lock around the
vfs_getattr call in nfsd4_encode_fattr. It may not be the most elegant
solution, but it should give us the atomicity we need, and it doesn't
require adding extra operations or locking to the write codepaths.

We could also consider less invasive ways to achieve this (maybe some
sort of seqretry loop around the vfs_getattr call?), but I'd rather not
do extra work in the write codepaths if we can get away with it.
--=20
Jeff Layton <jlayton@kernel.org>

