Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1256F1FC76D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jun 2020 09:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgFQHay (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jun 2020 03:30:54 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:53987 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726271AbgFQHay (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jun 2020 03:30:54 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 6BC0552E;
        Wed, 17 Jun 2020 03:30:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 17 Jun 2020 03:30:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        subject:from:to:cc:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=fm3; bh=KjcVrueijtwR2vVGeRp/lq0vvq
        KnNOZUqYEQUpc1N74=; b=quYzCjGrIw19p/E/tjzaPhq1saFxa0AjQ4FpbM9Pxv
        HMRolHVuIWD8GcM4gnwRHRQSWu7RCNd7ilIpoNpDugDsF+ZVUCh2hj37Im7IgIpb
        nAj39GXI8a/qVwF0LuCMB9OrEtiQM69m/pexNbt6G0Yg01S1Nj6VHli7dkZXUoIs
        nvhm/3JMG7TlsAjmG5r6rdGk027O6vTrWJ5G0kRsAHu9zHNiL6S8Mw9jp6xESAq8
        JkJjLPhNk7kNjdW6K9YykPoZhkqf2Z39p3zfalJ5lJmF016Kws7IX2gWMWhZWrDm
        Zt5uhlwFLmkkbFFlH8amT6Uxoz4qDXOKLnPc6RQguw2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=KjcVru
        eijtwR2vVGeRp/lq0vvqKnNOZUqYEQUpc1N74=; b=JVO5zTxNXA2dRPX8P6DUls
        IeMR2JmrV9WP++NVjtXmrcRm1xPtscdbmtYIpfUhZ5hRYsvEMmJJ6QgHgE4G/yA5
        w/zY1d1KKcK+ok9lVykLAfILPLbeuq5hXewMhN0uGCBuoYSeuppe34NVZjcc+yYv
        syYU2RdnOVE2hN/YZ+89LVeCAiJiAqKNHGBTXQYzfrCgP/v8S1jTpVUwR2oK7wOb
        +Kq5PH+66N6zbMzS2MxBdiUg+RAn4MpNXL2kdbpv5IJGuTgjAaOZPtt4ZJndfMw9
        8VEpZ82H+fG5qOyn5jclOGC8piqH/f/RqGWo+tfmlha44SziHnwDcCtdC1ThZGTQ
        ==
X-ME-Sender: <xms:q8bpXrIoQ0OXvQkm6_PCuU1vPQ-WG9CGDtXrnlnP_W6UvTK4b918lw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudejuddguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefuhffvfffkfgggtgfgsehtjedttddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnhepue
    eikeevgeekveetueffgefhveetieeigefghfejkefgteevheeguddufeethfdunecukfhp
    peehkedrjedrudelgedrkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprhgrvhgvnhesthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:q8bpXvJbNiKabt6P6unhZ0dbKtYnuS8qf45pvv-7FbsrMlE-ZFrX6Q>
    <xmx:q8bpXjvqOP7UcOvEMcaLvPPdecm16P0Y-Byzp-3jCl5j_5qv_1oPLw>
    <xmx:q8bpXkYp9L2SIk88Y5cjypVzYmSlRtWhax5AjD3AzFvj7LBUvdX4ew>
    <xmx:rMbpXpw3LA4MePq__qvK-VffqlKr1Qh4PumJ0fZHTIJm2rmkYwpMNQ>
Received: from mickey.themaw.net (58-7-194-87.dyn.iinet.net.au [58.7.194.87])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8D34B3060F09;
        Wed, 17 Jun 2020 03:30:50 -0400 (EDT)
Received: from mickey.themaw.net (localhost [127.0.0.1])
        by mickey.themaw.net (Postfix) with ESMTP id 146B1A0314;
        Wed, 17 Jun 2020 15:30:47 +0800 (AWST)
Subject: [PATCH v2 1/6] kernfs: switch kernfs to use an rwsem
From:   Ian Kent <raven@themaw.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 17 Jun 2020 15:30:47 +0800
Message-ID: <159237904699.89384.5185766359925629819.stgit@mickey.themaw.net>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The kernfs global lock restricts the ability to perform kernfs node
lookup operations in parallel.

Change the kernfs mutex to an rwsem so that, when oppertunity arises,
node searches can be done in parallel.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/kernfs/dir.c             |  119 +++++++++++++++++++++++--------------------
 fs/kernfs/file.c            |    4 +
 fs/kernfs/inode.c           |   16 +++---
 fs/kernfs/kernfs-internal.h |    5 +-
 fs/kernfs/mount.c           |   12 ++--
 fs/kernfs/symlink.c         |    4 +
 6 files changed, 86 insertions(+), 74 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 9aec80b9d7c6..d8213fc65eba 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -17,7 +17,7 @@
 
 #include "kernfs-internal.h"
 
-DEFINE_MUTEX(kernfs_mutex);
+DECLARE_RWSEM(kernfs_rwsem);
 static DEFINE_SPINLOCK(kernfs_rename_lock);	/* kn->parent and ->name */
 static char kernfs_pr_cont_buf[PATH_MAX];	/* protected by rename_lock */
 static DEFINE_SPINLOCK(kernfs_idr_lock);	/* root->ino_idr */
@@ -26,10 +26,21 @@ static DEFINE_SPINLOCK(kernfs_idr_lock);	/* root->ino_idr */
 
 static bool kernfs_active(struct kernfs_node *kn)
 {
-	lockdep_assert_held(&kernfs_mutex);
 	return atomic_read(&kn->active) >= 0;
 }
 
+static bool kernfs_active_write(struct kernfs_node *kn)
+{
+	lockdep_assert_held_write(&kernfs_rwsem);
+	return kernfs_active(kn);
+}
+
+static bool kernfs_active_read(struct kernfs_node *kn)
+{
+	lockdep_assert_held_read(&kernfs_rwsem);
+	return kernfs_active(kn);
+}
+
 static bool kernfs_lockdep(struct kernfs_node *kn)
 {
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
@@ -340,7 +351,7 @@ static int kernfs_sd_compare(const struct kernfs_node *left,
  *	@kn->parent->dir.children.
  *
  *	Locking:
- *	mutex_lock(kernfs_mutex)
+ *	kernfs_rwsem write lock
  *
  *	RETURNS:
  *	0 on susccess -EEXIST on failure.
@@ -385,7 +396,7 @@ static int kernfs_link_sibling(struct kernfs_node *kn)
  *	removed, %false if @kn wasn't on the rbtree.
  *
  *	Locking:
- *	mutex_lock(kernfs_mutex)
+ *	kernfs_rwsem write lock
  */
 static bool kernfs_unlink_sibling(struct kernfs_node *kn)
 {
@@ -455,14 +466,14 @@ void kernfs_put_active(struct kernfs_node *kn)
  * return after draining is complete.
  */
 static void kernfs_drain(struct kernfs_node *kn)
-	__releases(&kernfs_mutex) __acquires(&kernfs_mutex)
+	__releases(&kernfs_rwsem) __acquires(&kernfs_rwsem)
 {
 	struct kernfs_root *root = kernfs_root(kn);
 
-	lockdep_assert_held(&kernfs_mutex);
+	lockdep_assert_held_write(&kernfs_rwsem);
 	WARN_ON_ONCE(kernfs_active(kn));
 
-	mutex_unlock(&kernfs_mutex);
+	up_write(&kernfs_rwsem);
 
 	if (kernfs_lockdep(kn)) {
 		rwsem_acquire(&kn->dep_map, 0, 0, _RET_IP_);
@@ -481,7 +492,7 @@ static void kernfs_drain(struct kernfs_node *kn)
 
 	kernfs_drain_open_files(kn);
 
-	mutex_lock(&kernfs_mutex);
+	down_write(&kernfs_rwsem);
 }
 
 /**
@@ -560,10 +571,10 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 		goto out_bad_unlocked;
 
 	kn = kernfs_dentry_node(dentry);
-	mutex_lock(&kernfs_mutex);
+	down_read(&kernfs_rwsem);
 
 	/* The kernfs node has been deactivated */
-	if (!kernfs_active(kn))
+	if (!kernfs_active_read(kn))
 		goto out_bad;
 
 	/* The kernfs node has been moved? */
@@ -579,10 +590,10 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 	    kernfs_info(dentry->d_sb)->ns != kn->ns)
 		goto out_bad;
 
-	mutex_unlock(&kernfs_mutex);
+	up_read(&kernfs_rwsem);
 	return 1;
 out_bad:
-	mutex_unlock(&kernfs_mutex);
+	up_read(&kernfs_rwsem);
 out_bad_unlocked:
 	return 0;
 }
@@ -764,7 +775,7 @@ int kernfs_add_one(struct kernfs_node *kn)
 	bool has_ns;
 	int ret;
 
-	mutex_lock(&kernfs_mutex);
+	down_write(&kernfs_rwsem);
 
 	ret = -EINVAL;
 	has_ns = kernfs_ns_enabled(parent);
@@ -779,7 +790,7 @@ int kernfs_add_one(struct kernfs_node *kn)
 	if (parent->flags & KERNFS_EMPTY_DIR)
 		goto out_unlock;
 
-	if ((parent->flags & KERNFS_ACTIVATED) && !kernfs_active(parent))
+	if ((parent->flags & KERNFS_ACTIVATED) && !kernfs_active_write(parent))
 		goto out_unlock;
 
 	kn->hash = kernfs_name_hash(kn->name, kn->ns);
@@ -795,7 +806,7 @@ int kernfs_add_one(struct kernfs_node *kn)
 		ps_iattr->ia_mtime = ps_iattr->ia_ctime;
 	}
 
-	mutex_unlock(&kernfs_mutex);
+	up_write(&kernfs_rwsem);
 
 	/*
 	 * Activate the new node unless CREATE_DEACTIVATED is requested.
@@ -809,7 +820,7 @@ int kernfs_add_one(struct kernfs_node *kn)
 	return 0;
 
 out_unlock:
-	mutex_unlock(&kernfs_mutex);
+	up_write(&kernfs_rwsem);
 	return ret;
 }
 
@@ -830,7 +841,7 @@ static struct kernfs_node *kernfs_find_ns(struct kernfs_node *parent,
 	bool has_ns = kernfs_ns_enabled(parent);
 	unsigned int hash;
 
-	lockdep_assert_held(&kernfs_mutex);
+	lockdep_assert_held(&kernfs_rwsem);
 
 	if (has_ns != (bool)ns) {
 		WARN(1, KERN_WARNING "kernfs: ns %s in '%s' for '%s'\n",
@@ -862,7 +873,7 @@ static struct kernfs_node *kernfs_walk_ns(struct kernfs_node *parent,
 	size_t len;
 	char *p, *name;
 
-	lockdep_assert_held(&kernfs_mutex);
+	lockdep_assert_held_read(&kernfs_rwsem);
 
 	/* grab kernfs_rename_lock to piggy back on kernfs_pr_cont_buf */
 	spin_lock_irq(&kernfs_rename_lock);
@@ -902,10 +913,10 @@ struct kernfs_node *kernfs_find_and_get_ns(struct kernfs_node *parent,
 {
 	struct kernfs_node *kn;
 
-	mutex_lock(&kernfs_mutex);
+	down_read(&kernfs_rwsem);
 	kn = kernfs_find_ns(parent, name, ns);
 	kernfs_get(kn);
-	mutex_unlock(&kernfs_mutex);
+	up_read(&kernfs_rwsem);
 
 	return kn;
 }
@@ -926,10 +937,10 @@ struct kernfs_node *kernfs_walk_and_get_ns(struct kernfs_node *parent,
 {
 	struct kernfs_node *kn;
 
-	mutex_lock(&kernfs_mutex);
+	down_read(&kernfs_rwsem);
 	kn = kernfs_walk_ns(parent, path, ns);
 	kernfs_get(kn);
-	mutex_unlock(&kernfs_mutex);
+	up_read(&kernfs_rwsem);
 
 	return kn;
 }
@@ -1084,7 +1095,7 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 	struct inode *inode;
 	const void *ns = NULL;
 
-	mutex_lock(&kernfs_mutex);
+	down_read(&kernfs_rwsem);
 
 	if (kernfs_ns_enabled(parent))
 		ns = kernfs_info(dir->i_sb)->ns;
@@ -1107,7 +1118,7 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 	/* instantiate and hash dentry */
 	ret = d_splice_alias(inode, dentry);
  out_unlock:
-	mutex_unlock(&kernfs_mutex);
+	up_read(&kernfs_rwsem);
 	return ret;
 }
 
@@ -1226,7 +1237,7 @@ static struct kernfs_node *kernfs_next_descendant_post(struct kernfs_node *pos,
 {
 	struct rb_node *rbn;
 
-	lockdep_assert_held(&kernfs_mutex);
+	lockdep_assert_held_write(&kernfs_rwsem);
 
 	/* if first iteration, visit leftmost descendant which may be root */
 	if (!pos)
@@ -1262,7 +1273,7 @@ void kernfs_activate(struct kernfs_node *kn)
 {
 	struct kernfs_node *pos;
 
-	mutex_lock(&kernfs_mutex);
+	down_write(&kernfs_rwsem);
 
 	pos = NULL;
 	while ((pos = kernfs_next_descendant_post(pos, kn))) {
@@ -1276,14 +1287,14 @@ void kernfs_activate(struct kernfs_node *kn)
 		pos->flags |= KERNFS_ACTIVATED;
 	}
 
-	mutex_unlock(&kernfs_mutex);
+	up_write(&kernfs_rwsem);
 }
 
 static void __kernfs_remove(struct kernfs_node *kn)
 {
 	struct kernfs_node *pos;
 
-	lockdep_assert_held(&kernfs_mutex);
+	lockdep_assert_held_write(&kernfs_rwsem);
 
 	/*
 	 * Short-circuit if non-root @kn has already finished removal.
@@ -1298,7 +1309,7 @@ static void __kernfs_remove(struct kernfs_node *kn)
 	/* prevent any new usage under @kn by deactivating all nodes */
 	pos = NULL;
 	while ((pos = kernfs_next_descendant_post(pos, kn)))
-		if (kernfs_active(pos))
+		if (kernfs_active_write(pos))
 			atomic_add(KN_DEACTIVATED_BIAS, &pos->active);
 
 	/* deactivate and unlink the subtree node-by-node */
@@ -1306,7 +1317,7 @@ static void __kernfs_remove(struct kernfs_node *kn)
 		pos = kernfs_leftmost_descendant(kn);
 
 		/*
-		 * kernfs_drain() drops kernfs_mutex temporarily and @pos's
+		 * kernfs_drain() drops kernfs_rwsem temporarily and @pos's
 		 * base ref could have been put by someone else by the time
 		 * the function returns.  Make sure it doesn't go away
 		 * underneath us.
@@ -1353,9 +1364,9 @@ static void __kernfs_remove(struct kernfs_node *kn)
  */
 void kernfs_remove(struct kernfs_node *kn)
 {
-	mutex_lock(&kernfs_mutex);
+	down_write(&kernfs_rwsem);
 	__kernfs_remove(kn);
-	mutex_unlock(&kernfs_mutex);
+	up_write(&kernfs_rwsem);
 }
 
 /**
@@ -1442,17 +1453,17 @@ bool kernfs_remove_self(struct kernfs_node *kn)
 {
 	bool ret;
 
-	mutex_lock(&kernfs_mutex);
+	down_write(&kernfs_rwsem);
 	kernfs_break_active_protection(kn);
 
 	/*
 	 * SUICIDAL is used to arbitrate among competing invocations.  Only
 	 * the first one will actually perform removal.  When the removal
 	 * is complete, SUICIDED is set and the active ref is restored
-	 * while holding kernfs_mutex.  The ones which lost arbitration
-	 * waits for SUICDED && drained which can happen only after the
-	 * enclosing kernfs operation which executed the winning instance
-	 * of kernfs_remove_self() finished.
+	 * while holding kernfs_rwsem for write.  The ones which lost
+	 * arbitration waits for SUICIDED && drained which can happen only
+	 * after the enclosing kernfs operation which executed the winning
+	 * instance of kernfs_remove_self() finished.
 	 */
 	if (!(kn->flags & KERNFS_SUICIDAL)) {
 		kn->flags |= KERNFS_SUICIDAL;
@@ -1470,9 +1481,9 @@ bool kernfs_remove_self(struct kernfs_node *kn)
 			    atomic_read(&kn->active) == KN_DEACTIVATED_BIAS)
 				break;
 
-			mutex_unlock(&kernfs_mutex);
+			up_write(&kernfs_rwsem);
 			schedule();
-			mutex_lock(&kernfs_mutex);
+			down_write(&kernfs_rwsem);
 		}
 		finish_wait(waitq, &wait);
 		WARN_ON_ONCE(!RB_EMPTY_NODE(&kn->rb));
@@ -1480,12 +1491,12 @@ bool kernfs_remove_self(struct kernfs_node *kn)
 	}
 
 	/*
-	 * This must be done while holding kernfs_mutex; otherwise, waiting
-	 * for SUICIDED && deactivated could finish prematurely.
+	 * This must be done while holding kernfs_rwsem for write; otherwise,
+	 * waiting for SUICIDED && deactivated could finish prematurely.
 	 */
 	kernfs_unbreak_active_protection(kn);
 
-	mutex_unlock(&kernfs_mutex);
+	up_write(&kernfs_rwsem);
 	return ret;
 }
 
@@ -1509,13 +1520,13 @@ int kernfs_remove_by_name_ns(struct kernfs_node *parent, const char *name,
 		return -ENOENT;
 	}
 
-	mutex_lock(&kernfs_mutex);
+	down_write(&kernfs_rwsem);
 
 	kn = kernfs_find_ns(parent, name, ns);
 	if (kn)
 		__kernfs_remove(kn);
 
-	mutex_unlock(&kernfs_mutex);
+	up_write(&kernfs_rwsem);
 
 	if (kn)
 		return 0;
@@ -1541,10 +1552,10 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 	if (!kn->parent)
 		return -EINVAL;
 
-	mutex_lock(&kernfs_mutex);
+	down_write(&kernfs_rwsem);
 
 	error = -ENOENT;
-	if (!kernfs_active(kn) || !kernfs_active(new_parent) ||
+	if (!kernfs_active_write(kn) || !kernfs_active_write(new_parent) ||
 	    (new_parent->flags & KERNFS_EMPTY_DIR))
 		goto out;
 
@@ -1595,7 +1606,7 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 
 	error = 0;
  out:
-	mutex_unlock(&kernfs_mutex);
+	up_write(&kernfs_rwsem);
 	return error;
 }
 
@@ -1615,7 +1626,7 @@ static struct kernfs_node *kernfs_dir_pos(const void *ns,
 	struct kernfs_node *parent, loff_t hash, struct kernfs_node *pos)
 {
 	if (pos) {
-		int valid = kernfs_active(pos) &&
+		int valid = kernfs_active_read(pos) &&
 			pos->parent == parent && hash == pos->hash;
 		kernfs_put(pos);
 		if (!valid)
@@ -1635,7 +1646,7 @@ static struct kernfs_node *kernfs_dir_pos(const void *ns,
 		}
 	}
 	/* Skip over entries which are dying/dead or in the wrong namespace */
-	while (pos && (!kernfs_active(pos) || pos->ns != ns)) {
+	while (pos && (!kernfs_active_read(pos) || pos->ns != ns)) {
 		struct rb_node *node = rb_next(&pos->rb);
 		if (!node)
 			pos = NULL;
@@ -1656,7 +1667,7 @@ static struct kernfs_node *kernfs_dir_next_pos(const void *ns,
 				pos = NULL;
 			else
 				pos = rb_to_kn(node);
-		} while (pos && (!kernfs_active(pos) || pos->ns != ns));
+		} while (pos && (!kernfs_active_read(pos) || pos->ns != ns));
 	}
 	return pos;
 }
@@ -1670,7 +1681,7 @@ static int kernfs_fop_readdir(struct file *file, struct dir_context *ctx)
 
 	if (!dir_emit_dots(file, ctx))
 		return 0;
-	mutex_lock(&kernfs_mutex);
+	down_read(&kernfs_rwsem);
 
 	if (kernfs_ns_enabled(parent))
 		ns = kernfs_info(dentry->d_sb)->ns;
@@ -1687,12 +1698,12 @@ static int kernfs_fop_readdir(struct file *file, struct dir_context *ctx)
 		file->private_data = pos;
 		kernfs_get(pos);
 
-		mutex_unlock(&kernfs_mutex);
+		up_read(&kernfs_rwsem);
 		if (!dir_emit(ctx, name, len, ino, type))
 			return 0;
-		mutex_lock(&kernfs_mutex);
+		down_read(&kernfs_rwsem);
 	}
-	mutex_unlock(&kernfs_mutex);
+	up_read(&kernfs_rwsem);
 	file->private_data = NULL;
 	ctx->pos = INT_MAX;
 	return 0;
diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 34366db3620d..455caea6ab0b 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -879,7 +879,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 	spin_unlock_irq(&kernfs_notify_lock);
 
 	/* kick fsnotify */
-	mutex_lock(&kernfs_mutex);
+	down_write(&kernfs_rwsem);
 
 	list_for_each_entry(info, &kernfs_root(kn)->supers, node) {
 		struct kernfs_node *parent;
@@ -916,7 +916,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 		iput(inode);
 	}
 
-	mutex_unlock(&kernfs_mutex);
+	up_write(&kernfs_rwsem);
 	kernfs_put(kn);
 	goto repeat;
 }
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index fc2469a20fed..23a7996d06a9 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -106,9 +106,9 @@ int kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr)
 {
 	int ret;
 
-	mutex_lock(&kernfs_mutex);
+	down_write(&kernfs_rwsem);
 	ret = __kernfs_setattr(kn, iattr);
-	mutex_unlock(&kernfs_mutex);
+	up_write(&kernfs_rwsem);
 	return ret;
 }
 
@@ -121,7 +121,7 @@ int kernfs_iop_setattr(struct dentry *dentry, struct iattr *iattr)
 	if (!kn)
 		return -EINVAL;
 
-	mutex_lock(&kernfs_mutex);
+	down_write(&kernfs_rwsem);
 	error = setattr_prepare(dentry, iattr);
 	if (error)
 		goto out;
@@ -134,7 +134,7 @@ int kernfs_iop_setattr(struct dentry *dentry, struct iattr *iattr)
 	setattr_copy(inode, iattr);
 
 out:
-	mutex_unlock(&kernfs_mutex);
+	up_write(&kernfs_rwsem);
 	return error;
 }
 
