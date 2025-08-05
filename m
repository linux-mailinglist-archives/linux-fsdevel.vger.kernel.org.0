Return-Path: <linux-fsdevel+bounces-56721-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EECDBB1ADAE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 07:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C8B4166483
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 05:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A5321ADC6;
	Tue,  5 Aug 2025 05:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="RaeI5DqD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7532C190;
	Tue,  5 Aug 2025 05:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754372746; cv=none; b=pae/mBBfqjSCmSiItEfBnh73aozuDICElFq+JWR/fEreZmaCEEklXdxSQrj19Tqh/x4fF5Z8talafzMNX2DN/99wMASzLKPxg9iarjRjYOqjDnhMGRMv/i52edMLcfbO78BtwMTttZOuNAbpdt/CGzQ3wfjzlEdiK/arU0A180k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754372746; c=relaxed/simple;
	bh=7x0mPvQs3PnM6hnHwlsK0YkdyZQeEL2pqrRNyBv2YRw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o/Mbu1VNph6755EQVQUF4oJ0ENAK35ov51hL3CfqPFZtxRv2LAicwRU38iGOOE6uJomCmxCtHX8To/y5ACfXXBopxxDDxS4b+seekOW7lGB2gjtGl6eb5PSmGjmr3KpGTVetzukYMAX+qEWZGHMAUdzwCpwOWIfUIiu4+JhOPm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=RaeI5DqD; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4bx2TJ48fzz9spD;
	Tue,  5 Aug 2025 07:45:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1754372740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c5r3LUoIJotYAOtHbyXu8/Q2mXiFa0pZX7ipMCHCVe0=;
	b=RaeI5DqDynnMWoB9Pyeut6Ssh45JIVgC0CCIJCsu4UDcS6toKQGEwjDLEnp/8YSPgahq4f
	y7pAsl1IytM63yCsnglN9AA0dHhbZByvRwuODGiSUPfHya4/F0RBP3IyOAN2iSkfiHduC7
	cPcHPOJimiS7/rBorAmYOdCYmduoMYVA5Gqo+86+kGihsQxikwyfratztx+H2BWDkkahQd
	5sjcvfULX1bIqxnS3SnlOcKOgZTOUm27A2KngRCzh7PWd3w0NnI4Oa4qZFJiE0/N1t1+Sr
	oKsZq0SCGiC7m3WFQvuoaWEvcdRSrEtn/+UE1HYd4u3XMwvvT3njBIRtnK4Vzw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Tue, 05 Aug 2025 15:45:09 +1000
Subject: [PATCH v4 2/4] procfs: add "pidns" mount option
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-procfs-pidns-api-v4-2-705f984940e7@cyphar.com>
References: <20250805-procfs-pidns-api-v4-0-705f984940e7@cyphar.com>
In-Reply-To: <20250805-procfs-pidns-api-v4-0-705f984940e7@cyphar.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=7569; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=7x0mPvQs3PnM6hnHwlsK0YkdyZQeEL2pqrRNyBv2YRw=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWRMnJWnyC8rJRpQOvXnRiuzhSy1l1R8tj2UULn8aNLJt
 EPHYorfdJSyMIhxMciKKbJs8/MM3TR/8ZXkTyvZYOawMoEMYeDiFICJvLrI8N9nT9rnT+8ZpXco
 X7xa0rdjvqG0bnPlAXW+VrW11dXX2uoZGU5OMj35pWsC88n3/z7cXiDMaTF32WvGx+2fXbRSHvY
 IbuMBAA==
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386
X-Rspamd-Queue-Id: 4bx2TJ48fzz9spD

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
 Documentation/filesystems/proc.rst |  8 ++++
 fs/proc/root.c                     | 98 +++++++++++++++++++++++++++++++++++---
 2 files changed, 100 insertions(+), 6 deletions(-)

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
index ed86ac710384..fd1f1c8a939a 100644
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
 
@@ -109,11 +111,66 @@ static int proc_parse_subset_param(struct fs_context *fc, char *value)
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
+		/* came through fsconfig, steal the file reference */
+		ns_filp = no_free_ptr(param->file);
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
@@ -125,14 +182,38 @@ static int proc_parse_param(struct fs_context *fc, struct fs_parameter *param)
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
+#ifdef CONFIG_PID_NS
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
 		break;
+#else
+		errorfc(fc, "pidns mount flag not supported on this system");
+		return -EOPNOTSUPP;
+#endif
 
 	default:
 		return -EINVAL;
@@ -154,6 +235,11 @@ static void proc_apply_options(struct proc_fs_info *fs_info,
 		fs_info->hide_pid = ctx->hidepid;
 	if (ctx->mask & (1 << Opt_subset))
 		fs_info->pidonly = ctx->pidonly;
+	if (ctx->mask & (1 << Opt_pidns) &&
+	    !WARN_ON_ONCE(fc->purpose == FS_CONTEXT_FOR_RECONFIGURE)) {
+		put_pid_ns(fs_info->pid_ns);
+		fs_info->pid_ns = get_pid_ns(ctx->pid_ns);
+	}
 }
 
 static int proc_fill_super(struct super_block *s, struct fs_context *fc)

-- 
2.50.1


