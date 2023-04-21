Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5A56EB0F9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 19:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbjDURos (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 13:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbjDURor (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 13:44:47 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com (sonic317-38.consmr.mail.ne1.yahoo.com [66.163.184.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E221210E
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Apr 2023 10:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682099083; bh=K+a5p1KobxbILIuOL5gclfCciFK1XsNuzUGzThBlXOY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=TzLx+2VwDKcgiZxZu2YhzSHfC7y2FHlGiD/bmKkLhuKRbLciLUQw09zbZbgSRp3vznRx28qTksUPA1maaVBWP2KoVyY+iGPSYhS/jct33Uw6cdODG5Dp+TjbPiCGSqqgkw/LFCVBGwBTOVshHbDVUyn0ATCvQr4y2kyhMoe9Pv33fGGwoZ9d8k6FVwR7uw5EBQaSpvOCiJTjshi4tZMt9AFOWueqoYWbh07uLNGoiIIzmXJHk4yI92Ghyx6anqGpt2Ruxb7gU262HfJrkeoyMqToADruHXnBBQZ7chPJrIDFGsvPiEkm9Ux1k6toPnJ35CL1Q4xXbQDgoVHUOF7J/w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682099083; bh=dziiuDH1EKGxkLx1DwY8kTjpNr6qwgQnuQAZRALIcbK=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Irc5QAmWv2MbIYKElpWH8cWmHBXy3En0isaOYAr+o4VAGNStaUDbYiEnrRpryquo4CyzvE0OWvNYgkyjc7AgoI+ZSVYp0kmpH2Rv3R/MuFD1n2AvhW0NEZOEQfe8M1KDc3kiN2WcjFx3t4au+z2jwBJO/jNoOm6+1ptaUNs8geDFvIG5z0tiPwfbru+v25xsetMWpnIwBULiz7qvfTGAq9ye/wUhVUV5EBHBCOU6d26bnR0hm1uJH3qo/loxxUdGzwXJCgxhOeFrEfxqrn/pnuZmjSL8aEnFvsgrFM4jZZEiOKSxPbJixw3Jqa8hqM5Utdx9E60dvDqqK44xAXPxSQ==
X-YMail-OSG: DnWr.awVM1knRbJ4yXrv237YmVQvndtwlaQBaAERlwsDZHILgn9SZvIA6jkJgm6
 iVZfdbprCSId7_LlleTsz3HaIPmHUv1OhDiPunyweaJ0KIQ8bXbuPK.OTG3IgdrdMW3V0M347j9n
 o8.9uooh7lFqt0dLu8x2yfpTlxxP5MV23QbBCfdHhZBKZi5mM6WtSpiLVFSyl7B0.D6bt9QkSTye
 lD3FPMjVTjrLi22Ac8aLQYQomyWMWTWOFbybqpxLqncAi9BQMnHGmJ8K5O.HgV0156H_dPqEfoDL
 OSijCW.EVwldP5tdkwrB__mHo47P..jyFtxFaVLCTGHF8RAt96SxQAjd5U5zMS0CxSMEbS82Z0fY
 PI.v6CdORoGOBbKxyUFzaZM87ZfuumzYJKpWdxHwKPHBlSq0HRUAFLM0lHHbWD315IjheRCY2eCo
 AQjya93PZ7Qg_57GmV88_0DBDdj8iztwYctlDtRPruPErR_RCai.K1xtpGXW47DtWOETIbNR5IEP
 9XNkz6luStPgc5ay4IFsR02MtszLSLsk6dsB0_muqROALr.oxWlSTmH9lKU_pWnRF8Ht8yRj5tGJ
 4SjgSqMkwf84BrOXgjQJN5sU0WwYF6mHgV6UQYSY1WLYx0XvFF5Vf3V99nf8QtRAERiqX46.6VWU
 92dAHZ70mX1htDElIkJpX5vfPio6KK.U3ddkByQafC1W8qTpj0jJ4FtWcKdqlu9yRFDdoNTZFzel
 reXdHAxtOS47C9zRJ3or7sBH8m.UYhL_XhFVh98LRYhA1WUYiP6m0yVBH5372qQDnQHz0huyXIUs
 FT343J1DX2trnPS90NH._o.FCgGrfHil9KHTTWZjxvgHD0eE6lF5rIh9qH1XxGCDNEe2rDXTaiby
 ZWAR28RdDHnTvk9okUVWpSrSlfj3cxQmfmUlWL3kixM.1cKEAB2avceSc1w2yFBh7zaEeW7THx1o
 R8vfCUFaPBZGMJh5dBcAplhdcSL9jKclgAqrIoF6ExPI9AhWbxzG1YxwRq5kro7b4dj7oK8osygF
 M3Wy57_SEzV0Vp5Wucbox9r7AiGf9LENmAPFFeG7Cj_47OdXpytPwfddCCExpxGJtVNtBbAbGqu7
 Hq6Ejh87PB0ahvrCyeosgTG1AUbwc3kvUYMvzMh3kDX0LsugRLy9.hdAWEyw7lNrczoGcmiqYdqN
 ekMYgJSVGbiarq_PkH1tZC1UWsRxzXuZSntFGHwfTlmHzzvuuSB7T3kF3Au_lnPBhJqPJ5zeM3Ke
 nV1BTaPlpH566NnaoJ0skY4bssFbBrMTCzcpu2fYa2NrxQi_M3EfqOUC88Ich._MT2mPSm612HX5
 5Vpa3PAm0wGINRkW1bIzlKbzdRF8fP37BABUcVe50l3CRO07TMIpEGbe1n2uGBbINMQ47AIw2zHL
 XGqlKc1ehUayR8gJ09OdKFQogXqOi8qx2.Lf5uBKSNKNjsY52TQt17oRAz7SAWxLU6H2N5ZMrhkq
 I6uXggvn9yOYq.Y1RBX3CneKQFkyZKBHDxeT7YG8V.FppxNEeNPw4Z5yxvrH4rturBkFFFrL8I_l
 Hvu.eGXc.VnUdesdtDD6u25jjZ2giq0Dsc7iVnzV7HqnxAOWDAmhJGahVDysGYVrugOAz6JSmWwK
 2qNRs5PU_Xxn7lhr9ALrPxbXDgQl_3j0FAzjRyhiSWsQMxTVL2Z5bgg3z1fNEipj43o3IvzbYX9Z
 yWQ06lZFMVx44CNNgrQTrFf6pXh78lo0.xeTwAe0m4S0Qw3YPmLqtBc7Jf7P00HTbplORbvccZ_Y
 2pPlL2VML2xgZf.MQ0Ci2ISuHm0XYIjXq7s_ZMSZVEkD25t2WZwMov4qkFMpCvLzO9cWnFw5GH8w
 X3xBqzG6czI1efLqwBFZMEH51B_RWRK8W0VnIjW2KMmRs1D.dpdpJIPnFgd6rCqLBLFOEOMT3ZQp
 BxGv8XaV3QmgeRZYwzoQGrgL9nNzpVE6RUo9cwNqeaE64kLleUD_x1Gyo5vAStvAEY1He_SMS6Z1
 oLx4F727XdfszaDYh6gYwYpqsK2OsmXOEFbJUJO71ePDJA0hVF4YXFlFwNqrYB78ztyMmh2Zk2Ln
 b1r7i19suH2hLgv5Ak6Y2TJ5tzRzq2mNa_usjjnAXpTAt8nwbdoGdWjNOyuviHQfoK36Zuiv7bni
 wUIp1TcCda98.f5pa835g1YCcaV8zZ3y5g5YVG.RdRCJnsnpALqoT82Ophz45swwivyDI.satIbz
 iFCwAy62EBOzKtaG2In8CXwt9Wt5Kgzf79Br0LgS9gtnO_2PHUDsfk4_7DDJaONRgPDwC1gVEimy
 qcXZm4pvNEAUB_AvrS6DN
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 0cce5af3-dcae-4c0a-9bcc-69e0a95c6f8a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Fri, 21 Apr 2023 17:44:43 +0000
Received: by hermes--production-bf1-5f9df5c5c4-8dccp (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d2bcaa4718843a282c96eeaa4751b090;
          Fri, 21 Apr 2023 17:44:42 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v9 03/11] proc: Use lsmids instead of lsm names for attrs
Date:   Fri, 21 Apr 2023 10:42:51 -0700
Message-Id: <20230421174259.2458-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230421174259.2458-1-casey@schaufler-ca.com>
References: <20230421174259.2458-1-casey@schaufler-ca.com>
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

