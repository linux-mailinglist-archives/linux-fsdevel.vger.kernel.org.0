Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F3D7278A7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 09:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235315AbjFHHWB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 03:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235361AbjFHHVl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:21:41 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F332D57
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jun 2023 00:21:14 -0700 (PDT)
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 59E1E3F0F8
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jun 2023 07:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686208869;
        bh=ZsNRIyP+X7XOHybtDnn1u0u6wdb6BoZre2xC4a+Lfzc=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=J64qou7sI4dYNm7WOG8SzcrbN47b3LXQ8Pps9rK70L4w86OgSaKqJVrt+lZWQtZQS
         NVuNe7hq/eWW72Kp8DWF4PPy+84iRHL+cz6il4pxRX00HmU85wptGfUTjgWWVu97cV
         CoanG7XoWR2WDg5TjDxm9Gou40F+LuP3kC4o8V+RyTkHAM6bAxNs0cyuZIHWsYtWJf
         v1oVexNKuHcic5+XBt4bN7Ef1behHYg+HWrFVrmZXj9M5h9Cu7cE+WSeP6XoBeqnDg
         v8M5mUh5FbEjCmO1iNQIQQarPBEOOAXhBxwxM1bYoemT7cXlkqsTDKsr2YnbQfrMU5
         Pqj9ALQXMsooA==
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-5651d8acfe2so4778577b3.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jun 2023 00:21:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686208868; x=1688800868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZsNRIyP+X7XOHybtDnn1u0u6wdb6BoZre2xC4a+Lfzc=;
        b=SKfGKaObpSut+9jUNdc5NbA5Gra5X5jcDL3BiXPa9EvZmE6HS3ePT+kkdHuWsT2XVF
         2eIyBA5Ht6CxuTFTG7ZIi3+3oiPtVc2+XJwuGsjZkRTB5fGc6+hsZZJSqg3fAicTsv39
         DwUaEcQuEG+CIBFTwulin6g+Bo8QUDP7ugvSJIoApIj7H9BTuztG0a9vMO4WyAzcyyu5
         TE4S+A5xvRTUVU9sRl3W3/CDlUGQw0uRPHPBo4EczoMTt0nOQSwUpZ7x8t+41x95gkjw
         D1X54BiuyaEM0WA/jQJPcJLAMcawATZFyt356dKLYKfaGnlIZTSyY7il0ZzCEGVTGdj2
         Yrmw==
X-Gm-Message-State: AC+VfDy+SFjrOp0vnJiAB4Jszrt5LyvwCA5EP45hlg35TkiVcEpNCpMB
        wAT/hn9PXXOXQ0qxloUnVD4hfLcKUje14DwnrwfkPP2/3yq2j/BAtZvmUQABTgIwkiClYoJBXV2
        0KOsDA0hWXU32sxCqYWebtDZmqc+LCTEK7mXmj9bQEY0Pes8w+SgU2EeI3og=
X-Received: by 2002:a0d:ca89:0:b0:565:beb0:75b4 with SMTP id m131-20020a0dca89000000b00565beb075b4mr8683765ywd.49.1686208868284;
        Thu, 08 Jun 2023 00:21:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7X2flYyQdAEDNe82m+exDFIM0FQhBAqb+nyjjoepRZiJyrTEM1CairZrf0ohrMfiXcDXJEqvo+y7+2o3p1YDA=
X-Received: by 2002:a0d:ca89:0:b0:565:beb0:75b4 with SMTP id
 m131-20020a0dca89000000b00565beb075b4mr8683747ywd.49.1686208867965; Thu, 08
 Jun 2023 00:21:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230607180958.645115-1-aleksandr.mikhalitsyn@canonical.com> <8b22fc1e-595a-b729-dd21-2714f22a28a7@redhat.com>
