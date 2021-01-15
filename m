Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11DB82F7319
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 07:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbhAOG5H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 01:57:07 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41718 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbhAOG5H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 01:57:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610693826; x=1642229826;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TKpueyymWk3GGVnIta9p83tW6I0bSf3tAuzYPlV4XHE=;
  b=eZkT+u7C92Nmuuyp9QT6VYRSYJzKC6fc5E91ew3OTvtYyJIlG94DpPKR
   vIUM55sEztw0Wj0ICvpd3qGis2klrv+eILd31yZqx4qRX9TMn+G/1qsqU
   cN0LjusEQViDObRrHWWVEZe4xENIxyDhTYIjF9HVb3WjWlgu6gb7T7yVI
   vMNGY9nf+zVvUMLGY1pamshuXKQfCMbESrkudKJuK6HEqlyvjwkap3nkv
   L/uBKZTOtvAYHOZ9P3APCozTcz8zhehfIMowPLEmPKhfHgrcC+S2OvcDt
   w0nB+BrfFeQWDnCti3PBGlUX1HnxtmR0GI2iKk+xBQefrQfRBvyDLF7qT
   Q==;
IronPort-SDR: pooufi3pPy429PXLPJzwQqMgmOBVPGbsh06PJ033v5RAQOppUOANHj94srDMdEAtNnraSH53T2
 qWJpVBj+9HtuNs72WhYTZoV9cpiEvKkQGnPfeG+4mROQfh4mRkB5LBOsRUWriPZzJcl0JMIiSL
 cWCupYgx8twqFGhtUPiU5WmxqSIPNmRTlFRizdjHBbAkr1r4B4luVZ8+LL9moXYHS+5LTAKmuf
 5RGd2psXwczofaN5BC1ZTrmsnl5fQGk0JfQA6vbGUf+lPzSnf2ahP94aBV8CRxW7b730oW8Say
 6rY=
X-IronPort-AV: E=Sophos;i="5.79,348,1602518400"; 
   d="scan'208";a="161928191"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jan 2021 14:55:13 +0800
IronPort-SDR: WXpmbJyp3nrdAapu/XDUQe1r1WINj0+CYoB86lLS/laz9/rFODCiF1RiQn7DenQExPVW9ukKES
 E438TAk1tKCEYo+LCp4h+gsLU+S2QZt1rABah4idj9FhOEImtwgYatS+fDO2PbsKLQbKKp1vVS
 i8tyo2hmDIHLGhegp3ve3Dj6biv9UVBPJ2pAwnftKboyP6C1zt1qKVI9EIgcSbAlc1jzZPUiAH
 +H7ZVnEd00XbYBeu8r6KcLoOHF8+/lqh6A3SU1insql64lWJicWUhTEafBOIxGirkL/AauiCwz
 688E1j/g1Foho0KgETruH4Nl
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 22:39:55 -0800
IronPort-SDR: 8t4B3Fws7sG3ACmlGVB2R2AmEe78lNqfWhodKT6E2M2vE+uNM/U1ofumceKgZnAjYRxcCYJJP1
 ZRJv71VOxFLGJSIyPBOvbNZBGwCB58q6B4D/4QS9HksQK2VVGLvuXYQ4SerJJ7YwguqK/XMQjD
 P/4h4d2gdy4mGtdZ/5Fj5bNcS7tuHVq60peaFmAX0a6BrsyvMoLW0vpYlLazfRxMcWI0/S3iXr
 hrxMY9p+Xd6HqPiXpHEYtnf1efrN/tcvMcIhV+0+D5dp4Hy3G1o75ZC3gNYTRam9JD359XmndY
 wr8=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with SMTP; 14 Jan 2021 22:55:12 -0800
Received: (nullmailer pid 1916428 invoked by uid 1000);
        Fri, 15 Jan 2021 06:55:02 -0000
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v12 05/41] btrfs: release path before calling into btrfs_load_block_group_zone_info
Date:   Fri, 15 Jan 2021 15:53:08 +0900
Message-Id: <0786a9782ec6306cddb0a2808116c3f95a88849b.1610693037.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1610693036.git.naohiro.aota@wdc.com>
References: <cover.1610693036.git.naohiro.aota@wdc.com>
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
---
 fs/btrfs/block-group.c | 39 ++++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index b8bbdd95743e..ff13f7554ee5 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1806,24 +1806,8 @@ static int check_chunk_block_group_mappings(struct btrfs_fs_info *fs_info)
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
@@ -1838,7 +1822,9 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 	if (!cache)
 		return -ENOMEM;
 
-	read_block_group_item(cache, path, key);
+	cache->length = key->offset;
+	cache->used = btrfs_stack_block_group_used(bgi);
+	cache->flags = btrfs_stack_block_group_flags(bgi);
 
 	set_free_space_tree_thresholds(cache);
 
@@ -1997,19 +1983,30 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
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
+		btrfs_release_path(path);
+
+		read_extent_buffer(leaf, &bgi,
+				   btrfs_item_ptr_offset(leaf, slot),
+				   sizeof(bgi));
+
+		btrfs_item_key_to_cpu(leaf, &key, slot);
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

