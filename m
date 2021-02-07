Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E24AD31271D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Feb 2021 20:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhBGTG4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Feb 2021 14:06:56 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:24872 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbhBGTGt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Feb 2021 14:06:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612724809; x=1644260809;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dehfSSqAC1aZX9IJSa3h7Royg46gKKUc/ViSk1Qqt4w=;
  b=WZwpNOty3BPUFHcDBJiSB3D7FUX6a3v1mkptWtGQyTzAICp7VgBWjhfN
   utkYiZosb6BOnAp2GpEaUa9piZ67gdcJ/h+TupEEiAREiM9ogXn/Usu8i
   vEMtfFKy8A0w04mKX4ZjQ4PGQEluBgWJg3+HEmH/C3Q+OBwLVrG8GFP3U
   oai1Umg50GFrXLfp3ULPCaufyiIfJ8vcar0qmlzzQTlnBBDZZdQryk9iu
   w1tGjNYGZxZr9xZmKkpY5Q5slnQG0hpu6dEzhDw2nxHH7/LrhvSinS/St
   /Kz6CqwdK3tvFdVmpK7yKljsECdWjwfLPalKd+QTD972Tnlyfka4j/Tmr
   A==;
IronPort-SDR: F8gL0u8taR9K/hBBZq1ALYAkFd436qU+4N3isSJ64+pIGmiwg5Qhvix6w23kK7J6cHwvDcu2Wf
 nP4VJrAcC23uQpGxNOCUbmyRc4IsOPv/JRUnmqGM67lTJJpHw0CPU3a56SPhFtMre5AizvAbj1
 5RNCHdfbPq7BQgSxjFMfKfWQAZGUXNfMSkUOfuSc6u1I8zyq48HssnSYqg8ZKpUbAZ5D/pbdlT
 cobpbyC5NuCOC6Fmp2NrV0WqYxGS/iK1cstutOcS215B6GUjv7iIZvJzWiHrN1qw9LJnqCIWjb
 7Nc=
X-IronPort-AV: E=Sophos;i="5.81,160,1610380800"; 
   d="scan'208";a="163856632"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Feb 2021 03:05:18 +0800
IronPort-SDR: JhBGXGoCZTzrn2Hizeh1WT8BzOAmVixm+E4wE/KvnoefdXvEneGeitJbnUzk6LgFnV/i9sbDvc
 hmz4t26N3l55owuiFiRAb04cA2NNb+c6Mi5wTr8nr9O7zyE3w/UcNHEVrmhNxE/armoteTghXZ
 GA+jJd9u65vyTreWeIwESro4rrSQXWnN19iC784F7R1qUoKjT79NfHT8CMUSpy180aVT7W47dQ
 M7Yx69ibBgFakyyOJ7vLt2vOXNnTq6zD4m3SWoeJR6U1jEMCADwwR6yVYThjQ3IRjORatgNOwr
 wzMJT62loEnjYS+52+ePjbVx
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2021 10:47:13 -0800
IronPort-SDR: /NXkTLt/6qjduDdq2JFD7H6ZU+2oB0Rep9ax9+DK8GZwj+QwFm5xGHo/lvt8Jhf3VxkmGz9WKT
 ozZQT+ilXxLz9H78tNiiEyGRBVVQePcWqrOyWOs7rre3+lFVAGrVsUvOX5xKbv0BNnkxYqCDo6
 lcfJ0FnspF3wCcBsGYidK8L/jGC7u9NuvCYsuTVkTuxmgmuxeG/bdTYhdVz/T5bsstD10Aa/nN
 IJw8c3dJ5LpA9hTAS8X5AegS9FKMJ7cCnR8aKsp4kZvUGwJoa3LEMV3Fa3PQRHONuomK97B3SY
 j1k=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Feb 2021 11:05:18 -0800
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
Subject: [RFC PATCH 4/8] null_blk: use memcpy_page() in copy_from_nullb()
Date:   Sun,  7 Feb 2021 11:04:21 -0800
Message-Id: <20210207190425.38107-5-chaitanya.kulkarni@wdc.com>
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
 drivers/block/null_blk/main.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index c9b6db82b07c..1c0e1a295e90 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1042,7 +1042,6 @@ static int copy_from_nullb(struct nullb *nullb, struct page *dest,
 	size_t temp, count = 0;
 	unsigned int offset;
 	struct nullb_page *t_page;
-	void *dst, *src;
 
 	while (count < n) {
 		temp = min_t(size_t, nullb->dev->blocksize, n - count);
@@ -1051,16 +1050,11 @@ static int copy_from_nullb(struct nullb *nullb, struct page *dest,
 		t_page = null_lookup_page(nullb, sector, false,
 			!null_cache_active(nullb));
 
-		dst = kmap_atomic(dest);
-		if (!t_page) {
-			memset(dst + off + count, 0, temp);
-			goto next;
-		}
-		src = kmap_atomic(t_page->page);
-		memcpy(dst + off + count, src + offset, temp);
-		kunmap_atomic(src);
-next:
-		kunmap_atomic(dst);
+		if (t_page)
+			memcpy_page(dest, off + count, t_page->page, offset,
+				    temp);
+		else
+			zero_user(dest, off + count, temp);
 
 		count += temp;
 		sector += temp >> SECTOR_SHIFT;
-- 
2.22.1

