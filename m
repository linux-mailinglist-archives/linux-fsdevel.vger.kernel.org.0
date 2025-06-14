Return-Path: <linux-fsdevel+bounces-51670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B317CAD9EF9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jun 2025 20:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 858AE3AD3EB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jun 2025 18:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935182E337C;
	Sat, 14 Jun 2025 18:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="DTILlGoz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SM+Y5+yc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227D079D0;
	Sat, 14 Jun 2025 18:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749925623; cv=none; b=B+0JCXHtiRPQdKlD4UQZftuMXtrQqCPzoddd345uq8vlEUXVyuS4+ejp803K4wsT8NbT2vrZM7baSxY3FTK8GgzUOqgICrGIO9lwZajy4FqaPdoZArqQyvAx3LQhFR45PlPmLAIAxmgBoI0j8cIz4ch9T6H/N7pjEGfEFKLb2EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749925623; c=relaxed/simple;
	bh=yhE3kYIuS6e0GRl7uPSIcglzoiDqD609ZhjzThyuuNA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mNbpmsdlXsYgAHDjoc/6M3UcrAZJAcFj6w/1nP3MpzVO9ZCn5inRgIL06sF7/X+XVbdVlq1Y0FRuBtbVRairOeyOdqw9eu0qNMksAB+2jyPqF2FR8AJipqoAeHByi5QDOllaMdpi9m+AVBG5Y8rel7yJwB0NX0WyIHvfg0H4SnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=DTILlGoz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SM+Y5+yc; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 2A6C5138033A;
	Sat, 14 Jun 2025 14:26:59 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sat, 14 Jun 2025 14:26:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1749925619; x=1750012019; bh=sr1C6/pbThpyWAzfiQUO8
	1KdODSjOzOoODJh4Ycto4g=; b=DTILlGozcHiFErC3RE88UAgvUGszO93ojaUbl
	aoVr0lFftyMWa3gpORz7WPT0vPYjaqn3uSqfYcQom8tWxrkr/NmERHN4s3VCw3/w
	cCh/EkswVzOAVvK2ScIRoja82lXpmWbzZzSvJ7v3LFR0LPlsdp9PK19/a9P7PS3Q
	bMz90hdU5yblFnVRDaRi3RvMgQQA+VKgttRF/bfQiSnXVf53/zA9wMSq+VWBs+pV
	/BFubr0YWCsFrN0jKW8TnuduwDKcmSxNeUQe11KJ68U7MAT95H/+lHrVMzd1neS8
	YUp0WBWGcKtV4MzQLaBrgb2I9yblMwUA4vHdbfYjpyUzVeo2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749925619; x=1750012019; bh=sr1C6/pbThpyWAzfiQUO81KdODSjOzOoODJ
	h4Ycto4g=; b=SM+Y5+ycNB806Z+jquwj5n6ha4RN2JuszWM3QV1zJ5LRs3xIe1X
	3ovHhArbYc4GWeqe/dCzdPIcD9PRCr5OCRcM0xVc1vlUXE2dIgTkhDb0QvQ9P6A6
	RQ72shqqN1tZqTxEG8frUPw/uv+dBZr8wyrKE25NoVXf6tCC1NtiY7AO2XZ01k0R
	k8fK0Duo4m5lsF34uIrqEHtlCqi/ZnCB/o6lt2Qa60El4SrehifBCwE71ePTiijO
	0xFxjlOiegRu/2FXFxmTlpnz/3dHMFodYhj1OSKR1pQhB3xDtZN03Uziv2eKjgNx
	GEhKD79IURDYOI/0Sa4rGPu9KSvNrI7XB7A==
X-ME-Sender: <xms:8r5NaI67DV6f8RdLOQ7C6KJLHN0N4sdf0d5FpMy1ZMK84iLi2ii2xQ>
    <xme:8r5NaJ6LOLWkAEd7L83WLqo00iM3y4i4M2-sHZm68_nl0eRQMKOH-siNIEhEtlSjc
    gIkNtA143OtY7mt_yU>
