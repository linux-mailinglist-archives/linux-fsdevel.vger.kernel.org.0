Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2E385E73
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 11:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732424AbfHHJbv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 05:31:51 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:59666 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732419AbfHHJbu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 05:31:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565256709; x=1596792709;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FKpxSAahkceObCkCHvtSaJb1gQU26ZNexGqsAqpyCHs=;
  b=iZLGMNVycAYcwsQlEBYjiCtaoaC5tA1OejvAm7DRu+Mpsj32ac7tb8JE
   w9VKXwcdNIiAZgtUL0ZUlXqsFqCG4YzsvlpROfVZHieZxvhddXHufDqR4
   4r4huqaJe3EGw6iTq+7IKXJhC6Jlri87KfVuUHXHOVwCzsgNQIVE6DhRY
   oLfsiVYrSzSDFfRU11cBvI4R4UWTba2aLI5EB3K0dCO4nL2IKCuMYRo0W
   /n+7bEUaWYL+52j9Mcnh7FfehluIMb5tPssItFbz4BqgyRaBS1ZhduMLW
   cPPWMSdEICHbSBaXb3d1BY/t5axRkT4Wjx9PA/Cc+Q7SUOHrie7o2950A
   w==;
IronPort-SDR: 8gSMoeNHKdLrC1g3tr2/FZWgP7CIiDQev/Tht9swwFjt/f9+pcGK3eBfb8RP61omF7rzC3KNOo
 0DUMxSosgMZFfsrZ35Yk71jEvG9eLAg+CHbCFkkfojylS9a9JifFQUS2H/K/zv8CG8tcvthEH+
 p0b8KrqxLK5FrQSbvai1nZdV4rgT0Qp2TMSYVd3S+NJeoD4+IixAQkLcGQQ/TzWl09inWWfGcR
 YnMyFztJ5c27lAfARn5ixjhLE3kCc1Hdk0u22sAEJTuN1MEe4/OMjznYHu7ysaHrNOhwPmOiaR
 HRU=
X-IronPort-AV: E=Sophos;i="5.64,360,1559491200"; 
   d="scan'208";a="115363398"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2019 17:31:49 +0800
IronPort-SDR: vNJXFm1toqc8B0f8WTi6CokGXAWcPcXkobRyiX92mqTOkDhE8FFqbn3/IE0B6C27DKMZo0W3IL
 X7xwG/ku2/b/USCmqCFy3uKpLkxWYQbkmAHk0MXztCbWazggb9NJw2L7QziyI0Tm+hTLnTB5Gh
 j0eoBJemXbMhWMA7VB4I/SE/OKBsXDlaq8amZ0afUBKBhl8br7yggMeW1bQc9agsEpfhwZQ1DW
 zjWo275vhUSAwHPqjdBX4QjlHqw681nEMfV9csOCS+mWXHIFGwDH6ZmPTwALwScz+GMCYxgVHj
 aWzM12iEecrffGL+RUO4rUSO
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 02:29:33 -0700
IronPort-SDR: eVv6sa08/VTJrhxlQcdasc+oTG7jDsg4rvqOX10CixvsPT9kVoZ7m95kg3irLMStP4BEgJtZdQ
 j/Y9Dj8tcAEPk6PPh/NsjsCNFohzNHq+9z6m80qkn68M4vYs8zanWY83VcLq/DcVU7ZBCaBPLv
 t0WeqK7NvSUQNrjbo5B7ZUYCvuvtTGbARmysk0IpcDCc6ZBtP2sCngMaeBO3bAxwJDIICJ8hlv
 9Dwuxo6Qyd9xKhrfWyLGbSdFedobivAJwxHPBLwB85K1vM9OzaxpXqvRIpRDUaMLBqqQdmFi9A
 r7U=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Aug 2019 02:31:48 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 19/27] btrfs: serialize meta IOs on HMZONED mode
Date:   Thu,  8 Aug 2019 18:30:30 +0900
Message-Id: <20190808093038.4163421-20-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808093038.4163421-1-naohiro.aota@wdc.com>
References: <20190808093038.4163421-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As same as in data IO path, we must serialize write IOs for metadata. We
cannot add mutex around allocation and submit because metadata blocks are
allocated in an earlier stage to build up B-trees.

Thus, this commit add hmzoned_meta_io_lock and hold it during metadata IO
submission in btree_write_cache_pages() to serialize IOs. Furthermore, this
commit add per-block grorup metadata IO submission pointer
"meta_write_pointer" to ensure sequential writing.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/ctree.h     |  3 +++
 fs/btrfs/disk-io.c   |  1 +
 fs/btrfs/extent_io.c | 17 ++++++++++++++++-
 fs/btrfs/hmzoned.c   | 45 ++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/hmzoned.h   | 17 +++++++++++++++++
 5 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 1e924c0d1210..a6a03fc5e4c5 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -620,6 +620,7 @@ struct btrfs_block_group_cache {
 	 */
 	u64 alloc_offset;
 	struct mutex zone_io_lock;
+	u64 meta_write_pointer;
 };
 
 /* delayed seq elem */
