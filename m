Return-Path: <linux-fsdevel+bounces-1169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B707D6DED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 16:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 765AAB21010
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 14:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1495228E0C;
	Wed, 25 Oct 2023 14:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ida6CPj0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F27028E01
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 14:02:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3478184
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 07:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698242531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=x1DYN7Za1uyLzcDLrfQjEDekO6UImwLBhsScIzlPerc=;
	b=ida6CPj06NiVQ4YlzG1C6SpEje8t/0LYfNy5xNVXOPIWgpxDXMZhteX3CD/Tp4EowHZoU+
	L9nylfAoPFJseMx+ixJ/k/uNhwat+7OM2g8HodeganaIj8aQGCsivHU60btdQAogN+q1+4
	hOXh7lwvBmTNHYpEPB0xfgu3A3SbckU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-u5Dku-75Njmy8WjTo1N7Mw-1; Wed, 25 Oct 2023 10:02:10 -0400
X-MC-Unique: u5Dku-75Njmy8WjTo1N7Mw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9c797b497e8so308363766b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 07:02:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698242528; x=1698847328;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x1DYN7Za1uyLzcDLrfQjEDekO6UImwLBhsScIzlPerc=;
        b=F+vyEa1x5rTpGMV45fcriAqgs29ZLqhxoXOFY/oupWxSv3Rfs1yiO+G4/VSP4/n/Sx
         IrbGZ1BZOKRgseFf6BiRQayVCHMu/sBPAorYddMLN+nc3Pj+sv2HdThTh/tZ7ydrpv2Y
         QLIurTueeUWPJcllqktw2/pYD16HMNLTmlAjyvfJcti3HPXYJ52ZSt8nD/u9NiICHlH0
         xM6D3gT7iw2LDo3uTPcnfcDMze9Pv0SkIB29+2nD11zG4oub3g8SeFsk4/6KQlNh5OGA
         8yb0hLIq6IDQu+NFsjd2p/tWgvTdzrsV+Sl0Xo4sBx9vLfx4F4jBMu23TbRh+83CEdzX
         i81Q==
X-Gm-Message-State: AOJu0YxqD1OLXRTcXUBN/YKAsXX9GRUr36rL3swjIykaVMhjuSvxENGv
	PT0wk+2yJjgt4m2HissLlQx1EDjj4BdwKiKnan47TqmlNYFPl60flKi9F8Cm5XV8ZD/MR0CszYx
	O8uu6lLFB61sbEwExwxM+nLH+R9ChykiifOtBNF2CfLU8K3y+eZKrIkspCrnwPoPXMeSfLPIaNt
	eg9VM4nGZq5Q==
X-Received: by 2002:a17:906:c115:b0:9be:839a:3372 with SMTP id do21-20020a170906c11500b009be839a3372mr11884371ejc.59.1698242527958;
        Wed, 25 Oct 2023 07:02:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWrkTOkCAZfzN3xYcXcvz5ivnltGcFS7nQ3UQVnKVXqNdwubssOqdk3o6zzAPGNGJ5035rSA==
X-Received: by 2002:a17:906:c115:b0:9be:839a:3372 with SMTP id do21-20020a170906c11500b009be839a3372mr11884320ejc.59.1698242527362;
        Wed, 25 Oct 2023 07:02:07 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (92-249-235-200.pool.digikabel.hu. [92.249.235.200])
        by smtp.gmail.com with ESMTPSA id vl9-20020a170907b60900b00989828a42e8sm9857073ejc.154.2023.10.25.07.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 07:02:06 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-man@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Karel Zak <kzak@redhat.com>,
	Ian Kent <raven@themaw.net>,
	David Howells <dhowells@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <christian@brauner.io>,
	Amir Goldstein <amir73il@gmail.com>,
	Matthew House <mattlloydhouse@gmail.com>,
	Florian Weimer <fweimer@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v4 0/6] querying mount attributes
Date: Wed, 25 Oct 2023 16:01:58 +0200
Message-ID: <20231025140205.3586473-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement mount querying syscalls agreed on at LSF/MM 2023.

Features:

 - statx-like want/got mask
 - allows returning ascii strings (fs type, root, mount point)
 - returned buffer is relocatable (no pointers)

Still missing:
 - man pages
 - kselftest

Please find the test utility at the end of this mail.

  Usage: statmnt [-l|-r] [-u] (mnt_id|path)

Git tree:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git#statmount-v4


