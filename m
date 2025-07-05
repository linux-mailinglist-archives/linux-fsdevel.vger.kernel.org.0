Return-Path: <linux-fsdevel+bounces-54003-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AA5AF9E6A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Jul 2025 07:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F4FB5807C7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Jul 2025 05:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C51C273D65;
	Sat,  5 Jul 2025 05:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="BiFwGPew"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2506252910
	for <linux-fsdevel@vger.kernel.org>; Sat,  5 Jul 2025 05:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751695041; cv=none; b=o+taDLv6M4FmK+upaTzR22VlSeUpwM+jLwECcYEHmWFtBB1WQDSV5zRSKFv4aqJPyK+s3/zckfzqkc+MPCGg7v+vyCa5qJBVNwlI9h+cMzLDV9+GoglQZH6Q81jtVneld3t1iyJFow8Es/Q5jMsUeSCo7AK/7lPbJlwQQI/oQTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751695041; c=relaxed/simple;
	bh=l+7U11Hv+HjZKEaffBJx44/cyxZtk+Xs7caXj/PIlOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=POPtJDrilGdbVV8SdfhW6RcBe1j7Yl6Q7bbLX78CGwmJt/BlVogCwT0NLP3JlRzFyZjZ9IaFBlR+If3CI6e9ukkiLrj2To8W5n0TZvsffipRkgNa2UpQ0QS9pbZvlvANJlpBXsxxpT/EcC6KeV+C8peQKx9fLV1Fml6HpMu8iUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=BiFwGPew; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=I3tfCRs8l0wAoHBfK8OTR9w5VVuTGa1BBYmxXrQ+g6M=; b=BiFwGPew1bMZizsuWPNKrhCbL0
	j7WMGhQOSeXDV4HlH4qucjZYI2HpIYymFQf+fyN5otlagA5OBk6ove6Bfr3xkS1YPW5ZoC5vIC4pm
	naY2XWjZWVXAMqVi0vP96cTlR4u3D8rcvp+JqVw4TN1BU02Yy0Pxn+GvktByfeHExpxroeZnqJG3v
	PThOvpRZdmUPKqffaLCQoO35IvOzM3N8v1MfFYg6JisPz4JlrUMKAD9L+yTfQDMz8t8WxtaO3TY5C
	HrFdRzOjwio+qeaYjlSOlVHAxMtfhQqNAT20LtNeYTByqr2W85tDrh/ICW0M/sx5xG5Qfm1wyAFq0
	Ifd/qz8A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXvtj-00000000Xny-0lwC;
	Sat, 05 Jul 2025 05:57:15 +0000
Date: Sat, 5 Jul 2025 06:57:15 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [RFC] MNT_WRITE_HOLD mess
Message-ID: <20250705055715.GX1880847@ZenIV>
References: <20250704194414.GR1880847@ZenIV>
 <CAHk-=wgurLEukSdbUPk28rW=hsVGMxE4zDOCZ3xxY3ee3oGyoQ@mail.gmail.com>
 <20250704202337.GT1880847@ZenIV>
 <20250705000114.GU1880847@ZenIV>
 <CAJfpegu8aidxbF7XwfkC02waYpGNHSu1v184UEa2M8CTwtSGjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegu8aidxbF7XwfkC02waYpGNHSu1v184UEa2M8CTwtSGjw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Jul 05, 2025 at 06:52:51AM +0200, Miklos Szeredi wrote:
> On Sat, 5 Jul 2025 at 02:01, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >         * both vfs_create_mount() and clone_mnt() add mount to the tail
> > of ->s_mounts.  Is there any reason why that would be better than adding
> > to head?  I don't remember if that had been covered back in 2010/2011
> > discussion of per-mount r/o patchset; quick search on lore hasn't turned
> > up anything...  Miklos?
> 
> I don't see why it would matter.  And I tend to choose tail if it
> doesn't matter.

Just the question of imitation of list_head vs. that of hlist...
Completely untested variant (fs/{namespace,super}.o compiles, but I hadn't even
tried to build the kernel, let alone boot and test it) follows:

