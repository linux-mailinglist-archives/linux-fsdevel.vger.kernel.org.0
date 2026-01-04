Return-Path: <linux-fsdevel+bounces-72367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76014CF149A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 04 Jan 2026 21:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1ACD2300CBA1
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Jan 2026 20:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C656D2E2EF2;
	Sun,  4 Jan 2026 20:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aezM+pYs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF33D2AD37;
	Sun,  4 Jan 2026 20:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767559545; cv=none; b=ohndZeRrbuWtn1bBHriGQN5sT6dHQIJssBVS6mBQCzWt7dSO66hT4CW9DOug2TqeQKm16VBwXLheOe+ZDmmnoCQNujRqMkDIu/UkawUH6pLKlKsameulYHVKtDisGt4WFoiLaVbJFkmCnXoeQS6EcuetYEeHcL10uxqze03cYOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767559545; c=relaxed/simple;
	bh=0JpVwGP9E8UD74uPYp9inIyj1PG/NiRpjeVdlOWW6Z0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JB4pS7DW/Gqmk94JUjQ4b+xtDGAnTTDphQdNiO+X4fZI3/praC1LF8KEG1XdeSlZ350eyGFS/Cpj5wZwUWxi6R1sJMiynysLmyJI1uveNDQ6wjnpaTwFKenbgORcwmk0BPz0cVsWzwmNgY3rgQk5aszDtjLhFT93ub73cvbmWj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aezM+pYs; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=5EshGpZgeCWZ7O0/UaafXNwMrHNFJXbHUEojeAhkMYc=; b=aezM+pYsRFovjUVihWYx4+anlD
	OZUGcJhhNKcEfvqAgg495cWdGAzwa2R9GkwUnX7aXZnsMgQVS6nSMPFwShv331D4RkxbIoyCEE4oj
	Hw4aO7P7Mld5DeF5UwcaQ2bKQTKRF/BFO6JZc1zlIya/cfxFqKVII5VMPXK99jNFMhmtq8yEEmqPz
	dO4eS/jSmWT77ph3IPmjpGmbTLcsgebd+uE9pjqBHRx8icBdywNusbGAuHRrYxoSL9jwqEBczxsOI
	KiS1J0soiLSLC34X99txOJyXdOpb03rf/HgpOIIWyUv3VOm4LfXEDwM9GnLLegmufzGgsxtdtBPXl
	lgnOrMvA==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vcUyj-0000000ARTp-1QdE;
	Sun, 04 Jan 2026 20:45:33 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-doc@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] docs: filesystems: add fs/open.c to api-summary
Date: Sun,  4 Jan 2026 12:45:30 -0800
Message-ID: <20260104204530.518206-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Include fs/open.c in filesystems/api-summary.rst to provide its
exported APIs.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org

 Documentation/filesystems/api-summary.rst |    3 +++
 1 file changed, 3 insertions(+)

--- linux-next-20251219.orig/Documentation/filesystems/api-summary.rst
+++ linux-next-20251219/Documentation/filesystems/api-summary.rst
@@ -56,6 +56,9 @@ Other Functions
 .. kernel-doc:: fs/namei.c
    :export:
 
+.. kernel-doc:: fs/open.c
+   :export:
+
 .. kernel-doc:: block/bio.c
    :export:
 

