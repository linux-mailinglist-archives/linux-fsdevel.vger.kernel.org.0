Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9465B1B96
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Sep 2022 13:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbiIHLfL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 07:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbiIHLfD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 07:35:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16D43120A;
        Thu,  8 Sep 2022 04:35:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 348FE61C99;
        Thu,  8 Sep 2022 11:34:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853D8C433C1;
        Thu,  8 Sep 2022 11:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662636898;
        bh=wNz25kbhUUH7fFXO2OLBZ10iI63lbEA4XVm9xrD79g4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=YCxwNLWJTuv2/+xkGeyE+DVN7imflpeXqLBjPZ5XuwsY7Ib7GsF1/8O+dgv5McqEW
         8PQhNwat2z4BVVYnVgklGLdWYdtVYHLF/JYs8ku++tMGQ5aE7Hwp/EiV1chQj+yyMh
         B5HGp6XuMb66zmsQgxrv1I5imYBVmOYCDggOoWNBazfcdwE+idGv3lGtMMbP0C/SJF
         bI3zMtyTUIT0H7k6Xx3BfpyUhkvHNvLUaeUyiM2ySI1UlCzz5Nqn02yB8Bw/mv4STL
         K2hKF9N84ZY1xNoAE4h/jrBWZ0TI6q15QmXeSQufbp5VIHy0k7mB+xYsRltWX4K1hK
         Fp8bDMuvjBhxA==
Message-ID: <f7f852c2cd7757646d9ad8e822f7fd04c467df7d.camel@kernel.org>
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
Date:   Thu, 08 Sep 2022 07:34:55 -0400
In-Reply-To: <166259764365.30452.5588074352157110414@noble.neil.brown.name>
References: <20220907111606.18831-1-jlayton@kernel.org>
        , <166255065346.30452.6121947305075322036@noble.neil.brown.name>
        , <79aaf122743a295ddab9525d9847ac767a3942aa.camel@kernel.org>
        , <20220907125211.GB17729@fieldses.org>
        , <771650a814ab1ff4dc5473d679936b747d9b6cf5.camel@kernel.org>
        , <8a71986b4fb61cd9b4adc8b4250118cbb19eec58.camel@hammerspace.com>
        , <c22baa64133a23be3aba81df23b4af866df51343.camel@kernel.org>
         <166259764365.30452.5588074352157110414@noble.neil.brown.name>
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

On Thu, 2022-09-08 at 10:40 +1000, NeilBrown wrote:
> On Thu, 08 Sep 2022, Jeff Layton wrote:
> > On Wed, 2022-09-07 at 13:55 +0000, Trond Myklebust wrote:
> > > On Wed, 2022-09-07 at 09:12 -0400, Jeff Layton wrote:
> > > > On Wed, 2022-09-07 at 08:52 -0400, J. Bruce Fields wrote:
> > > > > On Wed, Sep 07, 2022 at 08:47:20AM -0400, Jeff Layton wrote:
> > > > > > On Wed, 2022-09-07 at 21:37 +1000, NeilBrown wrote:
> > > > > > > On Wed, 07 Sep 2022, Jeff Layton wrote:
> > > > > > > > +The change to \fIstatx.stx_ino_version\fP is not atomic wi=
th
> > > > > > > > respect to the
> > > > > > > > +other changes in the inode. On a write, for instance, the
> > > > > > > > i_version it usually
> > > > > > > > +incremented before the data is copied into the pagecache.
> > > > > > > > Therefore it is
> > > > > > > > +possible to see a new i_version value while a read still
> > > > > > > > shows the old data.
> > > > > > >=20
> > > > > > > Doesn't that make the value useless?
> > > > > > >=20
> > > > > >=20
> > > > > > No, I don't think so. It's only really useful for comparing to =
an
> > > > > > older
> > > > > > sample anyway. If you do "statx; read; statx" and the value
> > > > > > hasn't
> > > > > > changed, then you know that things are stable.=20
> > > > >=20
> > > > > I don't see how that helps.=A0 It's still possible to get:
> > > > >=20
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0reader=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0writer
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0------=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0------
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0i_version++
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0statx
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0read
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0statx
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0update page cache
> > > > >=20
> > > > > right?
> > > > >=20
> > > >=20
> > > > Yeah, I suppose so -- the statx wouldn't necessitate any locking. I=
n
> > > > that case, maybe this is useless then other than for testing purpos=
es
> > > > and userland NFS servers.
> > > >=20
> > > > Would it be better to not consume a statx field with this if so? Wh=
at
> > > > could we use as an alternate interface? ioctl? Some sort of global
> > > > virtual xattr? It does need to be something per-inode.
> > >=20
> > > I don't see how a non-atomic change attribute is remotely useful even
> > > for NFS.
> > >=20
> > > The main problem is not so much the above (although NFS clients are
> > > vulnerable to that too) but the behaviour w.r.t. directory changes.
> > >=20
> > > If the server can't guarantee that file/directory/... creation and
> > > unlink are atomically recorded with change attribute updates, then th=
e
> > > client has to always assume that the server is lying, and that it has
> > > to revalidate all its caches anyway. Cue endless readdir/lookup/getat=
tr
> > > requests after each and every directory modification in order to chec=
k
> > > that some other client didn't also sneak in a change of their own.
> > >=20
> >=20
> > We generally hold the parent dir's inode->i_rwsem exclusively over most
> > important directory changes, and the times/i_version are also updated
> > while holding it. What we don't do is serialize reads of this value vs.
> > the i_rwsem, so you could see new directory contents alongside an old
> > i_version. Maybe we should be taking it for read when we query it on a
> > directory?
>=20
> We do hold i_rwsem today.  I'm working on changing that.  Preserving
> atomic directory changeinfo will be a challenge.  The only mechanism I
> can think if is to pass a "u64*" to all the directory modification ops,
> and they fill in the version number at the point where it is incremented
> (inode_maybe_inc_iversion_return()).  The (nfsd) caller assumes that
> "before" was one less than "after".  If you don't want to internally
> require single increments, then you would need to pass a 'u64 [2]' to
> get two iversions back.
>=20

That's a major redesign of what the i_version counter is today. It may
very well end up being needed, but that's going to touch a lot of stuff
in the VFS. Are you planning to do that as a part of your locking
changes?

> >=20
> > Achieving atomicity with file writes though is another matter entirely.
> > I'm not sure that's even doable or how to approach it if so.
> > Suggestions?
>=20
> Call inode_maybe_inc_version(page->host) in __folio_mark_dirty() ??
>=20

Writes can cover multiple folios so we'd be doing several increments per
write. Maybe that's ok? Should we also be updating the ctime at that
point as well?

Fetching the i_version under the i_rwsem is probably sufficient to fix
this though. Most of the write_iter ops already bump the i_version while
holding that lock, so this wouldn't add any extra locking to the write
codepaths.

--=20
Jeff Layton <jlayton@kernel.org>
