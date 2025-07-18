Return-Path: <linux-fsdevel+bounces-55410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C763CB09E4F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 10:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 741E03B7C92
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 08:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178D01D7E5B;
	Fri, 18 Jul 2025 08:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="STiIPFCj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pf-012.whm.fr-par.scw.cloud (pf-012.whm.fr-par.scw.cloud [51.159.173.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506181D5CE8;
	Fri, 18 Jul 2025 08:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.173.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752828486; cv=none; b=XGOsiKlIfvrFvZ0bk4BS4pwUhth1IQiOIMG4LTfucrGjjZIWcxNYRAE7S+RAMZg5TRc0ALzMn2wZjy70iy7bvkTyOz/EhwcI++fPTB4XBSvvEa2qcxg1i87QpaBCz2yaw/978ak1b9gGdAQ2mdehnsi3kEWei7KcTKsfpZ7Y1vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752828486; c=relaxed/simple;
	bh=8hy2yyvZx6FxQeyR3HNQsV8og+N8sHyKJHBj23jeA5E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nHjiR22mUC/ucduOLz1x5QVLOHJyhuSPP81HTk0oJM8i+7nyEVo9xqCUxt53mOi1gNsUa4f5QDjre6WK3TYIVkIuD8rN7eEesxvPezjGhmlNmnJgz3dmMmuOSjFweutHxPeZIzBhWUQXE7/KjG8iv89Us/dOpKyqRZNmsavuPiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=STiIPFCj; arc=none smtp.client-ip=51.159.173.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Cc:To:Message-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rqaksRoeBQ/rOsz0sSuD0wr7LiuTmXSEVKm8NzN3ArE=; b=STiIPFCjCLXKi8Ike1koZKBeAC
	XBC4neeS1xgsXNcI5Q6iaXoclKwZ17/8I8BHeMs8hpFE1lCAk37/NqSXT5+gkWyFWNe+5Qy1Wm8lk
	z2ZPelYnfDK09sue7eOkB77LP1jms4fk7pDpu1Sijau3z9W2Rsb9/E5gws+mg2h19ybKRFAyJw8bj
	k/4kO5Qb/Pf2xqvg12sv4Vb8zBc6zigVjb1KFM5M3nGPQJFm7KLfPHfu0DD+igKwvJNnOc3yK4dDQ
	iEX/CdngufCyyT9AbCX4cAx32lR0lco0uDMBMCFA08ciEC6wR+EUohNe/BIlZvaPq6gniu9VIz7y1
	AE3AaP1w==;
Received: from laubervilliers-658-1-215-187.w90-63.abo.wanadoo.fr ([90.63.246.187]:15123 helo=archlinux.local)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <nicolas.bouchinet@oss.cyber.gouv.fr>)
	id 1ucgl8-00000009zAE-2Om5;
	Fri, 18 Jul 2025 10:48:02 +0200
From: nicolas.bouchinet@oss.cyber.gouv.fr
Date: Fri, 18 Jul 2025 10:47:48 +0200
Subject: [PATCH] fs: hidepid: Fixes hidepid non dumpable behavior
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250718-hidepid_fix-v1-1-3fd5566980bc@ssi.gouv.fr>
X-B4-Tracking: v=1; b=H4sIADMKemgC/x2MQQqAMAzAvjJ6dlDnxsSviIjYqr3o2EAE2d8tH
 hNIXiichQsM5oXMtxS5ToW2MbAey7mzFVIGhy5gbHt7CHESmjd5LGH0HWHwyBG0SJlV/7dxqvU
 D+Ewn5F0AAAA=
X-Change-ID: 20250718-hidepid_fix-d0743d0540e7
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, 
 Olivier Bal-Petre <olivier.bal-petre@oss.cyber.gouv.fr>, 
 Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
X-Mailer: b4 0.14.2
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: nicolas.bouchinet@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: nicolas.bouchinet@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>

The hidepid mount option documentation defines the following modes:

- "noaccess": user may not access any `/proc/<pid>/ directories but
  their own.
- "invisible": all `/proc/<pid>/` will be fully invisible to other users.
- "ptraceable": means that procfs should only contain `/proc/<pid>/`
  directories that the caller can ptrace.

We thus expect that with "noaccess" and "invisible" users would be able to
see their own processes in `/proc/<pid>/`.

The implementation of hidepid however control accesses using the
`ptrace_may_access()` function in any cases. Thus, if a process set
itself as non-dumpable using the `prctl(PR_SET_DUMPABLE,
SUID_DUMP_DISABLE)` it becomes invisible to the user.

This patch fixes the `has_pid_permissions()` function in order to make
its behavior to match the documentation.

Note that since `ptrace_may_access()` is not called anymore with
"noaccess" and "invisible", the `security_ptrace_access_check()` will no
longer be called either.

Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
---
 fs/proc/base.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index c667702dc69b8ca2531e88e12ed7a18533f294dd..fb128cb5f95fe65016fce96c75aee18c762a30f2 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -746,9 +746,12 @@ static bool has_pid_permissions(struct proc_fs_info *fs_info,
 				 struct task_struct *task,
 				 enum proc_hidepid hide_pid_min)
 {
+	const struct cred *cred = current_cred(), *tcred;
+	kuid_t caller_uid;
+	kgid_t caller_gid;
 	/*
-	 * If 'hidpid' mount option is set force a ptrace check,
-	 * we indicate that we are using a filesystem syscall
+	 * If 'hidepid=ptraceable' mount option is set, force a ptrace check.
+	 * We indicate that we are using a filesystem syscall
 	 * by passing PTRACE_MODE_READ_FSCREDS
 	 */
 	if (fs_info->hide_pid == HIDEPID_NOT_PTRACEABLE)
@@ -758,7 +761,25 @@ static bool has_pid_permissions(struct proc_fs_info *fs_info,
 		return true;
 	if (in_group_p(fs_info->pid_gid))
 		return true;
-	return ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS);
+
+	task_lock(task);
+	rcu_read_lock();
+	caller_uid = cred->fsuid;
+	caller_gid = cred->fsgid;
+	tcred = __task_cred(task);
+	if (uid_eq(caller_uid, tcred->euid) &&
+	    uid_eq(caller_uid, tcred->suid) &&
+	    uid_eq(caller_uid, tcred->uid)  &&
+	    gid_eq(caller_gid, tcred->egid) &&
+	    gid_eq(caller_gid, tcred->sgid) &&
+	    gid_eq(caller_gid, tcred->gid)) {
+		rcu_read_unlock();
+		task_unlock(task);
+		return true;
+	}
+	rcu_read_unlock();
+	task_unlock(task);
+	return false;
 }
 
 

---
base-commit: 884a80cc9208ce75831b2376f2b0464018d7f2c4
change-id: 20250718-hidepid_fix-d0743d0540e7

Best regards,
-- 
Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>


