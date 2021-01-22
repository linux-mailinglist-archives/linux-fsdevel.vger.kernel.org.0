Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2DBB2FFCD7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 07:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbhAVGbs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 01:31:48 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:51031 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbhAVGaW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 01:30:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611297022; x=1642833022;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4E4eQmbryp9+ccIW3vYSkkKzer1kPPbZykOhJlEGgJQ=;
  b=eDTnD5fNYeHfV6lbKjDKyHVcRUcyGEGDWNf32uZDN7zTPBXXntmIRgzH
   0n4+AbCXAyUgaL1oNLkyVBsURkMVBJt6ntLFX2q+aNKtgTxm9bVnKdiad
   ud5AWOyW0rU5GIB8FrcHV5cqqMQuOcff67d3JgC+xHCIYu0CWT9blKCqA
   /HqCtA51C7+Ca/r30sdrnVEHSNeniCHJUKrDdjc0P9qWZ2ETvN+SRclMO
   Jvg+XmJZh3LAgoDw36qfIpjvdXwYEt0HE7g6cyw/TPxz3N9UvPcecZPLD
   H0glII41hMuCgw/N4KKaOs7TS3DP1V1c5oZEif0VksAbVdVEOGvBKjwRP
   w==;
IronPort-SDR: eDRqazBn6G3HeFGj68goOj30gSbevsWvdUyoq72fgjW/5tGg+4h5rNvkVoKOYjhyMtMlfBzaCr
 klQHIvLb/UtU7EdXSN6uj7Gni/fQiUyWSCCJNTAal8ZfKCubvMWF4qBF2YLa7lpvwoHhueEhGe
 YrqgkkVbm8L+hPXCuriKxar3ayPTBCx15G+r8OtYAoEfUwmcuwSZPaKs5YVWku2hPlulVy7qbj
 RC/1UIw21AGPtlV9Jc+iK5Hwnj1benyYxkIeQ5jXAzJa5bljILb60O3xlTswHfNPokVbe+Fqrm
 aW0=
X-IronPort-AV: E=Sophos;i="5.79,365,1602518400"; 
   d="scan'208";a="268392109"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2021 14:23:31 +0800
IronPort-SDR: OHHiEv6pcE8ZELTLTGKjq7Y75GaonrVaWqZZLRpLq9y9zWs0nFNECrCak2nMXBVYheHLI6WRU6
 73CbHlc7WVcaBSEbGbFB4Br0Q72Ur9asAhZ/wcvAuXxrlfw9M06U4nG3Dg0ioeZL+bpD17xqEj
 vKqVWiVq8RerUarYfvqcTS2u0Fp8ku2sSi3yNN1bGXeFJ6GGMRUhunq5Zy3TuxUAGgiOchWRpn
 niivqx/IPxKnH0XdR6/P0DTIKw45f+B+Fqk+xDH4YRUsa0QsRpAKo9rnkTz5sNQgzVs6l6XrQi
 UOuQ5c/qwV24Dbl2SRLkpF7x
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 22:06:02 -0800
IronPort-SDR: tDGYIbakBpobWCYs/XeuPzEv5Obc5LXe3WiTbp8fqDs/HLdkZ4h6korm/XeLeglgAAok0FUG4/
 Ak4yY/W/wmCBSJol1oaWRhZfGqAi+BdbRDn/CMgjo4fX+am5oa1MEZ40AeYgxwxBZ71nbkNOm6
 JwPx4GvPNBxm5YokU9XHCJWjLnkCKVzNkMXZk1XJCnQA4Uqo1c9VJFzxds6PxeJdjG1HdD5lfB
 UGN4wVKA8KE53qQ1+oCViv11vsPI+JINXySWH7CF4FofLp7HllZnlaLqCpq8FYarYwiVTAPlpR
 b+4=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Jan 2021 22:23:29 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v13 42/42] btrfs: reorder log node allocation
Date:   Fri, 22 Jan 2021 15:21:42 +0900
Message-Id: <84e050d142732282ba7356fc06095e82fe5d3b72.1611295439.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611295439.git.naohiro.aota@wdc.com>
References: <cover.1611295439.git.naohiro.aota@wdc.com>
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
index c3b5cfe4d928..d2b30716de84 100644
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

