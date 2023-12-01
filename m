Return-Path: <linux-fsdevel+bounces-4585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E580D800D58
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 15:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F67D281B32
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 14:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4FC3E48D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 14:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jYqbmgjt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A322310FA
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 06:31:09 -0800 (PST)
Received: by mail-ed1-x54a.google.com with SMTP id 4fb4d7f45d1cf-54c64c3a702so316739a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Dec 2023 06:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701441068; x=1702045868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zc2n/IfdN6AW1c9SMxltAzJC+sd6luXorNUWF42eNJ4=;
        b=jYqbmgjtcbwUWr3AdkclsZjv/fdyGWWAlJGMwTdjaOZclKBL9IqxXhe7V8+MeDrqJv
         LEldVWSyZCQKQdkD2KT0B7a5Bvklj5SVKuXqGef3LFs6sKqG5kHynFfiRQaMySH5e/6R
         Xn42na9hA4xfE+UCNzF9D6bFIQjKamiFE0YDGwYKP825yaqtNxNUPG6GXq4si4cwhVVm
         PA82FEJBqQvhULrfCEgkOcAZFFBtTQcLceJu4lSdqKW2udiPFQrOgn7+VjB6NL8cvelg
         KtJczgLC83mKrFEx9hUp6KxQyEbIRYT8QI7gLUrK3r9Nw1NaiM266uJtnvoAB9l9bH0V
         F1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701441068; x=1702045868;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Zc2n/IfdN6AW1c9SMxltAzJC+sd6luXorNUWF42eNJ4=;
        b=opO99hiOz4NwE+mGx4WN9T7DL/MLDsffAyRktquOZT/mWauSYiC8ANT7cbT4Ypf0c+
         rFI4JISite/lG2QaqlkbDM6lFgSMUbgaTi9jX/0Dnb2xhzK59Uic2kGgIN/RUoRLGZux
         jaeFda1dmsX1dbeDaieLJh/2qMS02B0HAkGghTdzdQU6kL7lVl7dFL2pSprdkM/NkdKq
         /BlwlvXPEp1IZVNdNIwHOUbvZtSKuHmwUyAFR1av1U0BHk/Iss0EQBl0I/DYdrokEfcT
         nRgtXNpwmBoJCnFdnUjGW2qK0J7OPn0UvXsqAGVOmeBQO4Gne1jwMxbU/R72wj0BQaWl
         mv4A==
X-Gm-Message-State: AOJu0Yy5lm1Kyqi8dE3RTPtbpF0SRKgHw5JfD3lluai3hfj27U4wsFxT
	HOjfBq8m83aVowcndewDRN31t+de3nQ=
X-Google-Smtp-Source: AGHT+IFxeCHBw3CruXC3y61NsuMJhkBYw4MVKN3Q3KFVsKhCXKArCqmyJx77fkqBX4xWpH429QkvSV73/+o=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:fab0:4182:b9df:bfec])
 (user=gnoack job=sendgmr) by 2002:aa7:d7d5:0:b0:54c:557f:e6f2 with SMTP id
 e21-20020aa7d7d5000000b0054c557fe6f2mr18849eds.0.1701441068052; Fri, 01 Dec
 2023 06:31:08 -0800 (PST)
Date: Fri,  1 Dec 2023 15:30:40 +0100
In-Reply-To: <20231201143042.3276833-1-gnoack@google.com>
Message-Id: <20231201143042.3276833-8-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231201143042.3276833-1-gnoack@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v7 7/9] selftests/landlock: Test ioctl(2) and ftruncate(2)
 with open(O_PATH)
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

ioctl(2) and ftruncate(2) operations on files opened with O_PATH
should always return EBADF, independent of the
LANDLOCK_ACCESS_FS_TRUNCATE and LANDLOCK_ACCESS_FS_IOCTL access rights
in that file hierarchy.

Suggested-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 tools/testing/selftests/landlock/fs_test.c | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index dcc8ed6cc076..89d1e4af6fb2 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -3875,6 +3875,46 @@ TEST(memfd_ftruncate_and_ioctl)
 	}
 }
=20
+TEST_F_FORK(layout1, o_path_ftruncate_and_ioctl)
+{
+	const struct landlock_ruleset_attr attr =3D {
+		.handled_access_fs =3D ACCESS_ALL,
+	};
+	int ruleset_fd, fd;
+
+	/*
+	 * Checks that for files opened with O_PATH, both ioctl(2) and
+	 * ftruncate(2) yield EBADF, as it is documented in open(2) for the
+	 * O_PATH flag.
+	 */
+	fd =3D open(dir_s1d1, O_PATH | O_CLOEXEC);
+	ASSERT_LE(0, fd);
+
+	EXPECT_EQ(EBADF, test_ftruncate(fd));
+	EXPECT_EQ(EBADF, test_fs_ioc_getflags_ioctl(fd));
+
+	ASSERT_EQ(0, close(fd));
+
+	/* Enables Landlock. */
+	ruleset_fd =3D landlock_create_ruleset(&attr, sizeof(attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/*
+	 * Checks that after enabling Landlock,
+	 * - the file can still be opened with O_PATH
+	 * - both ioctl and truncate still yield EBADF (not EACCES).
+	 */
+	fd =3D open(dir_s1d1, O_PATH | O_CLOEXEC);
+	ASSERT_LE(0, fd);
+
+	EXPECT_EQ(EBADF, test_ftruncate(fd));
+	EXPECT_EQ(EBADF, test_fs_ioc_getflags_ioctl(fd));
+
+	ASSERT_EQ(0, close(fd));
+}
+
 /* clang-format off */
 FIXTURE(ioctl) {};
 /* clang-format on */
--=20
2.43.0.rc2.451.g8631bc7472-goog


