Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA6CC9ACC7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2019 12:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404597AbfHWKLu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Aug 2019 06:11:50 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:47806 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404383AbfHWKLt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Aug 2019 06:11:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566555109; x=1598091109;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yW9btYQxXmen4W7byA8IXC1sJmMINn7f2DFdlZItrXI=;
  b=GWGyqWf3BGEnYyXRYshdEc24JWcQzqJOU8W33VqB43d03enJ8G54kTYR
   /4DXHyrUhssUFlymnN0doy4Ma4gw7Y09DEJorBR6T9deC2BGT15O0CBZr
   bVlyWSMIK2IzGkSuaA/60qanxVQPr005fuW2grC822HVc4PWfFBslLTGu
   8M3pM1DYNvysy+DECMJ6DvqN0/B7w7i7nq7+7CzDwMCCl45PEQWU8Flqq
   RlPOluUiTKFrgULqYDmJNqPiJ9+HPLm0iUMrQv/C649vMvLCbI8RrCObZ
   SbHV3n/QurTE3ZJarP7F0NEeBs0MWq6Py0AG+G0rsMX5gqDWRW0shADdQ
   w==;
IronPort-SDR: F2qunQ0zpziNq+TqS/aQG4vQPRX53HuCenwf3MHvhro3Hp6ssf5UGxV+iDMBy82O1vw+i5CvWi
 rlPtVApJZAJLfsCe8wB7i9UHQy8iLD3bj4rymf8FjaY7De1ilu+JDCwrAomwynB9ZvgcqxnJuX
 4NQGWJo1QW5miDlJUjBXZ1pAHAJSZ7+pWMlEvCjc4BrZ91vaSGeBhS1ZUSVEEbV/PYxQWi1/NE
 b6j7mkwyEaWgh4ExSvw1yyz3afg6NlLYRZZIKmKo7nxh3bpWzkT2vLrheiUCvtkwjK1x9fobJw
 ero=
X-IronPort-AV: E=Sophos;i="5.64,420,1559491200"; 
   d="scan'208";a="121096265"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Aug 2019 18:11:49 +0800
IronPort-SDR: o/+GeNrrmtaEDgjmikqL5tyUouMKfaYyoNsff4QSf0MAnoGIvGVgDkItxyZruPE5C/TdACqZ1M
 tRWjsa9xaB0lOBECU/yM7rhON95yVIgfJS/QRZGsHmHWrFb/dL6zPscbY6/AYILnnjVDvNyvSU
 dTvaMuXo6Fa5fl/WvFKHlKdhkXeGxSFdAUGKS9bMV4C/nDy60R218kD1Xell9K1v+o+QnApq7h
 +cYJsLaDUcUyqTMRedOjfLQ6801ZAykhxERy50O81CPv1V2vRDMiRc/dXAQX76Yn66O/ADJsYL
 ORLLOrgpGq32B04V8Nt+puuj
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2019 03:09:07 -0700
IronPort-SDR: wzU3Od9kC5oShRwkcaQSC8AfIS5YNM3g93ZFOjLGqCQ5LZ+EuCl9SJCBsRr5Oy4XWxaBRWgl3S
 M96Xt+MiPt64S4Ips+TTCpoFbZQF7fCR6AmYcWMXDQ9GdX481MSee+3YCpWxnw5Ud9oEpE3f/m
 MMjJ3/97ipAXTHBueuM7PdkIZtsPS2hFUGrNhx+DgpPfLR83TgyDKW6LGd3AnUJcYSJi6V3QJo
 EsColpXJPO57giXsHppPnDMYtLUWmuN8E3XEGU6ysxG1GL9VAHERytQKrRd8BVv4jeWauCEf6N
 Boo=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Aug 2019 03:11:47 -0700
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
Subject: [PATCH v4 19/27] btrfs: serialize meta IOs on HMZONED mode
Date:   Fri, 23 Aug 2019 19:10:28 +0900
Message-Id: <20190823101036.796932-20-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190823101036.796932-1-naohiro.aota@wdc.com>
References: <20190823101036.796932-1-naohiro.aota@wdc.com>
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
index d4df9624cb04..e974174e12a2 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -619,6 +619,7 @@ struct btrfs_block_group_cache {
 	 */
 	u64 alloc_offset;
 	struct mutex zone_io_lock;
+	u64 meta_write_pointer;
 };
 
 /* delayed seq elem */
@@ -1105,6 +1106,8 @@ struct btrfs_fs_info {
 	spinlock_t ref_verify_lock;
 	struct rb_root block_tree;
 #endif
+
+	struct mutex hmzoned_meta_io_lock;
 };
 
 static inline struct btrfs_fs_info *btrfs_sb(struct super_block *sb)
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index d36cdb1b1421..a9632e455eb5 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2701,6 +2701,7 @@ int open_ctree(struct super_block *sb,
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
index 81d8037ae7f6..bfc95a0443d0 100644
--- a/fs/btrfs/hmzoned.c
+++ b/fs/btrfs/hmzoned.c
@@ -545,6 +545,9 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group_cache *cache)
 
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
2.23.0

