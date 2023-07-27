Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D875765044
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 11:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbjG0Jt7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 05:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbjG0Jtx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 05:49:53 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19FB358E
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 02:49:26 -0700 (PDT)
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com [209.85.219.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8133E40822
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 09:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1690451297;
        bh=WTLnGBvjCSqP+5BtDwi+mG3Apzjq6Uh/eJ7UyBfPVTU=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=n2AEJzcHbFqQQftkA8ZUuuXkz/5RuOMQqzHig86bmr2/OHpQYSSvDEfVb5KH91Rcq
         ONB/L8V2bz99j8xBSEbyLRegFoq2ptf/UZgc1fuWSjecbxmQjR2HNad4cPo0ytURtV
         Xt168Ozm8uPOCitD/8J++ST3C8P1prvGrG4lJ585P3XadEyaQ5rrjSzTuAwCFCedal
         C/+xiOZcDC5QOUEmPrDfkyWMW56EP6jUsUge/3TsOQDyep9hLFYVt4VgdGEckQ+0it
         jTHCceYYQSjrsCAnHuZSQftV0MGPkgwP8Jep8zVvmAju7UTT1J6wfr/Foo8FmDqwGP
         np/XXHgNZQy9Q==
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-d11f35a0d5cso737609276.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 02:48:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690451296; x=1691056096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WTLnGBvjCSqP+5BtDwi+mG3Apzjq6Uh/eJ7UyBfPVTU=;
        b=YSzqeLT5Zew4wJlKJDKYGIORmVcKks7+etAQm5IDBbMPueHfTo7hw7O4fNKYawgJfP
         hKySKy3T4hwnuypF001bFi4jM10VlGw0uja5UgNih+guvm4QBqDJyXBIu7g2OI9YmrRx
         g36SfPa9xve88Dz/VH2DznR3TlZutrUSoOkudwS86y6sxhsieoZkiCroMaaDdCVX+8Zj
         5USC/oqCf7gZmaz/OJDynQGjNr5sRQ2nI4m35k1uI4x5heez9Fw4vQ8yqxBhLnSboXP/
         g+aj9TTfFrDNXdW44X2Yw2LUBBm2NBDf6UJzasxgI2KdgzYWiBJwa340IA80srKxRti/
         6hoQ==
X-Gm-Message-State: ABy/qLaj83efhTcVldjXl9XpQ8XHLvjxExVf8wHgj8ZgaP0ILdCGU5mD
        4TU6B84B+PP1mV2HD6YG8uYuZBuE+WKZIrX/ihqBGLD8yJXK7N/x+/yh435A0E3MWXBa2qht5x+
        kwSRJ1L0JkKKN+HNgLGXgTtzT2gE0Gh7C2S8oqjVWyCUEOIRcK2VlB8UjCNY=
X-Received: by 2002:a25:aa44:0:b0:d08:5a25:e6b4 with SMTP id s62-20020a25aa44000000b00d085a25e6b4mr4275035ybi.28.1690451296224;
        Thu, 27 Jul 2023 02:48:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF5+2BQCM2TmchCezsz6wmmafSVYHnLcCDnM9U7L5fvA1biqUyUssGgCHz0KOjLvo/zIZX6Plh7IdUY3k7yM1c=
X-Received: by 2002:a25:aa44:0:b0:d08:5a25:e6b4 with SMTP id
 s62-20020a25aa44000000b00d085a25e6b4mr4275022ybi.28.1690451295998; Thu, 27
 Jul 2023 02:48:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230726141026.307690-1-aleksandr.mikhalitsyn@canonical.com>
 <20230726141026.307690-4-aleksandr.mikhalitsyn@canonical.com>
 <6ea8bf93-b456-bda4-b39d-a43328987ac9@redhat.com> <CAEivzxeQubvas2yPFYRRXr3BP7pp1HNM3b7C-PQQWy-0FpFKuQ@mail.gmail.com>
 <20230727-bedeuten-endkampf-22c87edd132b@brauner>
In-Reply-To: <20230727-bedeuten-endkampf-22c87edd132b@brauner>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Thu, 27 Jul 2023 11:48:04 +0200
Message-ID: <CAEivzxcx31k3M1jWhhDrx6jxYtw=VOd84N-cMNWc+BZjq6QuFQ@mail.gmail.com>
Subject: Re: [PATCH v7 03/11] ceph: handle idmapped mounts in create_request_message()
To:     Christian Brauner <brauner@kernel.org>
Cc:     Xiubo Li <xiubli@redhat.com>, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
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

On Thu, Jul 27, 2023 at 11:01=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Thu, Jul 27, 2023 at 08:36:40AM +0200, Aleksandr Mikhalitsyn wrote:
> > On Thu, Jul 27, 2023 at 7:30=E2=80=AFAM Xiubo Li <xiubli@redhat.com> wr=
ote:
> > >
> > >
> > > On 7/26/23 22:10, Alexander Mikhalitsyn wrote:
> > > > Inode operations that create a new filesystem object such as ->mkno=
d,
> > > > ->create, ->mkdir() and others don't take a {g,u}id argument explic=
itly.
> > > > Instead the caller's fs{g,u}id is used for the {g,u}id of the new
> > > > filesystem object.
> > > >
> > > > In order to ensure that the correct {g,u}id is used map the caller'=
s
> > > > fs{g,u}id for creation requests. This doesn't require complex chang=
es.
> > > > It suffices to pass in the relevant idmapping recorded in the reque=
st
> > > > message. If this request message was triggered from an inode operat=
ion
> > > > that creates filesystem objects it will have passed down the releva=
nt
> > > > idmaping. If this is a request message that was triggered from an i=
node
> > > > operation that doens't need to take idmappings into account the ini=
tial
> > > > idmapping is passed down which is an identity mapping.
> > > >
> > > > This change uses a new cephfs protocol extension CEPHFS_FEATURE_HAS=
_OWNER_UIDGID
> > > > which adds two new fields (owner_{u,g}id) to the request head struc=
ture.
> > > > So, we need to ensure that MDS supports it otherwise we need to fai=
l
> > > > any IO that comes through an idmapped mount because we can't proces=
s it
> > > > in a proper way. MDS server without such an extension will use call=
er_{u,g}id
> > > > fields to set a new inode owner UID/GID which is incorrect because =
caller_{u,g}id
> > > > values are unmapped. At the same time we can't map these fields wit=
h an
> > > > idmapping as it can break UID/GID-based permission checks logic on =
the
> > > > MDS side. This problem was described with a lot of details at [1], =
[2].
> > > >
> > > > [1] https://lore.kernel.org/lkml/CAEivzxfw1fHO2TFA4dx3u23ZKK6Q+EThf=
zuibrhA3RKM=3DZOYLg@mail.gmail.com/
> > > > [2] https://lore.kernel.org/all/20220104140414.155198-3-brauner@ker=
nel.org/
> > > >
> > > > Cc: Xiubo Li <xiubli@redhat.com>
> > > > Cc: Jeff Layton <jlayton@kernel.org>
> > > > Cc: Ilya Dryomov <idryomov@gmail.com>
> > > > Cc: ceph-devel@vger.kernel.org
> > > > Co-Developed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canon=
ical.com>
> > > > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > > > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonic=
al.com>
> > > > ---
> > > > v7:
> > > >       - reworked to use two new fields for owner UID/GID (https://g=
ithub.com/ceph/ceph/pull/52575)
> > > > ---
> > > >   fs/ceph/mds_client.c         | 20 ++++++++++++++++++++
> > > >   fs/ceph/mds_client.h         |  5 ++++-
> > > >   include/linux/ceph/ceph_fs.h |  4 +++-
> > > >   3 files changed, 27 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > > > index c641ab046e98..ac095a95f3d0 100644
> > > > --- a/fs/ceph/mds_client.c
> > > > +++ b/fs/ceph/mds_client.c
> > > > @@ -2923,6 +2923,7 @@ static struct ceph_msg *create_request_messag=
e(struct ceph_mds_session *session,
> > > >   {
> > > >       int mds =3D session->s_mds;
> > > >       struct ceph_mds_client *mdsc =3D session->s_mdsc;
> > > > +     struct ceph_client *cl =3D mdsc->fsc->client;
> > > >       struct ceph_msg *msg;
> > > >       struct ceph_mds_request_head_legacy *lhead;
> > > >       const char *path1 =3D NULL;
> > > > @@ -3028,6 +3029,16 @@ static struct ceph_msg *create_request_messa=
ge(struct ceph_mds_session *session,
> > > >       lhead =3D find_legacy_request_head(msg->front.iov_base,
> > > >                                        session->s_con.peer_features=
);
> > > >
> > > > +     if ((req->r_mnt_idmap !=3D &nop_mnt_idmap) &&
> > > > +         !test_bit(CEPHFS_FEATURE_HAS_OWNER_UIDGID, &session->s_fe=
atures)) {
> > > > +             pr_err_ratelimited_client(cl,
> > > > +                     "idmapped mount is used and CEPHFS_FEATURE_HA=
S_OWNER_UIDGID"
> > > > +                     " is not supported by MDS. Fail request with =
-EIO.\n");
> > > > +
> > > > +             ret =3D -EIO;
> > > > +             goto out_err;
> > > > +     }
> > > > +
> > >
> > > I think this couldn't fail the mounting operation, right ?
> >
> > This won't fail mounting. First of all an idmapped mount is always an
> > additional mount, you always
> > start from doing "normal" mount and only after that you can use this
> > mount to create an idmapped one.
> > ( example: https://github.com/brauner/mount-idmapped/tree/master )
> >
> > >
> > > IMO we should fail the mounting from the beginning.
> >
> > Unfortunately, we can't fail mount from the beginning. Procedure of
> > the idmapped mounts
> > creation is handled not on the filesystem level, but on the VFS level
>
> Correct. It's a generic vfsmount feature.
>
> > (source: https://github.com/torvalds/linux/blob/0a8db05b571ad5b8d5c8774=
a004c0424260a90bd/fs/namespace.c#L4277
> > )
> >
> > Kernel perform all required checks as:
> > - filesystem type has declared to support idmappings
> > (fs_type->fs_flags & FS_ALLOW_IDMAP)
> > - user who creates idmapped mount should be CAP_SYS_ADMIN in a user
> > namespace that owns superblock of the filesystem
> > (for cephfs it's always init_user_ns =3D> user should be root on the ho=
st)
> >
> > So I would like to go this way because of the reasons mentioned above:
> > - root user is someone who understands what he does.
> > - idmapped mounts are never "first" mounts. They are always created
> > after "normal" mount.
> > - effectively this check makes "normal" mount to work normally and
> > fail only requests that comes through an idmapped mounts
> > with reasonable error message. Obviously, all read operations will
> > work perfectly well only the operations that create new inodes will
> > fail.
> > Btw, we already have an analogical semantic on the VFS level for users
> > who have no UID/GID mapping to the host. Filesystem requests for
> > such users will fail with -EOVERFLOW. Here we have something close.
>
> Refusing requests coming from an idmapped mount if the server misses
> appropriate features is good enough as a first step imho. And yes, we do
> have similar logic on the vfs level for unmapped uid/gid.

Thanks, Christian!

I wanted to add that alternative here is to modify caller_{u,g}id
fields as it was done in the first approach,
it will break the UID/GID-based permissions model for old MDS versions
(we can put printk_once to inform user about this),
but at the same time it will allow us to support idmapped mounts in
all cases. This support will be not fully ideal for old MDS
 and perfectly well for new MDS versions.

Alternatively, we can introduce cephfs mount option like
"idmap_with_old_mds" and if it's enabled then we set caller_{u,g}id
for MDS without CEPHFS_FEATURE_HAS_OWNER_UIDGID, if it's disabled
(default) we fail requests with -EIO. For
new MDS everything goes in the right way.

Kind regards,
Alex
