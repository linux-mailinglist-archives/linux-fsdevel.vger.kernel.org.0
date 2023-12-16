Return-Path: <linux-fsdevel+bounces-6256-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 978128156BF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 04:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5438B28648C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 03:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF97101F5;
	Sat, 16 Dec 2023 03:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Kh8Zz0zS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932A26FDB
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Dec 2023 03:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702697223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QDPDnE/n3acaAH2Hi2C6UZBa9A2W+MdxbP8jgc4Vp4w=;
	b=Kh8Zz0zSVSO6t3QRCM0Q+ZaREhBd11qlcyiMp/lXjtRiQu4MVjyohcgZqxqXgj0W4CT/J3
	yNBqYQCMBQcoijIjfcKzBmgz1djKE0nU/b08jNyfpEWKZErgI1Z3evP4+7bZl10wWaWjZV
	V3xUaZN3wreslTrvrNMw/8CQ5BOB+XY=
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
	brauner@kernel.org,
	Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH 12/50] prandom: Remove unused include
Date: Fri, 15 Dec 2023 22:26:11 -0500
Message-ID: <20231216032651.3553101-2-kent.overstreet@linux.dev>
In-Reply-To: <20231216032651.3553101-1-kent.overstreet@linux.dev>
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
 <20231216032651.3553101-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

prandom.h doesn't use percpu.h - this fixes some circular header issues.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/prandom.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/prandom.h b/include/linux/prandom.h
index f2ed5b72b3d6..f7f1e5251c67 100644
--- a/include/linux/prandom.h
+++ b/include/linux/prandom.h
@@ -10,7 +10,6 @@
 
 #include <linux/types.h>
 #include <linux/once.h>
-#include <linux/percpu.h>
 #include <linux/random.h>
 
 struct rnd_state {
-- 
2.43.0


