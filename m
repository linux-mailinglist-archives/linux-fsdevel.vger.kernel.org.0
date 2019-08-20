Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E19D095641
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 06:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbfHTExK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 00:53:10 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:11098 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728206AbfHTExK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 00:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566276790; x=1597812790;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6o1gldu8mLQ/sEw6Hc3j3Y+Xm+tfLgqyimdGRfehMrY=;
  b=OEoa4SsawK/Svjs3Hhz/w0cJP7zFcHzY35teOO5w4k2uqryhl5zxcTz3
   0jMRI+FFOqVRADS+f/eKw8Xtw4+Vdr2a/JSvaOmyR6aA8MP8Vu3CvSTJg
   zKKLr025TBotGMjerO1QgB+gwlapbuOHaiMkVUNqC4849q69EMJLx5wk6
   I51KwWkdqnMsAROJcDnj9QU4JO/2NZSs2hHZ9XOU3s0kJ7ndsxYufxecj
   RmkMImDOh50vKGzJmxysRZ7xoitINXWUcya/9AjWYEikjLdKPmVvKyWla
   doj+K3+hn3Y2Qoq1JHu+2E8cyNo+2nz1D9q8rUiIIiECrm/zFsfmHJD+M
   g==;
IronPort-SDR: 1Eq83y2IqhZU07NKss5kgPZzmYYtlSUhFCqYoTy5AuCR0ZW52Kfi3ZkHBxMzeqRv4u19bnGpp0
 rTeSkyACRCkclwk22AApF78PFxxP19C+vDscc4LGvF4yxaH4V7s7TiTUB+TVxDWTFZ9yuasNLw
 ieIwjk4NcFKNDPfqVxkz9iL+tnGaxbYhxRouXM36rHCRw/JPZN9z/KTmmFO8ne2EXcNeuj72TH
 j0OOTpHyoy4VMS4D20QzityApgLuBNUYCWBy39LPxGegd/xaV8qrQGP5M82bzvCRAFPt9UTvDL
 gUE=
X-IronPort-AV: E=Sophos;i="5.64,407,1559491200"; 
   d="scan'208";a="117136287"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Aug 2019 12:53:09 +0800
IronPort-SDR: XmAOGXeFtaUBDTxU1nHe86mZ+Q/GMwtTXlpSLRqHdcVVyGEIO/+4i+ajNE1wbWniqbhKYyH8z/
 yR+f9FOZ/0ItCPj0kIO/J3BLDLLSgp+lSaBezlANVLk0VHHRGFIjtgPfwcMjD1FFa9d/BFsQ31
 Gh2iad/S+DXIBvdWc1HL3DcdNhf3ls5erHTvQEIsoc1dls5Pqy3A+k7XY3FjViQTseKKyXHUZa
 23HZG1zSA2TdIAZndeQTrdv4RUoyVG9Yrw7heWHjCm9EwIAcwk8CpIvnGADslRox4vii3/9rQX
 cEDo97gHEJg3FfylHFZNGVRo
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 21:50:33 -0700
IronPort-SDR: 6y+7ppOvnT2w3lX3jCqoq1rBA0qLVG0ODTiNzR8yb7OMqa+pI5ADEo69u5FtnldLtCQiMaQmYz
 Pg4IRwdpxe1HkgAWq8EBZEU+jZiB8MTh5jqpKBt+z0sOd/XDF/VkT+iQNNIxMBA5pTCvbCUkhB
 9X39yr4kBFHC/YR/7kziYoznTwnK+YA0Dkc3pprgf8dsfFirDG5QiGzLl/odpnGYGNiGO515L8
 DDTIuF00Cp5oVmR4hWTwCMxBWdCpIJLrt93ZMeYqZGBTDs28Lnfc1o+BHchAQy3dMiT0Ja1kcP
 Yc8=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Aug 2019 21:53:06 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 03/15] btrfs-progs: build: Check zoned block device support
Date:   Tue, 20 Aug 2019 13:52:46 +0900
Message-Id: <20190820045258.1571640-4-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190820045258.1571640-1-naohiro.aota@wdc.com>
References: <20190820045258.1571640-1-naohiro.aota@wdc.com>
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
2.23.0

