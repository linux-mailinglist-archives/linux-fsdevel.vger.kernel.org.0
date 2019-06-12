Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E47E426C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2019 14:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438639AbfFLM4M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jun 2019 08:56:12 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:40469 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438421AbfFLM4L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:56:11 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hb2nR-0004sb-Km; Wed, 12 Jun 2019 06:56:09 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hb2nQ-0004am-Lf; Wed, 12 Jun 2019 06:56:09 -0600
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
In-Reply-To: <95decc6904754004af8a5546aca0468a@AcuMS.aculab.com> (David
        Laight's message of "Tue, 11 Jun 2019 11:14:57 +0000")
References: <20190522032144.10995-1-deepa.kernel@gmail.com>
        <20190529161157.GA27659@redhat.com>
        <20190604134117.GA29963@redhat.com>
        <20190606140814.GA13440@redhat.com> <87k1dxaxcl.fsf_-_@xmission.com>
        <87ef45axa4.fsf_-_@xmission.com> <20190610162244.GB8127@redhat.com>
        <87lfy96sta.fsf@xmission.com>
        <9199239a450d4ea397783ccf98742220@AcuMS.aculab.com>
        <95decc6904754004af8a5546aca0468a@AcuMS.aculab.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
Date:   Wed, 12 Jun 2019 07:55:51 -0500
Message-ID: <87pnnj2ca0.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hb2nQ-0004am-Lf;;;mid=<87pnnj2ca0.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+N5PFr7zlZ/a3x2KGDitcGaQi9MJxANlc=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4896]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;David Laight <David.Laight@ACULAB.COM>
X-Spam-Relay-Country: 
X-Spam-Timing: total 554 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.5 (0.8%), b_tie_ro: 3.2 (0.6%), parse: 0.73
        (0.1%), extract_message_metadata: 9 (1.6%), get_uri_detail_list: 0.91
        (0.2%), tests_pri_-1000: 12 (2.1%), tests_pri_-950: 1.39 (0.3%),
        tests_pri_-900: 1.18 (0.2%), tests_pri_-90: 26 (4.7%), check_bayes: 24
        (4.4%), b_tokenize: 6 (1.1%), b_tok_get_all: 8 (1.5%), b_comp_prob:
        2.1 (0.4%), b_tok_touch_all: 4.5 (0.8%), b_finish: 0.80 (0.1%),
        tests_pri_0: 487 (88.0%), check_dkim_signature: 0.68 (0.1%),
        check_dkim_adsp: 2.8 (0.5%), poll_dns_idle: 0.21 (0.0%), tests_pri_10:
        2.5 (0.4%), tests_pri_500: 7 (1.2%), rewrite_mail: 0.00 (0.0%)
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
>> If I have an application that has a loop with a pselect call that
>> enables SIGINT (without a handler) and, for whatever reason,
>> one of the fd is always 'ready' then I'd expect a SIGINT
>> (from ^C) to terminate the program.
>> 
>> A quick test program:
>> 
>> #include <sys/time.h>
>> #include <sys/types.h>
>> #include <unistd.h>
>> 
>> #include <sys/select.h>
>> #include <signal.h>
>> 
>> int main(int argc, char **argv)
>> {
>>         fd_set readfds;
>>         sigset_t sig_int;
>>         struct timespec delay = {1, 0};
>> 
>>         sigfillset(&sig_int);
>>         sigdelset(&sig_int, SIGINT);
>> 
>>         sighold(SIGINT);
>> 
>>         for (;;) {
>>                 FD_ZERO(&readfds);
>>                 FD_SET(0, &readfds);
>>                 pselect(1, &readfds, NULL, NULL, &delay, &sig_int);
>> 
>>                 poll(0,0,1000);
>>         }
>> }
>> 
>> Run under strace to see what is happening and send SIGINT from a different terminal.
>> The program sleeps for a second in each of the pselect() and poll() calls.
>> Send a SIGINT and in terminates after pselect() returns ERESTARTNOHAND.
>> 
>> Run again, this time press enter - making fd 0 readable.
>> pselect() returns 1, but the program still exits.
>> (Tested on a 5.1.0-rc5 kernel.)
>> 
>> If a signal handler were defined it should be called instead.
>
> If I add a signal handler for SIGINT it is called when pselect()
> returns regardless of the return value.

That is odd.  Is this with Oleg's fix applied?

Eric
