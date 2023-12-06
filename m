Return-Path: <linux-fsdevel+bounces-4944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 586C280675C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 07:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A0471C209AF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 06:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC2A12E72
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 06:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="C70rExER"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541A210C8
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Dec 2023 22:06:39 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-286d8dae2dbso417855a91.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Dec 2023 22:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1701842798; x=1702447598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5c67p4Iwxfk8EXvTyIdbVdxswTm1LVGC6Ng7PTwCNc=;
        b=C70rExERCUDKVhuB49M3Fxl3WYE+P/JH2DBsrfx8UZ3Zc7HcBSZeAjtSnWWcPnKBRO
         JU5QdqH8lm8KJj/SKiRtRYxuqRwPLlgWXZOEtOmeJSGfnYHiwFBqnF8HDkNvZ0/ZL+Tn
         pdO0v2cOf8w54S8PVvmhaV3/QUZ194kwTJ3w+Wj4n9fjfkFMqL2nNsx2Oh/kSSpBfOY2
         YBMRl+m+f89zvWy+Ct/kjoMG1z8l40Hgd4/esQe45t2Qf+FWpkPRl2MWRUugTMRVeDDw
         jADnmoprU9tbUAdqmbPPAcsj66NQz9dkj709IhL3W/E1pZAXQa6Me7l0Exky/0YTR+WA
         7U6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701842798; x=1702447598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d5c67p4Iwxfk8EXvTyIdbVdxswTm1LVGC6Ng7PTwCNc=;
        b=t9i8aXg+DSgRi1kMSlLhMGMOHtvSFrMP4WE0agwYd9f/Z0CIbcskEx6ZDYPpV8YrAE
         eVm+9D4RbrwAnhomg//yeIYfulPw4iPfdNwTXat72O5zeLsCdhEZRtA37fHz/iyOI61l
         JJ0NaapSBOULklsIPv+Wg08dAhetT7W/Xi7FB2Drn2mWenXPFZaqdBSikIUiJosK48wZ
         vsrWaqbMhSaZTsJbp0PZhROYu9gp5jL329ASi2RWS4cTBFs1O8aWqyKCgd3rl6UKqVRR
         XbXn7Fdkb8Ib4Oy1gmuzjG675TbZC92Fv6eiwINATtpFnjn9Es6z6tCaR9uDSxePGeuB
         JI8A==
X-Gm-Message-State: AOJu0Yyg702QKt36vMpxJ7mx1YUESdCALRsYsotUymYhOiOlM+TuEuss
	uYUTCu7EmexoC5DHk7HmHSsoGw==
X-Google-Smtp-Source: AGHT+IFkKuykeoJVAudwwmFujiDHfPEHX1oc2kW4nogWIOsi4Zh1ZmlEITbhHDDGN4q70xM8zZRpIg==
X-Received: by 2002:a17:90a:d917:b0:286:b01d:88a6 with SMTP id c23-20020a17090ad91700b00286b01d88a6mr2839698pjv.6.1701842798242;
        Tue, 05 Dec 2023 22:06:38 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id m13-20020a17090a858d00b00286920600a9sm5350682pjn.32.2023.12.05.22.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 22:06:35 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.96)
	(envelope-from <dave@fromorbit.com>)
	id 1rAl3I-004VP3-0n;
	Wed, 06 Dec 2023 17:06:31 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.97-RC0)
	(envelope-from <dave@devoid.disaster.area>)
	id 1rAl3H-0000000BrVa-3MP5;
	Wed, 06 Dec 2023 17:06:31 +1100
From: Dave Chinner <david@fromorbit.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	linux-cachefs@redhat.com,
	dhowells@redhat.com,
	gfs2@lists.linux.dev,
	dm-devel@lists.linux.dev,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] vfs: inode cache conversion to hash-bl
Date: Wed,  6 Dec 2023 17:05:37 +1100
Message-ID: <20231206060629.2827226-9-david@fromorbit.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231206060629.2827226-1-david@fromorbit.com>
References: <20231206060629.2827226-1-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Chinner <dchinner@redhat.com>

Scalability of the global inode_hash_lock really sucks for
filesystems that use the vfs inode cache (i.e. everything but XFS).

Profiles of a 32-way concurrent sharded directory walk (no contended
directories) on a couple of different filesystems. All numbers from
a 6.7-rc4 kernel.

