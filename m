Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB3FC2A488B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 15:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbgKCOrS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 09:47:18 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:46146 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbgKCOpZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 09:45:25 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kZxYp-002xC6-Om; Tue, 03 Nov 2020 07:45:23 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kZxYo-009i9o-Gg; Tue, 03 Nov 2020 07:45:23 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Qian Cai <cai@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201030152407.43598-1-cai@redhat.com>
        <20201030184255.GP3576660@ZenIV.linux.org.uk>
        <ad9357e9-8364-a316-392d-7504af614cac@kernel.dk>
        <20201030184918.GQ3576660@ZenIV.linux.org.uk>
        <d858ba48-624f-43be-93cf-07d94f0ebefd@kernel.dk>
        <20201030222213.GR3576660@ZenIV.linux.org.uk>
        <a1e17902-a204-f03d-2a51-469633eca751@kernel.dk>
        <87eelba7ai.fsf@x220.int.ebiederm.org>
        <f33a6b5e-ecc9-2bef-ab40-6bd8cc2030c2@kernel.dk>
        <87k0v38qlw.fsf@x220.int.ebiederm.org>
        <d77e2d82-22da-a7a0-54e0-f5d315f32a75@kernel.dk>
        <3abc1742-733e-c682-5476-c6337a630e05@kernel.dk>
Date:   Tue, 03 Nov 2020 08:45:21 -0600
In-Reply-To: <3abc1742-733e-c682-5476-c6337a630e05@kernel.dk> (Jens Axboe's
        message of "Mon, 2 Nov 2020 14:39:32 -0700")
Message-ID: <87mtzy7b3y.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kZxYo-009i9o-Gg;;;mid=<87mtzy7b3y.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18vnl8MzKekN9Gx+3u0DKOS0AFAE+He3Vg=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,T_TooManySym_03,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4996]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Jens Axboe <axboe@kernel.dk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 523 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (2.0%), b_tie_ro: 9 (1.8%), parse: 0.96 (0.2%),
         extract_message_metadata: 13 (2.6%), get_uri_detail_list: 3.0 (0.6%),
        tests_pri_-1000: 4.6 (0.9%), tests_pri_-950: 1.28 (0.2%),
        tests_pri_-900: 0.98 (0.2%), tests_pri_-90: 101 (19.4%), check_bayes:
        99 (19.0%), b_tokenize: 11 (2.1%), b_tok_get_all: 12 (2.3%),
        b_comp_prob: 3.8 (0.7%), b_tok_touch_all: 68 (13.1%), b_finish: 0.94
        (0.2%), tests_pri_0: 375 (71.6%), check_dkim_signature: 0.55 (0.1%),
        check_dkim_adsp: 2.1 (0.4%), poll_dns_idle: 0.50 (0.1%), tests_pri_10:
        2.0 (0.4%), tests_pri_500: 10 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH -next] fs: Fix memory leaks in do_renameat2() error paths
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> On 11/2/20 1:31 PM, Jens Axboe wrote:
>> On 11/2/20 1:12 PM, Eric W. Biederman wrote:
>>> Jens Axboe <axboe@kernel.dk> writes:
>>>
>>>> On 11/2/20 12:27 PM, Eric W. Biederman wrote:
>>>>> Jens Axboe <axboe@kernel.dk> writes:
>>>>>
>>>>>> On 10/30/20 4:22 PM, Al Viro wrote:
>>>>>>> On Fri, Oct 30, 2020 at 02:33:11PM -0600, Jens Axboe wrote:
>>>>>>>> On 10/30/20 12:49 PM, Al Viro wrote:
>>>>>>>>> On Fri, Oct 30, 2020 at 12:46:26PM -0600, Jens Axboe wrote:
>>>>>>>>>
>>>>>>>>>> See other reply, it's being posted soon, just haven't gotten there yet
>>>>>>>>>> and it wasn't ready.
>>>>>>>>>>
>>>>>>>>>> It's a prep patch so we can call do_renameat2 and pass in a filename
>>>>>>>>>> instead. The intent is not to have any functional changes in that prep
>>>>>>>>>> patch. But once we can pass in filenames instead of user pointers, it's
>>>>>>>>>> usable from io_uring.
>>>>>>>>>
>>>>>>>>> You do realize that pathname resolution is *NOT* offloadable to helper
>>>>>>>>> threads, I hope...
>>>>>>>>
>>>>>>>> How so? If we have all the necessary context assigned, what's preventing
>>>>>>>> it from working?
>>>>>>>
>>>>>>> Semantics of /proc/self/..., for starters (and things like /proc/mounts, etc.
>>>>>>> *do* pass through that, /dev/stdin included)
>>>>>>
>>>>>> Don't we just need ->thread_pid for that to work?
>>>>>
>>>>> No.  You need ->signal.
>>>>>
>>>>> You need ->signal->pids[PIDTYPE_TGID].  It is only for /proc/thread-self
>>>>> that ->thread_pid is needed.
>>>>>
>>>>> Even more so than ->thread_pid, it is a kernel invariant that ->signal
>>>>> does not change.
>>>>
>>>> I don't care about the pid itself, my suggestion was to assign ->thread_pid
>>>> over the lookup operation to ensure that /proc/self/ worked the way that
>>>> you'd expect.
>>>
>>> I understand that.
>>>
>>> However /proc/self/ refers to the current process not to the current
>>> thread.  So ->thread_pid is not what you need to assign to make that
>>> happen.  What the code looks at is: ->signal->pids[PIDTYPE_TGID].
>>>
>>> It will definitely break invariants to assign to ->signal.
>>>
>>> Currently only exchange_tids assigns ->thread_pid and it is nasty.  It
>>> results in code that potentially results in infinite loops in
>>> kernel/signal.c
>>>
>>> To my knowledge nothing assigns ->signal->pids[PIDTYPE_TGID].  At best
>>> it might work but I expect the it would completely confuse something in
>>> the pid to task or pid to process mappings.  Which is to say even if it
>>> does work it would be an extremely fragile solution.
>> 
>> Thanks Eric, that's useful. Sounds to me like we're better off, at least
>> for now, to just expressly forbid async lookup of /proc/self/. Which
>> isn't really the end of the world as far as I'm concerned.
>
> Alternatively, we just teach task_pid_ptr() where to look for an
> alternate, if current->flags & PF_IO_WORKER is true. Then we don't have
> to assign anything that's visible in task_struct, and in fact the async
> worker can retain this stuff on the stack. As all requests are killed
> before a task is allowed to exit, that should be safe.

