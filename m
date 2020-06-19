Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2028C201E31
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jun 2020 00:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729589AbgFSWrL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jun 2020 18:47:11 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:34580 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729577AbgFSWrK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jun 2020 18:47:10 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jmPmr-0003up-6O; Fri, 19 Jun 2020 16:47:05 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jmPmq-0003DD-3a; Fri, 19 Jun 2020 16:47:05 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Junxiao Bi <junxiao.bi@oracle.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <matthew.wilcox@oracle.com>,
        Srinivas Eeda <SRINIVAS.EEDA@oracle.com>,
        "joe.jin\@oracle.com" <joe.jin@oracle.com>,
        Wengang Wang <wen.gang.wang@oracle.com>
References: <54091fc0-ca46-2186-97a8-d1f3c4f3877b@oracle.com>
        <20200618233958.GV8681@bombadil.infradead.org>
        <877dw3apn8.fsf@x220.int.ebiederm.org>
        <2cf6af59-e86b-f6cc-06d3-84309425bd1d@oracle.com>
        <87bllf87ve.fsf_-_@x220.int.ebiederm.org>
        <caa9adf6-e1bb-167b-6f59-d17fd587d4fa@oracle.com>
        <87k1036k9y.fsf@x220.int.ebiederm.org>
        <68a1f51b-50bf-0770-2367-c3e1b38be535@oracle.com>
Date:   Fri, 19 Jun 2020 17:42:45 -0500
In-Reply-To: <68a1f51b-50bf-0770-2367-c3e1b38be535@oracle.com> (Junxiao Bi's
        message of "Fri, 19 Jun 2020 14:56:58 -0700")
Message-ID: <87blle4qze.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jmPmq-0003DD-3a;;;mid=<87blle4qze.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/f9FJF3b8ZpMntMwzOY/uCE50xMD8xT64=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4135]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa04 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Junxiao Bi <junxiao.bi@oracle.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 689 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 12 (1.7%), b_tie_ro: 10 (1.5%), parse: 1.08
        (0.2%), extract_message_metadata: 12 (1.8%), get_uri_detail_list: 1.54
        (0.2%), tests_pri_-1000: 14 (2.1%), tests_pri_-950: 1.22 (0.2%),
        tests_pri_-900: 0.99 (0.1%), tests_pri_-90: 129 (18.7%), check_bayes:
        128 (18.5%), b_tokenize: 6 (0.9%), b_tok_get_all: 6 (0.9%),
        b_comp_prob: 2.2 (0.3%), b_tok_touch_all: 109 (15.9%), b_finish: 0.82
        (0.1%), tests_pri_0: 507 (73.6%), check_dkim_signature: 0.55 (0.1%),
        check_dkim_adsp: 2.4 (0.4%), poll_dns_idle: 0.72 (0.1%), tests_pri_10:
        1.79 (0.3%), tests_pri_500: 6 (0.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] proc: Avoid a thundering herd of threads freeing proc dentries
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Junxiao Bi <junxiao.bi@oracle.com> writes:

> On 6/19/20 10:24 AM, ebiederm@xmission.com wrote:
>
>> Junxiao Bi <junxiao.bi@oracle.com> writes:
>>
>>> Hi Eric,
>>>
>>> The patch didn't improve lock contention.
>> Which raises the question where is the lock contention coming from.
>>
>> Especially with my first variant.  Only the last thread to be reaped
>> would free up anything in the cache.
>>
>> Can you comment out the call to proc_flush_pid entirely?
>
> Still high lock contention. Collect the following hot path.

A different location this time.

I know of at least exit_signal and exit_notify that take thread wide
locks, and it looks like exit_mm is another.  Those don't use the same
locks as flushing proc.


So I think you are simply seeing a result of the thundering herd of
threads shutting down at once.  Given that thread shutdown is fundamentally
a slow path there is only so much that can be done.

If you are up for a project to working through this thundering herd I
expect I can help some.  It will be a long process of cleaning up
the entire thread exit process with an eye to performance.

To make incremental progress we are going to need a way to understand
the impact of various changes.  Such as my change to reduce the dentry
lock contention when a process is removed from proc.  I have the feeling
that made a real world improvement on your test (as the lock no longer
shows up in your profile). Unfortunately whatever that improvement was
it was not relfected in now you read your numbers.

Eric
