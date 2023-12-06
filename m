Return-Path: <linux-fsdevel+bounces-5060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 983B9807B74
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 23:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D5EA282341
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 22:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051886F623
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 22:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="avrfvmzI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D336CD5B;
	Wed,  6 Dec 2023 13:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UFI9cEKJE9ySAe7Mv4X2bPZ74TKR27JMswi9IVtNiyY=; b=avrfvmzIqCH2+ajHYm92MSxwJs
	838R2uv9H7Hx0E18HmLD/KUkq30Yu8JycRES7aXv+LxhQUYtJac7djsZAoaEPY6++XlZolI+J5ev/
	lfJapAFPgOrFelhC/25p1N/hcB9a3ysqiYb/ChH2sgFzkGxSfbAZGYppyQxCM6XeL533LJIRRTXJ0
	g8Tq1qzxjXtBIKhZbzXpWdikdRLp5LRfcDnJ6rCFA3Cdx/GkrnB3z4TFRnlD/AhDl/5GLamGk2aYJ
	Mb1Q5eWFNtXqD6hoxfa9KmvYiW2oTKDeuTH6Zgd88nyk8EpP2Il6QDXEPIXy5e2W3hhWOSuna8dZK
	T0+g7y1w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rAz70-007w1R-2B;
	Wed, 06 Dec 2023 21:07:18 +0000
Date: Wed, 6 Dec 2023 21:07:18 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Oliver Sang <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, linux-doc@vger.kernel.org,
	ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [viro-vfs:work.dcache2] [__dentry_kill()] 1b738f196e:
 stress-ng.sysinfo.ops_per_sec -27.2% regression
Message-ID: <20231206210718.GQ1674809@ZenIV>
References: <ZW3WKV9ut7aFteKS@xsang-OptiPlex-9020>
 <20231204195321.GA1674809@ZenIV>
 <ZW/fDxjXbU9CU0uz@xsang-OptiPlex-9020>
 <20231206054946.GM1674809@ZenIV>
 <ZXCLgJLy2b5LvfvS@xsang-OptiPlex-9020>
 <20231206161509.GN1674809@ZenIV>
 <20231206163010.445vjwmfwwvv65su@f>
 <CAGudoHF-eXYYYStBWEGzgP8RGXG2+ER4ogdtndkgLWSaboQQwA@mail.gmail.com>
 <20231206170958.GP1674809@ZenIV>
 <CAGudoHErh41OB6JDWHd2Mxzh5rFOGrV6PKC7Xh8JvTn0ws3L_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHErh41OB6JDWHd2Mxzh5rFOGrV6PKC7Xh8JvTn0ws3L_A@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Dec 06, 2023 at 06:24:29PM +0100, Mateusz Guzik wrote:
> On 12/6/23, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > On Wed, Dec 06, 2023 at 05:42:34PM +0100, Mateusz Guzik wrote:
> >
> >> That is to say your patchset is probably an improvement, but this
> >> benchmark uses kernfs which is a total crapper, with code like this in
> >> kernfs_iop_permission:
> >>
> >>         root = kernfs_root(kn);
> >>
> >>         down_read(&root->kernfs_iattr_rwsem);
> >>         kernfs_refresh_inode(kn, inode);
> >>         ret = generic_permission(&nop_mnt_idmap, inode, mask);
> >>         up_read(&root->kernfs_iattr_rwsem);
> >>
> >>
> >> Maybe there is an easy way to dodge this, off hand I don't see one.
> >
> > At a guess - seqcount on kernfs nodes, bumped on metadata changes
> > and a seqretry loop, not that this was the only problem with kernfs
> > scalability.
> >
> 
> I assumed you can't have possibly changing inode fields around
> generic_permission.

That's not the problem; kernfs_refresh_inode(), OTOH, is.
Locking in kernfs is really atrocious ;-/

I would prefer to make that thing per-node (and not an rwsem, obviously,
seqloct_t would suffice), but let's see what the minimal change would do
- turn that into a mutex + seqcount and keep them in the same place.

Below is completely untested, just to see if it would affect the sysinfo
side of things (both with and without dcache series - it's independent
from that):

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 8b2bd65d70e7..2784ac117a1f 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -383,11 +383,13 @@ static int kernfs_link_sibling(struct kernfs_node *kn)
 	rb_insert_color(&kn->rb, &kn->parent->dir.children);
 
 	/* successfully added, account subdir number */
