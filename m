Return-Path: <linux-fsdevel+bounces-74534-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CED7ED3B8C0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 21:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AB5630EDA13
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 20:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5112FC00C;
	Mon, 19 Jan 2026 20:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gOAB6xdI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6073F2F690D;
	Mon, 19 Jan 2026 20:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768855321; cv=none; b=F3DvsFIhlfz4CuUHrgf94SWTh8t8zvYpFUmKOgdXN0rssLnFlLb4wMyOlgEaGzF9bT+iwreHzwI58UOqelQvELYcjZeyODfzs5CdxF0WiPVUNl3deXgTO2oHTlrWebzkK0f/tSvbudOgbHPTA2otAhOgvV9DVeINDwhbEG0Uwj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768855321; c=relaxed/simple;
	bh=FTuuK2lbsKxW1TqNcpwiwlVgmoiY1ioRmAfUVOmsQ34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gJEcZz3rLdvdAOZ+PhaA+0h/OrO/P8gqAeHej9aT+MFwUc7NnLXDLBp3egKPcVwc1HVF2PCjzrKnlfya8Vel6Zgkp3PAiW4O5QiGQeu2MXgT9VnzoVzYAXcd19NIVO6BkID+QutBqB2XjThWZZnFLG3a0NzXg0xLHu+i2v7DqCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gOAB6xdI; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768855321; x=1800391321;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FTuuK2lbsKxW1TqNcpwiwlVgmoiY1ioRmAfUVOmsQ34=;
  b=gOAB6xdIYtVr6+4tewnylRRff2iJTS6vWAmhwLxK8bFvEki+ETJhvCFJ
   7Wlw9jQKghEeHgUSPyYqwHtKU9diuC3YYJSA8HFX6Jh/FqdA4oCcG4RYU
   MCZ2czFKH3qhzg7xjuvBLA79KcHQunnacQvhcBvsxNMGWxoYJaSbNUB2k
   5T7M8RDYYZ2wWbR4vUnekXOfV4i/ZLNaVDLrxn0kSHD5p849kMgPr7+6/
   WU/+ZYL3AQ2E7z6F3UekVcyvs/nHUMoeSDg3PBzv5abhOoz0pnzvRroOh
   B5aT2Z5gA1OZGvMGD1hTPQfab5/4Xtwo68vdm2u7yZ3fDK21tAGxysA/r
   A==;
X-CSE-ConnectionGUID: nyaeEUIOSKy5Be5t5ltPxQ==
X-CSE-MsgGUID: 0WZnAGuBS3SKR1kKboB4ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="70230329"
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; 
   d="scan'208";a="70230329"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 12:41:59 -0800
X-CSE-ConnectionGUID: n4zaTZTMQLS5I5QZZCbd1g==
X-CSE-MsgGUID: tCEdBISeQ3KKML7ycrMaZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; 
   d="scan'208";a="236620587"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa002.jf.intel.com with ESMTP; 19 Jan 2026 12:41:55 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 353BB9D; Mon, 19 Jan 2026 21:41:54 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christian Brauner <brauner@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH v1 3/4] vsprintf: Revert "add simple_strntoul"
Date: Mon, 19 Jan 2026 21:38:40 +0100
Message-ID: <20260119204151.1447503-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260119204151.1447503-1-andriy.shevchenko@linux.intel.com>
References: <20260119204151.1447503-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No users anymore and none should be in the first place.

This reverts commit fcc155008a20fa31b01569e105250490750f0687.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/kstrtox.h | 1 -
 lib/vsprintf.c          | 7 -------
 2 files changed, 8 deletions(-)

diff --git a/include/linux/kstrtox.h b/include/linux/kstrtox.h
index 6ea897222af1..7fcf29a4e0de 100644
--- a/include/linux/kstrtox.h
+++ b/include/linux/kstrtox.h
@@ -143,7 +143,6 @@ static inline int __must_check kstrtos32_from_user(const char __user *s, size_t
  */
 
 extern unsigned long simple_strtoul(const char *,char **,unsigned int);
-extern unsigned long simple_strntoul(const char *,char **,unsigned int,size_t);
 extern long simple_strtol(const char *,char **,unsigned int);
 extern unsigned long long simple_strtoull(const char *,char **,unsigned int);
 extern long long simple_strtoll(const char *,char **,unsigned int);
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 800b8ac49f53..52ea14a08d3a 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -129,13 +129,6 @@ unsigned long simple_strtoul(const char *cp, char **endp, unsigned int base)
 }
 EXPORT_SYMBOL(simple_strtoul);
 
-unsigned long simple_strntoul(const char *cp, char **endp, unsigned int base,
-			      size_t max_chars)
-{
-	return simple_strntoull(cp, endp, base, max_chars);
-}
-EXPORT_SYMBOL(simple_strntoul);
-
 /**
  * simple_strtol - convert a string to a signed long
  * @cp: The start of the string
-- 
2.50.1


