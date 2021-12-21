Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE2E147C9C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Dec 2021 00:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238008AbhLUXgK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Dec 2021 18:36:10 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:55006 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237268AbhLUXgK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Dec 2021 18:36:10 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:52356)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mzofw-0043kp-AO; Tue, 21 Dec 2021 16:36:08 -0700
Received: from ip68-227-161-49.om.om.cox.net ([68.227.161.49]:41210 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mzofv-0011pg-7L; Tue, 21 Dec 2021 16:36:07 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Willy Tarreau <w@1wt.eu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laurent Vivier <laurent@vivier.eu>,
        YunQiang Su <ysu@wavecomp.com>, Helge Deller <deller@gmx.de>
References: <20211221021744.864115-1-longman@redhat.com>
        <87lf0e7y0k.fsf@email.froward.int.ebiederm.org>
        <4f67dc4c-7038-7dde-cad9-4feeaa6bc71b@redhat.com>
        <87czlp7tdu.fsf@email.froward.int.ebiederm.org>
        <e78085e4-74cd-52e1-bc0e-4709fac4458a@redhat.com>
        <CAHk-=wg+qpNvqcROndhRidOE1i7bQm93xM=jmre98-X4qkVkMw@mail.gmail.com>
        <7f0f8e71-cf62-4c0b-5f13-a41919c6cd9b@redhat.com>
        <20211221205635.GB30289@1wt.eu> <20211221221336.GC30289@1wt.eu>
Date:   Tue, 21 Dec 2021 17:35:29 -0600
In-Reply-To: <20211221221336.GC30289@1wt.eu> (Willy Tarreau's message of "Tue,
        21 Dec 2021 23:13:36 +0100")
Message-ID: <87o8594jlq.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mzofv-0011pg-7L;;;mid=<87o8594jlq.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.161.49;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18phw0Fh80bB6hRLu0uycjSNt9ecskzegM=
X-SA-Exim-Connect-IP: 68.227.161.49
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.8 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMSubLong,
        XMSubMetaSxObfu_03,XMSubMetaSx_00 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4745]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Willy Tarreau <w@1wt.eu>
X-Spam-Relay-Country: 
X-Spam-Timing: total 525 ms - load_scoreonly_sql: 0.11 (0.0%),
        signal_user_changed: 13 (2.6%), b_tie_ro: 12 (2.2%), parse: 1.69
        (0.3%), extract_message_metadata: 20 (3.8%), get_uri_detail_list: 3.5
        (0.7%), tests_pri_-1000: 8 (1.5%), tests_pri_-950: 1.72 (0.3%),
        tests_pri_-900: 1.35 (0.3%), tests_pri_-90: 124 (23.6%), check_bayes:
        114 (21.7%), b_tokenize: 11 (2.1%), b_tok_get_all: 12 (2.2%),
        b_comp_prob: 3.9 (0.7%), b_tok_touch_all: 83 (15.8%), b_finish: 1.16
        (0.2%), tests_pri_0: 341 (64.9%), check_dkim_signature: 0.71 (0.1%),
        check_dkim_adsp: 3.4 (0.6%), poll_dns_idle: 0.49 (0.1%), tests_pri_10:
        2.1 (0.4%), tests_pri_500: 7 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] exec: Make suid_dumpable apply to SUID/SGID binaries irrespective of invoking users
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Willy Tarreau <w@1wt.eu> writes:

> On Tue, Dec 21, 2021 at 09:56:35PM +0100, Willy Tarreau wrote:
>> > As it is all done within the kernel, there is no need to
>> > change any userspace code. We may need to add a flag bit in the task
>> > structure to indicate using the suid_dumpable setting so that it can be
>> > inherited across fork/exec.
>> 
>> Depending on what we change there can be some subtly visible changes.
>> In one of my servers I explicitly re-enable dumpable before setsid()
>> when a core dump is desired for debugging. But other deamons could do
>> the exact opposite. If setsid() systematically restores suid_dumpable,
>> a process that explicitly disables it before calling setsid() would
>> see it come back. But if we have a special "suid_in_progress" flag
>> to mask suid_dumpable and that's reset by setsid() and possibly
>> prctl(PR_SET_DUMPABLE) then I think it could even cover that unlikely
>> case.
>
> Would there be any interest in pursuing attempts like the untested patch
> below ? The intent is to set a new MMF_NOT_DUMPABLE on exec on setuid or
> setgid bit, but clear it on setrlimit(RLIMIT_CORE), prctl(SET_DUMPABLE),
> and setsid(). This flag makes get_dumpable() return SUID_DUMP_DISABLED
> when set. I think that in the spirit it could maintain the info that a
> suidexec happened and was not reset, without losing any tuning made by
> the application. I never feel at ease touching all this and I certainly
> did some mistakes but for now it's mostly to have a base to discuss
> around, so do not hesitate to suggest or criticize.


Yes.  This looks like a good place to start the conversation.

We need to do something like you are doing to separate dumpability
changes due to privilege gains during exec and dumpability changes due
to privilege shuffling with setresuid.

As long as we only impact processes descending from a binary that has
gained privileges during exec (like this patch) I think we have a lot
of latitude in how we make this happen.  Basically we only need to
test su and sudo and verify that whatever we do works reasonably
well for them.

On the one hand I believe of gaining privileges during exec while
letting the caller control some aspect of our environment is a dangerous
design flaw and I would love to remove gaining privileges during exec
entirely.

On the other hand we need to introduces as few regressions as possible
and make gaining privileges during exec as safe as possible.



I do agree that RLIMIT_CORE and prctl(SET_DUMPABLE) are good places
to clear the flag.


I don't know if setsid is the proper key to re-enabling dumpability.

I ran a quick test and simply doing "su" and then running a shell
as root does not change the session, nor does "su -" (which creates
a login shell).  Also "sudo -s" does not create a new session.

So session creation does not happen naturally.

Still setsid is part of the standard formula for starting a daemon,
so I don't think system services that run as daemons will be affected.


I don't think anything we do matters for systemd.  As I understand
it "systemctl start ..." causes pid 1 to fork and exec services,
which will ensure the started processes are not descendants of
the binary the gained privileges during exec.

Eric
