Return-Path: <linux-fsdevel+bounces-56261-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B53FB15144
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 18:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E54518A1C4B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 16:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D35295DAF;
	Tue, 29 Jul 2025 16:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cybernetics.com header.i=@cybernetics.com header.b="dFUnq/TV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.cybernetics.com (mail.cybernetics.com [72.215.153.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4551270EA3
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Jul 2025 16:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.215.153.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753806314; cv=none; b=PIUp/8346qbKYJVtY3/eLHgnnv4M4bD0fcTnwuN6e7k4u//p3eMax3YHNN0N2ugtdqZKu0nFREjF7+4PfYi1uASll5iJR10XwaQSCmNkvPDeSQDwOcFrDkeneuIYnNcBUGiKmJfek7fUDSpaldv/kH3En7nqow5qNND1U+dxSIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753806314; c=relaxed/simple;
	bh=8WGW/u332m7iBIRo2+VYkware56X+PiBWChv1QdxcB0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=jMDXU6CkLVokBRVwY5qN60V4O7s+id6UzHPObz/ag9k7nvRiJKNb0MJ8whIuf4Ag/QFq9bn0ZCQkxzHtMix6xWT2gmMiu4oNm6AKkFC2NUu2b13Pgy5sQjmSXvICj3TePnoWKqrVc7w0bJIWTO864zvIzV1ZW6rBlPCGRG55dxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cybernetics.com; spf=pass smtp.mailfrom=cybernetics.com; dkim=pass (1024-bit key) header.d=cybernetics.com header.i=@cybernetics.com header.b=dFUnq/TV; arc=none smtp.client-ip=72.215.153.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cybernetics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cybernetics.com
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with ESMTP id 2UNKs8FjwTgmAkKy; Tue, 29 Jul 2025 12:13:43 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-Barracuda-RBL-Trusted-Forwarder: 10.10.4.126
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cybernetics.com; s=mail;
	bh=bX58Gpj8MJieSZ3eNdrwAn/t64m13puMU7fg2+7Zx0w=;
	h=Content-Transfer-Encoding:Content-Type:Subject:From:Cc:To:Content-Language:
	MIME-Version:Date:Message-ID; b=dFUnq/TVl3t81JN7hElW3rtu4ATn5LgcQkSo54IovGShE
	VME2N4n+4aU+Ypa0j/63IXbRAMyyEdpMUTnqUzmdNxXaUP2cY3mtLdIq7okzyy6cZuOLSSzWhRRnb
	xHjTEPUnSIbHLMgtc9r04mTseGyHjjOOX65ZqgEyX0NubAkS4=
Received: from [10.157.2.224] (HELO [192.168.200.1])
  by cybernetics.com (CommuniGate SPEC SMTP 8.0.5)
  with ESMTPS id 14113446; Tue, 29 Jul 2025 12:13:43 -0400
Message-ID: <55deda1d-967d-4d68-a9ba-4d5139374a37@cybernetics.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.157.2.224
Date: Tue, 29 Jul 2025 12:13:42 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Song Liu <song@kernel.org>, Yu Kuai <yukuai3@huawei.com>,
 Christian Brauner <brauner@kernel.org>, "Darrick J. Wong"
 <djwong@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-raid@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
From: Tony Battersby <tonyb@cybernetics.com>
Subject: [PATCH 2/2] iomap: align writeback to RAID stripe boundaries
Content-Type: text/plain; charset=UTF-8
X-ASG-Orig-Subj: [PATCH 2/2] iomap: align writeback to RAID stripe boundaries
Content-Transfer-Encoding: 7bit
X-Barracuda-Connect: UNKNOWN[10.10.4.126]
X-Barracuda-Start-Time: 1753805623
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 7085
X-ASG-Debug-ID: 1753805623-1cf43947df801f0001-kl68QG

Improve writeback performance to RAID-4/5/6 by aligning writes to stripe
boundaries.  This relies on io_opt being set to the stripe size (or
a multiple) when BLK_FEAT_RAID_PARTIAL_STRIPES_EXPENSIVE is set.

