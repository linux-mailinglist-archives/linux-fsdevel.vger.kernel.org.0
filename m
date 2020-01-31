Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 755C214E860
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2020 06:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgAaFZQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jan 2020 00:25:16 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42810 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgAaFZQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jan 2020 00:25:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iaONn3PN4CmGbzxX7vbz9VEQdINWrN40pXZYKxhUWYQ=; b=ehajBpRY8PCtQQNmVDv7QhYCT
        KeGc3R2zmCjkhJElf+507DzutiIJb03QGG9NvfxEoOejSJMeD71eJE8erPqpWYM+NHui05kl8PzNN
        sgjRky336NmKnskC+XdFH63rzvBaRY4YJ2sT/t+AaUsZKBAPbPtCQssMv2KUt0NxMP6I55cVODvE4
        zLv0ut4pDVgwB7tGOyjl7ucwMv3Of3qkcBKQFbVHa6zi6xr2luhb1bGPdbc3EX+j5v284pTZoF40o
        i792hcouH0FasM+CVotIv1sy63kwl5d6L637A3J8JCuBc1sJHR+E2pMQn/4Un6wL3NyHPix2hT6ZC
        JKPm4kAZA==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixOnr-0000lA-PD; Fri, 31 Jan 2020 05:25:15 +0000
To:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@ZenIV.linux.org.uk>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 2/2] fs/namespace.c: fix kernel coding style for comments and
 EXPORTs
Message-ID: <f29712ac-2cb1-d9ba-2c35-3bc88b0e0d48@infradead.org>
Date:   Thu, 30 Jan 2020 21:25:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix coding style to use documented multi-line comment style
and EXPORT_SYMBOL()s to immediately follow their function's
closing brace line.

Also fix a little punctuation and a few typos.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c |   52 +++++++++++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 19 deletions(-)

