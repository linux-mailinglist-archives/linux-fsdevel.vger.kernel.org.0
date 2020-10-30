Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE5DF2A070C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 14:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgJ3Nxk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 09:53:40 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:22003 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgJ3NxM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 09:53:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604065992; x=1635601992;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5Q87+JRgb7O8K8EiTKwhnGcUdvotKiuemZXbkPqubuM=;
  b=IZ3nXBd/iJ+ELySLw6q0A4RjnH/ahMOxCZdAgveVFJKaEpLLYl+W6XoT
   oT5OkMpHkAsZBESDycnFT3Ts6+du1TFv/FfjCaEKXXuFN5H3aOSEGWio4
   DcSZ1iAdKgMu52agiTC1nsyyTxAoTzg+xZff1rjVtE5jlRrDJ+rJWCgvF
   CMak6asNApzKSPjKmvVrRNJB7x75Pl84bg4wKHAiaMijyAPraMqXsOAj4
   jPhORODMdvXUvJ0FTwLmHehtjzndIecGIfSdxMV6JqZHjKWZDNn06nF/K
   BsfRobblKsFBNV9TKkDnAFxHQMnm9AmGoUqM+BC1qOrCkktSxC3/zKhez
   g==;
IronPort-SDR: dnOgLBfVWVB+Vs0gPs6jQrVrlgME06AtMoNEHnSK3sSAX7cA8I+1/H0/vGQ74unDqpGLMl5SG9
 AXevCuidreHpbYVUBEx5i2jAzXyG8k9PsFjMVrLEg5ibRsInrmgGJQZRAD55MCu0E4RmydOiyT
 wN9PoQzDkilaVHrs6eqCXtWUYLqbwc6+f071yZRkO/keycI9+YEDciBBpQSFnz/3/NUrW9BXJo
 M+xhyxXo4G10LX/RsHTGWSe99lJIJ951tG4zuBAlIf7Tz+k6lx/N59A8rGKFjum20pldK4HqWO
 ZHQ=
X-IronPort-AV: E=Sophos;i="5.77,433,1596470400"; 
   d="scan'208";a="155806643"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2020 21:53:06 +0800
IronPort-SDR: UWnc/G0JCkzoeLaYDtQ6z9jfmoim/rM2Yi51YCpszOtuk+Fv+iTdCkwSPYjCmXNyRBnjKi7SMl
 W5IwGYYHv6+px2ShhRGaXr9jUvHn/Jndzka8iepdgFR6IH5J9J/z2SRvGDQI547FIWjxlsZNsI
 MtCcGEdXTMu0qRFpSdfGxmDVyRqSLgXYuGW94TFOt2JwTD3Tvk0y1zPijjbLKO7x1K6GdDbofh
 ZVjm9RMmf0C70qyuLXksd/yHVTfVmyh+TOET3MTJWFo4CsjsgkxjigSv/76rE9uD7lMtvyjCIY
 0OH+6xvyojNkvX5FSB9iUnYv
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 06:39:20 -0700
IronPort-SDR: JLR7TQK/6qMD4c5ookN/Mibg70pCFS7wdJ/AEGf1hTv59p6JGm6L5DOHAz3C87Ti+iDPfWWx1e
 753kOXUMf5s0G3Jd9taktFl+sETjW4/SkkCzWUhOm4yZ3tFaftkua3lB+Fo1Mv89EpN6jcZURG
 FnJ6e05+aG2Mo1423bQfhZQQZ0Do9Bd8ndBBlLWfSf1n5vtiYRqlRAn6ZqRutra/wlg0WzBgiE
 xS9NhLoirTB5fah9rLlV8ymv2OqEaE8RR1RtkqggwKeM+SX9/B3K1H1MrkC2AJdUH7f0Xa+soO
 t6M=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Oct 2020 06:53:05 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v9 37/41] btrfs: split alloc_log_tree()
Date:   Fri, 30 Oct 2020 22:51:44 +0900
Message-Id: <71b8f94034f04da6f69f1ea0720825aabc852a54.1604065695.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
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

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/disk-io.c | 31 +++++++++++++++++++++++++------
 fs/btrfs/disk-io.h |  2 ++
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 2b30ef8a7034..70885f3d3321 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1211,7 +1211,6 @@ static struct btrfs_root *alloc_log_tree(struct btrfs_trans_handle *trans,
 					 struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_root *root;
-	struct extent_buffer *leaf;
 
 	root = btrfs_alloc_root(fs_info, BTRFS_TREE_LOG_OBJECTID, GFP_NOFS);
 	if (!root)
@@ -1221,6 +1220,14 @@ static struct btrfs_root *alloc_log_tree(struct btrfs_trans_handle *trans,
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
@@ -1233,26 +1240,31 @@ static struct btrfs_root *alloc_log_tree(struct btrfs_trans_handle *trans,
 
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
+	ret = btrfs_alloc_log_tree_node(trans, log_root);
+	if (ret) {
+		kfree(log_root);
+		return ret;
+	}
 	WARN_ON(fs_info->log_root_tree);
 	fs_info->log_root_tree = log_root;
 	return 0;
@@ -1264,11 +1276,18 @@ int btrfs_add_log_tree(struct btrfs_trans_handle *trans,
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
index fee69ced58b4..b82ae3711c42 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -115,6 +115,8 @@ blk_status_t btrfs_wq_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
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

