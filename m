Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2D92FFCDD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 07:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbhAVGcg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 01:32:36 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:51039 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbhAVGaT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 01:30:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611297019; x=1642833019;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mMmFlm1ADxq3dYqfU0mxrP6qLI19NJyl4vx6551H+1s=;
  b=RMVBDivLnm8yAkDymkakd1Ec4IEmcx7zIi+cTlrIGoLIG1/dCI3cIxT8
   bnDfBgvuiVeRK8dNAV8kSQTSJ5kujSNFyk45+C/7me55ug1Jz2ZRtTkjr
   u4KHvSUv9OXD1eY4b7bPEeMjxjQtixYFGwgrrTMB9CA8yvIrDQJr7qL9Q
   xNmd2XzqeFRBl2YIQTQJSq0pOx4BBfcg7qDat4wa7UCncOxKb264GobhV
   tab8lc6lXIRizaLBjTB/RzExmE20hvb8TDVebE66EUbdc3Z1Eb6gztHlf
   IX/B1RRsrUwwndd2NmpJ7WUn8hEiFBNCHw2LKCQO4PlXe1kwybW9Ghtoe
   A==;
IronPort-SDR: fp06muvTz2FyX1kaTu66n9ATV/nySIQZvJNJk5TQEe9t3ReojQplY0+GhEYMrbMcx0YLCc1dXR
 oTD6IZCwwql1S8G8QuD+cU4pPxJLyXABx2NRaOyQoiMwynYyhYCh/07g3u+j7mNkku7s3HYKtk
 +ADUb7dBosVLbzJ2T5eS79RDbxZdofp2BzjM7BPkGdY4nKj+872vIqBS1HMYdfRsveAMVZb+37
 STcQPQXkSD+H4bcP+EEbJ5FTecWgC5BCHaLjlcv+2fnffR6xI88uYcGJKikDmrLjUzHOaaAgZF
 5lA=
X-IronPort-AV: E=Sophos;i="5.79,365,1602518400"; 
   d="scan'208";a="268392091"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2021 14:23:26 +0800
IronPort-SDR: WmZmx0zT0rW7Rt3neLtFdHnXCWnSxlLnIJTa6JWw/8PUIruG1uzONRI+1u618zdOj/MP66NnPD
 Tkx2V58IK/r2ulfy+g6kti5eXmsOV3EhmNwUH0UNMu29cMAzXx/z7ERQMWxJYOUkcX5j2Qa2B/
 KVFFKT1mZf27SiOQ0txRMldVascfK9izLduLlByuW/s1KqnVCxEwAnzuH5RHDqpp2YDnPx7XGM
 65kmWXdzBCAfzaWYX2f6hDrojgcvvAD0IsFGJqleTrD/zZ0zETZN8RNZxWACsO+FIln5dnRY8t
 kjxqck6k4atdiRXZjfVCI/lF
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 22:05:57 -0800
IronPort-SDR: 544bDMKixWiEQUPiNojbFMrcWZRfa/U/Lezd71ivZnwASOPIlDwCMoHSTClT51BczOhxfei5wZ
 wHTUL3G3Ojobjnz8tJ7pXJQwLFPIPj9OtlHA60WPGFdo19qRKJKKtI/kceNmQDzzCfbRUP9joI
 55kRNoMw7Tt13y61WIdbMyTM0ReRwWGHssGwWkOtzcpWkA/uTQwKORnyhPnowZPoVksOQxGWwD
 RSdQNcnTSE92hZKalI6PDkaDxceEmJFb6pZaQOeuapTpwNbx3I6YFP0E3zk4pBP1DEEzUIt4Gi
 eF0=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Jan 2021 22:23:24 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v13 39/42] btrfs: split alloc_log_tree()
Date:   Fri, 22 Jan 2021 15:21:39 +0900
Message-Id: <074f66f9d68a916d5c897b08c80860375fbfb974.1611295439.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611295439.git.naohiro.aota@wdc.com>
References: <cover.1611295439.git.naohiro.aota@wdc.com>
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

