Return-Path: <linux-fsdevel+bounces-61151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F9BB55A6A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Sep 2025 01:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DC3E3AD415
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 23:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBC82857CB;
	Fri, 12 Sep 2025 23:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3lgDImF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3067B284694;
	Fri, 12 Sep 2025 23:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757720293; cv=none; b=g+etZB2ez4qZjuEh4OV36GRtg/yHz2QKl1tpHpsG67CYtRkUsHKuM5nu+dIa4UNeICz4YWenMkkbm654bWsep6k14f6sBVqniVqRcYPWyTyCLiiEEhLcnGmVxS/IDVyiWq7/kGPiN0YWyjgJzuIdIY6k+7osGESeR9MIWxdJjhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757720293; c=relaxed/simple;
	bh=J6x5NdAJtybs0NMqanhdaut7jmNtBH9IL/zkzhaIKIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ch1PIABMpDySbxZvGjXf52X8a9UdhhRJmgoJ/xCJ+EF/GvoVivorJo59kOySE8crtQCyHEHqKBP9Kxzml/qA50cuO8xLsYgfs/xESvrNf99qNVNEAn2g6WrYEVY9UGm9DyFkvthtpgdSbknIxMr7zYyPoEqlqykH8LnICSRjTxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3lgDImF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA35C4CEF1;
	Fri, 12 Sep 2025 23:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757720292;
	bh=J6x5NdAJtybs0NMqanhdaut7jmNtBH9IL/zkzhaIKIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I3lgDImF6CDmGDZ6ktUfqrczE+ToJW0rCkwu8Ju0T+WiN7XZyBXmNbPHzbXcCEiaz
	 18Wr0nTkcWFncWK0D93Naw3poEtNxG8E7KRiTmgF4z1WvF1dzeSdxIkqSNQVxyVyhp
	 h7CmNa1jxdPR/IE4HUNNv5geranylS0Zd85u6kJGhv0y8MD9bWk3zub9eLYMri0lCD
	 tneeTX6aUcjleEvsQNpZZkjic1Cd9QQnthes+bLvYQjg0c/Zlh3QBfzzV6rs7NufOx
	 9ib1dYnUAYvxUUquRSPy9EI/jM5V/+ScZSKkXE2usjLsWGRMDC7b/NxlRJ1wACY+P9
	 Ss5GEJHiQppiA==
Date: Fri, 12 Sep 2025 16:38:12 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: aalbersh@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH v3 v3 1/4] libfrog: add wrappers for
 file_getattr/file_setattr syscalls
Message-ID: <20250912233812.GJ1587915@frogsfrogsfrogs>
References: <20250909-xattrat-syscall-v3-0-4407a714817e@kernel.org>
 <20250909-xattrat-syscall-v3-1-4407a714817e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909-xattrat-syscall-v3-1-4407a714817e@kernel.org>

On Tue, Sep 09, 2025 at 05:24:36PM +0200, Andrey Albershteyn wrote:
> Add wrappers for new file_getattr/file_setattr inode syscalls which will
> be used by xfs_quota and xfs_io.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>