@@ -1108,6 +1109,8 @@ struct btrfs_fs_info {
 	spinlock_t ref_verify_lock;
 	struct rb_root block_tree;
 #endif
+
+	struct mutex hmzoned_meta_io_lock;
 };
 
 static inline struct btrfs_fs_info *btrfs_sb(struct super_block *sb)
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index e0a80997b6ee..63dd4670aba6 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2703,6 +2703,7 @@ int open_ctree(struct super_block *sb,
 	mutex_init(&fs_info->delete_unused_bgs_mutex);
 	mutex_init(&fs_info->reloc_mutex);
 	mutex_init(&fs_info->delalloc_root_mutex);
+	mutex_init(&fs_info->hmzoned_meta_io_lock);
 	seqlock_init(&fs_info->profiles_lock);
 
 	INIT_LIST_HEAD(&fs_info->dirty_cowonly_roots);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 4e67b16c9f80..ff963b2214aa 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3892,7 +3892,9 @@ int btree_write_cache_pages(struct address_space *mapping,
 				   struct writeback_control *wbc)
 {
 	struct extent_io_tree *tree = &BTRFS_I(mapping->host)->io_tree;
+	struct btrfs_fs_info *fs_info = tree->fs_info;
 	struct extent_buffer *eb, *prev_eb = NULL;
+	struct btrfs_block_group_cache *cache = NULL;
 	struct extent_page_data epd = {
 		.bio = NULL,
 		.tree = tree,
@@ -3922,6 +3924,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 		tag = PAGECACHE_TAG_TOWRITE;
 	else
 		tag = PAGECACHE_TAG_DIRTY;
+	btrfs_hmzoned_meta_io_lock(fs_info);
 retry:
 	if (wbc->sync_mode == WB_SYNC_ALL)
 		tag_pages_for_writeback(mapping, index, end);
@@ -3965,6 +3968,14 @@ int btree_write_cache_pages(struct address_space *mapping,
 			if (!ret)
 				continue;
 
+			if (!btrfs_check_meta_write_pointer(fs_info, eb,
+							    &cache)) {
+				ret = 0;
+				done = 1;
+				free_extent_buffer(eb);
+				break;
+			}
+
 			prev_eb = eb;
 			ret = lock_extent_buffer_for_io(eb, &epd);
 			if (!ret) {
@@ -3999,12 +4010,16 @@ int btree_write_cache_pages(struct address_space *mapping,
 		index = 0;
 		goto retry;
 	}
+	if (cache)
+		btrfs_put_block_group(cache);
 	ASSERT(ret <= 0);
 	if (ret < 0) {
 		end_write_bio(&epd, ret);
-		return ret;
+		goto out;
 	}
 	ret = flush_write_bio(&epd);
+out:
+	btrfs_hmzoned_meta_io_unlock(fs_info);
 	return ret;
 }
 
diff --git a/fs/btrfs/hmzoned.c b/fs/btrfs/hmzoned.c
index 4c296d282e67..4b13c6c47849 100644
--- a/fs/btrfs/hmzoned.c
+++ b/fs/btrfs/hmzoned.c
@@ -548,6 +548,9 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group_cache *cache)
 
 out:
 	cache->alloc_type = alloc_type;
+	if (!ret)
+		cache->meta_write_pointer =
+			cache->alloc_offset + cache->key.objectid;
 	kfree(alloc_offsets);
 	free_extent_map(em);
 
@@ -648,3 +651,45 @@ void btrfs_free_redirty_list(struct btrfs_transaction *trans)
 	}
 	spin_unlock(&trans->releasing_ebs_lock);
 }
+
+bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
+				    struct extent_buffer *eb,
+				    struct btrfs_block_group_cache **cache_ret)
+{
+	struct btrfs_block_group_cache *cache;
+
+	if (!btrfs_fs_incompat(fs_info, HMZONED))
+		return true;
+
+	cache = *cache_ret;
+
+	if (cache &&
+	    (eb->start < cache->key.objectid ||
+	     cache->key.objectid + cache->key.offset <= eb->start)) {
+		btrfs_put_block_group(cache);
+		cache = NULL;
+		*cache_ret = NULL;
+	}
+
+	if (!cache)
+		cache = btrfs_lookup_block_group(fs_info,
+						 eb->start);
+
+	if (cache) {
+		*cache_ret = cache;
+
+		if (cache->alloc_type != BTRFS_ALLOC_SEQ)
+			return true;
+
+		if (cache->meta_write_pointer != eb->start) {
+			btrfs_put_block_group(cache);
+			cache = NULL;
+			*cache_ret = NULL;
+			return false;
+		}
+
+		cache->meta_write_pointer = eb->start + eb->len;
+	}
+
+	return true;
+}
diff --git a/fs/btrfs/hmzoned.h b/fs/btrfs/hmzoned.h
index a8e7286708d4..c68c4b8056a4 100644
--- a/fs/btrfs/hmzoned.h
+++ b/fs/btrfs/hmzoned.h
@@ -40,6 +40,9 @@ void btrfs_redirty_list_add(struct btrfs_transaction *trans,
 			    struct extent_buffer *eb);
 void btrfs_free_redirty_list(struct btrfs_transaction *trans);
 void btrfs_hmzoned_data_io_unlock_at(struct inode *inode, u64 start, u64 len);
+bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
+				    struct extent_buffer *eb,
+				    struct btrfs_block_group_cache **cache_ret);
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
 {
@@ -174,4 +177,18 @@ static inline void btrfs_hmzoned_data_io_unlock_logical(
 	btrfs_put_block_group(cache);
 }
 
+static inline void btrfs_hmzoned_meta_io_lock(struct btrfs_fs_info *fs_info)
+{
+	if (!btrfs_fs_incompat(fs_info, HMZONED))
+		return;
+	mutex_lock(&fs_info->hmzoned_meta_io_lock);
+}
+
+static inline void btrfs_hmzoned_meta_io_unlock(struct btrfs_fs_info *fs_info)
+{
+	if (!btrfs_fs_incompat(fs_info, HMZONED))
+		return;
+	mutex_unlock(&fs_info->hmzoned_meta_io_lock);
+}
+
 #endif
-- 
2.22.0

