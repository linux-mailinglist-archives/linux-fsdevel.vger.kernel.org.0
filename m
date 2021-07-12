Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B83C3C64AA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 22:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbhGLUG0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 16:06:26 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:44984 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233686AbhGLUGZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 16:06:25 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1m329P-00GBKY-Tg; Mon, 12 Jul 2021 14:03:35 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:60510 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1m329O-002iY0-KP; Mon, 12 Jul 2021 14:03:35 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kalesh Singh <kaleshsingh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Android Kernel Team <kernel-team@android.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20210708155647.44208-1-kaleshsingh@google.com>
        <CAHk-=whDkekE8n2LdPiKHeTdRnV--ys0V0nPZ76oPaE0fn-d+g@mail.gmail.com>
Date:   Mon, 12 Jul 2021 15:02:38 -0500
In-Reply-To: <CAHk-=whDkekE8n2LdPiKHeTdRnV--ys0V0nPZ76oPaE0fn-d+g@mail.gmail.com>
        (Linus Torvalds's message of "Sat, 10 Jul 2021 11:21:34 -0700")
Message-ID: <87czrn8fmp.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1m329O-002iY0-KP;;;mid=<87czrn8fmp.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+kWxupuXErFY3jJxeNcvha9YzdyoVp6Nk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4763]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 520 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 10 (2.0%), b_tie_ro: 9 (1.7%), parse: 0.90 (0.2%),
         extract_message_metadata: 12 (2.3%), get_uri_detail_list: 1.74 (0.3%),
         tests_pri_-1000: 5 (1.0%), tests_pri_-950: 1.22 (0.2%),
        tests_pri_-900: 1.00 (0.2%), tests_pri_-90: 119 (22.8%), check_bayes:
        108 (20.7%), b_tokenize: 8 (1.5%), b_tok_get_all: 8 (1.5%),
        b_comp_prob: 2.5 (0.5%), b_tok_touch_all: 86 (16.5%), b_finish: 0.92
        (0.2%), tests_pri_0: 358 (68.8%), check_dkim_signature: 0.52 (0.1%),
        check_dkim_adsp: 2.7 (0.5%), poll_dns_idle: 1.01 (0.2%), tests_pri_10:
        2.2 (0.4%), tests_pri_500: 7 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] procfs: Prevent unpriveleged processes accessing fdinfo
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, Jul 8, 2021 at 8:57 AM Kalesh Singh <kaleshsingh@google.com> wrote:
>>
>> The file permissions on the fdinfo dir from were changed from
>> S_IRUSR|S_IXUSR to S_IRUGO|S_IXUGO, and a PTRACE_MODE_READ check was
>> added for opening the fdinfo files [1]. However, the ptrace permission
>> check was not added to the directory, allowing anyone to get the open FD
>> numbers by reading the fdinfo directory.
>>
>> Add the missing ptrace permission check for opening the fdinfo directory.
>
> The more I look at this, the more I feel like we should look at
> instead changing how "get_proc_task()" works.

The practical implementation that I can see is to add a
exec_id attribute into the proc inode and to modify proc_pid_make_inode
to take a new exec_id parameter.

There are some directories like /proc/PPP/, /proc/PPP/task/TTT/,
/proc/PPP/net where it is both safe and appropriate to allow caching the
reference over a suid exec.

To handle that I would have a flag somewhere (possibly a special exec_id
value) that indicates we don't care about the exec id.

Once get_proc_task is taught to handle both cases and the appropriate
exec_id is passed to proc_pid_make_inode proc_pid_invalidate works
automatically.  So I think that is all we really need to do.

> That's one of the core functions for /proc, and I wonder if we
> couldn't just make it refuse to look up a task that has gone through a
> suid execve() since the proc inode was opened.
>
> I don't think it's basically ever ok to open something for one thread,
> and then use it after the thread has gone through a suid thing.
>
> In fact, I wonder if we could make it even stricter, and go "any exec
> at all", but I think a suid exec might be the minimum we should do.
>
> Then the logic really becomes very simple: we did the permission
> checks at open time (like UNIX permission checks should be done), and
> "get_proc_task()" basically verifies that "yeah, that open-time
> decision is still valid".
>
> Wouldn't that make a lot of sense?

Roughly.  I want to use reuse exec_id but that seems a bit strong for
have the permissions changed.  Checking ->cred is too sensitive.
So it is a bit fiddly to get right.

Limiting this to suid-exec (and equivalent) seems like the proper
filter, because it is when the permissions have fundamentally changed.

I just don't think this should be blanket for everything that uses
get_prock_task.

Eric
