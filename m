Return-Path: <linux-fsdevel+bounces-3757-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DAC7F7A65
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 18:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2F7CB21476
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 17:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CBA39FC2;
	Fri, 24 Nov 2023 17:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1Jeej/Fn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F5710E7
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 09:30:45 -0800 (PST)
Received: by mail-ej1-x64a.google.com with SMTP id a640c23a62f3a-a049e6d78f9so158215566b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 09:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700847044; x=1701451844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aNvTGIRzTNBeOqkZTUDyXNQ6ht1ZIsjnKjJpiEic1xU=;
        b=1Jeej/FnzE3D/4NM/fQU8WYazRazYgTa29O7tvi2y2NFp41vpNOzKk6RhQ0NESp9U7
         7n0zGHmT0BTWoM9UoEAbdjbqxSc9Ew1Ftem63i3wPyNVZVRZtjnwgcDGrIJIB+RBAjhH
         oFofSW6TfJSbXIzxD8+nTTm/8YbtU7HJv9mDxLsf0ncNl0r4+JF3BqtlIaYRvzO3OCR0
         pM8Wf/0XuX3HRMUgAS6QN7SYZRUCIj5p73O9Kg8MKo/NxDQz+OY6BW2m+KhfODHCeKHN
         BicqOhUd5u6RPDLh3yE1fdZ6WO7xXkGjv711kOIvirmwsJnN8ycdL5tvVPJ81Ers+n6Q
         wGeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700847044; x=1701451844;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aNvTGIRzTNBeOqkZTUDyXNQ6ht1ZIsjnKjJpiEic1xU=;
        b=O8g8SjH2meaz/KYAEHLpNC3IeT5kuBlBw5emnh/VerArRQF+T/SJWq/1jRe+cEajM+
         smOTxJgK+GlQdhTPwC+hzZJoSizTgdI/5QrmyCM4bKNzcJg2Tg4/463tCiUMf60nNjx6
         PLLauHX03QlFQh5FJNG0rzKOTlen10ZybnIzqsaJCTz97Jo5L+CDati7Aay/GH7Tvz1+
         RjsVFScErjnakcgsrNk7RgqVUdDt1QvUUXcoGhQkfEsqU0Tr0boGWo0wONdP5ClV60Gd
         TF9CoGL7QYF+rj+Cb+Lxg3BeOPNlHnO4VcVOBEHtTztnYo0/iAtV3MMinQ2EH/WfAxvs
         ltOg==
X-Gm-Message-State: AOJu0YwMw2UwZjlUJ7yicqoazwVAhBXwx5dX0zJN40poMATiISAgkZEn
	keSuUVUsBsR820hNNgHxoxL8/JmJqjA=
X-Google-Smtp-Source: AGHT+IGNUM46R5k2pk+gpz+HTJkpDk3qzj2anTfxrhAxwu0WPR+Z4ARdK60TvfRk2KQhGnP+eQAtvf77KJ4=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:9429:6eed:3418:ad8a])
 (user=gnoack job=sendgmr) by 2002:a17:906:53cd:b0:9be:9c66:4507 with SMTP id
 p13-20020a17090653cd00b009be9c664507mr35927ejo.4.1700847044145; Fri, 24 Nov
 2023 09:30:44 -0800 (PST)
Date: Fri, 24 Nov 2023 18:30:22 +0100
In-Reply-To: <20231124173026.3257122-1-gnoack@google.com>
Message-Id: <20231124173026.3257122-6-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231124173026.3257122-1-gnoack@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v6 5/9] selftests/landlock: Test IOCTL support
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

Exercises Landlock's IOCTL feature in different combinations of
handling and permitting the rights LANDLOCK_ACCESS_FS_IOCTL,
LANDLOCK_ACCESS_FS_READ_FILE, LANDLOCK_ACCESS_FS_WRITE_FILE and
LANDLOCK_ACCESS_FS_READ_DIR, and in different combinations of using
files and directories.

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 tools/testing/selftests/landlock/fs_test.c | 431 ++++++++++++++++++++-
 1 file changed, 428 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index 0e86c14e7bb6..94f54a61e508 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -9,6 +9,7 @@
=20
 #define _GNU_SOURCE
 #include <fcntl.h>
+#include <linux/fs.h>
 #include <linux/landlock.h>
 #include <linux/magic.h>
 #include <sched.h>
@@ -672,6 +673,9 @@ static int create_ruleset(struct __test_metadata *const=
 _metadata,
 	}
