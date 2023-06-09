Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11557293FF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 11:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239812AbjFIJAf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 05:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241149AbjFII7i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:59:38 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465732711
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jun 2023 01:59:34 -0700 (PDT)
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com [209.85.219.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 72AAF3F15D
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jun 2023 08:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686301172;
        bh=cTj4GjB/9BDLM3nhk88ZM05TgDh034XIKIkWicIblZI=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=UPEIm71ivdXScEOIPAC7GgUVXPcm0WlIrPV/bMuNNGOmDDTnUsQFrKG0bfBPjnnZQ
         cSuWRawS2oUpwfB49VKanruhRHmErCOVT2A76yAJBHI0XIufZyCLX144zRgG5Z9LOp
         4cAwqndEDzUNqangWaXmjLcpUxGESxarArnuPmqtAWk4atvfofabEzYeIu1uSs5uEc
         kAT1gCWe5EtM17cloK+PAiNN0yD61rC9KYDSKfdoWlhKIBoRkAEVi/wLTWZNoq6BZf
         LCXJv4d5yMPEFln0rI8pPRUQu/QRe3Uem1GHyPkODjZgRIPn+mKzXHOAqP0kmvjrqL
         9T95dmiPT4+7g==
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-babb78a3daaso2286994276.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Jun 2023 01:59:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686301171; x=1688893171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cTj4GjB/9BDLM3nhk88ZM05TgDh034XIKIkWicIblZI=;
        b=SPaZ5S2qgiVGPkVHv2XGzrVqWlrkO4tuitcx810iyccSoexK1qRw3SJWcTspxZuBam
         zzH26UNLsFeopMQltZbcNMh7BspvktBJS58a7jH20mrFrb/fBntuvdyvppr2abNKLkip
         TMOTVuRYb/t02GJSC8qbHQoPjntQ3ZwN9hGRqEjZuyx4p5e/EWravIelfRzcjeSdlZoF
         bovpfyGL1WltK8CXOeYnfxiQMAnjCKEt1DjYsk0YZh28BsWqlkXyj5WIv03Fr+38yzmo
         lnIafaHpeopJhRDxUA/V0NdV2bVn8PfMlDQQL3sYtdHhMq+HUd9H1Cmod/IrG5HgUF16
         fRyQ==
X-Gm-Message-State: AC+VfDxzNSZMeJNUpU3Awu2jxJnc1lcU493pXuZw0Fu+FYIb9Dlp2BNF
        6z6nlAgL/pa3Jjfvg5CTHVJFNLgAvP7jOK9tK4Vmep4TxMJfdzAgXulzjRbWnhSQ1+wzHr4M4Am
        7tdX/ESL3cY47ycF0myihB8bM29F5q14XAGhBjLm5VNeQAQVbsck9Xx6UlZA=
X-Received: by 2002:a5b:804:0:b0:bac:9ba9:ada1 with SMTP id x4-20020a5b0804000000b00bac9ba9ada1mr453479ybp.28.1686301171351;
        Fri, 09 Jun 2023 01:59:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ59zGfy4dc8gYfqdDXyKBfpVeg1LYolpGdxg+escyvURJkfZF5yKxZDvex7d5pDFzFcyR4N0J3pJDQefXNnAL0=
X-Received: by 2002:a5b:804:0:b0:bac:9ba9:ada1 with SMTP id
 x4-20020a5b0804000000b00bac9ba9ada1mr453466ybp.28.1686301171072; Fri, 09 Jun
 2023 01:59:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230608154256.562906-1-aleksandr.mikhalitsyn@canonical.com> <f3864ed6-8c97-8a7a-f268-dab29eb2fb21@redhat.com>
In-Reply-To: <f3864ed6-8c97-8a7a-f268-dab29eb2fb21@redhat.com>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Fri, 9 Jun 2023 10:59:19 +0200
Message-ID: <CAEivzxcRsHveuW3nrPnSBK6_2-eT4XPvza3kN2oogvnbVXBKvQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/14] ceph: support idmapped mounts
To:     Xiubo Li <xiubli@redhat.com>
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
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

