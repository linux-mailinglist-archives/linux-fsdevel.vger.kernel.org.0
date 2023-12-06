Return-Path: <linux-fsdevel+bounces-4945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B74F80674A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 07:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10103280A80
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 06:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C361C32
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 06:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="SvdV/jF9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A8710CA
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Dec 2023 22:06:39 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1d0ccda19eeso9185905ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Dec 2023 22:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1701842799; x=1702447599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NnFiB1AOSnW5eXL0TXhVYgeL/vpsO/mdIcAfnCTORyA=;
        b=SvdV/jF9qBeunUyMw46u+j5wYLGdMXjRoiGBMsjCKwtEQJP3jhHGWTferAhYSizaCV
         fJpjzSUA1CkVJXuIsxI5iNPOAjJKKTL8dNF29vQGST2Xe+zzJorLUMyBenHkp9NtBc6Q
         DxT4Z+GzKlg+CBoEsfYlvHEt+chxZlCMIqaJmhwhpIJczkV53LuHCPLxmYbtvvFhKVTz
         JD/Gv3AJQDddoc64LIu5SNvVU/sIKB5W1FFkV2oPFQ/sKoLWVjTdrXdPRj5Bg9Vwz5wW
         EoeG8oV/pGF4X9z1txW22KjLuaLzk3FWsSjTNfjrWMh413GY7xNEySyzFkhn1rcgz+a7
         PAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701842799; x=1702447599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NnFiB1AOSnW5eXL0TXhVYgeL/vpsO/mdIcAfnCTORyA=;
        b=JdOQaYoVwqAlmw/h8r9KKOzOX9J/hg3bGr8ZkBZK6UkveAmPZxkMIVqsYyjGAI0T8S
         jwFEV5pZJ57QAJ17dip7mcx2Ybmwsp2FVzIzU9tJH6DS80vuReCTQtKcC3qlazGfgqse
         MaA5eCLcqHZ+aqH+SzIsPeDPVGymwnTBHMno0mX+4NPhdelvBrj/b32+LA5jJryVnlfi
         FOZsmb6kwAKvtKqWJ/gKqz8/U3m3z5ZDCMHKZiRqQUDI6cXYKtwGZHbUDbQzGcJlVQ16
         Oe3UGy1uDYuYjQxoWl31ggOXSofNVa3754y25BQl4+ZHlg1sB++goNZ8tZWmgDzQqPQT
         F4Dg==
X-Gm-Message-State: AOJu0YzPs/PBHtD0xU7bj5FZNu2OiS9Ln/QZzz9pDNgKJKbtsSeXiV4S
	UlYiyH7//PJXcyYYW0rt80PPkQ==
X-Google-Smtp-Source: AGHT+IHnOknw8OjWrnQAs5nfw1dZTQS0ZMfwHkjinURX0IvbbckhfMQRoU6wqY+9qjtNVe9wFLMfWg==
X-Received: by 2002:a17:902:b28c:b0:1d0:6ffe:1e89 with SMTP id u12-20020a170902b28c00b001d06ffe1e89mr238281plr.108.1701842798702;
        Tue, 05 Dec 2023 22:06:38 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id i4-20020a17090332c400b001d071d58e85sm7382209plr.98.2023.12.05.22.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 22:06:35 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.96)
	(envelope-from <dave@fromorbit.com>)
	id 1rAl3H-004VOj-33;
	Wed, 06 Dec 2023 17:06:31 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.97-RC0)
	(envelope-from <dave@devoid.disaster.area>)
	id 1rAl3H-0000000BrVB-27ej;
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
Subject: [PATCH 03/11] vfs: Use dlock list for superblock's inode list
Date: Wed,  6 Dec 2023 17:05:32 +1100
Message-ID: <20231206060629.2827226-4-david@fromorbit.com>
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

From: Waiman Long <longman@redhat.com>

[dchinner: original commit message preserved]

When many threads are trying to add or delete inode to or from
a superblock's s_inodes list, spinlock contention on the list can
become a performance bottleneck.

This patch changes the s_inodes field to become a dlock list which
is a distributed set of lists with per-list spinlocks.  As a result,
the following superblock inode list (sb->s_inodes) iteration functions
in vfs are also being modified:

 1. iterate_bdevs()
 2. drop_pagecache_sb()
 3. evict_inodes()
 4. invalidate_inodes()
 5. fsnotify_unmount_inodes()
 6. add_dquot_ref()
 7. remove_dquot_ref()