=20
 	for (i =3D 0; rules[i].path; i++) {
+		if (!rules[i].access)
+			continue;
+
 		add_path_beneath(_metadata, ruleset_fd, rules[i].access,
 				 rules[i].path);
 	}
@@ -3380,7 +3384,7 @@ TEST_F_FORK(layout1, truncate_unhandled)
 			      LANDLOCK_ACCESS_FS_WRITE_FILE;
 	int ruleset_fd;
=20
-	/* Enable Landlock. */
+	/* Enables Landlock. */
 	ruleset_fd =3D create_ruleset(_metadata, handled, rules);
=20
 	ASSERT_LE(0, ruleset_fd);
@@ -3463,7 +3467,7 @@ TEST_F_FORK(layout1, truncate)
 			      LANDLOCK_ACCESS_FS_TRUNCATE;
 	int ruleset_fd;
=20
-	/* Enable Landlock. */
+	/* Enables Landlock. */
 	ruleset_fd =3D create_ruleset(_metadata, handled, rules);
=20
 	ASSERT_LE(0, ruleset_fd);
@@ -3689,7 +3693,7 @@ TEST_F_FORK(ftruncate, open_and_ftruncate)
 	};
 	int fd, ruleset_fd;
=20
-	/* Enable Landlock. */
+	/* Enables Landlock. */
 	ruleset_fd =3D create_ruleset(_metadata, variant->handled, rules);
 	ASSERT_LE(0, ruleset_fd);
 	enforce_ruleset(_metadata, ruleset_fd);
@@ -3766,6 +3770,16 @@ TEST_F_FORK(ftruncate, open_and_ftruncate_in_differe=
nt_processes)
 	ASSERT_EQ(0, close(socket_fds[1]));
 }
=20
+/* Invokes the FS_IOC_GETFLAGS IOCTL and returns its errno or 0. */
+static int test_fs_ioc_getflags_ioctl(int fd)
+{
+	uint32_t flags;
+
+	if (ioctl(fd, FS_IOC_GETFLAGS, &flags) < 0)
+		return errno;
+	return 0;
+}
+
 TEST(memfd_ftruncate)
 {
 	int fd;
@@ -3782,6 +3796,417 @@ TEST(memfd_ftruncate)
 	ASSERT_EQ(0, close(fd));
 }
