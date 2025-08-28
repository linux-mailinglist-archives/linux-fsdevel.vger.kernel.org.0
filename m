Return-Path: <linux-fsdevel+bounces-59500-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E839B3A203
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 16:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D91A1891C51
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 14:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A573230FC20;
	Thu, 28 Aug 2025 14:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6S+U4vz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE0C30E0F3;
	Thu, 28 Aug 2025 14:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756391698; cv=none; b=FqOL/34a8KuPU/YcjI6PMZhnwTiTx9u5/MoOrWD73TGzeilIwQx/EorEkMo4iACWsU/y1EJmH2pZMbz3Quiam1vewFA+1rjltoc0xHO4WT/792tI6RWM/Bp7qrrQIdJ1nFrYU/OCYJmYGVH4hJ0PUTcJxJqc8336l2NDRHhyQv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756391698; c=relaxed/simple;
	bh=5ENyPjY5zuJDNKTs40ybxhLSsHhregkMdlqbtAB01kA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RSLk65kz4gSMSymYLymtiG4NdWLcSwFLcI0CTEdYcXTUn15AzcjXp+4V+CvwLGmPxUyElLOWgcqjqvdT9qRmgaN4lPL3+WU6M1bO8pskapHVAayb7Ngx/EBq3pKAJIJSlM6uuqzQd6HH3Bl9n3+zcv+MOZ8QtDC3O6zbUkAagHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6S+U4vz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D31EAC4CEED;
	Thu, 28 Aug 2025 14:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756391697;
	bh=5ENyPjY5zuJDNKTs40ybxhLSsHhregkMdlqbtAB01kA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E6S+U4vz68ZYzIQp9q1++Ykh3BvBzxLFW0Xwj1n06CEbL5jVW3PBRAZ/tFhAdvvrQ
	 BF2kNyC9ufgJq3BJkkVhkLalbhlBjceqSqlSUMfBVRGBbeYwIyIYSk6ZbD6jI6vilV
	 KTFIJhLuR/d//pVsmHOTlWowNEe2NSmQ3gDeh02CD9dzAIvU8e7lch7g99T3zg7+zc
	 gCvROK0o2WGELmFMCrNsiOxld8BCIY4mZMtWu0UqEE2+1pL7qJNVBHNd4S/G+0d0Cy
	 NtSY9j/e/xIQhr7aPQqhxX9znr4gLnS/qzyyPZSn/D3fo1yyYU9vU0fJmgZGxrSA8t
	 JjWxGJi/5OjzA==
Date: Thu, 28 Aug 2025 07:34:57 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: aalbersh@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 1/4] libfrog: add wrappers for
 file_getattr/file_setattr syscalls
Message-ID: <20250828143457.GA8096@frogsfrogsfrogs>
References: <20250827-xattrat-syscall-v2-0-82a2d2d5865b@kernel.org>
 <20250827-xattrat-syscall-v2-1-82a2d2d5865b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827-xattrat-syscall-v2-1-82a2d2d5865b@kernel.org>

