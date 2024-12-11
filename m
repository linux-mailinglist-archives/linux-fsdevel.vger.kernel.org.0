Return-Path: <linux-fsdevel+bounces-37063-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0589ECF08
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 15:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BEB2188787F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 14:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA5219F116;
	Wed, 11 Dec 2024 14:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTYzdN2F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5573E1494CC
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2024 14:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733928770; cv=none; b=StlkDwczMyqc6I8xILxvgTA7JZoAZ5we5PpkZYdIm+Y4lySlbWaNtacVzMI8c9/qfuNyMhao82REX+0Ypg/pAZrMEByywGZrjBx+4GfVXICccrFn1s3WCzCFJ5Mn9rKilWfzhAHNo0OB4Y3KpOImwyDz5HY3uCHmre4Nwq29jVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733928770; c=relaxed/simple;
	bh=z2oHhf6a6UuAtr3xvIJl7vsSRWhU+Qs9OZHcZCDKCpA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=INlyjAC9AIIdJP+mBaKR1vLBootTNa/8wVNHwa4VhPVEttLkjl2HbDku6eT9mMWpRmFjDtyeOPccNltsR9eoFkZ1h52lhEnZxEL3lue3qdIAIV0UDmzI0ORSSW33pkzcuUkAEPg9j7bbAOy/doDBhnvNtrOrcnMMhh9g57goz6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTYzdN2F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E61C4CED2;
	Wed, 11 Dec 2024 14:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733928769;
	bh=z2oHhf6a6UuAtr3xvIJl7vsSRWhU+Qs9OZHcZCDKCpA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=WTYzdN2F/ZGB+rnebJtuS/e/9dpVi72Sb9p3GATRjSaZPcbG2fM3vNta1mX4VVT00
	 b8tdLZQyQAlFumhaD2VE+oN5QUWuNXpFddxez2lmGmq0WY22XZWwnvEPAS1BxYv7gl
	 Mez+/HXVk8rgqtEuXXYKCyIniogbX4l382XMLn8KMNU2o88VXyFOdhHTb0P7UyzM0W
	 5czEn4XsXsdCSGD1tmFFmUSaR2+WZaOIJ4NKjWqNSHIG8UbrQSP1thsoCbrgthjAfh
	 SIIih/Y7f6P7HXCDYxmXCvR8wXFeYDdn+HLMnLHl8g19Id5OFzlxtJdRUh5BR4B2Ma
	 MmoE7YSzD5Ncw==
Message-ID: <50ea8aea7eff7ec8680564c10c54f6d1e4dee20b.camel@kernel.org>
Subject: Re: [PATCH 5/5] samples: add test-list-all-mounts
From: Jeff Layton <jlayton@kernel.org>
To: Christian Brauner <brauner@kernel.org>, Josef Bacik
 <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org
Date: Wed, 11 Dec 2024 09:52:48 -0500
In-Reply-To: <20241210-work-mount-rbtree-lockless-v1-5-338366b9bbe4@kernel.org>
References: 
	<20241210-work-mount-rbtree-lockless-v1-0-338366b9bbe4@kernel.org>
	 <20241210-work-mount-rbtree-lockless-v1-5-338366b9bbe4@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-12-10 at 21:58 +0100, Christian Brauner wrote:
> Add a sample program illustrating how to list all mounts in all mount
> namespaces.
>=20
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  samples/vfs/.gitignore             |   1 +
>  samples/vfs/Makefile               |   2 +-
>  samples/vfs/test-list-all-mounts.c | 235 +++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 237 insertions(+), 1 deletion(-)
>=20
> diff --git a/samples/vfs/.gitignore b/samples/vfs/.gitignore
> index 79212d91285bca72b0ff85f28aaccd2e803ac092..8694dd17b318768b975ece5c7=
cd450c2cca67318 100644
> --- a/samples/vfs/.gitignore
> +++ b/samples/vfs/.gitignore
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  /test-fsmount
> +/test-list-all-mounts
>  /test-statx
> diff --git a/samples/vfs/Makefile b/samples/vfs/Makefile
> index 6377a678134acf0d682151d751d2f5042dbf5e0a..301be72a52a0e376c7ebe235c=
c2058992919cc78 100644
> --- a/samples/vfs/Makefile
> +++ b/samples/vfs/Makefile
> @@ -1,4 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -userprogs-always-y +=3D test-fsmount test-statx
> +userprogs-always-y +=3D test-fsmount test-statx test-list-all-mounts
>=20
>=20

There will be a minor merge conflict above vs. the new mountinfo
program sitting in your tree.

> =20
>  userccflags +=3D -I usr/include
> diff --git a/samples/vfs/test-list-all-mounts.c b/samples/vfs/test-list-a=
ll-mounts.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..f372d5aea4717fd1ab3d4b3f9=
af79316cd5dd3d3
> --- /dev/null
> +++ b/samples/vfs/test-list-all-mounts.c
> @@ -0,0 +1,235 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +// Copyright (c) 2024 Christian Brauner <brauner@kernel.org>
> +
> +#define _GNU_SOURCE
> +#include <errno.h>
> +#include <limits.h>
> +#include <linux/types.h>
> +#include <stdio.h>
> +#include <sys/ioctl.h>
> +#include <sys/syscall.h>
> +
> +#include "../../tools/testing/selftests/pidfd/pidfd.h"
> +
> +#define die_errno(format, ...)                                          =
   \
