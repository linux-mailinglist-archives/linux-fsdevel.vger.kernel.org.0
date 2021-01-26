Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A52030492A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 20:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387626AbhAZFaX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:30:23 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:38250 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732334AbhAZCn6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:43:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611629038; x=1643165038;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mMmFlm1ADxq3dYqfU0mxrP6qLI19NJyl4vx6551H+1s=;
  b=SDvH5xovq6wBTfcifCFQBhNq9Si9ALXp0KycliKsdhou2jBUN4KMXbzB
   +ZoXbdhQ98BUl+pW08xNNp2cMTXoyYi9chf3Hh7abFGxcIInZdHYBna/p
   YM3vXiOdO0F2DEX805c5vRomXjO4Qtp2lu/f1lAaCegVBbwxGUI/CMjLu
   clTIu9OpBlblHYry8kR+KhWOffV+vNe0pBrCNbqercsbN7jwy5EtRpAjW
   ez3uUy0moVwyBExdMjOG1LzEHtHU4cgKxSrAqsRaOzEQINhV68nPIPZ/8
   xQVYdnCMJZJyufjb61X3uCmS3WEh5zOxnP/8dphRwAgaJ7uTOZ/W4KVcz
   w==;
IronPort-SDR: e7TWfv5AZfRgGMXm8gnQdmuz0xkPmffFJ9TvO7tFSiiEM0TGbhX5IJPksFOpCZy9Zvrz+nBsE0
 8n8qDFTRwMbADFvgOsthviJ9EcgK+Lmi2A5YkwO3E2l5ZyOEzE95+ph6zfSA78DAGLOLPNidpk
 N/MHvr1uoaY+EeTWGZG89R91WVIexDMme1SnGXBF6+b7NJHqfRPQi4/fp7FYAmZZGfuYBsLpaU
 3RMZvXImx7KBqYCMr9kFMY4rj/uaj2b0nmkYkNAW7TVotjh1uNzy+QyPHP2u6MJOiza0bwjp4C
 BEI=
X-IronPort-AV: E=Sophos;i="5.79,375,1602518400"; 
   d="scan'208";a="159483582"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2021 10:27:06 +0800
IronPort-SDR: 7FIYzlsFUiU770LmxizF/lvA+a/a8YULB4ilBEgzfZIywGIpLtrU26qpbFpKQy34sSamp/Am69
 7J2HtiiHlprJ1RngIGxbKXUB17W7OXMBN3ylMBItO7Sy8LZvW1EOYU5swdg2NRAJ13HIzGvNKt
 NR6T8f9sKIbU3BYPmxgBd2yxviD0Sw79qQHEVXkARayv6Gkn1oKi7Q3VduiCAisJUQ5P0HdH5p
 MSKw5BK14RKpvTU/uTd9SaDYWDPOyL3MSHAfsP0FGmTvJUBTonhbFcbmqoaKiQaH2GzfT90/wt
 0JH0sEFU1TUPIuXwrd8FjcLy
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 18:11:32 -0800
IronPort-SDR: qGpGfF9+fEaSlZB3VNHTVPx9N+zGYwV/m9HxF+A3yPWZfE68GmRTzgJmz0wzbvZiGmK2sswPCo
 maD9IVIBNdIqwtHOd0geVrl8PLwkhUkvaA2hJkMraVrrXbg+/jDjXXJIOy5LMqpgY4JNdjQxJ4
 fOqgu+TKW+KfTFJiLxd8vRim7borarJQchpq3DvBClADYr3f180VCp4INHDw0dPqbbyVv7+vRY
 Ch9XbpgPfqnTZhmFPRZrIqzsKWF7sAQt1SuiiOsaeGyJiIml1wJtulUiThrIiOw5UXScgeNjll
 eow=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Jan 2021 18:27:04 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v14 39/42] btrfs: split alloc_log_tree()
