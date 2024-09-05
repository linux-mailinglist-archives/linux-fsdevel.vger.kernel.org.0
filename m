Return-Path: <linux-fsdevel+bounces-28784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCE296E319
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 21:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 441C8B24BB8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 19:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1964E18D658;
	Thu,  5 Sep 2024 19:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GIensF/j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DED18037;
	Thu,  5 Sep 2024 19:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725564267; cv=none; b=N1CsOnPi6miq3Y7ojULL/r6QgOZoWYe7Zl2d0m5BLGL1j7q2gLd9LnW27mzRCCrWrVN414eGCrn0du7CqM0aY38oKANPpof8hkTj24M/MkrC+NOO85Ol6wSwLh1+6g8si+tsJlmrfbA2IFClSd9b58WTKjFQDlFYvDKnEdOB29I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725564267; c=relaxed/simple;
	bh=sDEF0H6JnV15/JAcpy7dDyRvthsl9PWlzlLViH5r+N0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pDzYe6llhekT0JSRmyf1t/tVtYAm1qVLEoMSuUIr9/lR4z73TftL8737kNCP+UWZMOXVB6rEJ7DsLS0inNoHMJW9oMBfA1RoYqEiC2d/vNSERTADgpVa7kIznCU0fvvsiGO0UWOF/nriMo/oAHlUkTf+cTIOjBsR7bI4LSiMHhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GIensF/j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03C5BC4CEC9;
	Thu,  5 Sep 2024 19:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725564265;
	bh=sDEF0H6JnV15/JAcpy7dDyRvthsl9PWlzlLViH5r+N0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GIensF/j7325j3Knp2YYk4uzK5OaTA24iFaZvlP3IP/kzH+FlkNMRw4T06FrBy2GE
	 ml2a7w9c++YZmd16XjFmvuPkrwNmoSVZMESSmrl1/fn73Ou7NmAkeKBfm9X5Lmix/Q
	 Ct8MTbqpjM5hqRwDV/Wsjx8x8bChOowghEe+Am4STtMB9sDnXBTZqLNWa8bfg8bdzn
	 FCTsDd6DOJXH2T/q9ISz9EOM2ZQhg8xW93U+rIrCfY6UkXcElimctFyDMjututPsTe
	 x+huGtvj2KzdQgDBoppq/dr/BiLHiZYt3d/6Wjvn52FeAgLzULWc22SMiiz1dEnqeJ
	 fzNpIb3SVkVcg==
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-456825b4314so11199041cf.0;
        Thu, 05 Sep 2024 12:24:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVJEHaiyEu4mS3cK27CB4RaPtrH0ODNasz1OUPAS1x28zcoqJVfAbMxxp7C9vSSBrmtdaMxCh9tkCWcSsiv@vger.kernel.org
X-Gm-Message-State: AOJu0YwGRcyJpX4oGbPg8t1ENKtR6lfGiDAdRDd4rmabKJIYSw0L+R93
	ysn9CcdRNIar+AIX1K4CH8o43HSlHszRyolZhZq+NzUGAc7Uip0jHINbO0J2PT+cDrG1fFq2L6L
	nJ0I1+OjQXrP4auQUlgfRnFYp/jk=
X-Google-Smtp-Source: AGHT+IFXh1uzl2cyMdWJU9l+NQP147Q/HgOj6IxoaGDgsXKSbQ/Eax+Atz0eYaerP3AH3QdYSLMNRcsSAhXgutYAigE=
X-Received: by 2002:ac8:5804:0:b0:457:cbf7:310 with SMTP id
 d75a77b69052e-4580c3cf1b0mr8154041cf.14.1725564264278; Thu, 05 Sep 2024
 12:24:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240831223755.8569-1-snitzer@kernel.org> <20240831223755.8569-15-snitzer@kernel.org>
In-Reply-To: <20240831223755.8569-15-snitzer@kernel.org>
From: Anna Schumaker <anna@kernel.org>
Date: Thu, 5 Sep 2024 15:24:06 -0400
X-Gmail-Original-Message-ID: <CAFX2Jf=chLdC-eip0JFbtjE+2pDq7G1vbRunB4OD2ZRd2=sDVQ@mail.gmail.com>
Message-ID: <CAFX2Jf=chLdC-eip0JFbtjE+2pDq7G1vbRunB4OD2ZRd2=sDVQ@mail.gmail.com>
Subject: Re: [PATCH v15 14/26] nfs_common: add NFS LOCALIO auxiliary protocol enablement
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Trond Myklebust <trondmy@hammerspace.com>, 
	NeilBrown <neilb@suse.de>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 31, 2024 at 6:38=E2=80=AFPM Mike Snitzer <snitzer@kernel.org> w=
