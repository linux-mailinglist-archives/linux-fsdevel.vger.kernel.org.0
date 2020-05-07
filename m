Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7CFB1C9B6B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 21:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbgEGTzX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 May 2020 15:55:23 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:59462 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbgEGTzW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 May 2020 15:55:22 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jWmby-0000uY-Rr; Thu, 07 May 2020 13:55:14 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jWmby-00073f-0p; Thu, 07 May 2020 13:55:14 -0600
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
        <87368ddsc9.fsf@x220.int.ebiederm.org>
        <202005060829.A09C366D0@keescook>
Date:   Thu, 07 May 2020 14:51:47 -0500
In-Reply-To: <202005060829.A09C366D0@keescook> (Kees Cook's message of "Wed, 6
        May 2020 08:30:33 -0700")
Message-ID: <87d07fa5gs.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jWmby-00073f-0p;;;mid=<87d07fa5gs.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19ux5x0eTpmQ6FRkwXIaJ6ku+USAj9wB9Q=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4998]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa04 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 462 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 11 (2.4%), b_tie_ro: 10 (2.1%), parse: 0.93
        (0.2%), extract_message_metadata: 15 (3.2%), get_uri_detail_list: 2.1
        (0.5%), tests_pri_-1000: 5 (1.1%), tests_pri_-950: 1.21 (0.3%),
        tests_pri_-900: 0.96 (0.2%), tests_pri_-90: 87 (18.8%), check_bayes:
        85 (18.4%), b_tokenize: 8 (1.8%), b_tok_get_all: 8 (1.8%),
        b_comp_prob: 2.8 (0.6%), b_tok_touch_all: 61 (13.2%), b_finish: 1.30
        (0.3%), tests_pri_0: 328 (70.9%), check_dkim_signature: 0.66 (0.1%),
        check_dkim_adsp: 2.3 (0.5%), poll_dns_idle: 0.50 (0.1%), tests_pri_10:
        2.2 (0.5%), tests_pri_500: 7 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 6/7] exec: Move most of setup_new_exec into flush_old_exec
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Wed, May 06, 2020 at 09:57:10AM -0500, Eric W. Biederman wrote:
>> Kees Cook <keescook@chromium.org> writes:
>> 
>> > On Tue, May 05, 2020 at 02:45:33PM -0500, Eric W. Biederman wrote:
>> >> 
>> >> The current idiom for the callers is:
>> >> 
>> >> flush_old_exec(bprm);
>> >> set_personality(...);
>> >> setup_new_exec(bprm);
>> >> 
>> >> In 2010 Linus split flush_old_exec into flush_old_exec and
>> >> setup_new_exec.  With the intention that setup_new_exec be what is
>> >> called after the processes new personality is set.
>> >> 
>> >> Move the code that doesn't depend upon the personality from
>> >> setup_new_exec into flush_old_exec.  This is to facilitate future
>> >> changes by having as much code together in one function as possible.
>> >
>> > Er, I *think* this is okay, but I have some questions below which
>> > maybe you already investigated (and should perhaps get called out in
>> > the changelog).
>> 
>> I will see if I can expand more on the review that I have done.
>> 
>> I saw this as moving thre lines and the personality setting later in the
>> code, rather than moving a bunch of lines up
>> 
>> AKA these lines:
>> >> +	arch_pick_mmap_layout(me->mm, &bprm->rlim_stack);
>> >> +
>> >> +	arch_setup_new_exec();
>> >> +
>> >> +	/* Set the new mm task size. We have to do that late because it may
>> >> +	 * depend on TIF_32BIT which is only updated in flush_thread() on
>> >> +	 * some architectures like powerpc
>> >> +	 */
>> >> +	me->mm->task_size = TASK_SIZE;
>> 
>> 
>> I verified carefully that only those three lines can depend upon the
>> personality changes.
>> 
>> Your concern if anything depends on those moved lines I haven't looked
>> at so closely so I will go back through and do that.  I don't actually
>> expect anything depends upon those three lines because they should only
>> be changing architecture specific state.  But that is general handwaving
>> not actually careful review which tends to turn up suprises in exec.
>
> Right -- I looked through all of it (see my last email) and I think it's
> all okay, but I was curious if you'd looked too. :)

I had and I will finish looking in the other direction and see if there
is anything else I can see.

Thank you for asking and keeping me honest.  There are so many moving
parts to this code it is easy to overlook something by accident.

>> Speaking of while I was looking through the lsm hooks again I just
>> realized that 613cc2b6f272 ("fs: exec: apply CLOEXEC before changing
>> dumpable task flags") only fixed half the problem.  So I am going to
>> take a quick detour fix that then come back to this.  As that directly
>> affects this code motion.
>
> Oh yay. :) Thanks for catching it!

Well that fix is going to be a lot more involved than I anticipated.
The more I looked the more bugs I find so I will revisit fixing that
after I complete this set of changes.  I thought it was going to be a
trivial localized fix, and unfortunately not.

Eric



