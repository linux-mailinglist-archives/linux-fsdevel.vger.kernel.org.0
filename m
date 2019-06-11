Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 987893D636
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2019 21:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392442AbfFKTDC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jun 2019 15:03:02 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:56843 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391474AbfFKTDB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:03:01 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1ham2s-0005xM-Q6; Tue, 11 Jun 2019 13:02:58 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1ham2r-0005Le-Qx; Tue, 11 Jun 2019 13:02:58 -0600
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
        <87lfy96sta.fsf@xmission.com> <20190611185548.GA31214@redhat.com>
Date:   Tue, 11 Jun 2019 14:02:41 -0500
In-Reply-To: <20190611185548.GA31214@redhat.com> (Oleg Nesterov's message of
        "Tue, 11 Jun 2019 20:55:49 +0200")
Message-ID: <87zhmo54j2.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ham2r-0005Le-Qx;;;mid=<87zhmo54j2.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX193lKbFzPtguYOlnucG7slA3C7KufMmyGY=
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
X-Spam-Timing: total 580 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 2.6 (0.5%), b_tie_ro: 1.72 (0.3%), parse: 1.61
        (0.3%), extract_message_metadata: 4.3 (0.7%), get_uri_detail_list:
        1.13 (0.2%), tests_pri_-1000: 7 (1.3%), tests_pri_-950: 2.2 (0.4%),
        tests_pri_-900: 1.75 (0.3%), tests_pri_-90: 30 (5.2%), check_bayes: 27
        (4.7%), b_tokenize: 11 (1.9%), b_tok_get_all: 6 (1.1%), b_comp_prob:
        3.8 (0.7%), b_tok_touch_all: 2.7 (0.5%), b_finish: 0.73 (0.1%),
        tests_pri_0: 505 (87.2%), check_dkim_signature: 0.84 (0.1%),
        check_dkim_adsp: 2.7 (0.5%), poll_dns_idle: 0.22 (0.0%), tests_pri_10:
        2.3 (0.4%), tests_pri_500: 10 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC PATCH 1/5] signal: Teach sigsuspend to use set_user_sigmask
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 06/10, Eric W. Biederman wrote:
>>
>> Personally I don't think anyone sane would intentionally depend on this
>> and I don't think there is a sufficiently reliable way to depend on this
>> by accident that people would actually be depending on it.
>
> Agreed.
>
> As I said I like these changes and I see nothing wrong. To me they fix the
> current behaviour, or at least make it more consistent.
>
> But perhaps this should be documented in the changelog? To make it clear
> that this change was intentional.

Good point.  I had not documented it because I thought I was only
disabling an optimization.

Eric
