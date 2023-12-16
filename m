Return-Path: <linux-fsdevel+bounces-6282-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0A18156F8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 04:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6475C1F218B7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 03:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD743D0BF;
	Sat, 16 Dec 2023 03:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VDRuNwP7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFB739AEC
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Dec 2023 03:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702697608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qg4R+3dS8NCrkMo6yTS+9uLjKp5USb4ob2mh3UIyr+c=;
	b=VDRuNwP7fSL5HGEtkp7KCl0slzTtRFbpCgoEv2ciFP/u3eQ5wwcFI1qnHP9Lt1PIQFU/XX
	5Al64y7SlntEQhG6fcqlTfjp5IdDnkGRsTV9KIgGS7YTCaZb59Vyj388Ri3UTtb/gLolCp
	Il3aCxumd3kGVsF8X4GKlOzfBIPSJKA=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	tglx@linutronix.de,
	x86@kernel.org,
	tj@kernel.org,
	peterz@infradead.org,
	mathieu.desnoyers@efficios.com,
	paulmck@kernel.org,
	keescook@chromium.org,
	dave.hansen@linux.intel.com,
	mingo@redhat.com,
	will@kernel.org,
	longman@redhat.com,
	boqun.feng@gmail.com,
	brauner@kernel.org
Subject: [PATCH 38/50] uapi/linux/resource.h: fix include
Date: Fri, 15 Dec 2023 22:32:44 -0500
Message-ID: <20231216033300.3553457-6-kent.overstreet@linux.dev>
In-Reply-To: <20231216033300.3553457-1-kent.overstreet@linux.dev>
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
 <20231216033300.3553457-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

We should't be depending on time.h; we should only be pulling in other
uapi headers.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/uapi/linux/resource.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/resource.h b/include/uapi/linux/resource.h
index ac5d6a3031db..4fc22908bc09 100644
--- a/include/uapi/linux/resource.h
+++ b/include/uapi/linux/resource.h
@@ -2,7 +2,7 @@
 #ifndef _UAPI_LINUX_RESOURCE_H
 #define _UAPI_LINUX_RESOURCE_H
 
-#include <linux/time.h>
+#include <linux/time_types.h>
 #include <linux/types.h>
 
 /*
-- 
2.43.0


