Return-Path: <linux-fsdevel+bounces-43025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D05EFA4D0AF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 02:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1213189130B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 01:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8531D757F3;
	Tue,  4 Mar 2025 01:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="afwZJpm8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e1URqcV4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7853833D8;
	Tue,  4 Mar 2025 01:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741051328; cv=none; b=lTCATuOj/sVLz7BvnYPu32MILf68MkxKMX3g8ocxJH7FptN0KAdeHK9IMRBHP5JYBgb3gMFdrDiEgZPXScjDZOvOc8PSR0Rs9u+qVXqMnIZm2sPkbShi31OWEIsc2JKISVvaO98lI/bX/5GcdMJDqO0TxHPRjWEa3UaEyOfpj3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741051328; c=relaxed/simple;
	bh=p4vlPwxauIVTbVuwo1A6jAImfwXTgdK+AuGw9IdBHMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ogDbr02P9qUujPO73JRaMZXlpd5iS7FfBHarF1/2vc9Rq+7B+2IRXnCz7t4cPs5ndQiMyMN2uf2F6lYIK+4Y3VgT5ZLz345TvgtqZ0Z7tkzRZU6edpfiE8182tnlq/UahG1fyHZePeYmQsU0QUw3VWdcqfkvue9S/30w2+gpMj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=afwZJpm8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e1URqcV4; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailflow.stl.internal (Postfix) with ESMTP id 6D0C51D415DD;
	Mon,  3 Mar 2025 20:22:05 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 03 Mar 2025 20:22:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1741051325; x=
	1741054925; bh=4wieLldKDZRs2aSCi2od3P1sUduKlu8VDZnNicEUjtc=; b=a
	fwZJpm85QyGCIRWyHiJSrBnF8wiKVq1vg/CyK7vFYKZWoG8a0rsbVDnx+/hwlK5E
	T6fGe50V35o6s2UPyoz2gQn6IUhnAUipdE0m0vijLG0Za7QRkmL+icEr4+TQ/jAa
	REs2c+o2UkZhlwRAB+qTg5uhKDiE6dZFX6lSqgeI5Hlrs0mlV8bjYrHQg6RyXHTe
	87s9jwmWMs1ErPwgn0GiqMmA9cmHWIa5EpPlZ5vrr538hZoqjKTAHaiQQ7/UNb5G
	0A0fqz2yHBWGhhl1mKFGFsOxOeqvxVdD8Wt8F+K71YUOKb7CGA5PUBs5Fjz0Jor0
	MiIOa0fjDDvwr0GdfiItA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1741051325; x=1741054925; bh=4
	wieLldKDZRs2aSCi2od3P1sUduKlu8VDZnNicEUjtc=; b=e1URqcV4MXKiYYhvU
	f2bcyGr5ehMTtX6vLOhJKkztn4vHVgC8CUNjAqxalgQeMqOF3/7Yh4AWN0waRIqI
	acEEFdOWxHbhIbuVKlWSF1CPch00AT7AEMIAEedjenmHqZX3ExyYnCp83mGZWGCr
	9Xp1DZRLjrFR7XwcHEnlxZz6kTbUaosn9fMVPLoxtwRtnjjSA3uqVoZimeDWjTo2
	/4X8QsQ62alR/OJNpihPdu08natMDswv8c1r2zy6YdiGY4d5JbSpaE74qBbTrFqN
	vPKRAu/xmWaRKp1xxWzGCYffo0fPfVghVFe31TJwlk+6eBdgU6cPdkhUkfDQeIWa
	KoHRA==
X-ME-Sender: <xms:vFXGZ7_2aGgchK0KvyyZuH4l_Jef0EVFNNOP2lhxoKoc5SwHVOr5-Q>
    <xme:vFXGZ3vFaiTS6WmXxiM83KgTLJsA0zmyCTlviOoLN6O7QRVsRHan7RxIGK9p9Lgy4
    DtA8matilgCTYCkPAY>
X-ME-Received: <xmr:vFXGZ5Dvph1FDfxDcJq6_LlH9ow0ITdMy3OjP1yPtr7cTRFi3VCklbfTtq-wmeAQV6don25K2HkqsyFXag9Kv-0vBxXKMo6Co4Q_bjGxpU3Ah243Y3szpYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddtieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomhepvfhinhhgmhgrohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqe
    enucggtffrrghtthgvrhhnpeeuuddthefhhefhvdejteevvddvteefffegteetueegueel
    jeefueekjeetieeuleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehmsehmrghofihtmhdrohhrghdpnhgspghrtghpthhtohepledpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepmhhitgesughighhikhhougdrnhgvthdprhgtph
    htthhopehgnhhorggtkhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhgrtghksehs
    uhhsvgdrtgiipdhrtghpthhtohepmhesmhgrohifthhmrdhorhhgpdhrtghpthhtoheplh
    hinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegrmhhirhejfehilhesghhmrghilhdrtghomhdprhgtphhtthhope
    hrvghpnhhophesghhoohhglhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqfhhsuggv
    vhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehthigthhhosehthi
    gthhhordhpihiiiigr
