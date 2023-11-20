Return-Path: <linux-fsdevel+bounces-3251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C66257F1B26
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 18:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8C8E1C21224
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 17:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F90724A17;
	Mon, 20 Nov 2023 17:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA616F4;
	Mon, 20 Nov 2023 09:41:36 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4SYvbf4hxXz9xvh1;
	Tue, 21 Nov 2023 01:27:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAXBXXxmVtlIZIKAQ--.7181S6;
	Mon, 20 Nov 2023 18:41:08 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	neilb@suse.de,
	kolga@netapp.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	dhowells@redhat.com,
	jarkko@kernel.org,
	stephen.smalley.work@gmail.com,
	eparis@parisplace.org,
	casey@schaufler-ca.com,
	mic@digikod.net
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	selinux@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v6 24/25] integrity: Remove LSM
Date: Mon, 20 Nov 2023 18:33:17 +0100
Message-Id: <20231120173318.1132868-25-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231120173318.1132868-1-roberto.sassu@huaweicloud.com>
References: <20231120173318.1132868-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwAXBXXxmVtlIZIKAQ--.7181S6
X-Coremail-Antispam: 1UD129KBjvJXoW3ZF43uw15Jr43KFy7Cr4xtFb_yoWDKr4rpF
	4UKayUJr4UAFW09F4vyF15ur1fK34qgFWxW345Cw1kAFyqvw1qqFWDAryUuF1rGrWrK34I
	qrsxKr45uF1DtrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7
	AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wr
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW7JVWDJwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_GcCE3s1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F
	4j6r4UJwCI42IY6I8E87Iv6xkF7I0E14v26rxl6s0DYxBIdaVFxhVjvjDU0xZFpf9x07jx
	WrAUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAHBF1jj5KqdgAAs+
X-CFilter-Loop: Reflected

From: Roberto Sassu <roberto.sassu@huawei.com>

Since now IMA and EVM use their own integrity metadata, it is safe to
remove the 'integrity' LSM, with its management of integrity metadata.

