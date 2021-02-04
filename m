Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A49630F0AB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 11:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235474AbhBDK0y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 05:26:54 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:54218 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235470AbhBDK0l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:26:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612434401; x=1643970401;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+YA1u2fIjmfdYUc6OdukrKqhcyqEGqgAMSEE4YwOv9A=;
  b=n5lLGWuyFgO55DCAm93TVD+YxF08WNQq+9UAty/1RbOIvz7/au5/yhug
   lF4HL8HnP8vSXYgtZxAZb08giwgywYGMo40Jfw7QSIrazbhoSJq8Xu1yB
   mlS7zFcVsRi3YJ1UFPRDPkewT57NfdLO1In0Uvkpr72kN6xN2pYufec08
   zywhsiThVFRPG23kIpngJOtKEpnt+PYznOEg8re9PXq7VnmuKriN5sUK9
   B0d0z8QNcEZC6nWAA0kJa4EQ1TH65NI3Q/QFPgpGevLqOE3NH2YGTyLgx
   ZPlbFUywxUXGdRmQ8Jhs7XRWazMTXahYY92rCeKgWSCb8P0gPS6HOQSrs
   A==;
IronPort-SDR: PyZi7ajfz2jV/CrmKWcL41+HEh1g5vz81ls/dXcoZVlIpS7RxJh8u14Qhp2WgIXuFb3M3EnUNd
 2YOzghReGzrFHp/MGKuT+aQA/f1r8sKTBlQhzmdZllRk9A5vYouXFGqIRGAjusA2zaa60SsN8F
 uzEGM+ossW9akor5roclW+HntzNd51KiCvuNROchqKyFuCooDlnSze7laV/1t+gVGI4lXezKKE
 92I8FXRqsKg/kvUkPEgP5TKRGmaXonl3jsDSV2A+ZGccDLboNlbsqzT6ZEN84ly6nc1lDQIUDK
 OEk=
X-IronPort-AV: E=Sophos;i="5.79,400,1602518400"; 
   d="scan'208";a="159108008"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2021 18:23:20 +0800
IronPort-SDR: ui0Ek1wH2M8uCVlTReBge7ijrFZNSlTIxHdHuI5WZlSDjKC52dGQrhk5P9nzwxSEbXE70Mc2sB
 55os5woBFSBwClbcvIzfQ9/V7m6d0qu0fEokwznCd/0xJvRFSChNZQWTxGk4BKfBljWqAmsUHQ
 amkLFeKMg0gz1j8tSozPTtQXA3jHdO3sMumcdiaCIfNoK04kWqZ0nBUfNMigZM9Zhd0B4oTeQf
 hgM2IJ2us+5M6YrkH+kl1eO/sz/qNU3YIjuOTHphragFaQlhEy6bVNlCensdJeijTzt8wmFbwt
 T+4z2ASugshpNV2Shz4jeRi2
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 02:05:23 -0800
IronPort-SDR: fx9ASOv67TOLqhuov9BfmWJWRQFX/Ie0T0viZbdXHXGrhz25NHpdDKkyJilvuQasQ/pYlfsB13
 z3N433GRluUF/r8UgDv3QnZgWm0j6l0pZC9Eh9zWT8iFoWEeBiGgcaOJL1C5ODKCAybZTdlKj/
 bwGBvKLbNxDUgx8CjzWcTzoPvyMTyeEtuqmNw6Cj/8EOy8bsQFflgsLymqWpKCtYXX9skJGHwC
 ZyIAwDopyKC3+DujFoqsFWXJsVsQboCqKz79icMsspZ5ZbFVN/TL7FZFhb4MZaMroCo3RyM9HO
 TDo=
WDCIronportException: Internal
Received: from jfklab-fym3sg2.ad.shared (HELO naota-xeon.wdc.com) ([10.84.71.79])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Feb 2021 02:23:19 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v15 18/42] btrfs: factor out helper adding a page to bio
Date:   Thu,  4 Feb 2021 19:21:57 +0900
Message-Id: <db222731674ba8f7aa9c92af8c62b82d48b8662f.1612434091.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
References: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Extract adding a page to a bio from submit_extent_page().  The page is
added only when bio_flags are the same, contiguous and the added page fits
in the same stripe as pages in the bio.

Condition checks are reordered to allow early return to avoid possibly
heavy btrfs_bio_fits_in_stripe() calling.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent_io.c | 60 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 45 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index fa9b37178d42..5db7e6c69391 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3084,6 +3084,48 @@ struct bio *btrfs_bio_clone_partial(struct bio *orig, int offset, int size)
 	return bio;
 }
 
+/**
+ * btrfs_bio_add_page - attempt to add a page to bio
+ *
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
+ * Attempt to add a page to bio considering stripe alignment etc.
+ *
+ * Return true if successfully page added. Otherwise, return false.
+ */
+static bool btrfs_bio_add_page(struct bio *bio, struct page *page,
+			       u64 disk_bytenr, unsigned int size,
+			       unsigned int pg_offset,
+			       unsigned long prev_bio_flags,
+			       unsigned long bio_flags)
+{
+	const sector_t sector = disk_bytenr >> SECTOR_SHIFT;
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
@@ -3112,27 +3154,15 @@ static int submit_extent_page(unsigned int opf,
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
2.30.0

