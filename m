Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 548A82A071A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 14:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgJ3Nx7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 09:53:59 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:22003 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbgJ3NxA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 09:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604065979; x=1635601979;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=75fAmRUO5nDwJooOw48asWhVJ81jKELWO2GhE82J9JA=;
  b=Li3HndKnO0hj7Cj1HfHxewe5w//qmq4DilNR3snq85hiDun+x9EML6m5
   HNKJlK2Hcgd9ifthS7yNPIfEssxp/8zja4nKdRZnh5bJ/gos3cleU/9Lt
   WkqjqZik1sjTCm0uf+733+v3jUAXCK3o5fDun0cHu0K3IeqZnkkSBbiSK
   ihuEHr71xGiKw5tRJENfIjRZzmsm/1RP71ahB7u28V7NSvj2aQqj1B9+C
   yhdMsxvesIarSAsMSrkINSJK9fT8pbokmkrvUlAcV/CeZIWK+HvbA7rvA
   eCgGFTNCR2T6lQSF352SVmZAjfnd+Jmw6aKQ5kTWML/xtuwWKX7oxl2Ib
   Q==;
IronPort-SDR: FkfNQi74RMkd8mKnOLAUtGlPsEhhQZrg9qSNssiE95ai4rlXynXeli9MtBzqzyAXd//mhD7Rfl
 8biYlkkVadkCwnWssgZ2NTX8uXT4KJYiIQDdSOqppQ1gdPAWzFk/YC2gjhwRYr4YjT3cGlM8D/
 c3OHXSGdS4VQJIxo4Me+xhPfHPVgQlGwr/JwyeaJ7QI50o3xzhvx95IDyArOQHkpo9FSQRY/VF
 4ClM8/BIk1m0LavoV37oDq78MTE1rdIXe3Y4IPoGUKYSrH8i3kJ/gKseVN1AcSYhSS+/OKGQ9b
 CaY=
X-IronPort-AV: E=Sophos;i="5.77,433,1596470400"; 
   d="scan'208";a="155806617"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2020 21:52:46 +0800
IronPort-SDR: M0qOG84xUQNT8jZ5h8W+xABVZgnJCU/Kx4YtUCVJsYwJjWU1lWMQrcXd4DsgYmiTUtMQxHuTDu
 bY0FB3VYXOu/pTYq/dwwvwO9cdTT2rOW9fiFzaP61Td2kf1czRwWhld1ejvBQrhEqXlisTTLx7
 JY1QlTudBdhijgvsQgvJ0hqBrO0IOvVg879iCMIuVBYOqW/89weeuUea2jpcKEGJSvdkunKhwH
 9jGKMQWg2XNLhTn5XLQ9DH9zRTjvokB/88OzmFf3oIbwkiI6884DWFMB29z63Q9TIibb+FFMsc
 NDEyKeUEH1GZnZB7yidWC7gR
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 06:39:00 -0700
IronPort-SDR: e7JzAysIXUEdQsx08XAZNIWGtmSWDB2UU/6Fde7TDpSfPeXFryEhu6+P7/PeVo7SVYLoitatSD
 TZ3MRXbAm+AFRExCIdeVPlP+DgYMQlUVK8wtzov2G7pF7AIpKSzJyK0SpHNrVcER7cAphRad6c
 /RUWGmr6vmtVP84TuybPlCZqeTR9Wpasrv1WBPNx+2XvBlSwprn9Zw2QMBjAPD97cdByGhhimk
 W0yIDJnmAol0zK1kYFUqFs3OIOe74DQ3FbinnWZjIcFuwVJi+Pmw0RW0fosRFKcETR5HDIsfI1
 G68=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Oct 2020 06:52:45 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v9 20/41] btrfs: extract page adding function
Date:   Fri, 30 Oct 2020 22:51:27 +0900
Message-Id: <da2dba415cc94f271f0693b30296d9cc4f583f03.1604065695.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This commit extract page adding to bio part from submit_extent_page(). The
page is added only when bio_flags are the same, contiguous and the added
page fits in the same stripe as pages in the bio.

Condition checkings are reordered to allow early return to avoid possibly
heavy btrfs_bio_fits_in_stripe() calling.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent_io.c | 55 ++++++++++++++++++++++++++++++++------------
 1 file changed, 40 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index e91c504fe973..17285048fb5a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3012,6 +3012,43 @@ struct bio *btrfs_bio_clone_partial(struct bio *orig, int offset, int size)
 	return bio;
 }
 
+/**
+ * btrfs_bio_add_page	-	attempt to add a page to bio
+ * @bio:	destination bio
+ * @page:	page to add to the bio
+ * @logical:	offset of the new bio or to check whether we are adding
+ *              a contiguous page to the previous one
+ * @pg_offset:	starting offset in the page
+ * @size:	portion of page that we want to write
+ * @prev_bio_flags:  flags of previous bio to see if we can merge the current one
+ * @bio_flags:	flags of the current bio to see if we can merge them
+ *
+ * Attempt to add a page to bio considering stripe alignment etc. Return
+ * true if successfully page added. Otherwise, return false.
+ */
+bool btrfs_bio_add_page(struct bio *bio, struct page *page, u64 logical,
+			unsigned int size, unsigned int pg_offset,
+			unsigned long prev_bio_flags, unsigned long bio_flags)
+{
+	sector_t sector = logical >> SECTOR_SHIFT;
+	bool contig;
+
+	if (prev_bio_flags != bio_flags)
+		return false;
+
+	if (prev_bio_flags & EXTENT_BIO_COMPRESSED)
+		contig = bio->bi_iter.bi_sector == sector;
+	else
+		contig = bio_end_sector(bio) == sector;
+	if (!contig)
+		return false;
+
+	if (btrfs_bio_fits_in_stripe(page, size, bio, bio_flags))
+		return false;
+
+	return bio_add_page(bio, page, size, pg_offset) == size;
+}
+
 /*
  * @opf:	bio REQ_OP_* and REQ_* flags as one value
  * @wbc:	optional writeback control for io accounting
@@ -3040,27 +3077,15 @@ static int submit_extent_page(unsigned int opf,
 	int ret = 0;
 	struct bio *bio;
 	size_t page_size = min_t(size_t, size, PAGE_SIZE);
-	sector_t sector = offset >> 9;
 	struct extent_io_tree *tree = &BTRFS_I(page->mapping->host)->io_tree;
 
 	ASSERT(bio_ret);
 
 	if (*bio_ret) {
-		bool contig;
-		bool can_merge = true;
-
 		bio = *bio_ret;
-		if (prev_bio_flags & EXTENT_BIO_COMPRESSED)
-			contig = bio->bi_iter.bi_sector == sector;
-		else
-			contig = bio_end_sector(bio) == sector;
-
-		if (btrfs_bio_fits_in_stripe(page, page_size, bio, bio_flags))
-			can_merge = false;
-
-		if (prev_bio_flags != bio_flags || !contig || !can_merge ||
-		    force_bio_submit ||
-		    bio_add_page(bio, page, page_size, pg_offset) < page_size) {
+		if (force_bio_submit ||
+		    !btrfs_bio_add_page(bio, page, offset, page_size, pg_offset,
+					prev_bio_flags, bio_flags)) {
 			ret = submit_one_bio(bio, mirror_num, prev_bio_flags);
 			if (ret < 0) {
 				*bio_ret = NULL;
-- 
2.27.0

