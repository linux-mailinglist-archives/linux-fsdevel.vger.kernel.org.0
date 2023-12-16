Return-Path: <linux-fsdevel+bounces-6247-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC3D81567C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 03:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 220BDB24631
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 02:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F23AD53A;
	Sat, 16 Dec 2023 02:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uOPZ6KP7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D01263B4
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Dec 2023 02:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702694928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=adc0sNIM7gQ4trdre1K6cbqGQoob6WcBiJ3dUIPudMk=;
	b=uOPZ6KP7ychMoKw8qtR/0qfWiQ8j9jkHkMD1SK35PVi+vFoj3X/OLCoqJUaIcYeIqu41/q
	ou7avzvpSAIlOW44jhZr4JYW24u6/QLdr8koxyghwIIaZLIQknvEo1WSBT50/ruKuYe0qj
	egaJK3764sLrvSCuHsyr5L9g/D8dUOU=
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
Subject: [PATCH 03/50] x86/lib/cache-smp.c: fix missing include
Date: Fri, 15 Dec 2023 21:47:44 -0500
Message-ID: <20231216024834.3510073-4-kent.overstreet@linux.dev>
In-Reply-To: <20231216024834.3510073-1-kent.overstreet@linux.dev>
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 arch/x86/lib/cache-smp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/lib/cache-smp.c b/arch/x86/lib/cache-smp.c
index 7c48ff4ae8d1..7af743bd3b13 100644
--- a/arch/x86/lib/cache-smp.c
+++ b/arch/x86/lib/cache-smp.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <asm/paravirt.h>
 #include <linux/smp.h>
 #include <linux/export.h>
 
-- 
2.43.0


