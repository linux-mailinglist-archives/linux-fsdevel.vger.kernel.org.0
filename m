Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7B4336ABEA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 07:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbhDZFvw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 01:51:52 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:39184 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbhDZFvs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 01:51:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619416267; x=1650952267;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VYQfDU+zPAANjwyhI4RM7sIHVe4r8Av/Xgfkn9XRd+s=;
  b=czLMoVHdj+Ns/N5lZi2tdFFq4odY5LlGfMKHC30U+SFvveuUIZpz+yMS
   64c3NW3w/XFQNRd5hBzyXdLe/tfXvkSYKPTNeID63oMKBNL92NF6vkAcF
   y5Hc4lX/oy1wu/ZgGAejT7YWrB5uUEd6ydgVpU1oBh1dTVd3YLo1ECVSm
   kOR2HIxf61Ccq+hcmgBRoa/sGkP6ei0bCWBl6gBQNTZqd2V2X8UpD9dRE
   TTbNShkRkexjyJ0RoomdE+uiB7wl4ppMB0PttFIPmFSoKe76Za8kD/MgZ
   adOrvWSr5LYrpHNSdItuCMSfeZozs+hZxs6NhChREF6d1nAaL7C/PjYei
   Q==;
IronPort-SDR: DMaIjvf5qx0H0xobea+piT+sxWYV4Qp1wlWVRlanVodYEEIVbU9WxYJGY8BQd7wHsvOpRqevDK
 C/XyJcB1z2NdzgcUxsP9xMehXLyp8DCMr7BDp7yJ4S4Cn8EJjx40kGOYQ/Pqm6CDxg/NRQjFKM
 xMitD18UVnZCJgk6lp3J1KnSdANJdh46Z+z4dGb2O01Jj5SuPFo/vjZljX3HgeHrmtOQ7fA4HN
 dCn2X94tnW+gAn6DPaOTeE2WhyAon5T+4Zl74hWzc3dlgaoUBAlJLTZ5+rD4JLDh3bE8AH74eG
 b8c=
X-IronPort-AV: E=Sophos;i="5.82,251,1613404800"; 
   d="scan'208";a="170785783"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Apr 2021 13:51:07 +0800
IronPort-SDR: 0E7fmmtZi7fxl3BHTsdKq5taFAfQY0tmQpaWDptfOQviL5VfozDSsvSImOcs8QqV0flX1czrbO
 +oUHcNU4qYI5b93XLyd3P+s2LRRgLRATRuQVJQRx63hoyOjr+xvjc2x4Rbu6NQGSSn19bKUYpE
 4cwGABx915kRT6LTDTeVZeWj8ak2LNci95Du3QywAtZyh5UNVdb0+HBpJeRrJW5Q8bLAsyf5rW
 2leQi8mGi+vQSe8AdHLJomOUkShdoci87UV5uYdZaDjvjYsjGdJPOm1chkeSVbbHOM2msDq/fY
 l9johy7HryjUKVH6fbL+970x
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 22:30:03 -0700
IronPort-SDR: HnxbbFM5IfW8t3+R9ZmRgetSw6AILt/dfl1A4ovLZTzVGM0Jw8E/bjbYawv2z24kmDxQpipWbq
 G0BI6VSOjb2QUlcN8/j4TyRaPp5SmWZrKWq+WLvqJsMhykdwr+9bCBA5XT0X+AJoizvJVUe5N7
 ZlCmGUTXHqdZxtYJAR1dVU/DxAUVhVmcMM0EpPZguRLwtGaU7H4xFuEyWv6ig+5W5zxxLKPXht
 nCQmDSyAUgO7kc6fyY/u3YcbLxaVVbpgv6vYqlbZp7Cu2A3dW1UqePlJytgu269cimREUg0Wzz
 IvA=
WDCIronportException: Internal
Received: from bgy2573.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.58])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 Apr 2021 22:51:07 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 3/3] blkid: support zone reset for wipefs
Date:   Mon, 26 Apr 2021 14:50:36 +0900
Message-Id: <20210426055036.2103620-4-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210426055036.2103620-1-naohiro.aota@wdc.com>
References: <20210426055036.2103620-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We cannot overwrite superblock magic in a sequential required zone. So,
wipefs cannot work as it is. Instead, this commit implements the wiping by
zone resetting.

