Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7934473487
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2019 19:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfGXRCy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jul 2019 13:02:54 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35743 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfGXRCy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jul 2019 13:02:54 -0400
Received: by mail-wr1-f67.google.com with SMTP id y4so47796677wrm.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jul 2019 10:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xa1NsVFGv/xJPIO0X4IJ6zOPEp6fe9IF2hXjxaPByDM=;
        b=ZnA7QKjx1Nj94L2MD0v8H1r0upuLZ8ncB4dDrGl2s54FmPYqfaJuMqGvPFLXWReTPZ
         QsIzwrD+Abhwfcs7l/3HNd/Y8f99RjG8P2Xn94oyaMlpB9js/JuYbGZUH9SBCBFJT+JT
         bibTCCVhewcCAil7qzMnNTa1+8Ia36mf6iQZRHLi5LsgQZWInNnGtkwrlEYkqasVOwRL
         Obd7qSjNGWGIX9KEXoMblzrQzgH3Sb+853Py8oDgOSxpZ4sinDQKY8wr5IvkYyXs35jm
         p+hlslRCCBHgQ/cD2cPnfigm2dDnj6l6rRdvxlIl6O4JmWaCToe4JCtIBGh9ZhZfwjjJ
         7OSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xa1NsVFGv/xJPIO0X4IJ6zOPEp6fe9IF2hXjxaPByDM=;
        b=K16jN/W1gVXQ270+uF3LeNGCay1AUMUDgmtGwUGM4RQgKtgDbq6t5WZ/bdrS6M4RkL
         TfaY1MSa1fOrLzLaPeCg1/o6QJLS7RjFivgH9OW9rnfEnpBmm/oSl4hdbAdYZHSPaHLY
         085nnDxcVg6mCSnoQncTsaPGocou0kIFlOpgIuAno5nYVhOdFApkOHVOdC/9Uv+S9N3H
         xKQfDG/+WrE8JYn7pFOsin9EPnlmmZbnTWr2qzFj0tfpC8jqPIzS2huq7hs3P3JleDqQ
         dAfPfoD+u5ylP2wtV/h4uXNEkDt4X+AWkUB7OtWry8/oW//SPu88zPAGOZe6TWMemSqq
         zyJw==
X-Gm-Message-State: APjAAAXsKPOfkNYiAyhCTijjAL7/CI8b1wpFJpWGZCt+MnEoaj23Fplu
        vF1fMEj1drGvGaSif4yV6MjHGlKZTF6PonRReo6PC4zhuS1eUGWgYKOosDSUvd4nKBRXewVjWgD
        RK86aEtv37xFosPNjjB6NeN82zJO1508Ht//uIrTaZP3GuZtQ4m2CO2GKIhzYpLBgAIeUbaRnQG
        /CuZV4ezYRHT5r3wLeYe7Z9NONcMxp5YrXnK8s
X-Google-Smtp-Source: APXvYqw6eRkGSuqhH3NK7HbDeM6wI4vyBoZ3jV624hq6Ly6BW+HRAwJR9DzcwAM2arpbBEyuqf5RYg==
X-Received: by 2002:adf:fe09:: with SMTP id n9mr93333801wrr.41.1563987771295;
        Wed, 24 Jul 2019 10:02:51 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j10sm80605867wrd.26.2019.07.24.10.02.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 10:02:50 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] hung_task: Allow printing warnings every check interval
Date:   Wed, 24 Jul 2019 18:02:49 +0100
Message-Id: <20190724170249.9644-1-dima@arista.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CLOUD-SEC-AV-Info: arista,google_mail,monitor
X-CLOUD-SEC-AV-Sent: true
X-Gm-Spam: 0
X-Gm-Phishy: 0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hung task detector has one timeout and has two associated actions on it:
- issuing warnings with names and stacks of blocked tasks
- panic()

We want switches to panic (and reboot) if there's a task
in uninterruptible sleep for some minutes - at that moment something
ugly has happened and the box needs a reboot.
But we also want to detect conditions that are "out of range"
or approaching the point of failure. Under such conditions we want
to issue an "early warning" of an impending failure, minutes before
the switch is going to panic.

Those "early warnings" serve a purpose while monitoring the network
infrastructure. Those are also valuable on post-mortem analysis, when
the logs from userspace applications aren't enough.
Furthermore, we have a test pool of long-running duts that are
constantly under close to real-world load for weeks. And such early
warnings allowed to figure out some bottle necks without much engineer
work intervention.

There are also not yet upstream patches for other kinds of "early
warnings" as prints whenever a mutex/semaphore is released after being
held for long time, but those patches are much more intricate and have
their runtime cost.

