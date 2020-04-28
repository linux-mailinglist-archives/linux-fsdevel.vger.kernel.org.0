Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E081BBD61
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 14:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgD1MUJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 08:20:09 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:52580 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgD1MUJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 08:20:09 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jTPDT-0006cz-Aw; Tue, 28 Apr 2020 06:19:59 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jTPDS-00016K-Gn; Tue, 28 Apr 2020 06:19:59 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>
References: <20200419141057.621356-1-gladkov.alexey@gmail.com>
        <87ftcv1nqe.fsf@x220.int.ebiederm.org>
        <87wo66vvnm.fsf_-_@x220.int.ebiederm.org>
        <20200424173927.GB26802@redhat.com>
        <87mu6ymkea.fsf_-_@x220.int.ebiederm.org>
        <875zdmmj4y.fsf_-_@x220.int.ebiederm.org>
        <CAHk-=whvktUC9VbzWLDw71BHbV4ofkkuAYsrB5Rmxnhc-=kSeQ@mail.gmail.com>
        <878sihgfzh.fsf@x220.int.ebiederm.org>
        <CAHk-=wjSM9mgsDuX=ZTy2L+S7wGrxZMcBn054As_Jyv8FQvcvQ@mail.gmail.com>
Date:   Tue, 28 Apr 2020 07:16:44 -0500
In-Reply-To: <CAHk-=wjSM9mgsDuX=ZTy2L+S7wGrxZMcBn054As_Jyv8FQvcvQ@mail.gmail.com>
        (Linus Torvalds's message of "Mon, 27 Apr 2020 13:27:40 -0700")
Message-ID: <87sggnajpv.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jTPDS-00016K-Gn;;;mid=<87sggnajpv.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+Ca6+ElOCctvOcWA7bIRbvwRUv+5ClZTc=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4485]
        *  0.7 XMSubLong Long Subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 378 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 11 (2.9%), b_tie_ro: 9 (2.5%), parse: 0.99 (0.3%),
         extract_message_metadata: 3.4 (0.9%), get_uri_detail_list: 1.18
        (0.3%), tests_pri_-1000: 4.0 (1.0%), tests_pri_-950: 1.26 (0.3%),
        tests_pri_-900: 1.02 (0.3%), tests_pri_-90: 115 (30.4%), check_bayes:
        113 (30.0%), b_tokenize: 7 (1.8%), b_tok_get_all: 17 (4.5%),
        b_comp_prob: 2.3 (0.6%), b_tok_touch_all: 83 (22.0%), b_finish: 1.12
        (0.3%), tests_pri_0: 219 (58.0%), check_dkim_signature: 0.62 (0.2%),
        check_dkim_adsp: 2.5 (0.7%), poll_dns_idle: 0.73 (0.2%), tests_pri_10:
        2.7 (0.7%), tests_pri_500: 12 (3.1%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v4 0/2] proc: Ensure we see the exit of each process tid exactly
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


In the work to remove proc_mnt I noticed that we were calling
proc_flush_task now proc_flush_pid possibly multiple times for the same
pid because of how de_thread works.

This is a bare minimal patchset to sort out de_thread, by introducing
exchange_tids and the helper of exchange_tids hlists_swap_heads_rcu.

The actual call of exchange_tids should be slowpath so I have
prioritized readability over getting every last drop of performance.

I have also read through a bunch of the code to see if I could find
anything that would be affected by this change.  Users of
has_group_leader_pid were a good canidates.  But I also looked at other
cases that might have a pid->task->pid transition.  I ignored other
sources of races with de_thread and exec as those are preexisting.

I found a close call with send_signals user of task_active_pid_ns, but
all pids of a thread group are guaranteeds to be in the same pid
namespace so there is not a problem.

I found a few pieces of debugging code that do:

	task = pid_task(pid, PIDTYPE_PID);
        if (task) {
        	printk("%u\n", task->pid);
        }

But I can't see how we care if it happens at the wrong moment that
task->pid might not match pid_nr(pid);

Similarly because the code in posix-cpu-timers goes pid->task->pid it
feels like there should be a problem.  But as the code that works with
PIDTYPE_PID is only available within the thread group, and as de_thread
kills all of the other threads before it makes any changes of this
kind the race can not happen.

In short I don't think this change will introduce any regressions.

Eric W. Biederman (2):
      rculist: Add hlists_swap_heads_rcu
      proc: Ensure we see the exit of each process tid exactly once

 fs/exec.c               |  5 +----
 include/linux/pid.h     |  1 +
 include/linux/rculist.h | 21 +++++++++++++++++++++
 kernel/pid.c            | 19 +++++++++++++++++++
 4 files changed, 42 insertions(+), 4 deletions(-)

Eric
