Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB24E35E8E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Apr 2021 00:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347184AbhDMWLu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Apr 2021 18:11:50 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:59043 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347217AbhDMWLs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Apr 2021 18:11:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618351906; x=1649887906;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gMLLv7zxga9NpYxzVeX9/lyMs74L5yS+qRs7J0Cu344=;
  b=rBDD4ohw9uz6h8R/Y9boDLx8CWEskLnXgSf4wWmg50ahUnoDbIX018U3
   6yln7w1HZSRxC7nylmESi2VRh/EBcRS/1y6kXpV+YwFePN3/zIqI9LfT8
   B+vLrsMi3YqsYhKfQGrnaUBeFK1/pfPmzgaGzq9CmHQ1flJYKc9jZwEZC
   RVd+fb3Yf1kTuyY00b5XDTA0SQL8EAR46FNtXHnPZwgWnUwVUdgv8gNvw
   aLNOynivB2rig8ppjrGaFCUOiUGjccF2GNOMvUdEnxz6pJz5HNsYBUqx5
   E8uJafUfwdJOzA/AdggAxW7xqHiMYJ/JZIG6gHhRagTUlsThN5prLMedh
   Q==;
IronPort-SDR: O5l7iTatSomjV/vDxD6RzGdr32+BiVnRo4hFSadEHg58lwi7Mbf2uZCvNpak/ahzB95FbENLQH
 PtYwQa819V9UKW8Hn34tJrX/PVBgh/9MU9xt2u2IUCrgawZGM90pS7e2KtLZMqpOs1VeTzWqX6
 4dsgQUGnnCD7XGoRIFn8DyjOrvQzpRk0OZqPx7Hcsv9hycWEnHgec/0xxaFZBR2hvIKNjHhEe2
 r8oJTm+MmCDgaFegYzAzpt3iO2dMwy596XkWNXm4WOZQGay+xcSzb7AgmKQ6JEDiGcTO5dbD+K
 DA0=
X-IronPort-AV: E=Sophos;i="5.82,220,1613404800"; 
   d="scan'208";a="268872447"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Apr 2021 06:11:10 +0800
IronPort-SDR: oTBJnWRI04NLhCiQWt+MTV0TVinvTM04jvP4HcPmcskX+yw9jtsZhRTyc3lf8UD4yzuHOqSTra
 Iz9c5DrTuLx12a2LSjGS7kYhhnVVoUhAT7ADeh7vb4JxJXQHZuI4eqYE3hvOcLtTZClVJVSTE+
 yb9nf3Hkfi48S9U7IN9PS6yFMZ1K1BdIwuxXEYpS9gagn6xIY3KTQdsWvznWCfzbLZgNU5qcSP
 8+ieuLVnSCfc1+rIQNONJDj1NKl/ogq+XSFcASDDMqGzx+JqzAXWulfYAQdsYLIJdQIHlTIrjY
 DXvgFZ1439lo4XWU+OyG4HdE
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 14:52:00 -0700
IronPort-SDR: 6F17vYSiViBhohpOk8+Z2LMTtu9dBa9CZPjzWUVlz4rATXIYVKPeG0P3va55VRmxWsyipZH/LJ
 YJ35UwE3OINdx3riTeIaZ4EM3kqK5jLEI+xt2ex9KlRAuDk8Asuwm86/2G9MUqOwa8PXCxSlof
 ok6QR8BoARdqm3wjlQirXyZ4GalyiSQiFJ1Adc9IBTOjNx7VyTDQdeiA3Tuaf/VIryDLPX3HD8
 JxjamZy8YMnUWDnlWtmWxx/TMexIQfI3c97eZEelJMie0r1KoTXRW5wqTBKVta64fIEbxfKZyO
 NcA=
WDCIronportException: Internal
Received: from 39xlxy2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.53.108])
  by uls-op-cesaip01.wdc.com with ESMTP; 13 Apr 2021 15:10:56 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 1/3] blkid: implement zone-aware probing
Date:   Wed, 14 Apr 2021 07:10:49 +0900
Message-Id: <20210413221051.2600455-2-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210413221051.2600455-1-naohiro.aota@wdc.com>
References: <20210413221051.2600455-1-naohiro.aota@wdc.com>
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
 libblkid/src/probe.c  | 26 ++++++++++++++++++++++++--
 3 files changed, 30 insertions(+), 2 deletions(-)

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
index a47a8720d4ac..102766e57aa0 100644
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
@@ -871,6 +874,7 @@ int blkid_probe_set_device(blkid_probe pr, int fd,
 #ifdef CDROM_GET_CAPABILITY
 	long last_written = 0;
 #endif
+	uint32_t zone_size_sector;
 
 	blkid_reset_probe(pr);
 	blkid_probe_reset_buffers(pr);
@@ -897,6 +901,7 @@ int blkid_probe_set_device(blkid_probe pr, int fd,
 	pr->wipe_off = 0;
 	pr->wipe_size = 0;
 	pr->wipe_chain = NULL;
+	pr->zone_size = 0;
 
 	if (fd < 0)
 		return 1;
@@ -996,6 +1001,11 @@ int blkid_probe_set_device(blkid_probe pr, int fd,
 #endif
 	free(dm_uuid);
 
+# ifdef HAVE_LINUX_BLKZONED_H
+	if (S_ISBLK(sb.st_mode) && !ioctl(pr->fd, BLKGETZONESZ, &zone_size_sector))
+		pr->zone_size = zone_size_sector << 9;
+# endif
+
 	DBG(LOWPROBE, ul_debug("ready for low-probing, offset=%"PRIu64", size=%"PRIu64"",
 				pr->off, pr->size));
 	DBG(LOWPROBE, ul_debug("whole-disk: %s, regfile: %s",
@@ -1064,12 +1074,24 @@ int blkid_probe_get_idmag(blkid_probe pr, const struct blkid_idinfo *id,
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
@@ -1079,7 +1101,7 @@ int blkid_probe_get_idmag(blkid_probe pr, const struct blkid_idinfo *id,
 				buf + (mag->sboff & 0x3ff), mag->len)) {
 
 			DBG(LOWPROBE, ul_debug("\tmagic sboff=%u, kboff=%ld",
-				mag->sboff, mag->kboff));
+				mag->sboff, kboff));
 			if (offset)
 				*offset = off + (mag->sboff & 0x3ff);
 			if (res)
-- 
2.31.1

