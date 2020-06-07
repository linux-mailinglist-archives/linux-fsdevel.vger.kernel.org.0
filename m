Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADA6C1F0C94
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Jun 2020 17:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbgFGPzw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Jun 2020 11:55:52 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:47446 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbgFGPzw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Jun 2020 11:55:52 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jhxeF-00011L-FU; Sun, 07 Jun 2020 09:55:47 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jhxeA-00082p-MQ; Sun, 07 Jun 2020 09:55:47 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        akpm@linux-foundation.org, ast@kernel.org, davem@davemloft.net,
        viro@zeniv.linux.org.uk, bpf <bpf@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20200329005528.xeKtdz2A0%akpm@linux-foundation.org>
        <13fb3ab7-9ab1-b25f-52f2-40a6ca5655e1@i-love.sakura.ne.jp>
        <202006051903.C44988B@keescook>
        <875zc4c86z.fsf_-_@x220.int.ebiederm.org>
        <20200606204326.GQ19604@bombadil.infradead.org>
Date:   Sun, 07 Jun 2020 10:51:39 -0500
In-Reply-To: <20200606204326.GQ19604@bombadil.infradead.org> (Matthew Wilcox's
        message of "Sat, 6 Jun 2020 13:43:26 -0700")
Message-ID: <87k10i7u2c.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jhxeA-00082p-MQ;;;mid=<87k10i7u2c.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/AFHWWMP4Agup0r0xRemu29zCl6v/Lm6Y=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4996]
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa07 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Matthew Wilcox <willy@infradead.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 4330 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 12 (0.3%), b_tie_ro: 11 (0.2%), parse: 1.31
        (0.0%), extract_message_metadata: 13 (0.3%), get_uri_detail_list: 0.72
        (0.0%), tests_pri_-1000: 5 (0.1%), tests_pri_-950: 1.36 (0.0%),
        tests_pri_-900: 1.07 (0.0%), tests_pri_-90: 302 (7.0%), check_bayes:
        300 (6.9%), b_tokenize: 5 (0.1%), b_tok_get_all: 5 (0.1%),
        b_comp_prob: 1.73 (0.0%), b_tok_touch_all: 285 (6.6%), b_finish: 0.95
        (0.0%), tests_pri_0: 358 (8.3%), check_dkim_signature: 0.59 (0.0%),
        check_dkim_adsp: 2.5 (0.1%), poll_dns_idle: 3607 (83.3%),
        tests_pri_10: 2.0 (0.0%), tests_pri_500: 3629 (83.8%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [RFC][PATCH] net/bpfilter:  Remove this broken and apparently unmantained
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

> On Sat, Jun 06, 2020 at 02:20:36PM -0500, Eric W. Biederman wrote:
>> @@ -39,7 +37,6 @@ static kernel_cap_t usermodehelper_inheritable = CAP_FULL_SET;
>>  static DEFINE_SPINLOCK(umh_sysctl_lock);
>>  static DECLARE_RWSEM(umhelper_sem);
>>  static LIST_HEAD(umh_list);
>> -static DEFINE_MUTEX(umh_list_lock);
>
> You can delete the umh_list too; you've deleted all its users.

Good catch, thank you.

Eric