With an exit microbenchmark that creates a large number of threads,
attachs many inodes to them in procfs and then exits. The runtimes of
that microbenchmark with various number of threads before and after
the patch on a 4-socket Intel E7-8867 v3 system (64 cores, 128 threads)
on a 4.19-rc3 based kernel were as follows:

  # of threads  Elapsed/Sys Time    Elapsed/Sys Time    Speedup
                Unpatched Kernel     Patched Kernel
  ------------  ----------------    ----------------    -------
      1000      59.17s/123m09.8s    18.90s/24m44.5s      3.13
      1200      73.20s/151m24.1s    27.54s/50m05.3s      2.66
      1400     102.04s/212m00.9s    36.75s/68m26.7s      2.78
      1600     131.13s/272m52.4s    50.16s/94m23.7s      2.61

[dchinner: forward port, add new inode list traversals, etc]
[dchinner: scalability results on current TOT XFS]

With 400k inodes per thread concurrent directory traversal workload,
scalability improves at >=16 threads on 6.7-rc4 on XFS. We only test
XFS here as it is the only filesystem that demonstrates sufficient
internal scalability for the superblock inode list to be a
scalability bottleneck.

Table contains test runtime in seconds; perfect scalability is
demonstrated by the runtime staying constant as thread count goes up.

Threads		6.4-rc7		patched
-------		-------		-------
2		11.673		11.158
4		 9.665		 9.444
8		10.622		 9.275
16		12.148		 9.508
32		20.518		10.308

Unpatched kernel profile at 32 threads:

- 95.45% vfs_fstatat
  - 95.00% vfs_statx
     - 91.00% filename_lookup
	- 90.90% path_lookupat
	   - 90.40% walk_component
	      - 89.05% lookup_slow
		 - 88.95% __lookup_slow
		    - 86.38% xfs_vn_lookup
		       - 84.05% xfs_lookup
			  - 78.82% xfs_iget
			     - 72.58% xfs_setup_inode
				- 72.54% inode_sb_list_add
				   - 71.12% _raw_spin_lock
				      - 71.09% do_raw_spin_lock
					 - 68.85% __pv_queued_spin_lock_slowpath

Patched kernel profile at 32 threads - the biggest single point of
contention is now the dentry cache LRU via dput():

-   21.59%     0.25%  [kernel]              [k] dput
   - 21.34% dput
      - 19.93% retain_dentry
         - d_lru_add
            - 19.82% list_lru_add
               - 14.62% _raw_spin_lock
                  - 14.47% do_raw_spin_lock
                       10.89% __pv_queued_spin_lock_slowpath
                 1.78% __list_add_valid_or_report
               - 0.81% _raw_spin_unlock
                  - do_raw_spin_unlock
                       0.77% __raw_callee_save___pv_queued_spin_unlock
      - 0.79% _raw_spin_unlock
         - 0.78% do_raw_spin_unlock
              0.67% __raw_callee_save___pv_queued_spin_unlock

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 block/bdev.c           | 24 ++++++++----------------
 fs/drop_caches.c       |  9 ++++-----
 fs/gfs2/ops_fstype.c   | 21 +++++++++++----------
 fs/inode.c             | 37 ++++++++++++++++---------------------
 fs/notify/fsnotify.c   | 12 ++++++------
 fs/quota/dquot.c       | 22 ++++++----------------
 fs/super.c             | 13 +++++++------
 include/linux/fs.h     |  8 ++++----
 security/landlock/fs.c | 25 ++++++-------------------
 9 files changed, 68 insertions(+), 103 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 750aec178b6a..07135fd6fda4 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -437,11 +437,11 @@ long nr_blockdev_pages(void)
 {
 	struct inode *inode;
 	long ret = 0;
+	DEFINE_DLOCK_LIST_ITER(iter, &blockdev_superblock->s_inodes);
 
-	spin_lock(&blockdev_superblock->s_inode_list_lock);
-	list_for_each_entry(inode, &blockdev_superblock->s_inodes, i_sb_list)
+	dlist_for_each_entry(inode, &iter, i_sb_list) {
 		ret += inode->i_mapping->nrpages;
-	spin_unlock(&blockdev_superblock->s_inode_list_lock);
+	}
 
 	return ret;
 }
