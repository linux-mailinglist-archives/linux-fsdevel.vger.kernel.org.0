Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC70C30F0E9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 11:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235538AbhBDKdF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 05:33:05 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:54296 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235583AbhBDKbj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:31:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612434698; x=1643970698;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QOL0E9tS9Yd5OAaj5DhPGdwfZr8n6HcliTvpWtqG1PU=;
  b=kvCaf6LGYsJUhHVMuP+HLW86EhT7Hd24vaBb5C5dbG6NCQxouLzNrPhB
   Vvbm6tyIYrJnHl4LZoKRZzvFgHYcYbYGHylvDO/zJ9zDPJNNP2JQtN4GK
   XAQWSruDOk8Sp4kDUHODkK0D5fah4UrqF9Ta+sEsxejUyXMMLNUj+eHJL
   apPMJ1Cmd0cQ+aNLmn18O4bpO1MzOmYtKtAGSZLPI88Y+T2fFdg9mukbF
   g/rG+zYaoDeB3CdYmCLaJ6CqtaLARS7vMRnxp2AkTXB2p6b2mgIfOGt7Z
   NipXhui44xHNZKNLD9cVk9ECFb25mo1trgsqJqHYQhng5OMjvSld4PfYt
   w==;
IronPort-SDR: S+cyzh/y0SGHNDthN4hxMEmnN8Pv84MqAQ5vp3E2mHQPWpX61sbLSUT35V5/wGP0LPdSD+3wGO
 9g79k1d22XjS09RKdsCh/88HxLiMdfL1W3mKR74EmCtURq8IHUJ0xv4ffYHupjYByAw4vgLDjG
 1F6iTRZetzzoFRC0XvN2JxuntiQdeA4mXf9KDrutMXjvHUlru0xxZ67JgtyANlGUlMNT0Im47o
 /2aFx9nppRfgn74phVhzHkkA5BqRAewaQt8NQEPMitKyhWqlDVvk68X1w5b6jonvOLMhFuIF8d
 zok=
X-IronPort-AV: E=Sophos;i="5.79,400,1602518400"; 
   d="scan'208";a="159108070"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2021 18:23:48 +0800
IronPort-SDR: hy0xPrr//yKzH5cVv0AJM5HCGGE2tIerkx2Y4Kptf3zUvg48IrBNRd065qPA7OFdR0ftOlWgDF
 e6D8p1ohCEJxZUrncdLx9sl1M9rUOvIgEu0d1wbg8CAltUmNh1SQH9urg7gC1a/hG3xCiJVZT8
 zHZADZQ2zU8iByOeYYf2R1xaTMv7hW5d7CjEevX8RxwfB8ha7ivYGEWOrv/k8ZVf/hHt+OspHD
 Y2aeNhYoByAU2Z3C+p1UhyNNFyhVRSYSASldh7SvSvOX7z0LtoYuq+ieSiS3T6FrEYpK9BX1xa
 xC5FnOj6/RlVIxR65Rrzu5rV
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 02:05:51 -0800
IronPort-SDR: xqF0nxsKXrJ2Vp05nTQyeV2qkxvMvic4SXc8Ks1xBYq55zF9+/EpScD9yOOctExM6XyHWbvoSg
 HfGUUcSOKH4SY3YiDjPZzGoZ4Ehb/qDv02chqK0s2HiMrap1t8ZoYSBAv+ALgBLNIM1QcFUdGR
 fWcvrQwSnRgQ3vZqP3RzVCCE+66ImRYW8AhST8p8xjnkGKGwQKK+Mwct9plMXPwrWW2Ed4M7ic
 xDnPfbIbSBwLUbY42z2m1G+Z2OeFz2RGDTvrAD0cLI1Y3S0R/rwjBqO1AqtX5pJc+KL4nbnlBY
 iMU=
WDCIronportException: Internal
Received: from jfklab-fym3sg2.ad.shared (HELO naota-xeon.wdc.com) ([10.84.71.79])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Feb 2021 02:23:47 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Filipe Manana <fdmanana@gmail.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v15 38/42] btrfs: split alloc_log_tree()
Date:   Thu,  4 Feb 2021 19:22:17 +0900
Message-Id: <2bb9a7626f2f19b722f07a9a44c7d077cde5fd27.1612434091.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
References: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a preparation patch for the next patch. Split alloc_log_tree()
into two parts. The first one allocating the tree structure, remains in
alloc_log_tree() and the second part allocating the tree node, which is
moved into btrfs_alloc_log_tree_node().

Also export the latter part is to be used in the next patch.

Cc: Filipe Manana <fdmanana@gmail.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/disk-io.c | 33 +++++++++++++++++++++++++++------
 fs/btrfs/disk-io.h |  2 ++
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 6e16f556ed75..d2fa92526b3b 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1254,7 +1254,6 @@ static struct btrfs_root *alloc_log_tree(struct btrfs_trans_handle *trans,
 					 struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_root *root;
-	struct extent_buffer *leaf;
 
 	root = btrfs_alloc_root(fs_info, BTRFS_TREE_LOG_OBJECTID, GFP_NOFS);
 	if (!root)
@@ -1264,6 +1263,14 @@ static struct btrfs_root *alloc_log_tree(struct btrfs_trans_handle *trans,
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
@@ -1276,26 +1283,33 @@ static struct btrfs_root *alloc_log_tree(struct btrfs_trans_handle *trans,
 
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
@@ -1307,11 +1321,18 @@ int btrfs_add_log_tree(struct btrfs_trans_handle *trans,
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
2.30.0

