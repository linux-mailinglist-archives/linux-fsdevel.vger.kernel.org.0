Return-Path: <linux-fsdevel+bounces-5339-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BC780A951
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 17:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EC371C20959
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 16:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD89636B05
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 16:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u4PO6hut"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEBC172A
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Dec 2023 07:51:48 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id ffacd0b85a97d-33349915d3cso1614343f8f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Dec 2023 07:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702050706; x=1702655506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avVducTTrz8Unk6ncqcB5xXi1wrDHpE3wxNIhRc8Oys=;
        b=u4PO6hutotp9fr13kxgArPUoEuROiB+bwTra/xbdz0LHHPhiN7I05yqtogUvcBBw/Z
         fxC8wp7XDK3D0MgiiobAEVtjxo/Rj8BmLuMCHCHkyjxrRA4dLCZbJJfYRFq0xuURqJ7d
         0IuvqwwiDb+z+IXTnh1rpvnNcWHyl9SDTB2oe2rsTKUQ42F69uiNH6+3wFgC5INP4ruz
         YsmMuvwwu4uOaEcWtCkVoHVmHVZGkOMHzKS5XLjzGJTLpOP0zi7qnH1W950Nf0kc2Fo9
         /WjZUCFsXBws6bxHVGmeyIY06a0eJptEqCKrZ5FTI3An1QP1QQTMK7zEdm0LNec2PmpM
         2avQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702050706; x=1702655506;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=avVducTTrz8Unk6ncqcB5xXi1wrDHpE3wxNIhRc8Oys=;
        b=Ewwj/yo0J9sL2Qrev7okEZ/xTD49+wEOYYxfes/c68P6lPhK9m9lM8shcaQENL/5J2
         14qObXHPtTqQYMSyx6cPX6JqY6AvTET7einsC1S+CdaNJOs4+4iePVzsSoPfnG2zVSSz
         7QX3s+ofpp1bPFsQo79am7UwT/jF6yCHmJDxkgPJtLoqWQiGQ/AI93MSzI2XxsM03sa4
         kNYASorRgi2rSGG0J6CVi64ZdsPENIitRq4ev6tj2tEpcNPVegX2npvQ2pv2lnd7OTg8
         74efFKCXo+9R37RkmyUGLRF6Yris6p9xrudVFMjBuXOcFq+N+92wavHE/7AbxAe5lSId
         Frww==
X-Gm-Message-State: AOJu0YxJn2mjO31RQs0MeGKD5yn+banEqhgFAFvSoijdKBWba21mBNTH
	FpK+XsQAkTyflDr3rSOJ8PyzgoFI3FM=
X-Google-Smtp-Source: AGHT+IGhon+9+mocZYXG/AkXZxfC8IiQVxvHXSA6wYkfaJglO6e4cFbNuHxeQEqiqKsISXIhQUWVcqKng7U=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:d80e:bfc8:2891:24c1])
 (user=gnoack job=sendgmr) by 2002:adf:d1cf:0:b0:333:5232:d7f5 with SMTP id
 b15-20020adfd1cf000000b003335232d7f5mr1303wrd.8.1702050706550; Fri, 08 Dec
 2023 07:51:46 -0800 (PST)
Date: Fri,  8 Dec 2023 16:51:19 +0100
In-Reply-To: <20231208155121.1943775-1-gnoack@google.com>
Message-Id: <20231208155121.1943775-8-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231208155121.1943775-1-gnoack@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Subject: [PATCH v8 7/9] selftests/landlock: Test ioctl(2) and ftruncate(2)
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
2.43.0.472.g3155946c3a-goog