@@ -1032,9 +1032,9 @@ EXPORT_SYMBOL_GPL(bdev_mark_dead);
 void sync_bdevs(bool wait)
 {
 	struct inode *inode, *old_inode = NULL;
+	DEFINE_DLOCK_LIST_ITER(iter, &blockdev_superblock->s_inodes);
 
-	spin_lock(&blockdev_superblock->s_inode_list_lock);
-	list_for_each_entry(inode, &blockdev_superblock->s_inodes, i_sb_list) {
+	dlist_for_each_entry(inode, &iter, i_sb_list) {
 		struct address_space *mapping = inode->i_mapping;
 		struct block_device *bdev;
 
@@ -1046,15 +1046,8 @@ void sync_bdevs(bool wait)
 		}
 		__iget(inode);
 		spin_unlock(&inode->i_lock);
-		spin_unlock(&blockdev_superblock->s_inode_list_lock);
-		/*
-		 * We hold a reference to 'inode' so it couldn't have been
-		 * removed from s_inodes list while we dropped the
-		 * s_inode_list_lock  We cannot iput the inode now as we can
-		 * be holding the last reference and we cannot iput it under
-		 * s_inode_list_lock. So we keep the reference and iput it
-		 * later.
-		 */
+		dlock_list_unlock(&iter);
+
 		iput(old_inode);
 		old_inode = inode;
 		bdev = I_BDEV(inode);
@@ -1075,9 +1068,8 @@ void sync_bdevs(bool wait)
 		}
 		mutex_unlock(&bdev->bd_disk->open_mutex);
 
-		spin_lock(&blockdev_superblock->s_inode_list_lock);
+		dlock_list_relock(&iter);
 	}
-	spin_unlock(&blockdev_superblock->s_inode_list_lock);
 	iput(old_inode);
 }
 
