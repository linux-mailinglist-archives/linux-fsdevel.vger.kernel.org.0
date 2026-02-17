Return-Path: <linux-fsdevel+bounces-77360-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKzcJetclGm3DAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77360-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 13:19:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A30A14BE0B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 13:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7282C302B80C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 12:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD3D3382EE;
	Tue, 17 Feb 2026 12:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M70MJ1yK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7773382DB;
	Tue, 17 Feb 2026 12:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771330328; cv=none; b=JRKGZQC5j8uZz9f+tzyZQPmFbprxXTzn0X5WgVrdCiHOdSBS9Hcn1Qgd7OieBxGtA7FHjbanDM0KFNj3Hy6XYXeUOgkIrvRTboyfw0a9/1cmZB7A7uS53aMQMDCwIIwRnO/QujLn69VZG7SfMOAbAhLil14dfGhYbAJAYqGf+aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771330328; c=relaxed/simple;
	bh=Rcydk4mXqdLWbHZmqbD4HEaij5FTeX1Fh1B0jUiENik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9YKE3hL+CHBFunJFuYi8LmdqcV3yOloCIuOQ9TzlSfC1a2mMhuYN3mLpkO0coTZqQylA0W8q8b3LhIEyuOlUDZ9bIXLBwlGlz0d43bsxwqrjfOiSaVi8uYk+//hQjacj2NE0KMXVNH0HA0YBpJmuBkA+9Cu2wxnkFuyFHWbWAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M70MJ1yK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F9FC4CEF7;
	Tue, 17 Feb 2026 12:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771330327;
	bh=Rcydk4mXqdLWbHZmqbD4HEaij5FTeX1Fh1B0jUiENik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M70MJ1yKylncJkoHkYHpVHv6r6vckWIN4IdJr12M8fbHiF8y48OdP/Tos5mip4DQ3
	 3Vunyo1CWpQS/vsqcQ3qbNmQiK81NJ3r7EfoeLszZ5Vgy2sMu5kZ/RECTssIDtUQQ7
	 e+nrOuvYTE4kmBPJSqln2BZ4b/xQdGQ2Ma4Za0K+W5Kwk0vs8wS4UZTl0Vex6j+r63
	 5WVU4ZOK1RaUS0da1Q/Xjnhow9Ct96+QlKFH7d+VXut+4hcnVHctjCLLg1jD9cd0lB
	 M3Ik1De2Ertvh+29Efsp5TQW2EfmUn2YJjhbax23RiCqdvyhvIurargCZ2kLW2ZRR4
	 gTqdiydgiKf3w==
Date: Tue, 17 Feb 2026 13:12:03 +0100
From: Christian Brauner <brauner@kernel.org>
To: syzbot <syzbot+a89f9434fb5a001ccd58@syzkaller.appspotmail.com>
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [fs?] KASAN: slab-use-after-free Read in clone_mnt
Message-ID: <20260217-reingehen-garant-4ee90d168229@brauner>
References: <699047f6.050a0220.2757fb.0024.GAE@google.com>
 <20260214-werft-vorerst-0b3bf9610224@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="tzmuvbdsgyutgbdg"
Content-Disposition: inline
In-Reply-To: <20260214-werft-vorerst-0b3bf9610224@brauner>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=6428d17febdfb14e];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-diff];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77360-lists,linux-fsdevel=lfdr.de];
	GREYLIST(0.00)[pass,body];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,appspotmail.com:email,storage.googleapis.com:url,syzkaller.appspot.com:url];
	HAS_ATTACHMENT(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel,a89f9434fb5a001ccd58];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 0A30A14BE0B
X-Rspamd-Action: no action