X-ME-Proxy: <xmx:vFXGZ3fM8phhjsHVzjBRhPrnuIdAbGQ2zGXqk-y-Xe-lCOv3K8iI9Q>
    <xmx:vFXGZwO9Cy-0k7T0DIcK1RiSmTy2QLKnBOoXVf-JpimPOo5VVg9n-w>
    <xmx:vFXGZ5nIeu0vQNiFAvYl4fi6Wym6RR0ylpmOmCQYiBt1Ac-cLsVKCA>
    <xmx:vFXGZ6twKnvtORsNP2VwF0mHUGfbn_vvMjzqdkDgF96JJ8ZShTt0WA>
    <xmx:vVXGZ8CJjW5es2tahRcHrhbthm7CWWYb6cc8DE-yi8LxnlbB-qbpDYxx>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 20:22:03 -0500 (EST)
From: Tingmao Wang <m@maowtm.org>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jan Kara <jack@suse.cz>
Cc: Tingmao Wang <m@maowtm.org>,
	linux-security-module@vger.kernel.org,
	Amir Goldstein <amir73il@gmail.com>,
	Matthew Bobrowski <repnop@google.com>,
	linux-fsdevel@vger.kernel.org,
	Tycho Andersen <tycho@tycho.pizza>
Subject: [RFC PATCH 9/9] Enhance the sandboxer example to support landlock-supervise
Date: Tue,  4 Mar 2025 01:13:05 +0000
Message-ID: <9dc2b112c4be1aadff612b226c603db66ef79955.1741047969.git.m@maowtm.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741047969.git.m@maowtm.org>
References: <cover.1741047969.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is perhaps a bit overengineered with the ppoll on 5 different fds,
but it makes sure the sandboxed child can't try to print anything to the
terminal from a different thread while an access request is pending
(otherwise it could trick the user by printing over the request text).
This also makes sure inputs are directed to the right place (the child
when no prompt, or the sandboxer itself when an access request is shown).

But even with that, I'm not claiming this "sandbox" with supervise mode is
in any way production quality.  It's intended as a PoC.

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 samples/landlock/sandboxer.c | 759 ++++++++++++++++++++++++++++++++++-
 1 file changed, 739 insertions(+), 20 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index 07fab2ef534e..4a6a0d74c614 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -24,10 +24,16 @@
 #include <sys/syscall.h>
 #include <unistd.h>
 #include <stdbool.h>
+#include <poll.h>
+#include <pthread.h>
+#include <sys/wait.h>
+#include <termios.h>
+#include <linux/limits.h>
+#include <stdint.h>
 
 #ifndef landlock_create_ruleset
 static inline int
-landlock_create_ruleset(const struct landlock_ruleset_attr *const attr,
+landlock_create_ruleset(struct landlock_ruleset_attr *const attr,
 			const size_t size, const __u32 flags)
 {
 	return syscall(__NR_landlock_create_ruleset, attr, size, flags);
@@ -58,6 +64,7 @@ static inline int landlock_restrict_self(const int ruleset_fd,
 #define ENV_TCP_BIND_NAME "LL_TCP_BIND"
 #define ENV_TCP_CONNECT_NAME "LL_TCP_CONNECT"
 #define ENV_SCOPED_NAME "LL_SCOPED"
+#define ENV_SUPERVISE "LL_SUPERVISE"
 #define ENV_DELIMITER ":"
 
 static int str2num(const char *numstr, __u64 *num_dst)
@@ -278,24 +285,30 @@ static bool check_ruleset_scope(const char *const env_var,
 	LANDLOCK_ACCESS_FS_READ_FILE | \
 	LANDLOCK_ACCESS_FS_READ_DIR)
 
-#define ACCESS_FS_ROUGHLY_WRITE ( \
-	LANDLOCK_ACCESS_FS_WRITE_FILE | \
-	LANDLOCK_ACCESS_FS_REMOVE_DIR | \
-	LANDLOCK_ACCESS_FS_REMOVE_FILE | \
+#define ACCESS_FS_ROUGHLY_CREATE ( \
 	LANDLOCK_ACCESS_FS_MAKE_CHAR | \
 	LANDLOCK_ACCESS_FS_MAKE_DIR | \
 	LANDLOCK_ACCESS_FS_MAKE_REG | \
 	LANDLOCK_ACCESS_FS_MAKE_SOCK | \
 	LANDLOCK_ACCESS_FS_MAKE_FIFO | \
 	LANDLOCK_ACCESS_FS_MAKE_BLOCK | \
-	LANDLOCK_ACCESS_FS_MAKE_SYM | \
+	LANDLOCK_ACCESS_FS_MAKE_SYM)
+
+#define ACCESS_FS_ROUGHLY_REMOVE ( \
+	LANDLOCK_ACCESS_FS_REMOVE_DIR | \
+	LANDLOCK_ACCESS_FS_REMOVE_FILE)
+
+#define ACCESS_FS_ROUGHLY_WRITE ( \
+	LANDLOCK_ACCESS_FS_WRITE_FILE | \
+	ACCESS_FS_ROUGHLY_CREATE | \
+	ACCESS_FS_ROUGHLY_REMOVE | \
 	LANDLOCK_ACCESS_FS_REFER | \
 	LANDLOCK_ACCESS_FS_TRUNCATE | \
 	LANDLOCK_ACCESS_FS_IOCTL_DEV)
 
 /* clang-format on */
 
