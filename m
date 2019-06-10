Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3FF3BE69
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2019 23:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390329AbfFJVVA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jun 2019 17:21:00 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:38333 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390317AbfFJVVA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jun 2019 17:21:00 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1haRiq-0001JP-E1; Mon, 10 Jun 2019 15:20:56 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1haRip-0005zq-I5; Mon, 10 Jun 2019 15:20:56 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        linux-kernel@vger.kernel.org, arnd@arndb.de, dbueso@suse.de,
        axboe@kernel.dk, dave@stgolabs.net, e@80x24.org, jbaron@akamai.com,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        omar.kilani@gmail.com, tglx@linutronix.de,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Laight <David.Laight@ACULAB.COM>,
        linux-arch@vger.kernel.org
References: <20190522032144.10995-1-deepa.kernel@gmail.com>
        <20190529161157.GA27659@redhat.com>
        <20190604134117.GA29963@redhat.com>
        <20190606140814.GA13440@redhat.com> <87k1dxaxcl.fsf_-_@xmission.com>
        <87ef45axa4.fsf_-_@xmission.com> <20190610162244.GB8127@redhat.com>
Date:   Mon, 10 Jun 2019 16:20:33 -0500
In-Reply-To: <20190610162244.GB8127@redhat.com> (Oleg Nesterov's message of
        "Mon, 10 Jun 2019 18:22:45 +0200")
Message-ID: <87lfy96sta.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1haRip-0005zq-I5;;;mid=<87lfy96sta.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19JMwWsnvGkbEiV8+1643ZDVFGDCR8cZgc=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
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
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 413 ms - load_scoreonly_sql: 0.09 (0.0%),
        signal_user_changed: 3.6 (0.9%), b_tie_ro: 2.2 (0.5%), parse: 1.01
        (0.2%), extract_message_metadata: 3.8 (0.9%), get_uri_detail_list:
        1.62 (0.4%), tests_pri_-1000: 4.6 (1.1%), tests_pri_-950: 1.39 (0.3%),
        tests_pri_-900: 1.20 (0.3%), tests_pri_-90: 27 (6.5%), check_bayes: 25
        (6.0%), b_tokenize: 8 (1.9%), b_tok_get_all: 8 (2.0%), b_comp_prob:
        2.8 (0.7%), b_tok_touch_all: 3.0 (0.7%), b_finish: 0.71 (0.2%),
        tests_pri_0: 350 (84.8%), check_dkim_signature: 0.65 (0.2%),
        check_dkim_adsp: 2.5 (0.6%), poll_dns_idle: 0.66 (0.2%), tests_pri_10:
        2.4 (0.6%), tests_pri_500: 10 (2.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC PATCH 1/5] signal: Teach sigsuspend to use set_user_sigmask
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 06/07, Eric W. Biederman wrote:
>>
>> +static int set_sigmask(sigset_t *kmask)
>> +{
>> +	set_restore_sigmask();
>> +	current->saved_sigmask = current->blocked;
>> +	set_current_blocked(kmask);
>> +
>> +	return 0;
>> +}
>
> I was going to do the same change except my version returns void ;)
>
> So ACK.
>
>
> As for 2-5, sorry I can't read them today, will do tomorrow.
>
> But at first glance... yes, we can remove TIF_RESTORE_SIGMASK.
>
> As for "remove saved_sigmask" I have some concerns... At least this
> means a user-visible change iiuc. Say, pselect unblocks a fatal signal.
> Say, SIGINT without a handler. Suppose SIGINT comes after set_sigmask().
>
> Before this change the process will be killed.
>
> After this change it will be killed or not. It won't be killed if
> do_select() finds an already ready fd without blocking, or it finds a
> ready fd right after SIGINT interrupts poll_schedule_timeout().

Yes.  Because having the signal set in real_blocked disables the
immediate kill optimization, and the signal has to be delivered before
we decide to kill the process.  Which matters because as you say if
nothing checks signal_pending() when the signals are unblocked we might
not attempt to deliver the signal.

So it is a matter of timing.

If we have both a signal and a file descriptor become ready
at the same time I would call that a race.  Either could
wake up the process and depending on the exact time we could
return either one.

So it is possible that today if the signal came just after the file
descriptor ,the code might have made it to restore_saved_sigmask_unless,
before __send_signal runs.

I see the concern.  I think in a matter like this we try it.  Make
the patches clean so people can bisect the problem.  Then if someone
runs into this problem we revert the offending patches.

If it looks like bisection won't cleanly reveal the potential problem
please let me know.

Personally I don't think anyone sane would intentionally depend on this
and I don't think there is a sufficiently reliable way to depend on this
by accident that people would actually be depending on it.

> And _to me_ the new behaviour makes more sense. But when it comes to
> user-visible changes you can never know if it breaks something or not.

True.

The set of applications is larger than any developer can reasonably test.

Eric
