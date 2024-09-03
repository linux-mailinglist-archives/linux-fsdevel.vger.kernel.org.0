Return-Path: <linux-fsdevel+bounces-28326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B85969626
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 09:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D147285805
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 07:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C804200101;
	Tue,  3 Sep 2024 07:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pnb8TiV1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43BB1CE6E6;
	Tue,  3 Sep 2024 07:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725349968; cv=none; b=Ti1EjaeZaGpG6JogDyELzwslNeA+idRHQ3mLWh4NEVMZihpLMI0FRn8zbDFzSW5kw6/TXnV0tMzldoAfFaPsJLf+vbDombrmMJu1NyJCScHc1IjMxe4AVa8BVRDH2ducPhSODsy1KKtRq8jf/O5CRe+9SBGzW3bZ62mUgtV8VKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725349968; c=relaxed/simple;
	bh=Snfq8ziAYjBDXEZXlWx2Lnss5CBoJyZ/z0LStNXWZVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oH61f9qpOkGk1oTIJqL1mIl2GpEgDknBB2pK1Qf7QME1rsaD5Vgpv3Qap+DQIeNIyk7WHf7W0QFEERdutKGUSBamfL/abzk8FpIOdYk3eQ78xRyoJQolL9qVzzraVoSBZC3ldPQR2DNZEZrTdrPNIZDqm2aon508FdKzjAyHhho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pnb8TiV1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA83AC4CEC5;
	Tue,  3 Sep 2024 07:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725349968;
	bh=Snfq8ziAYjBDXEZXlWx2Lnss5CBoJyZ/z0LStNXWZVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pnb8TiV1oHoESN7211jsWxmgvCiUWsIMhXI2TNsQqd0cesFFjMx2Pkb3k0bDeUxfS
	 J0ALJ60pP+Cg97LgQM7NBz2vGe1c/Ujq22NoEtPhaHLZR7mn1UoqVBCry3CcNZr7Cd
	 lhaON23k3pFV16pg9y5Wk1rlL4PgSKFD9JKkGTYz8UgncxosNYXq13Lc43Pw6EWVYo
	 Axpssajk56WJj/4bwiQZhGUlUxj8472ofRLvnheGW42lSnYdBZBo4YvRcV27cnLGoH
	 kkCIm8E8itQ+NY2biklQ/UJGE4kb+sAmqBf87hkPmHRpqL7O9zg/2+FOAfNoy0wKVq
	 aCSZOxo42CAEw==
Date: Tue, 3 Sep 2024 09:52:43 +0200
From: Christian Brauner <brauner@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: chandanbabu@kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/1] xfs: introduce new file range commit ioctls
Message-ID: <20240903-kapelle-anregen-6b346d4dbead@brauner>
References: <172530104958.3324894.994059142950589764.stgit@frogsfrogsfrogs>
 <172530104976.3324894.7457187634523547516.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <172530104976.3324894.7457187634523547516.stgit@frogsfrogsfrogs>

