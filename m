Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6934830F08A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 11:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235432AbhBDKYw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 05:24:52 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:54215 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234873AbhBDKYn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:24:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612434282; x=1643970282;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aX25ISm2mENeBvL+nhAQbvr1BG8yMXwYbvgZNdffXxQ=;
  b=NG8M1hl5tNFWTjePgWCbaoeRa/2Zy6NLjUgHX/sT4iw+0foleM2IhnKE
   K3OcHW+I6suNMOf1m5xPd/keFfVvy5DhmOzlNZmGEB4T3Iy9WfwHADXdG
   4rkIyw0ruKpMs+zEwqLYH2L4VMM5V/1fcEiLUad4hSf9qL7xrpXugCwgh
   n375CnbbmguDVcaI0WyXoXWnzwOK7a8AOktWzrC2BWKWL7RNq0Wv7Rt0E
   15rmDlf7+fl/43Q9FvzIi3nxYS4MO7tBrpygTaAuiTOYhICNz7xF4jSN8
   SpVG+nAL+Xy2d7b93wzOL1Lq3wI89OcuyTszHy4ZS0YvRKwviuYKS77cx
   g==;
IronPort-SDR: lQnE7O+XzLdZQjmgJI7WseIYhz3QBZh+jcBoJGazUT5Dk0CF/LItgoz6wi239nB8Y9ioJyeNnq
 je6NCGERW6KbRgwQOlv11+tArpO/1J3cdy0A5lo6Is8pnb41AzBJmi/uwcIilVgNe+zKvLlevb
 oSXYab+TV4RsAVGnIk0HNWJGodFcz0eNv7YD4WQF0mgGloXRqvCAknElJ8+PcYkayy5MKDB/yM
 Llloo0lTcRPpDXbjBIj9lG3MaGEEh1/QMTYgX4peNHytUICgD/uJTat41uXjMSaoV6Ik0cXfVK
 6sU=
X-IronPort-AV: E=Sophos;i="5.79,400,1602518400"; 
   d="scan'208";a="159107955"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2021 18:23:01 +0800
IronPort-SDR: okFE1leWb6OfgVCFB1GjuGWYiT4/lv0LXMF0BKTMrudi03u3bLBJz7a4ugr3qg9UmHSb7Hwox0
 FsFqz/bLa/Da1CQWJlGppTp75Bq/++ZcCt0v+E/gRDgT67RTNTBfDT9zq4Tz5/FfzARpFP0Dnm
 ikwq+Gr7p2qpj84YSYG2mK8SeOSh/RWOdz4LirDYt7vpEAyu8RjuIpnZmBCmw2XisWFpA7iX/H
 Gq0fSJbGoWxTprZX1pF/Hkq28RFcSYRcBqPbJJ3dwGsCUZSxds0srE6pK3k8zoKEfD6wb292fh
 vBUevP2Fx+WneNQgBd8goR+n
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 02:05:05 -0800
IronPort-SDR: hCyeLxDs43q5kz1q2dPIt39fx0an8FuSoLoIsMnyiiNYz6YGT1zUesFHb82Muwm1WV5v0Ad3Lk
 V60Zmvd5mIq8/UNN1t41PRkXLrhoNDyl4W+3moq7HRDTpaKsc2JZULhrQZxAMfEq/J7uCnwas8
 RxECLAtgUUlUNB2pEn0+Eg6w3tu37dSXY5Q/zc2mVEZrUuSSBHk0t8FGyHW9Lj0y+vaoHjXjvj
 sVYQ+sPyPuxoTqfawOHfZ4FR6aakj+zP2XY1hMi05F/wIEHK3x91YM0quxKs3SmMnz8z6e/jNQ
 VPs=
WDCIronportException: Internal
Received: from jfklab-fym3sg2.ad.shared (HELO naota-xeon.wdc.com) ([10.84.71.79])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Feb 2021 02:23:00 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Anand Jain <anand.jain@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v15 05/42] btrfs: release path before calling to btrfs_load_block_group_zone_info
Date:   Thu,  4 Feb 2021 19:21:44 +0900
Message-Id: <fccc7a9f182639b7610430ce98f28430f3b2a818.1612434091.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
References: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Since we have no write pointer in conventional zones, we cannot
determine the allocation offset from it. Instead, we set the allocation
offset after the highest addressed extent. This is done by reading the
extent tree in btrfs_load_block_group_zone_info().

However, this function is called from btrfs_read_block_groups(), so the
read lock for the tree node could be recursively taken.

To avoid this unsafe locking scenario, release the path before reading
the extent tree to get the allocation offset.

Reviewed-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/block-group.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 5fa6b3d540f4..b8fbee70a897 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1810,24 +1810,8 @@ static int check_chunk_block_group_mappings(struct btrfs_fs_info *fs_info)
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
@@ -1842,7 +1826,9 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 	if (!cache)
 		return -ENOMEM;
 
-	read_block_group_item(cache, path, key);
+	cache->length = key->offset;
+	cache->used = btrfs_stack_block_group_used(bgi);
+	cache->flags = btrfs_stack_block_group_flags(bgi);
 
 	set_free_space_tree_thresholds(cache);
 
@@ -2001,19 +1987,29 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
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
+		read_extent_buffer(leaf, &bgi, btrfs_item_ptr_offset(leaf, slot),
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
2.30.0

