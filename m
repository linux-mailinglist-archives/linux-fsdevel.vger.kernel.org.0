Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB3225EEA9
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Sep 2020 17:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbgIFPhd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Sep 2020 11:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728692AbgIFPhT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Sep 2020 11:37:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10D8C061574;
        Sun,  6 Sep 2020 08:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Resent-To:Resent-Message-ID:Resent-Date:
        Resent-From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        In-Reply-To:References; bh=y0Rh3YlzbBctzi3WdY354Yyw3/889TYkzB9+yv3Ev/o=; b=BQ
        UMz09oAKHzRf2ZQKQmUfOckMBzZljf3nqEK2bmQNYYpt44che0Sa2kSPl74agb5dmfyaKzrjHHs29
        gAKmfFNe+g5uEYSCFmKSSsW7CWxKVi9wTInjerEiCvDpog3GqQz4joZ4USrB1kpuPWhHQvc9lD6ZJ
        5BW7bwxLhr1fmuWE0nuIR6sGNEnQPkJxjLKgFJIoWC1f5p3APwblFKAPt9hmqxU0qV0QlIrXahzro
        55xLB7I2rTC6oihUu4q+DwwuaQRONi8oTYM2vIgoT2DbVCThT8ywDLPwNs8i4BP/9xSvLR/1cRWmd
        iIlEQJggt4L6UIJvKgAnSf5VnCw7imSg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kEwiw-0000yl-PX; Sun, 06 Sep 2020 15:36:58 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
        by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kEwUv-000062-4a
        for willy@casper.infradead.org; Sun, 06 Sep 2020 15:22:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=y0Rh3YlzbBctzi3WdY354Yyw3/889TYkzB9+yv3Ev/o=; b=mF06nnFRpEvbNsoS33IxMOhS5N
        NumwzTBkXiHPlGwKIzlOt9IFGtqr6Zk4wt5yOHlHO1NYKAbitPcO3BDp1RuQUhThgI6UvPWC4gnDG
        muFVQtCcbet9s2PUAAFozGiQgFJe3CaWyOADkC6SbIZh2MBqiHNtsPwzPuAcpspT+YnMXzPlI1QzV
        RAwLE+BDaBVycn4Nwp75Q8I7flsPmi+WgLYFLsgYqGR7QhcOwHmBARwrpBeE5U67F6QZVGglwlf1q
        uq5soyYfPdT01WLIuEmEMnopvlPWZfcTRfCR1YUNPk21EOyJ93nzOEKKN1Hctg+khupgG2uu4U8ty
        3U69Cbsg==;
