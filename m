Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242B8726471
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 17:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238742AbjFGP0d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 11:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241455AbjFGP0L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:26:11 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16BE26B7
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jun 2023 08:25:43 -0700 (PDT)
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com [209.85.219.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 89EC03F154
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jun 2023 15:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686151503;
        bh=UzyjLDSH3L83BUY14PzO6igurevkkcTAFURgUF3tbLc=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=fkxgZqGqHW+pi559AF3RM4Xqo4MsornXTpBlfpZWzdOkVpji690KH2eNnHJKhWqXG
         6YMLQL4kY17Z964171EX+fLDe4qQ698rjANTla1OczbOaih3FzPh5KKKSGcT//Of9j
         QE5eR8NxSCRyqO5KzqOCzxi9Jn87IO+W2nytRWmHlG0y0b/YOCZuxvy9Q0MjzEpv1Z
         7iydsKfc8H77R8pDGekPYyxeGiwzFrofPw26xuu2OYOH5IZIt1j2r34q/88GUdOd+3
         uGPwe8o+/tEY7YOmn5F63g4TxKo+6I971SZIRWCjZv6TTGXsno/ucxV6F2qr2665r3
         4mFX7wOOfWpkQ==
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-bb3cb542875so1803042276.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jun 2023 08:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686151502; x=1688743502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UzyjLDSH3L83BUY14PzO6igurevkkcTAFURgUF3tbLc=;
        b=NCBVHRuBRc7m0lmCEASsWUmGkFnElnI3AALN4sSK7Yj2fmiERFKVgGo7BkWzhSbrg0
         8Dz9yUq5XPlg65IA6g1nnp8zy+RcGP2355Embou8j0eNEOzc+QRk3gO5Rc6gqZlvQr/2
         mR1ItYcrdc1uerTYGDAsz0qkVqElL3SCN8BQiErCY2n5QeJcaNQBh9sUJ+g5YOckvunS
         gnOuSiyVektU6FlmUk7KcFc+eRbL1yJp9COsx+u9l1puKWqdTcexTAVJMI9/oPty2gRB
         Q19RB/JE/emIv3qQzQrP0fSFi6JDLLY0D5nxxAXLT3O/OlAj9J78HiJc9Xg5Txd6ctN5
         K3HQ==
X-Gm-Message-State: AC+VfDwsAtbHzcv6c63ihgrC+KDBdlQUg8nhydryM7xbL9sZiUajlDyj
        l7hM7+Iz4YsHMPRUqZwCqpnePsFVtLgSoUhPpL1dizVChy8qrN3qLK9D4z64LWFuVdKlH2s5zhN
        BSFEMD44mHswYiU2H/h/nGnwMotYk1PLdjcG1DM/VfQB7bJWWlau/NTS/96PFsWbEYUZErQ==
X-Received: by 2002:a25:d490:0:b0:bb3:cc80:ac4a with SMTP id m138-20020a25d490000000b00bb3cc80ac4amr4129201ybf.42.1686151502103;
        Wed, 07 Jun 2023 08:25:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6IXvmlrtEA8JFTZYK+1pTV1djV0J8QwczyxESJ1HLlJOoHkSD4NIuDqcp3jr364rEsXU+wd6zZScC8KyQRz8w=
X-Received: by 2002:a25:d490:0:b0:bb3:cc80:ac4a with SMTP id
 m138-20020a25d490000000b00bb3cc80ac4amr4129185ybf.42.1686151501851; Wed, 07
 Jun 2023 08:25:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230524153316.476973-1-aleksandr.mikhalitsyn@canonical.com>
In-Reply-To: <20230524153316.476973-1-aleksandr.mikhalitsyn@canonical.com>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Wed, 7 Jun 2023 17:24:50 +0200
Message-ID: <CAEivzxejMtctdEF2BHMBM5fU-5-Ps7Qt25_yLBTzDayUVNoErg@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] ceph: support idmapped mounts
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
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

version 3 was sent
https://lore.kernel.org/lkml/20230607152038.469739-1-aleksandr.mikhalitsyn@=
canonical.com/

On Wed, May 24, 2023 at 5:33=E2=80=AFPM Alexander Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:
>
> Dear friends,
>
> This patchset was originally developed by Christian Brauner but I'll cont=
inue
> to push it forward. Christian allowed me to do that :)
>
> This feature is already actively used/tested with LXD/LXC project.
>
> v2 is just a rebased version of the original series with some small field=
 naming change.
>
> Git tree (based on https://github.com/ceph/ceph-client.git master):
> https://github.com/mihalicyn/linux/tree/fs.idmapped.ceph.v2
>
> Original description from Christian:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> This patch series enables cephfs to support idmapped mounts, i.e. the
> ability to alter ownership information on a per-mount basis.
>
> Container managers such as LXD support sharaing data via cephfs between
> the host and unprivileged containers and between unprivileged containers.
> They may all use different idmappings. Idmapped mounts can be used to
> create mounts with the idmapping used for the container (or a different
> one specific to the use-case).
>
> There are in fact more use-cases such as remapping ownership for
> mountpoints on the host itself to grant or restrict access to different
> users or to make it possible to enforce that programs running as root
> will write with a non-zero {g,u}id to disk.
>
> The patch series is simple overall and few changes are needed to cephfs.
> There is one cephfs specific issue that I would like to discuss and
> solve which I explain in detail in:
>
> [PATCH 02/12] ceph: handle idmapped mounts in create_request_message()
>
> It has to do with how to handle mds serves which have id-based access
> restrictions configured. I would ask you to please take a look at the
> explanation in the aforementioned patch.
>
> The patch series passes the vfs and idmapped mount testsuite as part of
> xfstests. To run it you will need a config like:
>
> [ceph]
> export FSTYP=3Dceph
> export TEST_DIR=3D/mnt/test
> export TEST_DEV=3D10.103.182.10:6789:/
> export TEST_FS_MOUNT_OPTS=3D"-o name=3Dadmin,secret=3D$password
>
> and then simply call
>
> sudo ./check -g idmapped
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Alexander Mikhalitsyn (1):
>   fs: export mnt_idmap_get/mnt_idmap_put
>
> Christian Brauner (12):
>   ceph: stash idmapping in mdsc request
>   ceph: handle idmapped mounts in create_request_message()
>   ceph: allow idmapped mknod inode op
>   ceph: allow idmapped symlink inode op
>   ceph: allow idmapped mkdir inode op
>   ceph: allow idmapped rename inode op
>   ceph: allow idmapped getattr inode op
>   ceph: allow idmapped permission inode op
>   ceph: allow idmapped setattr inode op
>   ceph/acl: allow idmapped set_acl inode op
>   ceph/file: allow idmapped atomic_open inode op
>   ceph: allow idmapped mounts
>
>  fs/ceph/acl.c                 |  2 +-
>  fs/ceph/dir.c                 |  4 ++++
>  fs/ceph/file.c                | 10 ++++++++--
>  fs/ceph/inode.c               | 15 +++++++++++----
>  fs/ceph/mds_client.c          | 29 +++++++++++++++++++++++++----
>  fs/ceph/mds_client.h          |  1 +
>  fs/ceph/super.c               |  2 +-
>  fs/mnt_idmapping.c            |  2 ++
>  include/linux/mnt_idmapping.h |  3 +++
>  9 files changed, 56 insertions(+), 12 deletions(-)
>
> --
> 2.34.1
>
