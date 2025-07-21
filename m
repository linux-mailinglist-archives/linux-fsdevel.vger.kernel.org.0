Return-Path: <linux-fsdevel+bounces-55564-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA13B0BF3C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 10:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA4F6189AC6B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 08:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB459289364;
	Mon, 21 Jul 2025 08:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="C8pHkJ+A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F4628725A;
	Mon, 21 Jul 2025 08:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753087501; cv=none; b=NjBCGYQLuRvwsWwrCl8nWZBn/ZimTBpwGerHry/0lNgBCNucx01QNEws2THKpH2DwLyRiGop+qSVU2E6EL82J7cGAwQ+kqP9xMbO+4Am4N1Mc5iz92s0LuKZqgHQ3ufHOwOPrsljUttC7t79t2InclJKQtLM5kt5zm6DbVzGPLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753087501; c=relaxed/simple;
	bh=AEvujwBUjRTmHReBUwGHeNu6tYPvFq7/igA3xCswtkY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gq9Ys+lQWjBSsiOoDwxX/+5QTHQLRL384x8SNZfFp3TgszK1RRQKRPeZasS6hEUFb3hWvIKpc4wmVUBUbofi4MLBW5vZlZeQMP4rOlf+wjdtIUykrSVcSLZiKETpyqMVYMyFSPYysbK6LW3GO+dhpM6JAZK7sTr1wJaLrT4X0sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=C8pHkJ+A; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4blv93734kz9st4;
	Mon, 21 Jul 2025 10:44:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1753087496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sKANVQjFFkeVoyvMJ4VBA7OL+5rWrKofQzXQlRR9R/0=;
	b=C8pHkJ+Awd/FYZ4yOxQAcf1Uv6XS8s9brBayCd143sYWU9yMPhnFhPNq3Un980FvQNQUeR
	k27hbfOLAquSu57Xattp7LplP1UouOpcYpW36IV5REkJBIEQtBT6cIidNd5OXZ8jiUAZay
	/mw3D0X23+fqOq0Pzh8zQqZW+KlAt9MJsdCsG8hMe2SccsSFdWomJ0uJ0IVUSOTClv9Dp4
	xKUPvpCFj4winaycviD1ZtDKzuYXipjtOfGb5Xkmo0ZZj3Jy4FFSm/uGCcLZ5mJMhhhtHx
	PzZuA+fiH3nuCLJwrfjbubBCMNJsIcBGvhu8//Og+dEeoIBGUAQE+6EYvqHENg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Mon, 21 Jul 2025 18:44:12 +1000
Subject: [PATCH RFC 2/4] procfs: add pidns= mount option
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-procfs-pidns-api-v1-2-5cd9007e512d@cyphar.com>
References: <20250721-procfs-pidns-api-v1-0-5cd9007e512d@cyphar.com>
In-Reply-To: <20250721-procfs-pidns-api-v1-0-5cd9007e512d@cyphar.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-api@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5544; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=AEvujwBUjRTmHReBUwGHeNu6tYPvFq7/igA3xCswtkY=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWTU/v2Qr/PwJhd71N87f5L+lsvnWLpqt/35VVizVv8P/
 6YaubSLHaUsDGJcDLJiiizb/DxDN81ffCX500o2mDmsTCBDGLg4BWAi9e8YGZ60FxnIBt+8U6wZ
 s/vUmy3pjn2mV7Z9M3IqKxBhEOL1/snwP3BHGUvThJAbj0tVNkpMCRV9N7V3v8D1E58jAudOip8
 yhQkA
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386
X-Rspamd-Queue-Id: 4blv93734kz9st4

Since the introduction of pid namespaces, their interaction with procfs
has been entirely implicit in ways that require a lot of dancing around
by programs that need to construct sandboxes with different PID
namespaces.

Being able to explicitly specify the pid namespace to use when
constructing a procfs super block will allow programs to no longer need
to fork off a process which does then does unshare(2) / setns(2) and
forks again in order to construct a procfs in a pidns.

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 Documentation/filesystems/proc.rst |  6 +++
 fs/proc/root.c                     | 80 +++++++++++++++++++++++++++++++++++---
 2 files changed, 80 insertions(+), 6 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 5236cb52e357..c520b9f8a3fd 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -2360,6 +2360,7 @@ The following mount options are supported:
 	hidepid=	Set /proc/<pid>/ access mode.
 	gid=		Set the group authorized to learn processes information.
 	subset=		Show only the specified subset of procfs.
+	pidns=		Specify a the namespace used by this procfs.
 	=========	========================================================
 
 hidepid=off or hidepid=0 means classic mode - everybody may access all
@@ -2392,6 +2393,11 @@ information about processes information, just add identd to this group.
 subset=pid hides all top level files and directories in the procfs that
 are not related to tasks.
 
