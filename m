Return-Path: <linux-fsdevel+bounces-7397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5004824666
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 17:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F399287421
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 16:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB41B25553;
	Thu,  4 Jan 2024 16:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tjYUWWw7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F2A2C681;
	Thu,  4 Jan 2024 16:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=JwLl2WhYa5fG75rjmhMROOkOoxUhNUQ5T2hqMXJPpus=; b=tjYUWWw7CMHWkSfJQcOtluLMbz
	YP5JQDB2D28n1Qr1JyTpH6yfltqUSW+n3OB+jlqy2h6/u2z598LRtug7iId3oI60npzlgbwLiUspc
	tcJqAlTvUSC+9lPgtBRLRJCa8k0gwsa9WrH70O2tDDYnnjjgIFqq2YrgMj/u3RzTo+RFkx4CcKjTQ
	z4omyY8GcYoXh7AoriL2lFT3yolqFUto8/6noglBj2XRWES64m+fW4JbYhKxL4NUI5Av441NMvuSM
	7wdwYV2u6RkeIpHIGkIXyY6coIVOQQeP2DCY5+xrSQrGcm4j2jZzDmJxIrmAfPy3guO322hzfSjwd
	T19U1TLw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rLQiE-00FY2Z-TG; Thu, 04 Jan 2024 16:36:54 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] doc: Split buffer.rst out of api-summary.rst
Date: Thu,  4 Jan 2024 16:36:52 +0000
Message-Id: <20240104163652.3705753-6-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240104163652.3705753-1-willy@infradead.org>
References: <20240104163652.3705753-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Buffer heads are no longer a generic filesystem API but an optional
filesystem support library.  Make the documentation structure reflect
that, and include the fine documentation kept in buffer_head.h.
We could give a better overview of what buffer heads are all about,
but my enthusiasm for documenting it is limited.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 Documentation/filesystems/api-summary.rst | 3 ---
 Documentation/filesystems/index.rst       | 1 +
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/filesystems/api-summary.rst b/Documentation/filesystems/api-summary.rst
index 98db2ea5fa12..cc5cc7f3fbd8 100644
--- a/Documentation/filesystems/api-summary.rst
+++ b/Documentation/filesystems/api-summary.rst
@@ -56,9 +56,6 @@ Other Functions
 .. kernel-doc:: fs/namei.c
    :export:
 
-.. kernel-doc:: fs/buffer.c
-   :export:
-
 .. kernel-doc:: block/bio.c
    :export:
 
diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 09cade7eaefc..0cc2bb06de6a 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -50,6 +50,7 @@ filesystem implementations.
 .. toctree::
    :maxdepth: 2
 
+   buffer
    journalling
    fscrypt
    fsverity
-- 
2.43.0


