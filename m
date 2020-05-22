Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 414A31DE831
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 May 2020 15:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729868AbgEVNjB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 May 2020 09:39:01 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:34864 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729406AbgEVNjA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 May 2020 09:39:00 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jc7sy-0003j6-TB; Fri, 22 May 2020 07:38:53 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jc7sx-0000zH-CV; Fri, 22 May 2020 07:38:52 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Rob Landley <rob@landley.net>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
        <87sgga6ze4.fsf@x220.int.ebiederm.org>
        <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
        <877dx822er.fsf_-_@x220.int.ebiederm.org>
        <87y2poyd91.fsf_-_@x220.int.ebiederm.org>
        <adaced72-d757-e3e4-cfeb-5512533d0aa5@landley.net>
        <874ksaioc6.fsf@x220.int.ebiederm.org>
        <fc2cf2a7-e1a7-3170-32c9-43e593636799@landley.net>
        <87r1vcd4wo.fsf@x220.int.ebiederm.org>
        <6ce125fd-4fb1-8c39-a9a9-098391f2016a@landley.net>
Date:   Fri, 22 May 2020 08:35:06 -0500
In-Reply-To: <6ce125fd-4fb1-8c39-a9a9-098391f2016a@landley.net> (Rob Landley's
        message of "Thu, 21 May 2020 23:51:20 -0500")
Message-ID: <871rnccctx.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jc7sx-0000zH-CV;;;mid=<871rnccctx.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+mSrIOE54/VQp+XUfD3u/JlfcpgUct7Ko=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa06 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Rob Landley <rob@landley.net>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1062 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 12 (1.1%), b_tie_ro: 10 (1.0%), parse: 1.78
        (0.2%), extract_message_metadata: 18 (1.7%), get_uri_detail_list: 1.45
        (0.1%), tests_pri_-1000: 8 (0.7%), tests_pri_-950: 1.39 (0.1%),
        tests_pri_-900: 1.10 (0.1%), tests_pri_-90: 63 (5.9%), check_bayes: 61
        (5.7%), b_tokenize: 12 (1.2%), b_tok_get_all: 9 (0.8%), b_comp_prob:
        3.7 (0.3%), b_tok_touch_all: 32 (3.0%), b_finish: 1.06 (0.1%),
        tests_pri_0: 457 (43.0%), check_dkim_signature: 0.70 (0.1%),
        check_dkim_adsp: 2.6 (0.2%), poll_dns_idle: 481 (45.3%), tests_pri_10:
        2.4 (0.2%), tests_pri_500: 493 (46.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 7/8] exec: Generic execfd support
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rob Landley <rob@landley.net> writes:

> On 5/21/20 10:28 PM, Eric W. Biederman wrote:
>> 
>> Rob Landley <rob@landley.net> writes:
>> 
>>> On 5/20/20 11:05 AM, Eric W. Biederman wrote:
>> 
>>>> The file descriptor is stored in mm->exe_file.
>>>> Probably the most straight forward implementation is to allow
>>>> execveat(AT_EXE_FILE, ...).
>>>
>>> Cool, that works.
>>>
>>>> You can look at binfmt_misc for how to reopen an open file descriptor.
>>>
>>> Added to the todo heap.
>> 
>> Yes I don't think it would be a lot of code.
>> 
>> I think you might be better served with clone(CLONE_VM) as it doesn't
>> block so you don't need to feed yourself your context over a pipe.
>
> Except that doesn't fix it.
>
> Yes I could use threads instead, but the cure is worse than the disease and the
> result is your shell background processes are threads rather than independent
> processes (is $$ reporting PID or TID, I really don't want to go
> there).

I was just suggesting clone(CLONE_VM) because it creates a thread in a
separate process.  Which on nommu sounds like it could be almost exactly
what you want.

If you need the separate copies of all of your global variables etc,
re-exec'ing your self could be the easier way to go.

Eric

