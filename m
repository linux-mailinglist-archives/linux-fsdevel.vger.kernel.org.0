Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64492A0724
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 14:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbgJ3NyK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 09:54:10 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:21997 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgJ3Nwq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 09:52:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604065966; x=1635601966;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0nnONIf1rKLzuRt0TujUb7eMvjS+U1x8FR+Ol0oIp2k=;
  b=pvxRN/wBB1d0UatsC7ukEwBnz8KB6uto8y7Q9shDQUNaPOK1/pUSXJ3l
   kc1EOXv2BvpoR6k9sHLO+0twzKOx9mbjzBCq7/MZ+ZdV1GaTKFuh8mbzi
   HVmPa2j2ExGDwGJ/GMLcAbulibWIqiuO9BhXF2lkGLa8Q/LU6UjS9Ynzd
   J2Kt3cM39lQeBsim6yLWRS/MX2RexDZpxkKa3zuQuhy4ORsYhTHB3tgnE
   9JmEdOkidLzTE/jVCrPSgu1BTJ7mzI7j4pTo2vVIDd/oBpwLxDg51Sljh
   ljLjrQ9lZ+CwkuHsx8E3PdwBy3G5t/GvP0Ml8VogMMrRDRpM0sJgBsHH0
   Q==;
IronPort-SDR: CYc6zV3XDDRNJduiH051jthDlaXRT8jcZuv2mv6GiJ8D6Rh5A2A30kq5QIMCTn64fKUxwIKBp7
 HRso2MQtHzGGVYOSJE7zOoj2wjlsrFOla73rZ/vbirExqG7Iaonaq1kjHso/jybZ5kO8b+6HoX
 JIYKsRwKcXsdgaY41+WrFX5KACAjA8pM/wzr4GgUzKDdhEC/4vEbryIivGznQvL3OXGDSECaJf
 CnbReBAZ9L25qabk4oKmsLlXh4LM+Iu164eIe2ZtvW1cmhFbFrLOD7Gd0cjJAtxoztAHoJx5fr
 3yI=
X-IronPort-AV: E=Sophos;i="5.77,433,1596470400"; 
   d="scan'208";a="155806607"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2020 21:52:40 +0800
IronPort-SDR: GnPLVCzvL/pXu6qKPEKWggiRSUbz6nd58sfLSx/9zKuX3VD3Fi7jzRM40V8QDgF+df7QUTkAFD
 R1YB3yu9EgJOEEH6J+fKKEswZVAMkFq3yGoEvnTAhnhBlNog4v7gK4AQ0MRveE9PItW2G3tewh
 670rc9KXea+C4nak9mHEZerJSJwGGYlvu9djwASp10TS5qlNpNaQJ3HL25yI0RVCl4F/wX+YHo
 tu6iD3QGx0L8oZJ9XpgWJfYj7jHperOeWaxPkQcBHuv6Vacx3rRCOzSRaT7lfoqQteWOvySfsw
 CYuS9ZGjryNTin0AdnSYAX7q
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 06:38:54 -0700
IronPort-SDR: YqdWAIGHm/UYTJcK9H5eIeTI5wxVmLQTi0825SHSOlEXBgZ+p9J0ommRTt3DbL4hJUCQx57zgF
 +WIargxl69G2XfqWUvP4+Zd4695gH+5AG5gFAtzKpgqq6zYBlBPh2LmmymX52lOFF1adutLn/8
 z2mp6+U4oxwfo8qaXijgbFZ6/VqfdEfrIG6oCazJsG1QWW6ZPPIhnq+f4QUvZ1tqvVwu0ks1Oa
 L1xLOrw4RVRiBevOgjiU5kT4ghh19X/YwvCG83HXnZ2uZ0AkdWZLhxr2Pv8MP+Eb1VgOuXkLbN
 cI4=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Oct 2020 06:52:39 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v9 15/41] btrfs: emulate write pointer for conventional zones
Date:   Fri, 30 Oct 2020 22:51:22 +0900
Message-Id: <af1830174f9dd9e2651dab213c0b984d90811138.1604065695.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Conventional zones do not have a write pointer, so we cannot use it to
determine the allocation offset if a block group contains a conventional
zone.

But instead, we can consider the end of the last allocated extent in the
block group as an allocation offset.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/zoned.c | 119 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 113 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 0aa821893a51..8f58d0853cc3 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -740,6 +740,104 @@ int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size)
 	return 0;
 }
 
