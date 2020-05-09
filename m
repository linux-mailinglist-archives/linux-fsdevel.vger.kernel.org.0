Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3CAC1CC22B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 May 2020 16:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgEIOUo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 May 2020 10:20:44 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:50696 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbgEIOUo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 May 2020 10:20:44 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jXQLJ-0006Tb-Ur; Sat, 09 May 2020 08:20:41 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jXQLI-0001r0-SE; Sat, 09 May 2020 08:20:41 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
        <87sgga6ze4.fsf@x220.int.ebiederm.org>
        <875zd66za3.fsf_-_@x220.int.ebiederm.org>
        <202005082213.8BDD4AC0CC@keescook>
Date:   Sat, 09 May 2020 09:17:11 -0500
In-Reply-To: <202005082213.8BDD4AC0CC@keescook> (Kees Cook's message of "Fri,
        8 May 2020 22:15:43 -0700")
Message-ID: <87tv0p2nx4.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jXQLI-0001r0-SE;;;mid=<87tv0p2nx4.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18A1U/jWwxjIXHnvSgRraar1VS0tQcBrZU=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa07 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 446 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 10 (2.3%), b_tie_ro: 9 (2.0%), parse: 0.85 (0.2%),
         extract_message_metadata: 11 (2.5%), get_uri_detail_list: 1.07 (0.2%),
         tests_pri_-1000: 5 (1.2%), tests_pri_-950: 1.30 (0.3%),
        tests_pri_-900: 1.06 (0.2%), tests_pri_-90: 177 (39.6%), check_bayes:
        163 (36.4%), b_tokenize: 8 (1.9%), b_tok_get_all: 7 (1.5%),
        b_comp_prob: 3.2 (0.7%), b_tok_touch_all: 140 (31.4%), b_finish: 1.13
        (0.3%), tests_pri_0: 224 (50.2%), check_dkim_signature: 0.53 (0.1%),
        check_dkim_adsp: 2.8 (0.6%), poll_dns_idle: 1.19 (0.3%), tests_pri_10:
        3.2 (0.7%), tests_pri_500: 9 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 4/6] exec: Run sync_mm_rss before taking exec_update_mutex
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> $ git grep exec_mm_release
> fs/exec.c:      exec_mm_release(tsk, old_mm);
> include/linux/sched/mm.h:extern void exec_mm_release(struct task_struct *, struct mm_struct *);
> kernel/fork.c:void exec_mm_release(struct task_struct *tsk, struct mm_struct *mm)
>
> kernel/fork.c:
>
> void exit_mm_release(struct task_struct *tsk, struct mm_struct *mm)
> {
>         futex_exit_release(tsk);
>         mm_release(tsk, mm);
> }
>
> void exec_mm_release(struct task_struct *tsk, struct mm_struct *mm)
> {
>         futex_exec_release(tsk);
>         mm_release(tsk, mm);
> }
>
> $ git grep exit_mm_release
> include/linux/sched/mm.h:extern void exit_mm_release(struct task_struct *, struct mm_struct *);
> kernel/exit.c:  exit_mm_release(current, mm);
> kernel/fork.c:void exit_mm_release(struct task_struct *tsk, struct mm_struct *mm)
>
> kernel/exit.c:
>
>         exit_mm_release(current, mm);
>         if (!mm)
>                 return;
>         sync_mm_rss(mm);
>
> It looks to me like both exec_mm_release() and exit_mm_release() could
> easily have the sync_mm_rss(...) folded into their function bodies and
> removed from the callers. *shrug*

Well it would have to be all of:
	if (mm) 
		sync_mm_rss(mm);

I remember reading through exit_mm_release and seeing that nothing
actually depended upon a non-NULL mm. Unless you have clear_child_tid
set.

I am not up to speed on that part of the mm layer right now to know if
it is a good idea to put sync_mm_rss in exit_mm_release but at a quick
look it feels like it.

Eric

