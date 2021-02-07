Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478A5312711
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Feb 2021 20:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhBGTGI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Feb 2021 14:06:08 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:24872 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhBGTGG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Feb 2021 14:06:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612724766; x=1644260766;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bUHJh7WdO4b/toeg0AHLw0ztouu30XNNBjvj4mVAqXU=;
  b=MEGOBD0SUxSMma78+0AWH2c3ZlzZOiJSuuUCS1doO4+wr74a/n4zY3AZ
   08Bl0VTpKxODg8bTYJAh/7onO0hpSyfQwLIBNZPMg6kJ/+NG7RaNJuJjn
   LjwO4FQqOE8o9eCFm4wRulaAN6v8H3XmeCkYp/+zZjKtt/Xo7q4/WTy8G
   OulswRKRlogjJ5HvUK50Le31vPQ1waN8SXAZY0HvpBWBIeWasvmzTd9vE
   3/Rpd2eKHy2zOLvtvh58DwlmMo9X5pUcmQ7kEd/xDSl8Feuni7aZObnT1
   8wKLJ7A48/JwBGSHsP/FKOjvi8ujJC2w7fwfNau7r/Re8CTHEj37qtxwC
   w==;
IronPort-SDR: fuC609NQHBv4sVwfaP8nv/TaILqX5q7fvyUTHggPlee4x/t/LO7GkNbcXHp+2V2404pz1iJH2p
 Mefwxnxl0qMEyquFLejbk78ybegFR60ATtiutNnKEzw7FMaiv1sQeh0wWTl9Dx8w6N31lD33kt
 766gFrqqAzRLtuODFr9N5fVGITEelY3QsltsGsw3QvMvPmvYGnRUb2EfMH8SVj6KmSxMYFP+LF
 OLuBGRlwLSVsBeP9J6BHrTNI2rCTWaco0ubeM9ehIq+94UPW1Y1QSzrddocvb9pfbomEUxJtvH
 zTU=
X-IronPort-AV: E=Sophos;i="5.81,160,1610380800"; 
   d="scan'208";a="163856618"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Feb 2021 03:05:01 +0800
IronPort-SDR: dmQc6zWHhlp1Kuo4d6RnAamUi/SO9d/n+KohGH2iyxGndllBfGZ36Jocs56ClcKJFD1zTt0kfS
 IlxaH54+MKitkkgn4tV5wFDW1wNfR+4a6zu4SMOsMK2jgeEyRVMHXpK64TeejRTyTrxA4lxfdf
 wNNdkUqqJ14VjvDzYlcA6FU48fPfNSxRKZylD0wRiGQo7Ecjksa+8eufIiKNA3Rhq/BiRbyL9U
 KLqeRff40qqcDOq1/Cnx0t2pRp2QjeVFX0IZ1RgDqamQhIAa+MkjDkgTmP2X5enQfYkevXL0Vg
 m8RuPADHo3gLeJx5AztQaG+n
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2021 10:48:54 -0800
IronPort-SDR: TvntBeAolPC47uEpAHveeRKqEAmQL1bLDsoSWx9UpeX47q4cyQVQy0/0wIpmXUs9xAT7lHssFB
 L57BvqnFnKJXULcHqEPvzUOsd8dD+lK3twgfLVgzhBoeVPuQ4CwxXf6ijN+9cS23SbxJwwC1ca
 OiM7KkSy/vLyrwoKEiE0ZKxRIxUziNbioNV1M/OyOdDwMEiYT1CCLSrTb6O8b05Bfrul78hTkm
 1+OzN7Zu9sty6jW/ftaKVNTes1sB5dbW9tkCcjLxoqLUiryAVTdKBf9m197WEQaorT4hlklXpH
 B3I=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Feb 2021 11:05:01 -0800
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
Subject: [RFC PATCH 3/8] null_blk: use memcpy_page() in copy_to_nullb()
Date:   Sun,  7 Feb 2021 11:04:20 -0800
Message-Id: <20210207190425.38107-4-chaitanya.kulkarni@wdc.com>
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
 drivers/block/null_blk/main.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index d6c821d48090..c9b6db82b07c 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1010,7 +1010,6 @@ static int copy_to_nullb(struct nullb *nullb, struct page *source,
 	size_t temp, count = 0;
 	unsigned int offset;
 	struct nullb_page *t_page;
-	void *dst, *src;
 
 	while (count < n) {
 		temp = min_t(size_t, nullb->dev->blocksize, n - count);
@@ -1024,11 +1023,7 @@ static int copy_to_nullb(struct nullb *nullb, struct page *source,
 		if (!t_page)
 			return -ENOSPC;
 
-		src = kmap_atomic(source);
-		dst = kmap_atomic(t_page->page);
-		memcpy(dst + offset, src + off + count, temp);
-		kunmap_atomic(dst);
-		kunmap_atomic(src);
+		memcpy_page(t_page->page, offset, source, off + count, temp);
 
 		__set_bit(sector & SECTOR_MASK, t_page->bitmap);
 
-- 
2.22.1

