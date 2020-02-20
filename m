Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C800A16690D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 21:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbgBTUyu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 15:54:50 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:50204 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbgBTUyu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 15:54:50 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1j4sqP-0002HF-0g; Thu, 20 Feb 2020 13:54:49 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1j4sqN-00069Y-Au; Thu, 20 Feb 2020 13:54:48 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
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
        Solar Designer <solar@openwall.com>
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
Date:   Thu, 20 Feb 2020 14:52:47 -0600
In-Reply-To: <871rqpaswu.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Thu, 20 Feb 2020 14:46:25 -0600")
Message-ID: <87r1yp7zhc.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1j4sqN-00069Y-Au;;;mid=<87r1yp7zhc.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/YvfDt9LJUlANZXt5NnLd7OKfeCre6VOM=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,NO_DNS_FOR_FROM,T_TM2_M_HEADER_IN_MSG,XMNoVowels,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4998]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 NO_DNS_FOR_FROM DNS: Envelope sender has no MX or A DNS records
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1246 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.8 (0.2%), b_tie_ro: 2.0 (0.2%), parse: 1.28
        (0.1%), extract_message_metadata: 12 (1.0%), get_uri_detail_list: 2.9
        (0.2%), tests_pri_-1000: 3.4 (0.3%), tests_pri_-950: 0.99 (0.1%),
        tests_pri_-900: 0.86 (0.1%), tests_pri_-90: 26 (2.1%), check_bayes: 25
        (2.0%), b_tokenize: 9 (0.7%), b_tok_get_all: 9 (0.7%), b_comp_prob:
        1.68 (0.1%), b_tok_touch_all: 3.9 (0.3%), b_finish: 0.66 (0.1%),
        tests_pri_0: 1186 (95.2%), check_dkim_signature: 0.39 (0.0%),
        check_dkim_adsp: 553 (44.4%), poll_dns_idle: 549 (44.1%),
        tests_pri_10: 2.4 (0.2%), tests_pri_500: 7 (0.6%), rewrite_mail: 0.00
        (0.0%)
Subject: [PATCH 7/7] proc: Ensure we see the exit of each process tid exactly once
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


When the thread group leader changes during exec and the old leaders
thread is reaped proc_flush_pid will flush the dentries for the entire
process because the leader still has it's original pid.

Fix this by exchanging the pids in an rcu safe manner,
and wrapping the code to do that up in a helper exchange_tids.

When I removed switch_exec_pids and introduced this behavior
in d73d65293e3e ("[PATCH] pidhash: kill switch_exec_pids") there
really was nothing that cared as flushing happened with
the cached dentry and de_thread flushed both of them on exec.

This lack of fully exchanging pids became a problem a few months later
when I introduced 48e6484d4902 ("[PATCH] proc: Rewrite the proc dentry
flush on exit optimization").  Which overlooked the de_thread case
was no longer swapping pids, and I was looking up proc dentries
by task->pid.

The current behavior isn't properly a bug as everything in proc will
continue to work correctly just a little bit less efficiently.  Fix
this just so there are no little surprise corner cases waiting to bite
people.

Fixes: 48e6484d4902 ("[PATCH] proc: Rewrite the proc dentry flush on exit optimization").
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 fs/exec.c           |  5 +----
 include/linux/pid.h |  1 +
 kernel/pid.c        | 16 ++++++++++++++++
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index db17be51b112..3f0bc293442e 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1148,11 +1148,8 @@ static int de_thread(struct task_struct *tsk)
 
 		/* Become a process group leader with the old leader's pid.
 		 * The old leader becomes a thread of the this thread group.
-		 * Note: The old leader also uses this pid until release_task
-		 *       is called.  Odd but simple and correct.
 		 */
-		tsk->pid = leader->pid;
-		change_pid(tsk, PIDTYPE_PID, task_pid(leader));
+		exchange_tids(tsk, leader);
 		transfer_pid(leader, tsk, PIDTYPE_TGID);
 		transfer_pid(leader, tsk, PIDTYPE_PGID);
 		transfer_pid(leader, tsk, PIDTYPE_SID);
diff --git a/include/linux/pid.h b/include/linux/pid.h
index 01a0d4e28506..0f40b5f1c32c 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -101,6 +101,7 @@ extern void attach_pid(struct task_struct *task, enum pid_type);
 extern void detach_pid(struct task_struct *task, enum pid_type);
 extern void change_pid(struct task_struct *task, enum pid_type,
 			struct pid *pid);
+extern void exchange_tids(struct task_struct *task, struct task_struct *old);
 extern void transfer_pid(struct task_struct *old, struct task_struct *new,
 			 enum pid_type);
 
diff --git a/kernel/pid.c b/kernel/pid.c
index 0f4ecb57214c..0085b15478fb 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -359,6 +359,22 @@ void change_pid(struct task_struct *task, enum pid_type type,
 	attach_pid(task, type);
 }
 
+void exchange_tids(struct task_struct *ntask, struct task_struct *otask)
+{
+	/* pid_links[PIDTYPE_PID].next is always NULL */
+	struct pid *npid = READ_ONCE(ntask->thread_pid);
+	struct pid *opid = READ_ONCE(otask->thread_pid);
+
+	rcu_assign_pointer(opid->tasks[PIDTYPE_PID].first, &ntask->pid_links[PIDTYPE_PID]);
+	rcu_assign_pointer(npid->tasks[PIDTYPE_PID].first, &otask->pid_links[PIDTYPE_PID]);
+	rcu_assign_pointer(ntask->thread_pid, opid);
+	rcu_assign_pointer(otask->thread_pid, npid);
+	WRITE_ONCE(ntask->pid_links[PIDTYPE_PID].pprev, &opid->tasks[PIDTYPE_PID].first);
+	WRITE_ONCE(otask->pid_links[PIDTYPE_PID].pprev, &npid->tasks[PIDTYPE_PID].first);
+	WRITE_ONCE(ntask->pid, pid_nr(opid));
+	WRITE_ONCE(otask->pid, pid_nr(npid));
+}
+
 /* transfer_pid is an optimization of attach_pid(new), detach_pid(old) */
 void transfer_pid(struct task_struct *old, struct task_struct *new,
 			   enum pid_type type)
-- 
2.20.1

