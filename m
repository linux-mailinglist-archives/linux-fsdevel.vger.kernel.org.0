Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15BA5BFC66
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 12:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbiIUKdg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 06:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiIUKde (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 06:33:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2025F90822;
        Wed, 21 Sep 2022 03:33:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F70861F48;
        Wed, 21 Sep 2022 10:33:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD53C433D6;
        Wed, 21 Sep 2022 10:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663756412;
        bh=o3HfJ1dfwFPEiioeca+9POwOfG33OdnpIMMLdF2SNXg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=o4RWarLQHwD3AgIDoCdx243jvK53BMwSxiGuWrlraMHFS8gEDQfTIWpRECTQjNNCA
         IbgpwkHWl/rTTQmTv8TPytRLDSnvm7teGWEiEEE+hyPHTVeUAcxBz1VxOKgCz/BxKc
         Am0Ym+HTEpxP1D2u2vQK08YvOqreMedpmLNCQzvqfkcSWWxsycWUfOHPD95dXSzZsB
         Q9AmUVduI1DNK6H8fEGBNPtsFuSRoeP8q/jzCYY09qkjOSTkshgbrEfbZkSgSLs/NC
         nbiYmuOgJ2RJQaGElU7slr5O3+UYrzdtEVwtoCeIliH/I6uYg4XhlABfoWRef1lZ9Y
         IzjLY5PB5SSFw==
Message-ID: <93b6d9f7cf997245bb68409eeb195f9400e55cd0.camel@kernel.org>
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
From:   Jeff Layton <jlayton@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
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
Date:   Wed, 21 Sep 2022 06:33:28 -0400
In-Reply-To: <20220921000032.GR3600936@dread.disaster.area>
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
         <20220921000032.GR3600936@dread.disaster.area>
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

On Wed, 2022-09-21 at 10:00 +1000, Dave Chinner wrote:
> On Tue, Sep 20, 2022 at 06:26:05AM -0400, Jeff Layton wrote:
> > On Tue, 2022-09-20 at 10:16 +1000, Dave Chinner wrote:
> > > IOWs, the NFS server can define it's own on-disk persistent metadata
> > > using xattrs, and you don't need local filesystems to be modified at
> > > all. You can add the crash epoch into the change attr that is sent
> > > to NFS clients without having to change the VFS i_version
> > > implementation at all.
> > >=20
> > > This whole problem is solvable entirely within the NFS server code,
> > > and we don't need to change local filesystems at all. NFS can
> > > control the persistence and format of the xattrs it uses, and it
> > > does not need new custom on-disk format changes from every
> > > filesystem to support this new application requirement.
> > >=20
> > > At this point, NFS server developers don't need to care what the
> > > underlying filesystem format provides - the xattrs provide the crash
> > > detection and enumeration the NFS server functionality requires.
> > >=20
> >=20
> > Doesn't the filesystem already detect when it's been mounted after an
> > unclean shutdown?
>=20
> Not every filesystem will be able to guarantee unclean shutdown
> detection at the next mount. That's the whole problem - NFS
> developers are asking for something that cannot be provided as
> generic functionality by individual filesystems, so the NFS server
> application is going to have to work around any filesytem that
> cannot provide the information it needs.
>=20
> e.g. ext4 has it journal replayed by the userspace tools prior
> to mount, so when it then gets mounted by the kernel it's seen as a
> clean mount.
>=20
> If we shut an XFS filesystem down due to a filesystem corruption or
> failed IO to the journal code, the kernel might not be able to
> replay the journal on mount (i.e. it is corrupt).  We then run
> xfs_repair, and that fixes the corruption issue and -cleans the
> log-. When we next mount the filesystem, it results in a _clean
> mount_, and the kernel filesystem code can not signal to NFS that an
> unclean mount occurred and so it should bump it's crash counter.
>=20
> IOWs, this whole "filesystems need to tell NFS about crashes"
> propagates all the way through *every filesystem tool chain*, not
> just the kernel mount code. And we most certainly don't control
> every 3rd party application that walks around in the filesystem on
> disk format, and so there are -zero- guarantees that the kernel
> filesystem mount code can give that an unclean shutdown occurred
> prior to the current mount.
>=20
> And then for niche NFS server applications (like transparent
> fail-over between HA NFS servers) there are even more rigid
> constraints on NFS change attributes. And you're asking local
> filesystems to know about these application constraints and bake
> them into their on-disk format again.
>=20
> This whole discussion has come about because we baked certain
> behaviour for NFS into the on-disk format many, many years ago, and
> it's only now that it is considered inadequate for *new* NFS
> application related functionality (e.g. fscache integration and
> cache validity across server side mount cycles).
>=20
> We've learnt a valuable lesson from this: don't bake application
> specific persistent metadata requirements into the on-disk format
> because when the application needs to change, it requires every
> filesystem that supports taht application level functionality
> to change their on-disk formats...
>=20
> > I'm not sure what good we'll get out of bolting this
> > scheme onto the NFS server, when the filesystem could just as easily
> > give us this info.
>=20
> The xattr scheme guarantees the correct application behaviour that the NF=
S
> server requires, all at the NFS application level without requiring
> local filesystems to support the NFS requirements in their on-disk
> format. THe NFS server controls the format and versioning of it's
> on-disk persistent metadata (i.e. the xattrs it uses) and so any
> changes to the application level requirements of that functionality
> are now completely under the control of the application.
>=20
> i.e. the application gets to manage version control, backwards and
> forwards compatibility of it's persistent metadata, etc. What you
> are asking is that every local filesystem takes responsibility for
> managing the long term persistent metadata that only NFS requires.
> It's more complex to do this at the filesystem level, and we have to
> replicate the same work for every filesystem that is going to
> support this on-disk functionality.
>=20
> Using xattrs means the functionality is implemented once, it's
> common across all local filesystems, and no exportable filesystem
> needs to know anything about it as it's all self-contained in the
> NFS server code. THe code is smaller, easier to maintain, consistent
> across all systems, easy to test, etc.
>=20
> It also can be implemented and rolled out *immediately* to all
> existing supported NFS server implementations, without having to
> wait months/years (or never!) for local filesystem on-disk format
> changes to roll out to production systems.
>=20
> Asking individual filesystems to implement application specific
> persistent metadata is a *last resort* and should only be done if
> correctness or performance cannot be obtained in any other way.
>=20
> So, yeah, the only sane direction to take here is to use xattrs to
> store this NFS application level information. It's less work for
> everyone, and in the long term it means when the NFS application
> requirements change again, we don't need to modify the on-disk
> format of multiple local filesystems.
>=20
> > In any case, the main problem at this point is not so much in detecting
> > when there has been an unclean shutdown, but rather what to do when
> > there is one. We need to to advance the presented change attributes
> > beyond the largest possible one that may have been handed out prior to
> > the crash.=20
>=20
> Sure, but you're missing my point: by using xattrs for detection,
> you don't need to involve anything to do with local filesystems at
> all.
>=20
> > How do we determine what that offset should be? Your last email
> > suggested that there really is no limit to the number of i_version bump=
s
> > that can happen in memory before one of them makes it to disk. What can
> > we do to address that?
>=20
> <shrug>
>=20
> I'm just pointing out problems I see when defining this as behaviour
> for on-disk format purposes. If we define it as part of the on-disk
> format, then we have to be concerned about how it may be used
> outside the scope of just the NFS server application.=20
>=20
> However, If NFS keeps this metadata and functionaly entirely
> contained at the application level via xattrs, I really don't care
> what algorithm NFS developers decides to use for their crash
> sequencing. It's not my concern at this point, and that's precisely
> why NFS should be using xattrs for this NFS specific functionality.
>=20

I get it: you'd rather not have to deal with what you see as an NFS
problem, but I don't get how what you're proposing solves anything. We
might be able to use that scheme to detect crashes, but that's only part
of the problem (and it's a relatively simple part of the problem to
solve, really).

Maybe you can clarify it for me:

Suppose we go with what you're saying and store some information in
xattrs that allows us to detect crashes in some fashion. The server
crashes and comes back up and we detect that there was a crash earlier.

What does nfsd need to do now to ensure that it doesn't hand out a
duplicate change attribute?=20

Until we can answer that question, detecting crashes doesn't matter.
--=20
Jeff Layton <jlayton@kernel.org>
