Return-Path: <linux-fsdevel+bounces-6371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5543881757B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 16:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2290283916
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 15:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA985A872;
	Mon, 18 Dec 2023 15:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="42baJCQw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2289F5A86A;
	Mon, 18 Dec 2023 15:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=36T96oIsRQC1BPzxAOWfEESJ9XwkyWKz6mizx5levB4=; b=42baJCQw3pOImDKmFbkkzEpkVQ
	5NCVTCjUI/QZvG9jAZnUK4eyKqg84LJYQzNjtFggZSHzUQbx3wv/0y5vf20tJEpkPcN4clo+C8Gah
	damfhaw5voBLIumLJ7gGslg3H01RWcXG2RyNByfC6JWSnPfezp2VXRvqa9TlemNsnsh6fx90vCdNE
	QCybiqW+qDXQzcNbVC29SchVdBVODfmFbi1d6AxVM31jdqZAPxo9rQ9vPyfHTafY12LbYBVYOTs+2
	oPjMMUHHR1Xbnti7JO9/8/ZtRt3YHFmxVv/j0Ngpl7h4Q3yavIoFQtGXYJSeX3ABChPl9NCimD7kx
	jSDTxgNw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rFFf6-00BELm-1G;
	Mon, 18 Dec 2023 15:36:09 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/17] writeback: remove a duplicate prototype for tag_pages_for_writeback
Date: Mon, 18 Dec 2023 16:35:41 +0100
Message-Id: <20231218153553.807799-6-hch@lst.de>
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

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
[hch: split from a larger patch]
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/writeback.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 083387c00f0c8b..833ec38fc3e0c9 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -364,8 +364,6 @@ bool wb_over_bg_thresh(struct bdi_writeback *wb);
 typedef int (*writepage_t)(struct folio *folio, struct writeback_control *wbc,
 				void *data);
 
-void tag_pages_for_writeback(struct address_space *mapping,
-			     pgoff_t start, pgoff_t end);
 int write_cache_pages(struct address_space *mapping,
 		      struct writeback_control *wbc, writepage_t writepage,
 		      void *data);
-- 
2.39.2