On Wed, Aug 27, 2025 at 05:15:53PM +0200, Andrey Albershteyn wrote:
> Add wrappers for new file_getattr/file_setattr inode syscalls which will
> be used by xfs_quota and xfs_io.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
>  configure.ac          |   1 +
>  include/builddefs.in  |   5 +++
>  include/linux.h       |  20 +++++++++
>  libfrog/Makefile      |   2 +
>  libfrog/file_attr.c   | 122 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  libfrog/file_attr.h   |  35 +++++++++++++++
>  m4/package_libcdev.m4 |  19 ++++++++
>  7 files changed, 204 insertions(+)
> 
> diff --git a/configure.ac b/configure.ac
> index 195ee6dddf61..a3206d53e7e0 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -156,6 +156,7 @@ AC_PACKAGE_NEED_RCU_INIT
>  AC_HAVE_PWRITEV2
>  AC_HAVE_COPY_FILE_RANGE
>  AC_HAVE_CACHESTAT
> +AC_HAVE_FILE_ATTR
>  AC_NEED_INTERNAL_FSXATTR
>  AC_NEED_INTERNAL_FSCRYPT_ADD_KEY_ARG
>  AC_NEED_INTERNAL_FSCRYPT_POLICY_V2
> diff --git a/include/builddefs.in b/include/builddefs.in
> index 04b4e0880a84..d727b55b854f 100644
> --- a/include/builddefs.in
> +++ b/include/builddefs.in
> @@ -97,6 +97,7 @@ HAVE_ZIPPED_MANPAGES = @have_zipped_manpages@
>  HAVE_PWRITEV2 = @have_pwritev2@
>  HAVE_COPY_FILE_RANGE = @have_copy_file_range@
>  HAVE_CACHESTAT = @have_cachestat@
> +HAVE_FILE_ATTR = @have_file_attr@
>  NEED_INTERNAL_FSXATTR = @need_internal_fsxattr@
>  NEED_INTERNAL_FSCRYPT_ADD_KEY_ARG = @need_internal_fscrypt_add_key_arg@
>  NEED_INTERNAL_FSCRYPT_POLICY_V2 = @need_internal_fscrypt_policy_v2@
> @@ -169,6 +170,10 @@ ifeq ($(ENABLE_GETTEXT),yes)
>  GCFLAGS += -DENABLE_GETTEXT
>  endif
>  
> +ifeq ($(HAVE_FILE_ATTR),yes)
> +LCFLAGS += -DHAVE_FILE_ATTR
> +endif
> +
>  # Override these if C++ needs other options
>  SANITIZER_CXXFLAGS = $(SANITIZER_CFLAGS)
>  GCXXFLAGS = $(GCFLAGS)
> diff --git a/include/linux.h b/include/linux.h
> index 6e83e073aa2e..993789f01b3a 100644
> --- a/include/linux.h
> +++ b/include/linux.h
> @@ -16,6 +16,7 @@
>  #include <sys/param.h>
>  #include <sys/sysmacros.h>
>  #include <sys/stat.h>
> +#include <sys/syscall.h>
>  #include <inttypes.h>
>  #include <malloc.h>
>  #include <getopt.h>
> @@ -202,6 +203,25 @@ struct fsxattr {
>  };
>  #endif
>  
> +/*
> + * Use FILE_ATTR_SIZE_VER0 (linux/fs.h) instead of build system HAVE_FILE_ATTR
> + * as this header could be included in other places where HAVE_FILE_ATTR is not
> + * defined (e.g. xfstests's conftest.c in ./configure)
> + */
> +#ifndef FILE_ATTR_SIZE_VER0
> +/*
> + * We need to define file_attr if it's missing to know how to convert it to
> + * fsxattr
> + */
> +struct file_attr {
> +	__u32		fa_xflags;
> +	__u32		fa_extsize;
> +	__u32		fa_nextents;
> +	__u32		fa_projid;
> +	__u32		fa_cowextsize;
> +};
> +#endif
> +
>  #ifndef FS_IOC_FSGETXATTR
>  /*
>   * Flags for the fsx_xflags field
> diff --git a/libfrog/Makefile b/libfrog/Makefile
> index 560bad417ee4..268fa26638d7 100644
> --- a/libfrog/Makefile
> +++ b/libfrog/Makefile
> @@ -24,6 +24,7 @@ fsproperties.c \
>  fsprops.c \
>  getparents.c \
>  histogram.c \
> +file_attr.c \
>  list_sort.c \
>  linux.c \
>  logging.c \
> @@ -55,6 +56,7 @@ fsprops.h \
>  getparents.h \
>  handle_priv.h \
>  histogram.h \
> +file_attr.h \
>  logging.h \
>  paths.h \
>  projects.h \
> diff --git a/libfrog/file_attr.c b/libfrog/file_attr.c
> new file mode 100644
> index 000000000000..1d42895477ae
> --- /dev/null
> +++ b/libfrog/file_attr.c
> @@ -0,0 +1,122 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2024 Red Hat, Inc.

Nit: You might as well make that 2025

> + * All Rights Reserved.
> + */
> +
> +#include "file_attr.h"
> +#include <stdio.h>
> +#include <errno.h>
> +#include <string.h>
> +#include <sys/syscall.h>
> +#include <asm/types.h>
> +#include <fcntl.h>
> +
> +static void
> +file_attr_to_fsxattr(
> +	const struct file_attr	*fa,
> +	struct fsxattr		*fsxa)
> +{
> +     memset(fsxa, 0, sizeof(struct fsxattr));
> +
> +     fsxa->fsx_xflags = fa->fa_xflags;
> +     fsxa->fsx_extsize = fa->fa_extsize;
> +     fsxa->fsx_nextents = fa->fa_nextents;
> +     fsxa->fsx_projid = fa->fa_projid;
> +     fsxa->fsx_cowextsize = fa->fa_cowextsize;
> +
> +}
> +
> +static void
> +fsxattr_to_file_attr(
> +	const struct fsxattr	*fsxa,
> +	struct file_attr	*fa)
> +{
> +     memset(fa, 0, sizeof(struct file_attr));
> +
> +     fa->fa_xflags = fsxa->fsx_xflags;
> +     fa->fa_extsize = fsxa->fsx_extsize;
> +     fa->fa_nextents = fsxa->fsx_nextents;
> +     fa->fa_projid = fsxa->fsx_projid;
> +     fa->fa_cowextsize = fsxa->fsx_cowextsize;
> +}
> +
> +int
> +xfrog_file_getattr(
> +	const int		dfd,
> +	const char		*path,
> +	const struct stat	*stat,
> +	struct file_attr	*fa,
> +	const unsigned int	at_flags)
> +{
> +	int			error;
> +	int			fd;
> +	struct fsxattr		fsxa;
> +
> +#ifdef HAVE_FILE_ATTR
> +        error = syscall(__NR_file_getattr, dfd, path, fa,
> +                        sizeof(struct file_attr), at_flags);

Nit: ^^^^^^^^^^ tabs, not spaces, for indenting please.

> +	if (error && errno != ENOSYS)
> +		return error;
> +
> +	if (!error)
> +		return error;
> +#endif
> +
> +	if (SPECIAL_FILE(stat->st_mode)) {
> +		errno = EOPNOTSUPP;
> +		return -1;
> +	}
> +
> +	fd = open(path, O_RDONLY|O_NOCTTY);
> +	if (fd == -1)
> +		return fd;
> +
> +	error = ioctl(fd, FS_IOC_FSGETXATTR, &fsxa);
> +	close(fd);
> +	if (error)
> +		return error;
> +
> +	fsxattr_to_file_attr(&fsxa, fa);
> +
> +	return error;
> +}
> +
> +int
> +xfrog_file_setattr(
> +	const int		dfd,
> +	const char		*path,
> +	const struct stat	*stat,
> +	struct file_attr	*fa,
> +	const unsigned int	at_flags)
> +{
> +	int			error;
> +	int			fd;
> +	struct fsxattr		fsxa;
> +
> +#ifdef HAVE_FILE_ATTR
> +	error = syscall(__NR_file_setattr, dfd, path, fa,
> +			sizeof(struct file_attr), at_flags);
> +	if (error && errno != ENOSYS)
> +		return error;
> +
> +	if (!error)
> +		return error;
> +#endif
> +
> +	if (SPECIAL_FILE(stat->st_mode)) {
> +		errno = EOPNOTSUPP;
> +		return -1;
> +	}
> +
> +	fd = open(path, O_RDONLY|O_NOCTTY);
> +	if (fd == -1)
> +		return fd;
> +
> +	file_attr_to_fsxattr(fa, &fsxa);
> +
> +	error = ioctl(fd, FS_IOC_FSSETXATTR, fa);
> +	close(fd);
> +
> +	return error;
> +}
> diff --git a/libfrog/file_attr.h b/libfrog/file_attr.h
> new file mode 100644
> index 000000000000..ad33241bbffa
> --- /dev/null
> +++ b/libfrog/file_attr.h
> @@ -0,0 +1,35 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2024 Red Hat, Inc.
> + * All Rights Reserved.
> + */
> +#ifndef __LIBFROG_FILE_ATTR_H__
> +#define __LIBFROG_FILE_ATTR_H__
> +
> +#include "linux.h"
> +#include <sys/stat.h>
> +
> +#define SPECIAL_FILE(x) \
> +	   (S_ISCHR((x)) \
> +	|| S_ISBLK((x)) \
> +	|| S_ISFIFO((x)) \
> +	|| S_ISLNK((x)) \
> +	|| S_ISSOCK((x)))
> +
> +int
> +xfrog_file_getattr(
> +	const int		dfd,
> +	const char		*path,
> +	const struct stat	*stat,
> +	struct file_attr	*fa,
> +	const unsigned int	at_flags);
> +
> +int
> +xfrog_file_setattr(
> +	const int		dfd,
> +	const char		*path,
> +	const struct stat	*stat,
> +	struct file_attr	*fa,
> +	const unsigned int	at_flags);
> +
> +#endif /* __LIBFROG_FILE_ATTR_H__ */
> diff --git a/m4/package_libcdev.m4 b/m4/package_libcdev.m4
> index b77ac1a7580a..6a267dab7ab7 100644
> --- a/m4/package_libcdev.m4
> +++ b/m4/package_libcdev.m4
> @@ -274,3 +274,22 @@ AC_DEFUN([AC_PACKAGE_CHECK_LTO],
>      AC_SUBST(lto_cflags)
>      AC_SUBST(lto_ldflags)
>    ])
> +
> +#
> +# Check if we have a file_getattr/file_setattr system call (Linux)
> +#
> +AC_DEFUN([AC_HAVE_FILE_ATTR],

I would call the symbol AC_HAVE_FILE_GETATTR because you're not checking
the struct file_attr itself, just the syscall number.

Other than those nits, everything looks good here.

--D

> +  [ AC_MSG_CHECKING([for file_getattr/file_setattr syscalls])
> +    AC_LINK_IFELSE(
> +    [	AC_LANG_PROGRAM([[
> +#define _GNU_SOURCE
> +#include <sys/syscall.h>
> +#include <unistd.h>
> +	]], [[
> +syscall(__NR_file_getattr, 0, 0, 0, 0, 0);
> +	]])
> +    ], have_file_attr=yes
> +       AC_MSG_RESULT(yes),
> +       AC_MSG_RESULT(no))
> +    AC_SUBST(have_file_attr)
> +  ])
> 
> -- 
> 2.49.0
> 
> 

