Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C80B1786AE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 00:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgCCXu7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 18:50:59 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:50906 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbgCCXu7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 18:50:59 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1j9HJS-0006h4-7F; Tue, 03 Mar 2020 16:50:58 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1j9HJF-0000FX-Kq; Tue, 03 Mar 2020 16:50:57 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200223011154.GY23230@ZenIV.linux.org.uk>
        <20200301215125.GA873525@ZenIV.linux.org.uk>
        <CAHk-=wh1Q=H-YstHZRKfEw2McUBX2_TfTc=+5N-iH8DSGz44Qg@mail.gmail.com>
        <20200302003926.GM23230@ZenIV.linux.org.uk>
Date:   Tue, 03 Mar 2020 17:48:31 -0600
In-Reply-To: <20200302003926.GM23230@ZenIV.linux.org.uk> (Al Viro's message of
        "Mon, 2 Mar 2020 00:39:26 +0000")
Message-ID: <87o8tdgfu8.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1j9HJF-0000FX-Kq;;;mid=<87o8tdgfu8.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18MPB9/ctLiB1zinwxXNaRDXt7z8LOurDo=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_20,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_20 BODY: Bayes spam probability is 5 to 20%
        *      [score: 0.1849]
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Al Viro <viro@zeniv.linux.org.uk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 12049 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 8 (0.1%), b_tie_ro: 7 (0.1%), parse: 1.92 (0.0%),
        extract_message_metadata: 16 (0.1%), get_uri_detail_list: 2.2 (0.0%),
        tests_pri_-1000: 8 (0.1%), tests_pri_-950: 1.47 (0.0%),
        tests_pri_-900: 1.18 (0.0%), tests_pri_-90: 26 (0.2%), check_bayes: 25
        (0.2%), b_tokenize: 7 (0.1%), b_tok_get_all: 8 (0.1%), b_comp_prob:
        2.9 (0.0%), b_tok_touch_all: 4.0 (0.0%), b_finish: 0.75 (0.0%),
        tests_pri_0: 587 (4.9%), check_dkim_signature: 0.61 (0.0%),
        check_dkim_adsp: 2.4 (0.0%), poll_dns_idle: 11376 (94.4%),
        tests_pri_10: 2.4 (0.0%), tests_pri_500: 11392 (94.5%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [RFC][PATCHSET] sanitized pathwalk machinery (v3)
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> writes:

> On Sun, Mar 01, 2020 at 04:34:06PM -0600, Linus Torvalds wrote:
>> On Sun, Mar 1, 2020 at 3:51 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>> >
>> >         Extended since the last repost.  The branch is in #work.dotdot;
>> > #work.do_last is its beginning (about 2/3 of the total), slightly
>> > reworked since the last time.
>> 
>> I'm traveling, so only a quick read-through.
>> 
>> One request: can you add the total diffstat to the cover letter (along
>> with what you used as a base)?
>
> Sure, no problem (and the base is still -rc1)
>
>> I did apply it to a branch just to look
>> at it more closely, so I can see the final diffstat that way:
>> 
>>  Documentation/filesystems/path-lookup.rst |    7 +-
>>  fs/autofs/dev-ioctl.c                     |    6 +-
>>  fs/internal.h                             |    1 -
>>  fs/namei.c                                | 1333 +++++++++------------
>>  fs/namespace.c                            |   96 +-
>>  fs/open.c                                 |    4 +-
>>  include/linux/namei.h                     |    4 +-
>>  7 files changed, 642 insertions(+), 809 deletions(-)
>> 
>> but it would have been nice to see in your explanation too.
>> 
>> Anyway, from a quick read-through, I don't see anything that raises my
>> hackles - you've fixed the goto label naming, and I didn't notice
>> anything else odd.
>> 
>> Maybe that was because I wasn't careful enough. But the final line
>> count certainly speaks for the series..
>
> Heh...  Part of my metrics is actually "how large a sheet of paper does
> one need to fit the call graph on" ;-)
>
> I hope it gets serious beating, though - it touches pretty much every
> codepath in pathname resolution.  Is there any way to sic the bots on
> a branch, short of "push it into -next and wait for screams"?

Last I looked pushing a branch to kernel.org was enough for the
kbuild bots.  Sending patches to LKML is also enough for those bots.

I don't know if that kind of bot is what you need testing your code.

Eric

