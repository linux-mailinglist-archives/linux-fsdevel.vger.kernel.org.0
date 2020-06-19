Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 256F5201A70
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jun 2020 20:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388118AbgFSSes (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jun 2020 14:34:48 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:38886 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728430AbgFSSes (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jun 2020 14:34:48 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jmLqg-000426-8F; Fri, 19 Jun 2020 12:34:46 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jmLqf-0001Rb-Kl; Fri, 19 Jun 2020 12:34:46 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
cc:     <linux-fsdevel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>
Date:   Fri, 19 Jun 2020 13:30:27 -0500
Message-ID: <87pn9u6h8c.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jmLqf-0001Rb-Kl;;;mid=<87pn9u6h8c.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18qwTHJT1MKfbD5hUOoLqPHzZFLUB6QM18=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4964]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa03 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 253 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.5 (1.4%), b_tie_ro: 2.5 (1.0%), parse: 0.85
        (0.3%), extract_message_metadata: 2.5 (1.0%), get_uri_detail_list:
        0.62 (0.2%), tests_pri_-1000: 4.4 (1.7%), tests_pri_-950: 1.38 (0.5%),
        tests_pri_-900: 1.12 (0.4%), tests_pri_-90: 80 (31.7%), check_bayes:
        79 (31.1%), b_tokenize: 5 (2.1%), b_tok_get_all: 4.5 (1.8%),
        b_comp_prob: 1.95 (0.8%), b_tok_touch_all: 64 (25.3%), b_finish: 0.79
        (0.3%), tests_pri_0: 143 (56.7%), check_dkim_signature: 0.34 (0.1%),
        check_dkim_adsp: 3.1 (1.2%), poll_dns_idle: 1.08 (0.4%), tests_pri_10:
        1.66 (0.7%), tests_pri_500: 5 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 0/2] exec: s/group_exit_task/group_exec_task/ for clarity
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


I am hoping to be able to stop all of the threads at the beginning of
exec so we can write the exec code as if it is single threaded.   That
is hard but cleanups to enable that change are easy.

There is a variable tsk->signal->group_exit_task that is only truly
used in de_thread.  The changes clean up the coredump code and
rename the variable to make it clear that exec is it's only user.

Eric W. Biederman (2):
      exec: Don't set group_exit_task during a coredump
      exec: Rename group_exit_task group_exec_task and correct the Documentation

 fs/coredump.c                |  2 --
 fs/exec.c                    |  8 ++++----
 include/linux/sched/signal.h | 15 ++++++---------
 kernel/exit.c                |  4 ++--
 4 files changed, 12 insertions(+), 17 deletions(-)

