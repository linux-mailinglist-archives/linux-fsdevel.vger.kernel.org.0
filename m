Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E95F1BAE76
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 21:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgD0TuP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 15:50:15 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:53344 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbgD0TuP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 15:50:15 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jT9lX-0006L6-BZ; Mon, 27 Apr 2020 13:50:07 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jT9lV-0003xk-91; Mon, 27 Apr 2020 13:50:07 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
References: <20200419141057.621356-1-gladkov.alexey@gmail.com>
        <87ftcv1nqe.fsf@x220.int.ebiederm.org>
        <87wo66vvnm.fsf_-_@x220.int.ebiederm.org>
        <20200424173927.GB26802@redhat.com>
        <87mu6ymkea.fsf_-_@x220.int.ebiederm.org>
        <87blnemj5t.fsf_-_@x220.int.ebiederm.org>
        <87zhaxqkwa.fsf@nanos.tec.linutronix.de>
Date:   Mon, 27 Apr 2020 14:46:51 -0500
In-Reply-To: <87zhaxqkwa.fsf@nanos.tec.linutronix.de> (Thomas Gleixner's
        message of "Mon, 27 Apr 2020 12:32:21 +0200")
Message-ID: <87a72wd844.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jT9lV-0003xk-91;;;mid=<87a72wd844.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18j5AH/+MVgbJoMSFliM5bTtu8iUZh+Nco=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4893]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Thomas Gleixner <tglx@linutronix.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1680 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 11 (0.7%), b_tie_ro: 10 (0.6%), parse: 1.58
        (0.1%), extract_message_metadata: 23 (1.3%), get_uri_detail_list: 3.6
        (0.2%), tests_pri_-1000: 22 (1.3%), tests_pri_-950: 1.83 (0.1%),
        tests_pri_-900: 1.48 (0.1%), tests_pri_-90: 329 (19.6%), check_bayes:
        327 (19.4%), b_tokenize: 9 (0.5%), b_tok_get_all: 147 (8.8%),
        b_comp_prob: 2.7 (0.2%), b_tok_touch_all: 163 (9.7%), b_finish: 0.93
        (0.1%), tests_pri_0: 333 (19.8%), check_dkim_signature: 1.31 (0.1%),
        check_dkim_adsp: 2.6 (0.2%), poll_dns_idle: 932 (55.5%), tests_pri_10:
        2.0 (0.1%), tests_pri_500: 951 (56.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v3 2/6] posix-cpu-timers: Use PIDTYPE_TGID to simplify the logic in lookup_task
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

> ebiederm@xmission.com (Eric W. Biederman) writes:
>> Using pid_task(find_vpid(N), PIDTYPE_TGID) guarantees that if a task
>> is found it is at that moment the thread group leader.  Which removes
>> the need for the follow on test has_group_leader_pid.
>>
>> I have reorganized the rest of the code in lookup_task for clarity,
>> and created a common return for most of the code.
>
> Sorry, it's way harder to read than the very explicit exits which were
> there before.

My biggest gripe is the gettime and the ordinary !thread case should
be sharing code and they are not.  I know historically why they don't
but for all practical purposes has_group_leader_pid and
thread_group_leader are the same test.


>> The special case for clock_gettime with "pid == gettid" is not my
>> favorite.  I strongly suspect it isn't used as gettid is such a pain,
>> and passing 0 is much easier.  Still it is easier to keep this special
>> case than to do the reasarch that will show it isn't used.
>
> It might be not your favorite, but when I refactored the code I learned
> the hard way that one of the test suites has assumptions that
> clock_gettime(PROCESS) works from any task of a group and not just for
> the group leader. Sure we could fix the test suite, but test code tends
> to be copied ...

Do you know which test suite?
It would be nice to see such surprising code with my own eyes.

I completely agree that clock_gettime(PROCESS) should work for any task
of a group.  I would think anything with a constant like that would just
be passing in 0, which is trivial.  Looking up your threadid seems like
extra work.

Mostly my complaint is that the gettime subcase is an awkward special
case.  Added in 33ab0fec3352 ("posix-timers: Consolidate
posix_cpu_clock_get()") and the only justification for changing the
userspace ABI was that it made things less awkward to combine to
branches of code.

>>  /*
>>   * Functions for validating access to tasks.
>>   */
>> -static struct task_struct *lookup_task(const pid_t pid, bool thread,
>> +static struct task_struct *lookup_task(const pid_t which_pid, bool thread,
>>  				       bool gettime)
>>  {
>>  	struct task_struct *p;
>> +	struct pid *pid;
>>  
>>  	/*
>>  	 * If the encoded PID is 0, then the timer is targeted at current
>>  	 * or the process to which current belongs.
>>  	 */
>> -	if (!pid)
>> +	if (!which_pid)
>>  		return thread ? current : current->group_leader;
>>  
>> -	p = find_task_by_vpid(pid);
>> -	if (!p)
>> -		return p;
>> -
>> -	if (thread)
>> -		return same_thread_group(p, current) ? p : NULL;
>> -
>> -	if (gettime) {
>> +	pid = find_vpid(which_pid);
>> +	if (thread) {
>> +		p = pid_task(pid, PIDTYPE_PID);
>> +		if (p && !same_thread_group(p, current))
>> +			p = NULL;
>> +	} else {
>>  		/*
>>  		 * For clock_gettime(PROCESS) the task does not need to be
>>  		 * the actual group leader. tsk->sighand gives
>> @@ -76,13 +75,13 @@ static struct task_struct *lookup_task(const pid_t pid, bool thread,
>>  		 * reference on it and store the task pointer until the
>>  		 * timer is destroyed.
>
> Btw, this comment is wrong since
>
>      55e8c8eb2c7b ("posix-cpu-timers: Store a reference to a pid not a task")

It is definitely stale.  It continues to describe the motive for
limiting ourselves to a thread_group_leader.

I am cooking up a patch to tweak that comment, and get replace of
has_group_leader_pid.  Since it is unnecessary I just want to decouple
that work from this patchset.

Eric


