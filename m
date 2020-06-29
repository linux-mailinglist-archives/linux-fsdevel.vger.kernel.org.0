Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1205620DE54
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jun 2020 23:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388954AbgF2UYm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jun 2020 16:24:42 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:46406 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730311AbgF2UYk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jun 2020 16:24:40 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jq0KS-0008Ab-2k; Mon, 29 Jun 2020 14:24:36 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jq0KM-0006dY-76; Mon, 29 Jun 2020 14:24:35 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <greg@kroah.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200625095725.GA3303921@kroah.com>
        <778297d2-512a-8361-cf05-42d9379e6977@i-love.sakura.ne.jp>
        <20200625120725.GA3493334@kroah.com>
        <20200625.123437.2219826613137938086.davem@davemloft.net>
        <CAHk-=whuTwGHEPjvtbBvneHHXeqJC=q5S09mbPnqb=Q+MSPMag@mail.gmail.com>
        <87pn9mgfc2.fsf_-_@x220.int.ebiederm.org>
        <40720db5-92f0-4b5b-3d8a-beb78464a57f@i-love.sakura.ne.jp>
        <87366g8y1e.fsf@x220.int.ebiederm.org>
        <aa737d87-cf38-55d6-32f1-2d989a5412ea@i-love.sakura.ne.jp>
        <20200628194440.puzh7nhdnk6i4rqj@ast-mbp.dhcp.thefacebook.com>
        <c99d0cfc-8526-0daf-90b5-33e560efdede@i-love.sakura.ne.jp>
Date:   Mon, 29 Jun 2020 15:19:59 -0500
In-Reply-To: <c99d0cfc-8526-0daf-90b5-33e560efdede@i-love.sakura.ne.jp>
        (Tetsuo Handa's message of "Mon, 29 Jun 2020 11:20:14 +0900")
Message-ID: <874kqt39qo.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jq0KM-0006dY-76;;;mid=<874kqt39qo.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/d3NN0BDGHtc/aZ8NKVRKAhcNPeBHT1DI=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: ****
X-Spam-Status: No, score=4.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,NO_DNS_FOR_FROM,TR_XM_PhishingBody,
        T_TM2_M_HEADER_IN_MSG,XMNoVowels,XMSubLong,XM_B_Phish66
        autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 NO_DNS_FOR_FROM DNS: Envelope sender has no MX or A DNS records
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  2.0 XM_B_Phish66 BODY: Obfuscated XMission
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 TR_XM_PhishingBody Phishing flag in body of message
X-Spam-DCC: ; sa01 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
X-Spam-Relay-Country: 
X-Spam-Timing: total 5466 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.4 (0.1%), b_tie_ro: 3.0 (0.1%), parse: 1.13
        (0.0%), extract_message_metadata: 11 (0.2%), get_uri_detail_list: 1.46
        (0.0%), tests_pri_-1000: 3.4 (0.1%), tests_pri_-950: 0.95 (0.0%),
        tests_pri_-900: 0.82 (0.0%), tests_pri_-90: 101 (1.8%), check_bayes:
        99 (1.8%), b_tokenize: 6 (0.1%), b_tok_get_all: 8 (0.1%), b_comp_prob:
        1.77 (0.0%), b_tok_touch_all: 81 (1.5%), b_finish: 0.75 (0.0%),
        tests_pri_0: 5333 (97.6%), check_dkim_signature: 0.37 (0.0%),
        check_dkim_adsp: 5089 (93.1%), poll_dns_idle: 5086 (93.1%),
        tests_pri_10: 1.74 (0.0%), tests_pri_500: 5 (0.1%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: [PATCH 00/14] Make the user mode driver code a better citizen
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> writes:

> On 2020/06/29 4:44, Alexei Starovoitov wrote:
>> But all the defensive programming kinda goes against general kernel style.
>> I wouldn't do it. Especially pr_info() ?!
>> Though I don't feel strongly about it.
>
> Honestly speaking, caller should check for errors and print appropriate
> messages. info->wd.mnt->mnt_root != info->wd.dentry indicates that something
> went wrong (maybe memory corruption). But other conditions are not fatal.
> That is, I consider even pr_info() here should be unnecessary.

They were all should never happen cases.  Which is why my patches do:
if (WARN_ON_ONCE(...))

That let's the caller know the messed up very clearly while still
providing a change to continue.

If they were clearly corruption no ones kernel should ever continue
BUG_ON would be appropriate.

>> I would like to generalize elf_header_check() a bit and call it
>> before doing blob_to_mnt() to make sure that all blobs are elf files only.
>> Supporting '#!/bin/bash' or other things as blobs seems wrong to me.

I vote for not worry about things that have never happened, and are
obviously incorrect.

The only points of checks like that is to catch cases where other
developers misunderstand the interface.  When you get to something like
sysfs with lots and lots of users where it is hard to audit there
is real value in sanity checks.  In something like this with very few
users. Just making the code clear should be enough for people not to do
ridiculous things.


In any case Tetsuo I will leave futher sanity checks for you and Alexei
to work out.  It is beyond the scope of my patchset, and they are easy
enough to add as follow on patches.

Eric
