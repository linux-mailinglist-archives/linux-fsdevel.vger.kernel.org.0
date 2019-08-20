Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1AF295653
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 06:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbfHTEx1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 00:53:27 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:11098 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729190AbfHTEx0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 00:53:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566276806; x=1597812806;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SAnP0DvB0b+BvO+0g0H5T4EmJJtUjqsPCUh699GxsZU=;
  b=dLd9uv4V+30LsUv8mNgYZ0u0xbcF2Wk5ZN5w+lADdHMs1Mmo6fXgXYeF
   ltOhN+tLNZzdSfChoBd/y8ZgY1PTpm9efgZqMdnDGmkuY+1ssNV5bZxML
   cYYkrpUfm9/TdtSak/iBnYqVOPe3plgnLAFuy4JfaMu0o+X0TdzzkhJlo
   iXc4DZyCPs1OdN52WsxHmTO4H1gbjkj2QIyVe6zuGappEtsv6BdUGLt9K
   raiDWqwoPJ8n1WiHKVDa+jgUODEdt6+rTs6peDdgN2jnWDkx9DOITkEyY
   YZ9wUhVspjDQp9Re/O/+zCMsAU6t8NfW3EwOtayo47Xs1m/9zB2G/3ZyH
   w==;
IronPort-SDR: RgyG8UmN0lFL36rAm9aKE8Cm4ZIyPBNlLId1B7Oy29qvKgp2RAbr3QVA/Uu3yy8nUmvMLDQZTL
 nSLEBNpb7QL0vkYKAnfr79I2eqCyG/y0qnOfx8dPd2s1u/usYLLP6t3Mkt1mEyd7m6AF3KvJnl
 hy0PeYUGOLTe1l5CRVOtnU/5XcTeR7MFRFH64SOlmOSJDm3GM9grAGos+OgUVibMhdyLJS6DHa
 TD6HgEJbdyveD36Fvu6PxIwiFJx61yO5xpAM7F9Te5RL1W8uo57hU3+ro3kCMm0WQgEYHFfvgp
 AFo=
X-IronPort-AV: E=Sophos;i="5.64,407,1559491200"; 
   d="scan'208";a="117136317"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Aug 2019 12:53:26 +0800
IronPort-SDR: gs+1qRxJm2mvn2AN21korKrJErDYyjkHewc+lx67AMSo7WpVCwaYjeP7g3RboZp122gcOjSNQb
 Noc7n/7kQbHcPj4qtbkzxZQHdfKJPbise0nhH6+nO7PyHUP9fn9Foeqf+IyyG/+ZH7ZAsoutHz
 h2XfCGnAV0jJs+pUbHk0xl8ipG5JAJGyUeatStOx4p7ZiXbTo0YLkgFqBI6fOMcthy57hvhhkV
 HxMzF5Q6amg3Mv5nuoCI0V1mFzsfxyvxctsGXfi9+yuHlZ4IVFWEWXrT721fH1B3aeYyvUxLwu
 +7WZPMmUCg3HZm0Hhq9HWO8z
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 21:50:50 -0700
IronPort-SDR: VIchjVqil0QIEtBBpawPK1VhwNh3EOikcg1xX0rBJ7YU5Y5W0sEzKr+D45MWvyTHgMps3osHIt
 NeBQXFjfGYhX/lwjzJYv1Qa4qWggkRlQ3dJjvld62r/HAxXM4e78JiGN8PrFqfxVNF+6YxOtha
 21n8OzTQalQoQ2jJwQGQC+EXiT1MW0v0ly8x2KCUZPO94VqL2SeF6pl4EPpEoXpfY//IUae+L0
 gqEUvaBPPVB/Aie7clDT4HjekEuFoPxKxjO4ZKOufUOG07AhW5JpvLasPB7XnBrCG68Bedulr2
 qHc=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Aug 2019 21:53:23 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 12/15] btrfs-progs: redirty clean extent buffers in seq
Date:   Tue, 20 Aug 2019 13:52:55 +0900
Message-Id: <20190820045258.1571640-13-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190820045258.1571640-1-naohiro.aota@wdc.com>
References: <20190820045258.1571640-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Tree manipulating operations like merging nodes often release
once-allocated tree nodes. Btrfs cleans such nodes so that pages in the
node are not uselessly written out. On HMZONED drives, however, such
optimization blocks the following IOs as the cancellation of the write out
of the freed blocks breaks the sequential write sequence expected by the
device.

