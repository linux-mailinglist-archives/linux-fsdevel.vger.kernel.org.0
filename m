Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7341E4A7C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 May 2020 18:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbgE0Qkm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 May 2020 12:40:42 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:43368 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbgE0Qkm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 May 2020 12:40:42 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jdz6d-0006w9-OG; Wed, 27 May 2020 10:40:39 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jdz6c-0003Ki-Lj; Wed, 27 May 2020 10:40:39 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Kaitao Cheng <pilgrimtao@gmail.com>, christian@brauner.io,
        akpm@linux-foundation.org, gladkov.alexey@gmail.com, guro@fb.com,
        walken@google.com, avagin@gmail.com, khlebnikov@yandex-team.ru,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20200527141155.47554-1-pilgrimtao@gmail.com>
        <87k10x5tji.fsf@x220.int.ebiederm.org>
        <20200527152340.GA19985@localhost.localdomain>
Date:   Wed, 27 May 2020 11:36:48 -0500
In-Reply-To: <20200527152340.GA19985@localhost.localdomain> (Alexey Dobriyan's
        message of "Wed, 27 May 2020 18:23:40 +0300")
Message-ID: <87k10x49nj.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jdz6c-0003Ki-Lj;;;mid=<87k10x49nj.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18BJ/5vPS/5ztRlPMmB8rb39/YlelSsKas=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=8.0 tests=ALL_TRUSTED,BAYES_20,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_20 BODY: Bayes spam probability is 5 to 20%
        *      [score: 0.1826]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa06 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Alexey Dobriyan <adobriyan@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 648 ms - load_scoreonly_sql: 0.11 (0.0%),
        signal_user_changed: 210 (32.4%), b_tie_ro: 208 (32.2%), parse: 0.96
        (0.1%), extract_message_metadata: 3.6 (0.6%), get_uri_detail_list:
        1.27 (0.2%), tests_pri_-1000: 3.8 (0.6%), tests_pri_-950: 1.32 (0.2%),
        tests_pri_-900: 1.08 (0.2%), tests_pri_-90: 173 (26.7%), check_bayes:
        171 (26.5%), b_tokenize: 7 (1.1%), b_tok_get_all: 7 (1.1%),
        b_comp_prob: 2.7 (0.4%), b_tok_touch_all: 150 (23.2%), b_finish: 1.09
        (0.2%), tests_pri_0: 236 (36.4%), check_dkim_signature: 0.57 (0.1%),
        check_dkim_adsp: 2.8 (0.4%), poll_dns_idle: 0.69 (0.1%), tests_pri_10:
        2.3 (0.4%), tests_pri_500: 7 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] proc/base: Skip assignment to len when there is no error on d_path in do_proc_readlink.
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Alexey Dobriyan <adobriyan@gmail.com> writes:

> On Wed, May 27, 2020 at 09:41:53AM -0500, Eric W. Biederman wrote:
>> Kaitao Cheng <pilgrimtao@gmail.com> writes:
>> 
>> > we don't need {len = PTR_ERR(pathname)} when IS_ERR(pathname) is false,
>> > it's better to move it into if(IS_ERR(pathname)){}.
>> 
>> Please look at the generated code.
>> 
>> I believe you will find that your change will generate worse assembly.
>
> I think patch is good.
>
> Super duper CPUs which speculate thousands instructions forward won't
> care but more embedded ones do. Or in other words 1 unnecessary instruction
> on common path is more important for slow CPUs than for fast CPUs.

No.  This adds an entire extra basic block, with an extra jump.

A good compiler should not even generate an extra instruction for this
case.  A good compiler will just let len and pathname share the same
register.

So I think this will hurt your slow cpu case two as it winds up just
plain being more assembly code, which stress the size of the slow cpus
caches.



I do admit a good compiler should be able to hoist the assignment above
the branch (as we have today) it gets tricky to tell if hoisting the
assignment is safe.

> This style separates common path from error path more cleanly.

Very arguable.

[snip a completely different case]

Yes larger cases can have different solutions.

Eric
