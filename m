Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B835BAFED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Sep 2022 17:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbiIPPLm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Sep 2022 11:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiIPPLk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Sep 2022 11:11:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4779DAA344;
        Fri, 16 Sep 2022 08:11:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC5D162C56;
        Fri, 16 Sep 2022 15:11:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D98C433D6;
        Fri, 16 Sep 2022 15:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663341098;
        bh=xvCxeZz4qr3XPSIp4Xc+yhFsHVPnIedgZs2G2tMZsFY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=dflY6BY+7OgdppPwGYZ1j2a+2JWSUCq/paCdLXV43SC0YRNH9B1ZehljmY7G9jgUB
         R+rM9MN6G0TxYueqvRv2PUYrwCdN0UYQBSdo/ssfH5paScu6u6nG9H1FhTRFVqTgnV
         CDM4JmVTvgLtnXjop8rcMSH0BTec5Ri2zUU8JXcp64lS4X57v/A76eH+n2gNIog+yD
         +jCeKc2Gv2fgbGnsA8Ipm2MgrEx/ZugChsvZxy+JkRqSV/xO8Edtk9rlY9neC/OxIz
         37bpYnrUKpwjmWEgOvwAtmZo4hR/69GhVDEpM7zxq/Eh0xxPN8EamCTLOpo8NliT62
         Bcm3mFB44vmxA==
Message-ID: <24005713ad25370d64ab5bd0db0b2e4fcb902c1c.camel@kernel.org>
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
From:   Jeff Layton <jlayton@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>, NeilBrown <neilb@suse.de>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
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
Date:   Fri, 16 Sep 2022 11:11:34 -0400
In-Reply-To: <7027d1c2923053fe763e9218d10ce8634b56e81d.camel@kernel.org>
References: <20220912134208.GB9304@fieldses.org>
         <166302447257.30452.6751169887085269140@noble.neil.brown.name>
         <20220915140644.GA15754@fieldses.org>
         <577b6d8a7243aeee37eaa4bbb00c90799586bc48.camel@hammerspace.com>
         <1a968b8e87f054e360877c9ab8cdfc4cfdfc8740.camel@kernel.org>
         <0646410b6d2a5d19d3315f339b2928dfa9f2d922.camel@hammerspace.com>
         <34e91540c92ad6980256f6b44115cf993695d5e1.camel@kernel.org>
         <871f9c5153ddfe760854ca31ee36b84655959b83.camel@hammerspace.com>
         <e8922bc821a40f5a3f0a1301583288ed19b6891b.camel@kernel.org>
         <166328063547.15759.12797959071252871549@noble.neil.brown.name>
         <YyQdmLpiAMvl5EkU@mit.edu>
         <7027d1c2923053fe763e9218d10ce8634b56e81d.camel@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2022-09-16 at 07:36 -0400, Jeff Layton wrote:
> On Fri, 2022-09-16 at 02:54 -0400, Theodore Ts'o wrote:
> > On Fri, Sep 16, 2022 at 08:23:55AM +1000, NeilBrown wrote:
> > > > > If the answer is that 'all values change', then why store the cra=
sh
> > > > > counter in the inode at all? Why not just add it as an offset whe=
n
> > > > > you're generating the user-visible change attribute?
> > > > >=20
> > > > > i.e. statx.change_attr =3D inode->i_version + (crash counter * of=
fset)
> >=20
> > I had suggested just hashing the crash counter with the file system's
> > on-disk i_version number, which is essentially what you are suggested.
> >=20
> > > > Yes, if we plan to ensure that all the change attrs change after a
> > > > crash, we can do that.
> > > >=20
> > > > So what would make sense for an offset? Maybe 2**12? One would hope=
 that
> > > > there wouldn't be more than 4k increments before one of them made i=
t to
> > > > disk. OTOH, maybe that can happen with teeny-tiny writes.
> > >=20
> > > Leave it up the to filesystem to decide.  The VFS and/or NFSD should
> > > have not have part in calculating the i_version.  It should be entire=
ly
> > > in the filesystem - though support code could be provided if common
> > > patterns exist across filesystems.
> >=20
> > Oh, *heck* no.  This parameter is for the NFS implementation to
> > decide, because it's NFS's caching algorithms which are at stake here.
> >=20
> > As a the file system maintainer, I had offered to make an on-disk
> > "crash counter" which would get updated when the journal had gotten
> > replayed, in addition to the on-disk i_version number.  This will be
> > available for the Linux implementation of NFSD to use, but that's up
> > to *you* to decide how you want to use them.
> >=20
> > I was perfectly happy with hashing the crash counter and the i_version
> > because I had assumed that not *that* much stuff was going to be
> > cached, and so invalidating all of the caches in the unusual case
> > where there was a crash was acceptable.  After all it's a !@#?!@
> > cache.  Caches sometimmes get invalidated.  "That is the order of
> > things." (as Ramata'Klan once said in "Rocks and Shoals")
> >=20
> > But if people expect that multiple TB's of data is going to be stored;
> > that cache invalidation is unacceptable; and that a itsy-weeny chance
> > of false negative failures which might cause data corruption might be
> > acceptable tradeoff, hey, that's for the system which is providing
> > caching semantics to determine.
> >=20
> > PLEASE don't put this tradeoff on the file system authors; I would
> > much prefer to leave this tradeoff in the hands of the system which is
> > trying to do the caching.
> >=20
>=20
> Yeah, if we were designing this from scratch, I might agree with leaving
> more up to the filesystem, but the existing users all have pretty much
> the same needs. I'm going to plan to try to keep most of this in the
> common infrastructure defined in iversion.h.
>=20
> Ted, for the ext4 crash counter, what wordsize were you thinking? I
> doubt we'll be able to use much more than 32 bits so a larger integer is
> probably not worthwhile. There are several holes in struct super_block
> (at least on x86_64), so adding this field to the generic structure
> needn't grow it.

That said, now that I've taken a swipe at implementing this, I need more
information than just the crash counter. We need to multiply the crash
counter with a reasonable estimate of the maximum number of individual
writes that could occur between an i_version being incremented and that
value making it to the backing store.

IOW, given a write that bumps the i_version to X, how many more write
calls could race in before X makes it to the platter? I took a SWAG and
said 4k in an earlier email, but I don't really have a way to know, and
that could vary wildly with different filesystems and storage.

What I'd like to see is this in struct super_block:

	u32		s_version_offset;

...and then individual filesystems can calculate:

	crash_counter * max_number_of_writes

and put the correct value in there at mount time.

--=20
Jeff Layton <jlayton@kernel.org>
