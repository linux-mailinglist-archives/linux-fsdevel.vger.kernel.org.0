Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 901DF312718
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Feb 2021 20:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbhBGTGo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Feb 2021 14:06:44 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:39615 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhBGTGm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Feb 2021 14:06:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612725713; x=1644261713;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jVyWOzZt5w5fhEh8o7eS7+fG7L6zzNjoN92UbyfAIKQ=;
  b=fhUegeXtCpCNxvIC8FtU8wtCza+kfj12ia8ymkJsEj2UTsW9gf2D3bby
   qAEAoY11FWTmI+FQX1XYkggTrldZiG1/HVSrBHzdcDvcddL7uXul1CUYB
   64IDjJ3JalzLDv70CTs14u7/jwjVO/+F9dcb9MmSnUblYox6qzuD+irN9
   6bLPK1MtnVkVg3q9yTV6wIXN4SDruVzAs50lil1ijq9gtnCB3be7OYyHr
   BxAZWgS7UI1xRyjd673qVtvqNQRZuRM355D8tnKXRQmTgsj1Zi/m9IiJT
   udNiXSY2Dd5EZwK5OUiQQpAJYTe9mp66lipxWFYI5/Ydwa1eOnRFXsD5J
   g==;
IronPort-SDR: Sk5TaCaqaQzsBdbSxIlgsIaZ/fcWfd5NbQtzzlkEDThnpWNk9FS5fL5ny/2mv1OBzh8z+Iuezi
 UJLTP3fVyZMxO5J8A7kZeNs4xdC6I/ars6AKZKc7q4smZ+zf5GEZSt7PiABzLv3O3ZNJz2BqXx
 R1IUooK6vV3vDsslgwrr/xrMO4oMz+RporrOB9Pdw+bOipGnSXXioZv9OQOQg9AB+yBP1Rg9uA
 ffKPxPm+6Y0tH+Nik+b5CbUFYnPtlrJnwIeLad2pydmr5KaOoO3HUO4QXBYaJaOEn40TIFo2D2
 gSw=
X-IronPort-AV: E=Sophos;i="5.81,160,1610380800"; 
   d="scan'208";a="263497363"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Feb 2021 03:19:03 +0800
IronPort-SDR: O5pRkm4GtNflkibKekCTYFizVIhtbNVMn2NS3MtjCA/9sMie1pW1OtGvX9ZotQkIb4mGt1iTXB
 5sml7Lfs7ydPM9eAgMQ+KQ6Q1pTr4NrVIW/+pUY/j0/FgMVFsRdW1f4VayGixDQLqpWK3Qa9co
 JM2UR09xzssrQyzdcEUWkMmkopSOEzhzbuJ5onUilkXycbilZND6tn59A9BrvBfDFwf1C78jv2
 FPsjQRKJdkVOBC3HrT1JeE/LL6Leh2g26MtbuOb5aiMqXcvSaJhQ+tqOYWYmPp1NjkD0cl+86g
 00uzcO1hWoxmaYbiVsKK8nbL
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2021 10:46:44 -0800
IronPort-SDR: kbuKIeO0AI9DEI+MIQQ6CERcLJnA/EyVGmtMpQ8f1jguskefPUd+f/2FtXU9VCEEsfvZoymzjR
 Nz9W5KtndcUDtWjZFQc7XM7vAsahBOcCZfV0oKzAfYlSOYyNK42W5Y8zjeMh6yHosSJBJfsVDk
 Kz/m/KtvRXAkvLuXXc8iKui771YFkmjT5p2omMAQY5MvQDwVKZwmINqJBiIGWIClOHouEqXGIA
 5BFwvE6EyBVjXHK4MNwakyTD988bwcqPTepzRYwxBiNZ8RfhnV32rS5saUPih3CdycmFvOw7Z+
 q8A=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Feb 2021 11:04:49 -0800
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
Subject: [RFC PATCH 2/8] brd: use memcpy_from_page() in copy_from_brd()
Date:   Sun,  7 Feb 2021 11:04:19 -0800
Message-Id: <20210207190425.38107-3-chaitanya.kulkarni@wdc.com>
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
 drivers/block/brd.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index d41b7d489e9f..c1f6d768a1b3 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -220,7 +220,6 @@ static void copy_from_brd(void *dst, struct brd_device *brd,
 			sector_t sector, size_t n)
 {
 	struct page *page;
-	void *src;
 	unsigned int offset = (sector & (PAGE_SECTORS-1)) << SECTOR_SHIFT;
 	size_t copy;
 
@@ -236,11 +235,9 @@ static void copy_from_brd(void *dst, struct brd_device *brd,
 		sector += copy >> SECTOR_SHIFT;
 		copy = n - copy;
 		page = brd_lookup_page(brd, sector);
-		if (page) {
-			src = kmap_atomic(page);
-			memcpy(dst, src, copy);
-			kunmap_atomic(src);
-		} else
+		if (page)
+			memcpy_from_page(dst, page, offset, copy);
+		else
 			memset(dst, 0, copy);
 	}
 }
-- 
2.22.1

