Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4288F3034F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 06:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387659AbhAZFa1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:30:27 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:33036 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732410AbhAZCqV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:46:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611629181; x=1643165181;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4E4eQmbryp9+ccIW3vYSkkKzer1kPPbZykOhJlEGgJQ=;
  b=XiS4btePFbkXlz4bPkTjUQOVN5p4eLjMOIfSXKaXaGgLKXvuvUjL9cI9
   D7ZLYVtdu5tuymApu8eBuQF14zO8/MYjojJUluD00s8P1Zbmd6i9bNq7D
   WfP/36BkJuOZf9wGREG40uDCiTSMi5YhZKHEX1cbm20ygjjOYFXJ+EtEl
   M0RHO680dR1aNJTb5J0gdL0ASxRbtGGU3UsM/1x7IYdCdEqczi73SZ3Lo
   V6yR6xfpmOpqkzp8PKO1cX5VE4RrtWaJ7b53RCztU1IPcCRlcf+c36ji7
   Vosa/fYXNujlKiTAUSydbAjSNsxU9yp2cZQdZKqFHq33XuOGIOwQhf/a6
   A==;
IronPort-SDR: bIVPHBK6xcxb1zX7FyaYp+vYXNf25xHXAOinjU5qVcjHxVf/xULOnWjXW1sEt2Jp2nBDYG/K9y
 j59ORVsLod8J+qlI6IxPuw+HI0RzdFY0oevo9aYjhdB9fJHeQSSd8+dpGdTXqSetfVDfao1p0B
 MBhIE6dAWrRQmxkWjv5PPUjWfTGgYqXVFPZPmUswIq+YJVZMu6KH9pjKsQuVUVAvtlt4ZrqDJX
 IoGm6gm4qW5gsm9VNbgM0tr9kZ/tYvVm03+GykFUDzPtjfBbjxIheXjkXs4IM/b5G+6b4zQktw
 N6I=
X-IronPort-AV: E=Sophos;i="5.79,375,1602518400"; 
   d="scan'208";a="159483594"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2021 10:27:11 +0800
IronPort-SDR: Fy8xlq3uH8gAokt3yxlWxESoVaIeCkn+yIUKIE6trNZszINrW2o0j5ZW0AiAuYzM4l6Su2PJgr
 QeK2ew1FW1Bb21d5PQNoCAP5PwJET2/fvzyA4UKlwBeb4pyMSjxnBqs4sD/FjX5vWuGJQY/br/
 bVqKS4JuZu61TT8LXCYqSzBHP00OlAeyD6wr7xau2PjeGniL7cEuddeOy4Ayz+bsKDuiiUmrpb
 BAzsXKmSFk6Z0rkUhugbjg5iLFbhlLdHch5TCkoK+LZEvQCvVoFWooijHdC8ebU4yj5pJarrXC
 3aVCKgOjPhPighbL315cV4hA
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 18:11:38 -0800
IronPort-SDR: XnLxU7QF1GzciBQCA7PYmJv9mHN4Q/+eb6UcnXP9bKr7FZaIljn9N7KEmlqscaNlMkocJKJGWU
 wJj1y8qzsPxR0A8xs2UsPKcrkagE2gYwG7A/T88K0DoEuFnApDCzfB9+61ULys2E5kPIi0yEU9
 6IliH6wZVsWD/RYIceCP6ZvijOuLAkSRlRU0UDDQHRL1VU1PdHygOULP4woM1ykedwKuwZXO4P
 cNBz1KPXX3gJ2wrSFOV5VTX+oK4cBNj006lSo0mtvJGJdKGHaEUJ+o1Nl2RzxrmPvm7pQ/TEmU
 lCg=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Jan 2021 18:27:09 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v14 42/42] btrfs: reorder log node allocation
Date:   Tue, 26 Jan 2021 11:25:20 +0900
Message-Id: <246db67fcf56240127a252f09742684cd30f4cfe.1611627788.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611627788.git.naohiro.aota@wdc.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
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

