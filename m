Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87B631124CE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 09:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfLDI1f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 03:27:35 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:1552 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfLDI1f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:27:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1575448075; x=1606984075;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=La31vyTc1D4i+NcSd8jwSvvTchAP74R1Y3emgnrp0iU=;
  b=jnKMPKiqbZB6ZurGxqOMPL1Lj6EIVPPm3MII78bICpHZzOLSDsR58SI3
   RF6lPVsvAmiLDQjp9n3dnhf/AkCHLl4j3gbz3g1PghkQtWCR5GGjLZYLd
   5HSi+Hsl6sOJ+fW5lZXyPcpygQZrzAso2ckePFFAMn3t4i3EGZtPBEcY2
   rVwMWDrBSHGRK4+iZ6LmU+PtytM76ADGYrxNyqr+LHXfZOJaM2d04/DII
   zVMASHYcIoChvEWNcmBZC95eBSljNDeW2fDYXVlfhKXSyqQSQn8VK2M+0
   fk6I6e/zAB6u/84gFZ3gtOkfGl5N1PVAAQi7l8QbYr+jWFsLyM0N96qaD
   g==;
IronPort-SDR: 4T2uK/wTNbyfoeTuqHY8rCzuT62D8Cqajo0iW0Jtz4b5nZaRLiA52s8BXqYYUlLIAlHhhNWwdX
 uWclBNEU7J7dKeq1arFme9eEN3jKbuq24NGGYZ3HXtZ8AZgXA8lSvV29IGoevr94NCzCi+4z0d
 /1gna5s6zijtkYR+mMB//+E0Hn5O2w4ngBgL32L9v4fZJIQN5Y+aUgqpALLEK4Q/L14yzRAYAF
 7CVtULfMEkMeT/Y0G97XxyWM88SP1c8z6rvGLMqKhb5Qh7Dd5Fg6rlxTlKHsSWOMdKF6Pstm+t
 6cQ=
X-IronPort-AV: E=Sophos;i="5.69,276,1571673600"; 
   d="scan'208";a="226031732"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2019 16:27:55 +0800
IronPort-SDR: EpYxD1Fi66XANC/dKiPDwH2Y+Q2vbm6MErOGT/FsVjsfql8c1ErVlDsff7DvqvCidybR3bVVzw
 Zx33HaK4ei2X1NbKGq/zzxYFgK9zEHeZ8v1fQMoYn3O7ZPlT0TwG4Wyr3Umb7p6ykNIFeeafhA
 VRQBXkQEeRt2xzAwMLd3tZ8chESHxKFFnfJw1xP1MBYSDk3aU4IClBb6RG9CS4LaXiyHzYFo+S
 gvLHFkdcL8ymj1cwrpqPG3gdce4WChaMXAzZe6reZdeTTPFXGueW0MhZV4Kn1NgW9rzPiI8gca
 pLxgO78tGcPY3e0FimsxzDkE
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 00:22:22 -0800
IronPort-SDR: uqKWQE4e0U3hJKlPqJv6dUUOUiGxEdp73nYGS0N1syuKD6SuI5NFQQdYgwT2EEBLArqhcHm8Q3
 jcJTr/czKUTDH9qgIRtbEh5URfiO/fQddjqdGK/vjuCMAfYRKqUezMc6ucKGIewoSBbysMVrit
 H5ToJPV+8hCdatpa3YSH5cAnq0jN8kqrnMtTKZ1Nlfgtwq5Uol9Lj3g4LB1nmvXG0G5zrcj1A5
 +Hq5ZPEeMsK+0c+wIL2g7Z487LAjnSFTp3UctcXBfbLPJImgvGldfiR3mGTkrQQxPmh0sLPR8/
 N6g=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Dec 2019 00:27:34 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v5 03/15] btrfs-progs: build: Check zoned block device support
Date:   Wed,  4 Dec 2019 17:25:01 +0900
Message-Id: <20191204082513.857320-4-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204082513.857320-1-naohiro.aota@wdc.com>
References: <20191204082513.857320-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If the kernel supports zoned block devices, the file
/usr/include/linux/blkzoned.h will be present. Check this and define
BTRFS_ZONED if the file is present.

If it present, enables HMZONED feature, if not disable it.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 configure.ac | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/configure.ac b/configure.ac
index cf792eb5488b..c637f72a8fe6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -206,6 +206,18 @@ else
 AC_DEFINE([HAVE_OWN_FIEMAP_EXTENT_SHARED_DEFINE], [0], [We did not define FIEMAP_EXTENT_SHARED])
 fi
 
+AC_CHECK_HEADER(linux/blkzoned.h, [blkzoned_found=yes], [blkzoned_found=no])
+AC_ARG_ENABLE([zoned],
+  AS_HELP_STRING([--disable-zoned], [disable zoned block device support]),
+  [], [enable_zoned=$blkzoned_found]
+)
+
+AS_IF([test "x$enable_zoned" = xyes], [
+	AC_CHECK_HEADER(linux/blkzoned.h, [],
+		[AC_MSG_ERROR([Couldn't find linux/blkzoned.h])])
+	AC_DEFINE([BTRFS_ZONED], [1], [enable zoned block device support])
+])
+
 dnl Define <NAME>_LIBS= and <NAME>_CFLAGS= by pkg-config
 dnl
 dnl The default PKG_CHECK_MODULES() action-if-not-found is end the
@@ -307,6 +319,7 @@ AC_MSG_RESULT([
 	btrfs-restore zstd: ${enable_zstd}
 	Python bindings:    ${enable_python}
 	Python interpreter: ${PYTHON}
+	zoned device:       ${enable_zoned}
 
 	Type 'make' to compile.
 ])
-- 
2.24.0

