Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB1E1CC47E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 May 2020 22:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbgEIUP4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 May 2020 16:15:56 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:47412 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728244AbgEIUPz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 May 2020 16:15:55 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jXVt2-0005eM-E0; Sat, 09 May 2020 14:15:52 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jXVt1-0003ZO-Mf; Sat, 09 May 2020 14:15:52 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
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
        <87k11kzyjm.fsf_-_@x220.int.ebiederm.org>
        <CAHk-=wj-Znzqp3xktZ+kERM5cKF-Yh_6XjyGYof6bqPq2T3F5A@mail.gmail.com>
Date:   Sat, 09 May 2020 15:12:22 -0500
In-Reply-To: <CAHk-=wj-Znzqp3xktZ+kERM5cKF-Yh_6XjyGYof6bqPq2T3F5A@mail.gmail.com>
        (Linus Torvalds's message of "Sat, 9 May 2020 13:07:48 -0700")
Message-ID: <878si0yijd.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jXVt1-0003ZO-Mf;;;mid=<878si0yijd.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19cvWMPbuGySDS9RKEj6OOfBZhbGqCVxX0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        XMGappySubj_01,XMNoVowels,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.5 XMGappySubj_01 Very gappy subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa06 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 351 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 14 (3.9%), b_tie_ro: 12 (3.3%), parse: 1.11
        (0.3%), extract_message_metadata: 17 (4.9%), get_uri_detail_list: 1.33
        (0.4%), tests_pri_-1000: 24 (6.8%), tests_pri_-950: 1.37 (0.4%),
        tests_pri_-900: 1.13 (0.3%), tests_pri_-90: 55 (15.8%), check_bayes:
        54 (15.3%), b_tokenize: 7 (2.1%), b_tok_get_all: 8 (2.2%),
        b_comp_prob: 2.5 (0.7%), b_tok_touch_all: 32 (9.0%), b_finish: 1.11
        (0.3%), tests_pri_0: 224 (63.8%), check_dkim_signature: 0.57 (0.2%),
        check_dkim_adsp: 2.8 (0.8%), poll_dns_idle: 0.63 (0.2%), tests_pri_10:
        2.3 (0.7%), tests_pri_500: 8 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 2/5] exec: Directly call security_bprm_set_creds from __do_execve_file
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sat, May 9, 2020 at 12:44 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> Now that security_bprm_set_creds is no longer responsible for calling
>> cap_bprm_set_creds, security_bprm_set_creds only does something for
>> the primary file that is being executed (not any interpreters it may
>> have).  Therefore call security_bprm_set_creds from __do_execve_file,
>> instead of from prepare_binprm so that it is only called once, and
>> remove the now unnecessary called_set_creds field of struct binprm.
>
> Ahh, good, this patch removes the 'called_set_creds' logic from the
> security subsystems.
>
> So it does half of what I asked for: please also just rename that
> "security_bprm_set_creds()" to be "security_primary_bprm_set_creds()"
> so that the change of semantics also shows up that way.
>
> And so that there is no confusion about the fact that
> "cap_bprm_set_creds()" has absolutely nothing to do with
> "security_bprm_set_creds()" any more.

I agree something needs to be renamed, to remove confusion.

I am off for a nap now, and tomorrow is Mother's day so I probably won't
be back to this seriously until Monday.  But please disect these patches
and I will address any problems.

Eric


