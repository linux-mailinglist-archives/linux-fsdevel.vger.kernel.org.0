Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D39742DE4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 21:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbjF2T50 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 15:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbjF2T5Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 15:57:25 -0400
Received: from sonic303-28.consmr.mail.ne1.yahoo.com (sonic303-28.consmr.mail.ne1.yahoo.com [66.163.188.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D472D63
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 12:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1688068640; bh=/IXLwjq399ERRdbBU9bkxssM1yB35DCfDaZBrMF7pwg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=XdLqXxHvBtN/WC5TBCPeGeU9RVqEgErf/ma4QXVPyLSorT4cbFnb3Qk2OJ4g7u4+2TfvmO09mHZSY7YLHbsr+DDCkfD2Wgrt29wzQnVH/1f1Rtj7ynniFP66CICaGriOYWjeu550xGnju3ZcMBBLkkLaBmH99fBy5XDB6On8eEheBNDNS7JD2NVRws1Y1WjERaB9i7L1el+RBI6rKF0R6czeHW0Ja8ZYIkwEwznXTypo/FlHojn7/krOdXGRtDL8xuuXc+2ljDz3vJDcsXPMPzivVC5+Mw6CDBGw6VFGn5zGQ1V50q0+Knw7h599gzfz/QrOaAmJ+84X9yxS08YHPQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1688068640; bh=lUhJW2HXqOcpkQvKFZtcRFZgM8iA7o3EiwVAqMivPwk=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=CqIGIdBtiPNlRfm4sP2F6a+UiJPKxlDH8nPxrg8WLc3tt0+WqfGYhZkzN+qoqGlksSvJuUbtZF1b5NaswNIIaZ36i7EZo/3K/izOM3lMvATwfQZWB7TSmwcNyTRr2hB63M6KYTTAcTmsP+HZzA35AyESIhn+4N7gWoajgW7M8viPLI7oD17O+fOzAh8NU0RkML+4SvFXvBMVJriOWXOYdjx7PvB6LyGL4v+YhmackTq/A7jfHIKkj2RhxQHFobKnPaSl841UsSiKKO2Me20kUfA57BWX/gtX7WfHBDQwfvq7Aw2lh7dKQy4rYSp8Ae2Zj/ZOO5FX0gFfHaKloWhjMQ==
X-YMail-OSG: ZYbzpZcVM1nwbtn8IEcDnbEFLD.9xA91wps9QwNSuPFzjh1YOUGNUn7IMU0Fiy_
 1w3WKT9TlICfdLzX7d9jeSOzits0CRxwXVUzyDwHtwy_EI6kQnh0yMhUfyYNcbMFCl46KAZDz6pb
 uUjUDfLFEXCHB9WKfLQX9q4LjavBKUSFfETLIEXplM2UlJ8Krn4KNdr7l498Firk4LV3qTpusYFI
 1IIz0yNJ4eMl8Bp5vy_WSd05yPgLl_8ltkrvD8dPeFf9Iq53At67aAwFEC9HCoLxESomA1lZkR.w
 qv740nySsIu4aq3LAA1sHsVDvEk52TeUA3W.4xznO4nao8qBs2fTN3L_bxy6_wL_UZueJGVIaTUY
 XPMxpKGUBs5HIVnQep148zJ66H91J9SlgyyXVRQJmwJpevW1ifIOcPIGdVARB7maNt5epSz_Mleb
 EnvfMAo57qNxksONrUm1HsNMCBcEf3CbxcZZOI3JyvOvGenbvfBa3zDB84_1_lFr21ux2RojVEDJ
 nWNIhU_JR9yCFe.90dtCjcJO7Ccj.Q5iSrIc5E8Dl2h5NrT0jaEe57l3jOdA66umZaJ3o1O2vICu
 GQ4gAVVxndF6Vd6p1gug.bsxgcTZI.Gfso4sBt4mpqfXBomUYiZwq2s5rheT3FezLmE5nj8zFwtX
 H9LCh_YVmzPBTlol5kz6oVSEJecXx.ypGKsyHgZfsqz2_iJFmxP02YOytyEPuZStC1guTEYWOkn7
 eHIk3DcAzRPWC_7HrneYmrQTECDCmJESG3b8hIj4z2hhKAXAebITq.sA3.SUX5FVkFSqvnN1J_C4
 D8wHtYkOCGljLsuc1CvviriHi80u3gpKfyyezB26PZa52CYex4319i.l6AA3Shs6SSDNF7frNFf2
 4TmAk_ulXlK5ZQxnAhybt6GdJ0kj4saOQJUcaqCXsdUcmkechMXESjNcfUrX_FO1WCCB36xzUoFQ
 6j3gIA.rpZNtuoKp54Mb7izGlYn0AXBux6UaXCwZjIHIaK9VbBWCWD_dOvGd12kO0n4Re3CbzUvO
 EM4wAxXG3FD2bLzH3IUMZNhwKknyBmsGnSD5M51UqX2_USfviuxsyguJLmaZC56PCJjlrYeGocUT
 uoNNpnwcAc68_zN15GKCG8WZHubqlilsaEGNILxSI8PVhXMZHIcf14XyEjIejlzGE1KmAhlpG_Th
 Dj1Ajw9vxxubI9h0GCN1LQvwz0fAtx7kUAbUdwTDYGM1cEmdI8o.NNCX0lIyHTf7nUmlk2Mwirw4
 bCUExIW5m5hC1CkzgeJLkgdSYlMd0GsZTJKeQckri5JvUrAojtjCe3IWw0bCrz58YvHqrnsi9erA
 LqRLHgmKhDkYTUBCeevSzmhNKNC9IePgUa8DF.DvDCbvDHxHtZa_vhG8KSm3mivxO7PQLH2P22r4
 0Mv1f7DEZDz4ASHZufZ4j9orNDzuPK5e7KSdPQr2Cjr8v50xYt.BBNbF4P17icnWb49iYkhjbMsg
 29zA3Uuz1KWYyxjyHlW.NO9oNMhN1aw._ax1l9tnHs55Otn4hfnzwNj70LKYEY2Y_7nNA.1XZavM
 zDv7NIsWlW1qFaUTKUzlyMgBNUkCKK_4ApELnzF1ub1B7dZZDJ3Kbg1aofxSAO3v3rkLX7OuZdLJ
 ufNnHDUsAB2RzkSnJTPWZ3B3ruAeD9x4trYNBtlrr5Wm3kf5x0Tc3lYTcEiBKH5Y5inStS.xucPl
 HDuRBr951bPXkeDA92C3ubPXPAm5ovQEa2ke5SfADBjyXwe8xxljFtzquVhAf2dlzxQgIsbuf4Qa
 O038KmWy6L6w8gjsIGLtkv4hIMCqERRxxIQUsTyzQqBQzIXss5j9KWQUmTAeIvecNPw.1J8BG9C4
 POIO3OURuqfzKTeTWXcGmaWTWb3NZBMqkhFwMwj3g2qTDAXTGV7wyizgaoPJ1ug58icnhIUaJXct
 RGfnKszgEIR8DI5W_Mi3.osDwnjrFB8Eb0wiJCsbq4tcUVXaPOZdl2dyhLc41qzAz7usCSHhy9nP
 W7QPBTXaSWl3t9ZcNWnjvOxTyFmw372_bUkglblmJuaNF1bPRLDJH0nXzk23JDxnQItHDpC1KbHz
 mrJE37Ahvp3KppQZIcYQncbxq6yCHMhn4kGPDpMKU0NW_LHRtj9GT.mulaNrW4uODmug0oHagwqd
 OzcpR5_uFtzWaCYAH6NYdNFtQOpIKc0RkctbseZ2Hse_LKzdsYFEd3ulGlbKez9HqaZmpL.rOFSG
 oHnvEK2s4KPIKVVY66744t5ydyPVLw8YR5i0hudkA08EF99se9f03F1.4UzRnV_4i8S5irtCx4ZP
 JpVtBuVcLsQk5lfcGC9o-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 0ca98f84-4f47-46c3-bb52-b1a3fdfdeb79
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Thu, 29 Jun 2023 19:57:20 +0000
Received: by hermes--production-ne1-6d679867d5-xspjz (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2b963465d429516eabd169bf0e2fe051;
          Thu, 29 Jun 2023 19:57:14 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v12 03/11] proc: Use lsmids instead of lsm names for attrs
Date:   Thu, 29 Jun 2023 12:55:27 -0700
Message-Id: <20230629195535.2590-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230629195535.2590-1-casey@schaufler-ca.com>
References: <20230629195535.2590-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
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
index 5a699e47478b..d942b0c8e32f 100644
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
2.40.1

