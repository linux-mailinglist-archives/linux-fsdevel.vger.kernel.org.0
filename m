Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F366D79DA5E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 22:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235896AbjILU6t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Sep 2023 16:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233149AbjILU6r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Sep 2023 16:58:47 -0400
Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880D710D8
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Sep 2023 13:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1694552322; bh=mylOf4JC1yq4qctU71sNh4jo0TGeJpq4SlE0jOqt9mo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=QHXkvxKoLUHiYAFKHGS2Ecxj8mD+9qHChRVc9tzZ9F0uFhZut/E3znBCNTXAnac5GHjR/e4PUSZjFDp5UZ4ehd1WkQjUrQ9CNDcTBnueLLaklPRT/ZurPp4NuGXRJ5+FKlYZteEvWGIX8FaHN/cQqOK8AX6+gw6cIGSnqMq40FLl/g4guxPL18713K3WvRpuJQXJ23CH0kGxQsrBSTUYab8jATm7wYZ7jHsAsY4BKqJXdKqvJkPfYABYCkmSnlZaQ+EXc7Yo6aGy2IoizwNnoRcNveS9p5m3jHkgPvVvviEb6kqss+iSRgQzlpoFKksiEI/uErkNEJ+KA3i/JIjhBQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1694552322; bh=NmPzJxujTygJlxeurMgqremtUCwZIUH/8/jBOlRZrJP=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=tSwuF46RDbxWPVSbQPsK2oRc0fuaXT0+z1STWGWFeh4B6PwqINVn0issbmzdvDOMREVun6T7UirB7mRG7RzD1BcIZjEw7glfNztcFm/Nh+U5f90zMghjCz/PaZwZa9YavL4X+ngK5+7Q4zvptrX1ofjvPFjSyHlVe56MLB+vMKgdTex9zTiEJy8Ay3PV9Ul15CxDkNHktP4mhRPxj0zZZtCzE/CIvMCv62mpyqGDiZOaEyzyF2E8pZXM8hClFX3J92gCjb1xhit9+TXfsDCdsEcXpqUUWJcMOS2JPHacmlClNJxlZHz4JzlZrqCRm5ZTe89tK8XFPYoxZ9OZP3/7TA==
X-YMail-OSG: qXzP9RUVM1lJMUW7sH6Pfpwlkop1frJQ.F9VbCi.n_bgRxT9TggJsjMs_vhNRpQ
 Th.4JrjZt0hFCOIVHTRHwS_EQBL7IEdot1J0WcYtoyNNYHY00VpSybnAGUV3hXLaSJCqo2UXp9vy
 oNeMykXY3WDrO3.ysHcPWNQtdrnw8Y0fh06He4mucN7oAbK1q3dtVq4l2lj70mBFoPRieRGFkTP3
 rOwi1kAtueaywvzUAgAG6yaDYCugjXabPCsOxP.S6.HLcv.7g1.NWWGCjREHY9dT2eiTnU5ZxCdD
 1vKCT8BRuzeuIBOKPHeX0XrMY0LZCtcTl0DZd.eKVyXHNa8fvdTcXcXtyCA58lWoHLl_nTr5XqcZ
 oijSVHbBclf.tmk5YeRPkVZOlqR3dlVcLqv.rnQ41uRjQK1yI1qm6pks6nuoS6tMlwYH2uJeoKQI
 DxMo3go3zSUQ6XTCLFuD1DcTGNt0uB07TeMfvMi47WU5w0LfJJQpNGU7dS7St3VIl01F.K7LM7af
 iTogsR99uMIHNrlihAm3BbwBCZnDuApabouWUlKa.23d1Au3EwgEoC1G939zUDXX2DrPViUzeswt
 JzW2Ds.VUNzOXwbxOk2EeFIoQ3A3COt0psgdrdsL8Tjd7_tDvr98a2RZ_UCGTTJANSwKUtePknNw
 bGYWoNlwOYUBuI6NpleYgjCJOwfMSS5kAWc81Z_g7YC25e1M2uqHWB8h9EB0UXhUwwCP5.WS1O.p
 fl2SnjDo41U38uelqHOlxq6TghZMmlMcnkdlDmsofPgpWn10.cQL7XsW16tMCYYNfv.2C6VJ8uPB
 dxXg0lDufQGHA8nBFyswncn0nSH.LKFlGm.oovDa1N9yWRI.O3J1NbJgRA9WywSHLUTYvnTlakh9
 Lzg9DOgpuWXvblkOmKz8CWJzobH6GJN.7lz11hjq7q8DtMOCqUPnfqt_J7zntIH1HiKNOzsgTmZD
 xr.YjxcKNARso.X_OQXmNqyjXVPAHwgzB.1u3ChR_ObJrh6ziWSAWzaf07y8o8LzHm8iSjqz6KiA
 KqNT1UHQsAIaBNZlIxwkKI6LXzAJiQ3r.nnT5NNmDbX_1RSbKGrVHJVJXnHpEtYySlkEiYxN_Jaj
 orL_Jt2AvZZWU1YCJPQMjHbvJmP5AONO5xCD4EB95v7T6T2AJumw7LY4Nrig29.zKT3hVD1nxM7B
 VTA_4i97RF0tOGsL0UCX59FH_uJopA_uAQpXyRjcrXkomwykq7Vn0otkST8W0Y_jEj86fV6skNh4
 5kpLTZBA3EOvugVg_Bo.J8Z1IzZlfcDNoLXEF0GgjTMGJgHV1vXgIh1bAZFlk0EG3n7gG1n0lzDn
 _jnWTApuwnS2Q6sk_j8U51pG70Hs5dLebcgewaYhf193SWMBPfncPa7q03faXYl3pXJHTy5SLUNS
 kOmsi3bXEiei1BVzB8OCHzMGgESbjxGKKKCYv.MS3CRDrUE1TB7dwzL9bN5thEMbuVKDL1sPF9_m
 KBqTmu76UhvaxNcbCN4_cV.EUBIraGgyV4tTm5Tl_DdApqHxtODF9LdoI0Y940AgCgYJSqEmyKI0
 tlaDnX17Hn8eFJP0Z0OJBbWudiHGlT_GfzDM3I9oXNjLHEvzBpeOHUceSn7rwKD.qCUfX.T3Yi_E
 bW015xdfAgb4Nm3MBsZC.jZ3Ji9Eeio6JZsqtVGnHr1TGXFTmUlDRxvNfqV_qHtI1gzZFNHEaCSJ
 JIDha.xPHUtRPQBbiypwu8vN6pv2eY0RBZyEyD42kmdecUWf7o8Rq3yoCuecj0y8rFmlAlWr1Rvj
 pNJ4P3psSx3lvl6gxaZ.mxvLleGC8mDL4j4CppoSim8b700RADzV32hnRwcHHukQNLUoGi6iiIFF
 nLMtnj.2QGkXMJzd4dq6PS6xe1qKtXR4fUK.f1rZW19gTqbuSEsEBcMaOaHG37cH7B3PcrXXkIwA
 lU6xL2R_k5gsX6c90dfweWD6cGEn61nwHbDLYWi6jdk5v9v4ZeMbgi6hIYXqcF58LN9V7fUdhlQ8
 0J9Tc6JyY..QaqyYvh51DO9thnIwqK8bluEIyOAH6ZeL2HK4zahxKiOZHgbpW7NqWwzm3uVnzEzs
 cNCI63neZvC73xCZpmziYYc.jKd1dI0qZHCKeVagGsAxDZVhwPeIeSIh.HEAZE1ATBVV76hRQi8X
 q6pvzd.OAFWr9zwD63DXaykYbOs9LUFzX1Se8qw2Knns8Oa_fO4T.kT8cmtnlSBpRDJtbQVTMtr3
 wCOExEgvq5JKW170WEzuiN5VxtFoS62v7ZuJdKUD59_CYcQTCweKOn7BFYqFDhUhkQlNYaukt7Sx
 dChaphdorALo6BW3ZBA--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 61a19e8b-df2b-4164-9614-a42aeea95d2b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Tue, 12 Sep 2023 20:58:42 +0000
