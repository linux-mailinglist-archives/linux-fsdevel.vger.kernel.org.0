Return-Path: <linux-fsdevel+bounces-7394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E596E824652
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 17:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99A8F1F22ECA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 16:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD8B2511A;
	Thu,  4 Jan 2024 16:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bdsQoe71"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BE7250FB;
	Thu,  4 Jan 2024 16:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=PRb/Y6BB88izDA56LXWJLD7BSeD1+ZRIJAfMp12jSH4=; b=bdsQoe71FgfOKWWZVt6VUC44f2
	C2ivpE25Jt7gwEgEQVB6/ZSDqQm0aQOFUuUwOfOIEX6wrpRUvxmEwRxrx4ebBH7icK2HPL78BH/5A
	tiLro3AmH0zesSYDr69YCKKRBr1p/bWmByNBzCx/KRLXj5nFZH+XWc2C51gb+kzdfD2qJpc3L4fbF
	Juvaa4Q9oAQ0XlfzT0FSmBNkvK/6qtGmdKx8UnYXkCu5/2/rk/wHBJTko5gatvmefcHcfXCzB9czW
	gHmsiXtqRyR6BbQUsDoiHXOyy8njpj39tpi7tBdBmEjLTQKHQELpHSaajKU91Nig/wLII24kwQuoD
	IMI+DiiQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rLQiD-00FY2P-Ux; Thu, 04 Jan 2024 16:36:54 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Improve buffer head documentation
Date: Thu,  4 Jan 2024 16:36:47 +0000
Message-Id: <20240104163652.3705753-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Having started improving the kernel-doc for __folio_mark_dirty(), I
then started noticing other improvements that could be made, and this
is as far as I got before deciding I'd made enough for now.  Tested with
make htmldocs.

Matthew Wilcox (Oracle) (5):
  doc: Improve the description of __folio_mark_dirty
  buffer: Add kernel-doc for block_dirty_folio()
  buffer: Add kernel-doc for try_to_free_buffers()
  buffer: Fix __bread() kernel-doc
  doc: Split buffer.rst out of api-summary.rst

 Documentation/filesystems/api-summary.rst |  3 -
 Documentation/filesystems/index.rst       |  1 +
 fs/buffer.c                               | 98 +++++++++++++----------
 include/linux/buffer_head.h               | 17 ++--
 mm/page-writeback.c                       | 14 ++--
 5 files changed, 74 insertions(+), 59 deletions(-)

-- 
2.43.0


