Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F38F72844D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 17:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237421AbjFHPyo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 11:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236386AbjFHPyn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 11:54:43 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CF21FCC
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jun 2023 08:54:23 -0700 (PDT)
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6E1693F462
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jun 2023 15:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686239200;
        bh=RyaR97gkxxeix1gmKAnfIKIlV/8H2Db9pN/XXiJh8ZU=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=ZSj7fpDoPzQQoEuNEEXRbVBqZ1iAUovArD7dSe8zGgeFkpyQfu3m/PWHzMpk9Nr4X
         AiPW00BYelzlXBvRH0/Dns6UvWVGv9VY27UlgzuAsOIBtnxdRFcV1PH/qCBx3N8pN3
         4ZU2FneBgNcrTRYlIF0AOqt1YZuS3Qd8xRr7an77x9GARiDdLk5nh3dOfluZAn2nIY
         R/m+YzPK2k4NF2jlZJaUfu5Wm9GRvcJU4/GQAJqwfr++A5p/Kw1TiObkMJfmng6VTg
         e4DMo+n8n06UOvOuyMrxTnNPeOuP7AQYTfKDarZAC+kO6M8NA7wvhdvk7wchUNTEFk
         zicIfh3cxAvQA==
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-557d435c07cso712501eaf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jun 2023 08:46:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686239198; x=1688831198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RyaR97gkxxeix1gmKAnfIKIlV/8H2Db9pN/XXiJh8ZU=;
        b=Gdja7W/hMO5F8x7bccuMZ5evmEWsirl/wdKAvvQ16KLYSgqoPynSnrsh4zqpiaDZD8
         8HnVKxGu31FM9i0jKmhw+yi5Lf5kF4g35xCyc8atNOxEeCMnbCK3YR6Za3IWtj2evu5w
         6o10lMi+WNemO/a8Mzlqv9vjES7iPNssKhIOkFJEm7rxF9OSYZUl3q9+31jC8avGO9OS
         ytSgYhAhJRhs3j0IhcPWEUNqbJCwA3jhwCC5dltCODWt9XAtK5lAe1S9xN3yFq4SyG0R
         avxo8ub29CAAVVbMj7AAf9C+YSrbrzJJcOcy/R2iA9p5b7Rld5+F9ohYyTxu2WFasyDc
         e6NA==
X-Gm-Message-State: AC+VfDw2884hHUbBXfRXGJmHSe+u0KjPFByk39qdOq/Zrw/rsvh9BwLD
        UWaGxVlGETms7xWKfVcVypOJpIUMV99Y7oY1ccE6kxlsFjnpC/YaTEhRkwW5NJmZvnWsdvk4Fos
        BHMhFnV9PH92tVZ0CaG/gnow/AI0UZ3A4beTDIboWXCwqsYL537sXtlet97A=
X-Received: by 2002:a05:6358:e95:b0:129:cb51:7efe with SMTP id 21-20020a0563580e9500b00129cb517efemr6593623rwg.14.1686239197793;
        Thu, 08 Jun 2023 08:46:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5GrdwVlP788/m18FCJp3Hn8m8zO6nyX5cRUmH7sqvVSfU1RnwCMmPWmJgyf7zsTIVIlJdT0E9ti0o+vkF1GsE=
X-Received: by 2002:a05:6358:e95:b0:129:cb51:7efe with SMTP id
 21-20020a0563580e9500b00129cb517efemr6593615rwg.14.1686239197471; Thu, 08 Jun
 2023 08:46:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230607180958.645115-1-aleksandr.mikhalitsyn@canonical.com>
 <20230607180958.645115-12-aleksandr.mikhalitsyn@canonical.com> <f1e81edf-595b-3f7c-3f00-2c96718fbb69@redhat.com>
In-Reply-To: <f1e81edf-595b-3f7c-3f00-2c96718fbb69@redhat.com>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Thu, 8 Jun 2023 17:46:26 +0200
Message-ID: <CAEivzxeH1rBezS=+gMaEg4_2A9jweLgW7CCc7paaa=MRhh3VXQ@mail.gmail.com>
Subject: Re: [PATCH v4 11/14] ceph: allow idmapped setattr inode op
To:     Xiubo Li <xiubli@redhat.com>
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
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

