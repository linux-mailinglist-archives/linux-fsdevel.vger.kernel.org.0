Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFFD82E0530
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 04:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgLVD4P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 22:56:15 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:46382 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgLVD4P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 22:56:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1608609374; x=1640145374;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CpO3uWrOCuwnRCof5DeE8EOqszaN2mESlFAcrCxQTZw=;
  b=Kso2wPEF2xh9mSUq66v9bHLWAFgECynxD8nM4lGKv5z5HBjqV7eASfwY
   YAa8Nr6Nz+HezL4VKG6qSwWHNB3ZkWuVo30q5f24mapn0z5Twjc79uNhS
   XuXdR2zdkxH6juAoCjGOXg8ICtorOjD1EEwbPbO9jNzt4fIAH2pzGQgFg
   SgCV7yZUNYSUWuyql929QE9rVWrEx0EfmYw822yqR/vo9udaT19EgBHuM
   PAb4y5BqZ6CGeD98vQ/dv+IDki7cCFW3GC3CCbUxVK0E0KKSNrwogHsaE
   6ofEqmN6ai5NBzEh0CSxbUvoHkaEEofDaNmuOHVBK9mKXRXIfWLujYuRl
   Q==;
IronPort-SDR: 7dCuQKUJUuuxeb8HBJ42+k31QwDEbd4IS4XDI34N7lYZOHCB9Qe3Q0s9exEonfJ6mLJQJ03/ik
 T7+JwfgeHVLnT6SxZVrvUGZw5gwKgikHdvDYWjU8yWNV0M0ZyqGLMsIsyx8l6R0KrlzA9mkoxg
 HhFOgVCXN5XttziXoFE4uUdi1n6Zcoe1r9n4rydW6m6WdYxfvLy3NrXWLIm0qNV7BMRWFnxoJl
 RjKhEx7np2sBviWht/6Wqm63Aea8lLXggqE6Kor1o6EG3RVf0b4+D9rBo9ST34GQwT9Xp6a5i9
 ecU=
X-IronPort-AV: E=Sophos;i="5.78,438,1599494400"; 
   d="scan'208";a="160193910"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Dec 2020 11:51:29 +0800
IronPort-SDR: vTsGHhRMu2oze+etzUJ9aPdy1R8VWZI7hfhnD7QW+tJ57B24btFv/Ts+jxJrWX4hk8y1m0WwOx
 x8Ym8RbCp/jVXVOCZYf6ARVrDm7yi/A2+pdJDcScsbzohOvi3wJYVsbtQoMqm6xCSnqO5oSKSR
 1C/cMggJpoV1asbYb/aFWV7S7byHKyC2jMPr+NaR5lr2YQgvTj6FJktXrmCAqjBA2IQLhpzZCp
 gFrXrLSBbsFrsyTIUUUVkJ8u7EuzDM/U8ghNjC/d80QSdPuMZA9fQkdKtYO0tagpxRhD6tZQH4
 XdsKUkTzyH0xH3+FPYt0FDIP
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 19:36:40 -0800
IronPort-SDR: w14eSHPGdWO13CozOGfaVimijjvjBSy7x8EJ/7uLMS5C24yvydn8ZGRYtuOw4XIwIQ4OdX0ZWz
 onHEryPi8pV7m5Y/mv4nh7GyVN93Cm9xF5ZILLAh+sISPP2STCp4PS58uECumHG8ueB5nFSTfU
 eXWwmB3+0B1ZXB8PEOmZCWHyKWlhQ3mXDFXzbtY8P3BY4RT/oMfnkdKqdEf9izRDUU4b/a5FU0
 4jOtr5aXg9atexVa3qxTUsr98y8SCvAElfNvS17yNhBVsE8hN/LcrqSyetHETSHpnNmFdgWCen
 SAE=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Dec 2020 19:51:28 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v11 40/40] btrfs: reorder log node allocation
Date:   Tue, 22 Dec 2020 12:49:33 +0900
Message-Id: <f2209986991a93ff6d5a7979a1c7690e32882a5c.1608608848.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
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
index d269c9ea8706..8f917cb91151 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3157,6 +3157,16 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
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
@@ -3315,12 +3325,14 @@ static void free_log_tree(struct btrfs_trans_handle *trans,
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

