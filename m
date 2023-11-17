Return-Path: <linux-fsdevel+bounces-3026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 653B97EF5A5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 16:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18F0128137F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 15:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD8F3C49B;
	Fri, 17 Nov 2023 15:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CGMVQsEu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFC8E6
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 07:49:39 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-daa2684f67eso1730267276.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 07:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700236178; x=1700840978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CB1G0pSFnh90AFDrFXqyA+gNp0ElXy6xfe2eRyBIU6Q=;
        b=CGMVQsEu2uvZY2xr170a8J9xyS4J158mkUxLalV9BydCqbOVe3dE1ctMVUHiQ4J9Md
         4BaF8d/KTPnyIjiPE4UL33J+haMh09MjTf+2XeZi4W75QYSz6/+nx6M/WwojAmovAdBA
         wbQbBvn0XcSFmRP97UFNt/FPiuW1X0mDHdNhxd3BHFeMVtSLWg1E8ZMPLyNAVmEIPsps
         qZEkARdADBw88+Dq9z0USlvoXXXenoQFkPv8T7sPsPG/xzfLN/BFAcAZgRFCwiKGU2Bh
         1H0FWYxYlWv1qYV7XFIIOSjZfiuTKWSiwR37rG3WSMxvMu5d6S399Pzd7H7Qc+Z/XrnV
         E96Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700236178; x=1700840978;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CB1G0pSFnh90AFDrFXqyA+gNp0ElXy6xfe2eRyBIU6Q=;
        b=fiivs2bGaI07pYQYF1KyLdPlQSLk7ry5lIZ0Ox9re1pl4wEifaPx4fm4VZYDiPHv6Y
         oCOQs0wPt8zgChPltaiREPZrqpLn61qNUEjdlwOxrDwyXon4a1pH55a+CDrABN+EtFQz
         NpjtR9mEKt8pzZcO2Sqd+J1WlBl9vqWcpr3LXUWC/hBl4ZghicSusefq3M+gkOLjDgI8
         m1MdnzP5Oj/2uTBszFYRwZCjD3+mylXPKjJyu8ma/NwlTRJbwkILH+6mJcRd79MQBDu9
         NoXF1IFvfilxKWT0NZWvZQPIVyOu1WBFwi9itmdF2AYBmbgtpYOy0QNjAMLPQik+5QUW
         VUew==
X-Gm-Message-State: AOJu0Yw6Uf7uz/8wbqzFp/1Chvm8MkXb3+HP8XpWmctyI0x3NJbiZopB
	eGjmgBX6mAoUylo9gkeuH5S/RVISGc0=
X-Google-Smtp-Source: AGHT+IERYqT4X4e5oow9/OBDpktHd2R9R6ftPIKLPVry5XbGP9gHx4xIarnXl0L53dR4h77CPNAdy0Jp38I=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:2ae5:2882:889e:d0cf])
 (user=gnoack job=sendgmr) by 2002:a05:6902:571:b0:d9c:a723:5c3c with SMTP id
 a17-20020a056902057100b00d9ca7235c3cmr157438ybt.1.1700236178618; Fri, 17 Nov
 2023 07:49:38 -0800 (PST)
Date: Fri, 17 Nov 2023 16:49:16 +0100
In-Reply-To: <20231117154920.1706371-1-gnoack@google.com>
Message-Id: <20231117154920.1706371-4-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231117154920.1706371-1-gnoack@google.com>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Subject: [PATCH v5 3/7] selftests/landlock: Test IOCTL support
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
 tools/testing/selftests/landlock/fs_test.c | 423 ++++++++++++++++++++-
 1 file changed, 420 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index 256cd9a96eb7..564e73087e08 100644
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
@@ -3380,7 +3381,7 @@ TEST_F_FORK(layout1, truncate_unhandled)
 			      LANDLOCK_ACCESS_FS_WRITE_FILE;
 	int ruleset_fd;
=20
-	/* Enable Landlock. */
+	/* Enables Landlock. */
 	ruleset_fd =3D create_ruleset(_metadata, handled, rules);
=20
 	ASSERT_LE(0, ruleset_fd);
