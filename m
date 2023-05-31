Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978A371876C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 18:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjEaQdV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 12:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjEaQdT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 12:33:19 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175DE186
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 May 2023 09:33:16 -0700 (PDT)
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com [209.85.219.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 486364135A
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 May 2023 16:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1685550793;
        bh=m/PJ/CXwEb65uT4DFpZ+uGiDR+RX6ZXvA6Ht4wNjPd0=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=PWIU5LNoMljBBuo6ttpqxwa3dQ3Bt+oqtdC7OCKP27vx0gxixGHatbGBedOfAWyPI
         55RTtK4OZgh/2Q65hmZRP3jl6S+z6dW4qYoNKbWpHcQDgtd2R8HYwxtS44D2AlJv7U
         1HocoyvF3dV1HfNYzLebCShjRrJi5WjwSl0lKlBkmEp0uNg0MLTF3wrtyAma+yRVGt
         h/lhuHlLLeDcXksaG1/qzLhg89Be98DVerqWqlwlpxxIqaSYvsnHw1Blt8natJxm/5
         xFIDwlq89tli+slDan0YJmzfbP/s9txSJKudSW+jZYQBt2hxEo+L0QbT0Uy/FUP8fn
         Tlh4uNX28mo7g==
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-ba81b24b878so13282969276.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 May 2023 09:33:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685550789; x=1688142789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m/PJ/CXwEb65uT4DFpZ+uGiDR+RX6ZXvA6Ht4wNjPd0=;
        b=Xl0jkmIFMZpIiNfpFAkBxySA+Pk/DoPRCYgyASxokip2DuagfWYVr7FfbmgqVam6hL
         /ORD4vGpksYNblTiDL0XQ94NLnvpXVvIefwsh+9mLgG1TMF+3NYzHZIKstu70hy70CDD
         6YWkoI1DSlYWxSvMQRRs7BpBugdv16t9VxtgCb8imv+Jp87Riwccc//l/cozmVaRWPBq
         rQsCpFE9hVfQ2tyWW0zFdptiDS8wqNI+nNIH6LXMC0hTEBjT3x18YCE+trGPZT2ypAxj
         3T5toemmanUyQRplT9u1fAicatz5jlCIPTBLoSRd1RxEqOMMkV5e801ZoeO1Qy+3PaQN
         jb1g==
X-Gm-Message-State: AC+VfDzDVPDPbrobNO3vAXFtD0b53kFgzv14lGfhQ+qelmAYbMBAD5c4
        V1d6eT1TBtKViwkA5Seje95zy2sAKqhSDc7DBA0XQ8/chBbeCk2nddwUpxop8fdZVBgsVpeQbK6
        WS58MYhH5l52jjHv0ZcvIcXq22EDppoeb2x+0iLhng5v+gr3qx8BZTv1ZqSo=
X-Received: by 2002:a05:6902:1505:b0:bac:faf2:328f with SMTP id q5-20020a056902150500b00bacfaf2328fmr8340535ybu.6.1685550789232;
        Wed, 31 May 2023 09:33:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7VwMFjJ6I1kI/q4G8IJki1b4aua7xnWZtK4tAMTC+l7jBaace5D4HMOcq85LgFDI94JK4vh0rlthgII7pxaMA=
X-Received: by 2002:a05:6902:1505:b0:bac:faf2:328f with SMTP id
 q5-20020a056902150500b00bacfaf2328fmr8340518ybu.6.1685550788957; Wed, 31 May
 2023 09:33:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230524153316.476973-1-aleksandr.mikhalitsyn@canonical.com>
 <20230524153316.476973-4-aleksandr.mikhalitsyn@canonical.com> <ec6d6cf4-a1f9-ac45-d23d-b69805d81c02@redhat.com>
In-Reply-To: <ec6d6cf4-a1f9-ac45-d23d-b69805d81c02@redhat.com>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Wed, 31 May 2023 18:32:57 +0200
Message-ID: <CAEivzxe6t08UDv6ksKfqS6BP1HaunMxr2LTGZULX5_uQ5gaT=w@mail.gmail.com>
Subject: Re: [PATCH v2 03/13] ceph: handle idmapped mounts in create_request_message()
To:     Xiubo Li <xiubli@redhat.com>
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 29, 2023 at 5:52=E2=80=AFAM Xiubo Li <xiubli@redhat.com> wrote:
>
>
> On 5/24/23 23:33, Alexander Mikhalitsyn wrote:
> > From: Christian Brauner <christian.brauner@ubuntu.com>
> >
> > Inode operations that create a new filesystem object such as ->mknod,
> > ->create, ->mkdir() and others don't take a {g,u}id argument explicitly=
.
> > Instead the caller's fs{g,u}id is used for the {g,u}id of the new
> > filesystem object.
> >
> > Cephfs mds creation request argument structures mirror this filesystem
> > behavior. They don't encode a {g,u}id explicitly. Instead the caller's
> > fs{g,u}id that is always sent as part of any mds request is used by the
> > servers to set the {g,u}id of the new filesystem object.
> >
> > In order to ensure that the correct {g,u}id is used map the caller's
> > fs{g,u}id for creation requests. This doesn't require complex changes.
> > It suffices to pass in the relevant idmapping recorded in the request
> > message. If this request message was triggered from an inode operation
> > that creates filesystem objects it will have passed down the relevant
> > idmaping. If this is a request message that was triggered from an inode
> > operation that doens't need to take idmappings into account the initial
> > idmapping is passed down which is an identity mapping and thus is
> > guaranteed to leave the caller's fs{g,u}id unchanged.,u}id is sent.
> >
> > The last few weeks before Christmas 2021 I have spent time not just
> > reading and poking the cephfs kernel code but also took a look at the
> > ceph mds server userspace to ensure I didn't miss some subtlety.
> >
> > This made me aware of one complication to solve. All requests send the
> > caller's fs{g,u}id over the wire. The caller's fs{g,u}id matters for th=
e
> > server in exactly two cases:
> >
> > 1. to set the ownership for creation requests
> > 2. to determine whether this client is allowed access on this server
> >
> > Case 1. we already covered and explained. Case 2. is only relevant for
> > servers where an explicit uid access restriction has been set. That is
> > to say the mds server restricts access to requests coming from a
> > specific uid. Servers without uid restrictions will grant access to
> > requests from any uid by setting MDS_AUTH_UID_ANY.
> >
> > Case 2. introduces the complication because the caller's fs{g,u}id is
> > not just used to record ownership but also serves as the {g,u}id used
> > when checking access to the server.
> >
> > Consider a user mounting a cephfs client and creating an idmapped mount
> > from it that maps files owned by uid 1000 to be owned uid 0:
> >
> > mount -t cephfs -o [...] /unmapped
> > mount-idmapped --map-mount 1000:0:1 /idmapped
> >
> > That is to say if the mounted cephfs filesystem contains a file "file1"
> > which is owned by uid 1000:
> >
> > - looking at it via /unmapped/file1 will report it as owned by uid 1000
> >    (One can think of this as the on-disk value.)
> > - looking at it via /idmapped/file1 will report it as owned by uid 0
> >
> > Now, consider creating new files via the idmapped mount at /idmapped.
> > When a caller with fs{g,u}id 1000 creates a file "file2" by going
> > through the idmapped mount mounted at /idmapped it will create a file
> > that is owned by uid 1000 on-disk, i.e.:
> >
> > - looking at it via /unmapped/file2 will report it as owned by uid 1000
> > - looking at it via /idmapped/file2 will report it as owned by uid 0
> >
> > Now consider an mds server that has a uid access restriction set and
> > only grants access to requests from uid 0.
> >
> > If the client sends a creation request for a file e.g. /idmapped/file2
> > it will send the caller's fs{g,u}id idmapped according to the idmapped
> > mount. So if the caller has fs{g,u}id 1000 it will be mapped to {g,u}id
> > 0 in the idmapped mount and will be sent over the wire allowing the
> > caller access to the mds server.
> >
> > However, if the caller is not issuing a creation request the caller's
> > fs{g,u}id will be send without the mount's idmapping applied. So if the
> > caller that just successfully created a new file on the restricted mds
> > server sends a request as fs{g,u}id 1000 access will be refused. This
> > however is inconsistent.
> >
> >  From my perspective the root of the problem lies in the fact that
> > creation requests implicitly infer the ownership from the {g,u}id that
> > gets sent along with every mds request.
> >
> > I have thought of multiple ways of addressing this problem but the one =
I
> > prefer is to give all mds requests that create a filesystem object a
> > proper, separate {g,u}id field entry in the argument struct. This is,
> > for example how ->setattr mds requests work.
> >
> > This way the caller's fs{g,u}id can be used consistenly for server
> > access checks and is separated from the ownership for new filesystem
> > objects.
> >
> > Servers could then be updated to refuse creation requests whenever the
> > {g,u}id used for access checking doesn't match the {g,u}id used for
> > creating the filesystem object just as is done for setattr requests on =
a
> > uid restricted server. But I am, of course, open to other suggestions.
> >
> > Cc: Jeff Layton <jlayton@kernel.org>
> > Cc: Ilya Dryomov <idryomov@gmail.com>
> > Cc: ceph-devel@vger.kernel.org
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.c=
om>
> > ---
> >   fs/ceph/mds_client.c | 22 ++++++++++++++++++----
> >   1 file changed, 18 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > index 810c3db2e369..e4265843b838 100644
> > --- a/fs/ceph/mds_client.c
> > +++ b/fs/ceph/mds_client.c
> > @@ -2583,6 +2583,8 @@ static struct ceph_msg *create_request_message(st=
ruct ceph_mds_session *session,
> >       void *p, *end;
> >       int ret;
> >       bool legacy =3D !(session->s_con.peer_features & CEPH_FEATURE_FS_=
BTIME);
> > +     kuid_t caller_fsuid;
> > +     kgid_t caller_fsgid;
> >
> >       ret =3D set_request_path_attr(req->r_inode, req->r_dentry,
> >                             req->r_parent, req->r_path1, req->r_ino1.in=
o,
> > @@ -2651,10 +2653,22 @@ static struct ceph_msg *create_request_message(=
struct ceph_mds_session *session,
> >
> >       head->mdsmap_epoch =3D cpu_to_le32(mdsc->mdsmap->m_epoch);
> >       head->op =3D cpu_to_le32(req->r_op);
> > -     head->caller_uid =3D cpu_to_le32(from_kuid(&init_user_ns,
> > -                                              req->r_cred->fsuid));
> > -     head->caller_gid =3D cpu_to_le32(from_kgid(&init_user_ns,
> > -                                              req->r_cred->fsgid));
> > +     /*
> > +      * Inode operations that create filesystem objects based on the
> > +      * caller's fs{g,u}id like ->mknod(), ->create(), ->mkdir() etc. =
don't
> > +      * have separate {g,u}id fields in their respective structs in th=
e
> > +      * ceph_mds_request_args union. Instead the caller_{g,u}id field =
is
> > +      * used to set ownership of the newly created inode by the mds se=
rver.
> > +      * For these inode operations we need to send the mapped fs{g,u}i=
d over
> > +      * the wire. For other cases we simple set req->r_mnt_idmap to th=
e
> > +      * initial idmapping meaning the unmapped fs{g,u}id is sent.
> > +      */
> > +     caller_fsuid =3D from_vfsuid(req->r_mnt_idmap, &init_user_ns,
> > +                                     VFSUIDT_INIT(req->r_cred->fsuid))=
;
> > +     caller_fsgid =3D from_vfsgid(req->r_mnt_idmap, &init_user_ns,
> > +                                     VFSGIDT_INIT(req->r_cred->fsgid))=
;
> > +     head->caller_uid =3D cpu_to_le32(from_kuid(&init_user_ns, caller_=
fsuid));
> > +     head->caller_gid =3D cpu_to_le32(from_kgid(&init_user_ns, caller_=
fsgid));
>
> Hi Alexander,

Dear Xiubo,

Thanks for paying attention to this series!

>
> You didn't answer Jeff and Greg's concerns in the first version
> https://www.spinics.net/lists/ceph-devel/msg53356.html.

I've tried to respin discussion in the -v1 thread:
https://lore.kernel.org/all/20230519134420.2d04e5f70aad15679ab566fc@canonic=
al.com/

No one replied, so I decided to send rebased and slightly changed -v2,
where I've fixed this:
https://lore.kernel.org/all/041afbfd171915d62ab9a93c7a35d9c9d5c5bf7b.camel@=
kernel.org/

>
> I am also confused as Greg mentioned. If we just map the ids as 1000:0
> and created a file and then map the ids 1000:10, then the file couldn't
> be accessible, right ? Is this normal and as expected ?

This can be a problem only if filtering based on the UID is turned on
on the server side (which is a relatively rare case).

idmapped mounts are not about mapping a caller UID/GID, idmapped
mounts are about mapping inode owner's UID/GID.
So, for example if you have UID 1000 (on disk) and have an idmapping
1000:0 then it will be shown as owned by 0.
If you create a file from a user with UID 0 then you will get UID 1000
on disk. To achieve that, we map a current user fs{g,u}id
when sending a creation request according to the idmapping mount to
make things consistent. But when a user opens a file,
we are sending UID/GID as they are without applying an idmapping. Of
course, generic_permission() kernel helper is aware of
mount idmapping and before open request will go to the server we will
check that current user is allowed to open this file (and during
this check UID/GID of a current user and UID/GID of the file owner
will be properly compared). I.e. this issue is only relevant for the
case
when we have additional permission checks on the network file system
server side.

>
> IMO the idmapping should be client-side feature and we should make it
> consistent by using the unmapped fs{g,u}id always here.

To make the current user fs{g,u}id always idmapped we need to make
really big changes in the VFS layer. And it's not obvious
that it justifies the cost. Because this particular feature with
Cephfs idmapped mounts is already used/tested with LXD/LXC workloads
and it works perfectly well. And as far as I know, LXD/LXC were the
first idmapped mount adopters. IMHO, it's better to
start from this approach and if someone will want to extend this
functionality for network filesystems and want to map fs{g,u}id which
are sent over the
wire we will take a look at that. Because anyway, integration with
Cephfs is important for the LXD project and we are looking closely at
this.

Kind regards,
Alex

>
> Thanks
>
> - Xiubo
>
> >       head->ino =3D cpu_to_le64(req->r_deleg_ino);
> >       head->args =3D req->r_args;
> >
>