That seems assumes task_pid_ptr is always called on current.

When you are looking at the task through the proc filesystem you want
things like /proc/<pid>/stat and /proc/<pid>/status to be able to
display the pids without problem.  More than that it is desirable that
readdir does not get the view for the PF_IO_WORKER.

> diff --git a/kernel/pid.c b/kernel/pid.c
> index 74ddbff1a6ba..5fd421a4864c 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -42,6 +42,7 @@
>  #include <linux/sched/signal.h>
>  #include <linux/sched/task.h>
>  #include <linux/idr.h>
> +#include <linux/io_uring.h>
>  #include <net/sock.h>
>  #include <uapi/linux/pidfd.h>
>  
> @@ -320,6 +321,12 @@ EXPORT_SYMBOL_GPL(find_vpid);
>  
>  static struct pid **task_pid_ptr(struct task_struct *task, enum pid_type type)
>  {
> +	if ((task->flags & PF_IO_WORKER) && task->io_uring) {
> +		return (type == PIDTYPE_PID) ?
> +			&task->io_uring->thread_pid :
> +			&task->io_uring->pids[type];
> +	}
> +
>  	return (type == PIDTYPE_PID) ?
>  		&task->thread_pid :
>  		&task->signal->pids[type];

The only thing I can think of that might work convincingly is to split
get_current() into two functions get_context() and get_task().  Maybe
accessed as current_context and current_task.

With get_context() returning just a pointer to the fields that are safe
to use in io_uring, and get_task returning the other fields.

With exit and exec invaliding the pending work on the contexts it should
be safe to just return a pointer to the context that invoked io_uring.
Data in the context would either need to be read-only or be modified
and read in a multi-thread safe way.

The rest of the data in the task_struct by default could be assume it is
only modified by the task.

That would give type-safety and something avoids playing whack-a-mole
with every new piece of context that userspace accesses.

Eric


