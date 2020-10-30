Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9E882A0719
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 14:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbgJ3Nxy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 09:53:54 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:22003 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgJ3NxG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 09:53:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604065986; x=1635601986;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RAeB+WuV6ZtDINwa1qP3+ZHNXCsV2X3PR1lyuHebgjg=;
  b=JKt0w9JfJ6IcZ64MJvFin+wuhyt2wDHOOQ0Ohp/0NysSXSiKR1Bd7Etd
   gUa72kuG9bte80BNBDtNo87Ozc1nuJ3XokrCBKvHVcx3cswSXNBEwMGR3
   yG0SnYDAYNM8v3r5rWWjNquCMRfEZQi8gaOdu13yJSNnXIBIOMl2j6i7D
   T/ZLcJ8PTkYsW5oMxuzRALTvTzRVtg9aLxRI+nQ99Tsk9+cjDRsF3T/dr
   eFqwl7LcdureNMCgbBh9BHl3OrldZ2ItNeKMPdskoYiEjJZbSKHKqfSrx
   sTI2vxkfVStxdHr5KduVWBryA8iXe9VYLLvN8P8EHXfSzVXrVv10vg/4l
   g==;
IronPort-SDR: ntgXKQisF44/FN2R/Ukmbd1HUHF8ektMPspCr4fD1WjyjnpKtu+UFRgBTCnlIOmKXJjyPkxPpS
 ivP5QXpu4Lr+JEOsSFSOmRAHdJ1S/ZJAghx3I7tuBc4ko2Ok/YjwiK9vnf8b2YiTEGUKQFBE6R
 nCIMUNjz4Ra/ev1e0Sq5WWqiW23xlcAMRNiT9+8CE0lQUTJWcP+4VDtucQCvk4quGh8K/68aFJ
 MedBiQE6i8BfzJ/wdLtLvdkzeNgiZDgUvd6EdqSSYmtkFSR3SEofvMAIkyuaxyZSrM1PbEi0A0
 Vzo=
X-IronPort-AV: E=Sophos;i="5.77,433,1596470400"; 
   d="scan'208";a="155806628"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2020 21:52:54 +0800
IronPort-SDR: OBUAU/EKuvP9P2suQhZfzGf8Blt715yCoRpbO2T79wSnVKdGYV63znoVzJ0Iy4mmulvPxRY5b8
 W8qpIFCGCAiLOlRz1eJGxeRES9ChLvXesJvptCqA9kWfAJyqP2f7nwAUZA+AhfwzSItXl25Zot
 69COWtH51++kwCN2ryb+pOFf3g3BJDHpSbwaycDCvvnIpZyUutdvowMAoY4VaM4krcxsOpL7pz
 JLb8mbE5yuOVEsVVO3BKFgae/5dkF9UTgGtFM9Q2alNyfsEl9AinhZxW0oBWYVte0Ac4sUAIWY
 XlJzBdjz3MPgOQrHXEnRGCka
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 06:39:08 -0700
IronPort-SDR: 2kPBYhjNPn8n3ROFda2xIMMZscNNS2pSFW4xXNMfG8NP+9D/oGw4ymRFj/Qtae+wd5Z95xKnBG
 1nz6vwhmyoVwKYx3kXFBw2mOLQAYHjRj/7qHhHqrRs4EiEdJj6recLFLiMuiwqQz0mk//93t1J
 uSFE07mtZnrMX42cMfztMokk2ST3VAarv5+G5BQM53ZprPeCVRbPDWWx6x3pn+/E+vRrAu9FVm
 xjTPeVquENsCsenYYdLxgXZ2uy92IvhiZBSTUKOyVkEQnblisXwiZGb6HX84KQO59qaioOyOPM
 93o=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Oct 2020 06:52:53 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v9 27/41] btrfs: introduce dedicated data write path for ZONED mode
Date:   Fri, 30 Oct 2020 22:51:34 +0900
Message-Id: <72df5edeab150be3f081b0d96b174285f238eb0f.1604065695.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If more than one IO is issued for one file extent, these IO can be written
to separate regions on a device. Since we cannot map one file extent to
such a separate area, we need to follow the "one IO == one ordered extent"
rule.

The Normal buffered, uncompressed, not pre-allocated write path (used by
cow_file_range()) sometimes does not follow this rule. It can write a part
of an ordered extent when specified a region to write e.g., when its
called from fdatasync().

Introduces a dedicated (uncompressed buffered) data write path for ZONED
mode. This write path will CoW the region and write it at once.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/inode.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index bc853a4f22cc..fdc367a39194 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1350,6 +1350,29 @@ static int cow_file_range_async(struct btrfs_inode *inode,
 	return 0;
 }
 
+static noinline int run_delalloc_zoned(struct btrfs_inode *inode,
+				       struct page *locked_page, u64 start,
+				       u64 end, int *page_started,
+				       unsigned long *nr_written)
+{
+	int ret;
+
+	ret = cow_file_range(inode, locked_page, start, end,
+			     page_started, nr_written, 0);
+	if (ret)
+		return ret;
+
+	if (*page_started)
+		return 0;
+
+	__set_page_dirty_nobuffers(locked_page);
+	account_page_redirty(locked_page);
+	extent_write_locked_range(&inode->vfs_inode, start, end, WB_SYNC_ALL);
+	*page_started = 1;
+
+	return 0;
+}
+
 static noinline int csum_exist_in_range(struct btrfs_fs_info *fs_info,
 					u64 bytenr, u64 num_bytes)
 {
@@ -1820,17 +1843,24 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
 {
 	int ret;
 	int force_cow = need_force_cow(inode, start, end);
+	int do_compress = inode_can_compress(inode) &&
+		inode_need_compress(inode, start, end);
+	bool zoned = btrfs_is_zoned(inode->root->fs_info);
 
 	if (inode->flags & BTRFS_INODE_NODATACOW && !force_cow) {
+		ASSERT(!zoned);
 		ret = run_delalloc_nocow(inode, locked_page, start, end,
 					 page_started, 1, nr_written);
 	} else if (inode->flags & BTRFS_INODE_PREALLOC && !force_cow) {
+		ASSERT(!zoned);
 		ret = run_delalloc_nocow(inode, locked_page, start, end,
 					 page_started, 0, nr_written);
-	} else if (!inode_can_compress(inode) ||
-		   !inode_need_compress(inode, start, end)) {
+	} else if (!do_compress && !zoned) {
 		ret = cow_file_range(inode, locked_page, start, end,
 				     page_started, nr_written, 1);
+	} else if (!do_compress && zoned) {
+		ret = run_delalloc_zoned(inode, locked_page, start, end,
+					 page_started, nr_written);
 	} else {
 		set_bit(BTRFS_INODE_HAS_ASYNC_EXTENT, &inode->runtime_flags);
 		ret = cow_file_range_async(inode, wbc, locked_page, start, end,
-- 
2.27.0