This patch check if next dirty extent buffer is continuous to a previously
written one. If not, it redirty extent buffers between the previous one and
the next one, so that all dirty buffers are written sequentially.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 common/hmzoned.c | 28 ++++++++++++++++++++++++++++
 common/hmzoned.h |  2 ++
 ctree.h          |  1 +
 transaction.c    |  7 +++++++
 4 files changed, 38 insertions(+)

diff --git a/common/hmzoned.c b/common/hmzoned.c
index 0e54144259b7..1b3830b429ab 100644
--- a/common/hmzoned.c
+++ b/common/hmzoned.c
@@ -555,6 +555,34 @@ int btrfs_load_block_group_zone_info(struct btrfs_fs_info *fs_info,
 
 out:
 	cache->alloc_type = alloc_type;
+	cache->write_offset = cache->alloc_offset;
 	free(alloc_offsets);
 	return ret;
 }
+
+bool btrfs_redirty_extent_buffer_for_hmzoned(struct btrfs_fs_info *fs_info,
+					     u64 start, u64 end)
+{
+	u64 next;
+	struct btrfs_block_group_cache *cache;
+	struct extent_buffer *eb;
+
+	cache = btrfs_lookup_first_block_group(fs_info, start);
+	BUG_ON(!cache);
+
+	if (cache->alloc_type != BTRFS_ALLOC_SEQ)
+		return false;
+
+	if (cache->key.objectid + cache->write_offset < start) {
+		next = cache->key.objectid + cache->write_offset;
+		BUG_ON(next + fs_info->nodesize > start);
+		eb = btrfs_find_create_tree_block(fs_info, next);
+		btrfs_mark_buffer_dirty(eb);
+		free_extent_buffer(eb);
+		return true;
+	}
+
+	cache->write_offset += (end + 1 - start);
+
+	return false;
+}
diff --git a/common/hmzoned.h b/common/hmzoned.h
index dca7588f840b..bcbf6ea15c0b 100644
--- a/common/hmzoned.h
+++ b/common/hmzoned.h
@@ -55,6 +55,8 @@ int btrfs_get_zone_info(int fd, const char *file, bool hmzoned,
 			struct btrfs_zone_info *zinfo);
 bool btrfs_check_allocatable_zones(struct btrfs_device *device, u64 pos,
 				   u64 num_bytes);
+bool btrfs_redirty_extent_buffer_for_hmzoned(struct btrfs_fs_info *fs_info,
+					     u64 start, u64 end);
 
 #ifdef BTRFS_ZONED
 bool zone_is_sequential(struct btrfs_zone_info *zinfo, u64 bytenr);
diff --git a/ctree.h b/ctree.h
index d38708b8a6c5..cd315814614a 100644
--- a/ctree.h
+++ b/ctree.h
@@ -1125,6 +1125,7 @@ struct btrfs_block_group_cache {
 
 	enum btrfs_alloc_type alloc_type;
 	u64 alloc_offset;
+	u64 write_offset;
 };
 
 struct btrfs_device;
diff --git a/transaction.c b/transaction.c
index 45bb9e1f9de6..7b37f12f118f 100644
--- a/transaction.c
+++ b/transaction.c
@@ -18,6 +18,7 @@
 #include "disk-io.h"
 #include "transaction.h"
 #include "delayed-ref.h"
+#include "common/hmzoned.h"
 
 #include "common/messages.h"
 
@@ -136,10 +137,16 @@ int __commit_transaction(struct btrfs_trans_handle *trans,
 	int ret;
 
 	while(1) {
+again:
 		ret = find_first_extent_bit(tree, 0, &start, &end,
 					    EXTENT_DIRTY);
 		if (ret)
 			break;
+
+		if (btrfs_redirty_extent_buffer_for_hmzoned(fs_info, start,
+							    end))
+			goto again;
+
 		while(start <= end) {
 			eb = find_first_extent_buffer(tree, start);
 			BUG_ON(!eb || eb->start != start);
-- 
2.23.0

