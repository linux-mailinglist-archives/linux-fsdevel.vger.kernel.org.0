Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25C4711246E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 09:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfLDIT4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 03:19:56 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:32779 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727370AbfLDITz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:19:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1575447595; x=1606983595;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QqEFXmHtK6lkWlPuAAKCfDrEAYUfdSQMaeXLzrs1npQ=;
  b=EaDsvsUEu1Sf2R6dMtjuKD9U9xpIys2aWQl6s1kxC1TZRdvAR2CgCP2B
   IkQoOVmqCWcFVeXRiVGykA5o8F58BXcYR5TEYwfyCh5Nw+oj13RPTyHLK
   yp9nsAgfAOH3n2XvZ/FXpd3jsV1ho8/x7Fv3o/lAV6YzMCkSHsKwmxRdU
   65+/sJ+B3c+vOdrN0pwX3AJQbqnZpOxqKCxWUBR5xcl6zR95QBZ8cOeaL
   bxP86cyoxsElYwarRNWjLapT2VICjadMhwqVKfB5JSCcsc8b+PQUCoAwk
   SCO3ccVj7FecihlHi0B374zoL2Y3qTcp6nqYLbERGeVwR1WSMLyPiHjqR
   w==;
IronPort-SDR: kb48U6rMmJQoH1g84hu42+BpHJwTuC4HGbFSDoKx1FRhrw5EzMVCmJbo8jNM1aG2i3h+m4c+/Y
 IGoUujXzwbF7fBRuE8/P0Yq4GcrbeZO7e460gzFERQtRg0QHvG4EHPpnVDbeE0XaWJiQNPlp3M
 dVDVYu/g4KC1UPMb/5qoVIlmhRFjnUV+1+4JWdBRsNRlPvmsR3jlCsaTtWakYHgKaj0pdRhNnT
 lRknQ+Zt7RmC2XhTM3TzZrxK5K97NEdnuU96RWSm3mT0/Bj7/c7DDnYhukG+qE7TxKEdil4FIn
 WFU=
X-IronPort-AV: E=Sophos;i="5.69,276,1571673600"; 
   d="scan'208";a="125355087"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2019 16:19:55 +0800
IronPort-SDR: CMJEqtYUG5fAMVZeHFeEnLOqwvVdyo+Gb4zLLc4+bBQ+KybY3BJkotU2bIgrwsiBZxV20w+g3L
 SCbgD/RJwGjhoKzI3hMWfbDqRrSrKCU4kxOwbohB6Ur7xADZ6UwctUY+0giRu6p59M3681fxlP
 wGDP4MU16IztxcUIqbE+g9gMWwa3S/zP4t3DCsGCoWpZOauhDXsbwQ/iAH34VFTuJDxam381PD
 G09e/0rvECglUkIaUURn+4CgvrfD0aG8mYPLtDXjdtdJKjtYDlNqJ/WQvuBUFv87XBlO3uZpZQ
 G3LtaKIbUCcGm3ZQZMAvuWNC
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 00:14:20 -0800
IronPort-SDR: Z0cQab+MYNFHMPSGfvgbfDk1iXWx97vevPW+D8FSO9XeZiQrN9kBpgdzMo4dtYZkxAvpOblsyh
 V8A23SNK5GE4FdKSVtck24Zt3NVezeMmDlpeTNv009x9VLJO7kvRA58A9wTybk7k+0Rho/FD4L
 3h3rc6pIQzztcFmrVYvsFi1FruwZL4ydDaGJZ6WCwAeLCtKZYVgwGuUrO6fGfBqVwWHTnbKGhE
 BiCgaaPmR53yYulEyBZnhPbAGZVg+JLsXyNXqwQ+tmv4NAC3laYDdh5qK9T8fqgsJDIxyYT93b
 Pqc=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Dec 2019 00:19:51 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v5 14/28] btrfs: redirty released extent buffers in HMZONED mode
Date:   Wed,  4 Dec 2019 17:17:21 +0900
Message-Id: <20191204081735.852438-15-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204081735.852438-1-naohiro.aota@wdc.com>
References: <20191204081735.852438-1-naohiro.aota@wdc.com>
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
btree_write_cache_pages() can send proper bios to the devices.

Besides it clears the entire content of the extent buffer not to confuse
raw block scanners e.g. btrfsck. By clearing the content,
csum_dirty_buffer() complains about bytenr mismatch, so avoid the checking
and checksum using newly introduced buffer flag EXTENT_BUFFER_NO_CHECK.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/disk-io.c     |  8 ++++++++
 fs/btrfs/extent-tree.c | 12 +++++++++++-
 fs/btrfs/extent_io.c   |  3 +++
 fs/btrfs/extent_io.h   |  2 ++
 fs/btrfs/hmzoned.c     | 36 ++++++++++++++++++++++++++++++++++++
 fs/btrfs/hmzoned.h     |  6 ++++++
 fs/btrfs/transaction.c | 10 ++++++++++
 fs/btrfs/transaction.h |  3 +++
 8 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 7f4c6a92079a..fbbc313f9f46 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -525,6 +525,12 @@ static int csum_dirty_buffer(struct btrfs_fs_info *fs_info, struct page *page)
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
@@ -4521,6 +4527,8 @@ void btrfs_cleanup_one_transaction(struct btrfs_transaction *cur_trans,
 	btrfs_destroy_pinned_extent(fs_info,
 				    fs_info->pinned_extents);
 
+	btrfs_free_redirty_list(cur_trans);
+
 	cur_trans->state =TRANS_STATE_COMPLETED;
 	wake_up(&cur_trans->commit_wait);
 }
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index b41a45855bc4..e61f69eef4a8 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3301,8 +3301,10 @@ void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 
 		if (root->root_key.objectid != BTRFS_TREE_LOG_OBJECTID) {
 			ret = check_ref_cleanup(trans, buf->start);
-			if (!ret)
+			if (!ret) {
+				btrfs_redirty_list_add(trans->transaction, buf);
 				goto out;
+			}
 		}
 
 		pin = 0;
