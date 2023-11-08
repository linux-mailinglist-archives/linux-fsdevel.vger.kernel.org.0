Return-Path: <linux-fsdevel+bounces-2342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A06167E4DFF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 01:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3776B21361
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 00:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410131368;
	Wed,  8 Nov 2023 00:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="kaPTmLHD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ScEM7VnF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA1BEC2;
	Wed,  8 Nov 2023 00:28:06 +0000 (UTC)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43B410F9;
	Tue,  7 Nov 2023 16:28:05 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 3333C5C02D8;
	Tue,  7 Nov 2023 19:28:05 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 07 Nov 2023 19:28:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm2; t=1699403285; x=
	1699489685; bh=Q7C68g1l0YAovtw+myvue2kDtd3II7F9ffehR2Yn9uo=; b=k
	aPTmLHDlnOCl3eaplZufc3XBGP+2pywhKkhTKTl6x0QaSy99APuxSRMJtBEUQQ0D
	RoHOhCtix+KxTLPrqVHnH0NSfCebH6OCrzEGG4Gcj2TvcRoT9YrrZdQ5Yyi+EAsm
	LtOe9AymZFRuVEMUhtMBHyJAFia0lPDe3nJLkItolnZ6XkbpnNJW4R8T8uDwo/aa
	6xasAyqVWTi5UXmx2g2xVJfdCwCjIvYz7nS76/J67R2JmBBs9HyL5/VdM6E99Tp/
	oLOFluy5t+Gn9mlDrslZ/2cOXV3zFnDzH0iBdaj/2OtnfRBUY9FEmia5QQnh9rkZ
	FuwwKfKzt6AOVUJvYi97g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1699403285; x=
	1699489685; bh=Q7C68g1l0YAovtw+myvue2kDtd3II7F9ffehR2Yn9uo=; b=S
	cEM7VnFJL+rOkU/EDRjwwEZwZZ0XjQQClJ9Zn65M9SPSSueJI60LqK0a0Wx4d0sW
	Cep8qv9liYtxeBU4yTIR6H0oihvk8xWm8jkFjolmX3iy3Je2If/iOLgmvpQjvDkG
	CG4HRJvPjxE8/yAVqIJ9ATbAbkRjcPVA1WcRDkkJjeWVY1V+Gze4CNW+jClRXKmL
	8ETUcFWJL/QhsMaOko1g4x9qwQx04PMWjzjO0QytjC4LhDr4V79uVQyRAVdsYILa
	Vk1VLtvxkxQTZiirvTJ/yGnTuIU2xGLaa0Eo+EVuO1ViUE9EN/EKIi5s6h3LuK4y
	I+TAxxNOf49hB4F8jR4uw==
X-ME-Sender: <xms:FdZKZZmJkpjQIFPJ66ig-D_0n9FwnFpFh0azR5dJMVx0XXPeYAgPnA>
    <xme:FdZKZU0oBm0NQo0sZg8OK1IOPd0LpNzWzQn3qxl5KSQ37v45sJzHvKU9IzlwLM3Xr
    oZTSsgWyrDKckz50gk>
X-ME-Received: <xmr:FdZKZfquMNglX4PaToMKghIxBnhEGdIP1cnSlnYqFjNknj4EH9fz5tAa5A1n6MUIPTlxlw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddukedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhepvdegffehledvleejvdethffgieefveevhfeigefffffgheeguedtieek
    tdeigeeunecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomh
    epthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:FdZKZZmISik7vGaAPSi5NYk4csteIfDWhPhjQE16YMPM5No3twH-TQ>
    <xmx:FdZKZX1jxWKc0ZLj3JEjJptOclq3DfArzbAD_BmtC3wZcb-2EE5K7A>
    <xmx:FdZKZYtGkAOnySUf5KMINDiRpPv-3hJ2KqAPHLMonBpQcmB7qUtK7g>
    <xmx:FdZKZQJKsYZamshMtl2HF2VtZheu0XqlIdBnk4xQONZF57rwth2EYQ>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Nov 2023 19:28:03 -0500 (EST)
From: Tycho Andersen <tycho@tycho.pizza>
To: cgroups@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Haitao Huang <haitao.huang@linux.intel.com>,
	Kamalesh Babulal <kamalesh.babulal@oracle.com>,
	Tycho Andersen <tycho@tycho.pizza>,
	Tycho Andersen <tandersen@netflix.com>
Subject: [RFC 6/6] selftests/cgroup: add a test for misc cgroup
Date: Tue,  7 Nov 2023 17:26:47 -0700
Message-Id: <20231108002647.73784-7-tycho@tycho.pizza>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231108002647.73784-1-tycho@tycho.pizza>
References: <20231108002647.73784-1-tycho@tycho.pizza>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tycho Andersen <tandersen@netflix.com>

