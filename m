Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9E7620C158
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jun 2020 15:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgF0NEC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Jun 2020 09:04:02 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:57696 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgF0NEB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Jun 2020 09:04:01 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jpAUs-0005jA-Kz; Sat, 27 Jun 2020 07:03:54 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jpAUr-0008TJ-Nz; Sat, 27 Jun 2020 07:03:54 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <greg@kroah.com>,
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
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200625095725.GA3303921@kroah.com>
        <778297d2-512a-8361-cf05-42d9379e6977@i-love.sakura.ne.jp>
        <20200625120725.GA3493334@kroah.com>
        <20200625.123437.2219826613137938086.davem@davemloft.net>
        <CAHk-=whuTwGHEPjvtbBvneHHXeqJC=q5S09mbPnqb=Q+MSPMag@mail.gmail.com>
        <87pn9mgfc2.fsf_-_@x220.int.ebiederm.org>
        <40720db5-92f0-4b5b-3d8a-beb78464a57f@i-love.sakura.ne.jp>
Date:   Sat, 27 Jun 2020 07:59:25 -0500
In-Reply-To: <40720db5-92f0-4b5b-3d8a-beb78464a57f@i-love.sakura.ne.jp>
        (Tetsuo Handa's message of "Sat, 27 Jun 2020 20:38:33 +0900")
Message-ID: <87366g8y1e.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jpAUr-0008TJ-Nz;;;mid=<87366g8y1e.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/YkAZr0C5jEfgsil9qPDA/pLV/aYtliaA=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa03 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
X-Spam-Relay-Country: 
X-Spam-Timing: total 350 ms - load_scoreonly_sql: 0.02 (0.0%),
        signal_user_changed: 3.4 (1.0%), b_tie_ro: 2.3 (0.7%), parse: 0.87
        (0.2%), extract_message_metadata: 11 (3.2%), get_uri_detail_list: 0.89
        (0.3%), tests_pri_-1000: 6 (1.8%), tests_pri_-950: 1.20 (0.3%),
        tests_pri_-900: 1.16 (0.3%), tests_pri_-90: 121 (34.5%), check_bayes:
        113 (32.4%), b_tokenize: 8 (2.3%), b_tok_get_all: 8 (2.4%),
        b_comp_prob: 1.94 (0.6%), b_tok_touch_all: 92 (26.3%), b_finish: 0.72
        (0.2%), tests_pri_0: 196 (55.9%), check_dkim_signature: 0.47 (0.1%),
        check_dkim_adsp: 1.99 (0.6%), poll_dns_idle: 0.69 (0.2%),
        tests_pri_10: 1.57 (0.4%), tests_pri_500: 4.9 (1.4%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH 00/14] Make the user mode driver code a better citizen
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> writes:

> On 2020/06/26 21:51, Eric W. Biederman wrote:
>> Please let me know if you see any bugs.  Once the code review is
>> finished I plan to take this through my tree.
>

[sniped example code]
> causes
>
>    BUG_ON(!(task->flags & PF_KTHREAD));
>
> in __fput_sync(). Do we want to forbid umd_load_blob() from process context (e.g.
> upon module initialization time) ?

Interesting.  I had not realized that fput_sync would not work from
module context.

Forcing the fput to finish is absolutely necessary.  Otherwise the file
will still be open for write and deny_write_access in execve will fail.

Can you try replacing the __fput_sync with:
	fput(file);
        flush_delayed_fput();
        task_work_run();


Given that there is a big requirement for the code to run before init
I don't necessarily think it is a problem __fput_sync is a problem.
But it also seems silly to forbid modules if we can easily fix
the code.

Eric
