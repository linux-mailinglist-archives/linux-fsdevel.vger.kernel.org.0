Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C1A69FCC4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Feb 2023 21:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjBVUK3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Feb 2023 15:10:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjBVUK2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Feb 2023 15:10:28 -0500
Received: from sonic314-27.consmr.mail.ne1.yahoo.com (sonic314-27.consmr.mail.ne1.yahoo.com [66.163.189.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB90367F7
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Feb 2023 12:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677096625; bh=B5Ym+ZhpD8jge0qIBetXq+jxFEPE1o7Man05K2zRvxU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=qz6vJGLbS21pwR6VoiTJSQd91DvoKOysKWt2khlPtQxPjI+ppXex+mRvrhkxm4fHlT6crlWLbFQQOBw6PYmKSsdAg6udl3P+APPIv4uaP964efTr42RC9x1EM0PGJq46vuy/h18v3CBgBWhJ06JK/Us3gA3x24Olrd1jftkniIUdNUj2eMPis7juzAuKs0wSBK6PRztbcXQgI6C162M6FAteJ5UMzifPtuWvN6KJwx7XzoEwfnXRnAyImxQscpvV2kBoV3vuA+5Xcpyu2SvhlJEYg8TRr3FcYx9d76c3D+jf67WzRQKQlv9dTwe934bzoPwNiS5MPEN2fd0atTnTBA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677096625; bh=O4iBGhIl3ETBCMncjd0xYZq8gcAMRUe+DGnOFlY6hY8=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=p+x+rTpesRWquOfIyPPWPtqJJsxp+giSfJ84tdBr+OdTTRE8yW5SaI0r4wAZYv5Q4yWknLrMXTpxDucTTgTCBFUEwPA1i5l8dDmdbiW1UHjKhdoR16hYIEfRTfOGYwD4t7++5nBcKUrOC73W6K0pAV7hyURrfm3WfDo5PDC+jS8yomayG17LEjHulvIBs0oB04KgqF5OCN4MXBkhR9s5LQ1bLFPLmhzWd08yuRsGBbP+gCsDMcD8ySHS2DmnqPbUHaXgy6FoNBnWMXhcbAh+gmBfuVw5rSvqvSWzjIHgqfR8nk2KHEh2U0Ph5Qo9yyIrP1QcBnluzoNHJPfv+9GvQA==
X-YMail-OSG: D0ixvOAVM1ktltEt9bSxHoS.4MQl9Nb5ORCxa2BpKjuMTLrSN3APjpe9xfhej1F
 TDKWk1sKzw17KUZjcBTDBqkXd779Hsfz2dxitxo7IfrRuDOUCNp5RlikshBmeAGgEl0Pp28AwSck
 BjyTT9w.hoY.cmplkhNoQm6ppYm4EHh_vYmzhOAmcxn2zGdIN2XxRNe7Nojp3F4BJT9JgyvqbV9y
 c_fXnuLgncatCPDF60COP6tURFrvI3_kVaOjlvi8ae9z3DTAukVqyUugFiujHij1TWgmJTmXjNok
 xQ2ISyCekwSUUpk72TV0IL325rO2jLIQJ0o8O2JJtg9Zfm5StsvMF_W_rtXg3Z3_y5quU50pUQcU
 a7wdR.iPwvZd8wDjqb8T5Js5mPOprb9vIeN_O9aKytmV5y30PMmXNJ7eS3T8iTpDUsQnMiG5kczj
 nzfW83Mfh1jqDGIfrP2iSXuNzBYHbXd69xyXqRyLlvbv0JrED0FPiqzFRIWeuoDf3cVvT5fBctyE
 yTSy3SVYex1cHFN0sd8KHN1ORKCs1jvWOKUfVxf5icp1P4DLjkhfM1It59UPPA8Aq962PT8KnOp6
 iMi.wEvlqQ90xOOjo48IKYfMGIwX88PhgOVt4fWr89NhiWp_0loHlr_4t0_TbVXU88UplQ1Z2ysE
 dr9eG_NIIOj3zTNBvDwwQ7L3cAzi0LCbvvNl_qG7xUJp9q0_kUlBuUbMWZKY0cEM1aK5yNoCDOFu
 tbReegAIpAd2m01wH9JTRpKoOFST7AM._KUWAXCKeqiPD5.0GiLPkCiaSrcHCirxDFKhzaTyU1Db
 yDqqyPn76ElkMq8VLzuIWkY0oPRu.ndcp5_zcpvyHF8XtjILputDpEUVgXixqPAH6tK78FoXtlMQ
 tlrjIsV8E00b1aIi11MMvhJtnmslm96KRmA.c66rQG7O076FyHwlkiXErqQc5EHrcL.o5SW2hocL
 .ooYi9W1cydRS5Fb0Yk2CRTr7AYcqiXe6Q3q9a6tpNiwb0UN4uC1cyacM7.zcEWN5nsKZOqab8ip
 6hxLXsS6nAzj7LjwGjadfYen4ZJZdWBjWaONnCRtlTbAnE8b3cEamt35eVReMtTPir4h.XwSQDfB
 .nBay4pk6nQJKqtcgOjb9eXx1WjslMGz5awO1MSDlW0NIjyfsHZBYjG0RYIcFKgKjui5LeXskhf3
 xU9kuCD0KKHBY3c2QA_R5HvUvtx1D0fi9aiStTS9_nMeZxi8VsL6hHuEYpBiCqva4AbALMcZGS8M
 gBhv4uaVdjxE0PHlQgEQztNU93rWvQWsPPW1RWejBjZh6XiafCWLF31B6JW8kXvyk_LDRjkUywLR
 Gh7Tg0s57q7fgKeS4JH.z_7H6vScormtyGRS_JvXhAREO3TtosgiFjFVGyMQyUqLgubXXYhmVlct
 d5f7jxlen9DS760xc7ppWPNvPzUd7ZLJf2qnTS8clT8Y8qoIq7IlaGJuxux5nKuhHYyvtFKQ8KO9
 PUHZZfL4p..PG_y0ROZj3p1Jdq2qPkOYrgxFGLSRXE1YmmJf0kO6_yBi.drR6eS1bQyHlGj89hyx
 dA3wsYjbptvCPpDWTvzVtGOkaW6dJtu9SqLb4qLStdbS3bhlJC_SCpnOZ_njUhb6xRKHV0gytHGY
 ZFIULOHSA6ZvhimUUvJ49AoTbci9i.vnkU2JaYfa6SG_gkalyRKjttOYqWLyo5ywQMkQCI0aSzPd
 8CS91MM179m0yujeXlCFImnRI7_Cage04voGh545JMosO0pZDDHgAC9u5CY1EALaK6mf9rgmShu_
 8ovGRRQ.K4qldkzmXx3eIfmp0LfQoTAP70cbIAHTBIVDE81JlhF89oYCoq8W56B7BWgfLMZxfz.C
 F5EfNUaIOe.tHqqna5NZpKqGP80qnInIsQDPTEvmGQpF_TvmZu8YGUaTUB5DxOE_FDTstPp4Q8Bi
 iW1PGwISiVIMR7IT2DuHw6n3hWfvAo_W2LMOmGIIw5LvFsWJdDwDEVuhEqdWN6MTa3m20FUJvBhB
 HSE6K09TPFEdL1KYSZyR0KSYjE0L57NK5COK8fWf6TrwFc4_fA1FJ.hdqWxvUdEbuDPnArUQhnWf
 429Mv7IB2xd9.ZHNMP0Uv7lwOt4ELDqsohcg_26Hn5JaE3ynFO30S_lCHImgg8x8PCMLCwmzMBsz
 YVPDC.68NKH9VYfBbbnSUzu4Ib5dlmsDvizOdnEW6JZjWSCrs3W7r2GtZU.z9dBjBZo3amLVsmNX
 jvoMJZggFhweYYp8l7L7WWUyGftOtwb2x95qI6lpBTufBonLkRYWwjRA2nT585NCAXHvUdX0gnJV
 aTzbutcMKAGW5bJYdwYIwRQ--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Wed, 22 Feb 2023 20:10:25 +0000
Received: by hermes--production-ne1-746bc6c6c4-sslbc (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 54abe124e3c28d3626a364ed2359f9f6;
          Wed, 22 Feb 2023 20:10:24 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v6 03/11] proc: Use lsmids instead of lsm names for attrs
Date:   Wed, 22 Feb 2023 12:08:30 -0800
Message-Id: <20230222200838.8149-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230222200838.8149-1-casey@schaufler-ca.com>
References: <20230222200838.8149-1-casey@schaufler-ca.com>
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
index 9e479d7d202b..4c8c886d214f 100644
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
index 4b81734ae9bd..3308d7c8a20b 100644
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
2.39.0

