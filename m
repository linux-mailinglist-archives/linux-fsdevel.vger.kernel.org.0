Return-Path: <linux-fsdevel+bounces-57012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD750B1DCB8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 19:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85269A007DE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 17:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C982201004;
	Thu,  7 Aug 2025 17:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="ZVx+ttTg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07E2200BBC;
	Thu,  7 Aug 2025 17:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754589341; cv=none; b=TWbFjJuHUV1COYIy3au5ol9U2WkaZHdxw+m1nTcQx6Ed0GrxrX4aUFxvyqpsV5DIipbRb4+CVW3i0RGs9XnTlkFf8PfUdcnxRtgSoD2J3r7uH3k0qdOcyxJZ6Pg05FdxVCyf6wPpozXI8KCqaWNaezHVEAgPH6HbSJTJjrVk8Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754589341; c=relaxed/simple;
	bh=5SipIL2mqzjw8Lq0NGeJ5rC1D8r6xnD/6FPUKkhjv6c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hrZABSBwVzRrf0dp9YRlHhyuNp/Qqb/YTqarrZFh2kpjbBPyw0sqCR4EC3lzgMJXvyAFhLTRfwLe4QBexeq2dA0zfhiQVDmo2Gn+kVjjCtgURt6yzFVC0z60BCOrRPVsmDLMRCSqjujwit2IEvT0ANYP2PvWGgcqYES9eP+d8qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=ZVx+ttTg; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4byZZT1KVKz9tfQ;
	Thu,  7 Aug 2025 19:55:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1754589329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u1tGdj0bYIbktrA9nGNPQV29HAdkSKoqYz5zUeS8lIY=;
	b=ZVx+ttTgCC2wvM3YNPiaDoGGKLNuUQkh684NzSkrW0dQB58kAWvoTJd6IEZ29TjHt1xwim
	2A+jYaAKD3fTz1J88KquQQx1bErSq1LWnIXkKMX6nQE6qmN7DT3kPUNROfQ03pUuKI0xNX
	6ilWQGHpr9mTqplG9l3Oq8iP6DfQM8OZQ/jh3bN0G7IkXU3EPUdFTho/BgDuRZSRdhoGuo
	TRTSTFhPClWmIpQFk9D6hHfHj+JRJnHRH9jlT23yfl6voachoR5tyrQ/uDtfmawdg3Ds8k
	oZuDla+AQxvu/EjKskEZZ54oVxbogexfa4DgJGCXNmmWXqbVQUkEP7WBZOT2kQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Fri, 08 Aug 2025 03:55:06 +1000
Subject: [PATCH 2/2] selftests/mount_setattr: add smoke tests for
 open_tree_attr(2) bug
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-open_tree_attr-bugfix-idmap-v1-2-0ec7bc05646c@cyphar.com>
References: <20250808-open_tree_attr-bugfix-idmap-v1-0-0ec7bc05646c@cyphar.com>
In-Reply-To: <20250808-open_tree_attr-bugfix-idmap-v1-0-0ec7bc05646c@cyphar.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5342; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=5SipIL2mqzjw8Lq0NGeJ5rC1D8r6xnD/6FPUKkhjv6c=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWRMedHQ6HDUvlTz6mxFq8Q1dl/WW+W92xjQvMLsyvXkM
 +LpHybXdZSyMIhxMciKKbJs8/MM3TR/8ZXkTyvZYOawMoEMYeDiFICJ+K5i+O8W75S/+abnVS4V
 rgmrtC3b/vz8PXeWR+BsFl8DnUsvFe8x/NM84ryscxFPdcbm9js+TNw8Cl2yjI+K7J/Ya2w8ulL
 0IQ8A
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386
X-Rspamd-Queue-Id: 4byZZT1KVKz9tfQ

There appear to be no other open_tree_attr(2) tests at the moment, but
as a minimal solution just add some additional checks in the existing
MOUNT_ATTR_IDMAP tests to make sure that open_tree_attr(2) cannot be
used to bypass the tested restrictions that apply to mount_setattr(2).

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 .../selftests/mount_setattr/mount_setattr_test.c   | 77 ++++++++++++++++++----
 1 file changed, 64 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/mount_setattr/mount_setattr_test.c b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
index b1e4618399be..a688871a98eb 100644
--- a/tools/testing/selftests/mount_setattr/mount_setattr_test.c
+++ b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
@@ -107,6 +107,26 @@
 	#endif
 #endif
 
+#ifndef __NR_open_tree_attr
+	#if defined __alpha__
+		#define __NR_open_tree_attr 577
+	#elif defined _MIPS_SIM
+		#if _MIPS_SIM == _MIPS_SIM_ABI32	/* o32 */
+			#define __NR_open_tree_attr (467 + 4000)
+		#endif
+		#if _MIPS_SIM == _MIPS_SIM_NABI32	/* n32 */
+			#define __NR_open_tree_attr (467 + 6000)
+		#endif
+		#if _MIPS_SIM == _MIPS_SIM_ABI64	/* n64 */
+			#define __NR_open_tree_attr (467 + 5000)
+		#endif
+	#elif defined __ia64__
+		#define __NR_open_tree_attr (467 + 1024)
+	#else
+		#define __NR_open_tree_attr 467
+	#endif
+#endif
+
 #ifndef MOUNT_ATTR_IDMAP
 #define MOUNT_ATTR_IDMAP 0x00100000
 #endif
