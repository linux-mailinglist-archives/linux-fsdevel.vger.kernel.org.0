Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8BC0659348
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Dec 2022 00:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbiL2Xgt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Dec 2022 18:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234027AbiL2Xgr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Dec 2022 18:36:47 -0500
Received: from sonic305-28.consmr.mail.ne1.yahoo.com (sonic305-28.consmr.mail.ne1.yahoo.com [66.163.185.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF4410FEE
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Dec 2022 15:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1672357005; bh=KX7zkZBp7l2N6LQXje2QMwa2gNSim7yyh6UG4FUkUF0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=uc50UwulxgAu58w6QoDI5F3YFxGnrJZDfQkBeovPGBqko2oAJlvfH5UrzI4cQXoATfI3q7ZoX4Ag4KWHYVp4Zm1Mi6H6slgq2phq/Lqajt6P6rM+3MWeM0Tnur5iJgXrROUNEt5OXrMCSfTpvkaCrasJ+GFBGFpIqugzp3AOA1vcBDu7bTC17wKNx18G0q76daD1KN9PTxAQgeyaNISyJK5iN/tU1ACYkabrQ5USdSQbh/SQDU43jEyXRA/b0RKLkIS9X/qw6RW9+CIU7jXhdeC7QT5sGJcITRjkKKsNVwo49rvqoLeyh1lUZ8NWAo07b2E8mDYK3cNjINlkR1aKHA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1672357005; bh=5siTqCkMZhl7EPjmtvcYXVp4wf4GBa2tKpAXrSwUY+R=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=c3gYhLQmmGtgpe3VWrxW5KAXUulnJ6XeaLmtZdTO/iux+8gdFsEHeZFxnlppWqvs+RmhZm9hZrudLVTx8sI81OnIs4acvy+QnDlWv7DNEkS+LTfkEi4u1Jbm04T7W0/ukIMZ8D2xxrekgg+6A7KmQnO0WO6GVWESpHI6fTxHUTtQbR4qHt2nTABX0GQCWF/B7nDfEacwU/abLdochxo13mQaxG+GD1JzqAtJXhP8zE+4UEb42/7OqY+pGBtuNkx9BaaGBH5FkI1LPlDhozJ1xxV+OV8AohWTTlXCUBu4DrMTbIi84C/spXFIfklqJWND+9zb/5GRCwHWh4S8oGBfJA==
X-YMail-OSG: rfnpcZ0VM1nkfoQtImrlwySptKCmE94Q.ic5B2yMX50bkK1hNjKp.p6dYCIBA_V
 hNUiNcL9V8L80omcga3yXBmSTSAcSYqOaC5q81kuqUVreygH66If5nO_l8_7gVp9Y_y7P2VuALK6
 G4qat3tLACygqhqegI.In7AP9GwuSS7b2.j9cBnHqCPAOd7Oo_tPEfJwqnQZscZp9KP559JIATR2
 0hx4A70jtRMGBZUFOz8SZLNk4DYe9WxHYAEYkiEunw_7kaYHEIfGoDKbcI_EdF2YjOnRPQQeNCSO
 lO7One3asupJOanlAVLKryNwaaauyaNv1R53MTkZOH_4fFkC.5C64a_ot05ccI3EuWkEH8Jpbxet
 vQ0prPfFhCkwhdnjAX_W6B69t526ffSplAr_DURiwMGB.FprJULAv73GwH1TmJnYnGwBuGea8Ku1
 92pVooU_8WoXk3GvEuPFSmKziHSJBwMHMMxk5lesZhEpw0hCxASsX77GO0F5JWLBk.KfDZEvZWnm
 42sF3gac.Edzm_ijxS87mVttAtyaALWDHEBT59VBKiwEH615ZeptKpqUTypF1WZoqb4dajQE0ZEO
 3MRqpdetmC4pTEv8HO1.rmGb_EapfgElFD2bzmL2sZN2TEYPDud.naIATQ1H1BX9vf5cLjhEPsHL
 NAuvThHHAs1DIC8hFSpSRKsiv7oGAhFS5CAPC0D.Cw9GAstSDjRACSV4bJuCA6x4.yB37gQvcaLM
 Fd3Wp2mLoRpy0ob5p7jgYD_q6W9V1TytxVn9qRbsTMx93gPCsAhQG64WCdhnsv1ppJNJZlKHg8wG
 YqZ4lzdRYomFlSQfeA3FCLwWb9N7G0iHxR9yFnIAFuJtKmnHhdNDpFMcWnGJ88wr3Qg9rdI9PM1b
 Ti4E0r.vCJead3eTtt.ARvhYkAM9bBcOdpDiVpTTEfyVjjo1BE3RJrEDR4Yr_ps6RFh0lj7AXZ7K
 Ju9QGxxmyx1u4i8wncfViTa2KNZ7dSoT8eE7xV_0j..pG81PnqHDIQtw0Bb1xTphSLiqJvPVzSce
 g9jE6tJoClyTqMMF41Z9WPs5gmKiOeDErhC9YWFOyVh4IwUB5DBanYkmNowU88sJTf9J_BP1e2ko
 MZc2_jcA6ftZ3c8ZYFUAFqtyoIqDIs1q42sqmMe2R2wKsM15YLRIaOAvF3pfBd_lxqIUMX9.JR9p
 FVpIeMVaVfL4iixsFRhcHfTkGv3Mj2QsCgASdIP1EKeZcXhIPHugEpFOQpOG68bNtXOL9Gin2.Be
 jNxBzEfNLLVzC0hZ4O18ijvIBog2GaFrfjfWBNkXy.xHDYBGS4L8fvg9.tYTDy.INZB7_3BW04pG
 lcxi5WpJf3Fh4ue8CrEoe6TJ2kUCBNxS7S3iLNlQP9spq1OLO5Dv38ANYX_s7K8.d6cqoAC3ovFn
 sk9dQFVqN5m.YZb9IA9yppIRzqt7nFz1pQGPtjqts5FE7qFtyzz2x_zOlfYFdZfup41d4f9WqfCZ
 ibOfOQwxsbhuXq80KkBKcwaMveBSjwGfMZfk0ZBLb8uKC7Bc_UFqvM_SZGY1Lnkk9KlbbBuv_apg
 Hay6LdQ899MTVUj4HWgqj_uCr7iTNpUoiAGYh5qFD.ipm9bjBhrMzaRBXbWPRf675xii9uvfM2k3
 XIyi0Qz49uqiBUSZygOrJKITWYuNiUiJzV7zQwdXOvPuo6dtOcVM7t7UWIBiqb7LKtIsRMkEAYKw
 G0cNdhmlUYJU4rjRayTvpw0G4CL4odaZO8GxOEQejDuwz_Q4QA7nkZ7YNmh1ya0StiFfZ5lMoyEC
 aMdHbZbRZ1pWZ9EfX.L.L27rR7HmuBt_P7YpWdmFqp8YVmnbfjFz6Fa8AsCz1q7WmuHiG_KW1WpB
 xgGzZo38u.4vvluvmpLKJAIbEuUajG3SZ5W_cr1GQsu2TG3l0ZRYCfcFsD_nh26dHiwcchWHdawo
 p6RH3B2LT6jlX_9GajVMsAdmgr_wEopBFKyVUNVSc5xzmVDshM6oZy2ju9v_zj2_jlbuihF5pvyF
 6moRC4ZXfzGVlAtVjFTtgKM2XEhAk6DEGmv7loM7LwsCBa_D2ZBdZPfk91Nj4WqB5yyuFGz5Nthl
 375IfGLUIl_eyA38VtHTI7r3YKZVjH0jUW4iGAFgHB1rKSVHacWq98jfD8LPsMLlxGFZ131YHfTH
 1gC.vKHQJWx2QWUAYfsnPJKyYonbVRljgrYBd7EmPdcEdpPHSNj7rBBU3w7UYh1j5D0xf2mekpaY
 SUBlW2FC3Ns6P2awgKt6wQelckIecQWG1FCMiTSNfGw--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Thu, 29 Dec 2022 23:36:45 +0000
Received: by hermes--production-bf1-5458f64d4-x4bxm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2c9ed6e23ac4176228a90f5214b07a1b;
          Thu, 29 Dec 2022 23:36:42 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 3/8] proc: Use lsmids instead of lsm names for attrs
Date:   Thu, 29 Dec 2022 15:34:49 -0800
Message-Id: <20221229233454.43880-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221229233454.43880-1-casey@schaufler-ca.com>
References: <20221229233454.43880-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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
Cc: linux-fsdevel@vger.kernel.org
---
 fs/proc/base.c           | 29 +++++++++++++++--------------
 fs/proc/internal.h       |  2 +-
 include/linux/security.h | 11 +++++------
 security/security.c      | 11 +++++------
 4 files changed, 26 insertions(+), 27 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 9e479d7d202b..9328b6b07dfc 100644
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
+	ATTR(0, "current",	0666),
+	ATTR(0, "prev",		0444),
+	ATTR(0, "exec",		0666),
+	ATTR(0, "fscreate",	0666),
+	ATTR(0, "keycreate",	0666),
+	ATTR(0, "sockcreate",	0666),
 #ifdef CONFIG_SECURITY_SMACK
 	DIR("smack",			0555,
 	    proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index b701d0207edf..18db9722c81b 100644
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
index e70d546acf3d..18a481fef7fe 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -491,10 +491,9 @@ int security_sem_semctl(struct kern_ipc_perm *sma, int cmd);
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
@@ -1362,14 +1361,14 @@ static inline void security_d_instantiate(struct dentry *dentry,
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
index 4acb14500bc3..dfbb236fcc39 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2157,26 +2157,25 @@ void security_d_instantiate(struct dentry *dentry, struct inode *inode)
 }
 EXPORT_SYMBOL(security_d_instantiate);
 
-int security_getprocattr(struct task_struct *p, const char *lsm,
-			 const char *name, char **value)
+int security_getprocattr(struct task_struct *p, int lsmid, const char *name,
+			 char **value)
 {
 	struct security_hook_list *hp;
 
 	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
-		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
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
-		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
+		if (lsmid != 0 && lsmid != hp->lsmid->id)
 			continue;
 		return hp->hook.setprocattr(name, value, size);
 	}
-- 
2.38.1

