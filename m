Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A3D2FFCC2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 07:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbhAVG3l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 01:29:41 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:51039 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbhAVG1U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 01:27:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611296840; x=1642832840;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZDR+84muBJ96AMMRsDBsvzAu0B4WOvAi0xdManaKHBw=;
  b=JSazOebskAdMK0x4JBjdGf9Cpzv55NRoXq7GrIQmon6yBcEae0KFGzze
   r+i+qajuCSDNNZpNAlQwhECDxKjDR+coefrE9kOhjXizP+CLo2rOb3RMB
   iCLJIyvJehfwWdsQnnxn73ys/3XuiNFB7FDgnRPpk+61nMsrNTuTfX6Yd
   QEpxydccZzU7JxmjRy9WJL9yHr0kHygqlLyvS6Z8WTXDrsHxbAuBm8i9L
   1ahrWVB9G7jVHhO5iead30C82tYBxMYHcRkBpetPtdndt8Zv70XohX1j+
   +KtLQ2hPmsCSgcryR+41d4OFMpX62avEGeAzJnRgx8+NCT2+0++rwV2N1
   w==;
IronPort-SDR: CYmw81+ew4PzhmSpP7vTS9x+as5LtPCPSM2binJfKY+xoW3XIfSb+C+W5o4yimGsggE54+e9C3
 wvfL7Mp6D+NkaNT3p4MPUMRIGcLrqV60GG4GSdwoB58+JDsq5bjvSm6i56wmbM787EKrMyd1WR
 +cLVBsZGzDtOFzYd9CqWHQsRAi6wZWDw5wd5oFWYyBp0rI6P3muuhTQrltyjOcHiwTHOFc0EH4
 FzFUGwJczyNXCthTA1CEIy0R4SgphOQefIXzd0pHRaZvnYB8raXL2pJoz366r55I5pwWonvB+l
 XYg=
X-IronPort-AV: E=Sophos;i="5.79,365,1602518400"; 
   d="scan'208";a="268392034"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2021 14:23:07 +0800
IronPort-SDR: mA969MS+tQ703FWrl4ESttQq9PZ7aQYUiX/3+JCA8+TTVdtghRfy1jQrh+dsE03RTqlIFj8mf6
 lDnxLu76S0LUL3cAmHcQoLGeTuH5nJINBRgOSey2LrsD/VWLgApr8kyVIoAjgIQiztmebYMVpN
 C9Ja931BZdYIGvDdLexCItW7LSKgOUJYZud+BmgN9KoTSsJhFsaLO/orZN+sxHfMN4p+ZLg0Lg
 USg/6GxL2HO5B2V51QxkLxkeaVl2VMTRWQJPTRLL/TiUl2hqYtbXTsCBqqpsBAdhfgAIEmsDf1
 fV5sX9hLM4ScUjpRovPSNomR
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 22:05:39 -0800
IronPort-SDR: 1haN+nK4vC8wvxG790VU1vnDxNmo5krZcroax52tYCu8A80OrsaFNT1kr+3lzrCUrL1p/QC6wD
 i87H4eyP91jxIK/W/uAHPGaOOIZVrHkFk8uB8KwBDHXmxl/rTMKSPn24NLjXBpL0PT7PdBAKFM
 buQBcz9UGqwqLMiqh2UbFuQeTmHVlFn0Sld56BAltik+II535ja38N+nrGAFbNx+sxGvZw1cAD
 6oVcrlaZLBW2LUmV4XGQFZOHX9un2s/TcrjduaqZsJQJ3g2ijwjAAvsAdon4YfRkVCL6kdFtb0
 w/s=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Jan 2021 22:23:06 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v13 28/42] btrfs: enable zone append writing for direct IO
Date:   Fri, 22 Jan 2021 15:21:28 +0900
Message-Id: <0800322f509ef63bf4309d53742f5bfd53a8eb51.1611295439.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611295439.git.naohiro.aota@wdc.com>
References: <cover.1611295439.git.naohiro.aota@wdc.com>
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
index c67bfe9a8434..26de8158fbe8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7741,6 +7741,9 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	iomap->bdev = fs_info->fs_devices->latest_bdev;
 	iomap->length = len;
 
+	if (write && btrfs_use_zone_append(BTRFS_I(inode), em))
+		iomap->flags |= IOMAP_F_ZONE_APPEND;
+
 	free_extent_map(em);
 
 	return 0;
@@ -7967,6 +7970,8 @@ static void btrfs_end_dio_bio(struct bio *bio)
 	if (err)
 		dip->dio_bio->bi_status = err;
 
+	btrfs_record_physical_zoned(dip->inode, dip->logical_offset, bio);
+
 	bio_put(bio);
 	btrfs_dio_private_put(dip);
 }
@@ -8119,6 +8124,19 @@ static blk_qc_t btrfs_submit_direct(struct inode *inode, struct iomap *iomap,
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

