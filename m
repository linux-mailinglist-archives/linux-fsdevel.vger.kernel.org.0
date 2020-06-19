Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56CCF2000D8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jun 2020 05:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbgFSDei (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jun 2020 23:34:38 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:51406 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbgFSDeh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jun 2020 23:34:37 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jm7nV-0007NK-El; Thu, 18 Jun 2020 21:34:33 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jm7nU-0004ps-IZ; Thu, 18 Jun 2020 21:34:33 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Junxiao Bi <junxiao.bi@oracle.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <matthew.wilcox@oracle.com>,
        Srinivas Eeda <SRINIVAS.EEDA@oracle.com>,
        "joe.jin\@oracle.com" <joe.jin@oracle.com>
References: <54091fc0-ca46-2186-97a8-d1f3c4f3877b@oracle.com>
        <20200618233958.GV8681@bombadil.infradead.org>
        <877dw3apn8.fsf@x220.int.ebiederm.org>
        <2cf6af59-e86b-f6cc-06d3-84309425bd1d@oracle.com>
Date:   Thu, 18 Jun 2020 22:30:15 -0500
In-Reply-To: <2cf6af59-e86b-f6cc-06d3-84309425bd1d@oracle.com> (Junxiao Bi's
        message of "Thu, 18 Jun 2020 17:27:43 -0700")
Message-ID: <87sger91h4.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jm7nU-0004ps-IZ;;;mid=<87sger91h4.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19o0dSaAfyOt0uwUe//uvCCTnRQtYzJvXU=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4666]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa07 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Junxiao Bi <junxiao.bi@oracle.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 421 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 12 (2.8%), b_tie_ro: 10 (2.5%), parse: 1.16
        (0.3%), extract_message_metadata: 17 (4.1%), get_uri_detail_list: 2.9
        (0.7%), tests_pri_-1000: 25 (6.0%), tests_pri_-950: 1.22 (0.3%),
        tests_pri_-900: 0.99 (0.2%), tests_pri_-90: 59 (14.1%), check_bayes:
        58 (13.8%), b_tokenize: 9 (2.1%), b_tok_get_all: 10 (2.3%),
        b_comp_prob: 3.1 (0.7%), b_tok_touch_all: 33 (7.9%), b_finish: 0.83
        (0.2%), tests_pri_0: 289 (68.5%), check_dkim_signature: 0.53 (0.1%),
        check_dkim_adsp: 2.3 (0.6%), poll_dns_idle: 0.72 (0.2%), tests_pri_10:
        3.1 (0.7%), tests_pri_500: 9 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: severe proc dentry lock contention
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Junxiao Bi <junxiao.bi@oracle.com> writes:

> On 6/18/20 5:02 PM, ebiederm@xmission.com wrote:
>
>> Matthew Wilcox <willy@infradead.org> writes:
>>
>>> On Thu, Jun 18, 2020 at 03:17:33PM -0700, Junxiao Bi wrote:
>>>> When debugging some performance issue, i found that thousands of threads
>>>> exit around same time could cause a severe spin lock contention on proc
>>>> dentry "/proc/$parent_process_pid/task/", that's because threads needs to
>>>> clean up their pid file from that dir when exit. Check the following
>>>> standalone test case that simulated the case and perf top result on v5.7
>>>> kernel. Any idea on how to fix this?
>>> Thanks, Junxiao.
>>>
>>> We've looked at a few different ways of fixing this problem.
>>>
>>> Even though the contention is within the dcache, it seems like a usecase
>>> that the dcache shouldn't be optimised for -- generally we do not have
>>> hundreds of CPUs removing dentries from a single directory in parallel.
>>>
>>> We could fix this within procfs.  We don't have a great patch yet, but
>>> the current approach we're looking at allows only one thread at a time
>>> to call dput() on any /proc/*/task directory.
>>>
>>> We could also look at fixing this within the scheduler.  Only allowing
>>> one CPU to run the threads of an exiting process would fix this particular
>>> problem, but might have other consequences.
>>>
>>> I was hoping that 7bc3e6e55acf would fix this, but that patch is in 5.7,
>>> so that hope is ruled out.
>> Does anyone know if problem new in v5.7?  I am wondering if I introduced
>> this problem when I refactored the code or if I simply churned the code
>> but the issue remains effectively the same.
> It's not new issue, we see it in old kernel like v4.14
>>
>> Can you try only flushing entries when the last thread of the process is
>> reaped?  I think in practice we would want to be a little more
>> sophisticated but it is a good test case to see if it solves the issue.
>
> Thank you. i will try and let you know.

Assuming this works we can remove the hacking part of always doing
this by only doing this if SIGNAL_GROUP_EXIT when we know this
thundering herd will appear.

We still need to do something with the list however.

If your testing works out performance wise I will figure out what
we need to make the hack generale and safe.

Eric



> Thanks,
>
> Junxiao.
>
>>
>> diff --git a/kernel/exit.c b/kernel/exit.c
>> index cebae77a9664..d56e4eb60bdd 100644
>> --- a/kernel/exit.c
>> +++ b/kernel/exit.c
>> @@ -152,7 +152,7 @@ void put_task_struct_rcu_user(struct task_struct *task)
>>   void release_task(struct task_struct *p)
>>   {
>>   	struct task_struct *leader;
>> -	struct pid *thread_pid;
>> +	struct pid *thread_pid = NULL;
>>   	int zap_leader;
>>   repeat:
>>   	/* don't need to get the RCU readlock here - the process is dead and
>> @@ -165,7 +165,8 @@ void release_task(struct task_struct *p)
>>     	write_lock_irq(&tasklist_lock);
>>   	ptrace_release_task(p);
>> -	thread_pid = get_pid(p->thread_pid);
>> +	if (p == p->group_leader)
>> +		thread_pid = get_pid(p->thread_pid);
>>   	__exit_signal(p);
>>     	/*
>> @@ -188,8 +189,10 @@ void release_task(struct task_struct *p)
>>   	}
>>     	write_unlock_irq(&tasklist_lock);
>> -	proc_flush_pid(thread_pid);
>> -	put_pid(thread_pid);
>> +	if (thread_pid) {
>> +		proc_flush_pid(thread_pid);
>> +		put_pid(thread_pid);
>> +	}
>>   	release_thread(p);
>>   	put_task_struct_rcu_user(p);
>>   
