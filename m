Return-Path: <linux-fsdevel+bounces-43146-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F8FA4EACC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 19:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE3A67A32B7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 18:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0907255230;
	Tue,  4 Mar 2025 17:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nin0Afx2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B82123A989;
	Tue,  4 Mar 2025 17:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741110753; cv=none; b=jb7fzp4xf5N6Bp2jylV8OAw+YHH4wEXn+5ZB0///yPI2rAiHDtHIT6N21x+nbEnvousBJK6WpH8tPCYhwvIiDjD59e6VybVGLBkrxYtAWk/HUXtE2LbXr1TBXm7IWwJW6KMG+mYmzBdfQkjQAl8S3bHEZmwHpfBayPgSjCGq2pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741110753; c=relaxed/simple;
	bh=DBWrQCJHN4jVaCkIg21oc/RwrUdMwfIuD9JbJEWUsME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Li8sNweqOHLeRAvD5lqFCusAzccyqOsvpF6cXlc0m4+TnXIcxPQZFKG2SVYjQPTrA33RDt1xBqpVAdkJ154MLd4SWNxextsvG2eL88tgaJhhr5I2GTMCp5XX2C5wTcVZ6+zgA2ENp1+7zWKeyl3ZYgOuzets6+NdhchEgyh5tPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nin0Afx2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6F6C4CEE5;
	Tue,  4 Mar 2025 17:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741110752;
	bh=DBWrQCJHN4jVaCkIg21oc/RwrUdMwfIuD9JbJEWUsME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nin0Afx2HbEbTqdlL/21qO9m5S0Ml7d1asUhiJYJTMO8wbm1WqDTZB6gErb4eFUX0
	 JYMaJXt7cmi8K7iKRweAfb3rqbHlHt9I9x0zZnw7Fo/myKZBsn6jgM+uMUGBpHoN0K
	 SBDpc9EPISihVtJiEGbzApmiF/2o4GHye3KP+TQoY8MjlF57+Iuucmhr3bSICMyoEd
	 +ySJv43XvXRVt525fi1chnpq8FdQ1uUOQDsII2fpgIpO3v4g0Jzd1AnGMkKS4aOHih
	 CYmxWOoeWiGWtACJ9ThIR1YD2xHxasEaaEw33Ws7mmkTODA1AaRxDAUohNZVaaOqkY
	 CEt/YA+hfGR2g==
Date: Tue, 4 Mar 2025 09:52:32 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v1 1/3] configure: xfs_io: Add support for preadv2
Message-ID: <20250304175232.GB2803749@frogsfrogsfrogs>
References: <cover.1741087191.git.ritesh.list@gmail.com>
 <046cc1b4dc00f8fb8997ec6ebedc9b3625f34c1c.1741087191.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <046cc1b4dc00f8fb8997ec6ebedc9b3625f34c1c.1741087191.git.ritesh.list@gmail.com>

On Tue, Mar 04, 2025 at 05:25:35PM +0530, Ritesh Harjani (IBM) wrote:
> preadv2() was introduced in Linux 4.6. This patch adds support for
> preadv2() to xfs_io.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  configure.ac          |  1 +
>  include/builddefs.in  |  1 +
>  io/Makefile           |  4 ++++
>  io/pread.c            | 45 ++++++++++++++++++++++++++++---------------
>  m4/package_libcdev.m4 | 18 +++++++++++++++++
>  5 files changed, 54 insertions(+), 15 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 8c76f398..658117ad 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -153,6 +153,7 @@ AC_PACKAGE_NEED_URCU_H
>  AC_PACKAGE_NEED_RCU_INIT
>  
>  AC_HAVE_PWRITEV2
> +AC_HAVE_PREADV2

I wonder, will we ever encounter a C library that has pwritev2 and /not/
preadv2?

