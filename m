Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 474132A06ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 14:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgJ3NxC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 09:53:02 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:22001 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbgJ3Nwy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 09:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604065974; x=1635601974;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S/dQskmKO8j3MY3gFEXv2q8BEHlNOVyBWF+Bw+PXmzA=;
  b=VzZj5IuTHESWbB1Qc4C0wlCHtpkM26/jfg3Z3riKrOsWsx9ejm7xaEg1
   OJgqph6VSAmhqAcoSdL+EkA4+Fx8w3brw7TC1aOw91jYBVfIKeVVPU2D1
   DAq8cH95s/ljiKcsh51p0SbSeQKv1cdrPT4EExJ5LORy9AbajqDpTueLK
   jKJ6ltGEeqms+b83xoq+OcEthVHjKr6IMvEr26h1KxnRoOT8GfKOTroyW
   uHDSYtWZ7G9d2+WFZwWefMaSur6ZWgr8ELDyB1P4KIdfpnmCOhwZ/PzCe
   rIOIICjrE0krUsyyDvDAxqH4PlgJju5YkKer/nxqD3xzGkXMgIuBWAuaW
   A==;
IronPort-SDR: ygbZtGSJaVkqn79plI4+yOwXLuLOzecj1Vr34w3DIu/mtrmmy+ZbLW6eZKLcINdBwC/U94N4eO
 XQqUcpntuI7btgQnZHVpyaxXn3KB6tSdiAnRauqIvnUPzSdY/y9EJPRrv/ubDaTxzPm0CqlbfQ
 DVPDDtLFet4sEKUSy6jlQzOrhrgFHUO0XIKL40eNcCVFIPlp7dvNT4Qabkmlfl9AxfNyP9hCqm
 GxYX/K5CvVOOpKgHTb1b6uDBsPtrE0I2AtICwv5FSzv1TuqMueSeNHdGtPvFqw1r3SuFzDlkBg
 Uco=
X-IronPort-AV: E=Sophos;i="5.77,433,1596470400"; 
   d="scan'208";a="155806615"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2020 21:52:45 +0800
IronPort-SDR: seG1wholAwjChyf/gahL4jwgBdcL7EPbQbzl/w7L9EFWi3eCDcwphq6OoQPDt54jAa24XaYKE8
 a+QHp29/PpqYj6U70wsa1kBpnX8BUoiwuGkqi6/GoSidhIsvVhi2wpH+HrxJOfajjE9GOvWFHV
 Q8jN7tlC63rSzgXB/7uCPLCZVAZsKyBBZjSnDfvFfhBveZcGrxP5eRncqkySTbKiIQuGPZ55Av
 EIiHvpkrrFSzH/ffn2kZxxp4Cf8BNNjoar701SSGwnk7ywVkiREqM8NcSo2Y+LuxaXvLQVfUlS
 pfnJMSSORl5Gbpd7FBt2i+RH
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 06:38:59 -0700
IronPort-SDR: a9kFZpXppYU01dZKfL24wA++w/F1Vy/pifmxVvf4k6/5q6kdzrcLO2whObMr/2Hri112+c6ntI
 KZRq1O7GntU/cYpa0A/uKLa1E8JQyL59rfm/dP2Ixndc43ml49jveXqf0aARfMMm0F4btfB8ey
 3lrjq0RkG/8DvxUGJ/uALFwO6vufL/nhX9QhohpKRr4KGtyQJMuVoUDBoJv79+liQ0xhjDI4wR
 0RwV1Ac98nkPRsIeCdHxx+HX/6+hi848qIiTSFVb5kEixhtWOqgP7M5UeFg0qrR6h3+nS9eJuD
 O/I=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Oct 2020 06:52:44 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v9 19/41] btrfs: redirty released extent buffers in ZONED mode
Date:   Fri, 30 Oct 2020 22:51:26 +0900
Message-Id: <b2c1ee9a3c4067b9f8823604e4c4c5c96d3abc61.1604065695.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Tree manipulating operations like merging nodes often release
once-allocated tree nodes. Btrfs cleans such nodes so that pages in the
node are not uselessly written out. On ZONED volumes, however, such
optimization blocks the following IOs as the cancellation of the write out
of the freed blocks breaks the sequential write sequence expected by the
device.

This patch introduces a list of clean and unwritten extent buffers that
have been released in a transaction. Btrfs redirty the buffer so that
btree_write_cache_pages() can send proper bios to the devices.

