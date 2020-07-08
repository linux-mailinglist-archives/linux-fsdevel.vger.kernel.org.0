Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24786217DC8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 05:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbgGHDxA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 23:53:00 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:32788 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728369AbgGHDw7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 23:52:59 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jt18d-0004xm-Kc; Tue, 07 Jul 2020 21:52:51 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jt18c-00011Y-RJ; Tue, 07 Jul 2020 21:52:51 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <greg@kroah.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <87y2o1swee.fsf_-_@x220.int.ebiederm.org>
        <20200702164140.4468-13-ebiederm@xmission.com>
        <20200703203021.paebx25miovmaxqt@ast-mbp.dhcp.thefacebook.com>
        <873668s2j8.fsf@x220.int.ebiederm.org>
        <20200704155052.kmrest5useyxcfnu@wittgenstein>
        <87mu4bjlqm.fsf@x220.int.ebiederm.org>
        <a84ec1df-dc9b-dd5b-cc34-385fd3ca1da4@iogearbox.net>
Date:   Tue, 07 Jul 2020 22:50:07 -0500
In-Reply-To: <a84ec1df-dc9b-dd5b-cc34-385fd3ca1da4@iogearbox.net> (Daniel
        Borkmann's message of "Wed, 8 Jul 2020 02:05:03 +0200")
Message-ID: <87wo3ek6mo.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jt18c-00011Y-RJ;;;mid=<87wo3ek6mo.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+D9EfKJ8jTyPBEpHFcGJQyQvMMwdPPB/0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4456]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa01 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Daniel Borkmann <daniel@iogearbox.net>
X-Spam-Relay-Country: 
X-Spam-Timing: total 400 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.2 (1.1%), b_tie_ro: 3.0 (0.8%), parse: 0.61
        (0.2%), extract_message_metadata: 8 (2.1%), get_uri_detail_list: 0.42
        (0.1%), tests_pri_-1000: 4.6 (1.2%), tests_pri_-950: 1.04 (0.3%),
        tests_pri_-900: 0.83 (0.2%), tests_pri_-90: 128 (31.9%), check_bayes:
        126 (31.5%), b_tokenize: 4.8 (1.2%), b_tok_get_all: 5 (1.3%),
        b_comp_prob: 1.27 (0.3%), b_tok_touch_all: 112 (27.9%), b_finish: 0.69
        (0.2%), tests_pri_0: 115 (28.9%), check_dkim_signature: 0.34 (0.1%),
        check_dkim_adsp: 2.0 (0.5%), poll_dns_idle: 122 (30.5%), tests_pri_10:
        1.70 (0.4%), tests_pri_500: 133 (33.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v3 13/16] exit: Factor thread_group_exited out of pidfd_poll
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Daniel Borkmann <daniel@iogearbox.net> writes:

> Hey Eric, are you planning to push the final version into a topic branch
> so it can be pulled into bpf-next as discussed earlier?

Yes.  I just about have it ready.  I am taking one last pass through the
review comments to make certain I have not missed anything before I do.

I am hoping I can get it out tonight. Fingers crossed.

Eric