Received: from mout.gmx.net ([212.227.15.19])
        by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kEwUt-00053R-4Z
        for willy@infradead.org; Sun, 06 Sep 2020 15:22:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599405745;
        bh=x4JGcFUaDkLWdBvPJjm2HPbCsVaucqP6yPxA5Yn9DWQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=elLH0mlOC5O6Az/FhmihqDhK5WzGQ2sxkNq02uTy4hNQmwkokjFB1b4uRz9vI8Xse
         EqoqIeSibAk0CLNVVhKSpM9WFwtrZLlKuSY1y8Tqq41CPJRW4vyVoRHqSsrRcjLKUJ
         qDFapOCCBz8AIaUuxADEjMLtM5QT8T8LSz5nD4HM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([79.150.73.70]) by mail.gmx.com
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1McH5a-1kp5bB1Rbo-00chcC; Sun, 06 Sep 2020 17:22:25 +0200
From:   John Wood <john.wood@gmx.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     John Wood <john.wood@gmx.com>
Subject: [RFC PATCH 2/9] security/fbfam: Add the api to manage statistics
Date:   Sun,  6 Sep 2020 17:22:05 +0200
Message-Id: <20200906152205.7095-1-john.wood@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CWgT2GRMCZRhinh/463FDuev+ft7FYh9kFYG3p5FLUJwRGuQ+Ns
 L+A5OPhlSFdwKcQJ1gDkDQq0Da8UEYYut6B7n0oDhnIJLdOinJkumdzzWy1za8oD1ypnb6w
 7awtDim47JRB2JosEvZDvtznRYzxIu2Rbop4L+fXYkl086d77m79vHdKiz7cXCFa7ZAzTwR
 o8dnLfn7wqvf6N4vL6Ymw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6NGKTE8pME0=:lj/Zrv78yyGg1YOm8OqeJN
 sqn/+TPw2fgsZ6RowyZws60WmMyhUExWI6HBF+LSwgc8t831Qun1I3mEJVBr5RMxs02GDliCp
 uG/h+KCTukNLRmIcZ5zuJf8yCtL4ilRablnavsoO17s4jaDTG/ofslgzlFco6kXJlu5WEB71T
 63zaCh5dqMXvIvOLYkzd0EVqw+FH6FxiqainSlkb74lsSoWUNE/M/ynHSK7BFKjk9FwMRxXjT
 SLqwb7S2yw16DKqYKmyv5fsCMgUgJPFH5aYa/2+2+8uQK/WG33X3Y/lcIUfRc8WF5lPIYJ1aV
 b8kClwvbyMYUm5RyelqzOrZh6AvWuob8AZy+n6fcJtJaqgtmoQf0RfaH7l6cNvZ7TtVrH8vOz
 TdfnttYHUu0s2agVudq9wPjBSl0vKVbkNgJ6NaD7HD+PYCXh8SPmzM5Fhl0WGaeE7ZOu8f5dp
 83JDMFsy42NeE4UhtJl7X0EbL7Ck7BSH9OXPScjJRgbhtU5Xd2l/2M2lwzxfqD+6sH1piCDOV
 D/8n5T+/kZBw+qWbi7LKcZEaxlSwhxAO3rkFpykGq6h5fWqTUtERqgShI6mgyca+QsIkUrQEd
 pTz/GFGS73sYK45B/MZSZ/nYqP6CKJz+F05+l0WN0pAUuXt3lSLiqknRdhK9IB+bGODXiLiAi
 cH3fXYMyVrGHqF+Fy1Q+mT+qcqzeBbTzj/sj5VuavVpEc2hdbn1+Uggw8g/Jtiq6NlvSZeOYm
 h4dNzd5y4gYzI8jqJvUVQ6ViXe9bKmnFSN91M8k3l2nnE20HZwJZ+U9939DzrnnGUJCAErZ8Y
 mpy5b7PVWDT/43woEvnwkUUEgT3igrio1dJXW1Mf6RWkOzOwzfIqd8p/3EKxl14HA0YWQlmcb
 IOdgl0NU53PRkuzkGASKLRLFExK9orX4aVc6NHNuzM5XXZXEIAOhCsiJGQX9dtInlt6oXYt3Q
 ZPvmVLmidh2FAsoj2M67KWPYYGwbrX48R7DyG22h13ovUFFtayb/CPvZ5HBAtE9ffz0ybNxuP
 epS3rKt0crOQkD+EKIuiXanu9kBV/AqtbLTBl4pwS599wd24g3qpMQQBVdUaz3dYJVQA10DWN
 sbbV2yTU6DEM1+YxLgpTm2okGEo6B5wYPmu0YU8+VXsjI973iEwJXlL3mJJWcquJiVJudDnBo
 s2cTyUZW5W8v+WQlZeJ+SgnajaNB4ZKK5m+rMJnp6PxSabIcAPsLESuAxKM1iYVkWWDRzNyr4
 vns93VnN8C7wsIF/SbAvB5NAZPXhoSrnfghiGCA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200906_112227_418338_B1339D84 
X-CRM114-Status: GOOD (  29.52  )
X-Spam-Score: -0.7 (/)
X-Spam-Report: SpamAssassin version 3.4.4 on merlin.infradead.org summary:
 Content analysis details:   (-0.7 points)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
  0.0 FREEMAIL_FROM          Sender email is commonly abused enduser mail
                             provider
                             [john.wood[at]gmx.com]
  0.0 SPF_HELO_NONE          SPF: HELO does not publish an SPF Record
 -0.0 SPF_PASS               SPF: sender matches SPF record
 -0.0 RCVD_IN_MSPIKE_H2      RBL: Average reputation (+2)
                             [212.227.15.19 listed in wl.mailspike.net]
 -0.7 RCVD_IN_DNSWL_LOW      RBL: Sender listed at https://www.dnswl.org/,
                             low trust
                             [212.227.15.19 listed in list.dnswl.org]
  0.1 DKIM_SIGNED            Message has a DKIM or DK signature, not necessarily
                             valid
 -0.1 DKIM_VALID             Message has at least one valid DKIM or DK signature
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Create a statistical data structure to hold all the necessary
information involve in a fork brute force attack. This info is a
timestamp for the first fork or execve and the number of crashes since
then. Moreover, due to this statitistical data will be shared between
different tasks, a reference counter it is necessary.

For a correct management of an attack it is also necessary that all the
tasks hold statistical data. The same statistical data needs to be
shared between all the tasks that hold the same memory contents or in
other words, between all the tasks that have been forked without any
execve call.

When a forked task calls the execve system call, the memory contents are
set with new values. So, in this scenario the parent's statistical data
no need to be share. Instead, a new statistical data structure must be
allocated to start a new cycle.

