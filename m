Return-Path: <linux-fsdevel+bounces-29977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F16984758
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 16:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD4651F2598F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 14:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0351A76DE;
	Tue, 24 Sep 2024 14:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="kgb/UtcD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g2HqVTqL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42B91A7268;
	Tue, 24 Sep 2024 14:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727187055; cv=none; b=ip/NEIIsjES7lm+S58e1oBQM1NlbT//RmmCYdvQlyfLtTmaOpbGK/8Bm58EVJmc3N0HJJt8nzY4UAZxj0OFLohPAAK23mc0I13v1OvnV3VRjRa9PbSDGMDsggoqLlzH49P1A9xF04vEP9zG5hgkKVI1n4jR9gXw5QIQBIQ8B5vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727187055; c=relaxed/simple;
	bh=h6m2AKGgFDfrxKtkF45nKprZZJanRQKBHxtROCbEo6U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=nT0J85sNGeza/WLh5DNAgSegT0mzCEoWb03JAY5OWwLoVKlS6tY4zlGzizXXItbOTs2/zqVM5wLx9akXSqTOjyNxZvVZ7FvF8hzu+1Ok2v9hzfAEQW+4fYTrlBhNANnDL8s68oJEkc+OEaC49t7/aknNTwf2LJz7I+OwqJbdMb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza; spf=pass smtp.mailfrom=tycho.pizza; dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b=kgb/UtcD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g2HqVTqL; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tycho.pizza
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 9BF1813800C5;
	Tue, 24 Sep 2024 10:10:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 24 Sep 2024 10:10:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1727187051; x=1727273451; bh=Bm
	NudCcPUMExrTG7jtodHLWWbD8+3DLdgabiD4b+0DM=; b=kgb/UtcDTPZ0Yf4zoX
	C6KyHCptn0rYO7ROZlMts9/dqx/dl7/h730DzFPfmaX57JfKNcRZ9TnD8IPWwrmQ
	evTa4HaSmztkte6f5N0wdbx4rqjQny8cTtAdy4Io4g6E6CXUYKkBj9cbJbmJ2j7p
	Ze+48DHIqdD/W0Ub970jwqSbmyp0JTPMx3ZGYpK0PsdPcMFPLixUfJyI54gaNK7w
	pFL5Z8adDQ+d2sWaYJDIAoBGhBcpXP39GYBoylPjees5ObStnzKxG+QUd6+gBrfL
	jf72zxtbhEHdJ4AFz81mzs/dtJf+1ICjNuTTvDhvAx+kcgrAxtXRnPBBJLEhvRFZ
	sgYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1727187051; x=1727273451; bh=BmNudCcPUMExr
	TG7jtodHLWWbD8+3DLdgabiD4b+0DM=; b=g2HqVTqLftczY2ubxtNaKxmuTOmyY
	da90KGFdzxsNeJnzFAOaLOQ+WqAQi2DdPRyK6muvnQXRJPVoT70AHv3kL/KGRSMB
	CFlzL88/0wfWGnlHrLUfoYlvyQLuLaRz8Gg5E5GgMvmIkrOQv9VGPYIOculDDzs8
	pFhxZB0B3u4VAiW5QMZy89lrc6ZgWwqrFvoW1VGS1jEX5bjneCzk+QV6Pwc6yPWh
	21Mo9mzBgv4wr6JDHF4QGNU4JC1n21lSwD4v3yDB5M6uGMTOyFmwJkjoRTQPjV0E
	CtOg/ApUZ0A7EpaA8sNPqpexGo76CayCG8V8Ji126k3dZEEHJm58IvNUg==
X-ME-Sender: <xms:asjyZpAA-YYWHjRT8M_TTzW8j6EYO-_dU411YPiql9NM8hbONf04wQ>
    <xme:asjyZni5PNuci5-sD6wvAb00ZnTLhI783EebViJPvvLO-vA6tKew-h78sgFEK36dC
    lIuWi-Z2OO-q9UFr90>
