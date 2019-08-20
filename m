Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA72995649
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 06:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbfHTExS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 00:53:18 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:11098 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729178AbfHTExR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 00:53:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566276797; x=1597812797;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UWf4fXO5O18k5bQ8f/qM73iKo11oH8s2PQ6abn0uCnM=;
  b=EfSXcnX3tfA+HCYN7fMVC9WCOebDv+t8SRMDCO+cCUoiKuq3n8tYeWsm
   WrzPbzJDfLiMoVzcAttKAdZZ9JdVmD2t8SDsaWrDPsgSklHIp/CsQEgW+
   kKfi29x3nwXbZjyMDea2MW2SQhtZApp5jjAPXqYGz3jGvA+uIzJ8i0CUi
   WDJdIMWGcZekqF98z/bjob7+Iofq1EoQAA0gvSo1NXVE7oq9ZWPN6k0v2
   3N1LEKfZoiYR1k4JwqT8HwxE+k6O1QgNAzwK2Or1UcS0hP5RuPCSkuXJu
   vctqwkiSCIGXAwbBWgvoUDwAp11Aa/mJx5TrGHw0A6bTT8FYFboeJOHp0
   g==;
IronPort-SDR: GXzbshbfMnvJEAyAELo0lpSHQnTNLkA/LOrvwIh+zzW+HCU3jlEYSTT4LTmMhI4JESjmLEdxLP
 sS3Jz6NorY8rpwzllRdO8xHxzFY1BGHen+WNsTJE+Qp+f3U/Ja8rtHxf7in1bcSDtBF7MzN/FY
 +Im0LPeD0/sqe05PgjjX9eiHbal9l4nHCbjinTcgfQsS/1mFvi5NEicKQ4HNWWPLGvPJv4R5jb
 FLntUeVBGupgfgd3+yzF76fvv+xus5F1weOsfuI2hh65tvlUiB1TL0p2wtJ0OFXWWX7WbSkqwQ
 np0=
X-IronPort-AV: E=Sophos;i="5.64,407,1559491200"; 
   d="scan'208";a="117136301"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Aug 2019 12:53:17 +0800
IronPort-SDR: k0bJbJorqWMWxS/mOBivz2SFZ0ZLkpuOqFGK8RXXr3LkFjVQRHgMSqec2+52cZ4aub7grJCVaz
 ncdEXUhv1dosDfOr/EyzeT8CLKFJT5UHMpMjBlp3dBIsrAbFD88HrSL3w75kPctQ1mGH0frROT
 LWchrBPgrXFI2e3lnmj3pvCaZydwJtiarE0GYEgR5FILFv3GYL0R0Tt2pwB1y1kyITXeebVrDx
 HNlRL4yynqlZiq+dz2K6Yz9BqkQLro2ISY6QWFaOIs5GUuUgH5KYOXBDfmrYoUc79V6j86v5MU
 KOuTZVqc15sdnXzDAL5ePQtU
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 21:50:41 -0700
IronPort-SDR: kMJkeTDCg4Tn+tsZQsrigbvurLdZWCki6PPg/JyyavYU0+G+xj16SG4yNoFVZ1umQIE6kub03s
 a/Oz95ZOxbqNRMawAWwVqSiblJGnPUZjuOLdBdFV5PJol1fTwZa/l1ZaQ9JCqizni3bDYQ+sQQ
 w0AWe+HpU0Rkiu5d7nprOnE/Atj+cHTYZCKgN10RVN6vWrtxLUiYgAH48XvNKDKkq+fs6cIAik
 y3Co32Z85N70R9q9vGWwv+8MGPnw+iDA+ALxYvU4rVKyFY1Ap4J4/fMG69bJo52LZ8wsjq3d/9
 LNA=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Aug 2019 21:53:13 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 07/15] btrfs-progs: avoid writing super block to sequential zones
Date:   Tue, 20 Aug 2019 13:52:50 +0900
Message-Id: <20190820045258.1571640-8-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190820045258.1571640-1-naohiro.aota@wdc.com>
References: <20190820045258.1571640-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It is not possible to write a super block copy in sequential write required
zones as this prevents in-place updates required for super blocks.  This
patch limits super block possible locations to zones accepting random
writes. In particular, the zone containing the first block of the device or
partition being formatted must accept random writes.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 disk-io.c | 10 ++++++++++
 volumes.h |  4 ++++
 2 files changed, 14 insertions(+)

diff --git a/disk-io.c b/disk-io.c
index be44eead5cef..5dd55723b9b7 100644
--- a/disk-io.c
+++ b/disk-io.c
@@ -1632,6 +1632,14 @@ static int write_dev_supers(struct btrfs_fs_info *fs_info,
 				      BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
 		btrfs_csum_final(crc, &sb->csum[0]);
 
+		if (btrfs_dev_is_sequential(device, fs_info->super_bytenr)) {
+			errno = EIO;
+			error(
+"failed to write super block for devid %llu: require random write zone: %m",
+				device->devid);
+			return -EIO;
+		}
+
 		/*
 		 * super_copy is BTRFS_SUPER_INFO_SIZE bytes and is
 		 * zero filled, we can use it directly
@@ -1660,6 +1668,8 @@ static int write_dev_supers(struct btrfs_fs_info *fs_info,
 		bytenr = btrfs_sb_offset(i);
 		if (bytenr + BTRFS_SUPER_INFO_SIZE > device->total_bytes)
 			break;
+		if (btrfs_dev_is_sequential(device, bytenr))
+			continue;
 
 		btrfs_set_super_bytenr(sb, bytenr);
 
diff --git a/volumes.h b/volumes.h
index edbb0f36aa75..b5e7a07df5a8 100644
--- a/volumes.h
+++ b/volumes.h
@@ -319,4 +319,8 @@ int btrfs_fix_device_size(struct btrfs_fs_info *fs_info,
 			  struct btrfs_device *device);
 int btrfs_fix_super_size(struct btrfs_fs_info *fs_info);
 int btrfs_fix_device_and_super_size(struct btrfs_fs_info *fs_info);
+static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
+{
+	return zone_is_sequential(&device->zone_info, pos);
+}
 #endif
-- 
2.23.0

