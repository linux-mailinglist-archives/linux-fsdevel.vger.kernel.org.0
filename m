Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B046D1C9DF8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 23:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgEGVy4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 May 2020 17:54:56 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:54760 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbgEGVy4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 May 2020 17:54:56 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jWoTl-0001hY-36; Thu, 07 May 2020 15:54:53 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jWoTX-0000BH-Io; Thu, 07 May 2020 15:54:52 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
        <87ftcei2si.fsf@x220.int.ebiederm.org>
        <202005051354.C7E2278688@keescook>
Date:   Thu, 07 May 2020 16:51:13 -0500
In-Reply-To: <202005051354.C7E2278688@keescook> (Kees Cook's message of "Tue,
        5 May 2020 14:29:21 -0700")
Message-ID: <87blmz8lda.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jWoTX-0000BH-Io;;;mid=<87blmz8lda.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/TffCfJjUwfPc36yFMkBlfQrVmC892J1g=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa07 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 810 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 12 (1.4%), b_tie_ro: 10 (1.2%), parse: 1.41
        (0.2%), extract_message_metadata: 19 (2.4%), get_uri_detail_list: 5
        (0.6%), tests_pri_-1000: 23 (2.8%), tests_pri_-950: 1.37 (0.2%),
        tests_pri_-900: 1.13 (0.1%), tests_pri_-90: 150 (18.6%), check_bayes:
        148 (18.2%), b_tokenize: 17 (2.0%), b_tok_get_all: 14 (1.7%),
        b_comp_prob: 4.4 (0.5%), b_tok_touch_all: 108 (13.3%), b_finish: 0.96
        (0.1%), tests_pri_0: 584 (72.2%), check_dkim_signature: 0.82 (0.1%),
        check_dkim_adsp: 2.3 (0.3%), poll_dns_idle: 0.32 (0.0%), tests_pri_10:
        2.1 (0.3%), tests_pri_500: 12 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 6/7] exec: Move most of setup_new_exec into flush_old_exec
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Tue, May 05, 2020 at 02:45:33PM -0500, Eric W. Biederman wrote:
>> 
>> The current idiom for the callers is:
>> 
>> flush_old_exec(bprm);
>> set_personality(...);
>> setup_new_exec(bprm);
>> 
>> In 2010 Linus split flush_old_exec into flush_old_exec and
>> setup_new_exec.  With the intention that setup_new_exec be what is
>> called after the processes new personality is set.
>> 
>> Move the code that doesn't depend upon the personality from
>> setup_new_exec into flush_old_exec.  This is to facilitate future
>> changes by having as much code together in one function as possible.
>
> Er, I *think* this is okay, but I have some questions below which
> maybe you already investigated (and should perhaps get called out in
> the changelog).

I intend to the following text to the changelog.  At this point I
believe I have read through everything and nothing raises any concerns
for me:

--- text begin ---

To see why it is safe to move this code please note that effectively
this change moves the personality setting in the binfmt and the following
three lines of code after everything except unlocking the mutexes:
        arch_pick_mmap_layout
        arch_setup_new_exec
        mm->task_size = TASK_SIZE

The function arch_pick_mmap_layout at most sets:
        mm->get_unmapped_area
        mm->mmap_base
        mm->mmap_legacy_base
        mm->mmap_compat_base
        mm->mmap_compat_legacy_base
which nothing in flush_old_exec or setup_new_exec depends on.

The function arch_setup_new_exec only sets architecture specific
state and the rest of the functions only deal in state that applies
to all architectures.

The last line just sets mm->task_size and again nothing in flush_old_exec
or setup_new_exec depend on task_size.

--- text end ---