There's four tests here: a basic smoke test, and tests for clone/fork.
Ideally there'd be a test for the cancel_attach() path too.

Signed-off-by: Tycho Andersen <tandersen@netflix.com>
---
 tools/testing/selftests/cgroup/.gitignore  |   1 +
 tools/testing/selftests/cgroup/Makefile    |   2 +
 tools/testing/selftests/cgroup/test_misc.c | 385 +++++++++++++++++++++
 3 files changed, 388 insertions(+)

diff --git a/tools/testing/selftests/cgroup/.gitignore b/tools/testing/selftests/cgroup/.gitignore
index 2732e0b29271..7e57580ed363 100644
--- a/tools/testing/selftests/cgroup/.gitignore
+++ b/tools/testing/selftests/cgroup/.gitignore
@@ -9,3 +9,4 @@ test_cpuset
 test_zswap
 test_hugetlb_memcg
 wait_inotify
+test_misc
diff --git a/tools/testing/selftests/cgroup/Makefile b/tools/testing/selftests/cgroup/Makefile
index 00b441928909..2e5b72947134 100644
--- a/tools/testing/selftests/cgroup/Makefile
+++ b/tools/testing/selftests/cgroup/Makefile
@@ -15,6 +15,7 @@ TEST_GEN_PROGS += test_cpu
 TEST_GEN_PROGS += test_cpuset
 TEST_GEN_PROGS += test_zswap
 TEST_GEN_PROGS += test_hugetlb_memcg
+TEST_GEN_PROGS += test_misc
 
 LOCAL_HDRS += $(selfdir)/clone3/clone3_selftests.h $(selfdir)/pidfd/pidfd.h
 
@@ -29,3 +30,4 @@ $(OUTPUT)/test_cpu: cgroup_util.c
 $(OUTPUT)/test_cpuset: cgroup_util.c
 $(OUTPUT)/test_zswap: cgroup_util.c
 $(OUTPUT)/test_hugetlb_memcg: cgroup_util.c
