Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5601B5B7A6D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Sep 2022 21:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbiIMTDM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Sep 2022 15:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbiIMTCw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Sep 2022 15:02:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF7FC14;
        Tue, 13 Sep 2022 12:01:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8C2C9B80E42;
        Tue, 13 Sep 2022 19:01:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10AB1C433D7;
        Tue, 13 Sep 2022 19:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663095714;
        bh=9RF+0QcN+/pFpwRf+wXoUfwGV4Go/AvHmZuDiCUBtos=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=jwNv0SFF66fyyctsd1g0W7h20TEcG82c6vvY8Ouen4mrnjIpHOAxVlmN20hbS/6Sz
         Dh8zRrmmgBnfbwRXOwU6TYAx6d3YK2fb0bSTmixanvDQuVXis4t36z65l1ZeQ5QaQu
         JU4tf6dxt7MTV3dk2UYmJUtlgAlEc0j9aJ9FLq4j3+Pd2nindU/IIQ98faH5JmgmtK
         MRqDEhUshRzj4xZjoN2im0finwnosO9W+9m8lTgLeFmpR+Bg4bym25ZyGxqXbUWJly
         7jhMtKYtgKX71HUUiCjyFGzF2te1PC19K+O7zncdXoG8I+lfn0S4AqAtO2fjx7S82N
         IrMLYxA0GvRag==
Message-ID: <b67fe8b26977dc1213deb5ec815a53a26d31fbc0.camel@kernel.org>
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
From:   Jeff Layton <jlayton@kernel.org>
To:     Dave Chinner <david@fromorbit.com>, NeilBrown <neilb@suse.de>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
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
Date:   Tue, 13 Sep 2022 15:01:50 -0400
In-Reply-To: <20220913011518.GE3600936@dread.disaster.area>
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
         <20220913011518.GE3600936@dread.disaster.area>
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

On Tue, 2022-09-13 at 11:15 +1000, Dave Chinner wrote:
> On Tue, Sep 13, 2022 at 09:29:48AM +1000, NeilBrown wrote:
> > On Mon, 12 Sep 2022, Jeff Layton wrote:
> > > On Sun, 2022-09-11 at 08:53 +1000, NeilBrown wrote:
> > > > This could be expensive.
> > > >=20
> > > > There is not currently any locking around O_DIRECT writes.  You can=
not
> > > > synchronise with them.
> > > >=20
> > >=20
> > > AFAICT, DIO write() implementations in btrfs, ext4, and xfs all hold
> > > inode_lock_shared across the I/O. That was why patch #8 takes the
> > > inode_lock (exclusive) across the getattr.
> >=20
> > Looking at ext4_dio_write_iter() it certain does take
> > inode_lock_shared() before starting the write and in some cases it
> > requests, using IOMAP_DIO_FORCE_WAIT, that imap_dio_rw() should wait fo=
r
> > the write to complete.  But not in all cases.
> > So I don't think it always holds the shared lock across all direct IO.
>=20
> To serialise against dio writes, one must:
>=20
> 	// Lock the inode exclusively to block new DIO submissions
> 	inode_lock(inode);
>=20
> 	// Wait for all in flight DIO reads and writes to complete
> 	inode_dio_wait(inode);
>=20
> This is how truncate, fallocate, etc serialise against AIO+DIO which
> do not hold the inode lock across the entire IO. These have to
> serialise aginst DIO reads, too, because we can't have IO in
> progress over a range of the file that we are about to free....
>=20

Thanks, that clarifies a bit.

> > > Taking inode_lock_shared is sufficient to block out buffered and DAX
> > > writes. DIO writes sometimes only take the shared lock (e.g. when the
> > > data is already properly aligned). If we want to ensure the getattr
> > > doesn't run while _any_ writes are running, we'd need the exclusive
> > > lock.
> >=20
> > But the exclusive lock is bad for scalability.
>=20
> Serilisation against DIO is -expensive- and -slow-. It's not a
> solution for what is supposed to be a fast unlocked read-only
> operation like statx().
>=20

