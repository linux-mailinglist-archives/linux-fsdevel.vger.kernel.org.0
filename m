Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B4B304917
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 20:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387517AbhAZF34 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:29:56 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:38278 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732166AbhAZCjA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:39:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611628739; x=1643164739;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=niCYSduaj1gcu8wTmuqzJ1Ki+mzQOWMfoFT3y/unoec=;
  b=VbgjJyFsSDaTYZGzFEIt98FpqCU3awhozj2ZVDqjQQhOLLvT+RfGf9rs
   mUb7wCojTTt5ZJzCuQYFfk1vsw01OIYqz+mL7gLOHVRZUHKU3eeIDRPV+
   vG6u6qh4stYP/KNdC06gvJGyJPTE66CXLH1xEoB0ePJRh/ACf3DOBD98j
   fy0nlo0QsqVUAy8nKKMekP7TQ5fOTllEQkaEbZQ6pQduPDQoZeEAG8btK
   GV9jjlXYSZv2koD3rdkwhWIw4TYPl+JFK8f5nDkKtwyJ9mydtAnwrdx+c
   B5RBnNsO6FybhFl0LyEzONRNnHgvTu4yNw5q2QJ+UNTLo/8auszCQHcrJ
   g==;
IronPort-SDR: KmClbd228Jk69ErQQLXtitf/6oPVKcSS4ESgoF/D7mFPryVRsArO/S3+MpMOTjPlmyjygA1h19
 S33c5VDXITQHPrsbb+FBWFZNGPArkCB9G3uFlSSKV4n+ABOhtcCjIymT/pebsJvUJ0FE6rH7Kw
 T2pgd2hAj+6orQ2PWaKKdcfhkktxPmwS3mE3/OMo0mdPlUaV1/4QRsNQw0gu39FN86nkx5YGOF
 l2o4VIYUbHwal8n3BIq7xMSxA0M16s0xZuIVZPp9gsCxeuCI7Yq+q2Z1Ux3QAxChwmK0pbltVd
 qeY=
X-IronPort-AV: E=Sophos;i="5.79,375,1602518400"; 
   d="scan'208";a="159483564"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2021 10:26:47 +0800
IronPort-SDR: qRO2nLMxwI1L44Oqqo8NOozx4KT4q06QZ+TXRM7ji2unglDts8mLqR4CCSMBa7lwGBRT5ctRox
 B42xaGOeEev6AKdxaRiFz6oy8FndfnExpC86e+oANktU7L+7g8FjMGvcfXYEkfecsT3cThscVL
 TtyS3i0TE4l0oeeooTKosizNo2XTXFBDrxyMPEm5MC+kn9GIqvgXg59Al5j+hSXIrBAVmW6MWA
 s03cp8+Q5zXsma+Ynu/xSNthntMyxWWQgBLqNZnmT1CNFMupxkO/ycCCWiBcoFxltz7/+Bviei
 fOgcytRRBSMqgdvVG4t1ASEP
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 18:11:13 -0800
IronPort-SDR: XJrfF4KEJpM4IGm7W1vPXouxXc2yF3Vy0wq3l5LniIzjzkBKKrlPVEuhLI6O274WcX9w5bWHtD
 vw0Kdalhjy0qZlSZ4Ty2oDHPu8Cuo8I3z8nxMudyHYYJvg+biu22UYHxdfgkrOlCNkPA2zqBi6
 21ii39bNiNysWkqwvnI2zGC57If8sU7TZNVxOw5AuNJpHyo5bGdUhFTacxCCrPsQXNddOjUuFt
 C3wyOCty79QNGJepefEK1+H8/nUIRi7XFvuPeDfxq0inc8Gvl8thx8MuEYnXFjyX1ovmC30JvP
 pCU=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Jan 2021 18:26:45 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v14 28/42] btrfs: enable zone append writing for direct IO
Date:   Tue, 26 Jan 2021 11:25:06 +0900
Message-Id: <537b04a8699749b53431f875692c18bd1e7b379c.1611627788.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611627788.git.naohiro.aota@wdc.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Likewise to buffered IO, enable zone append writing for direct IO when its
used on a zoned block device.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/inode.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e3e4b4f7c0d7..a9bf78eaed42 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7743,6 +7743,9 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	iomap->bdev = fs_info->fs_devices->latest_bdev;
 	iomap->length = len;
 
+	if (write && btrfs_use_zone_append(BTRFS_I(inode), em))
+		iomap->flags |= IOMAP_F_ZONE_APPEND;
+
 	free_extent_map(em);
 
 	return 0;
@@ -7969,6 +7972,8 @@ static void btrfs_end_dio_bio(struct bio *bio)
 	if (err)
 		dip->dio_bio->bi_status = err;
 
+	btrfs_record_physical_zoned(dip->inode, dip->logical_offset, bio);
+
 	bio_put(bio);
 	btrfs_dio_private_put(dip);
 }
@@ -8121,6 +8126,19 @@ static blk_qc_t btrfs_submit_direct(struct inode *inode, struct iomap *iomap,
 		bio->bi_end_io = btrfs_end_dio_bio;
 		btrfs_io_bio(bio)->logical = file_offset;
 
+		WARN_ON_ONCE(write && btrfs_is_zoned(fs_info) &&
+			     fs_info->max_zone_append_size &&
+			     bio_op(bio) != REQ_OP_ZONE_APPEND);
+
+		if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
+			status = extract_ordered_extent(BTRFS_I(inode), bio,
+							file_offset);
+			if (status) {
+				bio_put(bio);
+				goto out_err;
+			}
+		}
+
 		ASSERT(submit_len >= clone_len);
 		submit_len -= clone_len;
 
-- 
2.27.0

