Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04C5A2F733D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 08:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730048AbhAOG6u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 01:58:50 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41752 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728452AbhAOG6t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 01:58:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610693928; x=1642229928;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XGPYvnrKmMcJTNq9V3Udz9HKkSqIOb888Y/DKSsZ2ow=;
  b=qyLu9Go3bGUH3Drf8jhaCzzyinaJBOpTVe7b73Yfae3tG+m7dik+JgCL
   ejj6wA9+o5bzkzn0GzlPqzP+Fn+N1zVbikEUESZ/ETMcaSFaUJbyliCjV
   9M5lKExWEFjipudTD5w17083iBvXhK5Yzd1dA2tcE90HCXnJPg4LJYWBx
   IFOJN+tCVGeh2Yvz9uLjJ4zZbY8sMBzoG1gcX04OompCTypY6Ed/H5xgx
   QliLprMudbV6bMB9p7KGbYDdAmNoRoG8+d7JiNlhWWQB4sec/7m706ubf
   mAmNItJt5lmfrhbqyFE2lsq739ZDSka3bCyqhV9OmKoAe7xMqYPZFTVIU
   Q==;
IronPort-SDR: KJLsvsYXFglnn3s5aNOk2Q+9CwLrqxZp69PkOVxLcWogBdOloYqbS9rmW9aQejn5YxFRy1cDFQ
 rhp+grnadkqCMCQz+1Nj1XpeTbMiLDBqQDXGG0vKi6QS6emo/QaXTGOtMlObYe7PcmS+M5IByM
 6db+UZFmip2PRYzPudXRuNtHo+6yMiQMMCW1rc21nEOfKK66XzlMmOuJ80cjd7YDFlFTSeIAyq
 SCGrKX3MjOsApje//ReyZWhowaXTO/loWIe5nFBPuLFsKVqX3cmDlzgOnQMF4vGKoObs2VnWJ0
 Kog=
X-IronPort-AV: E=Sophos;i="5.79,348,1602518400"; 
   d="scan'208";a="161928259"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jan 2021 14:55:43 +0800
IronPort-SDR: jcHwS56kCkMkfH8J0Z6rTXNS2VU7OsDIiv6Ck1seJMZHK5dWCdiXiFoVCtIQSUkjutIp5SIPzp
 GhQ1aYkbVqFPsLFPHkeq0ulfs5OctWGayP/BukbgRIU4ioUEwIuktIEYWL7/RhP7DbFm/mz5bt
 ENw4pwK3dwdYOXo61lYNkwOvMZYSAvvnPIOE12FdghKpUCDSX505dC0ujua+HHXuxb1PiOvdZr
 t6OTG+RBOcyw+9lbw2zauAOlfKnDvItWbTVSWTYV5TV6U27b0vnJebQ+vYVSCFN8KnHlelaAbT
 uUTKnRhFXQJ4VOB2fSl4/UsJ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 22:40:25 -0800
IronPort-SDR: aNnfu7fs4Ga3koA+tZMsjACOnbgQ6P2Zqy5s/BrQrIcdSE+h+YcQtv1v23EnUkQ95+GUuHN+7u
 Gr68RGspa0h0oqQxHZua7dJpt/Lq/7O1SilgB3KImsbQxDA73vBKlqtDevuV4ACcxcctOayMC6
 GymlpvQF9jZ32KsK5aB3g+wDRbxdaEbdNHoKZoJz+gEo/CDmymtGU+/pERMgdIr2v3h/6XTBud
 tUjuNtdqWzD6Mi5DE86OfRVP/JBQlahby8NzSXvcU6ggJ2JVW8g59DrEqjCxOARPA0myZ1NgqE
 sXA=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with SMTP; 14 Jan 2021 22:55:42 -0800
Received: (nullmailer pid 1916458 invoked by uid 1000);
        Fri, 15 Jan 2021 06:55:02 -0000
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v12 19/41] btrfs: extract page adding function
Date:   Fri, 15 Jan 2021 15:53:23 +0900
Message-Id: <59940825e958cf3e4cf99813febae57beb86ddaf.1610693037.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1610693036.git.naohiro.aota@wdc.com>
References: <cover.1610693036.git.naohiro.aota@wdc.com>
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

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent_io.c | 57 ++++++++++++++++++++++++++++++++------------
 1 file changed, 42 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 129d571a5c1a..96f43b9121d6 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3061,6 +3061,45 @@ struct bio *btrfs_bio_clone_partial(struct bio *orig, int offset, int size)
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
+ * @return:	true if page was added, false otherwise
+ *
+ * Attempt to add a page to bio considering stripe alignment etc. Return
+ * true if successfully page added. Otherwise, return false.
+ */
+static bool btrfs_bio_add_page(struct bio *bio, struct page *page, u64 logical,
+			       unsigned int size, unsigned int pg_offset,
+			       unsigned long prev_bio_flags,
+			       unsigned long bio_flags)
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
@@ -3089,27 +3128,15 @@ static int submit_extent_page(unsigned int opf,
 	int ret = 0;
 	struct bio *bio;
 	size_t io_size = min_t(size_t, size, PAGE_SIZE);
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
-		if (btrfs_bio_fits_in_stripe(page, io_size, bio, bio_flags))
-			can_merge = false;
-
-		if (prev_bio_flags != bio_flags || !contig || !can_merge ||
-		    force_bio_submit ||
-		    bio_add_page(bio, page, io_size, pg_offset) < io_size) {
+		if (force_bio_submit ||
+		    !btrfs_bio_add_page(bio, page, offset, io_size, pg_offset,
+					prev_bio_flags, bio_flags)) {
 			ret = submit_one_bio(bio, mirror_num, prev_bio_flags);
 			if (ret < 0) {
 				*bio_ret = NULL;
-- 
2.27.0

