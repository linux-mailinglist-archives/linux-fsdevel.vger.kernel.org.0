Return-Path: <linux-fsdevel+bounces-50547-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 246EFACD10A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 02:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E3B03A8348
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 00:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78371F94A;
	Wed,  4 Jun 2025 00:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="WfdG1BKU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X/2WfZSZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFC9372;
	Wed,  4 Jun 2025 00:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748998073; cv=none; b=BF+vp0CZ3/NIjRh3mmqQJKvmUIs+RoTWtmV2M+WxmRHHSV1LPOXRDhRSwGo0A/wkySmg3SApPHs/8ZclAYXTlOrpMEFrGUbdHLdhlx9cBEmNDaLEef6pFQyicl/C2/czrG8scpAbEvsG21r6H2qNVGoMgQmNClJDpBWxTEdGUq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748998073; c=relaxed/simple;
	bh=Q/uZdRqdSXjiRy3ls5znYy052LTsrGq30hjsehbfNG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AiZIusLxrmuMfPuaYPfWpYY0axMdcGBM4+cnuNrHOtKj/hkJt1MJEpWmFnXTmRkYTxHP5UocaP3xmQUCtOZKrRccCzkNHvJ46qZQByDyxRCv5spss0gndvDhJaq8IQytnaUX1MnTsUkuKw6w9dWc+s/Etcn9MITG1pkQp9Thb1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=WfdG1BKU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X/2WfZSZ; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CE25C2540119;
	Tue,  3 Jun 2025 20:47:49 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 03 Jun 2025 20:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748998069;
	 x=1749084469; bh=j9yHfjksmHhWCn+9SPAdMY1vmYg2tsXxgLM1z5n+K5Y=; b=
	WfdG1BKUPFotUcUHVrSVCrLYNuQWU5Y54WEb97Is8hF6GPHrvljSHMYdRXSNo+mV
	8baky/odKyaJhibxjex7SOBRKuVaz7hHv6DPoDlW5qsjFvggyjYaQZhmbWUY4T6t
	XUWlLUfiwMg49BnP6PWwVymKBrW8OVkKr/eiBnSIgDzZYGl6//B+JMrst+AB5RH4
	qW9713Ylj4zv5wciUnouyz1+LtSanv9XVTKdmbWG3838vESKNObIIYUulo3Semc1
	2seFS0CkelmQLjk4FutXZvcOxt1RjBXEUKg22ZzWsd6S1WHl897gs2LXxIlVj6wt
	sMvuFuM2xW8E9FMEjRXFVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748998069; x=
	1749084469; bh=j9yHfjksmHhWCn+9SPAdMY1vmYg2tsXxgLM1z5n+K5Y=; b=X
	/2WfZSZxs+GvuUAj2fQvv/TC7EPojupdhI8LTMlBPQ5+D77NORPPPoyHAMHgZHZs
	NLtyp83D3ILNFc2HafLXCNhEMIAnSyLmMaf2ztdzFok+POQyPrA+/5+udXcDND83
	Dv1R/SHDLoSb23HFUTrjzezZuevymAN9nOgH+gJnMgr6iUQnn/9Kr49MEZrev0MC
	hf5B/BG329Z6y1+GzAuc/G96OlgUNf35j7/biWuT4O9p+t6zgK95o3PS3lHemJEB
	2t53oNuVEswXeIl/Hi38DmU95umpp/LcxgnCFxSKf5lBL/UzLJtSHj+gY2lkiBYu
	FAGhU/30FyIO5dKsO55YA==
X-ME-Sender: <xms:tZc_aN0LYFDQoJaPfdnPCI5oO_gmMfOPU4SevllPtJWTlYMVS9gGtQ>
    <xme:tZc_aEG3P2EbEtkb0GubfrnUIymSU7tbH4YrcthY-t2UdJSyLnXyT4pSrQV6WpnUA
    I_4fEugTLO9c2Zqw_4>
