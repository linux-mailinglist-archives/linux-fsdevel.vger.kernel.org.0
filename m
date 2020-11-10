Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3314C2AD524
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 12:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732195AbgKJL3s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 06:29:48 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:12024 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732152AbgKJL3e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 06:29:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605007774; x=1636543774;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o6jKXgxzt9+2YdizC4VIrF+u5LglfzPnGXRDXk1bV4w=;
  b=akFMYeoGsDHgcgTIwegfGYAvaHEh1jeRN5oHGS5bVbEsbyU0lJNIOtlw
   VRVuD8Ouckmm07PHSZoemsQbmhDzZqAdXc4wuNJNyLVK2y9b8W6KwoogT
   pHRVclcmXkqU4jqmPqgFnegJbrr6wYa8sd6pkYazCvpMYRm71wc2Gs9AG
   P1/dwED3xH5orRn0UT32h7EC3Nu7M9GyxfTomPPG7FlC/A30Exp9tTDgi
   Zz+TYz2uam+QweAlVP8TgIViJ4iCLuA/xcNz20yeN7LIJKP3C2r6hphrO
   5S3kIrY0aMQ+7a2qTzdn3kuQQ7yTeiIaE7A0da0GMWbbSBYRAJ3hOMKES
   Q==;
IronPort-SDR: UE1V3bVFXTzv+htsqToFA4a9Xy/XsCh0AcMllIe/Eib15+EGA5zQWElslKyVbdjMDsJubPi8FP
 vdPbxZYzMHotZbqZbHhyEb9yS0soIEmtNxmHSHUJCBF2/KBpMMLtNZvKNKgnz3QIqxLO0qzysP
 K1q1MqAOGXSC24X42lYo+XL0n95ylms51demrNYcTfGWJfAbQZpN6D98NjC0gcYRazyKPXti4z
 YAtIqoDMOo4N9Yeh06Re8W8TpExnfWBCFfBvFciBS4Ga71qNu4F4rPasyIAyt5wW1nAQvbG3lg
 CgM=
X-IronPort-AV: E=Sophos;i="5.77,466,1596470400"; 
   d="scan'208";a="152376714"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 19:29:05 +0800
IronPort-SDR: Stfhn7VNMi5pZ3j7rAbYzUYKVqmikHnxunmx0uPu/SNtuaUspVNGiB/t1tuOTwQogxzJRCn6tJ
 sR9nURe/q3zQHiWlnA99CdpV2ZGOPBiAyWdjyMQQCZrSUxpk+NlfQ/C0Z0fG02r3x3ErnktXTi
 PZ9Z/hWeCcIvMB5RnqDOfazNcuEPfQMo9qJAXLZsQ9DEHpfMADyIdBkYkwRzOXr5Wy6gcIpo61
 mG/rSckdEUP04nzxWGzqERrlX0oRe1NF6Swm13A10vYMZQ7Z2or3CI2lOxhuNB45wULt7tFW0+
 OfIQC7HtiWVYivAXyPNrXpBh
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 03:15:06 -0800
IronPort-SDR: 2oeLZ2AbX0In4eFVHQb8MvUy7+KvtS/gNQuzSyyGr/fPhD7aR93XVuJVmeeKdZvyeH5XkI+7aA
 pWzQQeqUuMOZvEs3srH9I7FShhcmYiUoKRYcMjo956nVgmD9rTDPhOdoDefODPKtEy1Sw4LoNt
 MT6pSxMTJ7jMqzfTeImcqiMaalloL47x8e5T31n28xIwUlncs5XCz1QBZXSwXjxkmXOkSkDIVq
 jU/0W9QvCVNIJUboKxnwE97lYX82rk2qrKBbWrGYMWUgbhHtPia89ttifzJQxmtaoe6hMD44G2
 5Ak=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Nov 2020 03:29:04 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v10 37/41] btrfs: split alloc_log_tree()
Date:   Tue, 10 Nov 2020 20:26:40 +0900
Message-Id: <e55349ce9b5f093811925ae45239afd21daf184c.1605007037.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1605007036.git.naohiro.aota@wdc.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
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
 fs/btrfs/disk-io.c | 33 +++++++++++++++++++++++++++------
 fs/btrfs/disk-io.h |  2 ++
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 9490dbbbdb2a..97e3deb46cf1 100644
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
@@ -1233,26 +1240,33 @@ static struct btrfs_root *alloc_log_tree(struct btrfs_trans_handle *trans,
 
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
@@ -1264,11 +1278,18 @@ int btrfs_add_log_tree(struct btrfs_trans_handle *trans,
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

