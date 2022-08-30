Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEF25A6245
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Aug 2022 13:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbiH3LmP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Aug 2022 07:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiH3Llz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Aug 2022 07:41:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956D55B7B0;
        Tue, 30 Aug 2022 04:40:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CEC9BB81A5C;
        Tue, 30 Aug 2022 11:40:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C003C433D6;
        Tue, 30 Aug 2022 11:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661859605;
        bh=9U5YNZG5kGGVOkXBz5XYF4bS4GrVUMLFarYkV3ivBmI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=LJGU2MlvihvbWDegzJW9x4zDzYfr4RuHN1avdf2LC/d0uILp5ZxoG8FZFFVC37yiC
         zZ/k2xcy0WiPAfZhXY1pATPJqmDLFF2rR4+T4LT0HHIaLKuNbQ4o4FY+T2NtLmOAZv
         DNHu8b6lkZjJU6fe+lHENGmYwS9JjFl6Tvr/A7puLdcTsrBc8w5UxI7qJUTUxVdGIs
         NsH1AiofF7wbgJapwPcvITxWN2fyStNzOHWp+xq9dfReH1WzIibxnjxXqei4581RCt
         kvzCCbkUpOXF+iA6klzKuW9BROz+ZHywvmfybrUpmqA2U/lGefISWYhJdJ5FRUAgYi
         pddIxrdkoReoA==
Message-ID: <f5c42c0d87dfa45188c2109ccf9baeb7a42aa27e.camel@kernel.org>
Subject: Re: [PATCH v3 1/7] iversion: update comments with info about atime
 updates
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Dave Chinner <david@fromorbit.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, djwong@kernel.org,
        trondmy@hammerspace.com, viro@zeniv.linux.org.uk,
        zohar@linux.ibm.com, xiubli@redhat.com, chuck.lever@oracle.com,
        lczerner@redhat.com, jack@suse.cz, brauner@kernel.org,
        linux-api@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ceph@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        Colin Walters <walters@verbum.org>
Date:   Tue, 30 Aug 2022 07:40:02 -0400
In-Reply-To: <166181389550.27490.8200873228292034867@noble.neil.brown.name>
References: <20220826214703.134870-1-jlayton@kernel.org>
        , <20220826214703.134870-2-jlayton@kernel.org>
        , <20220829075651.GS3600936@dread.disaster.area>
        , <549776abfaddcc936c6de7800b6d8249d97d9f28.camel@kernel.org>
         <166181389550.27490.8200873228292034867@noble.neil.brown.name>
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

On Tue, 2022-08-30 at 08:58 +1000, NeilBrown wrote:
> On Mon, 29 Aug 2022, Jeff Layton wrote:
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
> > to make it*. If we define it to allow for spurious version bumps, then
> > these implementations would be conformant.
> >=20
> > Given that you can't tell what or how much changed in the inode wheneve=
r
> > the value changes, allowing it to be bumped on non-observable changes i=
s
> > ok and the counter is still useful. When you see it change you need to
> > go stat/read/getxattr etc, to see what actually happened anyway.
> >=20
> > Most applications won't be interested in every possible explicit change
> > that can happen to an inode. It's likely these applications would check
> > the parts of the inode they're interested in, and then go back to
> > waiting for the next bump if the change wasn't significant to them.
> >=20
> >=20
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
> > this value more often than is necessary is still useful. It's not
> > _ideal_, but it still meets the needs of NFSv4, IMA and other potential
> > users of it. After all, this is basically the definition of i_version
> > today and it's still useful, even if atime update i_version bumps are
> > currently harmful for performance.
>=20
> Why do you want to let it be OK?  Who is hurt by it being "more strict
> than needed"?  There is an obvious cost in not being strict as an
> implementation can be compliant but completely useless (increment every
> nanosecond).  So there needs to be a clear benefit to balance this.  Who
> benefits by not being strict?
>=20

Other filesystems that may not be able to provide the strict semantics
required. I don't have any names to name here -- I'm just trying to
ensure that we don't paint ourselves into a corner with rules that are
more strict than we really need.

If the consensus is that we should keep the definition strict, then Ican
live with that. That might narrow the number of filesystems that can
provide this attribute though.

> Also: Your spec doesn't say it must increase, only it must be different.
> So would as hash of all data and metadata be allowed (sysfs might be
> able to provide that, but probably wouldn't bother).
>=20
> Also: if stray updates are still conformant, can occasional repeated
> values be still conformant?  I would like for a high-precision ctime
> timestamp to be acceptable, but as time can go backwards it is currently
> not conformant (even though the xfs iversion which is less useful is
> actually conformant).
>=20

Yes, saying only that it must be different is intentional. What we
really want is for consumers to treat this as an opaque value for the
most part [1]. Therefore an implementation based on hashing would
conform to the spec, I'd think, as long as all of the relevant info is
part of the hash.

OTOH, hash collisions could be an issue here and I think we need to
avoid allowing duplicate values. When it comes to watching for changes
to an inode, false positives are generally ok since that should just
affect performance but not functionality.

False negatives are a different matter. They can lead to cache coherency
issues with NFS, or missing remeasurements in IMA. Userland applications
that use this could be subject to similar issues.
--=20
Jeff Layton <jlayton@kernel.org>


[1]: which may not be reasonable in the case of write delegations on
NFSv4, since the client is expected to increment it when it has cached
local changes.
