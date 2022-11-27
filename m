Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0DA6639AA9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Nov 2022 13:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiK0Myz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Nov 2022 07:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiK0Myy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Nov 2022 07:54:54 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08E4FAEE;
        Sun, 27 Nov 2022 04:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=oVNk4lEQ0K1JdpA13/d2hKcImYfgFLWJtsaOrxQ63Ck=; b=ZWifdx+pVnmKdy2vEN3gb2OEwH
        cBX2J5EnNkGmznKrcqozvJ9iZLqNPZshHU3QAQzO/f9UuwurMmLHZZ2bRgGSDKP8ebONFG9QzFyzH
        xtPoeHwLU+KY1dxBy/ZqeE0q6jG7n8lqwwWRQv5tULO5ELXraT11OohxcZ+gQ32e4aBLxr+9OY2QT
        QIrWA6hycT7isemTisGHYkmuj25PjlRHsYsc90hQ4Eu7m7MMQV37KYUt89NRNV3zDgefJU+Phn4Zz
        0pDPcacWoT2hu0dGJFbRDVepBFKtgRXmZ95xdKeNRsgnQavam5iG9j+v4+yOXNde7/R06iNNCQFgq
        R5LzaiUA==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ozHBS-00BbIo-46; Sun, 27 Nov 2022 12:54:58 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2 v2] fs/namespace.c: coding-style update
Date:   Sun, 27 Nov 2022 04:54:41 -0800
Message-Id: <20221127125441.10686-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix coding style to use documented multi-line comment style
and EXPORT_SYMBOL()s to immediately follow their function's
closing brace line.

Also fix a little punctuation and a few typos.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
---
 fs/namespace.c |   51 +++++++++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 19 deletions(-)

diff -- a/fs/namespace.c b/fs/namespace.c
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1189,8 +1189,9 @@ struct vfsmount *
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
@@ -1253,8 +1254,10 @@ static struct mount *clone_mnt(struct mo
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
@@ -1552,7 +1555,6 @@ int may_umount_tree(struct vfsmount *m)
 
 	return 1;
 }
-
 EXPORT_SYMBOL(may_umount_tree);
 
 /**
@@ -1579,7 +1581,6 @@ int may_umount(struct vfsmount *mnt)
 	up_read(&namespace_sem);
 	return ret;
 }
-
 EXPORT_SYMBOL(may_umount);
 
 static void namespace_unlock(void)
@@ -1628,7 +1629,8 @@ static bool disconnect_mount(struct moun
 	if (!mnt_has_parent(mnt))
 		return true;
 
-	/* Because the reference counting rules change when mounts are
+	/*
+	 * Because the reference counting rules change when mounts are
 	 * unmounted and connected, umounted mounts may not be
 	 * connected to mounted mounts.
 	 */
@@ -1966,7 +1968,8 @@ struct ns_common *from_mnt_ns(struct mnt
 
 static bool mnt_ns_loop(struct dentry *dentry)
 {
-	/* Could bind mounting the mount namespace inode cause a
+	/*
+	 * Could bind mounting the mount namespace inode cause a
 	 * mount namespace loop?
 	 */
 	struct mnt_namespace *mnt_ns;
@@ -2314,7 +2317,8 @@ static int attach_recursive_mnt(struct m
 	struct hlist_node *n;
 	int err;
 
-	/* Preallocate a mountpoint in case the new mounts need
+	/*
+	 * Preallocate a mountpoint in case the new mounts need
 	 * to be tucked under other mounts.
 	 */
 	smp = get_mountpoint(source_mnt->mnt.mnt_root);
@@ -2991,8 +2995,10 @@ static int do_move_mount(struct path *ol
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
@@ -3164,8 +3170,9 @@ int finish_automount(struct vfsmount *m,
 		return PTR_ERR(m);
 
 	mnt = real_mount(m);
-	/* The new mount record should have at least 2 refs to prevent it being
-	 * expired before we get a chance to add it
+	/*
+	 * The new mount record should have at least 2 refs to prevent it being
+	 * expired before we get a chance to add it.
 	 */
 	BUG_ON(mnt_get_count(mnt) < 2);
 
@@ -3252,7 +3259,8 @@ void mark_mounts_for_expiry(struct list_
 	namespace_lock();
 	lock_mount_hash();
 
-	/* extract from the expiration list every vfsmount that matches the
+	/*
+	 * extract from the expiration list every vfsmount that matches the
 	 * following criteria:
 	 * - only referenced by its parent vfsmount
 	 * - still marked for expiry (marked on the last call here; marks are
@@ -3815,7 +3823,8 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, uns
 	newmount.dentry = dget(fc->root);
 	newmount.mnt->mnt_flags = mnt_flags;
 
-	/* We've done the mount bit - now move the file context into more or
+	/*
+	 * We've done the mount bit - now move the file context into more or
 	 * less the same state as if we'd done an fspick().  We don't want to
 	 * do any memory allocation or anything like that at this point as we
 	 * don't want to have to handle any errors incurred.
@@ -3834,7 +3843,8 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, uns
 	list_add(&mnt->mnt_list, &ns->list);
 	mntget(newmount.mnt);
 
-	/* Attach to an apparent O_PATH fd with a note that we need to unmount
+	/*
+	 * Attach to an apparent O_PATH fd with a note that we need to unmount
 	 * it, not just simply put it.
 	 */
 	file = dentry_open(&newmount, O_PATH, fc->cred);
@@ -3883,7 +3893,8 @@ SYSCALL_DEFINE5(move_mount,
 	if (flags & ~MOVE_MOUNT__MASK)
 		return -EINVAL;
 
-	/* If someone gives a pathname, they aren't permitted to move
+	/*
+	 * If someone gives a pathname, they aren't permitted to move
 	 * from an fd that requires unmount as we can't get at the flag
 	 * to clear it afterwards.
 	 */
@@ -4643,7 +4654,8 @@ static bool mnt_already_visible(struct m
 		if (mnt->mnt.mnt_sb->s_type != sb->s_type)
 			continue;
 
-		/* This mount is not fully visible if it's root directory
+		/*
+		 * This mount is not fully visible if it's root directory
 		 * is not the root directory of the filesystem.
 		 */
 		if (mnt->mnt.mnt_root != mnt->mnt.mnt_sb->s_root)
@@ -4666,7 +4678,8 @@ static bool mnt_already_visible(struct m
 		    ((mnt_flags & MNT_ATIME_MASK) != (new_flags & MNT_ATIME_MASK)))
 			continue;
 
-		/* This mount is not fully visible if there are any
+		/*
+		 * This mount is not fully visible if there are any
 		 * locked child mounts that cover anything except for
 		 * empty directories.
 		 */
