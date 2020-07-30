Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 558982332DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 15:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgG3NUB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 09:20:01 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:60244 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgG3NUA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 09:20:00 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k18TV-001hYM-SG; Thu, 30 Jul 2020 07:19:57 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k18TU-0007zo-T5; Thu, 30 Jul 2020 07:19:57 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>, Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux PM <linux-pm@vger.kernel.org>
References: <87h7tsllgw.fsf@x220.int.ebiederm.org>
        <CAHk-=wj34Pq1oqFVg1iWYAq_YdhCyvhyCYxiy-CG-o76+UXydQ@mail.gmail.com>
        <87d04fhkyz.fsf@x220.int.ebiederm.org>
        <87h7trg4ie.fsf@x220.int.ebiederm.org>
        <CAHk-=wj+ynePRJC3U5Tjn+ZBRAE3y7=anc=zFhL=ycxyKP8BxA@mail.gmail.com>
Date:   Thu, 30 Jul 2020 08:16:47 -0500
In-Reply-To: <CAHk-=wj+ynePRJC3U5Tjn+ZBRAE3y7=anc=zFhL=ycxyKP8BxA@mail.gmail.com>
        (Linus Torvalds's message of "Tue, 28 Jul 2020 11:17:02 -0700")
Message-ID: <878sf16t34.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1k18TU-0007zo-T5;;;mid=<878sf16t34.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+4iyqqlziCrqY6rMi+7pSSsAUb0ivNwK0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4952]
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa07 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 639 ms - load_scoreonly_sql: 0.12 (0.0%),
        signal_user_changed: 11 (1.7%), b_tie_ro: 10 (1.5%), parse: 1.23
        (0.2%), extract_message_metadata: 17 (2.7%), get_uri_detail_list: 3.5
        (0.6%), tests_pri_-1000: 24 (3.8%), tests_pri_-950: 1.31 (0.2%),
        tests_pri_-900: 1.05 (0.2%), tests_pri_-90: 122 (19.2%), check_bayes:
        119 (18.7%), b_tokenize: 13 (2.1%), b_tok_get_all: 11 (1.8%),
        b_comp_prob: 4.7 (0.7%), b_tok_touch_all: 84 (13.2%), b_finish: 1.07
        (0.2%), tests_pri_0: 441 (69.0%), check_dkim_signature: 0.58 (0.1%),
        check_dkim_adsp: 2.5 (0.4%), poll_dns_idle: 0.37 (0.1%), tests_pri_10:
        3.3 (0.5%), tests_pri_500: 12 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC][PATCH] exec: Freeze the other threads during a multi-threaded exec
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, Jul 28, 2020 at 6:23 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> For exec all I care about are user space threads.  So it appears the
>> freezer infrastructure adds very little.
>
> Yeah. 99% of the freezer stuff is for just adding the magic notations
> for kernel threads, and for any user space threads it seems the wrong
> interface.
>
>> Now to see if I can find another way to divert a task into a slow path
>> as it wakes up, so I don't need to manually wrap all of the sleeping
>> calls.  Something that plays nice with the scheduler.
>
> The thing is, how many places really care?
>
> Because I think there are like five of them. And they are all marked
> by taking cred_guard_mutex, or the file table lock.
>
> So it seems really excessive to then create some whole new "let's
> serialize every thread", when you actually don't care about any of it,
> except for a couple of very very special cases.
>
> If you care about "thread count stable", you care about exit() and
> clone().  You don't care about threads that are happily running - or
> sleeping - doing their own thing.
>
> So trying to catch those threads and freezing them really feels like
> entirely the wrong interface.

For me stopping the other threads has been a conceptually simple
direction that needs exploration even if it doesn't work out.

On that note I have something that is just a little longer than the
patch I posted that doesn't use the freezer, and leans on the fact that
TASK_INTERRUPTBLE and TASK_KILLABLE can occassionaly expect a spurious
wake up.  Which means (with the right locking) those two states
can be transformed into TASK_WAKEKILL to keep sleeping processes
sleeping.

After that I only need one small test in get_signal to catch the
unlikely case of processes running in userspace.

I have not figured out TASK_STOPPED or TASK_TRACED yet as they do
not handle spurious wake ups.

So I think I can stop and keep stopped the other threads in the group
without too much code or complexity for other parts of the kernel
(assuming spurious wakes ups are allowed).




Even with the other threads stopped the code does not simplify as
much as I had hoped.  The code still has to deal with the existence
of the other threads.  So while races don't happen and thus the code
is easier to understand and make correct the actual work of walking
the threads making a count etc still remains.



The real sticky widget right now is the unshare_files call.  When Al
moved the call in fd8328be874f ("[PATCH] sanitize handling of shared
descriptor tables in failing execve()") it introduced a regression that
causes posix file locks to be improperly removed during exec.
Unfortunately no one noticed for about a decade.

What caused the regression is that unshare_files is a noop if the usage
count is 1.  Which means that after de_thread unshare_files only does
something if our file table is shared by another process.  However when
unshare_files is called before de_thread in a multi-threaded process
unshare_files will always perform work.

For the locks that set fl_owner to current->files unsharing
current->files when unnecessary already causes problems, as we now
have an unnecessary change of owner during exec.

After the unnecessary change in owner the existing locks are
eventually removed at the end of bprm_execve:
    bprm_execve()
       if (displaced)
           put_files_struct(displaced)
              filp_close()
                 locks_remove_posix()
                    /* Which removes the posix locks */



After 12 years moving unshare_files back where it used to be is
also problematic, as with the addition of execveat we grew
a clear dependency other threads not messing with our open files:

	/*
	 * Record that a name derived from an O_CLOEXEC fd will be
	 * inaccessible after exec. Relies on having exclusive access to
	 * current->files (due to unshare_files above).
	 */
	if (bprm->fdpath &&
	    close_on_exec(fd, rcu_dereference_raw(current->files->fdt)))
		bprm->interp_flags |= BINPRM_FLAGS_PATH_INACCESSIBLE;


I have made a cursory look and I don't expect any other issues as the
only code in exec that messes with file descriptors is in fs/exec.c
Everything else simply uses "struct file *".


Testing to see if the file descriptor is close_on_exec is just there to
prevent trying to run a script that through a close_on_exec file
descriptor, that is part of the path to the script.  So it is a quality
of implementation issue so the code does not fail later if userspace
tries something silly.

So I think we can safely just update the comment and say if userspace
messes with the file descriptor they pass to exec during exec userspace
can keep both pieces, as it is a self inflicted problem.

All of the other issues I see with reverting the location where the file
table is unshared also look like userspace shooting themselves in the
foot and not a problem with correctness of kernel code.

Which is a long way of saying that I have just convinced myself to
effectively revert fd8328be874f ("[PATCH] sanitize handling of shared
descriptor tables in failing execve()") 

A memory allocation failure after the point of no return is the only
reason to avoid doing this, and since the unshare is expected to
be a noop most of the time that doesn't look like a downside either.


Assuming I don't find anything else I think I will kick down the road
a bit the problem of stopping other threads during exec.  I can handle
unshare_files and seccomp without it.  There still might be something
I can not solve another way, but until I find it I will put this on the
back burner.

Eric

