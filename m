Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821E71CC450
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 May 2020 22:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbgEIUBM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 May 2020 16:01:12 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:44674 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727938AbgEIUBM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 May 2020 16:01:12 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jXVei-0004RB-KV; Sat, 09 May 2020 14:01:04 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jXVeh-0002GG-On; Sat, 09 May 2020 14:01:04 -0600
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
        Andrew Morton <akpm@linux-foundation.org>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
        <87sgga6ze4.fsf@x220.int.ebiederm.org>
        <87blmy6zay.fsf_-_@x220.int.ebiederm.org>
        <CAHk-=wguq6FwYb8_WZ_ZOxpHtwyc0xpz+PitNuf4pVxjWFmjFQ@mail.gmail.com>
Date:   Sat, 09 May 2020 14:57:33 -0500
In-Reply-To: <CAHk-=wguq6FwYb8_WZ_ZOxpHtwyc0xpz+PitNuf4pVxjWFmjFQ@mail.gmail.com>
        (Linus Torvalds's message of "Sat, 9 May 2020 12:18:06 -0700")
Message-ID: <87k11kyj82.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jXVeh-0002GG-On;;;mid=<87k11kyj82.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX199Tk+7UP647KCMuhUlT5KO3eF9VrjxQc8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong,XM_Body_Dirty_Words autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4991]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.5 XM_Body_Dirty_Words Contains a dirty word
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa04 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 441 ms - load_scoreonly_sql: 0.13 (0.0%),
        signal_user_changed: 13 (3.0%), b_tie_ro: 11 (2.5%), parse: 1.63
        (0.4%), extract_message_metadata: 21 (4.7%), get_uri_detail_list: 2.1
        (0.5%), tests_pri_-1000: 20 (4.5%), tests_pri_-950: 1.70 (0.4%),
        tests_pri_-900: 1.49 (0.3%), tests_pri_-90: 82 (18.5%), check_bayes:
        80 (18.0%), b_tokenize: 8 (1.9%), b_tok_get_all: 8 (1.8%),
        b_comp_prob: 2.9 (0.6%), b_tok_touch_all: 56 (12.6%), b_finish: 1.31
        (0.3%), tests_pri_0: 281 (63.7%), check_dkim_signature: 0.91 (0.2%),
        check_dkim_adsp: 12 (2.7%), poll_dns_idle: 0.30 (0.1%), tests_pri_10:
        3.9 (0.9%), tests_pri_500: 11 (2.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 3/6] exec: Stop open coding mutex_lock_killable of cred_guard_mutex
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, May 8, 2020 at 11:48 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>>
>> Oleg modified the code that did
>> "mutex_lock_interruptible(&current->cred_guard_mutex)" to return
>> -ERESTARTNOINTR instead of -EINTR, so that userspace will never see a
>> failure to grab the mutex.
>>
>> Slightly earlier Liam R. Howlett defined mutex_lock_killable for
>> exactly the same situation but it does it a little more cleanly.
>
> What what what?
>
> None of this makes sense. Your commit message is completely wrong, and
> the patch is utter shite.
>
> mutex_lock_interruptible() and mutex_lock_killable() are completely
> different operations, and the difference has absolutely nothing to do
> with  -ERESTARTNOINTR or -EINTR.
>
> mutex_lock_interruptible() is interrupted by any signal.
>
> mutex_lock_killable() is - surprise surprise - only interrupted by
> SIGKILL (in theory any fatal signal, but we never actually implemented
> that logic, so it's only interruptible by the known-to-always-be-fatal
> SIGKILL).
>
>> Switch the code to mutex_lock_killable so that it is clearer what the
>> code is doing.
>
> This nonsensical patch makes me worry about all your other patches.
> The explanation is wrong, the patch is wrong, and it changes things to
> be fundamentally broken.
>
> Before this, ^C would break out of a blocked execve()/ptrace()
> situation. After this patch, you need special tools to do so.
>
> This patch is completely wrong.

Sigh.  Brain fart on my part. You are correct.

I saw the restart, and totally forgot that it allows the handling of a
signal before restarting the system call.

Except for the handling of the signal in userspace it is the same as
mutex_lock_killable but that is a big big big if.

My apologies.  I will drop this patch.

Eric
