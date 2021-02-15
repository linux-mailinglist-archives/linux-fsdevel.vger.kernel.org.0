Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0F3F31C41B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Feb 2021 23:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhBOWnY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Feb 2021 17:43:24 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:47994 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhBOWnW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Feb 2021 17:43:22 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lBmZk-00CzWI-4n; Mon, 15 Feb 2021 15:42:40 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lBmZh-00HRe0-SB; Mon, 15 Feb 2021 15:42:39 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20201214191323.173773-1-axboe@kernel.dk>
        <m1lfbrwrgq.fsf@fess.ebiederm.org>
        <94731b5a-a83e-91b5-bc6c-6fd4aaacb704@kernel.dk>
        <CAHk-=wiZuX-tyhR6rRxDfQOvyRkCVZjv0DCg1pHBUmzRZ_f1bQ@mail.gmail.com>
        <m11rdhurvp.fsf@fess.ebiederm.org>
        <e9ba3d6c-ee1f-6491-e7a9-56f4d7a167a3@kernel.dk>
        <e3335211-83f2-5305-9601-663cc2a73427@kernel.dk>
Date:   Mon, 15 Feb 2021 16:41:55 -0600
In-Reply-To: <e3335211-83f2-5305-9601-663cc2a73427@kernel.dk> (Jens Axboe's
        message of "Mon, 15 Feb 2021 14:09:19 -0700")
Message-ID: <m1r1lht0lo.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lBmZh-00HRe0-SB;;;mid=<m1r1lht0lo.fsf@fess.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18ziSVJba5dIDfAS7E4xFfM2N4s8/gHYaI=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,T_TooManySym_03,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4990]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Jens Axboe <axboe@kernel.dk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 508 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.6 (0.7%), b_tie_ro: 2.5 (0.5%), parse: 0.73
        (0.1%), extract_message_metadata: 13 (2.5%), get_uri_detail_list: 2.3
        (0.5%), tests_pri_-1000: 5.0 (1.0%), tests_pri_-950: 0.99 (0.2%),
        tests_pri_-900: 0.80 (0.2%), tests_pri_-90: 113 (22.3%), check_bayes:
        105 (20.7%), b_tokenize: 8 (1.6%), b_tok_get_all: 11 (2.1%),
        b_comp_prob: 2.6 (0.5%), b_tok_touch_all: 81 (16.0%), b_finish: 0.57
        (0.1%), tests_pri_0: 360 (70.9%), check_dkim_signature: 0.42 (0.1%),
        check_dkim_adsp: 9 (1.8%), poll_dns_idle: 0.16 (0.0%), tests_pri_10:
        1.64 (0.3%), tests_pri_500: 6 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCHSET v3 0/4] fs: Support for LOOKUP_NONBLOCK / RESOLVE_NONBLOCK (Insufficiently faking current?)
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> On 2/15/21 11:24 AM, Jens Axboe wrote:
>> On 2/15/21 11:07 AM, Eric W. Biederman wrote:
>>> Linus Torvalds <torvalds@linux-foundation.org> writes:
>>>
>>>> On Sun, Feb 14, 2021 at 8:38 AM Jens Axboe <axboe@kernel.dk> wrote:
>>>>>
>>>>>> Similarly it looks like opening of "/dev/tty" fails to
>>>>>> return the tty of the caller but instead fails because
>>>>>> io-wq threads don't have a tty.
>>>>>
>>>>> I've got a patch queued up for 5.12 that clears ->fs and ->files for the
>>>>> thread if not explicitly inherited, and I'm working on similarly
>>>>> proactively catching these cases that could potentially be problematic.
>>>>
>>>> Well, the /dev/tty case still needs fixing somehow.
>>>>
>>>> Opening /dev/tty actually depends on current->signal, and if it is
>>>> NULL it will fall back on the first VT console instead (I think).
>>>>
>>>> I wonder if it should do the same thing /proc/self does..
>>>
>>> Would there be any downside of making the io-wq kernel threads be per
>>> process instead of per user?
>>>
>>> I can see a lower probability of a thread already existing.  Are there
>>> other downsides I am missing?
>>>
>>> The upside would be that all of the issues of have we copied enough
>>> should go away, as the io-wq thread would then behave like another user
>>> space thread.  To handle posix setresuid() and friends it looks like
>>> current_cred would need to be copied but I can't think of anything else.
>> 
>> I really like that idea. Do we currently have a way of creating a thread
>> internally, akin to what would happen if the same task did pthread_create?
>> That'd ensure that we have everything we need, without actively needing to
>> map the request types, or find future issues of "we also need this bit".
>> It'd work fine for the 'need new worker' case too, if one goes to sleep.
>> We'd just 'fork' off that child.
>> 
>> Would require some restructuring of io-wq, but at the end of it, it'd
>> be a simpler solution.
>
> I was intrigued enough that I tried to wire this up. If we can pull this
> off, then it would take a great weight off my shoulders as there would
> be no more worries on identity.
>
> Here's a branch that's got a set of patches that actually work, though
> it's a bit of a hack in spots. Notes:
>
> - Forked worker initially crashed, since it's an actual user thread and
>   bombed on deref of kernel structures. Expectedly. That's what the
>   horrible kernel_clone_args->io_wq hack is working around for now.
>   Obviously not the final solution, but helped move things along so
>   I could actually test this.
>
> - Shared io-wq helpers need indexing for task, right now this isn't
>   done. But that's not hard to do.
>
> - Idle thread reaping isn't done yet, so they persist until the
>   context goes away.
>
> - task_work fallback needs a bit of love. Currently we fallback to
>   the io-wq manager thread for handling that, but a) manager is gone,
>   and b) the new workers are now threads and go away as well when
>   the original task goes away. None of the three fallback sites need
>   task context, so likely solution here is just punt it to system_wq.
>   Not the hot path, obviously, we're exiting.
>
> - Personality registration is broken, it's just Good Enough to compile.
>
> Probably a few more items that escape me right now. As long as you
> don't hit the fallback cases, it appears to work fine for me. And
> the diffstat is pretty good to:
>
>  fs/io-wq.c                 | 418 +++++++++++--------------------------
>  fs/io-wq.h                 |  10 +-
>  fs/io_uring.c              | 314 +++-------------------------
>  fs/proc/self.c             |   7 -
>  fs/proc/thread_self.c      |   7 -
>  include/linux/io_uring.h   |  19 --
>  include/linux/sched.h      |   3 +
>  include/linux/sched/task.h |   1 +
>  kernel/fork.c              |   2 +
>  9 files changed, 161 insertions(+), 620 deletions(-)
>
> as it gets rid of _all_ the 'grab this or that piece' that we're
> tracking.
>
> WIP series here:
>
> https://git.kernel.dk/cgit/linux-block/log/?h=io_uring-worker

I took a quick look through the code and in general it seems reasonable.

Can the io_uring_task_cancel in begin_new_exec go away as well?
Today it happens after de_thread and so presumably all of the io_uring
threads are already gone.

Eric
