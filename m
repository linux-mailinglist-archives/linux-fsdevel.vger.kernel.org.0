Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB9782A0701
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 14:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgJ3Nx1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 09:53:27 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:22003 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbgJ3NxW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 09:53:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604066001; x=1635602001;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LPWEINL6u3NvTmMDpZCgBV2uMWMYSnwdj6ZztydhToc=;
  b=riHs8YNuT39EO3rVfCz2L8e453AabuWdySkpKq11ou/GJE+yHyes//Uc
   60Mgfkw4IB3ToEmWAXUEhEN7131K99J/uZJS4msyKQWrGhgpkBGVJ2wh8
   QxX2jrwbg9drXVL6MLCqCDxeSNbd2FRL1c5PI157cHu5q4YqDfO/9+m9g
   tL2YBeboZRGz/m5lIIjVudZsMvR4tqZ+EdPgi44nBEsdEQvOdqk/n/b4Y
   fgEmh6Tv4yeNLf2o/BBgZ4yJx/lp3Eg/HldVQY6t+KKRQdWmw8N+eOqDP
   0Kxtfo+cimZuKpAA1p7BTkAt3soTjTrtowUT4jU4M8CFb6VhNjFkNbcwn
   A==;
IronPort-SDR: 8MzuaK0Z1wCf76lmHX/AoJd1n3v0IXOnWosKVFq+szQjDj6AWwhBN7dleTlB/X/dYKvQgNWbSY
 26Ibo9razmjNLVzJrIJSFYizVcf4XgFqT9Qby3uVKucxXxpqITxO5Z5ZZrLjOckMfmE9q7ieMg
 eIeF9DrBjam8FDIAQe5Q9AVDpF5jtPqkJ8aG8tLbOtEFiVOTUE/k5U/NtUYO43hp2L2QRhD3o9
 Adyotp2ezUDYdH7GsSYqadJ06W/mfUUeTxgh4l679+AD/C/H86ifQxTPEljuN/qPM1VFHuu61S
 hIE=
X-IronPort-AV: E=Sophos;i="5.77,433,1596470400"; 
   d="scan'208";a="155806648"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2020 21:53:10 +0800
IronPort-SDR: uk+u5FHjr33GrMv3jY8XidiOq7DenHfu8Ach9dWkJ0B+Ngxgdmpq9r+pAzlsrv/nWKI1QcaKeh
 UTI9QvxW3EwohkE0RbyzhTEiSyGrL+j5PobDSLctV+aPFFCsmGjqN4SiUkE+a2B2Zm2Yr/uKwp
 SFs/JMJQLx1qRWs1vHgiYd9bDtVa8zqIs5Yq+IPX0VRJHIZ7f0/qBS1tjsFniw3xTDH+Gvix98
 h2mHFuo8e6hqpYrbqimDeYDxiXIcuK/43zkfsc2JCdWvn17qkwyQtaHZQ01GTPUh4yfphnZb1I
 MUVr8LVUG+HMo3fDLJAD1o9J
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 06:39:24 -0700
IronPort-SDR: SrAQhaShIz/dErxnrwPFjRuHxZw+CWnIcQX19wuQ730AKs9MctOYSt85zpEzQqop8Pls/1skdV
 JgPa6aNFUtdA6yLj1e6OK8+EEajl+6MeBFDaCfs6kxT6vKA8b2CMTRgx370izyN5MKIf0Lywyp
 JWWLMGJerPNOMJ6rbAN5B/mJE7Gbam5wxg3xaNnIbM2WT2vNq0kaiLWXx6zbv8o1fBuVpLU8dk
 mTHUiiRlnfVwssIS8fGY2msPQV/3pUXNYpeQdVPZ4IsfkAXn5Dm2Nu/Xq/rzgYM0BDX8hdGiIB
 upw=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Oct 2020 06:53:09 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v9 40/41] btrfs: reorder log node allocation
Date:   Fri, 30 Oct 2020 22:51:47 +0900
Message-Id: <ea3f5bdd11553b1ba3864f25c42d0943eb97b139.1604065695.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
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

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/disk-io.c  |  6 ------
 fs/btrfs/tree-log.c | 24 ++++++++++++++++++------
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 70885f3d3321..2c2fa5ebfef1 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1255,16 +1255,10 @@ int btrfs_init_log_root_tree(struct btrfs_trans_handle *trans,
 			     struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_root *log_root;
-	int ret;
 
 	log_root = alloc_log_tree(trans, fs_info);
 	if (IS_ERR(log_root))
 		return PTR_ERR(log_root);
-	ret = btrfs_alloc_log_tree_node(trans, log_root);
-	if (ret) {
-		kfree(log_root);
-		return ret;
-	}
 	WARN_ON(fs_info->log_root_tree);
 	fs_info->log_root_tree = log_root;
 	return 0;
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 826af2ff4740..46ff92a18474 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3140,6 +3140,16 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
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
@@ -3289,12 +3299,14 @@ static void free_log_tree(struct btrfs_trans_handle *trans,
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