diff --git a/fs/drop_caches.c b/fs/drop_caches.c
index b9575957a7c2..3596d0a7c0da 100644
--- a/fs/drop_caches.c
+++ b/fs/drop_caches.c
@@ -19,9 +19,9 @@ int sysctl_drop_caches;
 static void drop_pagecache_sb(struct super_block *sb, void *unused)
 {
 	struct inode *inode, *toput_inode = NULL;
+	DEFINE_DLOCK_LIST_ITER(iter, &sb->s_inodes);
 
-	spin_lock(&sb->s_inode_list_lock);
-	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
+	dlist_for_each_entry(inode, &iter, i_sb_list) {
 		spin_lock(&inode->i_lock);
 		/*
 		 * We must skip inodes in unusual state. We may also skip
@@ -35,16 +35,15 @@ static void drop_pagecache_sb(struct super_block *sb, void *unused)
 		}
 		__iget(inode);
 		spin_unlock(&inode->i_lock);
-		spin_unlock(&sb->s_inode_list_lock);
+		dlock_list_unlock(&iter);
 
 		invalidate_mapping_pages(inode->i_mapping, 0, -1);
 		iput(toput_inode);
 		toput_inode = inode;
 
 		cond_resched();
-		spin_lock(&sb->s_inode_list_lock);
+		dlock_list_relock(&iter);
 	}
-	spin_unlock(&sb->s_inode_list_lock);
 	iput(toput_inode);
 }
 
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index b108c5d26839..1105710482e7 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1738,22 +1738,24 @@ static int gfs2_meta_init_fs_context(struct fs_context *fc)
  * attempt will time out.  Since inodes are evicted sequentially, this can add
  * up quickly.
  *
- * Function evict_inodes() tries to keep the s_inode_list_lock list locked over
- * a long time, which prevents other inodes from being evicted concurrently.
- * This precludes the cooperative behavior we are looking for.  This special
- * version of evict_inodes() avoids that.
- *
  * Modeled after drop_pagecache_sb().
+ *
+ * XXX(dgc): this is particularly awful. With the dlist for inodes, concurrent
+ * access to the inode list can occur and evict_inodes() will drop the per-cpu
+ * list lock if the CPU needs rescheduling. Hence if this exists just because
+ * evict_inodes() holds the s_inode_list_lock for long periods preventing
+ * concurrent inode eviction work from being done, this can probably go away
+ * entirely now.
  */
 static void gfs2_evict_inodes(struct super_block *sb)
 {
 	struct inode *inode, *toput_inode = NULL;
 	struct gfs2_sbd *sdp = sb->s_fs_info;
+	DEFINE_DLOCK_LIST_ITER(iter, &sb->s_inodes);
 
 	set_bit(SDF_EVICTING, &sdp->sd_flags);
 
-	spin_lock(&sb->s_inode_list_lock);
-	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
+	dlist_for_each_entry(inode, &iter, i_sb_list) {
 		spin_lock(&inode->i_lock);
 		if ((inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) &&
 		    !need_resched()) {
@@ -1762,15 +1764,14 @@ static void gfs2_evict_inodes(struct super_block *sb)
 		}
 		atomic_inc(&inode->i_count);
 		spin_unlock(&inode->i_lock);
-		spin_unlock(&sb->s_inode_list_lock);
+		dlock_list_unlock(&iter);
 
 		iput(toput_inode);
 		toput_inode = inode;
 
 		cond_resched();
-		spin_lock(&sb->s_inode_list_lock);
+		dlock_list_relock(&iter);
 	}
-	spin_unlock(&sb->s_inode_list_lock);
 	iput(toput_inode);
 }
 
diff --git a/fs/inode.c b/fs/inode.c
index 17c50a75514f..3426691fa305 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -30,7 +30,7 @@
  *   inode->i_state, inode->i_hash, __iget(), inode->i_io_list
  * Inode LRU list locks protect:
  *   inode->i_sb->s_inode_lru, inode->i_lru
- * inode->i_sb->s_inode_list_lock protects:
+ * inode->i_sb->s_inodes->head->lock protects:
  *   inode->i_sb->s_inodes, inode->i_sb_list
  * bdi->wb.list_lock protects:
  *   bdi->wb.b_{dirty,io,more_io,dirty_time}, inode->i_io_list
@@ -39,7 +39,7 @@
  *
  * Lock ordering:
  *
- * inode->i_sb->s_inode_list_lock
+ * inode->i_sb->s_inodes->head->lock
  *   inode->i_lock
  *     Inode LRU list locks
  *
@@ -47,7 +47,7 @@
  *   inode->i_lock
  *
  * inode_hash_lock
- *   inode->i_sb->s_inode_list_lock
+ *   inode->i_sb->s_inodes->head->lock
  *   inode->i_lock
  *
  * iunique_lock
@@ -423,7 +423,7 @@ void inode_init_once(struct inode *inode)
 	INIT_LIST_HEAD(&inode->i_io_list);
 	INIT_LIST_HEAD(&inode->i_wb_list);
 	INIT_LIST_HEAD(&inode->i_lru);
-	INIT_LIST_HEAD(&inode->i_sb_list);
+	init_dlock_list_node(&inode->i_sb_list);
 	__address_space_init_once(&inode->i_data);
 	i_size_ordered_init(inode);
 }
@@ -492,19 +492,14 @@ static void inode_lru_list_del(struct inode *inode)
  */
 void inode_sb_list_add(struct inode *inode)
 {
-	spin_lock(&inode->i_sb->s_inode_list_lock);
-	list_add(&inode->i_sb_list, &inode->i_sb->s_inodes);
-	spin_unlock(&inode->i_sb->s_inode_list_lock);
+	dlock_lists_add(&inode->i_sb_list, &inode->i_sb->s_inodes);
 }
 EXPORT_SYMBOL_GPL(inode_sb_list_add);
 
 static inline void inode_sb_list_del(struct inode *inode)
 {
-	if (!list_empty(&inode->i_sb_list)) {
-		spin_lock(&inode->i_sb->s_inode_list_lock);
-		list_del_init(&inode->i_sb_list);
-		spin_unlock(&inode->i_sb->s_inode_list_lock);
-	}
+	if (!list_empty(&inode->i_sb_list.list))
+		dlock_lists_del(&inode->i_sb_list);
 }
 
 static unsigned long hash(struct super_block *sb, unsigned long hashval)
@@ -713,11 +708,12 @@ static void dispose_list(struct list_head *head)
 void evict_inodes(struct super_block *sb)
 {
 	struct inode *inode;
+	struct dlock_list_iter iter;
 	LIST_HEAD(dispose);
 
 again:
-	spin_lock(&sb->s_inode_list_lock);
-	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
+	init_dlock_list_iter(&iter, &sb->s_inodes);
+	dlist_for_each_entry(inode, &iter, i_sb_list) {
 		if (atomic_read(&inode->i_count))
 			continue;
 
@@ -738,13 +734,12 @@ void evict_inodes(struct super_block *sb)
 		 * bit so we don't livelock.
 		 */
 		if (need_resched()) {
-			spin_unlock(&sb->s_inode_list_lock);
+			dlock_list_unlock(&iter);
 			cond_resched();
 			dispose_list(&dispose);
 			goto again;
 		}
 	}
-	spin_unlock(&sb->s_inode_list_lock);
 
 	dispose_list(&dispose);
 }
@@ -759,11 +754,12 @@ EXPORT_SYMBOL_GPL(evict_inodes);
 void invalidate_inodes(struct super_block *sb)
 {
 	struct inode *inode;
+	struct dlock_list_iter iter;
 	LIST_HEAD(dispose);
 
 again:
-	spin_lock(&sb->s_inode_list_lock);
-	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
+	init_dlock_list_iter(&iter, &sb->s_inodes);
+	dlist_for_each_entry(inode, &iter, i_sb_list) {
 		spin_lock(&inode->i_lock);
 		if (inode->i_state & (I_NEW | I_FREEING | I_WILL_FREE)) {
 			spin_unlock(&inode->i_lock);
@@ -779,13 +775,12 @@ void invalidate_inodes(struct super_block *sb)
 		spin_unlock(&inode->i_lock);
 		list_add(&inode->i_lru, &dispose);
 		if (need_resched()) {
-			spin_unlock(&sb->s_inode_list_lock);
+			dlock_list_unlock(&iter);
 			cond_resched();
 			dispose_list(&dispose);
 			goto again;
 		}
 	}
-	spin_unlock(&sb->s_inode_list_lock);
 
 	dispose_list(&dispose);
 }
@@ -1232,7 +1227,7 @@ struct inode *inode_insert5(struct inode *inode, unsigned long hashval,
 	 * Add inode to the sb list if it's not already. It has I_NEW at this
 	 * point, so it should be safe to test i_sb_list locklessly.
 	 */
-	if (list_empty(&inode->i_sb_list))
+	if (list_empty(&inode->i_sb_list.list))
 		inode_sb_list_add(inode);
 unlock:
 	spin_unlock(&inode_hash_lock);
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 7974e91ffe13..15e3769e76f5 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -33,14 +33,15 @@ void __fsnotify_vfsmount_delete(struct vfsmount *mnt)
  * @sb: superblock being unmounted.
  *
  * Called during unmount with no locks held, so needs to be safe against
- * concurrent modifiers. We temporarily drop sb->s_inode_list_lock and CAN block.
+ * concurrent modifiers. We temporarily drop sb->s_inodes list lock and CAN
+ * block.
  */
 static void fsnotify_unmount_inodes(struct super_block *sb)
 {
 	struct inode *inode, *iput_inode = NULL;
+	DEFINE_DLOCK_LIST_ITER(iter, &sb->s_inodes);
 
-	spin_lock(&sb->s_inode_list_lock);
-	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
+	dlist_for_each_entry(inode, &iter, i_sb_list) {
 		/*
 		 * We cannot __iget() an inode in state I_FREEING,
 		 * I_WILL_FREE, or I_NEW which is fine because by that point
@@ -68,7 +69,7 @@ static void fsnotify_unmount_inodes(struct super_block *sb)
 
 		__iget(inode);
 		spin_unlock(&inode->i_lock);
-		spin_unlock(&sb->s_inode_list_lock);
+		dlock_list_unlock(&iter);
 
 		iput(iput_inode);
 
@@ -80,9 +81,8 @@ static void fsnotify_unmount_inodes(struct super_block *sb)
 		iput_inode = inode;
 
 		cond_resched();
-		spin_lock(&sb->s_inode_list_lock);
+		dlock_list_relock(&iter);
 	}
-	spin_unlock(&sb->s_inode_list_lock);
 
 	iput(iput_inode);
 }
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 58b5de081b57..e873dcbe6feb 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -1024,13 +1024,13 @@ static int dqinit_needed(struct inode *inode, int type)
 static int add_dquot_ref(struct super_block *sb, int type)
 {
 	struct inode *inode, *old_inode = NULL;
+	DEFINE_DLOCK_LIST_ITER(iter, &sb->s_inodes);
 #ifdef CONFIG_QUOTA_DEBUG
 	int reserved = 0;
 #endif
 	int err = 0;
 
-	spin_lock(&sb->s_inode_list_lock);
-	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
+	dlist_for_each_entry(inode, &iter, i_sb_list) {
 		spin_lock(&inode->i_lock);
 		if ((inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) ||
 		    !atomic_read(&inode->i_writecount) ||
@@ -1040,7 +1040,7 @@ static int add_dquot_ref(struct super_block *sb, int type)
 		}
 		__iget(inode);
 		spin_unlock(&inode->i_lock);
-		spin_unlock(&sb->s_inode_list_lock);
+		dlock_list_unlock(&iter);
 
 #ifdef CONFIG_QUOTA_DEBUG
 		if (unlikely(inode_get_rsv_space(inode) > 0))
@@ -1053,19 +1053,10 @@ static int add_dquot_ref(struct super_block *sb, int type)
 			goto out;
 		}
 
-		/*
-		 * We hold a reference to 'inode' so it couldn't have been
-		 * removed from s_inodes list while we dropped the
-		 * s_inode_list_lock. We cannot iput the inode now as we can be
-		 * holding the last reference and we cannot iput it under
-		 * s_inode_list_lock. So we keep the reference and iput it
-		 * later.
-		 */
 		old_inode = inode;
 		cond_resched();
-		spin_lock(&sb->s_inode_list_lock);
+		dlock_list_relock(&iter);
 	}
-	spin_unlock(&sb->s_inode_list_lock);
 	iput(old_inode);
 out:
 #ifdef CONFIG_QUOTA_DEBUG
@@ -1081,12 +1072,12 @@ static int add_dquot_ref(struct super_block *sb, int type)
 static void remove_dquot_ref(struct super_block *sb, int type)
 {
 	struct inode *inode;
+	DEFINE_DLOCK_LIST_ITER(iter, &sb->s_inodes);
 #ifdef CONFIG_QUOTA_DEBUG
 	int reserved = 0;
 #endif
 
-	spin_lock(&sb->s_inode_list_lock);
-	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
+	dlist_for_each_entry(inode, &iter, i_sb_list) {
 		/*
 		 *  We have to scan also I_NEW inodes because they can already
 		 *  have quota pointer initialized. Luckily, we need to touch
@@ -1108,7 +1099,6 @@ static void remove_dquot_ref(struct super_block *sb, int type)
 		}
 		spin_unlock(&dq_data_lock);
 	}
-	spin_unlock(&sb->s_inode_list_lock);
 #ifdef CONFIG_QUOTA_DEBUG
 	if (reserved) {
 		printk(KERN_WARNING "VFS (%s): Writes happened after quota"
diff --git a/fs/super.c b/fs/super.c
index 076392396e72..61c19e3f06d8 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -303,6 +303,7 @@ static void destroy_unused_super(struct super_block *s)
 	super_unlock_excl(s);
 	list_lru_destroy(&s->s_dentry_lru);
 	list_lru_destroy(&s->s_inode_lru);
+	free_dlock_list_heads(&s->s_inodes);
 	security_sb_free(s);
 	put_user_ns(s->s_user_ns);
 	kfree(s->s_subtype);
@@ -367,8 +368,6 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	INIT_HLIST_NODE(&s->s_instances);
 	INIT_HLIST_BL_HEAD(&s->s_roots);
 	mutex_init(&s->s_sync_lock);
-	INIT_LIST_HEAD(&s->s_inodes);
-	spin_lock_init(&s->s_inode_list_lock);
 	INIT_LIST_HEAD(&s->s_inodes_wb);
 	spin_lock_init(&s->s_inode_wblist_lock);
 
@@ -383,6 +382,9 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	s->s_time_min = TIME64_MIN;
 	s->s_time_max = TIME64_MAX;
 
+	if (alloc_dlock_list_heads(&s->s_inodes))
+		goto fail;
+
 	s->s_shrink = shrinker_alloc(SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE,
 				     "sb-%s", type->name);
 	if (!s->s_shrink)
@@ -695,7 +697,7 @@ void generic_shutdown_super(struct super_block *sb)
 		if (sop->put_super)
 			sop->put_super(sb);
 
-		if (CHECK_DATA_CORRUPTION(!list_empty(&sb->s_inodes),
+		if (CHECK_DATA_CORRUPTION(!dlock_lists_empty(&sb->s_inodes),
 				"VFS: Busy inodes after unmount of %s (%s)",
 				sb->s_id, sb->s_type->name)) {
 			/*
@@ -704,14 +706,13 @@ void generic_shutdown_super(struct super_block *sb)
 			 * iput_final() or such crashes cleanly.
 			 */
 			struct inode *inode;
+			DEFINE_DLOCK_LIST_ITER(iter, &sb->s_inodes);
 
-			spin_lock(&sb->s_inode_list_lock);
-			list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
+			dlist_for_each_entry(inode, &iter, i_sb_list) {
 				inode->i_op = VFS_PTR_POISON;
 				inode->i_sb = VFS_PTR_POISON;
 				inode->i_mapping = VFS_PTR_POISON;
 			}
-			spin_unlock(&sb->s_inode_list_lock);
 		}
 	}
 	/*
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 98b7a7a8c42e..bb35591733f1 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -43,6 +43,7 @@
 #include <linux/cred.h>
 #include <linux/mnt_idmapping.h>
 #include <linux/slab.h>
+#include <linux/dlock-list.h>
 
 #include <asm/byteorder.h>
 #include <uapi/linux/fs.h>
@@ -702,7 +703,7 @@ struct inode {
 	u16			i_wb_frn_history;
 #endif
 	struct list_head	i_lru;		/* inode LRU list */
-	struct list_head	i_sb_list;
+	struct dlock_list_node	i_sb_list;
 	struct list_head	i_wb_list;	/* backing dev writeback list */
 	union {
 		struct hlist_head	i_dentry;
@@ -1315,9 +1316,8 @@ struct super_block {
 	 */
 	int s_stack_depth;
 
-	/* s_inode_list_lock protects s_inodes */
-	spinlock_t		s_inode_list_lock ____cacheline_aligned_in_smp;
-	struct list_head	s_inodes;	/* all inodes */
+	/* The internal per-list locks protect s_inodes */
+	struct dlock_list_heads s_inodes;	/* all inodes */
 
 	spinlock_t		s_inode_wblist_lock;
 	struct list_head	s_inodes_wb;	/* writeback inodes */
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index bc7c126deea2..4269d9938c09 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -844,12 +844,12 @@ static void hook_inode_free_security(struct inode *const inode)
 static void hook_sb_delete(struct super_block *const sb)
 {
 	struct inode *inode, *prev_inode = NULL;
+	DEFINE_DLOCK_LIST_ITER(iter, &sb->s_inodes);
 
 	if (!landlock_initialized)
 		return;
 
-	spin_lock(&sb->s_inode_list_lock);
-	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
+	dlist_for_each_entry(inode, &iter, i_sb_list) {
 		struct landlock_object *object;
 
 		/* Only handles referenced inodes. */
@@ -883,6 +883,7 @@ static void hook_sb_delete(struct super_block *const sb)
 		/* Keeps a reference to this inode until the next loop walk. */
 		__iget(inode);
 		spin_unlock(&inode->i_lock);
+		dlock_list_unlock(&iter);
 
 		/*
 		 * If there is no concurrent release_inode() ongoing, then we
@@ -917,25 +918,11 @@ static void hook_sb_delete(struct super_block *const sb)
 			rcu_read_unlock();
 		}
 
-		if (prev_inode) {
-			/*
-			 * At this point, we still own the __iget() reference
-			 * that we just set in this loop walk.  Therefore we
-			 * can drop the list lock and know that the inode won't
-			 * disappear from under us until the next loop walk.
-			 */
-			spin_unlock(&sb->s_inode_list_lock);
-			/*
-			 * We can now actually put the inode reference from the
-			 * previous loop walk, which is not needed anymore.
-			 */
-			iput(prev_inode);
-			cond_resched();
-			spin_lock(&sb->s_inode_list_lock);
-		}
+		iput(prev_inode);
 		prev_inode = inode;
+		cond_resched();
+		dlock_list_relock(&iter);
 	}
-	spin_unlock(&sb->s_inode_list_lock);
 
 	/* Puts the inode reference from the last loop walk, if any. */
 	if (prev_inode)
-- 
2.42.0