Fair enough. I labeled that patch with RFC as I suspected that it would
be too expensive. I don't think we can guarantee perfect consistency vs.
mmap either, so carving out DIO is not a stretch (at least not for
NFSv4).

> > > Maybe that's overkill, though it seems like we could have a race like
> > > this without taking inode_lock across the getattr:
> > >=20
> > > reader				writer
> > > -----------------------------------------------------------------
> > > 				i_version++
> > > getattr
> > > read
> > > 				DIO write to backing store
> > >=20
> >=20
> > This is why I keep saying that the i_version increment must be after th=
e
> > write, not before it.
>=20
> Sure, but that ignores the reason why we actually need to bump
> i_version *before* we submit a DIO write. DIO write invalidates the
> page cache over the range of the write, so any racing read will
> re-populate the page cache during the DIO write.
>=20
> Hence buffered reads can return before the DIO write has completed,
> and the contents of the read can contain, none, some or all of the
> contents of the DIO write. Hence i_version has to be incremented
> before the DIO write is submitted so that racing getattrs will
> indicate that the local caches have been invalidated and that data
> needs to be refetched.
>=20

Bumping the change attribute after the write is done would be sufficient
for serving NFSv4. The clients just invalidate their caches if they see
the value change. Bumping it before and after would be fine too. We
might get some spurious cache invalidations but they'd be infrequent.

FWIW, we've never guaranteed any real atomicity with NFS readers vs.
writers. Clients may see the intermediate stages of a write from a
different client if their reads race in at the right time. If you need
real atomicity, then you really should be using locking. What we _do_
try to ensure is timely pagecache invalidation when this occurs.

If we want to expose this to userland via statx in the future, then we
may need a stronger guarantee because we can't as easily predict how
people will want to use this.

At that point, bumping i_version both before and after makes a bit more
sense, since it better ensures that a change will be noticed, whether
the related read op comes before or after the statx.

> But, yes, to actually be safe here, we *also* should be bumping
> i_version on DIO write on DIO write completion so that racing
> i_version and data reads that occur *after* the initial i_version
> bump are invalidated immediately.
>=20
> IOWs, to avoid getattr/read races missing stale data invalidations
> during DIO writes, we really need to bump i_version both _before and
> after_ DIO write submission.
>=20
> It's corner cases like this where "i_version should only be bumped
> when ctime changes" fails completely. i.e. there are concurrent IO
> situations which can only really be handled correctly by bumping
> i_version whenever either in-memory and/or on-disk persistent data/
> metadata state changes occur.....

I think we have two choices (so far) when it comes to closing the race
window between the i_version bump and the write. Either should be fine
for serving NFSv4.

1/ take the inode_lock in some form across the getattr call for filling
out GETATTR/READDIR/NVERIFY info. This is what the RFC patch in my
latest set does. That's obviously too expensive though. We could take
inode_lock_shared, which wouldn't exclude DIO, but would cover the
buffered and DAX codepaths. This is somewhat ugly though, particularly
with slow backend network filesystems (like NFS). That getattr could
take a while, and meanwhile all writes are stuck...

...or...

2/ start bumping the i_version after a write completes. Bumping it twice
(before and after) would be fine too. In most cases the second one will
be a no-op anyway. We might get the occasional false cache invalidations
there with NFS, but they should be pretty rare and that's preferable to
holding on to invalid cached data (which I think is a danger today).

To do #2, I guess we'd need to add an inode_maybe_inc_iversion call at
the end of the relevant ->write_iter ops, and then dirty the inode if
that comes back true? That should be pretty rare.

We do also still need some way to mitigate potential repeated versions
due to crashes, but that's orthogonal to the above issue (and being
discussed in a different branch of this thread).
--=20
Jeff Layton <jlayton@kernel.org>