In-Reply-To: <8b22fc1e-595a-b729-dd21-2714f22a28a7@redhat.com>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Thu, 8 Jun 2023 09:20:56 +0200
Message-ID: <CAEivzxfkinMgLWNc7u=bMw7HFkjZjDTJKtNNZhF7fZB=VuNTeQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] ceph: support idmapped mounts
To:     Xiubo Li <xiubli@redhat.com>
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 8, 2023 at 5:01=E2=80=AFAM Xiubo Li <xiubli@redhat.com> wrote:
>
> Hi Alexander,

Dear Xiubo,

>
> As I mentioned in V2 thread
> https://www.spinics.net/lists/kernel/msg4810994.html, we should use the
> 'idmap' for all the requests below, because MDS will do the
> 'check_access()' for all the requests by using the caller uid/gid,
> please see
> https://github.com/ceph/ceph/blob/main/src/mds/Server.cc#L3294-L3310.
>
>
> Cscope tag: ceph_mdsc_do_request
>     #   line  filename / context / line
>     1    321  fs/ceph/addr.c <<ceph_netfs_issue_op_inline>>
>               err =3D ceph_mdsc_do_request(mdsc, NULL, req);
>     2    443  fs/ceph/dir.c <<ceph_readdir>>
>               err =3D ceph_mdsc_do_request(mdsc, NULL, req);
>     3    838  fs/ceph/dir.c <<ceph_lookup>>
>               err =3D ceph_mdsc_do_request(mdsc, NULL, req);
>     4    933  fs/ceph/dir.c <<ceph_mknod>>
>               err =3D ceph_mdsc_do_request(mdsc, dir, req);
>     5   1045  fs/ceph/dir.c <<ceph_symlink>>
>               err =3D ceph_mdsc_do_request(mdsc, dir, req);
>     6   1120  fs/ceph/dir.c <<ceph_mkdir>>
>               err =3D ceph_mdsc_do_request(mdsc, dir, req);
>     7   1180  fs/ceph/dir.c <<ceph_link>>
>               err =3D ceph_mdsc_do_request(mdsc, dir, req);
>     8   1365  fs/ceph/dir.c <<ceph_unlink>>
>               err =3D ceph_mdsc_do_request(mdsc, dir, req);
>     9   1431  fs/ceph/dir.c <<ceph_rename>>
>               err =3D ceph_mdsc_do_request(mdsc, old_dir, req);
>    10   1927  fs/ceph/dir.c <<ceph_d_revalidate>>
>               err =3D ceph_mdsc_do_request(mdsc, NULL, req);
>    11    154  fs/ceph/export.c <<__lookup_inode>>
>               err =3D ceph_mdsc_do_request(mdsc, NULL, req);
>    12    262  fs/ceph/export.c <<__snapfh_to_dentry>>
>               err =3D ceph_mdsc_do_request(mdsc, NULL, req);
>    13    347  fs/ceph/export.c <<__get_parent>>
>               err =3D ceph_mdsc_do_request(mdsc, NULL, req);
>    14    490  fs/ceph/export.c <<__get_snap_name>>
>               err =3D ceph_mdsc_do_request(fsc->mdsc, NULL, req);
>    15    561  fs/ceph/export.c <<ceph_get_name>>
>               err =3D ceph_mdsc_do_request(mdsc, NULL, req);
>    16    339  fs/ceph/file.c <<ceph_renew_caps>>
>               err =3D ceph_mdsc_do_request(mdsc, NULL, req);
>    17    434  fs/ceph/file.c <<ceph_open>>
>               err =3D ceph_mdsc_do_request(mdsc, NULL, req);
>    18    855  fs/ceph/file.c <<ceph_atomic_open>>
>               err =3D ceph_mdsc_do_request(mdsc, (flags & O_CREAT) ? dir =
:
> NULL, req);
>    19   2715  fs/ceph/inode.c <<__ceph_setattr>>
>               err =3D ceph_mdsc_do_request(mdsc, NULL, req);
>    20   2839  fs/ceph/inode.c <<__ceph_do_getattr>>
>               err =3D ceph_mdsc_do_request(mdsc, NULL, req);
>    21   2883  fs/ceph/inode.c <<ceph_do_getvxattr>>
>               err =3D ceph_mdsc_do_request(mdsc, NULL, req);
>    22    126  fs/ceph/ioctl.c <<ceph_ioctl_set_layout>>
>               err =3D ceph_mdsc_do_request(mdsc, NULL, req);
>    23    171  fs/ceph/ioctl.c <<ceph_ioctl_set_layout_policy>>
>               err =3D ceph_mdsc_do_request(mdsc, inode, req);
>    24    216  fs/ceph/locks.c <<ceph_lock_wait_for_completion>>
>               err =3D ceph_mdsc_do_request(mdsc, inode, intr_req);
>    25   1091  fs/ceph/super.c <<open_root_dentry>>
>               err =3D ceph_mdsc_do_request(mdsc, NULL, req);
>    26   1151  fs/ceph/xattr.c <<ceph_sync_setxattr>>
>               err =3D ceph_mdsc_do_request(mdsc, NULL, req);

