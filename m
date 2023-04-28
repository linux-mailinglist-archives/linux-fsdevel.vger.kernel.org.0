Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E966F1F7F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Apr 2023 22:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346650AbjD1UgH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Apr 2023 16:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346594AbjD1UgF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Apr 2023 16:36:05 -0400
Received: from sonic307-15.consmr.mail.ne1.yahoo.com (sonic307-15.consmr.mail.ne1.yahoo.com [66.163.190.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EB52680
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Apr 2023 13:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682714161; bh=Z9nxeKbR438LSTP2aAwXWaACuXFQ/LPIBOgaq5Zksx0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=bnEdQcSd09ldghpnj0xWSJm2ZaPyUpq9AJyoeQWcyhZvG9utvW3g/O3qAQ8Opu3a0mE5c1c/7gLdnpVPPJfZdBXmKa2jNQPpshdOkU6MdpFqNZfh7Y0gzGooX2+NPoK3EZiJNElExqTstWweRAbDsWi9StwM6I82OvmjfB5lEZv4qGhZdYHfVbmUuVWZcn/c0llQ525Fj5W4MgmqnHiX/pbl5tfGGCUySR0ZhLGELZoMY58IRRvMB8kwbiautqG52LksUGTmI7Kw2eY/cLXkK4VFuqC/XnX+xA8ziPitsJr2R98HGKzCmS8t+O+SfTTdw9yE04FYEV850luRgucGHA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682714161; bh=dOztA4aP/OoVAsXLBz3o36hgyBNVc4KDmZzHOJEb24t=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=dq6EyGl9h7kvN8MFfees9hmbxPDjOFlbHdqIBGLcw6c46Wevbn2B9y8D1z/uHtu8DCzN4znlOJd8AYzrq6ircosObCd1pPrgBjw5T9Ox0n4MGHxlJNCbkjTUEaDZ59Mf8zd52fQi48paU2P8n9ENqAgQTI2EAp+9RlrWFmvH6X6E0NU7nP0ZhJR1Lp27wEEUP9adIITKOMbEkhmcmtqtuNJ+6EjyiiPZuNkXK3FHTNovC6+52qFuQzirEf6w3OgR9+VdGcmKs8gNcXsv2FyZz6H5gk1aTyh5QffjpREVF8fTYSWNlTygNYYEsRTs/AKDbL7g+NuzrRjHph4/Vm7Y9Q==
X-YMail-OSG: iTPDWNoVM1lRsIiaBd4O1etERTCAU1GlekRAQdXOnkqokVqIkjckmbN_Cbk3HNp
 LJW318iMfKYA7_emN4LREsDQdKCe3HnJyPhXG8GtQ6MrS0J9jG8xonx4D0etU.gGBTD_bKhUBkOl
 MFXaxztneWBu6jEo93H6bvR8EI4kFpi1ObP8JuTxbaqppQ_2MyEDcLlj0P0.w3T1jTk0QNQoKRO7
 wVZYnW0XDVSlfPot4_uR5dwm7FquTofk0a9wFyKNcZ3UYdmATCmTsXDOrlfl9klxIEjYsQfaVjWD
 oBSITcIw4sk0fUiGYPhoVwAQT1Y1hCKFlX44Q0cVZDSlhiZvTaBsphyOFxSGi9RZq0g7mmGPjkWq
 gUCF7pcJJiLkJZ0YbuNrSMZOzYkFaHFYJOKx17WNJhIi2UDMLp4MekY5biSfb1B2Q_y5MYkDMiPJ
 JaQqhLPSKlRMXwXND3sYvIl6C0nZs_GUzdqqeMwmh6zmaQ7qSbhbQ_HE9Ykyfc8O0X5t7OT0Oztj
 .kNgW2kE_wGd2tzpX_EaTRX67arDIwXpMdHsQ4xIAvcgqkVqcOP8.SCssQ_TC57HapUi9mTP2W6_
 mvRN9SElZ5s9Zszk951bnKVcDfioes28NlNQGcfgJdadbLrVVTMxYaYLQ26xhYUucOs5SkdoswRe
 DUVVe4SNdSHqzeI7VekTBny2e6bqJwF40nNFvpOlXkGPYbj25.dg0Y3qCsrq6669tYqIneSS4aJT
 3bvqLhDJEU6E8XMubqgC2isdHotK.NBkcaWPb69uTQ4KsdOFNilcZMNoJRw_rcrRHxdeuhzxCH3w
 fa5fdQsyS1ugnNPikC9_g5WkoO4lxzvdVmaYBEe2HBOMrXKgXrHwJurjzWtQrKIehJLK039BGiet
 tw0wDgvqNw8LWgfX.0cB.ufLGaexkDxu7qKoRW6eMkuLwc1PKoSyZrW5xv24mMB3VRPkkQM5E6.W
 T3unQcZ7QBd.gh6Y3QUOKXLP6x4Ih3zKYK7kBCUsR14in9e.v6RR7f2zd3BYsA7h2J9TlfdNvK0V
 eHBB7WdV54Tts68p41GjQDCXO_VI85W6CAeYdWoIC9ASF1f0vv6vfFYnrLAUdz1pEfFfdm5iC26m
 Pz4Gp9i0OuRE4._8boFfWskeDInDXu7k6oaeZnKastIocHwBAt4uSujqi8Hz1c3S61xc6udQNRvV
 AYRM7aqM6S0..kbPOts5xIgwCG4iXCdHBjU88QwaDiuPaHonKtm9oVCXDI8wjeIdRZl.P5D2fPIx
 AylimqmX4umZSb_pFep17CwrHmjeI88PRZnu.61U1DUuAU6fO1LcpbNMXCaoVZZeG5sVDCJ7vAZ.
 j3_nP_5vlMTnnFwyKO3H99bNJxQIKo8YpU0Zu8zH1neueNFj6gTL9XEFDAB0xQiBPW0.suO3YbtQ
 6PeKcn8UIu3sxH8YScnCk8gs.khivTBiWQ5Z_j2cIrxMSQZk9zwq0PI46_ZpkntzlJI3aEa8Datb
 IUCct.st6uST46toB7JovzGsi5gfZJuE7C0RmPOwqx4hs3IO9ra1QFwPd.AYc6ExU1oXg0zCM4n.
 c6GOBFZFaL0fko4L3YKN2DuAvjYM77zmWcsp2qHfPrtd74QfbIBwFLM91YjI9vm0o9h.ROm1Yf0N
 5BRWSPsgSRlCV1x3FqzOTUc.5lDDBM5a1cyY8T76UknzllogCzx5kpzIzMs6r_vAqiUlkCGYEdfQ
 lxNlfdfSWEppAdV09DfwkHsYJexi0VydxIV1ZnrgCnoddWJ_NyYJAF4BCqmGPLuNgEmXrkNimFWt
 aqsMbFrHv2clSjn3_qMyenfA5l3src7zDkLBDzn5yml_PCZlfMQ4iSnF8BSzQ__qvef0Jshq.jbO
 vPZFlgmWeZ3GQZMEiwh6esSPYY14GcaMobcgCuQPC9O6Aoq1K8YCwCFNVOsFH4oSwytanvJxarQg
 .Q_JXUQC98YFECZGAZ5tMPD5PMBk4DhjLX9F25rrDoeLZltakUZAtS64ytleRvkxHNNo5nEDInZ9
 Jh3Vp3HB5fz.PaCP_skrFWLsgysSpRPddcT4rf6WMFERLhDMfTiJuV0YkhiQyNt3YdHr.G1ImEMC
 r55v4Mty5dbKDdkrnp0DX783zVZhbO1tfwaSBWUn1nm2y4Yb0hMraeC9oM1rZT.CMRnwmmneV762
 iLfa0ggyVgziJ7W3U98M0VfEHbat7lGTSwqjnDgmGR6eiqSvV0jve7g.JW5n157m.Ush9OprBpqy
 aV64KCEKelAC3AuizSKnsSXXyIaZt60mzOQZ4lstsXowMocv_3hN.gSt.8wkru3P1sauu8N5AnHs
 L1uSpMF.JZIzNfCoDlHD7SFx_p9EoBK4-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: eab732d2-10f0-4291-9bed-60134f0b6787
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Fri, 28 Apr 2023 20:36:01 +0000
Received: by hermes--production-gq1-546798879c-mpgfb (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ba26e713cb439f1ca91afc1b8b946229;
          Fri, 28 Apr 2023 20:35:56 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v10 03/11] proc: Use lsmids instead of lsm names for attrs
Date:   Fri, 28 Apr 2023 13:34:09 -0700
Message-Id: <20230428203417.159874-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230428203417.159874-1-casey@schaufler-ca.com>
References: <20230428203417.159874-1-casey@schaufler-ca.com>
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