@@ -3314,6 +3316,13 @@ void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
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
@@ -4524,6 +4533,7 @@ btrfs_init_new_buffer(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	btrfs_tree_lock(buf);
 	btrfs_clean_tree_block(buf);
 	clear_bit(EXTENT_BUFFER_STALE, &buf->bflags);
+	clear_bit(EXTENT_BUFFER_NO_CHECK, &buf->bflags);
 
 	btrfs_set_lock_blocking_write(buf);
 	set_extent_buffer_uptodate(buf);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index eb8bd0258360..6e25c8790ef4 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -24,6 +24,7 @@
 #include "rcu-string.h"
 #include "backref.h"
 #include "disk-io.h"
+#include "hmzoned.h"
 
 static struct kmem_cache *extent_state_cache;
 static struct kmem_cache *extent_buffer_cache;
@@ -4889,6 +4890,7 @@ __alloc_extent_buffer(struct btrfs_fs_info *fs_info, u64 start,
 	init_waitqueue_head(&eb->read_lock_wq);
 
 	btrfs_leak_debug_add(&eb->leak_list, &buffers);
+	INIT_LIST_HEAD(&eb->release_list);
 
 	spin_lock_init(&eb->refs_lock);
 	atomic_set(&eb->refs, 1);
@@ -5686,6 +5688,7 @@ void write_extent_buffer(struct extent_buffer *eb, const void *srcv,
 
 	WARN_ON(start > eb->len);
 	WARN_ON(start + len > eb->start + eb->len);
+	WARN_ON(test_bit(EXTENT_BUFFER_NO_CHECK, &eb->bflags));
 
 	offset = offset_in_page(start_offset + start);
 
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index a8551a1f56e2..51a15e93a5cd 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -29,6 +29,7 @@ enum {
 	EXTENT_BUFFER_IN_TREE,
 	/* write IO error */
 	EXTENT_BUFFER_WRITE_ERR,
+	EXTENT_BUFFER_NO_CHECK,
 };
 
 /* these are flags for __process_pages_contig */
@@ -115,6 +116,7 @@ struct extent_buffer {
 	 */
 	wait_queue_head_t read_lock_wq;
 	struct page *pages[INLINE_EXTENT_BUFFER_PAGES];
+	struct list_head release_list;
 #ifdef CONFIG_BTRFS_DEBUG
 	int spinning_writers;
 	atomic_t spinning_readers;
diff --git a/fs/btrfs/hmzoned.c b/fs/btrfs/hmzoned.c
index 0eb4f578c54a..169ef8a35cba 100644
--- a/fs/btrfs/hmzoned.c
+++ b/fs/btrfs/hmzoned.c
@@ -1138,3 +1138,39 @@ int btrfs_reset_device_zone(struct btrfs_device *device, u64 physical,
 
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
diff --git a/fs/btrfs/hmzoned.h b/fs/btrfs/hmzoned.h
index e1fa6a2f2557..ddec6aed7283 100644
--- a/fs/btrfs/hmzoned.h
+++ b/fs/btrfs/hmzoned.h
@@ -45,6 +45,9 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache);
 int btrfs_hmzoned_check_metadata_space(struct btrfs_fs_info *fs_info);
 int btrfs_reset_device_zone(struct btrfs_device *device, u64 physical,
 			    u64 length, u64 *bytes);
+void btrfs_redirty_list_add(struct btrfs_transaction *trans,
+			    struct extent_buffer *eb);
+void btrfs_free_redirty_list(struct btrfs_transaction *trans);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -110,6 +113,9 @@ static inline int btrfs_reset_device_zone(struct btrfs_device *device,
 {
 	return 0;
 }
+static inline void btrfs_redirty_list_add(struct btrfs_transaction *trans,
+					  struct extent_buffer *eb) { }
+static inline void btrfs_free_redirty_list(struct btrfs_transaction *trans) { }
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 19de6e2041dc..39628c370bdb 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -21,6 +21,7 @@
 #include "dev-replace.h"
 #include "qgroup.h"
 #include "block-group.h"
+#include "hmzoned.h"
 
 #define BTRFS_ROOT_TRANS_TAG 0
 
@@ -329,6 +330,8 @@ static noinline int join_transaction(struct btrfs_fs_info *fs_info,
 	spin_lock_init(&cur_trans->dirty_bgs_lock);
 	INIT_LIST_HEAD(&cur_trans->deleted_bgs);
 	spin_lock_init(&cur_trans->dropped_roots_lock);
+	INIT_LIST_HEAD(&cur_trans->releasing_ebs);
+	spin_lock_init(&cur_trans->releasing_ebs_lock);
 	list_add_tail(&cur_trans->list, &fs_info->trans_list);
 	extent_io_tree_init(fs_info, &cur_trans->dirty_pages,
 			IO_TREE_TRANS_DIRTY_PAGES, fs_info->btree_inode);
@@ -2336,6 +2339,13 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
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
index 49f7196368f5..3d60d2213c70 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -84,6 +84,9 @@ struct btrfs_transaction {
 	spinlock_t dropped_roots_lock;
 	struct btrfs_delayed_ref_root delayed_refs;
 	struct btrfs_fs_info *fs_info;
+
+	spinlock_t releasing_ebs_lock;
+	struct list_head releasing_ebs;
 };
 
 #define __TRANS_FREEZABLE	(1U << 0)
-- 
2.24.0

