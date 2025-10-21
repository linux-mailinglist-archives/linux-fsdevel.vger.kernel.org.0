Return-Path: <linux-fsdevel+bounces-64908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DDABF6612
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 14:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F9EA503D56
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 12:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8AE2E62AC;
	Tue, 21 Oct 2025 12:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/ofNM8d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F7821578D;
	Tue, 21 Oct 2025 12:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761048684; cv=none; b=m4/GSAq3AFrkjU6di7m9yuoRFKj/nSfsyx2hgzvwnuvfBnyL+wygBiKnZygCqkEBtEH52YkK6V++ljY+Xl2wLpd0n4ipPd4cI/EOcJW2UCCeZy5+SiU/aqWocPyxVYyUWRwJFkmq5FcbAvfz1khFUDZCi0q7F4arkw0hevIjvn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761048684; c=relaxed/simple;
	bh=/eyJC7fFL048bFoOv3Vd5zRpz+YmvbCWpbBDrYeqJ4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4JNkKnpbZB0xS+G+cqD+rc8prjE0NURVHMO6aqgJX17gMkxJkz5PRFkZYc36vqsatKR+3N01C5/W/WdyXQQ5KpjzAw0onNP7rktpwj1CGGDAAliY1Oa+bnqAOzZGZgWcvWzdRWO21eXGLwfKHBVqGIK4a+5mdjj61TuVzKz39I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/ofNM8d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61AE3C4CEF1;
	Tue, 21 Oct 2025 12:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761048683;
	bh=/eyJC7fFL048bFoOv3Vd5zRpz+YmvbCWpbBDrYeqJ4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G/ofNM8dLE4QN47TBergBYTAz+pzCCiMxRGUsPpvr8R66SjiUBIsGKzbm8aZ1dvtN
	 tAQR5OY7NKxHAEWP5pPaoyEwehxgjBI1YtbZz102AOT9/S5LLOshs6PzH0mbBFmkfv
	 1Za3X8ToV9J6GlEOUG3Z/B4EXeCzB4KSVBIyFEyVjE4xPSDFHwbrnP39qIYKa9ulBp
	 EKq6DQChiDEL5RN7bYZUMOLnTFdh2TNV1BwY4UpEeSUnTmujffW6ebNRgzWzGtja1X
	 k7caRPnGg/yVV5XWkqQU2e+xXeHynMWhGAN4xf2HlsqtV9lg0nFYJ3mzGtHmDdN8NG
	 TeHcLFUeU23PA==
Date: Tue, 21 Oct 2025 14:11:17 +0200
From: Christian Brauner <brauner@kernel.org>
To: Bhavik Sachdev <b.sachdev1904@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>, 
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Jan Kara <jack@suse.cz>, John Garry <john.g.garry@oracle.com>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, "Darrick J . Wong" <djwong@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, Andrei Vagin <avagin@gmail.com>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Subject: Re: [PATCH v2 1/1] statmount: accept fd as a parameter
Message-ID: <20251021-blaumeise-verfassen-b8361569b6aa@brauner>
References: <20251011124753.1820802-1-b.sachdev1904@gmail.com>
 <20251011124753.1820802-2-b.sachdev1904@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251011124753.1820802-2-b.sachdev1904@gmail.com>