On Fri, Jun 9, 2023 at 3:57=E2=80=AFAM Xiubo Li <xiubli@redhat.com> wrote:
>
>
> On 6/8/23 23:42, Alexander Mikhalitsyn wrote:
> > Dear friends,
> >
> > This patchset was originally developed by Christian Brauner but I'll co=
ntinue
> > to push it forward. Christian allowed me to do that :)
> >
> > This feature is already actively used/tested with LXD/LXC project.
> >
> > Git tree (based on https://github.com/ceph/ceph-client.git master):

Hi Xiubo!

>
> Could you rebase these patches to 'testing' branch ?

Will do in -v6.

>
> And you still have missed several places, for example the following cases=
:
>
>
>     1    269  fs/ceph/addr.c <<ceph_netfs_issue_op_inline>>
>               req =3D ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_GETATTR,
> mode);

+

>     2    389  fs/ceph/dir.c <<ceph_readdir>>
>               req =3D ceph_mdsc_create_request(mdsc, op, USE_AUTH_MDS);

+

>     3    789  fs/ceph/dir.c <<ceph_lookup>>
>               req =3D ceph_mdsc_create_request(mdsc, op, USE_ANY_MDS);

We don't have an idmapping passed to lookup from the VFS layer. As I
mentioned before, it's just impossible now.

I've checked all places with ceph_mdsc_create_request and passed
idmapping everywhere if possible (in v6, that I will send soon).

>     ...
>
>
> For this requests you also need to set the real idmap.

Thanks,
Alex

>
>
> Thanks
>
> - Xiubo
>
>
>
> > v5: https://github.com/mihalicyn/linux/commits/fs.idmapped.ceph.v5
> > current: https://github.com/mihalicyn/linux/tree/fs.idmapped.ceph
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
> > Changelog for version 5:
> > - a few commits were squashed into one (as suggested by Xiubo Li)
> > - started passing an idmapping everywhere (if possible), so a caller
> > UID/GID-s will be mapped almost everywhere (as suggested by Xiubo Li)
> >
> > I can confirm that this version passes xfstests.
> >
> > Links to previous versions:
> > v1: https://lore.kernel.org/all/20220104140414.155198-1-brauner@kernel.=
org/
> > v2: https://lore.kernel.org/lkml/20230524153316.476973-1-aleksandr.mikh=
alitsyn@canonical.com/
> > tree: https://github.com/mihalicyn/linux/commits/fs.idmapped.ceph.v2
> > v3: https://lore.kernel.org/lkml/20230607152038.469739-1-aleksandr.mikh=
alitsyn@canonical.com/#t
> > v4: https://lore.kernel.org/lkml/20230607180958.645115-1-aleksandr.mikh=
alitsyn@canonical.com/#t
> > tree: https://github.com/mihalicyn/linux/commits/fs.idmapped.ceph.v4
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
> > Alexander Mikhalitsyn (5):
> >    fs: export mnt_idmap_get/mnt_idmap_put
> >    ceph: pass idmap to __ceph_setattr
> >    ceph: pass idmap to ceph_do_getattr
> >    ceph: pass idmap to __ceph_setxattr
> >    ceph: pass idmap to ceph_open/ioctl_set_layout
> >
> > Christian Brauner (9):
> >    ceph: stash idmapping in mdsc request
> >    ceph: handle idmapped mounts in create_request_message()
> >    ceph: pass an idmapping to mknod/symlink/mkdir/rename
> >    ceph: allow idmapped getattr inode op
> >    ceph: allow idmapped permission inode op
> >    ceph: allow idmapped setattr inode op
> >    ceph/acl: allow idmapped set_acl inode op
> >    ceph/file: allow idmapped atomic_open inode op
> >    ceph: allow idmapped mounts
> >
> >   fs/ceph/acl.c                 |  8 ++++----
> >   fs/ceph/addr.c                |  3 ++-
> >   fs/ceph/caps.c                |  3 ++-
> >   fs/ceph/dir.c                 |  4 ++++
> >   fs/ceph/export.c              |  2 +-
> >   fs/ceph/file.c                | 21 ++++++++++++++-----
> >   fs/ceph/inode.c               | 38 +++++++++++++++++++++-------------=
-
> >   fs/ceph/ioctl.c               |  9 +++++++--
> >   fs/ceph/mds_client.c          | 27 +++++++++++++++++++++----
> >   fs/ceph/mds_client.h          |  1 +
> >   fs/ceph/quota.c               |  2 +-
> >   fs/ceph/super.c               |  6 +++---
> >   fs/ceph/super.h               | 14 ++++++++-----
> >   fs/ceph/xattr.c               | 18 +++++++++--------
> >   fs/mnt_idmapping.c            |  2 ++
> >   include/linux/mnt_idmapping.h |  3 +++
> >   16 files changed, 111 insertions(+), 50 deletions(-)
> >
>
