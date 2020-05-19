Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054141DA0C0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 21:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgESTMX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 15:12:23 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:39744 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgESTMW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 15:12:22 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jb7ez-0008UU-9H; Tue, 19 May 2020 13:12:17 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jb7ey-00014b-3r; Tue, 19 May 2020 13:12:16 -0600
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
        <87imgszrwo.fsf_-_@x220.int.ebiederm.org>
        <202005191122.0A1FD07@keescook>
Date:   Tue, 19 May 2020 14:08:34 -0500
In-Reply-To: <202005191122.0A1FD07@keescook> (Kees Cook's message of "Tue, 19
        May 2020 11:27:25 -0700")
Message-ID: <87sgfvoi8d.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jb7ey-00014b-3r;;;mid=<87sgfvoi8d.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/kgQUwX+CSXDS53ITr/pklJfenYpzNP1g=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4998]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa06 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 406 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 11 (2.7%), b_tie_ro: 10 (2.4%), parse: 0.95
        (0.2%), extract_message_metadata: 11 (2.7%), get_uri_detail_list: 1.30
        (0.3%), tests_pri_-1000: 6 (1.4%), tests_pri_-950: 1.30 (0.3%),
        tests_pri_-900: 1.06 (0.3%), tests_pri_-90: 139 (34.2%), check_bayes:
        129 (31.7%), b_tokenize: 7 (1.8%), b_tok_get_all: 8 (2.0%),
        b_comp_prob: 2.5 (0.6%), b_tok_touch_all: 107 (26.3%), b_finish: 0.99
        (0.2%), tests_pri_0: 225 (55.3%), check_dkim_signature: 0.52 (0.1%),
        check_dkim_adsp: 2.2 (0.5%), poll_dns_idle: 0.62 (0.2%), tests_pri_10:
        2.1 (0.5%), tests_pri_500: 6 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 4/8] exec: Allow load_misc_binary to call prepare_binfmt unconditionally
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Mon, May 18, 2020 at 07:31:51PM -0500, Eric W. Biederman wrote:
>> 
>> Add a flag preserve_creds that binfmt_misc can set to prevent
>> credentials from being updated.  This allows binfmt_misc to always
>> call prepare_binfmt.  Allowing the credential computation logic to be
>
> typo: prepare_binprm()

Thank you.

>> consolidated.
>> 
>> Not replacing the credentials with the interpreters credentials is
>> safe because because an open file descriptor to the executable is
>> passed to the interpreter.   As the interpreter does not need to
>> reopen the executable it is guaranteed to see the same file that
>> exec sees.
>
> Yup, looks good. Note below on comment.
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
>> [...]
>> diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
>> index 8605ab4a0f89..dbb5614d62a2 100644
>> --- a/include/linux/binfmts.h
>> +++ b/include/linux/binfmts.h
>> @@ -26,6 +26,8 @@ struct linux_binprm {
>>  	unsigned long p; /* current top of mem */
>>  	unsigned long argmin; /* rlimit marker for copy_strings() */
>>  	unsigned int
>> +		/* It is safe to use the creds of a script (see binfmt_misc) */
>> +		preserve_creds:1,
>
> How about:
>
> 		/*
> 		 * A binfmt handler will set this to True before calling
> 		 * prepare_binprm() if it is safe to reuse the previous
> 		 * credentials, based on bprm->file (see binfmt_misc).
> 		 */

I think that is more words saying less.

While I agree it might be better.  I don't see what your comment adds to
the understanding.  What do you see my comment not saying that is important?

Eric

