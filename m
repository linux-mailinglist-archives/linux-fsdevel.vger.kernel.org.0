Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3DE930F0A6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 11:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235476AbhBDK00 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 05:26:26 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:54276 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235470AbhBDK0G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:26:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612434366; x=1643970366;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xg1Nsvpj3BZWKn8bbLvBcESBI3F08uBTb76C16cAjqc=;
  b=PFsmUJRlF+xojOBQT6fzsUfcfhHDEETOhBuSI+gnskzkCFp5anJl03lH
   Q/aFxtt9J0kz4fbVayyl5uGYAyWiwcw/Nz3wPC4xYjqrIsJ1Z5wyM9OXj
   Z4mjJlx3lB/jXkT/qkvtoZybMXSFQ73WHa0Li4RoxEagv4fVpLA7qx/uX
   Cewg9sXQeyzHsuFQlbKIemYFaYRuZFyL2hHCRICGwdbYyqGRl2dB8euCe
   tU9SCkSOzMAFCaCQ7//B7zLsDPnbHj+fYr4hue/gsc09BHyhj0/0cI36q
   FEAaW8IxzKQUfyzMWllxhHUlGaCpjao6ofsUontpb9UT7LSOvpQMaQjQt
   w==;
IronPort-SDR: c4j9F6Bwrb8wQeMRVOsZicXpLhGdq6wRFUVficWyezGVjYuPP1QgywqknriofAaBESmoXoH729
 eqWJsrrxpIrfajIGuh8GnMNoqt1ybEeXwxX7Y9NgFz/QwWfrDW7UgRO6wpMsWyqAtYjMBBLXuR
 kev3npQYK36BsGXuXqUFmGFRGlSUFmJdZBGCaL4uGATIUQASa6MWcU2l48BkiV/xB9kdhOwRP5
 W3+vZ2euBL51xan+d/znmFb4yRI3LL0j4QFCTUVjlnPieyZTGLfBn9Zho2yTQuSi9n8oIzjCbf
 YkI=
X-IronPort-AV: E=Sophos;i="5.79,400,1602518400"; 
   d="scan'208";a="159107997"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2021 18:23:16 +0800
IronPort-SDR: BsPKIUz4gdDjwVC4JvkPzzN7FxYom5I3xZm5OzihYNBASpwllPVfkONk+o4aVgsPpXEBILIgLO
 WE/ucbNfjM/paELznfY+rDUZAcoMBhaGEu45xxgXI4JBdOyZv+MH0RySWSBd4xyyJJosR15orp
 BRPPo7wrfXW7WZKkmyv1noGfrMWRVIxLUVhlJRyNe7N/92p+ONXS8X3wGqH8vJr63CWNIl0KQy
 AuVFOE3EIMJsZkShMqDZljtX1kG7D64R6X3jWqPC+gSyD00SBl5QcLaWAfW+tKz0LOhATWqcsU
 AhCtrKZaODlJvBHPps2Nz9M2
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 02:05:19 -0800
IronPort-SDR: fc4zyBDBfx3SbYVhTVaUcX5IkIOBvwmm5EIeuFRQrRxxWsNvRDppkXlUbD6T/AJZVucLZ9nVp6
 8WmymN0O547pCETmMyaNEzBDGNk406wI9rvVvLMfocKeBN8Yj2nkymZ5VK8Ybd+sV0exSuRr3E
 AMSUfZH4LreG0zBEP1cDj5T4CJKWSW5nEoMF8TWkgqdE0N7HQg6J8sYXpE/dVDlOrP7/sZKQNI
 IRcMFgFvDLjsDrGq49FSXpoYD6C5PtKwf77ekt0j/mRzndW49NBDKtcpLfHWJg/ETrYYF0xjze
 zlA=
WDCIronportException: Internal
Received: from jfklab-fym3sg2.ad.shared (HELO naota-xeon.wdc.com) ([10.84.71.79])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Feb 2021 02:23:15 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v15 15/42] btrfs: zoned: redirty released extent buffers
Date:   Thu,  4 Feb 2021 19:21:54 +0900
Message-Id: <60882b8bb6f8723b8568515212cac64a55ce405f.1612434091.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
References: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Tree manipulating operations like merging nodes often release
once-allocated tree nodes. Such nodes are cleaned so that pages in the
node are not uselessly written out. On zoned volumes, however, such
optimization blocks the following IOs as the cancellation of the write
out of the freed blocks breaks the sequential write sequence expected by
the device.

