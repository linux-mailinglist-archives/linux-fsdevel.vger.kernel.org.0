Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E25771E2D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Aug 2023 12:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjHGKe4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 06:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjHGKez (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 06:34:55 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0465710F7
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Aug 2023 03:34:54 -0700 (PDT)
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 90F893F078
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Aug 2023 10:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691404491;
        bh=jxCnlIcS4KeOxtxhqOQiG9Twpa6ijTqYfKwpK/hGiyw=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=ayx9kL5gIfI2MWU/AmJOJCitCRD2w11VcgbbtgBpWIdv5tivQsgsH7P+z5Mnda5uY
         71KffVXcyq4akkGcHaBpIQa26jLd6Q8Z0SrfqpnwsUL8YIWadRl9EzXrWDlyoJI3U+
         Yvs66CYstLyaoYo4ZIp4yj7rYeTJBKkcjQmqhgpHd4RrUHNpUoKAWtl2zggLB7FHWA
         bOXb+6jlImH3aB8JpTePz9lZdUqwrdPVwOWjWkbgXhOpZzpqMBE7AFdC5E/1HqVDvr
         UQIp6bSN1ur5pJn6CZjyZ2tlAscZMJV9jVHumYOqzk1rhMyj4fU1kwoI0cgIuBjhzf
         X3ql5ksV4f4tA==
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-583c1903ad3so51922767b3.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Aug 2023 03:34:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691404490; x=1692009290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jxCnlIcS4KeOxtxhqOQiG9Twpa6ijTqYfKwpK/hGiyw=;
        b=HzljEN+zamp7/PDyc6QMVsX2Jq8SyQcUo/Mz3011Hgza0jHCq9rSEAIJjw45Vc1X+r
         BiTh1GHfDjp3gpT1A7IcRtfYTNkRrM0B1tU/Y1jpJRijN7NboGlJzj3QRz1XYaQseYXM
         qQH5KLsrQ3Ox2SaCDHj9JclnvxTdDuCToAUPPDVa6RglY4lSPLNuFQkyorkF6KdQMjrd
         JSKfbMiBtNhKgz8HFzwAs6yU3JK7lpyN6t+SgG6MtPLlYlIukn5qtWFLIokE/DUyj+as
         7YARy59zGOFn2TFi0znPZ3jmG8j6QwGlpi0tZGShdPvFOFAlW7cDXiUXPQh9grKyx2M6
         +QnA==
X-Gm-Message-State: AOJu0Yzb1exxTR3eNw+oG44KCJ2sq/KGRJHUMphf51aHaRh/iktObX6j
        96UeEABwjBjLV/ILlPrKXOMb4a+WdGOq/ECL4DibIhrxj5QLwo+PTJRvaC+5RQT8kTowIenifH1
        +FXenPVrulzub7pHY9i3zk1s4e7xMI5OkdYNY0FIclKpXYDqUB6Ll04w0isw=
X-Received: by 2002:a05:6902:70a:b0:d4e:f64d:97bd with SMTP id k10-20020a056902070a00b00d4ef64d97bdmr5237860ybt.63.1691404490632;
        Mon, 07 Aug 2023 03:34:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEs1kCklRUH8/ebmlXd8KPIlNFDnlF4oDl61QCUrYMMpAiodJceb2rEaV50BY/+0iZ9xgZofIRyp/J1kV/At38=
X-Received: by 2002:a05:6902:70a:b0:d4e:f64d:97bd with SMTP id
 k10-20020a056902070a00b00d4ef64d97bdmr5237846ybt.63.1691404490370; Mon, 07
 Aug 2023 03:34:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230804084858.126104-1-aleksandr.mikhalitsyn@canonical.com>
 <20230804084858.126104-4-aleksandr.mikhalitsyn@canonical.com>
 <8446e5c9-7dd7-a1e9-e262-13811ee9e640@redhat.com> <CAEivzxedfaD7cPfQ-sspJabw_P6zSJtOrbiAGYN35LGXPoSwcg@mail.gmail.com>
 <d119ef88-d827-5e8d-13e3-74ddfea61d7f@redhat.com>
In-Reply-To: <d119ef88-d827-5e8d-13e3-74ddfea61d7f@redhat.com>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Mon, 7 Aug 2023 12:34:39 +0200
Message-ID: <CAEivzxeu9c-ZLRmz6kmvwUpofPK23cGn27XtOBRP3xSgb_JyWA@mail.gmail.com>
Subject: Re: [PATCH v9 03/12] ceph: handle idmapped mounts in create_request_message()
To:     Xiubo Li <xiubli@redhat.com>
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 7, 2023 at 12:28=E2=80=AFPM Xiubo Li <xiubli@redhat.com> wrote:
>
>
> On 8/7/23 14:51, Aleksandr Mikhalitsyn wrote:
> > On Mon, Aug 7, 2023 at 3:25=E2=80=AFAM Xiubo Li <xiubli@redhat.com> wro=
te:
> >>
> >> On 8/4/23 16:48, Alexander Mikhalitsyn wrote:
> >>> From: Christian Brauner <brauner@kernel.org>
> >>>
> >>> Inode operations that create a new filesystem object such as ->mknod,
> >>> ->create, ->mkdir() and others don't take a {g,u}id argument explicit=
ly.
> >>> Instead the caller's fs{g,u}id is used for the {g,u}id of the new
> >>> filesystem object.
> >>>
> >>> In order to ensure that the correct {g,u}id is used map the caller's
> >>> fs{g,u}id for creation requests. This doesn't require complex changes=
.
> >>> It suffices to pass in the relevant idmapping recorded in the request
> >>> message. If this request message was triggered from an inode operatio=
n
> >>> that creates filesystem objects it will have passed down the relevant
> >>> idmaping. If this is a request message that was triggered from an ino=
de
> >>> operation that doens't need to take idmappings into account the initi=
al
> >>> idmapping is passed down which is an identity mapping.
> >>>
> >>> This change uses a new cephfs protocol extension CEPHFS_FEATURE_HAS_O=
WNER_UIDGID
> >>> which adds two new fields (owner_{u,g}id) to the request head structu=
re.
> >>> So, we need to ensure that MDS supports it otherwise we need to fail
> >>> any IO that comes through an idmapped mount because we can't process =
it
> >>> in a proper way. MDS server without such an extension will use caller=
_{u,g}id
> >>> fields to set a new inode owner UID/GID which is incorrect because ca=
ller_{u,g}id
> >>> values are unmapped. At the same time we can't map these fields with =
an
> >>> idmapping as it can break UID/GID-based permission checks logic on th=
e
> >>> MDS side. This problem was described with a lot of details at [1], [2=
].
> >>>
> >>> [1] https://lore.kernel.org/lkml/CAEivzxfw1fHO2TFA4dx3u23ZKK6Q+EThfzu=
ibrhA3RKM=3DZOYLg@mail.gmail.com/
> >>> [2] https://lore.kernel.org/all/20220104140414.155198-3-brauner@kerne=
l.org/
> >>>
> >>> Link: https://github.com/ceph/ceph/pull/52575
> >>> Link: https://tracker.ceph.com/issues/62217
> >>> Cc: Xiubo Li <xiubli@redhat.com>
> >>> Cc: Jeff Layton <jlayton@kernel.org>
> >>> Cc: Ilya Dryomov <idryomov@gmail.com>
> >>> Cc: ceph-devel@vger.kernel.org
> >>> Co-Developed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonic=
al.com>
> >>> Signed-off-by: Christian Brauner <brauner@kernel.org>
> >>> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical=
.com>
> >>> ---
> >>> v7:
> >>>        - reworked to use two new fields for owner UID/GID (https://gi=
thub.com/ceph/ceph/pull/52575)
> >>> v8:
> >>>        - properly handled case when old MDS used with new kernel clie=
nt
> >>> ---
> >>>    fs/ceph/mds_client.c         | 47 ++++++++++++++++++++++++++++++++=
+---
> >>>    fs/ceph/mds_client.h         |  5 +++-
> >>>    include/linux/ceph/ceph_fs.h |  5 +++-
> >>>    3 files changed, 52 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> >>> index 8829f55103da..41e4bf3811c4 100644
> >>> --- a/fs/ceph/mds_client.c
> >>> +++ b/fs/ceph/mds_client.c
> >>> @@ -2902,6 +2902,17 @@ static void encode_mclientrequest_tail(void **=
p, const struct ceph_mds_request *
> >>>        }
> >>>    }
> >>>
> >>> +static inline u16 mds_supported_head_version(struct ceph_mds_session=
 *session)