On Mon, Sep 02, 2024 at 11:23:07AM GMT, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> This patch introduces two more new ioctls to manage atomic updates to
> file contents -- XFS_IOC_START_COMMIT and XFS_IOC_COMMIT_RANGE.  The
> commit mechanism here is exactly the same as what XFS_IOC_EXCHANGE_RANGE
> does, but with the additional requirement that file2 cannot have changed
> since some sampling point.  The start-commit ioctl performs the sampling
> of file attributes.
> 
> Note: This patch currently samples i_ctime during START_COMMIT and
> checks that it hasn't changed during COMMIT_RANGE.  This isn't entirely
> safe in kernels prior to 6.12 because ctime only had coarse grained
> granularity and very fast updates could collide with a COMMIT_RANGE.
> With the multi-granularity ctime introduced by Jeff Layton, it's now
> possible to update ctime such that this does not happen.
> 
> It is critical, then, that this patch must not be backported to any
> kernel that does not support fine-grained file change timestamps.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> Acked-by: Jeff Layton <jlayton@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/xfs/libxfs/xfs_fs.h |   26 +++++++++
>  fs/xfs/xfs_exchrange.c |  143 ++++++++++++++++++++++++++++++++++++++++++++++++
>  fs/xfs/xfs_exchrange.h |   16 +++++
>  fs/xfs/xfs_ioctl.c     |    4 +
>  fs/xfs/xfs_trace.h     |   57 +++++++++++++++++++
>  5 files changed, 243 insertions(+), 3 deletions(-)
> 
> 
> diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
> index 454b63ef7201..c85c8077fac3 100644
> --- a/fs/xfs/libxfs/xfs_fs.h
> +++ b/fs/xfs/libxfs/xfs_fs.h
> @@ -825,6 +825,30 @@ struct xfs_exchange_range {
>  	__u64		flags;		/* see XFS_EXCHANGE_RANGE_* below */
>  };
>  
> +/*
> + * Using the same definition of file2 as struct xfs_exchange_range, commit the
> + * contents of file1 into file2 if file2 has the same inode number, mtime, and
> + * ctime as the arguments provided to the call.  The old contents of file2 will
> + * be moved to file1.
> + *
> + * Returns -EBUSY if there isn't an exact match for the file2 fields.
> + *
> + * Filesystems must be able to restart and complete the operation even after
> + * the system goes down.
> + */
> +struct xfs_commit_range {
> +	__s32		file1_fd;
> +	__u32		pad;		/* must be zeroes */
> +	__u64		file1_offset;	/* file1 offset, bytes */
> +	__u64		file2_offset;	/* file2 offset, bytes */
> +	__u64		length;		/* bytes to exchange */
> +
> +	__u64		flags;		/* see XFS_EXCHANGE_RANGE_* below */
> +
> +	/* opaque file2 metadata for freshness checks */
> +	__u64		file2_freshness[6];
> +};
> +
>  /*
>   * Exchange file data all the way to the ends of both files, and then exchange
>   * the file sizes.  This flag can be used to replace a file's contents with a
> @@ -997,6 +1021,8 @@ struct xfs_getparents_by_handle {
>  #define XFS_IOC_BULKSTAT	     _IOR ('X', 127, struct xfs_bulkstat_req)
>  #define XFS_IOC_INUMBERS	     _IOR ('X', 128, struct xfs_inumbers_req)
>  #define XFS_IOC_EXCHANGE_RANGE	     _IOW ('X', 129, struct xfs_exchange_range)
> +#define XFS_IOC_START_COMMIT	     _IOR ('X', 130, struct xfs_commit_range)
> +#define XFS_IOC_COMMIT_RANGE	     _IOW ('X', 131, struct xfs_commit_range)
>  /*	XFS_IOC_GETFSUUID ---------- deprecated 140	 */
>  
>  
> diff --git a/fs/xfs/xfs_exchrange.c b/fs/xfs/xfs_exchrange.c
> index c8a655c92c92..d0889190ab7f 100644
> --- a/fs/xfs/xfs_exchrange.c
> +++ b/fs/xfs/xfs_exchrange.c
> @@ -72,6 +72,34 @@ xfs_exchrange_estimate(
>  	return error;
>  }
>  
> +/*
> + * Check that file2's metadata agree with the snapshot that we took for the
> + * range commit request.
> + *
> + * This should be called after the filesystem has locked /all/ inode metadata
> + * against modification.
> + */
> +STATIC int
> +xfs_exchrange_check_freshness(
> +	const struct xfs_exchrange	*fxr,
> +	struct xfs_inode		*ip2)
> +{
> +	struct inode			*inode2 = VFS_I(ip2);
> +	struct timespec64		ctime = inode_get_ctime(inode2);
> +	struct timespec64		mtime = inode_get_mtime(inode2);
> +
> +	trace_xfs_exchrange_freshness(fxr, ip2);
> +
> +	/* Check that file2 hasn't otherwise been modified. */
> +	if (fxr->file2_ino != ip2->i_ino ||
> +	    fxr->file2_gen != inode2->i_generation ||
> +	    !timespec64_equal(&fxr->file2_ctime, &ctime) ||
> +	    !timespec64_equal(&fxr->file2_mtime, &mtime))
> +		return -EBUSY;
> +
> +	return 0;
> +}
> +
>  #define QRETRY_IP1	(0x1)
>  #define QRETRY_IP2	(0x2)
>  
> @@ -607,6 +635,12 @@ xfs_exchrange_prep(
>  	if (error || fxr->length == 0)
>  		return error;
>  
> +	if (fxr->flags & __XFS_EXCHANGE_RANGE_CHECK_FRESH2) {
> +		error = xfs_exchrange_check_freshness(fxr, ip2);
> +		if (error)
> +			return error;
> +	}
> +
>  	/* Attach dquots to both inodes before changing block maps. */
>  	error = xfs_qm_dqattach(ip2);
>  	if (error)
> @@ -719,7 +753,8 @@ xfs_exchange_range(
>  	if (fxr->file1->f_path.mnt != fxr->file2->f_path.mnt)
>  		return -EXDEV;
>  
> -	if (fxr->flags & ~XFS_EXCHANGE_RANGE_ALL_FLAGS)
> +	if (fxr->flags & ~(XFS_EXCHANGE_RANGE_ALL_FLAGS |
> +			 __XFS_EXCHANGE_RANGE_CHECK_FRESH2))
>  		return -EINVAL;
>  
>  	/* Userspace requests only honored for regular files. */
> @@ -802,3 +837,109 @@ xfs_ioc_exchange_range(
>  	fdput(file1);
>  	return error;
>  }
> +
> +/* Opaque freshness blob for XFS_IOC_COMMIT_RANGE */
> +struct xfs_commit_range_fresh {
> +	xfs_fsid_t	fsid;		/* m_fixedfsid */
> +	__u64		file2_ino;	/* inode number */
> +	__s64		file2_mtime;	/* modification time */
> +	__s64		file2_ctime;	/* change time */
> +	__s32		file2_mtime_nsec; /* mod time, nsec */
> +	__s32		file2_ctime_nsec; /* change time, nsec */
> +	__u32		file2_gen;	/* inode generation */
> +	__u32		magic;		/* zero */
> +};
> +#define XCR_FRESH_MAGIC	0x444F524B	/* DORK */
> +
> +/* Set up a commitrange operation by sampling file2's write-related attrs */
> +long
> +xfs_ioc_start_commit(
> +	struct file			*file,
> +	struct xfs_commit_range __user	*argp)
> +{
> +	struct xfs_commit_range		args = { };
> +	struct timespec64		ts;
> +	struct xfs_commit_range_fresh	*kern_f;
> +	struct xfs_commit_range_fresh	__user *user_f;
> +	struct inode			*inode2 = file_inode(file);
> +	struct xfs_inode		*ip2 = XFS_I(inode2);
> +	const unsigned int		lockflags = XFS_IOLOCK_SHARED |
> +						    XFS_MMAPLOCK_SHARED |
> +						    XFS_ILOCK_SHARED;
> +
> +	BUILD_BUG_ON(sizeof(struct xfs_commit_range_fresh) !=
> +		     sizeof(args.file2_freshness));
> +
> +	kern_f = (struct xfs_commit_range_fresh *)&args.file2_freshness;
> +
> +	memcpy(&kern_f->fsid, ip2->i_mount->m_fixedfsid, sizeof(xfs_fsid_t));
> +
> +	xfs_ilock(ip2, lockflags);
> +	ts = inode_get_ctime(inode2);
> +	kern_f->file2_ctime		= ts.tv_sec;
> +	kern_f->file2_ctime_nsec	= ts.tv_nsec;
> +	ts = inode_get_mtime(inode2);
> +	kern_f->file2_mtime		= ts.tv_sec;
> +	kern_f->file2_mtime_nsec	= ts.tv_nsec;
> +	kern_f->file2_ino		= ip2->i_ino;
> +	kern_f->file2_gen		= inode2->i_generation;
> +	kern_f->magic			= XCR_FRESH_MAGIC;
> +	xfs_iunlock(ip2, lockflags);
> +
> +	user_f = (struct xfs_commit_range_fresh __user *)&argp->file2_freshness;
> +	if (copy_to_user(user_f, kern_f, sizeof(*kern_f)))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
> +/*
> + * Exchange file1 and file2 contents if file2 has not been written since the
> + * start commit operation.
> + */
> +long
> +xfs_ioc_commit_range(
> +	struct file			*file,
> +	struct xfs_commit_range __user	*argp)
> +{
> +	struct xfs_exchrange		fxr = {
> +		.file2			= file,
> +	};
> +	struct xfs_commit_range		args;
> +	struct xfs_commit_range_fresh	*kern_f;
> +	struct xfs_inode		*ip2 = XFS_I(file_inode(file));
> +	struct xfs_mount		*mp = ip2->i_mount;
> +	struct fd			file1;
> +	int				error;
> +
> +	kern_f = (struct xfs_commit_range_fresh *)&args.file2_freshness;
> +
> +	if (copy_from_user(&args, argp, sizeof(args)))
> +		return -EFAULT;
> +	if (args.flags & ~XFS_EXCHANGE_RANGE_ALL_FLAGS)
> +		return -EINVAL;
> +	if (kern_f->magic != XCR_FRESH_MAGIC)
> +		return -EBUSY;
> +	if (memcmp(&kern_f->fsid, mp->m_fixedfsid, sizeof(xfs_fsid_t)))
> +		return -EBUSY;

So, I mentioned this before in another mail a few months ago and I think
you liked the idea so just as a reminder in case you forgot:

Ioctls are extensible if done correctly:

switch (__IOC_NR(ioctl)) {
	case _IOC_NR(XFS_IOC_START_COMMIT): {
	        size_t usize = _IOC_SIZE(ioctl);
		struct xfs_commit_range	args;

		if (usize < XFS_IOC_START_COMMIT_SIZE_VER0)
                        return -EINVAL;

		if (copy_struct_from_user(&args, sizeof(args), argp, usize))
			return -EFAULT;
	}

If you code it this way, relying on copy_struct_from_user() right from
the start you can easily extend your struct in a backward and forward
compatible manner.

}

> +
> +	fxr.file1_offset	= args.file1_offset;
> +	fxr.file2_offset	= args.file2_offset;
> +	fxr.length		= args.length;
> +	fxr.flags		= args.flags | __XFS_EXCHANGE_RANGE_CHECK_FRESH2;
> +	fxr.file2_ino		= kern_f->file2_ino;
> +	fxr.file2_gen		= kern_f->file2_gen;
> +	fxr.file2_mtime.tv_sec	= kern_f->file2_mtime;
> +	fxr.file2_mtime.tv_nsec	= kern_f->file2_mtime_nsec;
> +	fxr.file2_ctime.tv_sec	= kern_f->file2_ctime;
> +	fxr.file2_ctime.tv_nsec	= kern_f->file2_ctime_nsec;
> +
> +	file1 = fdget(args.file1_fd);
> +	if (!file1.file)
> +		return -EBADF;

Please use CLASS(fd, f)(args.file1_fd) :)

> +	fxr.file1 = file1.file;
> +
> +	error = xfs_exchange_range(&fxr);
> +	fdput(file1);
> +	return error;
> +}
> diff --git a/fs/xfs/xfs_exchrange.h b/fs/xfs/xfs_exchrange.h
> index 039abcca546e..bc1298aba806 100644
> --- a/fs/xfs/xfs_exchrange.h
> +++ b/fs/xfs/xfs_exchrange.h
> @@ -10,8 +10,12 @@
>  #define __XFS_EXCHANGE_RANGE_UPD_CMTIME1	(1ULL << 63)
>  #define __XFS_EXCHANGE_RANGE_UPD_CMTIME2	(1ULL << 62)
>  
> +/* Freshness check required */
> +#define __XFS_EXCHANGE_RANGE_CHECK_FRESH2	(1ULL << 61)
> +
>  #define XFS_EXCHANGE_RANGE_PRIV_FLAGS	(__XFS_EXCHANGE_RANGE_UPD_CMTIME1 | \
> -					 __XFS_EXCHANGE_RANGE_UPD_CMTIME2)
> +					 __XFS_EXCHANGE_RANGE_UPD_CMTIME2 | \
> +					 __XFS_EXCHANGE_RANGE_CHECK_FRESH2)
>  
>  struct xfs_exchrange {
>  	struct file		*file1;
> @@ -22,10 +26,20 @@ struct xfs_exchrange {
>  	u64			length;
>  
>  	u64			flags;	/* XFS_EXCHANGE_RANGE flags */
> +
> +	/* file2 metadata for freshness checks */
> +	u64			file2_ino;
> +	struct timespec64	file2_mtime;
> +	struct timespec64	file2_ctime;
> +	u32			file2_gen;
>  };
>  
>  long xfs_ioc_exchange_range(struct file *file,
>  		struct xfs_exchange_range __user *argp);
> +long xfs_ioc_start_commit(struct file *file,
> +		struct xfs_commit_range __user *argp);
> +long xfs_ioc_commit_range(struct file *file,
> +		struct xfs_commit_range __user	*argp);
>  
>  struct xfs_exchmaps_req;
>  
> diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> index 6b13666d4e96..90b3ee21e7fe 100644
> --- a/fs/xfs/xfs_ioctl.c
> +++ b/fs/xfs/xfs_ioctl.c
> @@ -1518,6 +1518,10 @@ xfs_file_ioctl(
>  
>  	case XFS_IOC_EXCHANGE_RANGE:
>  		return xfs_ioc_exchange_range(filp, arg);
> +	case XFS_IOC_START_COMMIT:
> +		return xfs_ioc_start_commit(filp, arg);
> +	case XFS_IOC_COMMIT_RANGE:
> +		return xfs_ioc_commit_range(filp, arg);
>  
>  	default:
>  		return -ENOTTY;
> diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
> index 180ce697305a..4cf0fa71ba9c 100644
> --- a/fs/xfs/xfs_trace.h
> +++ b/fs/xfs/xfs_trace.h
> @@ -4926,7 +4926,8 @@ DEFINE_INODE_ERROR_EVENT(xfs_exchrange_error);
>  	{ XFS_EXCHANGE_RANGE_DRY_RUN,		"DRY_RUN" }, \
>  	{ XFS_EXCHANGE_RANGE_FILE1_WRITTEN,	"F1_WRITTEN" }, \
>  	{ __XFS_EXCHANGE_RANGE_UPD_CMTIME1,	"CMTIME1" }, \
> -	{ __XFS_EXCHANGE_RANGE_UPD_CMTIME2,	"CMTIME2" }
> +	{ __XFS_EXCHANGE_RANGE_UPD_CMTIME2,	"CMTIME2" }, \
> +	{ __XFS_EXCHANGE_RANGE_CHECK_FRESH2,	"FRESH2" }
>  
>  /* file exchange-range tracepoint class */
>  DECLARE_EVENT_CLASS(xfs_exchrange_class,
> @@ -4986,6 +4987,60 @@ DEFINE_EXCHRANGE_EVENT(xfs_exchrange_prep);
>  DEFINE_EXCHRANGE_EVENT(xfs_exchrange_flush);
>  DEFINE_EXCHRANGE_EVENT(xfs_exchrange_mappings);
>  
> +TRACE_EVENT(xfs_exchrange_freshness,
> +	TP_PROTO(const struct xfs_exchrange *fxr, struct xfs_inode *ip2),
> +	TP_ARGS(fxr, ip2),
> +	TP_STRUCT__entry(
> +		__field(dev_t, dev)
> +		__field(xfs_ino_t, ip2_ino)
> +		__field(long long, ip2_mtime)
> +		__field(long long, ip2_ctime)
> +		__field(int, ip2_mtime_nsec)
> +		__field(int, ip2_ctime_nsec)
> +
> +		__field(xfs_ino_t, file2_ino)
> +		__field(long long, file2_mtime)
> +		__field(long long, file2_ctime)
> +		__field(int, file2_mtime_nsec)
> +		__field(int, file2_ctime_nsec)
> +	),
> +	TP_fast_assign(
> +		struct timespec64	ts64;
> +		struct inode		*inode2 = VFS_I(ip2);
> +
> +		__entry->dev = inode2->i_sb->s_dev;
> +		__entry->ip2_ino = ip2->i_ino;
> +
> +		ts64 = inode_get_ctime(inode2);
> +		__entry->ip2_ctime = ts64.tv_sec;
> +		__entry->ip2_ctime_nsec = ts64.tv_nsec;
> +
> +		ts64 = inode_get_mtime(inode2);
> +		__entry->ip2_mtime = ts64.tv_sec;
> +		__entry->ip2_mtime_nsec = ts64.tv_nsec;
> +
> +		__entry->file2_ino = fxr->file2_ino;
> +		__entry->file2_mtime = fxr->file2_mtime.tv_sec;
> +		__entry->file2_ctime = fxr->file2_ctime.tv_sec;
> +		__entry->file2_mtime_nsec = fxr->file2_mtime.tv_nsec;
> +		__entry->file2_ctime_nsec = fxr->file2_ctime.tv_nsec;
> +	),
> +	TP_printk("dev %d:%d "
> +		  "ino 0x%llx mtime %lld:%d ctime %lld:%d -> "
> +		  "file 0x%llx mtime %lld:%d ctime %lld:%d",
> +		  MAJOR(__entry->dev), MINOR(__entry->dev),
> +		  __entry->ip2_ino,
> +		  __entry->ip2_mtime,
> +		  __entry->ip2_mtime_nsec,
> +		  __entry->ip2_ctime,
> +		  __entry->ip2_ctime_nsec,
> +		  __entry->file2_ino,
> +		  __entry->file2_mtime,
> +		  __entry->file2_mtime_nsec,
> +		  __entry->file2_ctime,
> +		  __entry->file2_ctime_nsec)
> +);
> +
>  TRACE_EVENT(xfs_exchmaps_overhead,
>  	TP_PROTO(struct xfs_mount *mp, unsigned long long bmbt_blocks,
>  		 unsigned long long rmapbt_blocks),
> 