On Sat, Oct 11, 2025 at 06:16:11PM +0530, Bhavik Sachdev wrote:
> Extend `struct mnt_id_req` to take in a fd and introduce STATMOUNT_FD
> flag. When a valid fd is provided and STATMOUNT_FD is set, statmount
> will return mountinfo about the mount the fd is on.
> 
> This even works for "unmounted" mounts (mounts that have been umounted
> using umount2(mnt, MNT_DETACH)), if you have access to a file descriptor
> on that mount. These "umounted" mounts will have no mountpoint hence we
> return "[detached]" and the mnt_ns_id to be 0.
> 
> Co-developed-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
> Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
> Signed-off-by: Bhavik Sachdev <b.sachdev1904@gmail.com>
> ---
>  fs/namespace.c             | 80 ++++++++++++++++++++++++++++----------
>  include/uapi/linux/mount.h |  8 ++++
>  2 files changed, 67 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index d82910f33dc4..eb82a22cffd5 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -5207,6 +5207,12 @@ static int statmount_mnt_root(struct kstatmount *s, struct seq_file *seq)
>  	return 0;
>  }
>  
> +static int statmount_mnt_point_detached(struct kstatmount *s, struct seq_file *seq)
> +{
> +	seq_puts(seq, "[detached]");
> +	return 0;
> +}
> +
>  static int statmount_mnt_point(struct kstatmount *s, struct seq_file *seq)
>  {
>  	struct vfsmount *mnt = s->mnt;
> @@ -5262,7 +5268,10 @@ static int statmount_sb_source(struct kstatmount *s, struct seq_file *seq)
>  static void statmount_mnt_ns_id(struct kstatmount *s, struct mnt_namespace *ns)
>  {
>  	s->sm.mask |= STATMOUNT_MNT_NS_ID;
> -	s->sm.mnt_ns_id = ns->ns.ns_id;
> +	if (ns)
> +		s->sm.mnt_ns_id = ns->ns.ns_id;
> +	else
> +		s->sm.mnt_ns_id = 0;
>  }
>  
>  static int statmount_mnt_opts(struct kstatmount *s, struct seq_file *seq)
> @@ -5431,7 +5440,10 @@ static int statmount_string(struct kstatmount *s, u64 flag)
>  		break;
>  	case STATMOUNT_MNT_POINT:
>  		offp = &sm->mnt_point;
> -		ret = statmount_mnt_point(s, seq);
> +		if (!s->root.mnt && !s->root.dentry)
> +			ret = statmount_mnt_point_detached(s, seq);
> +		else
> +			ret = statmount_mnt_point(s, seq);
>  		break;
>  	case STATMOUNT_MNT_OPTS:
>  		offp = &sm->mnt_opts;
> @@ -5572,29 +5584,33 @@ static int grab_requested_root(struct mnt_namespace *ns, struct path *root)
>  
>  /* locks: namespace_shared */
>  static int do_statmount(struct kstatmount *s, u64 mnt_id, u64 mnt_ns_id,
> -			struct mnt_namespace *ns)
> +			struct mnt_namespace *ns, unsigned int flags)
>  {
>  	struct mount *m;
>  	int err;
>  
>  	/* Has the namespace already been emptied? */
> -	if (mnt_ns_id && mnt_ns_empty(ns))
> +	if (!(flags & STATMOUNT_FD) && mnt_ns_id && mnt_ns_empty(ns))
>  		return -ENOENT;
>  
> -	s->mnt = lookup_mnt_in_ns(mnt_id, ns);
> -	if (!s->mnt)
> -		return -ENOENT;
> +	if (!(flags & STATMOUNT_FD)) {
> +		s->mnt = lookup_mnt_in_ns(mnt_id, ns);
> +		if (!s->mnt)
> +			return -ENOENT;
> +	}
>  
> -	err = grab_requested_root(ns, &s->root);
> -	if (err)
> -		return err;
> +	if (ns) {
> +		err = grab_requested_root(ns, &s->root);
> +		if (err)
> +			return err;
> +	}
>  
>  	/*
>  	 * Don't trigger audit denials. We just want to determine what
>  	 * mounts to show users.
>  	 */
>  	m = real_mount(s->mnt);
> -	if (!is_path_reachable(m, m->mnt.mnt_root, &s->root) &&
> +	if (ns && !is_path_reachable(m, m->mnt.mnt_root, &s->root) &&
>  	    !ns_capable_noaudit(ns->user_ns, CAP_SYS_ADMIN))
>  		return -EPERM;
>  
> @@ -5718,12 +5734,12 @@ static int prepare_kstatmount(struct kstatmount *ks, struct mnt_id_req *kreq,
>  }
>  
>  static int copy_mnt_id_req(const struct mnt_id_req __user *req,
> -			   struct mnt_id_req *kreq)
> +			   struct mnt_id_req *kreq, unsigned int flags)
>  {
>  	int ret;
>  	size_t usize;
>  
> -	BUILD_BUG_ON(sizeof(struct mnt_id_req) != MNT_ID_REQ_SIZE_VER1);
> +	BUILD_BUG_ON(sizeof(struct mnt_id_req) != MNT_ID_REQ_SIZE_VER2);
>  
>  	ret = get_user(usize, &req->size);
>  	if (ret)
> @@ -5738,6 +5754,11 @@ static int copy_mnt_id_req(const struct mnt_id_req __user *req,
>  		return ret;
>  	if (kreq->spare != 0)
>  		return -EINVAL;
> +	if (flags & STATMOUNT_FD) {
> +		if (kreq->fd < 0)
> +			return -EINVAL;
> +		return 0;
> +	}
>  	/* The first valid unique mount id is MNT_UNIQUE_ID_OFFSET + 1. */
>  	if (kreq->mnt_id <= MNT_UNIQUE_ID_OFFSET)
>  		return -EINVAL;
> @@ -5788,23 +5809,37 @@ SYSCALL_DEFINE4(statmount, const struct mnt_id_req __user *, req,
>  {
>  	struct mnt_namespace *ns __free(mnt_ns_release) = NULL;
>  	struct kstatmount *ks __free(kfree) = NULL;
> +	struct vfsmount *fd_mnt;
>  	struct mnt_id_req kreq;
>  	/* We currently support retrieval of 3 strings. */
>  	size_t seq_size = 3 * PATH_MAX;
>  	int ret;
>  
> -	if (flags)
> +	if (flags & ~STATMOUNT_FD)
>  		return -EINVAL;
>  
> -	ret = copy_mnt_id_req(req, &kreq);
> +	ret = copy_mnt_id_req(req, &kreq, flags);
>  	if (ret)
>  		return ret;
>  
> -	ns = grab_requested_mnt_ns(&kreq);
> -	if (!ns)
> -		return -ENOENT;
> +	if (flags & STATMOUNT_FD) {
> +		CLASS(fd_raw, f)(kreq.fd);
> +		if (fd_empty(f))
> +			return -EBADF;
> +		fd_mnt = fd_file(f)->f_path.mnt;
> +		ns = real_mount(fd_mnt)->mnt_ns;
> +		if (ns)
> +			refcount_inc(&ns->passive);
> +		else
> +			if (!ns_capable_noaudit(fd_file(f)->f_cred->user_ns, CAP_SYS_ADMIN))
> +				return -ENOENT;
> +	} else {
> +		ns = grab_requested_mnt_ns(&kreq);
> +		if (!ns)
> +			return -ENOENT;
> +	}
>  
> -	if (kreq.mnt_ns_id && (ns != current->nsproxy->mnt_ns) &&
> +	if (ns && (ns != current->nsproxy->mnt_ns) &&
>  	    !ns_capable_noaudit(ns->user_ns, CAP_SYS_ADMIN))
>  		return -ENOENT;
>  
> @@ -5817,8 +5852,11 @@ SYSCALL_DEFINE4(statmount, const struct mnt_id_req __user *, req,
>  	if (ret)
>  		return ret;
>  
> +	if (flags & STATMOUNT_FD)
> +		ks->mnt = fd_mnt;

The reference to fd_mount is bound to the scope of CLASS(fd_raw, f)(kreq.fd) above.
That means you don't hold a reference to fd_mnt here and so this is a UAF waiting to happen.

> +
>  	scoped_guard(namespace_shared)
> -		ret = do_statmount(ks, kreq.mnt_id, kreq.mnt_ns_id, ns);
> +		ret = do_statmount(ks, kreq.mnt_id, kreq.mnt_ns_id, ns, flags);
>  
>  	if (!ret)
>  		ret = copy_statmount_to_user(ks);
> @@ -5957,7 +5995,7 @@ SYSCALL_DEFINE4(listmount, const struct mnt_id_req __user *, req,
>  	if (!access_ok(mnt_ids, nr_mnt_ids * sizeof(*mnt_ids)))
>  		return -EFAULT;
>  
> -	ret = copy_mnt_id_req(req, &kreq);
> +	ret = copy_mnt_id_req(req, &kreq, 0);
>  	if (ret)
>  		return ret;
>  
> diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
> index 7fa67c2031a5..dfe8b8e7fa8d 100644
> --- a/include/uapi/linux/mount.h
> +++ b/include/uapi/linux/mount.h
> @@ -201,11 +201,14 @@ struct mnt_id_req {
>  	__u64 mnt_id;
>  	__u64 param;
>  	__u64 mnt_ns_id;
> +	__s32 fd;
> +	__u32 spare2;
>  };

Hm, do you really need a new field? You could just use the @spare
parameter in struct mnt_id_req. It's currently validated of not being
allowed to be non-zero in copy_mnt_id_req() which is used by both
statmount() and listmount().

I think you could just reuse it for this purpose in statmount(). And
then maybe the flag should be STATMOUNT_BY_FD?

Otherwise I think this could work.

>  
>  /* List of all mnt_id_req versions. */
>  #define MNT_ID_REQ_SIZE_VER0	24 /* sizeof first published struct */
>  #define MNT_ID_REQ_SIZE_VER1	32 /* sizeof second published struct */
> +#define MNT_ID_REQ_SIZE_VER2	40 /* sizeof third published struct */
>  
>  /*
>   * @mask bits for statmount(2)
> @@ -232,4 +235,9 @@ struct mnt_id_req {
>  #define LSMT_ROOT		0xffffffffffffffff	/* root mount */
>  #define LISTMOUNT_REVERSE	(1 << 0) /* List later mounts first */
>  
> +/*
> + * @flag bits for statmount(2)
> + */
> +#define STATMOUNT_FD		0x0000001U /* want mountinfo for given fd */
> +
>  #endif /* _UAPI_LINUX_MOUNT_H */
> -- 
> 2.51.0
> 

