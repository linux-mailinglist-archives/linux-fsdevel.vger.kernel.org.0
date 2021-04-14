Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74FB335EA78
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Apr 2021 03:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345993AbhDNBeX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Apr 2021 21:34:23 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:18400 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349037AbhDNBeK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Apr 2021 21:34:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618364030; x=1649900030;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ysMS2Kknxl6RT6GJVQKK3OyY+VYyJdNtAln3ZU9K/js=;
  b=lUHPbvZj0mZslJ+YzQKFtIMZ361q41QEmGEhU/xL2dbEM1Waz+dyg6y0
   moefvVvnQmtDLO8OWMy6MhmKSfEfc26SvdxMI9plsoeZaAoh5Uv8tWwEm
   L3KHUTd7s+tAY61bDObp2BZGSVYAegcUwm4tdmccd5hUlUcTj90R6mgAF
   I7NXBEFwOW1aZMxN8bhAmD7MekyCT2xg9yE357vlYyrQvefJ4iPEYE2pq
   fK+slGJyRnEYocqjkpas02IEwiFWYC5pTqnIaEqLGlz0Q3ZBrrCDy5jXV
   vsErBM2iZCi2RPJSCR2nKemCt8U6oKNTCC8/nB/2m8jz0+tiJbTs2+NpQ
   w==;
IronPort-SDR: OZm9K9CleR3Wu/4XUvJD9GkJ8fwqmO2tzcR+SMvewoThEsEyIIphj2pBQArZOQ+Nc7rHhCRlNK
 eHfVIcEdEtdLUaoYI4EuMTmUQqfjgAq2liq0tEZw5irZmf5lsMQxMTJpkaV2wCUsWdVsuLFaDP
 d1tw5ErqmsjcaQRaCphhGYq3I5vpFx7QZjAP46snY/rzjy4tMYpJW0Lx851m8XqwFCu+M2lprL
 pEWb5RWFrPv5Znp5b33CXDMGyZ3gxYwI4D+ByatTewmISJXS51cnFFRMuj34soLPGkutDRoblj
 7pE=
X-IronPort-AV: E=Sophos;i="5.82,221,1613404800"; 
   d="scan'208";a="169210804"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Apr 2021 09:33:47 +0800
IronPort-SDR: t/TVvgCgSiFx+dCUSDnGTaOmDm5JT7tWP7F8ZCm3J1wTwLhDV8ftSZrfqBlIEL21F8Yr88dddH
 mF9H9/heseL38Q8AvLa1cn+glQqsB1qy37nhPFHPVayXTsnxvLIvVgeNXeFuYtlBOcLue4TsWl
 dKw21hyzgum0urP0+9/UvQDKwnoSsb9q1FQHea3chCiyONKO9Xte24nJP37I7Pc8Zx/Lbk3YYt
 lWLiun+tpLx/nEbpJ1C0WuOTLDawb1AvIJ4IXmJ0XkuCS87l1ssdA5CYdjWB5m4eygO/JdBpzY
 wDJb7rTLJluRbbS83yHvasHz
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 18:14:49 -0700
IronPort-SDR: N/cfITB36rmpPLvy1J8sWpHrK8IcoFamkC7dluKdztovi+qnsZXvzw6TFjE4oddjvqQHqN2UJI
 oJ3PmXIKWbXm4RnLACnmfKJQk4dqa4eTVqCtGFdXNu0ct/9hA+kcvMdWTk20DhIMAmrBetOltw
 D+GnnqGMh1V30jGRlvwbjKLh5fXdBq+qGks9LEjPPzRy/ElTP8K4dStVwgbXBwtIHP0lub6+uR
 nkJOC/XqiA2dgYow4TFGO3V+TkMRmgfjoE08ZwHuuNI32WsvDNHER4SGvFZPapc3Mo5vH65Iu5
 Iw4=
WDCIronportException: Internal
Received: from jpf004864.ad.shared (HELO naota-xeon.wdc.com) ([10.225.53.142])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Apr 2021 18:33:46 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 3/3] blkid: support zone reset for wipefs
Date:   Wed, 14 Apr 2021 10:33:39 +0900
Message-Id: <20210414013339.2936229-4-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210414013339.2936229-1-naohiro.aota@wdc.com>
References: <20210414013339.2936229-1-naohiro.aota@wdc.com>
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
 libblkid/src/probe.c | 79 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 73 insertions(+), 6 deletions(-)

diff --git a/libblkid/src/probe.c b/libblkid/src/probe.c
index 9d180aab5242..23c3621627d4 100644
--- a/libblkid/src/probe.c
+++ b/libblkid/src/probe.c
@@ -107,6 +107,7 @@
 #include <stdint.h>
 #include <stdarg.h>
 #include <limits.h>
+#include <stdbool.h>
 
 #include "blkidP.h"
 #include "all-io.h"
@@ -1228,6 +1229,48 @@ int blkid_do_probe(blkid_probe pr)
 	return rc;
 }
 
+#ifdef HAVE_LINUX_BLKZONED_H
+static int is_conventional(blkid_probe pr, uint64_t offset)
+{
+	struct blk_zone_report *rep = NULL;
+	size_t rep_size;
+	int ret;
+	uint64_t zone_mask;
+
+	if (!pr->zone_size)
+		return 1;
+
+	rep_size = sizeof(struct blk_zone_report) + sizeof(struct blk_zone);
+	rep = calloc(1, rep_size);
+	if (!rep)
+		return -1;
+
+	zone_mask = ~(pr->zone_size - 1);
+	rep->sector = (offset & zone_mask) >> 9;
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
@@ -1267,6 +1310,7 @@ int blkid_do_wipe(blkid_probe pr, int dryrun)
 	const char *off = NULL;
 	size_t len = 0;
 	uint64_t offset, magoff;
+	bool conventional;
 	char buf[BUFSIZ];
 	int fd, rc = 0;
 	struct blkid_chain *chn;
@@ -1302,6 +1346,11 @@ int blkid_do_wipe(blkid_probe pr, int dryrun)
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
@@ -1309,13 +1358,31 @@ int blkid_do_wipe(blkid_probe pr, int dryrun)
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

