Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A68702309DC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 14:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbgG1MVs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 08:21:48 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:36608 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728458AbgG1MVs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:21:48 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1k0Oc4-0000u9-90; Tue, 28 Jul 2020 06:21:44 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k0Oc3-000583-HD; Tue, 28 Jul 2020 06:21:44 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-fsdevel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        linux-pm@vger.kernel.org
References: <87h7tsllgw.fsf@x220.int.ebiederm.org>
        <20200728092359.jrv7ygt6dwktwsgp@yavin.dot.cyphar.com>
Date:   Tue, 28 Jul 2020 07:18:37 -0500
In-Reply-To: <20200728092359.jrv7ygt6dwktwsgp@yavin.dot.cyphar.com> (Aleksa
        Sarai's message of "Tue, 28 Jul 2020 19:41:09 +1000")
Message-ID: <87bljzkf36.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1k0Oc3-000583-HD;;;mid=<87bljzkf36.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/ELoIme8I02gfNTorAJ93bwztnllU2YKA=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa07 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Aleksa Sarai <cyphar@cyphar.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 377 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 9 (2.5%), b_tie_ro: 8 (2.1%), parse: 0.80 (0.2%),
        extract_message_metadata: 14 (3.7%), get_uri_detail_list: 1.16 (0.3%),
        tests_pri_-1000: 15 (3.9%), tests_pri_-950: 1.30 (0.3%),
        tests_pri_-900: 1.13 (0.3%), tests_pri_-90: 82 (21.6%), check_bayes:
        80 (21.1%), b_tokenize: 7 (1.8%), b_tok_get_all: 6 (1.6%),
        b_comp_prob: 2.3 (0.6%), b_tok_touch_all: 61 (16.0%), b_finish: 1.04
        (0.3%), tests_pri_0: 239 (63.2%), check_dkim_signature: 0.77 (0.2%),
        check_dkim_adsp: 2.5 (0.7%), poll_dns_idle: 0.49 (0.1%), tests_pri_10:
        3.5 (0.9%), tests_pri_500: 9 (2.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC][PATCH] exec: Freeze the other threads during a multi-threaded exec
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Aleksa Sarai <cyphar@cyphar.com> writes:

> On 2020-07-27, Eric W. Biederman <ebiederm@xmission.com> wrote:
>> To the best of my knowledge processes with more than one thread
>> calling exec are not common, and as all of the threads will be killed
>> by exec there does not appear to be any useful work a thread can
>> reliably do during exec.
>
> Every Go program which calls exec (this includes runc, Docker, LXD,
> Kubernetes, et al) fills the niche of "multi-threaded program that calls
> exec" -- all Go programs are multi-threaded and there's no way of
> disabling this. This will most likely cause pretty bad performance
> regression for basically all container workloads.

So it is a good point that container runtimes use Go, and that
fundamentally anything that uses Go will be multi-threaded.  Having just
looked closely at this I don't think in practice this is an issue even
at this early state of my code.

If those other threads are sleeping the code I have implemented should
be a no-op.

If those threads aren't sleeping you have undefined behavior, as at
some point the kernel will come through and kill those threads.

Further unless I am completely mistaken the container runtimes use
forkAndExecInChild from go/src/syscall/exec_linux.go which performs a
vfork before performing the exec.

Eric

