Return-Path: <linux-fsdevel+bounces-26035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A3C952BE2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 12:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D7EA1F22CE9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 10:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC2E1E211D;
	Thu, 15 Aug 2024 09:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="h0itYGBR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEA71BCA0B;
	Thu, 15 Aug 2024 09:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723712981; cv=none; b=C9YB8ICbzgSrWHegMaa7lCNzMXTvb41lwgZ9p12iuNgVIveBIq77CdEzJuEZtIW0ZpxydjGbTklaYJeGI9TlqzTT+RGov+m48dNYmeEhs1CaS3yM2CCpa/XZ02ebP0rpydmm64ojaxbo8D0j1yvcFqcdVDDkb3GLW8YxlUFMz38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723712981; c=relaxed/simple;
	bh=Yg+YRdTBg5hGELKRFZ3k1jUXoyrsyFsRR3hRKhBmnu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IlRtsJSsM8rU8OO4VnbonM6ndbXSb+1eH8a4EC9zPCITDKgOLGcuqi0lbVXigZo2UuGOWVqBhDcLiAn9tLt4byd59oVe4sRc68l5yW2hUbEDAcVO0MFSDsafvVRmlfOLXcLgpLXqCl9uIK83k4lralQy48M6/VxSRYsL051hpZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=h0itYGBR; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WkzpJ4rC9z9tH1;
	Thu, 15 Aug 2024 11:09:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1723712968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uyP45Kb7uBDSBwQgasBASrViJg6ERuo2M5WpPhAgxr4=;
	b=h0itYGBR7U+eC3xJ2So8OH0XdSTYBdmL35lQJMwkKF+iuOzPpkOY+ABh+helnpAAAYjPxB
	nVXT4JJpXSfCLV7fZSCcjLv8XmQaubCtfdBrlyehhLz42F6N98P9j3xsHbyVZZS64K2WrW
	wImghDfD/gq8n8QqqP58PqtoNmQC8HJpgB1SDaC4wa2Fb0zGe3qh/Fro+VmwaIVbH1bWrk
	HL+K612QaE0qBAWtOyZPZwlgA4iQHFDNkVgYbuFUuIRoLDsc/Dr2gGgj4+i3N68a7fpflh
	rRlzgGphpd0taYzgyKwhcVwZnY4xcEMK3ZjpmT0U/irphQ2jMAQIK5Nykxy8YA==
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
	ryan.roberts@arm.com
Subject: [PATCH v12 05/10] filemap: cap PTE range to be created to allowed zero fill in folio_map_range()
Date: Thu, 15 Aug 2024 11:08:44 +0200
Message-ID: <20240815090849.972355-6-kernel@pankajraghav.com>
In-Reply-To: <20240815090849.972355-1-kernel@pankajraghav.com>
References: <20240815090849.972355-1-kernel@pankajraghav.com>
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
---
 mm/filemap.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 623c0f988da79..77b583a7aabd1 100644
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


