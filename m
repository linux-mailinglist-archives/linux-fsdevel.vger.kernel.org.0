Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0582F7363
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 08:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730972AbhAOHA4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 02:00:56 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41699 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730849AbhAOHA4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 02:00:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610694055; x=1642230055;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jRI20jlKCrFsFVWxCms2eubSZPqN4w0R3+WP+Nzk9No=;
  b=QGZIvRXQzaACrxHqEzQ9lfxDv06AN43AA8iUNgLMHtmzDFVm6IInQyTF
   VaQE/cFy3VMHB7N1eE9+wpkdUODkEZIjOZDAZnjdj0rVKaFbdi0+L0gl0
   Um6tP9g8p5lAiVkB5S2f+2PiAufL6FiW9kTDh1+LiDpWgl/qPFeASqDLc
   QNkgVNPR6LV3FkCbn3ucU/DgEtYzhG0p9/DqQc5HMwTreiuuLIQj16V4q
   cOU7DKt5muj5YP0J1KzYFQoLEzlnpT3NBHBguNppEwf0o43h8AoR1HC7N
   zX8zznySmcyOlzA2lSekGN+4LoP44Mfpf4bSZPFqRC+JtgJWV7qG4fGOy
   A==;
IronPort-SDR: CpAmhEIWiiM5yPE75joY0JX1Buke/dnGP2FFDKCQ+YcORLuMjJwrVLjkEhoNkfc0K2kmO5+Jn+
 Hr/vlGVPvloCs0STxKCB4pSoVO7HiYxcttSWyVjwt9r+MWYitRyzAEPNgqvhnaYVFV15sLRNEy
 2bz1zfKlHD8EAcsXVNSG/l2hMminZUmiFNWbjUKnrNo3/bW5LzJqvfGQ3j0SOBiFwQzNxp3YZG
 pEdIXwMHaii+8e1IcRmtn2heBYz/VtOFDK798awZSQLiF17N8Sda3e3cwOPkfTmUhvw0AGhuc/
 ZUk=
X-IronPort-AV: E=Sophos;i="5.79,348,1602518400"; 
   d="scan'208";a="161928323"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jan 2021 14:56:21 +0800
IronPort-SDR: 4wonu0zfEclVFVF5SZRkKSwefQuV7Ci/uIHRdIndX8Ali4+SBY+Bl8sGK8Say5pNhIDLM63pYs
 fuTm/km1PoNU5LfvGUKwr1R++9+jW2WlRCPuzxdm5r/0K+2067rwMSeKbnfzUKyek79cDQ1yqg
 hs3ntwJxI9WxGdVLEosI8tzDSK4sCmmYYh52wZBYzt4WjyxCaCuGs/Vz5yu6bK0bPqfoTQ6U6p
 JhnlXKA6g1BLPf5mWM8nQx9COznHtv14/6nqNteJHaw0LsW1k/+z1NWSJ5fC7h3zRYTftxpXOF
 AUNu4NOagqpm2Fd0bPqffkJH
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 22:41:03 -0800
IronPort-SDR: 3FjJSoC2lwrHJaD/n6fAHrhBy1Cg5sqEFekBoQmqJpOSrA1jG3wayCHEvxjMB1EB5QyZRZgR0X
 sCi1LShmZ6YcdvqtoDcXYL7acpVuKs82+opqlIBfwOk08IV66MoVQ77MWlKWIQMuOf7pZgn3jK
 f3Ih37bRfAdS939pqaE0gx9BuzUNmc2ljLB3NaHm7O6hZduItyUepz5c00yb3uqzRXE9LHHkZq
 3IHOSDpJ7DQz4cXYNqZMFuq3YAqIr4anJmX+EsKXNifhIdG1F0rKiTnuLFIPbzGU0PY31LymRq
 hts=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with SMTP; 14 Jan 2021 22:56:20 -0800
Received: (nullmailer pid 1916496 invoked by uid 1000);
        Fri, 15 Jan 2021 06:55:02 -0000
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v12 38/41] btrfs: split alloc_log_tree()
Date:   Fri, 15 Jan 2021 15:53:42 +0900
Message-Id: <55c972c153fbb041a0a0c1dda329da7d76e4432b.1610693037.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1610693036.git.naohiro.aota@wdc.com>
References: <cover.1610693036.git.naohiro.aota@wdc.com>
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
index efcf1a343732..dc0ddd097c6e 100644
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

