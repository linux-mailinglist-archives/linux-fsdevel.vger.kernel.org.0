Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337995AF23C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Sep 2022 19:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239620AbiIFRQd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Sep 2022 13:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbiIFRQP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Sep 2022 13:16:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265A88B2CC;
        Tue,  6 Sep 2022 10:05:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26041615D2;
        Tue,  6 Sep 2022 17:04:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74117C433C1;
        Tue,  6 Sep 2022 17:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662483848;
        bh=rAhCSLOrTwfGo2FpGcX0U4IJWpbmLaG/6c1iUIC7dnU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=FahQDDB0rwfzhSId2osRUDWnjY1U/m4yS41gsexD+LH5bYuPvvbXT2rQHvJxPVG8o
         sP1SnsnrkzsknF0uE2iEtswCyPJ2OREbPEjzx9ccrZgiqEy9bly9FpuaZf2gaa5lIb
         QzwG8rP5vGj4NEM1Wqd2fKJVRF8f5LiOGulqn2lvnHkUuDvH0MmfROv5vLDuqU0+H2
         /U8hTSYQY6duVo+0w85ViCBO7YwgQRNalVB4J4Uk0Htx7TzcNilHDpUcb6HRQQXkJb
         PU1eh7g9weTpHUxz8Z3Mwlh2Woi+sPLcLKmJF2wQgsdf64nhdHGRDVdIHvO7nk0pnZ
         mG9ZmRFQ2WmcA==
Message-ID: <b8b0c5adc6598c57fb109447e3bc54492b54c36a.camel@kernel.org>
Subject: Re: [RFC PATCH v2] statx, inode: document the new STATX_INO_VERSION
 field
From:   Jeff Layton <jlayton@kernel.org>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        david@fromorbit.com, trondmy@hammerspace.com, neilb@suse.de,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, jack@suse.cz,
        bfields@fieldses.org, brauner@kernel.org,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Date:   Tue, 06 Sep 2022 13:04:05 -0400
In-Reply-To: <d1ee62062c3f805460b7bdf2776e759be4dba43f.camel@kernel.org>
References: <20220901121714.20051-1-jlayton@kernel.org>
         <874jxrqdji.fsf@oldenburg.str.redhat.com>
         <81e57e81e4570d1659098f2bbc7c9049a605c5e8.camel@kernel.org>
         <87ilm066jh.fsf@oldenburg.str.redhat.com>
         <d1ee62062c3f805460b7bdf2776e759be4dba43f.camel@kernel.org>
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

On Tue, 2022-09-06 at 12:41 -0400, Jeff Layton wrote:
> On Tue, 2022-09-06 at 14:17 +0200, Florian Weimer wrote:
> > * Jeff Layton:
> >=20
> > > All of the existing implementations use all 64 bits. If you were to
> > > increment a 64 bit value every nanosecond, it will take >500 years fo=
r
> > > it to wrap. I'm hoping that's good enough. ;)
> > >=20
> > > The implementation that all of the local Linux filesystems use track
> > > whether the value has been queried using one bit, so there you only g=
et
> > > 63 bits of counter.
> > >=20
> > > My original thinking here was that we should leave the spec "loose" t=
o
> > > allow for implementations that may not be based on a counter. E.g. co=
uld
> > > some filesystem do this instead by hashing certain metadata?
> >=20
> > Hashing might have collisions that could be triggered deliberately, so
> > probably not a good idea.  It's also hard to argue that random
> > collisions are unlikely.
> >=20
>=20
> In principle, if a filesystem could guarantee enough timestamp
> resolution, it's possible collisions could be hard to achieve. It's also
> possible you could factor in other metadata that wasn't necessarily
> visible to userland to try and ensure uniqueness in the counter.
>=20
> Still...
>=20

Actually, Bruce brought up a good point on IRC. The main danger here is
that we might do this:

Start (i_version is at 1)
write data (i_version goes to 2)
statx+read data (observer associates data with i_version of 2)
Crash, but before new i_version made it to disk
Machine comes back up (i_version back at 1)
write data (i_version goes to 2)
statx (observer assumes his cache is valid)

We can mitigate this by factoring in the ctime when we do the statx.
Another option though would be to factor in the ctime when we generate
the new value and store it.

Here's what nfsd does today:

      chattr =3D  stat->ctime.tv_sec;
      chattr <<=3D 30;
      chattr +=3D stat->ctime.tv_nsec;
      chattr +=3D inode_query_iversion(inode);

Instead of doing this after we query it, we could do that before storing
it. After a crash, we might see the value go backward, but if a new
write later happens, the new value would be very unlikely to match the
one that got lost.

That seems quite doable, and might be better for userland consumers
overall.

> > > It's arguable though that the NFSv4 spec requires that this be based =
on
> > > a counter, as the client is required to increment it in the case of
> > > write delegations.
> >=20
> > Yeah, I think it has to be monotonic.
> >=20
>=20
> I think so too. NFSv4 sort of needs that anyway.
>=20
> > > > If the system crashes without flushing disks, is it possible to obs=
erve
> > > > new file contents without a change of i_version?
> > >=20
> > > Yes, I think that's possible given the current implementations.
> > >=20
> > > We don't have a great scheme to combat that at the moment, other than
> > > looking at this in conjunction with the ctime. As long as the clock
> > > doesn't jump backward after the crash and it takes more than one jiff=
y
> > > to get the host back up, then you can be reasonably sure that
> > > i_version+ctime should never repeat.
> > >=20
> > > Maybe that's worth adding to the NOTES section of the manpage?
> >=20
> > I'd appreciate that.
>=20
> Ok! New version of the manpage patch sent. If no one has strong
> objections to the proposed docs, I'll send out new kernel patches in the
> next day or two.
>=20
> Thanks!

--=20
Jeff Layton <jlayton@kernel.org>