+pidns= specifies a pid namespace (either as a string path to something like
+`/proc/$pid/ns/pid`, or a file descriptor when using `FSCONFIG_SET_FD`) that
+will be used by the procfs instance when translating pids. By default, procfs
+will use the calling process's active pid namespace.
+
 Chapter 5: Filesystem behavior
 ==============================
 
diff --git a/fs/proc/root.c b/fs/proc/root.c
index ed86ac710384..10ca94be0eef 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -38,12 +38,14 @@ enum proc_param {
 	Opt_gid,
 	Opt_hidepid,
 	Opt_subset,
+	Opt_pidns,
 };
 
 static const struct fs_parameter_spec proc_fs_parameters[] = {
-	fsparam_u32("gid",	Opt_gid),
+	fsparam_u32("gid",		Opt_gid),
 	fsparam_string("hidepid",	Opt_hidepid),
 	fsparam_string("subset",	Opt_subset),
+	fsparam_file_or_string("pidns",	Opt_pidns),
 	{}
 };
 
@@ -109,11 +111,65 @@ static int proc_parse_subset_param(struct fs_context *fc, char *value)
 	return 0;
 }
 
+static int proc_parse_pidns_param(struct fs_context *fc,
+				  struct fs_parameter *param,
+				  struct fs_parse_result *result)
+{
+	struct proc_fs_context *ctx = fc->fs_private;
+	struct pid_namespace *target, *active = task_active_pid_ns(current);
+	struct ns_common *ns;
+	struct file *ns_filp __free(fput) = NULL;
+
+	switch (param->type) {
+	case fs_value_is_file:
+		/* came throug fsconfig, steal the file reference */
+		ns_filp = param->file;
+		param->file = NULL;
+		break;
+	case fs_value_is_string:
+		ns_filp = filp_open(param->string, O_RDONLY, 0);
+		break;
+	default:
+		WARN_ON_ONCE(true);
+		break;
+	}
+	if (!ns_filp)
+		ns_filp = ERR_PTR(-EBADF);
+	if (IS_ERR(ns_filp)) {
+		errorfc(fc, "could not get file from pidns argument");
+		return PTR_ERR(ns_filp);
+	}
+
+	if (!proc_ns_file(ns_filp))
+		return invalfc(fc, "pidns argument is not an nsfs file");
+	ns = get_proc_ns(file_inode(ns_filp));
+	if (ns->ops->type != CLONE_NEWPID)
+		return invalfc(fc, "pidns argument is not a pidns file");
+	target = container_of(ns, struct pid_namespace, ns);
+
+	/*
+	 * pidns= is shorthand for joining the pidns to get a fsopen fd, so the
+	 * permission model should be the same as pidns_install().
+	 */
+	if (!ns_capable(target->user_ns, CAP_SYS_ADMIN)) {
+		errorfc(fc, "insufficient permissions to set pidns");
+		return -EPERM;
+	}
+	if (!pidns_is_ancestor(target, active))
+		return invalfc(fc, "cannot set pidns to non-descendant pidns");
+
+	put_pid_ns(ctx->pid_ns);
+	ctx->pid_ns = get_pid_ns(target);
+	put_user_ns(fc->user_ns);
+	fc->user_ns = get_user_ns(ctx->pid_ns->user_ns);
+	return 0;
+}
+
 static int proc_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
 	struct proc_fs_context *ctx = fc->fs_private;
 	struct fs_parse_result result;
-	int opt;
+	int opt, err;
 
 	opt = fs_parse(fc, proc_fs_parameters, param, &result);
 	if (opt < 0)
@@ -125,13 +181,21 @@ static int proc_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		break;
 
 	case Opt_hidepid:
-		if (proc_parse_hidepid_param(fc, param))
-			return -EINVAL;
+		err = proc_parse_hidepid_param(fc, param);
+		if (err)
+			return err;
 		break;
 
 	case Opt_subset:
-		if (proc_parse_subset_param(fc, param->string) < 0)
-			return -EINVAL;
+		err = proc_parse_subset_param(fc, param->string);
+		if (err)
+			return err;
+		break;
+
+	case Opt_pidns:
+		err = proc_parse_pidns_param(fc, param, &result);
+		if (err)
+			return err;
 		break;
 
 	default:
@@ -154,6 +218,10 @@ static void proc_apply_options(struct proc_fs_info *fs_info,
 		fs_info->hide_pid = ctx->hidepid;
 	if (ctx->mask & (1 << Opt_subset))
 		fs_info->pidonly = ctx->pidonly;
+	if (ctx->mask & (1 << Opt_pidns)) {
+		put_pid_ns(fs_info->pid_ns);
+		fs_info->pid_ns = get_pid_ns(ctx->pid_ns);
+	}
 }
 
 static int proc_fill_super(struct super_block *s, struct fs_context *fc)

-- 
2.50.0


