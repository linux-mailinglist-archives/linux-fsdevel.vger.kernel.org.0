Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4671B4270E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2019 15:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438756AbfFLNJi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jun 2019 09:09:38 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:41908 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728322AbfFLNJh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jun 2019 09:09:37 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hb30R-00063y-2Z; Wed, 12 Jun 2019 07:09:35 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hb30Q-00066J-7v; Wed, 12 Jun 2019 07:09:34 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Oleg Nesterov' <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd\@arndb.de" <arnd@arndb.de>,
        "dbueso\@suse.de" <dbueso@suse.de>,
        "axboe\@kernel.dk" <axboe@kernel.dk>,
        "dave\@stgolabs.net" <dave@stgolabs.net>,
        "e\@80x24.org" <e@80x24.org>,
        "jbaron\@akamai.com" <jbaron@akamai.com>,
        "linux-fsdevel\@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-aio\@kvack.org" <linux-aio@kvack.org>,
        "omar.kilani\@gmail.com" <omar.kilani@gmail.com>,
        "tglx\@linutronix.de" <tglx@linutronix.de>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-arch\@vger.kernel.org" <linux-arch@vger.kernel.org>
References: <20190522032144.10995-1-deepa.kernel@gmail.com>
        <20190529161157.GA27659@redhat.com>
        <20190604134117.GA29963@redhat.com>
        <20190606140814.GA13440@redhat.com> <87k1dxaxcl.fsf_-_@xmission.com>
        <87ef45axa4.fsf_-_@xmission.com> <20190610162244.GB8127@redhat.com>
        <87lfy96sta.fsf@xmission.com> <20190611185548.GA31214@redhat.com>
        <fd2aab3d26754becbb0efe4ae65c32ac@AcuMS.aculab.com>
Date:   Wed, 12 Jun 2019 08:09:17 -0500
In-Reply-To: <fd2aab3d26754becbb0efe4ae65c32ac@AcuMS.aculab.com> (David
        Laight's message of "Wed, 12 Jun 2019 08:39:53 +0000")
Message-ID: <874l4v0x36.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hb30Q-00066J-7v;;;mid=<874l4v0x36.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19+satK9tmg8L1GuZ+k6WyPXv9z0Jmmtd4=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_XMDrugObfuBody_00,XMNoVowels,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 T_XMDrugObfuBody_00 obfuscated drug references
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;David Laight <David.Laight@ACULAB.COM>
X-Spam-Relay-Country: 
X-Spam-Timing: total 477 ms - load_scoreonly_sql: 0.11 (0.0%),
        signal_user_changed: 3.5 (0.7%), b_tie_ro: 2.3 (0.5%), parse: 1.14
        (0.2%), extract_message_metadata: 13 (2.7%), get_uri_detail_list: 1.66
        (0.3%), tests_pri_-1000: 13 (2.7%), tests_pri_-950: 1.45 (0.3%),
        tests_pri_-900: 1.07 (0.2%), tests_pri_-90: 26 (5.4%), check_bayes: 24
        (5.1%), b_tokenize: 9 (1.8%), b_tok_get_all: 8 (1.7%), b_comp_prob:
        2.6 (0.5%), b_tok_touch_all: 3.3 (0.7%), b_finish: 0.60 (0.1%),
        tests_pri_0: 402 (84.1%), check_dkim_signature: 0.89 (0.2%),
        check_dkim_adsp: 3.4 (0.7%), poll_dns_idle: 0.12 (0.0%), tests_pri_10:
        2.3 (0.5%), tests_pri_500: 11 (2.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC PATCH 1/5] signal: Teach sigsuspend to use set_user_sigmask
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Laight <David.Laight@ACULAB.COM> writes:

> From: Oleg Nesterov [mailto:oleg@redhat.com]
>> Sent: 11 June 2019 19:56
>> On 06/10, Eric W. Biederman wrote:
>> >
>> > Personally I don't think anyone sane would intentionally depend on this
>> > and I don't think there is a sufficiently reliable way to depend on this
>> > by accident that people would actually be depending on it.
>> 
>> Agreed.
>> 
>> As I said I like these changes and I see nothing wrong. To me they fix the
>> current behaviour, or at least make it more consistent.
>> 
>> But perhaps this should be documented in the changelog? To make it clear
>> that this change was intentional.
>
> What happens if you run the test program I posted yesterday after the changes?
>
> It looks like pselect() and epoll_pwait() operated completely differently.
> pselect() would always calls the signal handlers.
> epoll_pwait() only calls them when EINTR is returned.
> So changing epoll_pwait() and pselect() to work the same way
> is bound to break some applications.

That is not the change we are discussing.  We are looking at making
pselect and epoll_pwait act a little more like sigtimedwait.

In particular we are discussiong signals whose handler is SIG_DFL and
whose default disposition is to kill the process, such as SIGINT.

When those signals are delivered and they are not blocked, we take
an optimized path in complete_signal and start the process tear down.

That early start of process tear down does not happen if the signal is
blocked or it happens to be in real_blocked (from sigtimedwait).

This matters is the small time window where the signal is received while
the process has temporarily unblocked the signal, and the signal is not
detected by the code and blocked and oridinarily would not be delivered
until next time because of restore_sigmask_unless.

If the tear down has started early.  Even if we would not have returned
the process normally the signal can kill the process.  AKA epoll_pwait
can today result in it's caller being killed without -EINTR being
returned.

My change fixes that behavior and disables the early process tear down
for those signals, by having real_blocked match the set of signals
that are normally blocked by the process.  The result should be
the signal will have to wait for the next call that temporarily
unblocked the process.

The real benefit is that that the code becomes more comprehensible.

It is my patch that titled: "signal: Always keep real_blocked in sync
with blocked" that causes that to happen.

Eric