-	down_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
+	mutex_lock(&kernfs_root(kn)->kernfs_iattr_lock);
+	write_seqcount_begin(&kernfs_root(kn)->kernfs_iattr_seq);
 	if (kernfs_type(kn) == KERNFS_DIR)
 		kn->parent->dir.subdirs++;
 	kernfs_inc_rev(kn->parent);
-	up_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
+	write_seqcount_end(&kernfs_root(kn)->kernfs_iattr_seq);
+	mutex_unlock(&kernfs_root(kn)->kernfs_iattr_lock);
 
 	return 0;
 }
@@ -410,11 +412,12 @@ static bool kernfs_unlink_sibling(struct kernfs_node *kn)
 	if (RB_EMPTY_NODE(&kn->rb))
 		return false;
 
-	down_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
+	mutex_lock(&kernfs_root(kn)->kernfs_iattr_lock);
+	write_seqcount_begin(&kernfs_root(kn)->kernfs_iattr_seq);
 	if (kernfs_type(kn) == KERNFS_DIR)
 		kn->parent->dir.subdirs--;
-	kernfs_inc_rev(kn->parent);
-	up_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
+	write_seqcount_end(&kernfs_root(kn)->kernfs_iattr_seq);
+	mutex_unlock(&kernfs_root(kn)->kernfs_iattr_lock);
 
 	rb_erase(&kn->rb, &kn->parent->dir.children);
 	RB_CLEAR_NODE(&kn->rb);
@@ -639,15 +642,11 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
 	kn->flags = flags;
 
 	if (!uid_eq(uid, GLOBAL_ROOT_UID) || !gid_eq(gid, GLOBAL_ROOT_GID)) {
-		struct iattr iattr = {
-			.ia_valid = ATTR_UID | ATTR_GID,
-			.ia_uid = uid,
-			.ia_gid = gid,
-		};
-
-		ret = __kernfs_setattr(kn, &iattr);
-		if (ret < 0)
+		kn->iattr = kernfs_alloc_iattrs(uid, gid);
+		if (!kn->iattr) {
+			ret = -ENOMEM;
 			goto err_out3;
+		}
 	}
 
 	if (parent) {
@@ -776,7 +775,8 @@ int kernfs_add_one(struct kernfs_node *kn)
 		goto out_unlock;
 
 	/* Update timestamps on the parent */
-	down_write(&root->kernfs_iattr_rwsem);
+	mutex_lock(&root->kernfs_iattr_lock);
+	write_seqcount_begin(&root->kernfs_iattr_seq);
 
 	ps_iattr = parent->iattr;
 	if (ps_iattr) {
@@ -784,7 +784,8 @@ int kernfs_add_one(struct kernfs_node *kn)
 		ps_iattr->ia_mtime = ps_iattr->ia_ctime;
 	}
 
-	up_write(&root->kernfs_iattr_rwsem);
+	write_seqcount_end(&root->kernfs_iattr_seq);
+	mutex_unlock(&root->kernfs_iattr_lock);
 	up_write(&root->kernfs_rwsem);
 
 	/*
@@ -949,7 +950,8 @@ struct kernfs_root *kernfs_create_root(struct kernfs_syscall_ops *scops,
 
 	idr_init(&root->ino_idr);
 	init_rwsem(&root->kernfs_rwsem);
-	init_rwsem(&root->kernfs_iattr_rwsem);
+	mutex_init(&root->kernfs_iattr_lock);
+	seqcount_mutex_init(&root->kernfs_iattr_seq, &root->kernfs_iattr_lock);
 	init_rwsem(&root->kernfs_supers_rwsem);
 	INIT_LIST_HEAD(&root->supers);
 
@@ -1473,14 +1475,16 @@ static void __kernfs_remove(struct kernfs_node *kn)
 				pos->parent ? pos->parent->iattr : NULL;
 
 			/* update timestamps on the parent */
-			down_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
+			mutex_lock(&kernfs_root(kn)->kernfs_iattr_lock);
+			write_seqcount_begin(&kernfs_root(kn)->kernfs_iattr_seq);
 
 			if (ps_iattr) {
 				ktime_get_real_ts64(&ps_iattr->ia_ctime);
 				ps_iattr->ia_mtime = ps_iattr->ia_ctime;
 			}
 
-			up_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
+			write_seqcount_end(&kernfs_root(kn)->kernfs_iattr_seq);
+			mutex_unlock(&kernfs_root(kn)->kernfs_iattr_lock);
 			kernfs_put(pos);
 		}
 
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index b83054da68b3..4b77931c814d 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -24,56 +24,49 @@ static const struct inode_operations kernfs_iops = {
 	.listxattr	= kernfs_iop_listxattr,
 };
 
