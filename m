Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECB0420F4CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jun 2020 14:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387764AbgF3MhU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jun 2020 08:37:20 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:39166 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387756AbgF3MhT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jun 2020 08:37:19 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jqFVg-0000GB-8B; Tue, 30 Jun 2020 06:37:12 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jqFVf-0001Kb-E9; Tue, 30 Jun 2020 06:37:12 -0600
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
        <874kqt39qo.fsf@x220.int.ebiederm.org>
        <6a9dd8be-333a-fd21-d125-ec20fb7c81df@i-love.sakura.ne.jp>
Date:   Tue, 30 Jun 2020 07:32:39 -0500
In-Reply-To: <6a9dd8be-333a-fd21-d125-ec20fb7c81df@i-love.sakura.ne.jp>
        (Tetsuo Handa's message of "Tue, 30 Jun 2020 15:28:49 +0900")
Message-ID: <871rlwzqc8.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jqFVf-0001Kb-E9;;;mid=<871rlwzqc8.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+cf8KC/zQ0OW1Sl8Ww5gwt7JSMLP+Y3F4=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa06 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
X-Spam-Relay-Country: 
X-Spam-Timing: total 344 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 11 (3.2%), b_tie_ro: 10 (2.8%), parse: 0.86
        (0.3%), extract_message_metadata: 11 (3.2%), get_uri_detail_list: 1.25
        (0.4%), tests_pri_-1000: 6 (1.6%), tests_pri_-950: 1.25 (0.4%),
        tests_pri_-900: 1.01 (0.3%), tests_pri_-90: 80 (23.2%), check_bayes:
        78 (22.7%), b_tokenize: 8 (2.2%), b_tok_get_all: 8 (2.2%),
        b_comp_prob: 2.3 (0.7%), b_tok_touch_all: 57 (16.5%), b_finish: 0.90
        (0.3%), tests_pri_0: 221 (64.4%), check_dkim_signature: 0.51 (0.1%),
        check_dkim_adsp: 1.82 (0.5%), poll_dns_idle: 0.27 (0.1%),
        tests_pri_10: 2.1 (0.6%), tests_pri_500: 7 (2.0%), rewrite_mail: 0.00
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

> On 2020/06/30 5:19, Eric W. Biederman wrote:
>> Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> writes:
>> 
>>> On 2020/06/29 4:44, Alexei Starovoitov wrote:
>>>> But all the defensive programming kinda goes against general kernel style.
>>>> I wouldn't do it. Especially pr_info() ?!
>>>> Though I don't feel strongly about it.
>>>
>>> Honestly speaking, caller should check for errors and print appropriate
>>> messages. info->wd.mnt->mnt_root != info->wd.dentry indicates that something
>>> went wrong (maybe memory corruption). But other conditions are not fatal.
>>> That is, I consider even pr_info() here should be unnecessary.
>> 
>> They were all should never happen cases.  Which is why my patches do:
>> if (WARN_ON_ONCE(...))
>
> No. Fuzz testing (which uses panic_on_warn=1) will trivially hit them.
> This bug was unfortunately not found by syzkaller because this path is
> not easily reachable via syscall interface.

Absolutely yes.  These are cases that should never happen.
They should never be reachable by userspace.

It is absolutely a bug if these are hit by userspace.

Now if fuzzers want horrible cases to be even more horrible and change a
nice friendly warn into a panic that is their problem.  The issue being
do they capture the information the rest of us need to fix.

Eric


