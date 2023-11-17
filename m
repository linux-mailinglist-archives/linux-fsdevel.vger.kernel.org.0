Return-Path: <linux-fsdevel+bounces-3027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 223437EF5A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 16:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 526751C208FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 15:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73003DBB3;
	Fri, 17 Nov 2023 15:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JfxSqnEs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB5BAA
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 07:49:42 -0800 (PST)
Received: by mail-ed1-x549.google.com with SMTP id 4fb4d7f45d1cf-5411a36a37fso2716792a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 07:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700236181; x=1700840981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6FpLrL6T5sRQ7ploFHr8tXpmBKeFm0JWqOkKrwN4Ms=;
        b=JfxSqnEsZGgCghLTgYFBJvjPQC5e3IMJl/l811SUmgkug3XiQ2yKWKVSuUBP3+ynpO
         t3stzFyvb+qOJHTccBRhiXxv7wyrywvV+mjtzsa2j31NnWTSZz6jbcbczXA7nniM/Pnw
         0gJvMrW3SKrissKXVUAwrNZaNRR/AmQNxJtDh0hmB4LLFcmSkp/qEw6dHN8QpDa1LY7R
         L5pCdtynJi2Nz36paktZ5+Iry58tA3gTZ0APFeXeKM6zb4NfNPuN6qPTeZcnw9Pono8w
         tMb5x5yQ8pEYJAtQVZA+B8FA5UX0icD6isqmdom/semMEfz54OYWhSqdRhkLjUzvINTJ
         eOWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700236181; x=1700840981;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y6FpLrL6T5sRQ7ploFHr8tXpmBKeFm0JWqOkKrwN4Ms=;
        b=Mhk9RE5pyMJho5o3s9vCvCYNN8aN6rwgG4nUDlEXjvtK/GD+b0qNWfXaTno6Cr2aGP
         zKjf3R4b9kaJUKlPg/ht1PJRWz/4Dzx42eCokOCUFaV+B2jcDMHx1bs3oM9GMtPaIgRh
         cNjGTREOiQwKfci6Tw7qJj5gAbCXY07SDFIhQfAB54bxXosvHynd+0U55iBEpPJ+KDq+
         T50nadFSMOAtl22DrAUTo53b66DQimOvWdcLedUeHGAZr6mUao58suqTuVZ0s1saMxQb
         fDrZO5uMkBx3KXVVZJ1oub7jEmT7wCrnWPFB+1yfNKo1xuiCLvoG2izRpr5qKxMnnb8A
         3ZTw==
X-Gm-Message-State: AOJu0YwlCjHpLvxt33CKtZwOZkFvtMIBNVgLt0g3Ltixx3fFENgCY5+Q
	WUsSGyP3Bdt9wn3etNAP0yX+sQwA6Oc=
X-Google-Smtp-Source: AGHT+IEbEUjzfqSnZbAg03Yz0uZfLr/h52QSsON79DRqm6yi857P5FdhGyVrzYtr1m6Hyro0gTS5Z8uRbAI=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:2ae5:2882:889e:d0cf])
 (user=gnoack job=sendgmr) by 2002:a05:6402:5004:b0:53f:a289:4542 with SMTP id
 p4-20020a056402500400b0053fa2894542mr88139eda.3.1700236181316; Fri, 17 Nov
 2023 07:49:41 -0800 (PST)
Date: Fri, 17 Nov 2023 16:49:17 +0100
In-Reply-To: <20231117154920.1706371-1-gnoack@google.com>
Message-Id: <20231117154920.1706371-5-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231117154920.1706371-1-gnoack@google.com>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Subject: [PATCH v5 4/7] selftests/landlock: Test IOCTL with memfds
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
index 564e73087e08..8a244c9cd030 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -3778,20 +3778,38 @@ static int test_fs_ioc_getflags_ioctl(int fd)
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
2.43.0.rc1.413.gea7ed67945-goog


