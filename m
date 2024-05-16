Return-Path: <linux-fsdevel+bounces-19573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2299E8C73AC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 11:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A18621F21602
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 09:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A99143878;
	Thu, 16 May 2024 09:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=3xx0.net header.i=@3xx0.net header.b="V7TZcx8W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kOYwKGKc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow7-smtp.messagingengine.com (flow7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DCE14386A;
	Thu, 16 May 2024 09:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715851289; cv=none; b=X5Egfs7AmdZuw6o80OZyBjn0/AJ38dw623t3nyg4sJf+aEgESlEzZ8vrAWt/E6roHcL22lOF9fBXShJf7NzopgtdngefOnGYxFZ4T5LMHEFheGFSq2NQPly4S230plsiUID7QMcoLputzyuz0BV7rs/TJ9tOW3k6PUsdzKqGfDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715851289; c=relaxed/simple;
	bh=Hr76OlKl3SP62o9nnG226zhHiGSCGjsCWFsUNe4kp6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PHMaLagpaAPJXzDSqHSmLQmgcYFZ1WrpTlc7BU4srOnlBZzlq0FDq0WYyfDXHjO/CdpD/vsVJfsyxfF1U0nUen/uZOdag+8y9Wmi1e9OcAGWfuf6qfYL5+MMd1xj2o2M0OuSNWB520Ldgpkw85c3bDUVTi0k7ra39DeZAbk4YR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3xx0.net; spf=pass smtp.mailfrom=3xx0.net; dkim=pass (2048-bit key) header.d=3xx0.net header.i=@3xx0.net header.b=V7TZcx8W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kOYwKGKc; arc=none smtp.client-ip=103.168.172.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3xx0.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3xx0.net
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailflow.nyi.internal (Postfix) with ESMTP id 3FAE5200436;
	Thu, 16 May 2024 05:21:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 16 May 2024 05:21:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=3xx0.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1715851287;
	 x=1715854887; bh=TZjOnb0H5vnFoLCsEWXTKcw89E4EnJrXebH7gGAIs9k=; b=
	V7TZcx8W2+KzAtGpTNZzqcpJp3Y0dmalztN7Er6atXZKKBW3FzoYzc9GUz8Y0ht4
	UgFVNsX7IsSSwM3bw+UT3L4xffgaI/njNt9S6RUBe4UxOJ5ev7N4O1KVVOI4DzCp
	MN6VbN4ciigV5EiuupFrqls2BsodZxAKFhLhxIXplpA76C9+JFxhB0gxicYU19Uj
	tbS7/AgH+LrR0qsnY2U2b6TPwMTGyJflJmkWDi44d3PSKiyhE46ZBQPxk6TK/omJ
	LZxBjAOh+5VeusKWl7lY1bDIJZAdFxGVkcJKZyRP1D5x/wmm92vxhtotJhkKgAEo
	fy54WgTSh842s/DtpHG0jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=i76614979.fm3; t=
	1715851287; x=1715854887; bh=TZjOnb0H5vnFoLCsEWXTKcw89E4EnJrXebH
	7gGAIs9k=; b=kOYwKGKcUlH6c9syVE4bN+2q1wSRmryV66C7lKvUspPiYMZ2yTj
	JsC0w3Gyo+rlfcVyaqg2ebJLXv91ME+6ioG0I6oH2VOfUZ9MqiKFbviMtsUjf2Y1
	Mpew/mbA3cEthBHH837dKIuOZRdR4H6RWzbV9hWeuoxUMjVrWr5VPvrlFjyjEJb7
	hXmqG0gKTmySmptxIUJjO3M4Ojuuhj+CrzWWSz6/9w1NOoHvseUAthr7NVi92DTG
	n3UsV2yVuZa4d5LA2lmwFKYst2uTHLQgxh3L3JqpnY0pwnzFbIclXWNccMKqphao
	d7Ug6MmbaK6aTZaAiKVTLajpjgWvbUdpj5A==
