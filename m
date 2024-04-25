Return-Path: <linux-fsdevel+bounces-17741-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA748B2075
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 13:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A08531F2548B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 11:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E11812C54A;
	Thu, 25 Apr 2024 11:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="jCmWig6I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B62D12A17F;
	Thu, 25 Apr 2024 11:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714045099; cv=none; b=nk4ClGAkRRedCtku/hyQZI4k5emACBmcifEuqgrB5HHBXd3S4Mbu2pBwQk22fPo+NGekmrud32diuiD1y5rJJFPbIkGnACCphYkwcGbKjULcW2YWrPkk2bskCqD4V1fwTtV+kjC/C/ANzrnG9hKhhIf12GKh2S9R3nF+QAUu+6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714045099; c=relaxed/simple;
	bh=2qjEihRuFxVVTsaAMCqdiZD7PcLnHkfVOtFWGATkUL0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CZbTwbSwWjYvOBZF4a54Q0UzIgW5DwgXqStxSy9a0KPrw6lfxxNGp8GbmCXeZVPF+GNpjGZwsrOvarFyguq3ZE0Mt3yuDH5RwcpPyMsnD4f0Tqf3G+qlF05swRr5er1KrM/9jVZVUMW41KIwR8U/IksDUK2MLAkhMd9zrD1BZyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=jCmWig6I; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4VQDPd5S7kz9sc2;
	Thu, 25 Apr 2024 13:38:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1714045093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=czSPhYVZqlifLCbGSVD4LN8Jicbe+9jxrg74bkE8W+M=;
	b=jCmWig6I8MmC4tVVnlqLI5vW94Wwlz9pRSUJiLooHMkOOe7ErsyVoFx2VhJY/WmdTxbbRT
	3dzg1UBlN4MP4RmAdPxL20o+ed6dhEyL92yPfrr/KbjbRfO3NVL1umnag6JzyRlRB6r5zC
	q4tIjG3KF/flynDrsYPmLRPtC8lMuVFbc3cQXAl6p3O/gubiU3hUBvII5ArCSxnWG3PUIL
	SCX71g1J51gObsRKmh9vM7WMGb8WM5/CcZazYgw6T63Kl7NB5sOhnSNIvvGue/BhWjHzoo
	P4xXrijI969rMXgdWqBJooEzEPQorZWYJq7MfcKRzA79aD6/EfPrL4zxXw/Skw==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: willy@infradead.org,
	djwong@kernel.org,
	brauner@kernel.org,
	david@fromorbit.com,
	chandan.babu@oracle.com,
	akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org,
	hare@suse.de,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-xfs@vger.kernel.org,
	mcgrof@kernel.org,
	gost.dev@samsung.com,
	p.raghav@samsung.com
Subject: [PATCH v4 06/11] filemap: cap PTE range to be created to i_size in folio_map_range()
Date: Thu, 25 Apr 2024 13:37:41 +0200
Message-Id: <20240425113746.335530-7-kernel@pankajraghav.com>
In-Reply-To: <20240425113746.335530-1-kernel@pankajraghav.com>
References: <20240425113746.335530-1-kernel@pankajraghav.com>
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
inode as we need to guarantee folios of minimum order. Cap the PTE range
to be created for the page cache by i_size.

A fstest has been created to trigger this edge case[1].

[1]https://lore.kernel.org/fstests/20240415081054.1782715-1-mcgrof@kernel.org/

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Co-Developed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 mm/filemap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index f0c0cfbbd134..259531dd297b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3600,12 +3600,15 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 	}
 	do {
 		unsigned long end;
+		unsigned long i_size;
 
 		addr += (xas.xa_index - last_pgoff) << PAGE_SHIFT;
 		vmf->pte += xas.xa_index - last_pgoff;
 		last_pgoff = xas.xa_index;
 		end = folio_next_index(folio) - 1;
-		nr_pages = min(end, end_pgoff) - xas.xa_index + 1;
+		i_size = DIV_ROUND_UP(i_size_read(mapping->host),
+				      PAGE_SIZE) - 1;
+		nr_pages = min3(end, end_pgoff, i_size) - xas.xa_index + 1;
 
 		if (!folio_test_large(folio))
 			ret |= filemap_map_order0_folio(vmf,
-- 
2.34.1


