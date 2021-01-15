Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2CFC2F7FEA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 16:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732702AbhAOPpE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 10:45:04 -0500
Received: from mail.efficios.com ([167.114.26.124]:39736 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732130AbhAOPpD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 10:45:03 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 70ADF2ED463;
        Fri, 15 Jan 2021 10:44:21 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 8yqs5yHjsDgP; Fri, 15 Jan 2021 10:44:21 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 02F272ED7C8;
        Fri, 15 Jan 2021 10:44:21 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 02F272ED7C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1610725461;
        bh=hHOaSuEsxF7HH6QvUOEW9vlsXyh2kshGGUnCj98GgPk=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=KWwfxa1rMdh9+imADasGtwgtoBOZI9THQY8caaIiAXtKLJpgx3OWRJiDw48iQDAED
         D1tZG2y6PCfb2bpJ3fRyTVRkMkQtXohj6fQb41BspaJQZ0sOC/eeMbIXU4MkF+XAMJ
         jyEZbuvzYPdnGxiZsyQyvb2U1Iha3QRQsAd3NlFL9p79KbLyx+ovP0XXolSnMMakjq
         9hJlD86t53s/fIMHwjXGDduOwAA/gZ+m9v3BdPMx/nHBOrI5zeUClzMSSqyA1Bs3fR
         3SY7nIYs45H86VMQR2h5i22a5l35ijbxepXiLVR01Cz7WuLxnvUN41aG7KVSZyTrDc
         gWW+972CnB6Tg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KZRFZ3auoPDG; Fri, 15 Jan 2021 10:44:20 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id E54D02ED7C5;
        Fri, 15 Jan 2021 10:44:20 -0500 (EST)
Date:   Fri, 15 Jan 2021 10:44:20 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Piotr Figiel <figiel@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Michel Lespinasse <walken@google.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Andrei Vagin <avagin@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Peter Oskolkov <posk@google.com>,
        Kamil Yurtsever <kyurtsever@google.com>,
        Chris Kennelly <ckennelly@google.com>,
        Paul Turner <pjt@google.com>
Message-ID: <1530232798.13459.1610725460826.JavaMail.zimbra@efficios.com>
In-Reply-To: <20210114185445.996-1-figiel@google.com>
References: <20210114185445.996-1-figiel@google.com>
Subject: Re: [PATCH v2] fs/proc: Expose RSEQ configuration
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3991 (ZimbraWebClient - FF84 (Linux)/8.8.15_GA_3980)
Thread-Topic: fs/proc: Expose RSEQ configuration
Thread-Index: fHnTuU7wnvFk0SnZHls1lGXop5OmJQ==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

----- On Jan 14, 2021, at 1:54 PM, Piotr Figiel figiel@google.com wrote:

Added PeterZ, Paul and Boqun to CC. They are also listed as maintainers of rseq.
Please CC them in your next round of patches.

> For userspace checkpoint and restore (C/R) some way of getting process
> state containing RSEQ configuration is needed.
> 
> There are two ways this information is going to be used:
> - to re-enable RSEQ for threads which had it enabled before C/R
> - to detect if a thread was in a critical section during C/R
> 
> Since C/R preserves TLS memory and addresses RSEQ ABI will be restored
> using the address registered before C/R.

Indeed, if the process goes through a checkpoint/restore while within a
rseq c.s., that critical section should abort. Given that it's only the
restored process which resumes user-space execution, there should be some
way to ensure that the rseq tls pointer is restored before that thread goes
back to user-space, or some way to ensure the rseq TLS is registered
before that thread returns to the saved instruction pointer.

How do you plan to re-register the rseq TLS for each thread upon restore ?

I suspect you move the return IP to the abort either at checkpoint or restore
if you detect that the thread is running in a rseq critical section.

> 
> Detection whether the thread is in a critical section during C/R is
> needed to enforce behavior of RSEQ abort during C/R. Attaching with
> ptrace() before registers are dumped itself doesn't cause RSEQ abort.

Right, because the RSEQ abort is only done when going back to user-space,
and AFAIU the checkpointed process will cease to exist, and won't go back
to user-space, therefore bypassing any RSEQ abort.

> Restoring the instruction pointer within the critical section is
> problematic because rseq_cs may get cleared before the control is
> passed to the migrated application code leading to RSEQ invariants not
> being preserved.

The commit message should state that both the per-thread rseq TLS area address
and the signature are dumped within this new proc file.

> 
> Signed-off-by: Piotr Figiel <figiel@google.com>
> 
> ---
> 
> v2:
> - fixed string formatting for 32-bit architectures
> 
> v1:
> - https://lkml.kernel.org/r/20210113174127.2500051-1-figiel@google.com
> 
> ---
> fs/proc/base.c | 21 +++++++++++++++++++++
> 1 file changed, 21 insertions(+)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index b3422cda2a91..7cc36a224b8b 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -662,6 +662,21 @@ static int proc_pid_syscall(struct seq_file *m, struct
> pid_namespace *ns,
> 
> 	return 0;
> }
> +
> +#ifdef CONFIG_RSEQ
> +static int proc_pid_rseq(struct seq_file *m, struct pid_namespace *ns,
> +				struct pid *pid, struct task_struct *task)
> +{
> +	int res = lock_trace(task);

AFAIU lock_trace prevents concurrent exec() from modifying the task's content.
What prevents a concurrent rseq register/unregister to be executed concurrently
with proc_pid_rseq ?

> +
> +	if (res)
> +		return res;
> +	seq_printf(m, "%tx %08x\n", (ptrdiff_t)((uintptr_t)task->rseq),

I wonder if all those parentheses are needed. Wouldn't it be enough to have:

  (ptrdiff_t)(uintptr_t)task->rseq

?

Thanks,

Mathieu

> +		   task->rseq_sig);
> +	unlock_trace(task);
> +	return 0;
> +}
> +#endif /* CONFIG_RSEQ */
> #endif /* CONFIG_HAVE_ARCH_TRACEHOOK */
> 
> /************************************************************************/
> @@ -3182,6 +3197,9 @@ static const struct pid_entry tgid_base_stuff[] = {
> 	REG("comm",      S_IRUGO|S_IWUSR, proc_pid_set_comm_operations),
> #ifdef CONFIG_HAVE_ARCH_TRACEHOOK
> 	ONE("syscall",    S_IRUSR, proc_pid_syscall),
> +#ifdef CONFIG_RSEQ
> +	ONE("rseq",       S_IRUSR, proc_pid_rseq),
> +#endif
> #endif
> 	REG("cmdline",    S_IRUGO, proc_pid_cmdline_ops),
> 	ONE("stat",       S_IRUGO, proc_tgid_stat),
> @@ -3522,6 +3540,9 @@ static const struct pid_entry tid_base_stuff[] = {
> 			 &proc_pid_set_comm_operations, {}),
> #ifdef CONFIG_HAVE_ARCH_TRACEHOOK
> 	ONE("syscall",   S_IRUSR, proc_pid_syscall),
> +#ifdef CONFIG_RSEQ
> +	ONE("rseq",      S_IRUSR, proc_pid_rseq),
> +#endif
> #endif
> 	REG("cmdline",   S_IRUGO, proc_pid_cmdline_ops),
> 	ONE("stat",      S_IRUGO, proc_tid_stat),
> --
> 2.30.0.284.gd98b1dd5eaa7-goog

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
