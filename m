Return-Path: <linux-fsdevel+bounces-59504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B801B3A2A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 16:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 025A41C82AC7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 14:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA18A3126C7;
	Thu, 28 Aug 2025 14:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mxw2vCvM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FA6230274;
	Thu, 28 Aug 2025 14:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756392563; cv=none; b=iVio2u1SxLrl8qCwI69bh2cmlvialYJCRSuquBXeSskftXmfOwgZkPAZXodmn4t2sHOkFwQ1PMS1iJt6QoFtRvRG8N4qVaQ38NAMCtNmjFxKW17vCIi6CQ5cMnYdeskdfsTeWNry5HpQO8P9kdDG/YWAhEv37W4UG4rLcHtmvaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756392563; c=relaxed/simple;
	bh=ZSoUIyV624ezKk5On7klkQxMRu5xyM9f9lgG8YsE/wY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uJebPLmXRnpCB8VZ3TPwHypAEooa2D5bQ4UhGiTNLyXLseMMrgpwrgURMrazJO3fivq//RcCJOO/HatHQ6JSnfAdAkKs3PgcdFk87fjJ7aXDELTevK6eYoZ+/8QNXznjWZwaPdA5WoADIt4bcTUewf/np2VMCv+D5ocoevvHhQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mxw2vCvM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5791C4CEEB;
	Thu, 28 Aug 2025 14:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756392562;
	bh=ZSoUIyV624ezKk5On7klkQxMRu5xyM9f9lgG8YsE/wY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mxw2vCvMWAX4qK2zM23c0ldUr8RGom8esxo7oK9pu1K9LIUzDvQUxTmrn0q/PZ0wR
	 3j2eSx88qyqt/oHKV+iFML85SyEuxU3QnyTOMxwjv9r3i+Oz6AelYhL7Pvnp/FIf51
	 PSrpMtuueTmPiXQtW4jldIdzuSAePLnMlQWMr3kwcCJ8jwbl43fo9shiS+3RK+L5O/
	 eG/0IJGH9rjtQbgvAnqLyil2yHyyzPnUh8uYI3IicwqL50KgtB2/a8+WdlcjPrp669
	 0SOJkTLZvSIqrALdhADVDVeX2Te2XYw1eWUPaReTsnDRYPuLoF6delovZi8ITICssd
	 ciO/3NiSvYf1g==
Date: Thu, 28 Aug 2025 07:49:22 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fstests@vger.kernel.org, zlang@redhat.com,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH v2 1/3] file_attr: introduce program to set/get fsxattr
Message-ID: <20250828144922.GE8096@frogsfrogsfrogs>
References: <20250827-xattrat-syscall-v2-0-ba489b5bc17a@kernel.org>
 <20250827-xattrat-syscall-v2-1-ba489b5bc17a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827-xattrat-syscall-v2-1-ba489b5bc17a@kernel.org>

