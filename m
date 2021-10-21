Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9D564368D7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 19:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbhJURRu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 13:17:50 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:33636 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhJURRt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 13:17:49 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:37160)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdbf9-000AMa-Iy; Thu, 21 Oct 2021 11:15:31 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:57708 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdbf8-004CFX-64; Thu, 21 Oct 2021 11:15:31 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Pratik Sampat <psampat@linux.ibm.com>
Cc:     Tejun Heo <tj@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        bristot@redhat.com, christian@brauner.io, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, mingo@kernel.org, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org, containers@lists.linux.dev,
        containers@lists.linux-foundation.org, pratik.r.sampat@gmail.com,
        Alexey Gladkov <legion@kernel.org>
References: <20211009151243.8825-1-psampat@linux.ibm.com>
        <20211011101124.d5mm7skqfhe5g35h@wittgenstein>
        <a0f9ed06-1e5d-d3d0-21a5-710c8e27749c@linux.ibm.com>
        <YWirxCjschoRJQ14@slm.duckdns.org>
        <b5f8505c-38d5-af6f-0de7-4f9df7ae9b9b@linux.ibm.com>
        <YW2g73Lwmrhjg/sv@slm.duckdns.org>
        <77854748-081f-46c7-df51-357ca78b83b3@linux.ibm.com>
Date:   Thu, 21 Oct 2021 12:15:22 -0500
In-Reply-To: <77854748-081f-46c7-df51-357ca78b83b3@linux.ibm.com> (Pratik
        Sampat's message of "Wed, 20 Oct 2021 16:14:25 +0530")
Message-ID: <87tuha7105.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mdbf8-004CFX-64;;;mid=<87tuha7105.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+k81XzcFL3nUOkF05szMGteN8T3vDwHqg=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMNoVowels autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4940]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Pratik Sampat <psampat@linux.ibm.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 387 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 14 (3.5%), b_tie_ro: 12 (3.0%), parse: 1.39
        (0.4%), extract_message_metadata: 4.4 (1.1%), get_uri_detail_list:
        1.49 (0.4%), tests_pri_-1000: 6 (1.6%), tests_pri_-950: 1.85 (0.5%),
        tests_pri_-900: 1.45 (0.4%), tests_pri_-90: 120 (31.0%), check_bayes:
        118 (30.4%), b_tokenize: 8 (2.1%), b_tok_get_all: 7 (1.8%),
        b_comp_prob: 2.6 (0.7%), b_tok_touch_all: 96 (24.9%), b_finish: 1.14
        (0.3%), tests_pri_0: 211 (54.6%), check_dkim_signature: 0.71 (0.2%),
        check_dkim_adsp: 3.1 (0.8%), poll_dns_idle: 0.58 (0.2%), tests_pri_10:
        4.0 (1.0%), tests_pri_500: 11 (2.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC 0/5] kernel: Introduce CPU Namespace
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pratik Sampat <psampat@linux.ibm.com> writes:

> On 18/10/21 9:59 pm, Tejun Heo wrote:
>> (cc'ing Johannes for memory sizing part)
>>
>> For memory, it's even trickier because in a lot of cases it's impossible to
>> tell how much memory is actually available without trying to use them as
>> active workingset can only be learned by trying to reclaim memory.
>
> Restrictions for memory are even more complicated to model as you have
> pointed out as well.

For memory sizing we currently have MemAvailable in /proc/meminfo which
makes a global guess at that.

We still need roughly that same approximation from an applications
perspective that takes cgroups into account.

There was another conversation not too long ago and it was tenatively
agreed that it could make sense to provide such a number.  However it
was very much requested that an application that would actually use
that number be found so it would be possible to tell what makes a
difference in practice rather than what makes a difference in theory.

Eric