>  AC_HAVE_COPY_FILE_RANGE
>  AC_NEED_INTERNAL_FSXATTR
>  AC_NEED_INTERNAL_FSCRYPT_ADD_KEY_ARG
> diff --git a/include/builddefs.in b/include/builddefs.in
> index 82840ec7..a11d201c 100644
> --- a/include/builddefs.in
> +++ b/include/builddefs.in
> @@ -94,6 +94,7 @@ ENABLE_SCRUB	= @enable_scrub@
>  HAVE_ZIPPED_MANPAGES = @have_zipped_manpages@
>  
>  HAVE_PWRITEV2 = @have_pwritev2@
> +HAVE_PREADV2 = @have_preadv2@
>  HAVE_COPY_FILE_RANGE = @have_copy_file_range@
>  NEED_INTERNAL_FSXATTR = @need_internal_fsxattr@
>  NEED_INTERNAL_FSCRYPT_ADD_KEY_ARG = @need_internal_fscrypt_add_key_arg@
> diff --git a/io/Makefile b/io/Makefile
> index 8f835ec7..f8b19ac5 100644
> --- a/io/Makefile
> +++ b/io/Makefile
> @@ -69,6 +69,10 @@ ifeq ($(HAVE_PWRITEV2),yes)
>  LCFLAGS += -DHAVE_PWRITEV2
>  endif
>  
> +ifeq ($(HAVE_PREADV2),yes)
> +LCFLAGS += -DHAVE_PREADV2
> +endif
> +
>  ifeq ($(HAVE_MAP_SYNC),yes)
>  LCFLAGS += -DHAVE_MAP_SYNC
>  endif
> diff --git a/io/pread.c b/io/pread.c
> index 62c771fb..782f2a36 100644
> --- a/io/pread.c
> +++ b/io/pread.c
> @@ -162,7 +162,8 @@ static ssize_t
>  do_preadv(
>  	int		fd,
>  	off_t		offset,
> -	long long	count)
> +	long long	count,
> +	int 		preadv2_flags)

Nit:       ^ space before tab.  There's a bunch more of thense, every
time a "preadv2_flags" variable or parameter are declared.

