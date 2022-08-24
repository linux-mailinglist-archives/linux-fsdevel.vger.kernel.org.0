Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282BB59FA35
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Aug 2022 14:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237192AbiHXMpK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Aug 2022 08:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234401AbiHXMpI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Aug 2022 08:45:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530D980F51;
        Wed, 24 Aug 2022 05:45:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E32066104A;
        Wed, 24 Aug 2022 12:45:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D0F7C433C1;
        Wed, 24 Aug 2022 12:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661345106;
        bh=AP8SI+V9Klense0pUNrysUm/tjBGKltTnwuRKTrq6i4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=APbx8hhN+doVOvFz00b6oh0mDFxX1SxfZeqMZYe/1APFBYyGn5ddQ/sosvTM7Zabk
         1PSez+pJnh2tKMcH03GiqL0e/kiMiMISA1QtUjFVEx0WOLnQXHWBNYX0GgfMFa8z6Y
         c3AXNxkKSOv4jHKhV4RxRJB+3eCY1UMzg2IQQ0HPsXVvctESAElsI7ss8Yg6D0Ul/P
         mpa06NBka6sRQ8nAUSP97Lo5sfnsvTJQ+MqRWWXGZ+9ExxnCT/IvDkXmuJAkldxUQd
         AZG7Y4QL/F0k7AkfnqnVPZePk3G53gsUBvQagNsOCZ3z/uFX1gFjE0GSCmdLpPSqoA
         mjw96BnT9EkfQ==
Message-ID: <6fc746c24be6f2c28ea39e76f01e57b14f91b90d.camel@kernel.org>
Subject: Re: [PATCH] iversion: update comments with info about atime updates
From:   Jeff Layton <jlayton@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, NeilBrown <neilb@suse.de>,
        Trond Myklebust <trondmy@hammerspace.com>
Date:   Wed, 24 Aug 2022 08:45:03 -0400
In-Reply-To: <20220823232537.GP3600936@dread.disaster.area>
References: <20220822133309.86005-1-jlayton@kernel.org>
         <ceb8f09a4cb2de67f40604d03ee0c475feb3130a.camel@linux.ibm.com>
         <f17b9d627703bee2a7b531a051461671648a9dbd.camel@kernel.org>
         <18827b350fbf6719733fda814255ec20d6dcf00f.camel@linux.ibm.com>
         <4cc84440d954c022d0235bf407a60da66a6ccc39.camel@kernel.org>
         <20220822233231.GJ3600936@dread.disaster.area>
         <6cbcb33d33613f50dd5e485ecbf6ce7e305f3d6f.camel@kernel.org>
         <20220823232537.GP3600936@dread.disaster.area>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2022-08-24 at 09:25 +1000, Dave Chinner wrote:
> On Tue, Aug 23, 2022 at 07:21:36AM -0400, Jeff Layton wrote:
> > On Tue, 2022-08-23 at 09:32 +1000, Dave Chinner wrote:
> > > On Mon, Aug 22, 2022 at 02:22:20PM -0400, Jeff Layton wrote:
> > > > diff --git a/include/linux/iversion.h b/include/linux/iversion.h
> > > > index 3bfebde5a1a6..524abd372100 100644
> > > > --- a/include/linux/iversion.h
> > > > +++ b/include/linux/iversion.h
> > > > @@ -9,8 +9,8 @@
> > > >   * ---------------------------
> > > >   * The change attribute (i_version) is mandated by NFSv4 and is mo=
stly for
> > > >   * knfsd, but is also used for other purposes (e.g. IMA). The i_ve=
rsion must
> > > > - * appear different to observers if there was a change to the inod=
e's data or
> > > > - * metadata since it was last queried.
> > > > + * appear different to observers if there was an explicit change t=
o the inode's
> > > > + * data or metadata since it was last queried.
> > > >   *
> > > >   * Observers see the i_version as a 64-bit number that never decre=
ases. If it
> > > >   * remains the same since it was last checked, then nothing has ch=
anged in the
> > > > @@ -18,6 +18,13 @@
> > > >   * anything about the nature or magnitude of the changes from the =
value, only
> > > >   * that the inode has changed in some fashion.
> > > >   *
> > > > + * Note that atime updates due to reads or similar activity do not=
 represent