rote:
>
> fs/nfs_common/nfslocalio.c provides interfaces that enable an NFS
> client to generate a nonce (single-use UUID) and associated
> short-lived nfs_uuid_t struct, register it with nfs_common for
> subsequent lookup and verification by the NFS server and if matched
> the NFS server populates members in the nfs_uuid_t struct.
>
> nfs_common's nfs_uuids list is the basis for localio enablement, as
> such it has members that point to nfsd memory for direct use by the
> client (e.g. 'net' is the server's network namespace, through it the
> client can access nn->nfsd_serv).
>
> This commit also provides the base nfs_uuid_t interfaces to allow
> proper net namespace refcounting for the LOCALIO use case.
>
> CONFIG_NFS_LOCALIO controls the nfs_common, NFS server and NFS client
> enablement for LOCALIO. If both NFS_FS=3Dm and NFSD=3Dm then
> NFS_COMMON_LOCALIO_SUPPORT=3Dm and nfs_localio.ko is built (and provides
> nfs_common's LOCALIO support).
>
>   # lsmod | grep nfs_localio
>   nfs_localio            12288  2 nfsd,nfs
>   sunrpc                745472  35 nfs_localio,nfsd,auth_rpcgss,lockd,nfs=
v3,nfs
>
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> Co-developed-by: NeilBrown <neilb@suse.de>
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/Kconfig                 |  23 ++++++++
>  fs/nfs_common/Makefile     |   3 +
>  fs/nfs_common/nfslocalio.c | 116 +++++++++++++++++++++++++++++++++++++
>  include/linux/nfslocalio.h |  36 ++++++++++++
>  4 files changed, 178 insertions(+)
>  create mode 100644 fs/nfs_common/nfslocalio.c
>  create mode 100644 include/linux/nfslocalio.h
>
> diff --git a/fs/Kconfig b/fs/Kconfig
> index a46b0cbc4d8f..24d4e4b419d1 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -382,6 +382,29 @@ config NFS_COMMON
>         depends on NFSD || NFS_FS || LOCKD
>         default y
>
> +config NFS_COMMON_LOCALIO_SUPPORT
> +       tristate
> +       default n
> +       default y if NFSD=3Dy || NFS_FS=3Dy
> +       default m if NFSD=3Dm && NFS_FS=3Dm
> +       select SUNRPC
> +
> +config NFS_LOCALIO
> +       bool "NFS client and server support for LOCALIO auxiliary protoco=
l"
> +       depends on NFSD && NFS_FS
> +       select NFS_COMMON_LOCALIO_SUPPORT
> +       default n
> +       help
> +         Some NFS servers support an auxiliary NFS LOCALIO protocol
> +         that is not an official part of the NFS protocol.
> +
> +         This option enables support for the LOCALIO protocol in the
> +         kernel's NFS server and client. Enable this to permit local
> +         NFS clients to bypass the network when issuing reads and
> +         writes to the local NFS server.
> +
> +         If unsure, say N.
> +

I'm wondering if it would make sense to create a fs/nfs_common/Kconfig
file at some point (not as part of this patchset!) to hold this group
of nfs_common options and to tidy up this section of the fs/Kconfig
file.

Thoughts?
Anna

>  config NFS_V4_2_SSC_HELPER
>         bool
>         default y if NFS_V4_2
> diff --git a/fs/nfs_common/Makefile b/fs/nfs_common/Makefile
> index e58b01bb8dda..a5e54809701e 100644
> --- a/fs/nfs_common/Makefile
> +++ b/fs/nfs_common/Makefile
> @@ -6,6 +6,9 @@
>  obj-$(CONFIG_NFS_ACL_SUPPORT) +=3D nfs_acl.o
>  nfs_acl-objs :=3D nfsacl.o
>
> +obj-$(CONFIG_NFS_COMMON_LOCALIO_SUPPORT) +=3D nfs_localio.o
> +nfs_localio-objs :=3D nfslocalio.o
> +
>  obj-$(CONFIG_GRACE_PERIOD) +=3D grace.o
>  obj-$(CONFIG_NFS_V4_2_SSC_HELPER) +=3D nfs_ssc.o
>
> diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
> new file mode 100644
> index 000000000000..22b0ddf225ca
> --- /dev/null
> +++ b/fs/nfs_common/nfslocalio.c
> @@ -0,0 +1,116 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2024 Mike Snitzer <snitzer@hammerspace.com>
> + * Copyright (C) 2024 NeilBrown <neilb@suse.de>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/rculist.h>
> +#include <linux/nfslocalio.h>
> +#include <net/netns/generic.h>
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("NFS localio protocol bypass support");
> +
> +static DEFINE_SPINLOCK(nfs_uuid_lock);
> +
> +/*
> + * Global list of nfs_uuid_t instances
> + * that is protected by nfs_uuid_lock.
> + */
> +LIST_HEAD(nfs_uuids);
> +
> +void nfs_uuid_begin(nfs_uuid_t *nfs_uuid)
> +{
> +       nfs_uuid->net =3D NULL;
> +       nfs_uuid->dom =3D NULL;
> +       uuid_gen(&nfs_uuid->uuid);
> +
> +       spin_lock(&nfs_uuid_lock);
> +       list_add_tail_rcu(&nfs_uuid->list, &nfs_uuids);
> +       spin_unlock(&nfs_uuid_lock);
> +}
> +EXPORT_SYMBOL_GPL(nfs_uuid_begin);
> +
> +void nfs_uuid_end(nfs_uuid_t *nfs_uuid)
> +{
> +       if (nfs_uuid->net =3D=3D NULL) {
> +               spin_lock(&nfs_uuid_lock);
> +               list_del_init(&nfs_uuid->list);
> +               spin_unlock(&nfs_uuid_lock);
> +       }
> +}
> +EXPORT_SYMBOL_GPL(nfs_uuid_end);
> +
> +static nfs_uuid_t * nfs_uuid_lookup_locked(const uuid_t *uuid)
> +{
> +       nfs_uuid_t *nfs_uuid;
> +
> +       list_for_each_entry(nfs_uuid, &nfs_uuids, list)
> +               if (uuid_equal(&nfs_uuid->uuid, uuid))
> +                       return nfs_uuid;
> +
> +       return NULL;
> +}
> +
> +struct module *nfsd_mod;
> +
> +void nfs_uuid_is_local(const uuid_t *uuid, struct list_head *list,
> +                      struct net *net, struct auth_domain *dom,
> +                      struct module *mod)
> +{
> +       nfs_uuid_t *nfs_uuid;
> +
> +       spin_lock(&nfs_uuid_lock);
> +       nfs_uuid =3D nfs_uuid_lookup_locked(uuid);
> +       if (nfs_uuid) {
> +               kref_get(&dom->ref);
> +               nfs_uuid->dom =3D dom;
> +               /*
> +                * We don't hold a ref on the net, but instead put
> +                * ourselves on a list so the net pointer can be
> +                * invalidated.
> +                */
> +               list_move(&nfs_uuid->list, list);
> +               nfs_uuid->net =3D net;
> +
> +               __module_get(mod);
> +               nfsd_mod =3D mod;
> +       }
> +       spin_unlock(&nfs_uuid_lock);
> +}
> +EXPORT_SYMBOL_GPL(nfs_uuid_is_local);
> +
> +static void nfs_uuid_put_locked(nfs_uuid_t *nfs_uuid)
> +{
> +       if (nfs_uuid->net) {
> +               module_put(nfsd_mod);
> +               nfs_uuid->net =3D NULL;
> +       }
> +       if (nfs_uuid->dom) {
> +               auth_domain_put(nfs_uuid->dom);
> +               nfs_uuid->dom =3D NULL;
> +       }
> +       list_del_init(&nfs_uuid->list);
> +}
> +
> +void nfs_uuid_invalidate_clients(struct list_head *list)
> +{
> +       nfs_uuid_t *nfs_uuid, *tmp;
> +
> +       spin_lock(&nfs_uuid_lock);
> +       list_for_each_entry_safe(nfs_uuid, tmp, list, list)
> +               nfs_uuid_put_locked(nfs_uuid);
> +       spin_unlock(&nfs_uuid_lock);
> +}
> +EXPORT_SYMBOL_GPL(nfs_uuid_invalidate_clients);
> +
> +void nfs_uuid_invalidate_one_client(nfs_uuid_t *nfs_uuid)
> +{
> +       if (nfs_uuid->net) {
> +               spin_lock(&nfs_uuid_lock);
> +               nfs_uuid_put_locked(nfs_uuid);
> +               spin_unlock(&nfs_uuid_lock);
> +       }
> +}
> +EXPORT_SYMBOL_GPL(nfs_uuid_invalidate_one_client);
> diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
> new file mode 100644
> index 000000000000..4165ff8390c1
> --- /dev/null
> +++ b/include/linux/nfslocalio.h
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2024 Mike Snitzer <snitzer@hammerspace.com>
> + * Copyright (C) 2024 NeilBrown <neilb@suse.de>
> + */
> +#ifndef __LINUX_NFSLOCALIO_H
> +#define __LINUX_NFSLOCALIO_H
> +
> +#include <linux/module.h>
> +#include <linux/list.h>
> +#include <linux/uuid.h>
> +#include <linux/sunrpc/svcauth.h>
> +#include <linux/nfs.h>
> +#include <net/net_namespace.h>
> +
> +/*
> + * Useful to allow a client to negotiate if localio
> + * possible with its server.
> + *
> + * See Documentation/filesystems/nfs/localio.rst for more detail.
> + */
> +typedef struct {
> +       uuid_t uuid;
> +       struct list_head list;
> +       struct net *net; /* nfsd's network namespace */
> +       struct auth_domain *dom; /* auth_domain for localio */
> +} nfs_uuid_t;
> +
> +void nfs_uuid_begin(nfs_uuid_t *);
> +void nfs_uuid_end(nfs_uuid_t *);
> +void nfs_uuid_is_local(const uuid_t *, struct list_head *,
> +                      struct net *, struct auth_domain *, struct module =
*);
> +void nfs_uuid_invalidate_clients(struct list_head *list);
> +void nfs_uuid_invalidate_one_client(nfs_uuid_t *nfs_uuid);
> +
> +#endif  /* __LINUX_NFSLOCALIO_H */
> --
> 2.44.0
>

