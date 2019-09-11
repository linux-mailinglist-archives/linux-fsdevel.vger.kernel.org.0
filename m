Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7DFB038D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2019 20:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729916AbfIKSYh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Sep 2019 14:24:37 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33151 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728117AbfIKSYg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Sep 2019 14:24:36 -0400
Received: by mail-io1-f68.google.com with SMTP id m11so48150028ioo.0;
        Wed, 11 Sep 2019 11:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ZlvQVc6zypxcrF1afNo7XcTMxjhTW94t+hF0bXvdHmw=;
        b=SQQpu/kP4uurQlNaKj3i6iORYZVoIJaZfGsEyqmWo29aCwcJ3m33C5uoFTjLCsAROT
         PnG9OEW9OfFYUqJLYmSLP0AaVJMjm1QvXQ//y5FWx1GFL9wWhF5Y+bJr7BCOFM5r72EB
         QYGAfwiRSEVS3EfAXTagT8P07abpkexakH/Pph7UTkgMoQ7VrKupChxLg57JrIL6m6Ne
         ayUgJbuT46sJ/3exbiEEqLPNhexcSWH4qL22uXruDBq9Ff0blOtxbKHyVYYoHds4P7pZ
         5b3sv1DPPFtCu8h//JHGkWVYmF7BQoagOTnroPIFqDe5aCThePoRuqY9dn6zsM6IaQvw
         ps8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ZlvQVc6zypxcrF1afNo7XcTMxjhTW94t+hF0bXvdHmw=;
        b=Kq6O5lEvfxkssAXfFdKC9SQboYS4E60xiE0r6b/q2alzIUVBBLJ+23PrfzGkvZEMSr
         ps6dtJZhESKOA9OWYWVQ/8nJC+mPuhUlKPk6C1Fun8iq34MvPaNo397LEhKPIqRv+lGJ
         ZSe2v3hVoqy85hRFKFQMAJknJ13Imz+Lh8AlYQ0JvMMXkibjDY/yrGUehKnxRrnXawHP
         Z4o6T0g1QyxyzFxqbR8eEhRJpA+XbcadfwEnSUPUe7WNPL3YpLigjKetHeOfr039wGbM
         EYWZkqDSZcHqfCPz7YKF5kIkHRcD1nncxEykAR7X1tqZHofjckdFXuO26tO+VXmcKQiQ
         7W6g==
X-Gm-Message-State: APjAAAVKvMVf3AevzLZTQdrnW+4Xk0TwDDKs6IZ/6xJx6RJzlDTJ8+16
        xG4goAHgWhYoOP+7NsYJ14UKHI8T
X-Google-Smtp-Source: APXvYqzj8h48ybkIp+QQag84de1JcWsVvHj8msXI7YuNwEcqTS288MiFLohNY7g/gvuw0lM6jOa0OA==
X-Received: by 2002:a5e:8d04:: with SMTP id m4mr13834591ioj.264.1568226273019;
        Wed, 11 Sep 2019 11:24:33 -0700 (PDT)
Received: from anon-dhcp-153.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id c4sm17209464ioa.76.2019.09.11.11.24.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2019 11:24:31 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v3 16/26] NFS: Move mount parameterisation bits into their
 own file
From:   Chuck Lever <chucklever@gmail.com>
In-Reply-To: <20190911161621.19832-17-smayhew@redhat.com>
Date:   Wed, 11 Sep 2019 14:24:30 -0400
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        trond.myklebust@hammerspace.com,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C39E36EC-EF71-446B-AD54-B33BD0CB4775@gmail.com>
References: <20190911161621.19832-1-smayhew@redhat.com>
 <20190911161621.19832-17-smayhew@redhat.com>
To:     Scott Mayhew <smayhew@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Sep 11, 2019, at 12:16 PM, Scott Mayhew <smayhew@redhat.com> wrote:
>=20
> From: David Howells <dhowells@redhat.com>
>=20
> Split various bits relating to mount parameterisation out from
> fs/nfs/super.c into their own file to form the basis of filesystem =
context
> handling for NFS.
>=20
> No other changes are made to the code beyond removing 'static' =
qualifiers.
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
> fs/nfs/Makefile     |    2 +-
> fs/nfs/fs_context.c | 1418 +++++++++++++++++++++++++++++++++++++++++++
> fs/nfs/internal.h   |   29 +
> fs/nfs/super.c      | 1411 ------------------------------------------
> 4 files changed, 1448 insertions(+), 1412 deletions(-)
> create mode 100644 fs/nfs/fs_context.c
>=20
> diff --git a/fs/nfs/Makefile b/fs/nfs/Makefile
> index 34cdeaecccf6..2433c3e03cfa 100644
> --- a/fs/nfs/Makefile
> +++ b/fs/nfs/Makefile
> @@ -9,7 +9,7 @@ CFLAGS_nfstrace.o +=3D -I$(src)
> nfs-y 			:=3D client.o dir.o file.o getroot.o =
inode.o super.o \
> 			   io.o direct.o pagelist.o read.o symlink.o =
unlink.o \
> 			   write.o namespace.o mount_clnt.o nfstrace.o \
> -			   export.o sysfs.o
> +			   export.o sysfs.o fs_context.o
> nfs-$(CONFIG_ROOT_NFS)	+=3D nfsroot.o
> nfs-$(CONFIG_SYSCTL)	+=3D sysctl.o
> nfs-$(CONFIG_NFS_FSCACHE) +=3D fscache.o fscache-index.o
> diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
> new file mode 100644
> index 000000000000..82b312a5cdde
> --- /dev/null
> +++ b/fs/nfs/fs_context.c
> @@ -0,0 +1,1418 @@
> +/* NFS mount handling.
> + *
> + * Copyright (C) 2018 Red Hat, Inc. All Rights Reserved.
> + * Written by David Howells (dhowells@redhat.com)
> + *
> + * Split from fs/nfs/super.c:
> + *
> + *  Copyright (C) 1992  Rick Sladkey
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public Licence
> + * as published by the Free Software Foundation; either version
> + * 2 of the Licence, or (at your option) any later version.
> + */

New source files should have an SPDX tag instead of boilerplate.
I suggest:

// SPDX-License-Identifier: GPL-2.0-only


