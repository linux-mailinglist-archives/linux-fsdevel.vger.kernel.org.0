Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAAE92D4894
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 19:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732676AbgLISGH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 13:06:07 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:34642 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730097AbgLISGA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 13:06:00 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kn3q1-0053Tt-Ky; Wed, 09 Dec 2020 11:05:17 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1kn3q0-0002xR-LT; Wed, 09 Dec 2020 11:05:17 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jann@thejh.net>
References: <87r1on1v62.fsf@x220.int.ebiederm.org>
        <20201120231441.29911-15-ebiederm@xmission.com>
        <20201207232900.GD4115853@ZenIV.linux.org.uk>
        <877dprvs8e.fsf@x220.int.ebiederm.org>
        <20201209040731.GK3579531@ZenIV.linux.org.uk>
        <877dprtxly.fsf@x220.int.ebiederm.org>
        <20201209142359.GN3579531@ZenIV.linux.org.uk>
Date:   Wed, 09 Dec 2020 12:04:38 -0600
In-Reply-To: <20201209142359.GN3579531@ZenIV.linux.org.uk> (Al Viro's message
        of "Wed, 9 Dec 2020 14:23:59 +0000")
Message-ID: <87o8j2svnt.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kn3q0-0002xR-LT;;;mid=<87o8j2svnt.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/AVDZYCvBzPyVf4VIYpXLHcjRbyxvbzzo=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4997]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Al Viro <viro@zeniv.linux.org.uk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 498 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.5 (0.7%), b_tie_ro: 2.4 (0.5%), parse: 1.33
        (0.3%), extract_message_metadata: 12 (2.4%), get_uri_detail_list: 2.7
        (0.5%), tests_pri_-1000: 13 (2.6%), tests_pri_-950: 1.40 (0.3%),
        tests_pri_-900: 1.12 (0.2%), tests_pri_-90: 116 (23.3%), check_bayes:
        113 (22.8%), b_tokenize: 8 (1.5%), b_tok_get_all: 7 (1.4%),
        b_comp_prob: 1.51 (0.3%), b_tok_touch_all: 94 (18.8%), b_finish: 0.77
        (0.2%), tests_pri_0: 339 (68.1%), check_dkim_signature: 0.42 (0.1%),
        check_dkim_adsp: 1.97 (0.4%), poll_dns_idle: 0.65 (0.1%),
        tests_pri_10: 1.68 (0.3%), tests_pri_500: 5 (1.0%), rewrite_mail: 0.00
        (0.0%)
Subject: [PATCH] files: rcu free files_struct
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


This makes it safe to deference task->files with just rcu_read_lock
held, removing the need to take task_lock.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---

I have cleaned up my patch a little more and made this a little
more explicitly rcu.  I took a completley different approach to
documenting the use of rcu_head than we described that seems a little
more robust.

 fs/file.c               | 53 ++++++++++++++++++++++++++---------------
 include/linux/fdtable.h |  1 +
 kernel/fork.c           |  4 ++--
 3 files changed, 37 insertions(+), 21 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 412033d8cfdf..88064f185560 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -379,7 +379,7 @@ struct files_struct *dup_fd(struct files_struct *oldf, unsigned int max_fds, int
 	return NULL;
 }
 