@@ -3463,7 +3464,7 @@ TEST_F_FORK(layout1, truncate)
 			      LANDLOCK_ACCESS_FS_TRUNCATE;
 	int ruleset_fd;
=20
-	/* Enable Landlock. */
+	/* Enables Landlock. */
 	ruleset_fd =3D create_ruleset(_metadata, handled, rules);
=20
 	ASSERT_LE(0, ruleset_fd);
@@ -3690,7 +3691,7 @@ TEST_F_FORK(ftruncate, open_and_ftruncate)
 	};
 	int fd, ruleset_fd;
=20
-	/* Enable Landlock. */
+	/* Enables Landlock. */
 	ruleset_fd =3D create_ruleset(_metadata, variant->handled, rules);
 	ASSERT_LE(0, ruleset_fd);
 	enforce_ruleset(_metadata, ruleset_fd);
@@ -3767,6 +3768,16 @@ TEST_F_FORK(ftruncate, open_and_ftruncate_in_differe=
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
@@ -3783,6 +3794,412 @@ TEST(memfd_ftruncate)
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
+	const __u64 permitted;
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
+FIXTURE_VARIANT_ADD(ioctl, ioctl_handled_i_permitted_none) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_EXECUTE | LANDLOCK_ACCESS_FS_IOCTL,
+	.permitted =3D LANDLOCK_ACCESS_FS_EXECUTE,
+	.open_mode =3D O_RDWR,
+	.expected_fioqsize_result =3D EACCES,
+	.expected_fibmap_result =3D EACCES,
+	.expected_fionread_result =3D EACCES,
+	.expected_fs_ioc_zero_range_result =3D EACCES,
+	.expected_fs_ioc_getflags_result =3D EACCES,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, ioctl_handled_i_permitted_i) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_IOCTL,
+	.permitted =3D LANDLOCK_ACCESS_FS_IOCTL,
+	.open_mode =3D O_RDWR,
+	.expected_fioqsize_result =3D 0,
+	.expected_fibmap_result =3D 0,
+	.expected_fionread_result =3D 0,
+	.expected_fs_ioc_zero_range_result =3D 0,
+	.expected_fs_ioc_getflags_result =3D 0,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, ioctl_unhandled) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_EXECUTE,
+	.permitted =3D LANDLOCK_ACCESS_FS_EXECUTE,
+	.open_mode =3D O_RDWR,
+	.expected_fioqsize_result =3D 0,
+	.expected_fibmap_result =3D 0,
+	.expected_fionread_result =3D 0,
+	.expected_fs_ioc_zero_range_result =3D 0,
+	.expected_fs_ioc_getflags_result =3D 0,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, ioctl_handled_rwd_permitted_r) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_READ_FILE |
+		   LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_READ_DIR,
+	.permitted =3D LANDLOCK_ACCESS_FS_READ_FILE,
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
+FIXTURE_VARIANT_ADD(ioctl, ioctl_handled_rwd_permitted_w) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_READ_FILE |
+		   LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_READ_DIR,
+	.permitted =3D LANDLOCK_ACCESS_FS_WRITE_FILE,
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
+FIXTURE_VARIANT_ADD(ioctl, ioctl_handled_ri_permitted_r) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_READ_FILE | LANDLOCK_ACCESS_FS_IOCTL,
+	.permitted =3D LANDLOCK_ACCESS_FS_READ_FILE,
+	.open_mode =3D O_RDONLY,
+	.expected_fioqsize_result =3D 0,
+	.expected_fibmap_result =3D 0,
+	.expected_fionread_result =3D 0,
+	.expected_fs_ioc_zero_range_result =3D EACCES,
+	.expected_fs_ioc_getflags_result =3D EACCES,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, ioctl_handled_wi_permitted_w) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_IOCTL,
+	.permitted =3D LANDLOCK_ACCESS_FS_WRITE_FILE,
+	.open_mode =3D O_WRONLY,
+	.expected_fioqsize_result =3D 0,
+	.expected_fibmap_result =3D 0,
+	.expected_fionread_result =3D EACCES,
+	.expected_fs_ioc_zero_range_result =3D 0,
+	.expected_fs_ioc_getflags_result =3D EACCES,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, ioctl_handled_di_permitted_d) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_READ_DIR | LANDLOCK_ACCESS_FS_IOCTL,
+	.permitted =3D LANDLOCK_ACCESS_FS_READ_DIR,
+	.open_mode =3D O_RDWR,
+	.expected_fioqsize_result =3D 0,
+	.expected_fibmap_result =3D EACCES,
+	.expected_fionread_result =3D EACCES,
+	.expected_fs_ioc_zero_range_result =3D EACCES,
+	.expected_fs_ioc_getflags_result =3D EACCES,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, ioctl_handled_rwi_permitted_rw) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_READ_FILE |
+		   LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_IOCTL,
+	.permitted =3D LANDLOCK_ACCESS_FS_READ_FILE |
+		     LANDLOCK_ACCESS_FS_WRITE_FILE,
+	.open_mode =3D O_RDWR,
+	.expected_fioqsize_result =3D 0,
+	.expected_fibmap_result =3D 0,
+	.expected_fionread_result =3D 0,
+	.expected_fs_ioc_zero_range_result =3D 0,
+	.expected_fs_ioc_getflags_result =3D EACCES,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, ioctl_handled_rwi_permitted_r) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_READ_FILE |
+		   LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_IOCTL,
+	.permitted =3D LANDLOCK_ACCESS_FS_READ_FILE,
+	.open_mode =3D O_RDONLY,
+	.expected_fioqsize_result =3D 0,
+	.expected_fibmap_result =3D 0,
+	.expected_fionread_result =3D 0,
+	.expected_fs_ioc_zero_range_result =3D EACCES,
+	.expected_fs_ioc_getflags_result =3D EACCES,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, ioctl_handled_rwi_permitted_ri) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_READ_FILE |
+		   LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_IOCTL,
+	.permitted =3D LANDLOCK_ACCESS_FS_READ_FILE | LANDLOCK_ACCESS_FS_IOCTL,
+	.open_mode =3D O_RDONLY,
+	.expected_fioqsize_result =3D 0,
+	.expected_fibmap_result =3D 0,
+	.expected_fionread_result =3D 0,
+	.expected_fs_ioc_zero_range_result =3D EACCES,
+	.expected_fs_ioc_getflags_result =3D 0,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, ioctl_handled_rwi_permitted_w) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_READ_FILE |
+		   LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_IOCTL,
+	.permitted =3D LANDLOCK_ACCESS_FS_WRITE_FILE,
+	.open_mode =3D O_WRONLY,
+	.expected_fioqsize_result =3D 0,
+	.expected_fibmap_result =3D 0,
+	.expected_fionread_result =3D EACCES,
+	.expected_fs_ioc_zero_range_result =3D 0,
+	.expected_fs_ioc_getflags_result =3D EACCES,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, ioctl_handled_rwi_permitted_wi) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_READ_FILE |
+		   LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_IOCTL,
+	.permitted =3D LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_IOCTL,
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
+			.access =3D variant->permitted,
+		},
+		{},
+	};
+	int fd, ruleset_fd;
+
+	/* Enables Landlock. */
+	ruleset_fd =3D create_ruleset(_metadata, variant->handled, rules);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	fd =3D open(file1_s1d1, variant->open_mode);
+	ASSERT_LE(0, fd);
+
+	/*
+	 * Checks that IOCTL commands in each IOCTL group return the expected
+	 * errors.
+	 */
+	EXPECT_EQ(variant->expected_fioqsize_result, test_fioqsize_ioctl(fd));
+	EXPECT_EQ(variant->expected_fibmap_result, test_fibmap_ioctl(fd));
+	EXPECT_EQ(variant->expected_fionread_result, test_fionread_ioctl(fd));
+	EXPECT_EQ(variant->expected_fs_ioc_zero_range_result,
+		  test_fs_ioc_zero_range_ioctl(fd));
+	EXPECT_EQ(variant->expected_fs_ioc_getflags_result,
+		  test_fs_ioc_getflags_ioctl(fd));
+
+	/* Checks that unrestrictable commands are unrestricted. */
+	EXPECT_EQ(0, ioctl(fd, FIOCLEX));
+	EXPECT_EQ(0, ioctl(fd, FIONCLEX));
+	EXPECT_EQ(0, ioctl(fd, FIONBIO, &flag));
+	EXPECT_EQ(0, ioctl(fd, FIOASYNC, &flag));
+
+	ASSERT_EQ(0, close(fd));
+}
+
+TEST_F_FORK(ioctl, handle_dir_access_dir)
+{
+	const char *const path =3D dir_s1d1;
+	const int flag =3D 0;
+	const struct rule rules[] =3D {
+		{
+			.path =3D path,
+			.access =3D variant->permitted,
+		},
+		{},
+	};
+	int fd, ruleset_fd;
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
+	fd =3D open(path, O_RDONLY);
+	if (fd < 0)
+		return;
+
+	/*
+	 * Checks that IOCTL commands in each IOCTL group return the expected
+	 * errors.
+	 */
+	EXPECT_EQ(variant->expected_fioqsize_result, test_fioqsize_ioctl(fd));
+	EXPECT_EQ(variant->expected_fibmap_result, test_fibmap_ioctl(fd));
+	EXPECT_EQ(variant->expected_fionread_result, test_fionread_ioctl(fd));
+	EXPECT_EQ(variant->expected_fs_ioc_zero_range_result,
+		  test_fs_ioc_zero_range_ioctl(fd));
+	EXPECT_EQ(variant->expected_fs_ioc_getflags_result,
+		  test_fs_ioc_getflags_ioctl(fd));
+
+	/* Checks that unrestrictable commands are unrestricted. */
+	EXPECT_EQ(0, ioctl(fd, FIOCLEX));
+	EXPECT_EQ(0, ioctl(fd, FIONCLEX));
+	EXPECT_EQ(0, ioctl(fd, FIONBIO, &flag));
+	EXPECT_EQ(0, ioctl(fd, FIOASYNC, &flag));
+
+	ASSERT_EQ(0, close(fd));
+}
+
+TEST_F_FORK(ioctl, handle_file_access_file)
+{
+	const char *const path =3D file1_s1d1;
+	const int flag =3D 0;
+	const struct rule rules[] =3D {
+		{
+			.path =3D path,
+			.access =3D variant->permitted,
+		},
+		{},
+	};
+	int fd, ruleset_fd;
+
+	if (variant->permitted & LANDLOCK_ACCESS_FS_READ_DIR) {
+		/* This access right can not be granted on files. */
+		return;
+	}
+
+	/* Enables Landlock. */
+	ruleset_fd =3D create_ruleset(_metadata, variant->handled, rules);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	fd =3D open(path, variant->open_mode);
+	ASSERT_LE(0, fd);
+
+	/*
+	 * Checks that IOCTL commands in each IOCTL group return the expected
+	 * errors.
+	 */
+	EXPECT_EQ(variant->expected_fioqsize_result, test_fioqsize_ioctl(fd));
+	EXPECT_EQ(variant->expected_fibmap_result, test_fibmap_ioctl(fd));
+	EXPECT_EQ(variant->expected_fionread_result, test_fionread_ioctl(fd));
+	EXPECT_EQ(variant->expected_fs_ioc_zero_range_result,
+		  test_fs_ioc_zero_range_ioctl(fd));
+	EXPECT_EQ(variant->expected_fs_ioc_getflags_result,
+		  test_fs_ioc_getflags_ioctl(fd));
+
+	/* Checks that unrestrictable commands are unrestricted. */
+	EXPECT_EQ(0, ioctl(fd, FIOCLEX));
+	EXPECT_EQ(0, ioctl(fd, FIONCLEX));
+	EXPECT_EQ(0, ioctl(fd, FIONBIO, &flag));
+	EXPECT_EQ(0, ioctl(fd, FIOASYNC, &flag));
+
+	ASSERT_EQ(0, close(fd));
+}
+
 /* clang-format off */
 FIXTURE(layout1_bind) {};
 /* clang-format on */
--=20
2.43.0.rc1.413.gea7ed67945-goog