Zone resetting must be done only for a sequential write zone. This is
checked by is_conventional().

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 libblkid/src/probe.c | 69 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 63 insertions(+), 6 deletions(-)

diff --git a/libblkid/src/probe.c b/libblkid/src/probe.c
index 219cceea0f94..d4ca47c6dbed 100644
--- a/libblkid/src/probe.c
+++ b/libblkid/src/probe.c
@@ -1229,6 +1229,39 @@ int blkid_do_probe(blkid_probe pr)
 	return rc;
 }
 
+#ifdef HAVE_LINUX_BLKZONED_H
+static int is_conventional(blkid_probe pr, uint64_t offset)
+{
+	struct blk_zone_report *rep = NULL;
+	int ret;
+	uint64_t zone_mask;
+
+	if (!pr->zone_size)
+		return 1;
+
+	zone_mask = ~(pr->zone_size - 1);
+	rep = blkdev_get_zonereport(blkid_probe_get_fd(pr),
+				    (offset & zone_mask) >> 9, 1);
+	if (!rep)
+		return -1;
+
+	if (rep->zones[0].type == BLK_ZONE_TYPE_CONVENTIONAL)
+		ret = 1;
+	else
+		ret = 0;
+
+	free(rep);
+
+	return ret;
+}
+#else
+static inline int is_conventional(blkid_probe pr __attribute__((__unused__)),
+				  uint64_t offset __attribute__((__unused__)))
+{
+	return 1;
+}
+#endif
+
 /**
  * blkid_do_wipe:
  * @pr: prober
@@ -1268,6 +1301,7 @@ int blkid_do_wipe(blkid_probe pr, int dryrun)
 	const char *off = NULL;
 	size_t len = 0;
 	uint64_t offset, magoff;
+	int conventional;
 	char buf[BUFSIZ];
 	int fd, rc = 0;
 	struct blkid_chain *chn;
@@ -1303,6 +1337,11 @@ int blkid_do_wipe(blkid_probe pr, int dryrun)
 	if (len > sizeof(buf))
 		len = sizeof(buf);
 
+	rc = is_conventional(pr, offset);
+	if (rc < 0)
+		return rc;
+	conventional = rc == 1;
+
 	DBG(LOWPROBE, ul_debug(
 	    "do_wipe [offset=0x%"PRIx64" (%"PRIu64"), len=%zu, chain=%s, idx=%d, dryrun=%s]\n",
 	    offset, offset, len, chn->driver->name, chn->idx, dryrun ? "yes" : "not"));
@@ -1310,13 +1349,31 @@ int blkid_do_wipe(blkid_probe pr, int dryrun)
 	if (lseek(fd, offset, SEEK_SET) == (off_t) -1)
 		return -1;
 
-	memset(buf, 0, len);
-
 	if (!dryrun && len) {
-		/* wipen on device */
-		if (write_all(fd, buf, len))
-			return -1;
-		fsync(fd);
+		if (conventional) {
+			memset(buf, 0, len);
+
+			/* wipen on device */
+			if (write_all(fd, buf, len))
+				return -1;
+			fsync(fd);
+		} else {
+#ifdef HAVE_LINUX_BLKZONED_H
+			uint64_t zone_mask = ~(pr->zone_size - 1);
+			struct blk_zone_range range = {
+				.sector = (offset & zone_mask) >> 9,
+				.nr_sectors = pr->zone_size >> 9,
+			};
+
+			rc = ioctl(fd, BLKRESETZONE, &range);
+			if (rc < 0)
+				return -1;
+#else
+			/* Should not reach here */
+			assert(0);
+#endif
+		}
+
 		pr->flags &= ~BLKID_FL_MODIF_BUFF;	/* be paranoid */
 
 		return blkid_probe_step_back(pr);
-- 
2.31.1

