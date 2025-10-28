Return-Path: <linux-fsdevel+bounces-65889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E7DC139CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 09:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 945691AA6B5E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 08:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87162E093A;
	Tue, 28 Oct 2025 08:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0yXSNMS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8C82E0905;
	Tue, 28 Oct 2025 08:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761641202; cv=none; b=khvfrRqVsiGSCDEfd/AIN6t371trXIk3DfyUUHNyx+nm4y/h8GVqL/DMKZ8sHoM4a52mpGY1D8sUNplZGVfSGXwFGaeK98u/XMmYZ1qbwf4Mvo2asyH+UOqokKpUeYoAZ5YHVO3QV6W3oopZPn7yQYU5blHen2VmCkWlXWw8zbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761641202; c=relaxed/simple;
	bh=98RE6pSg3hj80UMXIP92HOFlizvMalrKpuNL5KlJm2s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bm/RT7VedNX94pS21NqTLEOwjfsJ9T1GvpWv3cR3jdIDwG9cVRc9ttvN/LwURQZz52WqFwTqkqYcjrZ4aAv4QENDhY5HwItbadPmGi8yyMzLRvXsvZ2AV4CSJP/iTpPdHIrzFSpmNO7ONoeWmSRcRPTnSQI/xrmIk/e8gEZpHzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r0yXSNMS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D40E1C113D0;
	Tue, 28 Oct 2025 08:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761641201;
	bh=98RE6pSg3hj80UMXIP92HOFlizvMalrKpuNL5KlJm2s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=r0yXSNMSuP55Jdxh60luUdA6SPfKho92ePJjq4Ekl0YL+n0Jcd69MnqsIHctTRF0/
	 77jPeQx861sIDAWBTYl4a21RpdECMW/UB/j9YVeWwHIG+tTvYPKWCfvnC7gRLsBouN
	 1Ecvxgn16NgijyXVsYwPi7xh0R/hFiOaoqP0amliwPclwlMt5/q/QXi4/kzp/EBTz5
	 tUouudO1wEo9qCuXCZc8W8N8mFK5eT6fVUx2MceKTSxaSjCh26P+lZM6TLPrAuNBHn
	 ziLYGEKowIzBkp9PNtagsBUpevC/16tlqbR24cODEY/owNo286pAFpwJbT2AyG+/yd
	 ms6y78qlqIEvA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 28 Oct 2025 09:45:54 +0100
Subject: [PATCH 09/22] selftests/pidfd: update pidfd header
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-work-coredump-signal-v1-9-ca449b7b7aa0@kernel.org>
References: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org>
In-Reply-To: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>, Amir Goldstein <amir73il@gmail.com>, 
 Aleksa Sarai <cyphar@cyphar.com>, 
 Yu Watanabe <watanabe.yu+github@gmail.com>, 
 Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Jann Horn <jannh@google.com>, Luca Boccassi <luca.boccassi@gmail.com>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Lennart Poettering <lennart@poettering.net>, 
 Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=1060; i=brauner@kernel.org;
 h=from:subject:message-id; bh=98RE6pSg3hj80UMXIP92HOFlizvMalrKpuNL5KlJm2s=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQyNB1sz19zTGnPv4Zn60NyxdwXxwT9vBxb3WzIP1Pg0
 X6JCRbnO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACayMpfhf9yykmVaFtlz1xsU
 6NvErXmU0TP76DKP/ONNUjFWXw5oxTD8L0/TrxOvt/zrV73oUWfDxprL86rX8Zf8eXj48olMjuN
 efAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Include the new defines and members.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/pidfd/pidfd.h | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
index f87993def738..d60f10a873bb 100644
--- a/tools/testing/selftests/pidfd/pidfd.h
+++ b/tools/testing/selftests/pidfd/pidfd.h
@@ -148,6 +148,14 @@
 #define PIDFD_INFO_COREDUMP	(1UL << 4)
 #endif
 
+#ifndef PIDFD_INFO_SUPPORTED_MASK
+#define PIDFD_INFO_SUPPORTED_MASK	(1UL << 5)
+#endif
+
+#ifndef PIDFD_INFO_COREDUMP_SIGNAL
+#define PIDFD_INFO_COREDUMP_SIGNAL	(1UL << 6)
+#endif
+
 #ifndef PIDFD_COREDUMPED
 #define PIDFD_COREDUMPED	(1U << 0) /* Did crash and... */
 #endif
@@ -183,8 +191,11 @@ struct pidfd_info {
 	__u32 fsuid;
 	__u32 fsgid;
 	__s32 exit_code;
-	__u32 coredump_mask;
-	__u32 __spare1;
+	struct {
+		__u32 coredump_mask;
+		__u32 coredump_signal;
+	};
+	__u64 supported_mask;
 };
 
 /*

-- 
2.47.3


