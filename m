Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526BF5B36BF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 13:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbiIILxS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Sep 2022 07:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbiIILxR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Sep 2022 07:53:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A397E1228C4;
        Fri,  9 Sep 2022 04:53:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30E61B824F4;
        Fri,  9 Sep 2022 11:53:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA48C433D6;
        Fri,  9 Sep 2022 11:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662724392;
        bh=uG4ZyMQFoBQKsOPNCQvYKzi85qeTGEYNE6qpE9fsmu8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=buo6FK+9uFa0Thih9CGgikfS3PBPtA7APWZePrqOsOiklmsqJ4uySBKdhEjYHccqF
         kCOCaxgRCAkpq4t45XtXFyMOBWuPgjildydglrYD8J/TZQC6bknf9ofLPra8GtCHNs
         qDRdgvywtGfjUVr9AELnignfxeUeJ5bL3kpLxdTvqs6xmdHnhxU1WlTPxQjvrafnUK
         3vfmKYwf0xsz/CLa+4vcHwY+IO7EF+oXZOQYxXGDNGrQQpGQggySc27dq8gwJ/xq+V
         S3JNBD5P9FiaLePdavJWfeUGWHPtozHbuOxJW8NeSBr9brSpyrmCmUdtSANqsI2xg2
         8aZ9db/istzSQ==
Message-ID: <68049377014e7c4ba9552cf2913fa7de2a013f87.camel@kernel.org>
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "xiubli@redhat.com" <xiubli@redhat.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
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
        "lczerner@redhat.com" <lczerner@redhat.com>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Date:   Fri, 09 Sep 2022 07:53:09 -0400
In-Reply-To: <166267618149.30452.1385850427092221026@noble.neil.brown.name>
References: <20220907111606.18831-1-jlayton@kernel.org>
        , <166255065346.30452.6121947305075322036@noble.neil.brown.name>
        , <79aaf122743a295ddab9525d9847ac767a3942aa.camel@kernel.org>
        , <20220907125211.GB17729@fieldses.org>
        , <771650a814ab1ff4dc5473d679936b747d9b6cf5.camel@kernel.org>
        , <8a71986b4fb61cd9b4adc8b4250118cbb19eec58.camel@hammerspace.com>
        , <c22baa64133a23be3aba81df23b4af866df51343.camel@kernel.org>
        , <166259764365.30452.5588074352157110414@noble.neil.brown.name>
        , <f7f852c2cd7757646d9ad8e822f7fd04c467df7d.camel@kernel.org>
         <166267618149.30452.1385850427092221026@noble.neil.brown.name>
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

On Fri, 2022-09-09 at 08:29 +1000, NeilBrown wrote:
> On Thu, 08 Sep 2022, Jeff Layton wrote:
> > On Thu, 2022-09-08 at 10:40 +1000, NeilBrown wrote:
> > > On Thu, 08 Sep 2022, Jeff Layton wrote:
> > > > On Wed, 2022-09-07 at 13:55 +0000, Trond Myklebust wrote:
> > > > > On Wed, 2022-09-07 at 09:12 -0400, Jeff Layton wrote:
> > > > > > On Wed, 2022-09-07 at 08:52 -0400, J. Bruce Fields wrote:
> > > > > > > On Wed, Sep 07, 2022 at 08:47:20AM -0400, Jeff Layton wrote:
> > > > > > > > On Wed, 2022-09-07 at 21:37 +1000, NeilBrown wrote:
> > > > > > > > > On Wed, 07 Sep 2022, Jeff Layton wrote:
> > > > > > > > > > +The change to \fIstatx.stx_ino_version\fP is not atomi=
c with
> > > > > > > > > > respect to the
> > > > > > > > > > +other changes in the inode. On a write, for instance, =
the
> > > > > > > > > > i_version it usually
> > > > > > > > > > +incremented before the data is copied into the pagecac=
he.
> > > > > > > > > > Therefore it is
> > > > > > > > > > +possible to see a new i_version value while a read sti=
ll
> > > > > > > > > > shows the old data.
> > > > > > > > >=20
> > > > > > > > > Doesn't that make the value useless?
> > > > > > > > >=20
> > > > > > > >=20
> > > > > > > > No, I don't think so. It's only really useful for comparing=
 to an
