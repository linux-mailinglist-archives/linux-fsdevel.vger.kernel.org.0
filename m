Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 990A7112476
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 09:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbfLDIUF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 03:20:05 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:32779 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727435AbfLDIUF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:20:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1575447605; x=1606983605;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ciqj1oCL5KqUdvZbziaPfAt/t1dmYyxBglSVY3FHISw=;
  b=bTMNA4F333JjaZUx3u/m/3x1I9RWZ8mTXFo4pb+WgSEM1G2VukBFmTQ+
   vgd9P4HGQzyoigDZrLuCF8iumm15Eca6U3xtisTfP5Kh+/2wm9mDdkMVG
   ap/JkqycJs9yqzVpDAZVAHpifIiGamhEo3NQvQysrfjSKh17WQWnNOl8A
   PEj6X/hobDWDZp1i3IvO8n8XSRq8bfABl64DFedI5rqksqakL++tLHl8t
   h2IkBEWtOR5jVdUIRG2k3CjhxR6TPqtEau5eRmgQoCOa7eOi/tEGDmB2i
   igIrtTg1F8Qeou2g1DrnHFX9BsapHD8jFlN5Z9Lo/v/3QnoDYx6PterJj
   A==;
IronPort-SDR: VeOBzkPrJID8sKHAs7pV5GgNq9WVEn+n4OgFIVDRhJyDQ1iH55CY2lt/56IzmtGFOkZvLVLCFY
 JYA5gVnnfJwS2D3BKBt2jMoXTzY6Z/HRm/GjM62Of9KKKFHdTa/D12OKr2YRXoWwemZA31ByiV
 8dycCatnqxrx4eGnfbV5I5AEDHd+5Zn5nsEVBaV5sSOrVaQn8BM+k6T0xmGiUq+M/jtO8uapW3
 b6E5EfDuTPEPW33sx9RJDB+mr2Cy7Fy6usyf1LkGKJZoWDDrcS9TrYAevzF5wwzi67sWwL7wlV
 g8I=
X-IronPort-AV: E=Sophos;i="5.69,276,1571673600"; 
   d="scan'208";a="125355097"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2019 16:20:04 +0800
IronPort-SDR: 5R9YSsfSRClpkraFTKDXojOYEkXahHALa743vnKYnI6Zg+skGdsQsdBKEfmKgFW4Keczj7hXil
 FRRj+An8R/BtqKfDPu3UZ9YxxWj4NTB+9squYUXNYtmThxK964CtEILZk6ldGVmHQHOqi+x1Ie
 SwnAR05jO/VNxLqOKTXgmnRK9v6Tu4llW5h/8v39LQiJBaf0btTnR8VbAU819OCpfFkqKTrVqG
 YJc8UKobwlsp09yuwaIi59ctiKLojED3hgUdPHxWvWCYtZN8r+o0v5mLobUTUMPXtWGuaE6C2R
 l2NCX534CmfuGeofH0xhgwrF
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 00:14:29 -0800
IronPort-SDR: 4C48g2bSGT8qcFhyX4sG4jy2UOPWseEyn3rdjmwDvxqAkpp/Alg96Z0D2IwcY/WgOqsBZlTTxs
 7kigIe0VRmIKGFxpZaRcaxwHAD7nGFT9CI1Gtp4t5YeIG17rfxatFNMT7QiMaHUS02nMc8PJZH
 Hj9fvx0XpUm7ko5RUPkIuCCKOG7oEQiMMsnSbpON3gRLYzo+Ej1EjFew/WDMtsbcDb0xPvKcyd
 rp2jbj0o3R3JbkvbAhUfzufH2vyumuQndGT7LGUGhlzDBrpGZ+xPwY4D500QIr6nsudbrsIJPx
 IVo=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Dec 2019 00:20:02 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v5 18/28] btrfs: serialize meta IOs on HMZONED mode
