Return-Path: <linux-fsdevel+bounces-72958-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0C8D0672D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 23:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3067B3027595
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 22:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6156D328613;
	Thu,  8 Jan 2026 22:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="zGZXUVbH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FC5284B58
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jan 2026 22:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767911873; cv=none; b=fPO77fKifQMoq9GGSXjLtTbhHkkWuezxeJklBfIJd/C1pUvAL1MPt9hw6Ba/tu9NYrrs9JFtllGW3GISGZvJGw8W07OAscqUpotUC/rb+gxsGEd7RGyim5PV5mAJB3SY8oJ5J1DNZq/6L0GboFL3eiaEYJfsh1PZuKoC5e3ZRsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767911873; c=relaxed/simple;
	bh=8T9un7bQZqCWWJpLdpWCOztOTuOxvWt7nodiP1VzcOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7wx6hMiYY2MgkexztXmjS/ykfmH9CLhiTCkyW1Td5rVevBe+l4BT/woysRExwig4XdDpdIbC/FZ/7pPiHz9BSODfQtMSyBDgPtVZ19ugkAxInHlZSuxlKYWUbx/39Y1JKTpBDmio2ixEFetECOacTMqvQPsb8NfIuDT6nprh1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=zGZXUVbH; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dnKY60flqz9t13;
	Thu,  8 Jan 2026 23:37:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1767911866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lb3G72x+9lJW6xgQtqGt7+IxZmNLXxA58wBSmLtKKZU=;
	b=zGZXUVbH3mW9FbaxtmcbG9Vv7jpM6xROpe9g70JDvlahQfSACNzUsGxBXAPUcAl9hipFMi
	pV3LPOHzI7LLLNs9d6+d5CyoRIWefgs+EaaNn8F0ekQDf1FDGIDZWDHLROxRZhNmOYFqYS
	OwAsyCRwxM9YiU50D3s07yzpuxmSndwoqvEvI0vdAGZu8swg8Aj09hM+5u10gWky2MvA48
	C+91RnQ7m63MmaUA1zzobtAiioMtetF5NKzINgOhc6ND/xCKjNoIVtIlKr3+9dqmv7nNXc
	65NlKwU1HhlL8tLgGxkpoZIDwe3nUsZZN6BMO5AAg1sdO8hvFEW2MuaiEkJWyg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
Date: Thu, 8 Jan 2026 23:37:41 +0100
From: Aleksa Sarai <cyphar@cyphar.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Amir Goldstein <amir73il@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 1/2] mount: add OPEN_TREE_NAMESPACE
Message-ID: <2026-01-07-oldest-grim-captions-spills-ywC2O3@cyphar.com>
References: <20251229-work-empty-namespace-v1-0-bfb24c7b061f@kernel.org>
 <20251229-work-empty-namespace-v1-1-bfb24c7b061f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ucipoh2vbvfm5tzq"
Content-Disposition: inline
In-Reply-To: <20251229-work-empty-namespace-v1-1-bfb24c7b061f@kernel.org>
X-Rspamd-Queue-Id: 4dnKY60flqz9t13


--ucipoh2vbvfm5tzq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] mount: add OPEN_TREE_NAMESPACE
MIME-Version: 1.0

