Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3BF131C12C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Feb 2021 19:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhBOSIa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Feb 2021 13:08:30 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:39416 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbhBOSI1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Feb 2021 13:08:27 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lBiHh-00Exml-2G; Mon, 15 Feb 2021 11:07:45 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lBiHd-00Go0X-HA; Mon, 15 Feb 2021 11:07:44 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20201214191323.173773-1-axboe@kernel.dk>
        <m1lfbrwrgq.fsf@fess.ebiederm.org>
        <94731b5a-a83e-91b5-bc6c-6fd4aaacb704@kernel.dk>
        <CAHk-=wiZuX-tyhR6rRxDfQOvyRkCVZjv0DCg1pHBUmzRZ_f1bQ@mail.gmail.com>
Date:   Mon, 15 Feb 2021 12:07:22 -0600
In-Reply-To: <CAHk-=wiZuX-tyhR6rRxDfQOvyRkCVZjv0DCg1pHBUmzRZ_f1bQ@mail.gmail.com>
        (Linus Torvalds's message of "Sun, 14 Feb 2021 12:30:07 -0800")
Message-ID: <m11rdhurvp.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lBiHd-00Go0X-HA;;;mid=<m11rdhurvp.fsf@fess.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+kYEmN5PJD2f9ePzeREqnaiJQOPqGTsa4=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,T_TooManySym_03,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4519]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 826 ms - load_scoreonly_sql: 0.11 (0.0%),
        signal_user_changed: 13 (1.5%), b_tie_ro: 11 (1.3%), parse: 1.45
        (0.2%), extract_message_metadata: 19 (2.3%), get_uri_detail_list: 1.67
        (0.2%), tests_pri_-1000: 7 (0.9%), tests_pri_-950: 1.49 (0.2%),
        tests_pri_-900: 1.23 (0.1%), tests_pri_-90: 192 (23.3%), check_bayes:
        174 (21.1%), b_tokenize: 6 (0.8%), b_tok_get_all: 6 (0.8%),
        b_comp_prob: 2.4 (0.3%), b_tok_touch_all: 155 (18.7%), b_finish: 1.05
        (0.1%), tests_pri_0: 571 (69.2%), check_dkim_signature: 0.59 (0.1%),
        check_dkim_adsp: 2.7 (0.3%), poll_dns_idle: 0.79 (0.1%), tests_pri_10:
        4.2 (0.5%), tests_pri_500: 10 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCHSET v3 0/4] fs: Support for LOOKUP_NONBLOCK / RESOLVE_NONBLOCK (Insufficiently faking current?)
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sun, Feb 14, 2021 at 8:38 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> > Similarly it looks like opening of "/dev/tty" fails to
>> > return the tty of the caller but instead fails because
>> > io-wq threads don't have a tty.
>>
>> I've got a patch queued up for 5.12 that clears ->fs and ->files for the
>> thread if not explicitly inherited, and I'm working on similarly
>> proactively catching these cases that could potentially be problematic.
>
> Well, the /dev/tty case still needs fixing somehow.
>
> Opening /dev/tty actually depends on current->signal, and if it is
> NULL it will fall back on the first VT console instead (I think).
>
> I wonder if it should do the same thing /proc/self does..

Would there be any downside of making the io-wq kernel threads be per
process instead of per user?

I can see a lower probability of a thread already existing.  Are there
other downsides I am missing?

The upside would be that all of the issues of have we copied enough
should go away, as the io-wq thread would then behave like another user
space thread.  To handle posix setresuid() and friends it looks like
current_cred would need to be copied but I can't think of anything else.

Right I am with Al and I don't have any idea how many special cases we
need to play whack-a-mole with.

Eric
