Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4784838B7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jan 2022 23:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiACWLv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jan 2022 17:11:51 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:33930 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiACWLv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jan 2022 17:11:51 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:43928)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n4VYR-008zVt-Le; Mon, 03 Jan 2022 15:11:47 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:55768 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n4VYQ-0075Jo-Hl; Mon, 03 Jan 2022 15:11:47 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Wander Lairson Costa <wander@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Laurent Vivier <laurent@vivier.eu>,
        YunQiang Su <ysu@wavecomp.com>, Helge Deller <deller@gmx.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexey Gladkov <legion@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Rolf Eike Beer <eb@emlix.com>,
        linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and
        infrastructure)), linux-kernel@vger.kernel.org (open list),
        Waiman Long <longman@redhat.com>, Willy Tarreau <w@1wt.eu>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20211228170910.623156-1-wander@redhat.com>
Date:   Mon, 03 Jan 2022 16:11:38 -0600
In-Reply-To: <20211228170910.623156-1-wander@redhat.com> (Wander Lairson
        Costa's message of "Tue, 28 Dec 2021 14:09:04 -0300")
Message-ID: <87ilv0mput.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1n4VYQ-0075Jo-Hl;;;mid=<87ilv0mput.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18BzvDNT5e79GWdYRWUBVpXx3PYqjnnOyo=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Wander Lairson Costa <wander@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 476 ms - load_scoreonly_sql: 0.09 (0.0%),
        signal_user_changed: 11 (2.4%), b_tie_ro: 10 (2.0%), parse: 1.33
        (0.3%), extract_message_metadata: 5 (1.1%), get_uri_detail_list: 2.7
        (0.6%), tests_pri_-1000: 6 (1.3%), tests_pri_-950: 1.40 (0.3%),
        tests_pri_-900: 1.12 (0.2%), tests_pri_-90: 67 (14.0%), check_bayes:
        65 (13.6%), b_tokenize: 12 (2.5%), b_tok_get_all: 12 (2.5%),
        b_comp_prob: 3.8 (0.8%), b_tok_touch_all: 33 (7.0%), b_finish: 0.93
        (0.2%), tests_pri_0: 362 (76.0%), check_dkim_signature: 0.78 (0.2%),
        check_dkim_adsp: 3.0 (0.6%), poll_dns_idle: 1.02 (0.2%), tests_pri_10:
        1.91 (0.4%), tests_pri_500: 10 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH RFC v2 0/4] coredump: mitigate privilege escalation of process coredump
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Wander Lairson Costa <wander@redhat.com> writes:

Have you seen the discussion at:
https://lkml.kernel.org/r/20211221021744.864115-1-longman@redhat.com
?

Adding a few people from that conversation.

> v2
> ==
>
> Patch 02 conflicted with commit 92307383082d("coredump:  Don't perform
> any cleanups before dumping core") which I didn't have in my tree. V2
> just changes the hunk
>
> +#define PF_SUID   0x00000008
>
> To
>
> +#define PF_SUID   0x01000000
>
> To merge cleanly. Other than that, it is the same patch as v1.
>
> v1
> ==
>
> A set-uid executable might be a vector to privilege escalation if the
> system configures the coredump file name pattern as a relative
> directory destiny. The full description of the vulnerability and
> a demonstration of how we can exploit it can be found at [1].
>
> This patch series adds a PF_SUID flag to the process in execve if it is
> set-[ug]id binary and elevates the new image's privileges.
>
> In the do_coredump function, we check if:
>
> 1) We have the SUID_FLAG set
> 2) We have CAP_SYS_ADMIN (the process might have decreased its
>    privileges)
> 3) The current directory is owned by root (the current code already
>    checks for core_pattern being a relative path).
> 4) non-privileged users don't have permission to write to the current
>    directory.

Which is a slightly different approach than we have discussed
previously.

Something persistent to mark the processes descended from the suid exec
is something commonly agreed upon.

How we can dump core after that (with the least disruption is the
remaining question).

You would always allow coredumps unless the target directory is
problematic.  I remember it being suggested that even dumping to a pipe
might not be safe in practice.  Can someone remember why?

The other approach we have discussed is simply not allowing coredumps
unless the target process takes appropriate action to reenable them.

Willy posted a patch to that effect.


From a proof of concept perspective PF_SUID and your directory checks look
like fine.  From a production implementation standpoint I think we would
want to make them a bit more general.  PF_SUID because it is more than
uid changes that can grant privilege during exec.  We especially want to
watch out for setcap executables.  The directory checks similarly look
very inflexible.  I think what we want is to test if the process before
the privilege change of the exec could write to the directory.

Even with your directory test approach you are going to run into
the semi-common idio of becomming root and then starting a daemon
in debugging mode so you can get a core dump.

> If all four conditions match, we set the need_suid_safe flag.
>
> An alternative implementation (and more elegant IMO) would be saving
> the fsuid and fsgid of the process in the task_struct before loading the
> new image to the memory. But this approach would add eight bytes to all
> task_struct instances where only a tiny fraction of the processes need
> it and under a configuration that not all (most?) distributions don't
> adopt by default.

One possibility is to save a struct cred on the mm_struct.  If done
carefully I think that would allow commit_creds to avoid the need
for dumpability changes (there would always be enough information to
directly compute it).

I can see that working for detecting dropped privileges.  I don't know
if that would work for raised privileges.

Definitely focusing in on the mm_struct for where to save the needed
information seems preferable, as in general it is an mm property not a
per task property.

Eric



> Wander Lairson Costa (4):
>   exec: add a flag indicating if an exec file is a suid/sgid
>   process: add the PF_SUID flag
>   coredump: mitigate privilege escalation of process coredump
>   exec: only set the suid flag if the current proc isn't root
>
>  fs/coredump.c           | 15 +++++++++++++++
>  fs/exec.c               | 10 ++++++++++
>  include/linux/binfmts.h |  6 +++++-
>  include/linux/sched.h   |  1 +
>  kernel/fork.c           |  2 ++
>  5 files changed, 33 insertions(+), 1 deletion(-)
