Return-Path: <linux-fsdevel+bounces-63167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9192BB0448
	for <lists+linux-fsdevel@lfdr.de>; Wed, 01 Oct 2025 14:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 683943BC181
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Oct 2025 12:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FBB2E92CF;
	Wed,  1 Oct 2025 12:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jg9/bQtn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6021E5B72;
	Wed,  1 Oct 2025 12:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759320140; cv=none; b=TKAwhiFE6Zo8CtOtWvdfHlR/dRQyw2CItmuNs/kZPM0i1HgMx4ludvHfL06vtWxmFGFwz2jK+U7MKUOKeqznmQNoIA5Pkz2UXBJUzQBIozEZCPBXuCRIS9oq2Q3SSClg2RaoTR10l84O6e5WgnUoan/sODjwrWkN3DjpdqsQvAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759320140; c=relaxed/simple;
	bh=x2gcfm9rEn7fzGNxSfAb9nh5wBLIXStZrfyOxfPSfxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7TWDHus7ZfyJ83qcUbIFZEXJq/ZUkY5gVa5rdFTMKIMbyRO7BY0aU2tbB8bd9p/5fVjozqXWDS+zT+GLslKE1Cz+U6HjUdbf5gq1YElPNxxEi6s4FiCExrG7oEmgojBpifH2giDthkxgfj5cZX4gqfUn+O+/wdFmW6QvuHOwlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jg9/bQtn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D361C4CEF4;
	Wed,  1 Oct 2025 12:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759320139;
	bh=x2gcfm9rEn7fzGNxSfAb9nh5wBLIXStZrfyOxfPSfxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jg9/bQtncx6p+qhnz086sRK8fzpNmsrux64RijUq3Fu+A39c+epcLH4O3L7sSujMO
	 PfuF2A3e1mDdjTs7VfGgeTEIroSIrD1wwwmoNnzfOMVpyiQhBQVLj5+U/8/CUeA0O3
	 XOwsJaqg5SDy7nCajwuj4EyO0UoPGB1oIbK8x7pgc5UZ5zXybnrriWedGuE2EGTPvf
	 XMnIJjPibvFXSLaVkdPRaw7zlZsQ6V+8es/rURzF43dLniaNZRgrPMjooiRfm7qlw1
	 UKi5at6QAitr596c0ZmNPJynGNKEjl0y0J7j5y0N80vEwkLxhDti5T8p56DIxul5jl
	 Ps7twjgueHMFA==
Date: Wed, 1 Oct 2025 14:02:09 +0200
From: Carlos Maiolino <cem@kernel.org>
To: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, 
	Jonathan Corbet <corbet@lwn.net>, David Howells <dhowells@redhat.com>, 
	Paulo Alcantara <pc@manguebit.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-bcachefs@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org, david.hunter.linux@gmail.com
Subject: Re: [PATCH] fs: doc: Fix typos
Message-ID: <kp4tzf7hvtorldoktxelrvway6w4v4idmu5q3egeaacs7eg2tz@dovkk323ir3b>
References: <DrG_H24-pk-ha8vkOEHoZYVXyMFA60c_g4l7cZX4Z7lnKQIM4FjdI_qS-UIpFxa-t7T_JDAOSqKjew7M0wmYYw==@protonmail.internalid>
 <20251001083931.44528-1-bhanuseshukumar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001083931.44528-1-bhanuseshukumar@gmail.com>

On Wed, Oct 01, 2025 at 02:09:31PM +0530, Bhanu Seshu Kumar Valluri wrote:
> Fix typos in doc comments
> 
> Signed-off-by: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>

Perhaps would be better to split this into subsystem-specific patches?

This probably needs to be re-sent anyway as bcachefs was removed from
mainline.


