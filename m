Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0832E178A33
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 06:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725839AbgCDFZu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 00:25:50 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:39158 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgCDFZu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 00:25:50 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1j9MXV-0007tb-6m; Tue, 03 Mar 2020 22:25:49 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1j9MXU-0001BC-FT; Tue, 03 Mar 2020 22:25:49 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200223011154.GY23230@ZenIV.linux.org.uk>
        <20200301215125.GA873525@ZenIV.linux.org.uk>
        <CAHk-=wh1Q=H-YstHZRKfEw2McUBX2_TfTc=+5N-iH8DSGz44Qg@mail.gmail.com>
        <20200302003926.GM23230@ZenIV.linux.org.uk>
        <87o8tdgfu8.fsf@x220.int.ebiederm.org>
        <20200304002434.GO23230@ZenIV.linux.org.uk>
Date:   Tue, 03 Mar 2020 23:23:39 -0600
In-Reply-To: <20200304002434.GO23230@ZenIV.linux.org.uk> (Al Viro's message of
        "Wed, 4 Mar 2020 00:24:34 +0000")
Message-ID: <87wo80g0bo.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1j9MXU-0001BC-FT;;;mid=<87wo80g0bo.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/UTv8fSOWm0P3BimXgYvHzkz1l3lFMik8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4790]
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Al Viro <viro@zeniv.linux.org.uk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 279 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 4.0 (1.4%), b_tie_ro: 2.8 (1.0%), parse: 1.34
        (0.5%), extract_message_metadata: 23 (8.4%), get_uri_detail_list: 2.3
        (0.8%), tests_pri_-1000: 25 (9.0%), tests_pri_-950: 1.58 (0.6%),
        tests_pri_-900: 1.23 (0.4%), tests_pri_-90: 24 (8.6%), check_bayes: 22
        (8.1%), b_tokenize: 8 (2.7%), b_tok_get_all: 7 (2.4%), b_comp_prob:
        2.8 (1.0%), b_tok_touch_all: 2.9 (1.1%), b_finish: 0.76 (0.3%),
        tests_pri_0: 177 (63.5%), check_dkim_signature: 0.56 (0.2%),
        check_dkim_adsp: 2.4 (0.8%), poll_dns_idle: 0.84 (0.3%), tests_pri_10:
        4.2 (1.5%), tests_pri_500: 12 (4.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC][PATCHSET] sanitized pathwalk machinery (v3)
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> writes:

> On Tue, Mar 03, 2020 at 05:48:31PM -0600, Eric W. Biederman wrote:
>
>> > I hope it gets serious beating, though - it touches pretty much every
>> > codepath in pathname resolution.  Is there any way to sic the bots on
>> > a branch, short of "push it into -next and wait for screams"?
>> 
>> Last I looked pushing a branch to kernel.org was enough for the
>> kbuild bots.  Sending patches to LKML is also enough for those bots.
>> 
>> I don't know if that kind of bot is what you need testing your code.
>
> Build bots are generally nice, but in this case... pretty much all of
> the changes are in fs/namei.c, which is not all that sensitive to
> config/architecture/whatnot.  Sure, something like "is audit enabled?"
> may affect the build problems, but not much beyond that.
>
> What was that Intel-run(?) bot that posts "such-and-such metrics has
> 42% regression on such-and-such commit" from time to time?
> <checks>
> Subject: [locking/qspinlock] 7b6da71157: unixbench.score 8.4% improvement
> seems to be the latest of that sort,
> From: kernel test robot <rong.a.chen@intel.com>
>
> Not sure how much of pathwalk-heavy loads is covered by profiling
> bots of that sort, unfortunately... ;-/

Do the xfs-tests cover that sort of thing?
The emphasis is stress testing the filesystem not the VFS but there is a
lot of overlap between the two.

Eric