On 2025-12-29, Christian Brauner <brauner@kernel.org> wrote:
> When creating containers the setup usually involves using CLONE_NEWNS
> via clone3() or unshare(). This copies the caller's complete mount
> namespace. The runtime will also assemble a new rootfs and then use
> pivot_root() to switch the old mount tree with the new rootfs. Afterward
> it will recursively umount the old mount tree thereby getting rid of all
> mounts.
>=20
> On a basic system here where the mount table isn't particularly large
> this still copies about 30 mounts. Copying all of these mounts only to
> get rid of them later is pretty wasteful.
>=20
> This is exacerbated if intermediary mount namespaces are used that only
> exist for a very short amount of time and are immediately destroyed
> again causing a ton of mounts to be copied and destroyed needlessly.
>=20
> With a large mount table and a system where thousands or ten-thousands
> of containers are spawned in parallel this quickly becomes a bottleneck
> increasing contention on the semaphore.
>=20
> Extend open_tree() with a new OPEN_TREE_NAMESPACE flag. Similar to
> OPEN_TREE_CLONE only the indicated mount tree is copied. Instead of
> returning a file descriptor referring to that mount tree
> OPEN_TREE_NAMESPACE will cause open_tree() to return a file descriptor
> to a new mount namespace. In that new mount namespace the copied mount
> tree has been mounted on top of a copy of the real rootfs.
>=20
> The caller can setns() into that mount namespace and perform any
> additionally required setup such as move_mount() detached mounts in
> there.
>=20
> This allows OPEN_TREE_NAMESPACE to function as a combined
> unshare(CLONE_NEWNS) and pivot_root().
>=20
> A caller may for example choose to create an extremely minimal rootfs:
>=20
> fd_mntns =3D open_tree(-EBADF, "/var/lib/containers/wootwoot", OPEN_TREE_=
NAMESPACE);
>=20
> This will create a mount namespace where "wootwoot" has become the
> rootfs mounted on top of the real rootfs. The caller can now setns()
> into this new mount namespace and assemble additional mounts.
>=20
> This also works with user namespaces:
>=20
> unshare(CLONE_NEWUSER);
> fd_mntns =3D open_tree(-EBADF, "/var/lib/containers/wootwoot", OPEN_TREE_=
NAMESPACE);
>=20
> which creates a new mount namespace owned by the earlier created user
> namespace with "wootwoot" as the rootfs mounted on top of the real
> rootfs.

I think there are a few other things I would really like (with my runc
hat on), such as being able to move_mount(2) into this new kind of
OPEN_TREE_NAMESPACE handle.

However, on the whole I think this seems very reasonable and is much
simpler than I anticipated when we talked about this at LPC. I've just
taken a general look but feel free to take my

Reviewed-by: Aleksa Sarai <cyphar@cyphar.com>

and also maybe a

Suggested-by: Aleksa Sarai <cyphar@cyphar.com>

If you feel it's appropriate, since we came up with this together at
LPC? ;)

> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/internal.h              |   1 +
>  fs/namespace.c             | 155 +++++++++++++++++++++++++++++++++++++++=
+-----
>  fs/nsfs.c                  |  13 ++++
>  include/uapi/linux/mount.h |   3 +-
>  4 files changed, 155 insertions(+), 17 deletions(-)
>=20
> diff --git a/fs/internal.h b/fs/internal.h
> index ab638d41ab81..b5aad5265e0e 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -247,6 +247,7 @@ extern void mnt_pin_kill(struct mount *m);
>   */
>  extern const struct dentry_operations ns_dentry_operations;
>  int open_namespace(struct ns_common *ns);
> +struct file *open_namespace_file(struct ns_common *ns);
> =20
>  /*
>   * fs/stat.c:
> diff --git a/fs/namespace.c b/fs/namespace.c
> index c58674a20cad..fd9698671c70 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2796,6 +2796,9 @@ static inline void unlock_mount(struct pinned_mount=
point *m)
>  		__unlock_mount(m);
>  }
> =20
> +static void lock_mount_exact(const struct path *path,
> +			     struct pinned_mountpoint *mp);
> +
>  #define LOCK_MOUNT_MAYBE_BENEATH(mp, path, beneath) \
>  	struct pinned_mountpoint mp __cleanup(unlock_mount) =3D {}; \
>  	do_lock_mount((path), &mp, (beneath))
> @@ -2946,10 +2949,11 @@ static inline bool may_copy_tree(const struct pat=
h *path)
>  	return check_anonymous_mnt(mnt);
>  }
> =20
> -
> -static struct mount *__do_loopback(const struct path *old_path, int recu=
rse)
> +static struct mount *__do_loopback(const struct path *old_path,
> +				   unsigned int flags, unsigned int copy_flags)
>  {
>  	struct mount *old =3D real_mount(old_path->mnt);
> +	bool recurse =3D flags & AT_RECURSIVE;
> =20
>  	if (IS_MNT_UNBINDABLE(old))
>  		return ERR_PTR(-EINVAL);
> @@ -2960,10 +2964,22 @@ static struct mount *__do_loopback(const struct p=
ath *old_path, int recurse)
>  	if (!recurse && __has_locked_children(old, old_path->dentry))
>  		return ERR_PTR(-EINVAL);
> =20
> +	/*
> +	 * When creating a new mount namespace we don't want to copy over
> +	 * mounts of mount namespaces to avoid the risk of cycles and also to
> +	 * minimize the default complex interdependencies between mount
> +	 * namespaces.
> +	 *
> +	 * We could ofc just check whether all mount namespace files aren't
> +	 * creating cycles but really let's keep this simple.
> +	 */
> +	if (!(flags & OPEN_TREE_NAMESPACE))
> +		copy_flags |=3D CL_COPY_MNT_NS_FILE;

