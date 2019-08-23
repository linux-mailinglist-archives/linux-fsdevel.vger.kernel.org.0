Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 395279ACBF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2019 12:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404449AbfHWKLm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Aug 2019 06:11:42 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:47806 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404383AbfHWKLl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Aug 2019 06:11:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566555101; x=1598091101;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1c43D+Jl51SBUhxun53Ty9tOI8dHj9Y6YMFy+/m4kTw=;
  b=FIS1S7nQt4bqvzuoau1VHVCKwtFhhThGCSNn9jIyGhs6POkAVlAZF0ry
   psLacN2ccNaLUw2HJAhpQ1LW8qR6aTep/hnMWxY30JP8b51HUM9FRhswp
   oGEIPeUNhOXUssFoMfdsYWte2FmTzoa8O37Nxt9da5S6vlFohaXHSvlXf
   oc+G9JCN/BxXrEujW5XhXtXwA62gDseNk5nCjFpXEqO+x5rY9f3RlpIPf
   qpc2RHg93KzcIk6q/priiY46dVEae4OGpYJIyzUXb2sNisPRoI5M9tkmA
   +mF+1R/QzISiFuQ8I8M4i9agTwqJFGCNgxenQ8DL5+jU1Ik7kJ78Sud6i
   g==;
IronPort-SDR: Mxh5PQnktYugHOde/ZfSXcfMNWtpmGcHY90zXjkGOebkpXueFUEEWklrp+uwar6jeMkMrLiOTm
 StFI9VaXE6lBiTiS7FcifxZbEHW7HADOyYRRXFQSzPxvwX4tWX/9NjEGPNJcHy7/2KsNOxr5Jh
 3bP9hP4qLzml82AXYr8WmSjJ7RtS/w4QmlFNkxjir517afnkMaEyrBqysewRpVKLHDW5UnneoA
 taokqSh+DBqFgJHYQ7JIOaZjR8qBPPjLhI00gpJ171BHhd6F4sgCFOl9UlAccj6FkmGcqEDSPl
 eXE=
X-IronPort-AV: E=Sophos;i="5.64,420,1559491200"; 
   d="scan'208";a="121096257"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Aug 2019 18:11:40 +0800
IronPort-SDR: hjsPXGDNZwjK/9CzCwzlFtL1XB+xUFHOpksA6D/6CIjuvXS/6iGWlxxapHZAcHY09Ej2GtYZQl
 SeE7rMiN9s9Qc2Uvj/DLViPR6/pHkYqkCq1WqEiP9XHGMZJWCZj6f5NFaYrgVYOA3/0ckI7p8o
 s70K//VNUqze6CqhK1BfWiZP/gBPdUtaF5LzI80Y773wtowmihuAjoUf2w5MFv2m5w6Pp9E+Gv
 kX4Nqio5qj61ShMSOT5xsujrVLIINsg3AurI+2L09K+sTRKKzsCIcPR9OfrOz95rYXmk8rkNVG
 lC/yAKT+rZdPN8urgw3K52au
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2019 03:08:59 -0700
IronPort-SDR: KqU1rFPObFCOzGqmfOgm5Zfw2VUEnDebYLqg3Q2zrEMYDQj+ROSkMsx2O4Cy+628f8LHZGoqM6
 zHP29f4jclk4Nv1ImsDKfT7srj+caInE2B6gIlwwxijLhB+96tZMe07vCccANZ57UaRX9oXVz9
 6Ci9ueLoSIovFJJ/dPBB72yL9uyNSIpRaGB20Wr47ACeg+O/VLCWCqKAkzf7X4+AdQ94kcGF4o
 4vnVbtvCJpB4bB9Uwf30AFYNuSqXESphcYQQQVAlkgYpSUE7qCDU+3daBpEr59SQ5HCsDfLZ+6
 nwY=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Aug 2019 03:11:39 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v4 15/27] btrfs: redirty released extent buffers in sequential BGs
Date:   Fri, 23 Aug 2019 19:10:24 +0900
Message-Id: <20190823101036.796932-16-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190823101036.796932-1-naohiro.aota@wdc.com>
References: <20190823101036.796932-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Tree manipulating operations like merging nodes often release
once-allocated tree nodes. Btrfs cleans such nodes so that pages in the
node are not uselessly written out. On HMZONED drives, however, such
optimization blocks the following IOs as the cancellation of the write out
of the freed blocks breaks the sequential write sequence expected by the
device.