Changes v3..v4:

 - incorporate patch moving list of mounts to an rbtree
 - wire up syscalls for all archs
 - add LISTMOUNT_RECURSIVE (depth first iteration of mount tree)
 - add LSMT_ROOT (list root instead of a specific mount ID)
 - list_for_each_entry_del() moved to a separate patchset

Changes v1..v3:

 - rename statmnt(2) -> statmount(2)
 - rename listmnt(2) -> listmount(2)
 - make ABI 32bit compatible by passing 64bit args in a struct (tested on
   i386 and x32)
 - only accept new 64bit mount IDs
 - fix compile on !CONFIG_PROC_FS
 - call security_sb_statfs() in both syscalls
 - make lookup_mnt_in_ns() static
 - add LISTMOUNT_UNREACHABLE flag to listmnt() to explicitly ask for
   listing unreachable mounts
 - remove .sb_opts
 - remove subtype from .fs_type
 - return the number of bytes used (including strings) in .size
 - rename .mountpoint -> .mnt_point
 - point strings by an offset against char[] VLA at the end of the struct.
   E.g. printf("fs_type: %s\n", st->str + st->fs_type);
 - don't save string lengths
 - extend spare space in struct statmnt (complete size is now 512 bytes)


Miklos Szeredi (6):
  add unique mount ID
  mounts: keep list of mounts in an rbtree
  namespace: extract show_path() helper
  add statmount(2) syscall
  add listmount(2) syscall
  wire up syscalls for statmount/listmount

 arch/alpha/kernel/syscalls/syscall.tbl      |   3 +
 arch/arm/tools/syscall.tbl                  |   3 +
 arch/arm64/include/asm/unistd32.h           |   4 +
 arch/ia64/kernel/syscalls/syscall.tbl       |   3 +
 arch/m68k/kernel/syscalls/syscall.tbl       |   3 +
 arch/microblaze/kernel/syscalls/syscall.tbl |   3 +
 arch/mips/kernel/syscalls/syscall_n32.tbl   |   3 +
 arch/mips/kernel/syscalls/syscall_n64.tbl   |   3 +
 arch/mips/kernel/syscalls/syscall_o32.tbl   |   3 +
 arch/parisc/kernel/syscalls/syscall.tbl     |   3 +
 arch/powerpc/kernel/syscalls/syscall.tbl    |   3 +
 arch/s390/kernel/syscalls/syscall.tbl       |   3 +
 arch/sh/kernel/syscalls/syscall.tbl         |   3 +
 arch/sparc/kernel/syscalls/syscall.tbl      |   3 +
 arch/x86/entry/syscalls/syscall_32.tbl      |   3 +
 arch/x86/entry/syscalls/syscall_64.tbl      |   2 +
 arch/xtensa/kernel/syscalls/syscall.tbl     |   3 +
 fs/internal.h                               |   2 +
 fs/mount.h                                  |  27 +-
 fs/namespace.c                              | 573 ++++++++++++++++----
 fs/pnode.c                                  |   2 +-
 fs/proc_namespace.c                         |  13 +-
 fs/stat.c                                   |   9 +-
 include/linux/mount.h                       |   5 +-
 include/linux/syscalls.h                    |   8 +
 include/uapi/asm-generic/unistd.h           |   8 +-
 include/uapi/linux/mount.h                  |  65 +++
 include/uapi/linux/stat.h                   |   1 +
 28 files changed, 635 insertions(+), 129 deletions(-)

-- 
2.41.0

=== statmnt.c ===
#define _GNU_SOURCE
#include <unistd.h>
#include <stdio.h>
#include <fcntl.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <sys/mount.h>
#include <sys/stat.h>
#include <sys/param.h>
#include <err.h>

/*
 * Structure for getting mount/superblock/filesystem info with statmount(2).
 *
 * The interface is similar to statx(2): individual fields or groups can be
 * selected with the @mask argument of statmount().  Kernel will set the @mask
 * field according to the supported fields.
 *
 * If string fields are selected, then the caller needs to pass a buffer that
 * has space after the fixed part of the structure.  Nul terminated strings are
 * copied there and offsets relative to @str are stored in the relevant fields.
 * If the buffer is too small, then EOVERFLOW is returned.  The actually used
 * size is returned in @size.
 */