> > > > > > > > older
> > > > > > > > sample anyway. If you do "statx; read; statx" and the value
> > > > > > > > hasn't
> > > > > > > > changed, then you know that things are stable.=20
> > > > > > >=20
> > > > > > > I don't see how that helps.=A0 It's still possible to get:
> > > > > > >=20
> > > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0reader=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0writer
> > > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0------=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0------
> > > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0i_version++
> > > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0statx
> > > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0read
> > > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0statx
> > > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0update page cache
> > > > > > >=20
> > > > > > > right?
> > > > > > >=20
> > > > > >=20
> > > > > > Yeah, I suppose so -- the statx wouldn't necessitate any lockin=
g. In
> > > > > > that case, maybe this is useless then other than for testing pu=
rposes
> > > > > > and userland NFS servers.
> > > > > >=20
> > > > > > Would it be better to not consume a statx field with this if so=
? What
> > > > > > could we use as an alternate interface? ioctl? Some sort of glo=
bal
> > > > > > virtual xattr? It does need to be something per-inode.
> > > > >=20
> > > > > I don't see how a non-atomic change attribute is remotely useful =
even
> > > > > for NFS.
> > > > >=20
> > > > > The main problem is not so much the above (although NFS clients a=
re
> > > > > vulnerable to that too) but the behaviour w.r.t. directory change=
s.
> > > > >=20
> > > > > If the server can't guarantee that file/directory/... creation an=
d
> > > > > unlink are atomically recorded with change attribute updates, the=
n the
> > > > > client has to always assume that the server is lying, and that it=
 has
> > > > > to revalidate all its caches anyway. Cue endless readdir/lookup/g=
etattr
> > > > > requests after each and every directory modification in order to =
check
> > > > > that some other client didn't also sneak in a change of their own=
.
> > > > >=20
> > > >=20
> > > > We generally hold the parent dir's inode->i_rwsem exclusively over =
most
> > > > important directory changes, and the times/i_version are also updat=
ed
> > > > while holding it. What we don't do is serialize reads of this value=
 vs.
> > > > the i_rwsem, so you could see new directory contents alongside an o=
ld
> > > > i_version. Maybe we should be taking it for read when we query it o=
n a
> > > > directory?
> > >=20
> > > We do hold i_rwsem today.  I'm working on changing that.  Preserving
> > > atomic directory changeinfo will be a challenge.  The only mechanism =
I
> > > can think if is to pass a "u64*" to all the directory modification op=
s,
> > > and they fill in the version number at the point where it is incremen=
ted
> > > (inode_maybe_inc_iversion_return()).  The (nfsd) caller assumes that
> > > "before" was one less than "after".  If you don't want to internally
> > > require single increments, then you would need to pass a 'u64 [2]' to
> > > get two iversions back.
> > >=20
> >=20
> > That's a major redesign of what the i_version counter is today. It may
> > very well end up being needed, but that's going to touch a lot of stuff
> > in the VFS. Are you planning to do that as a part of your locking
> > changes?
> >=20
>=20
> "A major design"?  How?  The "one less than" might be, but allowing a
> directory morphing op to fill in a "u64 [2]" is just a new interface to
> existing data.  One that allows fine grained atomicity.
>=20
> This would actually be really good for NFS.  nfs_mkdir (for example)
> could easily have access to the atomic pre/post changedid provided by
> the server, and so could easily provide them to nfsd.
>=20
> I'm not planning to do this as part of my locking changes.  In the first
> instance only NFS changes behaviour, and it doesn't provide atomic
> changeids, so there is no loss of functionality.
>=20
> When some other filesystem wants to opt-in to shared-locking on
> directories - that would be the time to push through a better interface.
>=20

I think nfsd does provide atomic changeids for directory operations
currently. AFAICT, any operation where we're changing directory contents
is done while holding the i_rwsem exclusively, and we hold that lock
over the pre and post i_version fetch for the change_info4.

If you change nfsd to allow parallel directory morphing operations
without addressing this, then I think that would be a regression.

>=20
> > > >=20
> > > > Achieving atomicity with file writes though is another matter entir=
ely.
> > > > I'm not sure that's even doable or how to approach it if so.
> > > > Suggestions?
> > >=20
> > > Call inode_maybe_inc_version(page->host) in __folio_mark_dirty() ??
> > >=20
> >=20
> > Writes can cover multiple folios so we'd be doing several increments pe=
r
> > write. Maybe that's ok? Should we also be updating the ctime at that
> > point as well?
>=20
> You would only do several increments if something was reading the value
> concurrently, and then you really should to several increments for
> correctness.
>=20

Agreed.

> >=20
> > Fetching the i_version under the i_rwsem is probably sufficient to fix
> > this though. Most of the write_iter ops already bump the i_version whil=
e
> > holding that lock, so this wouldn't add any extra locking to the write
> > codepaths.
>=20
> Adding new locking doesn't seem like a good idea.  It's bound to have
> performance implications.  It may well end up serialising the directory
> op that I'm currently trying to make parallelisable.
>=20

The new locking would only be in the NFSv4 GETATTR codepath:

    https://lore.kernel.org/linux-nfs/20220908172448.208585-9-jlayton@kerne=
l.org/T/#u

Maybe we'd still better off taking a hit in the write codepath instead
of doing this, but with this, most of the penalty would be paid by nfsd
which I would think would be preferred here.

The problem of mmap writes is another matter though. Not sure what we
can do about that without making i_version bumps a lot more expensive.
--=20
Jeff Layton <jlayton@kernel.org>