-static struct fdtable *close_files(struct files_struct * files)
+static void close_files(struct files_struct * files)
 {
 	/*
 	 * It is safe to dereference the fd table without RCU or
@@ -397,8 +397,9 @@ static struct fdtable *close_files(struct files_struct * files)
 		set = fdt->open_fds[j++];
 		while (set) {
 			if (set & 1) {
-				struct file * file = xchg(&fdt->fd[i], NULL);
+				struct file * file = fdt->fd[i];
 				if (file) {
+					rcu_assign_pointer(fdt->fd[i], NULL);
 					filp_close(file, files);
 					cond_resched();
 				}
@@ -407,19 +408,35 @@ static struct fdtable *close_files(struct files_struct * files)
 			set >>= 1;
 		}
 	}
+}
 
-	return fdt;
+static void free_files_struct_rcu(struct rcu_head *rcu)
+{
+	struct files_struct *files =
+		container_of(rcu, struct files_struct, fdtab.rcu);
+	struct fdtable *fdt = rcu_dereference_raw(files->fdt);
+
+	/* free the arrays if they are not embedded */
+	if (fdt != &files->fdtab)
+		__free_fdtable(fdt);
+	kmem_cache_free(files_cachep, files);
 }
 
 void put_files_struct(struct files_struct *files)
 {
 	if (atomic_dec_and_test(&files->count)) {
-		struct fdtable *fdt = close_files(files);
-
-		/* free the arrays if they are not embedded */
-		if (fdt != &files->fdtab)
-			__free_fdtable(fdt);
-		kmem_cache_free(files_cachep, files);
+		close_files(files);
+		/*
+		 * The rules for using the rcu_head in fdtable:
+		 *
+		 * If the fdtable is being freed independently
+		 * of the files_struct fdtable->rcu is used.
+		 *
+		 * When the fdtable and files_struct are freed
+		 * together the rcu_head from the fdtable embedded in
+		 * files_struct is used.
+		 */
+		call_rcu(&files->fdtab.rcu, free_files_struct_rcu);
 	}
 }
 
@@ -822,12 +839,14 @@ EXPORT_SYMBOL(fget_raw);
 
 struct file *fget_task(struct task_struct *task, unsigned int fd)
 {
+	struct files_struct *files;
 	struct file *file = NULL;
 
-	task_lock(task);
-	if (task->files)
-		file = __fget_files(task->files, fd, 0, 1);
-	task_unlock(task);
+	rcu_read_lock();
+	files = rcu_dereference(task->files);
+	if (files)
+		file = __fget_files(files, fd, 0, 1);
+	rcu_read_unlock();
 
 	return file;
 }
@@ -838,11 +857,9 @@ struct file *task_lookup_fd_rcu(struct task_struct *task, unsigned int fd)
 	struct files_struct *files;
 	struct file *file = NULL;
 
-	task_lock(task);
-	files = task->files;
+	files = rcu_dereference(task->files);
 	if (files)
 		file = files_lookup_fd_rcu(files, fd);
-	task_unlock(task);
 
 	return file;
 }
@@ -854,8 +871,7 @@ struct file *task_lookup_next_fd_rcu(struct task_struct *task, unsigned int *ret
 	unsigned int fd = *ret_fd;
 	struct file *file = NULL;
 
-	task_lock(task);
-	files = task->files;
+	files = rcu_dereference(task->files);
 	if (files) {
 		for (; fd < files_fdtable(files)->max_fds; fd++) {
 			file = files_lookup_fd_rcu(files, fd);
@@ -863,7 +879,6 @@ struct file *task_lookup_next_fd_rcu(struct task_struct *task, unsigned int *ret
 				break;
 		}
 	}
-	task_unlock(task);
 	*ret_fd = fd;
 	return file;
 }
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index d0e78174874a..37dcface020f 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -30,6 +30,7 @@ struct fdtable {
 	unsigned long *close_on_exec;
 	unsigned long *open_fds;
 	unsigned long *full_fds_bits;
+	/* Used for freeing fdtable and any containing files_struct */
 	struct rcu_head rcu;
 };
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 4d0ae6f827df..eca474a1586a 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2982,7 +2982,7 @@ int ksys_unshare(unsigned long unshare_flags)
 
 		if (new_fd) {
 			fd = current->files;
-			current->files = new_fd;
+			rcu_assign_pointer(current->files, new_fd);
 			new_fd = fd;
 		}
 
@@ -3035,7 +3035,7 @@ int unshare_files(void)
 
 	old = task->files;
 	task_lock(task);
-	task->files = copy;
+	rcu_assign_pointer(task->files, copy);
 	task_unlock(task);
 	put_files_struct(old);
 	return 0;
-- 
2.20.1