Sure, I remember about this point and as far as I mentioned earlier
https://lore.kernel.org/all/20230519134420.2d04e5f70aad15679ab566fc@canonic=
al.com/
It is a discussional thing, because not all the inode_operations
allows us to get a mount idmapping.

For instance,
lookup, get_link, get_inode_acl, readlink, link, unlink, rmdir,
listxattr, fiemap, update_time, fileattr_get
inode_operations are not provided with an idmapping.

atomic_open also lacks the mnt_idmap argument, but we have a struct
file so we can get an idmapping through it.

As far as I can see from the code:
https://raw.githubusercontent.com/ceph/ceph/main/src/mds/Server.cc
We have Server::check_access calls for all inode_operations, including
the lookup.

It means that with the current VFS we are not able to support MDS
UID/GID-based path restriction with idmapped mounts.
But we can return to it later if someone really wants it.

If I understand your idea right, you want me to set req->r_mnt_idmap
to an actual idmapping everywhere, where it is possible,
and ignore inode_operations where we have no idmapping passed?

Christian's approach was more conservative here, his idea was to pass
an idmapping only to the operations that are creating
some nodes on the filesystem, but pass a "nop_mnt_idmap" to everyone else.

So, I'll try to set up MDS UID/GID-based path restriction on my local
environment and reproduce the issue with it,
but as I mentioned earlier we can't support it right now anyway. But
as we already have an idmappings supported for most
of existing filesystems, having it supported for cephfs would be great
(even with this limitation about MDS UID/GID-based path restriction),
because we already have a real world use cases for cephfs idmapped
mounts and this particular patchset is used by LXD/LXC for more that a
year.
We can extend this later, if someone really wants to use this
combination and once we extend the VFS layer.

>
>
> And also could you squash the similar commit into one ?

Sure, you mean commits that do `req->r_mnt_idmap =3D
mnt_idmap_get(idmap)`? Will do.

Big thanks for the fast reaction/review on this series, Xiubo!

>

Kind regards,
Alex