> > >=20
> > > What does "or similar activity" mean?
> > >=20
> >=20
> > Some examples:
> >=20
> > - readdir() in a directory
> > - readlink() on symlink
> > - mmap reads
> >=20
> > ...basically, things that access data without materially changing it.
>=20
> What happens if we have buffered dirty data in the page cache, and a
> DIO read is done at that location?
>=20
> This doesn't materially change data, but it forces writeback of the
> cached data, and that means XFS will bump iversion because of the
> data writeback changing inode metadata.
>=20

Ideally, the i_version should not change in this case.

> i can think of several scenarios where a pure data access operation
> that does not materially change user data but will cause an iversion
> change because those access operations imply some level of data
> persistence.
>=20
> > > In case you didn't realise, XFS can bump iversion 500+ times for a
> > > single 1MB write() on a 4kB block size filesytem, and only one of
> > > them is initial write() system call that copies the data into the
> > > page cache. The other 500+ are all the extent allocation and
> > > manipulation transactions that we might run when persisting the data
> > > to disk tens of seconds later. This is how iversion on XFS has
> > > behaved for the past decade.
> > >=20
> >=20
> > Bumping the change count multiple times internally for a single change
> > is not a problem. From the comments in iversion.h:
> >=20
> >  * Observers see the i_version as a 64-bit number that never decreases.=
 If it
> >  * remains the same since it was last checked, then nothing has changed=
 in the
> >  * inode. If it's different then something has changed. Observers canno=
t infer
> >  * anything about the nature or magnitude of the changes from the value=
, only
> >  * that the inode has changed in some fashion.
> >=20
> > Bumping it once or multiple times still conforms to how we have this
> > defined.
>=20
> Sure, it conforms to this piece of the specification. But the
> temporal aspect of the filesystem bumping iversion due to background
> operations most definitely conflicts with the new definition of
> iversion only changing when operations that change c/mtime are
> performed.
>=20
> i.e.  if we're to take the "iversion changes only when c/mtime is
> changed" definition at face value, then the filesystem is not free
> to modify iversion when it modifies metadata during background
> writeback. It's not free to bump iversion during fsync(). i.e. it's
> not free to bump iversion on any operation that implies data
> writeback is necessary.
>=20
> That makes the existing XFS di_changecount implementation
> incompatible with the newly redefined iversion semantics being
> pushed and wanting to be exposed to userspace. If the filesystem
> implementation can't meet the specification of the change attribute
> being exposed to userspace then we *must not expose that information
> to userspace*.
>=20
> This restriction does not prevent us from using our existing
> iversion implementation for NFS and IMA because the worst that
> happens is users occasionally have to refetch information from the
> server as has already been occurring for the past decade or so.
> Indeed, there's an argument to be made that the periodic IMA
> revalidation that relatime + iversion causes for the data at rest in
> the page cache is actually a good security practice and not a
> behaviour that we should be trying to optimise away.
>=20
> All I want from this process is a *solid definition* of what
> iversion is supposed to represent and what will be exposed to
> userspace and the ability for the filesystem to decide itself
> whether to expose it's persistent change counter to userspace. Us
> filesystem developers can take it from there to provide a change
> attribute that conforms to the contract we form with userspace by
> exposing this information to statx().
>=20
> > > Either way we chose, one of these options are the only way that we
> > > will end up with a consistent implementation of a change counter
> > > across all the filesystems. And, quite frankly, that's exactly is
> > > needed if we are going to present this information to userspace
> > > forever more.
> > >=20
> >=20
> > I agree that we need a real definition of what changes should be
> > represented in this value. My intent was to add that to the statx
> > manpage once we had gotten a little further along, but it won't hurt to
> > hash that out first.
>=20
> How have so many experienced engineers forgotten basic engineering
> processes they were taught as an undergrad? i.e. that requirements
> and specification come first, then the implementation is derived
> from the specification?
>=20
> And why do they keep "forgetting" this over and over again?
>=20

