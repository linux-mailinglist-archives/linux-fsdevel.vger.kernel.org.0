Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35C4D11DD00
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 05:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732054AbfLMELh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 23:11:37 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:11924 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732042AbfLMELh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 23:11:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1576210297; x=1607746297;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lnC8yzmKb8UpJR++C4z0jIqstzFWE9sHCk1QgPwlnlE=;
  b=exucFoIUsyqVh+QVlbGj3xPfszPq3RQTFzSXBuEULt4Ihnod5gdylQZa
   QdeLyF32F5NGImSfHvFWjTCAa/jKh3SKTypyYC3/TI2jQoZE3uNOdhfyk
   wAH/INpftDt9MXQyDhbYbhcF66sDGhCz8G2vxw9AWwWlBIptaO6lYgmzt
   BPS3+jteb9cx5DRHj+K3peM978fnlw/AwqxTZJqJhuAWFeKOBXkean2EI
   9sZ5tA7YynjMnxz/wgcsKUBmYyYkbXirNMFx23jzT6dU+gNdAHdE2yQwu
   mH21coj37LuEXfo1dKZS3QvSa8Vqf+ZbVMDdK9j3uUVwEiNOHov88ZRRh
   w==;
IronPort-SDR: 1P9vufYCC5hSlKO2IJLvoQonuwFm18bupfoh6E20amyXUi1JpaLktQESSKXiW1aaNE7PM3tDY4
 Lk0VWPF5KVBDpkHB9hoVMfsCe2e7Fxg5TbxdzqnT2AhTx7FFrOE9qmpkv0oSNnsGSYizPGtUlc
 ets7W4CFZ9y5mW6P9iTS01X1DfTQfKrcbylUJE7RhGKZWHPHaLD/3YpBmldvlfaLh9K9qquQ0A
 jW1TdG2nRHud8olnFfdFvxC7L5xn5p6juCUrazhBn6xkxODpp845b52iGKOHIEQvOARlz4GEbU
 ZAE=
X-IronPort-AV: E=Sophos;i="5.69,308,1571673600"; 
   d="scan'208";a="126860177"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2019 12:11:37 +0800
IronPort-SDR: Qmw7lyZkBXOhSGE49DC5P1HCdBxZzZU1DPZAQHuQe0iAK9ndJ3VQVWhCGxtqPDsts3mnTknpgq
 BZDRARdqC3AlOq3TNC/5S0/qaDRZULLM9j3xK8hiJzj5vSC62aWVLu+Qro1kIld/xRGONvlzXB
 g9ODlCugG1RntrDUvtI5p0U+QXJf0GC7t6htrc1bY3JA60MBVn6A2y7bYpmKrQ4IvHEUBWMzS+
 ejX8xPqilUJIk1I4/Pmt7ztPIJc+9mZBEfKp4SXyZa8rD+se0mqXboZ9hFcoEC6NPmfucQaAPO
 wOsuFFFNqUX4YO+8mhRWo26N
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 20:06:09 -0800
IronPort-SDR: 3puJfwwzOCL/0daR3sqnXAqM9fg9c+80mSie9ceJK28nMoBAyBPdod+cnMxiT0+YoK8VpXt5rx
 q1ZGN1OGIUgXNpvM4/9rzANF0xcZAJQzvOjyMYnxu6hVCapLHACjlTDCKJtWBlm83aOYdK4uzZ
 cu429yKqgMkJ9royet4/LM5i2LWXTLiMBnaOXNZL70GnKVV8PIIqacNhGGG/1QbG0FPbxd1tcl
 589iwrMIp+Ud/YSZN6gjRTJ8TIKdIhMw7ARZ8KvYqwhNX9N+vqfguWyNZi+hbb/zuiyImWYjAU
 I3c=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 Dec 2019 20:11:35 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v6 26/28] btrfs: split alloc_log_tree()
Date:   Fri, 13 Dec 2019 13:09:13 +0900
Message-Id: <20191213040915.3502922-27-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191213040915.3502922-1-naohiro.aota@wdc.com>
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
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

