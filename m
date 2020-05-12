Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 751A21CFDA5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 20:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730394AbgELSql (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 14:46:41 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:36668 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgELSqk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 14:46:40 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jYZvH-0007rr-9u; Tue, 12 May 2020 12:46:35 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jYZv7-0007UG-JY; Tue, 12 May 2020 12:46:35 -0600
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
Date:   Tue, 12 May 2020 13:42:53 -0500
In-Reply-To: <202005111428.B094E3B76A@keescook> (Kees Cook's message of "Mon,
        11 May 2020 14:55:27 -0700")
Message-ID: <874kslq9jm.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jYZv7-0007UG-JY;;;mid=<874kslq9jm.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19mzgJAcFNyQdQ94l+XWLB+0NtEuzgOx8c=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,NO_DNS_FOR_FROM,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,XMNoVowels,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 NO_DNS_FOR_FROM DNS: Envelope sender has no MX or A DNS records
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa01 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 9272 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.7 (0.1%), b_tie_ro: 3.3 (0.0%), parse: 1.24
        (0.0%), extract_message_metadata: 18 (0.2%), get_uri_detail_list: 3.7
        (0.0%), tests_pri_-1000: 3.5 (0.0%), tests_pri_-950: 1.03 (0.0%),
        tests_pri_-900: 0.81 (0.0%), tests_pri_-90: 194 (2.1%), check_bayes:
        193 (2.1%), b_tokenize: 9 (0.1%), b_tok_get_all: 11 (0.1%),
        b_comp_prob: 2.7 (0.0%), b_tok_touch_all: 167 (1.8%), b_finish: 0.77
        (0.0%), tests_pri_0: 6371 (68.7%), check_dkim_signature: 0.40 (0.0%),
        check_dkim_adsp: 6008 (64.8%), poll_dns_idle: 8662 (93.4%),
        tests_pri_10: 2.2 (0.0%), tests_pri_500: 2672 (28.8%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH 3/5] exec: Remove recursion from search_binary_handler
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Mon, May 11, 2020 at 09:33:21AM -0500, Eric W. Biederman wrote:
>> Linus Torvalds <torvalds@linux-foundation.org> writes:
>> 
>> > On Sat, May 9, 2020 at 9:30 PM Tetsuo Handa
>> > <penguin-kernel@i-love.sakura.ne.jp> wrote:
>> >>
>> >> Wouldn't this change cause
>> >>
>> >>         if (fd_binary > 0)
>> >>                 ksys_close(fd_binary);
>> >>         bprm->interp_flags = 0;
>> >>         bprm->interp_data = 0;
>> >>
>> >> not to be called when "Search for the interpreter" failed?
>> >
>> > Good catch. We seem to have some subtle magic wrt the fd_binary file
>> > descriptor, which depends on the recursive behavior.
>> 
>> Yes.  I Tetsuo I really appreciate you noticing this.  This is exactly
>> the kind of behavior I am trying to flush out and keep from being
>> hidden.
>> 
>> > I'm not seeing how to fix it cleanly with the "turn it into a loop".
>> > Basically, that binfmt_misc use-case isn't really a tail-call.
>> 
>> I have reservations about installing a new file descriptor before
>> we process the close on exec logic and the related security modules
>> closing file descriptors that your new credentials no longer give
>> you access to logic.
>
> Hm, this does feel odd. In looking at this, it seems like this file
> never gets close-on-exec set, and doesn't have its flags changed from
> its original open:
>                 .open_flag = O_LARGEFILE | O_RDONLY | __FMODE_EXEC,
> only the UMH path through exec doesn't explicitly open a file by name
> from what I can see, so we'll only have these flags.
>
>> I haven't yet figured out how opening a file descriptor during exec
>> should fit into all of that.
>> 
>> What I do see is that interp_data is just a parameter that is smuggled
>> into the call of search binary handler.  And the next binary handler
>> needs to be binfmt_elf for it to make much sense, as only binfmt_elf
>> (and binfmt_elf_fdpic) deals with BINPRM_FLAGS_EXECFD.
>> 
>> So I think what needs to happen is to rename bprm->interp_data to
>> bprm->execfd, remove BINPRM_FLAGS_EXECFD and make closing that file
>> descriptor free_bprm's responsiblity.
>
> Yeah, I would agree. As far as the close handling, I don't think there
> is a difference here: it interp_data was closed on the binfmt_misc.c
> error path, and in the new world it would be the exec error path -- both
> would be under the original credentials.
>
>> I hope such a change will make it easier to see all of the pieces that
>> are intereacting during exec.
>
> Right -- I'm not sure which piece should "consume" bprm->execfd though,
> which I think is what you're asking next...
>
>> I am still asking: is the installation of that file descriptor useful if
>> it is not exported passed to userspace as an AT_EXECFD note?
>> 
>> I will dig in and see what I can come up with.
>
> Should binfmt_misc do the install, or can the consuming binfmt do it?
> i.e. when binfmt_elf sees bprm->execfd, does it perform the install
> instead?

I am still thinking about this one, but here is where I am at.  At a
practical level passing the file descriptor of the script to interpreter
seems like something we should encourage in the long term.  It removes
races and it is cheaper because then the interpreter does not have to
turn around and open the script itself.



Strictly speaking binfmt_misc should not need to close the file
descriptor in binfmt_misc because we have already unshared the files
struct and reset_files_struct should handle restoring it.

Calling fd_install in binfmt_misc still seems wrong, as that exposes
the new file descriptor to user space with the old creds.

It is possible although unlikely for userspace to find the file
descriptor without consulting AT_EXECFD so just to be conservative I
think we should install the file descriptor in begin_new_exec even if
the next interpreter does not support AT_EXECFD.


I am still working on how to handle recursive binfmts but I suspect it
is just a matter of having an array of struct files in struct
linux_binprm.


Eric








