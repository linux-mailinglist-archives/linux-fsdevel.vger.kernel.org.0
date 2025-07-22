Return-Path: <linux-fsdevel+bounces-55766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4247B0E712
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 01:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06FBD562738
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 23:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7D928C86F;
	Tue, 22 Jul 2025 23:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="krl84KTJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10AE28C849;
	Tue, 22 Jul 2025 23:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753226377; cv=none; b=X0up+SVmTHqp0zf+0ce809otmclQgL9BI4yvUYQnlVcNjOAsrAoSoXg1Exu9FEID2uipozzDD1iGAU+Lb6E3bddKUQ8rCdrGljhRzY2lHmHp91rGIlqJpV8jdYoF8K/jqIeZgtADcFf3l9jOqJlBC+5j0IPhMbyucsr9mABpwVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753226377; c=relaxed/simple;
	bh=h32AkQqTQFMtDpPn/hB2iPuVrm4SLK7xkXiKfkcX7CE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RpWFwZOu/z6hxKPS+A0+dCZTNW38fvNUAiSu2+AwyKCZYgNWi1zMzSARwnltSY6CLOb+NwlvzKl1tCPau5CtXvjiRWxeWxeoJYaCVzIs5x4o9ggXE/rVjSIGrh1xc8CBCyR7TxplZNi//XXA3bL5k3Ofsk9edSTS2ts/cMtG2Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=krl84KTJ; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bmtWm1zHFz9sbL;
	Wed, 23 Jul 2025 01:19:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1753226372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8dffB/8g2jqxD1gkKKuu1Q7Sx0KA5pcUHUZQ8HGfuW8=;
	b=krl84KTJ0uBg/wZAWfhIJ1pCXOuDXcYGNcNCboWGRUvLDqmJuvIeOnOC1EugoIqV291VtH
	JuSh7IQoSEnG9Dp9jz6vciWPvCPgdG2J1jcyPx9K5AlqyPQ/sAyo2LM6/vZbfu6oXSpfyC
	6Ftt7i2LX9jUmQatxUezLVP+JO/YLTb5YvKEN/6aeIdBT6uLxPoCQeT1nJYDs7tPKgQLgG
	WdHUAiQ1pHyfTdNs74dRHZAugVGzAVj18mFvqfaRtiPv7eUYJwNJksUYs+QsVvl3sXtWpu
	yQEvKwkj1h7cnWz7Lo21lBM8m2DS/NMW9UGAi9xJO7eZB9N0NQGSkX1g7BoeGA==
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Wed, 23 Jul 2025 09:18:52 +1000
Subject: [PATCH RFC v2 2/4] procfs: add "pidns" mount option
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-procfs-pidns-api-v2-2-621e7edd8e40@cyphar.com>
References: <20250723-procfs-pidns-api-v2-0-621e7edd8e40@cyphar.com>
In-Reply-To: <20250723-procfs-pidns-api-v2-0-621e7edd8e40@cyphar.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-api@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6674; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=h32AkQqTQFMtDpPn/hB2iPuVrm4SLK7xkXiKfkcX7CE=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWQ0yOTnPH/7d6e13KXn0/+FTdX22uvVFi4m6dYluTeyQ
 /bM4i95HaUsDGJcDLJiiizb/DxDN81ffCX500o2mDmsTCBDGLg4BWAiC0MYGXa8stQ1PcW0ZIG9
 z1Kb3ywKslXb8+IyzWc9frNrmrT9DmeG/+EP5neHJB3tX32p4pp2ke0mzzYNgUrvRi7lGtuGKfM
 nMgMA
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386

Since the introduction of pid namespaces, their interaction with procfs
has been entirely implicit in ways that require a lot of dancing around
by programs that need to construct sandboxes with different PID
namespaces.

Being able to explicitly specify the pid namespace to use when
constructing a procfs super block will allow programs to no longer need
to fork off a process which does then does unshare(2) / setns(2) and
forks again in order to construct a procfs in a pidns.

So, provide a "pidns" mount option which allows such users to just
explicitly state which pid namespace they want that procfs instance to
use. This interface can be used with fsconfig(2) either with a file
descriptor or a path:

  fsconfig(procfd, FSCONFIG_SET_FD, "pidns", NULL, nsfd);
  fsconfig(procfd, FSCONFIG_SET_STRING, "pidns", "/proc/self/ns/pid", 0);

or with classic mount(2) / mount(8):

  // mount -t proc -o pidns=/proc/self/ns/pid proc /tmp/proc
  mount("proc", "/tmp/proc", "proc", MS_..., "pidns=/proc/self/ns/pid");

As this new API is effectively shorthand for setns(2) followed by
mount(2), the permission model for this mirrors pidns_install() to avoid
opening up new attack surfaces by loosening the existing permission
model.

Note that the mount infrastructure also allows userspace to reconfigure
the pidns of an existing procfs mount, which may or may not be useful to
some users.

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 Documentation/filesystems/proc.rst |  6 +++
 fs/proc/root.c                     | 90 +++++++++++++++++++++++++++++++++++---
 2 files changed, 90 insertions(+), 6 deletions(-)

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
index ed86ac710384..057c8a125c6e 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -38,12 +38,18 @@ enum proc_param {
 	Opt_gid,
 	Opt_hidepid,
 	Opt_subset,
+#ifdef CONFIG_PID_NS
+	Opt_pidns,
+#endif
 };
 
 static const struct fs_parameter_spec proc_fs_parameters[] = {
-	fsparam_u32("gid",	Opt_gid),
+	fsparam_u32("gid",		Opt_gid),
 	fsparam_string("hidepid",	Opt_hidepid),
 	fsparam_string("subset",	Opt_subset),
+#ifdef CONFIG_PID_NS
+	fsparam_file_or_string("pidns",	Opt_pidns),
+#endif
 	{}
 };
 
@@ -109,11 +115,67 @@ static int proc_parse_subset_param(struct fs_context *fc, char *value)
 	return 0;
 }
 
+#ifdef CONFIG_PID_NS
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
+#endif /* CONFIG_PID_NS */
+
 static int proc_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
 	struct proc_fs_context *ctx = fc->fs_private;
 	struct fs_parse_result result;
-	int opt;
+	int opt, err;
 
 	opt = fs_parse(fc, proc_fs_parameters, param, &result);
 	if (opt < 0)
@@ -125,14 +187,24 @@ static int proc_parse_param(struct fs_context *fc, struct fs_parameter *param)
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
+#ifdef CONFIG_PID_NS
+	case Opt_pidns:
+		err = proc_parse_pidns_param(fc, param, &result);
+		if (err)
+			return err;
 		break;
+#endif
 
 	default:
 		return -EINVAL;
@@ -154,6 +226,12 @@ static void proc_apply_options(struct proc_fs_info *fs_info,
 		fs_info->hide_pid = ctx->hidepid;
 	if (ctx->mask & (1 << Opt_subset))
 		fs_info->pidonly = ctx->pidonly;
+#ifdef CONFIG_PID_NS
+	if (ctx->mask & (1 << Opt_pidns)) {
+		put_pid_ns(fs_info->pid_ns);
+		fs_info->pid_ns = get_pid_ns(ctx->pid_ns);
+	}
+#endif
 }
 
 static int proc_fill_super(struct super_block *s, struct fs_context *fc)

-- 
2.50.0