Date:   Wed,  4 Dec 2019 17:17:25 +0900
Message-Id: <20191204081735.852438-19-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204081735.852438-1-naohiro.aota@wdc.com>
References: <20191204081735.852438-1-naohiro.aota@wdc.com>
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
commit add per-block group metadata IO submission pointer
"meta_write_pointer" to ensure sequential writing, which can be caused when
writing back blocks in a not finished transaction.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.h |  1 +
 fs/btrfs/ctree.h       |  2 ++
 fs/btrfs/disk-io.c     |  1 +
 fs/btrfs/extent_io.c   | 27 +++++++++++++++++++++-
 fs/btrfs/hmzoned.c     | 52 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/hmzoned.h     | 27 ++++++++++++++++++++++
 6 files changed, 109 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 57c8d6f4b3d1..8827869f1744 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -166,6 +166,7 @@ struct btrfs_block_group {
 	 */
 	u64 alloc_offset;
 	struct mutex zone_io_lock;
+	u64 meta_write_pointer;
 };
 
 #ifdef CONFIG_BTRFS_DEBUG
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 44517802b9e5..18d2d0581e68 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -905,6 +905,8 @@ struct btrfs_fs_info {
 	spinlock_t ref_verify_lock;
 	struct rb_root block_tree;
 #endif
+
+	struct mutex hmzoned_meta_io_lock;
 };
 
 static inline struct btrfs_fs_info *btrfs_sb(struct super_block *sb)
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index fbbc313f9f46..4abadd9317d1 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2707,6 +2707,7 @@ int __cold open_ctree(struct super_block *sb,
 	mutex_init(&fs_info->delete_unused_bgs_mutex);
 	mutex_init(&fs_info->reloc_mutex);
 	mutex_init(&fs_info->delalloc_root_mutex);
+	mutex_init(&fs_info->hmzoned_meta_io_lock);
 	seqlock_init(&fs_info->profiles_lock);
 
 	INIT_LIST_HEAD(&fs_info->dirty_cowonly_roots);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 6e25c8790ef4..24f7b05e1f4c 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3921,7 +3921,9 @@ int btree_write_cache_pages(struct address_space *mapping,
 				   struct writeback_control *wbc)
 {
 	struct extent_io_tree *tree = &BTRFS_I(mapping->host)->io_tree;
+	struct btrfs_fs_info *fs_info = tree->fs_info;
 	struct extent_buffer *eb, *prev_eb = NULL;
+	struct btrfs_block_group *cache = NULL;
 	struct extent_page_data epd = {
 		.bio = NULL,
 		.tree = tree,
@@ -3951,6 +3953,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 		tag = PAGECACHE_TAG_TOWRITE;
 	else
 		tag = PAGECACHE_TAG_DIRTY;
+	btrfs_hmzoned_meta_io_lock(fs_info);
 retry:
 	if (wbc->sync_mode == WB_SYNC_ALL)
 		tag_pages_for_writeback(mapping, index, end);
@@ -3994,12 +3997,30 @@ int btree_write_cache_pages(struct address_space *mapping,
 			if (!ret)
 				continue;
 
+			if (!btrfs_check_meta_write_pointer(fs_info, eb,
+							    &cache)) {
+				/*
+				 * If for_sync, this hole will be
+				 * filled with trasnsaction commit.
+				 */
+				if (wbc->sync_mode == WB_SYNC_ALL &&
+				    !wbc->for_sync)
+					ret = -EAGAIN;
+				else
+					ret = 0;
+				done = 1;
+				free_extent_buffer(eb);
+				break;
+			}
+
 			prev_eb = eb;
 			ret = lock_extent_buffer_for_io(eb, &epd);
 			if (!ret) {
+				btrfs_revert_meta_write_pointer(cache, eb);
 				free_extent_buffer(eb);
 				continue;
 			} else if (ret < 0) {
+				btrfs_revert_meta_write_pointer(cache, eb);
 				done = 1;
 				free_extent_buffer(eb);
 				break;
@@ -4032,12 +4053,16 @@ int btree_write_cache_pages(struct address_space *mapping,
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
index 169ef8a35cba..ee9d9cd54664 100644
--- a/fs/btrfs/hmzoned.c
+++ b/fs/btrfs/hmzoned.c
@@ -1072,6 +1072,9 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
 		}
 	}
 
+	if (!ret)
+		cache->meta_write_pointer = cache->alloc_offset + cache->start;
+
 	kfree(alloc_offsets);
 	free_extent_map(em);
 
@@ -1174,3 +1177,52 @@ void btrfs_free_redirty_list(struct btrfs_transaction *trans)
 	}
 	spin_unlock(&trans->releasing_ebs_lock);
 }
+
+bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
+				    struct extent_buffer *eb,
+				    struct btrfs_block_group **cache_ret)
+{
+	struct btrfs_block_group *cache;
+
+	if (!btrfs_fs_incompat(fs_info, HMZONED))
+		return true;
+
+	cache = *cache_ret;
+
+	if (cache &&
+	    (eb->start < cache->start ||
+	     cache->start + cache->length <= eb->start)) {
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
+
+void btrfs_revert_meta_write_pointer(struct btrfs_block_group *cache,
+				     struct extent_buffer *eb)
+{
+	if (!btrfs_fs_incompat(eb->fs_info, HMZONED) || !cache)
+		return;
+
+	ASSERT(cache->meta_write_pointer == eb->start + eb->len);
+	cache->meta_write_pointer = eb->start;
+}
diff --git a/fs/btrfs/hmzoned.h b/fs/btrfs/hmzoned.h
index f6682ead575b..54f1affa6919 100644
--- a/fs/btrfs/hmzoned.h
+++ b/fs/btrfs/hmzoned.h
@@ -50,6 +50,11 @@ void btrfs_redirty_list_add(struct btrfs_transaction *trans,
 			    struct extent_buffer *eb);
 void btrfs_free_redirty_list(struct btrfs_transaction *trans);
 void btrfs_hmzoned_data_io_unlock_at(struct inode *inode, u64 start, u64 len);
+bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
+				    struct extent_buffer *eb,
+				    struct btrfs_block_group **cache_ret);
+void btrfs_revert_meta_write_pointer(struct btrfs_block_group *cache,
+				     struct extent_buffer *eb);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -120,6 +125,14 @@ static inline void btrfs_redirty_list_add(struct btrfs_transaction *trans,
 static inline void btrfs_free_redirty_list(struct btrfs_transaction *trans) { }
 static inline void btrfs_hmzoned_data_io_unlock_at(struct inode *inode,
 						   u64 start, u64 len) { }
+static inline bool btrfs_check_meta_write_pointer(
+	struct btrfs_fs_info *fs_info, struct extent_buffer *eb,
+	struct btrfs_block_group **cache_ret)
+{
+	return true;
+}
+static inline void btrfs_revert_meta_write_pointer(
+	struct btrfs_block_group *cache, struct extent_buffer *eb) { }
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
@@ -254,4 +267,18 @@ static inline void btrfs_hmzoned_data_io_unlock_logical(
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
2.24.0

