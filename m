Return-Path: <linux-fsdevel+bounces-6251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63488815683
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 03:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95F7F1C23F12
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 02:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04B514AA5;
	Sat, 16 Dec 2023 02:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E5TOS+zz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033E413ACA
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Dec 2023 02:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702694936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JFJDIdtuotmIE37QAtPpvf0GFZ4wui0KRlxF/kj4A8Y=;
	b=E5TOS+zzwHxDMZr0qGILzsmsu2z5sXZ+KynrihtXY9WWFP97rdVx1Wa6+XQm9X/VJ7z5+R
	ztYZL3TcmTXvxqoFwA/JQcbXzPAGaEaXj6H0mketIq+hqbvN4x13KO+J55w7f74vvP79eu
	GNSTXpff1Z0o9Uw3fIy+k9LxiNzCnAc=
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
Subject: [PATCH 07/50] nsproxy.h: add missing include
Date: Fri, 15 Dec 2023 21:47:48 -0500
Message-ID: <20231216024834.3510073-8-kent.overstreet@linux.dev>
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
 include/linux/nsproxy.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/nsproxy.h b/include/linux/nsproxy.h
index 771cb0285872..5601d14e2886 100644
--- a/include/linux/nsproxy.h
+++ b/include/linux/nsproxy.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_NSPROXY_H
 #define _LINUX_NSPROXY_H
 
+#include <linux/refcount.h>
 #include <linux/spinlock.h>
 #include <linux/sched.h>
 
-- 
2.43.0


