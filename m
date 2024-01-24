Return-Path: <linux-fsdevel+bounces-8790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FE983B0C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 19:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 050631F26B5E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 18:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C970212A165;
	Wed, 24 Jan 2024 18:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gHbVnnpo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A289E12A163
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 18:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706119943; cv=none; b=bUsVhPV63rmgyTR361e2NNb9rlpRgSfrv1CJdyWJniHQ9SygrG3BtLmcbHRKaNOMp7GM+ZvCxvISqoFTBrftUG8td2MVhvi44FflLoCa18RVGEuEqQ6cuduV8FKt1UMBi/cLtix4Xxx1MSs+/lNQ16fTarlKaZGgfKxnUKe82dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706119943; c=relaxed/simple;
	bh=FMBb1I+lOesDMp3w1WhZWymfe06I+wFRnvW/je0MqFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BM6AtJOFNf9ROpi43svAk5HKAsR2yGjh0rwc3u+qhatpbpXW2SvlfDTg3mY4Jn9nCJGFPlkLGJDfl34L3gLmFkfKYZVRi8u8DHEE5SEUxN66ZhdPt9Le22DVsE3nKi0XAb16SUMupkyfwLT+dYHhEhtO8HtA3ntOZIqrEM+sQqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gHbVnnpo; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=AhiVK5zsyYmL8/e8G+YJeZMHQTJ4c3uco+OF9oETteY=; b=gHbVnnpoemGsB5FcNnKgoKSR8v
	D8yMXtsSgBx/UBGynJsDOhDRhXF8V+E0rSAFpaZVNmHrCev0B5iJPBYh8di2iBQ9jmio8mj7LoKRA
	DZ2wv22cqqeJHTCdSlXzyn2hGZYkv7ll220KxBg4wrrny9VfS8OpNbUciYxs/RQa1VaLDyqUkZThN
	HKaJV/lZCOjoNxfFYk/Rb58sZakaIil13ivkQeZwcNrJVFt1kNQIm66ILYTnREmVsg8UUv5Y14lNf
	z1AB+IQoEh33XvzF86Bj85lNWzePz67qfQVomyYjUxzySUY5sgKsGV6RJbCiHrlvR27gCYcaTFnAr
	nLIMUn4w==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rShjX-00000007OIL-1M4i;
	Wed, 24 Jan 2024 18:12:19 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] highmem: Add kernel-doc for memcpy_*_folio()
Date: Wed, 24 Jan 2024 18:12:15 +0000
Message-ID: <20240124181217.1761674-1-willy@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This was inadvertently skipped when adding the new functions.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/highmem.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 451c1dff0e87..00341b56d291 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -439,6 +439,13 @@ static inline void memzero_page(struct page *page, size_t offset, size_t len)
 	kunmap_local(addr);
 }
 
+/**
+ * memcpy_from_folio - Copy a range of bytes from a folio.
+ * @to: The memory to copy to.
+ * @folio: The folio to read from.
+ * @offset: The first byte in the folio to read.
+ * @len: The number of bytes to copy.
+ */
 static inline void memcpy_from_folio(char *to, struct folio *folio,
 		size_t offset, size_t len)
 {
@@ -460,6 +467,13 @@ static inline void memcpy_from_folio(char *to, struct folio *folio,
 	} while (len > 0);
 }
 
+/**
+ * memcpy_to_folio - Copy a range of bytes to a folio.
+ * @folio: The folio to write to.
+ * @offset: The first byte in the folio to store to.
+ * @from: The memory to copy from.
+ * @len: The number of bytes to copy.
+ */
 static inline void memcpy_to_folio(struct folio *folio, size_t offset,
 		const char *from, size_t len)
 {
-- 
2.43.0