The statistical data that every task holds needs to be clear when a task
exits. Due to this data is shared across multiples tasks, the reference
counter is useful to free the previous allocated data only when there
are not other pointers to the same data. Or in other words, when the
reference counter reaches zero.

So, based in all the previous information add the api to manage all the
commented cases.

Also, add to the struct task_struct a new field to point to the
statitistical data related to an attack. This way, all the tasks will
have access to this information.

Signed-off-by: John Wood <john.wood@gmx.com>
=2D--
 include/fbfam/fbfam.h   |  18 +++++
 include/linux/sched.h   |   4 +
 security/Makefile       |   4 +
 security/fbfam/Makefile |   2 +
 security/fbfam/fbfam.c  | 163 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 191 insertions(+)
 create mode 100644 include/fbfam/fbfam.h
 create mode 100644 security/fbfam/Makefile
 create mode 100644 security/fbfam/fbfam.c

diff --git a/include/fbfam/fbfam.h b/include/fbfam/fbfam.h
new file mode 100644
index 000000000000..b5b7d1127a52
=2D-- /dev/null
+++ b/include/fbfam/fbfam.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _FBFAM_H_
+#define _FBFAM_H_
+
+#include <linux/sched.h>
+
+#ifdef CONFIG_FBFAM
+int fbfam_fork(struct task_struct *child);
+int fbfam_execve(void);
+int fbfam_exit(void);
+#else
+static inline int fbfam_fork(struct task_struct *child) { return 0; }
+static inline int fbfam_execve(void) { return 0; }
+static inline int fbfam_exit(void) { return 0; }
+#endif
+
+#endif /* _FBFAM_H_ */
+
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 93ecd930efd3..f3f0cc169204 100644
=2D-- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1315,6 +1315,10 @@ struct task_struct {
 	struct callback_head		mce_kill_me;
 #endif

+#ifdef CONFIG_FBFAM
+	struct fbfam_stats		*fbfam_stats;
+#endif
+
 	/*
 	 * New fields for task_struct should be added above here, so that
 	 * they are included in the randomized portion of task_struct.
diff --git a/security/Makefile b/security/Makefile
index 3baf435de541..36dc4b536349 100644
=2D-- a/security/Makefile
+++ b/security/Makefile
@@ -36,3 +36,7 @@ obj-$(CONFIG_BPF_LSM)			+=3D bpf/
 # Object integrity file lists
 subdir-$(CONFIG_INTEGRITY)		+=3D integrity
 obj-$(CONFIG_INTEGRITY)			+=3D integrity/
+
+# Object fbfam file lists
+subdir-$(CONFIG_FBFAM)			+=3D fbfam
+obj-$(CONFIG_FBFAM)			+=3D fbfam/
diff --git a/security/fbfam/Makefile b/security/fbfam/Makefile
new file mode 100644
index 000000000000..f4b9f0b19c44
=2D-- /dev/null
+++ b/security/fbfam/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_FBFAM) +=3D fbfam.o
diff --git a/security/fbfam/fbfam.c b/security/fbfam/fbfam.c
new file mode 100644
index 000000000000..0387f95f6408
=2D-- /dev/null
+++ b/security/fbfam/fbfam.c
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <asm/current.h>
+#include <fbfam/fbfam.h>
+#include <linux/errno.h>
+#include <linux/gfp.h>
+#include <linux/jiffies.h>
+#include <linux/refcount.h>
+#include <linux/slab.h>
+
+/**
+ * struct fbfam_stats - Fork brute force attack mitigation statistics.
+ * @refc: Reference counter.
+ * @faults: Number of crashes since jiffies.
+ * @jiffies: First fork or execve timestamp.
+ *
+ * The purpose of this structure is to manage all the necessary informati=
on to
+ * compute the crashing rate of an application. So, it holds a first fork=
 or
+ * execve timestamp and a number of crashes since then. This way the cras=
hing
+ * rate in milliseconds per fault can be compute when necessary with the
+ * following formula:
+ *
+ * u64 delta_jiffies =3D get_jiffies_64() - fbfam_stats::jiffies;
+ * u64 delta_time =3D jiffies64_to_msecs(delta_jiffies);
+ * u64 crashing_rate =3D delta_time / (u64)fbfam_stats::faults;
+ *
+ * If the fbfam_stats::faults is zero, the above formula can't be used. I=
n this
+ * case, the crashing rate is zero.
+ *
+ * Moreover, since the same allocated structure will be used in every for=
k
+ * since the first one or execve, it's also necessary a reference counter=
.
+ */
+struct fbfam_stats {
+	refcount_t refc;
+	unsigned int faults;
+	u64 jiffies;
+};
+
+/**
+ * fbfam_new_stats() - Allocation of new statistics structure.
+ *
+ * If the allocation is successful the reference counter is set to one to
+ * indicate that there will be one task that points to this structure. Th=
e
+ * faults field is initialize to zero and the timestamp for this moment i=
s set.
+ *
+ * Return: NULL if the allocation fails. A pointer to the new allocated
+ *         statistics structure if it success.
+ */
+static struct fbfam_stats *fbfam_new_stats(void)
+{
+	struct fbfam_stats *stats =3D kmalloc(sizeof(struct fbfam_stats),
+					    GFP_KERNEL);
+
+	if (stats) {
+		refcount_set(&stats->refc, 1);
+		stats->faults =3D 0;
+		stats->jiffies =3D get_jiffies_64();
+	}
+
+	return stats;
+}
+
+/*
+ * fbfam_fork() - Fork management.
+ * @child: Pointer to the child task that will be created with the fork s=
ystem
+ *         call.
+ *
+ * For a correct management of a fork brute force attack it is necessary =
that
+ * all the tasks hold statistical data. The same statistical data needs t=
o be
+ * shared between all the tasks that hold the same memory contents or in =
other
+ * words, between all the tasks that have been forked without any execve =
call.
+ *
+ * To ensure this, if the current task doesn't have statistical data when=
 forks
+ * (only possible in the first fork of the zero task), it is mandatory to
+ * allocate a new one. This way, the child task always will share the sta=
tistics
+ * with its parent.
+ *
+ * Return: -ENOMEN if the allocation of the new statistics structure fail=
s.
+ *         Zero otherwise.
+ */
+int fbfam_fork(struct task_struct *child)
+{
+	struct fbfam_stats **stats =3D &current->fbfam_stats;
+
+	if (!*stats) {
+		*stats =3D fbfam_new_stats();
+		if (!*stats)
+			return -ENOMEM;
+	}
+
+	refcount_inc(&(*stats)->refc);
+	child->fbfam_stats =3D *stats;
+	return 0;
+}
+
+/**
+ * fbfam_execve() - Execve management.
+ *
+ * When a forked task calls the execve system call, the memory contents a=
re set
+ * with new values. So, in this scenario the parent's statistical data no=
 need
+ * to be share. Instead, a new statistical data structure must be allocat=
ed to
+ * start a new cycle. This condition is detected when the statistics refe=
rence
+ * counter holds a value greater than or equal to two (a fork always sets=
 the
+ * statistics reference counter to two since the parent and the child tas=
k are
+ * sharing the same data).
+ *
+ * However, if the execve function is called immediately after another ex=
ecve
+ * call, althought the memory contents are reset, there is no need to all=
ocate
+ * a new statistical data structure. This is possible because at this mom=
ent
+ * only one task (the task that calls the execve function) points to the =
data.
+ * In this case, the previous allocation is used and only the faults and =
time
+ * fields are reset.
+ *
+ * Return: -ENOMEN if the allocation of the new statistics structure fail=
s.
+ *         -EFAULT if the current task doesn't have statistical data. Zer=
o
+ *         otherwise.
+ */
+int fbfam_execve(void)
+{
+	struct fbfam_stats **stats =3D &current->fbfam_stats;
+
+	if (!*stats)
+		return -EFAULT;
+
+	if (!refcount_dec_not_one(&(*stats)->refc)) {
+		/* execve call after an execve call */
+		(*stats)->faults =3D 0;
+		(*stats)->jiffies =3D get_jiffies_64();
+		return 0;
+	}
+
+	/* execve call after a fork call */
+	*stats =3D fbfam_new_stats();
+	if (!*stats)
+		return -ENOMEM;
+
+	return 0;
+}
+
+/**
+ * fbfam_exit() - Exit management.
+ *
+ * The statistical data that every task holds needs to be clear when a ta=
sk
+ * exits. Due to this data is shared across multiples tasks, the referenc=
e
+ * counter is useful to free the previous allocated data only when there =
are
+ * not other pointers to the same data. Or in other words, when the refer=
ence
+ * counter reaches zero.
+ *
+ * Return: -EFAULT if the current task doesn't have statistical data. Zer=
o
+ *         otherwise.
+ */
+int fbfam_exit(void)
+{
+	struct fbfam_stats *stats =3D current->fbfam_stats;
+
+	if (!stats)
+		return -EFAULT;
+
+	if (refcount_dec_and_test(&stats->refc))
+		kfree(stats);
+
+	return 0;
+}
+
=2D-
2.25.1

