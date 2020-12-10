Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F02EE2D667C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Dec 2020 20:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393431AbgLJTae (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Dec 2020 14:30:34 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:49746 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393436AbgLJTad (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Dec 2020 14:30:33 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1knRdL-003Miz-OI; Thu, 10 Dec 2020 12:29:47 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1knRdK-0006sF-Uo; Thu, 10 Dec 2020 12:29:47 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jann@thejh.net>
References: <20201120231441.29911-15-ebiederm@xmission.com>
        <20201207232900.GD4115853@ZenIV.linux.org.uk>
        <877dprvs8e.fsf@x220.int.ebiederm.org>
        <20201209040731.GK3579531@ZenIV.linux.org.uk>
        <877dprtxly.fsf@x220.int.ebiederm.org>
        <20201209142359.GN3579531@ZenIV.linux.org.uk>
        <87o8j2svnt.fsf_-_@x220.int.ebiederm.org>
        <CAHk-=wiUMHBHmmDS3_Xqh1wfGFyd_rdDmpZzk0cODoj1i7_VOA@mail.gmail.com>
        <20201209195033.GP3579531@ZenIV.linux.org.uk>
        <87sg8er7gp.fsf@x220.int.ebiederm.org>
        <20201210061304.GS3579531@ZenIV.linux.org.uk>
Date:   Thu, 10 Dec 2020 13:29:01 -0600
In-Reply-To: <20201210061304.GS3579531@ZenIV.linux.org.uk> (Al Viro's message
        of "Thu, 10 Dec 2020 06:13:04 +0000")
Message-ID: <87h7oto3ya.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1knRdK-0006sF-Uo;;;mid=<87h7oto3ya.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19ZiLRNiJsD/mS47Qcr/W9aaoCcvplKFwU=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XM_B_SpammyWords
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4998]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Al Viro <viro@zeniv.linux.org.uk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 558 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 9 (1.6%), b_tie_ro: 7 (1.3%), parse: 1.57 (0.3%),
        extract_message_metadata: 25 (4.5%), get_uri_detail_list: 3.4 (0.6%),
        tests_pri_-1000: 17 (3.1%), tests_pri_-950: 1.31 (0.2%),
        tests_pri_-900: 1.11 (0.2%), tests_pri_-90: 131 (23.4%), check_bayes:
        129 (23.0%), b_tokenize: 9 (1.6%), b_tok_get_all: 9 (1.6%),
        b_comp_prob: 3.3 (0.6%), b_tok_touch_all: 103 (18.4%), b_finish: 0.94
        (0.2%), tests_pri_0: 289 (51.7%), check_dkim_signature: 0.54 (0.1%),
        check_dkim_adsp: 2.7 (0.5%), poll_dns_idle: 65 (11.7%), tests_pri_10:
        2.1 (0.4%), tests_pri_500: 77 (13.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] files: rcu free files_struct
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> writes:

> On Wed, Dec 09, 2020 at 03:32:38PM -0600, Eric W. Biederman wrote:
>> Al Viro <viro@zeniv.linux.org.uk> writes:
>> 
>> > On Wed, Dec 09, 2020 at 11:13:38AM -0800, Linus Torvalds wrote:
>> >> On Wed, Dec 9, 2020 at 10:05 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>> >> >
>> >> > -                               struct file * file = xchg(&fdt->fd[i], NULL);
>> >> > +                               struct file * file = fdt->fd[i];
>> >> >                                 if (file) {
>> >> > +                                       rcu_assign_pointer(fdt->fd[i], NULL);
>> >> 
>> >> This makes me nervous. Why did we use to do that xchg() there? That
>> >> has atomicity guarantees that now are gone.
>> >> 
>> >> Now, this whole thing should be called for just the last ref of the fd
>> >> table, so presumably that atomicity was never needed in the first
>> >> place. But the fact that we did that very expensive xchg() then makes
>> >> me go "there's some reason for it".
>> >> 
>> >> Is this xchg() just bogus historical leftover? It kind of looks that
>> >> way. But maybe that change should be done separately?
>> >
>> > I'm still not convinced that exposing close_files() to parallel
>> > 3rd-party accesses is safe in all cases, so this patch still needs
>> > more analysis.
>> 
>> That is fine.  I just wanted to post the latest version so we could
>> continue the discussion.  Especially with comments etc.
>
> It's probably safe.  I've spent today digging through the mess in
> fs/notify and kernel/bpf, and while I'm disgusted with both, at
> that point I believe that close_files() exposure is not going to
> create problems with either.  And xchg() in there _is_ useless.

Then I will work on a cleaned up version.

> Said that, BPF "file iterator" stuff is potentially very unpleasant -
> it allows to pin a struct file found in any process' descriptor table
> indefinitely long.  Temporary struct file references grabbed by procfs
> code, while unfortunate, are at least short-lived; with this stuff sky's
> the limit.
>
> I'm not happy about having that available, especially if it's a user-visible
> primitive we can't withdraw at zero notice ;-/
>
> What are the users of that thing and is there any chance to replace it
> with something saner?  IOW, what *is* realistically called for each
> struct file by the users of that iterator?

The bpf guys are no longer Cc'd and they can probably answer better than
I.

In a previous conversation it was mentioned that task_iter was supposed
to be a high performance interface for getting proc like data out of the
kernel using bpf.

If so I think that handles the lifetime issues as bpf programs are
supposed to be short-lived and can not pass references anywhere.

On the flip side it raises the question did the BPF guys just make the
current layout of task_struct and struct file part of the linux kernel
user space ABI?

Eric


