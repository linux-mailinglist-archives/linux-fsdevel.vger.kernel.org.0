Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475097336C1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jun 2023 18:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345981AbjFPQyZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jun 2023 12:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345712AbjFPQyK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:54:10 -0400
Received: from sonic303-27.consmr.mail.ne1.yahoo.com (sonic303-27.consmr.mail.ne1.yahoo.com [66.163.188.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CF24C16
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jun 2023 09:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1686934358; bh=DNWNKvtAd3be3OOMSbgYgPBEP6oRo5dkBW/l7tcDaJU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Z4vN6IMY8F8UeX+EhYfztwB4NqBYVIc5Xc6xPaCDdH1bYnoBhxA+WfR88KqJAGMlUotL9ioEcs2iy+eCyqbU72Szvxfl9s0cZRTnT0Xmkuyni48fdxREMd1PQUdvb6ZMtYRYZdDL0iaw+Y92c69hU9W0PYiNkvA0uxpaLUtdPbDdrOhN/sj5nFHuo919pQ6iMIpEp8eXmi1IC7KCOzOhBRqpqiVDeB9lg8TuVCT7d3quvbeanCN4z2AST/1VpiRDN9vl5QRjG5XGXYIwBB89r4mp8TSdM4CXjSpBj8WGPkWOOJMPeZZe/fhjlW9Sxb7+Cdwb+da16jx5hR8qiFuFFw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1686934358; bh=t+4IUkWeiK0dDuOvCw0N9CnVzq99glyCiHMU9RRJM/v=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=o6VeiKp58yWQPY2ULVmYqa/+neV2gbBgJpyKRmD9+JJuL4qiF749gt/RtfycJWDAJ64wh2kF/g1+SdBVLkclMLIZ9JBl+QdRaUtDAOMMG3vEL94Tqa79bkpPgzOj9u+QznkUpIRDDKJA0IU+3ItMPlj1biF+pE2nr9yxoM+66l6qcLmvvrHT54Vq2l7NodfmRYhi3OyedNJ37l/s3AEbIE4/eu4svjoUigZoXqmKBQ2wcL4GJSWnQa2K7mf8/xnXtuBx+TiOkDwrcNDphlaQ+O6ZkvX4k6RIaqHGD17qhoH7niJw8+a5Ph8yKVWMaAO7RickJimJ5updqnTEOgJJ0Q==
X-YMail-OSG: VxzDtF4VM1n8TFIQSOxNI4ADqjlPRBVFmfa3rjDQmYtxgQ5_15vKMPVGkZzViES
 YSclR0gLknANztxulLBdAykwx80VWagX3FdjnJ_MKCYwGsEeSFIcRJfik30BKCf_IeGZ7jcdHn85
 HJtfueh1cwGRzpfYijTgK7RkXy3LpYh2upX76.23MzubFYINiJ5uIqWmc51lenV0hl6qdhkT.Q_i
 Gxo3XxjSV38Nwr5mH2sK9_E2TMTVdryH4zeH.ykX3JYTA5SYwR87Jnyn7pmaz4Bhfg9f6pltinEZ
 lhgN24l895vnjdoQdigtV.O0iM8cRPammqeLHItY4JlUdL3LqoOCQ086YT..CWBvy_5ox8x_LlDS
 yEcY3xd_cTMpr.PLYBQlxvNsqOYFGlehvHtpt7cyYqXOfgdery5.cm3iUpigAdoKH1iDIYP5pgeB
 DoqBMkv6MkBdgXa5Ve6oDh56UMx9VCkpOwA5JjNwH9yTAZar4uThSmAseRS4fZbS092ErempnPrb
 uGObkWDkStqzw0eoEqjYlu2sjsYL57lU9m8Lz3XUaV_0jE.YVUPPahXNwjSx0FxekuXhVdjxELdV
 zd1gVW1.e5orhZ8JZSLziJKI5vs5TYnjjSsiDpG3sLLHzO4TvALrzwgeo7NPfOZu0eTIh3WuHV3M
 OKRbt3Ookepw4_xzuuMZaeyQSdTmN5UasybbzAhiiReMFB1pUcd3Ie2MZDkiaMt8r7hfKn5uv8Sh
 9pAqMYR3DabKZCG9zzGI12zC63LWzGDi2IrdP6upQm6jhpyH0yM3N_BsRRWHZgy2x2iFdyjsN2RU
 l3gUHNImJHkHoF93TL7XtctbC3xf1e9V47ppgUOr3CNH.wDWH3Ad4eFUZuR0pvg0GYfZVVjtxVBY
 1MtI3OZec_GpC..skCkgIpMoLtqWMBN5.MkRqs2KNaAgd_z0W_6u0ZcVzWecmLO3K9wqFA310gq0
 UWOByUom_mgApI5JylqhkAECGXIBqSVlleKtapMTtoeKusWQBH0a6BmIyRH0a_b7B2mJz1ET5MgQ
 TrsrFMh1dsdejDrmIad07aQH0LvZSPb9QBvOmZklkCb605HUsl_TNrX8Y.tBTVd69WKsPbUQxIxB
 rIFshIlSeX43oBkrSzq_dPlN6Gi7gxN6mObPCVelZfJWI6hniniT0GEQeSrdPw4o6ninlaPv4Cnu
 SnuCUzBxlcdjEzjShVK_6J9Jw_pg3IMs8PUr2RoK.61vECUM2S9Ppee.GriZwwqB.2N6tOc86C9l
 6V8tWLtYEQB80P.H0uYjHqqO_fhajLZiTUDaAiQC1Nd6XWxENVU8_iSnmiG2Sy28fb1SflCUWULw
 uMmRLFSFl1IW7JKXahWS4czON3g4pBFcmRHPAhE_NO3BJ.rC0ggJIRlkokEC58joGjAztn6Pt0TI
 WsDBPc4ovMls29ZaMIbd8ADidkyV0Vz4HuPselDakdQO.pQRnC_sranFxVXc85vjlNBlL9d4R7UZ
 vSpiNEc5K05x.wcCyzhbS0LvmagxxwoX.NJo_97Fz9tI9F8rt99Up0_7KYKOqebhFkyj1doRzKTO
 JxCofSBOaXVQJfHU3tTJtAvGNX0thb58U57xqLGr4g9_8AAQRuwLTKlPRuiNFEVXlfA7_y8sYydS
 _lm1PKMH64YOKe58pO1kICmVCbiP70miX3Z.xRJUJmLuA705X7k8fYp_2IWx08vsqDtF6zTejg71
 6mjGct3oB0Vk1lc0beha7pKSjjIP7dc1YQkWkIf9mHEdT2iv54a8z3Haw0JDb9lCmlWKzFbtaWlC
 ciAMciJWc44IPQxNyU9ytr64FHhlaoz8uK0pNBb7WcuUiShHRXw7YO7ZiAcRb9r0aI1tFkvyuvOm
 tQ7UwH1Cb2yKwbRqKMe1Ulf5JOLRT6PJd.Id1I_3MTipoBZtE642QO7v_oly4mrqB0d_xHLyMzzt
 hg65ja.NYUY.zKVZJclrACuHifguHkqovZPdpD4.jX6ui0uLcpno9OsYW0pdUgftZzgKRQhEB740
 kFCUpvopxPBdkXlm3N_GsVUv1x03tfS5bCxHaiwg0K2S25iJWwKhKLK3OBi6.uFiA6H8WtaW3qI5
 PYR0OK.2g4RwtQtPTJmwdGKodzaFHJKMWfv8lChWisDBUohsuXGQna1xunjpDAkEY3SIC6FjVQ5R
 Jhn44cBLT3bhizYueygskcOlNWWgjP3Qtt_SHyXwa7.8DWmQTeRwcwSdsvCSxs3tpBgLr0ckfHmD
 htzmb4HlA18K.3FLoA1_VwRtw8YFB1UWl8TtE6psOLKa73z8i098sGhBiwAjiryyzzdjNwNXDJTe
 Vr6x.dx_J3r5.bd1xKrQ-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: f81caaeb-5d63-4e09-8ab8-35021b7add7c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Fri, 16 Jun 2023 16:52:38 +0000
Received: by hermes--production-ne1-574d4b7954-r69wt (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 46e5733d7b6da7b60f76f64d6170c2d9;
          Fri, 16 Jun 2023 16:52:34 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v11 03/11] proc: Use lsmids instead of lsm names for attrs
Date:   Fri, 16 Jun 2023 09:50:47 -0700
Message-Id: <20230616165055.4705-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230616165055.4705-1-casey@schaufler-ca.com>
References: <20230616165055.4705-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Serge Hallyn <serge@hallyn.com>
Cc: linux-fsdevel@vger.kernel.org
---
 fs/proc/base.c           | 29 +++++++++++++++--------------
 fs/proc/internal.h       |  2 +-
 include/linux/security.h | 11 +++++------
 security/security.c      | 15 +++++++--------
 4 files changed, 28 insertions(+), 29 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 05452c3b9872..f999bb5c497b 100644
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
index 569b1d8ab002..945101b0d404 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -470,10 +470,9 @@ int security_sem_semctl(struct kern_ipc_perm *sma, int cmd);
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
@@ -1332,14 +1331,14 @@ static inline void security_d_instantiate(struct dentry *dentry,
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
index 39c5225603cf..501c0884ec03 100644
--- a/security/security.c
+++ b/security/security.c
@@ -3800,7 +3800,7 @@ EXPORT_SYMBOL(security_d_instantiate);
 /**
  * security_getprocattr() - Read an attribute for a task
  * @p: the task
- * @lsm: LSM name
+ * @lsmid: LSM identification
  * @name: attribute name
  * @value: attribute value
  *
@@ -3808,13 +3808,13 @@ EXPORT_SYMBOL(security_d_instantiate);
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
@@ -3823,7 +3823,7 @@ int security_getprocattr(struct task_struct *p, const char *lsm,
 
 /**
  * security_setprocattr() - Set an attribute for a task
- * @lsm: LSM name
+ * @lsmid: LSM identification
  * @name: attribute name
  * @value: attribute value
  * @size: attribute value size
@@ -3833,13 +3833,12 @@ int security_getprocattr(struct task_struct *p, const char *lsm,
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
2.40.1