X-ME-Sender: <xms:FtBFZjLNbpS14SOQRleoW7bKklKeIPkefpVJj-W2pNQUt1Frs03sBw>
    <xme:FtBFZnJmlo2jniiFzKCNk7c6bFL9hmgk1rUf1I4AyvdKNLv3plnE_nih6EfbXqmSp
    Qzs0w06Fbu7bz3Sgqo>
X-ME-Received: <xmr:FtBFZrtijK0m2dC_8pynNr8NR5wljqRX3qLG585UAPHFgoqrskLh8NWG-MPuqrfHDDcNGFG1Znv5cLWAIHlwCDu-w0KwVd0r725iNOPrli9LdQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehuddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeflohhn
    rghthhgrnhcuvegrlhhmvghlshcuoehjtggrlhhmvghlshesfeiggidtrdhnvghtqeenuc
    ggtffrrghtthgvrhhnpeeftdeutdejieffledtteeikeetkeehuefgtefghfevjefftdff
    jeegtedvkeethfenucffohhmrghinhepghhoohhglhgvsghlohhgrdgtohhmpdhkvghrnh
    gvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehjtggrlhhmvghlshesfeiggidtrdhnvght
X-ME-Proxy: <xmx:FtBFZsZ3wXhPLvB9m6YJ8sYrMIzQAowlfqVpmML_TdSy-PnG1xFNzg>
    <xmx:FtBFZqanx5aZOH5rt0R2xLcrre3zBI3KXM5W9Io-EtCAmt2ue023Dg>
    <xmx:FtBFZgAikJWSPVwj72FL2K4H3aX9yCxdgEPDMu5mYQ0iFo84KR01ag>
    <xmx:FtBFZoYLiPfBqGIHbd99su8p-5e7qFw5dHjHtnbk2_2G5HeTM9_yrQ>
    <xmx:FtBFZiqDLEA5vvHmkSNNrwt_pW-ZylAIJZrsbU6Yl7iYxIShPJfLkZo1>
Feedback-ID: i76614979:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 May 2024 05:21:25 -0400 (EDT)
From: Jonathan Calmels <jcalmels@3xx0.net>
To: brauner@kernel.org,
	ebiederm@xmission.com,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Joel Granados <j.granados@samsung.com>,
	Serge Hallyn <serge@hallyn.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: containers@lists.linux.dev,
	Jonathan Calmels <jcalmels@3xx0.net>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	keyrings@vger.kernel.org
Subject: [PATCH 1/3] capabilities: user namespace capabilities
Date: Thu, 16 May 2024 02:22:03 -0700
Message-ID: <20240516092213.6799-2-jcalmels@3xx0.net>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240516092213.6799-1-jcalmels@3xx0.net>
References: <20240516092213.6799-1-jcalmels@3xx0.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Attackers often rely on user namespaces to get elevated (yet confined)
privileges in order to target specific subsystems (e.g. [1]). Distributions
have been pretty adamant that they need a way to configure these, most of
them carry out-of-tree patches to do so, or plainly refuse to enable them.
As a result, there have been multiple efforts over the years to introduce
various knobs to control and/or disable user namespaces (e.g. [2][3][4]).

While we acknowledge that there are already ways to control the creation of
such namespaces (the most recent being a LSM hook), there are inherent
issues with these approaches. Preventing the user namespace creation is not
fine-grained enough, and in some cases, incompatible with various userspace
expectations (e.g. container runtimes, browser sandboxing, service
isolation)

This patch addresses these limitations by introducing an additional
capability set used to restrict the permissions granted when creating user
namespaces. This way, processes can apply the principle of least privilege
by configuring only the capabilities they need for their namespaces.

For compatibility reasons, processes always start with a full userns
capability set.

On namespace creation, the userns capability set (pU) is assigned to the
new effective (pE), permitted (pP) and bounding set (X) of the task:

    pU = pE = pP = X

