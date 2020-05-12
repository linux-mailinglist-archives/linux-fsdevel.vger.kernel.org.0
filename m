Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4D71CFF66
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 22:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731222AbgELUfq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 16:35:46 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:42488 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731183AbgELUfo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 16:35:44 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jYbch-0002xz-HY; Tue, 12 May 2020 14:35:31 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jYbcg-0006hZ-NY; Tue, 12 May 2020 14:35:31 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
        <87sgga6ze4.fsf@x220.int.ebiederm.org>
        <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
        <87eerszyim.fsf_-_@x220.int.ebiederm.org>
        <ee83587b-8a1c-3c4f-cc0f-7bc98afabae1@I-love.SAKURA.ne.jp>
        <CAHk-=wgQ2ovXMW=5ZHCpowkE1PwPQSL7oV4YXzBxd6eqNRXxnQ@mail.gmail.com>
        <87sgg6v8we.fsf@x220.int.ebiederm.org>
        <202005111428.B094E3B76A@keescook>
        <874kslq9jm.fsf@x220.int.ebiederm.org>
        <202005121218.ED0B728DA@keescook>
Date:   Tue, 12 May 2020 15:31:57 -0500
In-Reply-To: <202005121218.ED0B728DA@keescook> (Kees Cook's message of "Tue,
        12 May 2020 12:25:24 -0700")
Message-ID: <87lflwq4hu.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jYbcg-0006hZ-NY;;;mid=<87lflwq4hu.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+qsyyfmYubd8DotJ8yuQl163vwuqW1glQ=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
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
        *      [sa08 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa08 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 419 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 14 (3.4%), b_tie_ro: 13 (3.0%), parse: 0.80
        (0.2%), extract_message_metadata: 10 (2.5%), get_uri_detail_list: 1.54
        (0.4%), tests_pri_-1000: 5 (1.2%), tests_pri_-950: 1.38 (0.3%),
        tests_pri_-900: 1.22 (0.3%), tests_pri_-90: 98 (23.3%), check_bayes:
        95 (22.6%), b_tokenize: 8 (1.8%), b_tok_get_all: 11 (2.6%),
        b_comp_prob: 2.8 (0.7%), b_tok_touch_all: 68 (16.3%), b_finish: 1.21
        (0.3%), tests_pri_0: 276 (66.0%), check_dkim_signature: 0.73 (0.2%),
        check_dkim_adsp: 11 (2.6%), poll_dns_idle: 0.59 (0.1%), tests_pri_10:
        2.1 (0.5%), tests_pri_500: 6 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 3/5] exec: Remove recursion from search_binary_handler
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Tue, May 12, 2020 at 01:42:53PM -0500, Eric W. Biederman wrote:
>> Kees Cook <keescook@chromium.org> writes:
>> > Should binfmt_misc do the install, or can the consuming binfmt do it?
>> > i.e. when binfmt_elf sees bprm->execfd, does it perform the install
>> > instead?
>> 
>> I am still thinking about this one, but here is where I am at.  At a
>> practical level passing the file descriptor of the script to interpreter
>> seems like something we should encourage in the long term.  It removes
>> races and it is cheaper because then the interpreter does not have to
>> turn around and open the script itself.
>
> Yeah, this does sounds pretty good, though I have concerns about doing
> it for a process that isn't expecting it. I've seen a lot of bad code
> make assumptions about initial fd numbers. :(

Yes.  That is definitely a concern.

>> Strictly speaking binfmt_misc should not need to close the file
>> descriptor in binfmt_misc because we have already unshared the files
>> struct and reset_files_struct should handle restoring it.
>
> If I get what you mean, I agree. The error case is fine.
>
>> Calling fd_install in binfmt_misc still seems wrong, as that exposes
>> the new file descriptor to user space with the old creds.
>
> I haven't dug into the details here -- is there a real risk here? The
> old creds are what opened the file originally for the exec. Are you
> thinking about executable-but-not-readable files?

I am thinking about looking in proc/<pid>/fd and maybe opening those
files.  That access is gated by ptrace_may_access which is gated
by the process credentials. So I know strictly speaking it is wrong.

I think you are correct that it would only allow access to a file that
could be accessed another way.  Even execveat at a quick glance appears
to go through the orinary permission checks of open.

The current code is definitely a maintenance pitfall as it install state
into the process early.

>> It is possible although unlikely for userspace to find the file
>> descriptor without consulting AT_EXECFD so just to be conservative I
>> think we should install the file descriptor in begin_new_exec even if
>> the next interpreter does not support AT_EXECFD.
>
> I think universally installing the fd needs to be a distinct patch --
> it's going to have a lot of consequences, IMO. We can certainly deal
> with them, but I don't think it should be part of this clean-up series.

I meant generically installing the fd not universally installing it.

>> I am still working on how to handle recursive binfmts but I suspect it
>> is just a matter of having an array of struct files in struct
>> linux_binprm.
>
> If install is left if binfmt_misc, then the recursive problem goes away,
> yes?

I don't think leaving the install in binfmt_misc is responsible at this
point.

Eric
