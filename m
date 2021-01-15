Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDF3D2F736C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 08:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730573AbhAOHB3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 02:01:29 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41680 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730242AbhAOHBW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 02:01:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610694081; x=1642230081;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=csLrrBm102qZuWi7D/pLp/YzsEOPSdkmDmkPCx5pep0=;
  b=mx7jRgYdmq9jzwstZyKQKa/U7pNNHKfi5ALcw1Nfoe/Lyzj9tQM7yuLY
   VImisj0m3itGLjLiO8zMw3LC+2dmt+y3SzZITb/iuXej9nVaYBoi8VOcU
   S72ikRwFbpEQW/ZR6qBG0aYSuxw9O5VSpgQQNPMle1BIzzA6QknJd+h6j
   g2+wBKjKekq+sIxIhe78XajBZ3VfoGKgpr/nHDrK5eyp7Ka0zxb2MCLXz
   troYAAKDn4PnDvsPIYJZ1V/1TgCP/uiTrUH+N8vkHohZz4cdAfijsAWvN
   aav32u9YO1TteCzk/HgmeGuhrmb+wq9jDZOIdbL+eohYIklBWhfVdh8Bm
   g==;
IronPort-SDR: 0U4N7+dTgMFXe6RnAa9LL1YliS+3V9Dz5e2aEqgx9BsIkM5VgjA8JNWPQkuSWiPrrYDKJ8Tcyt
 imgbJuBt301SDC7dfVrH17tew9IIMFX6KxtDyTAcw4M7PXKSsnxtAaNUUvtbfUeIYwtNqippcn
 B7QiKKRZJcmwPhzCMndvWFYQw8jiBPQ42/LPxDU1GKKJkf7Vaui5/QED/Mng6yRFFLbPzPdq6n
 yWWSu5b+QKfLnbHouo9K4onV9yBio/MA1zBPn+QyUCgV+DuT1sBLmUxRfrhB/46ZIu0xELdekx
 WtE=
X-IronPort-AV: E=Sophos;i="5.79,348,1602518400"; 
   d="scan'208";a="161928332"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jan 2021 14:56:27 +0800
IronPort-SDR: vqYf03/TOb5w/pmfOyfBil4T+Qxal3w7Z0npkwCs2ZPWoC7D/K0lzcyYxT4XY+FsTIsagyW/kE
 CVZJ8hVgp+H8F2QepHQ0Pprg6NxAPweJVzmDPf+TBf9UQCxFMap7zOLDK7mp5przhOg6iaGtdy
 iAO6OdXZMdJqs319MsfP+H895WD1ozowBpAvlvpr7Nq7Q6HCGzZKq7Hh3ao7dz96I7kV2ir6ZV
 K8V/5Ho53IF9mQcgrKKTfr6H+bufvkLtmAo58S6m3Zqkwp/G34hN6ICTZXE7s2rThiQqz4MR4w
 jOM1wD0Joqe91ZfulopxuosG
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 22:41:09 -0800
IronPort-SDR: zFsbnVfml/IZovoWvEj385HiMenjtojOf4stmxLN/SV3DNmZh1WZG5OP48nu9oBlxI7T1ltz55
 JivfmctVVWz2EsCp1OnIsSHLgGf+7dFM8A/ZpRtqsUQNOUJsK1e14QFutnSjjPrzm+9+/xTWjf
 QzqLIAKZBVF4yoSSAjUl8eLmCe9YvH9sHqYJ86wzxeMmO39xy0cyX/HKwkd6u8ibPIYVZSyKTq
 lq70pS8Q90iF0M2dOPIObks4mgp1FN0vi95DTzPhZH32ozTeWVdtLZJKhjqd7AdVx9JdO3xdWC
 vMs=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with SMTP; 14 Jan 2021 22:56:26 -0800
Received: (nullmailer pid 1916502 invoked by uid 1000);
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
Subject: [PATCH v12 41/41] btrfs: reorder log node allocation
Date:   Fri, 15 Jan 2021 15:53:45 +0900
Message-Id: <2bec51e7fed71bf3b386360686b8bd25b1c81e62.1610693037.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1610693036.git.naohiro.aota@wdc.com>
References: <cover.1610693036.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the 3/3 patch to enable tree-log on ZONED mode.

The allocation order of nodes of "fs_info->log_root_tree" and nodes of
"root->log_root" is not the same as the writing order of them. So, the
writing causes unaligned write errors.

This patch reorders the allocation of them by delaying allocation of the
root node of "fs_info->log_root_tree," so that the node buffers can go out
sequentially to devices.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/disk-io.c  |  7 -------
 fs/btrfs/tree-log.c | 24 ++++++++++++++++++------
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 12c23cb410fd..0b403affa59c 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1241,18 +1241,11 @@ int btrfs_init_log_root_tree(struct btrfs_trans_handle *trans,
 			     struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_root *log_root;
-	int ret;
 
 	log_root = alloc_log_tree(trans, fs_info);
 	if (IS_ERR(log_root))
 		return PTR_ERR(log_root);
 
-	ret = btrfs_alloc_log_tree_node(trans, log_root);
-	if (ret) {
-		btrfs_put_root(log_root);
-		return ret;
-	}
-
 	WARN_ON(fs_info->log_root_tree);
 	fs_info->log_root_tree = log_root;
 	return 0;
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 71a1c0b5bc26..d8315363dc1e 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3159,6 +3159,16 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
 	list_add_tail(&root_log_ctx.list, &log_root_tree->log_ctxs[index2]);
 	root_log_ctx.log_transid = log_root_tree->log_transid;
 
+	mutex_lock(&fs_info->tree_log_mutex);
+	if (!log_root_tree->node) {
+		ret = btrfs_alloc_log_tree_node(trans, log_root_tree);
+		if (ret) {
+			mutex_unlock(&fs_info->tree_log_mutex);
+			goto out;
+		}
+	}
+	mutex_unlock(&fs_info->tree_log_mutex);
+
 	/*
 	 * Now we are safe to update the log_root_tree because we're under the
 	 * log_mutex, and we're a current writer so we're holding the commit
@@ -3317,12 +3327,14 @@ static void free_log_tree(struct btrfs_trans_handle *trans,
 		.process_func = process_one_buffer
 	};
 
-	ret = walk_log_tree(trans, log, &wc);
-	if (ret) {
-		if (trans)
-			btrfs_abort_transaction(trans, ret);
-		else
-			btrfs_handle_fs_error(log->fs_info, ret, NULL);
+	if (log->node) {
+		ret = walk_log_tree(trans, log, &wc);
+		if (ret) {
+			if (trans)
+				btrfs_abort_transaction(trans, ret);
+			else
+				btrfs_handle_fs_error(log->fs_info, ret, NULL);
+		}
 	}
 
 	clear_extent_bits(&log->dirty_log_pages, 0, (u64)-1,
-- 
2.27.0