The userns capability set obeys the invariant that no bit can ever be set
if it is not already part of the task’s bounding set. This ensures that no
namespace can ever gain more privileges than its predecessors.
Additionally, if a task is not privileged over CAP_SETPCAP, setting any bit
in the userns set requires its corresponding bit to be set in the permitted
set. This effectively mimics the inheritable set rules and means that, by
default, only root in the initial user namespace can gain userns
capabilities:

    p’U = (pE & CAP_SETPCAP) ? X : (X & pP)

Note that since userns capabilities are strictly hierarchical, policies can
be enforced at various levels (e.g. init, pam_cap) and inherited by every
child namespace.

Here is a sample program that can be used to verify the functionality:

/*
 * Test program that drops CAP_SYS_RAWIO from subsequent user namespaces.
 *
 * ./cap_userns_test unshare -r grep Cap /proc/self/status
 * CapInh: 0000000000000000
 * CapPrm: 000001fffffdffff
 * CapEff: 000001fffffdffff
 * CapBnd: 000001fffffdffff
 * CapAmb: 0000000000000000
 * CapUNs: 000001fffffdffff
 */

int main(int argc, char *argv[])
{
        if (prctl(PR_CAP_USERNS, PR_CAP_USERNS_LOWER, CAP_SYS_RAWIO, 0, 0) < 0)
                err(1, "cannot drop userns cap");

        execvp(argv[1], argv + 1);
        err(1, "cannot exec");
}

Link: https://security.googleblog.com/2023/06/learnings-from-kctf-vrps-42-linux.html
Link: https://lore.kernel.org/lkml/1453502345-30416-1-git-send-email-keescook@chromium.org
Link: https://lore.kernel.org/lkml/20220815162028.926858-1-fred@cloudflare.com
Link: https://lore.kernel.org/containers/168547265011.24337.4306067683997517082-0@git.sr.ht

Signed-off-by: Jonathan Calmels <jcalmels@3xx0.net>
---
 fs/proc/array.c              |  9 ++++++
 include/linux/cred.h         |  3 ++
 include/uapi/linux/prctl.h   |  7 +++++
 kernel/cred.c                |  3 ++
 kernel/umh.c                 | 16 ++++++++++
 kernel/user_namespace.c      | 12 +++-----
 security/commoncap.c         | 59 ++++++++++++++++++++++++++++++++++++
 security/keys/process_keys.c |  3 ++
 8 files changed, 105 insertions(+), 7 deletions(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index 34a47fb0c57f..364e8bb19f9d 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -313,6 +313,9 @@ static inline void task_cap(struct seq_file *m, struct task_struct *p)
 	const struct cred *cred;
 	kernel_cap_t cap_inheritable, cap_permitted, cap_effective,
 			cap_bset, cap_ambient;
+#ifdef CONFIG_USER_NS
+	kernel_cap_t cap_userns;
+#endif
 
 	rcu_read_lock();
 	cred = __task_cred(p);
@@ -321,6 +324,9 @@ static inline void task_cap(struct seq_file *m, struct task_struct *p)
 	cap_effective	= cred->cap_effective;
 	cap_bset	= cred->cap_bset;
 	cap_ambient	= cred->cap_ambient;
+#ifdef CONFIG_USER_NS
+	cap_userns	= cred->cap_userns;
+#endif
 	rcu_read_unlock();
 
 	render_cap_t(m, "CapInh:\t", &cap_inheritable);
@@ -328,6 +334,9 @@ static inline void task_cap(struct seq_file *m, struct task_struct *p)
 	render_cap_t(m, "CapEff:\t", &cap_effective);
 	render_cap_t(m, "CapBnd:\t", &cap_bset);
 	render_cap_t(m, "CapAmb:\t", &cap_ambient);
+#ifdef CONFIG_USER_NS
+	render_cap_t(m, "CapUNs:\t", &cap_userns);
+#endif
 }
 
 static inline void task_seccomp(struct seq_file *m, struct task_struct *p)
