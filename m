Return-Path: <linux-fsdevel+bounces-55934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA8CB1039C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 10:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80ED31C80962
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 08:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243CD2750F4;
	Thu, 24 Jul 2025 08:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="RgVhC88L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3922727F8;
	Thu, 24 Jul 2025 08:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753345958; cv=none; b=Em6r8x1mc8VwWLNSwexkLzeYRM2At/JPrCR4mNzpStUKDY5mC9N6BwKA8CUa1Kw71REQtBFtCuxheaeeI1986xM3393gXka6yiO9a3ESKsQcBuOauJRP68E8Q6qbj0aG7POIEDXrfvq3XYn5VwEKe5jApxB0JWlvlYArB64cels=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753345958; c=relaxed/simple;
	bh=WR2Yjuz8Mc/vXG9KvxrS5QXxToTR5cQK70jR9IK+U0Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I7oG+HHvvG4bA+sQEdGWm85l45JcYJtz90N6mtcG2YE0cF3DqKwXdXgbhPcTFVqlWii+MyE8e4bINTAP83RUuDGSae5tFZf2LsVa2Zdxx2+uwydDlPMnrmRd0BPNVCTPEXA5NaAdbqhdDNboFxq3HOiFZNJXXxjyaXFWQAreUKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=RgVhC88L; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bnklM68lbz9slG;
	Thu, 24 Jul 2025 10:32:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1753345951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rl5yvqTtnRR//NXgj32CA5MMFGAzw4ESehbikqsVXv0=;
	b=RgVhC88Ld673w7DV9RCIcveV70tUsUHdyAVFp1vBEoGeOPgJmwiIb3rqkhUUxJxRX+goLe
	ZbiQHcglXOZ16byKSg5b9s7NqIkiIjOtlcjWQeO0a1IDz6G7AgIv/ppi3niRDFwTiR8bD4
	7FbPxdBM3JPFOJotFGx59TwPRyE1yQZNCHRGFWLJmBonTbDpZpUnVClot0TOUrZ9AXjOTy
	WfVbsoMRx9ciPD60yJB7MVZB92b1N3HJ6PqIr5DwgUvlcI2xJpikgsf54BKt1sU6dIRw2K
	rRxSAcZydpegmd2j9eVC9E3IaptdsI6ICVTaa6IcxTmg6hTnJeGIVkZhzAZxUw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Thu, 24 Jul 2025 18:32:04 +1000
Subject: [PATCH v3 2/4] procfs: add "pidns" mount option
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250724-procfs-pidns-api-v3-2-4c685c910923@cyphar.com>
References: <20250724-procfs-pidns-api-v3-0-4c685c910923@cyphar.com>
In-Reply-To: <20250724-procfs-pidns-api-v3-0-4c685c910923@cyphar.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=7582; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=WR2Yjuz8Mc/vXG9KvxrS5QXxToTR5cQK70jR9IK+U0Q=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWQ0vu+sltpY2FoUwDDjcuhTzplCxfw9x5QeFif3Nkad3
 1g7c+qqjlIWBjEuBlkxRZZtfp6hm+YvvpL8aSUbzBxWJpAhDFycAjCRmp+MDK8knY2qFxVO+LtQ
 mam8X+CitUBfxUZrjvd+Ya0f+QLbGhj+GRgba87e6RA/5U1Nl/u0Jz4yzyRW5x0yWqT+cW9Zn28
 gEwA=
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386
X-Rspamd-Queue-Id: 4bnklM68lbz9slG

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

In order to avoid having to RCU-protect all users of proc_pid_ns() (to
avoid UAFs), attempting to reconfigure an existing procfs instance's pid
namespace will error out with -EBUSY. Creating new procfs instances is
quite cheap, so this should not be an impediment to most users, and lets
us avoid a lot of churn in fs/proc/* for a feature that it seems
unlikely userspace would use.

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 Documentation/filesystems/proc.rst |   8 +++
 fs/proc/root.c                     | 102 ++++++++++++++++++++++++++++++++++---
 2 files changed, 104 insertions(+), 6 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 5236cb52e357..5a157dadea0b 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -2360,6 +2360,7 @@ The following mount options are supported:
 	hidepid=	Set /proc/<pid>/ access mode.
 	gid=		Set the group authorized to learn processes information.
 	subset=		Show only the specified subset of procfs.
+	pidns=		Specify a the namespace used by this procfs.
 	=========	========================================================
 
 hidepid=off or hidepid=0 means classic mode - everybody may access all
@@ -2392,6 +2393,13 @@ information about processes information, just add identd to this group.
 subset=pid hides all top level files and directories in the procfs that
 are not related to tasks.
 
+pidns= specifies a pid namespace (either as a string path to something like
+`/proc/$pid/ns/pid`, or a file descriptor when using `FSCONFIG_SET_FD`) that
+will be used by the procfs instance when translating pids. By default, procfs
+will use the calling process's active pid namespace. Note that the pid
+namespace of an existing procfs instance cannot be modified (attempting to do
+so will give an `-EBUSY` error).
+
 Chapter 5: Filesystem behavior
 ==============================
 
diff --git a/fs/proc/root.c b/fs/proc/root.c
index ed86ac710384..22f8b10f6265 100644
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
@@ -125,15 +187,36 @@ static int proc_parse_param(struct fs_context *fc, struct fs_parameter *param)
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
 		break;
 
+#ifdef CONFIG_PID_NS
+	case Opt_pidns:
+		/*
+		 * We would have to RCU-protect every proc_pid_ns() or
+		 * proc_sb_info() access if we allowed this to be reconfigured
+		 * for an existing procfs instance. Luckily, procfs instances
+		 * are cheap to create, and mount-beneath would let you
+		 * atomically replace an instance even with overmounts.
+		 */
+		if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE) {
+			errorfc(fc, "cannot reconfigure pidns for existing procfs");
+			return -EBUSY;
+		}
+		err = proc_parse_pidns_param(fc, param, &result);
+		if (err)
+			return err;
+		break;
+#endif
+
 	default:
 		return -EINVAL;
 	}
@@ -154,6 +237,13 @@ static void proc_apply_options(struct proc_fs_info *fs_info,
 		fs_info->hide_pid = ctx->hidepid;
 	if (ctx->mask & (1 << Opt_subset))
 		fs_info->pidonly = ctx->pidonly;
+#ifdef CONFIG_PID_NS
+	if (ctx->mask & (1 << Opt_pidns) &&
+	    !WARN_ON_ONCE(fc->purpose == FS_CONTEXT_FOR_RECONFIGURE)) {
+		put_pid_ns(fs_info->pid_ns);
+		fs_info->pid_ns = get_pid_ns(ctx->pid_ns);
+	}
+#endif
 }
 
 static int proc_fill_super(struct super_block *s, struct fs_context *fc)

-- 
2.50.0


