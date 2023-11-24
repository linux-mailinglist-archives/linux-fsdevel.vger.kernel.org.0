Return-Path: <linux-fsdevel+bounces-3759-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D637F7A67
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 18:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B39941C20BFD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 17:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8928C39FEF;
	Fri, 24 Nov 2023 17:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WeLtt356"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8437A4
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 09:30:50 -0800 (PST)
Received: by mail-ej1-x649.google.com with SMTP id a640c23a62f3a-a018014e8e5so166807166b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 09:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700847049; x=1701451849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4o0npWr6QQfeGUIjBW1i5UWIlhIkHbBxxWJVk4Cg53c=;
        b=WeLtt3566O2w+oNzIy73EOLNEkcJs5AVtpXo1GYqotOV0OoeJWHyN0CgdO8UnS0nwU
         DB5X9J+AVCdlnSD0fzp6t5FgHBs8xxCcP7WMB6cXJ+DF5iozPgpdFV9fKgHEhkXJfL9p
         OhSXYh0vJ4jMFekzVTvH5mSxh0lcJR2igODKZqApedkvnxS2aXqx7Jj+0bgjkwOFWb3F
         24JLimtQrnA9fdi72yPggUkBqYyFbF54Zvmk2Bj86pBcEptLnqdiVlSFGkCDrXy48QVi
         /zx8Kd0OzUWLt2QqNQ8CG/f6//dc6IN0CXpogTxwCmqeB7dSRz3+xPbze7U9CO3UgqAu
         AXFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700847049; x=1701451849;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4o0npWr6QQfeGUIjBW1i5UWIlhIkHbBxxWJVk4Cg53c=;
        b=O+vmpS09qCne9YujMIMO9OW3Ul6VOXOKcRk+kGrZhYLaCST3yVJR0XuoejGV1V7HEX
         cCm7Oolchm/oCXMBVc8n9A0Do6ARvoVFkSMG9GlIWTXH6kBJl656C5e/BX0p00MZ8VS0
         KqqUVMLe3ePppsjLGtzrR1jcgsn9wToViHGer8brFHHI5vkS9rdTGKrV401+pUOgr9+e
         bxmS+QstvlM89k1doR5Gxx2xZ3ofPFFbeRSqmX2FzrX1LLQ833R7L6oSvJjyLLMR4PeH
         0OnhHLwGbfpvLqnxxiBDl7Ra+RCWyE4NCyghoPu7lfGst1LVi/zvafI8AhgWVPctoHJN
         0muQ==
X-Gm-Message-State: AOJu0YwlUj7rGRUSvr+qwcktbR9u0OzWt0nT6+NT0qpljAtiZMfc5I5A
	XA+gKPeDnMSHK0qTz+RlypoG95NFpkw=
X-Google-Smtp-Source: AGHT+IGaXn4S5eUG2SwbJoESQtF1eYE/p/j1rWSZx4+Zni38QT9Z3tNq/MLESaBeJcTTai4ogOYf4kSJaNc=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:9429:6eed:3418:ad8a])
 (user=gnoack job=sendgmr) by 2002:a17:906:76d7:b0:9c7:5826:b9ad with SMTP id
 q23-20020a17090676d700b009c75826b9admr35877ejn.5.1700847049214; Fri, 24 Nov
 2023 09:30:49 -0800 (PST)
Date: Fri, 24 Nov 2023 18:30:24 +0100
In-Reply-To: <20231124173026.3257122-1-gnoack@google.com>
Message-Id: <20231124173026.3257122-8-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231124173026.3257122-1-gnoack@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v6 7/9] selftests/landlock: Test ioctl(2) and ftruncate(2)
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

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
Suggested-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
---
 tools/testing/selftests/landlock/fs_test.c | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index 734647f86564..d7987b631ec4 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -3814,6 +3814,46 @@ TEST(memfd_ftruncate_and_ioctl)
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
2.43.0.rc1.413.gea7ed67945-goog


