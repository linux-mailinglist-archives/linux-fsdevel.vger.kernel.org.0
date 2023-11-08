Return-Path: <linux-fsdevel+bounces-2341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6FB7E4DFD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 01:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 509872814A4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 00:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE58111D;
	Wed,  8 Nov 2023 00:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="rrzAyJ0t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qk2Fxjl+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571AB634;
	Wed,  8 Nov 2023 00:28:04 +0000 (UTC)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FDD10F8;
	Tue,  7 Nov 2023 16:28:03 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 3D31B5C02CE;
	Tue,  7 Nov 2023 19:28:03 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 07 Nov 2023 19:28:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm2; t=1699403283; x=
	1699489683; bh=KgHW2t0uAGnDlmqiKupFGtWCbZUq9IWJHq2OXsFHtpM=; b=r
	rzAyJ0txDyyFwvn9UrzDatpfY6oUecPIrWLjoiyGym18qlS7gRPOIyV6nyghio6E
	adcAdaTR0+OaiKIdYrbDI59bjbZijurWN0aUdIaqwmYFf/3drbHIZ6aABuVYP4Ui
	rHE6heu5+L5CSE32AjltcZe3XDor6TCg9Or/g+jVgmBhW37qZQxhTGJOMCkddnxq
	Zr4Mfenpx1y6GINPwRG34IMF78/9g9nsEjM3GejafjF5xyGcXDRNdJ+YVRdzRuR/
	EEJedUia/85xcvh/bcoRo5xhpdMZeCXIWXkZ96jxBxGBdPCL2jltQBdr9TGC1lWD
	MenW6T66S98t/Udjp75Qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1699403283; x=
	1699489683; bh=KgHW2t0uAGnDlmqiKupFGtWCbZUq9IWJHq2OXsFHtpM=; b=q
	k2Fxjl+Np1aPNFjew9mlP73TCuHcly5879NWnsMW0zyIHwxK4if46nhBWF9OMkYF
	aV6xKPonys/Zu4AgjotPgUx69daXGG2vNMqG+imK9zLeNWYSLB2Nt96v/n59UEnI
	3GlOHjImHJyU/Svz9A9YWmxnstfsezegrhr1N6IizZN9R/4L0u7XddfiZ50zU5OW
	DqeiND1pJdz2d+LNN5zfF8BHEnPJP/4X9kpd7ohsLVwXr6wimqYLJ0LdBFlHQwba
	/esUKAYH4q4zlfzEpwgfR4ddrp9ST/kY1fgsIjlH0DExTU0nPPf2PCH6mbAKMnZ1
	PjsqmoUX3jju6DEebUV7g==
X-ME-Sender: <xms:E9ZKZchKx5E5gloh8BI2mDy1j_MKiOnynvVnfCcqQbJBTRswrjX08A>
    <xme:E9ZKZVCjYMekCeGR4LTsCled7i0trVG8U6Hk7dM8h1di1uq1P5jzuNsbmSJH22Oy-
    DVwTVW4tXe96q1nlCA>
X-ME-Received: <xmr:E9ZKZUHB_5vN37awjkG9gIOoJFW7Vc4TwBw_dPTxcz3VuSH4hJJiHlNATRyzrBZ45MZ-ng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddukedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhepvdegffehledvleejvdethffgieefveevhfeigefffffgheeguedtieek
    tdeigeeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:E9ZKZdQaVf4f9TnvGZcJvx-mv-egsQfq55ielkeoVcXCb6MH7vSSZQ>
    <xmx:E9ZKZZyoCpBY53uy9xgxlu7E_uUekP7ArieV5aV83vOWqy_ZLJ97SQ>
    <xmx:E9ZKZb6OvCDhU2-wg7J5oJiavkWY5L81Ffm_CmRyaiTma0MezvXRWg>
    <xmx:E9ZKZQl8lcR9WnJ5eOsv0NGisz1zTmaqOw08VCacEwyHEEFZZZs1yw>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Nov 2023 19:28:01 -0500 (EST)
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
Subject: [RFC 5/6] selftests/cgroup: add a flags arg to clone_into_cgroup()
Date: Tue,  7 Nov 2023 17:26:46 -0700
Message-Id: <20231108002647.73784-6-tycho@tycho.pizza>
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