> +	do {                                                               \
> +		fprintf(stderr, "%m | %s: %d: %s: " format "\n", __FILE__, \
> +			__LINE__, __func__, ##__VA_ARGS__);                \
> +		exit(EXIT_FAILURE);                                        \
> +	} while (0)
> +
> +/* Get the id for a mount namespace */
> +#define NS_GET_MNTNS_ID _IO(0xb7, 0x5)
> +/* Get next mount namespace. */
> +
> +struct mnt_ns_info {
> +	__u32 size;
> +	__u32 nr_mounts;
> +	__u64 mnt_ns_id;
> +};
> +
> +#define MNT_NS_INFO_SIZE_VER0 16 /* size of first published struct */
> +
> +/* Get information about namespace. */
> +#define NS_MNT_GET_INFO _IOR(0xb7, 10, struct mnt_ns_info)
> +/* Get next namespace. */
> +#define NS_MNT_GET_NEXT _IOR(0xb7, 11, struct mnt_ns_info)
> +/* Get previous namespace. */
> +#define NS_MNT_GET_PREV _IOR(0xb7, 12, struct mnt_ns_info)
> +
> +#define PIDFD_GET_MNT_NAMESPACE _IO(0xFF, 3)
> +
> +#ifndef __NR_listmount
> +#define __NR_listmount 458
> +#endif
> +
> +#ifndef __NR_statmount
> +#define __NR_statmount 457
> +#endif
> +
> +/* @mask bits for statmount(2) */
> +#define STATMOUNT_SB_BASIC		0x00000001U /* Want/got sb_... */
> +#define STATMOUNT_MNT_BASIC		0x00000002U /* Want/got mnt_... */
> +#define STATMOUNT_PROPAGATE_FROM	0x00000004U /* Want/got propagate_from =
*/
> +#define STATMOUNT_MNT_ROOT		0x00000008U /* Want/got mnt_root  */
> +#define STATMOUNT_MNT_POINT		0x00000010U /* Want/got mnt_point */
> +#define STATMOUNT_FS_TYPE		0x00000020U /* Want/got fs_type */
> +#define STATMOUNT_MNT_NS_ID		0x00000040U /* Want/got mnt_ns_id */
> +#define STATMOUNT_MNT_OPTS		0x00000080U /* Want/got mnt_opts */
> +
> +#define STATX_MNT_ID_UNIQUE 0x00004000U /* Want/got extended stx_mount_i=
d */
> +
> +struct statmount {
> +	__u32 size;
> +	__u32 mnt_opts;
> +	__u64 mask;
> +	__u32 sb_dev_major;
> +	__u32 sb_dev_minor;
> +	__u64 sb_magic;
> +	__u32 sb_flags;
> +	__u32 fs_type;
> +	__u64 mnt_id;
> +	__u64 mnt_parent_id;
> +	__u32 mnt_id_old;
> +	__u32 mnt_parent_id_old;
> +	__u64 mnt_attr;
> +	__u64 mnt_propagation;
> +	__u64 mnt_peer_group;
> +	__u64 mnt_master;
> +	__u64 propagate_from;
> +	__u32 mnt_root;
> +	__u32 mnt_point;
> +	__u64 mnt_ns_id;
> +	__u64 __spare2[49];
> +	char str[];
> +};
> +
> +struct mnt_id_req {
> +	__u32 size;
> +	__u32 spare;
> +	__u64 mnt_id;
> +	__u64 param;
> +	__u64 mnt_ns_id;
> +};
> +
> +#define MNT_ID_REQ_SIZE_VER1 32 /* sizeof second published struct */
> +
> +#define LSMT_ROOT 0xffffffffffffffff /* root mount */
> +
> +static int __statmount(__u64 mnt_id, __u64 mnt_ns_id, __u64 mask,
> +		       struct statmount *stmnt, size_t bufsize,
> +		       unsigned int flags)
> +{
> +	struct mnt_id_req req =3D {
> +		.size		=3D MNT_ID_REQ_SIZE_VER1,
> +		.mnt_id		=3D mnt_id,
> +		.param		=3D mask,
> +		.mnt_ns_id	=3D mnt_ns_id,
> +	};
> +
> +	return syscall(__NR_statmount, &req, stmnt, bufsize, flags);
> +}
> +
> +static struct statmount *sys_statmount(__u64 mnt_id, __u64 mnt_ns_id,
> +				       __u64 mask, unsigned int flags)
> +{
> +	size_t bufsize =3D 1 << 15;
> +	struct statmount *stmnt =3D NULL, *tmp =3D NULL;
> +	int ret;
> +
> +	for (;;) {
> +		tmp =3D realloc(stmnt, bufsize);
> +		if (!tmp)
> +			goto out;
> +
> +		stmnt =3D tmp;
> +		ret =3D __statmount(mnt_id, mnt_ns_id, mask, stmnt, bufsize, flags);
> +		if (!ret)
> +			return stmnt;
> +
> +		if (errno !=3D EOVERFLOW)
> +			goto out;
> +
> +		bufsize <<=3D 1;
> +		if (bufsize >=3D UINT_MAX / 2)
> +			goto out;
> +	}
> +
> +out:
> +	free(stmnt);
> +	return NULL;
> +}
> +
> +static ssize_t sys_listmount(__u64 mnt_id, __u64 last_mnt_id, __u64 mnt_=
ns_id,
> +			     __u64 list[], size_t num, unsigned int flags)
> +{
> +	struct mnt_id_req req =3D {
> +		.size		=3D MNT_ID_REQ_SIZE_VER1,
> +		.mnt_id		=3D mnt_id,
> +		.param		=3D last_mnt_id,
> +		.mnt_ns_id	=3D mnt_ns_id,
> +	};
> +
> +	return syscall(__NR_listmount, &req, list, num, flags);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +#define LISTMNT_BUFFER 10
> +	__u64 list[LISTMNT_BUFFER], last_mnt_id =3D 0;
> +	int ret, pidfd, fd_mntns;
> +	struct mnt_ns_info info =3D {};
> +
> +	pidfd =3D sys_pidfd_open(getpid(), 0);
> +	if (pidfd < 0)
> +		die_errno("pidfd_open failed");
> +
> +	fd_mntns =3D ioctl(pidfd, PIDFD_GET_MNT_NAMESPACE, 0);
> +	if (fd_mntns < 0)
> +		die_errno("ioctl(PIDFD_GET_MNT_NAMESPACE) failed");
> +
> +	ret =3D ioctl(fd_mntns, NS_MNT_GET_INFO, &info);
> +	if (ret < 0)
> +		die_errno("ioctl(NS_GET_MNTNS_ID) failed");
> +
> +	printf("Listing %u mounts for mount namespace %llu\n",
> +	       info.nr_mounts, info.mnt_ns_id);
> +	for (;;) {
> +		ssize_t nr_mounts;
> +next:
> +		nr_mounts =3D sys_listmount(LSMT_ROOT, last_mnt_id,
> +					  info.mnt_ns_id, list, LISTMNT_BUFFER,
> +					  0);
> +		if (nr_mounts <=3D 0) {
> +			int fd_mntns_next;
> +
> +			printf("Finished listing %u mounts for mount namespace %llu\n\n",
> +			       info.nr_mounts, info.mnt_ns_id);
> +			fd_mntns_next =3D ioctl(fd_mntns, NS_MNT_GET_NEXT, &info);
> +			if (fd_mntns_next < 0) {
> +				if (errno =3D=3D ENOENT) {
> +					printf("Finished listing all mount namespaces\n");
> +					exit(0);
> +				}
> +				die_errno("ioctl(NS_MNT_GET_NEXT) failed");
> +			}
> +			close(fd_mntns);
> +			fd_mntns =3D fd_mntns_next;
> +			last_mnt_id =3D 0;
> +			printf("Listing %u mounts for mount namespace %llu\n",
> +			       info.nr_mounts, info.mnt_ns_id);
> +			goto next;
> +		}
> +
> +		for (size_t cur =3D 0; cur < nr_mounts; cur++) {
> +			struct statmount *stmnt;
> +
> +			last_mnt_id =3D list[cur];
> +
> +			stmnt =3D sys_statmount(last_mnt_id, info.mnt_ns_id,
> +					      STATMOUNT_SB_BASIC |
> +					      STATMOUNT_MNT_BASIC |
> +					      STATMOUNT_MNT_ROOT |
> +					      STATMOUNT_MNT_POINT |
> +					      STATMOUNT_MNT_NS_ID |
> +					      STATMOUNT_MNT_OPTS |
> +					      STATMOUNT_FS_TYPE, 0);
> +			if (!stmnt) {
> +				printf("Failed to statmount(%llu) in mount namespace(%llu)\n",
> +				       last_mnt_id, info.mnt_ns_id);
> +				continue;
> +			}
> +
> +			printf("mnt_id:\t\t%llu\nmnt_parent_id:\t%llu\nfs_type:\t%s\nmnt_root=
:\t%s\nmnt_point:\t%s\nmnt_opts:\t%s\n\n",
> +			       stmnt->mnt_id,
> +			       stmnt->mnt_parent_id,
> +			       stmnt->str + stmnt->fs_type,
> +			       stmnt->str + stmnt->mnt_root,
> +			       stmnt->str + stmnt->mnt_point,
> +			       stmnt->str + stmnt->mnt_opts);
> +			free(stmnt);
> +		}
> +	}
> +
> +	exit(0);
> +}
>=20

Note that this replicates a lot of the functionality of the "mountinfo"
program. You could also extend that program with a different output
format instead of adding a new one.
--=20
Jeff Layton <jlayton@kernel.org>