Introduce a list of clean and unwritten extent buffers that have been
released in a transaction. Redirty the buffers so that
btree_write_cache_pages() can send proper bios to the devices.

Besides it clears the entire content of the extent buffer not to confuse
raw block scanners e.g. 'btrfs check'. By clearing the content,
csum_dirty_buffer() complains about bytenr mismatch, so avoid the
checking and checksum using newly introduced buffer flag
EXTENT_BUFFER_NO_CHECK.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
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
 fs/btrfs/zoned.h       |  7 +++++++
 9 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 8551b0fc1b22..eb1afd7d89f7 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -459,6 +459,12 @@ static int csum_dirty_buffer(struct btrfs_fs_info *fs_info, struct bio_vec *bvec
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
@@ -4774,6 +4780,8 @@ void btrfs_cleanup_one_transaction(struct btrfs_transaction *cur_trans,
 				     EXTENT_DIRTY);
 	btrfs_destroy_pinned_extent(fs_info, &cur_trans->pinned_extents);
 
+	btrfs_free_redirty_list(cur_trans);
+
 	cur_trans->state =TRANS_STATE_COMPLETED;
 	wake_up(&cur_trans->commit_wait);
 }
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 85d99307673d..4d48a773bf9c 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3292,8 +3292,10 @@ void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 
 		if (root->root_key.objectid != BTRFS_TREE_LOG_OBJECTID) {
 			ret = check_ref_cleanup(trans, buf->start);
-			if (!ret)
+			if (!ret) {
+				btrfs_redirty_list_add(trans->transaction, buf);
 				goto out;
+			}
 		}
 
 		cache = btrfs_lookup_block_group(fs_info, buf->start);
