Return-Path: <linux-fsdevel+bounces-6384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC5D8175A3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 16:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D4B2283A17
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 15:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7409B76095;
	Mon, 18 Dec 2023 15:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ta/ZLMIs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D347608C;
	Mon, 18 Dec 2023 15:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Yv9NEALRhhPVlldz2t/Fuz2oV/CBEjy/kwNcSSKy2c0=; b=Ta/ZLMIsSHqIp2kIeOMq/K8hB2
	zFZCr1dwmBjJEP7zd40V7gPNrS8Qq8UdpAP4HvpFibJa7PnELaGjiXIkJgs9LbZfhxzMLiZxR19/Z
	++ITeDX1dp9VlPnF7QA5rPA1D7yzo/KssnWGNQfL8BiIiooj5jmwq4zPBo9jPWNrxYSz0+JvXqQzt
	PcEtGKUqDiewhkGM0ONfc2onosXMtAAhLVUhezlbdzmUWnT4EE50UjXRKfAWvUhEtjA4PLGZp0qYc
	a8UXrSBukXbauIaVN5VwADLcnX3Mq8vOHhtXGAGyXTGZLBBIcMALFeurlzETNild+N+rdYR7/ZYiq
	U19LWeWQ==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rFFfh-00BEdJ-09;
	Mon, 18 Dec 2023 15:36:45 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 17/17] writeback: update the kerneldoc comment for tag_pages_for_writeback
Date: Mon, 18 Dec 2023 16:35:53 +0100
Message-Id: <20231218153553.807799-18-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231218153553.807799-1-hch@lst.de>
References: <20231218153553.807799-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Don't refer to write_cache_pages, which now is just a wrapper for the
writeback iterator.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/page-writeback.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index d3c2c78e0c67ce..bc69044fd063e8 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2325,18 +2325,18 @@ void __init page_writeback_init(void)
 }
 
 /**
- * tag_pages_for_writeback - tag pages to be written by write_cache_pages
+ * tag_pages_for_writeback - tag pages to be written by writeback
  * @mapping: address space structure to write
  * @start: starting page index
  * @end: ending page index (inclusive)
  *
  * This function scans the page range from @start to @end (inclusive) and tags
- * all pages that have DIRTY tag set with a special TOWRITE tag. The idea is
- * that write_cache_pages (or whoever calls this function) will then use
- * TOWRITE tag to identify pages eligible for writeback.  This mechanism is
- * used to avoid livelocking of writeback by a process steadily creating new
- * dirty pages in the file (thus it is important for this function to be quick
- * so that it can tag pages faster than a dirtying process can create them).
+ * all pages that have DIRTY tag set with a special TOWRITE tag.  The caller
+ * can then use the TOWRITE tag to identify pages eligible for writeback.
+ * This mechanism is used to avoid livelocking of writeback by a process
+ * steadily creating new dirty pages in the file (thus it is important for this
+ * function to be quick so that it can tag pages faster than a dirtying process
+ * can create them).
  */
 void tag_pages_for_writeback(struct address_space *mapping,
 			     pgoff_t start, pgoff_t end)
-- 
2.39.2


