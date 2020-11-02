Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD8422A34F6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 21:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgKBUNy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 15:13:54 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:56652 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgKBUND (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 15:13:03 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kZgCK-00512W-VY; Mon, 02 Nov 2020 13:13:01 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1kZgCK-0003Wq-0p; Mon, 02 Nov 2020 13:13:00 -0700
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
        <87eelba7ai.fsf@x220.int.ebiederm.org>
        <f33a6b5e-ecc9-2bef-ab40-6bd8cc2030c2@kernel.dk>
Date:   Mon, 02 Nov 2020 14:12:59 -0600
In-Reply-To: <f33a6b5e-ecc9-2bef-ab40-6bd8cc2030c2@kernel.dk> (Jens Axboe's
        message of "Mon, 2 Nov 2020 12:54:40 -0700")
Message-ID: <87k0v38qlw.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kZgCK-0003Wq-0p;;;mid=<87k0v38qlw.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/uzcPHiTMRr+f9d2gG7BAWgMjV5uEet8c=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,T_TooManySym_03,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4989]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Jens Axboe <axboe@kernel.dk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 549 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 10 (1.9%), b_tie_ro: 9 (1.6%), parse: 0.89 (0.2%),
         extract_message_metadata: 11 (2.0%), get_uri_detail_list: 1.56 (0.3%),
         tests_pri_-1000: 4.5 (0.8%), tests_pri_-950: 1.21 (0.2%),
        tests_pri_-900: 0.94 (0.2%), tests_pri_-90: 276 (50.3%), check_bayes:
        274 (50.0%), b_tokenize: 7 (1.2%), b_tok_get_all: 7 (1.3%),
        b_comp_prob: 2.5 (0.5%), b_tok_touch_all: 254 (46.4%), b_finish: 1.02
        (0.2%), tests_pri_0: 221 (40.2%), check_dkim_signature: 0.54 (0.1%),
        check_dkim_adsp: 2.5 (0.5%), poll_dns_idle: 0.74 (0.1%), tests_pri_10:
        2.0 (0.4%), tests_pri_500: 18 (3.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH -next] fs: Fix memory leaks in do_renameat2() error paths
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> On 11/2/20 12:27 PM, Eric W. Biederman wrote:
>> Jens Axboe <axboe@kernel.dk> writes:
>> 
>>> On 10/30/20 4:22 PM, Al Viro wrote:
>>>> On Fri, Oct 30, 2020 at 02:33:11PM -0600, Jens Axboe wrote:
>>>>> On 10/30/20 12:49 PM, Al Viro wrote:
>>>>>> On Fri, Oct 30, 2020 at 12:46:26PM -0600, Jens Axboe wrote:
>>>>>>
>>>>>>> See other reply, it's being posted soon, just haven't gotten there yet
>>>>>>> and it wasn't ready.
>>>>>>>
>>>>>>> It's a prep patch so we can call do_renameat2 and pass in a filename
>>>>>>> instead. The intent is not to have any functional changes in that prep
>>>>>>> patch. But once we can pass in filenames instead of user pointers, it's
>>>>>>> usable from io_uring.
>>>>>>
>>>>>> You do realize that pathname resolution is *NOT* offloadable to helper
>>>>>> threads, I hope...
>>>>>
>>>>> How so? If we have all the necessary context assigned, what's preventing
>>>>> it from working?
>>>>
>>>> Semantics of /proc/self/..., for starters (and things like /proc/mounts, etc.
>>>> *do* pass through that, /dev/stdin included)
>>>
>>> Don't we just need ->thread_pid for that to work?
>> 
>> No.  You need ->signal.
>> 
>> You need ->signal->pids[PIDTYPE_TGID].  It is only for /proc/thread-self
>> that ->thread_pid is needed.
>> 
>> Even more so than ->thread_pid, it is a kernel invariant that ->signal
>> does not change.
>
> I don't care about the pid itself, my suggestion was to assign ->thread_pid
> over the lookup operation to ensure that /proc/self/ worked the way that
> you'd expect.

I understand that.

However /proc/self/ refers to the current process not to the current
thread.  So ->thread_pid is not what you need to assign to make that
happen.  What the code looks at is: ->signal->pids[PIDTYPE_TGID].

It will definitely break invariants to assign to ->signal.

Currently only exchange_tids assigns ->thread_pid and it is nasty.  It
results in code that potentially results in infinite loops in
kernel/signal.c

To my knowledge nothing assigns ->signal->pids[PIDTYPE_TGID].  At best
it might work but I expect the it would completely confuse something in
the pid to task or pid to process mappings.  Which is to say even if it
does work it would be an extremely fragile solution.

Eric

