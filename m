Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1942E052A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 04:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgLVDz7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 22:55:59 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:46436 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgLVDz6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 22:55:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1608609358; x=1640145358;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bAerOpoWyJ4Z6ileXAdXXjiHOqmGj5NREdGkMvScpbg=;
  b=kefH29Fs+o1X8d1YW1o5VjfiAeFoePSU+VEPP6MFq9WhGHhe7dr97wEV
   NHgXjROW1TmtTbGtNOJiwAgRs59KExpQ5kv4pikqJtHLMp0PQCziOIvVA
   CCSxORXPLqx9w1pqUQE2YtePKTwCdJnW4Y6Gn7bbePCbvONLhREgd1bxE
   n0GqGX+az74fUd3hGBlEkVtVRLuC5a4LO55+qECPoS+RaqNFlnjSMHXdO
   JoauaYaj8hS9KmxHRJ6ATxD25fjS9h+uAuHBp4ZByAOLhK94gIAxGVpX9
   8wrFgHjDLnHYK8JGHTOl3XKZ0wrOvYer5Pnf/wPnVYU/ZShdTS3NtNBuf
   g==;
IronPort-SDR: P//FBOV2vjJZRvYRGs5GND2+iVetpJuP0trViG8gv9JOJ5Ilrcv6nRfJEN4v8IUdaNOSgfOiOx
 iC22KTaV/SAaNZiIZZ3O9356+xRvhGxolVvXJUXMMmT2BcVuCh8XxJNv60XF9SHQx586eO9tVm
 wulBNwkTvE5koeRQu+CQE/mtasXlcC4jctRmtJdXXjNZn5hALXQr96Rxov2+G7sKo+tvJxxxo5
 MCujWGJqkM1bqUO925OFxEm/yGXRua58uoBrscGBqey9ITeCPBtGMO5BZn7l2rtxQg2uHKmYWM
 aDs=
X-IronPort-AV: E=Sophos;i="5.78,438,1599494400"; 
   d="scan'208";a="160193875"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Dec 2020 11:51:24 +0800
IronPort-SDR: VdSnqwJKrt7pCJ9ul6cenqSTPzk9C9Ihvpafq9OGhep76xkUT011nYl3HMk7WLYpEP97KdUOaP
 rOV/PvyIyEI88/smm70sHkp3WSWQLRWLLiRRmgeNK5LcIdhM7+VQn5awCz6oVetAKr70iW37y9
 wd5Fhh3GxOHrYjvDl1crLTXgSPVjBw3uqgNYe9XKnh36soyW9OhetzXY8vHjC/4Cy0NypbnzCv
 Zis3/SavVYYVJ3UUMpOsooVR31dNcsw6fPGPp/QuxrOU1MWdPgzqSMJmRqQdvEcvM3V+WrYpcu
 hXgnqzvQs68o0KrTCDjIxbOj
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 19:36:35 -0800
IronPort-SDR: j2gjhs76+XVh9qhelyJMoeY6G+mUTAXIE4kwFSfnfWmNSsm9wLTQJNgd2NbaR2Q5RoCOLt+Pkt
 tSP4R2qvyL2lm3UYomeBw9Qy3GtNBgndQEvpqPWd30vNJGWHQ7nH+RGCQ+umm1q17c7IIk/0xb
 QrjXHPpMQN9cQDMknBxRdiiWhoyfs/NUT1pTRi+bCeR0cx6QopWv6cBfmPfqsKFyyfMFrmAmhy
 AJ9oMinq71cvaFw8FianTonRekGOMnVDC3CFcYEI7MMIbygsyhKr9OGFtpJn0SJZnXqKKY08iz
 dIE=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Dec 2020 19:51:23 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v11 37/40] btrfs: split alloc_log_tree()
Date:   Tue, 22 Dec 2020 12:49:30 +0900
Message-Id: <24e3b5fbc3897a7ab6881750a8ac28d70d91595d.1608608848.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
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

