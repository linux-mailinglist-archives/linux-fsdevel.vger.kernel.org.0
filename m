Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0428E205B4B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jun 2020 20:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733219AbgFWS6U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jun 2020 14:58:20 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:41676 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733138AbgFWS6T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jun 2020 14:58:19 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jno7Z-0004g1-A5; Tue, 23 Jun 2020 12:58:13 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jno7Y-0004Sv-7m; Tue, 23 Jun 2020 12:58:13 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        David Miller <davem@davemloft.net>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>
References: <87r1uo2ejt.fsf@x220.int.ebiederm.org>
        <20200609235631.ukpm3xngbehfqthz@ast-mbp.dhcp.thefacebook.com>
        <87d066vd4y.fsf@x220.int.ebiederm.org>
        <20200611233134.5vofl53dj5wpwp5j@ast-mbp.dhcp.thefacebook.com>
        <87bllngirv.fsf@x220.int.ebiederm.org>
        <CAADnVQ+qNxFjTYBpYW9ZhStMh_oJBS5C_FsxSS=0Mzy=u54MSg@mail.gmail.com>
        <CAADnVQLuGYX=LamARhrZcze1ej4ELj-y99fLzOCgz60XLPw_cQ@mail.gmail.com>
        <87ftaxd7ky.fsf@x220.int.ebiederm.org>
        <20200616015552.isi6j5x732okiky4@ast-mbp.dhcp.thefacebook.com>
        <87h7v1pskt.fsf@x220.int.ebiederm.org>
        <20200623183520.5e7fmlt3omwa2lof@ast-mbp.dhcp.thefacebook.com>
Date:   Tue, 23 Jun 2020 13:53:48 -0500
In-Reply-To: <20200623183520.5e7fmlt3omwa2lof@ast-mbp.dhcp.thefacebook.com>
        (Alexei Starovoitov's message of "Tue, 23 Jun 2020 11:35:20 -0700")
Message-ID: <87h7v1mx4z.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jno7Y-0004Sv-7m;;;mid=<87h7v1mx4z.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18/RJglEZjLIMbAudmB45pz7qaMdYp7mJU=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa08 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Alexei Starovoitov <alexei.starovoitov@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 660 ms - load_scoreonly_sql: 0.17 (0.0%),
        signal_user_changed: 15 (2.3%), b_tie_ro: 13 (2.0%), parse: 1.47
        (0.2%), extract_message_metadata: 4.3 (0.6%), get_uri_detail_list:
        1.38 (0.2%), tests_pri_-1000: 4.3 (0.6%), tests_pri_-950: 1.27 (0.2%),
        tests_pri_-900: 1.14 (0.2%), tests_pri_-90: 171 (25.9%), check_bayes:
        169 (25.6%), b_tokenize: 6 (1.0%), b_tok_get_all: 9 (1.4%),
        b_comp_prob: 3.0 (0.4%), b_tok_touch_all: 145 (22.0%), b_finish: 1.42
        (0.2%), tests_pri_0: 445 (67.3%), check_dkim_signature: 0.82 (0.1%),
        check_dkim_adsp: 2.8 (0.4%), poll_dns_idle: 1.23 (0.2%), tests_pri_10:
        2.1 (0.3%), tests_pri_500: 7 (1.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC][PATCH] net/bpfilter: Remove this broken and apparently unmantained
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Tue, Jun 23, 2020 at 01:04:02PM -0500, Eric W. Biederman wrote:
>> 
>> Sigh.  I was busy last week so I left reading this until now in the
>> hopes I would see something reasonable.
>> 
>> What I see is rejecting of everything that is said to you.
>> 
>> What I do not see are patches fixing issues.  I will await patches.
>
> huh?
> I can say exactly the same. You keep ignoring numerous points I brought up.
> You still haven't showed what kind of refactoring you have in mind and
> why fork_blob is in its way.

That is correct.  What I wind up doing with exec is irrelevant.

What is relevant is getting correct working code on the fork_blob path.
Something that is clean enough that whatever weird things it winds up
doing are readable.  The way things are intermingled today it took 2
years for someone to realize there was a basic reference counting bug.

This isn't work anyone else can do because there are not yet any real in
tree users of fork_blob.  The fact that no one else can make
substantials changes to the code because it has no users is what gets in
the way of maintenance.


One of the 2 year old bugs that needs to be fixed is that some LSMs
work in terms of paths.  Tetsuo has been very gracious in pointing that
out.  Either a path needs to be provided or the LSMs that work in terms
of paths need to be fixed.



Now I really don't care how the bugs are fixed.


My recomendation for long term maintenance is to split fork_blob into 2
functions: fs_from_blob, and the ordinary call_usermodehelper_exec.
That removes the need for any special support for anything in the exec
path because your blob will also have a path for your file, and the
file in the filesystem can be reused for restart.

That feels like the least long term work on everyone.

But with no in-tree users none of us can do anything bug guess what
the actual requirements of fork_usermode_blob are.


So patches to fix the bugs please.

Eric




