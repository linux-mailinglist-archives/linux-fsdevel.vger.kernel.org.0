Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 923322FFCA0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 07:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbhAVG0V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 01:26:21 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:51034 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbhAVGZr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 01:25:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611296746; x=1642832746;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OZu0hn380A0SKADq2p8+XA/2CYsLVFmKuaW6JAXQtyA=;
  b=cOZzLi2XeK8WFkQMLgirSFmLbQi0rTax5WSfujGV1KXEQyUrkb/vYJMX
   gU9nPU6cmUvHZIx8cEA29XZ9mNSgdihIFJGstfwnMEmeCqk+odoxrKu8k
   /OXFiCWH33mTt0TrmjLEVlgRJmDn/KDvdOPjrWx3P0GXd3tlVArIMElUv
   swkcWIqB646Rmbdpuc7R73JTXthnCQ9mUhHH3MOc+t+cXKosUtl9XMFL5
   6dikcNyDKI5ZpoQRzwZFvqC2+lhhvHvEoSSVPLH7lmocLnbCtY20pt0Sf
   jsDREp6mtX3kERfn658qy8bCI8JF/InUTx3CajOibuN/+GiZY6F25ZlKt
   Q==;
IronPort-SDR: tId0Pj5VHGWHAUpHcGnMIDDYfcl9M6rYw2Rw52cEtoL1ivXrmkZKQ6FjQR1pcBJst3ZYm57xD8
 MdU2AmYinxnoLrzS8RAfCrtUvJVg8wAIImRcfZPbJo5egOwFYzalNd/pH8O6kiQ5DbarpXOmMJ
 +PYHJKxkCHC5ZBw0la2sRIeNbQE4JrtyyA8RnNVHq60Y33VL3VSLtzPKn34EXXJRWcG/bWv7r7
 YSS+hLiqZUxCJsZyJWwjHiKlsPqNs8tAH6Zj/vTfYyu81z/D/+sPnefM5gXW849W6jtxtzY+qo
 gjo=
X-IronPort-AV: E=Sophos;i="5.79,365,1602518400"; 
   d="scan'208";a="268391998"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2021 14:22:52 +0800
IronPort-SDR: IEb4zx6TQj/sZY9yuoY/gtWWRzuuVcN3Sku38fGcl2zb5V1hTon9Z7GLzO36dpecaYCpcay6Hk
 boAJ6cVGsifLJof32Eg5xwouTrAkn+SS2zlCQm4/M1aaQS8G9bV6YpUwdHTDVJZddy0Z20ZI7K
 YFHXPajwn3UFK57GJz9Hty6i/gbF7m2hQoZv/MA8u+3P8sMvUGzJNG5aS7ODmdyMm1ysNvG90g
 z1m7UH9w4kp2eTAAeORYRasaDi4CcxW/iMkdKWmPplajn3fpXJy8rXi4ou+hR6EX0JXddf+jir
 ggjQ+9mEx42ruF1VGJenjxYF
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 22:05:24 -0800
IronPort-SDR: ob9lTzFCvxZCGWngV0JrUsGkrYnY5vtElqcS6QLfsMZkQqhg01Db4x06POzDbt6D3F+J6M2fW8
 7OqxJ/oVdvzWy4t9Gn8evHXBhwHh9gHPjITa7r8dWJQY8EGSsdGSf/CfjxutVYwKQWfWTr0QkY
 BYUSZk+vMDg27K9UQVnuh/w+0w4fjeveqPnPw+jwgFLItPEN1N8ya6wTgAcIY8W3ryv1fAXqgk
 BPod/Z55BL3+TEcWcNWy+zBZGem3acyO8A/ioXdJuDAcu7u6Gdi9lNmmSo7ugOQKp+3B554zY+
 jbg=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Jan 2021 22:22:51 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v13 19/42] btrfs: extract page adding function
Date:   Fri, 22 Jan 2021 15:21:19 +0900
Message-Id: <f3ce996099534c396cce8272e26cabfb0505608d.1611295439.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611295439.git.naohiro.aota@wdc.com>
References: <cover.1611295439.git.naohiro.aota@wdc.com>
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
index 1e652281afa6..df7665cdbb2c 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3059,6 +3059,46 @@ struct bio *btrfs_bio_clone_partial(struct bio *orig, int offset, int size)
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
@@ -3087,27 +3127,15 @@ static int submit_extent_page(unsigned int opf,
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