Benchmark of sequential writing to a large file on XFS using
io_uring with 8-disk md-raid6:
Before:      601.0 MB/s
After:       614.5 MB/s
Improvement: +2.3%

Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
---
 fs/iomap/buffered-io.c | 175 +++++++++++++++++++++++++----------------
 1 file changed, 106 insertions(+), 69 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index fb4519158f3a..f9020f916268 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1685,81 +1685,118 @@ static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
 		struct inode *inode, loff_t pos, loff_t end_pos,
 		unsigned len)
 {
-	struct iomap_folio_state *ifs = folio->private;
-	size_t poff = offset_in_folio(folio, pos);
-	unsigned int ioend_flags = 0;
-	int error;
-
-	if (wpc->iomap.type == IOMAP_UNWRITTEN)
-		ioend_flags |= IOMAP_IOEND_UNWRITTEN;
-	if (wpc->iomap.flags & IOMAP_F_SHARED)
-		ioend_flags |= IOMAP_IOEND_SHARED;
-	if (folio_test_dropbehind(folio))
-		ioend_flags |= IOMAP_IOEND_DONTCACHE;
-	if (pos == wpc->iomap.offset && (wpc->iomap.flags & IOMAP_F_BOUNDARY))
-		ioend_flags |= IOMAP_IOEND_BOUNDARY;
+	struct queue_limits *lim = bdev_limits(wpc->iomap.bdev);
+	unsigned int io_align =
+		(lim->features & BLK_FEAT_RAID_PARTIAL_STRIPES_EXPENSIVE) ?
+		lim->io_opt >> SECTOR_SHIFT : 0;
 
-	if (!wpc->ioend || !iomap_can_add_to_ioend(wpc, pos, ioend_flags)) {
+	do {
+		struct iomap_folio_state *ifs = folio->private;
+		size_t poff = offset_in_folio(folio, pos);
+		unsigned int ioend_flags = 0;
+		unsigned int rem_len = 0;
+		int error;
+
+		if (wpc->iomap.type == IOMAP_UNWRITTEN)
+			ioend_flags |= IOMAP_IOEND_UNWRITTEN;
+		if (wpc->iomap.flags & IOMAP_F_SHARED)
+			ioend_flags |= IOMAP_IOEND_SHARED;
+		if (folio_test_dropbehind(folio))
+			ioend_flags |= IOMAP_IOEND_DONTCACHE;
+		if (pos == wpc->iomap.offset &&
+		    (wpc->iomap.flags & IOMAP_F_BOUNDARY))
+			ioend_flags |= IOMAP_IOEND_BOUNDARY;
+
+		if (!wpc->ioend ||
+		    !iomap_can_add_to_ioend(wpc, pos, ioend_flags)) {
 new_ioend:
-		error = iomap_submit_ioend(wpc, 0);
-		if (error)
-			return error;
-		wpc->ioend = iomap_alloc_ioend(wpc, wbc, inode, pos,
-				ioend_flags);
-	}
+			error = iomap_submit_ioend(wpc, 0);
+			if (error)
+				return error;
+			wpc->ioend = iomap_alloc_ioend(wpc, wbc, inode, pos,
+					ioend_flags);
+		}
 
-	if (!bio_add_folio(&wpc->ioend->io_bio, folio, len, poff))
-		goto new_ioend;
+		/* Align writes to io_align if given. */
+		if (io_align && !(wpc->iomap.flags & IOMAP_F_ANON_WRITE)) {
+			sector_t lba = bio_end_sector(&wpc->ioend->io_bio);
+			unsigned int mod = lba % io_align;
+			unsigned int max_len;
 
-	if (ifs)
-		atomic_add(len, &ifs->write_bytes_pending);
+			/*
+			 * If the end sector is already aligned and the bio is
+			 * nonempty, then start a new bio for the remainder.
+			 */
+			if (!mod && wpc->ioend->io_bio.bi_iter.bi_size)
+				goto new_ioend;
 
-	/*
-	 * Clamp io_offset and io_size to the incore EOF so that ondisk
-	 * file size updates in the ioend completion are byte-accurate.
-	 * This avoids recovering files with zeroed tail regions when
-	 * writeback races with appending writes:
-	 *
-	 *    Thread 1:                  Thread 2:
-	 *    ------------               -----------
-	 *    write [A, A+B]
-	 *    update inode size to A+B
-	 *    submit I/O [A, A+BS]
-	 *                               write [A+B, A+B+C]
-	 *                               update inode size to A+B+C
-	 *    <I/O completes, updates disk size to min(A+B+C, A+BS)>
-	 *    <power failure>
-	 *
-	 *  After reboot:
-	 *    1) with A+B+C < A+BS, the file has zero padding in range
-	 *       [A+B, A+B+C]
-	 *
-	 *    |<     Block Size (BS)   >|
-	 *    |DDDDDDDDDDDD0000000000000|
-	 *    ^           ^        ^
-	 *    A          A+B     A+B+C
-	 *                       (EOF)
-	 *
-	 *    2) with A+B+C > A+BS, the file has zero padding in range
-	 *       [A+B, A+BS]
-	 *
-	 *    |<     Block Size (BS)   >|<     Block Size (BS)    >|
-	 *    |DDDDDDDDDDDD0000000000000|00000000000000000000000000|
-	 *    ^           ^             ^           ^
-	 *    A          A+B           A+BS       A+B+C
-	 *                             (EOF)
-	 *
-	 *    D = Valid Data
-	 *    0 = Zero Padding
-	 *
-	 * Note that this defeats the ability to chain the ioends of
-	 * appending writes.
-	 */
-	wpc->ioend->io_size += len;
-	if (wpc->ioend->io_offset + wpc->ioend->io_size > end_pos)
-		wpc->ioend->io_size = end_pos - wpc->ioend->io_offset;
+			/*
+			 * Clip the end of the bio to the alignment boundary.
+			 */
+			max_len = (io_align - mod) << SECTOR_SHIFT;
+			if (len > max_len) {
+				rem_len = len - max_len;
+				len = max_len;
+			}
+		}
+
+		if (!bio_add_folio(&wpc->ioend->io_bio, folio, len, poff))
+			goto new_ioend;
+
+		if (ifs)
+			atomic_add(len, &ifs->write_bytes_pending);
+
+		/*
+		 * Clamp io_offset and io_size to the incore EOF so that ondisk
+		 * file size updates in the ioend completion are byte-accurate.
+		 * This avoids recovering files with zeroed tail regions when
+		 * writeback races with appending writes:
+		 *
+		 *    Thread 1:                  Thread 2:
+		 *    ------------               -----------
+		 *    write [A, A+B]
+		 *    update inode size to A+B
+		 *    submit I/O [A, A+BS]
+		 *                               write [A+B, A+B+C]
+		 *                               update inode size to A+B+C
+		 *    <I/O completes, updates disk size to min(A+B+C, A+BS)>
+		 *    <power failure>
+		 *
+		 *  After reboot:
+		 *    1) with A+B+C < A+BS, the file has zero padding in range
+		 *       [A+B, A+B+C]
+		 *
+		 *    |<     Block Size (BS)   >|
+		 *    |DDDDDDDDDDDD0000000000000|
+		 *    ^           ^        ^
+		 *    A          A+B     A+B+C
+		 *                       (EOF)
+		 *
+		 *    2) with A+B+C > A+BS, the file has zero padding in range
+		 *       [A+B, A+BS]
+		 *
+		 *    |<     Block Size (BS)   >|<     Block Size (BS)    >|
+		 *    |DDDDDDDDDDDD0000000000000|00000000000000000000000000|
+		 *    ^           ^             ^           ^
+		 *    A          A+B           A+BS       A+B+C
+		 *                             (EOF)
+		 *
+		 *    D = Valid Data
+		 *    0 = Zero Padding
+		 *
+		 * Note that this defeats the ability to chain the ioends of
+		 * appending writes.
+		 */
+		wpc->ioend->io_size += len;
+		if (wpc->ioend->io_offset + wpc->ioend->io_size > end_pos)
+			wpc->ioend->io_size = end_pos - wpc->ioend->io_offset;
+
+		wbc_account_cgroup_owner(wbc, folio, len);
+
+		pos += len;
+		len = rem_len;
+	} while (len);
 
-	wbc_account_cgroup_owner(wbc, folio, len);
 	return 0;
 }
 
-- 
2.43.0


