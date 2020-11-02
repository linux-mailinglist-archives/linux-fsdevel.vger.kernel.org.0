Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 691A92A3409
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 20:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgKBT1U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 14:27:20 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:38178 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbgKBT1U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 14:27:20 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kZfU6-004uOq-Kz; Mon, 02 Nov 2020 12:27:18 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kZfU5-007zVJ-LR; Mon, 02 Nov 2020 12:27:18 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Qian Cai <cai@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201030152407.43598-1-cai@redhat.com>
        <20201030184255.GP3576660@ZenIV.linux.org.uk>
        <ad9357e9-8364-a316-392d-7504af614cac@kernel.dk>
        <20201030184918.GQ3576660@ZenIV.linux.org.uk>
        <d858ba48-624f-43be-93cf-07d94f0ebefd@kernel.dk>
        <20201030222213.GR3576660@ZenIV.linux.org.uk>
        <a1e17902-a204-f03d-2a51-469633eca751@kernel.dk>
Date:   Mon, 02 Nov 2020 13:27:17 -0600
In-Reply-To: <a1e17902-a204-f03d-2a51-469633eca751@kernel.dk> (Jens Axboe's
        message of "Fri, 30 Oct 2020 17:21:39 -0600")
Message-ID: <87eelba7ai.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kZfU5-007zVJ-LR;;;mid=<87eelba7ai.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19hmILBBOoyP9lI/H0XHWh2pxjCwSHzin8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,T_TooManySym_03,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4865]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Jens Axboe <axboe@kernel.dk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 353 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.4 (1.0%), b_tie_ro: 2.3 (0.7%), parse: 0.69
        (0.2%), extract_message_metadata: 8 (2.3%), get_uri_detail_list: 0.78
        (0.2%), tests_pri_-1000: 3.8 (1.1%), tests_pri_-950: 1.11 (0.3%),
        tests_pri_-900: 0.94 (0.3%), tests_pri_-90: 146 (41.5%), check_bayes:
        145 (41.0%), b_tokenize: 4.4 (1.2%), b_tok_get_all: 4.7 (1.3%),
        b_comp_prob: 1.56 (0.4%), b_tok_touch_all: 131 (37.2%), b_finish: 0.80
        (0.2%), tests_pri_0: 155 (44.1%), check_dkim_signature: 0.38 (0.1%),
        check_dkim_adsp: 2.7 (0.8%), poll_dns_idle: 15 (4.2%), tests_pri_10:
        1.63 (0.5%), tests_pri_500: 29 (8.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH -next] fs: Fix memory leaks in do_renameat2() error paths
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> On 10/30/20 4:22 PM, Al Viro wrote:
>> On Fri, Oct 30, 2020 at 02:33:11PM -0600, Jens Axboe wrote:
>>> On 10/30/20 12:49 PM, Al Viro wrote:
>>>> On Fri, Oct 30, 2020 at 12:46:26PM -0600, Jens Axboe wrote:
>>>>
>>>>> See other reply, it's being posted soon, just haven't gotten there yet
>>>>> and it wasn't ready.
>>>>>
>>>>> It's a prep patch so we can call do_renameat2 and pass in a filename
>>>>> instead. The intent is not to have any functional changes in that prep
>>>>> patch. But once we can pass in filenames instead of user pointers, it's
>>>>> usable from io_uring.
>>>>
>>>> You do realize that pathname resolution is *NOT* offloadable to helper
>>>> threads, I hope...
>>>
>>> How so? If we have all the necessary context assigned, what's preventing
>>> it from working?
>> 
>> Semantics of /proc/self/..., for starters (and things like /proc/mounts, etc.
>> *do* pass through that, /dev/stdin included)
>
> Don't we just need ->thread_pid for that to work?

No.  You need ->signal.

You need ->signal->pids[PIDTYPE_TGID].  It is only for /proc/thread-self
that ->thread_pid is needed.

Even more so than ->thread_pid, it is a kernel invariant that ->signal
does not change.

Eric


