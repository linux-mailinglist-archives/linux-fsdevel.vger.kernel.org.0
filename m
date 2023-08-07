Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A1277226E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Aug 2023 13:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbjHGLdp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 07:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232864AbjHGLcc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 07:32:32 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6FE2737
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Aug 2023 04:29:47 -0700 (PDT)
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 57D1B3F20E
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Aug 2023 11:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691407726;
        bh=qbnbOFh51mi/qrG/7hcqEm7+2Y8f9kd/IJcmNmyo2uY=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=cyTCkcim7GGKpmGkTo6E+OiQADp3bU/rtNSPo+a1RdrqaXyHs4ozhybbWM4LGdB5C
         wz/HZLwb1vrbwaTXX3gwNOo6+6gKlKdHzq/kqt41armLaWpMmVz6TxQHph7/chHi4n
         +uCtNx24XoZVndgpk5ViiwePq8iVoqLKJxCL93FHoBUpwqN/zge5GWyNfn4icexA8e
         l3XNHrpx+Cdc8DZxKyhund8JpL8rUvGGPmCTFHkA+CY8n+PiOWanumuhorEIFetCrl
         +Q7sfDB3kHe5Cyh3m0xwFF0VjsCFQRMIiTyZx2BvzPth5MYpwhvYAPKzVytcWi4V79
         H9VFvtEuYLXLw==
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-585fb08172bso52162817b3.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Aug 2023 04:28:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691407725; x=1692012525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qbnbOFh51mi/qrG/7hcqEm7+2Y8f9kd/IJcmNmyo2uY=;
        b=HY4bP8SCCvrjFVQ2+vOI0uooqvb8GCjySfIFVdbEMZWHF/XSSLupeydPHtt20uTd3V
         ktk15EFMyLMq45NU+fdTw4PcVOKRhnkNAoXQB1nTqffZDddHtVnzsD+FjX1rL4KdB52j
         o2fTMoXbqKgfezPPpqQK7vIjPExwrjt40s+lg4kDYTtfrx6cCFkyuvAcEvjFQ7UbDp0J
         znHoCy7Xjch5MntVQpdsspgGYcGhydHk/5cRhsUsx+4e/q+muqAOvMeO7BaV2xn57Lzh
         YjIHrL49DAWqMvUBeUdvfAOtGumK9rD+PhF+yYYVfJ7o7KwPENmlDKg7ejOYDtaQv7ia
         EgXQ==
X-Gm-Message-State: AOJu0YxOL3qKsdA4sWWH3DiBXyu0PqmrZv9SMZVUqSE7nqmeV1I9OQiu
        LcCtyub1vse/n8Y+C50DzLbHLnjZhiQQGynLkQd7ZP3gwDMoQUDax8lm7/VsZbIPoH7yuP7640q
        vio6thIqzeMszyngNQw5xXDO8YG5QwEtWnjncvpbWFWXlaQ3Qwr3MIAmgZg8=
X-Received: by 2002:a25:804e:0:b0:d0f:1f24:c620 with SMTP id a14-20020a25804e000000b00d0f1f24c620mr8058405ybn.9.1691407725114;
        Mon, 07 Aug 2023 04:28:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5AfpQ5OxPjO08RVKQslwxqbfNLDRI8BDefn6TTJJPa35dvfssWDJ1aF3OqRfAHIA1TfHP8AYt4tOHmxY3Ofo=
X-Received: by 2002:a25:804e:0:b0:d0f:1f24:c620 with SMTP id
 a14-20020a25804e000000b00d0f1f24c620mr8058393ybn.9.1691407724852; Mon, 07 Aug
 2023 04:28:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230804084858.126104-1-aleksandr.mikhalitsyn@canonical.com>
 <20230804084858.126104-4-aleksandr.mikhalitsyn@canonical.com>
 <8446e5c9-7dd7-a1e9-e262-13811ee9e640@redhat.com> <CAEivzxedfaD7cPfQ-sspJabw_P6zSJtOrbiAGYN35LGXPoSwcg@mail.gmail.com>
 <d119ef88-d827-5e8d-13e3-74ddfea61d7f@redhat.com> <CAEivzxeu9c-ZLRmz6kmvwUpofPK23cGn27XtOBRP3xSgb_JyWA@mail.gmail.com>
 <abb24879-1606-7cb4-c136-4ba1f18b1140@redhat.com>
