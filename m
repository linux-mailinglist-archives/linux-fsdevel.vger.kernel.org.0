Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506BC7656A3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 17:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbjG0PBF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 11:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233918AbjG0PBC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:01:02 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D0C3A97
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 08:00:44 -0700 (PDT)
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com [209.85.219.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 41AB4413BF
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 15:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1690470042;
        bh=1D6+NiWp32kZlSL9CJ9SErawj5XjZfPW8+mnuATgg30=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=uTNbryyHQxQ4mX1A3HxwGQA/L2a4+NfYKhJ2KYB+PVrP9bVKY+z2IVYTmI5R/4dWp
         RHO6pcLm1jPBuKv/yQTbwGjTk+xZrmH8GEkceW9iKp5kPSjJPpzjR2QMpLmlMS0yHG
         88Ek5JVqvBQ6TZyG9b/pV4GBFMTB2mWoKY+pVMQYjRUb4PDOVBLy+xaVCWinKl6+Bn
         JvfU4tohtdNnqy6NbEs3Jn5wgvOlj+jY9rTkjhyxSvDNoLuAIrTo0VRcycx9mrdptE
         1h0yNUiiZvm6b8kCwrTjSDXlDOFUHuIM6T2CV20z81VDSSP5cnxW931OM4GvQogT6G
         3/MU1WDzTz5oQ==
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-d1ef70d6a02so978708276.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 08:00:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690470040; x=1691074840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1D6+NiWp32kZlSL9CJ9SErawj5XjZfPW8+mnuATgg30=;
        b=lIk7Kyun1umbfhzrYKXNaTbA7okz6xzKLYukR0spn6GS9yeFetyAe8cfQpP04yrS33
         tQWi7i4uaOJ2UK96z3u2b7wUvC8tNIaS7kICSIhLqmfZDy7AaGlgbIktabjE5cwszd/g
         svvs3Fxm3vRATS9+PlxFJ7jjfw+GYQpnvTtYjCK3Z1PWraVqiolSpAWpLwhVGGZqp/nz
         9yAKKYfQ/dQwLG/oFmkVs/Sks6AQNxuxaIQZB7jYOuEizUUgqmrswcqXtNLCoBLHvruO
         CZFrKNj2tudsDJYLQOx3ektSsn41uVgr9vlEX1xyS/u9cGSSgHbvTwPqC+7BuTvn4xQ9
         lX5Q==
X-Gm-Message-State: ABy/qLZXBtLE4LkiWZo/wUFTga283Q2q5Q8bZfacYrtEmXS1VeHeYmis
        sfYw5LAw6QtcCcBl/HvlC0WhIO33ou3Lmjv6/RPEm74EqezXzFWr6Fr560OfmiBufDQk/my42N8
        sxuFqCI/ZHkivs0/Fwnc8FNNOnbuWnaQufl+RI3f8JLJh4c6SiOUaM3gZScQ=
X-Received: by 2002:a25:b10d:0:b0:cfe:9981:2af3 with SMTP id g13-20020a25b10d000000b00cfe99812af3mr4953891ybj.20.1690470039791;
        Thu, 27 Jul 2023 08:00:39 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEjtw/DRbycdcrtGPh+fqiSHho1Sea+pOgjGTC4Hr4uhOUkRE/+MHuVkQ7t0vbVjUyRVTnskbfTgzo9k4Sgr44=
X-Received: by 2002:a25:b10d:0:b0:cfe:9981:2af3 with SMTP id
 g13-20020a25b10d000000b00cfe99812af3mr4953870ybj.20.1690470039531; Thu, 27
 Jul 2023 08:00:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230726141026.307690-1-aleksandr.mikhalitsyn@canonical.com>
 <20230726141026.307690-4-aleksandr.mikhalitsyn@canonical.com>
 <6ea8bf93-b456-bda4-b39d-a43328987ac9@redhat.com> <CAEivzxeQubvas2yPFYRRXr3BP7pp1HNM3b7C-PQQWy-0FpFKuQ@mail.gmail.com>
 <20230727-bedeuten-endkampf-22c87edd132b@brauner> <CAEivzxcx31k3M1jWhhDrx6jxYtw=VOd84N-cMNWc+BZjq6QuFQ@mail.gmail.com>
 <CA+enf=sFC-hiziuXoeDWnb7MoErc+b1PAncOjbM2rNyB4fzfwA@mail.gmail.com>
In-Reply-To: <CA+enf=sFC-hiziuXoeDWnb7MoErc+b1PAncOjbM2rNyB4fzfwA@mail.gmail.com>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Thu, 27 Jul 2023 17:00:28 +0200
Message-ID: <CAEivzxdrVWB_jj58bU7kbNBD6kGhDJu_WZSocy4q=-RZEr-wfw@mail.gmail.com>
Subject: Re: [PATCH v7 03/11] ceph: handle idmapped mounts in create_request_message()
To:     =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@ubuntu.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Xiubo Li <xiubli@redhat.com>, linux-fsdevel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 27, 2023 at 4:46=E2=80=AFPM St=C3=A9phane Graber <stgraber@ubun=
tu.com> wrote:
>
> On Thu, Jul 27, 2023 at 5:48=E2=80=AFAM Aleksandr Mikhalitsyn
> <aleksandr.mikhalitsyn@canonical.com> wrote:
> >
> > On Thu, Jul 27, 2023 at 11:01=E2=80=AFAM Christian Brauner <brauner@ker=
nel.org> wrote:
> > >
> > > On Thu, Jul 27, 2023 at 08:36:40AM +0200, Aleksandr Mikhalitsyn wrote=
:
> > > > On Thu, Jul 27, 2023 at 7:30=E2=80=AFAM Xiubo Li <xiubli@redhat.com=
> wrote:
> > > > >
> > > > >
> > > > > On 7/26/23 22:10, Alexander Mikhalitsyn wrote:
> > > > > > Inode operations that create a new filesystem object such as ->=
mknod,
> > > > > > ->create, ->mkdir() and others don't take a {g,u}id argument ex=
plicitly.
> > > > > > Instead the caller's fs{g,u}id is used for the {g,u}id of the n=
ew
> > > > > > filesystem object.
> > > > > >
> > > > > > In order to ensure that the correct {g,u}id is used map the cal=
ler's
> > > > > > fs{g,u}id for creation requests. This doesn't require complex c=
hanges.
> > > > > > It suffices to pass in the relevant idmapping recorded in the r=
equest
> > > > > > message. If this request message was triggered from an inode op=
eration
> > > > > > that creates filesystem objects it will have passed down the re=
levant
> > > > > > idmaping. If this is a request message that was triggered from =
an inode
> > > > > > operation that doens't need to take idmappings into account the=
 initial
> > > > > > idmapping is passed down which is an identity mapping.
> > > > > >
> > > > > > This change uses a new cephfs protocol extension CEPHFS_FEATURE=
_HAS_OWNER_UIDGID
> > > > > > which adds two new fields (owner_{u,g}id) to the request head s=
tructure.
> > > > > > So, we need to ensure that MDS supports it otherwise we need to=
 fail
> > > > > > any IO that comes through an idmapped mount because we can't pr=
ocess it
> > > > > > in a proper way. MDS server without such an extension will use =
caller_{u,g}id
> > > > > > fields to set a new inode owner UID/GID which is incorrect beca=
use caller_{u,g}id
> > > > > > values are unmapped. At the same time we can't map these fields=
 with an
> > > > > > idmapping as it can break UID/GID-based permission checks logic=
 on the
> > > > > > MDS side. This problem was described with a lot of details at [=
1], [2].
> > > > > >
> > > > > > [1] https://lore.kernel.org/lkml/CAEivzxfw1fHO2TFA4dx3u23ZKK6Q+=
EThfzuibrhA3RKM=3DZOYLg@mail.gmail.com/
> > > > > > [2] https://lore.kernel.org/all/20220104140414.155198-3-brauner=
@kernel.org/
> > > > > >
> > > > > > Cc: Xiubo Li <xiubli@redhat.com>
> > > > > > Cc: Jeff Layton <jlayton@kernel.org>
> > > > > > Cc: Ilya Dryomov <idryomov@gmail.com>
> > > > > > Cc: ceph-devel@vger.kernel.org
> > > > > > Co-Developed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@c=
anonical.com>
> > > > > > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > > > > > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@can=
onical.com>
> > > > > > ---
> > > > > > v7:
> > > > > >       - reworked to use two new fields for owner UID/GID (https=
://github.com/ceph/ceph/pull/52575)
> > > > > > ---
> > > > > >   fs/ceph/mds_client.c         | 20 ++++++++++++++++++++
> > > > > >   fs/ceph/mds_client.h         |  5 ++++-
> > > > > >   include/linux/ceph/ceph_fs.h |  4 +++-
> > > > > >   3 files changed, 27 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > > > > > index c641ab046e98..ac095a95f3d0 100644
> > > > > > --- a/fs/ceph/mds_client.c
> > > > > > +++ b/fs/ceph/mds_client.c
> > > > > > @@ -2923,6 +2923,7 @@ static struct ceph_msg *create_request_me=
ssage(struct ceph_mds_session *session,
> > > > > >   {
> > > > > >       int mds =3D session->s_mds;
> > > > > >       struct ceph_mds_client *mdsc =3D session->s_mdsc;
> > > > > > +     struct ceph_client *cl =3D mdsc->fsc->client;
> > > > > >       struct ceph_msg *msg;
> > > > > >       struct ceph_mds_request_head_legacy *lhead;
> > > > > >       const char *path1 =3D NULL;
> > > > > > @@ -3028,6 +3029,16 @@ static struct ceph_msg *create_request_m=
essage(struct ceph_mds_session *session,
> > > > > >       lhead =3D find_legacy_request_head(msg->front.iov_base,
> > > > > >                                        session->s_con.peer_feat=
ures);
> > > > > >
> > > > > > +     if ((req->r_mnt_idmap !=3D &nop_mnt_idmap) &&
> > > > > > +         !test_bit(CEPHFS_FEATURE_HAS_OWNER_UIDGID, &session->=
s_features)) {
> > > > > > +             pr_err_ratelimited_client(cl,
> > > > > > +                     "idmapped mount is used and CEPHFS_FEATUR=
E_HAS_OWNER_UIDGID"
> > > > > > +                     " is not supported by MDS. Fail request w=
ith -EIO.\n");
> > > > > > +
> > > > > > +             ret =3D -EIO;
> > > > > > +             goto out_err;
> > > > > > +     }
> > > > > > +
> > > > >
> > > > > I think this couldn't fail the mounting operation, right ?
> > > >
> > > > This won't fail mounting. First of all an idmapped mount is always =
an
> > > > additional mount, you always
> > > > start from doing "normal" mount and only after that you can use thi=
s
> > > > mount to create an idmapped one.
> > > > ( example: https://github.com/brauner/mount-idmapped/tree/master )
> > > >
> > > > >
> > > > > IMO we should fail the mounting from the beginning.
> > > >
> > > > Unfortunately, we can't fail mount from the beginning. Procedure of
> > > > the idmapped mounts
> > > > creation is handled not on the filesystem level, but on the VFS lev=
el
> > >
> > > Correct. It's a generic vfsmount feature.
> > >
> > > > (source: https://github.com/torvalds/linux/blob/0a8db05b571ad5b8d5c=
8774a004c0424260a90bd/fs/namespace.c#L4277
> > > > )
> > > >
> > > > Kernel perform all required checks as:
> > > > - filesystem type has declared to support idmappings
> > > > (fs_type->fs_flags & FS_ALLOW_IDMAP)
> > > > - user who creates idmapped mount should be CAP_SYS_ADMIN in a user
> > > > namespace that owns superblock of the filesystem
> > > > (for cephfs it's always init_user_ns =3D> user should be root on th=
e host)
> > > >
> > > > So I would like to go this way because of the reasons mentioned abo=
ve:
> > > > - root user is someone who understands what he does.
> > > > - idmapped mounts are never "first" mounts. They are always created
> > > > after "normal" mount.
> > > > - effectively this check makes "normal" mount to work normally and
> > > > fail only requests that comes through an idmapped mounts
> > > > with reasonable error message. Obviously, all read operations will
> > > > work perfectly well only the operations that create new inodes will
> > > > fail.
> > > > Btw, we already have an analogical semantic on the VFS level for us=
ers
> > > > who have no UID/GID mapping to the host. Filesystem requests for
> > > > such users will fail with -EOVERFLOW. Here we have something close.
> > >
> > > Refusing requests coming from an idmapped mount if the server misses
> > > appropriate features is good enough as a first step imho. And yes, we=
 do
> > > have similar logic on the vfs level for unmapped uid/gid.
> >
> > Thanks, Christian!
> >
> > I wanted to add that alternative here is to modify caller_{u,g}id
> > fields as it was done in the first approach,
> > it will break the UID/GID-based permissions model for old MDS versions
> > (we can put printk_once to inform user about this),
> > but at the same time it will allow us to support idmapped mounts in
> > all cases. This support will be not fully ideal for old MDS
> >  and perfectly well for new MDS versions.
> >
> > Alternatively, we can introduce cephfs mount option like
> > "idmap_with_old_mds" and if it's enabled then we set caller_{u,g}id
> > for MDS without CEPHFS_FEATURE_HAS_OWNER_UIDGID, if it's disabled
> > (default) we fail requests with -EIO. For
> > new MDS everything goes in the right way.
> >
> > Kind regards,
> > Alex
>
> Hey there,
>
> A very strong +1 on there needing to be some way to make this work
> with older Ceph releases.
> Ceph Reef isn't out yet and we're in July 2023, so I'd really like not
> having to wait until Ceph Squid in mid 2024 to be able to make use of
> this!
>
> Some kind of mount option, module option or the like would all be fine fo=
r this.

I really like this way. I can implement it really quickly. Let's just
agree on this :)
It looks like an ideal solution for everyone.

Kind regards,
Alex

>
> St=C3=A9phane
