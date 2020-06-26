Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 409BD20B641
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jun 2020 18:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgFZQuF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jun 2020 12:50:05 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:56708 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbgFZQuF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jun 2020 12:50:05 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jorY9-0005GM-1G; Fri, 26 Jun 2020 10:50:01 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jorY2-0000c6-V9; Fri, 26 Jun 2020 10:50:00 -0600
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
        <87tuyyf0ln.fsf_-_@x220.int.ebiederm.org>
        <5ce4d340-096a-f468-6719-4c34a951511e@i-love.sakura.ne.jp>
Date:   Fri, 26 Jun 2020 11:45:27 -0500
In-Reply-To: <5ce4d340-096a-f468-6719-4c34a951511e@i-love.sakura.ne.jp>
        (Tetsuo Handa's message of "Sat, 27 Jun 2020 01:22:12 +0900")
Message-ID: <87d05lbwt4.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jorY2-0000c6-V9;;;mid=<87d05lbwt4.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19kMmKGvmUojtO4rei5sXZ7Qr00EPT1MD0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,NO_DNS_FOR_FROM,T_TM2_M_HEADER_IN_MSG,XMNoVowels,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 NO_DNS_FOR_FROM DNS: Envelope sender has no MX or A DNS records
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa01 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
X-Spam-Relay-Country: 
X-Spam-Timing: total 5686 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.5 (0.1%), b_tie_ro: 3.0 (0.1%), parse: 1.11
        (0.0%), extract_message_metadata: 12 (0.2%), get_uri_detail_list: 1.64
        (0.0%), tests_pri_-1000: 3.2 (0.1%), tests_pri_-950: 1.01 (0.0%),
        tests_pri_-900: 0.88 (0.0%), tests_pri_-90: 58 (1.0%), check_bayes: 56
        (1.0%), b_tokenize: 6 (0.1%), b_tok_get_all: 8 (0.1%), b_comp_prob:
        1.90 (0.0%), b_tok_touch_all: 38 (0.7%), b_finish: 0.76 (0.0%),
        tests_pri_0: 5597 (98.4%), check_dkim_signature: 0.37 (0.0%),
        check_dkim_adsp: 5389 (94.8%), poll_dns_idle: 5384 (94.7%),
        tests_pri_10: 1.61 (0.0%), tests_pri_500: 4.7 (0.1%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH 05/14] umh: Separate the user mode driver and the user mode helper support
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> writes:

> On 2020/06/26 21:55, Eric W. Biederman wrote:
>> +static void umd_cleanup(struct subprocess_info *info)
>> +{
>> +	struct umh_info *umh_info = info->data;
>> +
>> +	/* cleanup if umh_pipe_setup() was successful but exec failed */
>
> s/umh_pipe_setup/umd_setup/

Good catch.  I will fix that when I respin.

>> +	if (info->retval) {
>> +		fput(umh_info->pipe_to_umh);
>> +		fput(umh_info->pipe_from_umh);
>> +	}
>> +}
>
> After this cleanup, I expect adding some protections/isolation which kernel threads
> have (e.g. excluded from ptrace(), excluded from OOM victim selection, excluded from
> SysRq-i, won't be terminated by SIGKILL from usermode processes, won't be stopped by
> SIGSTOP from usermode processes, what else?). Doing it means giving up Alexei's
>
>   It's nice to be able to compile that blob with -g and be able to 'gdb -p' into it.
>   That works and very convenient when it comes to debugging. Compare that to debugging
>   a kernel module!
>
> but I think doing it is essential for keeping usermode blob processes as secure/robust
> as kernel threads.

Do you have an application for a user mode driver?

I think concerns like that are best addressed in the context of a
specific driver/usecase.  Just to make certain we are solving the right
problems.

My sense is that an advantage of user mode drivers can safely be buggier
than kernel drivers and the freedom to kill them when the drivers go
wrong (knowing the drivers will restart) is important.

Does this series by using the normal path through exec solve your
concerns with LSMs being able to identify these processes (both
individually and as class)?.

Eric