@@ -189,9 +189,9 @@ int kernfs_iop_getattr(const struct path *path, struct kstat *stat,
 	struct inode *inode = d_inode(path->dentry);
 	struct kernfs_node *kn = inode->i_private;
 
-	mutex_lock(&kernfs_mutex);
+	down_write(&kernfs_rwsem);
 	kernfs_refresh_inode(kn, inode);
-	mutex_unlock(&kernfs_mutex);
+	up_writeread(&kernfs_rwsem);
 
 	generic_fillattr(inode, stat);
 	return 0;
@@ -281,9 +281,9 @@ int kernfs_iop_permission(struct inode *inode, int mask)
 
 	kn = inode->i_private;
 
-	mutex_lock(&kernfs_mutex);
+	down_write(&kernfs_rwsem);
 	kernfs_refresh_inode(kn, inode);
-	mutex_unlock(&kernfs_mutex);
+	up_write(&kernfs_rwsem);
 
 	return generic_permission(inode, mask);
 }
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index 7ee97ef59184..097c1a989aa4 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -13,6 +13,7 @@
 #include <linux/lockdep.h>
 #include <linux/fs.h>
 #include <linux/mutex.h>
+#include <linux/rwsem.h>
 #include <linux/xattr.h>
 
 #include <linux/kernfs.h>