struct statmnt {
	__u32 size;		/* Total size, including strings */
	__u32 __spare1;
	__u64 mask;		/* What results were written */
	__u32 sb_dev_major;	/* Device ID */
	__u32 sb_dev_minor;
	__u64 sb_magic;		/* ..._SUPER_MAGIC */
	__u32 sb_flags;		/* MS_{RDONLY,SYNCHRONOUS,DIRSYNC,LAZYTIME} */
	__u32 fs_type;		/* [str] Filesystem type */
	__u64 mnt_id;		/* Unique ID of mount */
	__u64 mnt_parent_id;	/* Unique ID of parent (for root == mnt_id) */
	__u32 mnt_id_old;	/* Reused IDs used in proc/.../mountinfo */
	__u32 mnt_parent_id_old;
	__u64 mnt_attr;		/* MOUNT_ATTR_... */
	__u64 mnt_propagation;	/* MS_{SHARED,SLAVE,PRIVATE,UNBINDABLE} */
	__u64 mnt_peer_group;	/* ID of shared peer group */
	__u64 mnt_master;	/* Mount receives propagation from this ID */
	__u64 propagate_from;	/* Propagation from in current namespace */
	__u32 mnt_root;		/* [str] Root of mount relative to root of fs */
	__u32 mnt_point;	/* [str] Mountpoint relative to current root */
	__u64 __spare2[50];
	char str[];		/* Variable size part containing strings */
};

/*
 * To be used on the kernel ABI only for passing 64bit arguments to statmount(2)
 */
struct __mount_arg {
	__u64 mnt_id;
	__u64 request_mask;
};

/*
 * @mask bits for statmount(2)
 */
#define STMT_SB_BASIC		0x00000001U     /* Want/got sb_... */
#define STMT_MNT_BASIC		0x00000002U	/* Want/got mnt_... */
#define STMT_PROPAGATE_FROM	0x00000004U	/* Want/got propagate_from */
#define STMT_MNT_ROOT		0x00000008U	/* Want/got mnt_root  */
#define STMT_MNT_POINT		0x00000010U	/* Want/got mnt_point */
#define STMT_FS_TYPE		0x00000020U	/* Want/got fs_type */

/* listmount(2) flags */
#define LISTMOUNT_UNREACHABLE	0x01	/* List unreachable mounts too */
#define LISTMOUNT_RECURSIVE	0x02	/* List a mount tree */

/*
 * Special @mnt_id values that can be passed to listmount
 */
#define LSMT_ROOT		0xffffffffffffffff	/* root mount */

#ifdef __alpha__
#define __NR_statmount   564
#define __NR_listmount   565
#else
#define __NR_statmount   454
#define __NR_listmount   455
#endif

#define STATX_MNT_ID_UNIQUE	0x00004000U	/* Want/got extended stx_mount_id */


static void free_if_neq(void *p, const void *q)
{
	if (p != q)
		free(p);
}

static struct statmnt *statmount(uint64_t mnt_id, uint64_t mask, unsigned int flags)
{
	struct __mount_arg arg = {
		.mnt_id = mnt_id,
		.request_mask = mask,
	};
	union {
		struct statmnt m;
		char s[4096];
	} buf;
	struct statmnt *ret, *mm = &buf.m;
	size_t bufsize = sizeof(buf);

	while (syscall(__NR_statmount, &arg, mm, bufsize, flags) == -1) {
		free_if_neq(mm, &buf.m);
		if (errno != EOVERFLOW)
			return NULL;
		bufsize = MAX(1 << 15, bufsize << 1);
		mm = malloc(bufsize);
		if (!mm)
			return NULL;
	}
	ret = malloc(mm->size);
	if (ret)
		memcpy(ret, mm, mm->size);
	free_if_neq(mm, &buf.m);

	return ret;
}

static int listmount(uint64_t mnt_id, uint64_t **listp, unsigned int flags)
{
	struct __mount_arg arg = {
		.mnt_id = mnt_id,
	};
	uint64_t buf[512];
	size_t bufsize = sizeof(buf);
	uint64_t *ret, *ll = buf;
	long len;

	while ((len = syscall(__NR_listmount, &arg, ll, bufsize / sizeof(buf[0]), flags)) == -1) {
		free_if_neq(ll, buf);
		if (errno != EOVERFLOW)
			return -1;
		bufsize = MAX(1 << 15, bufsize << 1);
		ll = malloc(bufsize);
		if (!ll)
			return -1;
	}
	bufsize = len * sizeof(buf[0]);
	ret = malloc(bufsize);
	if (!ret)
		return -1;

	*listp = ret;
	memcpy(ret, ll, bufsize);
	free_if_neq(ll, buf);

	return len;
}


