Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4487D6F1F4C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Apr 2023 22:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346495AbjD1U2m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Apr 2023 16:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjD1U2j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Apr 2023 16:28:39 -0400
Received: from sonic307-15.consmr.mail.ne1.yahoo.com (sonic307-15.consmr.mail.ne1.yahoo.com [66.163.190.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFB72680
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Apr 2023 13:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682713716; bh=Z9nxeKbR438LSTP2aAwXWaACuXFQ/LPIBOgaq5Zksx0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=NocaLdVpDG61D/jx6Sv5OO8VDHl+J9+sWbduzmTtI43tPRLyOMHLRWh9VAeCA5EtiJwXpJaqNxVS/sPhSr+Lr8ta7IO8z3lX20/0XAAE2bLJ6POlYwsxg6F9hYsUysFUTSAqtaa/Fb85aaZqtHX9Fn6o+/oNTS5F/3/FOYMHLmwIXAXsuIu0yPi7RptS+iTX/wi58BbUCdYeDP8HSunFCnUJuVc5Frkoff/udpQ+rOAynyFYc1UxNUtdYkDlbvLUQFJgcZ3tTpwTJJQBdPj1SCCNT4/6zXOK/XBm4DzjbFqbWoRifhnXl+Jgk9aCooxC/9N+xRKgovDYAhs89O2t9g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682713716; bh=C4V9hmTd8b1iqTAtrKVOaZSJZfJ4VSs0WVZ9P3ICgnd=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=ohm0qjT+gcd9gHB9yVcEJ5kvXBdfgTvb737yOm7At0wIB9+GIF9/Iia1JabIaaQqqxa3M7xzwTM48G9zULHuOwIy7dwgHJUtNCmYGsgCDalIK7FdjIko5aY/Ba/SxpG20prpATYm3Kbo5LIiOIpmrVcx/TLWZglt6P+YrDLMwm+HZDK7Osn574uSxbrX8MsWhvQ2jWiFcem2KdPwE9/UwKrK25voMk0CSe79gabCO8lvGD7KOHyajSNtGM49HnAtygq0fSg0WvucuUL54ajnirENbqn/KRutvZUK/9DVBdjr/N3XIohLIdswf0gE9nBZJouU5utQ04b9TI0NWtM5HQ==
X-YMail-OSG: wpJRwCMVM1mQ4Tqd71nLl_3ZDMXP00vaG6.eJYyQLNpkZQ8AZZLPVu.OrLCh8he
 t_JJQKbJiW4CL8n53dysGkm2a_CtCKZkYnet.Ve_c1yoBRy3Pp8DsKAjEoAYqcIGxf6yO2AeCV0V
 7uCzT54ILCPCNADk5WKuARhE5JX0brR.bKs3MkrqgneEPOE73VG7ZvYh3e.ix1Ue0z0l0jGcEe0d
 UjMhvEfo9P4DaQr_JUbE9WF16RQ1dOnGdy22N5i0UDDKoDhI8FJENcTzDmlZgxlR5e9ezGkJKKkD
 fFpK55vgtXVCIJ9jIyoI1j3OYuX4Pfjq98TNVjnNuf5Q.Mjd9PA5Xm8JcL5Dxu1nNebSUmQD0RxS
 aQg_ZEC_w7qX40mnn17SjxBeoWQIbWhj0ttABxrRSeQBPN56FfFVpdWdrHumXOrl0rpTYVy.1qLG
 cxFnJlKTJm31Up63_qhrwnEPlVm5CTIgKdrMYyJu4SJnfz84WtOC.Yy_u8jBa6z24ILbjVp6hAwX
 JlT6OgQAY0_qIpQ4uaJ74_vgcVhAVc14lLwamhdFWCzvbO8FesyxywF7Oq6Blt_p1USCo8sCbiUp
 xqz4oC27TvtHadpJRY0o_6roqFZgRY_MGv1RxxZp9EK93WeKBvHwag3NLX6pZKU75WpdIDLAefWq
 BEbwM95C6qBEjxeHW.7TY0eGlOQP1HxZUnktAkXZs_JXdRyKD.3bufjax9B8cV11qp_rmLG76iNj
 6oIPzi.4KHsbFcE6LOx0DIXueqDwE_wPjiifjOstxjF2jqer0LBJS0cMAeGTfsFjA_uvlMwr.vTs
 oEJcq8xW4JNOE3Zx.AhclDj8qw9jT.qwq9hzZoVhhivu59uygIHIMPOg6hGRMHUoRf_N3WnT9LZN
 DEDFNRXm1kLfStQHVXM71ycazZBH9LqqKM.R2R1OFcbJrVI_CyI.2zFSfVcHwsrKGoscrjq.9j5T
 lq5fMa5x6s74RD4XFUu3J.G0TklfrqaJwu3XKtc.HO5TQLxO0H6Lb6RUGm0BlISKb1B.ZXcn0qUU
 h0FJtAKhxdcMrhDx0orxyKRHN.MNnEt3.OzB5SrnyaF3wE1xLYW46sxrFaWWzedQVlK6og_tsU7V
 UzXft7pJJk3PezgAqz8VvinQo4twDaAxks8RVPmxWyfwsn9FnKjKJQTTAlSzC4BlagLLwgTQ7QU.
 ZchedGoepO03nHzNGQhN4ZiSlOkk.Lf3UiG.LMBctbHqRP3YzkT32y5ROqE1dJ_qs4la3NQyK__z
 o0vzY8MmjCLmIyNCLP.0ARZxAKko5RTgY5to4hSXlHQyH2mLX3Z3guwZjWMZFbisigAQIBMuRGnu
 fDUuaJOu3KzZFJNlDAs3GF49i_0NbZdqBpbQR4CuSS9Ykhc.58M5GxGlrEAzBl8zw_LiaOKTRpA_
 3nrOqikoT8rqXMsRCFpkqzvkNzh.ufX.Go8ut3.nlvitgce6w9nUayMnGJ_l9KMx33Rs2CrUzI70
 Q_IOo4iueTiE_jzym38iWBhFcE6wGETA0SJtKQgsf5o.ikwHvPjVxwoM_p3Qq_Nqna4h4yeMDT6o
 q4uR2mAL_V6HOnCOItjznsB9IAUHlKiO7ZO4pdLLfiJYH3SZJLpLHDgXyHjG99kd9EBdUy8Jm_hE
 3SASHEMMIpgn.HoIGIhiVLuxbnVIY1KkaV.WqQS3SoUYrGHtQnjy6wQk_ONkA589Incxlt8GC2vx
 HBDssHc.slzR1EYkDP5l1oYIdHWyGLuWmhTFSsGAChIwRfWsgJsKoAGpLBQTUPHscNgoDZQdRG8.
 jUJ1bM9uKV7b8aKLiPmlZPRxOuYMLJfbRZH.XKVaJBvRs7vQ14H8GhXq3aAZiPqyl8rx0re4QaHy
 Ay2q0OjcmZzkKgJL3c_CAkROxPE59AswOai4wice13axZk4CcW5w.sXCgsLk3U0qqVQfmM9ExJr7
 TqltNt2qYEx3DGw5b.bawNcaK8QTnfPGA6JLY3CLTlpNq1Vuorh70YR_KrgekvISGt2pJBHOQcmO
 Ekv5jmyZa5XUn1SybUbS4FIekjqsnaiqY0Z7_bChyT90_RFVvTFiVgfXBqSeeBBPL4JH8HdrKEhA
 axg5DhCacmksArduyrH1V2uPRxtULefmz9SPFe7Jz2HS9a0YaYlr8ogEd9biUY7ETrbBYGYBZ.dn
 0jDvgDbyusuAP1lax6_gygq9imp9s3q.u4FE0g9qTanuFb1LcMheJnvMVteb1UnO828kyeFIRnsu
 d0436ozRXswHA_e40XN2hJScByF1FdXWnxSc_W0CNnOOX6lSisvmE7vurFER0efMBnMrmUNOrdwV
 gQPKkoNbsLC6YC.6gRwQ-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: e0a80f8b-9075-4f20-93a3-de59de2c1729
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Fri, 28 Apr 2023 20:28:36 +0000
Received: by hermes--production-ne1-7dbd98dd99-tcjjg (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b58a5884cc254441b7169bc1ab603d8d;
          Fri, 28 Apr 2023 20:28:33 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v10 03/11] proc: Use lsmids instead of lsm names for attrs
Date:   Fri, 28 Apr 2023 13:26:43 -0700
Message-Id: <20230428202651.159828-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230428202651.159828-1-casey@schaufler-ca.com>
References: <20230428202651.159828-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the LSM ID number instead of the LSM name to identify which
security module's attibute data should be shown in /proc/self/attr.
The security_[gs]etprocattr() functions have been changed to expect
the LSM ID. The change from a string comparison to an integer comparison
in these functions will provide a minor performance improvement.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: linux-fsdevel@vger.kernel.org
---
 fs/proc/base.c           | 29 +++++++++++++++--------------
 fs/proc/internal.h       |  2 +-
 include/linux/security.h | 11 +++++------
 security/security.c      | 11 +++++------
 4 files changed, 26 insertions(+), 27 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 5e0e0ccd47aa..cb6dec7473fe 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -96,6 +96,7 @@
 #include <linux/time_namespace.h>
 #include <linux/resctrl.h>
 #include <linux/cn_proc.h>
+#include <uapi/linux/lsm.h>
 #include <trace/events/oom.h>
 #include "internal.h"
 #include "fd.h"
@@ -145,10 +146,10 @@ struct pid_entry {
 	NOD(NAME, (S_IFREG|(MODE)),			\
 		NULL, &proc_single_file_operations,	\
 		{ .proc_show = show } )
-#define ATTR(LSM, NAME, MODE)				\
+#define ATTR(LSMID, NAME, MODE)				\
 	NOD(NAME, (S_IFREG|(MODE)),			\
 		NULL, &proc_pid_attr_operations,	\
-		{ .lsm = LSM })
+		{ .lsmid = LSMID })
 
 /*
  * Count the number of hardlinks for the pid_entry table, excluding the .
@@ -2730,7 +2731,7 @@ static ssize_t proc_pid_attr_read(struct file * file, char __user * buf,
 	if (!task)
 		return -ESRCH;
 
-	length = security_getprocattr(task, PROC_I(inode)->op.lsm,
+	length = security_getprocattr(task, PROC_I(inode)->op.lsmid,
 				      file->f_path.dentry->d_name.name,
 				      &p);
 	put_task_struct(task);
@@ -2788,7 +2789,7 @@ static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
 	if (rv < 0)
 		goto out_free;
 
-	rv = security_setprocattr(PROC_I(inode)->op.lsm,
+	rv = security_setprocattr(PROC_I(inode)->op.lsmid,
 				  file->f_path.dentry->d_name.name, page,
 				  count);
 	mutex_unlock(&current->signal->cred_guard_mutex);
@@ -2837,27 +2838,27 @@ static const struct inode_operations proc_##LSM##_attr_dir_inode_ops = { \
 
 #ifdef CONFIG_SECURITY_SMACK
 static const struct pid_entry smack_attr_dir_stuff[] = {
-	ATTR("smack", "current",	0666),
+	ATTR(LSM_ID_SMACK, "current",	0666),
 };
 LSM_DIR_OPS(smack);
 #endif
 
 #ifdef CONFIG_SECURITY_APPARMOR
 static const struct pid_entry apparmor_attr_dir_stuff[] = {
-	ATTR("apparmor", "current",	0666),
-	ATTR("apparmor", "prev",	0444),
-	ATTR("apparmor", "exec",	0666),
+	ATTR(LSM_ID_APPARMOR, "current",	0666),
+	ATTR(LSM_ID_APPARMOR, "prev",		0444),
+	ATTR(LSM_ID_APPARMOR, "exec",		0666),
 };
 LSM_DIR_OPS(apparmor);
 #endif
 
 static const struct pid_entry attr_dir_stuff[] = {
-	ATTR(NULL, "current",		0666),
-	ATTR(NULL, "prev",		0444),
-	ATTR(NULL, "exec",		0666),
-	ATTR(NULL, "fscreate",		0666),
-	ATTR(NULL, "keycreate",		0666),
-	ATTR(NULL, "sockcreate",	0666),
+	ATTR(LSM_ID_UNDEF, "current",	0666),
+	ATTR(LSM_ID_UNDEF, "prev",		0444),
+	ATTR(LSM_ID_UNDEF, "exec",		0666),
+	ATTR(LSM_ID_UNDEF, "fscreate",	0666),
+	ATTR(LSM_ID_UNDEF, "keycreate",	0666),
+	ATTR(LSM_ID_UNDEF, "sockcreate",	0666),
 #ifdef CONFIG_SECURITY_SMACK
 	DIR("smack",			0555,
 	    proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 9dda7e54b2d0..a889d9ef9584 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -92,7 +92,7 @@ union proc_op {
 	int (*proc_show)(struct seq_file *m,
 		struct pid_namespace *ns, struct pid *pid,
 		struct task_struct *task);
-	const char *lsm;
+	int lsmid;
 };
 
 struct proc_inode {
diff --git a/include/linux/security.h b/include/linux/security.h
index e70fc863b04a..8faed81fc3b4 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -473,10 +473,9 @@ int security_sem_semctl(struct kern_ipc_perm *sma, int cmd);
 int security_sem_semop(struct kern_ipc_perm *sma, struct sembuf *sops,
 			unsigned nsops, int alter);
 void security_d_instantiate(struct dentry *dentry, struct inode *inode);
-int security_getprocattr(struct task_struct *p, const char *lsm, const char *name,
+int security_getprocattr(struct task_struct *p, int lsmid, const char *name,
 			 char **value);
-int security_setprocattr(const char *lsm, const char *name, void *value,
-			 size_t size);
+int security_setprocattr(int lsmid, const char *name, void *value, size_t size);
 int security_netlink_send(struct sock *sk, struct sk_buff *skb);
 int security_ismaclabel(const char *name);
 int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
@@ -1344,14 +1343,14 @@ static inline void security_d_instantiate(struct dentry *dentry,
 					  struct inode *inode)
 { }
 
-static inline int security_getprocattr(struct task_struct *p, const char *lsm,
+static inline int security_getprocattr(struct task_struct *p, int lsmid,
 				       const char *name, char **value)
 {
 	return -EINVAL;
 }
 
-static inline int security_setprocattr(const char *lsm, char *name,
-				       void *value, size_t size)
+static inline int security_setprocattr(int lsmid, char *name, void *value,
+				       size_t size)
 {
 	return -EINVAL;
 }
diff --git a/security/security.c b/security/security.c
index e390001a32c9..5a48b1b539e5 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2176,26 +2176,25 @@ void security_d_instantiate(struct dentry *dentry, struct inode *inode)
 }
 EXPORT_SYMBOL(security_d_instantiate);
 
-int security_getprocattr(struct task_struct *p, const char *lsm,
-			 const char *name, char **value)
+int security_getprocattr(struct task_struct *p, int lsmid, const char *name,
+			 char **value)
 {
 	struct security_hook_list *hp;
 
 	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
-		if (lsm != NULL && strcmp(lsm, hp->lsmid->name))
+		if (lsmid != 0 && lsmid != hp->lsmid->id)
 			continue;
 		return hp->hook.getprocattr(p, name, value);
 	}
 	return LSM_RET_DEFAULT(getprocattr);
 }
 
-int security_setprocattr(const char *lsm, const char *name, void *value,
-			 size_t size)
+int security_setprocattr(int lsmid, const char *name, void *value, size_t size)
 {
 	struct security_hook_list *hp;
 
 	hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
-		if (lsm != NULL && strcmp(lsm, hp->lsmid->name))
+		if (lsmid != 0 && lsmid != hp->lsmid->id)
 			continue;
 		return hp->hook.setprocattr(name, value, size);
 	}
-- 
2.39.2

