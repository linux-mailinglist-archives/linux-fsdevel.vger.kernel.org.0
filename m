Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE821BA303
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 13:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgD0L47 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 07:56:59 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:42662 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgD0L46 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 07:56:58 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jT2Nc-0005LR-I5; Mon, 27 Apr 2020 05:56:56 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jT2Nb-000812-3T; Mon, 27 Apr 2020 05:56:56 -0600
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
        <87h7x6mj6h.fsf_-_@x220.int.ebiederm.org>
        <87368ps1ql.fsf@nanos.tec.linutronix.de>
Date:   Mon, 27 Apr 2020 06:53:42 -0500
In-Reply-To: <87368ps1ql.fsf@nanos.tec.linutronix.de> (Thomas Gleixner's
        message of "Mon, 27 Apr 2020 11:43:14 +0200")
Message-ID: <87zhaxi1q1.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jT2Nb-000812-3T;;;mid=<87zhaxi1q1.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+es43Xm7YLhAh5+wwr1PPIMlgGfoou5is=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMGappySubj_01,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.5 XMGappySubj_01 Very gappy subject
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Thomas Gleixner <tglx@linutronix.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1031 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.5 (0.4%), b_tie_ro: 3.1 (0.3%), parse: 1.13
        (0.1%), extract_message_metadata: 15 (1.5%), get_uri_detail_list: 2.2
        (0.2%), tests_pri_-1000: 12 (1.2%), tests_pri_-950: 0.97 (0.1%),
        tests_pri_-900: 0.81 (0.1%), tests_pri_-90: 256 (24.9%), check_bayes:
        254 (24.7%), b_tokenize: 6 (0.6%), b_tok_get_all: 6 (0.6%),
        b_comp_prob: 1.41 (0.1%), b_tok_touch_all: 238 (23.1%), b_finish: 0.76
        (0.1%), tests_pri_0: 239 (23.2%), check_dkim_signature: 0.39 (0.0%),
        check_dkim_adsp: 2.8 (0.3%), poll_dns_idle: 474 (46.0%), tests_pri_10:
        2.1 (0.2%), tests_pri_500: 496 (48.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v3 1/6] posix-cpu-timers: Always call __get_task_for_clock holding rcu_read_lock
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

> ebiederm@xmission.com (Eric W. Biederman) writes:
>
>> This allows the getref flag to be removed and the callers can
>> than take a task reference if needed.
>
> That changelog lacks any form of information why this should be
> changed. I can see the point vs. patch 2, but pretty please put coherent
> explanations into each patch.

Well excess flags bad.  But in this case I can do even better.

The code no longer takes a reference on task_struct so this patch
removes unnecessary code.

I will see if I can say that better.



>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>> ---
>>  kernel/time/posix-cpu-timers.c | 41 +++++++++++++++++-----------------
>>  1 file changed, 21 insertions(+), 20 deletions(-)
>>
>> diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
>> index 2fd3b3fa68bf..eba41c70f0f0 100644
>> --- a/kernel/time/posix-cpu-timers.c
>> +++ b/kernel/time/posix-cpu-timers.c
>> @@ -86,36 +86,34 @@ static struct task_struct *lookup_task(const pid_t pid, bool thread,
>>  }
>>  
>>  static struct task_struct *__get_task_for_clock(const clockid_t clock,
>> -						bool getref, bool gettime)
>> +						bool gettime)
>>  {
>>  	const bool thread = !!CPUCLOCK_PERTHREAD(clock);
>>  	const pid_t pid = CPUCLOCK_PID(clock);
>> -	struct task_struct *p;
>>  
>>  	if (CPUCLOCK_WHICH(clock) >= CPUCLOCK_MAX)
>>  		return NULL;
>>  
>> -	rcu_read_lock();
>> -	p = lookup_task(pid, thread, gettime);
>> -	if (p && getref)
>> -		get_task_struct(p);
>> -	rcu_read_unlock();
>> -	return p;
>> +	return lookup_task(pid, thread, gettime);
>>  }
>>  
>>  static inline struct task_struct *get_task_for_clock(const clockid_t clock)
>>  {
>> -	return __get_task_for_clock(clock, true, false);
>> +	return __get_task_for_clock(clock, false);
>>  }
>>  
>>  static inline struct task_struct *get_task_for_clock_get(const clockid_t clock)
>>  {
>> -	return __get_task_for_clock(clock, true, true);
>> +	return __get_task_for_clock(clock, true);
>>  }
>>  
>>  static inline int validate_clock_permissions(const clockid_t clock)
>>  {
>> -	return __get_task_for_clock(clock, false, false) ? 0 : -EINVAL;
>> +	int ret;
>
> New line between declarations and code please.
>
>> +	rcu_read_lock();
>> +	ret = __get_task_for_clock(clock, false) ? 0 : -EINVAL;
>> +	rcu_read_unlock();
>> +	return ret;
>>  }
>
> Thanks,
>
>         tglx
