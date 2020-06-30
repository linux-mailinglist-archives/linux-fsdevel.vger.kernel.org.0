Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0E4020F466
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jun 2020 14:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733276AbgF3MTI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jun 2020 08:19:08 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:33564 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732509AbgF3MTH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jun 2020 08:19:07 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jqFE5-00081m-AD; Tue, 30 Jun 2020 06:19:01 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jqFE0-00084E-2g; Tue, 30 Jun 2020 06:19:01 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <greg@kroah.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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
        Casey Schaufler <casey@schaufler-ca.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20200625095725.GA3303921@kroah.com>
        <778297d2-512a-8361-cf05-42d9379e6977@i-love.sakura.ne.jp>
        <20200625120725.GA3493334@kroah.com>
        <20200625.123437.2219826613137938086.davem@davemloft.net>
        <CAHk-=whuTwGHEPjvtbBvneHHXeqJC=q5S09mbPnqb=Q+MSPMag@mail.gmail.com>
        <87pn9mgfc2.fsf_-_@x220.int.ebiederm.org>
        <87y2oac50p.fsf@x220.int.ebiederm.org>
        <87bll17ili.fsf_-_@x220.int.ebiederm.org>
        <87lfk54p0m.fsf_-_@x220.int.ebiederm.org>
        <20200630054313.GB27221@infradead.org>
Date:   Tue, 30 Jun 2020 07:14:23 -0500
In-Reply-To: <20200630054313.GB27221@infradead.org> (Christoph Hellwig's
        message of "Tue, 30 Jun 2020 06:43:13 +0100")
Message-ID: <87a70k21k0.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jqFE0-00084E-2g;;;mid=<87a70k21k0.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18dJcHLmm8/3QJGbuxrMA4/Ld4nXUEMj/w=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4944]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa06 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Christoph Hellwig <hch@infradead.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 4796 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 9 (0.2%), b_tie_ro: 7 (0.2%), parse: 0.88 (0.0%),
        extract_message_metadata: 11 (0.2%), get_uri_detail_list: 0.73 (0.0%),
        tests_pri_-1000: 6 (0.1%), tests_pri_-950: 1.27 (0.0%),
        tests_pri_-900: 1.03 (0.0%), tests_pri_-90: 167 (3.5%), check_bayes:
        165 (3.4%), b_tokenize: 7 (0.1%), b_tok_get_all: 7 (0.1%),
        b_comp_prob: 1.91 (0.0%), b_tok_touch_all: 146 (3.0%), b_finish: 0.86
        (0.0%), tests_pri_0: 221 (4.6%), check_dkim_signature: 0.54 (0.0%),
        check_dkim_adsp: 2.3 (0.0%), poll_dns_idle: 4353 (90.8%),
        tests_pri_10: 2.2 (0.0%), tests_pri_500: 4374 (91.2%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH v2 10/15] exec: Remove do_execve_file
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> FYI, this clashes badly with my exec rework.  I'd suggest you
> drop everything touching exec here for now, and I can then
> add the final file based exec removal to the end of my series.

I have looked and I haven't even seen any exec work.  Where can it be
found?

I have working and cleaning up exec for what 3 cycles now.  There is
still quite a ways to go before it becomes possible to fix some of the
deep problems in exec.  Removing all of these broken exec special cases
is quite frankly the entire point of this patchset.

Sight unseen I suggest you send me your exec work and I can merge it
into my branch if we are going to conflict badly.

Eric

