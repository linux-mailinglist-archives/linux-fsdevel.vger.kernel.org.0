Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4502A06FA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 14:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgJ3NxH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 09:53:07 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:22001 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbgJ3NxG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 09:53:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604065985; x=1635601985;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zl4jN9ny58bdtwI9MRmAuXUyo6ZKJe0ZuqJHF7+FeRQ=;
  b=FWPrKlrh6/Ejyl5nUiesMUItgCi4VZ+dZxkPPdLxIXUP2kT+NcS2eBJQ
   /ciN9QOu8AA9GI/Mot2Zw8uoEEmPplhd7ad8YSysrfEvwN8X7wYolPIh8
   Q2Ksy4J1NO5L9yHsiYQcSOtIe9fxzQpmkhGt4+allF+ieoSnn0vBCDw2R
   qcUpe+pqau/gg5jptn1sTP6lqIo+SDjicGMo2NCV5HnIbMKVqKMtyfkCG
   omHwKq/8G90p6bwJ6El2I+c6drVRY/9mFGTL09RoGLIi/muD3kjweI5ii
   7CISshk5s9O9iCQrQnEDQZ9pQG0fkqmFV3ozajCFPEDreP2lcv15NRhNI
   g==;
IronPort-SDR: 6BCtU/d5wGXulUE74gPcYYWahDx6CmKs0BY8Q0KGLGZ27JOwjb98HDOzVErTxWV9f+mIyvFKV2
 +BtWd4UuTt9CUOT/VpVvCpUcLNWQRUyuyHKaEuMHiKYRjN4DT1ovz7pbn59WfKbm3ppWopn4B+
 RqpDfmW45doBWmsArjAzyr/Keef5CI0XVHHk0IHEjHyfTm7M9d02iC3RKH1Jn34OjcLZDbWkka
 QBpz++ENBTJZvmk9bYXzzdaxzF08BNGQ6HTotrVAEVW+2NMai2t3hFwY9594HO2Pe4EeYSdJx6
 H88=
X-IronPort-AV: E=Sophos;i="5.77,433,1596470400"; 
   d="scan'208";a="155806627"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2020 21:52:53 +0800
IronPort-SDR: RUjwikquoDAvtRSlId8sD22UQck8S8rzCC4QGa07BqXat+OTbjhGAMJsZ02b+10javEx0wY0Qa
 tFrBxCVZ1umPfwQQu0BltMs9SlWdWNz8EsqW+bXDTCTHFGe63BHNzvK7ReORRWbUEcF5aLLXSJ
 ePGHFvvGPeZIcUs+EK0nJl+OJTb510bEEZi3qXoXP2pLrPw8fl7tDtsfG4OtDhqVdei5TGyzKM
 XvWFZNe3dsLc+J+FgZAFm1aoUNYmNAyRpM4dl3lcRN+IpLeXf1EYBg7ynwjWkcpcg99aoY4zm2
 x/uh2U/+UuulbRqrcE0kV1ZO
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 06:39:07 -0700
IronPort-SDR: byyAOo3HiOQ5CFQZOXl7BPNjhA7sACD9AZ8uvlLKhRvWBO+1D7Tntf24Bx59X9BogeO5iAnB/q
 lN6myUYpLdokXtGBFPrxIOUrN7H341XpWakjnTWfEtSOkJyBvZWE4/JauuhlFlmX8Dk/Q3OIyA
 8S+PgnVMvVsowzOc3gmPC7YEA6KPhqrgPOZmEKvmMF/QS8tQLnQV+cRDYWSuY2HQzaNj9A5ohl
 I+8lbg9u6XF6QbGoQiv/VDYU5fneLVWfleZ0iC6KrJ9oBtIvOfbH04FSJZ2Qx685H2UzlRVAkh
 8FI=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Oct 2020 06:52:52 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v9 26/41] btrfs: enable zone append writing for direct IO
Date:   Fri, 30 Oct 2020 22:51:33 +0900
Message-Id: <0ac6b4d4630d97838ea6532ba81c8ebf1cfaffd3.1604065695.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Likewise to buffered IO, enable zone append writing for direct IO when its
used on a zoned block device.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/inode.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6d40affa833f..bc853a4f22cc 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7542,6 +7542,9 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	iomap->bdev = fs_info->fs_devices->latest_bdev;
 	iomap->length = len;
 
+	if (write && btrfs_is_zoned(fs_info) && fs_info->max_zone_append_size)
+		iomap->flags |= IOMAP_F_ZONE_APPEND;
+
 	free_extent_map(em);
 
 	return 0;
@@ -7779,6 +7782,8 @@ static void btrfs_end_dio_bio(struct bio *bio)
 	if (err)
 		dip->dio_bio->bi_status = err;
 
+	btrfs_record_physical_zoned(dip->inode, dip->logical_offset, bio);
+
 	bio_put(bio);
 	btrfs_dio_private_put(dip);
 }
@@ -7933,6 +7938,18 @@ static blk_qc_t btrfs_submit_direct(struct inode *inode, struct iomap *iomap,
 		bio->bi_end_io = btrfs_end_dio_bio;
 		btrfs_io_bio(bio)->logical = file_offset;
 
+		WARN_ON_ONCE(write && btrfs_is_zoned(fs_info) &&
+			     fs_info->max_zone_append_size &&
+			     bio_op(bio) != REQ_OP_ZONE_APPEND);
+
+		if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
+			ret = extract_ordered_extent(inode, bio, file_offset);
+			if (ret) {
+				bio_put(bio);
+				goto out_err;
+			}
+		}
+
 		ASSERT(submit_len >= clone_len);
 		submit_len -= clone_len;
 
-- 
2.27.0

