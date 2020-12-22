Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F95F2E0506
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 04:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgLVDx6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 22:53:58 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:46436 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbgLVDx5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 22:53:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1608609237; x=1640145237;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bU8sglzjy3FBMmGf/+DEoK6LMnSwuBzpBK7kWvoOAjE=;
  b=qIldjNK1B0IPo5TkXDtRT3pu5pcNRhWBztfT98TfD7sA75F9iSm/kwiL
   DsG7wY2yfr3d7LCLO5mcuZ9JXkw6RPgDaK2qDAGQLkWUrM1SZSWx6SMEk
   EJnAsICAW4UCJrkJslA+DJN/PgehfWqKjjYSVkLKo32O0mufK2i5/JO0V
   m1HrbblC7PlX6PdA+w0gLCfzKXRPXuVwq+j5RHp0hKaTBmTyAbyHENXmp
   A2s+tvMaJ/8HPeLEdiKTBKeKISQWmG7ixwOUiFphspApZZB/zhtRYYcii
   HQsjl+ZuBwn3vc52eikXo3KIr5LKgjNG1Hhg4D5Wq0bW1mUKfieOGwVIm
   A==;
IronPort-SDR: GRsQJl4SBBfqEPGieKUdnYVSpf+/09QErxpnPnG92B94isBK4/1dPQGXWdL07Q3WUozzrvGHoN
 W00IZV1uuOObMumKDf/qbnqVjsQboXTBEvkv0T/BPwzWO6B7T8UW4E5+VLDXORS2smPN4AqMMl
 xLCkgwURHb5QqdW2jgocBuCo0Rvf7MSfervCATe85hYkVvNnTOukv2vGl9AUlbgISrtElXpeT2
 O62kXHq1HZbGESfBn0OoHfpmUZSB5gJx2OXjhsByx9x4ZQvQgEp+GZZolMu62osZzuHg7TwLOX
 5yA=
X-IronPort-AV: E=Sophos;i="5.78,438,1599494400"; 
   d="scan'208";a="160193789"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Dec 2020 11:50:54 +0800
IronPort-SDR: GkXxfFf3ZfcG4Q8i50FPskusLtSWDYH6mPohxIdi/mvt+1/a5LzNvoxsLsDjNlZvJw8FpNSPZ8
 giwbZSsIQm1L3xlLrenghCWw2NNXAwOPNVVjXalzJASIG1BU5xT7TE5X3zifqnOBA5/KpT7c79
 1Uu1bZJPTWkbxjymiw1Fvh3SpWX0LzokOuEBhNnnDZrnZlvyd4VFvzhjEH5pzFGswt22+8wBM2
 8nPgBUQtX+8cq/znBH7S3kpgAEPiKZgLreJb65v3BQ8vV9pcfHMKC6QlQUs65Xu4A9JMN+sW0W
 nMJaa39yw+qWhsdtVQixeoHQ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 19:36:05 -0800
IronPort-SDR: /Jn3DbzDejVaTr1MEUMR+fZZ++/CbqOWBPD9MbS3NheEchcbLAk0kf+Roo4vCLrPFAC7qQZIDj
 lotU35bTwJAS3QRYKfhysLYqmFzAjddt11803D5MGlgV6paUaHmnEslfjbjjHcDFaBgB/A1tma
 u2cI+0hUnQjdYDBo2zYE2uETZBxzek2SSgTsja9HgPaDWaRCD6SQvViEcCK4uiJd0V6JyBLq2N
 ZzMthUodRlnKFUuWvFrdqNETUBgRUob3Sj7lwKf6BAGeWZHAPO11gKjAr01AqP8oNVZAZbPEfF
 GjY=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Dec 2020 19:50:53 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v11 19/40] btrfs: extract page adding function
Date:   Tue, 22 Dec 2020 12:49:12 +0900
Message-Id: <a442f64e5fd84a823993e81f81f29287cd4ec274.1608608848.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
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
 fs/btrfs/extent_io.c | 56 ++++++++++++++++++++++++++++++++------------
 1 file changed, 41 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 129d571a5c1a..2f070a9e5b22 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3061,6 +3061,44 @@ struct bio *btrfs_bio_clone_partial(struct bio *orig, int offset, int size)
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
@@ -3089,27 +3127,15 @@ static int submit_extent_page(unsigned int opf,
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

