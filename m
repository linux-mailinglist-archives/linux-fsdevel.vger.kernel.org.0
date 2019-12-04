Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43E6B112486
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 09:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfLDIUY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 03:20:24 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:32819 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727501AbfLDIUX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:20:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1575447623; x=1606983623;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lnC8yzmKb8UpJR++C4z0jIqstzFWE9sHCk1QgPwlnlE=;
  b=XBRWEoZunR/O4S0bCZUC1NkK6c0lMcFPtqOJiJI+fKiEjX8F1zT491BC
   AEfp6N+9frDrEcx+mPcwdAd32bAjeaCoJxz4WuoZcY5XueibSKA/NS4Bq
   8ZDvFeaNefPNMb7WwuntKgEh3d2gCE0eWqNfO/I4thXEEK69Rx2cmQuMN
   ss8ubf4UxAnclesyyaFdCWd0i7bJAj19l4FErgh++TZt7k41SegY88CeY
   Gz573zcPdKX4msI/BiibLM86pjGIBNIOWHoI5gAf9ThsQmXVvWoyOEjGD
   QqqJNDQ9WuZyBCWtG44u+a1SDMClsvhX8aurHT2eeRzIe9Lbfu2Z9J2Ou
   A==;
IronPort-SDR: 2bvY+D97ly1YH3vyF8VQ9JDAIxuY//IJchSCYArCGVD/b0JdHT8/vFLmv9dnNBzPVgIsXpTBg6
 8DUHbDlMkC6ltXeO2aMC/UBZtM6X1y5yrQBQO3n3U7p8Q1OpbnZjvuW4C5AKowSy0Q/DevJSIv
 kQj+mmWNGOvN/j1NbGEVz2MZwHnqPBSqGwxSDEgGFEeRC0yvYn8NfyH9dgpb2P3Gs9U+N87lu+
 UoUysj1ByH80nE0Sgy/5NxlgvTyL+Hnvl0eB9+WxwkHbTiROqkjwhOAuS3Y4JfP236GvSSljbP
 M0I=
X-IronPort-AV: E=Sophos;i="5.69,276,1571673600"; 
   d="scan'208";a="125355126"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2019 16:20:23 +0800
IronPort-SDR: PkfhPht3ONvTrrmiHrGsvW9ImAAMwMUpeTrchQoijR5CGQqbWfgT9heLxoQ2bwonlnM2Sa6r6C
 ZQw3px/q2hFiyqtBQ/6ZfldLHAmzGC4jrITYRY7cE2UWueAd3qc24kdrORwh7/ocJ53R1hNbTI
 C0xRqfGL4sTFjpePSchTeLXyuXFqRCkmvnRE0U827NcKEYal4N294b27jXif2BvYGDEUmUXI0Z
 54927AadE/RHTfyLerlsmlSOk/Ca9FR3rZG6AJVLxyGwoNo/rHTv++VlwJYg2TSNA/fQ2r/kDK
 aVGbMQBTqtUvaNE+iR2DHRxh
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 00:14:48 -0800
IronPort-SDR: 6HoN3pF6kKlpbPJNffhtuS2XBtZrsMhhdGq5tkjCVQSjuBVhsg1taUf7n3PCR80bF0IrlPICgZ
 G6iRJze+4SNzKWc1qA3giSxbbN6vOyAyWA2kFeJXOmyxgEeW6pL3twdFR0jE7ZbWQjxrU82WFA
 6y4L/X/JZXvf/Mxi0cAfuWDPqkogw9Xxw/Z9r0MY9xd1Q1Gdc12pFThpov7oU2K8KtRdWXJem0
 fvueB4l7r6BK+81+TQMC0EzLrX6vSu5Au3nPNXEA8D3aBZsYPb4UBUgG7tjYTy7sMpU/8G7/iE
 /80=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Dec 2019 00:20:20 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v5 26/28] btrfs: split alloc_log_tree()
Date:   Wed,  4 Dec 2019 17:17:33 +0900
Message-Id: <20191204081735.852438-27-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204081735.852438-1-naohiro.aota@wdc.com>
References: <20191204081735.852438-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a preparation for the next patch. This commit split
alloc_log_tree() to allocating tree structure part (remains in
alloc_log_tree()) and allocating tree node part (moved in
btrfs_alloc_log_tree_node()). The latter part is also exported to be used
in the next patch.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/disk-io.c | 31 +++++++++++++++++++++++++------
 fs/btrfs/disk-io.h |  2 ++
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index c3d8fc10d11d..914c517d26b0 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1315,7 +1315,6 @@ static struct btrfs_root *alloc_log_tree(struct btrfs_trans_handle *trans,
 					 struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_root *root;
-	struct extent_buffer *leaf;
 
 	root = btrfs_alloc_root(fs_info, GFP_NOFS);
 	if (!root)
@@ -1327,6 +1326,14 @@ static struct btrfs_root *alloc_log_tree(struct btrfs_trans_handle *trans,
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
 	 * DON'T set REF_COWS for log trees
 	 *
@@ -1338,26 +1345,31 @@ static struct btrfs_root *alloc_log_tree(struct btrfs_trans_handle *trans,
 
 	leaf = btrfs_alloc_tree_block(trans, root, 0, BTRFS_TREE_LOG_OBJECTID,
 			NULL, 0, 0, 0);
-	if (IS_ERR(leaf)) {
-		kfree(root);
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
+	ret = btrfs_alloc_log_tree_node(trans, log_root);
+	if (ret) {
+		kfree(log_root);
+		return ret;
+	}
 	WARN_ON(fs_info->log_root_tree);
 	fs_info->log_root_tree = log_root;
 	return 0;
@@ -1369,11 +1381,18 @@ int btrfs_add_log_tree(struct btrfs_trans_handle *trans,
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_root *log_root;
 	struct btrfs_inode_item *inode_item;
+	int ret;
 
 	log_root = alloc_log_tree(trans, fs_info);
 	if (IS_ERR(log_root))
 		return PTR_ERR(log_root);
 
+	ret = btrfs_alloc_log_tree_node(trans, log_root);
+	if (ret) {
+		kfree(log_root);
+		return ret;
+	}
+
 	log_root->last_trans = trans->transid;
 	log_root->root_key.offset = root->root_key.objectid;
 
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 76f123ebb292..21e8d936c705 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -121,6 +121,8 @@ blk_status_t btrfs_wq_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 			extent_submit_bio_start_t *submit_bio_start);
 blk_status_t btrfs_submit_bio_done(void *private_data, struct bio *bio,
 			  int mirror_num);
+int btrfs_alloc_log_tree_node(struct btrfs_trans_handle *trans,
+			      struct btrfs_root *root);
 int btrfs_init_log_root_tree(struct btrfs_trans_handle *trans,
 			     struct btrfs_fs_info *fs_info);
 int btrfs_add_log_tree(struct btrfs_trans_handle *trans,
-- 
2.24.0

