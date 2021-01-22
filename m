Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB7B12FFCB6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 07:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbhAVG2o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 01:28:44 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:51138 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbhAVG17 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 01:27:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611296879; x=1642832879;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2s5NK8tSWvlhL5OFm4v5zkBSPKsGpOvG+1jvfV3eidk=;
  b=U8Z3S2utgYHWukFkvx/PzUZlLV82DgUSOxK0Qc6aQb1d0Hn3R+ZPrJtL
   cbs4AMKFj+zLQWkHXtbAJfJPL1akoXkNe0+0Jedg6WcLsfe1TXgyyY7Oy
   RRJx6hQtqLuj3nUE+u+bucnOSAa3uDyNfbq4frMQPbybshHlHt5ZbH4mg
   3GRyfIbVGfbSqrVCyOHYKyC2QKZmmHPIPoHooytijWS86U1U8p0bhBtCO
   s79DcSe/eE5A9HSAnNIACVTdrBjkD/ALJL5KRClrp4KDFKkE6AUHpErkw
   wvTyggpL74JRMXtTmJFb2OxVRnHfTgQ+L4ZTeTZA+w0Q05WLnRX4xELq3
   w==;
IronPort-SDR: 3JP02dlNIE3HMntMiEBw6AqR2CfWT3JsVe6EfK7JMUJBko83EqqlkQ1DZIcp9gmCZiLgGhBZq8
 2vP1loh14+wWb5KN3litQ/UQFcSY0dmHk4bWOOUYgEJ01cPOK+S+vc/MrElLaLWCmdIbmtFNZp
 Y3GwIPD3COMtJVxLbtxIvsOBOdGmwcjMBYu4lXihkRWlictHR9zIga5P8hpzpoxfy45GllBUcp
 Ja7lscZ5psytBhrINJvRf2iiNp7sR28ZGCgvi764pRPGdk4iALdN1XXhyyJB1FdG8jgGcpJQGv
 4DM=
X-IronPort-AV: E=Sophos;i="5.79,365,1602518400"; 
   d="scan'208";a="268392052"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2021 14:23:14 +0800
IronPort-SDR: 9IZ1jthdsWqerJ1gd2YAlrRKtLmssF4RWXyOFM2/XI2N84E5oYVCiTgu7BLcOYnbJ6i5G2X1s/
 HTGl6p553w+J6vyDCA3Sc/8Bda6cWC3SKDZWFHQQ4xsJa4IpXh/ByTVhWxoVBa64PVbio6irk+
 36CFw8SjwB6GtuZ11xVA1he9685fDPRvDTzsJKOL6r82miSJ6AbVTWoEu4G0s5i2QWfFN3Pgoi
 dVkuoVIglBfgCP/Ke0CaIcggsVc3xNbumiDis9UPhwR56FvPxdLK4gjV4JgD2MwAUyo3F3ckl3
 ws1gj2PKERsnBU1qyWs1alh+
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 22:05:45 -0800
IronPort-SDR: KRiT5LtSciRwUL/uanpo1oUPnJBcJc+QClB/yOMrTkvt12/VNs31h1TIfshZxRTssu1MJC4dUj
 X8fYPUv9gQMad2Bh/O+wn88EDBUhhwXnT71iBKJhl7sn2IkjFD+XkAh68urQ79qcMYgqZ+Ekj9
 BbLfdawh71mojvyoOYLQo3OViOp4VRKxvU/lkdzHTQmJ2FdBbikOBL+eJAp41e3T07Hkd4h6wH
 6CJt4mW7ukYkCpEi64YtVmbl90Cex/ansK+X2YGS1cDJ9uwbQ2aeVRK96BSRJf9jyvUUkxSUcN
 Lek=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Jan 2021 22:23:12 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v13 32/42] btrfs: avoid async metadata checksum on ZONED mode
Date:   Fri, 22 Jan 2021 15:21:32 +0900
Message-Id: <f3b4ec5cb8c2e5cbe6f60810bda39bdfbdf051c4.1611295439.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611295439.git.naohiro.aota@wdc.com>
References: <cover.1611295439.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In ZONED, btrfs uses per-FS zoned_meta_io_lock to serialize the metadata
write IOs.

Even with these serialization, write bios sent from btree_write_cache_pages
can be reordered by async checksum workers as these workers are per CPU and
not per zone.

To preserve write BIO ordering, we can disable async metadata checksum on
ZONED.  This does not result in lower performance with HDDs as a single CPU
core is fast enough to do checksum for a single zone write stream with the
maximum possible bandwidth of the device. If multiple zones are being
written simultaneously, HDD seek overhead lowers the achievable maximum
bandwidth, resulting again in a per zone checksum serialization not
affecting performance.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/disk-io.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index a41bdf9312d6..5d14100ecf72 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -814,6 +814,8 @@ static blk_status_t btree_submit_bio_start(struct inode *inode, struct bio *bio,
 static int check_async_write(struct btrfs_fs_info *fs_info,
 			     struct btrfs_inode *bi)
 {
+	if (btrfs_is_zoned(fs_info))
+		return 0;
 	if (atomic_read(&bi->sync_writers))
 		return 0;
 	if (test_bit(BTRFS_FS_CSUM_IMPL_FAST, &fs_info->flags))
-- 
2.27.0

