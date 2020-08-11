Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3662024202D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Aug 2020 21:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbgHKTSW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 15:18:22 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:50036 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgHKTSV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 15:18:21 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k5Zmk-009h5q-P1; Tue, 11 Aug 2020 13:18:10 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k5Zmj-0008Qv-TU; Tue, 11 Aug 2020 13:18:10 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc:     linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Philippe =?utf-8?Q?Tr=C3=A9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Thibaut Sautereau <thibaut.sautereau@clip-os.org>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20200723171227.446711-1-mic@digikod.net>
        <20200723171227.446711-2-mic@digikod.net>
        <87eeodnh3v.fsf@x220.int.ebiederm.org>
Date:   Tue, 11 Aug 2020 14:14:43 -0500
In-Reply-To: <87eeodnh3v.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Tue, 11 Aug 2020 13:59:48 -0500")
Message-ID: <874kp9ngf0.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1k5Zmj-0008Qv-TU;;;mid=<874kp9ngf0.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19nTKA3mnL/oyWdDp6PD6Bdr/fgnKMbcEc=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,T_TooManySym_02,T_TooManySym_03,XMSubLong,
        XM_B_SpammyWords,XM_B_Unicode autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4916]
        *  0.7 XMSubLong Long Subject
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: ; sa07 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: =?ISO-8859-1?Q?**;Micka=c3=abl Sala=c3=bcn <mic@digikod.net>?=
X-Spam-Relay-Country: 
X-Spam-Timing: total 466 ms - load_scoreonly_sql: 0.13 (0.0%),
        signal_user_changed: 11 (2.4%), b_tie_ro: 9 (2.0%), parse: 1.53 (0.3%),
         extract_message_metadata: 20 (4.4%), get_uri_detail_list: 1.41 (0.3%),
         tests_pri_-1000: 20 (4.3%), tests_pri_-950: 1.31 (0.3%),
        tests_pri_-900: 1.15 (0.2%), tests_pri_-90: 131 (28.0%), check_bayes:
        120 (25.6%), b_tokenize: 12 (2.6%), b_tok_get_all: 10 (2.0%),
        b_comp_prob: 2.6 (0.6%), b_tok_touch_all: 92 (19.6%), b_finish: 0.95
        (0.2%), tests_pri_0: 259 (55.4%), check_dkim_signature: 0.65 (0.1%),
        check_dkim_adsp: 3.7 (0.8%), poll_dns_idle: 0.42 (0.1%), tests_pri_10:
        2.9 (0.6%), tests_pri_500: 14 (3.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v7 1/7] exec: Change uselib(2) IS_SREG() failure to EACCES
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> Mickaël Salaün <mic@digikod.net> writes:
>
>> From: Kees Cook <keescook@chromium.org>
>>
>> Change uselib(2)' S_ISREG() error return to EACCES instead of EINVAL so
>> the behavior matches execve(2), and the seemingly documented value.
>> The "not a regular file" failure mode of execve(2) is explicitly
>> documented[1], but it is not mentioned in uselib(2)[2] which does,
>> however, say that open(2) and mmap(2) errors may apply. The documentation
>> for open(2) does not include a "not a regular file" error[3], but mmap(2)
>> does[4], and it is EACCES.
>
> Do you have enough visibility into uselib to be certain this will change
> will not cause regressions?
>
> My sense of uselib is that it would be easier to remove the system call
> entirely (I think it's last use was in libc5) than to validate that a
> change like this won't cause problems for the users of uselib.
>
> For the kernel what is important are real world users and the manpages
> are only important as far as they suggest what the real world users
> do.

Hmm.

My apologies. After reading the next patch I see that what really makes
this safe is: 73601ea5b7b1 ("fs/open.c: allow opening only regular files
during execve()").

As in practice this change has already been made and uselib simply
can not reach the !S_ISREG test.

It might make sense to drop this patch or include that reference
in the next posting of this patch.

Eric