>> 
>> Ref: 221af7f87b97 ("Split 'flush_old_exec' into two functions")
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>> ---
>>  fs/exec.c | 85 ++++++++++++++++++++++++++++---------------------------
>>  1 file changed, 44 insertions(+), 41 deletions(-)
>> 
>> diff --git a/fs/exec.c b/fs/exec.c
>> index 8c3abafb9bb1..0eff20558735 100644
>> --- a/fs/exec.c
>> +++ b/fs/exec.c
>> @@ -1359,39 +1359,7 @@ int flush_old_exec(struct linux_binprm * bprm)
>>  	 * undergoing exec(2).
>>  	 */
>>  	do_close_on_exec(me->files);
>> -	return 0;
>> -
>> -out_unlock:
>> -	mutex_unlock(&me->signal->exec_update_mutex);
>> -out:
>> -	return retval;
>> -}
>> -EXPORT_SYMBOL(flush_old_exec);
>> -
>> -void would_dump(struct linux_binprm *bprm, struct file *file)
>> -{
>> -	struct inode *inode = file_inode(file);
>> -	if (inode_permission(inode, MAY_READ) < 0) {
>> -		struct user_namespace *old, *user_ns;
>> -		bprm->interp_flags |= BINPRM_FLAGS_ENFORCE_NONDUMP;
>> -
>> -		/* Ensure mm->user_ns contains the executable */
>> -		user_ns = old = bprm->mm->user_ns;
>> -		while ((user_ns != &init_user_ns) &&
>> -		       !privileged_wrt_inode_uidgid(user_ns, inode))
>> -			user_ns = user_ns->parent;
>>  
>> -		if (old != user_ns) {
>> -			bprm->mm->user_ns = get_user_ns(user_ns);
>> -			put_user_ns(old);
>> -		}
>> -	}
>> -}
>> -EXPORT_SYMBOL(would_dump);
>> -
>> -void setup_new_exec(struct linux_binprm * bprm)
>> -{
>> -	struct task_struct *me = current;
>>  	/*
>>  	 * Once here, prepare_binrpm() will not be called any more, so
>>  	 * the final state of setuid/setgid/fscaps can be merged into the
>> @@ -1414,8 +1382,6 @@ void setup_new_exec(struct linux_binprm * bprm)
>>  			bprm->rlim_stack.rlim_cur = _STK_LIM;
>>  	}
>>  
>> -	arch_pick_mmap_layout(me->mm, &bprm->rlim_stack);
>> -
>>  	me->sas_ss_sp = me->sas_ss_size = 0;
>>  
>>  	/*
>> @@ -1430,16 +1396,9 @@ void setup_new_exec(struct linux_binprm * bprm)
>>  	else
>>  		set_dumpable(current->mm, SUID_DUMP_USER);
>>  
>> -	arch_setup_new_exec();
>>  	perf_event_exec();
>
> What is perf expecting to be able to examine at this point? Does it want
> a view of things after arch_setup_new_exec()? (i.e. "final" TIF flags,
> mmap layout, etc.) From what I can, the answer is "no, it's just
> resetting counters", so I think this is fine. Maybe double-check with
> Steve?

I can't find anything in the perf code that depends on
arch_pick_mmap_layout or mm->task_size.  So I don't have any concerns.
I have grepped through both kernel/events/ and arch/x86/events/ and
include/trace to double check and have nothing turned up.

I can't see the policy of where things will be allocated in the
memory map making any difference to perf.

Depending on what events actually are I can imagine then firing and
having issues as I can imagine an event to be just about anything
but I don't see a way to prevent that.  

I do see perf disabling events that are based on addresses.  I further
see perf enabling/disabling events that have already been computed.  I
see perf treating exec effectively as a process scheduling out and in.

Then finally I see perf shutting itself down on suid exec, and
generating some final perf events.  I have some concerns that is
a bit late, and that the test might not be quite right but nothing
particular to this change.

>>  	__set_task_comm(me, kbasename(bprm->filename), true);
>>  
>> -	/* Set the new mm task size. We have to do that late because it may
>> -	 * depend on TIF_32BIT which is only updated in flush_thread() on
>> -	 * some architectures like powerpc
>> -	 */
>> -	me->mm->task_size = TASK_SIZE;
>> -
>>  	/* An exec changes our domain. We are no longer part of the thread
>>  	   group */
>>  	WRITE_ONCE(me->self_exec_id, me->self_exec_id + 1);
>> @@ -1467,6 +1426,50 @@ void setup_new_exec(struct linux_binprm * bprm)
>>  	 * credentials; any time after this it may be unlocked.
>>  	 */
>>  	security_bprm_committed_creds(bprm);
>
> Similarly for the LSM hook: is it expecting a post-arch-setup view? I
> don't see anything looking at task_size, TIF flags, or anything else;
> they seem to be just cleaning up from the old process being replaced, so
> against, I think this is okay.

Nothing at all with the mm.  The LSM hooks close files and
muck with rlimits and signals, and tidy up their lsm state.

There are only 3 implementations apparmor, tomoyo and selinux
so it isn't too hard to read through them.

> Not visible in this patch, the following things how happen earlier,
> which I feel should maybe get called out in the changelog, with,
> perhaps, better justification than what I've got here:
>
> bprm->secureexec set/check (looks safe, since it depends on
> prepare_binprm()'s security_bprm_set_creds().
>
> rlim_stack.rlim_cur setting (safe, just needs to happen before
> arch_pick_mmap_layout())
>
> dumpable() check (looks safe, BINPRM_FLAGS_ENFORCE_NONDUMP depends on
> much earlier would_dump(), and uid/gid depend on earlier calls to
> prepare_binprm()'s bprm_fill_uid())
>
> __set_task_comm (looks safe, just dealing with the task name...)
>
> self_exec_id bump (looks safe, but I think -- it's still after uid
> setting)
>
> flush_signal_handlers() (looks safe -- nothing appears to depend on mm
> nor personality)

Agreed.

>> +	return 0;
>> +
>> +out_unlock:
>> +	mutex_unlock(&me->signal->exec_update_mutex);
>> +out:
>> +	return retval;
>> +}
>> +EXPORT_SYMBOL(flush_old_exec);
>> +
>> +void would_dump(struct linux_binprm *bprm, struct file *file)
>> +{
>> +	struct inode *inode = file_inode(file);
>> +	if (inode_permission(inode, MAY_READ) < 0) {
>> +		struct user_namespace *old, *user_ns;
>> +		bprm->interp_flags |= BINPRM_FLAGS_ENFORCE_NONDUMP;
>> +
>> +		/* Ensure mm->user_ns contains the executable */
>> +		user_ns = old = bprm->mm->user_ns;
>> +		while ((user_ns != &init_user_ns) &&
>> +		       !privileged_wrt_inode_uidgid(user_ns, inode))
>> +			user_ns = user_ns->parent;
>> +
>> +		if (old != user_ns) {
>> +			bprm->mm->user_ns = get_user_ns(user_ns);
>> +			put_user_ns(old);
>> +		}
>> +	}
>> +}
>> +EXPORT_SYMBOL(would_dump);
>
> The diff helpfully decided this moved would_dump(). ;) Is it worth
> maybe just moviing it explicitly above flush_old_exec() to avoid this
> churn? I dunno.

Given the amount of review and testing that has been put in at
this point I don't think so.

>> +
>> +void setup_new_exec(struct linux_binprm * bprm)
>> +{
>> +	/* Setup things that can depend upon the personality */
>
> Should this comment be above the function instead?

My experience has been that comments above functions unless they are in
full linuxdoc tend to be less well maintained than comments within the
function itself.  So I don't think it is worth moving.x

>> +	struct task_struct *me = current;
>> +
>> +	arch_pick_mmap_layout(me->mm, &bprm->rlim_stack);
>> +
>> +	arch_setup_new_exec();
>> +
>> +	/* Set the new mm task size. We have to do that late because it may
>> +	 * depend on TIF_32BIT which is only updated in flush_thread() on
>> +	 * some architectures like powerpc
>> +	 */
>> +	me->mm->task_size = TASK_SIZE;
>>  	mutex_unlock(&me->signal->exec_update_mutex);
>>  	mutex_unlock(&me->signal->cred_guard_mutex);
>>  }
>> -- 
>> 2.20.1
>> 
>
> So, as I say, I *think* this is okay, but I always get suspicious about
> reordering things in execve(). ;)
>
> So, with a bit larger changelog discussing what's moving "earlier",
> I think this looks good:

Please see above.

Eric