+static int emulate_write_pointer(struct btrfs_block_group *cache,
+				 u64 *offset_ret)
+{
+	struct btrfs_fs_info *fs_info = cache->fs_info;
+	struct btrfs_root *root = fs_info->extent_root;
+	struct btrfs_path *path;
+	struct extent_buffer *leaf;
+	struct btrfs_key search_key;
+	struct btrfs_key found_key;
+	int slot;
+	int ret;
+	u64 length;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	search_key.objectid = cache->start + cache->length;
+	search_key.type = 0;
+	search_key.offset = 0;
+
+	ret = btrfs_search_slot(NULL, root, &search_key, path, 0, 0);
+	if (ret < 0)
+		goto out;
+	ASSERT(ret != 0);
+	slot = path->slots[0];
+	leaf = path->nodes[0];
+	ASSERT(slot != 0);
+	slot--;
+	btrfs_item_key_to_cpu(leaf, &found_key, slot);
+
+	if (found_key.objectid < cache->start) {
+		*offset_ret = 0;
+	} else if (found_key.type == BTRFS_BLOCK_GROUP_ITEM_KEY) {
+		struct btrfs_key extent_item_key;
+
+		if (found_key.objectid != cache->start) {
+			ret = -EUCLEAN;
+			goto out;
+		}
+
+		length = 0;
+
+		/* metadata may have METADATA_ITEM_KEY */
+		if (slot == 0) {
+			btrfs_set_path_blocking(path);
+			ret = btrfs_prev_leaf(root, path);
+			if (ret < 0)
+				goto out;
+			if (ret == 0) {
+				slot = btrfs_header_nritems(leaf) - 1;
+				btrfs_item_key_to_cpu(leaf, &extent_item_key,
+						      slot);
+			}
+		} else {
+			btrfs_item_key_to_cpu(leaf, &extent_item_key, slot - 1);
+			ret = 0;
+		}
+
+		if (ret == 0 &&
+		    extent_item_key.objectid == cache->start) {
+			if (extent_item_key.type == BTRFS_METADATA_ITEM_KEY)
+				length = fs_info->nodesize;
+			else if (extent_item_key.type == BTRFS_EXTENT_ITEM_KEY)
+				length = extent_item_key.offset;
+			else {
+				ret = -EUCLEAN;
+				goto out;
+			}
+		}
+
+		*offset_ret = length;
+	} else if (found_key.type == BTRFS_EXTENT_ITEM_KEY ||
+		   found_key.type == BTRFS_METADATA_ITEM_KEY) {
+
+		if (found_key.type == BTRFS_EXTENT_ITEM_KEY)
+			length = found_key.offset;
+		else
+			length = fs_info->nodesize;
+
+		if (!(found_key.objectid >= cache->start &&
+		       found_key.objectid + length <=
+		       cache->start + cache->length)) {
+			ret = -EUCLEAN;
+			goto out;
+		}
+		*offset_ret = found_key.objectid + length - cache->start;
+	} else {
+		ret = -EUCLEAN;
+		goto out;
+	}
+	ret = 0;
+
+out:
+	btrfs_free_path(path);
+	return ret;
+}
+
 int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
 {
 	struct btrfs_fs_info *fs_info = cache->fs_info;
@@ -754,6 +852,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
 	int i;
 	unsigned int nofs_flag;
 	u64 *alloc_offsets = NULL;
+	u64 emulated_offset = 0;
 	u32 num_sequential = 0, num_conventional = 0;
 
 	if (!btrfs_is_zoned(fs_info))
@@ -854,12 +953,12 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
 	}
 
 	if (num_conventional > 0) {
-		/*
-		 * Since conventional zones does not have write pointer, we
-		 * cannot determine alloc_offset from the pointer
-		 */
-		ret = -EINVAL;
-		goto out;
+		ret = emulate_write_pointer(cache, &emulated_offset);
+		if (ret || map->num_stripes == num_conventional) {
+			if (!ret)
+				cache->alloc_offset = emulated_offset;
+			goto out;
+		}
 	}
 
 	switch (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
@@ -881,6 +980,14 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
 	}
 
 out:
+	/* an extent is allocated after the write pointer */
+	if (num_conventional && emulated_offset > cache->alloc_offset) {
+		btrfs_err(fs_info,
+			  "got wrong write pointer in BG %llu: %llu > %llu",
+			  logical, emulated_offset, cache->alloc_offset);
+		ret = -EIO;
+	}
+
 	kfree(alloc_offsets);
 	free_extent_map(em);
 
-- 
2.27.0

