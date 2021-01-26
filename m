Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE04304977
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 21:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732835AbhAZF15 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:27:57 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:38278 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731710AbhAZC2G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:28:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611628085; x=1643164085;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uqJc7j6oBZt9woy6vA4bYp+7GoqizOx2pcMwC5qjXG0=;
  b=PebN9baQhxfqxKm+0RGc241MU84MJu1vC7c1uS2gEUl/eaLUGDtwH/UX
   M8KiyMBflgRqWKTQOKRA7w3QxzHQbj7G7hqPK5Dh0NMSCwDTUqQWDgiqC
   75jcrFWoU4v8z5wwSZVaZVAF3i81BEOyQQbia1yzVqRCAl8rW4WtQI/zA
   c+rogQwt+DUmKafuwb15mzW/4z8emtVixQ2EmdEaAU/wouDR8KkLXg5Oi
   Nriqj2cimT5zy0ltkUMNfXGzi9RZ0M0tm8lwBE3riD2B0J8py5+F6+QGA
   F+IIFU7tJ1yQV6YVvofxAYztaggr8lEE12oqI8UcLgXRb4v12lOVy+s1E
   Q==;
IronPort-SDR: CWEbwP8nInw4dOQfp6X0vB16/35DTFJVkiYJandBlc2E2XuH1KYYkmCc1hLtARQ84Id35x4fOE
 HeuzTybe8Ixvt6Hi90Yn60RqxMQfXFnwFdbVmzlg7Yo/ZmBwlXNQjxg2WhzFFLelpGk3d0sxW8
 6ONsazBMbgzwh8+OeA3sGRODrxOE0m84WLDS8kBxZZkyhd6eZtssTvGoCazxCyWM7G+R22sX8y
 cYgB4IpF5TOGrufIekRZcjOr6cWvBrj2tNzCuyZsP8oRT+pZnaggyFJlyw6tya9MXt+iYI7IyN
 NAU=
X-IronPort-AV: E=Sophos;i="5.79,375,1602518400"; 
   d="scan'208";a="159483508"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2021 10:26:08 +0800
IronPort-SDR: IPNcbEX85NVJ7KX5QzqTf7vwcm0nI35ptyQVwjRRphiNmeR/xJiR4bYFBhvuApEMI4MQN+sv+e
 OU3bxFhpTq9Du0qmPa4M7p3HDPsA23wI0g7kCmEQhbrTi00N6WLR1ravir4bP+ijWDFMAQvH5c
 jD+ltcqKXg2eqeoxEYr0U0etbbTc2cqjq74sFCSWdR+F8t/KIGxDPXVPrHnbsZFYx3Edip8G5k
 RbgcNcWHQ2RATcTwtdfUOV6erBe49dJhnVO6MaUFa3wotdRUF+U1qhdIwHRZhxbbVAYaBjAXif
 7yfP+54OrVFmU/iIJnlrWUbV
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 18:10:34 -0800
IronPort-SDR: 858dfzxsVthZ3RJeur89u2hmLObh/+YUb9bjO7suOQvfpPGY1gtMyS4GpEghOp/ORrl0+tIDxd
 7K3byeQ27Q2RQQcY3UNnCrl1txnInsh80RWjAxNOAJn26EJAEOalowPqm45MSKY0qz41tnRqtr
 CvRDvS5lF9P2zmjs8W8stpmvs359s13AKbivjxbyLc7OcuRXaoWnX0EXiT20QSPyArYXyB+Oif
 CHgVhHXasYHUz8ETI7mt5YwHtH5AUDC54TGpgc0Pb4QGMma989yqTiw97MUW4AOIiPJ7y4tTSM
 Lcs=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Jan 2021 18:26:06 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v14 05/42] btrfs: release path before calling into btrfs_load_block_group_zone_info
Date:   Tue, 26 Jan 2021 11:24:43 +0900
Message-Id: <d931b0c588dda740d140a1d8e87eb5b138869fc5.1611627788.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611627788.git.naohiro.aota@wdc.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Since we have no write pointer in conventional zones, we cannot determine
the allocation offset from it. Instead, we set the allocation offset after
the highest addressed extent. This is done by reading the extent tree in
btrfs_load_block_group_zone_info().

However, this function is called from btrfs_read_block_groups(), so the
read lock for the tree node can recursively taken.

To avoid this unsafe locking scenario, release the path before reading the
extent tree to get the allocation offset.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 39 ++++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 763a3671b7af..bdd20af69dde 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1805,24 +1805,8 @@ static int check_chunk_block_group_mappings(struct btrfs_fs_info *fs_info)
 	return ret;
 }
 
-static void read_block_group_item(struct btrfs_block_group *cache,
-				 struct btrfs_path *path,
-				 const struct btrfs_key *key)
-{
-	struct extent_buffer *leaf = path->nodes[0];
-	struct btrfs_block_group_item bgi;
-	int slot = path->slots[0];
-
-	cache->length = key->offset;
-
-	read_extent_buffer(leaf, &bgi, btrfs_item_ptr_offset(leaf, slot),
-			   sizeof(bgi));
-	cache->used = btrfs_stack_block_group_used(&bgi);
-	cache->flags = btrfs_stack_block_group_flags(&bgi);
-}
-
 static int read_one_block_group(struct btrfs_fs_info *info,
-				struct btrfs_path *path,
+				struct btrfs_block_group_item *bgi,
 				const struct btrfs_key *key,
 				int need_clear)
 {
@@ -1837,7 +1821,9 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 	if (!cache)
 		return -ENOMEM;
 
-	read_block_group_item(cache, path, key);
+	cache->length = key->offset;
+	cache->used = btrfs_stack_block_group_used(bgi);
+	cache->flags = btrfs_stack_block_group_flags(bgi);
 
 	set_free_space_tree_thresholds(cache);
 
@@ -1996,19 +1982,30 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 		need_clear = 1;
 
 	while (1) {
+		struct btrfs_block_group_item bgi;
+		struct extent_buffer *leaf;
+		int slot;
+
 		ret = find_first_block_group(info, path, &key);
 		if (ret > 0)
 			break;
 		if (ret != 0)
 			goto error;
 
-		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
-		ret = read_one_block_group(info, path, &key, need_clear);
+		leaf = path->nodes[0];
+		slot = path->slots[0];
+
+		read_extent_buffer(leaf, &bgi,
+				   btrfs_item_ptr_offset(leaf, slot),
+				   sizeof(bgi));
+
+		btrfs_item_key_to_cpu(leaf, &key, slot);
+		btrfs_release_path(path);
+		ret = read_one_block_group(info, &bgi, &key, need_clear);
 		if (ret < 0)
 			goto error;
 		key.objectid += key.offset;
 		key.offset = 0;
-		btrfs_release_path(path);
 	}
 	btrfs_release_path(path);
 
-- 
2.27.0