X-ME-Received: <xmr:tZc_aN7EEexSFMIRQbTUUIIYNY4DRFwr-P1TMKnyu_0OjHUBSSPsOaqeBNjjXK40saH0OrceaoJ0GxuvGwyJZAwvAMjYLb4MbDtrAbvzqExREyvNJPtcyw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddufeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdej
    necuhfhrohhmpefvihhnghhmrghoucghrghnghcuoehmsehmrghofihtmhdrohhrgheqne
    cuggftrfgrthhtvghrnhepieeigeeghedtffeifffhkeeuffehhfevuefgvdekjeekhedv
    tedtgfdvgefhudejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepmhesmhgrohifthhmrdhorhhgpdhnsggprhgtphhtthhopedutddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepmhhitgesughighhikhhougdrnhgvthdprhgtph
    htthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhhirhhoseiivghn
    ihhvrdhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehmsehmrghofihtmhdrohhrgh
    dprhgtphhtthhopehgnhhorggtkhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhgr
    tghksehsuhhsvgdrtgiipdhrtghpthhtoheprghlvgigvghirdhsthgrrhhovhhoihhtoh
    hvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhhinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:tZc_aK2y-7_3VBV9JPxVZ4x_ue-8JmFWRuqud__PipK11PeZChLIgQ>
    <xmx:tZc_aAFGctoufd4OpG4LvTtrmoRF5sOXz6qSlX6viNld0e6zu5KzzA>
    <xmx:tZc_aL9QX5WTHw0mjV9gylqyah8pTshbqTavejI7o75-mN8DY7FthA>
    <xmx:tZc_aNmM0sAnE0dKG-Qb_Xn_IxvsuKyKSaVwC_XV39q6B5TtJauDwA>
    <xmx:tZc_aNyJpYv-tE8m1kUoI-1yEQdsdfiJd_Q26n4gRV-efYFqJwNOUyZJ>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 20:47:47 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Song Liu <song@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jan Kara <jack@suse.cz>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 2/3] selftests/landlock: Add fs_race_test
Date: Wed,  4 Jun 2025 01:45:44 +0100
Message-ID: <5eedc31f8752e8f1251ea725f28931ae8f52a564.1748997840.git.m@maowtm.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1748997840.git.m@maowtm.org>
References: <cover.1748997840.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

By not taking references to parent directories when walking, the dentry
can become negative under us, if the target file is moved then the parent
quickly deleted.  This is problematic because it means that we lose access
to any landlock rules attached to that parent, and thus we won't be able
to grant the correct access even when we're allowed to pretend the move
hasn't happened yet.

This commit tests a slightly more complicated scenario, where after moving
the file's parent directory away, the next two intermediate directories
are quickly removed.  This demonstrates that in this situation the only
choice for Landlock is to restart the walk.  Without doing that, even if
we were to re-check d_parent, if we were "cut off" when we've already
walked away from the original leaf, we would still not be able to recover.

As an illustration:

mkdir /d1 /d1/d2 /b
create landlock rule on /d1
create landlock rule on /b
touch /d1/d2/file

thread 1                              thread 2
                                      cd /d1/d2
                                      cat file
                                        landlock walks to /d1/d2 without ref,
                                        checked rule on /d1/d2 (nothing),
                                        about to walk up to /d1
mv /d1/d2/file /b
rmdir /d1/d2 /d1
(/d1/d2 and /d1 both becomes negative)
                                        notices stuff changed
                                        at this point, we're looking at /d1/d2
                                        and trying to walk to its parent.
                                        however, both /d1/d2 and /d1 are negative
                                        now.
                                        Our only choice is to restart the walk
                                        altogether from the original file's dentry,
                                        which will now have d_parent /b.