--tzmuvbdsgyutgbdg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Sat, Feb 14, 2026 at 04:59:11PM +0100, Christian Brauner wrote:
> On Sat, Feb 14, 2026 at 02:01:26AM -0800, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    c22e26bd0906 Merge tag 'landlock-7.0-rc1' of git://git.ker..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=12c6a6e6580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=6428d17febdfb14e
> > dashboard link: https://syzkaller.appspot.com/bug?extid=a89f9434fb5a001ccd58
> > compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
> > 
> > Unfortunately, I don't have any reproducer for this issue yet.
> > 
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/b33c549157ca/disk-c22e26bd.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/34c7ded19553/vmlinux-c22e26bd.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/66faec2158ed/bzImage-c22e26bd.xz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+a89f9434fb5a001ccd58@syzkaller.appspotmail.com
> 
> Right, this should be fixed by the appended patch. If someone had the
> bright idea to make the real rootfs a shared or dependent mount and it
> is later copied the copy will become a peer of the old real rootfs mount
> or a dependent mount of it. If locking the new rootfs mount for mounting
> fails or the subsequent do_loopback() fails we rely on the copy of the
> real root mount to be cleaned up by path_put(). The problem is that this
> doesn't deal with mount propagation and will leave the mounts linked in
> the propagation lists. Fix this by actually unmounting the copied tree.

Actually lets just refactor this to be a bit cleaner as in the appended
patch. I plan on getting this upstream during this week.

--tzmuvbdsgyutgbdg
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0001-mount-hold-namespace_sem-across-copy-in-create_new_n.patch"

From 186af1baac0e03b0915287d31d8fcf237d9e5410 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Sat, 14 Feb 2026 16:22:13 +0100
Subject: [PATCH] mount: hold namespace_sem across copy in
 create_new_namespace()

Fix an oversight when creating a new mount namespace. If someone had the
bright idea to make the real rootfs a shared or dependent mount and it
is later copied the copy will become a peer of the old real rootfs mount
or a dependent mount of it. The namespace semaphore is dropped and we
use mount lock exact to lock the new real root mount. If that fails or
the subsequent do_loopback() fails we rely on the copy of the real root
mount to be cleaned up by path_put(). The problem is that this doesn't
deal with mount propagation and will leave the mounts linked in the
propagation lists.

When creating a new mount namespace create_new_namespace() first
acquires namespace_sem to clone the nullfs root, drops it, then
reacquires it via LOCK_MOUNT_EXACT which takes inode_lock first to
respect the inode_lock -> namespace_sem lock ordering. This
drop-and-reacquire pattern is fragile and was the source of the
propagation cleanup bug fixed in the preceding commit.

Extend lock_mount_exact() with a copy_mount mode that clones the mount
under the locks atomically. When copy_mount is true, path_overmounted()
is skipped since we're copying the mount, not mounting on top of it -
the nullfs root always has rootfs mounted on top so the check would
always fail. If clone_mnt() fails after get_mountpoint() has pinned the
mountpoint, __unlock_mount() is used to properly unpin the mountpoint
and release both locks.

This allows create_new_namespace() to use LOCK_MOUNT_EXACT_COPY which
takes inode_lock and namespace_sem once and holds them throughout the
clone and subsequent mount operations, eliminating the
drop-and-reacquire pattern entirely.

Reported-by: syzbot+a89f9434fb5a001ccd58@syzkaller.appspotmail.com
Fixes: 9b8a0ba68246 ("mount: add OPEN_TREE_NAMESPACE") # mainline only
Link: https://lore.kernel.org/699047f6.050a0220.2757fb.0024.GAE@google.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 112 +++++++++++++++++++++++++------------------------
 1 file changed, 58 insertions(+), 54 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 90700df65f0d..188be116f6e6 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2791,7 +2791,8 @@ static inline void unlock_mount(struct pinned_mountpoint *m)
 }
 
 static void lock_mount_exact(const struct path *path,
-			     struct pinned_mountpoint *mp);
+			     struct pinned_mountpoint *mp, bool copy_mount,
+			     unsigned int copy_flags);
 
 #define LOCK_MOUNT_MAYBE_BENEATH(mp, path, beneath) \
 	struct pinned_mountpoint mp __cleanup(unlock_mount) = {}; \
