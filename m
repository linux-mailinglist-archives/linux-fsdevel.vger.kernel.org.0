Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA4D30495A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 20:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733059AbhAZF3P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:29:15 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:33029 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732027AbhAZCfa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:35:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611628530; x=1643164530;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=93seYua6GtUzgBRkbG55tIMzckw0frJtOIIYR7zSu2g=;
  b=dPce5jkc3Yryib5NvX+XfXghfHerD9Jsl4nRtDuapeEZEnQ7jEn6R22v
   d5R0P8nZS8q5tpreQ4usLwWflBGV4ey8xEVpYDdqXfnj4WGV2KShnSpEC
   jgjw7Im26IEUuAq/+96ek4YJGmIMbSOScNxefBXq0+BaCLr8RIHKtlVaX
   IDCU8DTLe6RDvH3d6DVeNjkgA8X/AqLNpGREp7u2yyE7pPo9PfUStxGbg
   Q7DMzPN2EFTYms3q6tUC/SyGlHBF86YpHyxYWfa04zlcgP+GzUav6sNb6
   luFJnlgYq166b5VA4fCcypsOYXaTE9dNerElh15k55CqJx0sghgZKJHPS
   Q==;
IronPort-SDR: IeLwFrchL5at2eegMnR7G/XJ9dne8Xi02FBELvDJhhc3+Mz6mvUTRb6x2Z5UjwllhFjzn0uEUn
 ar2T98IO102231lFStlkHvU2c5yae5gyw4NozF0d6B23CCWjjGIatdGgSyLIFrYOjKDpTq+gEu
 oiigWr3HKsy64V75uYXQhIARHeiJqaUdF7UDB4VcGvLD/JKiUljunKr1B08ITR/ZVwULDGh44Q
 gud5f07oh/UzH4YdTfsuJD7yKnj7e2MtsSM9ezjW6m/7dhgvYS95hgY+OFO7MEXErgFxBykgee
 jB4=
X-IronPort-AV: E=Sophos;i="5.79,375,1602518400"; 
   d="scan'208";a="159483544"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2021 10:26:31 +0800
IronPort-SDR: YWThrVYiADF4pTcEo3Jq36fVvXq5q7xj3U4UKDo1udgDnnxOks+1VvcEC9ECW7OXKLonA+cp26
 1v0EUAHMSTN/gYYGKBpiEhSQaNwT+CsInKZLhBRblmKO2SGwVW1zea0Oe5tnEOhbtF/M8ztzHM
 S0agUgOhBCbeYYC54j4e537GISEWBE7hr/h/eZGezw3aLlglrl9kkKHrvEiFnQpecn+oCwxuda
 m2PvVyzdqK4qoK7MNhn6C+WMvO1o+5qzcWqz2d5isrQkyLOY/xSX6od8QdurKN6pO+N6p3bTaY
 keQ42hbX5+64qa2uVIFOCHaF
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 18:10:58 -0800
IronPort-SDR: ppnNv1gEYu9RKJ5hsqCPzI7TY7TOkmT10sD95NMwXP8KeBmkUKQY5LK5IiH86VCkecc6aSvZKx
 9JBWjHvVeJvRXxOa0n5a3E4mOEnKguzb+Z+uB753clDTVHKTBMY1PqgsIRjIvadUynHQ48AtFI
 +sFgP0pJT618ewy+NCp2AYO+VJ9rIHklkZXVPQm/9f6lhOEGwW1vVnDJDYtbUezuem15XGHBBI
 NZDoKGcmcFStL7uWABgOckxY9sCGV/J77C4d/pjY1wFXncKsDpbCvTMdZ20s++K6otpZJPQGcb
 GfE=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Jan 2021 18:26:30 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v14 19/42] btrfs: extract page adding function
Date:   Tue, 26 Jan 2021 11:24:57 +0900
Message-Id: <96945d7bd401af14e03525c0c4fe3557ab9441f9.1611627788.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611627788.git.naohiro.aota@wdc.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
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
 fs/btrfs/extent_io.c | 58 ++++++++++++++++++++++++++++++++------------
 1 file changed, 43 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d80b3a96ae49..df434f9ba774 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3060,6 +3060,46 @@ struct bio *btrfs_bio_clone_partial(struct bio *orig, int offset, int size)
 	return bio;
 }
 
+/**
+ * btrfs_bio_add_page	-	attempt to add a page to bio
+ * @bio:	destination bio
+ * @page:	page to add to the bio
+ * @disk_bytenr:  offset of the new bio or to check whether we are adding
+ *                a contiguous page to the previous one
+ * @pg_offset:	starting offset in the page
+ * @size:	portion of page that we want to write
+ * @prev_bio_flags:  flags of previous bio to see if we can merge the current one
+ * @bio_flags:	flags of the current bio to see if we can merge them
+ * @return:	true if page was added, false otherwise
+ *
+ * Attempt to add a page to bio considering stripe alignment etc. Return
+ * true if successfully page added. Otherwise, return false.
+ */
+static bool btrfs_bio_add_page(struct bio *bio, struct page *page,
+			       u64 disk_bytenr, unsigned int size,
+			       unsigned int pg_offset,
+			       unsigned long prev_bio_flags,
+			       unsigned long bio_flags)
+{
+	sector_t sector = disk_bytenr >> SECTOR_SHIFT;
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
@@ -3088,27 +3128,15 @@ static int submit_extent_page(unsigned int opf,
 	int ret = 0;
 	struct bio *bio;
 	size_t io_size = min_t(size_t, size, PAGE_SIZE);
-	sector_t sector = disk_bytenr >> 9;
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
+		    !btrfs_bio_add_page(bio, page, disk_bytenr, io_size,
+					pg_offset, prev_bio_flags, bio_flags)) {
 			ret = submit_one_bio(bio, mirror_num, prev_bio_flags);
 			if (ret < 0) {
 				*bio_ret = NULL;
-- 
2.27.0