The test is probablistic as it tests for a race condition, but I found
that in my environment, with the previous patch, it pretty much always
reliably fails within 10 seconds.  I've set the timeout to 30 seconds, and
the test will pass if no permission errors (or other errors) detected.  In
those 30 seconds it will keep recreating the above directory structure
(except with a lot more sibling directories so it can run for some time
before it "exhausts" all the directories and has to recreate the whole
thing).

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 .../testing/selftests/landlock/fs_race_test.c | 505 ++++++++++++++++++
 1 file changed, 505 insertions(+)
 create mode 100644 tools/testing/selftests/landlock/fs_race_test.c

diff --git a/tools/testing/selftests/landlock/fs_race_test.c b/tools/testing/selftests/landlock/fs_race_test.c
new file mode 100644
index 000000000000..16a70ff90532
--- /dev/null
+++ b/tools/testing/selftests/landlock/fs_race_test.c
@@ -0,0 +1,505 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Landlock tests - Pathwalk race conditions
+ *
+ * Copyright © 2025 Tingmao Wang <m@maowtm.org>
+ */
+
+#define _GNU_SOURCE
+#include <unistd.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <time.h>
+#include <linux/fs.h>
+#include <linux/mount.h>
+
+#include "common.h"
+
+#define NUM_SUBDIRS 1000
+#define TEST_DIR TMP_DIR "/fs_race_test"
+#define SUBDIR_NAME_FORMAT "s%dd1"
+#define SUBDIR2_NAME_FORMAT "s%dd2"
+#define SUBDIR3_NAME "d3"
+#define TEST_FILE_NAME "file"
+#define TEST_TIME 30
+#define RANDOM_DELAY_AFTER_MOVE false
+
+/* layout hierarchy:
+ * tmp
+ * └── fs_race_test
+ *     ├── s0d1
+ *     │   └── s0d2
+ *     │       └── d3
+ *     │           └── file
+ *     |── s1d1
+ *     │   └── s1d2
+ *     └── ...
+ */
+
+FIXTURE(layout)
+{
+	int base_dir_fd;
+	bool need_subdir_cleanup;
+	int subdir_fds[NUM_SUBDIRS];
+	int subdir2_fds[NUM_SUBDIRS];
+	int subdir3_fd;
+	int subdir3_at;
+	int ruleset_fd;
+};
+
+static void create_subdirs(struct __test_metadata *const _metadata,
+			   struct _test_data_layout *const self)
+{
+	int i, err;
+	char subdir[20], subdir2[20];
+
+	for (i = 0; i < NUM_SUBDIRS; i++) {
+		snprintf(subdir, sizeof(subdir), SUBDIR_NAME_FORMAT, i);
+		err = mkdirat(self->base_dir_fd, subdir, 0755);
+
+		ASSERT_TRUE(err == 0 || errno == EEXIST)
+		{
+			TH_LOG("Failed to create " TEST_DIR "/%s: %s", subdir,
+			       strerror(errno));
+		}
+		self->subdir_fds[i] = openat(self->base_dir_fd, subdir, O_PATH);
+		ASSERT_NE(self->subdir_fds[i], -1)
+		{
+			TH_LOG("Failed to open " TEST_DIR "/%s: %s", subdir,
+			       strerror(errno));
+		}
+
+		snprintf(subdir2, sizeof(subdir2), SUBDIR2_NAME_FORMAT, i);
+		err = mkdirat(self->subdir_fds[i], subdir2, 0755);
+		ASSERT_TRUE(err == 0 || errno == EEXIST)
+		{
+			TH_LOG("Failed to create " TEST_DIR "/%s/%s: %s",
+			       subdir, subdir2, strerror(errno));
+		}
+		self->subdir2_fds[i] =
+			openat(self->subdir_fds[i], subdir2, O_PATH);
+		ASSERT_NE(self->subdir2_fds[i], -1)
+		{
+			TH_LOG("Failed to open " TEST_DIR "/%s/%s: %s", subdir,
+			       subdir2, strerror(errno));
+		}
+	}
+
+	self->subdir3_at = 0;
+	err = mkdirat(self->subdir2_fds[self->subdir3_at], SUBDIR3_NAME, 0755);
+	ASSERT_TRUE(err == 0)
+	{
+		TH_LOG("Failed to create " TEST_DIR "/" SUBDIR_NAME_FORMAT
+		       "/" SUBDIR2_NAME_FORMAT "/" SUBDIR3_NAME ": %s",
+		       self->subdir3_at, self->subdir3_at, strerror(errno));
+	}
+	self->subdir3_fd = openat(self->subdir2_fds[self->subdir3_at],
+				  SUBDIR3_NAME, O_PATH);
+	ASSERT_NE(self->subdir3_fd, -1)
+	{
+		TH_LOG("Failed to open " TEST_DIR "/" SUBDIR_NAME_FORMAT
+		       "/" SUBDIR2_NAME_FORMAT "/" SUBDIR3_NAME ": %s",
+		       self->subdir3_at, self->subdir3_at, strerror(errno));
+	}
+
+	self->need_subdir_cleanup = true;
+}
+
+static void cleanup_subdirs(struct __test_metadata *const _metadata,
+			    struct _test_data_layout *const self)
+{
+	int i, err;
+	char subdir[20], subdir2[20];
+
+	if (!self->need_subdir_cleanup)
+		return;
+
+	self->need_subdir_cleanup = false;
+
+	if (self->subdir3_fd != -1) {
+		err = unlinkat(self->subdir3_fd, TEST_FILE_NAME, 0);
+		ASSERT_TRUE(err == 0 || errno == ENOENT)
+		{
+			TH_LOG("Failed to remove " TEST_DIR
+			       "/" SUBDIR_NAME_FORMAT "/" SUBDIR2_NAME_FORMAT
+			       "/" SUBDIR3_NAME "/" TEST_FILE_NAME ": %s",
+			       self->subdir3_at, self->subdir3_at,
+			       strerror(errno));
+		}
+		close(self->subdir3_fd);
+		self->subdir3_fd = -1;
+
+		err = unlinkat(self->subdir2_fds[self->subdir3_at],
+			       SUBDIR3_NAME, AT_REMOVEDIR);
+		ASSERT_TRUE(err == 0 || errno == ENOENT)
+		{
+			TH_LOG("Failed to remove " TEST_DIR
+			       "/" SUBDIR_NAME_FORMAT "/" SUBDIR2_NAME_FORMAT
+			       "/" SUBDIR3_NAME ": %s",
+			       self->subdir3_at, self->subdir3_at,
+			       strerror(errno));
+		}
+		self->subdir3_at = -1;
+	}
+
+	for (i = 0; i < NUM_SUBDIRS; i++) {
+		if (self->subdir2_fds[i] != -1) {
+			close(self->subdir2_fds[i]);
+			self->subdir2_fds[i] = -1;
+
+			snprintf(subdir2, sizeof(subdir2), SUBDIR2_NAME_FORMAT,
+				 i);
+			err = unlinkat(self->subdir_fds[i], subdir2,
+				       AT_REMOVEDIR);
+			ASSERT_TRUE(err == 0 || errno == ENOENT)
+			{
+				TH_LOG("Failed to remove " TEST_DIR
+				       "/" SUBDIR_NAME_FORMAT "/%s: %s",
+				       i, subdir2, strerror(errno));
+			}
+		}
+
+		if (self->subdir_fds[i] == -1)
+			continue;
+
+		close(self->subdir_fds[i]);
+		self->subdir_fds[i] = -1;
+
+		snprintf(subdir, sizeof(subdir), SUBDIR_NAME_FORMAT, i);
+		err = unlinkat(self->base_dir_fd, subdir, AT_REMOVEDIR);
+		ASSERT_TRUE(err == 0 || errno == ENOENT)
+		{
+			TH_LOG("Failed to remove " TEST_DIR "/%s: %s", subdir,
+			       strerror(errno));
+		}
+	}
+}
+
+static void create_test_dir(struct __test_metadata *const _metadata,
+			    struct _test_data_layout *const self)
+{
+	int err;
+
+	err = mkdir(TMP_DIR, 0755);
+	ASSERT_TRUE(err == 0 || errno == EEXIST)
+	{
+		TH_LOG("Failed to create ./" TMP_DIR ": %s", strerror(errno));
+		return;
+	}
+
+	err = mkdir(TEST_DIR, 0755);
+	ASSERT_TRUE(err == 0 || errno == EEXIST)
+	{
+		TH_LOG("Failed to create " TEST_DIR ": %s", strerror(errno));
+		return;
+	}
+
+	self->base_dir_fd = open(TEST_DIR, O_PATH);
+	ASSERT_NE(self->base_dir_fd, -1)
+	{
+		TH_LOG("Failed to open " TEST_DIR ": %s", strerror(errno));
+		return;
+	}
+}
+
+static void cleanup_test_dir(struct __test_metadata *const _metadata,
+			     struct _test_data_layout *const self)
+{
+	int err;
+
+	close(self->base_dir_fd);
+	err = rmdir(TEST_DIR);
+	ASSERT_EQ(0, err)
+	{
+		TH_LOG("Failed to remove " TEST_DIR ": %s", strerror(errno));
+	}
+	err = rmdir(TMP_DIR);
+	ASSERT_EQ(0, err)
+	{
+		TH_LOG("Failed to remove ./" TMP_DIR ": %s", strerror(errno));
+	}
+}
+
+static void create_test_file(struct __test_metadata *const _metadata,
+			     struct _test_data_layout *const self)
+{
+	int dfd;
+	int fd;
+
+	ASSERT_NE(-1, self->subdir3_at);
+	dfd = self->subdir3_fd;
+	ASSERT_NE(-1, dfd);
+
+	fd = openat(dfd, TEST_FILE_NAME, O_CREAT | O_RDWR, 0644);
+	ASSERT_NE(-1, fd)
+	{
+		TH_LOG("Failed to create " TEST_DIR "/" SUBDIR_NAME_FORMAT
+		       "/" SUBDIR2_NAME_FORMAT "/" SUBDIR3_NAME
+		       "/" TEST_FILE_NAME ": %s",
+		       self->subdir3_at, self->subdir3_at, strerror(errno));
+		return;
+	}
+	close(fd);
+}
+
+struct shared_region {
+	bool stop;
+};
+
+static void move_subdir3_and_rmdir(struct __test_metadata *const _metadata,
+				   struct _test_data_layout *const self, int to)
+{
+	int from, to_fd, err;
+	char pathbuf1[255], pathbuf2[255], pathbuf3[255], pathbuf4[255];
+
+	ASSERT_NE(to, self->subdir3_at);
+
+	from = self->subdir3_at;
+	ASSERT_NE(-1, from);
+	to_fd = self->subdir2_fds[to];
+	ASSERT_NE(-1, to_fd);
+
+	snprintf(pathbuf1, sizeof(pathbuf1), SUBDIR_NAME_FORMAT, from);
+	snprintf(pathbuf2, sizeof(pathbuf2),
+		 SUBDIR_NAME_FORMAT "/" SUBDIR2_NAME_FORMAT, from, from);
+	snprintf(pathbuf3, sizeof(pathbuf3),
+		 SUBDIR_NAME_FORMAT "/" SUBDIR2_NAME_FORMAT "/" SUBDIR3_NAME,
+		 from, from);
+	snprintf(pathbuf4, sizeof(pathbuf4),
+		 SUBDIR_NAME_FORMAT "/" SUBDIR2_NAME_FORMAT "/" SUBDIR3_NAME,
+		 to, to);
+
+	close(self->subdir2_fds[from]);
+	close(self->subdir_fds[from]);
+
+	/*
+	 * rename and the 2 following unlinkat must be executed as close as
+	 * possible
+	 */
+
+	err = renameat(self->base_dir_fd, pathbuf3, self->base_dir_fd,
+		       pathbuf4);
+	ASSERT_EQ(0, err)
+	{
+		TH_LOG("Failed to move " SUBDIR3_NAME
+		       " from " SUBDIR_NAME_FORMAT "/" SUBDIR2_NAME_FORMAT
+		       " to " SUBDIR_NAME_FORMAT "/" SUBDIR2_NAME_FORMAT ": %s",
+		       from, from, to, to, strerror(errno));
+	}
+
+	err = unlinkat(self->base_dir_fd, pathbuf2, AT_REMOVEDIR);
+	ASSERT_NE(-1, err)
+	{
+		TH_LOG("Failed to remove %s: %s", pathbuf2, strerror(errno));
+	}
+
+	err = unlinkat(self->base_dir_fd, pathbuf1, AT_REMOVEDIR);
+	ASSERT_NE(-1, err)
+	{
+		TH_LOG("Failed to remove " TEST_DIR "/%s: %s", pathbuf1,
+		       strerror(errno));
+	}
+
+	self->subdir_fds[from] = -1;
+	self->subdir2_fds[from] = -1;
+	self->subdir3_at = to;
+}
+
+static void create_ruleset(struct __test_metadata *const _metadata,
+			   struct _test_data_layout *const self)
+{
+	struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE |
+				     LANDLOCK_ACCESS_FS_READ_DIR |
+				     LANDLOCK_ACCESS_FS_WRITE_FILE |
+				     LANDLOCK_ACCESS_FS_REMOVE_FILE |
+				     LANDLOCK_ACCESS_FS_MAKE_REG |
+				     LANDLOCK_ACCESS_FS_MAKE_DIR |
+				     LANDLOCK_ACCESS_FS_REMOVE_DIR |
+				     LANDLOCK_ACCESS_FS_REFER,
+		.handled_access_net = 0,
+		.scoped = 0,
+	};
+	struct landlock_path_beneath_attr rule_attr = {
+		.parent_fd = -1,
+		.allowed_access = LANDLOCK_ACCESS_FS_READ_FILE |
+				  LANDLOCK_ACCESS_FS_READ_DIR,
+	};
+	int ruleset_fd, err, dfd;
+
+	ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	ASSERT_GE(ruleset_fd, 0)
+	{
+		TH_LOG("Failed to create ruleset: %s", strerror(errno));
+	}
+
+	for (int i = 0; i < NUM_SUBDIRS; i++) {
+		/* We want the rule to be on s*d1 */
+		dfd = self->subdir_fds[i];
+		ASSERT_NE(-1, dfd);
+		rule_attr.parent_fd = dfd;
+		err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+					&rule_attr, 0);
+		ASSERT_EQ(0, err)
+		{
+			TH_LOG("Failed to add rule for " TEST_DIR
+			       "/" SUBDIR_NAME_FORMAT ": %s",
+			       i, strerror(errno));
+		}
+	}
+
+	self->ruleset_fd = ruleset_fd;
+}
+
+static int child_restrict_self(int ruleset_fd)
+{
+	int err, n;
+	char errstr[512];
+
+	err = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	if (err != 0) {
+		err = errno;
+		n = snprintf(errstr, sizeof(errstr),
+			     "child process prctl(PR_SET_NO_NEW_PRIVS): %s\n",
+			     strerror(err));
+		write(STDERR_FILENO, errstr, n + 1);
+		return err;
+	}
+
+	err = landlock_restrict_self(ruleset_fd, 0);
+	if (err != 0) {
+		err = errno;
+		n = snprintf(errstr, sizeof(errstr),
+			     "child process landlock_restrict_self: %s\n",
+			     strerror(err));
+		write(STDERR_FILENO, errstr, n + 1);
+		return err;
+	}
+
+	return 0;
+}
+
+static int child_process(int subdir3_fd, int ruleset_fd,
+			 volatile bool *stop_sign)
+{
+	int err;
+
+	err = child_restrict_self(ruleset_fd);
+	if (err != 0)
+		return err;
+
+	while (!*stop_sign) {
+		err = openat(subdir3_fd, TEST_FILE_NAME, O_RDONLY);
+		char errstr[512];
+		int n;
+
+		if (err < 0) {
+			err = errno;
+			n = snprintf(errstr, sizeof(errstr),
+				     "openat(%d -> " SUBDIR3_NAME
+				     ", " TEST_FILE_NAME "): %s\n",
+				     subdir3_fd, strerror(err));
+			write(STDERR_FILENO, errstr, n + 1);
+			return err;
+		}
+		close(err);
+	}
+	return 0;
+}
+
+static void do_test(struct __test_metadata *const _metadata,
+		    struct _test_data_layout *const self)
+{
+	struct shared_region *shr;
+	int child_pid, status, err;
+
+	create_test_file(_metadata, self);
+
+	ASSERT_LE(sizeof(struct shared_region), 4096);
+	shr = mmap(NULL, 4096, PROT_READ | PROT_WRITE,
+		   MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	ASSERT_NE(shr, MAP_FAILED)
+	{
+		TH_LOG("Failed to create shared memory region with mmap: %s",
+		       strerror(errno));
+		return;
+	}
+
+	*(volatile bool *)(&shr->stop) = false;
+
+	child_pid = fork();
+	if (child_pid == 0) {
+		for (int i = 0; i < NUM_SUBDIRS; i++) {
+			if (self->subdir_fds[i] != -1)
+				close(self->subdir_fds[i]);
+			if (self->subdir2_fds[i] != -1)
+				close(self->subdir2_fds[i]);
+		}
+		close(self->base_dir_fd);
+		exit(child_process(self->subdir3_fd, self->ruleset_fd,
+				    &shr->stop));
+		return;
+	}
+
+	ASSERT_NE(-1, child_pid)
+	{
+		TH_LOG("Failed to fork child process: %s", strerror(errno));
+	}
+
+	close(self->ruleset_fd);
+	self->ruleset_fd = -1;
+
+	for (int i = 1; i < NUM_SUBDIRS; i++) {
+		move_subdir3_and_rmdir(_metadata, self, i);
+		if (RANDOM_DELAY_AFTER_MOVE) {
+			struct timespec ts = { .tv_sec = 0,
+					       .tv_nsec = rand() % 400001 };
+			nanosleep(&ts, NULL);
+		}
+	}
+
+	*(volatile bool *)(&shr->stop) = true;
+	err = waitpid(child_pid, &status, 0);
+	ASSERT_NE(-1, err)
+	{
+		TH_LOG("Failed to wait for child process: %s", strerror(errno));
+	}
+	ASSERT_EQ(child_pid, err);
+	status = WEXITSTATUS(status);
+	ASSERT_EQ(0, status)
+	{
+		TH_LOG("Child process terminated with exit code %d", status);
+	}
+}
+
+FIXTURE_SETUP(layout)
+{
+	create_test_dir(_metadata, self);
+	self->subdir3_at = -1;
+	self->subdir3_fd = -1;
+	self->ruleset_fd = -1;
+	for (int i = 0; i < NUM_SUBDIRS; i++) {
+		self->subdir_fds[i] = -1;
+		self->subdir2_fds[i] = -1;
+	}
+};
+
+FIXTURE_TEARDOWN(layout)
+{
+	cleanup_test_dir(_metadata, self);
+}
+
+TEST_F_TIMEOUT(layout, pathwalk_race_test, TEST_TIME + 10)
+{
+	int start_time = time(NULL);
+
+	while (time(NULL) - start_time < TEST_TIME) {
+		create_subdirs(_metadata, self);
+		create_ruleset(_metadata, self);
+		do_test(_metadata, self);
+		cleanup_subdirs(_metadata, self);
+	}
+}
+
+TEST_HARNESS_MAIN
-- 
2.49.0


