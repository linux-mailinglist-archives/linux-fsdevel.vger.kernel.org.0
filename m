Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBCF5B597E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 13:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiILLm3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 07:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiILLm0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 07:42:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3101E3C8EC;
        Mon, 12 Sep 2022 04:42:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82E67611D4;
        Mon, 12 Sep 2022 11:42:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD330C433D6;
        Mon, 12 Sep 2022 11:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662982939;
        bh=J80lqO8T+MQ009K2wk7kCJ5IpBgUGLtZUqfovw09npg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=R5fk2SYJ7keuw/mT8+NbWJTppM0IQktpH5ycR32l7IPSkyvAwv40AVRgGRgvDg8A0
         abVTcNlEm3+UVioXgJXkdEhp7uE8GI9Xqtfz3FodSdqpv4JgTppU9ky4Tdb5nBtLod
         g/ZTzyHYWwKUh1mzlqzyWS3ahOV+A+xPZyB7METhkCmWRubnL2UatKVYnByQNKhZ98
         QIDD+Qx+QL+cZbz5JPUuPPFcK4hkHwy4x/VcX4+kbj3Xyq5skEkOWOfPGLfSjoOQUw
         /M3LsCzWPsjZvl5MQ/DsuiLLOICMYz5SH4FlQ2c1e+LXHGrAdgbWG1HWvRuFV+4k+4
         wXJRcr+6no2kw==
Message-ID: <9eaed9a47d1aef11fee95f0079e302bc776bc7ff.camel@kernel.org>
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
From:   Jeff Layton <jlayton@kernel.org>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        NeilBrown <neilb@suse.de>, adilger.kernel@dilger.ca,
        djwong@kernel.org, david@fromorbit.com, trondmy@hammerspace.com,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, brauner@kernel.org,
        fweimer@redhat.com, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org
Date:   Mon, 12 Sep 2022 07:42:16 -0400
In-Reply-To: <20220910145600.GA347@fieldses.org>
References: <166259786233.30452.5417306132987966849@noble.neil.brown.name>
         <20220908083326.3xsanzk7hy3ff4qs@quack3> <YxoIjV50xXKiLdL9@mit.edu>
         <02928a8c5718590bea5739b13d6b6ebe66cac577.camel@kernel.org>
         <20220908155605.GD8951@fieldses.org>
         <9e06c506fd6b3e3118da0ec24276e85ea3ee45a1.camel@kernel.org>
         <20220908182252.GA18939@fieldses.org>
         <44efe219dbf511492b21a653905448d43d0f3363.camel@kernel.org>
         <20220909154506.GB5674@fieldses.org>
         <125df688dbebaf06478b0911e76e228e910b04b3.camel@kernel.org>
         <20220910145600.GA347@fieldses.org>
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

On Sat, 2022-09-10 at 10:56 -0400, J. Bruce Fields wrote:
> On Fri, Sep 09, 2022 at 12:36:29PM -0400, Jeff Layton wrote:
> > On Fri, 2022-09-09 at 11:45 -0400, J. Bruce Fields wrote:
> > > On Thu, Sep 08, 2022 at 03:07:58PM -0400, Jeff Layton wrote:
> > > > On Thu, 2022-09-08 at 14:22 -0400, J. Bruce Fields wrote:
> > > > > On Thu, Sep 08, 2022 at 01:40:11PM -0400, Jeff Layton wrote:
> > > > > > Yeah, ok. That does make some sense. So we would mix this into =
the
> > > > > > i_version instead of the ctime when it was available. Preferabl=
y, we'd
> > > > > > mix that in when we store the i_version rather than adding it a=
fterward.
> > > > > >=20
> > > > > > Ted, how would we access this? Maybe we could just add a new (g=
eneric)
> > > > > > super_block field for this that ext4 (and other filesystems) co=
uld
> > > > > > populate at mount time?
> > > > >=20
> > > > > Couldn't the filesystem just return an ino_version that already i=
ncludes
> > > > > it?
> > > > >=20
> > > >=20
> > > > Yes. That's simple if we want to just fold it in during getattr. If=
 we
> > > > want to fold that into the values stored on disk, then I'm a little=
 less