X-ME-Received: <xmr:asjyZkkgfelbrUGV_xX0LJ3nFRP0L0wiH7gwCGwH1J54dyTHBu67KEXMCyJBACRcz-fo4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtfedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofggtgfgsehtkeertdertdejnecu
    hfhrohhmpefvhigthhhoucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpih
    iiiigrqeenucggtffrrghtthgvrhhnpeeujeevvdelueeuuedvvdekvdetieehkefgfeet
    lefhvdeikeevveejvdfgteehieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehthigthhhosehthigthhhordhpihiiiigrpdhnsggprhgtphht
    thhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvhhirhhoseiivghnih
    hvrdhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopegvsg
    hivgguvghrmhesgihmihhsshhiohhnrdgtohhmpdhrtghpthhtohepkhgvvghssehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphhtthho
    pegrlhgvgidrrghrihhnghesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqd
    hfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:asjyZjzBdyuImKUS8yEllfYEe7NobcDGRCJemLXnlbdN6JvJprnfYw>
    <xmx:asjyZuTyLIGtSqtQh78hbVXK6kU7eS93l-lmm6upQd0AEPPwW28jwQ>
    <xmx:asjyZmbfcoWR0EP2u18QR2lfZvit_HD4nK9dKaOayE7EDmrVW7ea8g>
    <xmx:asjyZvRTRN-F1rQFFBD8wNrZf-AHmGp46j0fBcu5Sm7JJll8CPKE4Q>
    <xmx:a8jyZjig-itBT3Bh1BOFDU6Zu2Fykq7B5g2ygeEnLdzicJAEWaNxPbZC>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Sep 2024 10:10:48 -0400 (EDT)
From: Tycho Andersen <tycho@tycho.pizza>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <alex.aring@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Tycho Andersen <tycho@tycho.pizza>,
	Tycho Andersen <tandersen@netflix.com>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Aleksa Sarai <cyphar@cyphar.com>
Subject: [RFC] exec: add a flag for "reasonable" execveat() comm
Date: Tue, 24 Sep 2024 08:10:01 -0600
Message-Id: <20240924141001.116584-1-tycho@tycho.pizza>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Tycho Andersen <tandersen@netflix.com>

Zbigniew mentioned at Linux Plumber's that systemd is interested in
switching to execveat() for service execution, but can't, because the
contents of /proc/pid/comm are the file descriptor which was used,
instead of the path to the binary. This makes the output of tools like
top and ps useless, especially in a world where most fds are opened
CLOEXEC so the number is truly meaningless.

This patch adds an AT_ flag to fix up /proc/pid/comm to instead be the
contents of argv[0], instead of the fdno.

Signed-off-by: Tycho Andersen <tandersen@netflix.com>
Suggested-by: Zbigniew Jędrzejewski-Szmek <zbyszek@in.waw.pl>
CC: Aleksa Sarai <cyphar@cyphar.com>
---
There is some question about what to name the flag; it seems to me that
"everyone wants this" instead of the fdno, but probably "REASONABLE" is not
a good choice.

Also, requiring the arg to alloc_bprm() is a bit ugly: kernel-based execs
will never use this, so they just have to pass an empty thing. We could
introduce a bprm_fixup_comm() to do the munging there, but then the code
paths start to diverge, which is maybe not nice. I left it this way because
this is the smallest patch in terms of size, but I'm happy to change it.

Finally, here is a small set of test programs, I'm happy to turn them into
kselftests if we agree on an API

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

int main(void)
{
	int fd;
	char buf[128];

	fd = open("/proc/self/comm", O_RDONLY);
	if (fd < 0) {
		perror("open comm");
		exit(1);
	}

	if (read(fd, buf, 128) < 0) {
		perror("read");
		exit(1);
	}

	printf("comm: %s", buf);
	exit(0);
}

#define _GNU_SOURCE
#include <stdio.h>
#include <syscall.h>
#include <stdbool.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/wait.h>

#ifndef AT_EMPTY_PATH
#define AT_EMPTY_PATH                        0x1000  /* Allow empty relative */
#endif

#ifndef AT_EXEC_REASONABLE_COMM
#define AT_EXEC_REASONABLE_COMM         0x200
#endif