+$(OUTPUT)/test_misc: cgroup_util.c
diff --git a/tools/testing/selftests/cgroup/test_misc.c b/tools/testing/selftests/cgroup/test_misc.c
new file mode 100644
index 000000000000..8f15d899ed4a
--- /dev/null
+++ b/tools/testing/selftests/cgroup/test_misc.c
@@ -0,0 +1,385 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <sys/socket.h>
+#include <limits.h>
+#include <string.h>
+#include <signal.h>
+#include <syscall.h>
+#include <sched.h>
+#include <sys/wait.h>
+
+#include "../kselftest.h"
+#include "cgroup_util.h"
+
+#define N 100
+
+static int open_N_fds(const char *cgroup, void *arg)
+{
+	int i;
+	long nofile;
+
+	for (i = 0; i < N; i++) {
+		int fd;
+
+		fd = socket(AF_UNIX, SOCK_SEQPACKET, 0);
+		if (fd < 0) {
+			ksft_print_msg("%d socket: %s\n", i, strerror(errno));
+			return 1;
+		}
+	}
+
+	/*
+	 * N+3 std fds + 1 fd for "misc.current"
+	 */
+	nofile = cg_read_key_long(cgroup, "misc.current", "nofile ");
+	if (nofile != N+3+1) {
+		ksft_print_msg("bad open files count: %ld\n", nofile);
+		return 1;
+	}
+
+	return 0;
+}
+
+static int test_misc_cg_basic(const char *root)
+{
+	int ret = KSFT_FAIL;
+	char *foo;
+
+	foo = cg_name(root, "foo");
+	if (!foo)
+		goto cleanup;
+
+	if (cg_create(foo)) {
+		perror("cg_create");
+		ksft_print_msg("cg_create failed\n");
+		goto cleanup;
+	}
+
+	if (cg_write(root, "cgroup.subtree_control", "+misc")) {
+		ksft_print_msg("cg_write failed\n");
+		goto cleanup;
+	}
+
+	ret = cg_run(foo, open_N_fds, NULL);
+	if (ret < 0) {
+		ksft_print_msg("cg_run failed\n");
+		goto cleanup;
+	}
+
+	if (ret == 0)
+		ret = KSFT_PASS;
+
+cleanup:
+	cg_destroy(foo);
+	free(foo);
+	return ret;
+}
+
+static int open_N_fds_and_sleep(const char *root, void *arg)
+{
+	int i, *sock = arg;
+
+	for (i = 0; i < N; i++) {
+		int fd;
+
+		fd = socket(AF_UNIX, SOCK_SEQPACKET, 0);
+		if (fd < 0) {
+			ksft_print_msg("%d socket: %s\n", i, strerror(errno));
+			return 1;
+		}
+	}
+
+	if (write(*sock, "c", 1) != 1) {
+		ksft_print_msg("%d write: %s\n", i, strerror(errno));
+		return 1;
+	}
+
+	while (1)
+		sleep(1000);
+}
+
+#define COPIES 5
+static int test_misc_cg_threads(const char *root)
+{
+	int ret = KSFT_FAIL, i;
+	char *foo;
+	int pids[COPIES] = {};
+	long nofile;
+
+	foo = cg_name(root, "foo");
+	if (!foo)
+		goto cleanup;
+
+	if (cg_create(foo)) {
+		ksft_print_msg("cg_create failed\n");
+		goto cleanup;
+	}
+
+	if (cg_write(root, "cgroup.subtree_control", "+misc")) {
+		ksft_print_msg("cg_write failed\n");
+		goto cleanup;
+	}
+
+	for (i = 0; i < COPIES; i++) {
+		char c;
+		int sk_pair[2];
+
+		if (socketpair(PF_LOCAL, SOCK_SEQPACKET, 0, sk_pair) < 0) {
+			ksft_print_msg("socketpair failed %s\n", strerror(errno));
+			goto cleanup;
+		}
+
+		pids[i] = cg_run_nowait(foo, open_N_fds_and_sleep, sk_pair+1);
+		if (pids[i] < 0) {
+			perror("cg_run_nowait");
+			ksft_print_msg("cg_run failed\n");
+			goto cleanup;
+		}
+		close(sk_pair[1]);
+
+		if (read(sk_pair[0], &c, 1) != 1) {
+			ksft_print_msg("%d read: %s\n", i, strerror(errno));
+			goto cleanup;
+		}
+		close(sk_pair[0]);
+	}
+
+	/*
+	 * We expect COPIES * (N + 3 stdfs + 2 socketpair fds).
+	 */
+	nofile = cg_read_key_long(foo, "misc.current", "nofile ");
+	if (nofile != COPIES*(N+3+2)) {
+		ksft_print_msg("bad open files count: %ld != %d\n", nofile, COPIES*(N+3+1));
+		goto cleanup;
+	}
+
+	ret = KSFT_PASS;
+cleanup:
+	for (i = 0; i < COPIES; i++) {
+		if (pids[i] >= 0) {
+			kill(pids[i], SIGKILL);
+			waitpid(pids[i], NULL, 0);
+		}
+	}
+	cg_destroy(foo);
+	free(foo);
+	return ret;
+}
+
+static int test_shared_files_count(const char *root)
+{
+	char *foo, c;
+	int dfd, ret = KSFT_FAIL, sk_pair[2];
+	pid_t pid;
+	long nofile;
+
+	if (socketpair(PF_LOCAL, SOCK_SEQPACKET, 0, sk_pair) < 0) {
+		ksft_print_msg("socketpair failed %s\n", strerror(errno));
+		return ret;
+	}
+
+	foo = cg_name(root, "foo");
+	if (!foo)
+		goto cleanup;
+
+	if (cg_write(root, "cgroup.subtree_control", "+misc")) {
+		ksft_print_msg("cg_write failed\n");
+		goto cleanup;
+	}
+
+	if (cg_create(foo)) {
+		ksft_print_msg("cg_create failed\n");
+		goto cleanup;
+	}
+
+	dfd = dirfd_open_opath(foo);
+	if (dfd < 0) {
+		perror("cgroup dir open");
+		goto cleanup;
+	}
+
+	pid = clone_into_cgroup(dfd, CLONE_FILES);
+	if (pid < 0) {
+		perror("clone");
+		goto cleanup;
+	}
+
+	if (pid == 0) {
+		close(sk_pair[0]);
+		exit(open_N_fds_and_sleep(foo, sk_pair+1));
+	}
+
+	errno = 0;
+	nofile = read(sk_pair[0], &c, 1);
+	if (nofile != 1) {
+		ksft_print_msg("read: %s\n", strerror(errno));
+		goto cleanup;
+	}
+	close(sk_pair[0]);
+
+	/*
+	 * We have two threads with a shared fd table, so the fds should be
+	 * counted only once.
+	 * We expect N + 3 stdfs + 2 socketpair fds.
+	 */
+	nofile = cg_read_key_long(foo, "misc.current", "nofile ");
+	if (nofile != (N+3+2)) {
+		ksft_print_msg("bad open files count: %ld != %d\n", nofile, N+3+1);
+		goto cleanup;
+	}
+
+	ret = KSFT_PASS;
+cleanup:
+	close(sk_pair[0]);
+	close(sk_pair[1]);
+	close(dfd);
+	kill(pid, SIGKILL);
+	waitpid(pid, NULL, 0);
+	cg_destroy(foo);
+	free(foo);
+	return ret;
+}
+
+static int test_misc_cg_threads_shared_files(const char *root)
+{
+	pid_t pid;
+	int status;
+
+	/*
+	 * get a fresh process to share fd tables so we don't pollute the test
+	 * suite's fd table in the case of failure.
+	 */
+	pid = fork();
+	if (pid < 0) {
+		perror("fork");
+		return KSFT_FAIL;
+	}
+
+	if (pid == 0)
+		exit(test_shared_files_count(root));
+
+	if (waitpid(pid, &status, 0) != pid) {
+		ksft_print_msg("wait failed\n");
+		return KSFT_FAIL;
+	}
+
+	if (!WIFEXITED(status)) {
+		ksft_print_msg("died with %x\n", status);
+		return KSFT_FAIL;
+	}
+
+	return WEXITSTATUS(status);
+}
+
+#define EXTRA 5
+static int open_more_than_N_fds(const char *cgroup, void *arg)
+{
+	int emfiles = 0, i;
+
+	for (i = 0; i < N+EXTRA; i++) {
+		int fd;
+
+		fd = socket(AF_UNIX, SOCK_SEQPACKET, 0);
+		if (fd < 0) {
+			if (errno != EMFILE) {
+				ksft_print_msg("%d socket: %s\n", i, strerror(errno));
+				return 1;
+			}
+
+			emfiles++;
+		}
+	}
+
+	/*
+	 * We have 3 existing stdfds open, plus the 100 that we tried to open,
+	 * plus the five extra.
+	 */
+	if (emfiles != EXTRA+3) {
+		ksft_print_msg("got %d EMFILEs\n", emfiles);
+		return 1;
+	}
+	return 0;
+}
+
+static int test_misc_cg_emfile_count(const char *root)
+{
+	int ret = KSFT_FAIL;
+	char *foo;
+	char nofile[128];
+	long nofile_events;
+
+	foo = cg_name(root, "foo");
+	if (!foo)
+		goto cleanup;
+
+	if (cg_create(foo)) {
+		ksft_print_msg("cg_create failed\n");
+		goto cleanup;
+	}
+
+	if (cg_write(root, "cgroup.subtree_control", "+misc")) {
+		ksft_print_msg("cg_write failed\n");
+		goto cleanup;
+	}
+
+	snprintf(nofile, sizeof(nofile), "nofile %d", N);
+	if (cg_write(foo, "misc.max", nofile)) {
+		ksft_print_msg("cg_write failed\n");
+		goto cleanup;
+	}
+
+	if (cg_run(foo, open_more_than_N_fds, NULL)) {
+		perror("cg_run");
+		ksft_print_msg("cg_run failed\n");
+		goto cleanup;
+	}
+
+	nofile_events = cg_read_key_long(foo, "misc.events", "nofile.max ");
+	if (nofile_events != EXTRA+3) {
+		ksft_print_msg("bad nofile events: %ld\n", nofile_events);
+		goto cleanup;
+	}
+
+	ret = KSFT_PASS;
+cleanup:
+	cg_destroy(foo);
+	free(foo);
+	return ret;
+}
+
+#define T(x) { x, #x }
+struct misccg_test {
+	int (*fn)(const char *root);
+	const char *name;
+} tests[] = {
+	T(test_misc_cg_basic),
+	T(test_misc_cg_threads),
+	T(test_misc_cg_threads_shared_files),
+	T(test_misc_cg_emfile_count),
+};
+#undef T
+
+int main(int argc, char *argv[])
+{
+	char root[PATH_MAX];
+	int i, ret = EXIT_SUCCESS;
+
+	if (cg_find_unified_root(root, sizeof(root)))
+		ksft_exit_skip("cgroup v2 isn't mounted\n");
+	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		switch (tests[i].fn(root)) {
+		case KSFT_PASS:
+			ksft_test_result_pass("%s\n", tests[i].name);
+			break;
+		case KSFT_SKIP:
+			ksft_test_result_skip("%s\n", tests[i].name);
+			break;
+		default:
+			ret = EXIT_FAILURE;
+			ksft_test_result_fail("%s\n", tests[i].name);
+			break;
+		}
+	}
+
+	return ret;
+}
-- 
2.34.1


