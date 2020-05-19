Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2AED1DA081
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 21:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgESTHJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 15:07:09 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:37846 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgESTHI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 15:07:08 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jb7Zx-0007pH-RU; Tue, 19 May 2020 13:07:05 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jb7Zw-0008Ly-Mw; Tue, 19 May 2020 13:07:05 -0600
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
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
        <87sgga6ze4.fsf@x220.int.ebiederm.org>
        <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
        <877dx822er.fsf_-_@x220.int.ebiederm.org>
        <87o8qkzrxp.fsf_-_@x220.int.ebiederm.org>
        <202005191111.9B389D33@keescook>
Date:   Tue, 19 May 2020 14:03:23 -0500
In-Reply-To: <202005191111.9B389D33@keescook> (Kees Cook's message of "Tue, 19
        May 2020 11:21:34 -0700")
Message-ID: <875zcrpx1g.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jb7Zw-0008Ly-Mw;;;mid=<875zcrpx1g.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19uLsQEsrbyURG9a1RrgL6bJSOQRT5dyK8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        XMGappySubj_01,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.5 XMGappySubj_01 Very gappy subject
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa05 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 503 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 8 (1.6%), b_tie_ro: 7 (1.3%), parse: 0.78 (0.2%),
        extract_message_metadata: 10 (1.9%), get_uri_detail_list: 1.44 (0.3%),
        tests_pri_-1000: 11 (2.2%), tests_pri_-950: 0.95 (0.2%),
        tests_pri_-900: 0.79 (0.2%), tests_pri_-90: 185 (36.8%), check_bayes:
        183 (36.4%), b_tokenize: 7 (1.4%), b_tok_get_all: 7 (1.3%),
        b_comp_prob: 2.5 (0.5%), b_tok_touch_all: 165 (32.7%), b_finish: 0.63
        (0.1%), tests_pri_0: 271 (53.8%), check_dkim_signature: 0.80 (0.2%),
        check_dkim_adsp: 3.1 (0.6%), poll_dns_idle: 0.54 (0.1%), tests_pri_10:
        2.2 (0.4%), tests_pri_500: 11 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 3/8] exec: Convert security_bprm_set_creds into security_bprm_repopulate_creds
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Mon, May 18, 2020 at 07:31:14PM -0500, Eric W. Biederman wrote:
>> 
>> Rename bprm->cap_elevated to bprm->active_secureexec and initialize it
>> in prepare_binprm instead of in cap_bprm_set_creds.  Initializing
>> bprm->active_secureexec in prepare_binprm allows multiple
>> implementations of security_bprm_repopulate_creds to play nicely with
>> each other.
>> 
>> Rename security_bprm_set_creds to security_bprm_reopulate_creds to
>> emphasize that this path recomputes part of bprm->cred.  This
>> recomputation avoids the time of check vs time of use problems that
>> are inherent in unix #! interpreters.
>> 
>> In short two renames and a move in the location of initializing
>> bprm->active_secureexec.
>
> I like this much better than the direct call to the capabilities hook.
> Thanks!
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> One nit is a bikeshed on the name "active_secureexec", since
> the word "active" isn't really associated with any other part of the
> binfmt logic. It's supposed to be "latest state from the binfmt loop",
> so instead of "active", I considered these words that I also didn't
> like: "current", "this", "recent", and "now". Is "latest" better than
> "active"? Probably not.

I had pretty much the same problem.  Active at least conveys that it
is still malleable and might change.

>> [...]
>> diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
>> index d1217fcdedea..8605ab4a0f89 100644
>> --- a/include/linux/binfmts.h
>> +++ b/include/linux/binfmts.h
>> @@ -27,10 +27,10 @@ struct linux_binprm {
>>  	unsigned long argmin; /* rlimit marker for copy_strings() */
>>  	unsigned int
>>  		/*
>> -		 * True if most recent call to cap_bprm_set_creds
>> +		 * True if most recent call to security_bprm_set_creds
>>  		 * resulted in elevated privileges.
>>  		 */
>> -		cap_elevated:1,
>> +		active_secureexec:1,
>
> Also, I'd like it if this comment could be made more verbose as well, for
> anyone trying to understand the binfmt execution flow for the first time.
> Perhaps:
>
> 		/*
> 		 * Must be set True during the any call to
> 		 * bprm_set_creds hook where the execution would
> 		 * reuslt in elevated privileges. (The hook can be
> 		 * called multiple times during nested interpreter
> 		 * resolution across binfmt_script, binfmt_misc, etc).
> 		 */
Well it is not during but after the call that it becomes true.
I think most recent covers the case of multiple calls.

I think having the loop explicitly in the code a few patches
later makes it clear that there is a loop dealing with interpreters.

Conciseness has a virtue in that it is easy to absorb.  Seeing
active says most recent and secureexec does not is enough to ask
questions and look at the code.

Eric

