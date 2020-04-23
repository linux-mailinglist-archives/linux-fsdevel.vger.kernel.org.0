Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F91F1B649E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 21:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgDWTlX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 15:41:23 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:43014 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgDWTlW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 15:41:22 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jRhir-0006qh-LG; Thu, 23 Apr 2020 13:41:21 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jRhiq-0001Ot-TI; Thu, 23 Apr 2020 13:41:21 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20200419141057.621356-1-gladkov.alexey@gmail.com>
        <87ftcv1nqe.fsf@x220.int.ebiederm.org>
        <20200423175432.GA18034@redhat.com>
Date:   Thu, 23 Apr 2020 14:38:12 -0500
In-Reply-To: <20200423175432.GA18034@redhat.com> (Oleg Nesterov's message of
        "Thu, 23 Apr 2020 19:54:33 +0200")
Message-ID: <878simxaaj.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jRhiq-0001Ot-TI;;;mid=<878simxaaj.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19dCJ+VAndkjtlTXMjXhU69eKISG5HCfXc=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMSlimDrugH,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4387]
        *  1.0 XMSlimDrugH Weight loss drug headers
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 363 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 11 (3.1%), b_tie_ro: 10 (2.7%), parse: 0.81
        (0.2%), extract_message_metadata: 2.6 (0.7%), get_uri_detail_list:
        0.71 (0.2%), tests_pri_-1000: 17 (4.8%), tests_pri_-950: 1.95 (0.5%),
        tests_pri_-900: 1.69 (0.5%), tests_pri_-90: 61 (16.9%), check_bayes:
        59 (16.4%), b_tokenize: 9 (2.5%), b_tok_get_all: 6 (1.6%),
        b_comp_prob: 2.2 (0.6%), b_tok_touch_all: 38 (10.4%), b_finish: 1.36
        (0.4%), tests_pri_0: 211 (58.1%), check_dkim_signature: 1.60 (0.4%),
        check_dkim_adsp: 3.9 (1.1%), poll_dns_idle: 0.70 (0.2%), tests_pri_10:
        2.4 (0.7%), tests_pri_500: 44 (12.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 0/2] proc: Calling proc_flush_task exactly once per task
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 04/22, Eric W. Biederman wrote:
>>
>> Eric W. Biederman (2):
>>       proc: Use PIDTYPE_TGID in next_tgid
>>       proc: Ensure we see the exit of each process tid exactly once
>>
>>  fs/exec.c           |  5 +----
>>  fs/proc/base.c      | 16 ++--------------
>>  include/linux/pid.h |  1 +
>>  kernel/pid.c        | 16 ++++++++++++++++
>>  4 files changed, 20 insertions(+), 18 deletions(-)
>>
>> ---
>> Oleg if these look good I will add these onto my branch of proc changes
>> that includes Alexey's changes.
>
> Eric, sorry, where can I find these 2 patches?

Did I not post them?  Apologies.  I will post them now.

Eric
