Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 833EE31271A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Feb 2021 20:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbhBGTGz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Feb 2021 14:06:55 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:37278 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhBGTGt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Feb 2021 14:06:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612724809; x=1644260809;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rNdz9k9ffw5LAUxhwO57X4gVRFYzjraWgYm8UMbARD0=;
  b=Qxk2wI7NgxZvhytLnF4rBHG+AjGMM3a16j+keLAmErcADUE3z7Ia2yPW
   pjVaEwTgtkej1IegbdrxZnisuf17zSjrIeFbeMMeuiM7Yd+m2hV0tnjAu
   AqzBm0Rn+l9JIINunamAg5/nyLAUM7++4WSRDTaGVGp8aeXUBJHNSuPme
   ew6hi7fMGjN+BQsF6kFUav8zoPgL/kdoPdHOZbsPMd5G6Ut1kIHUbyBmd
   8nvBYhXMy70aou1c5S9xqYs+TV9vfmblRsUVtMg1sg4wR+jmX/NeOuq35
   whrvOte32p//rV0x0bVUyZFNEjjh/R4J2imOe5acmBii4YY7POCW9EKMZ
   Q==;
IronPort-SDR: dJxVxxCAkdcZUfi0xKPrUBXmmWM1JW4feusKWlrGNz2SdDpymbeTXjUegXj66zGXVmFEy9lMok
 WV5FsbexIqIUCGCOUhCVxATQ7DhrXhwOYacceIAo/HVO8/uXuD1NkKXIBvXQ3hB+u9k8OC6t+v
 phWvndStwEtCb7JERnQHIivHrLhJhcwhr5WaoyKF3HpWREWYn7mjI2W074AQI06xFNkI8xUeru
 UUecdrVBmgZsLGrTgrLbLqaFaYBsbwaMGwRZcR3oWr4uyHp7M4k10CfawiY3eFVu9qZjoz7XtG
 z8M=
X-IronPort-AV: E=Sophos;i="5.81,160,1610380800"; 
   d="scan'208";a="159399773"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Feb 2021 03:05:41 +0800
IronPort-SDR: h1t2WzGezVJR93Oxz5zJ0b7hqTneFgSxaJ/j8C00m4kVnto8z5Gfdfd/0LfVDMWeyUN20gWd0B
 3rG5a8hs9oUuBa2ZeP9tizi95rTx9fi2xQqgDVrD3ubaF0fuWPhiV7AwSMtf5N76sRhhdQIuoG
 T8d8TydhcsoneAZZNFOmff1GJCWDKNEVtwLxLOlUngKVI4BPiqT/xgwoaLCqtqxCU4MK/54iGI
 4UZ+ilxumN3hJpoXWApwZNBk1hlUUU4IP1sBvlphAVvRUZ1YWDOKOvXDjUjSOKQ3dKd4M9ZRoj
 kFYNsQ8fPqwv97nSgPMW+IbE
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2021 10:49:35 -0800
IronPort-SDR: Mqq4oD3AeYBOMQHpGBqpa7pFTs3cc0c1FqPIJAN7pudJdrjE1cjRu0dCs025PGzN1w2mJSwrI8
 aLMozTCLuRjHR3U2Ava6HaEOdzuNs6BKCjySlUFnlbnsz2mfLlHcpwKmSdmyHd92gceMCoHjff
 SrgH+/UBPE/azNd55IrtFOrGh9hfZBqgwHFD1ONIv1Su/ou3XzTuek77zBP92E3JHf9gMZ3g5V
 C8UdjLamPyOsH/7UOibmR6FxstwDhtHmvtbREVOVNEGrv3OlsgYYoV5l9pJ5DScQGhniarovqX
 2lg=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Feb 2021 11:05:42 -0800
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
Subject: [RFC PATCH 5/8] ext4: use memcpy_from_page() in pagecache_read()
Date:   Sun,  7 Feb 2021 11:04:22 -0800
Message-Id: <20210207190425.38107-6-chaitanya.kulkarni@wdc.com>
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
index 5b7ba8f71153..c8e07f8a792d 100644
--- a/fs/ext4/verity.c
+++ b/fs/ext4/verity.c
@@ -45,16 +45,13 @@ static int pagecache_read(struct inode *inode, void *buf, size_t count,
 		size_t n = min_t(size_t, count,
 				 PAGE_SIZE - offset_in_page(pos));
 		struct page *page;
-		void *addr;
 
 		page = read_mapping_page(inode->i_mapping, pos >> PAGE_SHIFT,
 					 NULL);
 		if (IS_ERR(page))
 			return PTR_ERR(page);
 
-		addr = kmap_atomic(page);
-		memcpy(buf, addr + offset_in_page(pos), n);
-		kunmap_atomic(addr);
+		memcpy_from_page(buf, page, offset_in_page(pos), n);
 
 		put_page(page);
 
-- 
2.22.1

