Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89CB27264DA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 17:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239988AbjFGPj7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 11:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241458AbjFGPjt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:39:49 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF4E1BC5
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jun 2023 08:39:45 -0700 (PDT)
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 065773F154
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jun 2023 15:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686152003;
        bh=IWFv37c+eoG8tJI1JWj5okUGLZBX2yml/Xw7WCENPys=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=ssX8PCyuNUFOOtoadK2m3mr2IAT+KEBW36aIZWDWvqB5ueiey2zRyAuSEV/t9SnN9
         /K5xHW32pwFVZ2ExIRanxCf5rYJ2ScGPxIXaXDHk/Apry6pacmb8bs73mm1IskLzyN
         YCADpVYNGB251qZ0z+96AjJ1sO0rVr/cfEGXPRRbKZDQJxCKeRiMVoncIu8Pz4BNGH
         pzA+L2N0rw6hIemeL7CaEOjEPPAEiRtOKLD/JH1nJGv51V8STPhRUuLrhhj3zTg2Zt
         GrbNc/dYm8qJatRNZJhdx4nC39J742eL/bvX82a09hQBB4XofgseuSHhLSGhBBSlzJ
         bta61CNa77FYQ==
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-568960f4596so126889557b3.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jun 2023 08:33:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686152001; x=1688744001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IWFv37c+eoG8tJI1JWj5okUGLZBX2yml/Xw7WCENPys=;
        b=VWngkmRTHRoWmbu4sTB8txxBIy8DBE21hCEczS7Ky8nTEN7gh/x4pX3MK04Orz4J9Z
         nH+JluHh30YyjGl9++Hph7O/9FdokkR4vBSNGM+KADvG7CSXuGpMzkB7M7PbRc1Y4izY
         9NH5XM8udqENiuAWvt3YGjfRClXa3WXv03p3XdGn8zI5xKPGyd7jV7d1/QXJ1PaIOV2W
         5dxeM5wma+U6a66esXkx4kK5fpFQjIfH42nPjj7tLfVn9OhajoEW/ZYvrkAN1AbRFBxH
         wkcy3sEeFz7OlLo2XubZippQtC7U/HgAAEVIkcQU9bVD9vpM50IPqLSPpgKEZKddZcyu
         ZZfw==
X-Gm-Message-State: AC+VfDzCH4bp5zH8/GdUm8DLNPFornncI4XbjimuMxsD+Qb4xfQgWyg4
        xRrWBNbUm1RZ3QVttl4tSckbRt7mC6N7wWmBAFG0pJohbScsnMdHwCgrDHPG77gQ4dWlfiwEGDb
        iwknos9it3SWmYc2nV9JrKEGypkI7Zxz8Du4yCdjhoRvHcDG6EcouzmMY7wY=
X-Received: by 2002:a81:9111:0:b0:561:da0d:6488 with SMTP id i17-20020a819111000000b00561da0d6488mr2028178ywg.50.1686152001631;
        Wed, 07 Jun 2023 08:33:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ41ujZduYo0Tx4YuzMUoEUAiQUD7l1XN5FJidm3Unip3PVpHkcdztp37wOx6A8Ub0V0IIOsJeVrBs0yIakpb2w=
X-Received: by 2002:a81:9111:0:b0:561:da0d:6488 with SMTP id
 i17-20020a819111000000b00561da0d6488mr2028126ywg.50.1686152000504; Wed, 07
 Jun 2023 08:33:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230607152038.469739-1-aleksandr.mikhalitsyn@canonical.com> <20230607152038.469739-4-aleksandr.mikhalitsyn@canonical.com>
