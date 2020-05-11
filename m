Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B268E1CE106
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 May 2020 18:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730048AbgEKQ4U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 May 2020 12:56:20 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:44880 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727874AbgEKQ4U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 May 2020 12:56:20 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jYBiw-0008Db-Jb; Mon, 11 May 2020 10:56:14 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jYBiv-000239-EN; Mon, 11 May 2020 10:56:14 -0600
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
        <87k11kzyjm.fsf_-_@x220.int.ebiederm.org>
        <202005101929.A4374D0F56@keescook>
Date:   Mon, 11 May 2020 11:52:41 -0500
In-Reply-To: <202005101929.A4374D0F56@keescook> (Kees Cook's message of "Sun,
        10 May 2020 20:15:34 -0700")
Message-ID: <87y2pytnvq.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jYBiv-000239-EN;;;mid=<87y2pytnvq.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+l+6Xh4x5nig+D3mtInQozkhcto8/9LHc=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        XMGappySubj_01,XMNoVowels,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.5 XMGappySubj_01 Very gappy subject
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa04 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 637 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (1.7%), b_tie_ro: 9 (1.5%), parse: 1.02 (0.2%),
         extract_message_metadata: 15 (2.4%), get_uri_detail_list: 2.7 (0.4%),
        tests_pri_-1000: 15 (2.3%), tests_pri_-950: 1.25 (0.2%),
        tests_pri_-900: 0.99 (0.2%), tests_pri_-90: 171 (26.9%), check_bayes:
        155 (24.3%), b_tokenize: 11 (1.7%), b_tok_get_all: 12 (1.8%),
        b_comp_prob: 3.1 (0.5%), b_tok_touch_all: 125 (19.7%), b_finish: 1.19
        (0.2%), tests_pri_0: 404 (63.4%), check_dkim_signature: 0.63 (0.1%),
        check_dkim_adsp: 2.3 (0.4%), poll_dns_idle: 0.65 (0.1%), tests_pri_10:
        4.0 (0.6%), tests_pri_500: 11 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 2/5] exec: Directly call security_bprm_set_creds from __do_execve_file
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Sat, May 09, 2020 at 02:41:17PM -0500, Eric W. Biederman wrote:
>> 
>> Now that security_bprm_set_creds is no longer responsible for calling
>> cap_bprm_set_creds, security_bprm_set_creds only does something for
>> the primary file that is being executed (not any interpreters it may
>> have).  Therefore call security_bprm_set_creds from __do_execve_file,
>> instead of from prepare_binprm so that it is only called once, and
>> remove the now unnecessary called_set_creds field of struct binprm.
>> 
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>> ---
>>  fs/exec.c                  | 11 +++++------
>>  include/linux/binfmts.h    |  6 ------
>>  security/apparmor/domain.c |  3 ---
>>  security/selinux/hooks.c   |  2 --
>>  security/smack/smack_lsm.c |  3 ---
>>  security/tomoyo/tomoyo.c   |  6 ------
>>  6 files changed, 5 insertions(+), 26 deletions(-)
>> 
>> diff --git a/fs/exec.c b/fs/exec.c
>> index 765bfd51a546..635b5085050c 100644
>> --- a/fs/exec.c
>> +++ b/fs/exec.c
>> @@ -1635,12 +1635,6 @@ int prepare_binprm(struct linux_binprm *bprm)
>>  
>>  	bprm_fill_uid(bprm);
>>  
>> -	/* fill in binprm security blob */
>> -	retval = security_bprm_set_creds(bprm);
>> -	if (retval)
>> -		return retval;
>> -	bprm->called_set_creds = 1;
>> -
>>  	retval = cap_bprm_set_creds(bprm);
>>  	if (retval)
>>  		return retval;
>> @@ -1858,6 +1852,11 @@ static int __do_execve_file(int fd, struct filename *filename,
>>  	if (retval < 0)
>>  		goto out;
>>  
>> +	/* fill in binprm security blob */
>> +	retval = security_bprm_set_creds(bprm);
>> +	if (retval)
>> +		goto out;
>> +
>>  	retval = prepare_binprm(bprm);
>>  	if (retval < 0)
>>  		goto out;
>> 
>
> Here I go with a Sunday night review, so hopefully I'm thinking better
> than Friday night's review, but I *think* this patch is broken from
> the LSM sense of the world in that security_bprm_set_creds() is getting
> called _before_ the creds actually get fully set (in prepare_binprm()
> by the calls to bprm_fill_uid(), cap_bprm_set_creds(), and
> check_unsafe_exec()).
>
> As a specific example, see the setting of LSM_UNSAFE_NO_NEW_PRIVS in
> bprm->unsafe during check_unsafe_exec(), which must happen after
> bprm_fill_uid(bprm) and cap_bprm_set_creds(bprm), to have a "true" view
> of the execution privileges. Apparmor checks for this flag in its
> security_bprm_set_creds() hook. Similarly do selinux, smack, etc...

I think you are getting prepare_binprm confused with prepare_bprm_creds.
Understandable given the similarity of their names.

> The security_bprm_set_creds() boundary for LSM is to see the "final"
> state of the process privileges, and that needs to happen after
> bprm_fill_uid(), cap_bprm_set_creds(), and check_unsafe_exec() have all
> finished.
>
> So, as it stands, I don't think this will work, but perhaps it can still
> be rearranged to avoid the called_set_creds silliness. I'll look more
> this week...

If you look at the flow of the code in __do_execve_file before this
change it is:

	prepare_bprm_creds()
        check_unsafe_exec()

	...

        prepare_binprm()
        	bprm_file_uid()
                	bprm->cred->euid = current_euid()
                        bprm->cred->egid = current_egid()
		security_bprm_set_creds()
                	for_each_lsm()
                        	lsm->bprm_set_creds()
                                	if (called_set_creds)
                                        	return;
                                        ...
		bprm->called_set_creds = 1;
	...

	exec_binprm()
        	search_binary_handler()
                	security_bprm_check()
                        	tomoyo_bprm_check_security()
                                ima_bprm_check()
   			load_script()
                        	prepare_binprm()
                                	/* called_set_creds already == 1 */
                                	bprm_file_uid()
                                        security_bprm_set_creds()
			                	for_each_lsm()
			                        	lsm->bprm_set_creds()
		                                	if (called_set_creds)
                		                        	return;
                                		        ...
                                search_binary_handler()
                                	security_bprm_check_security()
                                        load_elf_binary()
                                        	...
                                                setup_new_exec
                                                ...


Assuming you are executing a shell script.

Now bprm_file_uid is written with the assumption that it will be called
multiple times and it reinitializes all of it's variables each time.

As you can see in above the implementations of bprm_set_creds() only
really execute before called_set_creds is set, aka the first time.
They in no way see the final state.

Further when I looked as those hooks they were not looking at the values
set by bprm_file_uid at all.  There were busy with the values their
they needed to set in that hook for their particular lsm.

So while in theory I can see the danger of moving above bprm_file_uid
I don't see anything in practice that would be a problem.

Further by moving the call of security_bprm_set_creds out of
prepare_binprm int __do_execve_file just before the call of
prepare_binprm I am just moving the call above binprm_fill_uid
and nothing else.

So I think you just confused prepare_bprm_creds with prepare_binprm.
As most of your criticisms appear valid in that case.  Can you take a
second look?

Thank you,
Eric