X-ME-Received: <xmr:8r5NaHe-i6dyu_hNAv2KEgkoyfclPSljQSzXPug3j9rlUlgsBuPPQlMqeT85Lv7lo7smoZGetuVx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvudehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecu
    hfhrohhmpefvihhnghhmrghoucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepleeigeegudefjefhuefgtedtfeeggeegffeuffelvdeiheetuddt
    uddtudeukeevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmhdrohhrghdp
    nhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhitg
    esughighhikhhougdrnhgvthdprhgtphhtthhopehgnhhorggtkhesghhoohhglhgvrdgt
    ohhmpdhrtghpthhtohepmhesmhgrohifthhmrdhorhhgpdhrtghpthhtohepshhonhhgse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmhho
    ughulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfh
    hsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:8r5NaNJuNvDMdwKp1J3uegD9X_lK-cnaJIDiOZe0IZ_-Dw4wTgwqnw>
    <xmx:8r5NaMKfmbBIX6cKZ15PyFAgw67mnaQZoA3FbAmI6KIzdwghZ_-PIw>
    <xmx:8r5NaOztrzokjbZ318MleF1WvumFcNo6ARBjNb5Gnme9Xjmt8uNK0w>
    <xmx:8r5NaALn13z2J_yDq48ftKqKhscI5rai-ocw_Cc5M_FzZstf2LUBig>
    <xmx:875NaChZkTqw1acyOCHuaMUqgUwWmO4v4BHuGTgTD44SCDnat93t-n2J>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Jun 2025 14:26:57 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: Tingmao Wang <m@maowtm.org>,
	Song Liu <song@kernel.org>,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] selftests/landlock: Add tests for access through disconnected paths
Date: Sat, 14 Jun 2025 19:25:02 +0100
Message-ID: <09b24128f86973a6022e6aa8338945fcfb9a33e4.1749925391.git.m@maowtm.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds a test for the edge case discussed in [1], and in addition also
test rename operations when the operands are through disconnected paths,
as that go through a separate code path in Landlock.

[1]: https://lore.kernel.org/linux-security-module/027d5190-b37a-40a8-84e9-4ccbc352bcdf@maowtm.org/

This has resulted in a WARNING, due to collect_domain_accesses() not
expecting to reach a different root from path->mnt:

	#  RUN           layout1_bind.path_disconnected ...
	#            OK  layout1_bind.path_disconnected
	ok 96 layout1_bind.path_disconnected
	#  RUN           layout1_bind.path_disconnected_rename ...
	[..] ------------[ cut here ]------------
	[..] WARNING: CPU: 3 PID: 385 at security/landlock/fs.c:1065 collect_domain_accesses
	[..] ...
	[..] RIP: 0010:collect_domain_accesses (security/landlock/fs.c:1065 (discriminator 2) security/landlock/fs.c:1031 (discriminator 2))
	[..] current_check_refer_path (security/landlock/fs.c:1205)
	[..] ...
	[..] hook_path_rename (security/landlock/fs.c:1526)
	[..] security_path_rename (security/security.c:2026 (discriminator 1))
	[..] do_renameat2 (fs/namei.c:5264)
	#            OK  layout1_bind.path_disconnected_rename
	ok 97 layout1_bind.path_disconnected_rename

My understanding is that terminating at the mountpoint is basically an
optimization, so that for rename operations we only walks the path from
the mountpoint to the real root once.  We probably want to keep this
optimization, as disconnected paths are probably a very rare edge case.

This might need more thinking, but maybe if one of the operands is
disconnected, we can just let it walk until IS_ROOT(dentry), and also
collect access for the other path until IS_ROOT(dentry), then call
is_access_to_paths_allowed() passing in the root dentry we walked to?  (In
this case is_access_to_paths_allowed will not do any walking and just make
an access decision.)

Letting the walk continue until IS_ROOT(dentry) is what
is_access_to_paths_allowed() effectively does for non-renames.

(Also note: moving the const char definitions a bit above so that we can
use the path for s4d1 in cleanup code.)

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 tools/testing/selftests/landlock/fs_test.c | 271 ++++++++++++++++++++-
 1 file changed, 268 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 73729382d40f..d042a742a1c5 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -4521,6 +4521,17 @@ TEST_F_FORK(ioctl, handle_file_access_file)
 FIXTURE(layout1_bind) {};
 /* clang-format on */
 
