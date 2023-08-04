Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF26C76FA51
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 08:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbjHDGoQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 02:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233042AbjHDGoM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 02:44:12 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2A346AA
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Aug 2023 23:44:10 -0700 (PDT)
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com [209.85.219.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BCC6D3F131
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Aug 2023 06:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691131448;
        bh=gFhyqjSmeXhR4T6L3dQi172YmFQZiWK8SfiHKWHYkxM=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=pkfgGrbCoW7iet3ejt4s0e6VUL41kMGsX1hAczqyB8fHrMYgsv5CCueTLPWoJkSH2
         jBbBz8/fdLDO15NJXFupPJqkiWRovSo3mQhhcCrxDalkB1El5xwaWCtF2ObO4Mx/hX
         IMPZvGPlCbwTFpUPTwTo45FZ418v+6NxLjBRLqr4eZm+90WE40nq9pWmvXTQT8tV82
         alMlt8TroEMJJ6kBomENt8cUxoPGjv8SJjwCtgntEIL/6dACrtnOeZnhdrYkcTSrNZ
         DmMffRuP7yQ+Y2oJa/sCHreIHVxKBYJZfuZhjbWagEC5uthvGLWKg6Tx6AYJarTk21
         lTuYKWSYKoFxw==
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-d1d9814b89fso2044899276.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Aug 2023 23:44:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691131447; x=1691736247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gFhyqjSmeXhR4T6L3dQi172YmFQZiWK8SfiHKWHYkxM=;
        b=UnJOTLQ5JX1EiSFCKMqnJvYicjcZDcg/VW779IpkzYi1OyCCuXWHhoYtl3GOgas+NU
         6ZWoSw1HRiv/4kksp4rkinrU7fiCNAGyPkcBoRxcPAn1R2YW8c1yHasWpJ7dkGvuW3oH
         ke0fSbYkECwTBSGCd6v70Iy6wZkcjbB4blgYoze3CRUdoi8dWdIfYd/2zz7bf9IN3FoC
         BL0eYlKtkCWultv+6E2Ekd4K0Et6usiAnzbOdB2LUeG5cGVvGPoela1/Gtp3PxbXNUsf
         N/h9z08bO+QRWKH0ibcYh9/66FJWKuCLrX+nMmLUwZRwliQtIOSwDJTgnTZqxgmu7UDJ
         btQw==
X-Gm-Message-State: AOJu0YywBO9dENTm19H8lw2+D1X6CZ9be/fSP+Kf73gmiWmh7c1kSIl5
        5nUErZrpVL8cXXHOvhwzXT0MwFOjPxnBlEe1JK9dgqTYihyT5LNOHM1lb5xf3zKmy1md7KMAuQs
        rrO0m7lKjLAe1h61KR0M0hA3LN47SASJYsYekF2R9xqfvtl5bGgqnoZlb4ZQ=
X-Received: by 2002:a25:ab01:0:b0:cab:68e6:2eb3 with SMTP id u1-20020a25ab01000000b00cab68e62eb3mr1109844ybi.59.1691131447092;
        Thu, 03 Aug 2023 23:44:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwGzjIsOsiDEM7Oy7uv/7o6WavNCPA9Nu6K6mDzK3FrrlBSyvgKz4fCokZ4zpk57OJhNNLTT0KMh6JQlXg1JA=
X-Received: by 2002:a25:ab01:0:b0:cab:68e6:2eb3 with SMTP id
 u1-20020a25ab01000000b00cab68e62eb3mr1109832ybi.59.1691131446856; Thu, 03 Aug
 2023 23:44:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230803135955.230449-1-aleksandr.mikhalitsyn@canonical.com>
 <20230803135955.230449-4-aleksandr.mikhalitsyn@canonical.com>
 <71018b94-45a0-3404-d3d0-d9f808a72a00@redhat.com> <41ba61bf-3a45-cb20-1e4c-38dbd65bafa6@redhat.com>
 <CAEivzxcmurnArPRuLWXDjA2+qdicz4rnxA8ESTQprHJM1kKEnA@mail.gmail.com>
In-Reply-To: <CAEivzxcmurnArPRuLWXDjA2+qdicz4rnxA8ESTQprHJM1kKEnA@mail.gmail.com>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Fri, 4 Aug 2023 08:43:56 +0200
Message-ID: <CAEivzxeFeWt-VFOrNqTV5x38r1zwmfcEh_ScqriDHC8bL7s0dw@mail.gmail.com>
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 4, 2023 at 8:35=E2=80=AFAM Aleksandr Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:
>
> On Fri, Aug 4, 2023 at 5:24=E2=80=AFAM Xiubo Li <xiubli@redhat.com> wrote=
:
> >
> >
> > On 8/4/23 10:26, Xiubo Li wrote:
> > >
> > > On 8/3/23 21:59, Alexander Mikhalitsyn wrote:
> > >> From: Christian Brauner <brauner@kernel.org>
> > >>
> > >> Inode operations that create a new filesystem object such as ->mknod=
,
> > >> ->create, ->mkdir() and others don't take a {g,u}id argument explici=
tly.
> > >> Instead the caller's fs{g,u}id is used for the {g,u}id of the new
> > >> filesystem object.
> > >>
> > >> In order to ensure that the correct {g,u}id is used map the caller's
> > >> fs{g,u}id for creation requests. This doesn't require complex change=
s.
> > >> It suffices to pass in the relevant idmapping recorded in the reques=
t
> > >> message. If this request message was triggered from an inode operati=
on
> > >> that creates filesystem objects it will have passed down the relevan=
t
> > >> idmaping. If this is a request message that was triggered from an in=
ode
> > >> operation that doens't need to take idmappings into account the init=
ial
> > >> idmapping is passed down which is an identity mapping.
> > >>
> > >> This change uses a new cephfs protocol extension
> > >> CEPHFS_FEATURE_HAS_OWNER_UIDGID
> > >> which adds two new fields (owner_{u,g}id) to the request head struct=
ure.
> > >> So, we need to ensure that MDS supports it otherwise we need to fail
> > >> any IO that comes through an idmapped mount because we can't process=
 it
> > >> in a proper way. MDS server without such an extension will use
> > >> caller_{u,g}id
> > >> fields to set a new inode owner UID/GID which is incorrect because
> > >> caller_{u,g}id
> > >> values are unmapped. At the same time we can't map these fields with=
 an
> > >> idmapping as it can break UID/GID-based permission checks logic on t=
he
> > >> MDS side. This problem was described with a lot of details at [1], [=
2].
> > >>
> > >> [1]
> > >> https://lore.kernel.org/lkml/CAEivzxfw1fHO2TFA4dx3u23ZKK6Q+EThfzuibr=
hA3RKM=3DZOYLg@mail.gmail.com/
> > >> [2]
> > >> https://lore.kernel.org/all/20220104140414.155198-3-brauner@kernel.o=
rg/
> > >>
> > >> https://github.com/ceph/ceph/pull/52575
> > >> https://tracker.ceph.com/issues/62217
> > >>
> > >> Cc: Xiubo Li <xiubli@redhat.com>
> > >> Cc: Jeff Layton <jlayton@kernel.org>
> > >> Cc: Ilya Dryomov <idryomov@gmail.com>
> > >> Cc: ceph-devel@vger.kernel.org
> > >> Co-Developed-by: Alexander Mikhalitsyn
> > >> <aleksandr.mikhalitsyn@canonical.com>
> > >> Signed-off-by: Christian Brauner <brauner@kernel.org>
> > >> Signed-off-by: Alexander Mikhalitsyn
> > >> <aleksandr.mikhalitsyn@canonical.com>
> > >> ---
> > >> v7:
> > >>     - reworked to use two new fields for owner UID/GID
> > >> (https://github.com/ceph/ceph/pull/52575)
> > >> v8:
> > >>     - properly handled case when old MDS used with new kernel client
> > >> ---
> > >>   fs/ceph/mds_client.c         | 46 ++++++++++++++++++++++++++++++++=
+---
> > >>   fs/ceph/mds_client.h         |  5 +++-
> > >>   include/linux/ceph/ceph_fs.h |  4 +++-
> > >>   3 files changed, 50 insertions(+), 5 deletions(-)
> > >>
> > >> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > >> index 8829f55103da..7d3106d3b726 100644
> > >> --- a/fs/ceph/mds_client.c
> > >> +++ b/fs/ceph/mds_client.c
> > >> @@ -2902,6 +2902,17 @@ static void encode_mclientrequest_tail(void
> > >> **p, const struct ceph_mds_request *
> > >>       }
> > >>   }
> > >>   +static inline u16 mds_supported_head_version(struct
> > >> ceph_mds_session *session)
> > >> +{
> > >> +    if (!test_bit(CEPHFS_FEATURE_32BITS_RETRY_FWD,
> > >> &session->s_features))
> > >> +        return 1;
> > >> +
> > >> +    if (!test_bit(CEPHFS_FEATURE_HAS_OWNER_UIDGID,
> > >> &session->s_features))
> > >> +        return 2;
> > >> +
> > >> +    return CEPH_MDS_REQUEST_HEAD_VERSION;
> > >> +}
> > >> +
> > >>   static struct ceph_mds_request_head_legacy *
> > >>   find_legacy_request_head(void *p, u64 features)
> > >>   {
> > >> @@ -2923,6 +2934,7 @@ static struct ceph_msg
> > >> *create_request_message(struct ceph_mds_session *session,
> > >>   {
> > >>       int mds =3D session->s_mds;
> > >>       struct ceph_mds_client *mdsc =3D session->s_mdsc;
> > >> +    struct ceph_client *cl =3D mdsc->fsc->client;
> > >>       struct ceph_msg *msg;
> > >>       struct ceph_mds_request_head_legacy *lhead;
> > >>       const char *path1 =3D NULL;
> > >> @@ -2936,7 +2948,7 @@ static struct ceph_msg
> > >> *create_request_message(struct ceph_mds_session *session,
> > >>       void *p, *end;
> > >>       int ret;
> > >>       bool legacy =3D !(session->s_con.peer_features &
> > >> CEPH_FEATURE_FS_BTIME);
> > >> -    bool old_version =3D !test_bit(CEPHFS_FEATURE_32BITS_RETRY_FWD,
> > >> &session->s_features);
> > >> +    u16 request_head_version =3D mds_supported_head_version(session=
);
> > >>         ret =3D set_request_path_attr(mdsc, req->r_inode, req->r_den=
try,
> > >>                     req->r_parent, req->r_path1, req->r_ino1.ino,
> > >> @@ -2977,8 +2989,10 @@ static struct ceph_msg
> > >> *create_request_message(struct ceph_mds_session *session,
> > >>        */
> > >>       if (legacy)
> > >>           len =3D sizeof(struct ceph_mds_request_head_legacy);
> > >> -    else if (old_version)
> > >> +    else if (request_head_version =3D=3D 1)
> > >>           len =3D sizeof(struct ceph_mds_request_head_old);
> > >> +    else if (request_head_version =3D=3D 2)
> > >> +        len =3D offsetofend(struct ceph_mds_request_head, ext_num_f=
wd);
> > >>       else
> > >>           len =3D sizeof(struct ceph_mds_request_head);
> > >
> > > This is not what we suppose to. If we do this again and again when
> > > adding new members it will make the code very complicated to maintain=
.
> > >
> > > Once the CEPHFS_FEATURE_32BITS_RETRY_FWD has been supported the ceph
> > > should correctly decode it and if CEPHFS_FEATURE_HAS_OWNER_UIDGID is
> > > not supported the decoder should skip it directly.
> > >
> > > Is the MDS side buggy ? Why you last version didn't work ?
> > >
> >
> > I think the ceph side is buggy. Possibly we should add one new `length`
> > member in struct `struct ceph_mds_request_head` and just skip the extra
> > bytes when decoding it.
>
> Hm, I think I found something suspicious. In cephfs code we have many
> places that
> call the DECODE_FINISH macro, but in our decoder we don't have it.
>
> From documentation it follows that DECODE_FINISH purpose is precisely
> about this problem.
>
> What do you think?

Upd: this thing also changes on-wire format and adds field to store length.
But this will be a massive and incompatible protocol change. I don't think =
that
we want to do this in the scope of this task.

>
> >
> > Could you fix it together with your ceph PR ?
> >
> > Thanks
> >
> > - Xiubo
> >
> >
> > > Thanks
> > >
> > > - Xiubo
> > >
> > >> @@ -3028,6 +3042,16 @@ static struct ceph_msg
> > >> *create_request_message(struct ceph_mds_session *session,
> > >>       lhead =3D find_legacy_request_head(msg->front.iov_base,
> > >>                        session->s_con.peer_features);
> > >>   +    if ((req->r_mnt_idmap !=3D &nop_mnt_idmap) &&
> > >> +        !test_bit(CEPHFS_FEATURE_HAS_OWNER_UIDGID,
> > >> &session->s_features)) {
> > >> +        pr_err_ratelimited_client(cl,
> > >> +            "idmapped mount is used and
> > >> CEPHFS_FEATURE_HAS_OWNER_UIDGID"
> > >> +            " is not supported by MDS. Fail request with -EIO.\n");
> > >> +
> > >> +        ret =3D -EIO;
> > >> +        goto out_err;
> > >> +    }
> > >> +
> > >>       /*
> > >>        * The ceph_mds_request_head_legacy didn't contain a version
> > >> field, and
> > >>        * one was added when we moved the message version from 3->4.
> > >> @@ -3035,17 +3059,33 @@ static struct ceph_msg
> > >> *create_request_message(struct ceph_mds_session *session,
> > >>       if (legacy) {
> > >>           msg->hdr.version =3D cpu_to_le16(3);
> > >>           p =3D msg->front.iov_base + sizeof(*lhead);
> > >> -    } else if (old_version) {
> > >> +    } else if (request_head_version =3D=3D 1) {
> > >>           struct ceph_mds_request_head_old *ohead =3D msg->front.iov=
_base;
> > >>             msg->hdr.version =3D cpu_to_le16(4);
> > >>           ohead->version =3D cpu_to_le16(1);
> > >>           p =3D msg->front.iov_base + sizeof(*ohead);
> > >> +    } else if (request_head_version =3D=3D 2) {
> > >> +        struct ceph_mds_request_head *nhead =3D msg->front.iov_base=
;
> > >> +
> > >> +        msg->hdr.version =3D cpu_to_le16(6);
> > >> +        nhead->version =3D cpu_to_le16(2);
> > >> +
> > >> +        p =3D msg->front.iov_base + offsetofend(struct
> > >> ceph_mds_request_head, ext_num_fwd);
> > >>       } else {
> > >>           struct ceph_mds_request_head *nhead =3D msg->front.iov_bas=
e;
> > >> +        kuid_t owner_fsuid;
> > >> +        kgid_t owner_fsgid;
> > >>             msg->hdr.version =3D cpu_to_le16(6);
> > >>           nhead->version =3D cpu_to_le16(CEPH_MDS_REQUEST_HEAD_VERSI=
ON);
> > >> +
> > >> +        owner_fsuid =3D from_vfsuid(req->r_mnt_idmap, &init_user_ns=
,
> > >> +                      VFSUIDT_INIT(req->r_cred->fsuid));
> > >> +        owner_fsgid =3D from_vfsgid(req->r_mnt_idmap, &init_user_ns=
,
> > >> +                      VFSGIDT_INIT(req->r_cred->fsgid));
> > >> +        nhead->owner_uid =3D cpu_to_le32(from_kuid(&init_user_ns,
> > >> owner_fsuid));
> > >> +        nhead->owner_gid =3D cpu_to_le32(from_kgid(&init_user_ns,
> > >> owner_fsgid));
> > >>           p =3D msg->front.iov_base + sizeof(*nhead);
> > >>       }
> > >>   diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> > >> index e3bbf3ba8ee8..8f683e8203bd 100644
> > >> --- a/fs/ceph/mds_client.h
> > >> +++ b/fs/ceph/mds_client.h
> > >> @@ -33,8 +33,10 @@ enum ceph_feature_type {
> > >>       CEPHFS_FEATURE_NOTIFY_SESSION_STATE,
> > >>       CEPHFS_FEATURE_OP_GETVXATTR,
> > >>       CEPHFS_FEATURE_32BITS_RETRY_FWD,
> > >> +    CEPHFS_FEATURE_NEW_SNAPREALM_INFO,
> > >> +    CEPHFS_FEATURE_HAS_OWNER_UIDGID,
> > >>   -    CEPHFS_FEATURE_MAX =3D CEPHFS_FEATURE_32BITS_RETRY_FWD,
> > >> +    CEPHFS_FEATURE_MAX =3D CEPHFS_FEATURE_HAS_OWNER_UIDGID,
> > >>   };
> > >>     #define CEPHFS_FEATURES_CLIENT_SUPPORTED {    \
> > >> @@ -49,6 +51,7 @@ enum ceph_feature_type {
> > >>       CEPHFS_FEATURE_NOTIFY_SESSION_STATE,    \
> > >>       CEPHFS_FEATURE_OP_GETVXATTR,        \
> > >>       CEPHFS_FEATURE_32BITS_RETRY_FWD,    \
> > >> +    CEPHFS_FEATURE_HAS_OWNER_UIDGID,    \
> > >>   }
> > >>     /*
> > >> diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_=
fs.h
> > >> index 5f2301ee88bc..6eb83a51341c 100644
> > >> --- a/include/linux/ceph/ceph_fs.h
> > >> +++ b/include/linux/ceph/ceph_fs.h
> > >> @@ -499,7 +499,7 @@ struct ceph_mds_request_head_legacy {
> > >>       union ceph_mds_request_args args;
> > >>   } __attribute__ ((packed));
> > >>   -#define CEPH_MDS_REQUEST_HEAD_VERSION  2
> > >> +#define CEPH_MDS_REQUEST_HEAD_VERSION  3
> > >>     struct ceph_mds_request_head_old {
> > >>       __le16 version;                /* struct version */
> > >> @@ -530,6 +530,8 @@ struct ceph_mds_request_head {
> > >>         __le32 ext_num_retry;          /* new count retry attempts *=
/
> > >>       __le32 ext_num_fwd;            /* new count fwd attempts */
> > >> +
> > >> +    __le32 owner_uid, owner_gid;   /* used for OPs which create
> > >> inodes */
> > >>   } __attribute__ ((packed));
> > >>     /* cap/lease release record */
> >
