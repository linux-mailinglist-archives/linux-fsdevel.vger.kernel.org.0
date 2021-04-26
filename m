Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49ED136ABE4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 07:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbhDZFvr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 01:51:47 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:39184 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbhDZFvp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 01:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619416264; x=1650952264;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2v6v9dFrHyJXFtURrmhrQwKWuTiMXxzPNztQoJ8Dox4=;
  b=Wub+XQyKWQPXhYOMIw8HkmO6Co0AxRfqH8At83bzK+wwdAIx00V9y0GC
   rQNMPGffa+LXOYHnLhX+M1MZvkyc6CFgrQU4MFD0gN3f2QdJmY4ABpp1n
   1OpiD25D/L2X+S8qQGCH8fqQklzDsOMRxyZDtK17m9ur8F+rzgr3ysd6t
   BVGqB16+Y+iM8s8Vx6jBpkhE50jCdI2aq5gOh1fc+xrQP/ji8HP1OFDrV
   j0iK4lTCZFYgaSw0jZN400PGnPsVFxGy36uigpWx6DeMCJn1hjtqEXfUb
   I1b2lkafGujpcsCBTH6MMlDFbchLqJ3yFqJqC6GMqUR7OkXKv/I5wrDbO
   w==;
IronPort-SDR: 87kwVkNPLn9ogjv58j/HnFDyj9FnZgxZD75HM7LFlJXbndD1ZlOqeuVEFO42/fCvQlOSrYbsOl
 xonKZrrmgeGGRRhTH26zdTDNY2MRHq3C39wmZp+BaFsn299pBBSt42bY+MszqPRV1wD2CusoHp
 1Ek0IL1mH/Gbug42W/ebjbWiX4WZqtXJZu5YcklMWviriahOqPPtjHGGDItyoEInwzow997M5Y
 r64t7JuRKe+xkT4e5oOyG70WsFwEsrjLr/oyWxwzgvk23fTulBk3NZ/UDhbw8uun40R01rDq4q
 rec=
X-IronPort-AV: E=Sophos;i="5.82,251,1613404800"; 
   d="scan'208";a="170785779"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Apr 2021 13:51:04 +0800
IronPort-SDR: 0bS6P6wQ9PVgbLSIrhGQM8mFb5rxj8duy/FvvriSmh3Eh2qILXGUM67KpjP1tkLl+J1z/xsoye
 SWBzKn/HpY4TwXxoTgrDUgo/8iHWvM3HxoLfI2QhkakG77uObNzrevdDpTJAzJ4RuwM47jiSSx
 7fjcHD/EHhVDHu4cAkZjxE13w3td9b3U7r7MLFAIaerM8hY1JAiHYf4WADuLzOUDaeezRTn7pA
 oN7zN0j+IyAsEBgF3eLbqewSrVBtz/CqZWPsHGdJggoBX1lU7yLcJd95NatZnIACbwXrmR0k8/
 mK7eUyEWnlsXr4t1WcVLCNbp
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 22:30:00 -0700
IronPort-SDR: Qe9bm+lQ5nVLK7ScSetW1PFqhqkSBo3MRKz4ypkwoIP5y+jWLp+BUicxwo2SbScTUX3kjSyQJA
 T7ljh2fP9SAPboqM4f6SdQpBvlUsTHzKi/72LkODVr7z8CJrdmdBkK02+5hi5EnxlNAeav0tRy
 3ZPJoLg92hAd4fH4V8VfrhQHzYrVfl3L6aL1LWq2O1oiwVtjnECFECZXrXlQWnlM08G3s4ba3t
 BTfCFjDnk2/lqh5AoJWPXb5a0MNtF4q01DnfyfwGogS5aQ1+Cp/fbHcYv0Nd5SGEp0GsdFzBFT
 Rek=
WDCIronportException: Internal
Received: from bgy2573.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.58])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 Apr 2021 22:51:04 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 1/3] blkid: implement zone-aware probing
Date:   Mon, 26 Apr 2021 14:50:34 +0900
Message-Id: <20210426055036.2103620-2-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210426055036.2103620-1-naohiro.aota@wdc.com>
References: <20210426055036.2103620-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch makes libblkid zone-aware. It can probe the magic located at
some offset from the beginning of some specific zone of a device.

This patch introduces some new fields to struct blkid_idmag. They indicate
the magic location is placed related to a zone and the offset in the zone.

Also, this commit introduces `zone_size` to struct blkid_struct_probe. It
stores the size of zones of a device.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 libblkid/src/blkidP.h |  5 +++++
 libblkid/src/probe.c  | 30 ++++++++++++++++++++++++++++--
 2 files changed, 33 insertions(+), 2 deletions(-)

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
index a47a8720d4ac..219cceea0f94 100644
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
@@ -177,6 +180,7 @@ blkid_probe blkid_clone_probe(blkid_probe parent)
 	pr->disk_devno = parent->disk_devno;
 	pr->blkssz = parent->blkssz;
 	pr->flags = parent->flags;
+	pr->zone_size = parent->zone_size;
 	pr->parent = parent;
 
 	pr->flags &= ~BLKID_FL_PRIVATE_FD;
@@ -897,6 +901,7 @@ int blkid_probe_set_device(blkid_probe pr, int fd,
 	pr->wipe_off = 0;
 	pr->wipe_size = 0;
 	pr->wipe_chain = NULL;
+	pr->zone_size = 0;
 
 	if (fd < 0)
 		return 1;
@@ -996,6 +1001,15 @@ int blkid_probe_set_device(blkid_probe pr, int fd,
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
@@ -1064,12 +1078,24 @@ int blkid_probe_get_idmag(blkid_probe pr, const struct blkid_idinfo *id,
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
@@ -1079,7 +1105,7 @@ int blkid_probe_get_idmag(blkid_probe pr, const struct blkid_idinfo *id,
 				buf + (mag->sboff & 0x3ff), mag->len)) {
 
 			DBG(LOWPROBE, ul_debug("\tmagic sboff=%u, kboff=%ld",
-				mag->sboff, mag->kboff));
+				mag->sboff, kboff));
 			if (offset)
 				*offset = off + (mag->sboff & 0x3ff);
 			if (res)
-- 
2.31.1