--- linux-next-20200130.orig/fs/namespace.c
+++ linux-next-20200130/fs/namespace.c
@@ -1002,8 +1002,9 @@ struct vfsmount *
 vfs_submount(const struct dentry *mountpoint, struct file_system_type *type,
 	     const char *name, void *data)
 {
-	/* Until it is worked out how to pass the user namespace
-	 * through from the parent mount to the submount don't support
+	/*
+	 * Until it is worked out how to pass the user namespace
+	 * through from the parent mount to the submount, don't support
 	 * unprivileged mounts with submounts.
 	 */
 	if (mountpoint->d_sb->s_user_ns != &init_user_ns)
@@ -1064,8 +1065,10 @@ static struct mount *clone_mnt(struct mo
 	if (flag & CL_MAKE_SHARED)
 		set_mnt_shared(mnt);
 
-	/* stick the duplicate mount on the same expiry list
-	 * as the original if that was on one */
+	/*
+	 * stick the duplicate mount on the same expiry list
+	 * as the original if that was on one
+	 */
 	if (flag & CL_EXPIRE) {
 		if (!list_empty(&old->mnt_expire))
 			list_add(&mnt->mnt_expire, &old->mnt_expire);
@@ -1326,7 +1329,6 @@ int may_umount_tree(struct vfsmount *m)
 
 	return 1;
 }
-
 EXPORT_SYMBOL(may_umount_tree);
 
 /**
@@ -1353,7 +1355,6 @@ int may_umount(struct vfsmount *mnt)
 	up_read(&namespace_sem);
 	return ret;
 }
-
 EXPORT_SYMBOL(may_umount);
 
 static void namespace_unlock(void)
@@ -1402,7 +1403,8 @@ static bool disconnect_mount(struct moun
 	if (!mnt_has_parent(mnt))
 		return true;
 
-	/* Because the reference counting rules change when mounts are
+	/*
+	 * Because the reference counting rules change when mounts are
 	 * unmounted and connected, umounted mounts may not be
 	 * connected to mounted mounts.
 	 */
@@ -1736,7 +1738,8 @@ static struct mnt_namespace *to_mnt_ns(s
 
 static bool mnt_ns_loop(struct dentry *dentry)
 {
-	/* Could bind mounting the mount namespace inode cause a
+	/*
+	 * Could bind mounting the mount namespace inode cause a
 	 * mount namespace loop?
 	 */
 	struct mnt_namespace *mnt_ns;
@@ -2053,7 +2056,8 @@ static int attach_recursive_mnt(struct m
 	struct hlist_node *n;
 	int err;
 
-	/* Preallocate a mountpoint in case the new mounts need
+	/*
+	 * Preallocate a mountpoint in case the new mounts need
 	 * to be tucked under other mounts.
 	 */
 	smp = get_mountpoint(source_mnt->mnt.mnt_root);
@@ -2664,8 +2668,10 @@ static int do_move_mount(struct path *ol
 	if (err)
 		goto out;
 
-	/* if the mount is moved, it should no longer be expire
-	 * automatically */
+	/*
+	 * if the mount is moved, it should no longer be expired
+	 * automatically
+	 */
 	list_del_init(&old->mnt_expire);
 	if (attached)
 		put_mountpoint(old_mp);
@@ -2834,7 +2840,8 @@ int finish_automount(struct vfsmount *m,
 {
 	struct mount *mnt = real_mount(m);
 	int err;
-	/* The new mount record should have at least 2 refs to prevent it being
+	/*
+	 * The new mount record should have at least 2 refs to prevent it being
 	 * expired before we get a chance to add it
 	 */
 	BUG_ON(mnt_get_count(mnt) < 2);
@@ -2891,7 +2898,8 @@ void mark_mounts_for_expiry(struct list_
 	namespace_lock();
 	lock_mount_hash();
 
-	/* extract from the expiration list every vfsmount that matches the
+	/*
+	 * extract from the expiration list every vfsmount that matches the
 	 * following criteria:
 	 * - only referenced by its parent vfsmount
 	 * - still marked for expiry (marked on the last call here; marks are
@@ -3023,7 +3031,8 @@ void *copy_mount_options(const void __us
 	if (!copy)
 		return ERR_PTR(-ENOMEM);
 
-	/* We only care that *some* data at the address the user
+	/*
+	 * We only care that *some* data at the address the user
 	 * gave us is valid.  Just in case, we'll zero
 	 * the remainder of the page.
 	 */
@@ -3457,7 +3466,8 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, uns
 	newmount.dentry = dget(fc->root);
 	newmount.mnt->mnt_flags = mnt_flags;
 
-	/* We've done the mount bit - now move the file context into more or
+	/*
+	 * We've done the mount bit - now move the file context into more or
 	 * less the same state as if we'd done an fspick().  We don't want to
 	 * do any memory allocation or anything like that at this point as we
 	 * don't want to have to handle any errors incurred.
@@ -3476,7 +3486,8 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, uns
 	list_add(&mnt->mnt_list, &ns->list);
 	mntget(newmount.mnt);
 
-	/* Attach to an apparent O_PATH fd with a note that we need to unmount
+	/*
+	 * Attach to an apparent O_PATH fd with a note that we need to unmount
 	 * it, not just simply put it.
 	 */
 	file = dentry_open(&newmount, O_PATH, fc->cred);
@@ -3525,7 +3536,8 @@ SYSCALL_DEFINE5(move_mount,
 	if (flags & ~MOVE_MOUNT__MASK)
 		return -EINVAL;
 
-	/* If someone gives a pathname, they aren't permitted to move
+	/*
+	 * If someone gives a pathname, they aren't permitted to move
 	 * from an fd that requires unmount as we can't get at the flag
 	 * to clear it afterwards.
 	 */
@@ -3853,7 +3865,8 @@ static bool mnt_already_visible(struct m
 		if (mnt->mnt.mnt_sb->s_type != sb->s_type)
 			continue;
 
-		/* This mount is not fully visible if it's root directory
+		/*
+		 * This mount is not fully visible if it's root directory
 		 * is not the root directory of the filesystem.
 		 */
 		if (mnt->mnt.mnt_root != mnt->mnt.mnt_sb->s_root)
@@ -3876,7 +3889,8 @@ static bool mnt_already_visible(struct m
 		    ((mnt_flags & MNT_ATIME_MASK) != (new_flags & MNT_ATIME_MASK)))
 			continue;
 
-		/* This mount is not fully visible if there are any
+		/*
+		 * This mount is not fully visible if there are any
 		 * locked child mounts that cover anything except for
 		 * empty directories.
 		 */

