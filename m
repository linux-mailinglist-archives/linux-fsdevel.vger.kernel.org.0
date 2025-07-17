Return-Path: <linux-fsdevel+bounces-55232-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23671B088A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 10:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BBBF561DF7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 08:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6E328B7D3;
	Thu, 17 Jul 2025 08:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SAAP1r/j";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B7LBOg/O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60F528750E;
	Thu, 17 Jul 2025 08:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752742690; cv=none; b=cLzqICV2UPc7KwaIav/anIqZfHDgdC6x/4R9uhjFxf4JHYFZ/9ukfB1k+FycgQvXLQ2RcjKBfaxgYNo1UG+Y6ahY8yXpKvdMLJlP5Ws5WAhvcJkFO6rRTMapSKD0vR/nc+KRFn+dGop4kcn4Mp3CWk4+bgrukFOzrVqL6Kw/xxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752742690; c=relaxed/simple;
	bh=3M4JPjvhl+Rjt+50SdyWcI3mzzor/iTnWrktBIXqayw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O4l3XGwfK5/AMwXxz9642e0LtXnccTRut4lCyrvIK0DAodjJEVAmVTlS2jZw9pUfVCJCXt/mwRBaOPm2qMqqzxScFVtfj696yrPqm32rof/x+rH0/qdL7czl9QA+BnqWNW+nvUgsDPrT0llppaYfbgaQYnIt9nffQyJtJBdnhsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SAAP1r/j; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B7LBOg/O; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752742134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fk5e8oxV0FhssnGzrs35dTGs3v+t08Hny2Sdw8z3PgQ=;
	b=SAAP1r/jfB77yPtJufaakQ8N3HsC1SzMt/gtlfCduPj60AzpnI1NyNZf58iZ0CLn++BAcD
	hvIAI4d9vjVxxGHdeCBC6arLXLcG23xb4sk8zn2T6/CGsNuk/ruCs+5R+5/ZoxmHwVlCz8
	YmZyMzYpMJfZoR9/p0ShO2QnGgs1RfTEmaMzGLmyIRbxpERvdZB82kUc7YTzmbFCgRmv0i
	yd8RuB/EiMMS1vTBVkH3kY79R6DWwFyLmc2kyuUExYojt/C0Km/fKBNQ44tcFKSHbEOEmc
	5bSjtZokMKQTAHxlEFp4YO2YyWz3TgvjZpHkEGc5Ji3Fi83lljQTZJpQH5/7xA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752742134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fk5e8oxV0FhssnGzrs35dTGs3v+t08Hny2Sdw8z3PgQ=;
	b=B7LBOg/OtrXQjQSO/Saxz8j/GtU+uYxmTZBl7MgF93PyTUTfUjXD8s1yaeNGMV5tkt9vKJ
	4XfjJw+WKhNvYLAQ==
Date: Thu, 17 Jul 2025 10:48:06 +0200
Subject: [PATCH v5 04/15] init: re-add CONFIG_CC_CAN_LINK_STATIC
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250717-kunit-kselftests-v5-4-442b711cde2e@linutronix.de>
References: <20250717-kunit-kselftests-v5-0-442b711cde2e@linutronix.de>
In-Reply-To: <20250717-kunit-kselftests-v5-0-442b711cde2e@linutronix.de>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Nicolas Schier <nicolas.schier@linux.dev>, Kees Cook <kees@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Christoph Hellwig <hch@lst.de>, Luis Chamberlain <mcgrof@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-doc@vger.kernel.org, workflows@vger.kernel.org, linux-mm@kvack.org, 
 linux-fsdevel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Nicolas Schier <nicolas.schier@linux.dev>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752742130; l=1334;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=3M4JPjvhl+Rjt+50SdyWcI3mzzor/iTnWrktBIXqayw=;
 b=tXd+Mus/T9aD1SZ7NorbGjFvZ/DpE4NQwE3cajqT3dbbAz89RCSe1qE/DfmnGqgFt23NmD3cG
 aTsszNf+FGRCBQxKIygzvKSyOYKjLQUao1kFTFtrXexVkhIGdfJSKlU
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

For the kunit UAPI functionality this feature is needed again.

Effectively revert commit d1b99cdf22e0 ("init: remove unused
CONFIG_CC_CAN_LINK_STATIC"), which removed the option.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Nicolas Schier <n.schier@avm.de>
Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>
---
 init/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index af4c2f0854554bbcdf193852cf5c1d2c2accc64f..26cafbad4f1560fb56b4bef31ae29baf54175661 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -87,6 +87,11 @@ config CC_CAN_LINK
 	default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m64-flag)) if 64BIT
 	default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m32-flag))
 
+config CC_CAN_LINK_STATIC
+	bool
+	default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m64-flag) -static) if 64BIT
+	default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m32-flag) -static)
+
 # Fixed in GCC 14, 13.3, 12.4 and 11.5
 # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=113921
 config GCC_ASM_GOTO_OUTPUT_BROKEN

-- 
2.50.0


