Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB1B21E8D85
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 May 2020 05:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbgE3D2C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 23:28:02 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:54076 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728349AbgE3D2B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 23:28:01 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jesA5-0006lX-96; Fri, 29 May 2020 21:27:53 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jesA4-0005Dm-Bt; Fri, 29 May 2020 21:27:53 -0600
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
        <87k10wysqz.fsf_-_@x220.int.ebiederm.org>
        <87d06mr8ps.fsf_-_@x220.int.ebiederm.org>
        <877dwur8nj.fsf_-_@x220.int.ebiederm.org>
        <202005291403.BCDBFA7D1@keescook>
Date:   Fri, 29 May 2020 22:23:58 -0500
In-Reply-To: <202005291403.BCDBFA7D1@keescook> (Kees Cook's message of "Fri,
        29 May 2020 14:06:33 -0700")
Message-ID: <87k10unm0h.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jesA4-0005Dm-Bt;;;mid=<87k10unm0h.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18T3f2u8gHGrtWAPt/SgvEWL29Ef0wVq/8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,T_TooManySym_03,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: ; sa07 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 480 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 12 (2.4%), b_tie_ro: 10 (2.1%), parse: 1.26
        (0.3%), extract_message_metadata: 17 (3.6%), get_uri_detail_list: 2.5
        (0.5%), tests_pri_-1000: 24 (4.9%), tests_pri_-950: 1.31 (0.3%),
        tests_pri_-900: 1.06 (0.2%), tests_pri_-90: 130 (27.0%), check_bayes:
        126 (26.3%), b_tokenize: 9 (1.9%), b_tok_get_all: 11 (2.3%),
        b_comp_prob: 3.1 (0.6%), b_tok_touch_all: 98 (20.4%), b_finish: 1.09
        (0.2%), tests_pri_0: 282 (58.7%), check_dkim_signature: 0.53 (0.1%),
        check_dkim_adsp: 2.3 (0.5%), poll_dns_idle: 0.40 (0.1%), tests_pri_10:
        2.2 (0.5%), tests_pri_500: 7 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/2] exec: Add a per bprm->file version of per_clear
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Fri, May 29, 2020 at 11:46:40AM -0500, Eric W. Biederman wrote:
>> 
>> There is a small bug in the code that recomputes parts of bprm->cred
>> for every bprm->file.  The code never recomputes the part of
>> clear_dangerous_personality_flags it is responsible for.
>> 
>> Which means that in practice if someone creates a sgid script
>> the interpreter will not be able to use any of:
>> 	READ_IMPLIES_EXEC
>> 	ADDR_NO_RANDOMIZE
>> 	ADDR_COMPAT_LAYOUT
>> 	MMAP_PAGE_ZERO.
>> 
>> This accentially clearing of personality flags probably does
>> not matter in practice because no one has complained
>> but it does make the code more difficult to understand.
>> 
>> Further remaining bug compatible prevents the recomputation from being
>> removed and replaced by simply computing bprm->cred once from the
>> final bprm->file.
>> 
>> Making this change removes the last behavior difference between
>> computing bprm->creds from the final file and recomputing
>> bprm->cred several times.  Which allows this behavior change
>> to be justified for it's own reasons, and for any but hunts
>> looking into why the behavior changed to wind up here instead
>> of in the code that will follow that computes bprm->cred
>> from the final bprm->file.
>> 
>> This small logic bug appears to have existed since the code
>> started clearing dangerous personality bits.
>> 
>> History Tree: git://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
>> Fixes: 1bb0fa189c6a ("[PATCH] NX: clean up legacy binary support")
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>
> Yup, this looks good. Pointless nit because it's removed in the next
> patch, but pf_per_clear is following the same behavioral pattern as
> active_secureexec, it could be named active_per_clear, but since this
> already been bikeshed in v1, it's fine! :)

That plus it is very much true that active_ isn't a particularly good
prefix.  pf_ for per_file seems slightly better.

The only time I can imagine this patch seeing the light of day is if
someone happens to discover that this fixes a bug for them and just this
patch is backported.  At which point pf_per_clear pairs with
cap_elevated.  So I don't think it hurts.

*Shrug*

The next patch is my long term solution to the mess.

> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> I wish we had more robust execve tests. :(

I think you have more skill at writing automated tests than I do.  So
feel free to write some.

Eric
