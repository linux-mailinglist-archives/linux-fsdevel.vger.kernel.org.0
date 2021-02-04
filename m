Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A796C30F0F1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 11:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235608AbhBDKd1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 05:33:27 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:54215 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235470AbhBDKcc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:32:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612434751; x=1643970751;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x8SsAgvEZZFtSaxoJ+hvfgVR7BtrE4xDJTuYeqHp3AQ=;
  b=GLpFzu4VS7GRnHeRwfc3mrfcl2FzzHJ51ANVMGYNVXJhgcAmnj0uLZiq
   cLuqCM1WxXCyP7iTuVPnbXFnkDjTcyNcfyinVIR+6A0QUv7ObI8oONLwX
   S0I4CP1IRCvHG5dxYPnAzD9oT16eYWYbPSHUvP4anA9PZqEMgc6TcS8Zs
   zWMNLB46+4SUEOhQUJ5HOBcIbmqrJuSKOfsuWrSZKlsrOPbpl4EyNomz6
   nl5QqXlMi83flmeR7iKSXs+szutC+0VYye4PNqpy0t7sL1deo67zzT8pu
   c9b/NyzinWugnsxII8l+d6HsvCHJvn86ygs3pVfGQhoquKHgOOo3cY00P
   Q==;
IronPort-SDR: sHfPkhX67DRxZSPWXGNi6lAirudL4YRgNdemo1b1bLQIni+DXAmiO14Yqgzdr5W09u3jhQybsu
 v1KtGrDZC/SVjN9jDq1OQN8NE74wi41LjxAXqqtfbJywlJ3hOXKIPBdaSH/duwOVpCsjRWEqTo
 SFxEQ47hgFmyMRYRChpxfofv5ldF34XS14gEVQeTdedKq6eppuwg/HJ4z9bkzmE6Zex4oNbK9z
 Ef23Tm625WS5F759yuQVNPW99Ls0JC8fSfhFhBgxMeLOx8DP//yIFHVBc2JW7zMbGepRSbbqpV
 FA4=
X-IronPort-AV: E=Sophos;i="5.79,400,1602518400"; 
   d="scan'208";a="159108080"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2021 18:23:53 +0800
IronPort-SDR: r3ODROCgNwjXd1PH+51+zytJfZ6e1xbOSn/briII7Xqir91jiZ2dg94Jr993Teg5OiKiF7/z5x
 zZSI82jSIg0Jbw4MKL2KFF58BJKV3MpqQwaUci4MMSKoLDXqdD9KU8QrZ6wJGsbLKenKCKeAsI
 GUSmXRN0dYmFC/+XMwALwML5nqaElAi+8gqR0EC+F/d2EGZsonp3yKAAM9ZiOiiSrscXZCnMYA
 3MqlsqgQ7ZUALXdQH+u2SlVPYiwNrXcMfihhLC4haldN/5Ff9elTCzUvfV/PVel55Noe0OoHQ3
 LhMxRaQ9D4uvJ2aAvGrZKIp/
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 02:05:56 -0800
IronPort-SDR: QYc4lxBqemlvzRNbJ9FIFlVqBhgZJopvapNLSI/873G/a6DuIMIUXfvDf/trZOI61QtKCtq1Eb
 6iRT7uf4L6mUGbNdMew4D+88grNcnmrAr8PEL9O46L2hbS/pQmATNaJCsMtxF3P9GBMmjOSobm
 Q5YGmILrpQ82XpoPfyQNOewKLysthsbhNMCLlFSQ66GWDPedouyn/3OqE3fdYLkOZD83QOh3hU
 HWnc8Onsyvsd4fLCOOTFIaPlEmP77IQtaQvBVs/eqnnP70HJE5IXYVq9njUlaNDj2gMNa95Fda
 e/8=
WDCIronportException: Internal
Received: from jfklab-fym3sg2.ad.shared (HELO naota-xeon.wdc.com) ([10.84.71.79])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Feb 2021 02:23:51 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Filipe Manana <fdmanana@gmail.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v15 41/42] btrfs: zoned: reorder log node allocation on zoned filesystem
Date:   Thu,  4 Feb 2021 19:22:20 +0900
Message-Id: <492da9326ecb5f888e76117983603bb502b7b589.1612434091.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
References: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the 3/3 patch to enable tree-log on zoned filesystems.

The allocation order of nodes of "fs_info->log_root_tree" and nodes of
"root->log_root" is not the same as the writing order of them. So, the
writing causes unaligned write errors.

Reorder the allocation of them by delaying allocation of the root node of
"fs_info->log_root_tree," so that the node buffers can go out sequentially
to devices.

Cc: Filipe Manana <fdmanana@gmail.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/disk-io.c  | 12 +++++++-----
 fs/btrfs/tree-log.c | 27 +++++++++++++++++++++------
 2 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 84c6650d5ef7..c2576c5fe62e 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1298,16 +1298,18 @@ int btrfs_init_log_root_tree(struct btrfs_trans_handle *trans,
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
+	if (!btrfs_is_zoned(fs_info)) {
+		int ret = btrfs_alloc_log_tree_node(trans, log_root);
+
+		if (ret) {
+			btrfs_put_root(log_root);
+			return ret;
+		}
 	}
 
 	WARN_ON(fs_info->log_root_tree);
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 8be3164d4c5d..7ba044bfa9b1 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3159,6 +3159,19 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
 	list_add_tail(&root_log_ctx.list, &log_root_tree->log_ctxs[index2]);
 	root_log_ctx.log_transid = log_root_tree->log_transid;
 
+	if (btrfs_is_zoned(fs_info)) {
+		mutex_lock(&fs_info->tree_log_mutex);
+		if (!log_root_tree->node) {
+			ret = btrfs_alloc_log_tree_node(trans, log_root_tree);
+			if (ret) {
+				mutex_unlock(&fs_info->tree_log_mutex);
+				mutex_unlock(&log_root_tree->log_mutex);
+				goto out;
+			}
+		}
+		mutex_unlock(&fs_info->tree_log_mutex);
+	}
+
 	/*
 	 * Now we are safe to update the log_root_tree because we're under the
 	 * log_mutex, and we're a current writer so we're holding the commit
@@ -3317,12 +3330,14 @@ static void free_log_tree(struct btrfs_trans_handle *trans,
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
2.30.0

