Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2EC72028F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jun 2023 15:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235724AbjFBNGK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 09:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235560AbjFBNGI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 09:06:08 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6ABF1B5
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Jun 2023 06:06:03 -0700 (PDT)
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 78FEA3F555
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Jun 2023 13:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1685711162;
        bh=macnFrD8/88IsnbV5uDoEOVfHw1N8K7PkSHgwKoxduo=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=Qav+yZr8OnvBXbWRsjsCkoMciwaFfJ1j9pPUA2f9K300lSr1L77VdOvwdD9fwxleH
         IqsoftyCz5w7YK/enyxb1bmUL2kfwk8Pe1szkfy5MlyejPKOdJnrUjmhSipXgapITy
         Khe61/+4NDKfBUtldBisALDzM4IQLc5t3AphjCun/bV5IrIWC1NUYjOMGO0jDNL0Gy
         6K4k+viZ1chn9agMH1JWjIQ0LE4h7jjGkGEK3ZEjMCmZYv9gBqAdvaBh1hLWKzqxBt
         Bn0U7TZRQqKbqH6jjYHanPz9e5yXCuvSXjlP2GJCjKR+a/Nk7PVHiSTmZTGddjeXa0
         a7llAG31uhH1A==
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-56942667393so16144797b3.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Jun 2023 06:06:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685711161; x=1688303161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=macnFrD8/88IsnbV5uDoEOVfHw1N8K7PkSHgwKoxduo=;
        b=gyVxDoEVTvFKnKWio1ASxO11n3zyWwJFni/GHBtRCcDFbTqZgWYDR34+WsBAJ2YKQh
         qA7cgeuiJMWub78bI6Eeo12Kbny6AVzBwAClZ79MWtcVBhRnyP9YthMI7pc8ob9Ue9My
         VJBXREijr6eKAO2KeL51nkVhhDfYlWI3UmwgWGm4NEcB+befIgo5PxUF1TT4XsrD4BOz
         Dt95CSw2ZeuiDrqRhaFmV3UZ/sviDXaxRDl0OY8J43epuI0KXEtDY3aRI/SNFJHO/ofz
         Zvz3JS7xtABclMEOuZROM7RIUXm5uJEUUr1bMo90Wcuc6M6ByaVtACR3o5HpjylDfzyY
         6COQ==
X-Gm-Message-State: AC+VfDw1H4HvlqWBUKabEYRcMM8FzDymoOHIR5V6QkhvVrio7KR1yBdt
        m8aGbYCjiHCcmu8Yyf7B4HQnOtWpKl86guM69g3ODBy+DLRJD0J/5HvtWcxO1kqk96PX3n3+yd3
        l6UlDlvwht1PZJFeOY0tORQJDyyqqHQRL9qjq2xuzPmkkn75NvZWZcP16jdA=
X-Received: by 2002:a81:5254:0:b0:568:92f7:e215 with SMTP id g81-20020a815254000000b0056892f7e215mr11912409ywb.23.1685711161324;
        Fri, 02 Jun 2023 06:06:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7oA7T+zpgT92499QvwKgbnh0FC7Joa/ynQ1HKgPg0nAwH+/mxUTrJ+dYy2c2r1pz8Ur5M9Kl7cepTqGGbPLr4=
X-Received: by 2002:a81:5254:0:b0:568:92f7:e215 with SMTP id
 g81-20020a815254000000b0056892f7e215mr11912396ywb.23.1685711161103; Fri, 02
 Jun 2023 06:06:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230524153316.476973-1-aleksandr.mikhalitsyn@canonical.com>
 <20230524153316.476973-11-aleksandr.mikhalitsyn@canonical.com>
 <b3b1b8dc-9903-c4ff-0a63-9a31a311ff0b@redhat.com> <CAEivzxfxug8kb7_SzJGvEZMcYwGM8uW25gKa_osFqUCpF_+Lhg@mail.gmail.com>
 <20230602-vorzeichen-praktikum-f17931692301@brauner>