On Wed, Aug 27, 2025 at 05:16:15PM +0200, Andrey Albershteyn wrote:
> This programs uses newly introduced file_getattr and file_setattr
> syscalls. This program is partially a test of invalid options. This will
> be used further in the test.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
>  .gitignore            |   1 +
>  configure.ac          |   1 +
>  include/builddefs.in  |   1 +
>  m4/package_libcdev.m4 |  16 +++
>  src/Makefile          |   5 +
>  src/file_attr.c       | 268 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 292 insertions(+)
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
> index f3c8c643f0eb..6fe54e8e1d54 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -73,6 +73,7 @@ AC_HAVE_RLIMIT_NOFILE
>  AC_NEED_INTERNAL_XFS_IOC_EXCHANGE_RANGE
>  AC_HAVE_FICLONE
>  AC_HAVE_TRIVIAL_AUTO_VAR_INIT
> +AC_HAVE_FILE_ATTR
>  
>  AC_CHECK_FUNCS([renameat2])
>  AC_CHECK_FUNCS([reallocarray])
> diff --git a/include/builddefs.in b/include/builddefs.in
> index 96d5ed25b3e2..821237339cc7 100644
> --- a/include/builddefs.in
> +++ b/include/builddefs.in
> @@ -74,6 +74,7 @@ HAVE_BMV_OF_SHARED = @have_bmv_of_shared@
>  HAVE_RLIMIT_NOFILE = @have_rlimit_nofile@
>  NEED_INTERNAL_XFS_IOC_EXCHANGE_RANGE = @need_internal_xfs_ioc_exchange_range@
>  HAVE_FICLONE = @have_ficlone@
> +HAVE_FILE_ATTR = @have_file_attr@
>  
>  GCCFLAGS = -std=gnu11 -funsigned-char -fno-strict-aliasing -Wall
>  SANITIZER_CFLAGS += @autovar_init_cflags@
> diff --git a/m4/package_libcdev.m4 b/m4/package_libcdev.m4
> index ed8fe6e32ae0..e68a70f7d87e 100644
> --- a/m4/package_libcdev.m4
> +++ b/m4/package_libcdev.m4
> @@ -86,3 +86,19 @@ AC_DEFUN([AC_HAVE_TRIVIAL_AUTO_VAR_INIT],
>      CFLAGS="${OLD_CFLAGS}"
>      AC_SUBST(autovar_init_cflags)
>    ])
> +
> +#
> +# Check if we have a file_getattr/file_setattr system call (Linux)
> +#
> +AC_DEFUN([AC_HAVE_FILE_ATTR],
> +  [ AC_MSG_CHECKING([for file_getattr/file_setattr syscalls])
> +    AC_LINK_IFELSE([AC_LANG_PROGRAM([[
> +#define _GNU_SOURCE
> +#include <sys/syscall.h>
> +#include <unistd.h>
> +    ]], [[
> +         syscall(__NR_file_getattr, 0, 0, 0, 0, 0, 0);

Same comment as the xfsprogs series -- I'd name this AC_HAVE_FILE_ATTR
because you're testing for file_getattr, not struct file_attr itself.

> +    ]])],[have_file_attr=yes
> +       AC_MSG_RESULT(yes)],[AC_MSG_RESULT(no)])
> +    AC_SUBST(have_file_attr)
> +  ])
> diff --git a/src/Makefile b/src/Makefile
> index 7080e34896c3..db4223156fc2 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -62,6 +62,11 @@ ifeq ($(HAVE_FALLOCATE), true)
>  LCFLAGS += -DHAVE_FALLOCATE
>  endif
>  
> +ifeq ($(HAVE_FILE_ATTR), yes)
> +LINUX_TARGETS += file_attr
> +LCFLAGS += -DHAVE_FILE_ATTR
> +endif
> +
>  ifeq ($(PKG_PLATFORM),linux)
>  TARGETS += $(LINUX_TARGETS)
>  endif
> diff --git a/src/file_attr.c b/src/file_attr.c
> new file mode 100644
> index 000000000000..9baf0e9a12ee
> --- /dev/null
> +++ b/src/file_attr.c
> @@ -0,0 +1,268 @@
> +#include "global.h"

New file needs a SPDX license header and copyright statement.

Other than the inconsistent use of spaces vs tabs for indentation, this
file looks ok to me.

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
> +#ifndef HAVE_FILE_ATTR
> +#define __NR_file_getattr 468
> +#define __NR_file_setattr 469
> +
> +struct file_attr {
> +       __u32           fa_xflags;     /* xflags field value (get/set) */
> +       __u32           fa_extsize;    /* extsize field value (get/set)*/
> +       __u32           fa_nextents;   /* nextents field value (get)   */
> +       __u32           fa_projid;     /* project identifier (get/set) */
> +       __u32           fa_cowextsize; /* CoW extsize field value (get/set) */
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
> +        while (1) {
> +            int option_index = 0;
> +
> +            c = getopt_long_only(argc, argv, "", long_options, &option_index);
> +            if (c == -1)
> +                break;
> +
> +            switch (c) {
> +	    case 's':
> +		action = 1;
> +		break;
> +	    case 'g':
> +		action = 0;
> +		break;
> +	    case 'n':
> +		at_flags |= AT_SYMLINK_NOFOLLOW;
> +		break;
> +	    case 'a':
> +		at_fdcwd = 1;
> +		break;
> +	    case 'd':
> +		fa_xflags |= FS_XFLAG_NODUMP;
> +		break;
> +	    case 'i':
> +		at_flags |= (1 << 25);
> +		break;
> +	    case 'b':
> +		fa_size = getpagesize() + 1; /* max size if page size */
> +		break;
> +	    case 'm':
> +		fa_size = 19; /* VER0 size of fsxattr is 20 */
> +		break;
> +	    case 'x':
> +		unknwon_fa_flag = (1 << 27);
> +		break;
> +	    default:
> +		goto usage;
> +            }
> +        }
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
> +	printf("\t--invalid-at, -i\t\tUse invalida AT_* flag\n");

"Use invalid AT_* flag"

--D

> +	printf("\t--too-big-arg, -b\t\tSet fsxattr size bigger than PAGE_SIZE\n");
> +	printf("\t--too-small-arg, -m\t\tSet fsxattr size to 19 bytes\n");
> +	printf("\t--new-fsx-flag, -x\t\tUse unknown fa_flags flag\n");
> +
> +	return 1;
> +}
> 
> -- 
> 2.49.0
> 
> 