Besides it clears the entire content of the extent buffer not to confuse
raw block scanners e.g. btrfsck. By clearing the content,
csum_dirty_buffer() complains about bytenr mismatch, so avoid the checking
and checksum using newly introduced buffer flag EXTENT_BUFFER_NO_CHECK.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/disk-io.c     |  8 ++++++++
 fs/btrfs/extent-tree.c | 12 +++++++++++-
 fs/btrfs/extent_io.c   |  4 ++++
 fs/btrfs/extent_io.h   |  2 ++
 fs/btrfs/transaction.c | 10 ++++++++++
 fs/btrfs/transaction.h |  3 +++
 fs/btrfs/tree-log.c    |  6 ++++++
 fs/btrfs/zoned.c       | 37 +++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h       |  6 ++++++
 9 files changed, 87 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index fd8b970ee92c..9750b4e6d538 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -462,6 +462,12 @@ static int csum_dirty_buffer(struct btrfs_fs_info *fs_info, struct page *page)
 		return 0;
 
 	found_start = btrfs_header_bytenr(eb);
+
+	if (test_bit(EXTENT_BUFFER_NO_CHECK, &eb->bflags)) {
+		WARN_ON(found_start != 0);
+		return 0;
+	}
+
 	/*
 	 * Please do not consolidate these warnings into a single if.
 	 * It is useful to know what went wrong.
@@ -4616,6 +4622,8 @@ void btrfs_cleanup_one_transaction(struct btrfs_transaction *cur_trans,
 				     EXTENT_DIRTY);
 	btrfs_destroy_pinned_extent(fs_info, &cur_trans->pinned_extents);
 
+	btrfs_free_redirty_list(cur_trans);
+
 	cur_trans->state =TRANS_STATE_COMPLETED;
 	wake_up(&cur_trans->commit_wait);
 }
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index c134746d7417..57454ef4c91e 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3421,8 +3421,10 @@ void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 
 		if (root->root_key.objectid != BTRFS_TREE_LOG_OBJECTID) {
 			ret = check_ref_cleanup(trans, buf->start);
-			if (!ret)
+			if (!ret) {
+				btrfs_redirty_list_add(trans->transaction, buf);
 				goto out;
+			}
 		}
 
 		pin = 0;
@@ -3434,6 +3436,13 @@ void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 			goto out;
 		}
 
+		if (btrfs_is_zoned(fs_info)) {
+			btrfs_redirty_list_add(trans->transaction, buf);
+			pin_down_extent(trans, cache, buf->start, buf->len, 1);
+			btrfs_put_block_group(cache);
+			goto out;
+		}
+
 		WARN_ON(test_bit(EXTENT_BUFFER_DIRTY, &buf->bflags));
 
 		btrfs_add_free_space(cache, buf->start, buf->len);
@@ -4770,6 +4779,7 @@ btrfs_init_new_buffer(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	__btrfs_tree_lock(buf, nest);
 	btrfs_clean_tree_block(buf);
 	clear_bit(EXTENT_BUFFER_STALE, &buf->bflags);
+	clear_bit(EXTENT_BUFFER_NO_CHECK, &buf->bflags);
 
 	btrfs_set_lock_blocking_write(buf);
 	set_extent_buffer_uptodate(buf);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 60f5f68d892d..e91c504fe973 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -24,6 +24,7 @@
 #include "rcu-string.h"
 #include "backref.h"
 #include "disk-io.h"
+#include "zoned.h"
 
 static struct kmem_cache *extent_state_cache;
 static struct kmem_cache *extent_buffer_cache;
@@ -4959,6 +4960,7 @@ __alloc_extent_buffer(struct btrfs_fs_info *fs_info, u64 start,
 
 	btrfs_leak_debug_add(&fs_info->eb_leak_lock, &eb->leak_list,
 			     &fs_info->allocated_ebs);
+	INIT_LIST_HEAD(&eb->release_list);
 
 	spin_lock_init(&eb->refs_lock);
 	atomic_set(&eb->refs, 1);
@@ -5744,6 +5746,8 @@ void write_extent_buffer(const struct extent_buffer *eb, const void *srcv,
 	char *src = (char *)srcv;
 	unsigned long i = start >> PAGE_SHIFT;
 
+	WARN_ON(test_bit(EXTENT_BUFFER_NO_CHECK, &eb->bflags));
+
 	if (check_eb_range(eb, start, len))
 		return;
 
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index f39d02e7f7ef..5f2ccfd0205e 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -30,6 +30,7 @@ enum {
 	EXTENT_BUFFER_IN_TREE,
 	/* write IO error */
 	EXTENT_BUFFER_WRITE_ERR,
+	EXTENT_BUFFER_NO_CHECK,
 };
 
 /* these are flags for __process_pages_contig */
