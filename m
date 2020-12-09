Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACAA92D4D43
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 23:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388528AbgLIWGV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 17:06:21 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:55764 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729913AbgLIWGG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 17:06:06 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kn7aO-005WVg-0Y; Wed, 09 Dec 2020 15:05:24 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1kn7aN-000401-6k; Wed, 09 Dec 2020 15:05:23 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jann@thejh.net>
References: <87r1on1v62.fsf@x220.int.ebiederm.org>
        <20201120231441.29911-15-ebiederm@xmission.com>
        <20201207232900.GD4115853@ZenIV.linux.org.uk>
        <877dprvs8e.fsf@x220.int.ebiederm.org>
        <20201209040731.GK3579531@ZenIV.linux.org.uk>
        <877dprtxly.fsf@x220.int.ebiederm.org>
        <20201209142359.GN3579531@ZenIV.linux.org.uk>
        <87o8j2svnt.fsf_-_@x220.int.ebiederm.org>
        <CAHk-=wiUMHBHmmDS3_Xqh1wfGFyd_rdDmpZzk0cODoj1i7_VOA@mail.gmail.com>
Date:   Wed, 09 Dec 2020 16:04:44 -0600
In-Reply-To: <CAHk-=wiUMHBHmmDS3_Xqh1wfGFyd_rdDmpZzk0cODoj1i7_VOA@mail.gmail.com>
        (Linus Torvalds's message of "Wed, 9 Dec 2020 11:13:38 -0800")
Message-ID: <87eejyprer.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kn7aN-000401-6k;;;mid=<87eejyprer.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/+PqrkfZvGQ+wGIDdWEx2/OaAfcYGrrPY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XM_B_SpammyWords
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 530 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 11 (2.2%), b_tie_ro: 10 (1.9%), parse: 1.22
        (0.2%), extract_message_metadata: 23 (4.2%), get_uri_detail_list: 1.67
        (0.3%), tests_pri_-1000: 39 (7.4%), tests_pri_-950: 2.3 (0.4%),
        tests_pri_-900: 2.0 (0.4%), tests_pri_-90: 212 (40.1%), check_bayes:
        209 (39.4%), b_tokenize: 9 (1.8%), b_tok_get_all: 7 (1.3%),
        b_comp_prob: 2.4 (0.4%), b_tok_touch_all: 186 (35.1%), b_finish: 0.99
        (0.2%), tests_pri_0: 225 (42.5%), check_dkim_signature: 1.42 (0.3%),
        check_dkim_adsp: 2.9 (0.5%), poll_dns_idle: 0.33 (0.1%), tests_pri_10:
        2.1 (0.4%), tests_pri_500: 7 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] files: rcu free files_struct
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, Dec 9, 2020 at 10:05 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> -                               struct file * file = xchg(&fdt->fd[i], NULL);
>> +                               struct file * file = fdt->fd[i];
>>                                 if (file) {
>> +                                       rcu_assign_pointer(fdt->fd[i], NULL);
>
> This makes me nervous. Why did we use to do that xchg() there? That
> has atomicity guarantees that now are gone.
>
> Now, this whole thing should be called for just the last ref of the fd
> table, so presumably that atomicity was never needed in the first
> place. But the fact that we did that very expensive xchg() then makes
> me go "there's some reason for it".
>
> Is this xchg() just bogus historical leftover? It kind of looks that
> way. But maybe that change should be done separately?

Removing the xchg in a separate patch seems reasonable.  Just to make
the review easier.

I traced the xchg back to 7cf4dc3c8dbf ("move files_struct-related bits
from kernel/exit.c to fs/file.c") when put_files_struct was introduced.
The xchg did not exist before that change.

There were many other xchgs in the code back then so I suspect was left
over from some way an earlier version of the change worked and simply
was not removed when the patch was updated.

Eric
