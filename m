Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B092A06E3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 14:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgJ3Nwm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 09:52:42 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:21997 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbgJ3Nwi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 09:52:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604065958; x=1635601958;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4C8Gp+BZT/KoALoW+KYOIuH0QVroj4D4IuoxRX499wA=;
  b=mgRCubwvtkSREbbe1pK9ETxwrfOpflgGqaIj05TNXFHubcMs67AxMRCQ
   dsyv6pytnwUxHNnSX4UyweHrb8mv2RtlBW6/Kkoi13vuRmnylW2fCfhsH
   MPS8zO42r+GHYSFo/zUgpGsA0IOHQE/7udcQRUc+0hZeMnfCcWnzI9Zmj
   NP1Dck57Wj/YyY85os88z/OXL7u6tlU0sFb6E1Pikw+CORwSRW39uWKbe
   oZdmSh4fuBHrwfZOFUEHi3dih85Fh14ZeEPCkno/HSjPoPyBRENiYCfrM
   se6K4rYsxdYQ6qzBxOqpWpHmFKJ7YiIK1WiWlVHzz4IMziI1aR4JR9xq+
   g==;
IronPort-SDR: Je5ye50/LdErWHyqLXuXXR8PI17WCzy0EgzSztDw3tawpLZjyAGBx72nh5SHHmYwMqu2XCZci+
 QJdDi/4Cp4eo8YsK10jjgXOnCvKRf3xwRTwGoOpgqPiKLHcc6XYe7hLMNxPhoT1fg63rWtGGfM
 BnRsMeBD2cT6j2CL+gQ7ACP3dG9ZVKrw42XQ+DjmUVsOVRbe1lLaZ7VTsU39N6n2wJvkGA0z9E
 JHCmX9tdOgTJHuOzpqmuXK8axROjq7ZD0eVOd+fBSTn5WZe0Fzn8xaLw0fUkqTtyP2rDrosDOZ
 NgE=
X-IronPort-AV: E=Sophos;i="5.77,433,1596470400"; 
   d="scan'208";a="155806603"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2020 21:52:38 +0800
IronPort-SDR: rPz6P7Y2D6YYAwTpb0CqWdxz4u7ziEu/rrzTEjHe+ulUCi+3lc4shUD9wGff0DpM8IzeaZ4y1r
 80iGokjizSan/P5TNZLtl39q7cgs9tKhfVt566GHP6a6+Um4gXg4gB1KsKYIatLtUkSjYV0mLI
 yw1MBP7FDX+1oZNiTThm5efCX6PCfyxDWF/0+GAYSE2ZMvW1wn+XHvccdpUqrrLNpPT3McOd1G
 MT1FuswDjoTfc4gAGTQ/hiyQdC//prRdEm9zYg+KDajg7olLY+RswAY8+Jkn+xYJhOzpRtd5y4
 KJ2/2UbbVFYGqix23mdrPniG
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 06:38:52 -0700
IronPort-SDR: vExZKPzi6hHB3p672kGvds8Kkb8L4bueGdTxT51ZPSLZj9+RlWLcD8jULNAR47qW5tA5sx8t96
 xgsG7D2ZydgLSVIljOuS/CqmKTRjY0iFJLNvS3rUjMKENVmQirRM/dgFKM5skMsKUgB5CsrRqK
 m4U9Vgzq0RfqRK6CCDiYWxgRTWRu/4kTsEIbJxGP4RdrxWcV1RGazQtDeTY5DsToqJ/yqYxw0S
 hi/oP93PNAbKaSwDgoPBS2cEBNtlRgl7zjkObNOWyRrpG3mcYih+tbI9snHfc/nfI+vvd8OoOM
 +cA=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Oct 2020 06:52:37 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v9 13/41] btrfs: verify device extent is aligned to zone
Date:   Fri, 30 Oct 2020 22:51:20 +0900
Message-Id: <6d9191ed858e0a0283a8d52fefa538896d8d125b.1604065695.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a check in verify_one_dev_extent() to check if a device extent on a
zoned block device is aligned to the respective zone boundary.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/volumes.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 78c62ef02e6f..9e69222086ae 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7778,6 +7778,20 @@ static int verify_one_dev_extent(struct btrfs_fs_info *fs_info,
 		ret = -EUCLEAN;
 		goto out;
 	}
+
+	if (dev->zone_info) {
+		u64 zone_size = dev->zone_info->zone_size;
+
+		if (!IS_ALIGNED(physical_offset, zone_size) ||
+		    !IS_ALIGNED(physical_len, zone_size)) {
+			btrfs_err(fs_info,
+"dev extent devid %llu physical offset %llu len %llu is not aligned to device zone",
+				  devid, physical_offset, physical_len);
+			ret = -EUCLEAN;
+			goto out;
+		}
+	}
+
 out:
 	free_extent_map(em);
 	return ret;
-- 
2.27.0