Looks good now,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  configure.ac          |   1 +
>  include/builddefs.in  |   5 +++
>  include/linux.h       |  20 +++++++++
>  libfrog/Makefile      |   2 +
>  libfrog/file_attr.c   | 121 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  libfrog/file_attr.h   |  35 +++++++++++++++
>  m4/package_libcdev.m4 |  19 ++++++++
>  7 files changed, 203 insertions(+)
> 
> diff --git a/configure.ac b/configure.ac
> index 195ee6dddf61..0ba371c33147 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -156,6 +156,7 @@ AC_PACKAGE_NEED_RCU_INIT
>  AC_HAVE_PWRITEV2
>  AC_HAVE_COPY_FILE_RANGE
>  AC_HAVE_CACHESTAT
> +AC_HAVE_FILE_GETATTR
>  AC_NEED_INTERNAL_FSXATTR
>  AC_NEED_INTERNAL_FSCRYPT_ADD_KEY_ARG
>  AC_NEED_INTERNAL_FSCRYPT_POLICY_V2
> diff --git a/include/builddefs.in b/include/builddefs.in
> index 04b4e0880a84..b5aa1640711b 100644
> --- a/include/builddefs.in
> +++ b/include/builddefs.in
> @@ -97,6 +97,7 @@ HAVE_ZIPPED_MANPAGES = @have_zipped_manpages@
>  HAVE_PWRITEV2 = @have_pwritev2@
>  HAVE_COPY_FILE_RANGE = @have_copy_file_range@
>  HAVE_CACHESTAT = @have_cachestat@
> +HAVE_FILE_GETATTR = @have_file_getattr@
>  NEED_INTERNAL_FSXATTR = @need_internal_fsxattr@
>  NEED_INTERNAL_FSCRYPT_ADD_KEY_ARG = @need_internal_fscrypt_add_key_arg@
>  NEED_INTERNAL_FSCRYPT_POLICY_V2 = @need_internal_fscrypt_policy_v2@
> @@ -169,6 +170,10 @@ ifeq ($(ENABLE_GETTEXT),yes)
>  GCFLAGS += -DENABLE_GETTEXT
>  endif
>  
> +ifeq ($(HAVE_FILE_GETATTR),yes)
> +LCFLAGS += -DHAVE_FILE_GETATTR
> +endif
> +
>  # Override these if C++ needs other options
>  SANITIZER_CXXFLAGS = $(SANITIZER_CFLAGS)
>  GCXXFLAGS = $(GCFLAGS)
> diff --git a/include/linux.h b/include/linux.h
> index 6e83e073aa2e..cea468d2b9d8 100644
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
> + * Use FILE_ATTR_SIZE_VER0 (linux/fs.h) instead of build system
> + * HAVE_FILE_GETATTR as this header could be included in other places where
> + * HAVE_FILE_GETATTR is not defined (e.g. xfstests's conftest.c in ./configure)
> + */
> +#ifndef FILE_ATTR_SIZE_VER0
> +/*
> + * We need to define file_attr if it's missing to know how to convert it to
> + * fsxattr
> + */
> +struct file_attr {
> +	__u32	fa_xflags;
> +	__u32	fa_extsize;
> +	__u32	fa_nextents;
> +	__u32	fa_projid;
> +	__u32	fa_cowextsize;
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
> index 000000000000..bb51ac6eb2ef
> --- /dev/null
> +++ b/libfrog/file_attr.c
> @@ -0,0 +1,121 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2025 Red Hat, Inc.
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
> +	memset(fsxa, 0, sizeof(struct fsxattr));
> +
> +	fsxa->fsx_xflags = fa->fa_xflags;
> +	fsxa->fsx_extsize = fa->fa_extsize;
> +	fsxa->fsx_nextents = fa->fa_nextents;
> +	fsxa->fsx_projid = fa->fa_projid;
> +	fsxa->fsx_cowextsize = fa->fa_cowextsize;
> +}
> +
> +static void
> +fsxattr_to_file_attr(
> +	const struct fsxattr	*fsxa,
> +	struct file_attr	*fa)
> +{
> +	memset(fa, 0, sizeof(struct file_attr));
> +
> +	fa->fa_xflags = fsxa->fsx_xflags;
> +	fa->fa_extsize = fsxa->fsx_extsize;
> +	fa->fa_nextents = fsxa->fsx_nextents;
> +	fa->fa_projid = fsxa->fsx_projid;
> +	fa->fa_cowextsize = fsxa->fsx_cowextsize;
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
> +#ifdef HAVE_FILE_GETATTR
> +	error = syscall(__NR_file_getattr, dfd, path, fa,
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
> +#ifdef HAVE_FILE_GETATTR /* file_get/setattr goes together */
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
> index 000000000000..df9b6181d52c
> --- /dev/null
> +++ b/libfrog/file_attr.h
> @@ -0,0 +1,35 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2025 Red Hat, Inc.
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
> index b77ac1a7580a..28998e48ccdf 100644
> --- a/m4/package_libcdev.m4
> +++ b/m4/package_libcdev.m4
> @@ -274,3 +274,22 @@ AC_DEFUN([AC_PACKAGE_CHECK_LTO],
>      AC_SUBST(lto_cflags)
>      AC_SUBST(lto_ldflags)
>    ])
> +
> +#
> +# Check if we have a file_getattr system call (Linux)
> +#
> +AC_DEFUN([AC_HAVE_FILE_GETATTR],
> +  [AC_MSG_CHECKING([for file_getattr syscall])
> +    AC_LINK_IFELSE(
> +    [AC_LANG_PROGRAM([[
> +#define _GNU_SOURCE
> +#include <sys/syscall.h>
> +#include <unistd.h>
> +  ]], [[
> +syscall(__NR_file_getattr, 0, 0, 0, 0, 0);
> +  ]])
> +    ], have_file_getattr=yes
> +       AC_MSG_RESULT(yes),
> +       AC_MSG_RESULT(no))
> +    AC_SUBST(have_file_getattr)
> +  ])
> 
> -- 
> 2.50.1
> 
> 