I kind of think this is a somewhat theoretical issue but I don't think
we'll be bitten by it. My gut feeling is that I'd prefer this to be an
OPEN_TREE_* flag that you have to set (so we can support this in the
future) but that's kinda ugly too...

> +
>  	if (recurse)
> -		return copy_tree(old, old_path->dentry, CL_COPY_MNT_NS_FILE);
> -	else
> -		return clone_mnt(old, old_path->dentry, 0);
> +		return copy_tree(old, old_path->dentry, copy_flags);
> +
> +	return clone_mnt(old, old_path->dentry, copy_flags);
>  }
> =20
>  /*
> @@ -2974,7 +2990,9 @@ static int do_loopback(const struct path *path, con=
st char *old_name,
>  {
>  	struct path old_path __free(path_put) =3D {};
>  	struct mount *mnt =3D NULL;
> +	unsigned int flags =3D recurse ? AT_RECURSIVE : 0;
>  	int err;
> +
>  	if (!old_name || !*old_name)
>  		return -EINVAL;
>  	err =3D kern_path(old_name, LOOKUP_FOLLOW|LOOKUP_AUTOMOUNT, &old_path);
> @@ -2991,7 +3009,7 @@ static int do_loopback(const struct path *path, con=
st char *old_name,
>  	if (!check_mnt(mp.parent))
>  		return -EINVAL;
> =20
> -	mnt =3D __do_loopback(&old_path, recurse);
> +	mnt =3D __do_loopback(&old_path, flags, 0);
>  	if (IS_ERR(mnt))
>  		return PTR_ERR(mnt);
> =20
> @@ -3004,7 +3022,7 @@ static int do_loopback(const struct path *path, con=
st char *old_name,
>  	return err;
>  }
> =20
> -static struct mnt_namespace *get_detached_copy(const struct path *path, =
bool recursive)
> +static struct mnt_namespace *get_detached_copy(const struct path *path, =
unsigned int flags)
>  {
>  	struct mnt_namespace *ns, *mnt_ns =3D current->nsproxy->mnt_ns, *src_mn=
t_ns;
>  	struct user_namespace *user_ns =3D mnt_ns->user_ns;
> @@ -3029,7 +3047,7 @@ static struct mnt_namespace *get_detached_copy(cons=
t struct path *path, bool rec
>  			ns->seq_origin =3D src_mnt_ns->ns.ns_id;
>  	}
> =20
> -	mnt =3D __do_loopback(path, recursive);
> +	mnt =3D __do_loopback(path, flags, 0);
>  	if (IS_ERR(mnt)) {
>  		emptied_ns =3D ns;
>  		return ERR_CAST(mnt);
> @@ -3043,9 +3061,9 @@ static struct mnt_namespace *get_detached_copy(cons=
t struct path *path, bool rec
>  	return ns;
>  }
> =20
> -static struct file *open_detached_copy(struct path *path, bool recursive)
> +static struct file *open_detached_copy(struct path *path, unsigned int f=
lags)
>  {
> -	struct mnt_namespace *ns =3D get_detached_copy(path, recursive);
> +	struct mnt_namespace *ns =3D get_detached_copy(path, flags);
>  	struct file *file;
> =20
>  	if (IS_ERR(ns))
> @@ -3061,21 +3079,114 @@ static struct file *open_detached_copy(struct pa=
th *path, bool recursive)
>  	return file;
>  }
> =20
> +DEFINE_FREE(put_empty_mnt_ns, struct mnt_namespace *,
> +	    if (!IS_ERR_OR_NULL(_T)) free_mnt_ns(_T))
> +
> +static struct file *open_new_namespace(struct path *path, unsigned int f=
lags)
> +{
> +	struct mnt_namespace *new_ns __free(put_empty_mnt_ns) =3D NULL;
> +	struct path to_path __free(path_put) =3D {};
> +	struct mnt_namespace *ns =3D current->nsproxy->mnt_ns;
> +	struct user_namespace *user_ns =3D current_user_ns();
> +	struct mount *new_ns_root;
> +	struct mount *mnt;
> +	struct ns_common *new_ns_common;
> +	unsigned int copy_flags =3D 0;
> +	bool locked =3D false;
> +
> +	if (user_ns !=3D ns->user_ns)
> +		copy_flags |=3D CL_SLAVE;
> +
> +	new_ns =3D alloc_mnt_ns(user_ns, false);
> +	if (IS_ERR(new_ns))
> +		return ERR_CAST(new_ns);
> +
> +	scoped_guard(namespace_excl) {
> +		new_ns_root =3D clone_mnt(ns->root, ns->root->mnt.mnt_root, copy_flags=
);
> +		if (IS_ERR(new_ns_root))
> +			return ERR_CAST(new_ns_root);
> +
> +		/*
> +		 * If the real rootfs had a locked mount on top of it somewhere
> +		 * in the stack, lock the new mount tree as well so it can't be
> +		 * exposed.
> +		 */
> +		mnt =3D ns->root;
> +		while (mnt->overmount) {
> +			mnt =3D mnt->overmount;
> +			if (mnt->mnt.mnt_flags & MNT_LOCKED)
> +				locked =3D true;
> +		}
> +	}
> +
> +	/*
> +	 * We dropped the namespace semaphore so we can actually lock
> +	 * the copy for mounting. The copied mount isn't attached to any
> +	 * mount namespace and it is thus excluded from any propagation.
> +	 * So realistically we're isolated and the mount can't be
> +	 * overmounted.
> +	 */
> +
> +	/* Borrow the reference from clone_mnt(). */
> +	to_path.mnt =3D &new_ns_root->mnt;
> +	to_path.dentry =3D dget(new_ns_root->mnt.mnt_root);
> +
> +	/* Now lock for actual mounting. */
> +	LOCK_MOUNT_EXACT(mp, &to_path);
> +	if (unlikely(IS_ERR(mp.parent)))
> +		return ERR_CAST(mp.parent);
> +
> +	/*
> +	 * We don't emulate unshare()ing a mount namespace. We stick to the
> +	 * restrictions of creating detached bind-mounts. It has a lot
> +	 * saner and simpler semantics.
> +	 */
> +	mnt =3D __do_loopback(path, flags, copy_flags);
> +	if (IS_ERR(mnt))
> +		return ERR_CAST(mnt);
> +
> +	scoped_guard(mount_writer) {
> +		if (locked)
> +			mnt->mnt.mnt_flags |=3D MNT_LOCKED;
> +		/*
> +		 * Now mount the detached tree on top of the copy of the
> +		 * real rootfs we created.
> +		 */
> +		attach_mnt(mnt, new_ns_root, mp.mp);
> +		if (user_ns !=3D ns->user_ns)
> +			lock_mnt_tree(new_ns_root);
> +	}
> +
> +	/* Add all mounts to the new namespace. */
> +	for (struct mount *p =3D new_ns_root; p; p =3D next_mnt(p, new_ns_root)=
) {
> +		mnt_add_to_ns(new_ns, p);
> +		new_ns->nr_mounts++;
> +	}
> +
> +	new_ns->root =3D real_mount(no_free_ptr(to_path.mnt));
> +	ns_tree_add_raw(new_ns);
> +	new_ns_common =3D to_ns_common(no_free_ptr(new_ns));
> +	return open_namespace_file(new_ns_common);
> +}
> +
>  static struct file *vfs_open_tree(int dfd, const char __user *filename, =
unsigned int flags)
>  {
>  	int ret;
>  	struct path path __free(path_put) =3D {};
>  	int lookup_flags =3D LOOKUP_AUTOMOUNT | LOOKUP_FOLLOW;
> -	bool detached =3D flags & OPEN_TREE_CLONE;
> =20
>  	BUILD_BUG_ON(OPEN_TREE_CLOEXEC !=3D O_CLOEXEC);
> =20
>  	if (flags & ~(AT_EMPTY_PATH | AT_NO_AUTOMOUNT | AT_RECURSIVE |
>  		      AT_SYMLINK_NOFOLLOW | OPEN_TREE_CLONE |
> -		      OPEN_TREE_CLOEXEC))
> +		      OPEN_TREE_CLOEXEC | OPEN_TREE_NAMESPACE))
>  		return ERR_PTR(-EINVAL);
> =20
> -	if ((flags & (AT_RECURSIVE | OPEN_TREE_CLONE)) =3D=3D AT_RECURSIVE)
> +	if ((flags & (AT_RECURSIVE | OPEN_TREE_CLONE | OPEN_TREE_NAMESPACE)) =
=3D=3D
> +	    AT_RECURSIVE)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (hweight32(flags & (OPEN_TREE_CLONE | OPEN_TREE_NAMESPACE)) > 1)
>  		return ERR_PTR(-EINVAL);
> =20
>  	if (flags & AT_NO_AUTOMOUNT)
> @@ -3085,15 +3196,27 @@ static struct file *vfs_open_tree(int dfd, const =
char __user *filename, unsigned
>  	if (flags & AT_EMPTY_PATH)
>  		lookup_flags |=3D LOOKUP_EMPTY;
> =20
> -	if (detached && !may_mount())
> +	/*
> +	 * If we create a new mount namespace with the cloned mount tree we
> +	 * just care about being privileged over our current user namespace.
> +	 * The new mount namespace will be owned by it.
> +	 */
> +	if ((flags & OPEN_TREE_NAMESPACE) &&
> +	    !ns_capable(current_user_ns(), CAP_SYS_ADMIN))
> +		return ERR_PTR(-EPERM);
> +
> +	if ((flags & OPEN_TREE_CLONE) && !may_mount())
>  		return ERR_PTR(-EPERM);
> =20
>  	ret =3D user_path_at(dfd, filename, lookup_flags, &path);
>  	if (unlikely(ret))
>  		return ERR_PTR(ret);
> =20
> -	if (detached)
> -		return open_detached_copy(&path, flags & AT_RECURSIVE);
> +	if (flags & OPEN_TREE_NAMESPACE)
> +		return open_new_namespace(&path, flags);
> +
> +	if (flags & OPEN_TREE_CLONE)
> +		return open_detached_copy(&path, flags);
> =20
>  	return dentry_open(&path, O_PATH, current_cred());
>  }
> diff --git a/fs/nsfs.c b/fs/nsfs.c
> index bf27d5da91f1..db91de208645 100644
> --- a/fs/nsfs.c
> +++ b/fs/nsfs.c
> @@ -99,6 +99,19 @@ int ns_get_path(struct path *path, struct task_struct =
*task,
>  	return ns_get_path_cb(path, ns_get_path_task, &args);
>  }
> =20
> +struct file *open_namespace_file(struct ns_common *ns)
> +{
> +	struct path path __free(path_put) =3D {};
> +	int err;
> +
> +	/* call first to consume reference */
> +	err =3D path_from_stashed(&ns->stashed, nsfs_mnt, ns, &path);
> +	if (err < 0)
> +		return ERR_PTR(err);
> +
> +	return dentry_open(&path, O_RDONLY, current_cred());
> +}
> +
>  /**
>   * open_namespace - open a namespace
>   * @ns: the namespace to open
> diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
> index 5d3f8c9e3a62..acbc22241c9c 100644
> --- a/include/uapi/linux/mount.h
> +++ b/include/uapi/linux/mount.h
> @@ -61,7 +61,8 @@
>  /*
>   * open_tree() flags.
>   */
> -#define OPEN_TREE_CLONE		1		/* Clone the target tree and attach the clon=
e */
> +#define OPEN_TREE_CLONE		(1 << 0)	/* Clone the target tree and attach th=
e clone */
> +#define OPEN_TREE_NAMESPACE	(1 << 1)	/* Clone the target tree into a new=
 mount namespace */
>  #define OPEN_TREE_CLOEXEC	O_CLOEXEC	/* Close the file on execve() */
> =20
>  /*
>=20
> --=20
> 2.47.3
>=20
>=20

--=20
Aleksa Sarai
https://www.cyphar.com/

--ucipoh2vbvfm5tzq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaWAxsRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG/I4QD+LTXmtOB7yQNRUZNy3uDJ
MUHV2c3IKSVSHVTGjQ7war8A/2d/rr4QZgIB2ICzH/r8DZMgcfWNEBN/HI4uP58U
DNUN
=m+1O
-----END PGP SIGNATURE-----

--ucipoh2vbvfm5tzq--