This patch introduces a list of clean and unwritten extent buffers that
have been released in a transaction. Btrfs redirty the buffer so that
btree_write_cache_pages() can send proper bios to the disk.

Besides it clear the entire content of the extent buffer not to confuse
raw block scanners e.g. btrfsck. By clearing the content,
csum_dirty_buffer() complains about bytenr mismatch, so avoid the checking
and checksum using newly introduced buffer flag EXTENT_BUFFER_NO_CHECK.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/disk-io.c     |  5 +++++
 fs/btrfs/extent-tree.c | 11 ++++++++++-
 fs/btrfs/extent_io.c   |  2 ++
 fs/btrfs/extent_io.h   |  2 ++
 fs/btrfs/hmzoned.c     | 34 ++++++++++++++++++++++++++++++++++
 fs/btrfs/hmzoned.h     |  3 +++
 fs/btrfs/transaction.c | 10 ++++++++++
 fs/btrfs/transaction.h |  3 +++
 8 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 38a9830b4893..d36cdb1b1421 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -513,6 +513,9 @@ static int csum_dirty_buffer(struct btrfs_fs_info *fs_info, struct page *page)
 	if (page != eb->pages[0])
 		return 0;
 
+	if (test_bit(EXTENT_BUFFER_NO_CHECK, &eb->bflags))
+		return 0;
+
 	found_start = btrfs_header_bytenr(eb);
 	/*
 	 * Please do not consolidate these warnings into a single if.
@@ -4575,6 +4578,8 @@ void btrfs_cleanup_one_transaction(struct btrfs_transaction *cur_trans,
 	btrfs_destroy_pinned_extent(fs_info,
 				    fs_info->pinned_extents);
 
+	btrfs_free_redirty_list(cur_trans);
+
 	cur_trans->state =TRANS_STATE_COMPLETED;
 	wake_up(&cur_trans->commit_wait);
 }
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index ddf5c26b9f58..c0d7cb95a8c9 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5085,8 +5085,10 @@ void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 
 		if (root->root_key.objectid != BTRFS_TREE_LOG_OBJECTID) {
 			ret = check_ref_cleanup(trans, buf->start);
-			if (!ret)
+			if (!ret) {
+				btrfs_redirty_list_add(trans->transaction, buf);
 				goto out;
+			}
 		}
 
 		pin = 0;
@@ -5098,6 +5100,13 @@ void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 			goto out;
 		}
 
+		if (btrfs_fs_incompat(fs_info, HMZONED)) {
+			btrfs_redirty_list_add(trans->transaction, buf);
+			pin_down_extent(cache, buf->start, buf->len, 1);
+			btrfs_put_block_group(cache);
+			goto out;
+		}
+
 		WARN_ON(test_bit(EXTENT_BUFFER_DIRTY, &buf->bflags));
 
 		btrfs_add_free_space(cache, buf->start, buf->len);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index aea990473392..4e67b16c9f80 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -23,6 +23,7 @@
 #include "rcu-string.h"
 #include "backref.h"
 #include "disk-io.h"
+#include "hmzoned.h"
 
 static struct kmem_cache *extent_state_cache;
 static struct kmem_cache *extent_buffer_cache;
@@ -4863,6 +4864,7 @@ __alloc_extent_buffer(struct btrfs_fs_info *fs_info, u64 start,
 	init_waitqueue_head(&eb->read_lock_wq);
 
 	btrfs_leak_debug_add(&eb->leak_list, &buffers);
+	INIT_LIST_HEAD(&eb->release_list);
 
 	spin_lock_init(&eb->refs_lock);
 	atomic_set(&eb->refs, 1);
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 401423b16976..c63b58438f90 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -58,6 +58,7 @@ enum {
 	EXTENT_BUFFER_IN_TREE,
 	/* write IO error */
 	EXTENT_BUFFER_WRITE_ERR,
+	EXTENT_BUFFER_NO_CHECK,
 };
 
 /* these are flags for __process_pages_contig */
