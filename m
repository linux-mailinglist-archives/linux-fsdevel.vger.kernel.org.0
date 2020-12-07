Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF81C2D151A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 16:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgLGPue (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 10:50:34 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:49636 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgLGPue (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 10:50:34 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kmIln-000WAS-88; Mon, 07 Dec 2020 08:49:47 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kmIlm-003c0K-0C; Mon, 07 Dec 2020 08:49:46 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Vladimir Kondratiev <vladimir.kondratiev@linux.intel.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kars Mulder <kerneldev@karsmulder.nl>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Joe Perches <joe@perches.com>,
        Rafael Aquini <aquini@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michel Lespinasse <walken@google.com>,
        Jann Horn <jannh@google.com>, chenqiwu <chenqiwu@xiaomi.com>,
        Minchan Kim <minchan@kernel.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20201207124433.4017265-1-vladimir.kondratiev@linux.intel.com>
        <da3fece2-664c-0ac3-2d22-3ce29bf1bfa8@linux.intel.com>
Date:   Mon, 07 Dec 2020 09:49:08 -0600
In-Reply-To: <da3fece2-664c-0ac3-2d22-3ce29bf1bfa8@linux.intel.com> (Vladimir
        Kondratiev's message of "Mon, 7 Dec 2020 14:52:01 +0200")
Message-ID: <87pn3ly5u3.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kmIlm-003c0K-0C;;;mid=<87pn3ly5u3.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18a+xTR/tVhwGXNThjMWrRWA6aYRDEc9Hg=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,LotsOfNums_01,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Vladimir Kondratiev <vladimir.kondratiev@linux.intel.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 577 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 12 (2.0%), b_tie_ro: 10 (1.8%), parse: 1.95
        (0.3%), extract_message_metadata: 22 (3.7%), get_uri_detail_list: 4.4
        (0.8%), tests_pri_-1000: 14 (2.4%), tests_pri_-950: 2.1 (0.4%),
        tests_pri_-900: 1.75 (0.3%), tests_pri_-90: 112 (19.3%), check_bayes:
        103 (17.9%), b_tokenize: 26 (4.4%), b_tok_get_all: 13 (2.3%),
        b_comp_prob: 6 (1.0%), b_tok_touch_all: 54 (9.4%), b_finish: 0.99
        (0.2%), tests_pri_0: 392 (67.9%), check_dkim_signature: 0.87 (0.1%),
        check_dkim_adsp: 10 (1.7%), poll_dns_idle: 0.44 (0.1%), tests_pri_10:
        2.2 (0.4%), tests_pri_500: 13 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC PATCH v2] do_exit(): panic() recursion detected
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Vladimir Kondratiev <vladimir.kondratiev@linux.intel.com> writes:

> Please ignore version 1 of the patch - it was sent from wrong mail address.
>
> To clarify the reason:
>
> Situation where do_exit() re-entered, discovered by static code analysis.
> For safety critical system, it is better to panic() when minimal chance of
> corruption detected. For this reason, we also panic on fatal signal delivery -
> patch for this not submitted yet.

What did the static code analysis say?  What triggers the recursion.

What makes it safe to even call panic on this code path?  Is there
enough kernel stack?

My sense is that if this actually can happen and is a real concern,
and that it is safe to do something on this code path it is probably
better just to ooops.  That way if someone is trying to debug such
a recursion they will have a backtrace to work with.  Plus panic
on oops will work.

Eric

>
> On 12/7/20 2:44 PM, Vladimir Kondratiev wrote:
>> Recursive do_exit() is symptom of compromised kernel integrity.
>> For safety critical systems, it may be better to
>> panic() in this case to minimize risk.
>>
>> Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@linux.intel.com>
>> Change-Id: I42f45900a08c4282c511b05e9e6061360d07db60
>> ---
>>   Documentation/admin-guide/kernel-parameters.txt | 6 ++++++
>>   include/linux/kernel.h                          | 1 +
>>   kernel/exit.c                                   | 7 +++++++
>>   kernel/sysctl.c                                 | 9 +++++++++
>>   4 files changed, 23 insertions(+)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 44fde25bb221..6e12a6804557 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -3508,6 +3508,12 @@
>>   			bit 4: print ftrace buffer
>>   			bit 5: print all printk messages in buffer
>>   +	panic_on_exit_recursion
>> +			panic() when do_exit() recursion detected, rather then
>> +			try to stay running whenever possible.
>> +			Useful on safety critical systems; re-entry in do_exit
>> +			is a symptom of compromised kernel integrity.
>> +
>>   	panic_on_taint=	Bitmask for conditionally calling panic() in add_taint()
>>   			Format: <hex>[,nousertaint]
>>   			Hexadecimal bitmask representing the set of TAINT flags
>> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
>> index 2f05e9128201..5afb20534cb2 100644
>> --- a/include/linux/kernel.h
>> +++ b/include/linux/kernel.h
>> @@ -539,6 +539,7 @@ extern int sysctl_panic_on_rcu_stall;
>>   extern int sysctl_panic_on_stackoverflow;
>>     extern bool crash_kexec_post_notifiers;
>> +extern int panic_on_exit_recursion;
>>     /*
>>    * panic_cpu is used for synchronizing panic() and crash_kexec() execution. It
>> diff --git a/kernel/exit.c b/kernel/exit.c
>> index 1f236ed375f8..162799a8b539 100644
>> --- a/kernel/exit.c
>> +++ b/kernel/exit.c
>> @@ -68,6 +68,9 @@
>>   #include <asm/unistd.h>
>>   #include <asm/mmu_context.h>
>>   +int panic_on_exit_recursion __read_mostly;
>> +core_param(panic_on_exit_recursion, panic_on_exit_recursion, int, 0644);
>> +
>>   static void __unhash_process(struct task_struct *p, bool group_dead)
>>   {
>>   	nr_threads--;
>> @@ -757,6 +760,10 @@ void __noreturn do_exit(long code)
>>   	 */
>>   	if (unlikely(tsk->flags & PF_EXITING)) {
>>   		pr_alert("Fixing recursive fault but reboot is needed!\n");
>> +		if (panic_on_exit_recursion)
>> +			panic("Recursive do_exit() detected in %s[%d]\n",
>> +			      current->comm, task_pid_nr(current));
>> +
>>   		futex_exit_recursive(tsk);
>>   		set_current_state(TASK_UNINTERRUPTIBLE);
>>   		schedule();
>> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
>> index afad085960b8..bb397fba2c42 100644
>> --- a/kernel/sysctl.c
>> +++ b/kernel/sysctl.c
>> @@ -2600,6 +2600,15 @@ static struct ctl_table kern_table[] = {
>>   		.extra2		= &one_thousand,
>>   	},
>>   #endif
>> +	{
>> +		.procname	= "panic_on_exit_recursion",
>> +		.data		= &panic_on_exit_recursion,
>> +		.maxlen		= sizeof(int),
>> +		.mode		= 0644,
>> +		.proc_handler	= proc_dointvec_minmax,
>> +		.extra1		= SYSCTL_ZERO,
>> +		.extra2		= SYSCTL_ONE,
>> +	},
>>   	{
>>   		.procname	= "panic_on_warn",
>>   		.data		= &panic_on_warn,
>>