-#define LANDLOCK_ABI_LAST 6
+#define LANDLOCK_ABI_LAST 7
 
 #define XSTR(s) #s
 #define STR(s) XSTR(s)
@@ -321,6 +334,7 @@ static const char help[] =
 	"* " ENV_SCOPED_NAME ": actions denied on the outside of the landlock domain\n"
 	"  - \"a\" to restrict opening abstract unix sockets\n"
 	"  - \"s\" to restrict sending signals\n"
+	"* " ENV_SUPERVISE ": set to 1 to enable supervisor mode\n"
 	"\n"
 	"Example:\n"
 	ENV_FS_RO_NAME "=\"${PATH}:/lib:/usr:/proc:/etc:/dev/urandom\" "
@@ -335,14 +349,22 @@ static const char help[] =
 
 /* clang-format on */
 
+int verbose_exec(const char *cmd_path, char *const *cmd_argv,
+		 char *const *envp);
+int interactive_sandboxer(int supervisor_fd, int child_stdin, int child_stdout,
+			  int child_stderr, pid_t child_pid);
+
 int main(const int argc, char *const argv[], char *const *const envp)
 {
 	const char *cmd_path;
 	char *const *cmd_argv;
-	int ruleset_fd, abi;
+	int ruleset_fd = -1, supervisor_fd = -1, abi;
 	char *env_port_name;
 	__u64 access_fs_ro = ACCESS_FS_ROUGHLY_READ,
 	      access_fs_rw = ACCESS_FS_ROUGHLY_READ | ACCESS_FS_ROUGHLY_WRITE;
+	bool supervise = false;
+	__u32 flags;
+	char *env_supervise;
 
 	struct landlock_ruleset_attr ruleset_attr = {
 		.handled_access_fs = access_fs_rw,
@@ -350,6 +372,8 @@ int main(const int argc, char *const argv[], char *const *const envp)
 				      LANDLOCK_ACCESS_NET_CONNECT_TCP,
 		.scoped = LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
 			  LANDLOCK_SCOPE_SIGNAL,
+		.supervisor_fd = 0,
+		.pad = 0,
 	};
 
 	if (argc < 2) {
@@ -357,6 +381,11 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		return 1;
 	}
 
+	env_supervise = getenv(ENV_SUPERVISE);
+	if (env_supervise && strcmp(env_supervise, "1") == 0) {
+		supervise = true;
+	}
+
 	abi = landlock_create_ruleset(NULL, 0, LANDLOCK_CREATE_RULESET_VERSION);
 	if (abi < 0) {
 		const int err = errno;
@@ -422,6 +451,10 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		/* Removes LANDLOCK_SCOPE_* for ABI < 6 */
 		ruleset_attr.scoped &= ~(LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
 					 LANDLOCK_SCOPE_SIGNAL);
+		__attribute__((fallthrough));
+	case 6:
+		/* Removes supervisor mode for ABI < 7 */
+		supervise = false;
 		fprintf(stderr,
 			"Hint: You should update the running kernel "
 			"to leverage Landlock features "
@@ -456,12 +489,31 @@ int main(const int argc, char *const argv[], char *const *const envp)
 	if (check_ruleset_scope(ENV_SCOPED_NAME, &ruleset_attr))
 		return 1;
 
-	ruleset_fd =
-		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	flags = 0;
+	if (supervise)
+		flags |= LANDLOCK_CREATE_RULESET_SUPERVISE;
+
+	ruleset_fd = landlock_create_ruleset(&ruleset_attr,
+					     sizeof(ruleset_attr), flags);
 	if (ruleset_fd < 0) {
 		perror("Failed to create a ruleset");
 		return 1;
 	}
+	if (supervise) {
+		supervisor_fd = ruleset_attr.supervisor_fd;
+		if (supervisor_fd < 0) {
+			fprintf(stderr, "supervisor_fd is invalid");
+			return 1;
+		}
+		if (supervisor_fd == 0) {
+			fprintf(stderr, "supervisor_fd not set by kernel");
+			return 1;
+		}
+	} else if (ruleset_attr.supervisor_fd != 0) {
+		fprintf(stderr,
+			"supervisor_fd should not be set by kernel, but it is not 0");
+		return 1;
+	}
 
 	if (populate_ruleset_fs(ENV_FS_RO_NAME, ruleset_fd, access_fs_ro)) {
 		goto err_close_ruleset;
@@ -483,23 +535,690 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		perror("Failed to restrict privileges");
 		goto err_close_ruleset;
 	}
-	if (landlock_restrict_self(ruleset_fd, 0)) {
-		perror("Failed to enforce ruleset");
-		goto err_close_ruleset;
-	}
-	close(ruleset_fd);
 
 	cmd_path = argv[1];
 	cmd_argv = argv + 1;
+
+	if (!supervise) {
+		if (landlock_restrict_self(ruleset_fd, 0)) {
+			perror("Failed to enforce ruleset");
+			goto err_close_ruleset;
+		}
+		close(ruleset_fd);
+		verbose_exec(cmd_path, cmd_argv, envp);
+	} else {
+		pid_t child;
+		int child_stdin_pipe[2], child_stdout_pipe[2],
+			child_stderr_pipe[2];
+		// read from [0], write to [1]
+		if (pipe(child_stdin_pipe) || pipe(child_stdout_pipe) ||
+		    pipe(child_stderr_pipe)) {
+			perror("Failed to create pipes");
+			goto err_close_ruleset;
+		}
+		child = fork();
+		if (child < 0) {
+			perror("Failed to fork");
+			goto err_close_ruleset;
+		}
+		if (child == 0) {
+			close(supervisor_fd);
+
+			if (landlock_restrict_self(ruleset_fd, 0)) {
+				perror("Failed to enforce ruleset");
+				goto err_close_ruleset;
+			}
+
+			close(child_stdin_pipe[1]);
+			close(child_stdout_pipe[0]);
+			close(child_stderr_pipe[0]);
+			if (dup2(child_stdin_pipe[0], STDIN_FILENO) < 0 ||
+			    dup2(child_stdout_pipe[1], STDOUT_FILENO) < 0 ||
+			    dup2(child_stderr_pipe[1], STDERR_FILENO) < 0) {
+				perror("Failed to redirect child I/O");
+				exit(1);
+			}
+			close(child_stdin_pipe[0]);
+			close(child_stdout_pipe[1]);
+			close(child_stderr_pipe[1]);
+
+			close(ruleset_fd);
+			verbose_exec(cmd_path, cmd_argv, envp);
+		} else {
+			close(ruleset_fd);
+			close(child_stdin_pipe[0]);
+			close(child_stdout_pipe[1]);
+			close(child_stderr_pipe[1]);
+			return interactive_sandboxer(supervisor_fd,
+						     child_stdin_pipe[1],
+						     child_stdout_pipe[0],
+						     child_stderr_pipe[0],
+						     child);
+		}
+	}
+
+err_close_ruleset:
+	close(ruleset_fd);
+	return 1;
+}
+
+int verbose_exec(const char *cmd_path, char *const *cmd_argv, char *const *envp)
+{
 	fprintf(stderr, "Executing the sandboxed command...\n");
 	execvpe(cmd_path, cmd_argv, envp);
+	int err = errno;
 	fprintf(stderr, "Failed to execute \"%s\": %s\n", cmd_path,
-		strerror(errno));
+		strerror(err));
 	fprintf(stderr, "Hint: access to the binary, the interpreter or "
 			"shared libraries may be denied.\n");
-	return 1;
+	return err;
+}
 
-err_close_ruleset:
-	close(ruleset_fd);
-	return 1;
+enum SandboxAccessType {
+	ACCESS_READ,
+	ACCESS_READWRITE,
+	ACCESS_CREATE,
+	ACCESS_REMOVE,
+};
+
+struct context {
+	int supervisor_fd;
+	char **allowed_paths;
+	size_t num_allowed_paths;
+};
+
+static int f_set_noblock(int fd)
+{
+	int flags = fcntl(fd, F_GETFL, 0);
+	if (flags < 0) {
+		perror("Failed to get flags");
+		return -1;
+	}
+	if (fcntl(fd, F_SETFL, flags | O_NONBLOCK) < 0) {
+		perror("Failed to set flags");
+		return -1;
+	}
+	return 0;
+}
+
+static int write_all(int fd, const char *buf, size_t count)
+{
+	while (count > 0) {
+		ssize_t written = write(fd, buf, count);
+		if (written < 0) {
+			return written;
+		}
+		count -= written;
+		buf += written;
+	}
+	return 0;
+}
+
+static int readlink_fd_s(int fd, char *buf, size_t buf_len)
+{
+	if (buf_len == 0) {
+		errno = EINVAL;
+		return -1;
+	}
+	char procfd[100];
+	snprintf(procfd, sizeof(procfd), "/proc/self/fd/%d", fd);
+	ssize_t len = readlink(procfd, buf, buf_len - 1);
+	if (len < 0) {
+		return -1;
+	}
+	buf[len] = '\0';
+	return len;
+}
+
+static bool show_sandbox_prompt_fs(enum SandboxAccessType access,
+				   const char *file1, const char *file2,
+				   int pid, const char *comm, const char *exe,
+				   struct context *context)
+{
+	const char *access_kv;
+	switch (access) {
+	case ACCESS_READ:
+		access_kv = "read";
+		break;
+	case ACCESS_READWRITE:
+		access_kv = "read/write";
+		break;
+	case ACCESS_CREATE:
+		access_kv = "create";
+		break;
+	case ACCESS_REMOVE:
+		access_kv = "remove";
+		break;
+	default:
+		abort();
+		return false;
+	}
+	if (isatty(STDIN_FILENO)) {
+		tcflush(STDIN_FILENO, TCIOFLUSH);
+	}
+	fprintf(stderr,
+		"------------- Sandboxer access request -------------\n");
+	fprintf(stderr, "Process %s[%d] (%s) wants to %s\n  %s\n", comm, pid,
+		exe, access_kv, file1);
+	if (file2) {
+		fprintf(stderr, "  %s\n", file2);
+	}
+	bool allow = false;
+	while (true) {
+		char answer[10];
+		fprintf(stderr, "(y)es/(a)lways/(n)o > ");
+		fflush(stderr);
+		int rc = read(STDIN_FILENO, answer, sizeof(answer));
+		if (rc < 0) {
+			perror("Failed to read answer");
+			break;
+		}
+		if (rc == 0) {
+			break;
+		}
+		answer[rc] = '\0';
+		if (strcmp(answer, "y\n") == 0) {
+			allow = true;
+			break;
+		} else if (strcmp(answer, "a\n") == 0) {
+			allow = true;
+			/* +2 in case file2 is also set */
+			context->allowed_paths =
+				realloc(context->allowed_paths,
+					(context->num_allowed_paths + 2) *
+						sizeof(char *));
+			if (!context->allowed_paths) {
+				abort();
+			}
+			char *dup_str = strdup(file1);
+			if (!dup_str) {
+				abort();
+			}
+			context->allowed_paths[context->num_allowed_paths] =
+				dup_str;
+			context->num_allowed_paths++;
+
+			if (file2) {
+				dup_str = strdup(file2);
+				if (!dup_str) {
+					abort();
+				}
+				context->allowed_paths
+					[context->num_allowed_paths] = dup_str;
+				context->num_allowed_paths++;
+			}
+			break;
+		} else if (strcmp(answer, "n\n") == 0) {
+			allow = false;
+			break;
+		} else {
+			fprintf(stderr,
+				"Please answer \"y\", \"a\", or \"n\"\n");
+		}
+	}
+	fprintf(stderr,
+		"----------------------------------------------------\n");
+	return allow;
+}
+
+static bool show_sandbox_prompt_network(__u16 port, struct context *context)
+{
+	/* TODO: unimplemented in kernel */
+	return true;
+}
+
+#ifndef min
+#define min(a, b) ((a) < (b) ? (a) : (b))
+#endif
+
+static bool path_join(char *dest_buf, size_t dest_buf_len, const char *last)
+{
+	if (dest_buf_len <= 1) {
+		return false;
+	}
+	size_t last_len = strlen(last);
+	size_t dest_len = strnlen(dest_buf, dest_buf_len);
+	if (dest_len == 1 && dest_buf[0] == '/') {
+		dest_buf[0] = '\0';
+		dest_len = 0;
+	}
+	size_t dest_space = dest_buf_len - dest_len;
+	if (dest_space <= 1) {
+		return false;
+	}
+	if (dest_space == 2) {
+		dest_buf[dest_len] = '/';
+		dest_buf[dest_len + 1] = '\0';
+		return false;
+	}
+	size_t copy_count = min(dest_space - 2, last_len);
+	dest_buf[dest_len] = '/';
+	memcpy(dest_buf + dest_len + 1, last, copy_count);
+	dest_buf[dest_len + 1 + copy_count] = '\0';
+	return copy_count == last_len;
+}
+
+static int process_event(struct landlock_supervise_event *evt,
+			 struct context *context)
+{
+	char *target_path_1 = NULL;
+	char *target_path_2 = NULL;
+	char *comm = NULL;
+	char *exe = NULL;
+	int pid;
+	int fd = -1;
+	ssize_t len;
+	enum SandboxAccessType access = -1;
+	char proc_exe[100], proc_comm[100];
+	struct landlock_supervise_response response;
+	bool allow = false;
+	int ret = 0;
+	int supervisor_fd = context->supervisor_fd;
+
+	memset(&response, 0, sizeof(response));
+
+	if (((uintptr_t)evt) % __alignof__(struct landlock_supervise_event) !=
+	    0) {
+		/*
+		 * Check that the kernel hasn't messed up given we're
+		 * reading an array of varable length struct
+		 */
+		fprintf(stderr, "evt = %p is badly aligned\n", evt);
+		abort();
+	}
+
+	switch (evt->hdr.type) {
+	case LANDLOCK_SUPERVISE_EVENT_TYPE_FS_ACCESS:
+		if (evt->fd1 != -1) {
+			target_path_1 = malloc(PATH_MAX);
+			if (!target_path_1) {
+				abort();
+			}
+			if (readlink_fd_s(evt->fd1, target_path_1, PATH_MAX) <
+			    -1) {
+				close(evt->fd1);
+				perror("Failed to readlink");
+				ret = -1;
+				goto ret;
+			}
+			close(evt->fd1);
+		} else {
+			fprintf(stderr, "fd1 is -1 which should not happen.");
+			abort();
+		}
+		if (evt->fd2 != -1) {
+			target_path_2 = malloc(PATH_MAX);
+			if (!target_path_2) {
+				abort();
+			}
+			if (readlink_fd_s(evt->fd2, target_path_2, PATH_MAX) <
+			    -1) {
+				perror("Failed to readlink");
+				close(evt->fd2);
+				ret = -1;
+				goto ret;
+			}
+			close(evt->fd2);
+		}
+		if (evt->destname[0] != 0) {
+			if (evt->fd2 != -1) {
+				path_join(target_path_2, PATH_MAX,
+					  evt->destname);
+			} else {
+				path_join(target_path_1, PATH_MAX,
+					  evt->destname);
+			}
+		}
+		if (evt->access_request & ACCESS_FS_ROUGHLY_CREATE) {
+			access = ACCESS_CREATE;
+		} else if (evt->access_request & ACCESS_FS_ROUGHLY_REMOVE) {
+			access = ACCESS_REMOVE;
+		} else if (evt->access_request & ACCESS_FS_ROUGHLY_WRITE) {
+			access = ACCESS_READWRITE;
+		} else {
+			access = ACCESS_READ;
+		}
+
+		if (strcmp(target_path_1, "/dev/tty") == 0) {
+			/*
+			 * Deny TTY access to bash, as it messes with the
+			 * supervisor input, causing the supervisor to
+			 * receive SIGTTIN
+			 */
+			goto response;
+		}
+
+		for (size_t i = 0; i < context->num_allowed_paths; i++) {
+			if (strcmp(target_path_1, context->allowed_paths[i]) ==
+			    0) {
+				allow = true;
+				break;
+			}
+		}
+		break;
+	case LANDLOCK_SUPERVISE_EVENT_TYPE_NET_ACCESS:
+		/* No pre-processing needed */
+		break;
+	default:
+		fprintf(stderr, "Unknown event type: %d\n", evt->hdr.type);
+		ret = -1;
+		break;
+	}
+
+	pid = evt->accessor;
+	snprintf(proc_exe, sizeof(proc_exe), "/proc/%d/exe", pid);
+	exe = malloc(PATH_MAX);
+	if (!exe) {
+		abort();
+	}
+	len = readlink(proc_exe, exe, PATH_MAX - 1);
+	if (len < 0) {
+		perror("Failed to readlink proc exe");
+		return -1;
+	}
+	exe[len] = '\0';
+	snprintf(proc_comm, sizeof(proc_comm), "/proc/%d/comm", pid);
+	comm = malloc(PATH_MAX);
+	if (!comm) {
+		abort();
+	}
+	fd = open(proc_comm, O_RDONLY);
+	if (fd < 0) {
+		snprintf(comm, PATH_MAX, "???");
+	} else {
+		len = read(fd, comm, PATH_MAX - 1);
+		if (len < 0) {
+			snprintf(comm, PATH_MAX, "???");
+		} else {
+			comm[len] = '\0';
+			if (len > 0 && comm[len - 1] == '\n') {
+				comm[len - 1] = '\0';
+			}
+		}
+		close(fd);
+	}
+
+	switch (evt->hdr.type) {
+	case LANDLOCK_SUPERVISE_EVENT_TYPE_FS_ACCESS:
+		if (!allow) {
+			allow = show_sandbox_prompt_fs(access, target_path_1,
+						       target_path_2, pid, comm,
+						       exe, context);
+		}
+		break;
+	case LANDLOCK_SUPERVISE_EVENT_TYPE_NET_ACCESS:
+		allow = show_sandbox_prompt_network(evt->port, context);
+		break;
+	}
+
+response:
+	/* Prepare and send response to the kernel */
+	response.length = sizeof(response);
+	response.decision = allow ? LANDLOCK_SUPERVISE_DECISION_ALLOW :
+				    LANDLOCK_SUPERVISE_DECISION_DENY;
+	response.cookie = evt->hdr.cookie;
+
+	if (write(supervisor_fd, &response, sizeof(response)) !=
+	    sizeof(response)) {
+		perror("Failed to write supervisor response");
+		ret = -1;
+	}
+
+ret:
+	free(target_path_1);
+	free(target_path_2);
+	free(comm);
+	free(exe);
+	return ret;
+}
+
+static int process_events(void *data, size_t data_len, struct context *context)
+{
+	while (data_len > 0) {
+		struct landlock_supervise_event *evt;
+		int rc;
+		if (data_len < sizeof(evt->hdr)) {
+			fprintf(stderr,
+				"Too few bytes for a event header - got %zu left, need %zu.",
+				data_len, sizeof(evt->hdr));
+			return -EINVAL;
+		}
+		evt = data;
+		if (evt->hdr.length > data_len) {
+			fprintf(stderr,
+				"Length from event header is greater than remaining data.");
+			return -EINVAL;
+		}
+		rc = process_event(evt, context);
+		if (rc < 0) {
+			return rc;
+		}
+		data_len -= evt->hdr.length;
+		data += evt->hdr.length;
+	}
+	return 0;
+}
+
+int interactive_sandboxer(int supervisor_fd, int child_stdin, int child_stdout,
+			  int child_stderr, pid_t child_pid)
+{
+	char *write_buf = NULL;
+	size_t write_buf_len = 0;
+
+	size_t io_buf_len = 4096;
+	char *io_buf = malloc(io_buf_len);
+	if (!io_buf) {
+		fprintf(stderr, "Failed to allocate I/O buffer");
+		return -1;
+	}
+
+	int status = 0;
+
+	struct pollfd pfds[5] = {
+		{ .fd = STDIN_FILENO, .events = POLLIN },
+		{ .fd = child_stdout, .events = POLLIN },
+		{ .fd = child_stderr, .events = POLLIN },
+		{ .fd = supervisor_fd, .events = POLLIN },
+		{ .fd = child_stdin, .events = POLLOUT },
+	};
+	const int pfd_idx_stdin = 0;
+	const int pfd_idx_child_stdout = 1;
+	const int pfd_idx_child_stderr = 2;
+	const int pfd_idx_supervisor = 3;
+	const int pfd_idx_child_stdin = 4;
+	const int poll_len = 5;
+
+	struct context context = {
+		.supervisor_fd = supervisor_fd,
+		.allowed_paths = NULL,
+		.num_allowed_paths = 0,
+	};
+
+	bool child_stdin_closed = false;
+
+	/*
+	 * Don't deadlock by us trying to write to child, and child
+	 * waiting to write to us.
+	 */
+	f_set_noblock(child_stdin);
+
+	/* Don't get killed by SIGPIPE when child closes stdout/err */
+	signal(SIGPIPE, SIG_IGN);
+
+	while (1) {
+		if (write_buf_len > 0 && !child_stdin_closed) {
+			pfds[pfd_idx_child_stdin].fd = child_stdin;
+		} else {
+			pfds[pfd_idx_child_stdin].fd = -1;
+		}
+
+		for (int i = 0; i < poll_len; i++) {
+			pfds[i].revents = 0;
+		}
+
+		if (ppoll(pfds, poll_len, NULL, NULL) < 0) {
+			if (errno != EINTR) {
+				perror("ppoll");
+				goto err_kill_child;
+			}
+		}
+
+		if (pfds[0].revents & POLLIN) {
+			/*
+			 * Our stdin -> temp buffer for child's stdin.
+			 * Need to do this before handling any supervisor
+			 * events so that inputs intended for the child is
+			 * not interperted as user decision.
+			 */
+			const int read_len = 4096;
+			write_buf =
+				realloc(write_buf, write_buf_len + read_len);
+			if (!write_buf) {
+				fprintf(stderr,
+					"Failed to realloc write buffer\n");
+				goto err_kill_child;
+			}
+			ssize_t count = read(STDIN_FILENO,
+					     write_buf + write_buf_len,
+					     read_len);
+			if (count > 0) {
+				write_buf_len += count;
+			} else if (count == 0) {
+				/* Our stdin is closed. Don't read from it anymore. */
+				pfds[pfd_idx_stdin].fd = -1;
+			} else {
+				perror("Failed to read from stdin");
+				goto err_kill_child;
+			}
+		}
+
+		if (write_buf_len > 0) {
+			/* Attempt to write any outstanding stdin to child */
+			ssize_t written =
+				write(child_stdin, write_buf, write_buf_len);
+			if (written > 0) {
+				if (written > write_buf_len) {
+					abort();
+				} else if (written == write_buf_len) {
+					write_buf_len = 0;
+				} else {
+					memmove(write_buf, write_buf + written,
+						write_buf_len - written);
+					write_buf_len -= written;
+				}
+			} else {
+				if (errno == EPIPE) {
+					close(child_stdin);
+					child_stdin_closed = true;
+					pfds[pfd_idx_child_stdin].fd = -1;
+					write_buf_len = 0;
+				} else if (errno != EAGAIN) {
+					perror("Failed to write to child stdin");
+					goto err_kill_child;
+				}
+			}
+		}
+
+		if (pfds[pfd_idx_stdin].fd == -1 && write_buf_len == 0) {
+			/* We can safely close child's stdin now */
+			close(child_stdin);
+			child_stdin_closed = true;
+			pfds[pfd_idx_child_stdin].fd = -1;
+		}
+
+		if (pfds[pfd_idx_child_stdout].revents & POLLIN) {
+			/* Child stdout -> our stdout */
+			ssize_t count = read(child_stdout, io_buf, io_buf_len);
+			if (count > 0) {
+				if (write_all(STDOUT_FILENO, io_buf, count) <
+				    0) {
+					perror("Failed to write to stdout");
+					goto err_kill_child;
+				}
+			} else if (count == 0 ||
+				   (count < 0 && errno == EPIPE)) {
+				close(child_stdout);
+				pfds[pfd_idx_child_stdout].fd = -1;
+			} else if (count < 0 && errno != EAGAIN) {
+				perror("Failed to read from child stdout");
+				goto err_kill_child;
+			}
+		}
+
+		if (pfds[2].revents & POLLIN) {
+			/* Child stderr -> our stderr */
+			ssize_t count = read(child_stderr, io_buf, io_buf_len);
+			if (count > 0) {
+				if (write_all(STDERR_FILENO, io_buf, count) <
+				    0) {
+					perror("Failed to write to stderr");
+					goto err_kill_child;
+				}
+			} else if (count == 0 ||
+				   (count < 0 && errno == EPIPE)) {
+				close(child_stderr);
+				pfds[pfd_idx_child_stderr].fd = -1;
+			} else if (count < 0 && errno != EAGAIN) {
+				perror("Failed to read from child stderr");
+				goto err_kill_child;
+			}
+		}
+
+		if (waitpid(child_pid, &status, WNOHANG) == child_pid) {
+			/*
+			 * Write out any remaining child stdout/stderr.
+			 * If child died, read would just return EOF.
+			 */
+			while (1) {
+				ssize_t count =
+					read(child_stdout, io_buf, io_buf_len);
+				if (count > 0)
+					write_all(STDOUT_FILENO, io_buf, count);
+				else
+					break;
+			}
+			while (1) {
+				ssize_t count =
+					read(child_stderr, io_buf, io_buf_len);
+				if (count > 0)
+					write_all(STDERR_FILENO, io_buf, count);
+				else
+					break;
+			}
+			return WIFEXITED(status) ? WEXITSTATUS(status) : 1;
+		}
+
+		if (pfds[pfd_idx_supervisor].revents) {
+retry:
+			ssize_t count = read(supervisor_fd, io_buf, io_buf_len);
+			if (count > 0) {
+				process_events(io_buf, count, &context);
+			} else if (count == 0) {
+				fprintf(stderr,
+					"Unexpected EOF on supervisor fd\n");
+				goto err_kill_child;
+			} else if (count < 0 && errno != EAGAIN) {
+				if (errno == EINVAL) {
+					io_buf_len *= 2;
+					io_buf = realloc(io_buf, io_buf_len);
+					if (!io_buf) {
+						fprintf(stderr,
+							"Failed to realloc I/O buffer\n");
+						goto err_kill_child;
+					}
+					fprintf(stderr,
+						"Got EINVAL - possibly event too big. Realloced I/O buffer to %zu\n",
+						io_buf_len);
+					goto retry;
+				}
+				perror("Failed to read from supervisor");
+				goto err_kill_child;
+			}
+		}
+	}
+
+err_kill_child:
+	close(supervisor_fd);
+	kill(child_pid, SIGTERM);
+	return -1;
 }
-- 
2.39.5


