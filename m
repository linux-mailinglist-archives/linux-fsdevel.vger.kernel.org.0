Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C405A6392
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Aug 2022 14:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiH3Mi1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Aug 2022 08:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiH3MiU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Aug 2022 08:38:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F25DF0751;
        Tue, 30 Aug 2022 05:38:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43898B81B21;
        Tue, 30 Aug 2022 12:38:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27181C43470;
        Tue, 30 Aug 2022 12:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661863096;
        bh=Z2Uw+eKcR8qnBXxCJPNZXehF4kL5olAbE4MD9S5gmHc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=tzK2GUGaRSQpp5z3xwIGfwoqJzsSmm8NgGVMpqXAIAFPorSIH0xng4kbLHh2sHi/u
         YBXYSJ0YYMUmZry4t8nynJ8zCLHes3EAGkHnVsTRVWbFsnRUKVOGhaQWk4TByJssyT
         Fsi1p0AwmWPeItOMN1U8MLyHesuUqw4vH4GpySuLrb+y7PrZbSXXkeWf6dFS/NMFDH
         P+uNlA4SexZ6D733rS0krvbOMBJ0v6FuI9/+5QwB0iSYvqNECxH6FnUW3IR7TtBXBc
         rL3Mf/s5B8QA+OdnwyQz+QoggBkIip5qH3EL9ntgPt2BH9BCOvZ3WKNLdvg1Sr7x4E
         TPomQStYs0aXA==
Message-ID: <f3da0a35adfa829af5374b34746eac630b0e67fe.camel@kernel.org>
Subject: Re: [PATCH v3 1/7] iversion: update comments with info about atime
 updates
From:   Jeff Layton <jlayton@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        trondmy@hammerspace.com, neilb@suse.de, viro@zeniv.linux.org.uk,
        zohar@linux.ibm.com, xiubli@redhat.com, chuck.lever@oracle.com,
        lczerner@redhat.com, jack@suse.cz, brauner@kernel.org,
        linux-api@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ceph@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        Colin Walters <walters@verbum.org>
Date:   Tue, 30 Aug 2022 08:38:12 -0400
In-Reply-To: <20220830010442.GW3600936@dread.disaster.area>
References: <20220826214703.134870-1-jlayton@kernel.org>
         <20220826214703.134870-2-jlayton@kernel.org>
         <20220829075651.GS3600936@dread.disaster.area>
         <549776abfaddcc936c6de7800b6d8249d97d9f28.camel@kernel.org>
         <20220830010442.GW3600936@dread.disaster.area>
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

On Tue, 2022-08-30 at 11:04 +1000, Dave Chinner wrote:
> On Mon, Aug 29, 2022 at 06:39:04AM -0400, Jeff Layton wrote:
> > On Mon, 2022-08-29 at 17:56 +1000, Dave Chinner wrote:
> > > On Fri, Aug 26, 2022 at 05:46:57PM -0400, Jeff Layton wrote:
> > > > The i_version field in the kernel has had different semantics over
> > > > the decades, but we're now proposing to expose it to userland via
> > > > statx. This means that we need a clear, consistent definition of
> > > > what it means and when it should change.
> > > >=20
> > > > Update the comments in iversion.h to describe how a conformant
> > > > i_version implementation is expected to behave. This definition
> > > > suits the current users of i_version (NFSv4 and IMA), but is
> > > > loose enough to allow for a wide range of possible implementations.
> > > >=20
> > > > Cc: Colin Walters <walters@verbum.org>
> > > > Cc: NeilBrown <neilb@suse.de>
> > > > Cc: Trond Myklebust <trondmy@hammerspace.com>
> > > > Cc: Dave Chinner <david@fromorbit.com>
> > > > Link: https://lore.kernel.org/linux-xfs/166086932784.5425.171347126=
94961326033@noble.neil.brown.name/#t
> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > ---
> > > >  include/linux/iversion.h | 23 +++++++++++++++++++++--
> > > >  1 file changed, 21 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/include/linux/iversion.h b/include/linux/iversion.h
> > > > index 3bfebde5a1a6..45e93e1b4edc 100644
> > > > --- a/include/linux/iversion.h
> > > > +++ b/include/linux/iversion.h
> > > > @@ -9,8 +9,19 @@
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
> > > > + *
> > > > + * An explicit change is one that would ordinarily result in a cha=
nge to the
> > > > + * inode status change time (aka ctime). The version must appear t=
o change, even
> > > > + * if the ctime does not (since the whole point is to avoid missin=
g updates due
> > > > + * to timestamp granularity). If POSIX mandates that the ctime mus=
t change due
> > > > + * to an operation, then the i_version counter must be incremented=
 as well.
> > > > + *
> > > > + * A conformant implementation is allowed to increment the counter=
 in other
> > > > + * cases, but this is not optimal. NFSv4 and IMA both use this val=
ue to determine
> > > > + * whether caches are up to date. Spurious increments can cause fa=
lse cache
> > > > + * invalidations.
> > >=20
> > > "not optimal", but never-the-less allowed - that's "unspecified
> > > behaviour" if I've ever seen it. How is userspace supposed to
> > > know/deal with this?
> > >=20
> > > Indeed, this loophole clause doesn't exist in the man pages that
> > > define what statx.stx_ino_version means. The man pages explicitly
> > > define that stx_ino_version only ever changes when stx_ctime
> > > changes.
> > >=20
> >=20
> > We can fix the manpage to make this more clear.
> >=20
> > > IOWs, the behaviour userspace developers are going to expect *does
> > > not include* stx_ino_version changing it more often than ctime is
> > > changed. Hence a kernel iversion implementation that bumps the
> > > counter more often than ctime changes *is not conformant with the
> > > statx version counter specification*. IOWs, we can't export such
> > > behaviour to userspace *ever* - it is a non-conformant
> > > implementation.
> > >=20
> >=20
> > Nonsense. The statx version counter specification is *whatever we decid=
e
> > to make it*.
>=20
> Yes, but...
>=20
> > If we define it to allow for spurious version bumps, then
> > these implementations would be conformant.
>=20
> ... that's _not how you defined stx_ino_version to behave_!
>=20

