Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F752233B2B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jul 2020 00:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbgG3WQp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 18:16:45 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:33670 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbgG3WQo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 18:16:44 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k1Gqn-001wra-Oy; Thu, 30 Jul 2020 16:16:33 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k1Gqm-0008QM-Tw; Thu, 30 Jul 2020 16:16:33 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     viro@zeniv.linux.org.uk, adobriyan@gmail.com, davem@davemloft.net,
        akpm@linux-foundation.org, christian.brauner@ubuntu.com,
        areber@redhat.com, serge@hallyn.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
References: <159611007271.535980.15362304262237658692.stgit@localhost.localdomain>
        <87k0yl5axy.fsf@x220.int.ebiederm.org>
        <56928404-f194-4194-5f2a-59acb15b1a04@virtuozzo.com>
Date:   Thu, 30 Jul 2020 17:13:23 -0500
In-Reply-To: <56928404-f194-4194-5f2a-59acb15b1a04@virtuozzo.com> (Kirill
        Tkhai's message of "Thu, 30 Jul 2020 18:01:20 +0300")
Message-ID: <875za43b3w.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1k1Gqm-0008QM-Tw;;;mid=<875za43b3w.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+vnnMZQDTkMO3rqB1WFCp+/Q/VJb4nbWE=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa07 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Kirill Tkhai <ktkhai@virtuozzo.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 462 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 11 (2.3%), b_tie_ro: 9 (2.0%), parse: 0.93 (0.2%),
         extract_message_metadata: 12 (2.7%), get_uri_detail_list: 2.2 (0.5%),
        tests_pri_-1000: 4.6 (1.0%), tests_pri_-950: 1.20 (0.3%),
        tests_pri_-900: 1.01 (0.2%), tests_pri_-90: 70 (15.2%), check_bayes:
        69 (14.8%), b_tokenize: 8 (1.8%), b_tok_get_all: 9 (2.0%),
        b_comp_prob: 3.2 (0.7%), b_tok_touch_all: 44 (9.4%), b_finish: 0.98
        (0.2%), tests_pri_0: 343 (74.1%), check_dkim_signature: 0.62 (0.1%),
        check_dkim_adsp: 1.89 (0.4%), poll_dns_idle: 0.40 (0.1%),
        tests_pri_10: 2.4 (0.5%), tests_pri_500: 13 (2.8%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: [PATCH 00/23] proc: Introduce /proc/namespaces/ directory to expose namespaces lineary
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Kirill Tkhai <ktkhai@virtuozzo.com> writes:

> On 30.07.2020 17:34, Eric W. Biederman wrote:
>> Kirill Tkhai <ktkhai@virtuozzo.com> writes:
>> 
>>> Currently, there is no a way to list or iterate all or subset of namespaces
>>> in the system. Some namespaces are exposed in /proc/[pid]/ns/ directories,
>>> but some also may be as open files, which are not attached to a process.
>>> When a namespace open fd is sent over unix socket and then closed, it is
>>> impossible to know whether the namespace exists or not.
>>>
>>> Also, even if namespace is exposed as attached to a process or as open file,
>>> iteration over /proc/*/ns/* or /proc/*/fd/* namespaces is not fast, because
>>> this multiplies at tasks and fds number.
>> 
>> I am very dubious about this.
>> 
>> I have been avoiding exactly this kind of interface because it can
>> create rather fundamental problems with checkpoint restart.
>
> restart/restore :)
>
>> You do have some filtering and the filtering is not based on current.
>> Which is good.
>> 
>> A view that is relative to a user namespace might be ok.    It almost
>> certainly does better as it's own little filesystem than as an extension
>> to proc though.
>> 
>> The big thing we want to ensure is that if you migrate you can restore
>> everything.  I don't see how you will be able to restore these files
>> after migration.  Anything like this without having a complete
>> checkpoint/restore story is a non-starter.
>
> There is no difference between files in /proc/namespaces/ directory and /proc/[pid]/ns/.
>
> CRIU can restore open files in /proc/[pid]/ns, the same will be with /proc/namespaces/ files.
> As a person who worked deeply for pid_ns and user_ns support in CRIU, I don't see any
> problem here.

An obvious diffference is that you are adding the inode to the inode to
the file name.  Which means that now you really do have to preserve the
inode numbers during process migration.

Which means now we have to do all of the work to make inode number
restoration possible.  Which means now we need to have multiple
instances of nsfs so that we can restore inode numbers.

I think this is still possible but we have been delaying figuring out
how to restore inode numbers long enough that may be actual technical
problems making it happen.

Now maybe CRIU can handle the names of the files changing during
migration but you have just increased the level of difficulty for doing
that.

> If you have a specific worries about, let's discuss them.

I was asking and I am asking that it be described in the patch
description how a container using this feature can be migrated
from one machine to another.  This code is so close to being problematic
that we need be very careful we don't fundamentally break CRIU while
trying to make it's job simpler and easier.

> CC: Pavel Tikhomirov CRIU maintainer, who knows everything about namespaces C/R.
>  
>> Further by not going through the processes it looks like you are
>> bypassing the existing permission checks.  Which has the potential
>> to allow someone to use a namespace who would not be able to otherwise.
>
> I agree, and I wrote to Christian, that permissions should be more strict.
> This just should be formalized. Let's discuss this.
>
>> So I think this goes one step too far but I am willing to be persuaded
>> otherwise.
>> 

Eric

