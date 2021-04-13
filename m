Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8572835E8E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Apr 2021 00:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348628AbhDMWMI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Apr 2021 18:12:08 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:5817 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348615AbhDMWMG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Apr 2021 18:12:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618351906; x=1649887906;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/cFInViD5uKiWQWCCh4dWTsaKAByi7k1gtbm9ZK+N4E=;
  b=XdlFfOIaMx1Q+U+v0eckWXO795f66SwUycb+ZjhqC3ViqJkbi5+EuTI7
   A79maIuUOLRkVUXndu4VrMRiarFxhcd59hiBmbAVJMm6cmMZBnbXaDuoP
   /Mwnm5rv8iZRndCstkEr40SVOr6qWi9SVjROnuo19UFrSezrlOpt2rbXL
   xnfZDgD+MR6yM3gaAQJhrkuyxyoge2DMVgPjvVcWEkcXFjZEImOqeB5p/
   c8W9XpycRd1Fv6oikzpLy2sCW+0/KIlTPp7TkU1dUVFreHwXUMpyOcjVk
   P4gBvsqN3vVJE2wpcsErMkoyfeRJo2fKDYJJN2Jl4xNedlL07ZWyd1hE7
   Q==;
IronPort-SDR: s+6TtNmoCSsinWUJtspmpQm9v7eXTWzunMd/3J9arRy2gquC/OndWCI3mQ0zhWGSTUqpQDlCoa
 PzwrpIHpBRWqz82yo38xs2UqtL1m1+gK3iI6fED0pZWNbic6nVJxdb4k0yFdNUgt9FvzvnfHnB
 hGuGhX1A7PKQupjhoCBh8VQlkNZGxrQGRQz4r8N3JANCsX3ZOf5ohbdAxsPfGwI1VWsw3U/bVZ
 jSnkVdx+aIBqjruPSONPALS16eSEtK41r28q5hOsyE8eTbF23Qo2WuAxWvMLqi0Tc08wBNl9Tr
 ih8=
X-IronPort-AV: E=Sophos;i="5.82,220,1613404800"; 
   d="scan'208";a="164254976"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Apr 2021 06:11:27 +0800
IronPort-SDR: U+3K6gRHqMzFrxx6B9J0/UHzn3BY3gqEg0uyVUpV2s3oPVjL8lzGCqOjjpHoXhgP1iy024VPKa
 AifezWSAT0yx6VOGy/tpAMKfGR1vOWVC2NBwIjx3VIUTH1EwqtYyJVhwnUXaZElclFJkSNTHOP
 y72yVRjhR8Tf4sDoxliDjl0wF+6jnkGiEsh/q+kRaPRPJcFTO9at3F0s4Az00OLWx851TfVIJF
 KCQfTCuMmWBp4o/gkXYx/DDT2HXX/mRIQI0BzBn932DGv4Dr8GVFvPXcm02tzyLPYSoRDDov9M
 eMMoyydQ/8SabkW3DUd65q/t
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 14:52:04 -0700
IronPort-SDR: DLOAUPh1EDMXm84y7UMyBlzr40f98K8xkvsxdPUoBhO2UXt7CXjOK8l6NZaquup9uGO0l/CekZ
 EOAs9xEZKh5e7YRbBjTaTg/ET/pzewalF2Yc0+AjJfTCiWTWQ9eBsmXHfozvlPt4W+voevGdNM
 isOJshnzawZvYnH25smuJyVhD9xqblC0jnlvMQFFOErzWY7BVyLedwEBmkK7cczksuyY2fk9b1
 +kN5dnvqWdhHUwXVHzL6uoqE/4hdxT8ptI/EFZkK6yAZq9e4O/q2Jq26M0P/Hm4y2pthk+/Fet
 o0E=
WDCIronportException: Internal
Received: from 39xlxy2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.53.108])
  by uls-op-cesaip01.wdc.com with ESMTP; 13 Apr 2021 15:10:59 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 3/3] blkid: support zone reset for wipefs
Date:   Wed, 14 Apr 2021 07:10:51 +0900
Message-Id: <20210413221051.2600455-4-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210413221051.2600455-1-naohiro.aota@wdc.com>
References: <20210413221051.2600455-1-naohiro.aota@wdc.com>
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
 libblkid/src/probe.c | 65 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 59 insertions(+), 6 deletions(-)

diff --git a/libblkid/src/probe.c b/libblkid/src/probe.c
index 102766e57aa0..7454a14bdfe6 100644
--- a/libblkid/src/probe.c
+++ b/libblkid/src/probe.c
@@ -107,6 +107,7 @@
 #include <stdint.h>
 #include <stdarg.h>
 #include <limits.h>
+#include <stdbool.h>
 
 #include "blkidP.h"
 #include "all-io.h"
@@ -1225,6 +1226,40 @@ int blkid_do_probe(blkid_probe pr)
 	return rc;
 }
 
+static int is_conventional(blkid_probe pr, uint64_t offset)
+{
+	struct blk_zone_report *rep = NULL;
+	size_t rep_size;
+	bool conventional;
+	int ret;
+
+	if (!pr->zone_size)
+		return 1;
+
+	rep_size = sizeof(struct blk_zone_report) + sizeof(struct blk_zone);
+	rep = malloc(rep_size);
+	if (!rep)
+		return -1;
+
+	memset(rep, 0, rep_size);
+	rep->sector = (offset & pr->zone_size) >> 9;
+	rep->nr_zones = 1;
+	ret = ioctl(blkid_probe_get_fd(pr), BLKREPORTZONE, rep);
+	if (ret) {
+		free(rep);
+		return -1;
+	}
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
+
 /**
  * blkid_do_wipe:
  * @pr: prober
@@ -1264,6 +1299,7 @@ int blkid_do_wipe(blkid_probe pr, int dryrun)
 	const char *off = NULL;
 	size_t len = 0;
 	uint64_t offset, magoff;
+	bool conventional;
 	char buf[BUFSIZ];
 	int fd, rc = 0;
 	struct blkid_chain *chn;
@@ -1299,6 +1335,11 @@ int blkid_do_wipe(blkid_probe pr, int dryrun)
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
@@ -1306,13 +1347,25 @@ int blkid_do_wipe(blkid_probe pr, int dryrun)
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
+			struct blk_zone_range range = {
+			    (offset & pr->zone_size) >> 9,
+			    pr->zone_size >> 9,
+			};
+
+			rc = ioctl(fd, BLKRESETZONE, &range);
+			if (rc < 0)
+				return -1;
+		}
+
 		pr->flags &= ~BLKID_FL_MODIF_BUFF;	/* be paranoid */
 
 		return blkid_probe_step_back(pr);
-- 
2.31.1

