Return-Path: <linux-fsdevel+bounces-5338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C42C80A950
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 17:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE9A81C2095A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 16:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBE038DF7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 16:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gcSmKBq/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64261738
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Dec 2023 07:51:44 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5deda822167so5658017b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Dec 2023 07:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702050704; x=1702655504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6mPdEIprGvUFZuXoRGdXLqkm72vuiPRRlFEEhLhd+1s=;
        b=gcSmKBq/1L3qk1F9Oij9hmCuJx3cmCBt7HsA3lRM8l2Ri0wgQcib8XCNvyh11ELyYy
         Vfep+VfMHO9Ak4+4VcrjSHg77Ro/on62OtDviJH3Z1073VAUkZZbwC+d65WozaohhpTz
         IST6IleOUsZOpy8zrSDB5Lk450ItjrbtWBmTYuGvOnQ1kM4trxGIkwPirhMmHawTsShl
         +wUmXFsPJHUrzCJPAvmulUfMGZIihlFwoWNeAggeFw/xZnmmfkZmQFUPrEIXPCLHUWRh
         j4AIgrc+NgRd9iUM4TmNkBJcBmmhihsKD32tqzXdQdDLAllHNIKkH4ZBuw14Eo06BMPw
         bz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702050704; x=1702655504;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6mPdEIprGvUFZuXoRGdXLqkm72vuiPRRlFEEhLhd+1s=;
        b=omMc+ykls7T4wnoSVi1CCdx6iZ093wWyWFtwQYXR2TtCA5R+xsednQctRQv8XaGRVD
         brlzZccXzf3+SwPY1HHf6Dnwal2AIC1xHQzmWvGEV5u6f2z36ecpUuwYpB+gc0XcL1Lz
         G8bet6yXAyjKQk+O7yeQM608WC/85sCgcfkXWtF61TkUBJYMNztxsidvPWmkAdEb+fyK
         AhA0OHQ1+snS5jcqZvGxVGLEwbix/d+phKgKTTvTpW0nesDIr1+1AYHMD/4KXR3r6Dw4
         7rnxWYMFkzUN2fK9lcon6QGc+LmfuNLULCwDJ4YA5RujKeG/vEQ498ieIBeq/xl2FGGH
         18rw==
X-Gm-Message-State: AOJu0YwLQ2fQRqRgx0bn65vyI8bpjSjXj+3+lcQU4FIcILPNizqaTekp
	6F0n4F9sK3UBHFJOYwBFDkd6qfcXqKc=
X-Google-Smtp-Source: AGHT+IFegrrXXNLonZvTnAfBxTcKZdv4Jx3BrR8i4TJvJucVt//Hla5nVKGApO7TDKDLC1N30gwnhl4Zhr0=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:d80e:bfc8:2891:24c1])
 (user=gnoack job=sendgmr) by 2002:a05:690c:a8c:b0:5d7:8bf2:de42 with SMTP id
 ci12-20020a05690c0a8c00b005d78bf2de42mr1866ywb.9.1702050703815; Fri, 08 Dec
 2023 07:51:43 -0800 (PST)
Date: Fri,  8 Dec 2023 16:51:18 +0100
In-Reply-To: <20231208155121.1943775-1-gnoack@google.com>
Message-Id: <20231208155121.1943775-7-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231208155121.1943775-1-gnoack@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Subject: [PATCH v8 6/9] selftests/landlock: Test IOCTL with memfds
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: linux-security-module@vger.kernel.org, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc: Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Allen Webb <allenwebb@google.com>, Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Because the LANDLOCK_ACCESS_FS_IOCTL right is associated with the
opened file during open(2), IOCTLs are supposed to work with files
which are opened by means other than open(2).

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 tools/testing/selftests/landlock/fs_test.c | 36 ++++++++++++++++------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index 054779ef4527..dcc8ed6cc076 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -3841,20 +3841,38 @@ static int test_fs_ioc_getflags_ioctl(int fd)
 	return 0;
 }
=20
-TEST(memfd_ftruncate)
+TEST(memfd_ftruncate_and_ioctl)
 {
-	int fd;
-
-	fd =3D memfd_create("name", MFD_CLOEXEC);
-	ASSERT_LE(0, fd);
+	const struct landlock_ruleset_attr attr =3D {
+		.handled_access_fs =3D ACCESS_ALL,
+	};
+	int ruleset_fd, fd, i;
=20
 	/*
-	 * Checks that ftruncate is permitted on file descriptors that are
-	 * created in ways other than open(2).
+	 * We exercise the same test both with and without Landlock enabled, to
+	 * ensure that it behaves the same in both cases.
 	 */
-	EXPECT_EQ(0, test_ftruncate(fd));
+	for (i =3D 0; i < 2; i++) {
+		/* Creates a new memfd. */
+		fd =3D memfd_create("name", MFD_CLOEXEC);
+		ASSERT_LE(0, fd);
=20
-	ASSERT_EQ(0, close(fd));
+		/*
+		 * Checks that operations associated with the opened file
+		 * (ftruncate, ioctl) are permitted on file descriptors that are
+		 * created in ways other than open(2).
+		 */
+		EXPECT_EQ(0, test_ftruncate(fd));
+		EXPECT_EQ(0, test_fs_ioc_getflags_ioctl(fd));
+
+		ASSERT_EQ(0, close(fd));
+
+		/* Enables Landlock. */
+		ruleset_fd =3D landlock_create_ruleset(&attr, sizeof(attr), 0);
+		ASSERT_LE(0, ruleset_fd);
+		enforce_ruleset(_metadata, ruleset_fd);
+		ASSERT_EQ(0, close(ruleset_fd));
+	}
 }
=20
 /* clang-format off */
--=20
2.43.0.472.g3155946c3a-goog