On Thu, Jun 8, 2023 at 4:50=E2=80=AFAM Xiubo Li <xiubli@redhat.com> wrote:
>
>
> On 6/8/23 02:09, Alexander Mikhalitsyn wrote:
> > From: Christian Brauner <christian.brauner@ubuntu.com>
> >
> > Enable __ceph_setattr() to handle idmapped mounts. This is just a matte=
r
> > of passing down the mount's idmapping.
> >
> > Cc: Xiubo Li <xiubli@redhat.com>
> > Cc: Jeff Layton <jlayton@kernel.org>
> > Cc: Ilya Dryomov <idryomov@gmail.com>
> > Cc: ceph-devel@vger.kernel.org
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > [ adapted to b27c82e12965 ("attr: port attribute changes to new types")=
 ]
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.c=
om>
> > ---
> > v4:
> >       - introduced fsuid/fsgid local variables
> > v3:
> >       - reworked as Christian suggested here:
> >       https://lore.kernel.org/lkml/20230602-vorzeichen-praktikum-f17931=
692301@brauner/
> > ---
> >   fs/ceph/inode.c | 20 ++++++++++++--------
> >   1 file changed, 12 insertions(+), 8 deletions(-)
> >
> > diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> > index bcd9b506ec3b..ca438d1353b2 100644
> > --- a/fs/ceph/inode.c
> > +++ b/fs/ceph/inode.c
> > @@ -2052,31 +2052,35 @@ int __ceph_setattr(struct mnt_idmap *idmap, str=
uct inode *inode,
> >       dout("setattr %p issued %s\n", inode, ceph_cap_string(issued));
> >
> >       if (ia_valid & ATTR_UID) {
> > +             kuid_t fsuid =3D from_vfsuid(idmap, i_user_ns(inode), att=
r->ia_vfsuid);
> > +
> >               dout("setattr %p uid %d -> %d\n", inode,
> >                    from_kuid(&init_user_ns, inode->i_uid),
> >                    from_kuid(&init_user_ns, attr->ia_uid));
> >               if (issued & CEPH_CAP_AUTH_EXCL) {
> > -                     inode->i_uid =3D attr->ia_uid;
> > +                     inode->i_uid =3D fsuid;
> >                       dirtied |=3D CEPH_CAP_AUTH_EXCL;
> >               } else if ((issued & CEPH_CAP_AUTH_SHARED) =3D=3D 0 ||
> > -                        !uid_eq(attr->ia_uid, inode->i_uid)) {
> > +                        !uid_eq(fsuid, inode->i_uid)) {
> >                       req->r_args.setattr.uid =3D cpu_to_le32(
> > -                             from_kuid(&init_user_ns, attr->ia_uid));
> > +                             from_kuid(&init_user_ns, fsuid));
> >                       mask |=3D CEPH_SETATTR_UID;
> >                       release |=3D CEPH_CAP_AUTH_SHARED;
> >               }
> >       }
> >       if (ia_valid & ATTR_GID) {
> > +             kgid_t fsgid =3D from_vfsgid(idmap, i_user_ns(inode), att=
r->ia_vfsgid);
> > +
> >               dout("setattr %p gid %d -> %d\n", inode,
> >                    from_kgid(&init_user_ns, inode->i_gid),
> >                    from_kgid(&init_user_ns, attr->ia_gid));
> >               if (issued & CEPH_CAP_AUTH_EXCL) {
> > -                     inode->i_gid =3D attr->ia_gid;
> > +                     inode->i_gid =3D fsgid;
> >                       dirtied |=3D CEPH_CAP_AUTH_EXCL;
> >               } else if ((issued & CEPH_CAP_AUTH_SHARED) =3D=3D 0 ||
> > -                        !gid_eq(attr->ia_gid, inode->i_gid)) {
> > +                        !gid_eq(fsgid, inode->i_gid)) {
> >                       req->r_args.setattr.gid =3D cpu_to_le32(
> > -                             from_kgid(&init_user_ns, attr->ia_gid));
> > +                             from_kgid(&init_user_ns, fsgid));
> >                       mask |=3D CEPH_SETATTR_GID;
> >                       release |=3D CEPH_CAP_AUTH_SHARED;
> >               }
> > @@ -2241,7 +2245,7 @@ int ceph_setattr(struct mnt_idmap *idmap, struct =
dentry *dentry,
> >       if (ceph_inode_is_shutdown(inode))
> >               return -ESTALE;
> >
> > -     err =3D setattr_prepare(&nop_mnt_idmap, dentry, attr);
> > +     err =3D setattr_prepare(idmap, dentry, attr);
> >       if (err !=3D 0)
> >               return err;
> >
> > @@ -2256,7 +2260,7 @@ int ceph_setattr(struct mnt_idmap *idmap, struct =
dentry *dentry,
> >       err =3D __ceph_setattr(idmap, inode, attr);
> >
> >       if (err >=3D 0 && (attr->ia_valid & ATTR_MODE))
> > -             err =3D posix_acl_chmod(&nop_mnt_idmap, dentry, attr->ia_=
mode);
> > +             err =3D posix_acl_chmod(idmap, dentry, attr->ia_mode);
> >
> >       return err;
> >   }

Hi Xiubo,

>
> You should also do 'req->r_mnt_idmap =3D idmap;' for sync setattr request=
.
>
> the setattr will just cache the change locally in client side if the 'x'
> caps are issued and returns directly or will set a sync setattr reqeust.

Have done in v5:
("ceph: pass idmap to __ceph_setattr")
https://lore.kernel.org/lkml/20230608154256.562906-8-aleksandr.mikhalitsyn@=
canonical.com/

Kind regards,
Alex

>
> Thanks
>
> - Xiubo
>