> >>> +{
> >>> +     if (!test_bit(CEPHFS_FEATURE_32BITS_RETRY_FWD, &session->s_feat=
ures))
> >>> +             return 1;
> >>> +
> >>> +     if (!test_bit(CEPHFS_FEATURE_HAS_OWNER_UIDGID, &session->s_feat=
ures))
> >>> +             return 2;
> >>> +
> >>> +     return CEPH_MDS_REQUEST_HEAD_VERSION;
> >>> +}
> >>> +
> >>>    static struct ceph_mds_request_head_legacy *
> >>>    find_legacy_request_head(void *p, u64 features)
> >>>    {
> >>> @@ -2923,6 +2934,7 @@ static struct ceph_msg *create_request_message(=
struct ceph_mds_session *session,
> >>>    {
> >>>        int mds =3D session->s_mds;
> >>>        struct ceph_mds_client *mdsc =3D session->s_mdsc;
> >>> +     struct ceph_client *cl =3D mdsc->fsc->client;
> >>>        struct ceph_msg *msg;
> >>>        struct ceph_mds_request_head_legacy *lhead;
> >>>        const char *path1 =3D NULL;
> >>> @@ -2936,7 +2948,7 @@ static struct ceph_msg *create_request_message(=
struct ceph_mds_session *session,
> >>>        void *p, *end;
> >>>        int ret;
> >>>        bool legacy =3D !(session->s_con.peer_features & CEPH_FEATURE_=
FS_BTIME);
> >>> -     bool old_version =3D !test_bit(CEPHFS_FEATURE_32BITS_RETRY_FWD,=
 &session->s_features);
> >>> +     u16 request_head_version =3D mds_supported_head_version(session=
);
> >>>
> >>>        ret =3D set_request_path_attr(mdsc, req->r_inode, req->r_dentr=
y,
> >>>                              req->r_parent, req->r_path1, req->r_ino1=
.ino,
> >>> @@ -2977,8 +2989,10 @@ static struct ceph_msg *create_request_message=
(struct ceph_mds_session *session,
> >>>         */
> >>>        if (legacy)
> >>>                len =3D sizeof(struct ceph_mds_request_head_legacy);
> >>> -     else if (old_version)
> >>> +     else if (request_head_version =3D=3D 1)
> >>>                len =3D sizeof(struct ceph_mds_request_head_old);
> >>> +     else if (request_head_version =3D=3D 2)
> >>> +             len =3D offsetofend(struct ceph_mds_request_head, ext_n=
um_fwd);
> >>>        else
> >>>                len =3D sizeof(struct ceph_mds_request_head);
> >>>
> >>> @@ -3028,6 +3042,16 @@ static struct ceph_msg *create_request_message=
(struct ceph_mds_session *session,
> >>>        lhead =3D find_legacy_request_head(msg->front.iov_base,
> >>>                                         session->s_con.peer_features)=
;
> >>>
> >>> +     if ((req->r_mnt_idmap !=3D &nop_mnt_idmap) &&
> >>> +         !test_bit(CEPHFS_FEATURE_HAS_OWNER_UIDGID, &session->s_feat=
ures)) {
> >>> +             pr_err_ratelimited_client(cl,
> >>> +                     "idmapped mount is used and CEPHFS_FEATURE_HAS_=
OWNER_UIDGID"
> >>> +                     " is not supported by MDS. Fail request with -E=
IO.\n");
> >>> +
> >>> +             ret =3D -EIO;
> >>> +             goto out_err;
> >>> +     }
> >>> +
> >>>        /*
> >>>         * The ceph_mds_request_head_legacy didn't contain a version f=
ield, and
> >>>         * one was added when we moved the message version from 3->4.
> >>> @@ -3035,17 +3059,34 @@ static struct ceph_msg *create_request_messag=
e(struct ceph_mds_session *session,
> >>>        if (legacy) {
> >>>                msg->hdr.version =3D cpu_to_le16(3);
> >>>                p =3D msg->front.iov_base + sizeof(*lhead);
> >>> -     } else if (old_version) {
> >>> +     } else if (request_head_version =3D=3D 1) {
> >>>                struct ceph_mds_request_head_old *ohead =3D msg->front=
.iov_base;
> >>>
> >>>                msg->hdr.version =3D cpu_to_le16(4);
> >>>                ohead->version =3D cpu_to_le16(1);
> >>>                p =3D msg->front.iov_base + sizeof(*ohead);
> >>> +     } else if (request_head_version =3D=3D 2) {
> >>> +             struct ceph_mds_request_head *nhead =3D msg->front.iov_=
base;
> >>> +
> >>> +             msg->hdr.version =3D cpu_to_le16(6);
> >>> +             nhead->version =3D cpu_to_le16(2);
> >>> +
> >>> +             p =3D msg->front.iov_base + offsetofend(struct ceph_mds=
_request_head, ext_num_fwd);
> >>>        } else {
> >>>                struct ceph_mds_request_head *nhead =3D msg->front.iov=
_base;
> >>> +             kuid_t owner_fsuid;
> >>> +             kgid_t owner_fsgid;
> >>>
> >>>                msg->hdr.version =3D cpu_to_le16(6);
> >>>                nhead->version =3D cpu_to_le16(CEPH_MDS_REQUEST_HEAD_V=
ERSION);
> >>> +             nhead->struct_len =3D sizeof(struct ceph_mds_request_he=
ad);
> >>> +
> >>> +             owner_fsuid =3D from_vfsuid(req->r_mnt_idmap, &init_use=
r_ns,
> >>> +                                       VFSUIDT_INIT(req->r_cred->fsu=
id));
> >>> +             owner_fsgid =3D from_vfsgid(req->r_mnt_idmap, &init_use=
r_ns,
> >>> +                                       VFSGIDT_INIT(req->r_cred->fsg=
id));
> >>> +             nhead->owner_uid =3D cpu_to_le32(from_kuid(&init_user_n=
s, owner_fsuid));
> >>> +             nhead->owner_gid =3D cpu_to_le32(from_kgid(&init_user_n=
s, owner_fsgid));
> >>>                p =3D msg->front.iov_base + sizeof(*nhead);
> >>>        }
> >>>
> >>> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> >>> index e3bbf3ba8ee8..8f683e8203bd 100644
> >>> --- a/fs/ceph/mds_client.h
> >>> +++ b/fs/ceph/mds_client.h
> >>> @@ -33,8 +33,10 @@ enum ceph_feature_type {
> >>>        CEPHFS_FEATURE_NOTIFY_SESSION_STATE,
> >>>        CEPHFS_FEATURE_OP_GETVXATTR,
> >>>        CEPHFS_FEATURE_32BITS_RETRY_FWD,
> >>> +     CEPHFS_FEATURE_NEW_SNAPREALM_INFO,
> >>> +     CEPHFS_FEATURE_HAS_OWNER_UIDGID,
> >>>
> >>> -     CEPHFS_FEATURE_MAX =3D CEPHFS_FEATURE_32BITS_RETRY_FWD,
> >>> +     CEPHFS_FEATURE_MAX =3D CEPHFS_FEATURE_HAS_OWNER_UIDGID,
> >>>    };
> >>>
> >>>    #define CEPHFS_FEATURES_CLIENT_SUPPORTED {  \
> >>> @@ -49,6 +51,7 @@ enum ceph_feature_type {
> >>>        CEPHFS_FEATURE_NOTIFY_SESSION_STATE,    \
> >>>        CEPHFS_FEATURE_OP_GETVXATTR,            \
> >>>        CEPHFS_FEATURE_32BITS_RETRY_FWD,        \
> >>> +     CEPHFS_FEATURE_HAS_OWNER_UIDGID,        \
> >>>    }
> >>>
> >>>    /*
> >>> diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_f=
s.h
> >>> index 5f2301ee88bc..b91699b08f26 100644
> >>> --- a/include/linux/ceph/ceph_fs.h
> >>> +++ b/include/linux/ceph/ceph_fs.h
> >>> @@ -499,7 +499,7 @@ struct ceph_mds_request_head_legacy {
> >>>        union ceph_mds_request_args args;
> >>>    } __attribute__ ((packed));
> >>>
> >>> -#define CEPH_MDS_REQUEST_HEAD_VERSION  2
> >>> +#define CEPH_MDS_REQUEST_HEAD_VERSION  3
> >>>
> >>>    struct ceph_mds_request_head_old {
> >>>        __le16 version;                /* struct version */
> >>> @@ -530,6 +530,9 @@ struct ceph_mds_request_head {
> >>>
> >>>        __le32 ext_num_retry;          /* new count retry attempts */
> >>>        __le32 ext_num_fwd;            /* new count fwd attempts */
> >>> +
> >>> +     __le32 struct_len;             /* to store size of struct ceph_=
mds_request_head */
> >>> +     __le32 owner_uid, owner_gid;   /* used for OPs which create ino=
des */
> >> Let's also initialize them to -1 for all the other requests as we do i=
n
> >> your PR.
> > They are always initialized already. As you can see from the code we
> > don't have any extra conditions
> > on filling these fields. We always fill them with an appropriate
> > UID/GID. If mount is not idmapped then it's just =3D=3D caller_uid/gid,
> > if mount idmapped then it's idmapped caller_uid/gid.
>
> Then in kclient all the request will always initialized the
> 'owner_{uid/gid}' with 'caller_{uid/gid}'. While in userspace libcephfs
> it will only set them for 'create/mknod/mkdir/symlink` instead.
>
> I'd prefer to make them consistent, which is what I am still focusing
> on, to make them easier to read and comparing when troubles hooting.

Dear Xiubo,

Sure, I will do it.

Couldn't you please review all the rest of the patches before I fix
this particular thing?
It will allow me to fix and send -v10 with all required fixes
incorporated in it.

Kind regards,
Alex

>
> Thanks
>
> - Xiubo
>
> > Kind regards,
> > Alex
> >
> >> Thanks
> >>
> >> - Xiubo
> >>
> >>
> >>
> >>>    } __attribute__ ((packed));
> >>>
> >>>    /* cap/lease release record */
>
