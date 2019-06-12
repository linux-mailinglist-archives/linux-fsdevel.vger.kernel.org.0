Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7299A4261A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2019 14:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408255AbfFLMk1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jun 2019 08:40:27 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:60350 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbfFLMk0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:40:26 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hb2Y9-0005YG-UZ; Wed, 12 Jun 2019 06:40:21 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hb2Y8-0002jU-NW; Wed, 12 Jun 2019 06:40:21 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Oleg Nesterov' <oleg@redhat.com>,
        'Andrew Morton' <akpm@linux-foundation.org>,
        'Deepa Dinamani' <deepa.kernel@gmail.com>,
        "'linux-kernel\@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'arnd\@arndb.de'" <arnd@arndb.de>,
        "'dbueso\@suse.de'" <dbueso@suse.de>,
        "'axboe\@kernel.dk'" <axboe@kernel.dk>,
        "'dave\@stgolabs.net'" <dave@stgolabs.net>,
        "'e\@80x24.org'" <e@80x24.org>,
        "'jbaron\@akamai.com'" <jbaron@akamai.com>,
        "'linux-fsdevel\@vger.kernel.org'" <linux-fsdevel@vger.kernel.org>,
        "'linux-aio\@kvack.org'" <linux-aio@kvack.org>,
        "'omar.kilani\@gmail.com'" <omar.kilani@gmail.com>,
        "'tglx\@linutronix.de'" <tglx@linutronix.de>,
        'Al Viro' <viro@ZenIV.linux.org.uk>,
        'Linus Torvalds' <torvalds@linux-foundation.org>,
        "'linux-arch\@vger.kernel.org'" <linux-arch@vger.kernel.org>
References: <20190522032144.10995-1-deepa.kernel@gmail.com>
        <20190529161157.GA27659@redhat.com>
        <20190604134117.GA29963@redhat.com>
        <20190606140814.GA13440@redhat.com> <87k1dxaxcl.fsf_-_@xmission.com>
        <87ef45axa4.fsf_-_@xmission.com> <20190610162244.GB8127@redhat.com>
        <87lfy96sta.fsf@xmission.com>
        <9199239a450d4ea397783ccf98742220@AcuMS.aculab.com>
        <05ffd0f434c64262aa767db81ad75ac1@AcuMS.aculab.com>
Date:   Wed, 12 Jun 2019 07:40:03 -0500
In-Reply-To: <05ffd0f434c64262aa767db81ad75ac1@AcuMS.aculab.com> (David
        Laight's message of "Tue, 11 Jun 2019 15:46:11 +0000")
Message-ID: <8736kf3rks.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hb2Y8-0002jU-NW;;;mid=<8736kf3rks.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/YVLyi/xjY76Y8LOZImydvuQ/haxaL6i0=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4994]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;David Laight <David.Laight@ACULAB.COM>
X-Spam-Relay-Country: 
X-Spam-Timing: total 520 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 3.1 (0.6%), b_tie_ro: 2.2 (0.4%), parse: 1.41
        (0.3%), extract_message_metadata: 15 (2.9%), get_uri_detail_list: 1.46
        (0.3%), tests_pri_-1000: 7 (1.3%), tests_pri_-950: 1.47 (0.3%),
        tests_pri_-900: 1.17 (0.2%), tests_pri_-90: 26 (5.0%), check_bayes: 24
        (4.7%), b_tokenize: 8 (1.6%), b_tok_get_all: 8 (1.5%), b_comp_prob:
        2.7 (0.5%), b_tok_touch_all: 3.4 (0.6%), b_finish: 0.69 (0.1%),
        tests_pri_0: 452 (86.9%), check_dkim_signature: 0.65 (0.1%),
        check_dkim_adsp: 2.4 (0.5%), poll_dns_idle: 0.26 (0.0%), tests_pri_10:
        2.4 (0.5%), tests_pri_500: 7 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC PATCH 1/5] signal: Teach sigsuspend to use set_user_sigmask
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Laight <David.Laight@ACULAB.COM> writes:

> From: David Laight
>> Sent: 11 June 2019 10:52
> ...
>> FWIW is ERESTARTNOHAND actually sane here?
>> If I've used setitimer() to get SIGALARM generated every second I'd
>> expect select() to return EINTR every second even if I don't
>> have a SIGALARM handler?
>
> Actually no - after sigset(SIGALRM, SIG_IGN) I'd expect absolutely
> nothing to happen when kill(pid, SIGALRM) is called.
>
> However if I run:
>
> 	struct itimerval itimerval = {{1, 0}, {1, 0}};
> 	setitimer(ITIMER_REAL, &itimerval, NULL);
> 	sigset(SIGALRM, SIG_IGN);
>
> 	poll(0, 0, big_timeout);
>
> I see (with strace) poll() repeatedly returning ERESTART_RESTARTBLOCK
> and being restarted.
> Replacing poll() with pselect() returns ERESTARTNOHAND.
> (In both cases the timeout must be updated since the application
> does see the timeout.)
>
> I'm sure other unix kernels completely ignore signals set to SIG_IGN.
> So this restart dance just isn't needed.

We also ignore such signals except when the signal is blocked when it is
received.

We don't currently but it would be perfectly legitimate for
set_current_blocked to dequeue and drop signals that have become
unblocked whose handler is SIG_IGN.

The dance would still be needed for the rare case where TIF_SIGPENDING
gets set for a non-signal.

Dropping the signal while it is blocked if it's handler is SIG_IGN looks
like a bad idea.

Eric








