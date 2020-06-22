Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23AB5203C76
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jun 2020 18:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729522AbgFVQYf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jun 2020 12:24:35 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:59208 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729479AbgFVQYe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jun 2020 12:24:34 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jnPFJ-0001B5-RR; Mon, 22 Jun 2020 10:24:33 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jnPFI-00036S-V4; Mon, 22 Jun 2020 10:24:33 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>
References: <87pn9u6h8c.fsf@x220.int.ebiederm.org>
        <87k1026h4x.fsf@x220.int.ebiederm.org>
        <CAHk-=wgczNRMP-DK3Ga-e_HXvZMBbQNxthdGt=MqMZ0CFDHHcg@mail.gmail.com>
Date:   Mon, 22 Jun 2020 11:20:11 -0500
In-Reply-To: <CAHk-=wgczNRMP-DK3Ga-e_HXvZMBbQNxthdGt=MqMZ0CFDHHcg@mail.gmail.com>
        (Linus Torvalds's message of "Sat, 20 Jun 2020 11:58:13 -0700")
Message-ID: <87eeq7xebo.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jnPFI-00036S-V4;;;mid=<87eeq7xebo.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+6wsbR3bkAf75/oFgf7QvXKVQ+hcFeirM=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMNoVowels,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa05 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 452 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 10 (2.3%), b_tie_ro: 9 (2.0%), parse: 0.82 (0.2%),
         extract_message_metadata: 14 (3.1%), get_uri_detail_list: 1.01 (0.2%),
         tests_pri_-1000: 15 (3.3%), tests_pri_-950: 1.21 (0.3%),
        tests_pri_-900: 0.93 (0.2%), tests_pri_-90: 81 (17.9%), check_bayes:
        80 (17.6%), b_tokenize: 6 (1.2%), b_tok_get_all: 5 (1.2%),
        b_comp_prob: 1.72 (0.4%), b_tok_touch_all: 64 (14.1%), b_finish: 0.85
        (0.2%), tests_pri_0: 317 (70.2%), check_dkim_signature: 0.49 (0.1%),
        check_dkim_adsp: 2.1 (0.5%), poll_dns_idle: 0.65 (0.1%), tests_pri_10:
        1.66 (0.4%), tests_pri_500: 7 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/2] exec: Don't set group_exit_task during a coredump
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, Jun 19, 2020 at 11:36 AM Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>>
>> Instead test SIGNAL_GROUP_COREDUMP in signal_group_exit().
>
> You say "instead", but the patch itself doesn't agree:
>
>>  static inline int signal_group_exit(const struct signal_struct *sig)
>>  {
>> -       return  (sig->flags & SIGNAL_GROUP_EXIT) ||
>> +       return  (sig->flags & (SIGNAL_GROUP_EXIT | SIGNAL_GROUP_COREDUMP)) ||
>>                 (sig->group_exit_task != NULL);
>>  }
>
> it does it _in_addition_to_.

Hmm.  I think I can change that line to:
>> Instead add a test for SIGNAL_GROUP_COREDUMP in signal_group_exit().

Does that read better?

> I think the whole test for "sig->group_exit_task != NULL" should be
> removed for this commit to make sense.

The code change is designed not to have a behavioral change in
signal_group_exit().  As de_thread also sets sig->group_exit_task
the test for sig->group_exit_task needs to remain in signal_group_exit()
for the behavior of signal_group_exit() to remain unchanged.



Why do you think the test sig->group_exit_task != NULL should be removed
for the commit to make sense?

Eric