The sanctimonious comments are really unnecessary.

YOU are the person who asked me to write testcases for this. The only
reasonable way to do that is to expose this attribute to userland.

I would certainly have approached all of this differently had I been
implementing the i_version counter from scratch. The time to write a
specification for i_version was when it was created (>20 years ago).
That predates my involvement in Linux kernel development. I'm doing what
I can to remedy it now. Be patient, please.

> > I do not intend to exhaustively list all possible activities that shoul=
d
> > and shouldn't update the i_version. It's as difficult to put together a
> > comprehensive list of what activities should and shouldn't change the
> > i_version as it is to list what activities should and shouldn't cause
> > the mtime/ctime/atime to change. The list is also going to constantly
> > change as our interfaces change.
>=20
> If this change attribute is not going to specified in a way that
> userspace cannot rely on it's behaviour not changing in incompatible
> ways, then it should not be exposed to userspace at all. Both
> userspace and the filesystems need an unambiguous definition so that
> userspace applications can rely on the behaviour that the kernel
> and filesystems guarantee will be provided.
>=20
> > What may be best is to just define this value in terms of how timestamp=
s
> > get updated, since POSIX already specifies that. Section 4.9 in the
> > POSIX spec discusses file time updates:
> >=20
> >     https://pubs.opengroup.org/onlinepubs/9699919799/
> >=20
> > It says:
> >=20
> > "Each function or utility in POSIX.1-2017 that reads or writes data
> > (even if the data does not change) or performs an operation to change
> > file status (even if the file status does not change) indicates which o=
f
> > the appropriate timestamps shall be marked for update."
> >=20
> > So, we can refer to that and simply say:
> >=20
> > "If the function updates the mtime or ctime on the inode, then the
> > i_version should be incremented. If only the atime is being updated,
> > then the i_version should not be incremented. The exception to this rul=
e
> > is explicit atime updates via utimes() or similar mechanism, which
> > should result in the i_version being incremented."
>=20
> I'd almost be fine with that definition for iversion being exposed
> to userspace, but it doesn't say anything about metadata changes
> that don't change c/mtime. i.e. this needs to define iversion as
> "_Only_ operations that modify user data and/or c/mtime on the inode
> should increment the change attribute", not leave it ambiguous as to
> whether other operations can bump the change attribute or not.
>=20

Good, this is probably how we'll end up defining it. Doing anything else
is going to be too difficult, I think.

> Of course, this new iversion deinition is most definitely
> incompatible with the existing specification of the XFS persistent
> change attribute.....
>=20

We could also allow for a conformant implementation to have i_version
bumps even when something "invisible" happens, and just mention that the
consumer of it (i.e. application or subsystem) must allow for that
possibility.

With that, a change in i_version would mean that something _might_ have
changed instead of something having definitely changed. Ideally, an
implementation wouldn't do that, since doing so would likely have
measurable performance performance impact.

If we did that, it would mean that the xfs implementation currently
conforms to the proposed spec. Then it would just be a matter of trying
to optimize away the i_version bumps that occur during read-like
activity.

I think it's probably best to define this as loosely as possible so that
we can make it easier for a broad range of filesystems to implement it.
All of the existing consumers can (and do) work with i_version today,
it's just that the extra i_version bumps are terrible for performance
(particularly with NFS).

If we get a spurious bump just occasionally, then it's not too awful
(particularly when the file is being written to anyway, and we'll need
to dump the cache for it). The biggest pain point is i_version being
updated on all atime updates though.
--=20
Jeff Layton <jlayton@kernel.org>
