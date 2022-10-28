Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019BA61094D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 06:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiJ1EbA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 00:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiJ1Eau (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 00:30:50 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBD9625F0;
        Thu, 27 Oct 2022 21:30:48 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id g62so3833752pfb.10;
        Thu, 27 Oct 2022 21:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ps4fRWhKIumemA2cJEvrmieQ3xGKdOyI72P2C1pb+Z8=;
        b=cWiWSao6rmKSUdRf6IELyQFrHZUt6biTnKeGPCRJ9ogIbFsT1FHMDxnEx/IcMqVdE4
         XNLC10T8K6pN+V0haA790gUMZgfsJ/Og3u4mIazD0Yg9kbxaKoZqHtMr0H/HyxXR0LRH
         ACH8r0VDfBaLhA9X5MeYzrjmrMRgIdFPxar+CihcSkdTwbIfJHx6IZzUIohnL9T4wKiJ
         61V/rJ+AcPrPd+mnhjoRTw7uAj6WtYQoap6RqReN415wGj35ZPPnhb+G/lnzHc5xYNbM
         49f6rKynj5YFH/vWLwma+7OO08aJKP4CKYWDhvaznEIr/uMTrjfKRhQhYG2x6qlfJmL2
         Hlnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ps4fRWhKIumemA2cJEvrmieQ3xGKdOyI72P2C1pb+Z8=;
        b=1zr5E761R6IAheZi3qhjj4xvrd8iEz811k+lpTLk1xo4N+J9JdKx3eS15h/1o4Zazg
         nUU3cmHNOgujCsy+Tx8by8l5xnHKNT+6o4YU4FSmXC2hLUxGNW/WIV78rVuSGciHjP+Y
         r10JXABaPOHFk9JMk6LaJHvF/JRn7xjp7vDn0c7tlJtLvAoAF9afbghJduRTWibd87xv
         sGacSYSiDh4dZ7LgMM3YR6TXhDhg4PhkeLgV16xY8bGuy/+LFeUeeWYUurqtws5pgLWA
         qTrAmTfblPWZiUViYDvhWwqtuz+ubT0F+XTd++JoeCx/8cn+Q0wTzORt5NY+93DuLRF1
         GgYw==
X-Gm-Message-State: ACrzQf0zfTvdzo4iiW8YcJAvq5NuZ/cEfTGSuzmCvwGLyu9uWbvHNZl9
        4I1qWaxjeH4iLeb8oHVBekLdlRg3g8c=
X-Google-Smtp-Source: AMsMyM7BEagdfYlfOkBRtASCMGsqWIbNJm+R1oEvD7NZAT+p4/Zz/mqZQRDyYgHnCJzvg73Kl4D3qw==
X-Received: by 2002:a63:e806:0:b0:44b:d45b:b8a2 with SMTP id s6-20020a63e806000000b0044bd45bb8a2mr44631373pgh.14.1666931447844;
        Thu, 27 Oct 2022 21:30:47 -0700 (PDT)
Received: from localhost ([58.84.24.234])
        by smtp.gmail.com with ESMTPSA id qe10-20020a17090b4f8a00b0020c899b11f1sm3396527pjb.23.2022.10.27.21.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 21:30:47 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Aravinda Herle <araherle@in.ibm.com>
Subject: [RFC 2/2] iomap: Support subpage size dirty tracking to improve write performance
Date:   Fri, 28 Oct 2022 10:00:33 +0530
Message-Id: <886076cfa6f547d22765c522177d33cf621013d2.1666928993.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1666928993.git.ritesh.list@gmail.com>
References: <cover.1666928993.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On a 64k pagesize platforms (specially Power and/or aarch64) with 4k
filesystem blocksize, this patch should improve the performance by doing
only the subpage dirty data write.

This should also reduce the write amplification since we can now track
subpage dirty status within state bitmaps. Earlier we had to
write the entire 64k page even if only a part of it (e.g. 4k) was
updated.

Performance testing of below fio workload reveals ~16x performance
improvement on nvme with XFS (4k blocksize) on Power (64K pagesize)
FIO reported write bw scores improved from around ~28 MBps to ~452 MBps.

<test_randwrite.fio>
[global]
	ioengine=psync
	rw=randwrite
	overwrite=1
	pre_read=1
	direct=0
	bs=4k
	size=1G
	dir=./
	numjobs=8
	fdatasync=1
	runtime=60
	iodepth=64
	group_reporting=1

[fio-run]

Reported-by: Aravinda Herle <araherle@in.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/iomap/buffered-io.c | 53 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 255f9f92668c..31ee80a996b2 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -58,7 +58,7 @@ iomap_page_create(struct inode *inode, struct folio *folio, unsigned int flags)
 	else
 		gfp = GFP_NOFS | __GFP_NOFAIL;
 
-	iop = kzalloc(struct_size(iop, state, BITS_TO_LONGS(nr_blocks)),
+	iop = kzalloc(struct_size(iop, state, BITS_TO_LONGS(2 * nr_blocks)),
 		      gfp);
 	if (iop) {
 		spin_lock_init(&iop->state_lock);
@@ -168,6 +168,48 @@ static void iomap_set_range_uptodate(struct folio *folio,
 		folio_mark_uptodate(folio);
 }
 
+static void iomap_iop_set_range_dirty(struct folio *folio,
+		struct iomap_page *iop, size_t off, size_t len)
+{
+	struct inode *inode = folio->mapping->host;
+	unsigned int nr_blocks = i_blocks_per_folio(inode, folio);
+	unsigned first = (off >> inode->i_blkbits) + nr_blocks;
+	unsigned last = ((off + len - 1) >> inode->i_blkbits) + nr_blocks;
+	unsigned long flags;
+
+	spin_lock_irqsave(&iop->state_lock, flags);
+	bitmap_set(iop->state, first, last - first + 1);
+	spin_unlock_irqrestore(&iop->state_lock, flags);
+}
+
+static void iomap_set_range_dirty(struct folio *folio,
+		struct iomap_page *iop, size_t off, size_t len)
+{
+	if (iop)
+		iomap_iop_set_range_dirty(folio, iop, off, len);
+}
+
+static void iomap_iop_clear_range_dirty(struct folio *folio,
+		struct iomap_page *iop, size_t off, size_t len)
+{
+	struct inode *inode = folio->mapping->host;
+	unsigned int nr_blocks = i_blocks_per_folio(inode, folio);
+	unsigned first = (off >> inode->i_blkbits) + nr_blocks;
+	unsigned last = ((off + len - 1) >> inode->i_blkbits) + nr_blocks;
+	unsigned long flags;
+
+	spin_lock_irqsave(&iop->state_lock, flags);
+	bitmap_clear(iop->state, first, last - first + 1);
+	spin_unlock_irqrestore(&iop->state_lock, flags);
+}
+
+static void iomap_clear_range_dirty(struct folio *folio,
+		struct iomap_page *iop, size_t off, size_t len)
+{
+	if (iop)
+		iomap_iop_clear_range_dirty(folio, iop, off, len);
+}
+
 static void iomap_finish_folio_read(struct folio *folio, size_t offset,
 		size_t len, int error)
 {
@@ -665,6 +707,7 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 	if (unlikely(copied < len && !folio_test_uptodate(folio)))
 		return 0;
 	iomap_set_range_uptodate(folio, iop, offset_in_folio(folio, pos), len);
+	iomap_set_range_dirty(folio, iop, offset_in_folio(folio, pos), len);
 	filemap_dirty_folio(inode->i_mapping, folio);
 	return copied;
 }
@@ -979,6 +1022,8 @@ static loff_t iomap_folio_mkwrite_iter(struct iomap_iter *iter,
 		block_commit_write(&folio->page, 0, length);
 	} else {
 		WARN_ON_ONCE(!folio_test_uptodate(folio));
+		iomap_set_range_dirty(folio, to_iomap_page(folio),
+				offset_in_folio(folio, iter->pos), length);
 		folio_mark_dirty(folio);
 	}
 
@@ -1354,7 +1399,8 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	 * invalid, grab a new one.
 	 */
 	for (i = 0; i < nblocks && pos < end_pos; i++, pos += len) {
-		if (iop && !test_bit(i, iop->state))
+		if (iop && (!test_bit(i, iop->state) ||
+			    !test_bit(i + nblocks, iop->state)))
 			continue;
 
 		error = wpc->ops->map_blocks(wpc, inode, pos);
@@ -1397,6 +1443,9 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		}
 	}
 
+	iomap_clear_range_dirty(folio, iop,
+				offset_in_folio(folio, folio_pos(folio)),
+				end_pos - folio_pos(folio));
 	folio_start_writeback(folio);
 	folio_unlock(folio);
 
-- 
2.37.3