@@ -186,6 +187,7 @@ struct extent_buffer {
 	 */
 	wait_queue_head_t read_lock_wq;
 	struct page *pages[INLINE_EXTENT_BUFFER_PAGES];
+	struct list_head release_list;
 #ifdef CONFIG_BTRFS_DEBUG
 	int spinning_writers;
 	atomic_t spinning_readers;
diff --git a/fs/btrfs/hmzoned.c b/fs/btrfs/hmzoned.c
index 3d7db7d480d4..81d8037ae7f6 100644
--- a/fs/btrfs/hmzoned.c
+++ b/fs/btrfs/hmzoned.c
@@ -614,3 +614,37 @@ int btrfs_reset_device_zone(struct btrfs_device *device, u64 physical,
 
 	return ret;
 }
+
+void btrfs_redirty_list_add(struct btrfs_transaction *trans,
+			    struct extent_buffer *eb)
+{
+	struct btrfs_fs_info *fs_info = eb->fs_info;
+
+	if (!btrfs_fs_incompat(fs_info, HMZONED) ||
+	    btrfs_header_flag(eb, BTRFS_HEADER_FLAG_WRITTEN) ||
+	    !list_empty(&eb->release_list))
+		return;
+
+	set_extent_buffer_dirty(eb);
+	memzero_extent_buffer(eb, 0, eb->len);
+	set_bit(EXTENT_BUFFER_NO_CHECK, &eb->bflags);
+
+	spin_lock(&trans->releasing_ebs_lock);
+	list_add_tail(&eb->release_list, &trans->releasing_ebs);
+	spin_unlock(&trans->releasing_ebs_lock);
+	atomic_inc(&eb->refs);
+}
+
+void btrfs_free_redirty_list(struct btrfs_transaction *trans)
+{
+	spin_lock(&trans->releasing_ebs_lock);
+	while (!list_empty(&trans->releasing_ebs)) {
+		struct extent_buffer *eb;
+
+		eb = list_first_entry(&trans->releasing_ebs,
+				      struct extent_buffer, release_list);
+		list_del_init(&eb->release_list);
+		free_extent_buffer(eb);
+	}
+	spin_unlock(&trans->releasing_ebs_lock);
+}
diff --git a/fs/btrfs/hmzoned.h b/fs/btrfs/hmzoned.h
index 9de26d6b8c4e..3a73c3c5e1da 100644
--- a/fs/btrfs/hmzoned.h
+++ b/fs/btrfs/hmzoned.h
@@ -36,6 +36,9 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group_cache *cache);
 int btrfs_reset_device_zone(struct btrfs_device *device, u64 physical,
 			    u64 length, u64 *bytes);
 int btrfs_hmzoned_check_metadata_space(struct btrfs_fs_info *fs_info);
+void btrfs_redirty_list_add(struct btrfs_transaction *trans,
+			    struct extent_buffer *eb);
+void btrfs_free_redirty_list(struct btrfs_transaction *trans);
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
 {
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index e3adb714c04b..45bd7c25bebf 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -19,6 +19,7 @@
 #include "volumes.h"
 #include "dev-replace.h"
 #include "qgroup.h"
+#include "hmzoned.h"
 
 #define BTRFS_ROOT_TRANS_TAG 0
 
@@ -257,6 +258,8 @@ static noinline int join_transaction(struct btrfs_fs_info *fs_info,
 	spin_lock_init(&cur_trans->dirty_bgs_lock);
 	INIT_LIST_HEAD(&cur_trans->deleted_bgs);
 	spin_lock_init(&cur_trans->dropped_roots_lock);
+	INIT_LIST_HEAD(&cur_trans->releasing_ebs);
+	spin_lock_init(&cur_trans->releasing_ebs_lock);
 	list_add_tail(&cur_trans->list, &fs_info->trans_list);
 	extent_io_tree_init(fs_info, &cur_trans->dirty_pages,
 			IO_TREE_TRANS_DIRTY_PAGES, fs_info->btree_inode);
@@ -2269,6 +2272,13 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 		goto scrub_continue;
 	}
 
+	/*
+	 * At this point, we should have written the all tree blocks
+	 * allocated in this transaction. So it's now safe to free the
+	 * redirtyied extent buffers.
+	 */
+	btrfs_free_redirty_list(cur_trans);
+
 	ret = write_all_supers(fs_info, 0);
 	/*
 	 * the super is written, we can safely allow the tree-loggers
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index 2c5a6f6e5bb0..09329d2901b7 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -85,6 +85,9 @@ struct btrfs_transaction {
 	spinlock_t dropped_roots_lock;
 	struct btrfs_delayed_ref_root delayed_refs;
 	struct btrfs_fs_info *fs_info;
+
+	spinlock_t releasing_ebs_lock;
+	struct list_head releasing_ebs;
 };
 
 #define __TRANS_FREEZABLE	(1U << 0)
-- 
2.23.0

