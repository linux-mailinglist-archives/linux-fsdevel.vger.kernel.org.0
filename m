Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683BE6BC008
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Mar 2023 23:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbjCOWs4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Mar 2023 18:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbjCOWsv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Mar 2023 18:48:51 -0400
Received: from sonic314-27.consmr.mail.ne1.yahoo.com (sonic314-27.consmr.mail.ne1.yahoo.com [66.163.189.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4524231C8
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Mar 2023 15:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1678920525; bh=FMVFAxqJdW5LB5HmBRy6lGCH894a+0dyKnb8QZDxt3I=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=aAznSEjc2F6NJ7uaMR1ZQi9modsveslJXmjOAyZvMCjrknsnnMTc0DzyR2Cc+H9ui1iXlsRFGtCl4eSRMAX9GoXH/NYHDxoQq+fi7dwTkh8cz1dUjf5TRse8Iy6zjcYLvOYtmikR4/wD55uVkuLsfjnvk1o6dPn0Sl3miBFpu7iuVPrXXVIPyX3ouJrs4LUOWhBcrD6LNG6nPWS2Fk+BTY8RkFSzFdMbliIS60SkWMwrVjfxrh95ErLW3QNI8kgQkIitMy7CpUwC+MOhM0dZp7xpi6zvVpCLjtsRpSysDeTPXwkdLpS8+dgt8NAbhRfO4IchgmwwItJjDHpPh/LoyQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1678920525; bh=d7lVY9W9tMwABm0YRNC6vvbP/sryM4aC9W5mkbzmsn5=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=sI+ncWp1O1/gNyH1pNZ0WwAsgbblYeP7ojpdAeUV4PcfHapgEztmtiKvWtPqffGMcUyLT405/gq++0+Qe3GpKCMGm4dAznvupWSx7Btb7jMg15ZPA/sZVeBl7X6XfoSt84/wbcqZbkefoLPuCK5eXIYdMOklHVE2/QHpRlCxmE7+V/aC8aYGA81yDQ+06YnrJe8sHFz1FrbzOLKWLTcKT76EnUpXd51L9XDX26SZh8u+3Q2gI1T7X4uCN0Tug8J9/rkKrV6fH6zg7GNf/86ZJ9US/pidUAyyGsgWLLk8tO6C33vQs2u4WNajt55HbFUToS1YMrczeuDeMUqKJbweCQ==
X-YMail-OSG: Lph3bxgVM1mae997hMuryZDgdzOaxVB_4hRDRazerWErtgI8l7o7Sr708Ugsq5p
 qqb2S.W9TWL5AtPJZn_eD8jbW.rp6FilF_A3zb6GeJNSvQn34FJkSV0qzW7NN6Fq6Q.D8Mn1aAwJ
 umDn500aAQpssjiDp7s8rYFVhv9XNiTT9hh_YVSsmCsxn1wiazjy7Y4E_fi019dcUQoIRv_WrbuB
 VKV14qiczBT7aHIdwatGt2SyKH3cXdE_DTU20eirZ03NtejQzPCwO26FYcErEbfCI5Dd0soarkFP
 LKfOJMYAOBY3eS_o2S78YWcMz_FUpuzp4YwEbXHWxY3fKGG_F7pyGM04I43xb9X8is8pEBKogHKl
 reFoCAka_xg2TQQGOwiNCMp2LH2WygN1pPDDQ1T63b5e378lgl7wSZtG.arr2FSfCqqX7SmGNqb5
 cg4ZUZskEqFo_2KkBkxrvn2mgU5UvlO_d.g4B0ZbPp4XE1VixdocA6eDo7UbMPWzzXJ371hhzMug
 C5k5yNnP64IR6MZtR2gU0.kIvoGomP1FT3qK.GdPisT6a3PfWj95zyMaEumqKiF7Wh55wDspvI0A
 6083qPXHJ__TZ1PvX4Tb8R642y30YZ3H0waVLTRgzeFBUwIxFIc1EDJWGMQ__e7PHsgUkmmO23wX
 IUzkKr6LHdaXZGkF6i_YY6JcDBUL6cg3waBlqgzWskKHyNnhsD_4PumHu_xNAIRzXgo1SwN_e5rS
 PrUnigj7U2b4WELoQMZEcH_bfOA3r1t6shc0uqWDMlOirTDEhTm_JkPDqwoUQ1.hQHm2qnw4FpVR
 T5wu6i_x9L4M1J2_EAUG_MuBZbZXo0Vtt8CduXQJQwePC8nXQkc4ILSexnXQBD57GvSXiCmKB6UB
 eQK.SvuHaxhKMtvXN4swkDf8vnvbbR_RGP6IqOX.q8VyMOSJ24r5vy3xn8OgLa1aC0VKShNGkewp
 g_bBxy55yIUhA6zRT.nzvjrXIRltIlvgfdBMe_U2_AhebdnYsf8UZlaoCWUqb2cesZBSYlcG63Aw
 rGX8edHRrpusrZ6Ytp_K8Bs_haeUu_i0dD2Kwb12k29dCzmbyNQmvJmuGvFvus53rn79RZM87oqu
 S_aVAh6FZad9QeO9fow2WGnkyqQu0Q6KMDFt_AqJwu31NMICaezE8eFhtAt5qCxW0YNo16q1_P77
 UE7HVaHcQn3skUrEoqFWUR8LU8FwD_RuPgk0hwtowtyrZgACX2kd4SL99rW0Ja6QEUNut5NJjCPN
 cy.NZitFACmYv6edvhmN7LEet2q9m_QLg6iZ6RYr2RbUEUhK02NmMjO456jo4Pj3jEmxpbWB0gBr
 prEFiVYWkBqewvVwa8TerxaEIITjXVpnqZ1ZQfvRNsxzRO6niT1I4tarRSvUoHnzboCr4MwkHtfz
 VuzIhd3yyh6KwRnobHZrtvY6Apavx8Hy4VCC5rXvP8Sy4g5uCx3M2KBN.1T7OrtR0Pu8gATct1LK
 cMr9MIw4jkN9NInQKbkttjCi5CtaTNy38lRfhHXO7Td06SwiIl.KEf5ZOBAiyBckPdihDoPnlw2Z
 fPmc85Cp61fsRGKNQ_zUedrk9TMxI9rkoqB3xH053BvIQ12tiF_wKg3CDy0JmPuNzvnJ5EWDLZdx
 4K5F1TFw3B6OnDlVysOoN0CgiTKjUz.RzYNQ42vFodKlsRkLWedPSPbB.fWMP4xlrF61oGtwiODM
 F8mWGGv58yfG151E4MCAMExwbYlJ2Mu9Qywf62TYzNinzIhbyCfJAGoCzxhGV9Cx6mgyRlcwVUxe
 P_ZbUwYcdUUctBKf3Z6mQPA36C0Cja6hqVmZqCrFuXG1W.WP86OkQv17Dqbit_ON8FoGXpTsy3yF
 nZr0O7e1JkR4_6OqIuwNLwfsmOQUnmx.xWng0nBVGMfyXxouf56gMniMXVwPaPjnt3vB.rTgEXLa
 mi31HtfAvVLiLgZ1lMahtHKLW7iSMWKbTE5_wJ9Wz.6kBAyK7gtfP3vyOIuWh3MvGjkuTuaj3vNT
 p0KVTdhw0H1VRghKIz8WcGtbs6MV6kRL931eCc_713I.VbTLCtyKYd0JsdhpDbeG_6x5Kg6Und3X
 PRkUDZcIeCizRmT7EggKOIwGoBzZLsYS4fFYmUMlJnvBwVKwLCBnTgEdBwiydnF9N7Enp0ihqZKB
 .VZQf2gfYM_Q94wnGTMYKt4GMZinmRbjC1cSDLnqtCsgGONBe8Xv1dJudIes9ZgLWyM_YB4wpmS0
 epBB.0qarynn9VZIaOXj9Ohv3w1xS0JZBw6hSEMMb1bSv3uL_dBLlgVPrMMkHpBqZUoJ7RMhe4l7
 1Co9lUW1rxcpjl18L.7s-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: b353b499-8fc4-4618-9168-04fbbc2ead2b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Wed, 15 Mar 2023 22:48:45 +0000
Received: by hermes--production-gq1-6cf7749bc8-pgxdl (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 85e66b2f7435f9f3ba08ad33962dc8cf;
          Wed, 15 Mar 2023 22:48:42 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v7 03/11] proc: Use lsmids instead of lsm names for attrs
Date:   Wed, 15 Mar 2023 15:46:56 -0700
Message-Id: <20230315224704.2672-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230315224704.2672-1-casey@schaufler-ca.com>
References: <20230315224704.2672-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
index aa84b1cf4253..87c8796c3c46 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2168,26 +2168,25 @@ void security_d_instantiate(struct dentry *dentry, struct inode *inode)
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
2.39.2