In-Reply-To: <20230607152038.469739-4-aleksandr.mikhalitsyn@canonical.com>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Wed, 7 Jun 2023 17:33:09 +0200
Message-ID: <CAEivzxdkKENc=2a5gzyO6cX9+=XYnNHHj0NBi2fcC_2vEoaBPQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/14] ceph: handle idmapped mounts in create_request_message()
To:     xiubli@redhat.com
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 7, 2023 at 5:21=E2=80=AFPM Alexander Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:
>
> From: Christian Brauner <christian.brauner@ubuntu.com>
>
> Inode operations that create a new filesystem object such as ->mknod,
> ->create, ->mkdir() and others don't take a {g,u}id argument explicitly.
> Instead the caller's fs{g,u}id is used for the {g,u}id of the new
> filesystem object.
>
> Cephfs mds creation request argument structures mirror this filesystem
> behavior. They don't encode a {g,u}id explicitly. Instead the caller's
> fs{g,u}id that is always sent as part of any mds request is used by the
> servers to set the {g,u}id of the new filesystem object.
>
> In order to ensure that the correct {g,u}id is used map the caller's
> fs{g,u}id for creation requests. This doesn't require complex changes.
> It suffices to pass in the relevant idmapping recorded in the request
> message. If this request message was triggered from an inode operation
> that creates filesystem objects it will have passed down the relevant
> idmaping. If this is a request message that was triggered from an inode
> operation that doens't need to take idmappings into account the initial
> idmapping is passed down which is an identity mapping and thus is
> guaranteed to leave the caller's fs{g,u}id unchanged.,u}id is sent.
>
> The last few weeks before Christmas 2021 I have spent time not just
> reading and poking the cephfs kernel code but also took a look at the
> ceph mds server userspace to ensure I didn't miss some subtlety.
>
> This made me aware of one complication to solve. All requests send the
> caller's fs{g,u}id over the wire. The caller's fs{g,u}id matters for the
> server in exactly two cases:
>
> 1. to set the ownership for creation requests
> 2. to determine whether this client is allowed access on this server
>
> Case 1. we already covered and explained. Case 2. is only relevant for
> servers where an explicit uid access restriction has been set. That is
> to say the mds server restricts access to requests coming from a
> specific uid. Servers without uid restrictions will grant access to
> requests from any uid by setting MDS_AUTH_UID_ANY.
>
> Case 2. introduces the complication because the caller's fs{g,u}id is
> not just used to record ownership but also serves as the {g,u}id used
> when checking access to the server.
>
> Consider a user mounting a cephfs client and creating an idmapped mount
> from it that maps files owned by uid 1000 to be owned uid 0:
>
> mount -t cephfs -o [...] /unmapped
> mount-idmapped --map-mount 1000:0:1 /idmapped
>
> That is to say if the mounted cephfs filesystem contains a file "file1"
> which is owned by uid 1000:
>
> - looking at it via /unmapped/file1 will report it as owned by uid 1000
>   (One can think of this as the on-disk value.)
> - looking at it via /idmapped/file1 will report it as owned by uid 0
>
> Now, consider creating new files via the idmapped mount at /idmapped.
> When a caller with fs{g,u}id 1000 creates a file "file2" by going
> through the idmapped mount mounted at /idmapped it will create a file
> that is owned by uid 1000 on-disk, i.e.:
>
> - looking at it via /unmapped/file2 will report it as owned by uid 1000
> - looking at it via /idmapped/file2 will report it as owned by uid 0
>
> Now consider an mds server that has a uid access restriction set and
> only grants access to requests from uid 0.
>
> If the client sends a creation request for a file e.g. /idmapped/file2
> it will send the caller's fs{g,u}id idmapped according to the idmapped
> mount. So if the caller has fs{g,u}id 1000 it will be mapped to {g,u}id
> 0 in the idmapped mount and will be sent over the wire allowing the
> caller access to the mds server.
>
> However, if the caller is not issuing a creation request the caller's
> fs{g,u}id will be send without the mount's idmapping applied. So if the
> caller that just successfully created a new file on the restricted mds
> server sends a request as fs{g,u}id 1000 access will be refused. This
> however is inconsistent.
>
> From my perspective the root of the problem lies in the fact that
> creation requests implicitly infer the ownership from the {g,u}id that
> gets sent along with every mds request.
>
> I have thought of multiple ways of addressing this problem but the one I
> prefer is to give all mds requests that create a filesystem object a
> proper, separate {g,u}id field entry in the argument struct. This is,
> for example how ->setattr mds requests work.
>
> This way the caller's fs{g,u}id can be used consistenly for server
> access checks and is separated from the ownership for new filesystem
> objects.
>
> Servers could then be updated to refuse creation requests whenever the
> {g,u}id used for access checking doesn't match the {g,u}id used for
> creating the filesystem object just as is done for setattr requests on a
> uid restricted server. But I am, of course, open to other suggestions.
>
> Cc: Xiubo Li <xiubli@redhat.com>
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: Ilya Dryomov <idryomov@gmail.com>
> Cc: ceph-devel@vger.kernel.org
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com=
>
> ---
>  fs/ceph/mds_client.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 810c3db2e369..e4265843b838 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -2583,6 +2583,8 @@ static struct ceph_msg *create_request_message(stru=
ct ceph_mds_session *session,
>         void *p, *end;
>         int ret;
>         bool legacy =3D !(session->s_con.peer_features & CEPH_FEATURE_FS_=
BTIME);
> +       kuid_t caller_fsuid;
> +       kgid_t caller_fsgid;
>
>         ret =3D set_request_path_attr(req->r_inode, req->r_dentry,
>                               req->r_parent, req->r_path1, req->r_ino1.in=
o,
> @@ -2651,10 +2653,22 @@ static struct ceph_msg *create_request_message(st=
ruct ceph_mds_session *session,
>
>         head->mdsmap_epoch =3D cpu_to_le32(mdsc->mdsmap->m_epoch);
>         head->op =3D cpu_to_le32(req->r_op);
> -       head->caller_uid =3D cpu_to_le32(from_kuid(&init_user_ns,
> -                                                req->r_cred->fsuid));
> -       head->caller_gid =3D cpu_to_le32(from_kgid(&init_user_ns,
> -                                                req->r_cred->fsgid));
> +       /*
> +        * Inode operations that create filesystem objects based on the
> +        * caller's fs{g,u}id like ->mknod(), ->create(), ->mkdir() etc. =
don't
> +        * have separate {g,u}id fields in their respective structs in th=
e
> +        * ceph_mds_request_args union. Instead the caller_{g,u}id field =
is
> +        * used to set ownership of the newly created inode by the mds se=
rver.
> +        * For these inode operations we need to send the mapped fs{g,u}i=
d over
> +        * the wire. For other cases we simple set req->r_mnt_idmap to th=
e
> +        * initial idmapping meaning the unmapped fs{g,u}id is sent.
> +        */
> +       caller_fsuid =3D from_vfsuid(req->r_mnt_idmap, &init_user_ns,
> +                                       VFSUIDT_INIT(req->r_cred->fsuid))=
;
> +       caller_fsgid =3D from_vfsgid(req->r_mnt_idmap, &init_user_ns,
> +                                       VFSGIDT_INIT(req->r_cred->fsgid))=
;
> +       head->caller_uid =3D cpu_to_le32(from_kuid(&init_user_ns, caller_=
fsuid));
> +       head->caller_gid =3D cpu_to_le32(from_kgid(&init_user_ns, caller_=
fsgid));
>         head->ino =3D cpu_to_le64(req->r_deleg_ino);
>         head->args =3D req->r_args;
>
> --
> 2.34.1
>

Probably it's worth adding to a commit message or cover letter, but
let it be there for now.

Explanation/demonstration from this thread:
https://lore.kernel.org/lkml/CAEivzxefBRPozUPQxYgVh0gOpjsovtBuJ3w9BoqSizpST=
_YxTA@mail.gmail.com/#t

1. Mount cephfs

mount.ceph admin@XYZ.cephfs=3D/ /mnt/ceph -o
mon_addr=3D127.0.0.1:6789,secret=3Dvery_secret_key

2. Make 1000:1000 a root dentry owner (it will be convenient because
we want to use mapping 1000:0:1 for simplicity)

chown 1000:1000 /mnt/ceph

3. create an idmapped mount based on a regular /mnt/ceph mount using a
mount-idmapped tool that was written by Christian.
[ taken from https://raw.githubusercontent.com/brauner/mount-idmapped/maste=
r/mount-idmapped.c
]

./mount-idmapped --map-mount b:1000:0:1 /mnt/ceph /mnt/ceph_idmapped

"b" stands for "both", so we are creating a mapping of length 1 for
both UID and GID.
1000 is a UID/GID "on-disk", 0 is a mapped UID/GID.

4. Just to be precise, let's look at which UID/GID we have now.

root@ubuntu:/home/ubuntu# ls -lan /mnt/ceph
total 4
drwxrwxrwx 2 1000 1000    0 Jun  1 17:51 .
drwxr-xr-x 4    0    0 4096 Jun  1 16:55 ..

root@ubuntu:/home/ubuntu# ls -lan /mnt/ceph_idmapped
total 4
drwxrwxrwx 2 0 0    0 Jun  1 17:51 .
drwxr-xr-x 4 0 0 4096 Jun  1 16:55 ..

5. Now let's create a bunch of files with different owners and through
different mounts (idmapped/non-idmapped).

5.1. Create a file from 0:0 through the idmapped mount (it should
appear as 1000:1000 on disk)
root@ubuntu:/home/ubuntu# sudo -u#0 -g#0 touch
/mnt/ceph_idmapped/created_through_idmapped_mnt_with_uid0

5.2. Create a file from 1000:1000 through the idmapped mount (should
fail because 1000:1000 is not a valid UID/GID as it can't be mapped
back to the "on-disk" UID/GID set).
root@ubuntu:/home/ubuntu# sudo -u#1000 -g#1000 touch
/mnt/ceph_idmapped/created_through_idmapped_mnt_with_uid1000
touch: cannot touch
'/mnt/ceph_idmapped/created_through_idmapped_mnt_with_uid1000': Value
too large for defined data type

... and we've got EOVERFLOW. That's correct!

5.3. Create a file from 0:0 but through the regular mount. (it should
appear as overflowuid(=3D65534) in idmapped mount, because 0:0 on-disk
is not mapped to the UID/GID set).

root@ubuntu:/home/ubuntu# sudo -u#0 -g#0 touch
/mnt/ceph/created_directly_with_uid0

5.4. Create a file from 1000:1000 but through the regular mount. (it
should appear as 0:0 in idmapped mount, because 1000 (on-disk) mapped
to 0).

root@ubuntu:/home/ubuntu# sudo -u#1000 -g#1000 touch
/mnt/ceph/created_directly_with_uid1000

6. Now let's look on the result:

root@ubuntu:/home/ubuntu# ls -lan /mnt/ceph
total 4
drwxrwxrwx 2 1000 1000    3 Jun  1 17:54 .
drwxr-xr-x 4    0    0 4096 Jun  1 16:55 ..
-rw-r--r-- 1    0    0    0 Jun  1 17:54 created_directly_with_uid0
-rw-rw-r-- 1 1000 1000    0 Jun  1 17:54 created_directly_with_uid1000
-rw-r--r-- 1 1000 1000    0 Jun  1 17:53 created_through_idmapped_mnt_with_=
uid0

root@ubuntu:/home/ubuntu# ls -lan /mnt/ceph_idmapped
total 4
drwxrwxrwx 2     0     0    3 Jun  1 17:54 .
drwxr-xr-x 4     0     0 4096 Jun  1 16:55 ..
-rw-r--r-- 1 65534 65534    0 Jun  1 17:54 created_directly_with_uid0
-rw-rw-r-- 1     0     0    0 Jun  1 17:54 created_directly_with_uid1000
-rw-r--r-- 1     0     0    0 Jun  1 17:53
created_through_idmapped_mnt_with_uid0