It seems rather easy to add printing tasks and their stacks for
notification and debugging purposes into hung task detector without
complicating the code or major cost (prints are with KERN_INFO loglevel
and so don't go on console, only into dmesg log).

Since commit a2e514453861 ("kernel/hung_task.c: allow to set checking
interval separately from timeout") it's possible to set checking
interval for hung task detector with `hung_task_check_interval_secs`.

Provide `hung_task_interval_warnings` sysctl that allows printing
hung tasks every detection interval. It's not ratelimited, so the root
should be cautious configuring it.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Vasiliy Khoruzhick <vasilykh@arista.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 Documentation/admin-guide/sysctl/kernel.rst | 20 ++++++++-
 include/linux/sched/sysctl.h                |  1 +
 kernel/hung_task.c                          | 50 ++++++++++++++-------
 kernel/sysctl.c                             |  8 ++++
 4 files changed, 62 insertions(+), 17 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 032c7cd3cede..2e36620ec1e4 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -45,6 +45,7 @@ show up in /proc/sys/kernel:
 - hung_task_timeout_secs
 - hung_task_check_interval_secs
 - hung_task_warnings
+- hung_task_interval_warnings
 - hyperv_record_panic_msg
 - kexec_load_disabled
 - kptr_restrict
@@ -383,14 +384,29 @@ Possible values to set are in range {0..LONG_MAX/HZ}.
 hung_task_warnings:
 ===================
 
-The maximum number of warnings to report. During a check interval
-if a hung task is detected, this value is decreased by 1.
+The maximum number of warnings to report. If after timeout a hung
+task is present, this value is decreased by 1 every check interval,
+producing a warning.
 When this value reaches 0, no more warnings will be reported.
 This file shows up if CONFIG_DETECT_HUNG_TASK is enabled.
 
 -1: report an infinite number of warnings.
 
 
+hung_task_interval_warnings:
+===================
+
+The same as hung_task_warnings, but set the number of interval
+warnings to be issued about detected hung tasks during check
+interval. That will produce warnings *before* the timeout happens.
+If a hung task is detected during check interval, this value is
+decreased by 1. When this value reaches 0, only timeout warnings
+will be reported.
+This file shows up if CONFIG_DETECT_HUNG_TASK is enabled.
+
+-1: report an infinite number of check interval warnings.
+
+
 hyperv_record_panic_msg:
 ========================
 
diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index d4f6215ee03f..89f55e914673 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -12,6 +12,7 @@ extern unsigned int  sysctl_hung_task_panic;
 extern unsigned long sysctl_hung_task_timeout_secs;
 extern unsigned long sysctl_hung_task_check_interval_secs;
 extern int sysctl_hung_task_warnings;
+extern int sysctl_hung_task_interval_warnings;
 extern int proc_dohung_task_timeout_secs(struct ctl_table *table, int write,
 					 void __user *buffer,
 					 size_t *lenp, loff_t *ppos);
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 14a625c16cb3..cd971eef8226 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -49,6 +49,7 @@ unsigned long __read_mostly sysctl_hung_task_timeout_secs = CONFIG_DEFAULT_HUNG_
 unsigned long __read_mostly sysctl_hung_task_check_interval_secs;
 
 int __read_mostly sysctl_hung_task_warnings = 10;
+int __read_mostly sysctl_hung_task_interval_warnings;
 
 static int __read_mostly did_panic;
 static bool hung_task_show_lock;
@@ -85,6 +86,34 @@ static struct notifier_block panic_block = {
 	.notifier_call = hung_task_panic,
 };
 
+static void hung_task_warning(struct task_struct *t, bool timeout)
+{
+	const char *loglevel = timeout ? KERN_ERR : KERN_INFO;
+	const char *path;
+	int *warnings;
+
+	if (timeout) {
+		warnings = &sysctl_hung_task_warnings;
+		path = "hung_task_timeout_secs";
+	} else {
+		warnings = &sysctl_hung_task_interval_warnings;
+		path = "hung_task_interval_secs";
+	}
+
+	if (*warnings > 0)
+		--*warnings;
+
+	printk("%sINFO: task %s:%d blocked for more than %ld seconds.\n",
+	       loglevel, t->comm, t->pid, (jiffies - t->last_switch_time) / HZ);
+	printk("%s      %s %s %.*s\n",
+		loglevel, print_tainted(), init_utsname()->release,
+		(int)strcspn(init_utsname()->version, " "),
+		init_utsname()->version);
+	printk("%s\"echo 0 > /proc/sys/kernel/%s\" disables this message.\n",
+		loglevel, path);
+	sched_show_task(t);
+}
+
 static void check_hung_task(struct task_struct *t, unsigned long timeout)
 {
 	unsigned long switch_count = t->nvcsw + t->nivcsw;
@@ -109,6 +138,9 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 		t->last_switch_time = jiffies;
 		return;
 	}
+	if (sysctl_hung_task_interval_warnings)
+		hung_task_warning(t, false);
+
 	if (time_is_after_jiffies(t->last_switch_time + timeout * HZ))
 		return;
 
@@ -120,22 +152,10 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 		hung_task_call_panic = true;
 	}
 
-	/*
-	 * Ok, the task did not get scheduled for more than 2 minutes,
-	 * complain:
-	 */
 	if (sysctl_hung_task_warnings) {
-		if (sysctl_hung_task_warnings > 0)
-			sysctl_hung_task_warnings--;
-		pr_err("INFO: task %s:%d blocked for more than %ld seconds.\n",
-		       t->comm, t->pid, (jiffies - t->last_switch_time) / HZ);
-		pr_err("      %s %s %.*s\n",
-			print_tainted(), init_utsname()->release,
-			(int)strcspn(init_utsname()->version, " "),
-			init_utsname()->version);
-		pr_err("\"echo 0 > /proc/sys/kernel/hung_task_timeout_secs\""
-			" disables this message.\n");
-		sched_show_task(t);
+		/* Don't print warings twice */
+		if (!sysctl_hung_task_interval_warnings)
+			hung_task_warning(t, true);
 		hung_task_show_lock = true;
 	}
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 078950d9605b..f12888971d66 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1147,6 +1147,14 @@ static struct ctl_table kern_table[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= &neg_one,
 	},
+	{
+		.procname	= "hung_task_interval_warnings",
+		.data		= &sysctl_hung_task_interval_warnings,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= &neg_one,
+	},
 #endif
 #ifdef CONFIG_RT_MUTEXES
 	{
-- 
2.22.0