@@ -69,7 +70,7 @@ struct kernfs_super_info {
 	 */
 	const void		*ns;
 
-	/* anchored at kernfs_root->supers, protected by kernfs_mutex */
+	/* anchored at kernfs_root->supers, protected by kernfs_rwsem */
 	struct list_head	node;
 };
 #define kernfs_info(SB) ((struct kernfs_super_info *)(SB->s_fs_info))
@@ -99,7 +100,7 @@ int __kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr);
 /*
  * dir.c
  */
-extern struct mutex kernfs_mutex;
+extern struct rw_semaphore kernfs_rwsem;
 extern const struct dentry_operations kernfs_dops;
 extern const struct file_operations kernfs_dir_fops;
 extern const struct inode_operations kernfs_dir_iops;
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index 9dc7e7a64e10..baa4155ba2ed 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -255,9 +255,9 @@ static int kernfs_fill_super(struct super_block *sb, struct kernfs_fs_context *k
 	sb->s_shrink.seeks = 0;
 
 	/* get root inode, initialize and unlock it */
-	mutex_lock(&kernfs_mutex);
+	down_write(&kernfs_rwsem);
 	inode = kernfs_get_inode(sb, info->root->kn);
-	mutex_unlock(&kernfs_mutex);
+	up_write(&kernfs_rwsem);
 	if (!inode) {
 		pr_debug("kernfs: could not get root inode\n");
 		return -ENOMEM;
@@ -344,9 +344,9 @@ int kernfs_get_tree(struct fs_context *fc)
 		}
 		sb->s_flags |= SB_ACTIVE;
 
-		mutex_lock(&kernfs_mutex);
+		down_write(&kernfs_rwsem);
 		list_add(&info->node, &info->root->supers);
-		mutex_unlock(&kernfs_mutex);
+		up_write(&kernfs_rwsem);
 	}
 
 	fc->root = dget(sb->s_root);
@@ -372,9 +372,9 @@ void kernfs_kill_sb(struct super_block *sb)
 {
 	struct kernfs_super_info *info = kernfs_info(sb);
 
-	mutex_lock(&kernfs_mutex);
+	down_write(&kernfs_rwsem);
 	list_del(&info->node);
-	mutex_unlock(&kernfs_mutex);
+	up_write(&kernfs_rwsem);
 
 	/*
 	 * Remove the superblock from fs_supers/s_instances
diff --git a/fs/kernfs/symlink.c b/fs/kernfs/symlink.c
index 5432883d819f..7246b470de3c 100644
--- a/fs/kernfs/symlink.c
+++ b/fs/kernfs/symlink.c
@@ -116,9 +116,9 @@ static int kernfs_getlink(struct inode *inode, char *path)
 	struct kernfs_node *target = kn->symlink.target_kn;
 	int error;
 
-	mutex_lock(&kernfs_mutex);
+	down_write(&kernfs_rwsem);
 	error = kernfs_get_target_path(parent, target, path);
-	mutex_unlock(&kernfs_mutex);
+	up_write(&kernfs_rwsem);
 
 	return error;
 }


