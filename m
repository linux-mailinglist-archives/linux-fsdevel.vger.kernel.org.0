Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4367312714
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Feb 2021 20:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbhBGTGS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Feb 2021 14:06:18 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:38248 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhBGTGR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Feb 2021 14:06:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612725675; x=1644261675;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F38JIOmH/bO60aVqbPLRnyXb9cZeXf1sDr0Po0447lk=;
  b=ah8/FYKWXv25NSnpIOscqUTMcvmyMjWYNGT1pTEfWBEcqZ1jJ4XqwOfz
   msgnlnwGOGn80QJfvDpBSQdwsOUDQDFPmSRB0xTcl1G8HIRX3DMVkWRzf
   +CU9XXha8EmPMoP0Ct2Zv/iTcpKe2g133rnmuVFdugU0gSaXSPdqpNbrr
   4XideXGlfWJC8tv855/SfhGaWeVAtp29ZVgLmpS+x9fU/Cd58bcebURUG
   oUCuLmN9nokRJYLvuvpsJnKpjyMIEkMkOtph9Yu77rnWXyWnfd73jHwOv
   P/4X05g+DkrmA2/X/cbddSx1vIXeXHnqD3XsGNk0eQuxpl0eAMCzkozc5
   w==;
IronPort-SDR: DDgVYYJP4x/8VeelTOZWLgrZVeKK66mrVaagwp82s0DpYuo3+h5yGPOKbxD80KKbq96Xal6rK9
 oPfjdMz7HJSw/dnv31423zxgkOJ5JQRejQYBaD5bkNXL0ezp+Y7RkOmnWcmJQqJkXpyYnUAM1E
 1900t2yPsl5v3tKmec2bpMCxW9zFVys0HCCrAanOu0KjYc+THxitZ50rBDnRonVSHRbvZG2NSP
 5wsRA0hjvqfOk84XpKYT8w8fKZnmQElPvLrBvwnUpbeQGjahhp8nX0ZyWMDW623z3kAenwnsRj
 seA=
X-IronPort-AV: E=Sophos;i="5.81,160,1610380800"; 
   d="scan'208";a="263497357"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Feb 2021 03:18:47 +0800
IronPort-SDR: CTpDn1GpWiAmWx7HWhnsQpO9wY4M5i274jtO4n6/z6+tyLr5RUu1A/9Lq/5j62ri1mcvy7fPoT
 ZQiR9iEROoltVHeTdEQKHIg+GZVMR4oE1np21pOgEvlcGZOEPpH8SV0GzTtjODrgcCfKACy8Ic
 4OtFP9qL7z0gGApo69dmu7tjArKvoI3CiH3k9UeE+oWbAHNbJtGEOhK6ndfeYsPq/dvlYNWceg
 hxZe3eNGUijihhGvu+dLzgvzgLcl7+7g8hf9A9tKfUAedjldZOCYyTVmvLMY3YFZOjkoYUJ0Ns
 A+Jsszk6OcNBQgwU2mwA/kND
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2021 10:48:32 -0800
IronPort-SDR: 95X1JNQjuKEYeODWhVDVzpmJeAmRC+qi6PkDW1g7K+Lf+5rq7gnfFOS12ox+MhnE326Q1n/6S6
 6EeT5PpazKBHTW6Af6ZI24rlL7mUtxPXZeOi2iq1msSf5Oh+xFVcV9PJ0eGtZs3Muxtfy8HpMz
 skaukzAmdnakYARnvPHY6ukLuiyfq8Uxxg4k+mgcLA4JpOAvz3OVHl6QDgN26CLYAB9XLT86O0
 gjQoItL/O4VqWgBcHrgBs24UkssGH8iK8vn2r6od9A8XyvTcgMv+IOEk3E7gkqHk1Kum4mDhh7
 05Q=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Feb 2021 11:04:39 -0800
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
Subject: [RFC PATCH 1/8] brd: use memcpy_from_page() in copy_from_brd()
Date:   Sun,  7 Feb 2021 11:04:18 -0800
Message-Id: <20210207190425.38107-2-chaitanya.kulkarni@wdc.com>
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
 drivers/block/brd.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index cb5c872ac9b2..d41b7d489e9f 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -226,11 +226,9 @@ static void copy_from_brd(void *dst, struct brd_device *brd,
 
 	copy = min_t(size_t, n, PAGE_SIZE - offset);
 	page = brd_lookup_page(brd, sector);
-	if (page) {
-		src = kmap_atomic(page);
-		memcpy(dst, src + offset, copy);
-		kunmap_atomic(src);
-	} else
+	if (page)
+		memcpy_from_page(dst, page, offset, copy);
+	else
 		memset(dst, 0, copy);
 
 	if (copy < n) {
-- 
2.22.1