int main(int argc, char *argv[])
{
	pid_t pid;
	int status;
	bool wants_reasonable_comm = argc > 1;

	pid = fork();
	if (pid < 0) {
		perror("fork");
		exit(1);
	}

	if (pid == 0) {
		int fd;
		long ret, flags;

		fd = open("./catprocselfcomm", O_PATH);
		if (fd < 0) {
			perror("open catprocselfname");
			exit(1);
		}

		flags = AT_EMPTY_PATH;
		if (wants_reasonable_comm)
			flags |= AT_EXEC_REASONABLE_COMM;
		syscall(__NR_execveat, fd, "", (char *[]){"./catprocselfcomm", NULL}, NULL, flags);
		fprintf(stderr, "execveat failed %d\n", errno);
		exit(1);
	}

	if (waitpid(pid, &status, 0) != pid) {
		fprintf(stderr, "wrong child\n");
		exit(1);
	}

	if (!WIFEXITED(status)) {
		fprintf(stderr, "exit status %x\n", status);
		exit(1);
	}

	if (WEXITSTATUS(status) != 0) {
		fprintf(stderr, "child failed\n");
		exit(1);
	}

	return 0;
}
---
 fs/exec.c                  | 22 ++++++++++++++++++----
 include/uapi/linux/fcntl.h |  3 ++-
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index dad402d55681..36434feddb7b 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1569,11 +1569,15 @@ static void free_bprm(struct linux_binprm *bprm)
 	kfree(bprm);
 }
 
-static struct linux_binprm *alloc_bprm(int fd, struct filename *filename, int flags)
+static struct linux_binprm *alloc_bprm(int fd, struct filename *filename,
+				       struct user_arg_ptr argv, int flags)
 {
 	struct linux_binprm *bprm;
 	struct file *file;
 	int retval = -ENOMEM;
+	bool needs_comm_fixup = flags & AT_EXEC_REASONABLE_COMM;
+
+	flags &= ~AT_EXEC_REASONABLE_COMM;
 
 	file = do_open_execat(fd, filename, flags);
 	if (IS_ERR(file))
@@ -1590,11 +1594,20 @@ static struct linux_binprm *alloc_bprm(int fd, struct filename *filename, int fl
 	if (fd == AT_FDCWD || filename->name[0] == '/') {
 		bprm->filename = filename->name;
 	} else {
-		if (filename->name[0] == '\0')
+		if (needs_comm_fixup) {
+			const char __user *p = get_user_arg_ptr(argv, 0);
+
+			retval = -EFAULT;
+			if (!p)
+				goto out_free;
+
+			bprm->fdpath = strndup_user(p, MAX_ARG_STRLEN);
+		} else if (filename->name[0] == '\0')
 			bprm->fdpath = kasprintf(GFP_KERNEL, "/dev/fd/%d", fd);
 		else
 			bprm->fdpath = kasprintf(GFP_KERNEL, "/dev/fd/%d/%s",
 						  fd, filename->name);
+		retval = -ENOMEM;
 		if (!bprm->fdpath)
 			goto out_free;
 
@@ -1969,7 +1982,7 @@ static int do_execveat_common(int fd, struct filename *filename,
 	 * further execve() calls fail. */
 	current->flags &= ~PF_NPROC_EXCEEDED;
 
-	bprm = alloc_bprm(fd, filename, flags);
+	bprm = alloc_bprm(fd, filename, argv, flags);
 	if (IS_ERR(bprm)) {
 		retval = PTR_ERR(bprm);
 		goto out_ret;
@@ -2034,6 +2047,7 @@ int kernel_execve(const char *kernel_filename,
 	struct linux_binprm *bprm;
 	int fd = AT_FDCWD;
 	int retval;
+	struct user_arg_ptr user_argv = {};
 
 	/* It is non-sense for kernel threads to call execve */
 	if (WARN_ON_ONCE(current->flags & PF_KTHREAD))
@@ -2043,7 +2057,7 @@ int kernel_execve(const char *kernel_filename,
 	if (IS_ERR(filename))
 		return PTR_ERR(filename);
 
-	bprm = alloc_bprm(fd, filename, 0);
+	bprm = alloc_bprm(fd, filename, user_argv, 0);
 	if (IS_ERR(bprm)) {
 		retval = PTR_ERR(bprm);
 		goto out_ret;
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 87e2dec79fea..7178d1e4a3de 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -100,7 +100,8 @@
 /* Reserved for per-syscall flags	0xff. */
 #define AT_SYMLINK_NOFOLLOW		0x100   /* Do not follow symbolic
 						   links. */
-/* Reserved for per-syscall flags	0x200 */
+#define AT_EXEC_REASONABLE_COMM		0x200   /* Use argv[0] for comm in
+						   execveat */
 #define AT_SYMLINK_FOLLOW		0x400   /* Follow symbolic links. */
 #define AT_NO_AUTOMOUNT			0x800	/* Suppress terminal automount
 						   traversal. */

base-commit: baeb9a7d8b60b021d907127509c44507539c15e5
-- 
2.34.1


