Return-Path: <linux-fsdevel+bounces-26732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA05C95B78E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 15:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61D0D28636C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 13:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED2B1CEAD5;
	Thu, 22 Aug 2024 13:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="J0HCp7BX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3221CB136;
	Thu, 22 Aug 2024 13:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724334666; cv=none; b=tNHX1CMBl1BdCO0Namb6NdHGuWjKIy//gCM3W0I5kK2h2ZwRBYsTcpPV45jEGn8MRYo/V/nhUfDW0ixDugZTDG7oI1Uep4UuLdW+TM2iP8ako3HwINIM7EhhX6PqG1PoyZAfvKAi2tZYZysaD2Jm3vD8D/XeV3NG2pA3JNvqQmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724334666; c=relaxed/simple;
	bh=PzomrYcS5MsbwmYGtgT6nQN/QehlXO49qE1JuEEmT4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iWkrLZIP402Dq46rUUnspWgh/tImA9LAkSxpA2u4n0DyiTKo+e9rkyYy31GE3lo1xBQqfZJxohKjMXHa6OW/PYI6e1S37vysgAoPPto7BZ8Iu+xsKozOf9qsuLVtC02In9uf/uSxbipwcsJft4/DDM1tie10NxJEhGADMWMW0xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=J0HCp7BX; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WqPjq2sLvz9t4y;
	Thu, 22 Aug 2024 15:50:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1724334655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Q1lbNMqgjDwqXL3NMwe856kt2DWnR8U6HSjOpp9wIA=;
	b=J0HCp7BXa6hLOSuHOQdvc1tqzAJwVHXrI6wHgtgDZKOx5Vsa9imVJ7aEDuNgTxZZOJ45Xg
	vuTXxmTLHQEjTAuPYLpI2WKg9Tf40FDsa2jZJP9J+xBkawdcZ9ZXZoaebLfQBmWq+PZOvj
	/fZ4kfiR5/HCF0mprnb5JZHnl1Jytl5CiAZJ68wC3UdQajUvMv+S2i/kp2Es/uNeOUzhI4
	BKbHhS/Sf0Wh3x5MmBQxNV9gS3KZPyfNEAoIESk3kUwDA6e/JywmZoK1G71/GODP13GZpl
	COWjMESiif/EilWe1/RDOigqZhf+45xezdL2GC4Wumxpcgx2YEKsWhljf2097g==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: brauner@kernel.org,
	akpm@linux-foundation.org
Cc: chandan.babu@oracle.com,
	linux-fsdevel@vger.kernel.org,
	djwong@kernel.org,
	hare@suse.de,
	gost.dev@samsung.com,
	linux-xfs@vger.kernel.org,
	kernel@pankajraghav.com,
	hch@lst.de,
	david@fromorbit.com,
	Zi Yan <ziy@nvidia.com>,
	yang@os.amperecomputing.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	willy@infradead.org,
	john.g.garry@oracle.com,
	cl@os.amperecomputing.com,
	p.raghav@samsung.com,
	mcgrof@kernel.org,
	ryan.roberts@arm.com,
	David Howells <dhowells@redhat.com>
Subject: [PATCH v13 05/10] filemap: cap PTE range to be created to allowed zero fill in folio_map_range()
Date: Thu, 22 Aug 2024 15:50:13 +0200
Message-ID: <20240822135018.1931258-6-kernel@pankajraghav.com>
In-Reply-To: <20240822135018.1931258-1-kernel@pankajraghav.com>
References: <20240822135018.1931258-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pankaj Raghav <p.raghav@samsung.com>

Usually the page cache does not extend beyond the size of the inode,
therefore, no PTEs are created for folios that extend beyond the size.

But with LBS support, we might extend page cache beyond the size of the
inode as we need to guarantee folios of minimum order. While doing a
read, do_fault_around() can create PTEs for pages that lie beyond the
EOF leading to incorrect error return when accessing a page beyond the
mapped file.

Cap the PTE range to be created for the page cache up to the end of
file(EOF) in filemap_map_pages() so that return error codes are consistent
with POSIX[1] for LBS configurations.

generic/749 has been created to trigger this edge case. This also fixes
generic/749 for tmpfs with huge=always on systems with 4k base page size.

[1](from mmap(2))  SIGBUS
    Attempted access to a page of the buffer that lies beyond the end
    of the mapped file.  For an explanation of the treatment  of  the
    bytes  in  the  page that corresponds to the end of a mapped file
    that is not a multiple of the page size, see NOTES.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Tested-by: David Howells <dhowells@redhat.com>
---
 mm/filemap.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 9a047c6d03e4e..eab1f12e7b840 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3607,7 +3607,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 	struct vm_area_struct *vma = vmf->vma;
 	struct file *file = vma->vm_file;
 	struct address_space *mapping = file->f_mapping;
-	pgoff_t last_pgoff = start_pgoff;
+	pgoff_t file_end, last_pgoff = start_pgoff;
 	unsigned long addr;
 	XA_STATE(xas, &mapping->i_pages, start_pgoff);
 	struct folio *folio;
@@ -3633,6 +3633,10 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 		goto out;
 	}
 
+	file_end = DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE) - 1;
+	if (end_pgoff > file_end)
+		end_pgoff = file_end;
+
 	folio_type = mm_counter_file(folio);
 	do {
 		unsigned long end;
-- 
2.44.1


