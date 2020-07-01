Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10D72111DD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jul 2020 19:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731548AbgGARXT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jul 2020 13:23:19 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:59228 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbgGARXT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jul 2020 13:23:19 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jqgS1-0004UG-IT; Wed, 01 Jul 2020 11:23:13 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jqgS0-0002b1-HA; Wed, 01 Jul 2020 11:23:13 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
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
        Luis Chamberlain <mcgrof@kernel.org>
References: <20200625095725.GA3303921@kroah.com>
        <778297d2-512a-8361-cf05-42d9379e6977@i-love.sakura.ne.jp>
        <20200625120725.GA3493334@kroah.com>
        <20200625.123437.2219826613137938086.davem@davemloft.net>
        <CAHk-=whuTwGHEPjvtbBvneHHXeqJC=q5S09mbPnqb=Q+MSPMag@mail.gmail.com>
        <87pn9mgfc2.fsf_-_@x220.int.ebiederm.org>
        <87y2oac50p.fsf@x220.int.ebiederm.org>
        <87bll17ili.fsf_-_@x220.int.ebiederm.org>
        <87imf963s6.fsf_-_@x220.int.ebiederm.org>
        <CAHk-=wihqhksXHkcjuTrYmC-vajeRcNh3s6eeoJNxS7wp77dFQ@mail.gmail.com>
Date:   Wed, 01 Jul 2020 12:18:38 -0500
In-Reply-To: <CAHk-=wihqhksXHkcjuTrYmC-vajeRcNh3s6eeoJNxS7wp77dFQ@mail.gmail.com>
        (Linus Torvalds's message of "Tue, 30 Jun 2020 09:58:47 -0700")
Message-ID: <87ftabw3v5.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jqgS0-0002b1-HA;;;mid=<87ftabw3v5.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19t9X1hgcG3oTWl30nEiWfbVh/quO6qF7U=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4935]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa08 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 599 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 13 (2.2%), b_tie_ro: 11 (1.9%), parse: 0.73
        (0.1%), extract_message_metadata: 12 (2.0%), get_uri_detail_list: 0.79
        (0.1%), tests_pri_-1000: 14 (2.4%), tests_pri_-950: 1.29 (0.2%),
        tests_pri_-900: 1.22 (0.2%), tests_pri_-90: 65 (10.8%), check_bayes:
        62 (10.4%), b_tokenize: 7 (1.2%), b_tok_get_all: 8 (1.4%),
        b_comp_prob: 2.1 (0.4%), b_tok_touch_all: 38 (6.4%), b_finish: 1.79
        (0.3%), tests_pri_0: 479 (80.0%), check_dkim_signature: 0.82 (0.1%),
        check_dkim_adsp: 2.8 (0.5%), poll_dns_idle: 0.94 (0.2%), tests_pri_10:
        2.5 (0.4%), tests_pri_500: 7 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 05/15] umh: Separate the user mode driver and the user mode helper support
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, Jun 29, 2020 at 1:05 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> This makes it clear which code is part of the core user mode
>> helper support and which code is needed to implement user mode
>> drivers.
>>
>>  kernel/umd.c             | 146 +++++++++++++++++++++++++++++++++++++++
>>  kernel/umh.c             | 139 -------------------------------------
>
> I certainly don't object to the split, but I hate the name.
>
> We have uml, umd and umh for user mode {linux, drivers, helper}
> respectively.And honestly, I don't see the point in using an obscure
> and unreadable TLA for something like this.
>
> I really don't think it would hurt to write out even the full name
> with "usermode_driver.c" or something like that, would it?
>
> Then "umd" could be continued to be used as a prefix for the helper
> functions, by all means, but if we startv renaming files, can we do it
> properly?

I will take care of it.  I have to respin the patchset for a silly bug anyways.

Eric
