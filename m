Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADE935EA73
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Apr 2021 03:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349076AbhDNBeW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Apr 2021 21:34:22 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:18400 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbhDNBeE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Apr 2021 21:34:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618364024; x=1649900024;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=83kyN5f/gaEoADXr8s+jQJ7fslqUI+KQk9/TLXZBRBo=;
  b=mlECpj3zrJ2/x1Z5CW9xAxvctrMSFgWtbL/iPsqb3TG1xpczgtO7A/Ck
   F9+UIW8MBugNkJsbUl1M49hdG4/psGQ7JYgeiL9L5sjtboCC5JWT5g2o3
   RlZKnT0ilMJyTfi7o4c+9ABPHLqraq0M5rWQNLaDzEKjdLWEv3SpYbLwZ
   Gy/VBupT4K70mY7gtWtc2wU7rljWlTWyUEqfV/1KjgiX+MS9lGXYC7F9Q
   4cmOmMyrBnAMZg6KS4YDfjqnI1hxA3R9tsxEUMjmqLzGVUkjjKOp8vNwY
   pMHXUPpYCfg7s4MG8I22dG6FEaJY1qucUvczRkHn9hO9kBbBsvkQWeK7Q
   A==;
IronPort-SDR: ySYhUrDisXDAIkWzdJjEVCWHVznuEVGDiuryFKvla6/HEyxwTO8AQeNgFuy+kxQ0pnlGkeKU1T
 titKB0NKbIHi0/Sp9/xlPy2Gj4xwv5MDbecC498YNjG+LhvfT1Eq/QIHaP9Y6ejVOO23D4JLde
 a2xR3QbS43zvPBcBpP6gwX8e/k0DVE8x1bOG4fFbTuylbbKf4X/5D2BrJRqiIPd91M6TNuFMKl
 hJV8pGRUs4nRK+BSiejmmR3hrQsfJn4BZy+L8Lo6elBeKucLiHjrCHaKgRAKC5i0PgMSoflCQ2
 7kY=
X-IronPort-AV: E=Sophos;i="5.82,221,1613404800"; 
   d="scan'208";a="169210799"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Apr 2021 09:33:43 +0800
IronPort-SDR: rLWgn+VrCQALg97mW0Ndkt+qISnYihYAXi4weGuMZf4jI5ou9QVjfj0eC8Uzj4ieRNt1bkL5wi
 mWPXeTgqWsJytvtrzvdZl7HiEkg4aOESiQ6fAdgvCJe3Ikx5bP8ElQP6Wry6aM2OifYya+VKHn
 2IlnvKQKWRNZEvtZ6/G/G2O8B9RoYBYEXJmAMilj2WEzRrOD88J7wRdCr7+vfLbOl9Kzm5ujWl
 MGVbibSrBqR5F9umehFko8H6IDZFdsMTWBzidvZgMJFH/dnr2dztCNvHLB77PKZi/1jG2aH6VE
 VPPTqqA7GjhAKC+jIkfypFx1
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 18:14:46 -0700
IronPort-SDR: IvpUHBlcp0DJxhTt2Lwt+nDn3Rn7FiA9B4m/qg8TUxVMcBx0QR5QHvI8NjO93oNNSYTSl9bRgD
 9bB76rMPrSA5/ynjrM0c67hFOAYrLa0bihC2DjHW8t9RvVGGBwFZZiTJDn9AROX30s/ma0k2Nz
 MMfCsIZPO5/vOvs905uE3lqeJNOQH+LgaI8y1aOFNC+qgXEr921mCqr+JFoqMWF1d4UF4tKjWj
 TXcdpFQUP6ke6kE3bGTjhfagG8LMfyImnM6GKgxVW5WLGTfc7DdXQO8wzprAeHyUOzbjZFVKcv
 d0c=
WDCIronportException: Internal
Received: from jpf004864.ad.shared (HELO naota-xeon.wdc.com) ([10.225.53.142])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Apr 2021 18:33:43 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 1/3] blkid: implement zone-aware probing
Date:   Wed, 14 Apr 2021 10:33:37 +0900
Message-Id: <20210414013339.2936229-2-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210414013339.2936229-1-naohiro.aota@wdc.com>
References: <20210414013339.2936229-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch makes libblkid zone-aware. It can probe the magic located at
some offset from the beginning of some specific zone of a device.

Ths patch introduces some new fields to struct blkid_idmag. They indicate
the magic location is placed related to a zone, and the offset in the zone.

Also, this commit introduces `zone_size` to struct blkid_struct_probe. It
stores the size of zones of a device.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 configure.ac          |  1 +
 libblkid/src/blkidP.h |  5 +++++
 libblkid/src/probe.c  | 29 +++++++++++++++++++++++++++--
 3 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index bebb4085425a..52b164e834db 100644