=20
+/* clang-format off */
+FIXTURE(ioctl) {};
+/* clang-format on */
+
+FIXTURE_SETUP(ioctl)
+{
+	prepare_layout(_metadata);
+	create_file(_metadata, file1_s1d1);
+}
+
+FIXTURE_TEARDOWN(ioctl)
+{
+	EXPECT_EQ(0, remove_path(file1_s1d1));
+	cleanup_layout(_metadata);
+}
+
+FIXTURE_VARIANT(ioctl)
+{
+	const __u64 handled;
+	const __u64 allowed;
+	const mode_t open_mode;
+	/*
+	 * These are the expected IOCTL results for a representative IOCTL from
+	 * each of the IOCTL groups.  We only distinguish the 0 and EACCES
+	 * results here, and treat other errors as 0.
+	 */
+	const int expected_fioqsize_result; /* G1 */
+	const int expected_fibmap_result; /* G2 */
+	const int expected_fionread_result; /* G3 */
+	const int expected_fs_ioc_zero_range_result; /* G4 */
+	const int expected_fs_ioc_getflags_result; /* other */
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, handled_i_allowed_none) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_IOCTL,
+	.allowed =3D 0,
+	.open_mode =3D O_RDWR,
+	.expected_fioqsize_result =3D EACCES,
+	.expected_fibmap_result =3D EACCES,
+	.expected_fionread_result =3D EACCES,
+	.expected_fs_ioc_zero_range_result =3D EACCES,
+	.expected_fs_ioc_getflags_result =3D EACCES,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, handled_i_allowed_i) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_IOCTL,
+	.allowed =3D LANDLOCK_ACCESS_FS_IOCTL,
+	.open_mode =3D O_RDWR,
+	.expected_fioqsize_result =3D 0,
+	.expected_fibmap_result =3D 0,
+	.expected_fionread_result =3D 0,
+	.expected_fs_ioc_zero_range_result =3D 0,
+	.expected_fs_ioc_getflags_result =3D 0,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, unhandled) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_EXECUTE,
+	.allowed =3D LANDLOCK_ACCESS_FS_EXECUTE,
+	.open_mode =3D O_RDWR,
+	.expected_fioqsize_result =3D 0,
+	.expected_fibmap_result =3D 0,
+	.expected_fionread_result =3D 0,
+	.expected_fs_ioc_zero_range_result =3D 0,
+	.expected_fs_ioc_getflags_result =3D 0,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, handled_rwd_allowed_r) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_READ_FILE |
+		   LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_READ_DIR,
+	.allowed =3D LANDLOCK_ACCESS_FS_READ_FILE,
+	.open_mode =3D O_RDONLY,
+	/* If LANDLOCK_ACCESS_FS_IOCTL is not handled, all IOCTLs work. */
+	.expected_fioqsize_result =3D 0,
+	.expected_fibmap_result =3D 0,
+	.expected_fionread_result =3D 0,
+	.expected_fs_ioc_zero_range_result =3D 0,
+	.expected_fs_ioc_getflags_result =3D 0,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, handled_rwd_allowed_w) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_READ_FILE |
+		   LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_READ_DIR,
+	.allowed =3D LANDLOCK_ACCESS_FS_WRITE_FILE,
+	.open_mode =3D O_WRONLY,
+	/* If LANDLOCK_ACCESS_FS_IOCTL is not handled, all IOCTLs work. */
+	.expected_fioqsize_result =3D 0,
+	.expected_fibmap_result =3D 0,
+	.expected_fionread_result =3D 0,
+	.expected_fs_ioc_zero_range_result =3D 0,
+	.expected_fs_ioc_getflags_result =3D 0,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, handled_ri_allowed_r) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_READ_FILE | LANDLOCK_ACCESS_FS_IOCTL,
+	.allowed =3D LANDLOCK_ACCESS_FS_READ_FILE,
+	.open_mode =3D O_RDONLY,
+	.expected_fioqsize_result =3D 0,
+	.expected_fibmap_result =3D 0,
+	.expected_fionread_result =3D 0,
+	.expected_fs_ioc_zero_range_result =3D EACCES,
+	.expected_fs_ioc_getflags_result =3D EACCES,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, handled_wi_allowed_w) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_IOCTL,
+	.allowed =3D LANDLOCK_ACCESS_FS_WRITE_FILE,
+	.open_mode =3D O_WRONLY,
+	.expected_fioqsize_result =3D 0,
+	.expected_fibmap_result =3D 0,
+	.expected_fionread_result =3D EACCES,
+	.expected_fs_ioc_zero_range_result =3D 0,
+	.expected_fs_ioc_getflags_result =3D EACCES,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, handled_di_allowed_d) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_READ_DIR | LANDLOCK_ACCESS_FS_IOCTL,
+	.allowed =3D LANDLOCK_ACCESS_FS_READ_DIR,
+	.open_mode =3D O_RDWR,
+	.expected_fioqsize_result =3D 0,
+	.expected_fibmap_result =3D EACCES,
+	.expected_fionread_result =3D EACCES,
+	.expected_fs_ioc_zero_range_result =3D EACCES,
+	.expected_fs_ioc_getflags_result =3D EACCES,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, handled_rwi_allowed_rw) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_READ_FILE |
+		   LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_IOCTL,
+	.allowed =3D LANDLOCK_ACCESS_FS_READ_FILE | LANDLOCK_ACCESS_FS_WRITE_FILE=
,
+	.open_mode =3D O_RDWR,
+	.expected_fioqsize_result =3D 0,
+	.expected_fibmap_result =3D 0,
+	.expected_fionread_result =3D 0,
+	.expected_fs_ioc_zero_range_result =3D 0,
+	.expected_fs_ioc_getflags_result =3D EACCES,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, handled_rwi_allowed_r) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_READ_FILE |
+		   LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_IOCTL,
+	.allowed =3D LANDLOCK_ACCESS_FS_READ_FILE,
+	.open_mode =3D O_RDONLY,
+	.expected_fioqsize_result =3D 0,
+	.expected_fibmap_result =3D 0,
+	.expected_fionread_result =3D 0,
+	.expected_fs_ioc_zero_range_result =3D EACCES,
+	.expected_fs_ioc_getflags_result =3D EACCES,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, handled_rwi_allowed_ri) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_READ_FILE |
+		   LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_IOCTL,
+	.allowed =3D LANDLOCK_ACCESS_FS_READ_FILE | LANDLOCK_ACCESS_FS_IOCTL,
+	.open_mode =3D O_RDONLY,
+	.expected_fioqsize_result =3D 0,
+	.expected_fibmap_result =3D 0,
+	.expected_fionread_result =3D 0,
+	.expected_fs_ioc_zero_range_result =3D EACCES,
+	.expected_fs_ioc_getflags_result =3D 0,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, handled_rwi_allowed_w) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_READ_FILE |
+		   LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_IOCTL,
+	.allowed =3D LANDLOCK_ACCESS_FS_WRITE_FILE,
+	.open_mode =3D O_WRONLY,
+	.expected_fioqsize_result =3D 0,
+	.expected_fibmap_result =3D 0,
+	.expected_fionread_result =3D EACCES,
+	.expected_fs_ioc_zero_range_result =3D 0,
+	.expected_fs_ioc_getflags_result =3D EACCES,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, handled_rwi_allowed_wi) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_READ_FILE |
+		   LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_IOCTL,
+	.allowed =3D LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_IOCTL,
+	.open_mode =3D O_WRONLY,
+	.expected_fioqsize_result =3D 0,
+	.expected_fibmap_result =3D 0,
+	.expected_fionread_result =3D EACCES,
+	.expected_fs_ioc_zero_range_result =3D 0,
+	.expected_fs_ioc_getflags_result =3D 0,
+};
+
+static int test_fioqsize_ioctl(int fd)
+{
+	size_t sz;
+
+	if (ioctl(fd, FIOQSIZE, &sz) < 0)
+		return errno;
+	return 0;
+}
+
+static int test_fibmap_ioctl(int fd)
+{
+	int blk =3D 0;
+
+	/*
+	 * We only want to distinguish here whether Landlock already caught it,
+	 * so we treat anything but EACCESS as success.  (It commonly returns
+	 * EPERM when missing CAP_SYS_RAWIO.)
+	 */
+	if (ioctl(fd, FIBMAP, &blk) < 0 && errno =3D=3D EACCES)
+		return errno;
+	return 0;
+}
+
+static int test_fionread_ioctl(int fd)
+{
+	size_t sz =3D 0;
+
+	if (ioctl(fd, FIONREAD, &sz) < 0 && errno =3D=3D EACCES)
+		return errno;
+	return 0;
+}
+
+#define FS_IOC_ZERO_RANGE _IOW('X', 57, struct space_resv)
+
+static int test_fs_ioc_zero_range_ioctl(int fd)
+{
+	struct space_resv {
+		__s16 l_type;
+		__s16 l_whence;
+		__s64 l_start;
+		__s64 l_len; /* len =3D=3D 0 means until end of file */
+		__s32 l_sysid;
+		__u32 l_pid;
+		__s32 l_pad[4]; /* reserved area */
+	} reservation =3D {};
+	/*
+	 * This can fail for various reasons, but we only want to distinguish
+	 * here whether Landlock already caught it, so we treat anything but
+	 * EACCES as success.
+	 */
+	if (ioctl(fd, FS_IOC_ZERO_RANGE, &reservation) < 0 && errno =3D=3D EACCES=
)
+		return errno;
+	return 0;
+}
+
+TEST_F_FORK(ioctl, handle_dir_access_file)
+{
+	const int flag =3D 0;
+	const struct rule rules[] =3D {
+		{
+			.path =3D dir_s1d1,
+			.access =3D variant->allowed,
+		},
+		{},
+	};
+	int file_fd, ruleset_fd;
+
+	/* Enables Landlock. */
+	ruleset_fd =3D create_ruleset(_metadata, variant->handled, rules);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	file_fd =3D open(file1_s1d1, variant->open_mode);
+	ASSERT_LE(0, file_fd);
+
+	/*
+	 * Checks that IOCTL commands in each IOCTL group return the expected
+	 * errors.
+	 */
+	EXPECT_EQ(variant->expected_fioqsize_result,
+		  test_fioqsize_ioctl(file_fd));
+	EXPECT_EQ(variant->expected_fibmap_result, test_fibmap_ioctl(file_fd));
+	EXPECT_EQ(variant->expected_fionread_result,
+		  test_fionread_ioctl(file_fd));
+	EXPECT_EQ(variant->expected_fs_ioc_zero_range_result,
+		  test_fs_ioc_zero_range_ioctl(file_fd));
+	EXPECT_EQ(variant->expected_fs_ioc_getflags_result,
+		  test_fs_ioc_getflags_ioctl(file_fd));
+
+	/* Checks that unrestrictable commands are unrestricted. */
+	EXPECT_EQ(0, ioctl(file_fd, FIOCLEX));
+	EXPECT_EQ(0, ioctl(file_fd, FIONCLEX));
+	EXPECT_EQ(0, ioctl(file_fd, FIONBIO, &flag));
+	EXPECT_EQ(0, ioctl(file_fd, FIOASYNC, &flag));
+
+	ASSERT_EQ(0, close(file_fd));
+}
+
+TEST_F_FORK(ioctl, handle_dir_access_dir)
+{
+	const char *const path =3D dir_s1d1;
+	const int flag =3D 0;
+	const struct rule rules[] =3D {
+		{
+			.path =3D path,
+			.access =3D variant->allowed,
+		},
+		{},
+	};
+	int dir_fd, ruleset_fd;
+
+	/* Enables Landlock. */
+	ruleset_fd =3D create_ruleset(_metadata, variant->handled, rules);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/*
+	 * Ignore variant->open_mode for this test, as we intend to open a
+	 * directory.  If the directory can not be opened, the variant is
+	 * infeasible to test with an opened directory.
+	 */
+	dir_fd =3D open(path, O_RDONLY);
+	if (dir_fd < 0)
+		return;
+
+	/*
+	 * Checks that IOCTL commands in each IOCTL group return the expected
+	 * errors.
+	 */
+	EXPECT_EQ(variant->expected_fioqsize_result,
+		  test_fioqsize_ioctl(dir_fd));
+	EXPECT_EQ(variant->expected_fibmap_result, test_fibmap_ioctl(dir_fd));
+	EXPECT_EQ(variant->expected_fionread_result,
+		  test_fionread_ioctl(dir_fd));
+	EXPECT_EQ(variant->expected_fs_ioc_zero_range_result,
+		  test_fs_ioc_zero_range_ioctl(dir_fd));
+	EXPECT_EQ(variant->expected_fs_ioc_getflags_result,
+		  test_fs_ioc_getflags_ioctl(dir_fd));
+
+	/* Checks that unrestrictable commands are unrestricted. */
+	EXPECT_EQ(0, ioctl(dir_fd, FIOCLEX));
+	EXPECT_EQ(0, ioctl(dir_fd, FIONCLEX));
+	EXPECT_EQ(0, ioctl(dir_fd, FIONBIO, &flag));
+	EXPECT_EQ(0, ioctl(dir_fd, FIOASYNC, &flag));
+
+	ASSERT_EQ(0, close(dir_fd));
+}
+
+TEST_F_FORK(ioctl, handle_file_access_file)
+{
+	const char *const path =3D file1_s1d1;
+	const int flag =3D 0;
+	const struct rule rules[] =3D {
+		{
+			.path =3D path,
+			.access =3D variant->allowed,
+		},
+		{},
+	};
+	int file_fd, ruleset_fd;
+
+	if (variant->allowed & LANDLOCK_ACCESS_FS_READ_DIR) {
+		SKIP(return, "LANDLOCK_ACCESS_FS_READ_DIR "
+			     "can not be granted on files");
+	}
+
+	/* Enables Landlock. */
+	ruleset_fd =3D create_ruleset(_metadata, variant->handled, rules);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	file_fd =3D open(path, variant->open_mode);
+	ASSERT_LE(0, file_fd);
+
+	/*
+	 * Checks that IOCTL commands in each IOCTL group return the expected
+	 * errors.
+	 */
+	EXPECT_EQ(variant->expected_fioqsize_result,
+		  test_fioqsize_ioctl(file_fd));
+	EXPECT_EQ(variant->expected_fibmap_result, test_fibmap_ioctl(file_fd));
+	EXPECT_EQ(variant->expected_fionread_result,
+		  test_fionread_ioctl(file_fd));
+	EXPECT_EQ(variant->expected_fs_ioc_zero_range_result,
+		  test_fs_ioc_zero_range_ioctl(file_fd));
+	EXPECT_EQ(variant->expected_fs_ioc_getflags_result,
+		  test_fs_ioc_getflags_ioctl(file_fd));
+
+	/* Checks that unrestrictable commands are unrestricted. */
+	EXPECT_EQ(0, ioctl(file_fd, FIOCLEX));
+	EXPECT_EQ(0, ioctl(file_fd, FIONCLEX));
+	EXPECT_EQ(0, ioctl(file_fd, FIONBIO, &flag));
+	EXPECT_EQ(0, ioctl(file_fd, FIOASYNC, &flag));
+
+	ASSERT_EQ(0, close(file_fd));
+}
+
 /* clang-format off */
 FIXTURE(layout1_bind) {};
 /* clang-format on */
--=20
2.43.0.rc1.413.gea7ed67945-goog


