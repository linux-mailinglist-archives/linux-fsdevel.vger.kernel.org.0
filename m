Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E952AD4F7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 12:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731275AbgKJL2o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 06:28:44 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:11959 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730651AbgKJL2j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 06:28:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605007718; x=1636543718;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0DiHBGFjDCJ5ptw3denLqvkhsyqTI6b8OhHflIU+leY=;
  b=ViMwpgc1NRjgIw3kLEwqUfoYvk1n9d0ds3zMGixe62n27MvqE0l9sQDD
   z1EcTYd5VaNmaHzKO3K9l9zuqtlAHepCQVUp0HgAi+aNHVVnpbICZIDKK
   YGRO7MA9qcrI0cN4sPRPIXnP0LhU8APPRGassAjJWntubNyEWqLOuHZ0W
   cJp1opu1oPsY+ed0slSs0QWLK20lt0PJvPNlBwQJAcAAgmolx4Vawgu9V
   n3+o6Zl+q9Q6bn0vJBzI5UtBdEV7FWDA5CdqcJNOBYVWSP1e5mDvMNGhA
   lCI7/DOjPct7rAst/tRQoZXGaefu6CzW1TAeNffkGv08vUMWtHn1GUmTF
   Q==;
IronPort-SDR: ZevCRCd8Z6FT52ZQtBie2joxAfcjwk48e3FJ+QlY8mkO8SxPuy1rjWZuk44RjXVzluTEvekIXL
 Y/6o/D/Yq1NhoOQbSgob/xYEZrsyjD9moyNS/PsrcEikaB2zY0zyMYc+2sfCJjuI7kdyWpBLKr
 SU0KEPxOWneFQ1Dgsj+4DCPt38/DHCHcWCLbd6Na5txjVFQ854X61U2DhPC+KfsWNphwkJL1QI
 K1ZMttbmmkgWUx/WhO+JEi3AsLsuJBF4WFjbAyIO+W/jN5rJOtGi17zauSHI6ayL4D9ty3JJMO
 d0I=
X-IronPort-AV: E=Sophos;i="5.77,466,1596470400"; 
   d="scan'208";a="152376546"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 19:28:37 +0800
IronPort-SDR: iM+FUreI4CxIDHtCwD0XHbj5Ce9GUFzHDMOpfr/ZUQem8o4glink2+VHyv3lox6RrrF9ukOMMU
 G+khoatX74QzUsBqArLZbGOhHI0i555fl3+3jhYimY5eAWj4AIxq025vt880k4L9xAYD9I6u8m
 3dLZf2Wa3gSFRwRVfouaiPH9N5pIYfTwyHsp4bAExwU1jlDXzgCNTbJNrHuyrKl6doGKEtb3+q
 ayJOC8wGzDK88r9WUwRHqVuQUlJTt/GyCz6k57jrKTdRC80bix7P70K6fKQMN8JeqmGeY+9ZZb
 fBHhnmv+5YgZ7LRWhm3T4RlU
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 03:14:38 -0800
IronPort-SDR: M9Lv1HMBCoQ6QrL93UKKXBJUG9DCaYFF2aV5jYYqLBQsClN2EKnp6GIy9/UIRTsmzftLAqtCeb
 Z4w1dc3gm2F9ETPBlJdKTTUWVGDqRoNraZ1/XHhp3o7KwOaiQH0CG35MQP3gaShYXTZI1jOg8h
 jit9zVPwdsbw/MVjLWBMdqcR/rsw9xLCRoGDk2a7yUpM7zEHv1/ImnmLBaCLT11xWJ6FfYd7vm
 YTqf8v/ojy06KZbuKrCrOo8KgeLTeEwJQaDF4RjPsfbkRiFLrfe3NINEwBe0P8Fgl8pCgvK9Ys
 zGA=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Nov 2020 03:28:37 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v10 20/41] btrfs: extract page adding function
Date:   Tue, 10 Nov 2020 20:26:23 +0900
Message-Id: <d61bf18010906da87d1472cd16f512680a12ac6f.1605007036.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1605007036.git.naohiro.aota@wdc.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
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
index e91c504fe973..868ae0874a34 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3012,6 +3012,44 @@ struct bio *btrfs_bio_clone_partial(struct bio *orig, int offset, int size)
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
@@ -3040,27 +3078,15 @@ static int submit_extent_page(unsigned int opf,
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

