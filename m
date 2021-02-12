Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5BE431A861
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Feb 2021 00:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbhBLXpS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Feb 2021 18:45:18 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:37708 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhBLXpS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Feb 2021 18:45:18 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lAi72-001KCr-76; Fri, 12 Feb 2021 16:44:36 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lAi70-00AAP5-Mb; Fri, 12 Feb 2021 16:44:35 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <85ff6fd6b26aafdf6087666629bad3acc29258d8.camel@perches.com>
        <m1im6x0wtv.fsf@fess.ebiederm.org>
        <130bc5f98c2fd501d32024d267ea73f1fb9d88b6.camel@perches.com>
Date:   Fri, 12 Feb 2021 17:44:16 -0600
In-Reply-To: <130bc5f98c2fd501d32024d267ea73f1fb9d88b6.camel@perches.com> (Joe
        Perches's message of "Fri, 12 Feb 2021 14:51:26 -0800")
Message-ID: <m1y2fszwa7.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lAi70-00AAP5-Mb;;;mid=<m1y2fszwa7.fsf@fess.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+qBXDbfZLXHXoONMPahKJzWEoz0+wrmrk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,T_TooManySym_02 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Joe Perches <joe@perches.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 899 ms - load_scoreonly_sql: 0.15 (0.0%),
        signal_user_changed: 14 (1.6%), b_tie_ro: 12 (1.4%), parse: 1.09
        (0.1%), extract_message_metadata: 17 (1.9%), get_uri_detail_list: 2.1
        (0.2%), tests_pri_-1000: 12 (1.4%), tests_pri_-950: 1.51 (0.2%),
        tests_pri_-900: 1.18 (0.1%), tests_pri_-90: 91 (10.1%), check_bayes:
        88 (9.7%), b_tokenize: 4.8 (0.5%), b_tok_get_all: 8 (0.9%),
        b_comp_prob: 2.3 (0.3%), b_tok_touch_all: 67 (7.5%), b_finish: 1.36
        (0.2%), tests_pri_0: 155 (17.3%), check_dkim_signature: 0.47 (0.1%),
        check_dkim_adsp: 3.3 (0.4%), poll_dns_idle: 578 (64.3%), tests_pri_10:
        2.3 (0.3%), tests_pri_500: 600 (66.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] proc: Convert S_<FOO> permission uses to octal
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Joe Perches <joe@perches.com> writes:

> On Fri, 2021-02-12 at 16:01 -0600, Eric W. Biederman wrote:
>> Joe Perches <joe@perches.com> writes:
>> 
>> > Convert S_<FOO> permissions to the more readable octal.
>> > 
>> > Done using:
>> > $ ./scripts/checkpatch.pl -f --fix-inplace --types=SYMBOLIC_PERMS fs/proc/*.[ch]
>> > 
>> > No difference in generated .o files allyesconfig x86-64
>> > 
>> > Link:
>> > https://lore.kernel.org/lkml/CA+55aFw5v23T-zvDZp-MmD_EYxF8WbafwwB59934FV7g21uMGQ@mail.gmail.com/
>> 
>> 
>> I will be frank.  I don't know what 0644 means.  I can never remember
>> which bit is read, write or execute.  So I like symbolic constants.
>> 
>> I don't see a compelling reason to change the existing code.
>
> Did you read Linus' message in the Link: above?
>
> It was a reply to what Ingo Molnar suggested here:
>
> https://lore.kernel.org/lkml/20160803081140.GA7833@gmail.com/

Only if you read in reverse chronological order.

Ingo's message was in reply to Linus and it received somewhat favorable
replies and was not shot down.

I certainly do not see sufficient consensus to go around changing code
other people maintain.

My suggest has the nice property that it handles all 512 different
combinations.  I think that was the only real downside of Ingo's
suggestion.  There are just too many different combinations to define
a set of macros to cover all of the cases.

Eric
