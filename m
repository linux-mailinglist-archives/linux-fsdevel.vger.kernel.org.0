Return-Path: <linux-fsdevel+bounces-70557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BC1C9F34C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 14:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAC633A28B3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 13:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9632FB97F;
	Wed,  3 Dec 2025 13:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fVNmH9lP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gz5PabyW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3D5DF6C;
	Wed,  3 Dec 2025 13:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764770312; cv=none; b=EWg65PrN6Yi+JroWrT5Xj/XersNe/mT8+ukxKvD+010w5ggRrd5TCmvZQvug2kUVyEx6gN/voxDxN3AQ3RtNaPUzWbalXvr4PsYz1Gh2faJRsXUgOar3yy2Pgwha7f/+aJ7izqXYBEPdVfR+j+Ck4PAFY2+gjN2Gkfz3jyFBAd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764770312; c=relaxed/simple;
	bh=A1D45P1c0pI10i6/SQoS1HK5wNLB0cf4IJN5T1WTtU4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BHcn0c6d56kqobIFb+/Nfwgn4gXyYgO/E7brJe9uWp2E7kZnNWJjW4UF0vUFrBn+Q8BobRSZrn8l3XERwAT5ElEoVRkpHR+FtzpZxTJ6kQveoQ6MuT6gYuX2t7HtZXm/zWLQ8VrnzLZkErwahRxMAaWbgOHyVm4+YzXAz+v9xqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fVNmH9lP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Gz5PabyW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764770309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kg6VLLyQAiKqydyvo9Wq+p0LHnyvVxrhZ5f7AmcwwYE=;
	b=fVNmH9lPgGh/i+oA56fFGh2u52OPjNjp7tVGsOUbihwACe1mNdLexHPXSrg1KArlZu3H9j
	lQ44woTBLFAVTn982NNGdp/PR2Jg06FF/n2Xr04V3D3BPtRjlvaoeK4AdiA4mvCP78gb3n
	GbJ6Rg10iPkzYNbFlAd+vctfRQOPViVohfAiOU1b2ikqt3URV3PKa2+Gkf0ijq38pd0rTf
	yBHdsRwmqvY5T4sHvGvjSbUnAkGK5dA9l+fIKFSYytZ5rimjD80WKg04GqJ8BRBKi8Hq9I
	sZxiLFtzmmYEBIFM8xFa+O8Na6mQ3RxceVkvE3Zt1wA8eSpCh9cHrGUPxFDuCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764770309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kg6VLLyQAiKqydyvo9Wq+p0LHnyvVxrhZ5f7AmcwwYE=;
	b=Gz5PabyWwo2BtuyfySH7xocOI6RxZ/8Z3LPqfYK8hTySE/wsx9QMxHeU6viOngA5pJq3wX
	5C617MPvV0GFC9Cg==
Date: Wed, 03 Dec 2025 14:57:57 +0100
Subject: [PATCH] vfs: use UAPI types for new struct delegation definition
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251203-uapi-fcntl-v1-1-490c67bf3425@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAORBMGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDIwNj3dLEgkzdtOS8khzdNBPLFNMkY4M0i+QUJaCGgqLUtMwKsGHRsbW
 1AOPCvoVcAAAA
X-Change-ID: 20251203-uapi-fcntl-f49d5b30f8cd
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, Jan Kara <jack@suse.cz>, 
 Christian Brauner <brauner@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764770293; l=1502;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=A1D45P1c0pI10i6/SQoS1HK5wNLB0cf4IJN5T1WTtU4=;
 b=JMElsfbQF9Y/mWnTZBaRqgmo5JTcWSZK3Kt4syIwI+GO+HCSmeHdtt4Ijc9qCF1aWZMF8AEvy
 Xiz0gMj80JDBHmarKdJ/Rv1I4O50I/T3uN8LnMYQAAjVCgmxViGsr5C
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Using libc types and headers from the UAPI headers is problematic as it
introduces a dependency on a full C toolchain.

Use the fixed-width integer types provided by the UAPI headers instead.

Fixes: 1602bad16d7d ("vfs: expose delegation support to userland")
Fixes: 4be9e04ebf75 ("vfs: add needed headers for new struct delegation definition")
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/uapi/linux/fcntl.h | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 5e277fd955aa..aadfbf6e0cb3 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -4,11 +4,7 @@
 
 #include <asm/fcntl.h>
 #include <linux/openat2.h>
-#ifdef __KERNEL__
 #include <linux/types.h>
-#else
-#include <stdint.h>
-#endif
 
 #define F_SETLEASE	(F_LINUX_SPECIFIC_BASE + 0)
 #define F_GETLEASE	(F_LINUX_SPECIFIC_BASE + 1)
@@ -90,9 +86,9 @@
 
 /* Argument structure for F_GETDELEG and F_SETDELEG */
 struct delegation {
-	uint32_t	d_flags;	/* Must be 0 */
-	uint16_t	d_type;		/* F_RDLCK, F_WRLCK, F_UNLCK */
-	uint16_t	__pad;		/* Must be 0 */
+	__u32	d_flags;	/* Must be 0 */
+	__u16	d_type;		/* F_RDLCK, F_WRLCK, F_UNLCK */
+	__u16	__pad;		/* Must be 0 */
 };
 
 /*

---
base-commit: 3f9f0252130e7dd60d41be0802bf58f6471c691d
change-id: 20251203-uapi-fcntl-f49d5b30f8cd

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