Bcachefs:

  - 98.78% vfs_statx
     - 97.74% filename_lookup
	- 97.70% path_lookupat
	   - 97.54% walk_component
	      - 97.06% lookup_slow
		 - 97.03% __lookup_slow
		    - 96.21% bch2_lookup
		       - 91.87% bch2_vfs_inode_get
			  - 84.10% iget5_locked
			     - 44.09% ilookup5
				- 43.50% _raw_spin_lock
				   - 43.49% do_raw_spin_lock
					42.75% __pv_queued_spin_lock_slowpath
			     - 39.06% inode_insert5
				- 38.46% _raw_spin_lock
				   - 38.46% do_raw_spin_lock
					37.51% __pv_queued_spin_lock_slowpath

ext4:

  - 93.75% vfs_statx
     - 92.39% filename_lookup
	- 92.34% path_lookupat
	   - 92.09% walk_component
	      - 91.48% lookup_slow
		 - 91.43% __lookup_slow
		    - 90.18% ext4_lookup
		       - 84.84% __ext4_iget
			  - 83.67% iget_locked
			     - 81.24% _raw_spin_lock
				- 81.23% do_raw_spin_lock
				   - 78.90% __pv_queued_spin_lock_slowpath


Both bcachefs and ext4 demonstrate poor scaling at >=8 threads on
concurrent lookup or create workloads.

Hence convert the inode hash table to a RCU-aware hash-bl table just
like the dentry cache. Note that we need to store a pointer to the
hlist_bl_head the inode has been added to in the inode so that when
it comes to unhash the inode we know what list to lock. We need to
do this because, unlike the dentry cache, the hash value that is
used to hash the inode is not generated from the inode itself. i.e.
filesystems can provide this themselves so we have to either store
the hashval or the hlist head pointer in the inode to be able to
find the right list head for removal...

Concurrent walk of 400k files per thread with varying thread count
in seconds is as follows. Perfect scaling is an unchanged walk time
as thread count increases.

		ext4			bcachefs
threads		vanilla	 patched	vanilla	patched
2		 7.923	  7.358		 8.003	 7.276
4		 8.152	  7.530		 9.097	 8.506
8		13.090	  7.871		11.752	10.015
16		24.602	  9.540		24.614	13.989
32		49.536	 19.314		49.179	25.982

The big wins here are at >= 8 threads, with both filesytsems now
being limited by internal filesystem algorithms, not the VFS inode
cache scalability.

Ext4 contention moves to the buffer cache on directory block
lookups:

-   66.45%     0.44%  [kernel]              [k] __ext4_read_dirblock
   - 66.01% __ext4_read_dirblock
      - 66.01% ext4_bread
         - ext4_getblk
            - 64.77% bdev_getblk
               - 64.69% __find_get_block
                  - 63.01% _raw_spin_lock
                     - 62.96% do_raw_spin_lock
                          59.21% __pv_queued_spin_lock_slowpath

bcachefs contention moves to internal btree traversal locks.

 - 95.37% __lookup_slow
    - 93.95% bch2_lookup
       - 82.57% bch2_vfs_inode_get
	  - 65.44% bch2_inode_find_by_inum_trans
	     - 65.41% bch2_inode_peek_nowarn
		- 64.60% bch2_btree_iter_peek_slot
		   - 64.55% bch2_btree_path_traverse_one
		      - bch2_btree_path_traverse_cached
			 - 63.02% bch2_btree_path_traverse_cached_slowpath
			    - 56.60% mutex_lock
			       - 55.29% __mutex_lock_slowpath
				  - 55.25% __mutex_lock
				       50.29% osq_lock
				       1.84% __raw_callee_save___kvm_vcpu_is_preempted
				       0.54% mutex_spin_on_owner

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 fs/inode.c         | 200 ++++++++++++++++++++++++++++-----------------
 include/linux/fs.h |   9 +-
 2 files changed, 132 insertions(+), 77 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index fead81550cf4..3eb9c4e5b279 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -56,8 +56,7 @@
 
 static unsigned int i_hash_mask __ro_after_init;
 static unsigned int i_hash_shift __ro_after_init;
