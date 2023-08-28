Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61D178B8E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 22:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbjH1UAt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 16:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233663AbjH1UAZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 16:00:25 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9510E65
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Aug 2023 12:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693252791; bh=9bBL0SSvraIoWhKG8mEdrfeN0p2i0Zm9X3YxMUEQ2nk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=MhHIQF6cMVaR6iiopY+w2mZFdDdKXpVbdVsY84TGAoME3VMtN0j1gBJybmzugo49W4oTAZuX4dx6K9/HQEUzGGVtThwhIhK++LbGEF9DosD8nmKlUR6FIeqzfAEASIAvbi2kQqMn+R+6XFShHRgWaIiSZMA7Q2kWfWquO0Tg4D/FynCdkMfw+yQVxX1LJ557o20oBfVj1xh7zeZRx7cR07MWgI+OG31BG/w+6ff6vDE8oqvrLmIzda9RG/G4ssyBgEnkZ4HAiSpAc9p23WH1Xeg3S1kEXVaAEh4wMMzm0tR4Kc3/zvz30aes9/9QDjTs0Fv4CxmPp7sYB95/GqVrAQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693252791; bh=gX6R6UuwC4i1QptNc0KJH3TdTyV3S3OnIlNhPSdwzuH=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=lExvP2mO4qplACA5dsEJhNTO7W5szP88CKvxurOl+B+gGbUabwDcPOxAfZn30ASz9TVnwEIcZ54Bl9hBZJJGGxKZyg6uhXAMSrfxo6EKQpQeztSzFxzFlACnShBUc3leh5Hnv/yRlfrF0wQ8ixDCATcyRsHA/8oyTOR77xm9sKOZbCrvvLVE1DwdWK9p53yIhTpQhRTZNTsUcb3XzKb2rEZGAkH62hbxya8BHSeHr+uCJnMk8lJh34Pd7V2WCJJn+519EYz/mxC/JD8L4orriYlsZdKfMKzT7B35gkV3CTqmQE27n2nd2jLgAl9N9IRAcEYW2qSilLPpWmb3B+cfbQ==
X-YMail-OSG: TKxkARUVM1nInNlgVK_9rC.EzQljUBgdwdmtF7pSr2ctgZbizL55fQciV36wUlV
 aICPrl411MotTy9daF_r.fktA.M8WPaU5sgubry4CHOmvopan3MxCJ3rZg9gLm1QZD_lA87T9daD
 C32u8FOlaOOe717.Xb08ZpLm8JZCRUlSQM1ZmwmgGdvNnkXRmaWQwj8LMQky5Ck57g_4ZG4KRWfX
 szK3gWLb98GLhSAz6dvZpxC2vsVuiqm5r_NEuYCkEAef.QXji11DfU2h6guHmG_gd8kI5CCMX4NN
 8P0PGxjnedrSFQQIL9bgfruEaJHFUwL4ct3zGTUqjUshmmuBPkIk7WMdwKNh2rwC0svrIMJhNO4m
 35Q4N11OF0x_hG7Og_gr49cG0dXAgL9eleXO9B98Zib03LMI5IIguz8QkNH03jjTuAoUDBW2pa8w
 v4bcERIdTwb5dVz_QyXChUgISnYNW2svLZlD.xZrFTIXqA3GHLXY2.HfUkw496FhHxOBFDnb_272
 LPlZxlib7YEOPF6a9Rwzq7jHAtW3_mGV2bRdtzdrGwzBD93jdBp2xh_kkCfTOGqq4QCu4LRbha7g
 X2rYrLRSq2tD2pX66VSC82vHNbwX4snDLA.DcDWWgfrB6UmS8IEK9p8g7VaUtSfU21RTnoBazixX
 3mkKbZd7ep0e1hUW1Ul8mH0qG2nHeRxOrmqvPKI9.s5BZjxLxf1AJY2zsEiMKDguKpJAi.j_2ZVf
 QaRus1N1w6w_Ds8Ve5EV9q8oUJ_Jra3ksFVVxbD_w8kYk3yAnGF.kixk8qygxjicMJlE.dLJ82cT
 q0ZKkZbWG.cMu4RZ18fCSfiE09yZErdUYz0G3Jl1mXWn_QvRhGaCK705iqms2hNEOp3HYR70WiS1
 0tX2xRHu.AIWSbu8is.nDz1cTWOco37jKJJV0FBT7d6CYGNb4VMd7awnENSakcVEOyWNzrabN.zc
 t3k_h5HHRxWSVZiX7IawEXQDO2tNjJprspFfanxMIRnDu5VRIhM3nARY6ZF201iWOqMX7dqj.xTs
 hW7b37Wu2NTt3KjLT4CqjqO2vktAS9PvqjHo3Th0TBVesbkt5A7Vog7iQFATZHD3QARxR5AoFOe1
 CV8dRwqey6z1b.EESzDki7Cro3JxIV9Sn4JSDw._P_7XZpPPZjJjGgGkiqwM8PH4Yvl.kCDHCSlq
 dR2Tvcau35VAhjjm_68mUo9Htnf96KC_WlUyO0OS3kaKGvm2iynge6WSUhh1uVmTzgTKxNUHdFAF
 sPQWOzV0YyelmrEGwa56eLSnC5obRYtVYFK_Niiay3mV4yDL6xJZdJdf.GJji0pyvedkmxYn5wXl
 GrU.pKA_52sXmJJFuSp3IEcSZFJp2Z36TYJ5nhxvNhcstmSPmLw3ueEEPn.98UkqC4xVdshPpa5f
 fF6jgkoeef8HiiFoKlNq0kWjZ2S4zmo.QllPQMvoJ.KSZMZ2_jG5oppduRpem0kP84lxkJI8SZCm
 4IbXPbKRVr7nGc.LJ.ddJya5ukqMxuX5S4nKbldX0IZeCWQyMAyTxfaCZGegpITMfSvMJvDKyBEO
 C7w8xd8_qDbRqqogsXPlP7KrUwWUaqV_XTkSlFKLhwIOVBFUyNrmnkY2RlDU0zCDVa3Qm7E2WW4X
 TCW.KQfL.GQrT1aikb7lFKM_yNgKoVW6lxWiTOYE8pV7pFuC56985dO5zLKsvuy0bIPjCNBqLuKh
 uw3XH2fGWPX3ZNDh2KuPFcGn5piBaCbsPb6AuKrB5lY0Tudvt.WIuF5wBANuB2rBAaL2Z9uShoDt
 DJhglog4MJj77gayXl.L91O5wg5uORU5qfWL1liaEtx7X6MQd97rOSzBb0dzKHy0EJSB7LuLQu1U
 OfFuqsn_Al_bQ9Ix9fRmpiPj.ddIDn8yNH2KLkQLKaygKtclmyXWAn6izwfyn2o763Ab54qT43DJ
 qss6TxI48X4tR5VBNL04B98iIGG45als.0MmOH9R4_SVrj3nnWrfd1ygP1Wp94Sgcx82RUJ0g92Y
 T3gdyJJ8bNFt01FROa53foK2nswWV4IbZlkNeFM8DbweNFOGxNDOwebnnQr2wGICLjKv_e9tSrs6
 tbLBlp6QVTCBnkv9WtVG0xwl66jEMbusGafT71cm3Oh6lurZ.FAxEC5aoxm2suzgv8G3LvtYBT4G
 .4FZie9lzTkMg6s0YpFaBA4W6zLakAjl7SG8RSdsUD4fyjzd4UPU2.PqRYWQl3iNM7GUjzaRRKZe
 50DGOiSzZc_CX5fflIzj2wFnZ1qLH8pNRiUAsgLQADw9.suotnisrumsjQWJCF8e_z2deF6KR1As
 mLgvfX4W_Sa1fwVnj7K4-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: c3928164-679d-4496-a295-5bbe78276782
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Mon, 28 Aug 2023 19:59:51 +0000
Received: by hermes--production-bf1-865889d799-x5klk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4fa193a662e8d287c56340453369fa5e;
          Mon, 28 Aug 2023 19:59:45 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 03/11] proc: Use lsmids instead of lsm names for attrs
Date:   Mon, 28 Aug 2023 12:57:53 -0700
Message-ID: <20230828195802.135055-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828195802.135055-1-casey@schaufler-ca.com>
References: <20230828195802.135055-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
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
index 9df3f4839662..42a02375fb5f 100644
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
index 3c0342410531..82253294069c 100644
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

