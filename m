Return-Path: <linux-fsdevel+bounces-55403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 640E9B09CFA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 09:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A7715A2056
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 07:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE5B292B53;
	Fri, 18 Jul 2025 07:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ErVUEaeG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e7rjsFFP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AEF28C866;
	Fri, 18 Jul 2025 07:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752825164; cv=none; b=dahnbw92Yj3ButKF0rPoPIhc+Fablp75kgdEP1gOiOAkBhfmJfiqiuzNzxLgLA6LJc+Fl+rVrp5g77p9roYoy4QgsNHH4CQZLzxp199AJQDyN1Fi/zyjfapCvB8jge2asMlE+nst/gjYsksE0Z2DmcaYbUf5P3ypmSIN0hOv6Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752825164; c=relaxed/simple;
	bh=FGQlBoPm1PKEd0IQK+rgrMUjaCmUcAXlg83cGI/1wSU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H5CxW5XH2zsSo/tRsfMKZYOSonMZxvRzBm62waEVWKAcn9ub8OxJYuNenUU08/HvlxmYVKi3Rb8MLvOnF2bYyCTBc9//gxBXw9UUgtRzaYSWKyylqVPWVIXtvMGxy6lYATc91g9Q0AlKp0wbO5+wSch/SeJCd2gx1pB5wNL+Yz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ErVUEaeG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e7rjsFFP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752825161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mNKPptFsyfmWbCY4i1DfRN3MXotJF8V+8zEiwOtGLF4=;
	b=ErVUEaeGmwb6pHg+kFCage9yNzc5Cg+ShmQgZVhfv37SdWU1Ci6yc0nvEgvHA0ybgwdvrf
	lAThY4UYhVJaHgiTwLEinS6nyLRfMlOHrmUqUx+PXz5qKzfiGZVpRSnMUqnhoZMm9A0WEr
	jV9NA/cb3iZd4f3DLwkU43ppJX8iOC8aIp6A/MvivKwL1SdJnJQEsD3qSsUaFh4bFGGg6D
	o6PTzaVpcSTAgC2N9+/sP+iLSsgHvp6wjrW9YTlWFXYikBiX0Qf+AHacA1+S1AxCrQ/8rV
	wXNgwEqN+b43ZqJSIbpxOu0GBpQjHzQtDXhatKzQRpfnWV2VkRaP8idJMAm0Rw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752825161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mNKPptFsyfmWbCY4i1DfRN3MXotJF8V+8zEiwOtGLF4=;
	b=e7rjsFFPCRhgpPSfoT89GcilN72Cyram+MT98zrxzjkv6LnXlwYNi47B18QOjI1cCfYfQY
	ttQnoXsOWu6QYwDQ==
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Shuah Khan <shuah@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Soheil Hassas Yeganeh <soheil@google.com>,
	Khazhismel Kumykov <khazhy@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Jens Axboe <axboe@kernel.dk>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 1/2] selftests/eventpoll: Add test for multiple waiters
Date: Fri, 18 Jul 2025 09:52:28 +0200
Message-Id: <92a02f24fe05c1a284bd643e830b182e0a2571b2.1752824628.git.namcao@linutronix.de>
In-Reply-To: <cover.1752824628.git.namcao@linutronix.de>
References: <cover.1752824628.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a test whichs creates 64 threads who all epoll_wait() on the same
eventpoll. The source eventfd is written but never read, therefore all the
threads should always see an EPOLLIN event.

This test fails because of a kernel bug, which will be fixed by a follow-up
commit.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 .../filesystems/epoll/epoll_wakeup_test.c     | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c =
b/tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c
index 65ede506305c..0852c68d0461 100644
--- a/tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c
+++ b/tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c
@@ -3493,4 +3493,49 @@ TEST(epoll64)
 	close(ctx.sfd[1]);
 }
=20
+static void *epoll65_wait(void *ctx_)
+{
+	struct epoll_mtcontext *ctx =3D ctx_;
+	struct epoll_event event;
+
+	for (int i =3D 0; i < 100000; ++i) {
+		if (!epoll_wait(ctx->efd[0], &event, 1, 0))
+			return (void *)ENODATA;
+	}
+
+	return (void *)0;
+}
+
+TEST(epoll65)
+{
+	struct epoll_mtcontext ctx;
+	struct epoll_event event;
+	int64_t dummy_data =3D 99;
+	pthread_t threads[64];
+	uintptr_t ret;
+	int i, err;
+
+	ctx.efd[0] =3D epoll_create(1);
+	ASSERT_GE(ctx.efd[0], 0);
+	ctx.efd[1] =3D eventfd(0, 0);
+	ASSERT_GE(ctx.efd[1], 0);
+
+	event.events =3D EPOLLIN;
+	err =3D epoll_ctl(ctx.efd[0], EPOLL_CTL_ADD, ctx.efd[1], &event);
+	ASSERT_EQ(err, 0);
+
+	write(ctx.efd[1], &dummy_data, sizeof(dummy_data));
+
+	for (i =3D 0; i < ARRAY_SIZE(threads); ++i)
+		ASSERT_EQ(pthread_create(&threads[i], NULL, epoll65_wait, &ctx), 0);
+
+	for (i =3D 0; i < ARRAY_SIZE(threads); ++i) {
+		ASSERT_EQ(pthread_join(threads[i], (void **)&ret), 0);
+		ASSERT_EQ(ret, 0);
+	}
+
+	close(ctx.efd[0]);
+	close(ctx.efd[1]);
+}
+
 TEST_HARNESS_MAIN
--=20
2.39.5