-static struct kernfs_iattrs *__kernfs_iattrs(struct kernfs_node *kn, int alloc)
+struct kernfs_iattrs *kernfs_alloc_iattrs(kuid_t uid, kgid_t gid)
 {
-	static DEFINE_MUTEX(iattr_mutex);
-	struct kernfs_iattrs *ret;
+	struct kernfs_iattrs *ret = kmem_cache_zalloc(kernfs_iattrs_cache, GFP_KERNEL);
 
-	mutex_lock(&iattr_mutex);
+	if (ret) {
+		ret->ia_uid = uid;
+		ret->ia_gid = gid;
 
-	if (kn->iattr || !alloc)
-		goto out_unlock;
+		ktime_get_real_ts64(&ret->ia_atime);
+		ret->ia_ctime = ret->ia_mtime = ret->ia_atime;
 
-	kn->iattr = kmem_cache_zalloc(kernfs_iattrs_cache, GFP_KERNEL);
-	if (!kn->iattr)
-		goto out_unlock;
-
-	/* assign default attributes */
-	kn->iattr->ia_uid = GLOBAL_ROOT_UID;
-	kn->iattr->ia_gid = GLOBAL_ROOT_GID;
-
-	ktime_get_real_ts64(&kn->iattr->ia_atime);
-	kn->iattr->ia_mtime = kn->iattr->ia_atime;
-	kn->iattr->ia_ctime = kn->iattr->ia_atime;
-
-	simple_xattrs_init(&kn->iattr->xattrs);
-	atomic_set(&kn->iattr->nr_user_xattrs, 0);
-	atomic_set(&kn->iattr->user_xattr_size, 0);
-out_unlock:
-	ret = kn->iattr;
-	mutex_unlock(&iattr_mutex);
+		simple_xattrs_init(&ret->xattrs);
+		atomic_set(&ret->nr_user_xattrs, 0);
+		atomic_set(&ret->user_xattr_size, 0);
+	}
 	return ret;
 }
 
 static struct kernfs_iattrs *kernfs_iattrs(struct kernfs_node *kn)
 {
-	return __kernfs_iattrs(kn, 1);
+	struct kernfs_iattrs *ret = READ_ONCE(kn->iattr);
+
+	if (!ret) {
+		struct kernfs_iattrs *new;
+		new = kernfs_alloc_iattrs(GLOBAL_ROOT_UID, GLOBAL_ROOT_GID);
+		ret = cmpxchg(&kn->iattr, NULL, new);
+		if (likely(!ret))
+			return new;
+		kfree(new);
+	}
+	return ret;
 }
 
 static struct kernfs_iattrs *kernfs_iattrs_noalloc(struct kernfs_node *kn)
 {
-	return __kernfs_iattrs(kn, 0);
+	return READ_ONCE(kn->iattr);
 }
 
-int __kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr)
+static void __kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr)
 {
-	struct kernfs_iattrs *attrs;
+	struct kernfs_iattrs *attrs = kernfs_iattrs_noalloc(kn);
 	unsigned int ia_valid = iattr->ia_valid;
 
-	attrs = kernfs_iattrs(kn);
-	if (!attrs)
-		return -ENOMEM;
-
 	if (ia_valid & ATTR_UID)
 		attrs->ia_uid = iattr->ia_uid;
 	if (ia_valid & ATTR_GID)
@@ -86,7 +79,6 @@ int __kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr)
 		attrs->ia_ctime = iattr->ia_ctime;
 	if (ia_valid & ATTR_MODE)
 		kn->mode = iattr->ia_mode;
-	return 0;
 }
 
 /**
@@ -98,13 +90,17 @@ int __kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr)
  */
 int kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr)
 {
-	int ret;
 	struct kernfs_root *root = kernfs_root(kn);
 
-	down_write(&root->kernfs_iattr_rwsem);
-	ret = __kernfs_setattr(kn, iattr);
-	up_write(&root->kernfs_iattr_rwsem);
-	return ret;
+	if (!kernfs_iattrs(kn))
+		return -ENOMEM;
+
+	mutex_lock(&root->kernfs_iattr_lock);
+	write_seqcount_begin(&root->kernfs_iattr_seq);
+	__kernfs_setattr(kn, iattr);
+	write_seqcount_end(&root->kernfs_iattr_seq);
+	mutex_unlock(&root->kernfs_iattr_lock);
+	return 0;
 }
 
 int kernfs_iop_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
