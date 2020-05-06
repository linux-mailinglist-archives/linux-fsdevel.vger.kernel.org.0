Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDDE1C737F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 May 2020 17:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbgEFPAk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 11:00:40 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:57032 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728428AbgEFPAk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 11:00:40 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jWLXI-0000qZ-6w; Wed, 06 May 2020 09:00:36 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jWLXH-0006vv-HW; Wed, 06 May 2020 09:00:36 -0600
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
Date:   Wed, 06 May 2020 09:57:10 -0500
In-Reply-To: <202005051354.C7E2278688@keescook> (Kees Cook's message of "Tue,
        5 May 2020 14:29:21 -0700")
Message-ID: <87368ddsc9.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jWLXH-0006vv-HW;;;mid=<87368ddsc9.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18x9VVQhJyecxxOZFaE4ZN6/7+8evDmFrk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa08 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 312 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (3.7%), b_tie_ro: 10 (3.1%), parse: 0.76
        (0.2%), extract_message_metadata: 10 (3.1%), get_uri_detail_list: 1.21
        (0.4%), tests_pri_-1000: 4.6 (1.5%), tests_pri_-950: 1.30 (0.4%),
        tests_pri_-900: 1.18 (0.4%), tests_pri_-90: 59 (18.9%), check_bayes:
        57 (18.4%), b_tokenize: 6 (1.9%), b_tok_get_all: 9 (2.8%),
        b_comp_prob: 3.2 (1.0%), b_tok_touch_all: 35 (11.1%), b_finish: 1.20
        (0.4%), tests_pri_0: 213 (68.2%), check_dkim_signature: 0.49 (0.2%),
        check_dkim_adsp: 2.9 (0.9%), poll_dns_idle: 0.50 (0.2%), tests_pri_10:
        1.97 (0.6%), tests_pri_500: 7 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 6/7] exec: Move most of setup_new_exec into flush_old_exec
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
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

I will see if I can expand more on the review that I have done.

I saw this as moving thre lines and the personality setting later in the
code, rather than moving a bunch of lines up

AKA these lines:
>> +	arch_pick_mmap_layout(me->mm, &bprm->rlim_stack);
>> +
>> +	arch_setup_new_exec();
>> +
>> +	/* Set the new mm task size. We have to do that late because it may
>> +	 * depend on TIF_32BIT which is only updated in flush_thread() on
>> +	 * some architectures like powerpc
>> +	 */
>> +	me->mm->task_size = TASK_SIZE;


I verified carefully that only those three lines can depend upon the
personality changes.

Your concern if anything depends on those moved lines I haven't looked
at so closely so I will go back through and do that.  I don't actually
expect anything depends upon those three lines because they should only
be changing architecture specific state.  But that is general handwaving
not actually careful review which tends to turn up suprises in exec.

Speaking of while I was looking through the lsm hooks again I just
realized that 613cc2b6f272 ("fs: exec: apply CLOEXEC before changing
dumpable task flags") only fixed half the problem.  So I am going to
take a quick detour fix that then come back to this.  As that directly
affects this code motion.

Eric