diff --git a/fs/mount.h b/fs/mount.h
index ad7173037924..10fde24ecf5d 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -65,7 +65,9 @@ struct mount {
 #endif
 	struct list_head mnt_mounts;	/* list of children, anchored here */
 	struct list_head mnt_child;	/* and going through their mnt_child */
-	struct list_head mnt_instance;	/* mount instance on sb->s_mounts */
+	struct mount *mnt_next_for_sb;	/* the next two fields are hlist_node */
+	unsigned long mnt_prev_for_sb;	/* except that LSB of pprev is stolen */
+#define WRITE_HOLD 1			/* ... for use by mnt_hold_writers() */
 	const char *mnt_devname;	/* Name of device e.g. /dev/dsk/hda1 */
 	struct list_head mnt_list;
 	struct list_head mnt_expire;	/* link in fs-specific expiry list */
diff --git a/fs/namespace.c b/fs/namespace.c
index 54c59e091919..797d0bd7b674 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -501,31 +501,31 @@ int mnt_get_write_access(struct vfsmount *m)
 	mnt_inc_writers(mnt);
 	/*
 	 * The store to mnt_inc_writers must be visible before we pass
-	 * MNT_WRITE_HOLD loop below, so that the slowpath can see our
-	 * incremented count after it has set MNT_WRITE_HOLD.
+	 * WRITE_HOLD loop below, so that the slowpath can see our
+	 * incremented count after it has set WRITE_HOLD.
 	 */
 	smp_mb();
 	might_lock(&mount_lock.lock);
-	while (READ_ONCE(mnt->mnt.mnt_flags) & MNT_WRITE_HOLD) {
+	while (READ_ONCE(mnt->mnt_prev_for_sb) & WRITE_HOLD) {
 		if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
 			cpu_relax();
 		} else {
 			/*
 			 * This prevents priority inversion, if the task
-			 * setting MNT_WRITE_HOLD got preempted on a remote
-			 * CPU, and it prevents life lock if the task setting
-			 * MNT_WRITE_HOLD has a lower priority and is bound to
+			 * setting WRITE_HOLD got preempted on a remote
+			 * CPU, and it prevents life lock if such task
+			 * has a lower priority and is bound to
 			 * the same CPU as the task that is spinning here.
 			 */
 			preempt_enable();
-			lock_mount_hash();
-			unlock_mount_hash();
+			read_seqlock_excl(&mount_lock);
+			read_sequnlock_excl(&mount_lock);
 			preempt_disable();
 		}
 	}
 	/*
 	 * The barrier pairs with the barrier sb_start_ro_state_change() making
-	 * sure that if we see MNT_WRITE_HOLD cleared, we will also see
+	 * sure that if we see WRITE_HOLD cleared, we will also see
 	 * s_readonly_remount set (or even SB_RDONLY / MNT_READONLY flags) in
 	 * mnt_is_readonly() and bail in case we are racing with remount
 	 * read-only.
@@ -663,16 +663,15 @@ EXPORT_SYMBOL(mnt_drop_write_file);
  * a call to mnt_unhold_writers() in order to stop preventing write access to
  * @mnt.
  *
- * Context: This function expects lock_mount_hash() to be held serializing
- *          setting MNT_WRITE_HOLD.
+ * Context: This function expects read_seqlock_excl(&mount_lock).
  * Return: On success 0 is returned.
  *	   On error, -EBUSY is returned.
  */
 static inline int mnt_hold_writers(struct mount *mnt)
 {
-	mnt->mnt.mnt_flags |= MNT_WRITE_HOLD;
+	mnt->mnt_prev_for_sb |= WRITE_HOLD;
 	/*
-	 * After storing MNT_WRITE_HOLD, we'll read the counters. This store
+	 * After storing WRITE_HOLD, we'll read the counters. This store
 	 * should be visible before we do.
 	 */
 	smp_mb();
@@ -688,9 +687,9 @@ static inline int mnt_hold_writers(struct mount *mnt)
 	 * sum up each counter, if we read a counter before it is incremented,
 	 * but then read another CPU's count which it has been subsequently
 	 * decremented from -- we would see more decrements than we should.
-	 * MNT_WRITE_HOLD protects against this scenario, because
+	 * WRITE_HOLD protects against this scenario, because
 	 * mnt_want_write first increments count, then smp_mb, then spins on
-	 * MNT_WRITE_HOLD, so it can't be decremented by another CPU while
+	 * WRITE_HOLD, so it can't be decremented by another CPU while
 	 * we're counting up here.
 	 */
 	if (mnt_get_writers(mnt) > 0)
@@ -709,16 +708,39 @@ static inline int mnt_hold_writers(struct mount *mnt)
  * This function can only be called after a successful call to
  * mnt_hold_writers().
  *
- * Context: This function expects lock_mount_hash() to be held.
+ * Context: This function expects read_seqlock_excl(&mount_lock) to be held.
  */
 static inline void mnt_unhold_writers(struct mount *mnt)
 {
+	if (!(mnt->mnt_prev_for_sb & WRITE_HOLD))
+		return;
 	/*
-	 * MNT_READONLY must become visible before ~MNT_WRITE_HOLD, so writers
+	 * MNT_READONLY must become visible before ~WRITE_HOLD, so writers
 	 * that become unheld will see MNT_READONLY.
 	 */
 	smp_wmb();
-	mnt->mnt.mnt_flags &= ~MNT_WRITE_HOLD;
+	mnt->mnt_prev_for_sb &= ~WRITE_HOLD;
+}
+
+static inline void mnt_del_instance(struct mount *m)
+{
+	struct mount **p = (void *)m->mnt_prev_for_sb;
+	struct mount *next = m->mnt_next_for_sb;
+
+	if (next)
+		next->mnt_prev_for_sb = (unsigned long)p;
+	*p = next;
+}
+
+static inline void mnt_add_instance(struct mount *m, struct super_block *s)
+{
+	struct mount *first = s->s_mounts;
+
+	if (first)
+		first->mnt_prev_for_sb = (unsigned long)m;
+	m->mnt_next_for_sb = first;
+	m->mnt_prev_for_sb = (unsigned long)&s->s_mounts;
+	s->s_mounts = m;
 }
 
 static int mnt_make_readonly(struct mount *mnt)
@@ -734,17 +756,16 @@ static int mnt_make_readonly(struct mount *mnt)
 
 int sb_prepare_remount_readonly(struct super_block *sb)
 {
-	struct mount *mnt;
 	int err = 0;
 
-	/* Racy optimization.  Recheck the counter under MNT_WRITE_HOLD */
+	/* Racy optimization.  Recheck the counter under WRITE_HOLD */
 	if (atomic_long_read(&sb->s_remove_count))
 		return -EBUSY;
 
-	lock_mount_hash();
-	list_for_each_entry(mnt, &sb->s_mounts, mnt_instance) {
-		if (!(mnt->mnt.mnt_flags & MNT_READONLY)) {
-			err = mnt_hold_writers(mnt);
+	read_seqlock_excl(&mount_lock);
+	for (struct mount *m = sb->s_mounts; m; m = m->mnt_next_for_sb) {
+		if (!(m->mnt.mnt_flags & MNT_READONLY)) {
+			err = mnt_hold_writers(m);
 			if (err)
 				break;
 		}
@@ -754,11 +775,11 @@ int sb_prepare_remount_readonly(struct super_block *sb)
 
 	if (!err)
 		sb_start_ro_state_change(sb);
-	list_for_each_entry(mnt, &sb->s_mounts, mnt_instance) {
-		if (mnt->mnt.mnt_flags & MNT_WRITE_HOLD)
-			mnt->mnt.mnt_flags &= ~MNT_WRITE_HOLD;
+	for (struct mount *m = sb->s_mounts; m; m = m->mnt_next_for_sb) {
+		if (m->mnt_prev_for_sb & WRITE_HOLD)
+			m->mnt_prev_for_sb &= ~WRITE_HOLD;
 	}
-	unlock_mount_hash();
+	read_sequnlock_excl(&mount_lock);
 
 	return err;
 }
@@ -1249,6 +1270,21 @@ static struct mount *skip_mnt_tree(struct mount *p)
 	return p;
 }
 
+static void setup_mnt(struct mount *m, struct dentry *root)
+{
+	struct super_block *s = root->d_sb;
+
+	atomic_inc(&s->s_active);
+	m->mnt.mnt_sb = s;
+	m->mnt.mnt_root = dget(root);
+	m->mnt_mountpoint = m->mnt.mnt_root;
+	m->mnt_parent = m;
+
+	read_seqlock_excl(&mount_lock);
+	mnt_add_instance(m, s);
+	read_sequnlock_excl(&mount_lock);
+}
+
 /**
  * vfs_create_mount - Create a mount for a configured superblock
  * @fc: The configuration context with the superblock attached
@@ -1272,15 +1308,8 @@ struct vfsmount *vfs_create_mount(struct fs_context *fc)
 	if (fc->sb_flags & SB_KERNMOUNT)
 		mnt->mnt.mnt_flags = MNT_INTERNAL;
 
-	atomic_inc(&fc->root->d_sb->s_active);
-	mnt->mnt.mnt_sb		= fc->root->d_sb;
-	mnt->mnt.mnt_root	= dget(fc->root);
-	mnt->mnt_mountpoint	= mnt->mnt.mnt_root;
-	mnt->mnt_parent		= mnt;
+	setup_mnt(mnt, fc->root);
 
-	lock_mount_hash();
-	list_add_tail(&mnt->mnt_instance, &mnt->mnt.mnt_sb->s_mounts);
-	unlock_mount_hash();
 	return &mnt->mnt;
 }
 EXPORT_SYMBOL(vfs_create_mount);
@@ -1329,7 +1358,6 @@ EXPORT_SYMBOL_GPL(vfs_kern_mount);
 static struct mount *clone_mnt(struct mount *old, struct dentry *root,
 					int flag)
 {
-	struct super_block *sb = old->mnt.mnt_sb;
 	struct mount *mnt;
 	int err;
 
@@ -1349,18 +1377,11 @@ static struct mount *clone_mnt(struct mount *old, struct dentry *root,
 	}
 
 	mnt->mnt.mnt_flags = old->mnt.mnt_flags;
-	mnt->mnt.mnt_flags &= ~(MNT_WRITE_HOLD|MNT_MARKED|MNT_INTERNAL);
+	mnt->mnt.mnt_flags &= ~(MNT_MARKED|MNT_INTERNAL);
 
-	atomic_inc(&sb->s_active);
 	mnt->mnt.mnt_idmap = mnt_idmap_get(mnt_idmap(&old->mnt));
 
-	mnt->mnt.mnt_sb = sb;
-	mnt->mnt.mnt_root = dget(root);
-	mnt->mnt_mountpoint = mnt->mnt.mnt_root;
-	mnt->mnt_parent = mnt;
-	lock_mount_hash();
-	list_add_tail(&mnt->mnt_instance, &sb->s_mounts);
-	unlock_mount_hash();
+	setup_mnt(mnt, root);
 
 	if ((flag & CL_SLAVE) ||
 	    ((flag & CL_SHARED_TO_SLAVE) && IS_MNT_SHARED(old))) {
@@ -1477,7 +1498,7 @@ static void mntput_no_expire(struct mount *mnt)
 	mnt->mnt.mnt_flags |= MNT_DOOMED;
 	rcu_read_unlock();
 
-	list_del(&mnt->mnt_instance);
+	mnt_del_instance(mnt);
 
 	if (unlikely(!list_empty(&mnt->mnt_mounts))) {
 		struct mount *p, *tmp;
@@ -4953,18 +4974,17 @@ static int mount_setattr_prepare(struct mount_kattr *kattr, struct mount *mnt)
 		struct mount *p;
 
 		/*
-		 * If we had to call mnt_hold_writers() MNT_WRITE_HOLD will
-		 * be set in @mnt_flags. The loop unsets MNT_WRITE_HOLD for all
+		 * If we had to call mnt_hold_writers() WRITE_HOLD will be set
+		 * in @mnt_prev_for_sb. The loop unsets WRITE_HOLD for all
 		 * mounts and needs to take care to include the first mount.
 		 */
 		for (p = mnt; p; p = next_mnt(p, mnt)) {
 			/* If we had to hold writers unblock them. */
-			if (p->mnt.mnt_flags & MNT_WRITE_HOLD)
-				mnt_unhold_writers(p);
+			mnt_unhold_writers(p);
 
 			/*
 			 * We're done once the first mount we changed got
-			 * MNT_WRITE_HOLD unset.
+			 * WRITE_HOLD unset.
 			 */
 			if (p == m)
 				break;
@@ -4999,8 +5019,7 @@ static void mount_setattr_commit(struct mount_kattr *kattr, struct mount *mnt)
 		WRITE_ONCE(m->mnt.mnt_flags, flags);
 
 		/* If we had to hold writers unblock them. */
-		if (m->mnt.mnt_flags & MNT_WRITE_HOLD)
-			mnt_unhold_writers(m);
+		mnt_unhold_writers(m);
 
 		if (kattr->propagation)
 			change_mnt_propagation(m, kattr->propagation);
diff --git a/fs/super.c b/fs/super.c
index 80418ca8e215..6ca4bace5476 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -323,7 +323,6 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	if (!s)
 		return NULL;
 
-	INIT_LIST_HEAD(&s->s_mounts);
 	s->s_user_ns = get_user_ns(user_ns);
 	init_rwsem(&s->s_umount);
 	lockdep_set_class(&s->s_umount, &type->s_umount_key);
@@ -408,7 +407,7 @@ static void __put_super(struct super_block *s)
 		list_del_init(&s->s_list);
 		WARN_ON(s->s_dentry_lru.node);
 		WARN_ON(s->s_inode_lru.node);
-		WARN_ON(!list_empty(&s->s_mounts));
+		WARN_ON(s->s_mounts);
 		call_rcu(&s->rcu, destroy_super_rcu);
 	}
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index b085f161ed22..004d6a63fa5a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1356,7 +1356,7 @@ struct super_block {
 	__u16 s_encoding_flags;
 #endif
 	struct hlist_bl_head	s_roots;	/* alternate root dentries for NFS */
-	struct list_head	s_mounts;	/* list of mounts; _not_ for fs use */
+	void			*s_mounts;	/* list of mounts; _not_ for fs use */
 	struct block_device	*s_bdev;	/* can go away once we use an accessor for @s_bdev_file */
 	struct file		*s_bdev_file;
 	struct backing_dev_info *s_bdi;
diff --git a/include/linux/mount.h b/include/linux/mount.h
index 1a508beba446..1728bc50d02b 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -33,7 +33,6 @@ enum mount_flags {
 	MNT_NOSYMFOLLOW	= 0x80,
 
 	MNT_SHRINKABLE	= 0x100,
-	MNT_WRITE_HOLD	= 0x200,
 
 	MNT_SHARED	= 0x1000, /* if the vfsmount is a shared mount */
 	MNT_UNBINDABLE	= 0x2000, /* if the vfsmount is a unbindable mount */
@@ -64,7 +63,7 @@ enum mount_flags {
 				  | MNT_READONLY | MNT_NOSYMFOLLOW,
 	MNT_ATIME_MASK = MNT_NOATIME | MNT_NODIRATIME | MNT_RELATIME,
 
-	MNT_INTERNAL_FLAGS = MNT_SHARED | MNT_WRITE_HOLD | MNT_INTERNAL |
+	MNT_INTERNAL_FLAGS = MNT_SHARED | MNT_INTERNAL |
 			     MNT_DOOMED | MNT_SYNC_UMOUNT | MNT_MARKED |
 			     MNT_LOCKED,
 };

