Return-Path: <linux-fsdevel+bounces-61153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A5EB55A6E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Sep 2025 01:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0DD5188A5BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 23:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AA228469E;
	Fri, 12 Sep 2025 23:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1ZZon/p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030DC220F24;
	Fri, 12 Sep 2025 23:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757720387; cv=none; b=S9bE/Qa17t37G97ayDII5iCtyz9SEQ27sw/Kl/i5wHLT89O0Vf+oGv4TbJ8btmN+J20IPQmssJEq83KbjhaDyBs9XlVShGq1zrLJaL1Z+YAZauP4KCZblMaTtV1iejVkW2Upqn/lQMqqx5qEG+J6A0iiEjS12vbZsu+an8Snowo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757720387; c=relaxed/simple;
	bh=K+6dGMKW0Up7H6JciyTB+2ubBTK7URD/Hx/jR5yUBlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WlEHbUGFl2KbyabGG/h9H2J5yfHfmZpMAGuzalHjoFI742ISFliRpCLpRUnOEaiaieFcfcLC63kplvhney8mtCtxj65GRFSIusDUmX+WxMAYn2axnKAttxkr3DtWmiU/1/dZR8eeFaaowwbWJYWR2G5GVSALa4Fnq/SegbNT6MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1ZZon/p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68809C4CEF1;
	Fri, 12 Sep 2025 23:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757720386;
	bh=K+6dGMKW0Up7H6JciyTB+2ubBTK7URD/Hx/jR5yUBlk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y1ZZon/pE4QbJ6LOmh5ojD8LntmXWMSYGde8f+jRR5UWvzEHHDsFbVniK0mxUMC55
	 G6rtchZh1f0KCKjpadkJ93/zcII9Sbi1XQjlhqPJt5TNS/qAm0PPcC0cBPe79S5GnN
	 oTEombSLV//0h8Y+TBx79AQh7w6by9D84h7eD6W8kCYhgyptvxO32h/OIxbUmWgaZD
	 MqQa73EHm2a7M50a7CfqD++ixnaHDiTzgzvIejwD6JX+DiTxY8Zv7fGvEA+wdFuu8T
	 vT6sKy/yo0PRE7+kLiA4vt4ueGswSepHBf04tFwmNj6RD6rBniJXo15y33rx+n+5Iy
	 x5YlUCGQt5G6w==
Date: Fri, 12 Sep 2025 16:39:45 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fstests@vger.kernel.org, zlang@redhat.com,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH v3 1/3] file_attr: introduce program to set/get fsxattr
Message-ID: <20250912233945.GL1587915@frogsfrogsfrogs>
References: <20250909-xattrat-syscall-v3-0-9ba483144789@kernel.org>
 <20250909-xattrat-syscall-v3-1-9ba483144789@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909-xattrat-syscall-v3-1-9ba483144789@kernel.org>

On Tue, Sep 09, 2025 at 05:25:56PM +0200, Andrey Albershteyn wrote:
> This programs uses newly introduced file_getattr and file_setattr
> syscalls. This program is partially a test of invalid options. This will
> be used further in the test.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>

