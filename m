Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1BC5AF570
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Sep 2022 22:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbiIFUHf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Sep 2022 16:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiIFUHI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Sep 2022 16:07:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE080B959D;
        Tue,  6 Sep 2022 13:02:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8D72616BD;
        Tue,  6 Sep 2022 19:55:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03CE8C433C1;
        Tue,  6 Sep 2022 19:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662494115;
        bh=6i7lr427IxGhPiuy5/6nMg/d/7/AE1l1MM7NVDF5UqY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=YG/66iew6yKNxCZmbqO9wPKHaC/GKiFAw6fUHNDCW6B7DrRgsPn8qgmvQUSU8qo/5
         bAUbpKZHZfW4ktDB94hHO5uo1dxrPiW82iUM2MXU0vpNZGOIbNhJTSfet8L6m7nCb7
         Z5WGNxaXZmIkeqqVEXIbvsXJ/hvfnhhCPBvhclUGpsPXNoF497bUGKu7CBlPu4QTo0
         JsV9FwvY9YHEY5B+fD7j1Ylt+LsZHg0jUuq6jLhqfG9h1zQGsjpzWo2ttwk63P1Ntl
         kAe8/qEbeMhiuSOoLnYRqRDASb8qLiOzmFKmsTryIN67zxqKsgm+xtqn3j4sY7RbJH
         Rx2qxA0DqucJg==
Message-ID: <826554795cafa9495f13e08109682f939d71b92d.camel@kernel.org>
Subject: Re: [RFC PATCH v2] statx, inode: document the new STATX_INO_VERSION
 field
From:   Jeff Layton <jlayton@kernel.org>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Florian Weimer <fweimer@redhat.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, djwong@kernel.org, david@fromorbit.com,
        trondmy@hammerspace.com, neilb@suse.de, viro@zeniv.linux.org.uk,
        zohar@linux.ibm.com, xiubli@redhat.com, chuck.lever@oracle.com,
        lczerner@redhat.com, jack@suse.cz, brauner@kernel.org,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Date:   Tue, 06 Sep 2022 15:55:11 -0400
In-Reply-To: <20220906192937.GE25323@fieldses.org>
References: <20220901121714.20051-1-jlayton@kernel.org>
         <874jxrqdji.fsf@oldenburg.str.redhat.com>
         <81e57e81e4570d1659098f2bbc7c9049a605c5e8.camel@kernel.org>
         <87ilm066jh.fsf@oldenburg.str.redhat.com>
         <d1ee62062c3f805460b7bdf2776e759be4dba43f.camel@kernel.org>
         <b8b0c5adc6598c57fb109447e3bc54492b54c36a.camel@kernel.org>
         <20220906192937.GE25323@fieldses.org>
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

On Tue, 2022-09-06 at 15:29 -0400, J. Bruce Fields wrote:
> On Tue, Sep 06, 2022 at 01:04:05PM -0400, Jeff Layton wrote:
> > On Tue, 2022-09-06 at 12:41 -0400, Jeff Layton wrote:
> > > On Tue, 2022-09-06 at 14:17 +0200, Florian Weimer wrote:
> > > > * Jeff Layton:
> > > >=20
> > > > > All of the existing implementations use all 64 bits. If you were =
to
> > > > > increment a 64 bit value every nanosecond, it will take >500 year=
s for
> > > > > it to wrap. I'm hoping that's good enough. ;)
> > > > >=20
> > > > > The implementation that all of the local Linux filesystems use tr=
ack
> > > > > whether the value has been queried using one bit, so there you on=
ly get
> > > > > 63 bits of counter.
> > > > >=20
> > > > > My original thinking here was that we should leave the spec "loos=
e" to
> > > > > allow for implementations that may not be based on a counter. E.g=
. could
> > > > > some filesystem do this instead by hashing certain metadata?
> > > >=20
> > > > Hashing might have collisions that could be triggered deliberately,=
 so
> > > > probably not a good idea.  It's also hard to argue that random
> > > > collisions are unlikely.
> > > >=20
> > >=20
> > > In principle, if a filesystem could guarantee enough timestamp
> > > resolution, it's possible collisions could be hard to achieve. It's a=
lso
> > > possible you could factor in other metadata that wasn't necessarily
> > > visible to userland to try and ensure uniqueness in the counter.
> > >=20
> > > Still...
>=20
> I've got one other nagging worry, about the ordering of change attribute
> updates with respect to their corresponding changes.  I think with
> current implementations it's possible that the only change attribute
> update(s) may happen while the old file data is still visible, which
> means a concurrent reader could cache the old data with the new change
> attribute, and be left with a stale cache indefinitely.
>=20

Yeah, that's a potential issue. The i_version is updated in
inode_update_time, which does happen before the write to the pagecache.

We should probably add a note to the manpage that one should not expect
any sort of atomicity between the change to the inode and the change in
the value. I'm not sure we can offer much in the way of mitigation for
that problem, otherwise.

> For the purposes of close-to-open semantics I think that's not a
> problem, though.
>=20
> There may be some previous discussion of this in mailing list archives.
>=20

--=20
Jeff Layton <jlayton@kernel.org>