I certainly didn't say that it must _only_ be incremented when the ctime
would change, only that if the ctime would change that it must be
incremented.

The weasel-words make all the difference. But, point taken, the spec
should be explicit about this. I'll plan to revise the manpage patch and
resend it.

> > Given that you can't tell what or how much changed in the inode wheneve=
r
> > the value changes, allowing it to be bumped on non-observable changes i=
s
> > ok and the counter is still useful. When you see it change you need to
> > go stat/read/getxattr etc, to see what actually happened anyway.
>=20
> IDGI. If this is acceptible, then you're forcing userspace into
> "store and filter" implementations as the only viable method of
> using the change notification usefully.
>=20

Well, that's all it's really useful for anyway. The counter itself has
tells you nothing other than that something changed.

> That means atime is just another attribute in the "store and
> filter" algorithm, so if this is how we define stx_ino_version
> behaviour, why carve out an explicit exception for atime?
>=20

Because atime updates are particularly problematic. Ideally, we'd filter
out all implicit updates, but that may not be feasible in all cases.

> > Most applications won't be interested in every possible explicit change
> > that can happen to an inode. It's likely these applications would check
> > the parts of the inode they're interested in, and then go back to
> > waiting for the next bump if the change wasn't significant to them.
>=20
> Yes, that is exactly my point.
>=20
> You make the argument that we must not bump iversion in certain
> situations (atime) because it will cause spurious cache
> invalidations, but then say it is OK to bump it in others regardless
> of the fact that it will cause spurious cache invalidations. And you
> justify this latter behaviour by saying it is up to the application
> to avoid spurious invalidations by using "store and filter"
> algorithms.
>=20
> If the application has to store state and filter changes indicated
> by stx_ino_version changing, then by definition *it must be capable
> of filtering iversion bumps as a result of atime changes*.
>=20
> The iversion exception carved out for atime requires the application
> to implement "store and filter" algorithms only if it needs to care
> about atime changes. The "invisible bump" exception carved out here
> *requires* applications to implement "store and filter" algorithms
> to filter out invisible bumps.
>=20
> Hence if we combine both these behaviours, atime bumping iversion
> appears to userspace exactly the same as "invisible bump occurred,
> followed by access that changes atime".  IOWs, userspace cannot tell the
> difference between a filesystem implementation that doesn't bump
> iversion on atime but has invisible bump, and a filesystem that
> bumps iversion on atime updates and so it always needs to filter
> atime changes if it doesn't care about them.
>=20
> Hence if stx_ino_version can have invisible bumps, it makes no
> difference to userspace if atime updates bump iversion or not. They
> will have to filter atime if they don't care about it, and they have
> to store the new stx_ino_version every time they filter out an
> invisible bump that doesn't change anything their filters care
> about (e.g. atime!).
>=20
> At which point I have to ask: if we are expecting userspace to
> filter out invisible iversion bumps because that's allowed,
> conformant behaviour, then why aren't we requiring both the NFS
> server and IMA applications to filter spurious iversion bumps as
> well?
>=20

I think you're reading too much into my attempt to carve out atime from
i_version updates. That is purely a pragmatic attempt to staunch the
worst of the bleeding from this problem.

atime updates are _very_ frequent, and the default relatime behavior
ensures that each NFS client reading file data or dir info after a
change to it will end up downloading it at least twice: once to read the
file itself, and then again after it drops its cache due to the atime
update from the prior read.

In an ideal world, an implementation would only bump the i_version on
explicit changes. If an implicit change only happens infrequently, or
always happens in very close succession after an explicit change (such
that readers can't race in as easily) then that's less harmful for
performance.

The i_version value itself can't tell you anything about the inode. It's
only useful for comparing to an earlier sample to see if it is has
changed. This attribute is mostly useful in the context of a store-and-
invalidate kind of system. We want to keep the invalidations to a
minimum, but eliminating spurious updates is more of an optimization
problem than one of correctness.

It would be best if we could eliminate all spurious updates, but I think
the stx_ino_version is just as useful without being that strict, and
that leaves the door open for other implementations that aren't able to
filter out all spurious updates.

> > > Hence I think anything that bumps iversion outside the bounds of the
> > > statx definition should be declared as such:
> > >=20
> > > "Non-conformant iversion implementations:
> > > 	- MUST NOT be exported by statx() to userspace
> > > 	- MUST be -tolerated- by kernel internal applications that
> > > 	  use iversion for their own purposes."
> > >=20
> >=20
> > I think this is more strict than is needed. An implementation that bump=
s
> > this value more often than is necessary is still useful.
>=20
> I never said that non-conformant implementations aren't useful. What
> I said is they aren't conformant with the provided definition of
> stx_ino_version, and as a result we should not allow them to be
> exposed to userspace.

As I said above, I'll respin the manpage patch to better specify what a
conformant implementation can and can't do, and we can discuss from
there.

--=20
Jeff Layton <jlayton@kernel.org>
