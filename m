Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F01576D5DC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 19:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbjHBRqz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 13:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233856AbjHBRqw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:46:52 -0400
Received: from sonic316-26.consmr.mail.ne1.yahoo.com (sonic316-26.consmr.mail.ne1.yahoo.com [66.163.187.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755482D70
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 10:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1690998383; bh=iaQolsl3sFRyW5C1He9kXXrK37N5lEsFb/9+BTkGmFg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=V/dQEF1kOhNPyHofyT0gg2h2tx9RiGs8xjpsXJTVCtaQCryfjIV/o0GAQ4uMa1Jlyvc1S7PSHHQ5tOuidTY+pk4Um2k/lq8171n8fSV3Ww1+rtSOv2E6o5B9UnTMkK5t+Ex1nBM2L+ZqjYkEG2jTPyzWFLOt3gZ1E8f7i9Jmn2y6xqu10xZqPYcsOvwIkFntd7s2LVo4vRvQjqUs8o5TlkboIcF+c/lmdzrfGcAYuqkj5aGEWxTmF8pBZa41BxTllFYRi+4P3rVBrGrwB8H4bBTHybFxzZiuww+yLSw/wVFnAj1iA74l+5V0QY3LR0Dr/Cr4F4PTacnFSRejFGSeNw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1690998383; bh=u2my3CohSbo13xziLaVtDHzR6Ptf0wTHKjyQVu8PBBR=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=ex8JE0R5qhc0rac9FiQhLXrb6f5pUlYrl77xSnPx67koGg1FB/C4DREhvUPwB2h7bBznt0NyI2fEmHTmKghQ+PvxsE3KUmfKNHKerWC7K2TnGF6g+SBC8BlSB59ZPtQlGHUFvnJl6HCg51XwmckkIBC3b6pqvJ2cQpxbY9sSO0Cv219AxMUl6Zb97odIUSBNkW7M2jM9cMtyDRvbu2QohQf7n19DsTWA7XuWp6/DE1lVY26wI87YSRiV1GPvqZVtJsqV2FacDKSw5LBCogEkjqcU7tkceixFhYKOYIDE7bJLef4sbgsi9ZRKjVQtAGWFjcGAJJTCPQAMS7vq933wLA==
X-YMail-OSG: iPGTO.wVM1keLaDBUoKuDAhqFN3vtRLoukHHj1gacSHG8SnRNeKdhxg7hTBd1LU
 FxzW.UvOiXJd7j_bpr9wwFrIRBkNB7iuiXSvsBgaQmEAYzJzAyTrutO_.AbFKLTTWHuL6ptUPN4s
 .7qjDNZ4H2Tue4BcrxvUDTkMFEA27YsfiepOG6JnU0KnZ0YKT97r_nEQ9qeW.rv1x77_Y1kqYv_G
 2sucrz.DrOAmBuw14ACcV7SplWcb5cDhhGnmVQAFacbacG2MAFPcwmZjTKU3xMCHNgsvd9hlV_jA
 crLmpNioe..rf7lK8R2JIoy3eQwnc1zjvMGzmByseoy_J6ToA3O1KSp0CJr_gMsVMS7_XKXdOTzU
 E0izgZBXTRcLO8cf7UE1SZqA5KCl1qYzPSOtfNVWLMxGGoFSLeyM1LG1BYo4Sx5OFr.LgRo9s4zR
 UDH439WDxiQwIMO.pv_c6HvhoVA.r1MAEKCakaekZyt4pLuC7ydMwqPfLeO.zt_63Bi0CLJinsTT
 ji1V2cV4Mbq09CIN2VpH3cOTypEfl3.wWZ7knGl3J3VRx5VAEDf3BbQt3BVEBQAO09hTCdJkhZKW
 b0dnnagVmPzfg.GlGw37WOJR4q0oq2dzushjyCMSIVePTvZrU_GkoNT.UG_DkvqnZ7TjiS_LNWix
 1UPMMTdbcmP1PxTxN6pOchaawAfbarmHxgoE4w7JFUR_NbmDnikNUD4N2OyEWRuxWCl7mCILOCLo
 hpmA.1cGAQMf3NqpGusd4.ee9e7g0mxrO5TYqVIHF6c9gk4QxohrCz83ULhSBrwPzJTVJYLDpGsj
 LFbgzAFzS4imC2SV2723xa8pdMWoSwI1SbTHNP8_fB1QGAfIE7mYOiyyHZbeBBnHtkxliedyF5Xm
 5Me8Kcx.0ZBLC.HY525FQvf0OK_Ne150DuIACc1M9kyI0Eaoxv6VJddyK9Ij0s0OjAFrmnqcCo_P
 H1Ow.q6PDYJ0bAy3p3wJ87PnS_Yh_Et07RsLuwTkL7q8T4Q8xghmElFOOCX1zNKVqSFkwC_T92QP
 h4JX4.RiFbKlxl4h3_51XVmeBv8RxUdcMW.ADkZFlScypvZAMCg9SmoHgyCamXP42IVjWMooQEoP
 rBpDm8fbUN2PIzeUG0Qch00Af7b.TTEBfLSlbjk7dw5aOkn0zXz.zpkhUNIw5euZGpFmir5eSVeZ
 w9BVffwnz92Ioj27OEFI9gupHuVPjFo1hleKl0JwfR56j4nlABmwfW5GHPpB.OqwXAsi0zmTluLJ
 L4K8ik8Yxt_mcKt_oOEI.ZvYErsmKGaos9v.jW8IKsihB3Xq9K7bZldFAZ12PIyrKz4z_GgWf7sq
 S.EJ5THtDLWpZEii0r1ZxcixgoJE3eeH.mzyuAVSev9rp0na0..qUIJbF3BjvzozDM7R0_N1QGII
 dPUL1Kc7AcNzaj5i43fC07XnZs3jj79z7RiNStR1VvuTIeqJxVXgi7yjfr_wyMUw0LcIjC6EayRR
 P2.MZyDSRB58frHWXvC3qJV9shagwMhUges2nOPoH.oRvQ.aDZ1QGKBY0FWhuvJallRf9P5QQkhg
 SCKJUUU9dcWl69TvPCKlUkU3ZWToJxwNj6HX2q_DnI_ZChe0XW7mLnxKsw8W5FqXKIHGjuArEhiK
 QhcsSyysb2VOvBptNOwZQOoh9eHiz3ys1mJvhfc.HvWearV6AJ2i9jYldKgtLQkie_UBw6oBLcS4
 B3TdU_ahegUTLFwA7_ebX4vu45e1bex5fK1YQtNvPO3hQurekwjxNGHk1rrFbyXzN0dDq8oNzHfz
 WuwVcsf8Bi_9Uojq0KfhHlxiEdFPjL7ttMuzABohaBp3_lCmJl4g97S4RK0lJdJ8qs6GfbfQ91ZZ
 lfiV5LM5C8V8KLSMY9tozlhII54e8gqew3EU.MmA5ZhaXySJA.TxMmtrmVpbwTYZ7WNdEN6YTs2w
 ymJYIT3.df8tt1zZqzE92ZUat0jLbcks2RpRL71BCd0ckn.ydKDxyAzy25CP._fm8Y6zYJOjROZR
 NzvAz6f9E_V968kU2sJ.x0nrMGnagQMPlUCipndQRPwFnFz9YUD5UYeos6jAj_bAOi60.QyepTa4
 QqrPN5Ri1Y1eNizWcSbSJvkZAbRbEXfHbU1NFnGsExo7fqgLQNFxHPzkzkHjwraR.TgO9KvxCRxg
 EZa7ZD2o4T7wUagTuvseI86REIMPepY05E2DGxD_NvCEcWddhjf.GwUnmmklwklgc.W24N6tMi5i
 WAZumxt8fUbp6U7m1ZAqHKSoSPSiTFBoNWLpttAowtyqr5.fF3genAJSYOjERmd0sJeoTHqehmkA
 HXe.ahe9igeA.t6UAVg--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 68ffcf8b-d10b-453e-bb7f-4324b32ce5bb
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Wed, 2 Aug 2023 17:46:23 +0000
Received: by hermes--production-bf1-7c4db57b6-4hrkz (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 49a3a41e5715f67667cdb3b18eebd6de;
          Wed, 02 Aug 2023 17:46:17 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 03/11] proc: Use lsmids instead of lsm names for attrs
Date:   Wed,  2 Aug 2023 10:44:26 -0700
Message-ID: <20230802174435.11928-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802174435.11928-1-casey@schaufler-ca.com>
References: <20230802174435.11928-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
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
Reviewed-by: Serge Hallyn <serge@hallyn.com>
Reviewed-by: Mickael Salaun <mic@digikod.net>
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
index a20a4ceda6d9..b5fd3f7f4cd3 100644
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
index 87b70a55a028..5e9cd548dd95 100644
--- a/security/security.c
+++ b/security/security.c
@@ -3801,7 +3801,7 @@ EXPORT_SYMBOL(security_d_instantiate);
 /**
  * security_getprocattr() - Read an attribute for a task
  * @p: the task
- * @lsm: LSM name
+ * @lsmid: LSM identification
  * @name: attribute name
  * @value: attribute value
  *
@@ -3809,13 +3809,13 @@ EXPORT_SYMBOL(security_d_instantiate);
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
@@ -3824,7 +3824,7 @@ int security_getprocattr(struct task_struct *p, const char *lsm,
 
 /**
  * security_setprocattr() - Set an attribute for a task
- * @lsm: LSM name
+ * @lsmid: LSM identification
  * @name: attribute name
  * @value: attribute value
  * @size: attribute value size
@@ -3834,13 +3834,12 @@ int security_getprocattr(struct task_struct *p, const char *lsm,
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