>  {
>  	int		vecs = 0;
>  	ssize_t		oldlen = 0;
> @@ -181,8 +182,14 @@ do_preadv(
>  	} else {
>  		vecs = vectors;
>  	}
> +#ifdef HAVE_PREADV2
> +	if (preadv2_flags)
> +		bytes = preadv2(fd, iov, vectors, offset, preadv2_flags);
> +	else
> +		bytes = preadv(fd, iov, vectors, offset);
> +#else
>  	bytes = preadv(fd, iov, vectors, offset);
> -
> +#endif

Can we have the case that preadv2_flags!=0 and HAVE_PREADV2 isn't
defined?  If so, then there ought to be a warning about that.

--D

>  	/* restore trimmed iov */
>  	if (oldlen)
>  		iov[vecs - 1].iov_len = oldlen;
> @@ -195,12 +202,13 @@ do_pread(
>  	int		fd,
>  	off_t		offset,
>  	long long	count,
> -	size_t		buffer_size)
> +	size_t		buffer_size,
> +	int 		preadv2_flags)
>  {
>  	if (!vectors)
>  		return pread(fd, io_buffer, min(count, buffer_size), offset);
>  
> -	return do_preadv(fd, offset, count);
> +	return do_preadv(fd, offset, count, preadv2_flags);
>  }
>  
>  static int
> @@ -210,7 +218,8 @@ read_random(
>  	long long	count,
>  	long long	*total,
>  	unsigned int	seed,
> -	int		eof)
> +	int		eof,
> +	int 	preadv2_flags)
>  {
>  	off_t		end, off, range;
>  	ssize_t		bytes;
> @@ -234,7 +243,7 @@ read_random(
>  				io_buffersize;
>  		else
>  			off = offset;
> -		bytes = do_pread(fd, off, io_buffersize, io_buffersize);
> +		bytes = do_pread(fd, off, io_buffersize, io_buffersize, preadv2_flags);
>  		if (bytes == 0)
>  			break;
>  		if (bytes < 0) {
> @@ -256,7 +265,8 @@ read_backward(
>  	off_t		*offset,
>  	long long	*count,
>  	long long	*total,
> -	int		eof)
> +	int		eof,
> +	int 	preadv2_flags)
>  {
>  	off_t		end, off = *offset;
>  	ssize_t		bytes = 0, bytes_requested;
> @@ -276,7 +286,7 @@ read_backward(
>  	/* Do initial unaligned read if needed */
>  	if ((bytes_requested = (off % io_buffersize))) {
>  		off -= bytes_requested;
> -		bytes = do_pread(fd, off, bytes_requested, io_buffersize);
> +		bytes = do_pread(fd, off, bytes_requested, io_buffersize, preadv2_flags);
>  		if (bytes == 0)
>  			return ops;
>  		if (bytes < 0) {
> @@ -294,7 +304,7 @@ read_backward(
>  	while (cnt > end) {
>  		bytes_requested = min(cnt, io_buffersize);
>  		off -= bytes_requested;
> -		bytes = do_pread(fd, off, cnt, io_buffersize);
> +		bytes = do_pread(fd, off, cnt, io_buffersize, preadv2_flags);
>  		if (bytes == 0)
>  			break;
>  		if (bytes < 0) {
> @@ -318,14 +328,15 @@ read_forward(
>  	long long	*total,
>  	int		verbose,
>  	int		onlyone,
> -	int		eof)
> +	int		eof,
> +	int 	preadv2_flags)
>  {
>  	ssize_t		bytes;
>  	int		ops = 0;
>  
>  	*total = 0;
>  	while (count > 0 || eof) {
> -		bytes = do_pread(fd, offset, count, io_buffersize);
> +		bytes = do_pread(fd, offset, count, io_buffersize, preadv2_flags);
>  		if (bytes == 0)
>  			break;
>  		if (bytes < 0) {
> @@ -353,7 +364,7 @@ read_buffer(
>  	int		verbose,
>  	int		onlyone)
>  {
> -	return read_forward(fd, offset, count, total, verbose, onlyone, 0);
> +	return read_forward(fd, offset, count, total, verbose, onlyone, 0, 0);
>  }
>  
>  static int
> @@ -371,6 +382,7 @@ pread_f(
>  	int		Cflag, qflag, uflag, vflag;
>  	int		eof = 0, direction = IO_FORWARD;
>  	int		c;
> +	int 	preadv2_flags = 0;
>  
>  	Cflag = qflag = uflag = vflag = 0;
>  	init_cvtnum(&fsblocksize, &fssectsize);
> @@ -463,15 +475,18 @@ pread_f(
>  	case IO_RANDOM:
>  		if (!zeed)	/* srandom seed */
>  			zeed = time(NULL);
> -		c = read_random(file->fd, offset, count, &total, zeed, eof);
> +		c = read_random(file->fd, offset, count, &total, zeed, eof,
> +						preadv2_flags);
>  		break;
>  	case IO_FORWARD:
> -		c = read_forward(file->fd, offset, count, &total, vflag, 0, eof);
> +		c = read_forward(file->fd, offset, count, &total, vflag, 0, eof,
> +						 preadv2_flags);
>  		if (eof)
>  			count = total;
>  		break;
>  	case IO_BACKWARD:
> -		c = read_backward(file->fd, &offset, &count, &total, eof);
> +		c = read_backward(file->fd, &offset, &count, &total, eof,
> +						  preadv2_flags);
>  		break;
>  	default:
>  		ASSERT(0);
> diff --git a/m4/package_libcdev.m4 b/m4/package_libcdev.m4
> index 4ef7e8f6..5a1f748a 100644
> --- a/m4/package_libcdev.m4
> +++ b/m4/package_libcdev.m4
> @@ -16,6 +16,24 @@ pwritev2(0, 0, 0, 0, 0);
>      AC_SUBST(have_pwritev2)
>    ])
>  
> +#
> +# Check if we have a preadv2 libc call (Linux)
> +#
> +AC_DEFUN([AC_HAVE_PREADV2],
> +  [ AC_MSG_CHECKING([for preadv2])
> +    AC_LINK_IFELSE(
> +    [	AC_LANG_PROGRAM([[
> +#define _GNU_SOURCE
> +#include <sys/uio.h>
> +	]], [[
> +preadv2(0, 0, 0, 0, 0);
> +	]])
> +    ], have_preadv2=yes
> +       AC_MSG_RESULT(yes),
> +       AC_MSG_RESULT(no))
> +    AC_SUBST(have_preadv2)
> +  ])
> +
>  #
>  # Check if we have a copy_file_range system call (Linux)
>  #
> -- 
> 2.48.1
> 
> 

