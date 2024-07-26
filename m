Return-Path: <linux-fsdevel+bounces-24314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EACE93D2AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 14:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C268F2811FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 12:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BC417BB1C;
	Fri, 26 Jul 2024 12:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="S8zUd4b9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8710A17B417;
	Fri, 26 Jul 2024 12:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721995238; cv=none; b=U9z1VLplGKeLZ5KAea9DPgKZXlvcfJZea4wktezXYk0kcFOQvJzq37rH/ytWBtVemYQmjlyegbH6qCJA1h0u5vEyDI1dYVFCt9iPJQymbc4mcH+41P4ma6UIeGHGnfaCBltNpgfrIAe9VgoA3eb/OW9edtj6wjLkhP+ggACobz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721995238; c=relaxed/simple;
	bh=Y6wnkr9YicCwKOn6q4dbs0j5MDwg7izxrtZViWy+w08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CvxTxpFpZ4zNKaQxB+g+P0jZqXhWNJmdKExTkWKEzAzvPso8GvMcSaPzibcp97I6TCGfP3YViyV2RsCtISqDZ9do0V9sV8pSZ1PE3PGhgPDoeNUti1gUGTelsptJABTnt7Xfro11cywkopbUtkU16KbnlFRhdWt99UfULLdw2lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=S8zUd4b9; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WVmXq3GNbz9t61;
	Fri, 26 Jul 2024 14:00:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1721995227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xbld/pizLMEJfrPYBqwQ81gjcSKIsZj5n7TDu8kDUY0=;
	b=S8zUd4b9nleV0856IBngGbMzeTPCVO64N152k7I1ao1Q2BDdzmiasjo0YlYJL+9SwYI8wy
	M3i5xAWMFzqlDmscQeIVxcpJoPByQaD3IXZmK52GN545FLNaNDQk4H0L3lDlQmM34Top1e
	N+n3N6SGuiX+swJCDr46SdKD5KUZjO/Te2HdnlGFz7755gYEr7X81lnN89zn/4krjtDCOl
	7RtCx0LhczAUhqqUN6NtYT41BVWmzZU3BVrJiIeos7oOhlIMWJ2QbS4fWd/R8bobyqRKkp
	2JDiKib9LAcrI3iZJ20YkPeq9vc4Yj4C8T68oXLWo8XigGJ23I13gZ2XhjpceA==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: david@fromorbit.com,
	willy@infradead.org,
	chandan.babu@oracle.com,
	djwong@kernel.org,
	brauner@kernel.org,
	akpm@linux-foundation.org
Cc: yang@os.amperecomputing.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	john.g.garry@oracle.com,
	linux-fsdevel@vger.kernel.org,
	hare@suse.de,
	p.raghav@samsung.com,
	mcgrof@kernel.org,
	gost.dev@samsung.com,
	cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org,
	kernel@pankajraghav.com,
	ryan.roberts@arm.com,
	hch@lst.de,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH v11 05/10] filemap: cap PTE range to be created to allowed zero fill in folio_map_range()
Date: Fri, 26 Jul 2024 13:59:51 +0200
Message-ID: <20240726115956.643538-6-kernel@pankajraghav.com>
In-Reply-To: <20240726115956.643538-1-kernel@pankajraghav.com>
References: <20240726115956.643538-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4WVmXq3GNbz9t61

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

generic/749(currently in xfstest-dev patches-in-queue branch [0]) has
been created to trigger this edge case. This also fixes generic/749 for
tmpfs with huge=always on systems with 4k base page size.

[0] https://lore.kernel.org/all/20240615002935.1033031-3-mcgrof@kernel.org/
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
---
 mm/filemap.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index d27e9ac54309d..d322109274532 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3608,7 +3608,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 	struct vm_area_struct *vma = vmf->vma;
 	struct file *file = vma->vm_file;
 	struct address_space *mapping = file->f_mapping;
-	pgoff_t last_pgoff = start_pgoff;
+	pgoff_t file_end, last_pgoff = start_pgoff;
 	unsigned long addr;
 	XA_STATE(xas, &mapping->i_pages, start_pgoff);
 	struct folio *folio;
@@ -3634,6 +3634,10 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
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


