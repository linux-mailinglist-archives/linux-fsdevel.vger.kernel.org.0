Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B19311740E6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2020 21:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgB1UVc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Feb 2020 15:21:32 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:48570 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgB1UVc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Feb 2020 15:21:32 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1j7m8Y-0008CC-TQ; Fri, 28 Feb 2020 13:21:30 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1j7m8X-0002B5-4f; Fri, 28 Feb 2020 13:21:30 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>
References: <20200210150519.538333-8-gladkov.alexey@gmail.com>
        <87v9odlxbr.fsf@x220.int.ebiederm.org>
        <20200212144921.sykucj4mekcziicz@comp-core-i7-2640m-0182e6>
        <87tv3vkg1a.fsf@x220.int.ebiederm.org>
        <CAHk-=wg52stFtUxMOxs3afkwDWmWn1JXC7RJ7dPsTrJbnxpZVg@mail.gmail.com>
        <87v9obipk9.fsf@x220.int.ebiederm.org>
        <CAHk-=wgwmu4jpmOqW0+Lz0dcem1Fub=ThLHvmLobf_WqCq7bwg@mail.gmail.com>
        <20200212200335.GO23230@ZenIV.linux.org.uk>
        <CAHk-=wi+1CPShMFvJNPfnrJ8DD8uVKUOQ5TQzQUNGLUkeoahkg@mail.gmail.com>
        <20200212203833.GQ23230@ZenIV.linux.org.uk>
        <20200212204124.GR23230@ZenIV.linux.org.uk>
        <CAHk-=wi5FOGV_3tALK3n6E2fK3Oa_yCYkYQtCSaXLSEm2DUCKg@mail.gmail.com>
        <87lfp7h422.fsf@x220.int.ebiederm.org>
        <CAHk-=wgmn9Qds0VznyphouSZW6e42GWDT5H1dpZg8pyGDGN+=w@mail.gmail.com>
        <87pnejf6fz.fsf@x220.int.ebiederm.org>
        <871rqpaswu.fsf_-_@x220.int.ebiederm.org>
        <871rqk2brn.fsf_-_@x220.int.ebiederm.org>
        <878skmsbyy.fsf_-_@x220.int.ebiederm.org>
Date:   Fri, 28 Feb 2020 14:19:22 -0600
In-Reply-To: <878skmsbyy.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Fri, 28 Feb 2020 14:17:41 -0600")
Message-ID: <87r1yeqxbp.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1j7m8X-0002B5-4f;;;mid=<87r1yeqxbp.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19VfyN/lsDbEeYKOAeN0gaGhdR50pzHuEY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,LotsOfNums_01,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4413]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 680 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 3.7 (0.6%), b_tie_ro: 2.8 (0.4%), parse: 1.59
        (0.2%), extract_message_metadata: 15 (2.2%), get_uri_detail_list: 3.4
        (0.5%), tests_pri_-1000: 15 (2.2%), tests_pri_-950: 1.28 (0.2%),
        tests_pri_-900: 1.06 (0.2%), tests_pri_-90: 38 (5.5%), check_bayes: 36
        (5.3%), b_tokenize: 14 (2.1%), b_tok_get_all: 11 (1.7%), b_comp_prob:
        3.1 (0.5%), b_tok_touch_all: 3.4 (0.5%), b_finish: 0.64 (0.1%),
        tests_pri_0: 592 (87.1%), check_dkim_signature: 0.61 (0.1%),
        check_dkim_adsp: 2.3 (0.3%), poll_dns_idle: 0.74 (0.1%), tests_pri_10:
        2.2 (0.3%), tests_pri_500: 8 (1.1%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 3/3] proc: Remove the now unnecessary internal mount of proc
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


There remains no more code in the kernel using pids_ns->proc_mnt,
therefore remove it from the kernel.

The big benefit of this change is that one of the most error prone and
tricky parts of the pid namespace implementation, maintaining kernel
mounts of proc is removed.

In addition removing the unnecessary complexity of the kernel mount
fixes a regression that caused the proc mount options to be ignored.
Now that the initial mount of proc comes from userspace, those mount
options are again honored.  This fixes Android's usage of the proc
hidepid option.

Reported-by: Alistair Strachan <astrachan@google.com>
Fixes: e94591d0d90c ("proc: Convert proc_mount to use mount_ns.")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/proc/root.c                | 36 -----------------------------------
 include/linux/pid_namespace.h |  2 --
 include/linux/proc_ns.h       |  5 -----
 kernel/pid.c                  |  8 --------
 kernel/pid_namespace.c        |  7 -------
 5 files changed, 58 deletions(-)

diff --git a/fs/proc/root.c b/fs/proc/root.c
index 608233dfd29c..2633f10446c3 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -292,39 +292,3 @@ struct proc_dir_entry proc_root = {
 	.subdir		= RB_ROOT,
 	.name		= "/proc",
 };
