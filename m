Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694F676FA06
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 08:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbjHDGZ5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 02:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233561AbjHDGZa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 02:25:30 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BE54696
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Aug 2023 23:25:24 -0700 (PDT)
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com [209.85.219.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5ECD0417B7
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Aug 2023 06:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691130321;
        bh=itdf6DX/+djB/5S+zCyJq9/k0mddNxPoSW79Hcknvrw=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=qx4lLP3+xlL3zfgajeMl8IoOPMShVU2w8tYD2SS7/LaAllwHwb8RHovlpX8CLyXhJ
         PvcsbOmGal7oWbn3zJlvycuuG93vWbx/o+3LruvcgVIHDRRSJX4Kh0kojlSYNQzm71
         ZgUCz9EXKZFzQwjo8K4GkPY+kUQenSWxs4Z1mBNZFkMIBFkYQ2FHHfxYK+GmpTGRMG
         yeCTM9DGYGdnJlyi2Ffw7fb39q8CmQJr06uu9gzywRhsykJ0eZ44vt0IO7uDgpXUGT
         bOV4tRhoRatsfJnmu5h3A+hd+W00BIA2OnWFk4z1yckRRGO0FpTAX38vf0iGbxepaW
         zRqrRALuU9Wlg==
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-d11f35a0d5cso2015428276.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Aug 2023 23:25:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691130319; x=1691735119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=itdf6DX/+djB/5S+zCyJq9/k0mddNxPoSW79Hcknvrw=;
        b=RLv/coLnpvpKsEZdILM1psJHhZgGciisT7/X1VZ5KI+GwWU7DFKCUL0dJsF68yGEZJ
         YxovFCvcOK7zRivelXtQBqKVyfMOHeaoSfI7jQaP4HbSAQDunbXYKastW/glarb12ruh
         EgPlEz/50njZz/MAUL7GFI7BLR1KI/HWKx+vWNa8Lx3Av/BJ5GN3qrY1wWjgfn3+Dq8Y
         QWfQsO81B2xvpFCK93dMfYA8rsP197RXdVcbeZOzx/1401+cstukgeB8eayNragXTD9L
         iF9pONuLviUZPKu8T5H8Y+CmDRfHZDgQVsARC2pA4EPovLoMU1d3o7TkbS/49wPiOLuO
         jp+Q==
X-Gm-Message-State: AOJu0YwpHs6QLWyCELNVeRLXHNzadK+I0JHkwZ/R4zdsFNcgJ8Q2eH68
        xq1uVPLbC3/dJ8utaygW1hlZC3xvnXqe2d/pTbVSYye3/ckaBQUGYXCvdzHrTB8kG8OIn8uzfO8
        xz29dVpg5/rCrqUMLyfDDABcFBzRe0TJcxqu00b4/BDOVy/rFQb+SJGZy5ao=
X-Received: by 2002:a05:6902:508:b0:d44:a90b:ba50 with SMTP id x8-20020a056902050800b00d44a90bba50mr778731ybs.5.1691130319698;
        Thu, 03 Aug 2023 23:25:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyKTZRqtr/EO+10gorsT0drzn+0f/e3R2eDHCxrX6lpPi1AkEAljxTqL9lhvMsdzwdgr4jC6/1WI3YOJ8HhWM=
X-Received: by 2002:a05:6902:508:b0:d44:a90b:ba50 with SMTP id
 x8-20020a056902050800b00d44a90bba50mr778716ybs.5.1691130319410; Thu, 03 Aug
 2023 23:25:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230803135955.230449-1-aleksandr.mikhalitsyn@canonical.com>
 <20230803135955.230449-4-aleksandr.mikhalitsyn@canonical.com> <71018b94-45a0-3404-d3d0-d9f808a72a00@redhat.com>
In-Reply-To: <71018b94-45a0-3404-d3d0-d9f808a72a00@redhat.com>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Fri, 4 Aug 2023 08:25:08 +0200
Message-ID: <CAEivzxezBsWe-=Ey03u4wf59y9g6+TUF0sFZh=XK3-Q1rPm9hQ@mail.gmail.com>
Subject: Re: [PATCH v8 03/12] ceph: handle idmapped mounts in create_request_message()
To:     Xiubo Li <xiubli@redhat.com>
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 4, 2023 at 4:26=E2=80=AFAM Xiubo Li <xiubli@redhat.com> wrote:
>
>
> On 8/3/23 21:59, Alexander Mikhalitsyn wrote:
> > From: Christian Brauner <brauner@kernel.org>
> >
> > Inode operations that create a new filesystem object such as ->mknod,
> > ->create, ->mkdir() and others don't take a {g,u}id argument explicitly=
.
> > Instead the caller's fs{g,u}id is used for the {g,u}id of the new
> > filesystem object.
> >
> > In order to ensure that the correct {g,u}id is used map the caller's
> > fs{g,u}id for creation requests. This doesn't require complex changes.
> > It suffices to pass in the relevant idmapping recorded in the request
> > message. If this request message was triggered from an inode operation
> > that creates filesystem objects it will have passed down the relevant
> > idmaping. If this is a request message that was triggered from an inode
> > operation that doens't need to take idmappings into account the initial
> > idmapping is passed down which is an identity mapping.
> >
> > This change uses a new cephfs protocol extension CEPHFS_FEATURE_HAS_OWN=
ER_UIDGID
> > which adds two new fields (owner_{u,g}id) to the request head structure=
.
> > So, we need to ensure that MDS supports it otherwise we need to fail
> > any IO that comes through an idmapped mount because we can't process it
> > in a proper way. MDS server without such an extension will use caller_{=
u,g}id
> > fields to set a new inode owner UID/GID which is incorrect because call=
er_{u,g}id
> > values are unmapped. At the same time we can't map these fields with an
> > idmapping as it can break UID/GID-based permission checks logic on the
> > MDS side. This problem was described with a lot of details at [1], [2].
> >
> > [1] https://lore.kernel.org/lkml/CAEivzxfw1fHO2TFA4dx3u23ZKK6Q+EThfzuib=
rhA3RKM=3DZOYLg@mail.gmail.com/
> > [2] https://lore.kernel.org/all/20220104140414.155198-3-brauner@kernel.=
org/
> >
> > https://github.com/ceph/ceph/pull/52575
> > https://tracker.ceph.com/issues/62217
> >
> > Cc: Xiubo Li <xiubli@redhat.com>
> > Cc: Jeff Layton <jlayton@kernel.org>
> > Cc: Ilya Dryomov <idryomov@gmail.com>
> > Cc: ceph-devel@vger.kernel.org
> > Co-Developed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical=
.com>
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.c=
om>
> > ---
> > v7:
> >       - reworked to use two new fields for owner UID/GID (https://githu=
b.com/ceph/ceph/pull/52575)
> > v8:
> >       - properly handled case when old MDS used with new kernel client
> > ---
> >   fs/ceph/mds_client.c         | 46 +++++++++++++++++++++++++++++++++--=
-
> >   fs/ceph/mds_client.h         |  5 +++-
> >   include/linux/ceph/ceph_fs.h |  4 +++-
> >   3 files changed, 50 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > index 8829f55103da..7d3106d3b726 100644
> > --- a/fs/ceph/mds_client.c
> > +++ b/fs/ceph/mds_client.c
> > @@ -2902,6 +2902,17 @@ static void encode_mclientrequest_tail(void **p,=
 const struct ceph_mds_request *
> >       }
> >   }
> >
> > +static inline u16 mds_supported_head_version(struct ceph_mds_session *=
session)
> > +{
> > +     if (!test_bit(CEPHFS_FEATURE_32BITS_RETRY_FWD, &session->s_featur=
es))
> > +             return 1;
> > +
> > +     if (!test_bit(CEPHFS_FEATURE_HAS_OWNER_UIDGID, &session->s_featur=
es))
> > +             return 2;
> > +
> > +     return CEPH_MDS_REQUEST_HEAD_VERSION;
> > +}
> > +
> >   static struct ceph_mds_request_head_legacy *
> >   find_legacy_request_head(void *p, u64 features)
> >   {
> > @@ -2923,6 +2934,7 @@ static struct ceph_msg *create_request_message(st=
ruct ceph_mds_session *session,
> >   {
> >       int mds =3D session->s_mds;
> >       struct ceph_mds_client *mdsc =3D session->s_mdsc;
> > +     struct ceph_client *cl =3D mdsc->fsc->client;
> >       struct ceph_msg *msg;
> >       struct ceph_mds_request_head_legacy *lhead;
> >       const char *path1 =3D NULL;
> > @@ -2936,7 +2948,7 @@ static struct ceph_msg *create_request_message(st=
ruct ceph_mds_session *session,
> >       void *p, *end;
> >       int ret;
> >       bool legacy =3D !(session->s_con.peer_features & CEPH_FEATURE_FS_=
BTIME);
> > -     bool old_version =3D !test_bit(CEPHFS_FEATURE_32BITS_RETRY_FWD, &=
session->s_features);
> > +     u16 request_head_version =3D mds_supported_head_version(session);
> >
> >       ret =3D set_request_path_attr(mdsc, req->r_inode, req->r_dentry,
> >                             req->r_parent, req->r_path1, req->r_ino1.in=
o,
> > @@ -2977,8 +2989,10 @@ static struct ceph_msg *create_request_message(s=
truct ceph_mds_session *session,
> >        */
> >       if (legacy)
> >               len =3D sizeof(struct ceph_mds_request_head_legacy);
> > -     else if (old_version)
> > +     else if (request_head_version =3D=3D 1)
> >               len =3D sizeof(struct ceph_mds_request_head_old);
> > +     else if (request_head_version =3D=3D 2)
> > +             len =3D offsetofend(struct ceph_mds_request_head, ext_num=
_fwd);
> >       else
> >               len =3D sizeof(struct ceph_mds_request_head);
> >
>
> This is not what we suppose to. If we do this again and again when
> adding new members it will make the code very complicated to maintain.
>
> Once the CEPHFS_FEATURE_32BITS_RETRY_FWD has been supported the ceph
> should correctly decode it and if CEPHFS_FEATURE_HAS_OWNER_UIDGID is not
> supported the decoder should skip it directly.

I thought that too. But it doesn't work. Just try - take kernel client
testing branch, and then
add a new field to the struct ceph_mds_request_head. Compile and try to mou=
nt.
It will stop to work and on the MDS side you will see something like:

2023-08-03T13:15:40.871+0200 7fe64ef5e640 10 mds.c ms_handle_accept
v1:192.168.2.136:0/49354629 con 0x563962206880 session 0x563967054000
2023-08-03T13:15:40.871+0200 7fe650f62640 -1 failed to decode message
of type 24 v6: End of buffer [buffer:2]
2023-08-03T13:15:40.871+0200 7fe650f62640  1 dump:
00000000  03 00 01 00 00 00 00 00  00 00 10 00 00 00 00 00  |..............=
..|
00000010  00 00 00 00 00 00 01 01  00 00 00 00 00 00 00 00  |..............=
..|
00000020  00 00 00 00 00 00 00 00  00 00 01 00 00 00 00 00  |..............=
..|
00000030  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |..............=
..|
*
00000070  00 00 01 01 00 00 00 00  00 00 00 00 00 00 00 01  |..............=
..|
00000080  00 00 00 00 00 00 00 00  00 00 00 00 5b 8c cb 64  |............[.=
.d|
00000090  64 78 11 13 01 00 00 00  00 00 00 00 00 00 00 00  |dx............=
..|
000000a0  00 00 00 00 00 00 00 00  00 00 00 00              |............|
000000ac

As I understand, the MDS side is not ready to see struct
ceph_mds_request_head bigger in size
than supported.

>
> Is the MDS side buggy ? Why you last version didn't work ?
>
> Thanks
>
> - Xiubo
>
> > @@ -3028,6 +3042,16 @@ static struct ceph_msg *create_request_message(s=
truct ceph_mds_session *session,
> >       lhead =3D find_legacy_request_head(msg->front.iov_base,
> >                                        session->s_con.peer_features);
> >
> > +     if ((req->r_mnt_idmap !=3D &nop_mnt_idmap) &&
> > +         !test_bit(CEPHFS_FEATURE_HAS_OWNER_UIDGID, &session->s_featur=
es)) {
> > +             pr_err_ratelimited_client(cl,
> > +                     "idmapped mount is used and CEPHFS_FEATURE_HAS_OW=
NER_UIDGID"
> > +                     " is not supported by MDS. Fail request with -EIO=
.\n");
> > +
> > +             ret =3D -EIO;
> > +             goto out_err;
> > +     }
> > +
> >       /*
> >        * The ceph_mds_request_head_legacy didn't contain a version fiel=
d, and
> >        * one was added when we moved the message version from 3->4.
> > @@ -3035,17 +3059,33 @@ static struct ceph_msg *create_request_message(=
struct ceph_mds_session *session,
> >       if (legacy) {
> >               msg->hdr.version =3D cpu_to_le16(3);
> >               p =3D msg->front.iov_base + sizeof(*lhead);
> > -     } else if (old_version) {
> > +     } else if (request_head_version =3D=3D 1) {
> >               struct ceph_mds_request_head_old *ohead =3D msg->front.io=
v_base;
> >
> >               msg->hdr.version =3D cpu_to_le16(4);
> >               ohead->version =3D cpu_to_le16(1);
> >               p =3D msg->front.iov_base + sizeof(*ohead);
> > +     } else if (request_head_version =3D=3D 2) {
> > +             struct ceph_mds_request_head *nhead =3D msg->front.iov_ba=
se;
> > +
> > +             msg->hdr.version =3D cpu_to_le16(6);
> > +             nhead->version =3D cpu_to_le16(2);
> > +
> > +             p =3D msg->front.iov_base + offsetofend(struct ceph_mds_r=
equest_head, ext_num_fwd);
> >       } else {
> >               struct ceph_mds_request_head *nhead =3D msg->front.iov_ba=
se;
> > +             kuid_t owner_fsuid;
> > +             kgid_t owner_fsgid;
> >
> >               msg->hdr.version =3D cpu_to_le16(6);
> >               nhead->version =3D cpu_to_le16(CEPH_MDS_REQUEST_HEAD_VERS=
ION);
> > +
> > +             owner_fsuid =3D from_vfsuid(req->r_mnt_idmap, &init_user_=
ns,
> > +                                       VFSUIDT_INIT(req->r_cred->fsuid=
));
> > +             owner_fsgid =3D from_vfsgid(req->r_mnt_idmap, &init_user_=
ns,
> > +                                       VFSGIDT_INIT(req->r_cred->fsgid=
));
> > +             nhead->owner_uid =3D cpu_to_le32(from_kuid(&init_user_ns,=
 owner_fsuid));
> > +             nhead->owner_gid =3D cpu_to_le32(from_kgid(&init_user_ns,=
 owner_fsgid));
> >               p =3D msg->front.iov_base + sizeof(*nhead);
> >       }
> >
> > diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> > index e3bbf3ba8ee8..8f683e8203bd 100644
> > --- a/fs/ceph/mds_client.h
> > +++ b/fs/ceph/mds_client.h
> > @@ -33,8 +33,10 @@ enum ceph_feature_type {
> >       CEPHFS_FEATURE_NOTIFY_SESSION_STATE,
> >       CEPHFS_FEATURE_OP_GETVXATTR,
> >       CEPHFS_FEATURE_32BITS_RETRY_FWD,
> > +     CEPHFS_FEATURE_NEW_SNAPREALM_INFO,
> > +     CEPHFS_FEATURE_HAS_OWNER_UIDGID,
> >
> > -     CEPHFS_FEATURE_MAX =3D CEPHFS_FEATURE_32BITS_RETRY_FWD,
> > +     CEPHFS_FEATURE_MAX =3D CEPHFS_FEATURE_HAS_OWNER_UIDGID,
> >   };
> >
> >   #define CEPHFS_FEATURES_CLIENT_SUPPORTED {  \
> > @@ -49,6 +51,7 @@ enum ceph_feature_type {
> >       CEPHFS_FEATURE_NOTIFY_SESSION_STATE,    \
> >       CEPHFS_FEATURE_OP_GETVXATTR,            \
> >       CEPHFS_FEATURE_32BITS_RETRY_FWD,        \
> > +     CEPHFS_FEATURE_HAS_OWNER_UIDGID,        \
> >   }
> >
> >   /*
> > diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.=
h
> > index 5f2301ee88bc..6eb83a51341c 100644
> > --- a/include/linux/ceph/ceph_fs.h
> > +++ b/include/linux/ceph/ceph_fs.h
> > @@ -499,7 +499,7 @@ struct ceph_mds_request_head_legacy {
> >       union ceph_mds_request_args args;
> >   } __attribute__ ((packed));
> >
> > -#define CEPH_MDS_REQUEST_HEAD_VERSION  2
> > +#define CEPH_MDS_REQUEST_HEAD_VERSION  3
> >
> >   struct ceph_mds_request_head_old {
> >       __le16 version;                /* struct version */
> > @@ -530,6 +530,8 @@ struct ceph_mds_request_head {
> >
> >       __le32 ext_num_retry;          /* new count retry attempts */
> >       __le32 ext_num_fwd;            /* new count fwd attempts */
> > +
> > +     __le32 owner_uid, owner_gid;   /* used for OPs which create inode=
s */
> >   } __attribute__ ((packed));
> >
> >   /* cap/lease release record */
>