> ---
>  Note: No change in functionality intended.
> 
>  Documentation/filesystems/bcachefs/future/idle_work.rst  | 6 +++---
>  Documentation/filesystems/xfs/xfs-online-fsck-design.rst | 2 +-
>  fs/netfs/buffered_read.c                                 | 2 +-
>  fs/xfs/xfs_linux.h                                       | 2 +-
>  include/linux/fs.h                                       | 4 ++--
>  5 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/filesystems/bcachefs/future/idle_work.rst b/Documentation/filesystems/bcachefs/future/idle_work.rst
> index 59a332509dcd..f1202113dde0 100644
> --- a/Documentation/filesystems/bcachefs/future/idle_work.rst
> +++ b/Documentation/filesystems/bcachefs/future/idle_work.rst
> @@ -11,10 +11,10 @@ idle" so the system can go to sleep. We don't want to be dribbling out
>  background work while the system should be idle.
> 
>  The complicating factor is that there are a number of background tasks, which
> -form a heirarchy (or a digraph, depending on how you divide it up) - one
> +form a hierarchy (or a digraph, depending on how you divide it up) - one
>  background task may generate work for another.
> 
> -Thus proper idle detection needs to model this heirarchy.
> +Thus proper idle detection needs to model this hierarchy.
> 
>  - Foreground writes
>  - Page cache writeback
> @@ -51,7 +51,7 @@ IDLE REGIME
>  When the system becomes idle, we should start flushing our pending work
>  quicker so the system can go to sleep.
> 
> -Note that the definition of "idle" depends on where in the heirarchy a task
> +Note that the definition of "idle" depends on where in the hierarchy a task
>  is - a task should start flushing work more quickly when the task above it has
>  stopped generating new work.
> 
> diff --git a/Documentation/filesystems/xfs/xfs-online-fsck-design.rst b/Documentation/filesystems/xfs/xfs-online-fsck-design.rst
> index e231d127cd40..e872d480691b 100644
> --- a/Documentation/filesystems/xfs/xfs-online-fsck-design.rst
> +++ b/Documentation/filesystems/xfs/xfs-online-fsck-design.rst
> @@ -4179,7 +4179,7 @@ When the exchange is initiated, the sequence of operations is as follows:
>     This will be discussed in more detail in subsequent sections.
> 
>  If the filesystem goes down in the middle of an operation, log recovery will
> -find the most recent unfinished maping exchange log intent item and restart
> +find the most recent unfinished mapping exchange log intent item and restart
>  from there.
>  This is how atomic file mapping exchanges guarantees that an outside observer
>  will either see the old broken structure or the new one, and never a mismash of
> diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
> index 37ab6f28b5ad..c81be6390309 100644
> --- a/fs/netfs/buffered_read.c
> +++ b/fs/netfs/buffered_read.c
> @@ -329,7 +329,7 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq,
>   * the netfs if not.  Space beyond the EOF is zero-filled.  Multiple I/O
>   * requests from different sources will get munged together.  If necessary, the
>   * readahead window can be expanded in either direction to a more convenient
> - * alighment for RPC efficiency or to make storage in the cache feasible.
> + * alignment for RPC efficiency or to make storage in the cache feasible.
>   *
>   * The calling netfs must initialise a netfs context contiguous to the vfs
>   * inode before calling this.
> diff --git a/fs/xfs/xfs_linux.h b/fs/xfs/xfs_linux.h
> index 9a2221b4aa21..fdf3cd8c4d19 100644
> --- a/fs/xfs/xfs_linux.h
> +++ b/fs/xfs/xfs_linux.h
> @@ -145,7 +145,7 @@ static inline void delay(long ticks)
>  /*
>   * XFS wrapper structure for sysfs support. It depends on external data
>   * structures and is embedded in various internal data structures to implement
> - * the XFS sysfs object heirarchy. Define it here for broad access throughout
> + * the XFS sysfs object hierarchy. Define it here for broad access throughout
>   * the codebase.
>   */
>  struct xfs_kobj {
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 601d036a6c78..72e82a4a0bbc 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1040,7 +1040,7 @@ struct fown_struct {
>   * struct file_ra_state - Track a file's readahead state.
>   * @start: Where the most recent readahead started.
>   * @size: Number of pages read in the most recent readahead.
> - * @async_size: Numer of pages that were/are not needed immediately
> + * @async_size: Number of pages that were/are not needed immediately
>   *      and so were/are genuinely "ahead".  Start next readahead when
>   *      the first of these pages is accessed.
>   * @ra_pages: Maximum size of a readahead request, copied from the bdi.
> @@ -3149,7 +3149,7 @@ static inline void kiocb_start_write(struct kiocb *iocb)
> 
>  /**
>   * kiocb_end_write - drop write access to a superblock after async file io
> - * @iocb: the io context we sumbitted the write with
> + * @iocb: the io context we submitted the write with
>   *
>   * Should be matched with a call to kiocb_start_write().
>   */
> --
> 2.34.1
> 