In-Reply-To: <20230602-vorzeichen-praktikum-f17931692301@brauner>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Fri, 2 Jun 2023 15:05:50 +0200
Message-ID: <CAEivzxcwTbOUrT2ha8fR=wy-bU1+ZppapnMsqVXBXAc+C0gwhw@mail.gmail.com>
Subject: Re: [PATCH v2 10/13] ceph: allow idmapped setattr inode op
To:     Christian Brauner <brauner@kernel.org>
Cc:     Xiubo Li <xiubli@redhat.com>, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 2, 2023 at 2:54=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Fri, Jun 02, 2023 at 02:45:30PM +0200, Aleksandr Mikhalitsyn wrote:
> > On Fri, Jun 2, 2023 at 3:30=E2=80=AFAM Xiubo Li <xiubli@redhat.com> wro=
te:
> > >
> > >
> > > On 5/24/23 23:33, Alexander Mikhalitsyn wrote:
> > > > From: Christian Brauner <christian.brauner@ubuntu.com>
> > > >
> > > > Enable __ceph_setattr() to handle idmapped mounts. This is just a m=
atter
> > > > of passing down the mount's idmapping.
> > > >
> > > > Cc: Jeff Layton <jlayton@kernel.org>
> > > > Cc: Ilya Dryomov <idryomov@gmail.com>
> > > > Cc: ceph-devel@vger.kernel.org
> > > > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > > > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonic=
al.com>
> > > > ---
> > > >   fs/ceph/inode.c | 11 +++++++++--
> > > >   1 file changed, 9 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> > > > index 37e1cbfc7c89..f1f934439be0 100644
> > > > --- a/fs/ceph/inode.c
> > > > +++ b/fs/ceph/inode.c
> > > > @@ -2050,6 +2050,13 @@ int __ceph_setattr(struct inode *inode, stru=
ct iattr *attr)
> > > >
> > > >       dout("setattr %p issued %s\n", inode, ceph_cap_string(issued)=
);
> > > >
> > > > +     /*
> > > > +      * The attr->ia_{g,u}id members contain the target {g,u}id we=
're
>
> This is now obsolete... In earlier imlementations attr->ia_{g,u}id was
> used and contained the filesystem wide value, not the idmapped mount
> value.
>
> However, this was misleading and we changed that in commit b27c82e12965
> ("attr: port attribute changes to new types") and introduced dedicated
> new types into struct iattr->ia_vfs{g,u}id. So the you need to use
> attr->ia_vfs{g,u}id as documented in include/linux/fs.h and you need to
> transform them into filesystem wide values and then to raw values you
> send over the wire.
>
> Alex should be able to figure this out though.

Hi Christian,

Thanks for pointing this out. Unfortunately I wasn't able to notice
that. I'll take a look closer and fix that.

>
> > > > +      * sending over the wire. The mount idmapping only matters wh=
en we
> > > > +      * create new filesystem objects based on the caller's mapped
> > > > +      * fs{g,u}id.
> > > > +      */
> > > > +     req->r_mnt_idmap =3D &nop_mnt_idmap;
> > >
> > > For example with an idmapping 1000:0 and in the /mnt/idmapped_ceph/.
> > >
> > > This means the "__ceph_setattr()" will always use UID 0 to set the
> > > caller_uid, right ? If it is then the client auth checking for the
> >
> > Yes, if you have a mapping like b:1000:0:1 (the last number is a
> > length of a mapping). It means even more,
> > the only user from which you can create something on the filesystem
> > will be UID =3D 0,
> > because all other UIDs/GIDs are not mapped and you'll instantly get
> > -EOVERFLOW from the kernel.
> >
> > > setattr requests in cephfs MDS will succeed, since the UID 0 is root.
> > > But if you use a different idmapping, such as 1000:2000, it will fail=
.
> >
> > If you have a mapping b:1000:2000:1 then the only valid UID/GID from
> > which you can create something
> > on an idmapped mount will be UID/GID =3D 2000:2000 (and this will be
> > mapped to 1000:1000 and sent over the wire,
> > because we performing an idmapping procedure for requests those are
> > creating inodes).
> > So, even root with UID =3D 0 will not be able to create a file on such =
a
> > mount and get -EOVERFLOW.
> >
> > >
> > > So here IMO we should set it to 'idmap' too ?
> >
> > Good question. I can't see any obvious issue with setting an actual
> > idmapping here.
> > It will be interesting to know Christian's opinion about this.

^

Kind regards,
Alex

> >
> > Kind regards,
> > Alex
> >
> > >
> > > Thanks
> > >
> > > - Xiubo
> > >
> > > >       if (ia_valid & ATTR_UID) {
> > > >               dout("setattr %p uid %d -> %d\n", inode,
> > > >                    from_kuid(&init_user_ns, inode->i_uid),
> > > > @@ -2240,7 +2247,7 @@ int ceph_setattr(struct mnt_idmap *idmap, str=
uct dentry *dentry,
> > > >       if (ceph_inode_is_shutdown(inode))
> > > >               return -ESTALE;
> > > >
> > > > -     err =3D setattr_prepare(&nop_mnt_idmap, dentry, attr);
> > > > +     err =3D setattr_prepare(idmap, dentry, attr);
> > > >       if (err !=3D 0)
> > > >               return err;
> > > >
> > > > @@ -2255,7 +2262,7 @@ int ceph_setattr(struct mnt_idmap *idmap, str=
uct dentry *dentry,
> > > >       err =3D __ceph_setattr(inode, attr);
> > > >
> > > >       if (err >=3D 0 && (attr->ia_valid & ATTR_MODE))
> > > > -             err =3D posix_acl_chmod(&nop_mnt_idmap, dentry, attr-=
>ia_mode);
> > > > +             err =3D posix_acl_chmod(idmap, dentry, attr->ia_mode)=
;
> > > >
> > > >       return err;
> > > >   }
> > >