> > > > clear on how that will work.
> > > >=20
> > > > Maybe I need a concrete example of how that will work:
> > > >=20
> > > > Suppose we have an i_version value X with the previous crash counte=
r
> > > > already factored in that makes it to disk. We hand out a newer vers=
ion
> > > > X+1 to a client, but that value never makes it to disk.
> > > >=20
> > > > The machine crashes and comes back up, and we get a query for i_ver=
sion
> > > > and it comes back as X. Fine, it's an old version. Now there is a w=
rite.
> > > > What do we do to ensure that the new value doesn't collide with X+1=
?=20
> > >=20
> > > I was assuming we could partition i_version's 64 bits somehow: e.g., =
top
> > > 16 bits store the crash counter.  You increment the i_version by: 1)
> > > replacing the top bits by the new crash counter, if it has changed, a=
nd
> > > 2) incrementing.
> > >=20
> > > Do the numbers work out?  2^16 mounts after unclean shutdowns sounds
> > > like a lot for one filesystem, as does 2^48 changes to a single file,
> > > but people do weird things.  Maybe there's a better partitioning, or
> > > some more flexible way of maintaining an i_version that still allows =
you
> > > to identify whether a given i_version preceded a crash.
> > >=20
> >=20
> > We consume one bit to keep track of the "seen" flag, so it would be a
> > 16+47 split. I assume that we'd also reset the version counter to 0 whe=
n
> > the crash counter changes? Maybe that doesn't matter as long as we don'=
t
> > overflow into the crash counter.
> >=20
> > I'm not sure we can get away with 16 bits for the crash counter, as
> > it'll leave us subject to the version counter wrapping after a long
> > uptimes.=20
> >=20
> > If you increment a counter every nanosecond, how long until that counte=
r
> > wraps? With 63 bits, that's 292 years (and change). With 16+47 bits,
> > that's less than two days. An 8+55 split would give us ~416 days which
> > seems a bit more reasonable?
>=20
> Though now it's starting to seem a little limiting to allow only 2^8
> mounts after unclean shutdowns.
>=20
> Another way to think of it might be: multiply that 8-bit crash counter
> by 2^48, and think of it as a 64-bit value that we believe (based on
> practical limits on how many times you can modify a single file) is
> gauranteed to be larger than any i_version that we gave out before the
> most recent crash.
>=20
> Our goal is to ensure that after a crash, any *new* i_versions that we
> give out or write to disk are larger than any that have previously been
> given out.  We can do that by ensuring that they're equal to at least
> that old maximum.
>=20
> So think of the 64-bit value we're storing in the superblock as a
> ceiling on i_version values across all the filesystem's inodes.  Call it
> s_version_max or something.  We also need to know what the maximum was
> before the most recent crash.  Call that s_version_max_old.
>=20
> Then we could get correct behavior if we generated i_versions with
> something like:
>=20
> 	i_version++;
> 	if (i_version < s_version_max_old)
> 		i_version =3D s_version_max_old;
> 	if (i_version > s_version_max)
> 		s_version_max =3D i_version + 1;
>=20
> But that last step makes this ludicrously expensive, because for this to
> be safe across crashes we need to update that value on disk as well, and
> we need to do that frequently.
>=20
> Fortunately, s_version_max doesn't have to be a tight bound at all.  We
> can easily just initialize it to, say, 2^40, and only bump it by 2^40 at
> a time.  And recognize when we're running up against it way ahead of
> time, so we only need to say "here's an updated value, could you please
> make sure it gets to disk sometime in the next twenty minutes"?
> (Numbers made up.)
>=20
> Sorry, that was way too many words.  But I think something like that
> could work, and make it very difficult to hit any hard limits, and
> actually not be too complicated??  Unless I missed something.
>=20

That's not too many words -- I appreciate a good "for dummies"
explanation!

A scheme like that could work. It might be hard to do it without a
spinlock or something, but maybe that's ok. Thinking more about how we'd
implement this in the underlying filesystems:

To do this we'd need 2 64-bit fields in the on-disk and in-memory=20
superblocks for ext4, xfs and btrfs. On the first mount after a crash,
the filesystem would need to bump s_version_max by the significant
increment (2^40 bits or whatever). On a "clean" mount, it wouldn't need
to do that.

Would there be a way to ensure that the new s_version_max value has made
it to disk? Bumping it by a large value and hoping for the best might be
ok for most cases, but there are always outliers, so it might be
worthwhile to make an i_version increment wait on that if necessary.=20
--=20
Jeff Layton <jlayton@kernel.org>
