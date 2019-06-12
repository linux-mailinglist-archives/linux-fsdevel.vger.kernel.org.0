Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59BB642A6E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2019 17:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407307AbfFLPLt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jun 2019 11:11:49 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:58798 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405378AbfFLPLt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jun 2019 11:11:49 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hb4uh-00030e-1P; Wed, 12 Jun 2019 09:11:47 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hb4ug-0007r0-5p; Wed, 12 Jun 2019 09:11:46 -0600
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
        <87lfy96sta.fsf@xmission.com>
        <9199239a450d4ea397783ccf98742220@AcuMS.aculab.com>
        <20190612134558.GB3276@redhat.com>
        <6f748b26bef748208e2a74174c0c0bfc@AcuMS.aculab.com>
Date:   Wed, 12 Jun 2019 10:11:28 -0500
In-Reply-To: <6f748b26bef748208e2a74174c0c0bfc@AcuMS.aculab.com> (David
        Laight's message of "Wed, 12 Jun 2019 14:18:28 +0000")
Message-ID: <87v9xayh27.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hb4ug-0007r0-5p;;;mid=<87v9xayh27.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19kiBhawfAF+2ElSohjNKI8rMsbiXCtMS0=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_XMDrugObfuBody_12,T_XMDrugObfuBody_14,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 T_XMDrugObfuBody_12 obfuscated drug references
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.2 T_XMDrugObfuBody_14 obfuscated drug references
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;David Laight <David.Laight@ACULAB.COM>
X-Spam-Relay-Country: 
X-Spam-Timing: total 439 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 5 (1.2%), b_tie_ro: 3.7 (0.8%), parse: 1.62
        (0.4%), extract_message_metadata: 16 (3.6%), get_uri_detail_list: 2.3
        (0.5%), tests_pri_-1000: 7 (1.5%), tests_pri_-950: 1.44 (0.3%),
        tests_pri_-900: 1.30 (0.3%), tests_pri_-90: 36 (8.2%), check_bayes: 34
        (7.7%), b_tokenize: 9 (2.1%), b_tok_get_all: 12 (2.6%), b_comp_prob:
        4.2 (1.0%), b_tok_touch_all: 4.7 (1.1%), b_finish: 1.01 (0.2%),
        tests_pri_0: 356 (81.1%), check_dkim_signature: 0.86 (0.2%),
        check_dkim_adsp: 9 (2.1%), poll_dns_idle: 0.56 (0.1%), tests_pri_10:
        2.5 (0.6%), tests_pri_500: 8 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC PATCH 1/5] signal: Teach sigsuspend to use set_user_sigmask
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Laight <David.Laight@ACULAB.COM> writes:

> From: Oleg Nesterov
>> Sent: 12 June 2019 14:46
>> On 06/11, David Laight wrote:
>> >
>> > If I have an application that has a loop with a pselect call that
>> > enables SIGINT (without a handler) and, for whatever reason,
>> > one of the fd is always 'ready' then I'd expect a SIGINT
>> > (from ^C) to terminate the program.

I think this gets into a quality of implementation.

I suspect that set_user_sigmask should do:
if (signal_pending())
	return -ERESTARNOSIGHAND; /* -EINTR that restarts if nothing was pending */

Which should be safe as nothing has blocked yet to consume any of the
timeouts, and it should ensure that none of the routines miss a signal.

>> This was never true.
>> 
>> Before Eric's patches SIGINT can kill a process or not, depending on timing.
>> In particular, if SIGINT was already pending before pselect() and it finds
>> an already ready fd, the program won't terminate.
>
> Which matches what I see on a very old Linux system.
>
>> After the Eric's patches SIGINT will only kill the program if pselect() does
>> not find a ready fd.
>> 
>> And this is much more consistent. Now we can simply say that the signal will
>> be delivered only if pselect() fails and returns -EINTR. If it doesn't have
>> a handler the process will be killed, otherwise the handler will be called.
>
> But is it what the standards mandate?
> Can anyone check how Solaris and any of the BSDs behave?
> I don't have access to any solaris systems (I doubt I'll get the disk to
> spin on the one in my garage).
> I can check NetBSD when I get home.
>
> The ToG page for pselect() http://pubs.opengroup.org/onlinepubs/9699919799/functions/pselect.html says:
>     "If sigmask is not a null pointer, then the pselect() function shall replace
>     the signal mask of the caller by the set of signals pointed to by sigmask
>     before examining the descriptors, and shall restore the signal mask of the
>     calling thread before returning."
> Note that it says 'before examining the descriptors' not 'before blocking'.
> Under the general description about signals it also says that the signal handler
> will be called (or other action happen) when a pending signal is unblocked.
> So unblocking SIGINT (set to SIG_DFL) prior to examining the descriptors
> should be enough to cause the process to exit.
> The fact that signal handlers are not called until 'return to user'
> is really an implementation choice - but (IMHO) it should appear as if they
> were called at the time they became unmasked.
>
> If nothing else the man pages need a note about the standards and portability.

I think the entire point is so that signals can be added to an event
loop in a race free way.  *cough* signalfd *cough*.  I think if you are
setting SIGINT to SIG_DFL you would leave SIGINT unblocked so it can
happen anywhere.

I can see more utility in having a SIGINT handler and you block SIGINT
except in your polling loop so you can do something deterministic when
SIGINT comes in.

Which makes it independent of my patches, but still worth fixing.

Eric