>
> Thanks
>
> - Xiubo
>
>
> On 6/8/23 02:09, Alexander Mikhalitsyn wrote:
> > Dear friends,
> >
> > This patchset was originally developed by Christian Brauner but I'll co=
ntinue
> > to push it forward. Christian allowed me to do that :)
> >
> > This feature is already actively used/tested with LXD/LXC project.
> >
> > Git tree (based on https://github.com/ceph/ceph-client.git master):
> > https://github.com/mihalicyn/linux/tree/fs.idmapped.ceph
> >
> > In the version 3 I've changed only two commits:
> > - fs: export mnt_idmap_get/mnt_idmap_put
> > - ceph: allow idmapped setattr inode op
> > and added a new one:
> > - ceph: pass idmap to __ceph_setattr
> >
> > In the version 4 I've reworked the ("ceph: stash idmapping in mdsc requ=
est")
> > commit. Now we take idmap refcounter just in place where req->r_mnt_idm=
ap
> > is filled. It's more safer approach and prevents possible refcounter un=
derflow
> > on error paths where __register_request wasn't called but ceph_mdsc_rel=
ease_request is
> > called.
> >
> > I can confirm that this version passes xfstests.
> >
> > Links to previous versions:
> > v1: https://lore.kernel.org/all/20220104140414.155198-1-brauner@kernel.=
org/
> > v2: https://lore.kernel.org/lkml/20230524153316.476973-1-aleksandr.mikh=
alitsyn@canonical.com/
> > v3: https://lore.kernel.org/lkml/20230607152038.469739-1-aleksandr.mikh=
alitsyn@canonical.com/#t
> >
> > Kind regards,
> > Alex
> >
> > Original description from Christian:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > This patch series enables cephfs to support idmapped mounts, i.e. the
> > ability to alter ownership information on a per-mount basis.
> >
> > Container managers such as LXD support sharaing data via cephfs between
> > the host and unprivileged containers and between unprivileged container=
s.
> > They may all use different idmappings. Idmapped mounts can be used to
> > create mounts with the idmapping used for the container (or a different
> > one specific to the use-case).
> >
> > There are in fact more use-cases such as remapping ownership for
> > mountpoints on the host itself to grant or restrict access to different
> > users or to make it possible to enforce that programs running as root
> > will write with a non-zero {g,u}id to disk.
> >
> > The patch series is simple overall and few changes are needed to cephfs=
.
> > There is one cephfs specific issue that I would like to discuss and
> > solve which I explain in detail in:
> >
> > [PATCH 02/12] ceph: handle idmapped mounts in create_request_message()
> >
> > It has to do with how to handle mds serves which have id-based access
> > restrictions configured. I would ask you to please take a look at the
> > explanation in the aforementioned patch.
> >
> > The patch series passes the vfs and idmapped mount testsuite as part of
> > xfstests. To run it you will need a config like:
> >
> > [ceph]
> > export FSTYP=3Dceph
> > export TEST_DIR=3D/mnt/test
> > export TEST_DEV=3D10.103.182.10:6789:/
> > export TEST_FS_MOUNT_OPTS=3D"-o name=3Dadmin,secret=3D$password
> >
> > and then simply call
> >
> > sudo ./check -g idmapped
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Alexander Mikhalitsyn (2):
> >    fs: export mnt_idmap_get/mnt_idmap_put
> >    ceph: pass idmap to __ceph_setattr
> >
> > Christian Brauner (12):
> >    ceph: stash idmapping in mdsc request
> >    ceph: handle idmapped mounts in create_request_message()
> >    ceph: allow idmapped mknod inode op
> >    ceph: allow idmapped symlink inode op
> >    ceph: allow idmapped mkdir inode op
> >    ceph: allow idmapped rename inode op
> >    ceph: allow idmapped getattr inode op
> >    ceph: allow idmapped permission inode op
> >    ceph: allow idmapped setattr inode op
> >    ceph/acl: allow idmapped set_acl inode op
> >    ceph/file: allow idmapped atomic_open inode op
> >    ceph: allow idmapped mounts
> >
> >   fs/ceph/acl.c                 |  6 +++---
> >   fs/ceph/dir.c                 |  4 ++++
> >   fs/ceph/file.c                | 10 ++++++++--
> >   fs/ceph/inode.c               | 29 +++++++++++++++++------------
> >   fs/ceph/mds_client.c          | 27 +++++++++++++++++++++++----
> >   fs/ceph/mds_client.h          |  1 +
> >   fs/ceph/super.c               |  2 +-
> >   fs/ceph/super.h               |  3 ++-
> >   fs/mnt_idmapping.c            |  2 ++
> >   include/linux/mnt_idmapping.h |  3 +++
> >   10 files changed, 64 insertions(+), 23 deletions(-)
> >
>