Thanks for cleaning up the indentation.
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  .gitignore            |   1 +
>  configure.ac          |   1 +
>  include/builddefs.in  |   1 +
>  m4/package_libcdev.m4 |  16 +++
>  src/Makefile          |   5 +
>  src/file_attr.c       | 274 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 298 insertions(+)
> 
> diff --git a/.gitignore b/.gitignore
> index 6948fd602f95..82c57f415301 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -211,6 +211,7 @@ tags
>  /src/min_dio_alignment
>  /src/dio-writeback-race
>  /src/unlink-fsync
> +/src/file_attr
>  
>  # Symlinked files
>  /tests/generic/035.out
> diff --git a/configure.ac b/configure.ac
> index f3c8c643f0eb..f7519fa97654 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -73,6 +73,7 @@ AC_HAVE_RLIMIT_NOFILE
>  AC_NEED_INTERNAL_XFS_IOC_EXCHANGE_RANGE
>  AC_HAVE_FICLONE
>  AC_HAVE_TRIVIAL_AUTO_VAR_INIT
> +AC_HAVE_FILE_GETATTR
>  
>  AC_CHECK_FUNCS([renameat2])
>  AC_CHECK_FUNCS([reallocarray])
> diff --git a/include/builddefs.in b/include/builddefs.in
> index 96d5ed25b3e2..708d75b24d76 100644
> --- a/include/builddefs.in
> +++ b/include/builddefs.in
> @@ -74,6 +74,7 @@ HAVE_BMV_OF_SHARED = @have_bmv_of_shared@
>  HAVE_RLIMIT_NOFILE = @have_rlimit_nofile@
>  NEED_INTERNAL_XFS_IOC_EXCHANGE_RANGE = @need_internal_xfs_ioc_exchange_range@
>  HAVE_FICLONE = @have_ficlone@
> +HAVE_FILE_GETATTR = @have_file_getattr@
>  
>  GCCFLAGS = -std=gnu11 -funsigned-char -fno-strict-aliasing -Wall
>  SANITIZER_CFLAGS += @autovar_init_cflags@
> diff --git a/m4/package_libcdev.m4 b/m4/package_libcdev.m4
> index ed8fe6e32ae0..17f57f427410 100644
> --- a/m4/package_libcdev.m4
> +++ b/m4/package_libcdev.m4
> @@ -86,3 +86,19 @@ AC_DEFUN([AC_HAVE_TRIVIAL_AUTO_VAR_INIT],
>      CFLAGS="${OLD_CFLAGS}"
>      AC_SUBST(autovar_init_cflags)
>    ])
> +
> +#
> +# Check if we have a file_getattr system call (Linux)
> +#
> +AC_DEFUN([AC_HAVE_FILE_GETATTR],
> +  [ AC_MSG_CHECKING([for file_getattr syscall])
> +    AC_LINK_IFELSE([AC_LANG_PROGRAM([[
> +#define _GNU_SOURCE
> +#include <sys/syscall.h>
> +#include <unistd.h>
> +    ]], [[
> +         syscall(__NR_file_getattr, 0, 0, 0, 0, 0, 0);
> +    ]])],[have_file_getattr=yes
> +       AC_MSG_RESULT(yes)],[AC_MSG_RESULT(no)])
> +    AC_SUBST(have_file_getattr)
> +  ])
> diff --git a/src/Makefile b/src/Makefile
> index 7080e34896c3..711dbb917b3a 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -62,6 +62,11 @@ ifeq ($(HAVE_FALLOCATE), true)
>  LCFLAGS += -DHAVE_FALLOCATE
>  endif
>  
> +ifeq ($(HAVE_FILE_GETATTR), yes)
> +LINUX_TARGETS += file_attr
> +LCFLAGS += -DHAVE_FILE_GETATTR
> +endif
> +
>  ifeq ($(PKG_PLATFORM),linux)
>  TARGETS += $(LINUX_TARGETS)
>  endif
> diff --git a/src/file_attr.c b/src/file_attr.c
> new file mode 100644
> index 000000000000..29bb6c903403
> --- /dev/null
> +++ b/src/file_attr.c
> @@ -0,0 +1,274 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2025 Red Hat, Inc.  All Rights Reserved.
> + */
> +
> +#include "global.h"
> +#include <sys/syscall.h>
> +#include <getopt.h>
> +#include <errno.h>
> +#include <linux/fs.h>
> +#include <sys/stat.h>
> +#include <string.h>
> +#include <getopt.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +
> +#ifndef HAVE_FILE_GETATTR
> +#define __NR_file_getattr 468
> +#define __NR_file_setattr 469
> +
> +struct file_attr {
> +	__u32	fa_xflags;	/* xflags field value (get/set) */
> +	__u32	fa_extsize;	/* extsize field value (get/set)*/
> +	__u32	fa_nextents;	/* nextents field value (get)   */
> +	__u32	fa_projid;	/* project identifier (get/set) */
> +	__u32	fa_cowextsize;	/* CoW extsize field value (get/set) */
> +};
> +
> +#endif
> +
> +#define SPECIAL_FILE(x) \
> +	   (S_ISCHR((x)) \
> +	|| S_ISBLK((x)) \
> +	|| S_ISFIFO((x)) \
> +	|| S_ISLNK((x)) \
> +	|| S_ISSOCK((x)))
> +
> +static struct option long_options[] = {
> +	{"set",			no_argument,	0,	's' },
> +	{"get",			no_argument,	0,	'g' },
> +	{"no-follow",		no_argument,	0,	'n' },
> +	{"at-cwd",		no_argument,	0,	'a' },
> +	{"set-nodump",		no_argument,	0,	'd' },
> +	{"invalid-at",		no_argument,	0,	'i' },
> +	{"too-big-arg",		no_argument,	0,	'b' },
> +	{"too-small-arg",	no_argument,	0,	'm' },
> +	{"new-fsx-flag",	no_argument,	0,	'x' },
> +	{0,			0,		0,	0 }
> +};
> +
> +static struct xflags {
> +	uint	flag;
> +	char	*shortname;
> +	char	*longname;
> +} xflags[] = {
> +	{ FS_XFLAG_REALTIME,		"r", "realtime"		},
> +	{ FS_XFLAG_PREALLOC,		"p", "prealloc"		},
> +	{ FS_XFLAG_IMMUTABLE,		"i", "immutable"	},
> +	{ FS_XFLAG_APPEND,		"a", "append-only"	},
> +	{ FS_XFLAG_SYNC,		"s", "sync"		},
> +	{ FS_XFLAG_NOATIME,		"A", "no-atime"		},
> +	{ FS_XFLAG_NODUMP,		"d", "no-dump"		},
> +	{ FS_XFLAG_RTINHERIT,		"t", "rt-inherit"	},
> +	{ FS_XFLAG_PROJINHERIT,		"P", "proj-inherit"	},
> +	{ FS_XFLAG_NOSYMLINKS,		"n", "nosymlinks"	},
> +	{ FS_XFLAG_EXTSIZE,		"e", "extsize"		},
> +	{ FS_XFLAG_EXTSZINHERIT,	"E", "extsz-inherit"	},
> +	{ FS_XFLAG_NODEFRAG,		"f", "no-defrag"	},
> +	{ FS_XFLAG_FILESTREAM,		"S", "filestream"	},
> +	{ FS_XFLAG_DAX,			"x", "dax"		},
> +	{ FS_XFLAG_COWEXTSIZE,		"C", "cowextsize"	},
> +	{ FS_XFLAG_HASATTR,		"X", "has-xattr"	},
> +	{ 0, NULL, NULL }
> +};
> +
> +static int
> +file_getattr(
> +		int			dfd,
> +		const char		*filename,
> +		struct file_attr	*fsx,
> +		size_t			usize,
> +		unsigned int		at_flags)
> +{
> +	return syscall(__NR_file_getattr, dfd, filename, fsx, usize, at_flags);
> +}
> +
> +static int
> +file_setattr(
> +		int			dfd,
> +		const char		*filename,
> +		struct file_attr	*fsx,
> +		size_t			usize,
> +		unsigned int		at_flags)
> +{
> +	return syscall(__NR_file_setattr, dfd, filename, fsx, usize, at_flags);
> +}
> +
> +static void
> +print_xflags(
> +	uint		flags,
> +	int		verbose,
> +	int		dofname,
> +	const char	*fname,
> +	int		dobraces,
> +	int		doeol)
> +{
> +	struct xflags	*p;
> +	int		first = 1;
> +
> +	if (dobraces)
> +		fputs("[", stdout);
> +	for (p = xflags; p->flag; p++) {
> +		if (flags & p->flag) {
> +			if (verbose) {
> +				if (first)
> +					first = 0;
> +				else
> +					fputs(", ", stdout);
> +				fputs(p->longname, stdout);
> +			} else {
> +				fputs(p->shortname, stdout);
> +			}
> +		} else if (!verbose) {
> +			fputs("-", stdout);
> +		}
> +	}
> +	if (dobraces)
> +		fputs("]", stdout);
> +	if (dofname)
> +		printf(" %s ", fname);
> +	if (doeol)
> +		fputs("\n", stdout);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	int error;
> +	int c;
> +	const char *path = NULL;
> +	const char *path1 = NULL;
> +	const char *path2 = NULL;
> +	unsigned int at_flags = 0;
> +	unsigned int fa_xflags = 0;
> +	int action = 0; /* 0 get; 1 set */
> +	struct file_attr fsx = { };
> +	int fa_size = sizeof(struct file_attr);
> +	struct stat status;
> +	int fd;
> +	int at_fdcwd = 0;
> +	int unknwon_fa_flag = 0;
> +
> +	while (1) {
> +		int option_index = 0;
> +
> +		c = getopt_long_only(argc, argv, "", long_options,
> +				&option_index);
> +		if (c == -1)
> +			break;
> +
> +		switch (c) {
> +		case 's':
> +			action = 1;
> +			break;
> +		case 'g':
> +			action = 0;
> +			break;
> +		case 'n':
> +			at_flags |= AT_SYMLINK_NOFOLLOW;
> +			break;
> +		case 'a':
> +			at_fdcwd = 1;
> +			break;
> +		case 'd':
> +			fa_xflags |= FS_XFLAG_NODUMP;
> +			break;
> +		case 'i':
> +			at_flags |= (1 << 25);
> +			break;
> +		case 'b':
> +			fa_size = getpagesize() + 1; /* max size if page size */
> +			break;
> +		case 'm':
> +			fa_size = 19; /* VER0 size of fsxattr is 20 */
> +			break;
> +		case 'x':
> +			unknwon_fa_flag = (1 << 27);
> +			break;
> +		default:
> +			goto usage;
> +		}
> +	}
> +
> +	if (!path1 && optind < argc)
> +		path1 = argv[optind++];
> +	if (!path2 && optind < argc)
> +		path2 = argv[optind++];
> +
> +	if (at_fdcwd) {
> +		fd = AT_FDCWD;
> +		path = path1;
> +	} else if (!path2) {
> +		error = stat(path1, &status);
> +		if (error) {
> +			fprintf(stderr,
> +"Can not get file status of %s: %s\n", path1, strerror(errno));
> +			return error;
> +		}
> +
> +		if (SPECIAL_FILE(status.st_mode)) {
> +			fprintf(stderr,
> +"Can not open special file %s without parent dir: %s\n", path1, strerror(errno));
> +			return errno;
> +		}
> +
> +		fd = open(path1, O_RDONLY);
> +		if (fd == -1) {
> +			fprintf(stderr, "Can not open %s: %s\n", path1,
> +					strerror(errno));
> +			return errno;
> +		}
> +	} else {
> +		fd = open(path1, O_RDONLY);
> +		if (fd == -1) {
> +			fprintf(stderr, "Can not open %s: %s\n", path1,
> +					strerror(errno));
> +			return errno;
> +		}
> +		path = path2;
> +	}
> +
> +	if (!path)
> +		at_flags |= AT_EMPTY_PATH;
> +
> +	error = file_getattr(fd, path, &fsx, fa_size,
> +			at_flags);
> +	if (error) {
> +		fprintf(stderr, "Can not get fsxattr on %s: %s\n", path,
> +				strerror(errno));
> +		return error;
> +	}
> +	if (action) {
> +		fsx.fa_xflags |= (fa_xflags | unknwon_fa_flag);
> +
> +		error = file_setattr(fd, path, &fsx, fa_size,
> +				at_flags);
> +		if (error) {
> +			fprintf(stderr, "Can not set fsxattr on %s: %s\n", path,
> +					strerror(errno));
> +			return error;
> +		}
> +	} else {
> +		if (path2)
> +			print_xflags(fsx.fa_xflags, 0, 1, path, 0, 1);
> +		else
> +			print_xflags(fsx.fa_xflags, 0, 1, path1, 0, 1);
> +	}
> +
> +	return error;
> +
> +usage:
> +	printf("Usage: %s [options]\n", argv[0]);
> +	printf("Options:\n");
> +	printf("\t--get, -g\t\tget filesystem inode attributes\n");
> +	printf("\t--set, -s\t\tset filesystem inode attributes\n");
> +	printf("\t--at-cwd, -a\t\topen file at current working directory\n");
> +	printf("\t--no-follow, -n\t\tdon't follow symlinks\n");
> +	printf("\t--set-nodump, -d\t\tset FS_XFLAG_NODUMP on an inode\n");
> +	printf("\t--invalid-at, -i\t\tUse invalid AT_* flag\n");
> +	printf("\t--too-big-arg, -b\t\tSet fsxattr size bigger than PAGE_SIZE\n");
> +	printf("\t--too-small-arg, -m\t\tSet fsxattr size to 19 bytes\n");
> +	printf("\t--new-fsx-flag, -x\t\tUse unknown fa_flags flag\n");
> +
> +	return 1;
> +}
> 
> -- 
> 2.50.1
> 
> 

