Return-Path: <linux-fsdevel+bounces-7622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A74F8828844
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 15:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E809B23BB7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 14:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FEC3BB46;
	Tue,  9 Jan 2024 14:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ziv+kSTd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EFC3BB26;
	Tue,  9 Jan 2024 14:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=BXc+4WKC8+eb9zNRohZjAGSMHA28vjIGn5u2I+5gdTw=; b=Ziv+kSTd8e4knFsf+cZ4FhSgIg
	U9pzgaaTvSfxy9LbNi4iN9eaV7kk0SCSH4a9+ukAso1FUS4dPAzlMCz1Lx50nWwL0EKgv1T8LuyV+
	4AWy423Jd3yuguBwNDUUp5ffII1/mH8tkvvc4IMeS3MLW3ptkF2mGEnUEAB0UtuZqgu6A8TNYuhoW
	SBu5o8PccwH8QsxCW7CySkGVly2rIndLhiauUKbVVpiMvcvXzORh0hq+bTn6cuXlZLiYH/dYoMOsa
	vcqVdltFfkgRr9BSJzsTF9KdZjSuxnMbB08s2cQCQwDb7ovAQjvYdJeblntnp2O/VKD3Hu1laZ9hy
	8q02evYg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rNDB0-009xrO-Nf; Tue, 09 Jan 2024 14:33:58 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/8] Improve buffer head documentation
Date: Tue,  9 Jan 2024 14:33:49 +0000
Message-Id: <20240109143357.2375046-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Turn buffer head documentation into its own document, and make many
general improvements to the docs.  Obviously there is much more that
could be done.  Tested with make htmldocs.

v2:
 - Incorporate feedback from Randy & Pankaj
 - Add docs for brelse() and bforget()
 - Improve bdev_getblk() docs

Matthew Wilcox (Oracle) (8):
  doc: Improve the description of __folio_mark_dirty
  buffer: Add kernel-doc for block_dirty_folio()
  buffer: Add kernel-doc for try_to_free_buffers()
  buffer: Fix __bread and __bread_gfp kernel-doc
  buffer: Add kernel-doc for brelse() and __brelse()
  buffer: Add kernel-doc for bforget() and __bforget()
  buffer: Improve bdev_getblk documentation
  doc: Split buffer.rst out of api-summary.rst

 Documentation/filesystems/api-summary.rst |   3 -
 Documentation/filesystems/index.rst       |   1 +
 fs/buffer.c                               | 165 +++++++++++++---------
 include/linux/buffer_head.h               |  48 +++++--
 mm/page-writeback.c                       |  14 +-
 5 files changed, 145 insertions(+), 86 deletions(-)

-- 
2.43.0