--- a/configure.ac
+++ b/configure.ac
@@ -302,6 +302,7 @@ AC_CHECK_HEADERS([ \
 	lastlog.h \
 	libutil.h \
 	linux/btrfs.h \
+	linux/blkzoned.h \
 	linux/capability.h \
 	linux/cdrom.h \
 	linux/falloc.h \
diff --git a/libblkid/src/blkidP.h b/libblkid/src/blkidP.h
index a3fe6748a969..e3a160aa97c0 100644
--- a/libblkid/src/blkidP.h
+++ b/libblkid/src/blkidP.h
@@ -150,6 +150,10 @@ struct blkid_idmag
 	const char	*hoff;		/* hint which contains byte offset to kboff */
 	long		kboff;		/* kilobyte offset of superblock */
 	unsigned int	sboff;		/* byte offset within superblock */
+
+	int		is_zoned;	/* indicate magic location is calcluated based on zone position  */
+	long		zonenum;	/* zone number which has superblock */
+	long		kboff_inzone;	/* kilobyte offset of superblock in a zone */
 };
 
 /*
@@ -206,6 +210,7 @@ struct blkid_struct_probe
 	dev_t			disk_devno;	/* devno of the whole-disk or 0 */
 	unsigned int		blkssz;		/* sector size (BLKSSZGET ioctl) */
 	mode_t			mode;		/* struct stat.sb_mode */
+	uint64_t		zone_size;	/* zone size (BLKGETZONESZ ioctl) */
 
 	int			flags;		/* private library flags */
 	int			prob_flags;	/* always zeroized by blkid_do_*() */
diff --git a/libblkid/src/probe.c b/libblkid/src/probe.c
index a47a8720d4ac..9d180aab5242 100644
--- a/libblkid/src/probe.c
+++ b/libblkid/src/probe.c
@@ -94,6 +94,9 @@
 #ifdef HAVE_LINUX_CDROM_H
 #include <linux/cdrom.h>
 #endif
+#ifdef HAVE_LINUX_BLKZONED_H
+#include <linux/blkzoned.h>
+#endif
 #ifdef HAVE_SYS_STAT_H
 #include <sys/stat.h>
 #endif
@@ -897,6 +900,7 @@ int blkid_probe_set_device(blkid_probe pr, int fd,
 	pr->wipe_off = 0;
 	pr->wipe_size = 0;
 	pr->wipe_chain = NULL;
+	pr->zone_size = 0;
 
 	if (fd < 0)
 		return 1;
@@ -996,6 +1000,15 @@ int blkid_probe_set_device(blkid_probe pr, int fd,
 #endif
 	free(dm_uuid);
 
+# ifdef HAVE_LINUX_BLKZONED_H
+	if (S_ISBLK(sb.st_mode)) {
+		uint32_t zone_size_sector;
+
+		if (!ioctl(pr->fd, BLKGETZONESZ, &zone_size_sector))
+			pr->zone_size = zone_size_sector << 9;
+	}
+# endif
+
 	DBG(LOWPROBE, ul_debug("ready for low-probing, offset=%"PRIu64", size=%"PRIu64"",
 				pr->off, pr->size));
 	DBG(LOWPROBE, ul_debug("whole-disk: %s, regfile: %s",
@@ -1064,12 +1077,24 @@ int blkid_probe_get_idmag(blkid_probe pr, const struct blkid_idinfo *id,
 	/* try to detect by magic string */
 	while(mag && mag->magic) {
 		unsigned char *buf;
+		uint64_t kboff;
 		uint64_t hint_offset;
 
 		if (!mag->hoff || blkid_probe_get_hint(pr, mag->hoff, &hint_offset) < 0)
 			hint_offset = 0;
 
-		off = hint_offset + ((mag->kboff + (mag->sboff >> 10)) << 10);
+		/* If the magic is for zoned device, skip non-zoned device */
+		if (mag->is_zoned && !pr->zone_size) {
+			mag++;
+			continue;
+		}
+
+		if (!mag->is_zoned)
+			kboff = mag->kboff;
+		else
+			kboff = ((mag->zonenum * pr->zone_size) >> 10) + mag->kboff_inzone;
+
+		off = hint_offset + ((kboff + (mag->sboff >> 10)) << 10);
 		buf = blkid_probe_get_buffer(pr, off, 1024);
 
 		if (!buf && errno)
@@ -1079,7 +1104,7 @@ int blkid_probe_get_idmag(blkid_probe pr, const struct blkid_idinfo *id,
 				buf + (mag->sboff & 0x3ff), mag->len)) {
 
 			DBG(LOWPROBE, ul_debug("\tmagic sboff=%u, kboff=%ld",
-				mag->sboff, mag->kboff));
+				mag->sboff, kboff));
 			if (offset)
 				*offset = off + (mag->sboff & 0x3ff);
 			if (res)
-- 
2.31.1