Date:   Tue, 26 Jan 2021 11:25:17 +0900
Message-Id: <183f68ab886fde72dcaacacf4619d59f44dfab8d.1611627788.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611627788.git.naohiro.aota@wdc.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a preparation for the next patch. This commit split
alloc_log_tree() to allocating tree structure part (remains in
alloc_log_tree()) and allocating tree node part (moved in
btrfs_alloc_log_tree_node()). The latter part is also exported to be used
in the next patch.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/disk-io.c | 33 +++++++++++++++++++++++++++------
 fs/btrfs/disk-io.h |  2 ++
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5d14100ecf72..2e2f09a46f45 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1197,7 +1197,6 @@ static struct btrfs_root *alloc_log_tree(struct btrfs_trans_handle *trans,
 					 struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_root *root;
-	struct extent_buffer *leaf;
 
 	root = btrfs_alloc_root(fs_info, BTRFS_TREE_LOG_OBJECTID, GFP_NOFS);
 	if (!root)
@@ -1207,6 +1206,14 @@ static struct btrfs_root *alloc_log_tree(struct btrfs_trans_handle *trans,
 	root->root_key.type = BTRFS_ROOT_ITEM_KEY;
 	root->root_key.offset = BTRFS_TREE_LOG_OBJECTID;
 
+	return root;
+}
+
+int btrfs_alloc_log_tree_node(struct btrfs_trans_handle *trans,
+			      struct btrfs_root *root)
+{
+	struct extent_buffer *leaf;
+
 	/*
 	 * DON'T set SHAREABLE bit for log trees.
 	 *
@@ -1219,26 +1226,33 @@ static struct btrfs_root *alloc_log_tree(struct btrfs_trans_handle *trans,
 
 	leaf = btrfs_alloc_tree_block(trans, root, 0, BTRFS_TREE_LOG_OBJECTID,
 			NULL, 0, 0, 0, BTRFS_NESTING_NORMAL);
-	if (IS_ERR(leaf)) {
-		btrfs_put_root(root);
-		return ERR_CAST(leaf);
-	}
+	if (IS_ERR(leaf))
+		return PTR_ERR(leaf);
 
 	root->node = leaf;
 
 	btrfs_mark_buffer_dirty(root->node);
 	btrfs_tree_unlock(root->node);
-	return root;
+
+	return 0;
 }
 
 int btrfs_init_log_root_tree(struct btrfs_trans_handle *trans,
 			     struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_root *log_root;
+	int ret;
 
 	log_root = alloc_log_tree(trans, fs_info);
 	if (IS_ERR(log_root))
 		return PTR_ERR(log_root);
+
+	ret = btrfs_alloc_log_tree_node(trans, log_root);
+	if (ret) {
+		btrfs_put_root(log_root);
+		return ret;
+	}
+
 	WARN_ON(fs_info->log_root_tree);
 	fs_info->log_root_tree = log_root;
 	return 0;
@@ -1250,11 +1264,18 @@ int btrfs_add_log_tree(struct btrfs_trans_handle *trans,
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_root *log_root;
 	struct btrfs_inode_item *inode_item;
+	int ret;
 
 	log_root = alloc_log_tree(trans, fs_info);
 	if (IS_ERR(log_root))
 		return PTR_ERR(log_root);
 
+	ret = btrfs_alloc_log_tree_node(trans, log_root);
+	if (ret) {
+		btrfs_put_root(log_root);
+		return ret;
+	}
+
 	log_root->last_trans = trans->transid;
 	log_root->root_key.offset = root->root_key.objectid;
 
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 9f4a2a1e3d36..0e7e9526b6a8 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -120,6 +120,8 @@ blk_status_t btrfs_wq_submit_bio(struct inode *inode, struct bio *bio,
 				 extent_submit_bio_start_t *submit_bio_start);
 blk_status_t btrfs_submit_bio_done(void *private_data, struct bio *bio,
 			  int mirror_num);
+int btrfs_alloc_log_tree_node(struct btrfs_trans_handle *trans,
+			      struct btrfs_root *root);
 int btrfs_init_log_root_tree(struct btrfs_trans_handle *trans,
 			     struct btrfs_fs_info *fs_info);
 int btrfs_add_log_tree(struct btrfs_trans_handle *trans,
-- 
2.27.0

