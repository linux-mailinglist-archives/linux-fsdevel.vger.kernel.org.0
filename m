Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A7A77DCD9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 10:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243006AbjHPI4z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 04:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243172AbjHPI4q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 04:56:46 -0400
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050:0:465::103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF7110C8;
        Wed, 16 Aug 2023 01:56:43 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4RQhny66Szz9sT7;
        Wed, 16 Aug 2023 10:56:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
        t=1692176198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ms2B8hw9nJax/TMsNoRDe/x9trl313HzGXwhTIo3l9w=;
        b=BKa3jKqFfjyb3DkcDsg1tK9eMRAuJfoVHmkAqueUNoaHRoMHGpU3938BSNxkAodadlv5op
        6AVCvdJLIXSlYmD2rQKLA9+1IEwcUSSaJx+NYW8t1jAzEZiJV9q4t7ZrWSzzvpJg4g56wk
        +QwcqSs1R2scGEHVUyxe2xxlmboI46RneK7mXKE0ne26ZsXnNOab+bdhM1ZM8fxAfIRXti
        thCIT5EZ4zC1E+eTyLb7yRgH6eQV8AR/OHE3sl95qsqxLoS2f7NmodQaIyhe/5Z4Mtl1X+
        XR/fovFxbFID8kx5NeuIV0kE+0SLq8IOigixlL2LKGpoyBR3OltBPQZnJjeL3w==
Date:   Wed, 16 Aug 2023 18:56:25 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Sargun Dhillon <sargun@sargun.me>, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/3] fs: Allow user to lock mount attributes with
 mount_setattr
Message-ID: <20230816.081541-lush.apricots.naughty.importer-1AIDZGMF3bd@cyphar.com>
References: <20230810090044.1252084-1-sargun@sargun.me>
 <20230810090044.1252084-2-sargun@sargun.me>
 <20230815-ableisten-offiziell-9b4de6357f7c@brauner>
 <CAMp4zn_RM+X8PBkAxXSuXrxbLTb2ndzVNXt10eaWj4uyWna30w@mail.gmail.com>
 <20230816-gauner-ehrung-95dc455055a0@brauner>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tpidzyxiu2ffujww"
Content-Disposition: inline
In-Reply-To: <20230816-gauner-ehrung-95dc455055a0@brauner>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--tpidzyxiu2ffujww
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-08-16, Christian Brauner <brauner@kernel.org> wrote:
> On Tue, Aug 15, 2023 at 06:46:33AM -0700, Sargun Dhillon wrote:
> > On Tue, Aug 15, 2023 at 2:30=E2=80=AFAM Christian Brauner <brauner@kern=
el.org> wrote:
> > >
> > > On Thu, Aug 10, 2023 at 02:00:43AM -0700, Sargun Dhillon wrote:
> > > > We support locking certain mount attributes in the kernel. This API
> > > > isn't directly exposed to users. Right now, users can lock mount
> > > > attributes by going through the process of creating a new user
> > > > namespaces, and when the mounts are copied to the "lower privilege"
> > > > domain, they're locked. The mount can be reopened, and passed around
> > > > as a "locked mount".
> > >
> > > Not sure if that's what you're getting at but you can actually fully
> > > create these locked mounts already:
> > >
> > > P1                                                 P2
> > > # init userns + init mountns                       # init userns + in=
it mountns
> > > sudo mount --bind /foo /bar
> > > sudo mount --bind -o ro,nosuid,nodev,noexec /bar
> > >
> > > # unprivileged userns + unprivileged mountns
> > > unshare --mount --user --map-root
> > >
> > > mount --bind -oremount
> > >
> > > fd =3D open_tree(/bar, OPEN_TREE_CLONE)
> > >
> > > send(fd_send, P2);
> > >
> > >                                                    recv(&fd_recv, P1)
> > >
> > >                                                    move_mount(fd_recv=
, /locked-mnt);
> > >
> > > and now you have a fully locked mount on the host for P2. Did you mea=
n that?
> > >
> >=20
> > Yep. Doing this within a program without clone / fork is awkward. Forki=
ng and
> > unsharing in random C++ programs doesn't always go super well, so in my
> > mind it'd be nice to have an API to do this directly.
> >=20
> > In addition, having the superblock continue to be owned by the userns t=
hat
> > its mounted in is nice because then they can toggle the other mount att=
ributes
> > (nodev, nosuid, noexec are the ones we care about).
> >=20
> > > >
> > > > Locked mounts are useful, for example, in container execution witho=
ut
> > > > user namespaces, where you may want to expose some host data as read
> > > > only without allowing the container to remount the mount as mutable.
> > > >
> > > > The API currently requires that the given privilege is taken away
> > > > while or before locking the flag in the less privileged position.
> > > > This could be relaxed in the future, where the user is allowed to
> > > > remount the mount as read only, but once they do, they cannot make
> > > > it read only again.
> > >
> > > s/read only/read write/
> > >
> > > >
> > > > Right now, this allows for all flags that are lockable via the
> > > > userns unshare trick to be locked, other than the atime related
> > > > ones. This is because the semantics of what the "less privileged"
> > > > position is around the atime flags is unclear.
> > >
> > > I think that atime stuff doesn't really make sense to expose to
> > > userspace. That seems a bit pointless imho.
> > >
> > > >
> > > > Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> > > > ---
> > > >  fs/namespace.c             | 40 ++++++++++++++++++++++++++++++++++=
+---
> > > >  include/uapi/linux/mount.h |  2 ++
> > > >  2 files changed, 39 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/fs/namespace.c b/fs/namespace.c
> > > > index 54847db5b819..5396e544ac84 100644
> > > > --- a/fs/namespace.c
> > > > +++ b/fs/namespace.c
> > > > @@ -78,6 +78,7 @@ static LIST_HEAD(ex_mountpoints); /* protected by=
 namespace_sem */
> > > >  struct mount_kattr {
> > > >       unsigned int attr_set;
> > > >       unsigned int attr_clr;
> > > > +     unsigned int attr_lock;
> > >
> > > So when I originally noted down this crazy idea
> > > https://github.com/uapi-group/kernel-features
> > > I didn't envision a new struct member but rather a flag that could be
> > > raised in attr_set like MOUNT_ATTR_LOCK that would indicate for the
> > > other flags in attr_set to become locked.
> > >
> > > So if we could avoid growing the struct pointlessly I'd prefer that. =
Is
> > > there a reason that wouldn't work?
> > No reason. The semantics were just a little more awkward, IMHO.
> > Specifically:
> > * This attr could never be cleared, only set, which didn't seem to foll=
ow
> > the attr_set / attr_clr semantics
> > * If we ever introduced a mount_getattr call, you'd want to expose
> > each of the locked bits independently, I'd think, and exposing
> > that through one flag wouldn't give you the same fidelity.
>=20
> Hm, right. So it's either new flags or a new member. @Aleksa?

I like ->attr_lock more tbh, especially since they cannot be cleared.
They are implemented as mount flags internally, but conceptually locking
flags is a separate thing to setting them.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--tpidzyxiu2ffujww
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZNyPOAAKCRAol/rSt+lE
byOxAP9NofYvu/DmC0bMVuwkFBH6tecUjIlDVJFumvK/GCbwmgEAosUX+/+aSC+r
eDoZDVj6qA5adPgTimSq0G4+ibZjEwo=
=dJ14
-----END PGP SIGNATURE-----

--tpidzyxiu2ffujww--