-static struct hlist_head *inode_hashtable __ro_after_init;
-static __cacheline_aligned_in_smp DEFINE_SPINLOCK(inode_hash_lock);
+static struct hlist_bl_head *inode_hashtable __ro_after_init;
 
 static unsigned long hash(struct super_block *sb, unsigned long hashval)
 {
@@ -69,7 +68,7 @@ static unsigned long hash(struct super_block *sb, unsigned long hashval)
 	return tmp & i_hash_mask;
 }
 
-static inline struct hlist_head *i_hash_head(struct super_block *sb,
+static inline struct hlist_bl_head *i_hash_head(struct super_block *sb,
 		unsigned int hashval)
 {
 	return inode_hashtable + hash(sb, hashval);
@@ -434,7 +433,7 @@ EXPORT_SYMBOL(address_space_init_once);
 void inode_init_once(struct inode *inode)
 {
 	memset(inode, 0, sizeof(*inode));
-	INIT_HLIST_NODE(&inode->i_hash);
+	INIT_HLIST_BL_NODE(&inode->i_hash);
 	INIT_LIST_HEAD(&inode->i_devices);
 	INIT_LIST_HEAD(&inode->i_io_list);
 	INIT_LIST_HEAD(&inode->i_wb_list);
@@ -518,6 +517,17 @@ static inline void inode_sb_list_del(struct inode *inode)
 		dlock_lists_del(&inode->i_sb_list);
 }
 
+/*
+ * Ensure that we store the hash head in the inode when we insert the inode into
+ * the hlist_bl_head...
+ */
+static inline void
+__insert_inode_hash_head(struct inode *inode, struct hlist_bl_head *b)
+{
+	hlist_bl_add_head_rcu(&inode->i_hash, b);
+	inode->i_hash_head = b;
+}
+
 /**
  *	__insert_inode_hash - hash an inode
  *	@inode: unhashed inode
@@ -528,13 +538,13 @@ static inline void inode_sb_list_del(struct inode *inode)
  */
 void __insert_inode_hash(struct inode *inode, unsigned long hashval)
 {
-	struct hlist_head *b = inode_hashtable + hash(inode->i_sb, hashval);
+	struct hlist_bl_head *b = i_hash_head(inode->i_sb, hashval);
 
-	spin_lock(&inode_hash_lock);
+	hlist_bl_lock(b);
 	spin_lock(&inode->i_lock);
-	hlist_add_head_rcu(&inode->i_hash, b);
+	__insert_inode_hash_head(inode, b);
 	spin_unlock(&inode->i_lock);
-	spin_unlock(&inode_hash_lock);
+	hlist_bl_unlock(b);
 }
 EXPORT_SYMBOL(__insert_inode_hash);
 
@@ -546,11 +556,44 @@ EXPORT_SYMBOL(__insert_inode_hash);
  */
 void __remove_inode_hash(struct inode *inode)
 {
-	spin_lock(&inode_hash_lock);
-	spin_lock(&inode->i_lock);
-	hlist_del_init_rcu(&inode->i_hash);
-	spin_unlock(&inode->i_lock);
-	spin_unlock(&inode_hash_lock);
+	struct hlist_bl_head *b = inode->i_hash_head;
+
+	/*
+	 * There are some callers that come through here without synchronisation
+	 * and potentially with multiple references to the inode. Hence we have
+	 * to handle the case that we might race with a remove and insert to a
+	 * different list. Coda, in particular, seems to have a userspace API
+	 * that can directly trigger "unhash/rehash to different list" behaviour
+	 * without any serialisation at all.
+	 *
+	 * Hence we have to handle the situation where the inode->i_hash_head
+	 * might point to a different list than what we expect, indicating that
+	 * we raced with another unhash and potentially a new insertion. This
+	 * means we have to retest the head once we have everything locked up
+	 * and loop again if it doesn't match.
+	 */
+	while (b) {
+		hlist_bl_lock(b);
+		spin_lock(&inode->i_lock);
+		if (b != inode->i_hash_head) {
+			hlist_bl_unlock(b);
+			b = inode->i_hash_head;
+			spin_unlock(&inode->i_lock);
+			continue;
+		}
+		/*
+		 * Need to set the pprev pointer to NULL after list removal so
+		 * that both RCU traversals and hlist_bl_unhashed() work
+		 * correctly at this point.
+		 */
+		hlist_bl_del_rcu(&inode->i_hash);
+		inode->i_hash.pprev = NULL;
+		inode->i_hash_head = NULL;
+		spin_unlock(&inode->i_lock);
+		hlist_bl_unlock(b);
+		break;
+	}
+
 }
 EXPORT_SYMBOL(__remove_inode_hash);
 
@@ -886,26 +929,28 @@ long prune_icache_sb(struct super_block *sb, struct shrink_control *sc)
 	return freed;
 }
 
-static void __wait_on_freeing_inode(struct inode *inode);
+static void __wait_on_freeing_inode(struct hlist_bl_head *b,
+				struct inode *inode);
 /*
  * Called with the inode lock held.
  */
 static struct inode *find_inode(struct super_block *sb,
-				struct hlist_head *head,
+				struct hlist_bl_head *b,
 				int (*test)(struct inode *, void *),
 				void *data)
 {
+	struct hlist_bl_node *node;
 	struct inode *inode = NULL;
 
 repeat:
-	hlist_for_each_entry(inode, head, i_hash) {
+	hlist_bl_for_each_entry(inode, node, b, i_hash) {
 		if (inode->i_sb != sb)
 			continue;
 		if (!test(inode, data))
 			continue;
 		spin_lock(&inode->i_lock);
 		if (inode->i_state & (I_FREEING|I_WILL_FREE)) {
-			__wait_on_freeing_inode(inode);
+			__wait_on_freeing_inode(b, inode);
 			goto repeat;
 		}
 		if (unlikely(inode->i_state & I_CREATING)) {
@@ -924,19 +969,20 @@ static struct inode *find_inode(struct super_block *sb,
  * iget_locked for details.
  */
 static struct inode *find_inode_fast(struct super_block *sb,
-				struct hlist_head *head, unsigned long ino)
+				struct hlist_bl_head *b, unsigned long ino)
 {
+	struct hlist_bl_node *node;
 	struct inode *inode = NULL;
 
 repeat:
-	hlist_for_each_entry(inode, head, i_hash) {
+	hlist_bl_for_each_entry(inode, node, b, i_hash) {
 		if (inode->i_ino != ino)
 			continue;
 		if (inode->i_sb != sb)
 			continue;
 		spin_lock(&inode->i_lock);
 		if (inode->i_state & (I_FREEING|I_WILL_FREE)) {
-			__wait_on_freeing_inode(inode);
+			__wait_on_freeing_inode(b, inode);
 			goto repeat;
 		}
 		if (unlikely(inode->i_state & I_CREATING)) {
@@ -1186,25 +1232,25 @@ EXPORT_SYMBOL(unlock_two_nondirectories);
  * return it locked, hashed, and with the I_NEW flag set. The file system gets
  * to fill it in before unlocking it via unlock_new_inode().
  *
- * Note both @test and @set are called with the inode_hash_lock held, so can't
- * sleep.
+ * Note both @test and @set are called with the inode hash chain lock held,
+ * so can't sleep.
  */
 struct inode *inode_insert5(struct inode *inode, unsigned long hashval,
 			    int (*test)(struct inode *, void *),
 			    int (*set)(struct inode *, void *), void *data)
 {
-	struct hlist_head *head = i_hash_head(inode->i_sb, hashval);
+	struct hlist_bl_head *b = i_hash_head(inode->i_sb, hashval);
 	struct inode *old;
 
 again:
-	spin_lock(&inode_hash_lock);
-	old = find_inode(inode->i_sb, head, test, data);
+	hlist_bl_lock(b);
+	old = find_inode(inode->i_sb, b, test, data);
 	if (unlikely(old)) {
 		/*
 		 * Uhhuh, somebody else created the same inode under us.
 		 * Use the old inode instead of the preallocated one.
 		 */
-		spin_unlock(&inode_hash_lock);
+		hlist_bl_unlock(b);
 		if (IS_ERR(old))
 			return NULL;
 		wait_on_inode(old);
@@ -1226,7 +1272,7 @@ struct inode *inode_insert5(struct inode *inode, unsigned long hashval,
 	 */
 	spin_lock(&inode->i_lock);
 	inode->i_state |= I_NEW;
-	hlist_add_head_rcu(&inode->i_hash, head);
+	__insert_inode_hash_head(inode, b);
 	spin_unlock(&inode->i_lock);
 
 	/*
@@ -1236,7 +1282,7 @@ struct inode *inode_insert5(struct inode *inode, unsigned long hashval,
 	if (list_empty(&inode->i_sb_list.list))
 		inode_sb_list_add(inode);
 unlock:
-	spin_unlock(&inode_hash_lock);
+	hlist_bl_unlock(b);
 
 	return inode;
 }
@@ -1297,12 +1343,12 @@ EXPORT_SYMBOL(iget5_locked);
  */
 struct inode *iget_locked(struct super_block *sb, unsigned long ino)
 {
-	struct hlist_head *head = i_hash_head(sb, ino);
+	struct hlist_bl_head *b = i_hash_head(sb, ino);
 	struct inode *inode;
 again:
-	spin_lock(&inode_hash_lock);
-	inode = find_inode_fast(sb, head, ino);
-	spin_unlock(&inode_hash_lock);
+	hlist_bl_lock(b);
+	inode = find_inode_fast(sb, b, ino);
+	hlist_bl_unlock(b);
 	if (inode) {
 		if (IS_ERR(inode))
 			return NULL;
@@ -1318,17 +1364,17 @@ struct inode *iget_locked(struct super_block *sb, unsigned long ino)
 	if (inode) {
 		struct inode *old;
 
-		spin_lock(&inode_hash_lock);
+		hlist_bl_lock(b);
 		/* We released the lock, so.. */
-		old = find_inode_fast(sb, head, ino);
+		old = find_inode_fast(sb, b, ino);
 		if (!old) {
 			inode->i_ino = ino;
 			spin_lock(&inode->i_lock);
 			inode->i_state = I_NEW;
-			hlist_add_head_rcu(&inode->i_hash, head);
+			__insert_inode_hash_head(inode, b);
 			spin_unlock(&inode->i_lock);
 			inode_sb_list_add(inode);
-			spin_unlock(&inode_hash_lock);
+			hlist_bl_unlock(b);
 
 			/* Return the locked inode with I_NEW set, the
 			 * caller is responsible for filling in the contents
@@ -1341,7 +1387,7 @@ struct inode *iget_locked(struct super_block *sb, unsigned long ino)
 		 * us. Use the old inode instead of the one we just
 		 * allocated.
 		 */
-		spin_unlock(&inode_hash_lock);
+		hlist_bl_unlock(b);
 		destroy_inode(inode);
 		if (IS_ERR(old))
 			return NULL;
@@ -1365,10 +1411,11 @@ EXPORT_SYMBOL(iget_locked);
  */
 static int test_inode_iunique(struct super_block *sb, unsigned long ino)
 {
-	struct hlist_head *b = i_hash_head(sb, ino);
+	struct hlist_bl_head *b = i_hash_head(sb, ino);
+	struct hlist_bl_node *node;
 	struct inode *inode;
 
-	hlist_for_each_entry_rcu(inode, b, i_hash) {
+	hlist_bl_for_each_entry_rcu(inode, node, b, i_hash) {
 		if (inode->i_ino == ino && inode->i_sb == sb)
 			return 0;
 	}
@@ -1452,12 +1499,12 @@ EXPORT_SYMBOL(igrab);
 struct inode *ilookup5_nowait(struct super_block *sb, unsigned long hashval,
 		int (*test)(struct inode *, void *), void *data)
 {
-	struct hlist_head *head = i_hash_head(sb, hashval);
+	struct hlist_bl_head *b = i_hash_head(sb, hashval);
 	struct inode *inode;
 
-	spin_lock(&inode_hash_lock);
-	inode = find_inode(sb, head, test, data);
-	spin_unlock(&inode_hash_lock);
+	hlist_bl_lock(b);
+	inode = find_inode(sb, b, test, data);
+	hlist_bl_unlock(b);
 
 	return IS_ERR(inode) ? NULL : inode;
 }
@@ -1507,12 +1554,12 @@ EXPORT_SYMBOL(ilookup5);
  */
 struct inode *ilookup(struct super_block *sb, unsigned long ino)
 {
-	struct hlist_head *head = i_hash_head(sb, ino);
+	struct hlist_bl_head *b = i_hash_head(sb, ino);
 	struct inode *inode;
 again:
-	spin_lock(&inode_hash_lock);
-	inode = find_inode_fast(sb, head, ino);
-	spin_unlock(&inode_hash_lock);
+	hlist_bl_lock(b);
+	inode = find_inode_fast(sb, b, ino);
+	hlist_bl_unlock(b);
 
 	if (inode) {
 		if (IS_ERR(inode))
@@ -1556,12 +1603,13 @@ struct inode *find_inode_nowait(struct super_block *sb,
 					     void *),
 				void *data)
 {
-	struct hlist_head *head = i_hash_head(sb, hashval);
+	struct hlist_bl_head *b = i_hash_head(sb, hashval);
+	struct hlist_bl_node *node;
 	struct inode *inode, *ret_inode = NULL;
 	int mval;
 
-	spin_lock(&inode_hash_lock);
-	hlist_for_each_entry(inode, head, i_hash) {
+	hlist_bl_lock(b);
+	hlist_bl_for_each_entry(inode, node, b, i_hash) {
 		if (inode->i_sb != sb)
 			continue;
 		mval = match(inode, hashval, data);
@@ -1572,7 +1620,7 @@ struct inode *find_inode_nowait(struct super_block *sb,
 		goto out;
 	}
 out:
-	spin_unlock(&inode_hash_lock);
+	hlist_bl_unlock(b);
 	return ret_inode;
 }
 EXPORT_SYMBOL(find_inode_nowait);
@@ -1601,13 +1649,14 @@ EXPORT_SYMBOL(find_inode_nowait);
 struct inode *find_inode_rcu(struct super_block *sb, unsigned long hashval,
 			     int (*test)(struct inode *, void *), void *data)
 {
-	struct hlist_head *head = i_hash_head(sb, hashval);
+	struct hlist_bl_head *b = i_hash_head(sb, hashval);
+	struct hlist_bl_node *node;
 	struct inode *inode;
 
 	RCU_LOCKDEP_WARN(!rcu_read_lock_held(),
 			 "suspicious find_inode_rcu() usage");
 
-	hlist_for_each_entry_rcu(inode, head, i_hash) {
+	hlist_bl_for_each_entry_rcu(inode, node, b, i_hash) {
 		if (inode->i_sb == sb &&
 		    !(READ_ONCE(inode->i_state) & (I_FREEING | I_WILL_FREE)) &&
 		    test(inode, data))
@@ -1639,13 +1688,14 @@ EXPORT_SYMBOL(find_inode_rcu);
 struct inode *find_inode_by_ino_rcu(struct super_block *sb,
 				    unsigned long ino)
 {
-	struct hlist_head *head = i_hash_head(sb, ino);
+	struct hlist_bl_head *b = i_hash_head(sb, ino);
+	struct hlist_bl_node *node;
 	struct inode *inode;
 
 	RCU_LOCKDEP_WARN(!rcu_read_lock_held(),
 			 "suspicious find_inode_by_ino_rcu() usage");
 
-	hlist_for_each_entry_rcu(inode, head, i_hash) {
+	hlist_bl_for_each_entry_rcu(inode, node, b, i_hash) {
 		if (inode->i_ino == ino &&
 		    inode->i_sb == sb &&
 		    !(READ_ONCE(inode->i_state) & (I_FREEING | I_WILL_FREE)))
@@ -1659,39 +1709,42 @@ int insert_inode_locked(struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
 	ino_t ino = inode->i_ino;
-	struct hlist_head *head = i_hash_head(sb, ino);
+	struct hlist_bl_head *b = i_hash_head(sb, ino);
 
 	while (1) {
-		struct inode *old = NULL;
-		spin_lock(&inode_hash_lock);
-		hlist_for_each_entry(old, head, i_hash) {
-			if (old->i_ino != ino)
+		struct hlist_bl_node *node;
+		struct inode *old = NULL, *t;
+
+		hlist_bl_lock(b);
+		hlist_bl_for_each_entry(t, node, b, i_hash) {
+			if (t->i_ino != ino)
 				continue;
-			if (old->i_sb != sb)
+			if (t->i_sb != sb)
 				continue;
-			spin_lock(&old->i_lock);
-			if (old->i_state & (I_FREEING|I_WILL_FREE)) {
-				spin_unlock(&old->i_lock);
+			spin_lock(&t->i_lock);
+			if (t->i_state & (I_FREEING|I_WILL_FREE)) {
+				spin_unlock(&t->i_lock);
 				continue;
 			}
+			old = t;
 			break;
 		}
 		if (likely(!old)) {
 			spin_lock(&inode->i_lock);
 			inode->i_state |= I_NEW | I_CREATING;
-			hlist_add_head_rcu(&inode->i_hash, head);
+			__insert_inode_hash_head(inode, b);
 			spin_unlock(&inode->i_lock);
-			spin_unlock(&inode_hash_lock);
+			hlist_bl_unlock(b);
 			return 0;
 		}
 		if (unlikely(old->i_state & I_CREATING)) {
 			spin_unlock(&old->i_lock);
-			spin_unlock(&inode_hash_lock);
+			hlist_bl_unlock(b);
 			return -EBUSY;
 		}
 		__iget(old);
 		spin_unlock(&old->i_lock);
-		spin_unlock(&inode_hash_lock);
+		hlist_bl_unlock(b);
 		wait_on_inode(old);
 		if (unlikely(!inode_unhashed(old))) {
 			iput(old);
@@ -2271,17 +2324,18 @@ EXPORT_SYMBOL(inode_needs_sync);
  * wake_up_bit(&inode->i_state, __I_NEW) after removing from the hash list
  * will DTRT.
  */
-static void __wait_on_freeing_inode(struct inode *inode)
+static void __wait_on_freeing_inode(struct hlist_bl_head *b,
+				struct inode *inode)
 {
 	wait_queue_head_t *wq;
 	DEFINE_WAIT_BIT(wait, &inode->i_state, __I_NEW);
 	wq = bit_waitqueue(&inode->i_state, __I_NEW);
 	prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
 	spin_unlock(&inode->i_lock);
-	spin_unlock(&inode_hash_lock);
+	hlist_bl_unlock(b);
 	schedule();
 	finish_wait(wq, &wait.wq_entry);
-	spin_lock(&inode_hash_lock);
+	hlist_bl_lock(b);
 }
 
 static __initdata unsigned long ihash_entries;
@@ -2307,7 +2361,7 @@ void __init inode_init_early(void)
 
 	inode_hashtable =
 		alloc_large_system_hash("Inode-cache",
-					sizeof(struct hlist_head),
+					sizeof(struct hlist_bl_head),
 					ihash_entries,
 					14,
 					HASH_EARLY | HASH_ZERO,
@@ -2333,7 +2387,7 @@ void __init inode_init(void)
 
 	inode_hashtable =
 		alloc_large_system_hash("Inode-cache",
-					sizeof(struct hlist_head),
+					sizeof(struct hlist_bl_head),
 					ihash_entries,
 					14,
 					HASH_ZERO,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index bb35591733f1..0ef1b72340c7 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -692,7 +692,8 @@ struct inode {
 	unsigned long		dirtied_when;	/* jiffies of first dirtying */
 	unsigned long		dirtied_time_when;
 
-	struct hlist_node	i_hash;
+	struct hlist_bl_node	i_hash;
+	struct hlist_bl_head	*i_hash_head;
 	struct list_head	i_io_list;	/* backing dev IO list */
 #ifdef CONFIG_CGROUP_WRITEBACK
 	struct bdi_writeback	*i_wb;		/* the associated cgroup wb */
@@ -758,7 +759,7 @@ static inline unsigned int i_blocksize(const struct inode *node)
 
 static inline int inode_unhashed(struct inode *inode)
 {
-	return hlist_unhashed(&inode->i_hash);
+	return hlist_bl_unhashed(&inode->i_hash);
 }
 
 /*
@@ -769,7 +770,7 @@ static inline int inode_unhashed(struct inode *inode)
  */
 static inline void inode_fake_hash(struct inode *inode)
 {
-	hlist_add_fake(&inode->i_hash);
+	hlist_bl_add_fake(&inode->i_hash);
 }
 
 /*
@@ -2946,7 +2947,7 @@ static inline void insert_inode_hash(struct inode *inode)
 extern void __remove_inode_hash(struct inode *);
 static inline void remove_inode_hash(struct inode *inode)
 {
-	if (!inode_unhashed(inode) && !hlist_fake(&inode->i_hash))
+	if (!inode_unhashed(inode) && !hlist_bl_fake(&inode->i_hash))
 		__remove_inode_hash(inode);
 }
 
-- 
2.42.0


