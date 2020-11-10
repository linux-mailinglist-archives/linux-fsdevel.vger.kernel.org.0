Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC9E2AD4E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 12:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729826AbgKJL2Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 06:28:16 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:11943 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgKJL2K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 06:28:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605007689; x=1636543689;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JURNtChtu4jU2Kkb/XX8ESd3HK5ZuzHxwYwetvjZgvM=;
  b=RL/akRa3O1zn/QBbaqt3qaRWosLq2YLrgtXN2dUk077VgHUkNgrU+PQf
   Yg6rIk7i0T8hfx3lq7RGunJo/NmmRNiIJx3J6TyZeryMi3g93kbHc4+TI
   XqV66rJUMaf4h9qbQGKH0WZ4lSwWWXg2opfVqvc40WNQFpYGizAGzxXrv
   Txh9ui5VcTYvhSBlUNp939XOPhXj7Rqqf8DPu4qCfn5gFV8S50FkxWPMK
   1gNVNgC1J3N2nCt8wvho/Fpm8lQCa4RYMrhZguFCnX0fwj+zSo9NNgunS
   hhssB6rt02ilSsug/gXR7dR2IZCLWAU9hDJBaqwhYb7Q0bm3oSeXRksRS
   w==;
IronPort-SDR: 1KOfDF8W92K8jSnDPTD8dqyFv45tOp38lGNUB9Sb+gDPLdN4nEcvPr0XJ8rtBDiMY+/RN0ERvs
 oZm3OI9fZ+cOJQ/kfXYL67v8lyI4XOlamaqSrDMqK5wy2oidrWOj+6f/WYe9goRcJlv61fe2ft
 PPK/vNosEocG5eCXeO7SzUKRk2nfblJUniFIm3wusiqhzQ98aktqdKNb7SxQr1C7OvJz1YFYEv
 atGS2qa9Lqlbv5me6+kxXTdUfTw29s9m2YFNFdSDgoNmfgdvA3l2yDB/n3BV2jEVtAPd4/5Y6S
 qQQ=
X-IronPort-AV: E=Sophos;i="5.77,466,1596470400"; 
   d="scan'208";a="152376413"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 19:28:09 +0800
IronPort-SDR: JCEgWA8K6dgPaHHZViuZLkAXBDIvg45tald8hMZVJjrlY8t+QewflVNoXzHaFdjQ62ao9LOyyX
 1kkR2aTHPUIauozsaR6paTcqIEIR96GcjUtPI0yBZ5Lona3w8F4RLgTwkSwGMY6zPfD6+tY88K
 JhMVl5lMk0QUSqqPb8sVxs1pxa8i5KD+YOl2/l0Tx/HyJNPQgPdns2z+04WilO6s5y9TE6iAUQ
 ar0NfsSNjuNmpD3qYPMLup+uH2FMLX98CMQDWfjEvacpvl8mC9YXXvbQwEEfyVh+fkieEVkTZV
 FEsPBhYB2PBqZM68bz91xli9
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 03:14:10 -0800
IronPort-SDR: G/5wE+L+D6oY4teJBwHVyS0eq0M9Gtqk4Q9cPJjposUxfyUXIF0XreHpRjIiycfK6YDV+XYH+K
 tZtjAsxb/7Z2OnNHW20DYYm6N9AWSst2GC1vfEiQsuFTEDcaeqrrutQxM82BA1dWNIdDxE2kJB
 9LUz3L5kiw+LfuRTqjIpCEM6rs1lIxZPuowcj9QmwaY9b7UtCcm51WmxTTwyKsDUneb4g0cFO/
 E2B/RsFfU3TL8wLWUNHUmCQj/Naq4roeYED7tFeR4M/7tEnjdiIXYpP4twTi8g+Izcu/6XWyIO
 /sA=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Nov 2020 03:28:07 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Anand Jain <anand.jain@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v10 03/41] btrfs: introduce ZONED feature flag
Date:   Tue, 10 Nov 2020 20:26:06 +0900
Message-Id: <5abeb08ecb3fe5776b359d318641ef5078467070.1605007036.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1605007036.git.naohiro.aota@wdc.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch introduces the ZONED incompat flag. The flag indicates that the
volume management will satisfy the constraints imposed by host-managed
zoned block devices.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/sysfs.c           | 2 ++
 include/uapi/linux/btrfs.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 279d9262b676..828006020bbd 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -263,6 +263,7 @@ BTRFS_FEAT_ATTR_INCOMPAT(no_holes, NO_HOLES);
 BTRFS_FEAT_ATTR_INCOMPAT(metadata_uuid, METADATA_UUID);
 BTRFS_FEAT_ATTR_COMPAT_RO(free_space_tree, FREE_SPACE_TREE);
 BTRFS_FEAT_ATTR_INCOMPAT(raid1c34, RAID1C34);
+BTRFS_FEAT_ATTR_INCOMPAT(zoned, ZONED);
 
 static struct attribute *btrfs_supported_feature_attrs[] = {
 	BTRFS_FEAT_ATTR_PTR(mixed_backref),
@@ -278,6 +279,7 @@ static struct attribute *btrfs_supported_feature_attrs[] = {
 	BTRFS_FEAT_ATTR_PTR(metadata_uuid),
 	BTRFS_FEAT_ATTR_PTR(free_space_tree),
 	BTRFS_FEAT_ATTR_PTR(raid1c34),
+	BTRFS_FEAT_ATTR_PTR(zoned),
 	NULL
 };
 
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index 2c39d15a2beb..5df73001aad4 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -307,6 +307,7 @@ struct btrfs_ioctl_fs_info_args {
 #define BTRFS_FEATURE_INCOMPAT_NO_HOLES		(1ULL << 9)
 #define BTRFS_FEATURE_INCOMPAT_METADATA_UUID	(1ULL << 10)
 #define BTRFS_FEATURE_INCOMPAT_RAID1C34		(1ULL << 11)
+#define BTRFS_FEATURE_INCOMPAT_ZONED		(1ULL << 12)
 
 struct btrfs_ioctl_feature_flags {
 	__u64 compat_flags;
-- 
2.27.0

