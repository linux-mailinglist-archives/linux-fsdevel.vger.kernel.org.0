Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 647899ACA3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2019 12:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404089AbfHWKLO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Aug 2019 06:11:14 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:47762 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404040AbfHWKLO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Aug 2019 06:11:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566555073; x=1598091073;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n+UrDX4m+T4iHtzoCxuskv309A0OFYCB2UEgJ6ooGCc=;
  b=eBanygCoLaS/8PY946JazOyuy1zwA1gLU8OdtEE872pBeL1033IhugPG
   PP4xhkv7iBagCRfBcvXk6ioZ+1N+W93PedqEamK8hcOnfAZMhXE4Y6cJ7
   8U1NOfF1WM/Mn6XyNsPi587/8tB7euz4lJreQ18Jdz/EXHQ/V4cTpNKCE
   pSuBLZflZ/N5wRJXfc2kvGK/ps7ZYPeCsSJRdNHSqQ6zusMgDHE07Hu5y
   1KvPEpT+y1iDBDnvWFGxnqi0I790uTHRVqM3k1W8ShbarxmgYCX+IM4Of
   lckcnsAh9l2jU/JA2XqQHT2xJj8jX624StRXxThpAdJvd/+gTsObJH6UE
   g==;
IronPort-SDR: fkbP/43wVviic4f2w9JY8IOsSVCJNRdvmPaajSFViFIeD7dyE9QFIUHBSfLWVKZm1ksyZVAzNt
 RVcHrwmBvB1NX26rnwPcH6ptIeW3Y5yo2jsXDkGyQ5YuXhbXLXz4SYdnEBXNaumPpa4mxBjaTG
 DzjXOhZ6P7j7ijZkhEZMhVCJa5SJQBX5RFVr1UCFRbxVpFrHQmXI/CbIB5u4fwKImQzO33TX8l
 yw4gtoRVPQxrLsixNUdzd7OOlIbAeu0E+0GbGom7ynxNy6LXIm7gFy+LMGtl/MZ6K+Uf/0C27S
 SNA=
X-IronPort-AV: E=Sophos;i="5.64,420,1559491200"; 
   d="scan'208";a="121096230"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Aug 2019 18:11:12 +0800
IronPort-SDR: ngwc5LG5NO6kBn8wV7aGvtBDdkznWOFjqTL95q4iqDrVy22JZjTnpECX8shaRIerWKesvL8DB2
 hBsMPwwUpW7dZ6TwDLJGnU7xrxHFMtVvlfKtBfczthYCjQa4pjzcbffcmTBDoEDaltq6BA6bAq
 Pz6JNULfkJGBX4oXFf40p8lsFN9GKf2WKdMMpwG13kNIfCprRdIaUc8SCWYHix4iSsPhNIvpXW
 257P/nbrx5nKpZ9paD8Bzoz6VC6BF/sKOKYeZ3ewOCXM/7ouSCDoW/Z7cnpS6PAd7Sy/EjVWJp
 01XztSiSJg6Brmhl263r6S7z
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2019 03:08:30 -0700
IronPort-SDR: Wp7uRQJMEP6FLkPJkhybTR8zIz6p3D0cVan9pX9qBWB5b3xB5gHwh10vPZuWxxlNGfzkrwl9vV
 zc9WSVTljv1FfuwGXo54Z25hlK11iEvYnH9mjP0ixMW8FTJjM5xOBDqK4aSUt5wMo4yYMssGnp
 aDGjjkje0EbNq54P0YZtrQHtuM/mS890TuQ1/uHSU8ACn21kDWYp7f0ZjFYnz1vmjt5oAqX7dR
 uQYcttKANtY4DdUNEym6wi9v+iRM17TH2w4uAvf9N9sR1wcIaeitlsstb6wWS481tcoiDwE8m+
 LZI=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Aug 2019 03:11:10 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v4 01/27] btrfs: introduce HMZONED feature flag
Date:   Fri, 23 Aug 2019 19:10:10 +0900
Message-Id: <20190823101036.796932-2-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190823101036.796932-1-naohiro.aota@wdc.com>
References: <20190823101036.796932-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch introduces the HMZONED incompat flag. The flag indicates that
the volume management will satisfy the constraints imposed by host-managed
zoned block devices.

Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/sysfs.c           | 2 ++
 include/uapi/linux/btrfs.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index e6493b068294..ad708a9edd0b 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -193,6 +193,7 @@ BTRFS_FEAT_ATTR_INCOMPAT(raid56, RAID56);
 BTRFS_FEAT_ATTR_INCOMPAT(skinny_metadata, SKINNY_METADATA);
 BTRFS_FEAT_ATTR_INCOMPAT(no_holes, NO_HOLES);
 BTRFS_FEAT_ATTR_INCOMPAT(metadata_uuid, METADATA_UUID);
+BTRFS_FEAT_ATTR_INCOMPAT(hmzoned, HMZONED);
 BTRFS_FEAT_ATTR_COMPAT_RO(free_space_tree, FREE_SPACE_TREE);
 
 static struct attribute *btrfs_supported_feature_attrs[] = {
@@ -207,6 +208,7 @@ static struct attribute *btrfs_supported_feature_attrs[] = {
 	BTRFS_FEAT_ATTR_PTR(skinny_metadata),
 	BTRFS_FEAT_ATTR_PTR(no_holes),
 	BTRFS_FEAT_ATTR_PTR(metadata_uuid),
+	BTRFS_FEAT_ATTR_PTR(hmzoned),
 	BTRFS_FEAT_ATTR_PTR(free_space_tree),
 	NULL
 };
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index c195896d478f..2d5e8f801135 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -270,6 +270,7 @@ struct btrfs_ioctl_fs_info_args {
 #define BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA	(1ULL << 8)
 #define BTRFS_FEATURE_INCOMPAT_NO_HOLES		(1ULL << 9)
 #define BTRFS_FEATURE_INCOMPAT_METADATA_UUID	(1ULL << 10)
+#define BTRFS_FEATURE_INCOMPAT_HMZONED		(1ULL << 11)
 
 struct btrfs_ioctl_feature_flags {
 	__u64 compat_flags;
-- 
2.23.0