-
-int pid_ns_prepare_proc(struct pid_namespace *ns)
-{
-	struct proc_fs_context *ctx;
-	struct fs_context *fc;
-	struct vfsmount *mnt;
-
-	fc = fs_context_for_mount(&proc_fs_type, SB_KERNMOUNT);
-	if (IS_ERR(fc))
-		return PTR_ERR(fc);
-
-	if (fc->user_ns != ns->user_ns) {
-		put_user_ns(fc->user_ns);
-		fc->user_ns = get_user_ns(ns->user_ns);
-	}
-
-	ctx = fc->fs_private;
-	if (ctx->pid_ns != ns) {
-		put_pid_ns(ctx->pid_ns);
-		get_pid_ns(ns);
-		ctx->pid_ns = ns;
-	}
-
-	mnt = fc_mount(fc);
-	put_fs_context(fc);
-	if (IS_ERR(mnt))
-		return PTR_ERR(mnt);
-
-	ns->proc_mnt = mnt;
-	return 0;
-}
-
-void pid_ns_release_proc(struct pid_namespace *ns)
-{
-	kern_unmount(ns->proc_mnt);
-}
diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
index 2ed6af88794b..4956e362e55e 100644
--- a/include/linux/pid_namespace.h
+++ b/include/linux/pid_namespace.h
@@ -33,7 +33,6 @@ struct pid_namespace {
 	unsigned int level;
 	struct pid_namespace *parent;
 #ifdef CONFIG_PROC_FS
-	struct vfsmount *proc_mnt;
 	struct dentry *proc_self;
 	struct dentry *proc_thread_self;
 #endif
@@ -42,7 +41,6 @@ struct pid_namespace {
 #endif
 	struct user_namespace *user_ns;
 	struct ucounts *ucounts;
-	struct work_struct proc_work;
 	kgid_t pid_gid;
 	int hide_pid;
 	int reboot;	/* group exit code if this pidns was rebooted */
diff --git a/include/linux/proc_ns.h b/include/linux/proc_ns.h
index 4626b1ac3b6c..e1106a077c1a 100644
--- a/include/linux/proc_ns.h
+++ b/include/linux/proc_ns.h
@@ -50,16 +50,11 @@ enum {
 
 #ifdef CONFIG_PROC_FS
 
-extern int pid_ns_prepare_proc(struct pid_namespace *ns);
-extern void pid_ns_release_proc(struct pid_namespace *ns);
 extern int proc_alloc_inum(unsigned int *pino);
 extern void proc_free_inum(unsigned int inum);
 
 #else /* CONFIG_PROC_FS */
 
-static inline int pid_ns_prepare_proc(struct pid_namespace *ns) { return 0; }
-static inline void pid_ns_release_proc(struct pid_namespace *ns) {}
-
 static inline int proc_alloc_inum(unsigned int *inum)
 {
 	*inum = 1;
diff --git a/kernel/pid.c b/kernel/pid.c
index ca08d6a3aa77..60820e72634c 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -144,9 +144,6 @@ void free_pid(struct pid *pid)
 			/* Handle a fork failure of the first process */
 			WARN_ON(ns->child_reaper);
 			ns->pid_allocated = 0;
-			/* fall through */
-		case 0:
-			schedule_work(&ns->proc_work);
 			break;
 		}
 
@@ -247,11 +244,6 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
 		tmp = tmp->parent;
 	}
 
-	if (unlikely(is_child_reaper(pid))) {
-		if (pid_ns_prepare_proc(ns))
-			goto out_free;
-	}
-
 	get_pid_ns(ns);
 	refcount_set(&pid->count, 1);
 	for (type = 0; type < PIDTYPE_MAX; ++type)
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index d40017e79ebe..318fcc6ba301 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -57,12 +57,6 @@ static struct kmem_cache *create_pid_cachep(unsigned int level)
 	return READ_ONCE(*pkc);
 }
 
-static void proc_cleanup_work(struct work_struct *work)
-{
-	struct pid_namespace *ns = container_of(work, struct pid_namespace, proc_work);
-	pid_ns_release_proc(ns);
-}
-
 static struct ucounts *inc_pid_namespaces(struct user_namespace *ns)
 {
 	return inc_ucount(ns, current_euid(), UCOUNT_PID_NAMESPACES);
@@ -114,7 +108,6 @@ static struct pid_namespace *create_pid_namespace(struct user_namespace *user_ns
 	ns->user_ns = get_user_ns(user_ns);
 	ns->ucounts = ucounts;
 	ns->pid_allocated = PIDNS_ADDING;
-	INIT_WORK(&ns->proc_work, proc_cleanup_work);
 
 	return ns;
 
-- 
2.25.0