@@ -107,6 +108,7 @@ struct extent_buffer {
 	 */
 	wait_queue_head_t read_lock_wq;
 	struct page *pages[INLINE_EXTENT_BUFFER_PAGES];
+	struct list_head release_list;
 #ifdef CONFIG_BTRFS_DEBUG
 	int spinning_writers;
 	atomic_t spinning_readers;
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 52ada47aff50..5c561cdcce42 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -22,6 +22,7 @@
 #include "qgroup.h"
 #include "block-group.h"
 #include "space-info.h"
+#include "zoned.h"
 
 #define BTRFS_ROOT_TRANS_TAG 0
 
@@ -336,6 +337,8 @@ static noinline int join_transaction(struct btrfs_fs_info *fs_info,
 	spin_lock_init(&cur_trans->dirty_bgs_lock);
 	INIT_LIST_HEAD(&cur_trans->deleted_bgs);
 	spin_lock_init(&cur_trans->dropped_roots_lock);
+	INIT_LIST_HEAD(&cur_trans->releasing_ebs);
+	spin_lock_init(&cur_trans->releasing_ebs_lock);
 	list_add_tail(&cur_trans->list, &fs_info->trans_list);
 	extent_io_tree_init(fs_info, &cur_trans->dirty_pages,
 			IO_TREE_TRANS_DIRTY_PAGES, fs_info->btree_inode);
@@ -2345,6 +2348,13 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
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
index 858d9153a1cd..380e0aaa15b3 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -92,6 +92,9 @@ struct btrfs_transaction {
 	 */
 	atomic_t pending_ordered;
 	wait_queue_head_t pending_wait;
+
+	spinlock_t releasing_ebs_lock;
+	struct list_head releasing_ebs;
 };
 
 #define __TRANS_FREEZABLE	(1U << 0)
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 56cbc1706b6f..5f585cf57383 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -20,6 +20,7 @@
 #include "inode-map.h"
 #include "block-group.h"
 #include "space-info.h"
+#include "zoned.h"
 
 /* magic values for the inode_only field in btrfs_log_inode:
  *
@@ -2742,6 +2743,8 @@ static noinline int walk_down_log_tree(struct btrfs_trans_handle *trans,
 						free_extent_buffer(next);
 						return ret;
 					}
+					btrfs_redirty_list_add(
+						trans->transaction, next);
 				} else {
 					if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &next->bflags))
 						clear_extent_buffer_dirty(next);
@@ -3277,6 +3280,9 @@ static void free_log_tree(struct btrfs_trans_handle *trans,
 	clear_extent_bits(&log->dirty_log_pages, 0, (u64)-1,
 			  EXTENT_DIRTY | EXTENT_NEW | EXTENT_NEED_WAIT);
 	extent_io_tree_release(&log->log_csum_range);
+
+	if (trans && log->node)
+		btrfs_redirty_list_add(trans->transaction, log->node);
 	btrfs_put_root(log);
 }
 
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index d94a2c363a47..b45ca33282d9 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -10,6 +10,7 @@
 #include "rcu-string.h"
 #include "disk-io.h"
 #include "block-group.h"
+#include "transaction.h"
 
 /* Maximum number of zones to report per blkdev_report_zones() call */
 #define BTRFS_REPORT_NR_ZONES   4096
@@ -1015,3 +1016,39 @@ void btrfs_calc_zone_unusable(struct btrfs_block_group *cache)
 	 */
 	btrfs_free_excluded_extents(cache);
 }
+
+void btrfs_redirty_list_add(struct btrfs_transaction *trans,
+			    struct extent_buffer *eb)
+{
+	struct btrfs_fs_info *fs_info = eb->fs_info;
+
+	if (!btrfs_is_zoned(fs_info) ||
+	    btrfs_header_flag(eb, BTRFS_HEADER_FLAG_WRITTEN) ||
+	    !list_empty(&eb->release_list))
+		return;
+
+	set_extent_buffer_dirty(eb);
+	set_extent_bits_nowait(&trans->dirty_pages, eb->start,
+			       eb->start + eb->len - 1, EXTENT_DIRTY);
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
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index d13bc6d70ea4..845623932fa5 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -41,6 +41,9 @@ int btrfs_reset_device_zone(struct btrfs_device *device, u64 physical,
 int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size);
 int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache);
 void btrfs_calc_zone_unusable(struct btrfs_block_group *cache);
+void btrfs_redirty_list_add(struct btrfs_transaction *trans,
+			    struct extent_buffer *eb);
+void btrfs_free_redirty_list(struct btrfs_transaction *trans);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -107,6 +110,9 @@ static inline int btrfs_load_block_group_zone_info(
 	return 0;
 }
 static inline void btrfs_calc_zone_unusable(struct btrfs_block_group *cache) { }
+static inline void btrfs_redirty_list_add(struct btrfs_transaction *trans,
+					  struct extent_buffer *eb) { }
+static inline void btrfs_free_redirty_list(struct btrfs_transaction *trans) { }
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
-- 
2.27.0

