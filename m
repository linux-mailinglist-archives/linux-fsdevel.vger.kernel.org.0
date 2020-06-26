Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27AFD20B5FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jun 2020 18:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgFZQf4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jun 2020 12:35:56 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:46180 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbgFZQf4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jun 2020 12:35:56 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jorKP-0000ZI-IS; Fri, 26 Jun 2020 10:35:49 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jorKO-0008KB-5c; Fri, 26 Jun 2020 10:35:48 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <greg@kroah.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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
        <87o8p6f0kw.fsf_-_@x220.int.ebiederm.org>
        <202006260836.FB867484@keescook>
Date:   Fri, 26 Jun 2020 11:31:20 -0500
In-Reply-To: <202006260836.FB867484@keescook> (Kees Cook's message of "Fri, 26
        Jun 2020 08:37:05 -0700")
Message-ID: <87bll5dc13.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jorKO-0008KB-5c;;;mid=<87bll5dc13.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/aEzzvuT3lhgyym3QCRnXX9VNZ0yqWApw=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4966]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa05 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 343 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 10 (3.0%), b_tie_ro: 9 (2.6%), parse: 0.82 (0.2%),
         extract_message_metadata: 11 (3.1%), get_uri_detail_list: 0.80 (0.2%),
         tests_pri_-1000: 5 (1.6%), tests_pri_-950: 1.14 (0.3%),
        tests_pri_-900: 0.95 (0.3%), tests_pri_-90: 58 (16.9%), check_bayes:
        57 (16.5%), b_tokenize: 6 (1.9%), b_tok_get_all: 6 (1.9%),
        b_comp_prob: 2.2 (0.6%), b_tok_touch_all: 38 (11.1%), b_finish: 0.88
        (0.3%), tests_pri_0: 244 (70.9%), check_dkim_signature: 0.49 (0.1%),
        check_dkim_adsp: 10 (2.9%), poll_dns_idle: 0.20 (0.1%), tests_pri_10:
        2.2 (0.6%), tests_pri_500: 8 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 06/14] umd: For clarity rename umh_info umd_info
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Fri, Jun 26, 2020 at 07:55:43AM -0500, Eric W. Biederman wrote:
>> This structure is only used for user mode drivers so change
>> the prefix from umh to umd to make that clear.
>
> Should bpfilter_umh get renamed to bpfilter_umd at some point in this
> series too?

I think it would make a natural follow on, in a patches welcome sort of
way.

In this series I think it is important to draw a clear line between the
user mode driver infrastructure and the more general user mode helper
infrastructure.  As it fundamentally makes a difference when you are
skimming through the code trying to find the details you care about.

But that line, which removes the maintenance burden from everyone else
is where this series stops.

I will be reposting shortly to fix the build issue I overlooked.

Eric








