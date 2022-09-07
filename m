Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4585B0749
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Sep 2022 16:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiIGOnm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Sep 2022 10:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiIGOnP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Sep 2022 10:43:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19927956BA;
        Wed,  7 Sep 2022 07:43:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 745D9B81D4C;
        Wed,  7 Sep 2022 14:43:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC28BC433D6;
        Wed,  7 Sep 2022 14:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662561791;
        bh=RJUuE6TtbAEmyXO144jflnrUxtajEUR5AU9O8xs0fkA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=G3Mqs2auJIxQBypGYorryf7m3qZLDZrNkCO2Ze1TQVFb6eeUpsTrFjepv3AgkfcUO
         N7rmiK+hknBW94epBcdF3wYws+2vefcFR/8VL26f0xi4GPORhEtyhN/SS0wBlZrv6G
         C+OufpGojYQTqW4iDUIONf6B6VD1TUrNY7dPEAJ3Yoy7udhhp2mQ0FII/UALu9pTyl
         JE2X4fC5LAY0K5ZTwdx1AumiYyRGDARwPNX2qzHQWvZNSTOiM7QDDlla4LpeaBPFmY
         sdwQCneyPDbAD6Nv10StzJ4VY1Bekdy1/k/Lr61M7W8oHoiYa6yXzN/X9iTJRLol3t
         xg9VTtkCFaUUg==
Message-ID: <36e2a19ea789aca3c1cdc9a93b26285b6e7b428c.camel@kernel.org>
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
From:   Jeff Layton <jlayton@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        NeilBrown <neilb@suse.de>, tytso@mit.edu,
        adilger.kernel@dilger.ca, djwong@kernel.org, david@fromorbit.com,
        trondmy@hammerspace.com, viro@zeniv.linux.org.uk,
        zohar@linux.ibm.com, xiubli@redhat.com, chuck.lever@oracle.com,
        lczerner@redhat.com, brauner@kernel.org, fweimer@redhat.com,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Date:   Wed, 07 Sep 2022 10:43:07 -0400
In-Reply-To: <20220907135153.qvgibskeuz427abw@quack3>
References: <20220907111606.18831-1-jlayton@kernel.org>
         <166255065346.30452.6121947305075322036@noble.neil.brown.name>
         <79aaf122743a295ddab9525d9847ac767a3942aa.camel@kernel.org>
         <20220907125211.GB17729@fieldses.org>
         <771650a814ab1ff4dc5473d679936b747d9b6cf5.camel@kernel.org>
         <20220907135153.qvgibskeuz427abw@quack3>
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

On Wed, 2022-09-07 at 15:51 +0200, Jan Kara wrote:
> On Wed 07-09-22 09:12:34, Jeff Layton wrote:
> > On Wed, 2022-09-07 at 08:52 -0400, J. Bruce Fields wrote:
> > > On Wed, Sep 07, 2022 at 08:47:20AM -0400, Jeff Layton wrote:
> > > > On Wed, 2022-09-07 at 21:37 +1000, NeilBrown wrote:
> > > > > On Wed, 07 Sep 2022, Jeff Layton wrote:
> > > > > > +The change to \fIstatx.stx_ino_version\fP is not atomic with r=
espect to the
> > > > > > +other changes in the inode. On a write, for instance, the i_ve=
rsion it usually
> > > > > > +incremented before the data is copied into the pagecache. Ther=
efore it is
> > > > > > +possible to see a new i_version value while a read still shows=
 the old data.
> > > > >=20
> > > > > Doesn't that make the value useless?
> > > > >=20
> > > >=20
> > > > No, I don't think so. It's only really useful for comparing to an o=
lder
> > > > sample anyway. If you do "statx; read; statx" and the value hasn't
> > > > changed, then you know that things are stable.=20
> > >=20
> > > I don't see how that helps.  It's still possible to get:
> > >=20
> > > 		reader		writer
> > > 		------		------
> > > 				i_version++
> > > 		statx
> > > 		read
> > > 		statx
> > > 				update page cache
> > >=20
> > > right?
> > >=20
> >=20
> > Yeah, I suppose so -- the statx wouldn't necessitate any locking. In
> > that case, maybe this is useless then other than for testing purposes
> > and userland NFS servers.
> >=20
> > Would it be better to not consume a statx field with this if so? What
> > could we use as an alternate interface? ioctl? Some sort of global
> > virtual xattr? It does need to be something per-inode.
>=20
> I was thinking how hard would it be to increment i_version after updating
> data but it will be rather hairy. In particular because of stuff like
> IOCB_NOWAIT support which needs to bail if i_version update is needed. So
> yeah, I don't think there's an easy way how to provide useful i_version f=
or
> general purpose use.
>=20

Yeah, it does look ugly.

Another idea might be to just take the i_rwsem for read in the statx
codepath when STATX_INO_VERSION has been requested. xfs, ext4 and btrfs
hold the i_rwsem exclusively over their buffered write ops. Doing that
should be enough to prevent the race above, I think. The ext4 DAX path
also looks ok there.

The ext4 DIO write implementation seems to take the i_rwsem for read
though unless the size is changing or the write is unaligned. So a
i_rwsem readlock would probably not be enough to guard against changes
there. Maybe we can just say if you're doing DIO, then don't expect real
atomicity wrt i_version?

knfsd seems to already hold i_rwsem when doing directory morphing
operations (where it fetches the pre and post attrs), but it doesn't
take it when calling nfsd4_encode_fattr (which is used to fill out
GETATTR and READDIR replies, etc.). We'd probably have to start taking
it in those codepaths too.

We should also bear in mind that from userland, doing a read of a normal
file and fetching the i_version takes two different syscalls. I'm not
sure we need things to be truly "atomic", per-se. Whether and how we can
exploit that fact, I'm not sure.
--=20
Jeff Layton <jlayton@kernel.org>
