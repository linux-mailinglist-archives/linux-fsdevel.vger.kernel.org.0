Return-Path: <linux-fsdevel+bounces-1938-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71ECE7E05E6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 16:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B6B0281F2B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 15:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFA61C6B6;
	Fri,  3 Nov 2023 15:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tGhAnidS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1271C689
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Nov 2023 15:57:49 +0000 (UTC)
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0228FD4E
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Nov 2023 08:57:48 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id a640c23a62f3a-99bca0b9234so154840666b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Nov 2023 08:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699027066; x=1699631866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4UZ/Kc+lRwWA7nYggLhLN0g2SyGgzuCpunnNbgZX4k=;
        b=tGhAnidSl5C9XtMZB/R72TI3V1ulpsK5a2d/QHYqXPNdIWF58/iVsKa9zcHl53pL+R
         fqejD+7EIM9Hsy8ZQ+zmDgXIYIB7toXlHwS5mgykffJsrjE+w7HLmW+8BET302Qqam4p
         SVSxezOO2uUuq/A8owsFFbc+Jd2xcvm0oyUsOqB/OhNWZPzZWNO7J/ceQePFYa9DToG5
         xekQ+rcEJujLb2wDpE3+RV5SrYbWH/VHqyYX6WPvOna9Jmqs4NlDSqoL107sUZ6YAM4J
         RgH+cgtxkXIvLpv2WsrCaeH35cLTm/FYIlvlLNHOBEOjbqaeaH+74FelxLuMNjYb0Hn0
         G5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699027066; x=1699631866;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p4UZ/Kc+lRwWA7nYggLhLN0g2SyGgzuCpunnNbgZX4k=;
        b=lbToDyjpE/6Fzk9gfsVgBhQ8XmLRL+vfBlwtRnBHqik5g+lm6gKcQuPg3iX6K0tUy6
         KdvFgzeWh+7rVAN8J/EevK5JvhGF6ldnqHEncACa9zsaLE/Aj2bsli89Ii2XiSRZ6n2x
         xZ9fDPBnN2MZmsTtot8q3tkf9/7gx+6oENrrrIUNA8stUGs6PH08uQZkVIGbHDBDap+/
         bbclzE2vy28e0GOPR4HWqZGZWozUrgBInsJj6Yn7pQbgsdejDKhHJK/oD6j0uUaG8WTf
         9OQk2XCPUIIDotXxStvfWnDzwmhFqclKtuwCJp4YXCWfV08ReCvyZLRvPxplAohcgc1K
         +ZUQ==
X-Gm-Message-State: AOJu0Yyc6uva46QKR3X71LrKBKP25u+/r4sqliYq+EaDruANcD05uR8x
	KE/msRHKNq6bj8IFdFcbYSq/73HoSWo=
X-Google-Smtp-Source: AGHT+IGVzbVzowF2B2fGNgQgbqnZM9+eSt7APbm+XXebbcm7Cet2bq9r24REnItIAZa1So9zyVWNUTegqsQ=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:7ddd:bc72:7a4a:ba94])
 (user=gnoack job=sendgmr) by 2002:a17:907:3907:b0:9dd:9857:85e with SMTP id
 so7-20020a170907390700b009dd9857085emr9777ejc.13.1699027066427; Fri, 03 Nov
 2023 08:57:46 -0700 (PDT)
Date: Fri,  3 Nov 2023 16:57:15 +0100
In-Reply-To: <20231103155717.78042-1-gnoack@google.com>
Message-Id: <20231103155717.78042-6-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231103155717.78042-1-gnoack@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Subject: [PATCH v4 5/7] selftests/landlock: Test ioctl(2) and ftruncate(2)
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
index 8a244c9cd030..06c47c816c51 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -3812,6 +3812,46 @@ TEST(memfd_ftruncate_and_ioctl)
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
2.42.0.869.gea05f2083d-goog