In-Reply-To: <abb24879-1606-7cb4-c136-4ba1f18b1140@redhat.com>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Mon, 7 Aug 2023 13:28:34 +0200
Message-ID: <CAEivzxdTvDJ9htu7sVUkWFi35gMid07waA-2u=wne-B9auLEzg@mail.gmail.com>
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

On Mon, Aug 7, 2023 at 1:21=E2=80=AFPM Xiubo Li <xiubli@redhat.com> wrote:
>
>
> On 8/7/23 18:34, Aleksandr Mikhalitsyn wrote:
> > On Mon, Aug 7, 2023 at 12:28=E2=80=AFPM Xiubo Li <xiubli@redhat.com> wr=
ote:
> >>
> >> On 8/7/23 14:51, Aleksandr Mikhalitsyn wrote:
> >>> On Mon, Aug 7, 2023 at 3:25=E2=80=AFAM Xiubo Li <xiubli@redhat.com> w=
rote:
> >>>> On 8/4/23 16:48, Alexander Mikhalitsyn wrote:
> >>>>> From: Christian Brauner <brauner@kernel.org>
> >>>>>
> >>>>> Inode operations that create a new filesystem object such as ->mkno=
d,
> >>>>> ->create, ->mkdir() and others don't take a {g,u}id argument explic=
itly.
> >>>>> Instead the caller's fs{g,u}id is used for the {g,u}id of the new
> >>>>> filesystem object.
> >>>>>
> >>>>> In order to ensure that the correct {g,u}id is used map the caller'=
s
> >>>>> fs{g,u}id for creation requests. This doesn't require complex chang=
es.
> >>>>> It suffices to pass in the relevant idmapping recorded in the reque=
st
> >>>>> message. If this request message was triggered from an inode operat=
ion
> >>>>> that creates filesystem objects it will have passed down the releva=
nt
> >>>>> idmaping. If this is a request message that was triggered from an i=
node
> >>>>> operation that doens't need to take idmappings into account the ini=
tial
> >>>>> idmapping is passed down which is an identity mapping.
> >>>>>
> >>>>> This change uses a new cephfs protocol extension CEPHFS_FEATURE_HAS=
_OWNER_UIDGID
> >>>>> which adds two new fields (owner_{u,g}id) to the request head struc=
ture.
> >>>>> So, we need to ensure that MDS supports it otherwise we need to fai=
l
> >>>>> any IO that comes through an idmapped mount because we can't proces=
s it
> >>>>> in a proper way. MDS server without such an extension will use call=
er_{u,g}id
> >>>>> fields to set a new inode owner UID/GID which is incorrect because =
caller_{u,g}id
> >>>>> values are unmapped. At the same time we can't map these fields wit=
h an
> >>>>> idmapping as it can break UID/GID-based permission checks logic on =
the
> >>>>> MDS side. This problem was described with a lot of details at [1], =
[2].
> >>>>>
> >>>>> [1] https://lore.kernel.org/lkml/CAEivzxfw1fHO2TFA4dx3u23ZKK6Q+EThf=
zuibrhA3RKM=3DZOYLg@mail.gmail.com/
> >>>>> [2] https://lore.kernel.org/all/20220104140414.155198-3-brauner@ker=
nel.org/
> >>>>>
> >>>>> Link: https://github.com/ceph/ceph/pull/52575
> >>>>> Link: https://tracker.ceph.com/issues/62217
> >>>>> Cc: Xiubo Li <xiubli@redhat.com>
> >>>>> Cc: Jeff Layton <jlayton@kernel.org>
> >>>>> Cc: Ilya Dryomov <idryomov@gmail.com>
> >>>>> Cc: ceph-devel@vger.kernel.org
> >>>>> Co-Developed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canon=
ical.com>
> >>>>> Signed-off-by: Christian Brauner <brauner@kernel.org>
> >>>>> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonic=
al.com>
> >>>>> ---
> >>>>> v7:
> >>>>>         - reworked to use two new fields for owner UID/GID (https:/=
/github.com/ceph/ceph/pull/52575)
> >>>>> v8:
> >>>>>         - properly handled case when old MDS used with new kernel c=
lient
> >>>>> ---
> >>>>>     fs/ceph/mds_client.c         | 47 +++++++++++++++++++++++++++++=
++++---
> >>>>>     fs/ceph/mds_client.h         |  5 +++-
> >>>>>     include/linux/ceph/ceph_fs.h |  5 +++-
> >>>>>     3 files changed, 52 insertions(+), 5 deletions(-)
> >>>>>
> >>>>> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> >>>>> index 8829f55103da..41e4bf3811c4 100644
> >>>>> --- a/fs/ceph/mds_client.c
> >>>>> +++ b/fs/ceph/mds_client.c
> >>>>> @@ -2902,6 +2902,17 @@ static void encode_mclientrequest_tail(void =
**p, const struct ceph_mds_request *
> >>>>>         }
> >>>>>     }
> >>>>>
> >>>>> +static inline u16 mds_supported_head_version(struct ceph_mds_sessi=
on *session)
> >>>>> +{
> >>>>> +     if (!test_bit(CEPHFS_FEATURE_32BITS_RETRY_FWD, &session->s_fe=
atures))
> >>>>> +             return 1;
> >>>>> +
> >>>>> +     if (!test_bit(CEPHFS_FEATURE_HAS_OWNER_UIDGID, &session->s_fe=
atures))
> >>>>> +             return 2;
> >>>>> +
> >>>>> +     return CEPH_MDS_REQUEST_HEAD_VERSION;
> >>>>> +}
> >>>>> +
> >>>>>     static struct ceph_mds_request_head_legacy *
> >>>>>     find_legacy_request_head(void *p, u64 features)
> >>>>>     {
> >>>>> @@ -2923,6 +2934,7 @@ static struct ceph_msg *create_request_messag=
e(struct ceph_mds_session *session,
> >>>>>     {
> >>>>>         int mds =3D session->s_mds;
> >>>>>         struct ceph_mds_client *mdsc =3D session->s_mdsc;
> >>>>> +     struct ceph_client *cl =3D mdsc->fsc->client;
> >>>>>         struct ceph_msg *msg;
> >>>>>         struct ceph_mds_request_head_legacy *lhead;
> >>>>>         const char *path1 =3D NULL;
> >>>>> @@ -2936,7 +2948,7 @@ static struct ceph_msg *create_request_messag=
e(struct ceph_mds_session *session,
> >>>>>         void *p, *end;
> >>>>>         int ret;
> >>>>>         bool legacy =3D !(session->s_con.peer_features & CEPH_FEATU=
RE_FS_BTIME);
> >>>>> -     bool old_version =3D !test_bit(CEPHFS_FEATURE_32BITS_RETRY_FW=
D, &session->s_features);
> >>>>> +     u16 request_head_version =3D mds_supported_head_version(sessi=
on);
> >>>>>
> >>>>>         ret =3D set_request_path_attr(mdsc, req->r_inode, req->r_de=
ntry,
> >>>>>                               req->r_parent, req->r_path1, req->r_i=
no1.ino,
> >>>>> @@ -2977,8 +2989,10 @@ static struct ceph_msg *create_request_messa=
ge(struct ceph_mds_session *session,
> >>>>>          */
> >>>>>         if (legacy)
> >>>>>                 len =3D sizeof(struct ceph_mds_request_head_legacy)=
;
> >>>>> -     else if (old_version)
> >>>>> +     else if (request_head_version =3D=3D 1)
> >>>>>                 len =3D sizeof(struct ceph_mds_request_head_old);
> >>>>> +     else if (request_head_version =3D=3D 2)
> >>>>> +             len =3D offsetofend(struct ceph_mds_request_head, ext=
_num_fwd);
> >>>>>         else
> >>>>>                 len =3D sizeof(struct ceph_mds_request_head);
> >>>>>
> >>>>> @@ -3028,6 +3042,16 @@ static struct ceph_msg *create_request_messa=
ge(struct ceph_mds_session *session,
> >>>>>         lhead =3D find_legacy_request_head(msg->front.iov_base,
> >>>>>                                          session->s_con.peer_featur=
es);
> >>>>>
> >>>>> +     if ((req->r_mnt_idmap !=3D &nop_mnt_idmap) &&
> >>>>> +         !test_bit(CEPHFS_FEATURE_HAS_OWNER_UIDGID, &session->s_fe=
atures)) {
> >>>>> +             pr_err_ratelimited_client(cl,
> >>>>> +                     "idmapped mount is used and CEPHFS_FEATURE_HA=
S_OWNER_UIDGID"
> >>>>> +                     " is not supported by MDS. Fail request with =
-EIO.\n");
> >>>>> +
> >>>>> +             ret =3D -EIO;
> >>>>> +             goto out_err;
> >>>>> +     }
> >>>>> +
> >>>>>         /*
> >>>>>          * The ceph_mds_request_head_legacy didn't contain a versio=
n field, and
> >>>>>          * one was added when we moved the message version from 3->=
4.
> >>>>> @@ -3035,17 +3059,34 @@ static struct ceph_msg *create_request_mess=
age(struct ceph_mds_session *session,
> >>>>>         if (legacy) {
> >>>>>                 msg->hdr.version =3D cpu_to_le16(3);
> >>>>>                 p =3D msg->front.iov_base + sizeof(*lhead);
> >>>>> -     } else if (old_version) {
> >>>>> +     } else if (request_head_version =3D=3D 1) {
> >>>>>                 struct ceph_mds_request_head_old *ohead =3D msg->fr=
ont.iov_base;
> >>>>>
> >>>>>                 msg->hdr.version =3D cpu_to_le16(4);
> >>>>>                 ohead->version =3D cpu_to_le16(1);
> >>>>>                 p =3D msg->front.iov_base + sizeof(*ohead);
> >>>>> +     } else if (request_head_version =3D=3D 2) {
> >>>>> +             struct ceph_mds_request_head *nhead =3D msg->front.io=
v_base;
> >>>>> +
> >>>>> +             msg->hdr.version =3D cpu_to_le16(6);
> >>>>> +             nhead->version =3D cpu_to_le16(2);
> >>>>> +
> >>>>> +             p =3D msg->front.iov_base + offsetofend(struct ceph_m=
ds_request_head, ext_num_fwd);
> >>>>>         } else {
> >>>>>                 struct ceph_mds_request_head *nhead =3D msg->front.=
iov_base;
> >>>>> +             kuid_t owner_fsuid;
> >>>>> +             kgid_t owner_fsgid;
> >>>>>
> >>>>>                 msg->hdr.version =3D cpu_to_le16(6);
> >>>>>                 nhead->version =3D cpu_to_le16(CEPH_MDS_REQUEST_HEA=
D_VERSION);
> >>>>> +             nhead->struct_len =3D sizeof(struct ceph_mds_request_=
head);
> >>>>> +
> >>>>> +             owner_fsuid =3D from_vfsuid(req->r_mnt_idmap, &init_u=
ser_ns,
> >>>>> +                                       VFSUIDT_INIT(req->r_cred->f=
suid));
> >>>>> +             owner_fsgid =3D from_vfsgid(req->r_mnt_idmap, &init_u=
ser_ns,
> >>>>> +                                       VFSGIDT_INIT(req->r_cred->f=
sgid));
> >>>>> +             nhead->owner_uid =3D cpu_to_le32(from_kuid(&init_user=
_ns, owner_fsuid));
> >>>>> +             nhead->owner_gid =3D cpu_to_le32(from_kgid(&init_user=
_ns, owner_fsgid));
> >>>>>                 p =3D msg->front.iov_base + sizeof(*nhead);
> >>>>>         }
> >>>>>
> >>>>> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> >>>>> index e3bbf3ba8ee8..8f683e8203bd 100644
> >>>>> --- a/fs/ceph/mds_client.h
> >>>>> +++ b/fs/ceph/mds_client.h
> >>>>> @@ -33,8 +33,10 @@ enum ceph_feature_type {
> >>>>>         CEPHFS_FEATURE_NOTIFY_SESSION_STATE,
> >>>>>         CEPHFS_FEATURE_OP_GETVXATTR,
> >>>>>         CEPHFS_FEATURE_32BITS_RETRY_FWD,
> >>>>> +     CEPHFS_FEATURE_NEW_SNAPREALM_INFO,
> >>>>> +     CEPHFS_FEATURE_HAS_OWNER_UIDGID,
> >>>>>
> >>>>> -     CEPHFS_FEATURE_MAX =3D CEPHFS_FEATURE_32BITS_RETRY_FWD,
> >>>>> +     CEPHFS_FEATURE_MAX =3D CEPHFS_FEATURE_HAS_OWNER_UIDGID,
> >>>>>     };
> >>>>>
> >>>>>     #define CEPHFS_FEATURES_CLIENT_SUPPORTED {  \
> >>>>> @@ -49,6 +51,7 @@ enum ceph_feature_type {
> >>>>>         CEPHFS_FEATURE_NOTIFY_SESSION_STATE,    \
> >>>>>         CEPHFS_FEATURE_OP_GETVXATTR,            \
> >>>>>         CEPHFS_FEATURE_32BITS_RETRY_FWD,        \
> >>>>> +     CEPHFS_FEATURE_HAS_OWNER_UIDGID,        \
> >>>>>     }
> >>>>>
> >>>>>     /*
> >>>>> diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph=
_fs.h
> >>>>> index 5f2301ee88bc..b91699b08f26 100644
> >>>>> --- a/include/linux/ceph/ceph_fs.h
> >>>>> +++ b/include/linux/ceph/ceph_fs.h
> >>>>> @@ -499,7 +499,7 @@ struct ceph_mds_request_head_legacy {
> >>>>>         union ceph_mds_request_args args;
> >>>>>     } __attribute__ ((packed));
> >>>>>
> >>>>> -#define CEPH_MDS_REQUEST_HEAD_VERSION  2
> >>>>> +#define CEPH_MDS_REQUEST_HEAD_VERSION  3
> >>>>>
> >>>>>     struct ceph_mds_request_head_old {
> >>>>>         __le16 version;                /* struct version */
> >>>>> @@ -530,6 +530,9 @@ struct ceph_mds_request_head {
> >>>>>
> >>>>>         __le32 ext_num_retry;          /* new count retry attempts =
*/
> >>>>>         __le32 ext_num_fwd;            /* new count fwd attempts */
> >>>>> +
> >>>>> +     __le32 struct_len;             /* to store size of struct cep=
h_mds_request_head */
> >>>>> +     __le32 owner_uid, owner_gid;   /* used for OPs which create i=
nodes */
> >>>> Let's also initialize them to -1 for all the other requests as we do=
 in
> >>>> your PR.
> >>> They are always initialized already. As you can see from the code we
> >>> don't have any extra conditions
> >>> on filling these fields. We always fill them with an appropriate
> >>> UID/GID. If mount is not idmapped then it's just =3D=3D caller_uid/gi=
d,
> >>> if mount idmapped then it's idmapped caller_uid/gid.
> >> Then in kclient all the request will always initialized the
> >> 'owner_{uid/gid}' with 'caller_{uid/gid}'. While in userspace libcephf=
s
> >> it will only set them for 'create/mknod/mkdir/symlink` instead.
> >>
> >> I'd prefer to make them consistent, which is what I am still focusing
> >> on, to make them easier to read and comparing when troubles hooting.
> > Dear Xiubo,
> >
> > Sure, I will do it.
> >
> > Couldn't you please review all the rest of the patches before I fix
> > this particular thing?
> > It will allow me to fix and send -v10 with all required fixes
> > incorporated in it.
>
> I have gone through them all and they LGTM.

Thanks!

Kind regards,
Alex

>
> Thanks
>
> - Xiubo
>
>
> > Kind regards,
> > Alex
> >
> >> Thanks
> >>
> >> - Xiubo
> >>
> >>> Kind regards,
> >>> Alex
> >>>
> >>>> Thanks
> >>>>
> >>>> - Xiubo
> >>>>
> >>>>
> >>>>
> >>>>>     } __attribute__ ((packed));
> >>>>>
> >>>>>     /* cap/lease release record */
>
