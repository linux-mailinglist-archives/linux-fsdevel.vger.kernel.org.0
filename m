Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27BBF662E61
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 19:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237358AbjAISKV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 13:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237434AbjAISJk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 13:09:40 -0500
Received: from sonic302-28.consmr.mail.ne1.yahoo.com (sonic302-28.consmr.mail.ne1.yahoo.com [66.163.186.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159666560
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jan 2023 10:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1673287747; bh=UkfRcDMPf/v1DcWo04q62pwUSUPbnp//erzjsjt01Vs=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=DTwP1PWzMxGoqT041JAZTuN7kRjnfPepw9YnmknPtmeQXTpRfHl5oLUwD/SENda2P7hhneYngAeV8NYVjvEXUwlV9pQCJr/D1xPuB1BUa94MWt9UgqdJ/M11J4bpz7Wp6ELSRoM/OF4XFOa6F0v3ekn9VrIbI76e+qbDAl92D/1POciUw4d/PrcR4hLmTrIfWZDyZWji8gZni10eMWEIsSLNEhmIgid0o5tS/Crc2afsZJQKSoILpT2g6dENb9hXMq+U0K1h9v/Wi5TkUAlotABfuFBK9aBnUQkTZIq7h39bEfx56LcAtTIe+4fq9Vh2M+oxqvLKHBMqAspBW3TxDw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1673287747; bh=0V71/1e8f/JUulk1j0yXLI4ibca3kGMAkCTPoIx8CKv=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=gZ4aNpsOnzWyS8h1EbpX1G5nCp5qmiHEEQ0l+MCMxPu9pJyXpLun9Ldkh3ewFyfF0A1SUrlLzrtGWJ/NBfMuMZ95EcHavzeU8j7yQPhdM28RK/8MW6NpYdvXXAI87wi8C2/yvU5ygIxsg7TtrfLjoi53EtRfAgO+YmwU7sjK8SOazG8Eun+eOPU+L2O6YS69oqhn7ZzQA5CnKTcTYTSQUPPrfUJKmHPygCpuZksUr1+QWGslH6b++PyhClGUpiSpoyUoqkUe9ZUFzIvk+T24d0e/MQ+Trf6ce5Wnqx/Y/ofaaL3UunNHW7fMhe0R+TXli3u1MRgYlZLuxnNdv4CTrA==
X-YMail-OSG: CpzcW9UVM1mblJ2JGRpNGRRBVfYPbAxCcDUwbRlMQp.mvxCpKxnYVvRBTgH104R
 L0tNZ.ttFY8j6yb0OmBQhvjSMvWW0CQIcDlEDS3T4Vqyc6GD4kR9otl8q4EZb91jbgxbFQN5PQTj
 ZgA46h18pnKtGfePgANHcpsaZVAcpKJ5BI6oFi4vlUQQ4cAVkVBFn82Ca19twIv0Yo.7p9lMzjUL
 5xdJX64zlD5GumMZhZqbuh5AV_w5qxQTu769E46iwJvlpEuYarpSYe5ZDhOHdAd8jiTy_xgCDKdh
 7nr7noD7vnvfBsIUFWx6p6J3XS0Fv9altzty35n4AIxBuUJZLQyALIUmBtFhamkYBYf0RwYGB1Rt
 ZPiG8fjYDCXK3v2tXxQjMjnfZH8PjeGBVpn3G.uQ4.zjpTWSWXqrC68KJHFJ7sHmA3lDba1ew3ti
 Y3ICjAgOa7gIPX15szsSlr5Gm56XLX.kNRtb5TcY99sXwIEGsr176gJdnY61n73j0z98kmtGc65n
 FJjR4A7DoBLnnGI_ZPh8DAvqoAbS5Ec8bIKrGC15dl7V5AH3gjt3FC3dMtkZlaGRlx_A_LPZ9GWa
 vKWcsSRwTq.7GZfX9LeKb.YGksUJ6emdUymOZ7RZHKT5tjWn5T8Q6MOELa4GIH3qe6dms.d506JJ
 1.9peYpcR6WH0ogmKXb9okbJeOLNvLq1ezMYmeaXeW8Wij9e7EApW1dn3enoAkyvbCc9FzZHRZm2
 jMCPC4EAzANHwVnaoImruIrpKB5t.nIMLv6k3g68itIXMo0xB1XTckm3y6pCMaYSSsmH7DKWdhUI
 Oe6r6I9cZUUVF6sHQruKRD3YxIkwE1tNo18mpSWlueLBY_.emoeZN1n3p2Entcelk_Dar73DIifZ
 wYxc9Mv5BSKzQIB9hbmt1UgVdx_PxjsZwMirBnWG2aD0_CJzF5OqJho1K2mXcXdWxkUcmTOaZRR5
 OTwwB1lROfldhGbNlSrYd4CF7u6gP_YlrfTnpTGnx0xRRuQEqp6FKgAzCWwANM7l6TEPj7RY2ZqL
 h4zpgp4mZDHAmvUVox0gTSYkqwmTDcMALCnS11b.3HU1i4WzKCx7DZozerUn1_aDL8xhtHm2aDE8
 zbvvuvRE2hjcnEGmEan1gV24Rc6L2pqo.WBYs8MlURVwY25DvUWdp1vf.67Ot.vPCS7aGu.knJ2s
 zKVzYpzG12tjUThyL47yjwv69Jj45qgFkEJK4E37GV8zTvmmj3bCiqRFtrZkbkESMKjVYykLodij
 PmdOfQv7pAwwxGUFFGVboSUKf5N7q97osjz3nDBOe0Nh3IAGdYLMjEBtNUSiHqv2uAqLtD_65wQk
 T3UEYZmVrNSBfvvj51OyLRnIxxN6OfvmNrVEB0xPiDU8Sf4QCUzJMn_vtrT7U0gH37IrLet4YgdA
 N8R7RkQlgmHgMdnAhl1sPU8NOJNuGdOWD7_jER6yiamcxKoj6LMFVTuynGZk82a6etYiOusm3Hcm
 ICBMxGVlnb75iNVfesnCtjgP7MAEPyDBmdB8CwQo1pzoTTjg4n3h8aNQcKprRNjc4M6Zwj.FSFrC
 L8aiiFxWO4QJTmwG2fOWFCtcHWT9k3CbvRkZO4.iwOzlE9m1wm16kpj48aJsYaI6WfdJkL2vgGws
 p6ntfgxUAvjUXix0zKLCfOAF8odzGFXc7qr_WN1zq8pCEaoZH3Ukn5NMm2631jbKmytwygy4ibp2
 XiamsL58G5gPmeTnL3UDjAn9rLCzYuOwuqAV3hPaHRdDCL0mZqf6EJaoR3vJXzzKVJ.HXGJnLREt
 zabCwjC.deWDzQO2mejPxnPbth7NvC3s1e8.YZDhY4fkJWfIJdTcqer1hwqfL_zb7n.jjLXjsdXq
 jyyn5UzCPJCtdgvG20AMDb0GCTxrSO6QEoE_6ZRrQt5Ud4.jKdsD8xUwITwjQttUy1wTzVLyGvyN
 LtRi5OlW7Pk0ob6W_37nqv3as4STd_fSy9RJ0S5dGE8gb3zKQls.fbOjVX8UleMvXAZcfQN.zkrI
 EdMZOWlZKnmxJau.5A5gPlQy.6CAadrPet0mXmQi9OU6sfT7pwpu21t_EX4L6uOg6UuUFDwFQHlw
 l4n9b8TE9OA3x7N54D2HQyfBYCtadNUR98QbibZJIywgk9aYw7UHtGWo2FXczmF.qeKNxOU77Amw
 GhmnmmHaRFb_vcuTWgyqZ48YA2GK2w6buPpbANLr0mQ8q7dLHW2gCV1ZJIRfJtNNjoZ9DTccFRQz
 iWDf7HDWfUrJpmkqI__aCrRcm3gECrjoCTNMSPLnDBAc1
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Mon, 9 Jan 2023 18:09:07 +0000
Received: by hermes--production-ne1-7b69748c4d-474lb (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 3be57d1d3a3d9a781b586d3784815f58;
          Mon, 09 Jan 2023 18:09:02 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     casey@schaufler-ca.com, jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v5 3/8] proc: Use lsmids instead of lsm names for attrs
Date:   Mon,  9 Jan 2023 10:07:12 -0800
Message-Id: <20230109180717.58855-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230109180717.58855-1-casey@schaufler-ca.com>
References: <20230109180717.58855-1-casey@schaufler-ca.com>
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
index 33ed1860b96f..2d09e818a7d1 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -475,10 +475,9 @@ int security_sem_semctl(struct kern_ipc_perm *sma, int cmd);
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
@@ -1346,14 +1345,14 @@ static inline void security_d_instantiate(struct dentry *dentry,
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
index a590fa98ddd6..a0f4af2da5f3 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2169,26 +2169,25 @@ void security_d_instantiate(struct dentry *dentry, struct inode *inode)
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
2.39.0