@@ -117,22 +113,23 @@ int kernfs_iop_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 
 	if (!kn)
 		return -EINVAL;
+	if (!kernfs_iattrs(kn))
+		return -ENOMEM;
 
 	root = kernfs_root(kn);
-	down_write(&root->kernfs_iattr_rwsem);
+	mutex_lock(&root->kernfs_iattr_lock);
+	write_seqcount_begin(&root->kernfs_iattr_seq);
 	error = setattr_prepare(&nop_mnt_idmap, dentry, iattr);
 	if (error)
 		goto out;
 
-	error = __kernfs_setattr(kn, iattr);
-	if (error)
-		goto out;
-
+	__kernfs_setattr(kn, iattr);
 	/* this ignores size changes */
 	setattr_copy(&nop_mnt_idmap, inode, iattr);
 
 out:
-	up_write(&root->kernfs_iattr_rwsem);
+	write_seqcount_end(&root->kernfs_iattr_seq);
+	mutex_unlock(&root->kernfs_iattr_lock);
 	return error;
 }
 
@@ -187,11 +184,13 @@ int kernfs_iop_getattr(struct mnt_idmap *idmap,
 	struct inode *inode = d_inode(path->dentry);
 	struct kernfs_node *kn = inode->i_private;
 	struct kernfs_root *root = kernfs_root(kn);
+	unsigned seq;
 
-	down_read(&root->kernfs_iattr_rwsem);
-	kernfs_refresh_inode(kn, inode);
-	generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
-	up_read(&root->kernfs_iattr_rwsem);
+	do {
+		seq = read_seqcount_begin(&root->kernfs_iattr_seq);
+		kernfs_refresh_inode(kn, inode);
+		generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
+	} while (read_seqcount_retry(&root->kernfs_iattr_seq, seq));
 
 	return 0;
 }
@@ -276,7 +275,7 @@ int kernfs_iop_permission(struct mnt_idmap *idmap,
 {
 	struct kernfs_node *kn;
 	struct kernfs_root *root;
-	int ret;
+	unsigned seq;
 
 	if (mask & MAY_NOT_BLOCK)
 		return -ECHILD;
@@ -284,12 +283,11 @@ int kernfs_iop_permission(struct mnt_idmap *idmap,
 	kn = inode->i_private;
 	root = kernfs_root(kn);
 
-	down_read(&root->kernfs_iattr_rwsem);
-	kernfs_refresh_inode(kn, inode);
-	ret = generic_permission(&nop_mnt_idmap, inode, mask);
-	up_read(&root->kernfs_iattr_rwsem);
-
-	return ret;
+	do {
+		seq = read_seqcount_begin(&root->kernfs_iattr_seq);
+		kernfs_refresh_inode(kn, inode);
+	} while (read_seqcount_retry(&root->kernfs_iattr_seq, seq));
+	return generic_permission(&nop_mnt_idmap, inode, mask);
 }
 
 int kernfs_xattr_get(struct kernfs_node *kn, const char *name,
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index 237f2764b941..0aea5151ed1a 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -47,7 +47,8 @@ struct kernfs_root {
 
 	wait_queue_head_t	deactivate_waitq;
 	struct rw_semaphore	kernfs_rwsem;
-	struct rw_semaphore	kernfs_iattr_rwsem;
+	struct mutex		kernfs_iattr_lock;
+	seqcount_mutex_t	kernfs_iattr_seq;
 	struct rw_semaphore	kernfs_supers_rwsem;
 };
 
@@ -137,7 +138,7 @@ int kernfs_iop_getattr(struct mnt_idmap *idmap,
 		       const struct path *path, struct kstat *stat,
 		       u32 request_mask, unsigned int query_flags);
 ssize_t kernfs_iop_listxattr(struct dentry *dentry, char *buf, size_t size);
-int __kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr);
+struct kernfs_iattrs *kernfs_alloc_iattrs(kuid_t uid, kgid_t gid);
 
 /*
  * dir.c