int main(int argc, char *argv[])
{
	struct statmnt *st;
	char *end;
	int res;
	int list = 0;
	int flags = 0;
	uint64_t mask = STMT_SB_BASIC | STMT_MNT_BASIC | STMT_PROPAGATE_FROM | STMT_MNT_ROOT | STMT_MNT_POINT | STMT_FS_TYPE;
	uint64_t mnt_id;
	int opt;

	for (;;) {
		opt = getopt(argc, argv, "lru");
		if (opt == -1)
			break;
		switch (opt) {
		case 'r':
			flags |= LISTMOUNT_RECURSIVE;
			/* fallthrough */
		case 'l':
			list = 1;
			break;
		case 'u':
			flags |= LISTMOUNT_UNREACHABLE;
			break;
		default:
			errx(1, "usage: %s [-l|-r] [-u] (mnt_id|path)", argv[0]);
		}
	}
	if (optind >= argc) {
		if (!list)
			errx(1, "missing mnt_id or path");
		else
			mnt_id = -1LL;
	} else {
		const char *arg = argv[optind];

		mnt_id = strtoll(arg, &end, 0);
		if (!mnt_id || *end != '\0') {
			struct statx sx;

			res = statx(AT_FDCWD, arg, 0, STATX_MNT_ID_UNIQUE, &sx);
			if (res == -1)
				err(1, "%s", arg);

			if (!(sx.stx_mask & (STATX_MNT_ID | STATX_MNT_ID_UNIQUE)))
				errx(1, "Sorry, no mount ID");

			mnt_id = sx.stx_mnt_id;
		}
	}

	if (list) {
		uint64_t *list;
		int num, i;

		res = listmount(mnt_id, &list, flags);
		if (res == -1)
			err(1, "listmnt(0x%llx)", (unsigned long long) mnt_id);

		num = res;
		for (i = 0; i < num; i++) {
			printf("0x%llx", (unsigned long long) list[i]);

			st = statmount(list[i], STMT_MNT_POINT, 0);
			if (!st) {
				printf("\t[%s]\n", strerror(errno));
			} else {
				printf("\t%s\n", (st->mask & STMT_MNT_POINT) ? st->str + st->mnt_point : "???");
			}
			free(st);
		}
		free(list);

		return 0;
	}

	st = statmount(mnt_id, mask, 0);
	if (!st)
		err(1, "statmnt(0x%llx)", (unsigned long long) mnt_id);

	printf("size: %u\n", st->size);
	printf("mask: 0x%llx\n", st->mask);
	if (st->mask & STMT_SB_BASIC) {
		printf("sb_dev_major: %u\n", st->sb_dev_major);
		printf("sb_dev_minor: %u\n", st->sb_dev_minor);
		printf("sb_magic: 0x%llx\n", st->sb_magic);
		printf("sb_flags: 0x%08x\n", st->sb_flags);
	}
	if (st->mask & STMT_MNT_BASIC) {
		printf("mnt_id: 0x%llx\n", st->mnt_id);
		printf("mnt_parent_id: 0x%llx\n", st->mnt_parent_id);
		printf("mnt_id_old: %u\n", st->mnt_id_old);
		printf("mnt_parent_id_old: %u\n", st->mnt_parent_id_old);
		printf("mnt_attr: 0x%08llx\n", st->mnt_attr);
		printf("mnt_propagation: %s%s%s%s\n",
		       st->mnt_propagation & MS_SHARED ? "shared," : "",
		       st->mnt_propagation & MS_SLAVE ? "slave," : "",
		       st->mnt_propagation & MS_UNBINDABLE ? "unbindable," : "",
		       st->mnt_propagation & MS_PRIVATE ? "private" : "");
		printf("mnt_peer_group: %llu\n", st->mnt_peer_group);
		printf("mnt_master: %llu\n", st->mnt_master);
	}
	if (st->mask & STMT_PROPAGATE_FROM)
		printf("propagate_from: %llu\n", st->propagate_from);
	if (st->mask & STMT_MNT_ROOT)
		printf("mnt_root: %u <%s>\n", st->mnt_root, st->str + st->mnt_root);
	if (st->mask & STMT_MNT_POINT)
		printf("mnt_point: %u <%s>\n", st->mnt_point, st->str + st->mnt_point);
	if (st->mask & STMT_FS_TYPE)
		printf("fs_type: %u <%s>\n", st->fs_type, st->str + st->fs_type);
	free(st);

	return 0;
}