We'll use this to test some extra scenarios in the nofile misc cg test
suite.

Signed-off-by: Tycho Andersen <tandersen@netflix.com>
---
 tools/testing/selftests/cgroup/cgroup_util.c | 8 ++++----
 tools/testing/selftests/cgroup/cgroup_util.h | 2 +-
 tools/testing/selftests/cgroup/test_core.c   | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
index 0340d4ca8f51..c65b9f41fdd2 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/cgroup_util.c
@@ -345,13 +345,13 @@ int cg_run(const char *cgroup,
 	}
 }
 
-pid_t clone_into_cgroup(int cgroup_fd)
+pid_t clone_into_cgroup(int cgroup_fd, unsigned long extra_flags)
 {
 #ifdef CLONE_ARGS_SIZE_VER2
 	pid_t pid;
 
 	struct __clone_args args = {
-		.flags = CLONE_INTO_CGROUP,
+		.flags = CLONE_INTO_CGROUP | extra_flags,
 		.exit_signal = SIGCHLD,
 		.cgroup = cgroup_fd,
 	};
@@ -429,7 +429,7 @@ static int clone_into_cgroup_run_nowait(const char *cgroup,
 	if (cgroup_fd < 0)
 		return -1;
 
-	pid = clone_into_cgroup(cgroup_fd);
+	pid = clone_into_cgroup(cgroup_fd, 0);
 	close_prot_errno(cgroup_fd);
 	if (pid == 0)
 		exit(fn(cgroup, arg));
@@ -588,7 +588,7 @@ int clone_into_cgroup_run_wait(const char *cgroup)
 	if (cgroup_fd < 0)
 		return -1;
 
-	pid = clone_into_cgroup(cgroup_fd);
+	pid = clone_into_cgroup(cgroup_fd, 0);
 	close_prot_errno(cgroup_fd);
 	if (pid < 0)
 		return -1;
diff --git a/tools/testing/selftests/cgroup/cgroup_util.h b/tools/testing/selftests/cgroup/cgroup_util.h
index 1df7f202214a..e2190202e8c3 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.h
+++ b/tools/testing/selftests/cgroup/cgroup_util.h
@@ -57,7 +57,7 @@ extern int cg_killall(const char *cgroup);
 int proc_mount_contains(const char *option);
 extern ssize_t proc_read_text(int pid, bool thread, const char *item, char *buf, size_t size);
 extern int proc_read_strstr(int pid, bool thread, const char *item, const char *needle);
-extern pid_t clone_into_cgroup(int cgroup_fd);
+extern pid_t clone_into_cgroup(int cgroup_fd, unsigned long extra_flags);
 extern int clone_reap(pid_t pid, int options);
 extern int clone_into_cgroup_run_wait(const char *cgroup);
 extern int dirfd_open_opath(const char *dir);
diff --git a/tools/testing/selftests/cgroup/test_core.c b/tools/testing/selftests/cgroup/test_core.c
index 80aa6b2373b9..1b2ec7b6825c 100644
--- a/tools/testing/selftests/cgroup/test_core.c
+++ b/tools/testing/selftests/cgroup/test_core.c
@@ -201,7 +201,7 @@ static int test_cgcore_populated(const char *root)
 	if (cgroup_fd < 0)
 		goto cleanup;
 
-	pid = clone_into_cgroup(cgroup_fd);
+	pid = clone_into_cgroup(cgroup_fd, 0);
 	if (pid < 0) {
 		if (errno == ENOSYS)
 			goto cleanup_pass;
@@ -233,7 +233,7 @@ static int test_cgcore_populated(const char *root)
 		cg_test_d = NULL;
 	}
 
-	pid = clone_into_cgroup(cgroup_fd);
+	pid = clone_into_cgroup(cgroup_fd, 0);
 	if (pid < 0)
 		goto cleanup_pass;
 	if (pid == 0)
-- 
2.34.1