> +
> +#include <linux/module.h>
> +#include <linux/fs.h>
> +#include <linux/parser.h>
> +#include <linux/nfs_fs.h>
> +#include <linux/nfs_mount.h>
> +#include <linux/nfs4_mount.h>
> +#include "nfs.h"
> +#include "internal.h"
> +
> +#define NFSDBG_FACILITY		NFSDBG_MOUNT
> +
> +#if IS_ENABLED(CONFIG_NFS_V3)
> +#define NFS_DEFAULT_VERSION 3
> +#else
> +#define NFS_DEFAULT_VERSION 2
> +#endif
> +
> +#define NFS_MAX_CONNECTIONS 16
> +
> +enum {
> +	/* Mount options that take no arguments */
> +	Opt_soft, Opt_softerr, Opt_hard,
> +	Opt_posix, Opt_noposix,
> +	Opt_cto, Opt_nocto,
> +	Opt_ac, Opt_noac,
> +	Opt_lock, Opt_nolock,
> +	Opt_udp, Opt_tcp, Opt_rdma,
> +	Opt_acl, Opt_noacl,
> +	Opt_rdirplus, Opt_nordirplus,
> +	Opt_sharecache, Opt_nosharecache,
> +	Opt_resvport, Opt_noresvport,
> +	Opt_fscache, Opt_nofscache,
> +	Opt_migration, Opt_nomigration,
> +
> +	/* Mount options that take integer arguments */
> +	Opt_port,
> +	Opt_rsize, Opt_wsize, Opt_bsize,
> +	Opt_timeo, Opt_retrans,
> +	Opt_acregmin, Opt_acregmax,
> +	Opt_acdirmin, Opt_acdirmax,
> +	Opt_actimeo,
> +	Opt_namelen,
> +	Opt_mountport,
> +	Opt_mountvers,
> +	Opt_minorversion,
> +
> +	/* Mount options that take string arguments */
> +	Opt_nfsvers,
> +	Opt_sec, Opt_proto, Opt_mountproto, Opt_mounthost,
> +	Opt_addr, Opt_mountaddr, Opt_clientaddr,
> +	Opt_nconnect,
> +	Opt_lookupcache,
> +	Opt_fscache_uniq,
> +	Opt_local_lock,
> +
> +	/* Special mount options */
> +	Opt_userspace, Opt_deprecated, Opt_sloppy,
> +
> +	Opt_err
> +};
> +
> +static const match_table_t nfs_mount_option_tokens =3D {
> +	{ Opt_userspace, "bg" },
> +	{ Opt_userspace, "fg" },
> +	{ Opt_userspace, "retry=3D%s" },
> +
> +	{ Opt_sloppy, "sloppy" },
> +
> +	{ Opt_soft, "soft" },
> +	{ Opt_softerr, "softerr" },
> +	{ Opt_hard, "hard" },
> +	{ Opt_deprecated, "intr" },
> +	{ Opt_deprecated, "nointr" },
> +	{ Opt_posix, "posix" },
> +	{ Opt_noposix, "noposix" },
> +	{ Opt_cto, "cto" },
> +	{ Opt_nocto, "nocto" },
> +	{ Opt_ac, "ac" },
> +	{ Opt_noac, "noac" },
> +	{ Opt_lock, "lock" },
> +	{ Opt_nolock, "nolock" },
> +	{ Opt_udp, "udp" },
> +	{ Opt_tcp, "tcp" },
> +	{ Opt_rdma, "rdma" },
> +	{ Opt_acl, "acl" },
> +	{ Opt_noacl, "noacl" },
> +	{ Opt_rdirplus, "rdirplus" },
> +	{ Opt_nordirplus, "nordirplus" },
> +	{ Opt_sharecache, "sharecache" },
> +	{ Opt_nosharecache, "nosharecache" },
> +	{ Opt_resvport, "resvport" },
> +	{ Opt_noresvport, "noresvport" },
> +	{ Opt_fscache, "fsc" },
> +	{ Opt_nofscache, "nofsc" },
> +	{ Opt_migration, "migration" },
> +	{ Opt_nomigration, "nomigration" },
> +
> +	{ Opt_port, "port=3D%s" },
> +	{ Opt_rsize, "rsize=3D%s" },
> +	{ Opt_wsize, "wsize=3D%s" },
> +	{ Opt_bsize, "bsize=3D%s" },
> +	{ Opt_timeo, "timeo=3D%s" },
> +	{ Opt_retrans, "retrans=3D%s" },
> +	{ Opt_acregmin, "acregmin=3D%s" },
> +	{ Opt_acregmax, "acregmax=3D%s" },
> +	{ Opt_acdirmin, "acdirmin=3D%s" },
> +	{ Opt_acdirmax, "acdirmax=3D%s" },
> +	{ Opt_actimeo, "actimeo=3D%s" },
> +	{ Opt_namelen, "namlen=3D%s" },
> +	{ Opt_mountport, "mountport=3D%s" },
> +	{ Opt_mountvers, "mountvers=3D%s" },
> +	{ Opt_minorversion, "minorversion=3D%s" },
> +
> +	{ Opt_nfsvers, "nfsvers=3D%s" },
> +	{ Opt_nfsvers, "vers=3D%s" },
> +
> +	{ Opt_sec, "sec=3D%s" },
> +	{ Opt_proto, "proto=3D%s" },
> +	{ Opt_mountproto, "mountproto=3D%s" },
> +	{ Opt_addr, "addr=3D%s" },
> +	{ Opt_clientaddr, "clientaddr=3D%s" },
> +	{ Opt_mounthost, "mounthost=3D%s" },
> +	{ Opt_mountaddr, "mountaddr=3D%s" },
> +
> +	{ Opt_nconnect, "nconnect=3D%s" },
> +
> +	{ Opt_lookupcache, "lookupcache=3D%s" },
> +	{ Opt_fscache_uniq, "fsc=3D%s" },
> +	{ Opt_local_lock, "local_lock=3D%s" },
> +
> +	/* The following needs to be listed after all other options */
> +	{ Opt_nfsvers, "v%s" },
> +
> +	{ Opt_err, NULL }
> +};
> +
> +enum {
> +	Opt_xprt_udp, Opt_xprt_udp6, Opt_xprt_tcp, Opt_xprt_tcp6, =
Opt_xprt_rdma,
> +	Opt_xprt_rdma6,
> +
> +	Opt_xprt_err
> +};
> +
> +static const match_table_t nfs_xprt_protocol_tokens =3D {
> +	{ Opt_xprt_udp, "udp" },
> +	{ Opt_xprt_udp6, "udp6" },
> +	{ Opt_xprt_tcp, "tcp" },
> +	{ Opt_xprt_tcp6, "tcp6" },
> +	{ Opt_xprt_rdma, "rdma" },
> +	{ Opt_xprt_rdma6, "rdma6" },
> +
> +	{ Opt_xprt_err, NULL }
> +};
> +
> +enum {
> +	Opt_sec_none, Opt_sec_sys,
> +	Opt_sec_krb5, Opt_sec_krb5i, Opt_sec_krb5p,
> +	Opt_sec_lkey, Opt_sec_lkeyi, Opt_sec_lkeyp,
> +	Opt_sec_spkm, Opt_sec_spkmi, Opt_sec_spkmp,
> +
> +	Opt_sec_err
> +};
> +
> +static const match_table_t nfs_secflavor_tokens =3D {
> +	{ Opt_sec_none, "none" },
> +	{ Opt_sec_none, "null" },
> +	{ Opt_sec_sys, "sys" },
> +
> +	{ Opt_sec_krb5, "krb5" },
> +	{ Opt_sec_krb5i, "krb5i" },
> +	{ Opt_sec_krb5p, "krb5p" },
> +
> +	{ Opt_sec_lkey, "lkey" },
> +	{ Opt_sec_lkeyi, "lkeyi" },
> +	{ Opt_sec_lkeyp, "lkeyp" },
> +
> +	{ Opt_sec_spkm, "spkm3" },
> +	{ Opt_sec_spkmi, "spkm3i" },
> +	{ Opt_sec_spkmp, "spkm3p" },
> +
> +	{ Opt_sec_err, NULL }
> +};
> +
> +enum {
> +	Opt_lookupcache_all, Opt_lookupcache_positive,
> +	Opt_lookupcache_none,
> +
> +	Opt_lookupcache_err
> +};
> +
> +static match_table_t nfs_lookupcache_tokens =3D {
> +	{ Opt_lookupcache_all, "all" },
> +	{ Opt_lookupcache_positive, "pos" },
> +	{ Opt_lookupcache_positive, "positive" },
> +	{ Opt_lookupcache_none, "none" },
> +
> +	{ Opt_lookupcache_err, NULL }
> +};
> +
> +enum {
> +	Opt_local_lock_all, Opt_local_lock_flock, Opt_local_lock_posix,
> +	Opt_local_lock_none,
> +
> +	Opt_local_lock_err
> +};
> +
> +static match_table_t nfs_local_lock_tokens =3D {
> +	{ Opt_local_lock_all, "all" },
> +	{ Opt_local_lock_flock, "flock" },
> +	{ Opt_local_lock_posix, "posix" },
> +	{ Opt_local_lock_none, "none" },
> +
> +	{ Opt_local_lock_err, NULL }
> +};
> +
> +enum {
> +	Opt_vers_2, Opt_vers_3, Opt_vers_4, Opt_vers_4_0,
> +	Opt_vers_4_1, Opt_vers_4_2,
> +
> +	Opt_vers_err
> +};
> +
> +static match_table_t nfs_vers_tokens =3D {
> +	{ Opt_vers_2, "2" },
> +	{ Opt_vers_3, "3" },
> +	{ Opt_vers_4, "4" },
> +	{ Opt_vers_4_0, "4.0" },
> +	{ Opt_vers_4_1, "4.1" },
> +	{ Opt_vers_4_2, "4.2" },
> +
> +	{ Opt_vers_err, NULL }
> +};
> +
> +struct nfs_parsed_mount_data *nfs_alloc_parsed_mount_data(void)
> +{
> +	struct nfs_parsed_mount_data *data;
> +
> +	data =3D kzalloc(sizeof(*data), GFP_KERNEL);
> +	if (data) {
> +		data->timeo		=3D NFS_UNSPEC_TIMEO;
> +		data->retrans		=3D NFS_UNSPEC_RETRANS;
> +		data->acregmin		=3D NFS_DEF_ACREGMIN;
> +		data->acregmax		=3D NFS_DEF_ACREGMAX;
> +		data->acdirmin		=3D NFS_DEF_ACDIRMIN;
> +		data->acdirmax		=3D NFS_DEF_ACDIRMAX;
> +		data->mount_server.port	=3D NFS_UNSPEC_PORT;
> +		data->nfs_server.port	=3D NFS_UNSPEC_PORT;
> +		data->nfs_server.protocol =3D XPRT_TRANSPORT_TCP;
> +		data->selected_flavor	=3D RPC_AUTH_MAXFLAVOR;
> +		data->minorversion	=3D 0;
> +		data->need_mount	=3D true;
> +		data->net		=3D current->nsproxy->net_ns;
> +		data->lsm_opts		=3D NULL;
> +	}
> +	return data;
> +}
> +
> +void nfs_free_parsed_mount_data(struct nfs_parsed_mount_data *data)
> +{
> +	if (data) {
> +		kfree(data->client_address);
> +		kfree(data->mount_server.hostname);
> +		kfree(data->nfs_server.export_path);
> +		kfree(data->nfs_server.hostname);
> +		kfree(data->fscache_uniq);
> +		security_free_mnt_opts(&data->lsm_opts);
> +		kfree(data);
> +	}
> +}
> +
> +/*
> + * Sanity-check a server address provided by the mount command.
> + *
> + * Address family must be initialized, and address must not be
> + * the ANY address for that family.
> + */
> +static int nfs_verify_server_address(struct sockaddr *addr)
> +{
> +	switch (addr->sa_family) {
> +	case AF_INET: {
> +		struct sockaddr_in *sa =3D (struct sockaddr_in *)addr;
> +		return sa->sin_addr.s_addr !=3D htonl(INADDR_ANY);
> +	}
> +	case AF_INET6: {
> +		struct in6_addr *sa =3D &((struct sockaddr_in6 =
*)addr)->sin6_addr;
> +		return !ipv6_addr_any(sa);
> +	}
> +	}
> +
> +	dfprintk(MOUNT, "NFS: Invalid IP address specified\n");
> +	return 0;
> +}
> +
> +/*
> + * Sanity check the NFS transport protocol.
> + *
> + */
> +static void nfs_validate_transport_protocol(struct =
nfs_parsed_mount_data *mnt)
> +{
> +	switch (mnt->nfs_server.protocol) {
> +	case XPRT_TRANSPORT_UDP:
> +	case XPRT_TRANSPORT_TCP:
> +	case XPRT_TRANSPORT_RDMA:
> +		break;
> +	default:
> +		mnt->nfs_server.protocol =3D XPRT_TRANSPORT_TCP;
> +	}
> +}
> +
> +/*
> + * For text based NFSv2/v3 mounts, the mount protocol transport =
default
> + * settings should depend upon the specified NFS transport.
> + */
> +static void nfs_set_mount_transport_protocol(struct =
nfs_parsed_mount_data *mnt)
> +{
> +	nfs_validate_transport_protocol(mnt);
> +
> +	if (mnt->mount_server.protocol =3D=3D XPRT_TRANSPORT_UDP ||
> +	    mnt->mount_server.protocol =3D=3D XPRT_TRANSPORT_TCP)
> +			return;
> +	switch (mnt->nfs_server.protocol) {
> +	case XPRT_TRANSPORT_UDP:
> +		mnt->mount_server.protocol =3D XPRT_TRANSPORT_UDP;
> +		break;
> +	case XPRT_TRANSPORT_TCP:
> +	case XPRT_TRANSPORT_RDMA:
> +		mnt->mount_server.protocol =3D XPRT_TRANSPORT_TCP;
> +	}
> +}
> +
> +/*
> + * Add 'flavor' to 'auth_info' if not already present.
> + * Returns true if 'flavor' ends up in the list, false otherwise
> + */
> +static bool nfs_auth_info_add(struct nfs_auth_info *auth_info,
> +			      rpc_authflavor_t flavor)
> +{
> +	unsigned int i;
> +	unsigned int max_flavor_len =3D ARRAY_SIZE(auth_info->flavors);
> +
> +	/* make sure this flavor isn't already in the list */
> +	for (i =3D 0; i < auth_info->flavor_len; i++) {
> +		if (flavor =3D=3D auth_info->flavors[i])
> +			return true;
> +	}
> +
> +	if (auth_info->flavor_len + 1 >=3D max_flavor_len) {
> +		dfprintk(MOUNT, "NFS: too many sec=3D flavors\n");
> +		return false;
> +	}
> +
> +	auth_info->flavors[auth_info->flavor_len++] =3D flavor;
> +	return true;
> +}
> +
> +/*
> + * Parse the value of the 'sec=3D' option.
> + */
> +static int nfs_parse_security_flavors(char *value,
> +				      struct nfs_parsed_mount_data *mnt)
> +{
> +	substring_t args[MAX_OPT_ARGS];
> +	rpc_authflavor_t pseudoflavor;
> +	char *p;
> +
> +	dfprintk(MOUNT, "NFS: parsing sec=3D%s option\n", value);
> +
> +	while ((p =3D strsep(&value, ":")) !=3D NULL) {
> +		switch (match_token(p, nfs_secflavor_tokens, args)) {
> +		case Opt_sec_none:
> +			pseudoflavor =3D RPC_AUTH_NULL;
> +			break;
> +		case Opt_sec_sys:
> +			pseudoflavor =3D RPC_AUTH_UNIX;
> +			break;
> +		case Opt_sec_krb5:
> +			pseudoflavor =3D RPC_AUTH_GSS_KRB5;
> +			break;
> +		case Opt_sec_krb5i:
> +			pseudoflavor =3D RPC_AUTH_GSS_KRB5I;
> +			break;
> +		case Opt_sec_krb5p:
> +			pseudoflavor =3D RPC_AUTH_GSS_KRB5P;
> +			break;
> +		case Opt_sec_lkey:
> +			pseudoflavor =3D RPC_AUTH_GSS_LKEY;
> +			break;
> +		case Opt_sec_lkeyi:
> +			pseudoflavor =3D RPC_AUTH_GSS_LKEYI;
> +			break;
> +		case Opt_sec_lkeyp:
> +			pseudoflavor =3D RPC_AUTH_GSS_LKEYP;
> +			break;
> +		case Opt_sec_spkm:
> +			pseudoflavor =3D RPC_AUTH_GSS_SPKM;
> +			break;
> +		case Opt_sec_spkmi:
> +			pseudoflavor =3D RPC_AUTH_GSS_SPKMI;
> +			break;
> +		case Opt_sec_spkmp:
> +			pseudoflavor =3D RPC_AUTH_GSS_SPKMP;
> +			break;
> +		default:
> +			dfprintk(MOUNT,
> +				 "NFS: sec=3D option '%s' not =
recognized\n", p);
> +			return 0;
> +		}
> +
> +		if (!nfs_auth_info_add(&mnt->auth_info, pseudoflavor))
> +			return 0;
> +	}
> +
> +	return 1;
> +}
> +
> +static int nfs_parse_version_string(char *string,
> +		struct nfs_parsed_mount_data *mnt,
> +		substring_t *args)
> +{
> +	mnt->flags &=3D ~NFS_MOUNT_VER3;
> +	switch (match_token(string, nfs_vers_tokens, args)) {
> +	case Opt_vers_2:
> +		mnt->version =3D 2;
> +		break;
> +	case Opt_vers_3:
> +		mnt->flags |=3D NFS_MOUNT_VER3;
> +		mnt->version =3D 3;
> +		break;
> +	case Opt_vers_4:
> +		/* Backward compatibility option. In future,
> +		 * the mount program should always supply
> +		 * a NFSv4 minor version number.
> +		 */
> +		mnt->version =3D 4;
> +		break;
> +	case Opt_vers_4_0:
> +		mnt->version =3D 4;
> +		mnt->minorversion =3D 0;
> +		break;
> +	case Opt_vers_4_1:
> +		mnt->version =3D 4;
> +		mnt->minorversion =3D 1;
> +		break;
> +	case Opt_vers_4_2:
> +		mnt->version =3D 4;
> +		mnt->minorversion =3D 2;
> +		break;
> +	default:
> +		return 0;
> +	}
> +	return 1;
> +}
> +
> +static int nfs_get_option_str(substring_t args[], char **option)
> +{
> +	kfree(*option);
> +	*option =3D match_strdup(args);
> +	return !*option;
> +}
> +
> +static int nfs_get_option_ul(substring_t args[], unsigned long =
*option)
> +{
> +	int rc;
> +	char *string;
> +
> +	string =3D match_strdup(args);
> +	if (string =3D=3D NULL)
> +		return -ENOMEM;
> +	rc =3D kstrtoul(string, 10, option);
> +	kfree(string);
> +
> +	return rc;
> +}
> +
> +static int nfs_get_option_ul_bound(substring_t args[], unsigned long =
*option,
> +		unsigned long l_bound, unsigned long u_bound)
> +{
> +	int ret;
> +
> +	ret =3D nfs_get_option_ul(args, option);
> +	if (ret !=3D 0)
> +		return ret;
> +	if (*option < l_bound || *option > u_bound)
> +		return -ERANGE;
> +	return 0;
> +}
> +
> +/*
> + * Error-check and convert a string of mount options from user space =
into
> + * a data structure.  The whole mount string is processed; bad =
options are
> + * skipped as they are encountered.  If there were no errors, return =
1;
> + * otherwise return 0 (zero).
> + */
> +int nfs_parse_mount_options(char *raw, struct nfs_parsed_mount_data =
*mnt)
> +{
> +	char *p, *string;
> +	int rc, sloppy =3D 0, invalid_option =3D 0;
> +	unsigned short protofamily =3D AF_UNSPEC;
> +	unsigned short mountfamily =3D AF_UNSPEC;
> +
> +	if (!raw) {
> +		dfprintk(MOUNT, "NFS: mount options string was =
NULL.\n");
> +		return 1;
> +	}
> +	dfprintk(MOUNT, "NFS: nfs mount opts=3D'%s'\n", raw);
> +
> +	rc =3D security_sb_eat_lsm_opts(raw, &mnt->lsm_opts);
> +	if (rc)
> +		goto out_security_failure;
> +
> +	while ((p =3D strsep(&raw, ",")) !=3D NULL) {
> +		substring_t args[MAX_OPT_ARGS];
> +		unsigned long option;
> +		int token;
> +
> +		if (!*p)
> +			continue;
> +
> +		dfprintk(MOUNT, "NFS:   parsing nfs mount option =
'%s'\n", p);
> +
> +		token =3D match_token(p, nfs_mount_option_tokens, args);
> +		switch (token) {
> +
> +		/*
> +		 * boolean options:  foo/nofoo
> +		 */
> +		case Opt_soft:
> +			mnt->flags |=3D NFS_MOUNT_SOFT;
> +			mnt->flags &=3D ~NFS_MOUNT_SOFTERR;
> +			break;
> +		case Opt_softerr:
> +			mnt->flags |=3D NFS_MOUNT_SOFTERR;
> +			mnt->flags &=3D ~NFS_MOUNT_SOFT;
> +			break;
> +		case Opt_hard:
> +			mnt->flags &=3D =
~(NFS_MOUNT_SOFT|NFS_MOUNT_SOFTERR);
> +			break;
> +		case Opt_posix:
> +			mnt->flags |=3D NFS_MOUNT_POSIX;
> +			break;
> +		case Opt_noposix:
> +			mnt->flags &=3D ~NFS_MOUNT_POSIX;
> +			break;
> +		case Opt_cto:
> +			mnt->flags &=3D ~NFS_MOUNT_NOCTO;
> +			break;
> +		case Opt_nocto:
> +			mnt->flags |=3D NFS_MOUNT_NOCTO;
> +			break;
> +		case Opt_ac:
> +			mnt->flags &=3D ~NFS_MOUNT_NOAC;
> +			break;
> +		case Opt_noac:
> +			mnt->flags |=3D NFS_MOUNT_NOAC;
> +			break;
> +		case Opt_lock:
> +			mnt->flags &=3D ~NFS_MOUNT_NONLM;
> +			mnt->flags &=3D ~(NFS_MOUNT_LOCAL_FLOCK |
> +					NFS_MOUNT_LOCAL_FCNTL);
> +			break;
> +		case Opt_nolock:
> +			mnt->flags |=3D NFS_MOUNT_NONLM;
> +			mnt->flags |=3D (NFS_MOUNT_LOCAL_FLOCK |
> +				       NFS_MOUNT_LOCAL_FCNTL);
> +			break;
> +		case Opt_udp:
> +			mnt->flags &=3D ~NFS_MOUNT_TCP;
> +			mnt->nfs_server.protocol =3D XPRT_TRANSPORT_UDP;
> +			break;
> +		case Opt_tcp:
> +			mnt->flags |=3D NFS_MOUNT_TCP;
> +			mnt->nfs_server.protocol =3D XPRT_TRANSPORT_TCP;
> +			break;
> +		case Opt_rdma:
> +			mnt->flags |=3D NFS_MOUNT_TCP; /* for side =
protocols */
> +			mnt->nfs_server.protocol =3D =
XPRT_TRANSPORT_RDMA;
> +			xprt_load_transport(p);
> +			break;
> +		case Opt_acl:
> +			mnt->flags &=3D ~NFS_MOUNT_NOACL;
> +			break;
> +		case Opt_noacl:
> +			mnt->flags |=3D NFS_MOUNT_NOACL;
> +			break;
> +		case Opt_rdirplus:
> +			mnt->flags &=3D ~NFS_MOUNT_NORDIRPLUS;
> +			break;
> +		case Opt_nordirplus:
> +			mnt->flags |=3D NFS_MOUNT_NORDIRPLUS;
> +			break;
> +		case Opt_sharecache:
> +			mnt->flags &=3D ~NFS_MOUNT_UNSHARED;
> +			break;
> +		case Opt_nosharecache:
> +			mnt->flags |=3D NFS_MOUNT_UNSHARED;
> +			break;
> +		case Opt_resvport:
> +			mnt->flags &=3D ~NFS_MOUNT_NORESVPORT;
> +			break;
> +		case Opt_noresvport:
> +			mnt->flags |=3D NFS_MOUNT_NORESVPORT;
> +			break;
> +		case Opt_fscache:
> +			mnt->options |=3D NFS_OPTION_FSCACHE;
> +			kfree(mnt->fscache_uniq);
> +			mnt->fscache_uniq =3D NULL;
> +			break;
> +		case Opt_nofscache:
> +			mnt->options &=3D ~NFS_OPTION_FSCACHE;
> +			kfree(mnt->fscache_uniq);
> +			mnt->fscache_uniq =3D NULL;
> +			break;
> +		case Opt_migration:
> +			mnt->options |=3D NFS_OPTION_MIGRATION;
> +			break;
> +		case Opt_nomigration:
> +			mnt->options &=3D ~NFS_OPTION_MIGRATION;
> +			break;
> +
> +		/*
> +		 * options that take numeric values
> +		 */
> +		case Opt_port:
> +			if (nfs_get_option_ul(args, &option) ||
> +			    option > USHRT_MAX)
> +				goto out_invalid_value;
> +			mnt->nfs_server.port =3D option;
> +			break;
> +		case Opt_rsize:
> +			if (nfs_get_option_ul(args, &option))
> +				goto out_invalid_value;
> +			mnt->rsize =3D option;
> +			break;
> +		case Opt_wsize:
> +			if (nfs_get_option_ul(args, &option))
> +				goto out_invalid_value;
> +			mnt->wsize =3D option;
> +			break;
> +		case Opt_bsize:
> +			if (nfs_get_option_ul(args, &option))
> +				goto out_invalid_value;
> +			mnt->bsize =3D option;
> +			break;
> +		case Opt_timeo:
> +			if (nfs_get_option_ul_bound(args, &option, 1, =
INT_MAX))
> +				goto out_invalid_value;
> +			mnt->timeo =3D option;
> +			break;
> +		case Opt_retrans:
> +			if (nfs_get_option_ul_bound(args, &option, 0, =
INT_MAX))
> +				goto out_invalid_value;
> +			mnt->retrans =3D option;
> +			break;
> +		case Opt_acregmin:
> +			if (nfs_get_option_ul(args, &option))
> +				goto out_invalid_value;
> +			mnt->acregmin =3D option;
> +			break;
> +		case Opt_acregmax:
> +			if (nfs_get_option_ul(args, &option))
> +				goto out_invalid_value;
> +			mnt->acregmax =3D option;
> +			break;
> +		case Opt_acdirmin:
> +			if (nfs_get_option_ul(args, &option))
> +				goto out_invalid_value;
> +			mnt->acdirmin =3D option;
> +			break;
> +		case Opt_acdirmax:
> +			if (nfs_get_option_ul(args, &option))
> +				goto out_invalid_value;
> +			mnt->acdirmax =3D option;
> +			break;
> +		case Opt_actimeo:
> +			if (nfs_get_option_ul(args, &option))
> +				goto out_invalid_value;
> +			mnt->acregmin =3D mnt->acregmax =3D
> +			mnt->acdirmin =3D mnt->acdirmax =3D option;
> +			break;
> +		case Opt_namelen:
> +			if (nfs_get_option_ul(args, &option))
> +				goto out_invalid_value;
> +			mnt->namlen =3D option;
> +			break;
> +		case Opt_mountport:
> +			if (nfs_get_option_ul(args, &option) ||
> +			    option > USHRT_MAX)
> +				goto out_invalid_value;
> +			mnt->mount_server.port =3D option;
> +			break;
> +		case Opt_mountvers:
> +			if (nfs_get_option_ul(args, &option) ||
> +			    option < NFS_MNT_VERSION ||
> +			    option > NFS_MNT3_VERSION)
> +				goto out_invalid_value;
> +			mnt->mount_server.version =3D option;
> +			break;
> +		case Opt_minorversion:
> +			if (nfs_get_option_ul(args, &option))
> +				goto out_invalid_value;
> +			if (option > NFS4_MAX_MINOR_VERSION)
> +				goto out_invalid_value;
> +			mnt->minorversion =3D option;
> +			break;
> +
> +		/*
> +		 * options that take text values
> +		 */
> +		case Opt_nfsvers:
> +			string =3D match_strdup(args);
> +			if (string =3D=3D NULL)
> +				goto out_nomem;
> +			rc =3D nfs_parse_version_string(string, mnt, =
args);
> +			kfree(string);
> +			if (!rc)
> +				goto out_invalid_value;
> +			break;
> +		case Opt_sec:
> +			string =3D match_strdup(args);
> +			if (string =3D=3D NULL)
> +				goto out_nomem;
> +			rc =3D nfs_parse_security_flavors(string, mnt);
> +			kfree(string);
> +			if (!rc) {
> +				dfprintk(MOUNT, "NFS:   unrecognized "
> +						"security flavor\n");
> +				return 0;
> +			}
> +			break;
> +		case Opt_proto:
> +			string =3D match_strdup(args);
> +			if (string =3D=3D NULL)
> +				goto out_nomem;
> +			token =3D match_token(string,
> +					    nfs_xprt_protocol_tokens, =
args);
> +
> +			protofamily =3D AF_INET;
> +			switch (token) {
> +			case Opt_xprt_udp6:
> +				protofamily =3D AF_INET6;
> +				/* fall through */
> +			case Opt_xprt_udp:
> +				mnt->flags &=3D ~NFS_MOUNT_TCP;
> +				mnt->nfs_server.protocol =3D =
XPRT_TRANSPORT_UDP;
> +				break;
> +			case Opt_xprt_tcp6:
> +				protofamily =3D AF_INET6;
> +				/* fall through */
> +			case Opt_xprt_tcp:
> +				mnt->flags |=3D NFS_MOUNT_TCP;
> +				mnt->nfs_server.protocol =3D =
XPRT_TRANSPORT_TCP;
> +				break;
> +			case Opt_xprt_rdma6:
> +				protofamily =3D AF_INET6;
> +				/* fall through */
> +			case Opt_xprt_rdma:
> +				/* vector side protocols to TCP */
> +				mnt->flags |=3D NFS_MOUNT_TCP;
> +				mnt->nfs_server.protocol =3D =
XPRT_TRANSPORT_RDMA;
> +				xprt_load_transport(string);
> +				break;
> +			default:
> +				dfprintk(MOUNT, "NFS:   unrecognized "
> +						"transport protocol\n");
> +				kfree(string);
> +				return 0;
> +			}
> +			kfree(string);
> +			break;
> +		case Opt_mountproto:
> +			string =3D match_strdup(args);
> +			if (string =3D=3D NULL)
> +				goto out_nomem;
> +			token =3D match_token(string,
> +					    nfs_xprt_protocol_tokens, =
args);
> +			kfree(string);
> +
> +			mountfamily =3D AF_INET;
> +			switch (token) {
> +			case Opt_xprt_udp6:
> +				mountfamily =3D AF_INET6;
> +				/* fall through */
> +			case Opt_xprt_udp:
> +				mnt->mount_server.protocol =3D =
XPRT_TRANSPORT_UDP;
> +				break;
> +			case Opt_xprt_tcp6:
> +				mountfamily =3D AF_INET6;
> +				/* fall through */
> +			case Opt_xprt_tcp:
> +				mnt->mount_server.protocol =3D =
XPRT_TRANSPORT_TCP;
> +				break;
> +			case Opt_xprt_rdma: /* not used for side =
protocols */
> +			default:
> +				dfprintk(MOUNT, "NFS:   unrecognized "
> +						"transport protocol\n");
> +				return 0;
> +			}
> +			break;
> +		case Opt_addr:
> +			string =3D match_strdup(args);
> +			if (string =3D=3D NULL)
> +				goto out_nomem;
> +			mnt->nfs_server.addrlen =3D
> +				rpc_pton(mnt->net, string, =
strlen(string),
> +					(struct sockaddr *)
> +					&mnt->nfs_server.address,
> +					=
sizeof(mnt->nfs_server.address));
> +			kfree(string);
> +			if (mnt->nfs_server.addrlen =3D=3D 0)
> +				goto out_invalid_address;
> +			break;
> +		case Opt_clientaddr:
> +			if (nfs_get_option_str(args, =
&mnt->client_address))
> +				goto out_nomem;
> +			break;
> +		case Opt_mounthost:
> +			if (nfs_get_option_str(args,
> +					       =
&mnt->mount_server.hostname))
> +				goto out_nomem;
> +			break;
> +		case Opt_mountaddr:
> +			string =3D match_strdup(args);
> +			if (string =3D=3D NULL)
> +				goto out_nomem;
> +			mnt->mount_server.addrlen =3D
> +				rpc_pton(mnt->net, string, =
strlen(string),
> +					(struct sockaddr *)
> +					&mnt->mount_server.address,
> +					=
sizeof(mnt->mount_server.address));
> +			kfree(string);
> +			if (mnt->mount_server.addrlen =3D=3D 0)
> +				goto out_invalid_address;
> +			break;
> +		case Opt_nconnect:
> +			if (nfs_get_option_ul_bound(args, &option, 1, =
NFS_MAX_CONNECTIONS))
> +				goto out_invalid_value;
> +			mnt->nfs_server.nconnect =3D option;
> +			break;
> +		case Opt_lookupcache:
> +			string =3D match_strdup(args);
> +			if (string =3D=3D NULL)
> +				goto out_nomem;
> +			token =3D match_token(string,
> +					nfs_lookupcache_tokens, args);
> +			kfree(string);
> +			switch (token) {
> +				case Opt_lookupcache_all:
> +					mnt->flags &=3D =
~(NFS_MOUNT_LOOKUP_CACHE_NONEG|NFS_MOUNT_LOOKUP_CACHE_NONE);
> +					break;
> +				case Opt_lookupcache_positive:
> +					mnt->flags &=3D =
~NFS_MOUNT_LOOKUP_CACHE_NONE;
> +					mnt->flags |=3D =
NFS_MOUNT_LOOKUP_CACHE_NONEG;
> +					break;
> +				case Opt_lookupcache_none:
> +					mnt->flags |=3D =
NFS_MOUNT_LOOKUP_CACHE_NONEG|NFS_MOUNT_LOOKUP_CACHE_NONE;
> +					break;
> +				default:
> +					dfprintk(MOUNT, "NFS:   invalid =
"
> +							"lookupcache =
argument\n");
> +					return 0;
> +			};
> +			break;
> +		case Opt_fscache_uniq:
> +			if (nfs_get_option_str(args, =
&mnt->fscache_uniq))
> +				goto out_nomem;
> +			mnt->options |=3D NFS_OPTION_FSCACHE;
> +			break;
> +		case Opt_local_lock:
> +			string =3D match_strdup(args);
> +			if (string =3D=3D NULL)
> +				goto out_nomem;
> +			token =3D match_token(string, =
nfs_local_lock_tokens,
> +					args);
> +			kfree(string);
> +			switch (token) {
> +			case Opt_local_lock_all:
> +				mnt->flags |=3D (NFS_MOUNT_LOCAL_FLOCK |
> +					       NFS_MOUNT_LOCAL_FCNTL);
> +				break;
> +			case Opt_local_lock_flock:
> +				mnt->flags |=3D NFS_MOUNT_LOCAL_FLOCK;
> +				break;
> +			case Opt_local_lock_posix:
> +				mnt->flags |=3D NFS_MOUNT_LOCAL_FCNTL;
> +				break;
> +			case Opt_local_lock_none:
> +				mnt->flags &=3D ~(NFS_MOUNT_LOCAL_FLOCK =
|
> +						NFS_MOUNT_LOCAL_FCNTL);
> +				break;
> +			default:
> +				dfprintk(MOUNT, "NFS:	invalid	"
> +						"local_lock =
argument\n");
> +				return 0;
> +			};
> +			break;
> +
> +		/*
> +		 * Special options
> +		 */
> +		case Opt_sloppy:
> +			sloppy =3D 1;
> +			dfprintk(MOUNT, "NFS:   relaxing parsing =
rules\n");
> +			break;
> +		case Opt_userspace:
> +		case Opt_deprecated:
> +			dfprintk(MOUNT, "NFS:   ignoring mount option "
> +					"'%s'\n", p);
> +			break;
> +
> +		default:
> +			invalid_option =3D 1;
> +			dfprintk(MOUNT, "NFS:   unrecognized mount =
option "
> +					"'%s'\n", p);
> +		}
> +	}
> +
> +	if (!sloppy && invalid_option)
> +		return 0;
> +
> +	if (mnt->minorversion && mnt->version !=3D 4)
> +		goto out_minorversion_mismatch;
> +
> +	if (mnt->options & NFS_OPTION_MIGRATION &&
> +	    (mnt->version !=3D 4 || mnt->minorversion !=3D 0))
> +		goto out_migration_misuse;
> +
> +	/*
> +	 * verify that any proto=3D/mountproto=3D options match the =
address
> +	 * families in the addr=3D/mountaddr=3D options.
> +	 */
> +	if (protofamily !=3D AF_UNSPEC &&
> +	    protofamily !=3D mnt->nfs_server.address.ss_family)
> +		goto out_proto_mismatch;
> +
> +	if (mountfamily !=3D AF_UNSPEC) {
> +		if (mnt->mount_server.addrlen) {
> +			if (mountfamily !=3D =
mnt->mount_server.address.ss_family)
> +				goto out_mountproto_mismatch;
> +		} else {
> +			if (mountfamily !=3D =
mnt->nfs_server.address.ss_family)
> +				goto out_mountproto_mismatch;
> +		}
> +	}
> +
> +	return 1;
> +
> +out_mountproto_mismatch:
> +	printk(KERN_INFO "NFS: mount server address does not match =
mountproto=3D "
> +			 "option\n");
> +	return 0;
> +out_proto_mismatch:
> +	printk(KERN_INFO "NFS: server address does not match proto=3D =
option\n");
> +	return 0;
> +out_invalid_address:
> +	printk(KERN_INFO "NFS: bad IP address specified: %s\n", p);
> +	return 0;
> +out_invalid_value:
> +	printk(KERN_INFO "NFS: bad mount option value specified: %s\n", =
p);
> +	return 0;
> +out_minorversion_mismatch:
> +	printk(KERN_INFO "NFS: mount option vers=3D%u does not support "
> +			 "minorversion=3D%u\n", mnt->version, =
mnt->minorversion);
> +	return 0;
> +out_migration_misuse:
> +	printk(KERN_INFO
> +		"NFS: 'migration' not supported for this NFS =
version\n");
> +	return 0;
> +out_nomem:
> +	printk(KERN_INFO "NFS: not enough memory to parse option\n");
> +	return 0;
> +out_security_failure:
> +	printk(KERN_INFO "NFS: security options invalid: %d\n", rc);
> +	return 0;
> +}
> +
> +/*
> + * Split "dev_name" into "hostname:export_path".
> + *
> + * The leftmost colon demarks the split between the server's hostname
> + * and the export path.  If the hostname starts with a left square
> + * bracket, then it may contain colons.
> + *
> + * Note: caller frees hostname and export path, even on error.
> + */
> +static int nfs_parse_devname(const char *dev_name,
> +			     char **hostname, size_t maxnamlen,
> +			     char **export_path, size_t maxpathlen)
> +{
> +	size_t len;
> +	char *end;
> +
> +	if (unlikely(!dev_name || !*dev_name)) {
> +		dfprintk(MOUNT, "NFS: device name not specified\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Is the host name protected with square brakcets? */
> +	if (*dev_name =3D=3D '[') {
> +		end =3D strchr(++dev_name, ']');
> +		if (end =3D=3D NULL || end[1] !=3D ':')
> +			goto out_bad_devname;
> +
> +		len =3D end - dev_name;
> +		end++;
> +	} else {
> +		char *comma;
> +
> +		end =3D strchr(dev_name, ':');
> +		if (end =3D=3D NULL)
> +			goto out_bad_devname;
> +		len =3D end - dev_name;
> +
> +		/* kill possible hostname list: not supported */
> +		comma =3D strchr(dev_name, ',');
> +		if (comma !=3D NULL && comma < end)
> +			len =3D comma - dev_name;
> +	}
> +
> +	if (len > maxnamlen)
> +		goto out_hostname;
> +
> +	/* N.B. caller will free nfs_server.hostname in all cases */
> +	*hostname =3D kstrndup(dev_name, len, GFP_KERNEL);
> +	if (*hostname =3D=3D NULL)
> +		goto out_nomem;
> +	len =3D strlen(++end);
> +	if (len > maxpathlen)
> +		goto out_path;
> +	*export_path =3D kstrndup(end, len, GFP_KERNEL);
> +	if (!*export_path)
> +		goto out_nomem;
> +
> +	dfprintk(MOUNT, "NFS: MNTPATH: '%s'\n", *export_path);
> +	return 0;
> +
> +out_bad_devname:
> +	dfprintk(MOUNT, "NFS: device name not in host:path format\n");
> +	return -EINVAL;
> +
> +out_nomem:
> +	dfprintk(MOUNT, "NFS: not enough memory to parse device =
name\n");
> +	return -ENOMEM;
> +
> +out_hostname:
> +	dfprintk(MOUNT, "NFS: server hostname too long\n");
> +	return -ENAMETOOLONG;
> +
> +out_path:
> +	dfprintk(MOUNT, "NFS: export pathname too long\n");
> +	return -ENAMETOOLONG;
> +}
> +
> +/*
> + * Validate the NFS2/NFS3 mount data
> + * - fills in the mount root filehandle
> + *
> + * For option strings, user space handles the following behaviors:
> + *
> + * + DNS: mapping server host name to IP address ("addr=3D" option)
> + *
> + * + failure mode: how to behave if a mount request can't be handled
> + *   immediately ("fg/bg" option)
> + *
> + * + retry: how often to retry a mount request ("retry=3D" option)
> + *
> + * + breaking back: trying proto=3Dudp after proto=3Dtcp, v2 after =
v3,
> + *   mountproto=3Dtcp after mountproto=3Dudp, and so on
> + */
> +static int nfs23_validate_mount_data(void *options,
> +				     struct nfs_parsed_mount_data *args,
> +				     struct nfs_fh *mntfh,
> +				     const char *dev_name)
> +{
> +	struct nfs_mount_data *data =3D (struct nfs_mount_data =
*)options;
> +	struct sockaddr *sap =3D (struct sockaddr =
*)&args->nfs_server.address;
> +	int extra_flags =3D NFS_MOUNT_LEGACY_INTERFACE;
> +
> +	if (data =3D=3D NULL)
> +		goto out_no_data;
> +
> +	args->version =3D NFS_DEFAULT_VERSION;
> +	switch (data->version) {
> +	case 1:
> +		data->namlen =3D 0; /* fall through */
> +	case 2:
> +		data->bsize =3D 0; /* fall through */
> +	case 3:
> +		if (data->flags & NFS_MOUNT_VER3)
> +			goto out_no_v3;
> +		data->root.size =3D NFS2_FHSIZE;
> +		memcpy(data->root.data, data->old_root.data, =
NFS2_FHSIZE);
> +		/* Turn off security negotiation */
> +		extra_flags |=3D NFS_MOUNT_SECFLAVOUR;
> +		/* fall through */
> +	case 4:
> +		if (data->flags & NFS_MOUNT_SECFLAVOUR)
> +			goto out_no_sec;
> +		/* fall through */
> +	case 5:
> +		memset(data->context, 0, sizeof(data->context));
> +		/* fall through */
> +	case 6:
> +		if (data->flags & NFS_MOUNT_VER3) {
> +			if (data->root.size > NFS3_FHSIZE || =
data->root.size =3D=3D 0)
> +				goto out_invalid_fh;
> +			mntfh->size =3D data->root.size;
> +			args->version =3D 3;
> +		} else {
> +			mntfh->size =3D NFS2_FHSIZE;
> +			args->version =3D 2;
> +		}
> +
> +
> +		memcpy(mntfh->data, data->root.data, mntfh->size);
> +		if (mntfh->size < sizeof(mntfh->data))
> +			memset(mntfh->data + mntfh->size, 0,
> +			       sizeof(mntfh->data) - mntfh->size);
> +
> +		/*
> +		 * Translate to nfs_parsed_mount_data, which =
nfs_fill_super
> +		 * can deal with.
> +		 */
> +		args->flags		=3D data->flags & =
NFS_MOUNT_FLAGMASK;
> +		args->flags		|=3D extra_flags;
> +		args->rsize		=3D data->rsize;
> +		args->wsize		=3D data->wsize;
> +		args->timeo		=3D data->timeo;
> +		args->retrans		=3D data->retrans;
> +		args->acregmin		=3D data->acregmin;
> +		args->acregmax		=3D data->acregmax;
> +		args->acdirmin		=3D data->acdirmin;
> +		args->acdirmax		=3D data->acdirmax;
> +		args->need_mount	=3D false;
> +
> +		memcpy(sap, &data->addr, sizeof(data->addr));
> +		args->nfs_server.addrlen =3D sizeof(data->addr);
> +		args->nfs_server.port =3D ntohs(data->addr.sin_port);
> +		if (sap->sa_family !=3D AF_INET ||
> +		    !nfs_verify_server_address(sap))
> +			goto out_no_address;
> +
> +		if (!(data->flags & NFS_MOUNT_TCP))
> +			args->nfs_server.protocol =3D =
XPRT_TRANSPORT_UDP;
> +		/* N.B. caller will free nfs_server.hostname in all =
cases */
> +		args->nfs_server.hostname =3D kstrdup(data->hostname, =
GFP_KERNEL);
> +		args->namlen		=3D data->namlen;
> +		args->bsize		=3D data->bsize;
> +
> +		if (data->flags & NFS_MOUNT_SECFLAVOUR)
> +			args->selected_flavor =3D data->pseudoflavor;
> +		else
> +			args->selected_flavor =3D RPC_AUTH_UNIX;
> +		if (!args->nfs_server.hostname)
> +			goto out_nomem;
> +
> +		if (!(data->flags & NFS_MOUNT_NONLM))
> +			args->flags &=3D ~(NFS_MOUNT_LOCAL_FLOCK|
> +					 NFS_MOUNT_LOCAL_FCNTL);
> +		else
> +			args->flags |=3D (NFS_MOUNT_LOCAL_FLOCK|
> +					NFS_MOUNT_LOCAL_FCNTL);
> +		/*
> +		 * The legacy version 6 binary mount data from userspace =
has a
> +		 * field used only to transport selinux information into =
the
> +		 * the kernel.  To continue to support that =
functionality we
> +		 * have a touch of selinux knowledge here in the NFS =
code. The
> +		 * userspace code converted context=3Dblah to just blah =
so we are
> +		 * converting back to the full string selinux =
understands.
> +		 */
> +		if (data->context[0]){
> +#ifdef CONFIG_SECURITY_SELINUX
> +			int rc;
> +			data->context[NFS_MAX_CONTEXT_LEN] =3D '\0';
> +			rc =3D security_add_mnt_opt("context", =
data->context,
> +					strlen(data->context), =
&args->lsm_opts);
> +			if (rc)
> +				return rc;
> +#else
> +			return -EINVAL;
> +#endif
> +		}
> +
> +		break;
> +	default:
> +		return NFS_TEXT_DATA;
> +	}
> +
> +	return 0;
> +
> +out_no_data:
> +	dfprintk(MOUNT, "NFS: mount program didn't pass any mount =
data\n");
> +	return -EINVAL;
> +
> +out_no_v3:
> +	dfprintk(MOUNT, "NFS: nfs_mount_data version %d does not support =
v3\n",
> +		 data->version);
> +	return -EINVAL;
> +
> +out_no_sec:
> +	dfprintk(MOUNT, "NFS: nfs_mount_data version supports only =
AUTH_SYS\n");
> +	return -EINVAL;
> +
> +out_nomem:
> +	dfprintk(MOUNT, "NFS: not enough memory to handle mount =
options\n");
> +	return -ENOMEM;
> +
> +out_no_address:
> +	dfprintk(MOUNT, "NFS: mount program didn't pass remote =
address\n");
> +	return -EINVAL;
> +
> +out_invalid_fh:
> +	dfprintk(MOUNT, "NFS: invalid root filehandle\n");
> +	return -EINVAL;
> +}
> +
> +#if IS_ENABLED(CONFIG_NFS_V4)
> +
> +static void nfs4_validate_mount_flags(struct nfs_parsed_mount_data =
*args)
> +{
> +	args->flags &=3D =
~(NFS_MOUNT_NONLM|NFS_MOUNT_NOACL|NFS_MOUNT_VER3|
> +			 NFS_MOUNT_LOCAL_FLOCK|NFS_MOUNT_LOCAL_FCNTL);
> +}
> +
> +/*
> + * Validate NFSv4 mount options
> + */
> +static int nfs4_validate_mount_data(void *options,
> +				    struct nfs_parsed_mount_data *args,
> +				    const char *dev_name)
> +{
> +	struct sockaddr *sap =3D (struct sockaddr =
*)&args->nfs_server.address;
> +	struct nfs4_mount_data *data =3D (struct nfs4_mount_data =
*)options;
> +	char *c;
> +
> +	if (data =3D=3D NULL)
> +		goto out_no_data;
> +
> +	args->version =3D 4;
> +
> +	switch (data->version) {
> +	case 1:
> +		if (data->host_addrlen > =
sizeof(args->nfs_server.address))
> +			goto out_no_address;
> +		if (data->host_addrlen =3D=3D 0)
> +			goto out_no_address;
> +		args->nfs_server.addrlen =3D data->host_addrlen;
> +		if (copy_from_user(sap, data->host_addr, =
data->host_addrlen))
> +			return -EFAULT;
> +		if (!nfs_verify_server_address(sap))
> +			goto out_no_address;
> +		args->nfs_server.port =3D ntohs(((struct sockaddr_in =
*)sap)->sin_port);
> +
> +		if (data->auth_flavourlen) {
> +			rpc_authflavor_t pseudoflavor;
> +			if (data->auth_flavourlen > 1)
> +				goto out_inval_auth;
> +			if (copy_from_user(&pseudoflavor,
> +					   data->auth_flavours,
> +					   sizeof(pseudoflavor)))
> +				return -EFAULT;
> +			args->selected_flavor =3D pseudoflavor;
> +		} else
> +			args->selected_flavor =3D RPC_AUTH_UNIX;
> +
> +		c =3D strndup_user(data->hostname.data, NFS4_MAXNAMLEN);
> +		if (IS_ERR(c))
> +			return PTR_ERR(c);
> +		args->nfs_server.hostname =3D c;
> +
> +		c =3D strndup_user(data->mnt_path.data, =
NFS4_MAXPATHLEN);
> +		if (IS_ERR(c))
> +			return PTR_ERR(c);
> +		args->nfs_server.export_path =3D c;
> +		dfprintk(MOUNT, "NFS: MNTPATH: '%s'\n", c);
> +
> +		c =3D strndup_user(data->client_addr.data, 16);
> +		if (IS_ERR(c))
> +			return PTR_ERR(c);
> +		args->client_address =3D c;
> +
> +		/*
> +		 * Translate to nfs_parsed_mount_data, which =
nfs4_fill_super
> +		 * can deal with.
> +		 */
> +
> +		args->flags	=3D data->flags & NFS4_MOUNT_FLAGMASK;
> +		args->rsize	=3D data->rsize;
> +		args->wsize	=3D data->wsize;
> +		args->timeo	=3D data->timeo;
> +		args->retrans	=3D data->retrans;
> +		args->acregmin	=3D data->acregmin;
> +		args->acregmax	=3D data->acregmax;
> +		args->acdirmin	=3D data->acdirmin;
> +		args->acdirmax	=3D data->acdirmax;
> +		args->nfs_server.protocol =3D data->proto;
> +		nfs_validate_transport_protocol(args);
> +		if (args->nfs_server.protocol =3D=3D XPRT_TRANSPORT_UDP)
> +			goto out_invalid_transport_udp;
> +
> +		break;
> +	default:
> +		return NFS_TEXT_DATA;
> +	}
> +
> +	return 0;
> +
> +out_no_data:
> +	dfprintk(MOUNT, "NFS4: mount program didn't pass any mount =
data\n");
> +	return -EINVAL;
> +
> +out_inval_auth:
> +	dfprintk(MOUNT, "NFS4: Invalid number of RPC auth flavours =
%d\n",
> +		 data->auth_flavourlen);
> +	return -EINVAL;
> +
> +out_no_address:
> +	dfprintk(MOUNT, "NFS4: mount program didn't pass remote =
address\n");
> +	return -EINVAL;
> +
> +out_invalid_transport_udp:
> +	dfprintk(MOUNT, "NFSv4: Unsupported transport protocol udp\n");
> +	return -EINVAL;
> +}
> +
> +int nfs_validate_mount_data(struct file_system_type *fs_type,
> +			    void *options,
> +			    struct nfs_parsed_mount_data *args,
> +			    struct nfs_fh *mntfh,
> +			    const char *dev_name)
> +{
> +	if (fs_type =3D=3D &nfs_fs_type)
> +		return nfs23_validate_mount_data(options, args, mntfh, =
dev_name);
> +	return nfs4_validate_mount_data(options, args, dev_name);
> +}
> +#else
> +int nfs_validate_mount_data(struct file_system_type *fs_type,
> +			    void *options,
> +			    struct nfs_parsed_mount_data *args,
> +			    struct nfs_fh *mntfh,
> +			    const char *dev_name)
> +{
> +	return nfs23_validate_mount_data(options, args, mntfh, =
dev_name);
> +}
> +#endif
> +
> +int nfs_validate_text_mount_data(void *options,
> +				 struct nfs_parsed_mount_data *args,
> +				 const char *dev_name)
> +{
> +	int port =3D 0;
> +	int max_namelen =3D PAGE_SIZE;
> +	int max_pathlen =3D NFS_MAXPATHLEN;
> +	struct sockaddr *sap =3D (struct sockaddr =
*)&args->nfs_server.address;
> +
> +	if (nfs_parse_mount_options((char *)options, args) =3D=3D 0)
> +		return -EINVAL;
> +
> +	if (!nfs_verify_server_address(sap))
> +		goto out_no_address;
> +
> +	if (args->version =3D=3D 4) {
> +#if IS_ENABLED(CONFIG_NFS_V4)
> +		if (args->nfs_server.protocol =3D=3D =
XPRT_TRANSPORT_RDMA)
> +			port =3D NFS_RDMA_PORT;
> +		else
> +			port =3D NFS_PORT;
> +		max_namelen =3D NFS4_MAXNAMLEN;
> +		max_pathlen =3D NFS4_MAXPATHLEN;
> +		nfs_validate_transport_protocol(args);
> +		if (args->nfs_server.protocol =3D=3D XPRT_TRANSPORT_UDP)
> +			goto out_invalid_transport_udp;
> +		nfs4_validate_mount_flags(args);
> +#else
> +		goto out_v4_not_compiled;
> +#endif /* CONFIG_NFS_V4 */
> +	} else {
> +		nfs_set_mount_transport_protocol(args);
> +		if (args->nfs_server.protocol =3D=3D =
XPRT_TRANSPORT_RDMA)
> +			port =3D NFS_RDMA_PORT;
> +	}
> +
> +	nfs_set_port(sap, &args->nfs_server.port, port);
> +
> +	return nfs_parse_devname(dev_name,
> +				   &args->nfs_server.hostname,
> +				   max_namelen,
> +				   &args->nfs_server.export_path,
> +				   max_pathlen);
> +
> +#if !IS_ENABLED(CONFIG_NFS_V4)
> +out_v4_not_compiled:
> +	dfprintk(MOUNT, "NFS: NFSv4 is not compiled into kernel\n");
> +	return -EPROTONOSUPPORT;
> +#else
> +out_invalid_transport_udp:
> +	dfprintk(MOUNT, "NFSv4: Unsupported transport protocol udp\n");
> +	return -EINVAL;
> +#endif /* !CONFIG_NFS_V4 */
> +
> +out_no_address:
> +	dfprintk(MOUNT, "NFS: mount program didn't pass remote =
address\n");
> +	return -EINVAL;
> +}
> diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
> index d512ec394559..b66fd35993b3 100644
> --- a/fs/nfs/internal.h
> +++ b/fs/nfs/internal.h
> @@ -7,6 +7,7 @@
> #include <linux/mount.h>
> #include <linux/security.h>
> #include <linux/crc32.h>
> +#include <linux/sunrpc/addr.h>
> #include <linux/nfs_page.h>
> #include <linux/wait_bit.h>
>=20
> @@ -232,6 +233,22 @@ extern const struct svc_version =
nfs4_callback_version1;
> extern const struct svc_version nfs4_callback_version4;
>=20
> struct nfs_pageio_descriptor;
> +
> +/* mount.c */
> +#define NFS_TEXT_DATA		1
> +
> +extern struct nfs_parsed_mount_data =
*nfs_alloc_parsed_mount_data(void);
> +extern void nfs_free_parsed_mount_data(struct nfs_parsed_mount_data =
*data);
> +extern int nfs_parse_mount_options(char *raw, struct =
nfs_parsed_mount_data *mnt);
> +extern int nfs_validate_mount_data(struct file_system_type *fs_type,
> +				   void *options,
> +				   struct nfs_parsed_mount_data *args,
> +				   struct nfs_fh *mntfh,
> +				   const char *dev_name);
> +extern int nfs_validate_text_mount_data(void *options,
> +					struct nfs_parsed_mount_data =
*args,
> +					const char *dev_name);
> +
> /* pagelist.c */
> extern int __init nfs_init_nfspagecache(void);
> extern void nfs_destroy_nfspagecache(void);
> @@ -763,3 +780,15 @@ static inline bool nfs_error_is_fatal(int err)
> 	}
> }
>=20
> +/*
> + * Select between a default port value and a user-specified port =
value.
> + * If a zero value is set, then autobind will be used.
> + */
> +static inline void nfs_set_port(struct sockaddr *sap, int *port,
> +				const unsigned short default_port)
> +{
> +	if (*port =3D=3D NFS_UNSPEC_PORT)
> +		*port =3D default_port;
> +
> +	rpc_set_port(sap, *port);
> +}
> diff --git a/fs/nfs/super.c b/fs/nfs/super.c
> index d8702e57f7fc..886220d2da4e 100644
> --- a/fs/nfs/super.c
> +++ b/fs/nfs/super.c
> @@ -69,229 +69,6 @@
> #include "nfs.h"
>=20
> #define NFSDBG_FACILITY		NFSDBG_VFS
> -#define NFS_TEXT_DATA		1
> -
> -#if IS_ENABLED(CONFIG_NFS_V3)
> -#define NFS_DEFAULT_VERSION 3
> -#else
> -#define NFS_DEFAULT_VERSION 2
> -#endif
> -
> -#define NFS_MAX_CONNECTIONS 16
> -
> -enum {
> -	/* Mount options that take no arguments */
> -	Opt_soft, Opt_softerr, Opt_hard,
> -	Opt_posix, Opt_noposix,
> -	Opt_cto, Opt_nocto,
> -	Opt_ac, Opt_noac,
> -	Opt_lock, Opt_nolock,
> -	Opt_udp, Opt_tcp, Opt_rdma,
> -	Opt_acl, Opt_noacl,
> -	Opt_rdirplus, Opt_nordirplus,
> -	Opt_sharecache, Opt_nosharecache,
> -	Opt_resvport, Opt_noresvport,
> -	Opt_fscache, Opt_nofscache,
> -	Opt_migration, Opt_nomigration,
> -
> -	/* Mount options that take integer arguments */
> -	Opt_port,
> -	Opt_rsize, Opt_wsize, Opt_bsize,
> -	Opt_timeo, Opt_retrans,
> -	Opt_acregmin, Opt_acregmax,
> -	Opt_acdirmin, Opt_acdirmax,
> -	Opt_actimeo,
> -	Opt_namelen,
> -	Opt_mountport,
> -	Opt_mountvers,
> -	Opt_minorversion,
> -
> -	/* Mount options that take string arguments */
> -	Opt_nfsvers,
> -	Opt_sec, Opt_proto, Opt_mountproto, Opt_mounthost,
> -	Opt_addr, Opt_mountaddr, Opt_clientaddr,
> -	Opt_nconnect,
> -	Opt_lookupcache,
> -	Opt_fscache_uniq,
> -	Opt_local_lock,
> -
> -	/* Special mount options */
> -	Opt_userspace, Opt_deprecated, Opt_sloppy,
> -
> -	Opt_err
> -};
> -
> -static const match_table_t nfs_mount_option_tokens =3D {
> -	{ Opt_userspace, "bg" },
> -	{ Opt_userspace, "fg" },
> -	{ Opt_userspace, "retry=3D%s" },
> -
> -	{ Opt_sloppy, "sloppy" },
> -
> -	{ Opt_soft, "soft" },
> -	{ Opt_softerr, "softerr" },
> -	{ Opt_hard, "hard" },
> -	{ Opt_deprecated, "intr" },
> -	{ Opt_deprecated, "nointr" },
> -	{ Opt_posix, "posix" },
> -	{ Opt_noposix, "noposix" },
> -	{ Opt_cto, "cto" },
> -	{ Opt_nocto, "nocto" },
> -	{ Opt_ac, "ac" },
> -	{ Opt_noac, "noac" },
> -	{ Opt_lock, "lock" },
> -	{ Opt_nolock, "nolock" },
> -	{ Opt_udp, "udp" },
> -	{ Opt_tcp, "tcp" },
> -	{ Opt_rdma, "rdma" },
> -	{ Opt_acl, "acl" },
> -	{ Opt_noacl, "noacl" },
> -	{ Opt_rdirplus, "rdirplus" },
> -	{ Opt_nordirplus, "nordirplus" },
> -	{ Opt_sharecache, "sharecache" },
> -	{ Opt_nosharecache, "nosharecache" },
> -	{ Opt_resvport, "resvport" },
> -	{ Opt_noresvport, "noresvport" },
> -	{ Opt_fscache, "fsc" },
> -	{ Opt_nofscache, "nofsc" },
> -	{ Opt_migration, "migration" },
> -	{ Opt_nomigration, "nomigration" },
> -
> -	{ Opt_port, "port=3D%s" },
> -	{ Opt_rsize, "rsize=3D%s" },
> -	{ Opt_wsize, "wsize=3D%s" },
> -	{ Opt_bsize, "bsize=3D%s" },
> -	{ Opt_timeo, "timeo=3D%s" },
> -	{ Opt_retrans, "retrans=3D%s" },
> -	{ Opt_acregmin, "acregmin=3D%s" },
> -	{ Opt_acregmax, "acregmax=3D%s" },
> -	{ Opt_acdirmin, "acdirmin=3D%s" },
> -	{ Opt_acdirmax, "acdirmax=3D%s" },
> -	{ Opt_actimeo, "actimeo=3D%s" },
> -	{ Opt_namelen, "namlen=3D%s" },
> -	{ Opt_mountport, "mountport=3D%s" },
> -	{ Opt_mountvers, "mountvers=3D%s" },
> -	{ Opt_minorversion, "minorversion=3D%s" },
> -
> -	{ Opt_nfsvers, "nfsvers=3D%s" },
> -	{ Opt_nfsvers, "vers=3D%s" },
> -
> -	{ Opt_sec, "sec=3D%s" },
> -	{ Opt_proto, "proto=3D%s" },
> -	{ Opt_mountproto, "mountproto=3D%s" },
> -	{ Opt_addr, "addr=3D%s" },
> -	{ Opt_clientaddr, "clientaddr=3D%s" },
> -	{ Opt_mounthost, "mounthost=3D%s" },
> -	{ Opt_mountaddr, "mountaddr=3D%s" },
> -
> -	{ Opt_nconnect, "nconnect=3D%s" },
> -
> -	{ Opt_lookupcache, "lookupcache=3D%s" },
> -	{ Opt_fscache_uniq, "fsc=3D%s" },
> -	{ Opt_local_lock, "local_lock=3D%s" },
> -
> -	/* The following needs to be listed after all other options */
> -	{ Opt_nfsvers, "v%s" },
> -
> -	{ Opt_err, NULL }
> -};
> -
> -enum {
> -	Opt_xprt_udp, Opt_xprt_udp6, Opt_xprt_tcp, Opt_xprt_tcp6, =
Opt_xprt_rdma,
> -	Opt_xprt_rdma6,
> -
> -	Opt_xprt_err
> -};
> -
> -static const match_table_t nfs_xprt_protocol_tokens =3D {
> -	{ Opt_xprt_udp, "udp" },
> -	{ Opt_xprt_udp6, "udp6" },
> -	{ Opt_xprt_tcp, "tcp" },
> -	{ Opt_xprt_tcp6, "tcp6" },
> -	{ Opt_xprt_rdma, "rdma" },
> -	{ Opt_xprt_rdma6, "rdma6" },
> -
> -	{ Opt_xprt_err, NULL }
> -};
> -
> -enum {
> -	Opt_sec_none, Opt_sec_sys,
> -	Opt_sec_krb5, Opt_sec_krb5i, Opt_sec_krb5p,
> -	Opt_sec_lkey, Opt_sec_lkeyi, Opt_sec_lkeyp,
> -	Opt_sec_spkm, Opt_sec_spkmi, Opt_sec_spkmp,
> -
> -	Opt_sec_err
> -};
> -
> -static const match_table_t nfs_secflavor_tokens =3D {
> -	{ Opt_sec_none, "none" },
> -	{ Opt_sec_none, "null" },
> -	{ Opt_sec_sys, "sys" },
> -
> -	{ Opt_sec_krb5, "krb5" },
> -	{ Opt_sec_krb5i, "krb5i" },
> -	{ Opt_sec_krb5p, "krb5p" },
> -
> -	{ Opt_sec_lkey, "lkey" },
> -	{ Opt_sec_lkeyi, "lkeyi" },
> -	{ Opt_sec_lkeyp, "lkeyp" },
> -
> -	{ Opt_sec_spkm, "spkm3" },
> -	{ Opt_sec_spkmi, "spkm3i" },
> -	{ Opt_sec_spkmp, "spkm3p" },
> -
> -	{ Opt_sec_err, NULL }
> -};
> -
> -enum {
> -	Opt_lookupcache_all, Opt_lookupcache_positive,
> -	Opt_lookupcache_none,
> -
> -	Opt_lookupcache_err
> -};
> -
> -static match_table_t nfs_lookupcache_tokens =3D {
> -	{ Opt_lookupcache_all, "all" },
> -	{ Opt_lookupcache_positive, "pos" },
> -	{ Opt_lookupcache_positive, "positive" },
> -	{ Opt_lookupcache_none, "none" },
> -
> -	{ Opt_lookupcache_err, NULL }
> -};
> -
> -enum {
> -	Opt_local_lock_all, Opt_local_lock_flock, Opt_local_lock_posix,
> -	Opt_local_lock_none,
> -
> -	Opt_local_lock_err
> -};
> -
> -static match_table_t nfs_local_lock_tokens =3D {
> -	{ Opt_local_lock_all, "all" },
> -	{ Opt_local_lock_flock, "flock" },
> -	{ Opt_local_lock_posix, "posix" },
> -	{ Opt_local_lock_none, "none" },
> -
> -	{ Opt_local_lock_err, NULL }
> -};
> -
> -enum {
> -	Opt_vers_2, Opt_vers_3, Opt_vers_4, Opt_vers_4_0,
> -	Opt_vers_4_1, Opt_vers_4_2,
> -
> -	Opt_vers_err
> -};
> -
> -static match_table_t nfs_vers_tokens =3D {
> -	{ Opt_vers_2, "2" },
> -	{ Opt_vers_3, "3" },
> -	{ Opt_vers_4, "4" },
> -	{ Opt_vers_4_0, "4.0" },
> -	{ Opt_vers_4_1, "4.1" },
> -	{ Opt_vers_4_2, "4.2" },
> -
> -	{ Opt_vers_err, NULL }
> -};
>=20
> static struct dentry *nfs_prepared_mount(struct file_system_type =
*fs_type,
> 		int flags, const char *dev_name, void *raw_data);
> @@ -332,10 +109,6 @@ const struct super_operations nfs_sops =3D {
> EXPORT_SYMBOL_GPL(nfs_sops);
>=20
> #if IS_ENABLED(CONFIG_NFS_V4)
> -static void nfs4_validate_mount_flags(struct nfs_parsed_mount_data =
*);
> -static int nfs4_validate_mount_data(void *options,
> -	struct nfs_parsed_mount_data *args, const char *dev_name);
> -
> struct file_system_type nfs4_fs_type =3D {
> 	.owner		=3D THIS_MODULE,
> 	.name		=3D "nfs4",
> @@ -932,141 +705,6 @@ void nfs_umount_begin(struct super_block *sb)
> }
> EXPORT_SYMBOL_GPL(nfs_umount_begin);
>=20
> -static struct nfs_parsed_mount_data =
*nfs_alloc_parsed_mount_data(void)
> -{
> -	struct nfs_parsed_mount_data *data;
> -
> -	data =3D kzalloc(sizeof(*data), GFP_KERNEL);
> -	if (data) {
> -		data->timeo		=3D NFS_UNSPEC_TIMEO;
> -		data->retrans		=3D NFS_UNSPEC_RETRANS;
> -		data->acregmin		=3D NFS_DEF_ACREGMIN;
> -		data->acregmax		=3D NFS_DEF_ACREGMAX;
> -		data->acdirmin		=3D NFS_DEF_ACDIRMIN;
> -		data->acdirmax		=3D NFS_DEF_ACDIRMAX;
> -		data->mount_server.port	=3D NFS_UNSPEC_PORT;
> -		data->nfs_server.port	=3D NFS_UNSPEC_PORT;
> -		data->nfs_server.protocol =3D XPRT_TRANSPORT_TCP;
> -		data->selected_flavor	=3D RPC_AUTH_MAXFLAVOR;
> -		data->minorversion	=3D 0;
> -		data->need_mount	=3D true;
> -		data->net		=3D current->nsproxy->net_ns;
> -		data->lsm_opts		=3D NULL;
> -	}
> -	return data;
> -}
> -
> -static void nfs_free_parsed_mount_data(struct nfs_parsed_mount_data =
*data)
> -{
> -	if (data) {
> -		kfree(data->client_address);
> -		kfree(data->mount_server.hostname);
> -		kfree(data->nfs_server.export_path);
> -		kfree(data->nfs_server.hostname);
> -		kfree(data->fscache_uniq);
> -		security_free_mnt_opts(&data->lsm_opts);
> -		kfree(data);
> -	}
> -}
> -
> -/*
> - * Sanity-check a server address provided by the mount command.
> - *
> - * Address family must be initialized, and address must not be
> - * the ANY address for that family.
> - */
> -static int nfs_verify_server_address(struct sockaddr *addr)
> -{
> -	switch (addr->sa_family) {
> -	case AF_INET: {
> -		struct sockaddr_in *sa =3D (struct sockaddr_in *)addr;
> -		return sa->sin_addr.s_addr !=3D htonl(INADDR_ANY);
> -	}
> -	case AF_INET6: {
> -		struct in6_addr *sa =3D &((struct sockaddr_in6 =
*)addr)->sin6_addr;
> -		return !ipv6_addr_any(sa);
> -	}
> -	}
> -
> -	dfprintk(MOUNT, "NFS: Invalid IP address specified\n");
> -	return 0;
> -}
> -
> -/*
> - * Select between a default port value and a user-specified port =
value.
> - * If a zero value is set, then autobind will be used.
> - */
> -static void nfs_set_port(struct sockaddr *sap, int *port,
> -				 const unsigned short default_port)
> -{
> -	if (*port =3D=3D NFS_UNSPEC_PORT)
> -		*port =3D default_port;
> -
> -	rpc_set_port(sap, *port);
> -}
> -
> -/*
> - * Sanity check the NFS transport protocol.
> - *
> - */
> -static void nfs_validate_transport_protocol(struct =
nfs_parsed_mount_data *mnt)
> -{
> -	switch (mnt->nfs_server.protocol) {
> -	case XPRT_TRANSPORT_UDP:
> -	case XPRT_TRANSPORT_TCP:
> -	case XPRT_TRANSPORT_RDMA:
> -		break;
> -	default:
> -		mnt->nfs_server.protocol =3D XPRT_TRANSPORT_TCP;
> -	}
> -}
> -
> -/*
> - * For text based NFSv2/v3 mounts, the mount protocol transport =
default
> - * settings should depend upon the specified NFS transport.
> - */
> -static void nfs_set_mount_transport_protocol(struct =
nfs_parsed_mount_data *mnt)
> -{
> -	nfs_validate_transport_protocol(mnt);
> -
> -	if (mnt->mount_server.protocol =3D=3D XPRT_TRANSPORT_UDP ||
> -	    mnt->mount_server.protocol =3D=3D XPRT_TRANSPORT_TCP)
> -			return;
> -	switch (mnt->nfs_server.protocol) {
> -	case XPRT_TRANSPORT_UDP:
> -		mnt->mount_server.protocol =3D XPRT_TRANSPORT_UDP;
> -		break;
> -	case XPRT_TRANSPORT_TCP:
> -	case XPRT_TRANSPORT_RDMA:
> -		mnt->mount_server.protocol =3D XPRT_TRANSPORT_TCP;
> -	}
> -}
> -
> -/*
> - * Add 'flavor' to 'auth_info' if not already present.
> - * Returns true if 'flavor' ends up in the list, false otherwise
> - */
> -static bool nfs_auth_info_add(struct nfs_auth_info *auth_info,
> -			      rpc_authflavor_t flavor)
> -{
> -	unsigned int i;
> -	unsigned int max_flavor_len =3D ARRAY_SIZE(auth_info->flavors);
> -
> -	/* make sure this flavor isn't already in the list */
> -	for (i =3D 0; i < auth_info->flavor_len; i++) {
> -		if (flavor =3D=3D auth_info->flavors[i])
> -			return true;
> -	}
> -
> -	if (auth_info->flavor_len + 1 >=3D max_flavor_len) {
> -		dfprintk(MOUNT, "NFS: too many sec=3D flavors\n");
> -		return false;
> -	}
> -
> -	auth_info->flavors[auth_info->flavor_len++] =3D flavor;
> -	return true;
> -}
> -
> /*
>  * Return true if 'match' is in auth_info or auth_info is empty.
>  * Return false otherwise.
> @@ -1087,627 +725,6 @@ bool nfs_auth_info_match(const struct =
nfs_auth_info *auth_info,
> }
> EXPORT_SYMBOL_GPL(nfs_auth_info_match);
>=20
> -/*
> - * Parse the value of the 'sec=3D' option.
> - */
> -static int nfs_parse_security_flavors(char *value,
> -				      struct nfs_parsed_mount_data *mnt)
> -{
> -	substring_t args[MAX_OPT_ARGS];
> -	rpc_authflavor_t pseudoflavor;
> -	char *p;
> -
> -	dfprintk(MOUNT, "NFS: parsing sec=3D%s option\n", value);
> -
> -	while ((p =3D strsep(&value, ":")) !=3D NULL) {
> -		switch (match_token(p, nfs_secflavor_tokens, args)) {
> -		case Opt_sec_none:
> -			pseudoflavor =3D RPC_AUTH_NULL;
> -			break;
> -		case Opt_sec_sys:
> -			pseudoflavor =3D RPC_AUTH_UNIX;
> -			break;
> -		case Opt_sec_krb5:
> -			pseudoflavor =3D RPC_AUTH_GSS_KRB5;
> -			break;
> -		case Opt_sec_krb5i:
> -			pseudoflavor =3D RPC_AUTH_GSS_KRB5I;
> -			break;
> -		case Opt_sec_krb5p:
> -			pseudoflavor =3D RPC_AUTH_GSS_KRB5P;
> -			break;
> -		case Opt_sec_lkey:
> -			pseudoflavor =3D RPC_AUTH_GSS_LKEY;
> -			break;
> -		case Opt_sec_lkeyi:
> -			pseudoflavor =3D RPC_AUTH_GSS_LKEYI;
> -			break;
> -		case Opt_sec_lkeyp:
> -			pseudoflavor =3D RPC_AUTH_GSS_LKEYP;
> -			break;
> -		case Opt_sec_spkm:
> -			pseudoflavor =3D RPC_AUTH_GSS_SPKM;
> -			break;
> -		case Opt_sec_spkmi:
> -			pseudoflavor =3D RPC_AUTH_GSS_SPKMI;
> -			break;
> -		case Opt_sec_spkmp:
> -			pseudoflavor =3D RPC_AUTH_GSS_SPKMP;
> -			break;
> -		default:
> -			dfprintk(MOUNT,
> -				 "NFS: sec=3D option '%s' not =
recognized\n", p);
> -			return 0;
> -		}
> -
> -		if (!nfs_auth_info_add(&mnt->auth_info, pseudoflavor))
> -			return 0;
> -	}
> -
> -	return 1;
> -}
> -
> -static int nfs_parse_version_string(char *string,
> -		struct nfs_parsed_mount_data *mnt,
> -		substring_t *args)
> -{
> -	mnt->flags &=3D ~NFS_MOUNT_VER3;
> -	switch (match_token(string, nfs_vers_tokens, args)) {
> -	case Opt_vers_2:
> -		mnt->version =3D 2;
> -		break;
> -	case Opt_vers_3:
> -		mnt->flags |=3D NFS_MOUNT_VER3;
> -		mnt->version =3D 3;
> -		break;
> -	case Opt_vers_4:
> -		/* Backward compatibility option. In future,
> -		 * the mount program should always supply
> -		 * a NFSv4 minor version number.
> -		 */
> -		mnt->version =3D 4;
> -		break;
> -	case Opt_vers_4_0:
> -		mnt->version =3D 4;
> -		mnt->minorversion =3D 0;
> -		break;
> -	case Opt_vers_4_1:
> -		mnt->version =3D 4;
> -		mnt->minorversion =3D 1;
> -		break;
> -	case Opt_vers_4_2:
> -		mnt->version =3D 4;
> -		mnt->minorversion =3D 2;
> -		break;
> -	default:
> -		return 0;
> -	}
> -	return 1;
> -}
> -
> -static int nfs_get_option_str(substring_t args[], char **option)
> -{
> -	kfree(*option);
> -	*option =3D match_strdup(args);
> -	return !*option;
> -}
> -
> -static int nfs_get_option_ul(substring_t args[], unsigned long =
*option)
> -{
> -	int rc;
> -	char *string;
> -
> -	string =3D match_strdup(args);
> -	if (string =3D=3D NULL)
> -		return -ENOMEM;
> -	rc =3D kstrtoul(string, 10, option);
> -	kfree(string);
> -
> -	return rc;
> -}
> -
> -static int nfs_get_option_ul_bound(substring_t args[], unsigned long =
*option,
> -		unsigned long l_bound, unsigned long u_bound)
> -{
> -	int ret;
> -
> -	ret =3D nfs_get_option_ul(args, option);
> -	if (ret !=3D 0)
> -		return ret;
> -	if (*option < l_bound || *option > u_bound)
> -		return -ERANGE;
> -	return 0;
> -}
> -
> -/*
> - * Error-check and convert a string of mount options from user space =
into
> - * a data structure.  The whole mount string is processed; bad =
options are
> - * skipped as they are encountered.  If there were no errors, return =
1;
> - * otherwise return 0 (zero).
> - */
> -static int nfs_parse_mount_options(char *raw,
> -				   struct nfs_parsed_mount_data *mnt)
> -{
> -	char *p, *string;
> -	int rc, sloppy =3D 0, invalid_option =3D 0;
> -	unsigned short protofamily =3D AF_UNSPEC;
> -	unsigned short mountfamily =3D AF_UNSPEC;
> -
> -	if (!raw) {
> -		dfprintk(MOUNT, "NFS: mount options string was =
NULL.\n");
> -		return 1;
> -	}
> -	dfprintk(MOUNT, "NFS: nfs mount opts=3D'%s'\n", raw);
> -
> -	rc =3D security_sb_eat_lsm_opts(raw, &mnt->lsm_opts);
> -	if (rc)
> -		goto out_security_failure;
> -
> -	while ((p =3D strsep(&raw, ",")) !=3D NULL) {
> -		substring_t args[MAX_OPT_ARGS];
> -		unsigned long option;
> -		int token;
> -
> -		if (!*p)
> -			continue;
> -
> -		dfprintk(MOUNT, "NFS:   parsing nfs mount option =
'%s'\n", p);
> -
> -		token =3D match_token(p, nfs_mount_option_tokens, args);
> -		switch (token) {
> -
> -		/*
> -		 * boolean options:  foo/nofoo
> -		 */
> -		case Opt_soft:
> -			mnt->flags |=3D NFS_MOUNT_SOFT;
> -			mnt->flags &=3D ~NFS_MOUNT_SOFTERR;
> -			break;
> -		case Opt_softerr:
> -			mnt->flags |=3D NFS_MOUNT_SOFTERR;
> -			mnt->flags &=3D ~NFS_MOUNT_SOFT;
> -			break;
> -		case Opt_hard:
> -			mnt->flags &=3D =
~(NFS_MOUNT_SOFT|NFS_MOUNT_SOFTERR);
> -			break;
> -		case Opt_posix:
> -			mnt->flags |=3D NFS_MOUNT_POSIX;
> -			break;
> -		case Opt_noposix:
> -			mnt->flags &=3D ~NFS_MOUNT_POSIX;
> -			break;
> -		case Opt_cto:
> -			mnt->flags &=3D ~NFS_MOUNT_NOCTO;
> -			break;
> -		case Opt_nocto:
> -			mnt->flags |=3D NFS_MOUNT_NOCTO;
> -			break;
> -		case Opt_ac:
> -			mnt->flags &=3D ~NFS_MOUNT_NOAC;
> -			break;
> -		case Opt_noac:
> -			mnt->flags |=3D NFS_MOUNT_NOAC;
> -			break;
> -		case Opt_lock:
> -			mnt->flags &=3D ~NFS_MOUNT_NONLM;
> -			mnt->flags &=3D ~(NFS_MOUNT_LOCAL_FLOCK |
> -					NFS_MOUNT_LOCAL_FCNTL);
> -			break;
> -		case Opt_nolock:
> -			mnt->flags |=3D NFS_MOUNT_NONLM;
> -			mnt->flags |=3D (NFS_MOUNT_LOCAL_FLOCK |
> -				       NFS_MOUNT_LOCAL_FCNTL);
> -			break;
> -		case Opt_udp:
> -			mnt->flags &=3D ~NFS_MOUNT_TCP;
> -			mnt->nfs_server.protocol =3D XPRT_TRANSPORT_UDP;
> -			break;
> -		case Opt_tcp:
> -			mnt->flags |=3D NFS_MOUNT_TCP;
> -			mnt->nfs_server.protocol =3D XPRT_TRANSPORT_TCP;
> -			break;
> -		case Opt_rdma:
> -			mnt->flags |=3D NFS_MOUNT_TCP; /* for side =
protocols */
> -			mnt->nfs_server.protocol =3D =
XPRT_TRANSPORT_RDMA;
> -			xprt_load_transport(p);
> -			break;
> -		case Opt_acl:
> -			mnt->flags &=3D ~NFS_MOUNT_NOACL;
> -			break;
> -		case Opt_noacl:
> -			mnt->flags |=3D NFS_MOUNT_NOACL;
> -			break;
> -		case Opt_rdirplus:
> -			mnt->flags &=3D ~NFS_MOUNT_NORDIRPLUS;
> -			break;
> -		case Opt_nordirplus:
> -			mnt->flags |=3D NFS_MOUNT_NORDIRPLUS;
> -			break;
> -		case Opt_sharecache:
> -			mnt->flags &=3D ~NFS_MOUNT_UNSHARED;
> -			break;
> -		case Opt_nosharecache:
> -			mnt->flags |=3D NFS_MOUNT_UNSHARED;
> -			break;
> -		case Opt_resvport:
> -			mnt->flags &=3D ~NFS_MOUNT_NORESVPORT;
> -			break;
> -		case Opt_noresvport:
> -			mnt->flags |=3D NFS_MOUNT_NORESVPORT;
> -			break;
> -		case Opt_fscache:
> -			mnt->options |=3D NFS_OPTION_FSCACHE;
> -			kfree(mnt->fscache_uniq);
> -			mnt->fscache_uniq =3D NULL;
> -			break;
> -		case Opt_nofscache:
> -			mnt->options &=3D ~NFS_OPTION_FSCACHE;
> -			kfree(mnt->fscache_uniq);
> -			mnt->fscache_uniq =3D NULL;
> -			break;
> -		case Opt_migration:
> -			mnt->options |=3D NFS_OPTION_MIGRATION;
> -			break;
> -		case Opt_nomigration:
> -			mnt->options &=3D ~NFS_OPTION_MIGRATION;
> -			break;
> -
> -		/*
> -		 * options that take numeric values
> -		 */
> -		case Opt_port:
> -			if (nfs_get_option_ul(args, &option) ||
> -			    option > USHRT_MAX)
> -				goto out_invalid_value;
> -			mnt->nfs_server.port =3D option;
> -			break;
> -		case Opt_rsize:
> -			if (nfs_get_option_ul(args, &option))
> -				goto out_invalid_value;
> -			mnt->rsize =3D option;
> -			break;
> -		case Opt_wsize:
> -			if (nfs_get_option_ul(args, &option))
> -				goto out_invalid_value;
> -			mnt->wsize =3D option;
> -			break;
> -		case Opt_bsize:
> -			if (nfs_get_option_ul(args, &option))
> -				goto out_invalid_value;
> -			mnt->bsize =3D option;
> -			break;
> -		case Opt_timeo:
> -			if (nfs_get_option_ul_bound(args, &option, 1, =
INT_MAX))
> -				goto out_invalid_value;
> -			mnt->timeo =3D option;
> -			break;
> -		case Opt_retrans:
> -			if (nfs_get_option_ul_bound(args, &option, 0, =
INT_MAX))
> -				goto out_invalid_value;
> -			mnt->retrans =3D option;
> -			break;
> -		case Opt_acregmin:
> -			if (nfs_get_option_ul(args, &option))
> -				goto out_invalid_value;
> -			mnt->acregmin =3D option;
> -			break;
> -		case Opt_acregmax:
> -			if (nfs_get_option_ul(args, &option))
> -				goto out_invalid_value;
> -			mnt->acregmax =3D option;
> -			break;
> -		case Opt_acdirmin:
> -			if (nfs_get_option_ul(args, &option))
> -				goto out_invalid_value;
> -			mnt->acdirmin =3D option;
> -			break;
> -		case Opt_acdirmax:
> -			if (nfs_get_option_ul(args, &option))
> -				goto out_invalid_value;
> -			mnt->acdirmax =3D option;
> -			break;
> -		case Opt_actimeo:
> -			if (nfs_get_option_ul(args, &option))
> -				goto out_invalid_value;
> -			mnt->acregmin =3D mnt->acregmax =3D
> -			mnt->acdirmin =3D mnt->acdirmax =3D option;
> -			break;
> -		case Opt_namelen:
> -			if (nfs_get_option_ul(args, &option))
> -				goto out_invalid_value;
> -			mnt->namlen =3D option;
> -			break;
> -		case Opt_mountport:
> -			if (nfs_get_option_ul(args, &option) ||
> -			    option > USHRT_MAX)
> -				goto out_invalid_value;
> -			mnt->mount_server.port =3D option;
> -			break;
> -		case Opt_mountvers:
> -			if (nfs_get_option_ul(args, &option) ||
> -			    option < NFS_MNT_VERSION ||
> -			    option > NFS_MNT3_VERSION)
> -				goto out_invalid_value;
> -			mnt->mount_server.version =3D option;
> -			break;
> -		case Opt_minorversion:
> -			if (nfs_get_option_ul(args, &option))
> -				goto out_invalid_value;
> -			if (option > NFS4_MAX_MINOR_VERSION)
> -				goto out_invalid_value;
> -			mnt->minorversion =3D option;
> -			break;
> -
> -		/*
> -		 * options that take text values
> -		 */
> -		case Opt_nfsvers:
> -			string =3D match_strdup(args);
> -			if (string =3D=3D NULL)
> -				goto out_nomem;
> -			rc =3D nfs_parse_version_string(string, mnt, =
args);
> -			kfree(string);
> -			if (!rc)
> -				goto out_invalid_value;
> -			break;
> -		case Opt_sec:
> -			string =3D match_strdup(args);
> -			if (string =3D=3D NULL)
> -				goto out_nomem;
> -			rc =3D nfs_parse_security_flavors(string, mnt);
> -			kfree(string);
> -			if (!rc) {
> -				dfprintk(MOUNT, "NFS:   unrecognized "
> -						"security flavor\n");
> -				return 0;
> -			}
> -			break;
> -		case Opt_proto:
> -			string =3D match_strdup(args);
> -			if (string =3D=3D NULL)
> -				goto out_nomem;
> -			token =3D match_token(string,
> -					    nfs_xprt_protocol_tokens, =
args);
> -
> -			protofamily =3D AF_INET;
> -			switch (token) {
> -			case Opt_xprt_udp6:
> -				protofamily =3D AF_INET6;
> -				/* fall through */
> -			case Opt_xprt_udp:
> -				mnt->flags &=3D ~NFS_MOUNT_TCP;
> -				mnt->nfs_server.protocol =3D =
XPRT_TRANSPORT_UDP;
> -				break;
> -			case Opt_xprt_tcp6:
> -				protofamily =3D AF_INET6;
> -				/* fall through */
> -			case Opt_xprt_tcp:
> -				mnt->flags |=3D NFS_MOUNT_TCP;
> -				mnt->nfs_server.protocol =3D =
XPRT_TRANSPORT_TCP;
> -				break;
> -			case Opt_xprt_rdma6:
> -				protofamily =3D AF_INET6;
> -				/* fall through */
> -			case Opt_xprt_rdma:
> -				/* vector side protocols to TCP */
> -				mnt->flags |=3D NFS_MOUNT_TCP;
> -				mnt->nfs_server.protocol =3D =
XPRT_TRANSPORT_RDMA;
> -				xprt_load_transport(string);
> -				break;
> -			default:
> -				dfprintk(MOUNT, "NFS:   unrecognized "
> -						"transport protocol\n");
> -				kfree(string);
> -				return 0;
> -			}
> -			kfree(string);
> -			break;
> -		case Opt_mountproto:
> -			string =3D match_strdup(args);
> -			if (string =3D=3D NULL)
> -				goto out_nomem;
> -			token =3D match_token(string,
> -					    nfs_xprt_protocol_tokens, =
args);
> -			kfree(string);
> -
> -			mountfamily =3D AF_INET;
> -			switch (token) {
> -			case Opt_xprt_udp6:
> -				mountfamily =3D AF_INET6;
> -				/* fall through */
> -			case Opt_xprt_udp:
> -				mnt->mount_server.protocol =3D =
XPRT_TRANSPORT_UDP;
> -				break;
> -			case Opt_xprt_tcp6:
> -				mountfamily =3D AF_INET6;
> -				/* fall through */
> -			case Opt_xprt_tcp:
> -				mnt->mount_server.protocol =3D =
XPRT_TRANSPORT_TCP;
> -				break;
> -			case Opt_xprt_rdma: /* not used for side =
protocols */
> -			default:
> -				dfprintk(MOUNT, "NFS:   unrecognized "
> -						"transport protocol\n");
> -				return 0;
> -			}
> -			break;
> -		case Opt_addr:
> -			string =3D match_strdup(args);
> -			if (string =3D=3D NULL)
> -				goto out_nomem;
> -			mnt->nfs_server.addrlen =3D
> -				rpc_pton(mnt->net, string, =
strlen(string),
> -					(struct sockaddr *)
> -					&mnt->nfs_server.address,
> -					=
sizeof(mnt->nfs_server.address));
> -			kfree(string);
> -			if (mnt->nfs_server.addrlen =3D=3D 0)
> -				goto out_invalid_address;
> -			break;
> -		case Opt_clientaddr:
> -			if (nfs_get_option_str(args, =
&mnt->client_address))
> -				goto out_nomem;
> -			break;
> -		case Opt_mounthost:
> -			if (nfs_get_option_str(args,
> -					       =
&mnt->mount_server.hostname))
> -				goto out_nomem;
> -			break;
> -		case Opt_mountaddr:
> -			string =3D match_strdup(args);
> -			if (string =3D=3D NULL)
> -				goto out_nomem;
> -			mnt->mount_server.addrlen =3D
> -				rpc_pton(mnt->net, string, =
strlen(string),
> -					(struct sockaddr *)
> -					&mnt->mount_server.address,
> -					=
sizeof(mnt->mount_server.address));
> -			kfree(string);
> -			if (mnt->mount_server.addrlen =3D=3D 0)
> -				goto out_invalid_address;
> -			break;
> -		case Opt_nconnect:
> -			if (nfs_get_option_ul_bound(args, &option, 1, =
NFS_MAX_CONNECTIONS))
> -				goto out_invalid_value;
> -			mnt->nfs_server.nconnect =3D option;
> -			break;
> -		case Opt_lookupcache:
> -			string =3D match_strdup(args);
> -			if (string =3D=3D NULL)
> -				goto out_nomem;
> -			token =3D match_token(string,
> -					nfs_lookupcache_tokens, args);
> -			kfree(string);
> -			switch (token) {
> -				case Opt_lookupcache_all:
> -					mnt->flags &=3D =
~(NFS_MOUNT_LOOKUP_CACHE_NONEG|NFS_MOUNT_LOOKUP_CACHE_NONE);
> -					break;
> -				case Opt_lookupcache_positive:
> -					mnt->flags &=3D =
~NFS_MOUNT_LOOKUP_CACHE_NONE;
> -					mnt->flags |=3D =
NFS_MOUNT_LOOKUP_CACHE_NONEG;
> -					break;
> -				case Opt_lookupcache_none:
> -					mnt->flags |=3D =
NFS_MOUNT_LOOKUP_CACHE_NONEG|NFS_MOUNT_LOOKUP_CACHE_NONE;
> -					break;
> -				default:
> -					dfprintk(MOUNT, "NFS:   invalid =
"
> -							"lookupcache =
argument\n");
> -					return 0;
> -			};
> -			break;
> -		case Opt_fscache_uniq:
> -			if (nfs_get_option_str(args, =
&mnt->fscache_uniq))
> -				goto out_nomem;
> -			mnt->options |=3D NFS_OPTION_FSCACHE;
> -			break;
> -		case Opt_local_lock:
> -			string =3D match_strdup(args);
> -			if (string =3D=3D NULL)
> -				goto out_nomem;
> -			token =3D match_token(string, =
nfs_local_lock_tokens,
> -					args);
> -			kfree(string);
> -			switch (token) {
> -			case Opt_local_lock_all:
> -				mnt->flags |=3D (NFS_MOUNT_LOCAL_FLOCK |
> -					       NFS_MOUNT_LOCAL_FCNTL);
> -				break;
> -			case Opt_local_lock_flock:
> -				mnt->flags |=3D NFS_MOUNT_LOCAL_FLOCK;
> -				break;
> -			case Opt_local_lock_posix:
> -				mnt->flags |=3D NFS_MOUNT_LOCAL_FCNTL;
> -				break;
> -			case Opt_local_lock_none:
> -				mnt->flags &=3D ~(NFS_MOUNT_LOCAL_FLOCK =
|
> -						NFS_MOUNT_LOCAL_FCNTL);
> -				break;
> -			default:
> -				dfprintk(MOUNT, "NFS:	invalid	"
> -						"local_lock =
argument\n");
> -				return 0;
> -			};
> -			break;
> -
> -		/*
> -		 * Special options
> -		 */
> -		case Opt_sloppy:
> -			sloppy =3D 1;
> -			dfprintk(MOUNT, "NFS:   relaxing parsing =
rules\n");
> -			break;
> -		case Opt_userspace:
> -		case Opt_deprecated:
> -			dfprintk(MOUNT, "NFS:   ignoring mount option "
> -					"'%s'\n", p);
> -			break;
> -
> -		default:
> -			invalid_option =3D 1;
> -			dfprintk(MOUNT, "NFS:   unrecognized mount =
option "
> -					"'%s'\n", p);
> -		}
> -	}
> -
> -	if (!sloppy && invalid_option)
> -		return 0;
> -
> -	if (mnt->minorversion && mnt->version !=3D 4)
> -		goto out_minorversion_mismatch;
> -
> -	if (mnt->options & NFS_OPTION_MIGRATION &&
> -	    (mnt->version !=3D 4 || mnt->minorversion !=3D 0))
> -		goto out_migration_misuse;
> -
> -	/*
> -	 * verify that any proto=3D/mountproto=3D options match the =
address
> -	 * families in the addr=3D/mountaddr=3D options.
> -	 */
> -	if (protofamily !=3D AF_UNSPEC &&
> -	    protofamily !=3D mnt->nfs_server.address.ss_family)
> -		goto out_proto_mismatch;
> -
> -	if (mountfamily !=3D AF_UNSPEC) {
> -		if (mnt->mount_server.addrlen) {
> -			if (mountfamily !=3D =
mnt->mount_server.address.ss_family)
> -				goto out_mountproto_mismatch;
> -		} else {
> -			if (mountfamily !=3D =
mnt->nfs_server.address.ss_family)
> -				goto out_mountproto_mismatch;
> -		}
> -	}
> -
> -	return 1;
> -
> -out_mountproto_mismatch:
> -	printk(KERN_INFO "NFS: mount server address does not match =
mountproto=3D "
> -			 "option\n");
> -	return 0;
> -out_proto_mismatch:
> -	printk(KERN_INFO "NFS: server address does not match proto=3D =
option\n");
> -	return 0;
> -out_invalid_address:
> -	printk(KERN_INFO "NFS: bad IP address specified: %s\n", p);
> -	return 0;
> -out_invalid_value:
> -	printk(KERN_INFO "NFS: bad mount option value specified: %s\n", =
p);
> -	return 0;
> -out_minorversion_mismatch:
> -	printk(KERN_INFO "NFS: mount option vers=3D%u does not support "
> -			 "minorversion=3D%u\n", mnt->version, =
mnt->minorversion);
> -	return 0;
> -out_migration_misuse:
> -	printk(KERN_INFO
> -		"NFS: 'migration' not supported for this NFS =
version\n");
> -	return 0;
> -out_nomem:
> -	printk(KERN_INFO "NFS: not enough memory to parse option\n");
> -	return 0;
> -out_security_failure:
> -	printk(KERN_INFO "NFS: security options invalid: %d\n", rc);
> -	return 0;
> -}
> -
> /*
>  * Ensure that a specified authtype in args->auth_info is supported by
>  * the server. Returns 0 and sets args->selected_flavor if it's ok, =
and
> @@ -1908,327 +925,6 @@ struct dentry *nfs_try_mount(int flags, const =
char *dev_name,
> }
> EXPORT_SYMBOL_GPL(nfs_try_mount);
>=20
> -/*
> - * Split "dev_name" into "hostname:export_path".
> - *
> - * The leftmost colon demarks the split between the server's hostname
> - * and the export path.  If the hostname starts with a left square
> - * bracket, then it may contain colons.
> - *
> - * Note: caller frees hostname and export path, even on error.
> - */
> -static int nfs_parse_devname(const char *dev_name,
> -			     char **hostname, size_t maxnamlen,
> -			     char **export_path, size_t maxpathlen)
> -{
> -	size_t len;
> -	char *end;
> -
> -	if (unlikely(!dev_name || !*dev_name)) {
> -		dfprintk(MOUNT, "NFS: device name not specified\n");
> -		return -EINVAL;
> -	}
> -
> -	/* Is the host name protected with square brakcets? */
> -	if (*dev_name =3D=3D '[') {
> -		end =3D strchr(++dev_name, ']');
> -		if (end =3D=3D NULL || end[1] !=3D ':')
> -			goto out_bad_devname;
> -
> -		len =3D end - dev_name;
> -		end++;
> -	} else {
> -		char *comma;
> -
> -		end =3D strchr(dev_name, ':');
> -		if (end =3D=3D NULL)
> -			goto out_bad_devname;
> -		len =3D end - dev_name;
> -
> -		/* kill possible hostname list: not supported */
> -		comma =3D strchr(dev_name, ',');
> -		if (comma !=3D NULL && comma < end)
> -			len =3D comma - dev_name;
> -	}
> -
> -	if (len > maxnamlen)
> -		goto out_hostname;
> -
> -	/* N.B. caller will free nfs_server.hostname in all cases */
> -	*hostname =3D kstrndup(dev_name, len, GFP_KERNEL);
> -	if (*hostname =3D=3D NULL)
> -		goto out_nomem;
> -	len =3D strlen(++end);
> -	if (len > maxpathlen)
> -		goto out_path;
> -	*export_path =3D kstrndup(end, len, GFP_KERNEL);
> -	if (!*export_path)
> -		goto out_nomem;
> -
> -	dfprintk(MOUNT, "NFS: MNTPATH: '%s'\n", *export_path);
> -	return 0;
> -
> -out_bad_devname:
> -	dfprintk(MOUNT, "NFS: device name not in host:path format\n");
> -	return -EINVAL;
> -
> -out_nomem:
> -	dfprintk(MOUNT, "NFS: not enough memory to parse device =
name\n");
> -	return -ENOMEM;
> -
> -out_hostname:
> -	dfprintk(MOUNT, "NFS: server hostname too long\n");
> -	return -ENAMETOOLONG;
> -
> -out_path:
> -	dfprintk(MOUNT, "NFS: export pathname too long\n");
> -	return -ENAMETOOLONG;
> -}
> -
> -/*
> - * Validate the NFS2/NFS3 mount data
> - * - fills in the mount root filehandle
> - *
> - * For option strings, user space handles the following behaviors:
> - *
> - * + DNS: mapping server host name to IP address ("addr=3D" option)
> - *
> - * + failure mode: how to behave if a mount request can't be handled
> - *   immediately ("fg/bg" option)
> - *
> - * + retry: how often to retry a mount request ("retry=3D" option)
> - *
> - * + breaking back: trying proto=3Dudp after proto=3Dtcp, v2 after =
v3,
> - *   mountproto=3Dtcp after mountproto=3Dudp, and so on
> - */
> -static int nfs23_validate_mount_data(void *options,
> -				     struct nfs_parsed_mount_data *args,
> -				     struct nfs_fh *mntfh,
> -				     const char *dev_name)
> -{
> -	struct nfs_mount_data *data =3D (struct nfs_mount_data =
*)options;
> -	struct sockaddr *sap =3D (struct sockaddr =
*)&args->nfs_server.address;
> -	int extra_flags =3D NFS_MOUNT_LEGACY_INTERFACE;
> -
> -	if (data =3D=3D NULL)
> -		goto out_no_data;
> -
> -	args->version =3D NFS_DEFAULT_VERSION;
> -	switch (data->version) {
> -	case 1:
> -		data->namlen =3D 0; /* fall through */
> -	case 2:
> -		data->bsize =3D 0; /* fall through */
> -	case 3:
> -		if (data->flags & NFS_MOUNT_VER3)
> -			goto out_no_v3;
> -		data->root.size =3D NFS2_FHSIZE;
> -		memcpy(data->root.data, data->old_root.data, =
NFS2_FHSIZE);
> -		/* Turn off security negotiation */
> -		extra_flags |=3D NFS_MOUNT_SECFLAVOUR;
> -		/* fall through */
> -	case 4:
> -		if (data->flags & NFS_MOUNT_SECFLAVOUR)
> -			goto out_no_sec;
> -		/* fall through */
> -	case 5:
> -		memset(data->context, 0, sizeof(data->context));
> -		/* fall through */
> -	case 6:
> -		if (data->flags & NFS_MOUNT_VER3) {
> -			if (data->root.size > NFS3_FHSIZE || =
data->root.size =3D=3D 0)
> -				goto out_invalid_fh;
> -			mntfh->size =3D data->root.size;
> -			args->version =3D 3;
> -		} else {
> -			mntfh->size =3D NFS2_FHSIZE;
> -			args->version =3D 2;
> -		}
> -
> -
> -		memcpy(mntfh->data, data->root.data, mntfh->size);
> -		if (mntfh->size < sizeof(mntfh->data))
> -			memset(mntfh->data + mntfh->size, 0,
> -			       sizeof(mntfh->data) - mntfh->size);
> -
> -		/*
> -		 * Translate to nfs_parsed_mount_data, which =
nfs_fill_super
> -		 * can deal with.
> -		 */
> -		args->flags		=3D data->flags & =
NFS_MOUNT_FLAGMASK;
> -		args->flags		|=3D extra_flags;
> -		args->rsize		=3D data->rsize;
> -		args->wsize		=3D data->wsize;
> -		args->timeo		=3D data->timeo;
> -		args->retrans		=3D data->retrans;
> -		args->acregmin		=3D data->acregmin;
> -		args->acregmax		=3D data->acregmax;
> -		args->acdirmin		=3D data->acdirmin;
> -		args->acdirmax		=3D data->acdirmax;
> -		args->need_mount	=3D false;
> -
> -		memcpy(sap, &data->addr, sizeof(data->addr));
> -		args->nfs_server.addrlen =3D sizeof(data->addr);
> -		args->nfs_server.port =3D ntohs(data->addr.sin_port);
> -		if (sap->sa_family !=3D AF_INET ||
> -		    !nfs_verify_server_address(sap))
> -			goto out_no_address;
> -
> -		if (!(data->flags & NFS_MOUNT_TCP))
> -			args->nfs_server.protocol =3D =
XPRT_TRANSPORT_UDP;
> -		/* N.B. caller will free nfs_server.hostname in all =
cases */
> -		args->nfs_server.hostname =3D kstrdup(data->hostname, =
GFP_KERNEL);
> -		args->namlen		=3D data->namlen;
> -		args->bsize		=3D data->bsize;
> -
> -		if (data->flags & NFS_MOUNT_SECFLAVOUR)
> -			args->selected_flavor =3D data->pseudoflavor;
> -		else
> -			args->selected_flavor =3D RPC_AUTH_UNIX;
> -		if (!args->nfs_server.hostname)
> -			goto out_nomem;
> -
> -		if (!(data->flags & NFS_MOUNT_NONLM))
> -			args->flags &=3D ~(NFS_MOUNT_LOCAL_FLOCK|
> -					 NFS_MOUNT_LOCAL_FCNTL);
> -		else
> -			args->flags |=3D (NFS_MOUNT_LOCAL_FLOCK|
> -					NFS_MOUNT_LOCAL_FCNTL);
> -		/*
> -		 * The legacy version 6 binary mount data from userspace =
has a
> -		 * field used only to transport selinux information into =
the
> -		 * the kernel.  To continue to support that =
functionality we
> -		 * have a touch of selinux knowledge here in the NFS =
code. The
> -		 * userspace code converted context=3Dblah to just blah =
so we are
> -		 * converting back to the full string selinux =
understands.
> -		 */
> -		if (data->context[0]){
> -#ifdef CONFIG_SECURITY_SELINUX
> -			int rc;
> -			data->context[NFS_MAX_CONTEXT_LEN] =3D '\0';
> -			rc =3D security_add_mnt_opt("context", =
data->context,
> -					strlen(data->context), =
&args->lsm_opts);
> -			if (rc)
> -				return rc;
> -#else
> -			return -EINVAL;
> -#endif
> -		}
> -
> -		break;
> -	default:
> -		return NFS_TEXT_DATA;
> -	}
> -
> -	return 0;
> -
> -out_no_data:
> -	dfprintk(MOUNT, "NFS: mount program didn't pass any mount =
data\n");
> -	return -EINVAL;
> -
> -out_no_v3:
> -	dfprintk(MOUNT, "NFS: nfs_mount_data version %d does not support =
v3\n",
> -		 data->version);
> -	return -EINVAL;
> -
> -out_no_sec:
> -	dfprintk(MOUNT, "NFS: nfs_mount_data version supports only =
AUTH_SYS\n");
> -	return -EINVAL;
> -
> -out_nomem:
> -	dfprintk(MOUNT, "NFS: not enough memory to handle mount =
options\n");
> -	return -ENOMEM;
> -
> -out_no_address:
> -	dfprintk(MOUNT, "NFS: mount program didn't pass remote =
address\n");
> -	return -EINVAL;
> -
> -out_invalid_fh:
> -	dfprintk(MOUNT, "NFS: invalid root filehandle\n");
> -	return -EINVAL;
> -}
> -
> -#if IS_ENABLED(CONFIG_NFS_V4)
> -static int nfs_validate_mount_data(struct file_system_type *fs_type,
> -				   void *options,
> -				   struct nfs_parsed_mount_data *args,
> -				   struct nfs_fh *mntfh,
> -				   const char *dev_name)
> -{
> -	if (fs_type =3D=3D &nfs_fs_type)
> -		return nfs23_validate_mount_data(options, args, mntfh, =
dev_name);
> -	return nfs4_validate_mount_data(options, args, dev_name);
> -}
> -#else
> -static int nfs_validate_mount_data(struct file_system_type *fs_type,
> -				   void *options,
> -				   struct nfs_parsed_mount_data *args,
> -				   struct nfs_fh *mntfh,
> -				   const char *dev_name)
> -{
> -	return nfs23_validate_mount_data(options, args, mntfh, =
dev_name);
> -}
> -#endif
> -
> -static int nfs_validate_text_mount_data(void *options,
> -					struct nfs_parsed_mount_data =
*args,
> -					const char *dev_name)
> -{
> -	int port =3D 0;
> -	int max_namelen =3D PAGE_SIZE;
> -	int max_pathlen =3D NFS_MAXPATHLEN;
> -	struct sockaddr *sap =3D (struct sockaddr =
*)&args->nfs_server.address;
> -
> -	if (nfs_parse_mount_options((char *)options, args) =3D=3D 0)
> -		return -EINVAL;
> -
> -	if (!nfs_verify_server_address(sap))
> -		goto out_no_address;
> -
> -	if (args->version =3D=3D 4) {
> -#if IS_ENABLED(CONFIG_NFS_V4)
> -		if (args->nfs_server.protocol =3D=3D =
XPRT_TRANSPORT_RDMA)
> -			port =3D NFS_RDMA_PORT;
> -		else
> -			port =3D NFS_PORT;
> -		max_namelen =3D NFS4_MAXNAMLEN;
> -		max_pathlen =3D NFS4_MAXPATHLEN;
> -		nfs_validate_transport_protocol(args);
> -		if (args->nfs_server.protocol =3D=3D XPRT_TRANSPORT_UDP)
> -			goto out_invalid_transport_udp;
> -		nfs4_validate_mount_flags(args);
> -#else
> -		goto out_v4_not_compiled;
> -#endif /* CONFIG_NFS_V4 */
> -	} else {
> -		nfs_set_mount_transport_protocol(args);
> -		if (args->nfs_server.protocol =3D=3D =
XPRT_TRANSPORT_RDMA)
> -			port =3D NFS_RDMA_PORT;
> -	}
> -
> -	nfs_set_port(sap, &args->nfs_server.port, port);
> -
> -	return nfs_parse_devname(dev_name,
> -				   &args->nfs_server.hostname,
> -				   max_namelen,
> -				   &args->nfs_server.export_path,
> -				   max_pathlen);
> -
> -#if !IS_ENABLED(CONFIG_NFS_V4)
> -out_v4_not_compiled:
> -	dfprintk(MOUNT, "NFS: NFSv4 is not compiled into kernel\n");
> -	return -EPROTONOSUPPORT;
> -#else
> -out_invalid_transport_udp:
> -	dfprintk(MOUNT, "NFSv4: Unsupported transport protocol udp\n");
> -	return -EINVAL;
> -#endif /* !CONFIG_NFS_V4 */
> -
> -out_no_address:
> -	dfprintk(MOUNT, "NFS: mount program didn't pass remote =
address\n");
> -	return -EINVAL;
> -}
> -
> #define NFS_REMOUNT_CMP_FLAGMASK ~(NFS_MOUNT_INTR \
> 		| NFS_MOUNT_SECURE \
> 		| NFS_MOUNT_TCP \
> @@ -2719,113 +1415,6 @@ nfs_prepared_mount(struct file_system_type =
*fs_type, int flags,
>=20
> #if IS_ENABLED(CONFIG_NFS_V4)
>=20
> -static void nfs4_validate_mount_flags(struct nfs_parsed_mount_data =
*args)
> -{
> -	args->flags &=3D =
~(NFS_MOUNT_NONLM|NFS_MOUNT_NOACL|NFS_MOUNT_VER3|
> -			 NFS_MOUNT_LOCAL_FLOCK|NFS_MOUNT_LOCAL_FCNTL);
> -}
> -
> -/*
> - * Validate NFSv4 mount options
> - */
> -static int nfs4_validate_mount_data(void *options,
> -				    struct nfs_parsed_mount_data *args,
> -				    const char *dev_name)
> -{
> -	struct sockaddr *sap =3D (struct sockaddr =
*)&args->nfs_server.address;
> -	struct nfs4_mount_data *data =3D (struct nfs4_mount_data =
*)options;
> -	char *c;
> -
> -	if (data =3D=3D NULL)
> -		goto out_no_data;
> -
> -	args->version =3D 4;
> -
> -	switch (data->version) {
> -	case 1:
> -		if (data->host_addrlen > =
sizeof(args->nfs_server.address))
> -			goto out_no_address;
> -		if (data->host_addrlen =3D=3D 0)
> -			goto out_no_address;
> -		args->nfs_server.addrlen =3D data->host_addrlen;
> -		if (copy_from_user(sap, data->host_addr, =
data->host_addrlen))
> -			return -EFAULT;
> -		if (!nfs_verify_server_address(sap))
> -			goto out_no_address;
> -		args->nfs_server.port =3D ntohs(((struct sockaddr_in =
*)sap)->sin_port);
> -
> -		if (data->auth_flavourlen) {
> -			rpc_authflavor_t pseudoflavor;
> -			if (data->auth_flavourlen > 1)
> -				goto out_inval_auth;
> -			if (copy_from_user(&pseudoflavor,
> -					   data->auth_flavours,
> -					   sizeof(pseudoflavor)))
> -				return -EFAULT;
> -			args->selected_flavor =3D pseudoflavor;
> -		} else
> -			args->selected_flavor =3D RPC_AUTH_UNIX;
> -
> -		c =3D strndup_user(data->hostname.data, NFS4_MAXNAMLEN);
> -		if (IS_ERR(c))
> -			return PTR_ERR(c);
> -		args->nfs_server.hostname =3D c;
> -
> -		c =3D strndup_user(data->mnt_path.data, =
NFS4_MAXPATHLEN);
> -		if (IS_ERR(c))
> -			return PTR_ERR(c);
> -		args->nfs_server.export_path =3D c;
> -		dfprintk(MOUNT, "NFS: MNTPATH: '%s'\n", c);
> -
> -		c =3D strndup_user(data->client_addr.data, 16);
> -		if (IS_ERR(c))
> -			return PTR_ERR(c);
> -		args->client_address =3D c;
> -
> -		/*
> -		 * Translate to nfs_parsed_mount_data, which =
nfs4_fill_super
> -		 * can deal with.
> -		 */
> -
> -		args->flags	=3D data->flags & NFS4_MOUNT_FLAGMASK;
> -		args->rsize	=3D data->rsize;
> -		args->wsize	=3D data->wsize;
> -		args->timeo	=3D data->timeo;
> -		args->retrans	=3D data->retrans;
> -		args->acregmin	=3D data->acregmin;
> -		args->acregmax	=3D data->acregmax;
> -		args->acdirmin	=3D data->acdirmin;
> -		args->acdirmax	=3D data->acdirmax;
> -		args->nfs_server.protocol =3D data->proto;
> -		nfs_validate_transport_protocol(args);
> -		if (args->nfs_server.protocol =3D=3D XPRT_TRANSPORT_UDP)
> -			goto out_invalid_transport_udp;
> -
> -		break;
> -	default:
> -		return NFS_TEXT_DATA;
> -	}
> -
> -	return 0;
> -
> -out_no_data:
> -	dfprintk(MOUNT, "NFS4: mount program didn't pass any mount =
data\n");
> -	return -EINVAL;
> -
> -out_inval_auth:
> -	dfprintk(MOUNT, "NFS4: Invalid number of RPC auth flavours =
%d\n",
> -		 data->auth_flavourlen);
> -	return -EINVAL;
> -
> -out_no_address:
> -	dfprintk(MOUNT, "NFS4: mount program didn't pass remote =
address\n");
> -	return -EINVAL;
> -
> -out_invalid_transport_udp:
> -	dfprintk(MOUNT, "NFSv4: Unsupported transport protocol udp\n");
> -	return -EINVAL;
> -}
> -
> /*
>  * NFS v4 module parameters need to stay in the
>  * NFS client for backwards compatibility
> --=20
> 2.17.2
>=20

--
Chuck Lever
chucklever@gmail.com



