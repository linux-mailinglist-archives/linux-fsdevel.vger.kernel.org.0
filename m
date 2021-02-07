Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE055312721
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Feb 2021 20:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbhBGTHA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Feb 2021 14:07:00 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:40046 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhBGTGz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Feb 2021 14:06:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612725733; x=1644261733;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e4vze4agz5qI/6i5moaf/fwbfxYs65n7gouRgw41U/E=;
  b=DlQ0j0HOrgUAJh8BkLfusxY8/Maf3SU/RYNUNnoy+IzXc+QfxVUQKSHl
   8gXtZaWKL8qvo6Y6JqIc+VNq6HM58pRPEhjl61BaI2pL8FhZonBrxZpCQ
   HQGcux6+RJqevV8VCDT4WS8I4u9ixTJjyraVg5dX/zrZv2eRPYca+zVen
   sxQb3KP+PZKY2faEdi9tKFelHdRHg8shjGB1X3fQJIS6dfRVZmMMyKB7w
   9kzk5W6Hm2//nh3nCWvYkaWh5Q66iyv64w3zk1xv8cNWOGUY7NuXwE/gS
   Y0+Z5ssd5Lbin5CRql1DsnU4kcvpi/ZEIrOnX7iW7sQ+JBI9Jqr8Wcb/0
   Q==;
IronPort-SDR: U30CByVFb5OHGcMW2JkcskUggPjOS4+c57wsDPFAWwbVw4k8NlAFFk3k+lrCxusmj2PG1U57dw
 gZ4ENYwmW+9PgBXq66L+Q2fu5GX4Ctd9FMnKZ1H3Hrk1qrwaxEYSsk8AnoaAEz9k6Y4znT25c0
 VkobfG9hYu0g20HIe6xhXFqY8qLCGhLit0NyJeTRwV2P8BwkT6eC9ljxOu9MBmsTKFarV3X3fz
 Qks1LOrMF3D7Ka6J/RCmTIc1ftE/EKCuJN/2N9DZZw1vSPmbuDgJHQ2RvCocdub7vFRSVZlH2K
 txU=
X-IronPort-AV: E=Sophos;i="5.81,160,1610380800"; 
   d="scan'208";a="263497385"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Feb 2021 03:20:34 +0800
IronPort-SDR: UpQXkqJ1ixAs5/BGHBnXZklTe8fLP5vV0g/vGLCGGTpYI/040rSUtP//bZf4o3rzZLsfwOZcXX
 XNai8I07MSLN524ZVPbn71uhi2EJn5Fp2b767lT2iAknnfkJwIpaP3X0R/Vin3X/HHx3CTGjP1
 E+PFPdIp+qFb/E8OrFscmDZWLS/uQUMc2JneLvSNYlNKqmv8o7JZADpgrsC3mcejixtcwz7X3p
 yhEoahBJERU03UAFeRwAPIcwExUwjNatrlPJBd+QzWu/EFeW+s+vMAHzLO6ugKZjtSoimOBkT6
 hh0MoVejfUGyBWW3kIGowMT8
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2021 10:49:43 -0800
IronPort-SDR: 43sJyMm+E8HHgPMk2LqQoOndsIqMY2uxtZc9Zo3NeUktByX5cUc+e7r1vsPvEqvYJHKVJ3Or86
 BuXhCpv7P+wcwaPweZ7VodIlEaWUlqrDMhvfVz8SFeQ3Has/3V7k9knr6HZcWkazEioNxOtfai
 8hgEan6PoOi7NG1nMyP9jcXGC5ycxVtppZHe9HkTB5axK67Hbr3QSjYHfNv0ADwQ5FPYBEchp3
 kydAR4oGU5ktepD0fHi4lz5EhxbrcYGVM1q/wuv/rWZ4YmLA9nHQTC2SyNZ/YZTuUVDqYbhNGb
 Dl4=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Feb 2021 11:05:50 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org
Cc:     axboe@kernel.dk, tytso@mit.edu, adilger.kernel@dilger.ca,
        jaegeuk@kernel.org, chao@kernel.org, johannes.thumshirn@wdc.com,
        damien.lemoal@wdc.com, bvanassche@acm.org,
        chaitanya.kulkarni@wdc.com, dongli.zhang@oracle.com, clm@fb.com,
        ira.weiny@intel.com, dsterba@suse.com, ebiggers@kernel.org,
        hch@infradead.org, dave.hansen@intel.com
Subject: [RFC PATCH 6/8] ext4: use memcpy_to_page() in pagecache_write()
Date:   Sun,  7 Feb 2021 11:04:23 -0800
Message-Id: <20210207190425.38107-7-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210207190425.38107-1-chaitanya.kulkarni@wdc.com>
References: <20210207190425.38107-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 fs/ext4/verity.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index c8e07f8a792d..cc4b046490b0 100644
--- a/fs/ext4/verity.c
+++ b/fs/ext4/verity.c
@@ -77,7 +77,6 @@ static int pagecache_write(struct inode *inode, const void *buf, size_t count,
 				 PAGE_SIZE - offset_in_page(pos));
 		struct page *page;
 		void *fsdata;
-		void *addr;
 		int res;
 
 		res = pagecache_write_begin(NULL, inode->i_mapping, pos, n, 0,
@@ -85,9 +84,7 @@ static int pagecache_write(struct inode *inode, const void *buf, size_t count,
 		if (res)
 			return res;
 
-		addr = kmap_atomic(page);
-		memcpy(addr + offset_in_page(pos), buf, n);
-		kunmap_atomic(addr);
+		memcpy_to_page(page, offset_in_page(pos), buf, n);
 
 		res = pagecache_write_end(NULL, inode->i_mapping, pos, n, n,
 					  page, fsdata);
-- 
2.22.1

