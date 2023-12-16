Return-Path: <linux-fsdevel+bounces-6246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EAC815679
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 03:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EE41283ABC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 02:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BAE26AA5;
	Sat, 16 Dec 2023 02:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kjH1mX2r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F1D46BD
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Dec 2023 02:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702694926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N4QTR2/N8809UNpiUk1nEmTQb/VXiPK1VfzHpWfE4AE=;
	b=kjH1mX2r1sSnQGMez9MPglMnwKgNBiVdKnHgbMusC0unwxLJ98cnwh2/RvFv5rU4t9RGjp
	zZIYYU7XV6YACVErvZP3Pd4wVOaZpQbkO138BuemBgLJZfYNrjyJk7HQm1N0hr1a9NXe8n
	aBTw5c+L9g7thNIddUk1niUgyphXAOQ=
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
Subject: [PATCH 02/50] x86/kernel/fpu/bugs.c: fix missing include
Date: Fri, 15 Dec 2023 21:47:43 -0500
Message-ID: <20231216024834.3510073-3-kent.overstreet@linux.dev>
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
 arch/x86/kernel/fpu/bugs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/fpu/bugs.c b/arch/x86/kernel/fpu/bugs.c
index 794e70151203..a06b876bbf2d 100644
--- a/arch/x86/kernel/fpu/bugs.c
+++ b/arch/x86/kernel/fpu/bugs.c
@@ -2,6 +2,7 @@
 /*
  * x86 FPU bug checks:
  */
+#include <asm/cpufeature.h>
 #include <asm/fpu/api.h>
 
 /*
-- 
2.43.0


