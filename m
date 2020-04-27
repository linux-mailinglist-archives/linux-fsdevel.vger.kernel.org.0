Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0187B1BAF72
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 22:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgD0U1R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 16:27:17 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:38562 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbgD0U1Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 16:27:16 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jTALP-0002P1-Fx; Mon, 27 Apr 2020 14:27:11 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jTALO-0000RH-Fn; Mon, 27 Apr 2020 14:27:11 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200419141057.621356-1-gladkov.alexey@gmail.com>
        <87ftcv1nqe.fsf@x220.int.ebiederm.org>
        <87wo66vvnm.fsf_-_@x220.int.ebiederm.org>
        <20200424173927.GB26802@redhat.com>
        <87mu6ymkea.fsf_-_@x220.int.ebiederm.org>
        <87r1w8ete7.fsf@x220.int.ebiederm.org>
Date:   Mon, 27 Apr 2020 15:23:57 -0500
In-Reply-To: <87r1w8ete7.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Mon, 27 Apr 2020 12:21:52 -0500")
Message-ID: <87v9lkbrtu.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jTALO-0000RH-Fn;;;mid=<87v9lkbrtu.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+rFpxBVGQYkwi+81h5QUMxWKfMmzPUaw8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4827]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 563 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.2 (0.7%), b_tie_ro: 3.0 (0.5%), parse: 0.63
        (0.1%), extract_message_metadata: 9 (1.5%), get_uri_detail_list: 0.55
        (0.1%), tests_pri_-1000: 11 (2.0%), tests_pri_-950: 1.06 (0.2%),
        tests_pri_-900: 0.81 (0.1%), tests_pri_-90: 390 (69.4%), check_bayes:
        389 (69.2%), b_tokenize: 3.7 (0.7%), b_tok_get_all: 254 (45.1%),
        b_comp_prob: 1.25 (0.2%), b_tok_touch_all: 127 (22.6%), b_finish: 0.83
        (0.1%), tests_pri_0: 136 (24.2%), check_dkim_signature: 0.35 (0.1%),
        check_dkim_adsp: 2.3 (0.4%), poll_dns_idle: 0.89 (0.2%), tests_pri_10:
        1.74 (0.3%), tests_pri_500: 5 (0.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v3] proc: Ensure we see the exit of each process tid exactly
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:
> Take a good look over the code base and see if I can see any more
> issues like was found in next_tgid and repost the core patches.

Oleg,

I am reading through kernel/ptrace.c and I am seeing a lot of:

	spin_lock(&child->sighand->siglock);

In places where I don't see anything guaranteeing the child is stopped
such as ptrace_freeze_traced.  Are all of those places safe or
do some of the need to be transformed into lock_task_sighand in
case the process is current running?

I might just be reading the code to quickly and missing what keeps the
code from executing exec and changing sighand.

Eric
