Return-Path: <linux-fsdevel+bounces-55221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C45BB08848
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 10:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D00784A5313
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 08:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E07028A1DB;
	Thu, 17 Jul 2025 08:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F1UQYxFL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ejZx2Edt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81C7283C82;
	Thu, 17 Jul 2025 08:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752742145; cv=none; b=J8XDNtCjP/a4TljMxI8lhXKn4fD5VHn2lhEoSfrWKKVFHTUWJFgkqd0/18Kw0UBzLHlcTRGL+QVT7pRIi5qw0Ra5QEBDPVl12v7JDIb2LQ32jOjThknvyQbJaCCz4v9LNhy2hkpHLojJwuPJ5Kd9psrs+dn/uv0WSxFU14vmfRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752742145; c=relaxed/simple;
	bh=uYbDX0tuhfBybp4zBtjmC97SEQNiCLwjFQ5JZf0se98=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lI1fUbitiSxgFwxubeaY3GFVtZxLA2cLLUkxpBb1Jdy2HakwnkRLqxKeFOa2yGcB7aWwQvi54Cx3lR6QWI05e0D+uI9QJUH9T12/jD+0ZJT9ZAgP9UWW/TrsxERzmA9gHWqLSfRmVJOpYsEFJC18Qr09YdlPJ4iJ3UiAEEv0rcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F1UQYxFL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ejZx2Edt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752742138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3coL6itBSAQiKwOZXEjAxfGw4ky2lWtS9inL/ixAlLY=;
	b=F1UQYxFLM4xqtBPz2jcxDiS0tjJxXXbaK5ry92KcFGkZrYMhcDwnMzbLGiSaKQJlc0JVR5
	WOtGizERh75cEMjXTSZxju/Jh397Fejsgz28E9X+P1OAajMabZF5vh+yvxQmB0OhPgMkzt
	dlpvHkd06JjvU/Bt3KZOjTW6zYVdoQYmbuhV7gKp/8a+iE7RIyHJap/BHDJnw7fcJ1qgGk
	OtCE9nXGlyzXLTL72A/zd0t9hEJCrKqLODy7otvj09z66zgEjotryz35Y1SfE+niQ04ndO
	pYBGtAYHUtRBfLyDPnmo209OnCoJG1GFA4jLmkfl4O7+yxbrQENHqDMu1g3FZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752742138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3coL6itBSAQiKwOZXEjAxfGw4ky2lWtS9inL/ixAlLY=;
	b=ejZx2EdtueEVmba6KbH+m9aPZYYWPrL0kWz1728k/DLtzcvoMwUSPs/Xo9GRvHhVkXg2ar
	kRhnIJhFdtOqRJAA==
Date: Thu, 17 Jul 2025 10:48:12 +0200
Subject: [PATCH v5 10/15] kunit: Always descend into kunit directory during
 build
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250717-kunit-kselftests-v5-10-442b711cde2e@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752742130; l=1601;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=uYbDX0tuhfBybp4zBtjmC97SEQNiCLwjFQ5JZf0se98=;
 b=bHyewFwHKAKDKekhXmQwKbW62825yb2xHBgjfNAFCj4wxJ+UUeg7RzKadxfAdhpJsrB5VH68V
 5z5qvKPS2cFCc3k0zres0QX9nsS4ZPOjCOOrfIvUwLl+EKtCklHOsQh
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

An upcoming change will add 'userprogs' to the kunit subdirectory.
For kbuild to properly clean up these build artifacts the subdirectory
needs to be always processed.

Pushing the special logic for hook.o into the kunit Makefile also makes the
logic easier to understand.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: David Gow <davidgow@google.com>
---
 lib/Makefile       | 4 ----
 lib/kunit/Makefile | 2 +-
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/lib/Makefile b/lib/Makefile
index c38582f187dd81916113319072e5cfef26f26c84..698566135091cc3bf0054f1954b434dc3325364a 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -108,11 +108,7 @@ test_fpu-y := test_fpu_glue.o test_fpu_impl.o
 CFLAGS_test_fpu_impl.o += $(CC_FLAGS_FPU)
 CFLAGS_REMOVE_test_fpu_impl.o += $(CC_FLAGS_NO_FPU)
 
-# Some KUnit files (hooks.o) need to be built-in even when KUnit is a module,
-# so we can't just use obj-$(CONFIG_KUNIT).
-ifdef CONFIG_KUNIT
 obj-y += kunit/
-endif
 
 ifeq ($(CONFIG_DEBUG_KOBJECT),y)
 CFLAGS_kobject.o += -DDEBUG
diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index 5aa51978e456ab3bb60c12071a26cf2bdcb1b508..656f1fa35abcc635e67d5b4cb1bc586b48415ac5 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -17,7 +17,7 @@ kunit-objs +=				debugfs.o
 endif
 
 # KUnit 'hooks' are built-in even when KUnit is built as a module.
-obj-y +=				hooks.o
+obj-$(if $(CONFIG_KUNIT),y) +=		hooks.o
 
 obj-$(CONFIG_KUNIT_TEST) +=		kunit-test.o
 obj-$(CONFIG_KUNIT_TEST) +=		platform-test.o

-- 
2.50.0


