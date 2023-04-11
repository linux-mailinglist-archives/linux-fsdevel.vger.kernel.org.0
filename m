Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587836DE043
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 18:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjDKQBY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 12:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjDKQBO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 12:01:14 -0400
Received: from sonic307-15.consmr.mail.ne1.yahoo.com (sonic307-15.consmr.mail.ne1.yahoo.com [66.163.190.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364E5525A
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Apr 2023 09:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681228867; bh=K+a5p1KobxbILIuOL5gclfCciFK1XsNuzUGzThBlXOY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=TIxu4doak7mkZNVVlHTLO9nAz10GhNdl2ObtVdTtsiFQzgX06cZu5u/wwTvJEW8Uxc1mAaF27/128PV2iTnKTtNEfupwHiDwkEm4+SwF8K7JzbFyFfAh/LcVNkxI1ZCvKxRkoyIJ5RxxQPiTH6J0M3+OilDXs9QVcxGfAThL3qxlthaD1Fx+nmegDN+cQxj/zpjgoE1WnapCOKFvDgyUxo5nmrm32MWPZZQFLMPrYLZ2/IlqemEpZo8BPI5Gt9VXvZeyGGS9t1Vtqzr9YncFuqLEPxcl/ofONeRtgV+T2d/YINgjbHAUvVI3fEZltb35oo8O6B3/Hg2dpcvlnIXrNg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681228867; bh=9kRzBjf7wB+5mAPA+BbUvyHaUFRjASqjpjxQDELQm4I=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=D1xwfVXcivTXbG50YoPNRTwbWILJhJnhQqwP+5q0yxpg851VIVhpxT1wHrtpZ/9Lg4ESYb6GNkfdzKEA8mLdY3HPNerVuF6keKJqb6Fo5ohmzDk48Y/0P9gRNxqZPsk8IUYJqdUwwD8lE9OMOSLzjm2VkxqCwEz13JttL0jOe/RQgniXzhu4ATaupsupbPZuqe6BnxCTA7A6G/XpO/FDSFtrSQQBCPSF0fbi6+jZacE8DnHextncDTwKKSjN6REhD5HmhymnxJ7SFNHBlz9g3+vVFJGSeqk6FwcKCeX2+b9ik+CQgdLQNfuFsl0hbbbja77ztMFxp7WNN7S3+2BiUA==
X-YMail-OSG: og7B8O0VM1nOvGuqRQVR7VXpUpKhds.p9QNHZCUJidk1NDsIfVlNEr_utktFFRb
 EVAB0Qk7yPPX6.r06Y8HGTK_zpUpLxjNNcx1995jISmNwFEkdnatD1RE0MI1PUkQDB_SfKmRVEmA
 LfaK3WR72jyFadrpxZ0l3HHfXwu2SxTC1mAEmcMwpcFq9nSO02XEVoXtcsQS_VVIYv6eCetsFnBn
 WNu2_FwcZVfoyhZgo9T8IUBFTNqUrusMHB_DG.Mm3xtVhYF44hEp3XQ9nEZ.Dx_JxOEZ.hGYXcAu
 j14EmUPys46Bn2TDWd9aZvomQrBMRYnwczG8RhsexhiFxrV2Em6ZGcuELJncsWa784GWGw.zXim0
 RopKTwbVCery0Bu_.rjsdtz4RUYOMjUON4..sCMwHPRRxLmU0QI8L_l3lMSu3q8to91yOGNVUGic
 LAEh00S0Oddb1KXS8yDpDdIiAIFsWK3f.7tGk1AhZ1ezYFdsreuioq3lv.CJGWTLsXN4tHJ_ekTQ
 lcOkb_9RrfmQwVIDUuDZvkqcJ96CN_DwvksA6I8eBV76.jxDOq1157SZw_Z7G.hvcxiFsRDgojjL
 0u6xwTVAmh755zaoaos23njfA_J_0kFP.0whaVkVKp7l6xB0DaShiEE_A4e79XRkgEFjxd9b9AAO
 Hooi4j0sXwZMHSt_xEiACazku8KZQek6ULDSfpV7v1zYiiI_aj3tslBgvF6J.AN..O.WaO8bQ8K5
 iowOs499xO1LjoqAwvW9zjm9gO.rF9ytXSammKoDT9sGToVw4Ek7sduVkOUc4gtDPL2BdGB4pYRL
 027u3zjGq1DH4YsCGsh.ECftF3az1mABtVffbxwTz1P5Ow0MXzFWiLelcqPYheG7THMnEL226bIh
 0buqq0o_mBAAY3h1o9KGTuTImVAXC.4RdC3ZZjGSRqM4app0tEE8vFWC.MJI0LlLSZVdNvbXKXNH
 THtDyYtUfsatUE3FFdlsa20X8YXnWzGfQLCJbb9vTUGsrsC0o8W9sf9HhhEunohnVvEkY3Dm8S7k
 A4t9IcAyjrh7OS09Q5gbPMZG8iYrOmqKpnm_X9ob6lx6Nu2xblxPlmoFgfR8UKrRBcmaTmKu3lnC
 LFEYoVAR5wsFYxi2IMs1OKr5aN2V33j189omOSZsw1AjSTf1D.1WgLAc4FscscbbF.OzzyPU5da2
 nlbzsnust.ut2u4ndhrM4wZWp1K98LjtNfPXyL_2rBb3qAcipsIOS1OryE7xMY7fgCJhSGDo85Kg
 8Lc1W_uFS_URY3awyWos6t6UwQs6A55GnYeoH6TpnvdNUe0kylPI9U8uAWLteLb8PUX2um5Pqw0c
 4BgscpyrF7GjXfJS6N2B.wcPzi.p7d8MX9aY1K_3HOuAAiHeyY5uti3xrTal6mn0hB_1V3c2Ip3Y
 akEBltbFM9Y9kdbUIEtm4ehwtflYdLG0OQzj1OlX1rZYcF8LjVcJMmRYSdtpDokRxgbAlL1SeQJY
 W41h9M0bR3EtEONmAHxdF7fp1I3NVi8vChBI4MoowBBbAs.s3FQBTHneRX9OHfSaqSIhExr7Eype
 ouGRdzbB78r2XTz3HICYJUh6czy_ZgGgFjplRn5fG_g1IinduQQlgLuD9MB_HfHRyqpa.JS2OzMc
 zeDgWk77FyGyI1Lx7uXTE1easFqtP9aKN4fny2D7rQcrfA8ReDK1PKQA9Zjp_McGQExRaIQRfESJ
 uZ0KG0QfvVatDp8YqCcvLJOMzGJ.JTTcbjptzPAS4gbIl6yB7_VevTIpI26aFSPyLX7SvWFjVWq1
 vFcr3Rt3hD8UZe0QPQuASEUGh8yEoAriUV6XvdkxZm59p9hQkKqhSd21_5tr4B_J2pWZzjES9s.Z
 03NB99wTKyqchRn1sGn2G6bMZudcOlKWsKoMas3hvbBnPp1M2VJ4ZjYBzGP7Yx8ndNfpLtio7ti6
 Ch2Z8jSnySdHsRIkyejy.t9iO0ioezoHA04WZfBwz.hM8lwvbEhNMWGdSza_PFanSM1XwBmnH13E
 dgIf14XM_2M7v0tZSbBzsRnjUQMQdMtO50JEN70V.bFLG4XyldqlN3fAN.NEwkoUC1pMsO9BmXvR
 Llv0twPL6S2ic74OLqehNA8LODii.OUsj__pqEstPq3Zuf6Jc7n_hA819aKNHRbkr8UiLYRSbE0d
 U1.2SM_6XZ5Rl93wVrSE4_89aHr7xwAzz9vFOXzK11XFDRJMMWZl922IJJA53y8Jr4YgX3D5hfIP
 KHtyAOOV65qVrYu4DX8aBbjxExR.Y4APKtfVWlskDwL5UddrcJMAfzk6dYJHhCRbd_M1n2L3ePbf
 ZwOz.lgeFzpImpGXMkzM-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 5feadeb4-7c34-4ca0-aad9-dcd39bdb2cfb
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 Apr 2023 16:01:07 +0000
Received: by hermes--production-gq1-546798879c-7rgpc (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8b8bac55a2979a45d5da198554da66f8;
          Tue, 11 Apr 2023 16:01:04 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v8 03/11] proc: Use lsmids instead of lsm names for attrs
Date:   Tue, 11 Apr 2023 08:59:13 -0700
Message-Id: <20230411155921.14716-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411155921.14716-1-casey@schaufler-ca.com>
References: <20230411155921.14716-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
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
index 3f98e5171176..38ca0e646cac 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2167,26 +2167,25 @@ void security_d_instantiate(struct dentry *dentry, struct inode *inode)
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

