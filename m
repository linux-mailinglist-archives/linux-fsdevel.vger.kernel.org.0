Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED36233AA21
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 04:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbhCODtc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Mar 2021 23:49:32 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:29592 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhCODtV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Mar 2021 23:49:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615780180; x=1647316180;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TMNqp6puhFs9cVzUL+PcsKNvjzULnsi5KVTwOEMC8Mo=;
  b=clKUVToOdHRsucAyPq6sGJnHfrqj57ydx+5IMhiuRD+CNtmEttk7TQfo
   oE9ixQdPRc+a4UVzBYPEoD8vrb6CF4vCr+PwEmBSZIMIOc7X04l9I9xg8
   Au5v+yBvE3CZjw3tM/D6iFR0RF/X0G3p/5LAGNvhITnqwbgL4LtbeWY/I
   SyV8Rzy6nI/eDES5HFFSYDEIxNcvHhorfLfU3bJ5w8L09nbaq6YM3jbka
   NbBfSiH78z2H0YFsxBUXBUqzyx1kApCDA/40xxwnxbqTF9F/Fjm3rSHbw
   w83fKJ41OHcbwamZKk+KhKGJ4VLGyKPBA3R24pYbST/I5NMZA7QG1HgFq
   A==;
IronPort-SDR: sth3vHJpuuJKhtWo8i8JeB7tiTZ+6fn1l/8PfMGLrTKlOb1ewV42NK6Wd+iMuS2sUuM6g6JZAB
 EC4APh3JoaFFmmBuRi/nILZbhprxMppX9CNNrz8o4CSMkkdetrhWHmJvC17GKM58atQBnW5I/L
 f+iYa+8+pyi0/u9jw0QbgHRuzbhxf2+4bpjEB8XHypY2Z2Xp5GCIuagnhqUx/uXgj/G9eLjTPx
 yb2X64Js3n868Fc6PUXh87SMd9NMNy0Rpach7eG18wN5QSsIOQmojzxrdD3zI6s+pO6NkmgpiV
 SRA=
X-IronPort-AV: E=Sophos;i="5.81,249,1610380800"; 
   d="scan'208";a="266509451"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Mar 2021 11:49:40 +0800
IronPort-SDR: Gf4NIdTecg05AroepOGXPtp14kEZcfJEEBHSTKWKD55oY87gZkBUz3Ikd/580g+o9ts3pztqA1
 1chqI46v6c60yeGmQr54BkDM5xVoJbAVJYWKwAfm7CmL9u8T9QAS7RKgm/Xxhr+oiY9Z837CoM
 LT/jKHKikUE8co+ZNUMx/a4MPfT6K/TfiEpLr2qHDRXlB5rqOPL7jX9CxdWjs1UYlyBB3Akxdd
 DfleTEwA9Ftc10peimGapTsgbuexsU1qOTX5SFGEDREaThlJb/7etT5P072tdWC0sYq6FAiqQo
 1rcFMMnnPzG9oBM24+/vPKin
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2021 20:31:51 -0700
IronPort-SDR: o8L7VNcJfUj1kyaajcU+PlwKGQbQRpzLMH52nVUVWQrHGegUzvo7Isu1kPSF19koMZJkIoL/HD
 P3BTt2E6W17ZFH4qRVb9Bu4jqT1l3NWf7pyY/TGYkVSaXNvKGXeIvsSIIxewcimfr8ZAtLnO+n
 Qnk82zmg3OggHT7cOVZJ0wEXbAVvHFxwhVT0RrvJ0qEWk9hr0f6QZVumvR/6w/Vpuy88fG6AR4
 EOw5VjliWUrgacdE33MjLwNSNMXiP64EuVEEZTgM4K5MzUZo6uOwm+RtgtBSTCy+UqJvDOSIBG
 0Ic=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 Mar 2021 20:49:21 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 1/2] zonefs: prevent use of seq files as swap file
Date:   Mon, 15 Mar 2021 12:49:18 +0900
Message-Id: <20210315034919.87980-2-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210315034919.87980-1-damien.lemoal@wdc.com>
References: <20210315034919.87980-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The sequential write constraint of sequential zone file prevent their
use as swap files. Only allow conventional zone files to be used as swap
files.

Fixes: 8dcc1a9d90c1 ("fs: New zonefs file system")
Cc: <stable@vger.kernel.org>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 fs/zonefs/super.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 0fe76f376dee..a3d074f98660 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -165,6 +165,21 @@ static int zonefs_writepages(struct address_space *mapping,
 	return iomap_writepages(mapping, wbc, &wpc, &zonefs_writeback_ops);
 }
 
+static int zonefs_swap_activate(struct swap_info_struct *sis,
+				struct file *swap_file, sector_t *span)
+{
+	struct inode *inode = file_inode(swap_file);
+	struct zonefs_inode_info *zi = ZONEFS_I(inode);
+
+	if (zi->i_ztype != ZONEFS_ZTYPE_CNV) {
+		zonefs_err(inode->i_sb,
+			   "swap file: not a conventional zone file\n");
+		return -EINVAL;
+	}
+
+	return iomap_swapfile_activate(sis, swap_file, span, &zonefs_iomap_ops);
+}
+
 static const struct address_space_operations zonefs_file_aops = {
 	.readpage		= zonefs_readpage,
 	.readahead		= zonefs_readahead,
@@ -177,6 +192,7 @@ static const struct address_space_operations zonefs_file_aops = {
 	.is_partially_uptodate	= iomap_is_partially_uptodate,
 	.error_remove_page	= generic_error_remove_page,
 	.direct_IO		= noop_direct_IO,
+	.swap_activate		= zonefs_swap_activate,
 };
 
 static void zonefs_update_stats(struct inode *inode, loff_t new_isize)
-- 
2.30.2

