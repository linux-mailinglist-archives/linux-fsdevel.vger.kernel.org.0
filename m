Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC7F91DA0F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 21:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgESTXq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 15:23:46 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:42842 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgESTXq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 15:23:46 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jb7py-000156-HH; Tue, 19 May 2020 13:23:38 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jb7px-0002fg-EF; Tue, 19 May 2020 13:23:38 -0600
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
        <874ksczru6.fsf_-_@x220.int.ebiederm.org>
        <202005191144.E3112135@keescook>
Date:   Tue, 19 May 2020 14:19:56 -0500
In-Reply-To: <202005191144.E3112135@keescook> (Kees Cook's message of "Tue, 19
        May 2020 12:08:25 -0700")
Message-ID: <87zha3n34z.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jb7px-0002fg-EF;;;mid=<87zha3n34z.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/o3JOqx7Xhio3cLEEFkP2sYm5qyEXZ5Q0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,T_TooManySym_03,T_TooManySym_04,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4966]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_04 7+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: ; sa02 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 495 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.1 (0.8%), b_tie_ro: 2.8 (0.6%), parse: 0.93
        (0.2%), extract_message_metadata: 11 (2.2%), get_uri_detail_list: 2.8
        (0.6%), tests_pri_-1000: 10 (2.1%), tests_pri_-950: 1.01 (0.2%),
        tests_pri_-900: 0.81 (0.2%), tests_pri_-90: 57 (11.5%), check_bayes:
        56 (11.3%), b_tokenize: 10 (2.0%), b_tok_get_all: 10 (2.0%),
        b_comp_prob: 2.3 (0.5%), b_tok_touch_all: 31 (6.2%), b_finish: 0.63
        (0.1%), tests_pri_0: 397 (80.2%), check_dkim_signature: 0.42 (0.1%),
        check_dkim_adsp: 2.7 (0.5%), poll_dns_idle: 0.19 (0.0%), tests_pri_10:
        2.5 (0.5%), tests_pri_500: 7 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 6/8] exec/binfmt_script: Don't modify bprm->buf and then return -ENOEXEC
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Mon, May 18, 2020 at 07:33:21PM -0500, Eric W. Biederman wrote:
>> 
>> When replacing loops with next_non_spacetab and next_terminator care
>> has been take that the logic of the parsing code (short of replacing
>> characters by '\0') remains the same.
>
> Ah, interesting. As in, bprm->buf must not be modified unless the binfmt
> handler is going to succeed. I think this requirement should be
> documented in the binfmt struct header file.

I think the best way to document this is to modify bprm->buf to be
"const char buf[BINPRM_BUF_SIZE]" or something like that and not
allow any modifications by anything except for the code that
initially reads in contets of the file.

That unfortunately requires copy_strings_kernel which has become
copy_string_kernel to take a length.  Then I don't need to modify the
buffer at all here.

I believe binfmt_scripts is a bit unique in wanting to modify the buffer
because it is parsing strings.

The requirement is that a binfmt should not modify bprm unless it will
succeed or fail with an error that is not -ENOEXEC.  The fundamental
issue is that search_binary_handler will reuse bprm if -ENOEXEC is
returned.

Until the next patch there is an escape hatch by clearing and closing
bprm->file but that goes away.  Which is why I need this patch.

I guess I can see adding a comment about the general case of not
changing bprm unless you are doing something other than returning
-ENOEXEC and letting the search continue.

Eric