@@ -121,6 +141,12 @@ static inline int sys_mount_setattr(int dfd, const char *path, unsigned int flag
 	return syscall(__NR_mount_setattr, dfd, path, flags, attr, size);
 }
 
+static inline int sys_open_tree_attr(int dfd, const char *path, unsigned int flags,
+				     struct mount_attr *attr, size_t size)
+{
+	return syscall(__NR_open_tree_attr, dfd, path, flags, attr, size);
+}
+
 static ssize_t write_nointr(int fd, const void *buf, size_t count)
 {
 	ssize_t ret;
@@ -1222,6 +1248,12 @@ TEST_F(mount_setattr_idmapped, attached_mount_inside_current_mount_namespace)
 	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
 	ASSERT_GE(attr.userns_fd, 0);
 	ASSERT_NE(sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr)), 0);
+	/*
+	 * Make sure that open_tree_attr() without OPEN_TREE_CLONE is not a way
+	 * to bypass this mount_setattr() restriction.
+	 */
+	ASSERT_LT(sys_open_tree_attr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr)), 0);
+
 	ASSERT_EQ(close(attr.userns_fd), 0);
 	ASSERT_EQ(close(open_tree_fd), 0);
 }
@@ -1255,6 +1287,12 @@ TEST_F(mount_setattr_idmapped, attached_mount_outside_current_mount_namespace)
 	ASSERT_GE(attr.userns_fd, 0);
 	ASSERT_NE(sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr,
 				    sizeof(attr)), 0);
+	/*
+	 * Make sure that open_tree_attr() without OPEN_TREE_CLONE is not a way
+	 * to bypass this mount_setattr() restriction.
+	 */
+	ASSERT_LT(sys_open_tree_attr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr)), 0);
+
 	ASSERT_EQ(close(attr.userns_fd), 0);
 	ASSERT_EQ(close(open_tree_fd), 0);
 }
@@ -1321,6 +1359,19 @@ TEST_F(mount_setattr_idmapped, detached_mount_outside_current_mount_namespace)
 	ASSERT_EQ(close(open_tree_fd), 0);
 }
 
+static bool expected_uid_gid(int dfd, const char *path, int flags,
+			     uid_t expected_uid, gid_t expected_gid)
+{
+	int ret;
+	struct stat st;
+
+	ret = fstatat(dfd, path, &st, flags);
+	if (ret < 0)
+		return false;
+
+	return st.st_uid == expected_uid && st.st_gid == expected_gid;
+}
+
 /**
  * Validate that currently changing the idmapping of an idmapped mount fails.
  */
@@ -1331,6 +1382,8 @@ TEST_F(mount_setattr_idmapped, change_idmapping)
 		.attr_set = MOUNT_ATTR_IDMAP,
 	};
 
+	ASSERT_TRUE(expected_uid_gid(-EBADF, "/mnt/D", 0, 0, 0));
+
 	if (!mount_setattr_supported())
 		SKIP(return, "mount_setattr syscall not supported");
 
@@ -1348,27 +1401,25 @@ TEST_F(mount_setattr_idmapped, change_idmapping)
 				    AT_EMPTY_PATH, &attr, sizeof(attr)), 0);
 	ASSERT_EQ(close(attr.userns_fd), 0);
 
+	EXPECT_FALSE(expected_uid_gid(open_tree_fd, ".", 0, 0, 0));
+	EXPECT_TRUE(expected_uid_gid(open_tree_fd, ".", 0, 10000, 10000));
+
 	/* Change idmapping on a detached mount that is already idmapped. */
 	attr.userns_fd	= get_userns_fd(0, 20000, 10000);
 	ASSERT_GE(attr.userns_fd, 0);
 	ASSERT_NE(sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr)), 0);
+	/*
+	 * Make sure that open_tree_attr() without OPEN_TREE_CLONE is not a way
+	 * to bypass this mount_setattr() restriction.
+	 */
+	EXPECT_LT(sys_open_tree_attr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr)), 0);
+	EXPECT_FALSE(expected_uid_gid(open_tree_fd, ".", 0, 20000, 20000));
+	EXPECT_TRUE(expected_uid_gid(open_tree_fd, ".", 0, 10000, 10000));
+
 	ASSERT_EQ(close(attr.userns_fd), 0);
 	ASSERT_EQ(close(open_tree_fd), 0);
 }
 
-static bool expected_uid_gid(int dfd, const char *path, int flags,
-			     uid_t expected_uid, gid_t expected_gid)
-{
-	int ret;
-	struct stat st;
-
-	ret = fstatat(dfd, path, &st, flags);
-	if (ret < 0)
-		return false;
-
-	return st.st_uid == expected_uid && st.st_gid == expected_gid;
-}
-
 TEST_F(mount_setattr_idmapped, idmap_mount_tree_invalid)
 {
 	int open_tree_fd = -EBADF;

-- 
2.50.1


