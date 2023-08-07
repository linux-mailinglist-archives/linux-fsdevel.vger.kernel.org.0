Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1E1771ABE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Aug 2023 08:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjHGGvZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 02:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjHGGvX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 02:51:23 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8117FE78
        for <linux-fsdevel@vger.kernel.org>; Sun,  6 Aug 2023 23:51:20 -0700 (PDT)
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 94594417BA
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Aug 2023 06:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691391078;
        bh=PggsEy84fZWlgbba8z1nKEleWVdKwuckVEDccJes6ig=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=dIVjAUJhYlSvSjL9mY+S4ClLJCUFUHP0LZ3aKRZogfuG5bDPL4llzabrQ72dRP2Zh
         GzWjBJsisaygwFjidK+DtYbX08JNMAZFpSAO1a0SSwvmsLenpu4ENb+MLuZJ2nfpp1
         b4FRgBOqN8FhNTW71f+CKXoEYMcyllOmix0Ro/7kJKoy2zY3eKJ2nezFZU1H2KQFkM
         z50Nh4NlsmPDSo1GlrfV1MrfjIqDFCtxhdX7d/r0Tv1hIgAdAw4E1HVl5R93GITYcH
         n/+hpsCCk4RIrCPRREaaJMwtE+eK1drHKzKaHvnteeXRY2SK8mXO3Ay4ghMPVFJ4eD
         ccfWAyotR2RmQ==
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3a7a17912d2so481867b6e.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Aug 2023 23:51:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691391077; x=1691995877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PggsEy84fZWlgbba8z1nKEleWVdKwuckVEDccJes6ig=;
        b=SLYG+ZwknWAhjK/Ifoebmw15VvGe9QIhPv38xyhpnzAG/5mtfCWvmwa4XdnoP6acXG
         IZ8Zdu0sT+/cUAoqnyP060GMsAELPbMlTSBSvmfX3Hp41EqW2NSzWSwe7KbAQcIHxZYM
         JE6sCd2Wxp/NL9rSpBQKxjLPK4iy6FsGKrRM+IIyUjmoSMGvi8tiHL4ykEPLJvvSzetD
         1lH0CouIOo7MAM09uPPtCzVt5f6UPkCsqVu2YV8N8g1fTWB0CNPpuRLirPNDSch0HWsr
         QcQqMOCXwxARIrFB3L/B7g5ICb1u7+4dTAxKJxKwD6V/F0AEGaSY09lhp8+LuZFgM6lJ
         +SpQ==
X-Gm-Message-State: AOJu0Yywx4rybHv9b+reCAExY72hLxzukRSqtI92tIKqBAaGDQ1zY+Sm
        Hd+KbKlvxc0huY1n/i6Wuus8TArquioswFOWkKZpSo1CbJr9BjS8rEeHKotWAVemgMNt8H77c+F
        AmDvawZPJLUBGiAghQLbE9jPEM1k3FmrJ5l6KOvOJK8+VGMygmY9uyDbLa0E=
X-Received: by 2002:a05:6358:2484:b0:139:c7cb:77cd with SMTP id m4-20020a056358248400b00139c7cb77cdmr8851274rwc.11.1691391077173;
        Sun, 06 Aug 2023 23:51:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqBAqtQZNmd5IKvfl34fA+arv+IV2EwCvvh/g5BrkOOdPEx67IoUKVYwuTDYTcWc9DhYFcafDN9Uj1PG01jhE=
X-Received: by 2002:a05:6358:2484:b0:139:c7cb:77cd with SMTP id
 m4-20020a056358248400b00139c7cb77cdmr8851256rwc.11.1691391076694; Sun, 06 Aug
 2023 23:51:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230804084858.126104-1-aleksandr.mikhalitsyn@canonical.com>
 <20230804084858.126104-4-aleksandr.mikhalitsyn@canonical.com> <8446e5c9-7dd7-a1e9-e262-13811ee9e640@redhat.com>
In-Reply-To: <8446e5c9-7dd7-a1e9-e262-13811ee9e640@redhat.com>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Mon, 7 Aug 2023 08:51:05 +0200
Message-ID: <CAEivzxedfaD7cPfQ-sspJabw_P6zSJtOrbiAGYN35LGXPoSwcg@mail.gmail.com>
Subject: Re: [PATCH v9 03/12] ceph: handle idmapped mounts in create_request_message()
To:     Xiubo Li <xiubli@redhat.com>
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 7, 2023 at 3:25=E2=80=AFAM Xiubo Li <xiubli@redhat.com> wrote:
>
>
> On 8/4/23 16:48, Alexander Mikhalitsyn wrote:
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
> > Link: https://github.com/ceph/ceph/pull/52575
> > Link: https://tracker.ceph.com/issues/62217
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
> >   fs/ceph/mds_client.c         | 47 +++++++++++++++++++++++++++++++++--=
-
> >   fs/ceph/mds_client.h         |  5 +++-
> >   include/linux/ceph/ceph_fs.h |  5 +++-
> >   3 files changed, 52 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > index 8829f55103da..41e4bf3811c4 100644
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
> > @@ -3035,17 +3059,34 @@ static struct ceph_msg *create_request_message(=
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
> > +             nhead->struct_len =3D sizeof(struct ceph_mds_request_head=
);
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
> > index 5f2301ee88bc..b91699b08f26 100644
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
> > @@ -530,6 +530,9 @@ struct ceph_mds_request_head {
> >
> >       __le32 ext_num_retry;          /* new count retry attempts */
> >       __le32 ext_num_fwd;            /* new count fwd attempts */
> > +
> > +     __le32 struct_len;             /* to store size of struct ceph_md=
s_request_head */
> > +     __le32 owner_uid, owner_gid;   /* used for OPs which create inode=
s */
>
> Let's also initialize them to -1 for all the other requests as we do in
> your PR.

They are always initialized already. As you can see from the code we
don't have any extra conditions
on filling these fields. We always fill them with an appropriate
UID/GID. If mount is not idmapped then it's just =3D=3D caller_uid/gid,
if mount idmapped then it's idmapped caller_uid/gid.

Kind regards,
Alex

>
> Thanks
>
> - Xiubo
>
>
>
> >   } __attribute__ ((packed));
> >
> >   /* cap/lease release record */
>
