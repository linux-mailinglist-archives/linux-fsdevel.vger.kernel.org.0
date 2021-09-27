Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C91B441A185
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 23:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237323AbhI0VxM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 17:53:12 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:40404 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237446AbhI0VxK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 17:53:10 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:49496)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mUyX5-00Ba9o-95; Mon, 27 Sep 2021 15:51:31 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:40602 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mUyX4-00FmAu-B0; Mon, 27 Sep 2021 15:51:30 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        contact@linuxplumbersconf.org
References: <CAHrFyr4AYi_gad7LQ-cJ9Peg=Gt73Sded8k_ZHeRZz=faGzpQA@mail.gmail.com>
Date:   Mon, 27 Sep 2021 16:51:05 -0500
In-Reply-To: <CAHrFyr4AYi_gad7LQ-cJ9Peg=Gt73Sded8k_ZHeRZz=faGzpQA@mail.gmail.com>
        (Christian Brauner's message of "Mon, 27 Sep 2021 23:21:00 +0200")
Message-ID: <87pmst4rhy.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mUyX4-00FmAu-B0;;;mid=<87pmst4rhy.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18e30myv93RW4z3ZyRvYrTwhuvPrbbjkT4=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4572]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Christian Brauner <christian.brauner@ubuntu.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 395 ms - load_scoreonly_sql: 0.11 (0.0%),
        signal_user_changed: 14 (3.6%), b_tie_ro: 12 (3.1%), parse: 1.07
        (0.3%), extract_message_metadata: 14 (3.5%), get_uri_detail_list: 1.54
        (0.4%), tests_pri_-1000: 6 (1.5%), tests_pri_-950: 1.49 (0.4%),
        tests_pri_-900: 1.35 (0.3%), tests_pri_-90: 116 (29.4%), check_bayes:
        114 (28.9%), b_tokenize: 6 (1.4%), b_tok_get_all: 6 (1.4%),
        b_comp_prob: 2.2 (0.6%), b_tok_touch_all: 98 (24.7%), b_finish: 0.82
        (0.2%), tests_pri_0: 225 (56.9%), check_dkim_signature: 0.62 (0.2%),
        check_dkim_adsp: 10 (2.4%), poll_dns_idle: 0.51 (0.1%), tests_pri_10:
        1.89 (0.5%), tests_pri_500: 11 (2.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [lpc-contact] Linux Plumbers Conference Last Day
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christian Brauner <christian.brauner@ubuntu.com> writes:

> I'm expanding the Cc on this since this has crossed a clear line now.

What asking people to fix their bugs?

Sitting out and not engaging because this situation is very frustrating
when people refuse to fix their bugs?

> You have claimed on two occasions on the PR itself (cf. [1]) and in a
> completely unrelated thread on fsdevel (cf. [2]) that there exist bugs in the
> current implementation.
> On both occasions (cf. [3], [4]) we have responded and asked you to please
> disclose those bugs and provide reproducers. You have not responded on both
> occasions.

You acknowledged the trivial bug in chown_common that affects security
modules and exists to this day.

It is trivial to see all you have to do is look at the stomp of uid and
gid.

The other bug I gave details of you and it the tracing was tricky and
you did not agree.  Last I looked it is also there.

> I ask you to stop spreading demonstrably false information such as that we are
> refusing to fix bugs. The links clearly disprove your claims.
> We are more than happy to fix any bugs that exist. But we can't if we don't
> know what they are.

Hog wash.

A demonstration is a simple as observing that security_path_chown very
much gets a different uid and gid values than it used to.

I have been able to dig in far enough to see that the idmapped mounts
code does not have issues when you are not using idmapped mounts, and I
am not using idmapped mounts.  So dealing with this has not been a
priority for me.

All I have seen you do on this issue is get frustrated.  I am very
frustrated also.

All I was intending to say was that if we could sit down in person at
LPC we could probably sort this all out quickly, and get past this our
frustrations with each other.  As it is, I don't know a quick way to
resolve our frustrations easily.

Eric