Keep the iint.c file only for loading IMA and EVM keys at boot, and for
creating the integrity directory in securityfs (we need to keep it for
retrocompatibility reasons).

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/linux/fs.h                     |   2 -
 include/linux/integrity.h              |  14 --
 security/integrity/digsig_asymmetric.c |   1 -
 security/integrity/iint.c              | 197 +------------------------
 security/integrity/integrity.h         |  25 ----
 security/security.c                    |   2 -
 6 files changed, 2 insertions(+), 239 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 98b7a7a8c42e..745c1faf6c5b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2104,7 +2104,6 @@ struct super_operations {
 #define S_NOCMTIME	(1 << 7)  /* Do not update file c/mtime */
 #define S_SWAPFILE	(1 << 8)  /* Do not truncate: swapon got its bmaps */
 #define S_PRIVATE	(1 << 9)  /* Inode is fs-internal */
-#define S_IMA		(1 << 10) /* Inode has an associated IMA struct */
 #define S_AUTOMOUNT	(1 << 11) /* Automount/referral quasi-directory */
 #define S_NOSEC		(1 << 12) /* no suid or xattr security attributes */
 #ifdef CONFIG_FS_DAX
@@ -2156,7 +2155,6 @@ static inline bool sb_rdonly(const struct super_block *sb) { return sb->s_flags
 #define IS_NOCMTIME(inode)	((inode)->i_flags & S_NOCMTIME)
 #define IS_SWAPFILE(inode)	((inode)->i_flags & S_SWAPFILE)
 #define IS_PRIVATE(inode)	((inode)->i_flags & S_PRIVATE)
-#define IS_IMA(inode)		((inode)->i_flags & S_IMA)
 #define IS_AUTOMOUNT(inode)	((inode)->i_flags & S_AUTOMOUNT)
 #define IS_NOSEC(inode)		((inode)->i_flags & S_NOSEC)
 #define IS_DAX(inode)		((inode)->i_flags & S_DAX)
diff --git a/include/linux/integrity.h b/include/linux/integrity.h
index ef0f63ef5ebc..459b79683783 100644
--- a/include/linux/integrity.h
+++ b/include/linux/integrity.h
@@ -19,24 +19,10 @@ enum integrity_status {
 	INTEGRITY_UNKNOWN,
 };
 
-/* List of EVM protected security xattrs */
 #ifdef CONFIG_INTEGRITY
-extern struct integrity_iint_cache *integrity_inode_get(struct inode *inode);
-extern void integrity_inode_free(struct inode *inode);
 extern void __init integrity_load_keys(void);
 
 #else
-static inline struct integrity_iint_cache *
-				integrity_inode_get(struct inode *inode)
-{
-	return NULL;
-}
-
-static inline void integrity_inode_free(struct inode *inode)
-{
-	return;
-}
-
 static inline void integrity_load_keys(void)
 {
 }
diff --git a/security/integrity/digsig_asymmetric.c b/security/integrity/digsig_asymmetric.c
index 4d11c622fabd..de603cf42ac7 100644
--- a/security/integrity/digsig_asymmetric.c
+++ b/security/integrity/digsig_asymmetric.c
@@ -132,4 +132,3 @@ int asymmetric_verify(struct key *keyring, const char *sig,
 	pr_debug("%s() = %d\n", __func__, ret);
 	return ret;
 }
-
diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 6cbf2aa5540e..068ac6c2ae1e 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -6,207 +6,14 @@
  * Mimi Zohar <zohar@us.ibm.com>
  *
  * File: integrity_iint.c
- *	- implements the integrity hooks: integrity_inode_alloc,
- *	  integrity_inode_free
- *	- cache integrity information associated with an inode
- *	  using a rbtree tree.
+ *	- initialize the integrity directory in securityfs
+ *	- load IMA and EVM keys
  */
-#include <linux/slab.h>
-#include <linux/init.h>
-#include <linux/spinlock.h>
-#include <linux/rbtree.h>
-#include <linux/file.h>
-#include <linux/uaccess.h>
 #include <linux/security.h>
-#include <linux/lsm_hooks.h>
 #include "integrity.h"
 
-static struct rb_root integrity_iint_tree = RB_ROOT;
-static DEFINE_RWLOCK(integrity_iint_lock);
-static struct kmem_cache *iint_cache __ro_after_init;
-
 struct dentry *integrity_dir;
 
-/*
- * __integrity_iint_find - return the iint associated with an inode
- */
-static struct integrity_iint_cache *__integrity_iint_find(struct inode *inode)
-{
-	struct integrity_iint_cache *iint;
-	struct rb_node *n = integrity_iint_tree.rb_node;
-
-	while (n) {
-		iint = rb_entry(n, struct integrity_iint_cache, rb_node);
-
-		if (inode < iint->inode)
-			n = n->rb_left;
-		else if (inode > iint->inode)
-			n = n->rb_right;
-		else
-			return iint;
-	}
-
-	return NULL;
-}
-
-/*
- * integrity_iint_find - return the iint associated with an inode
- */
-struct integrity_iint_cache *integrity_iint_find(struct inode *inode)
-{
-	struct integrity_iint_cache *iint;
-
-	if (!IS_IMA(inode))
-		return NULL;
-
-	read_lock(&integrity_iint_lock);
-	iint = __integrity_iint_find(inode);
-	read_unlock(&integrity_iint_lock);
-
-	return iint;
-}
-
-#define IMA_MAX_NESTING (FILESYSTEM_MAX_STACK_DEPTH+1)
-
-/*
- * It is not clear that IMA should be nested at all, but as long is it measures
- * files both on overlayfs and on underlying fs, we need to annotate the iint
- * mutex to avoid lockdep false positives related to IMA + overlayfs.
- * See ovl_lockdep_annotate_inode_mutex_key() for more details.
- */
-static inline void iint_lockdep_annotate(struct integrity_iint_cache *iint,
-					 struct inode *inode)
-{
-#ifdef CONFIG_LOCKDEP
-	static struct lock_class_key iint_mutex_key[IMA_MAX_NESTING];
-
-	int depth = inode->i_sb->s_stack_depth;
-
-	if (WARN_ON_ONCE(depth < 0 || depth >= IMA_MAX_NESTING))
-		depth = 0;
-
-	lockdep_set_class(&iint->mutex, &iint_mutex_key[depth]);
-#endif
-}
-
-static void iint_init_always(struct integrity_iint_cache *iint,
-			     struct inode *inode)
-{
-	iint->ima_hash = NULL;
-	iint->version = 0;
-	iint->flags = 0UL;
-	iint->atomic_flags = 0UL;
-	iint->ima_file_status = INTEGRITY_UNKNOWN;
-	iint->ima_mmap_status = INTEGRITY_UNKNOWN;
-	iint->ima_bprm_status = INTEGRITY_UNKNOWN;
-	iint->ima_read_status = INTEGRITY_UNKNOWN;
-	iint->ima_creds_status = INTEGRITY_UNKNOWN;
-	iint->evm_status = INTEGRITY_UNKNOWN;
-	iint->measured_pcrs = 0;
-	mutex_init(&iint->mutex);
-	iint_lockdep_annotate(iint, inode);
-}
-
-static void iint_free(struct integrity_iint_cache *iint)
-{
-	kfree(iint->ima_hash);
-	mutex_destroy(&iint->mutex);
-	kmem_cache_free(iint_cache, iint);
-}
-
-/**
- * integrity_inode_get - find or allocate an iint associated with an inode
- * @inode: pointer to the inode
- * @return: allocated iint
- *
- * Caller must lock i_mutex
- */
-struct integrity_iint_cache *integrity_inode_get(struct inode *inode)
-{
-	struct rb_node **p;
-	struct rb_node *node, *parent = NULL;
-	struct integrity_iint_cache *iint, *test_iint;
-
-	iint = integrity_iint_find(inode);
-	if (iint)
-		return iint;
-
-	iint = kmem_cache_alloc(iint_cache, GFP_NOFS);
-	if (!iint)
-		return NULL;
-
-	iint_init_always(iint, inode);
-
-	write_lock(&integrity_iint_lock);
-
-	p = &integrity_iint_tree.rb_node;
-	while (*p) {
-		parent = *p;
-		test_iint = rb_entry(parent, struct integrity_iint_cache,
-				     rb_node);
-		if (inode < test_iint->inode) {
-			p = &(*p)->rb_left;
-		} else if (inode > test_iint->inode) {
-			p = &(*p)->rb_right;
-		} else {
-			write_unlock(&integrity_iint_lock);
-			kmem_cache_free(iint_cache, iint);
-			return test_iint;
-		}
-	}
-
-	iint->inode = inode;
-	node = &iint->rb_node;
-	inode->i_flags |= S_IMA;
-	rb_link_node(node, parent, p);
-	rb_insert_color(node, &integrity_iint_tree);
-
-	write_unlock(&integrity_iint_lock);
-	return iint;
-}
-
-/**
- * integrity_inode_free - called on security_inode_free
- * @inode: pointer to the inode
- *
- * Free the integrity information(iint) associated with an inode.
- */
-void integrity_inode_free(struct inode *inode)
-{
-	struct integrity_iint_cache *iint;
-
-	if (!IS_IMA(inode))
-		return;
-
-	write_lock(&integrity_iint_lock);
-	iint = __integrity_iint_find(inode);
-	rb_erase(&iint->rb_node, &integrity_iint_tree);
-	write_unlock(&integrity_iint_lock);
-
-	iint_free(iint);
-}
-
-static void iint_init_once(void *foo)
-{
-	struct integrity_iint_cache *iint = (struct integrity_iint_cache *) foo;
-
-	memset(iint, 0, sizeof(*iint));
-}
-
-static int __init integrity_iintcache_init(void)
-{
-	iint_cache =
-	    kmem_cache_create("iint_cache", sizeof(struct integrity_iint_cache),
-			      0, SLAB_PANIC, iint_init_once);
-	return 0;
-}
-
-DEFINE_LSM(integrity) = {
-	.name = "integrity",
-	.init = integrity_iintcache_init,
-	.order = LSM_ORDER_LAST,
-};
-
 /*
  * integrity_kernel_read - read data from the file
  *
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 59eaddd84434..1f473fe876eb 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -156,31 +156,6 @@ struct ima_file_id {
 	__u8 hash[HASH_MAX_DIGESTSIZE];
 } __packed;
 
-/* integrity data associated with an inode */
-struct integrity_iint_cache {
-	struct rb_node rb_node;	/* rooted in integrity_iint_tree */
-	struct mutex mutex;	/* protects: version, flags, digest */
-	struct inode *inode;	/* back pointer to inode in question */
-	u64 version;		/* track inode changes */
-	unsigned long flags;
-	unsigned long measured_pcrs;
-	unsigned long atomic_flags;
-	unsigned long real_ino;
-	dev_t real_dev;
-	enum integrity_status ima_file_status:4;
-	enum integrity_status ima_mmap_status:4;
-	enum integrity_status ima_bprm_status:4;
-	enum integrity_status ima_read_status:4;
-	enum integrity_status ima_creds_status:4;
-	enum integrity_status evm_status:4;
-	struct ima_digest_data *ima_hash;
-};
-
-/* rbtree tree calls to lookup, insert, delete
- * integrity data associated with an inode.
- */
-struct integrity_iint_cache *integrity_iint_find(struct inode *inode);
-
 int integrity_kernel_read(struct file *file, loff_t offset,
 			  void *addr, unsigned long count);
 
diff --git a/security/security.c b/security/security.c
index 7741d2d076c5..351a124b771c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -19,7 +19,6 @@
 #include <linux/kernel.h>
 #include <linux/kernel_read_file.h>
 #include <linux/lsm_hooks.h>
-#include <linux/integrity.h>
 #include <linux/fsnotify.h>
 #include <linux/mman.h>
 #include <linux/mount.h>
@@ -1597,7 +1596,6 @@ static void inode_free_by_rcu(struct rcu_head *head)
  */
 void security_inode_free(struct inode *inode)
 {
-	integrity_inode_free(inode);
 	call_void_hook(inode_free_security, inode);
 	/*
 	 * The inode may still be referenced in a path walk and
-- 
2.34.1