+static const char bind_dir_s1d3[] = TMP_DIR "/s2d1/s2d2/s1d3";
+static const char bind_file1_s1d3[] = TMP_DIR "/s2d1/s2d2/s1d3/f1";
+/* Move targets for disconnected path tests */
+static const char dir_s4d1[] = TMP_DIR "/s4d1";
+static const char file1_s4d1[] = TMP_DIR "/s4d1/f1";
+static const char file2_s4d1[] = TMP_DIR "/s4d1/f2";
+static const char dir_s4d2[] = TMP_DIR "/s4d1/s4d2";
+static const char file1_s4d2[] = TMP_DIR "/s4d1/s4d2/f1";
+static const char file1_name[] = "f1";
+static const char file2_name[] = "f2";
+
 FIXTURE_SETUP(layout1_bind)
 {
 	prepare_layout(_metadata);
@@ -4536,14 +4547,14 @@ FIXTURE_TEARDOWN_PARENT(layout1_bind)
 {
 	/* umount(dir_s2d2)) is handled by namespace lifetime. */
 
+	remove_path(file1_s4d1);
+	remove_path(file2_s4d1);
+
 	remove_layout1(_metadata);
 
 	cleanup_layout(_metadata);
 }
 
-static const char bind_dir_s1d3[] = TMP_DIR "/s2d1/s2d2/s1d3";
-static const char bind_file1_s1d3[] = TMP_DIR "/s2d1/s2d2/s1d3/f1";
-
 /*
  * layout1_bind hierarchy:
  *
@@ -4766,6 +4777,260 @@ TEST_F_FORK(layout1_bind, reparent_cross_mount)
 	ASSERT_EQ(0, rename(bind_file1_s1d3, file1_s2d2));
 }
 
+/*
+ * Make sure access to file through a disconnected path works as expected.
+ * This test uses s4d1 as the move target.
+ */
+TEST_F_FORK(layout1_bind, path_disconnected)
+{
+	const struct rule layer1_allow_all[] = {
+		{
+			.path = TMP_DIR,
+			.access = ACCESS_ALL,
+		},
+		{},
+	};
+
+	const struct rule layer2_allow_just_f1[] = {
+		{
+			.path = file1_s1d3,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE,
+		},
+		{},
+	};
+
+	const struct rule layer3_only_s1d2[] = {
+		{
+			.path = dir_s1d2,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE,
+		},
+		{},
+	};
+
+	/* Landlock should not deny access just because it is disconnected */
+	int ruleset_fd =
+		create_ruleset(_metadata, ACCESS_ALL, layer1_allow_all);
+	/*
+	 * Create the new ruleset now before we move the dir containing the
+	 * file
+	 */
+	int ruleset_fd_l2 =
+		create_ruleset(_metadata, ACCESS_RW, layer2_allow_just_f1);
+	int ruleset_fd_l3 =
+		create_ruleset(_metadata, ACCESS_RW, layer3_only_s1d2);
+	int bind_s1d3_fd;
+
+	ASSERT_LE(0, ruleset_fd);
+	ASSERT_LE(0, ruleset_fd_l2);
+	ASSERT_LE(0, ruleset_fd_l3);
+
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	bind_s1d3_fd = open(bind_dir_s1d3, O_PATH | O_CLOEXEC);
+
+	ASSERT_LE(0, bind_s1d3_fd);
+	/* Test access is possible before we move */
+	ASSERT_EQ(0, test_open_rel(bind_s1d3_fd, file1_name, O_RDONLY));
+	/* Make it disconnected */
+	ASSERT_EQ(0, rename(dir_s1d3, dir_s4d1))
+	{
+		TH_LOG("Failed to rename %s to %s: %s", dir_s1d3, dir_s4d1,
+		       strerror(errno));
+	}
+	/* Test access still possible */
+	ASSERT_EQ(0, test_open_rel(bind_s1d3_fd, file1_name, O_RDONLY));
+	/*
+	 * Test ".." not possibe (not because of landlock, but just because
+	 * it's disconnected)
+	 */
+	ASSERT_EQ(ENOENT,
+		  test_open_rel(bind_s1d3_fd, "..", O_RDONLY | O_DIRECTORY));
+
+	/* Should still work with a narrower rule */
+	enforce_ruleset(_metadata, ruleset_fd_l2);
+	ASSERT_EQ(0, close(ruleset_fd_l2));
+
+	ASSERT_EQ(0, test_open(file1_s4d1, O_RDONLY));
+	ASSERT_EQ(0, test_open_rel(bind_s1d3_fd, file1_name, O_RDONLY));
+	ASSERT_EQ(EACCES, test_open_rel(bind_s1d3_fd, file2_name, O_RDONLY));
+
+	/*
+	 * But if we only allow access to under the original dir, then it
+	 * should be denied.
+	 */
+	enforce_ruleset(_metadata, ruleset_fd_l3);
+	ASSERT_EQ(0, close(ruleset_fd_l3));
+	ASSERT_EQ(EACCES, test_open(file1_s4d1, O_RDONLY));
+	ASSERT_EQ(EACCES, test_open_rel(bind_s1d3_fd, file1_name, O_RDONLY));
+}
+
+/*
+ * Test that we can rename to make files disconnected, and rename it back,
+ * under landlock.  This test uses s4d2 as the move target, so that we can
+ * have a rule allowing refers on the move target's immediate parent.
+ */
+TEST_F_FORK(layout1_bind, path_disconnected_rename)
+{
+	const struct rule layer1[] = {
+		{
+			.path = dir_s1d2,
+			.access = LANDLOCK_ACCESS_FS_REFER |
+				  LANDLOCK_ACCESS_FS_MAKE_DIR |
+				  LANDLOCK_ACCESS_FS_REMOVE_DIR |
+				  LANDLOCK_ACCESS_FS_MAKE_REG |
+				  LANDLOCK_ACCESS_FS_REMOVE_FILE |
+				  LANDLOCK_ACCESS_FS_READ_FILE,
+		},
+		{
+			.path = dir_s4d1,
+			.access = LANDLOCK_ACCESS_FS_REFER |
+				  LANDLOCK_ACCESS_FS_MAKE_DIR |
+				  LANDLOCK_ACCESS_FS_REMOVE_DIR |
+				  LANDLOCK_ACCESS_FS_MAKE_REG |
+				  LANDLOCK_ACCESS_FS_REMOVE_FILE |
+				  LANDLOCK_ACCESS_FS_READ_FILE,
+		},
+		{}
+	};
+
+	const struct rule layer2_only_s1d2[] = {
+		{
+			.path = dir_s1d2,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE,
+		},
+		{},
+	};
+
+	ASSERT_EQ(0, mkdir(dir_s4d1, 0755))
+	{
+		TH_LOG("Failed to create %s: %s", dir_s4d1, strerror(errno));
+	}
+
+	int ruleset_fd = create_ruleset(_metadata, ACCESS_ALL, layer1);
+	int ruleset_fd_l2 = create_ruleset(
+		_metadata, LANDLOCK_ACCESS_FS_READ_FILE, layer2_only_s1d2);
+	pid_t child_pid;
+	int bind_s1d3_fd, status;
+
+	ASSERT_LE(0, ruleset_fd);
+	ASSERT_LE(0, ruleset_fd_l2);
+
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	bind_s1d3_fd = open(bind_dir_s1d3, O_PATH | O_CLOEXEC);
+	ASSERT_LE(0, bind_s1d3_fd);
+	ASSERT_EQ(0, test_open_rel(bind_s1d3_fd, file1_name, O_RDONLY));
+
+	ASSERT_EQ(0, rename(dir_s1d3, dir_s4d2))
+	{
+		TH_LOG("Failed to rename %s to %s: %s", dir_s1d3, dir_s4d2,
+		       strerror(errno));
+	}
+
+	/*
+	 * Since file is no longer under s1d2, we should not be able to access
+	 * it if we enforced layer 2.  Do a fork to test this so we don't
+	 * prevent ourselves from renaming it back later.
+	 */
+	child_pid = fork();
+	if (child_pid == 0) {
+		enforce_ruleset(_metadata, ruleset_fd_l2);
+		ASSERT_EQ(0, close(ruleset_fd_l2));
+		ASSERT_EQ(EACCES,
+			  test_open_rel(bind_s1d3_fd, file1_name, O_RDONLY));
+		ASSERT_EQ(EACCES, test_open(file1_s4d2, O_RDONLY));
+
+		/*
+		 * Test that access widening checks indeed prevents us from
+		 * renaming it back
+		 */
+		ASSERT_EQ(-1, rename(dir_s4d2, dir_s1d3));
+		ASSERT_EQ(EXDEV, errno);
+		/*
+		 * Including through the now disconnected fd (but it should return
+		 * EXDEV)
+		 */
+		ASSERT_EQ(-1, renameat(bind_s1d3_fd, file1_name, AT_FDCWD,
+				       file1_s2d2));
+		ASSERT_EQ(EXDEV, errno);
+		_exit(!__test_passed(_metadata));
+		return;
+	}
+
+	ASSERT_NE(-1, child_pid);
+	ASSERT_EQ(child_pid, waitpid(child_pid, &status, 0));
+	ASSERT_EQ(1, WIFEXITED(status));
+	ASSERT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
+
+	ASSERT_EQ(0, rename(dir_s4d2, dir_s1d3))
+	{
+		TH_LOG("Failed to rename %s back to %s: %s", dir_s4d1, dir_s1d3,
+		       strerror(errno));
+	}
+
+	/* Now check that we can access it under l2 */
+	child_pid = fork();
+	if (child_pid == 0) {
+		enforce_ruleset(_metadata, ruleset_fd_l2);
+		ASSERT_EQ(0, close(ruleset_fd_l2));
+		ASSERT_EQ(0, test_open_rel(bind_s1d3_fd, file1_name, O_RDONLY));
+		ASSERT_EQ(0, test_open(file1_s1d3, O_RDONLY));
+		_exit(!__test_passed(_metadata));
+		return;
+	}
+	ASSERT_NE(-1, child_pid);
+	ASSERT_EQ(child_pid, waitpid(child_pid, &status, 0));
+	ASSERT_EQ(1, WIFEXITED(status));
+	ASSERT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
+
+	/*
+	 * Also test that we can rename via a disconnected path.  We move the
+	 * dir back to the disconnected place first, then we rename file1 to
+	 * file2 through our dir fd.
+	 */
+	ASSERT_EQ(0, rename(dir_s1d3, dir_s4d2))
+	{
+		TH_LOG("Failed to rename %s to %s: %s", dir_s1d3, dir_s4d2,
+		       strerror(errno));
+	}
+	ASSERT_EQ(0,
+		  renameat(bind_s1d3_fd, file1_name, bind_s1d3_fd, file2_name))
+	{
+		TH_LOG("Failed to rename %s to %s through disconnected %s: %s",
+		       file1_name, file2_name, bind_dir_s1d3, strerror(errno));
+	}
+	ASSERT_EQ(0, test_open_rel(bind_s1d3_fd, file2_name, O_RDONLY));
+	ASSERT_EQ(0, renameat(bind_s1d3_fd, file2_name, AT_FDCWD, file1_s2d2))
+	{
+		TH_LOG("Failed to rename %s to %s through disconnected %s: %s",
+		       file2_name, file1_s2d2, bind_dir_s1d3, strerror(errno));
+	}
+	ASSERT_EQ(0, test_open(file1_s2d2, O_RDONLY));
+	ASSERT_EQ(0, test_open(file1_s1d2, O_RDONLY));
+
+	/* Move it back using the disconnected path as the target */
+	ASSERT_EQ(0, renameat(AT_FDCWD, file1_s2d2, bind_s1d3_fd, file1_name))
+	{
+		TH_LOG("Failed to rename %s to %s through disconnected %s: %s",
+		       file1_s1d2, file1_name, bind_dir_s1d3, strerror(errno));
+	}
+
+	/* Now make it connected again */
+	ASSERT_EQ(0, rename(dir_s4d2, dir_s1d3))
+	{
+		TH_LOG("Failed to rename %s back to %s: %s", dir_s4d2, dir_s1d3,
+		       strerror(errno));
+	}
+
+	/* Check again that we can access it under l2 */
+	enforce_ruleset(_metadata, ruleset_fd_l2);
+	ASSERT_EQ(0, close(ruleset_fd_l2));
+	ASSERT_EQ(0, test_open_rel(bind_s1d3_fd, file1_name, O_RDONLY));
+	ASSERT_EQ(0, test_open(file1_s1d3, O_RDONLY));
+}
+
 #define LOWER_BASE TMP_DIR "/lower"
 #define LOWER_DATA LOWER_BASE "/data"
 static const char lower_fl1[] = LOWER_DATA "/fl1";

base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
-- 
2.49.0