@@ -3304,6 +3306,13 @@ void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
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
@@ -4635,6 +4644,7 @@ btrfs_init_new_buffer(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	__btrfs_tree_lock(buf, nest);
 	btrfs_clean_tree_block(buf);
 	clear_bit(EXTENT_BUFFER_STALE, &buf->bflags);
+	clear_bit(EXTENT_BUFFER_NO_CHECK, &buf->bflags);
 
 	set_extent_buffer_uptodate(buf);
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 2fa4ca12e2dd..fa9b37178d42 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -25,6 +25,7 @@
 #include "backref.h"
 #include "disk-io.h"
 #include "subpage.h"
+#include "zoned.h"
 
 static struct kmem_cache *extent_state_cache;
 static struct kmem_cache *extent_buffer_cache;
@@ -5183,6 +5184,7 @@ __alloc_extent_buffer(struct btrfs_fs_info *fs_info, u64 start,
 
 	btrfs_leak_debug_add(&fs_info->eb_leak_lock, &eb->leak_list,
 			     &fs_info->allocated_ebs);
+	INIT_LIST_HEAD(&eb->release_list);
 
 	spin_lock_init(&eb->refs_lock);
 	atomic_set(&eb->refs, 1);
@@ -6105,6 +6107,8 @@ void write_extent_buffer(const struct extent_buffer *eb, const void *srcv,
 	char *src = (char *)srcv;
 	unsigned long i = get_eb_page_index(start);
 
+	WARN_ON(test_bit(EXTENT_BUFFER_NO_CHECK, &eb->bflags));
+
 	if (check_eb_range(eb, start, len))
 		return;
 
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 047b3e66897f..824640cb0ace 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -31,6 +31,7 @@ enum {
 	EXTENT_BUFFER_IN_TREE,
 	/* write IO error */
 	EXTENT_BUFFER_WRITE_ERR,
+	EXTENT_BUFFER_NO_CHECK,
 };
 
 /* these are flags for __process_pages_contig */
@@ -93,6 +94,7 @@ struct extent_buffer {
 	struct rw_semaphore lock;
 
 	struct page *pages[INLINE_EXTENT_BUFFER_PAGES];
+	struct list_head release_list;
 #ifdef CONFIG_BTRFS_DEBUG
 	struct list_head leak_list;
 #endif
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 00c0680dac3a..acff6bb49a97 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -21,6 +21,7 @@
 #include "qgroup.h"
 #include "block-group.h"
 #include "space-info.h"
+#include "zoned.h"
 
 #define BTRFS_ROOT_TRANS_TAG 0
 
@@ -380,6 +381,8 @@ static noinline int join_transaction(struct btrfs_fs_info *fs_info,
 	spin_lock_init(&cur_trans->dirty_bgs_lock);
 	INIT_LIST_HEAD(&cur_trans->deleted_bgs);
 	spin_lock_init(&cur_trans->dropped_roots_lock);
+	INIT_LIST_HEAD(&cur_trans->releasing_ebs);
+	spin_lock_init(&cur_trans->releasing_ebs_lock);
 	list_add_tail(&cur_trans->list, &fs_info->trans_list);
 	extent_io_tree_init(fs_info, &cur_trans->dirty_pages,
 			IO_TREE_TRANS_DIRTY_PAGES, fs_info->btree_inode);
@@ -2350,6 +2353,13 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 		goto scrub_continue;
 	}
 
+	/*
+	 * At this point, we should have written all the tree blocks allocated
+	 * in this transaction. So it's now safe to free the redirtyied extent
+	 * buffers.
+	 */
+	btrfs_free_redirty_list(cur_trans);
+
 	ret = write_all_supers(fs_info, 0);
 	/*
 	 * the super is written, we can safely allow the tree-loggers
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index 935bd6958a8a..6335716e513f 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -93,6 +93,9 @@ struct btrfs_transaction {
 	 */
 	atomic_t pending_ordered;
 	wait_queue_head_t pending_wait;
+
+	spinlock_t releasing_ebs_lock;
+	struct list_head releasing_ebs;
 };
 
 #define __TRANS_FREEZABLE	(1U << 0)
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 4c7b283ed2b2..c02eeeac439c 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -19,6 +19,7 @@
 #include "qgroup.h"
 #include "block-group.h"
 #include "space-info.h"
+#include "zoned.h"
 
 /* magic values for the inode_only field in btrfs_log_inode:
  *
@@ -2752,6 +2753,8 @@ static noinline int walk_down_log_tree(struct btrfs_trans_handle *trans,
 						free_extent_buffer(next);
 						return ret;
 					}
+					btrfs_redirty_list_add(
+						trans->transaction, next);
 				} else {
 					if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &next->bflags))
 						clear_extent_buffer_dirty(next);
@@ -3296,6 +3299,9 @@ static void free_log_tree(struct btrfs_trans_handle *trans,
 	clear_extent_bits(&log->dirty_log_pages, 0, (u64)-1,
 			  EXTENT_DIRTY | EXTENT_NEW | EXTENT_NEED_WAIT);
 	extent_io_tree_release(&log->log_csum_range);
+
+	if (trans && log->node)
+		btrfs_redirty_list_add(trans->transaction, log->node);
 	btrfs_put_root(log);
 }
 
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index c5f9f4c6f20b..1de67d789b83 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -10,6 +10,7 @@
 #include "rcu-string.h"
 #include "disk-io.h"
 #include "block-group.h"
+#include "transaction.h"
 
 /* Maximum number of zones to report per blkdev_report_zones() call */
 #define BTRFS_REPORT_NR_ZONES   4096
@@ -1181,3 +1182,39 @@ void btrfs_calc_zone_unusable(struct btrfs_block_group *cache)
 	/* Should not have any excluded extents. Just in case, though */
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
index 37304d1675e6..b250a578e38c 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -43,6 +43,9 @@ int btrfs_reset_device_zone(struct btrfs_device *device, u64 physical,
 int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size);
 int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new);
 void btrfs_calc_zone_unusable(struct btrfs_block_group *cache);
+void btrfs_redirty_list_add(struct btrfs_transaction *trans,
+			    struct extent_buffer *eb);
+void btrfs_free_redirty_list(struct btrfs_transaction *trans);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -126,6 +129,10 @@ static inline int btrfs_load_block_group_zone_info(
 
 static inline void btrfs_calc_zone_unusable(struct btrfs_block_group *cache) { }
 
+static inline void btrfs_redirty_list_add(struct btrfs_transaction *trans,
+					  struct extent_buffer *eb) { }
+static inline void btrfs_free_redirty_list(struct btrfs_transaction *trans) { }
+
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
-- 
2.30.0