diff --git a/include/linux/cred.h b/include/linux/cred.h
index 2976f534a7a3..adab0031443e 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -124,6 +124,9 @@ struct cred {
 	kernel_cap_t	cap_effective;	/* caps we can actually use */
 	kernel_cap_t	cap_bset;	/* capability bounding set */
 	kernel_cap_t	cap_ambient;	/* Ambient capability set */
+#ifdef CONFIG_USER_NS
+	kernel_cap_t	cap_userns;	/* User namespace capability set */
+#endif
 #ifdef CONFIG_KEYS
 	unsigned char	jit_keyring;	/* default keyring to attach requested
 					 * keys to */
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 370ed14b1ae0..e09475171f62 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -198,6 +198,13 @@ struct prctl_mm_map {
 # define PR_CAP_AMBIENT_LOWER		3
 # define PR_CAP_AMBIENT_CLEAR_ALL	4
 
+/* Control the userns capability set */
+#define PR_CAP_USERNS			48
+# define PR_CAP_USERNS_IS_SET		1
+# define PR_CAP_USERNS_RAISE		2
+# define PR_CAP_USERNS_LOWER		3
+# define PR_CAP_USERNS_CLEAR_ALL	4
+
 /* arm64 Scalable Vector Extension controls */
 /* Flag values must be kept in sync with ptrace NT_ARM_SVE interface */
 #define PR_SVE_SET_VL			50	/* set task vector length */
diff --git a/kernel/cred.c b/kernel/cred.c
index 075cfa7c896f..9912c6f3bc6b 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -56,6 +56,9 @@ struct cred init_cred = {
 	.cap_permitted		= CAP_FULL_SET,
 	.cap_effective		= CAP_FULL_SET,
 	.cap_bset		= CAP_FULL_SET,
+#ifdef CONFIG_USER_NS
+	.cap_userns		= CAP_FULL_SET,
+#endif
 	.user			= INIT_USER,
 	.user_ns		= &init_user_ns,
 	.group_info		= &init_groups,
diff --git a/kernel/umh.c b/kernel/umh.c
index 1b13c5d34624..51f1e1d25d49 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -32,6 +32,9 @@
 
 #include <trace/events/module.h>
 
+#ifdef CONFIG_USER_NS
+static kernel_cap_t usermodehelper_userns = CAP_FULL_SET;
+#endif
 static kernel_cap_t usermodehelper_bset = CAP_FULL_SET;
 static kernel_cap_t usermodehelper_inheritable = CAP_FULL_SET;
 static DEFINE_SPINLOCK(umh_sysctl_lock);
@@ -94,6 +97,10 @@ static int call_usermodehelper_exec_async(void *data)
 	new->cap_bset = cap_intersect(usermodehelper_bset, new->cap_bset);
 	new->cap_inheritable = cap_intersect(usermodehelper_inheritable,
 					     new->cap_inheritable);
+#ifdef CONFIG_USER_NS
+	new->cap_userns = cap_intersect(usermodehelper_userns,
+					new->cap_userns);
+#endif
 	spin_unlock(&umh_sysctl_lock);
 
 	if (sub_info->init) {
@@ -560,6 +567,15 @@ static struct ctl_table usermodehelper_table[] = {
 		.mode		= 0600,
 		.proc_handler	= proc_cap_handler,
 	},
+#ifdef CONFIG_USER_NS
+	{
+		.procname	= "userns",
+		.data		= &usermodehelper_userns,
+		.maxlen		= 2 * sizeof(unsigned long),
+		.mode		= 0600,
+		.proc_handler	= proc_cap_handler,
+	},
+#endif
 	{ }
 };
 
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 0b0b95418b16..7e624607330b 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -42,15 +42,13 @@ static void dec_user_namespaces(struct ucounts *ucounts)
 
 static void set_cred_user_ns(struct cred *cred, struct user_namespace *user_ns)
 {
-	/* Start with the same capabilities as init but useless for doing
-	 * anything as the capabilities are bound to the new user namespace.
-	 */
-	cred->securebits = SECUREBITS_DEFAULT;
+	/* Start with the capabilities defined in the userns set. */
+	cred->cap_bset = cred->cap_userns;
+	cred->cap_permitted = cred->cap_userns;
+	cred->cap_effective = cred->cap_userns;
 	cred->cap_inheritable = CAP_EMPTY_SET;
-	cred->cap_permitted = CAP_FULL_SET;
-	cred->cap_effective = CAP_FULL_SET;
 	cred->cap_ambient = CAP_EMPTY_SET;
-	cred->cap_bset = CAP_FULL_SET;
+	cred->securebits = SECUREBITS_DEFAULT;
 #ifdef CONFIG_KEYS
 	key_put(cred->request_key_auth);
 	cred->request_key_auth = NULL;
diff --git a/security/commoncap.c b/security/commoncap.c
index 162d96b3a676..b3d3372bf910 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -228,6 +228,28 @@ static inline int cap_inh_is_capped(void)
 	return 1;
 }
 
+/*
+ * Determine whether a userns capability can be raised.
+ * Returns 1 if it can, 0 otherwise.
+ */
+#ifdef CONFIG_USER_NS
+static inline int cap_uns_is_raiseable(unsigned long cap)
+{
+	if (!!cap_raised(current_cred()->cap_userns, cap))
+		return 1;
+	/* a capability cannot be raised unless the current task has it in
+	 * its bounding set and, without CAP_SETPCAP, its permitted set.
+	 */
+	if (!cap_raised(current_cred()->cap_bset, cap))
+		return 0;
+	if (cap_capable(current_cred(), current_cred()->user_ns,
+			CAP_SETPCAP, CAP_OPT_NONE) != 0 &&
+	    !cap_raised(current_cred()->cap_permitted, cap))
+		return 0;
+	return 1;
+}
+#endif
+
 /**
  * cap_capset - Validate and apply proposed changes to current's capabilities
  * @new: The proposed new credentials; alterations should be made here
@@ -1382,6 +1404,43 @@ int cap_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			return commit_creds(new);
 		}
 
+#ifdef CONFIG_USER_NS
+	case PR_CAP_USERNS:
+		if (arg2 == PR_CAP_USERNS_CLEAR_ALL) {
+			if (arg3 | arg4 | arg5)
+				return -EINVAL;
+
+			new = prepare_creds();
+			if (!new)
+				return -ENOMEM;
+			cap_clear(new->cap_userns);
+			return commit_creds(new);
+		}
+
+		if (((!cap_valid(arg3)) | arg4 | arg5))
+			return -EINVAL;
+
+		if (arg2 == PR_CAP_USERNS_IS_SET) {
+			return !!cap_raised(current_cred()->cap_userns, arg3);
+		} else if (arg2 != PR_CAP_USERNS_RAISE &&
+			   arg2 != PR_CAP_USERNS_LOWER) {
+			return -EINVAL;
+		} else {
+			if (arg2 == PR_CAP_USERNS_RAISE &&
+			    !cap_uns_is_raiseable(arg3))
+				return -EPERM;
+
+			new = prepare_creds();
+			if (!new)
+				return -ENOMEM;
+			if (arg2 == PR_CAP_USERNS_RAISE)
+				cap_raise(new->cap_userns, arg3);
+			else
+				cap_lower(new->cap_userns, arg3);
+			return commit_creds(new);
+		}
+#endif
+
 	default:
 		/* No functionality available - continue with default */
 		return -ENOSYS;
diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
index b5d5333ab330..e3670d815435 100644
--- a/security/keys/process_keys.c
+++ b/security/keys/process_keys.c
@@ -944,6 +944,9 @@ void key_change_session_keyring(struct callback_head *twork)
 	new->cap_effective	= old->cap_effective;
 	new->cap_ambient	= old->cap_ambient;
 	new->cap_bset		= old->cap_bset;
+#ifdef CONFIG_USER_NS
+	new->cap_userns		= old->cap_userns;
+#endif
 
 	new->jit_keyring	= old->jit_keyring;
 	new->thread_keyring	= key_get(old->thread_keyring);
-- 
2.45.0