>> [...]
>> diff --git a/fs/binfmt_script.c b/fs/binfmt_script.c
>> index 8d718d8fd0fe..85e0ef86eb11 100644
>> --- a/fs/binfmt_script.c
>> +++ b/fs/binfmt_script.c
>> @@ -71,39 +56,48 @@ static int load_script(struct linux_binprm *bprm)
>>  	 * parse them on its own.
>>  	 */
>>  	buf_end = bprm->buf + sizeof(bprm->buf) - 1;
>> -	cp = strnchr(bprm->buf, sizeof(bprm->buf), '\n');
>> -	if (!cp) {
>> -		cp = next_non_spacetab(bprm->buf + 2, buf_end);
>> -		if (!cp)
>> +	i_end = strnchr(bprm->buf, sizeof(bprm->buf), '\n');
>> +	if (!i_end) {
>> +		i_end = next_non_spacetab(bprm->buf + 2, buf_end);
>> +		if (!i_end)
>>  			return -ENOEXEC; /* Entire buf is spaces/tabs */
>>  		/*
>>  		 * If there is no later space/tab/NUL we must assume the
>>  		 * interpreter path is truncated.
>>  		 */
>> -		if (!next_terminator(cp, buf_end))
>> +		if (!next_terminator(i_end, buf_end))
>>  			return -ENOEXEC;
>> -		cp = buf_end;
>> +		i_end = buf_end;
>>  	}
>> -	/* NUL-terminate the buffer and any trailing spaces/tabs. */
>> -	*cp = '\0';
>> -	while (cp > bprm->buf) {
>> -		cp--;
>> -		if ((*cp == ' ') || (*cp == '\t'))
>> -			*cp = '\0';
>> -		else
>> -			break;
>> -	}
>> -	for (cp = bprm->buf+2; (*cp == ' ') || (*cp == '\t'); cp++);
>> -	if (*cp == '\0')
>> +	/* Trim any trailing spaces/tabs from i_end */
>> +	while (spacetab(i_end[-1]))
>> +		i_end--;
>> +
>> +	/* Skip over leading spaces/tabs */
>> +	i_name = next_non_spacetab(bprm->buf+2, i_end);
>> +	if (!i_name || (i_name == i_end))
>>  		return -ENOEXEC; /* No interpreter name found */
>> -	i_name = cp;
>> +
>> +	/* Is there an optional argument? */
>>  	i_arg = NULL;
>> -	for ( ; *cp && (*cp != ' ') && (*cp != '\t'); cp++)
>> -		/* nothing */ ;
>> -	while ((*cp == ' ') || (*cp == '\t'))
>> -		*cp++ = '\0';
>> -	if (*cp)
>> -		i_arg = cp;
>> +	i_sep = next_terminator(i_name, i_end);
>> +	if (i_sep && (*i_sep != '\0'))
>> +		i_arg = next_non_spacetab(i_sep, i_end);
>> +
>> +	/*
>> +	 * If the script filename will be inaccessible after exec, typically
>> +	 * because it is a "/dev/fd/<fd>/.." path against an O_CLOEXEC fd, give
>> +	 * up now (on the assumption that the interpreter will want to load
>> +	 * this file).
>> +	 */
>> +	if (bprm->interp_flags & BINPRM_FLAGS_PATH_INACCESSIBLE)
>> +		return -ENOENT;
>> +
>> +	/* Release since we are not mapping a binary into memory. */
>> +	allow_write_access(bprm->file);
>> +	fput(bprm->file);
>> +	bprm->file = NULL;
>> +
>>  	/*
>>  	 * OK, we've parsed out the interpreter name and
>>  	 * (optional) argument.
>> @@ -121,7 +115,9 @@ static int load_script(struct linux_binprm *bprm)
>>  	if (retval < 0)
>>  		return retval;
>>  	bprm->argc++;
>> +	*((char *)i_end) = '\0';
>>  	if (i_arg) {
>> +		*((char *)i_sep) = '\0';
>>  		retval = copy_strings_kernel(1, &i_arg, bprm);
>>  		if (retval < 0)
>>  			return retval;
>
> I think this is all correct, though I'm always suspicious of my visual
> inspection of string parsers. ;)
>
> I had a worry the \n was not handled correctly in some case. I.e. before
> any \n was converted into \0, and so next_terminator() didn't need to
> consider \n separately. (next_non_spacetab() doesn't care since \n and \0
> are both not ' ' nor '\t'.) For next_terminator(), though, I was worried
> there was a case where *i_end == '\n', and next_terminator()
> will return NULL instead of "last" due to *last being '\n' instead of
> '\0', causing a problem, but you're using the adjusted i_end so I think
> it's correct. And you've handled i_name == i_end.
>
> I will see if I can find my testing scripts I used when commit
> b5372fe5dc84 originally landed to double-check... until then:
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
