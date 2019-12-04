Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCB911248A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 09:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfLDIU1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 03:20:27 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:32819 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727526AbfLDIU1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:20:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1575447628; x=1606983628;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=13Xj/2Q3e/31YLvSZL3B4rqcPrjvoVC0rWnzkBnhSLo=;
  b=P8QxwLNDI+bJjRcmJp1JFZnFS1+T7HWAELUdwFR2FtfwYa6DtPEX/dV6
   h4+njsGvrzoE3+hJGG7JPxAnI/WHFEUIS1d0+X2er4NoiENM944hi54E8
   r8H+o/TRgJxdfHzT4DgnuAkVmMX8kbVp3OyhlIqaIZ1wNsaKPDpREAVtg
   r5xHIaE45GoMjVQbPCjyAU20swFO/zJQRYAES4WzvFd6dvZJvXGThiOtY
   ma/leiBmMW6YVUiETPuMhMh9FzwbGpRTb+29YABN+sX6svbmqdcInDB7h
   wmlAhEn+LdW0Q7jWsreAZ4ex/i9CqK1KS4S3RXYk0FWBcRrOrZA96EIR9
   A==;
IronPort-SDR: GvXXMJ8PFpudt7x8tZvYjQY4SSWsEtKtnOye3cTERuE8CzRXkMcifLieu3p9RWFV2ebr+hc9K/
 4O30XzQnMVm+9MyZ+gLEOhXZmzjEszPE4N0mE7ZfwkUrdI4RcRTc+F9Um2ekaQpAYBxZRyvtey
 4irhBo/ReExfgaZi/vna3NJV+Dpnf70Fbls4lhaeMrLBs9G+pTPnQ2isLWaNtsFVIxgMmClA5F
 WO7dlMhy9nmZUFu3mDMKmOLgh0xH6vbTgOMAeWyIcMzTKZzGpaeQCeisc6U3kqFxOei2g82nmF
 fFo=
X-IronPort-AV: E=Sophos;i="5.69,276,1571673600"; 
   d="scan'208";a="125355133"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2019 16:20:27 +0800
IronPort-SDR: 3Dpfe6Ilx6l7yGCVCqIckNqoz5nDdnoJmHe6syjIWmSVfpilN+kuog2xX0cWD0wfc3MmGjAL+O
 ACorQ7vrO/gkbTQ5zEjub9qa4fMKaGQ1uw0GNCPBNTu/vXohYhdGCMUBnIcuA+5Qq7ZXX5AJIV
 3ml+fWJXdEuXeJpGLiCgnK7SZ/yVvbRKGiimAO3JGRDxcrT06SgyPKoHNZPRniLZFxcL/LBnZt
 sTkyaoqDOpXm1osz1p+QSHLUT+YusJrpXDrtdbmpaGckkx7pWqTV/sMG76ZXYGRrqqcEEuhGUt
 KZZjoWvgDHU0DwE4DctW8ycY
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 00:14:52 -0800
IronPort-SDR: NvZG6aFfXhkQl4+OfEo0KxqnzfcGolAes1NmOIyJ1/FMzhixOds6RAvXOv//7TjTkmCWE6BzBg
 Aq0XtToJzxG45ExLJJyZ+lJ9EYqQDyDUEGFS9sshIY/1eUEzoUGzzZqSyNDMiOvdAgYoRYnDbe
 LZPttHCQFzCjHAnyD+Obe2Zs1CK0KSg/KtiMCt9UWVVHG8GVvIJlLGQgETgHCAixIWWc881JQk
 oSwQWG2+aaHEZN+9wjre6p7dY3iS72PdbC3FEaHle7FysWe1N7PwHnpDy2tO3wyncO8ftu7N/3
 xPw=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Dec 2019 00:20:24 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v5 28/28] btrfs: enable to mount HMZONED incompat flag
Date:   Wed,  4 Dec 2019 17:17:35 +0900
Message-Id: <20191204081735.852438-29-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204081735.852438-1-naohiro.aota@wdc.com>
References: <20191204081735.852438-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This final patch adds the HMZONED incompat flag to
BTRFS_FEATURE_INCOMPAT_SUPP and enables btrfs to mount HMZONED flagged file
system.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/ctree.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index cba8a169002c..79c8695ba4b4 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -293,7 +293,8 @@ struct btrfs_super_block {
 	 BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA |	\
 	 BTRFS_FEATURE_INCOMPAT_NO_HOLES	|	\
 	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID	|	\
-	 BTRFS_FEATURE_INCOMPAT_RAID1C34)
+	 BTRFS_FEATURE_INCOMPAT_RAID1C34	|	\
+	 BTRFS_FEATURE_INCOMPAT_HMZONED)
 
 #define BTRFS_FEATURE_INCOMPAT_SAFE_SET			\
 	(BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF)
-- 
2.24.0