Received: by hermes--production-gq1-6b7c87dcf5-6x8bf (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 7160b6de539f095788df3fe36388d168;
          Tue, 12 Sep 2023 20:58:38 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v15 03/11] proc: Use lsmids instead of lsm names for attrs
Date:   Tue, 12 Sep 2023 13:56:48 -0700
Message-ID: <20230912205658.3432-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912205658.3432-1-casey@schaufler-ca.com>
References: <20230912205658.3432-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Reviewed-by: Serge Hallyn <serge@hallyn.com>
Reviewed-by: Mickael Salaun <mic@digikod.net>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Cc: linux-fsdevel@vger.kernel.org
---
 fs/proc/base.c           | 29 +++++++++++++++--------------
 fs/proc/internal.h       |  2 +-
 include/linux/security.h | 11 +++++------
 security/security.c      | 15 +++++++--------
 4 files changed, 28 insertions(+), 29 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index ffd54617c354..97ce30528f75 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -97,6 +97,7 @@
 #include <linux/resctrl.h>
 #include <linux/cn_proc.h>
 #include <linux/ksm.h>
+#include <uapi/linux/lsm.h>
 #include <trace/events/oom.h>
 #include "internal.h"
 #include "fd.h"
@@ -146,10 +147,10 @@ struct pid_entry {
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
index c1a6af37a538..3f79bc191a7c 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -472,10 +472,9 @@ int security_sem_semctl(struct kern_ipc_perm *sma, int cmd);
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
@@ -1339,14 +1338,14 @@ static inline void security_d_instantiate(struct dentry *dentry,
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
index f71715a6f5dd..a3489c04b783 100644
--- a/security/security.c
+++ b/security/security.c
@@ -3840,7 +3840,7 @@ EXPORT_SYMBOL(security_d_instantiate);
 /**
  * security_getprocattr() - Read an attribute for a task
  * @p: the task
- * @lsm: LSM name
+ * @lsmid: LSM identification
  * @name: attribute name
  * @value: attribute value
  *
@@ -3848,13 +3848,13 @@ EXPORT_SYMBOL(security_d_instantiate);
  *
  * Return: Returns the length of @value on success, a negative value otherwise.
  */
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
@@ -3863,7 +3863,7 @@ int security_getprocattr(struct task_struct *p, const char *lsm,
 
 /**
  * security_setprocattr() - Set an attribute for a task
- * @lsm: LSM name
+ * @lsmid: LSM identification
  * @name: attribute name
  * @value: attribute value
  * @size: attribute value size
@@ -3873,13 +3873,12 @@ int security_getprocattr(struct task_struct *p, const char *lsm,
  *
  * Return: Returns bytes written on success, a negative value otherwise.
  */
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
2.41.0