@@ -2799,7 +2800,10 @@ static void lock_mount_exact(const struct path *path,
 #define LOCK_MOUNT(mp, path) LOCK_MOUNT_MAYBE_BENEATH(mp, (path), false)
 #define LOCK_MOUNT_EXACT(mp, path) \
 	struct pinned_mountpoint mp __cleanup(unlock_mount) = {}; \
-	lock_mount_exact((path), &mp)
+	lock_mount_exact((path), &mp, false, 0)
+#define LOCK_MOUNT_EXACT_COPY(mp, path, copy_flags) \
+	struct pinned_mountpoint mp __cleanup(unlock_mount) = {}; \
+	lock_mount_exact((path), &mp, true, (copy_flags))
 
 static int graft_tree(struct mount *mnt, const struct pinned_mountpoint *mp)
 {
@@ -3073,16 +3077,13 @@ static struct file *open_detached_copy(struct path *path, unsigned int flags)
 	return file;
 }
 
-DEFINE_FREE(put_empty_mnt_ns, struct mnt_namespace *,
-	    if (!IS_ERR_OR_NULL(_T)) free_mnt_ns(_T))
-
 static struct mnt_namespace *create_new_namespace(struct path *path, unsigned int flags)
 {
-	struct mnt_namespace *new_ns __free(put_empty_mnt_ns) = NULL;
-	struct path to_path __free(path_put) = {};
 	struct mnt_namespace *ns = current->nsproxy->mnt_ns;
 	struct user_namespace *user_ns = current_user_ns();
-	struct mount *new_ns_root;
+	struct mnt_namespace *new_ns;
+	struct mount *new_ns_root, *old_ns_root;
+	struct path to_path;
 	struct mount *mnt;
 	unsigned int copy_flags = 0;
 	bool locked = false;
@@ -3094,71 +3095,64 @@ static struct mnt_namespace *create_new_namespace(struct path *path, unsigned in
 	if (IS_ERR(new_ns))
 		return ERR_CAST(new_ns);
 
-	scoped_guard(namespace_excl) {
-		new_ns_root = clone_mnt(ns->root, ns->root->mnt.mnt_root, copy_flags);
-		if (IS_ERR(new_ns_root))
-			return ERR_CAST(new_ns_root);
+	old_ns_root = ns->root;
+	to_path.mnt = &old_ns_root->mnt;
+	to_path.dentry = old_ns_root->mnt.mnt_root;
 
-		/*
-		 * If the real rootfs had a locked mount on top of it somewhere
-		 * in the stack, lock the new mount tree as well so it can't be
-		 * exposed.
-		 */
-		mnt = ns->root;
-		while (mnt->overmount) {
-			mnt = mnt->overmount;
-			if (mnt->mnt.mnt_flags & MNT_LOCKED)
-				locked = true;
-		}
+	VFS_WARN_ON_ONCE(old_ns_root->mnt_id_unique != 1);
+	VFS_WARN_ON_ONCE(old_ns_root->mnt.mnt_sb->s_type != &nullfs_fs_type);
+
+	LOCK_MOUNT_EXACT_COPY(mp, &to_path, copy_flags);
+	if (IS_ERR(mp.parent)) {
+		free_mnt_ns(new_ns);
+		return ERR_CAST(mp.parent);
 	}
+	new_ns_root = mp.parent;
 
 	/*
-	 * We dropped the namespace semaphore so we can actually lock
-	 * the copy for mounting. The copied mount isn't attached to any
-	 * mount namespace and it is thus excluded from any propagation.
-	 * So realistically we're isolated and the mount can't be
-	 * overmounted.
+	 * If the real rootfs had a locked mount on top of it somewhere
+	 * in the stack, lock the new mount tree as well so it can't be
+	 * exposed.
 	 */
-
-	/* Borrow the reference from clone_mnt(). */
-	to_path.mnt = &new_ns_root->mnt;
-	to_path.dentry = dget(new_ns_root->mnt.mnt_root);
-
-	/* Now lock for actual mounting. */
-	LOCK_MOUNT_EXACT(mp, &to_path);
-	if (unlikely(IS_ERR(mp.parent)))
-		return ERR_CAST(mp.parent);
+	mnt = old_ns_root;
+	while (mnt->overmount) {
+		mnt = mnt->overmount;
+		if (mnt->mnt.mnt_flags & MNT_LOCKED)
+			locked = true;
+	}
 
 	/*
-	 * We don't emulate unshare()ing a mount namespace. We stick to the
-	 * restrictions of creating detached bind-mounts. It has a lot
-	 * saner and simpler semantics.
+	 * We don't emulate unshare()ing a mount namespace. We stick
+	 * to the restrictions of creating detached bind-mounts. It
+	 * has a lot saner and simpler semantics.
 	 */
 	mnt = __do_loopback(path, flags, copy_flags);
-	if (IS_ERR(mnt))
-		return ERR_CAST(mnt);
-
 	scoped_guard(mount_writer) {
+		if (IS_ERR(mnt)) {
+			emptied_ns = new_ns;
+			umount_tree(new_ns_root, 0);
+			return ERR_CAST(mnt);
+		}
+
 		if (locked)
 			mnt->mnt.mnt_flags |= MNT_LOCKED;
 		/*
-		 * Now mount the detached tree on top of the copy of the
-		 * real rootfs we created.
+		 * now mount the detached tree on top of the copy
+		 * of the real rootfs we created.
 		 */
 		attach_mnt(mnt, new_ns_root, mp.mp);
 		if (user_ns != ns->user_ns)
 			lock_mnt_tree(new_ns_root);
 	}
 
-	/* Add all mounts to the new namespace. */
-	for (struct mount *p = new_ns_root; p; p = next_mnt(p, new_ns_root)) {
-		mnt_add_to_ns(new_ns, p);
+	for (mnt = new_ns_root; mnt; mnt = next_mnt(mnt, new_ns_root)) {
+		mnt_add_to_ns(new_ns, mnt);
 		new_ns->nr_mounts++;
 	}
 
-	new_ns->root = real_mount(no_free_ptr(to_path.mnt));
+	new_ns->root = new_ns_root;
 	ns_tree_add_raw(new_ns);
-	return no_free_ptr(new_ns);
+	return new_ns;
 }
 
 static struct file *open_new_namespace(struct path *path, unsigned int flags)
@@ -3840,16 +3834,20 @@ static int do_new_mount(const struct path *path, const char *fstype,
 }
 
 static void lock_mount_exact(const struct path *path,
-			     struct pinned_mountpoint *mp)
+			     struct pinned_mountpoint *mp, bool copy_mount,
+			     unsigned int copy_flags)
 {
 	struct dentry *dentry = path->dentry;
 	int err;
 
+	/* Assert that inode_lock() locked the correct inode. */
+	VFS_WARN_ON_ONCE(copy_mount && !path_mounted(path));
+
 	inode_lock(dentry->d_inode);
 	namespace_lock();
 	if (unlikely(cant_mount(dentry)))
 		err = -ENOENT;
-	else if (path_overmounted(path))
+	else if (!copy_mount && path_overmounted(path))
 		err = -EBUSY;
 	else
 		err = get_mountpoint(dentry, mp);
@@ -3857,9 +3855,15 @@ static void lock_mount_exact(const struct path *path,
 		namespace_unlock();
 		inode_unlock(dentry->d_inode);
 		mp->parent = ERR_PTR(err);
-	} else {
-		mp->parent = real_mount(path->mnt);
+		return;
 	}
+
+	if (copy_mount)
+		mp->parent = clone_mnt(real_mount(path->mnt), dentry, copy_flags);
+	else
+		mp->parent = real_mount(path->mnt);
+	if (unlikely(IS_ERR(mp->parent)))
+		__unlock_mount(mp);
 }
 
 int finish_automount(struct vfsmount *__m, const struct path *path)
-- 
2.47.3


--tzmuvbdsgyutgbdg--

