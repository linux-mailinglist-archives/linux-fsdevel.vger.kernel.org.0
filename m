Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 664B83A1D85
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jun 2021 21:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbhFITQi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Jun 2021 15:16:38 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:50002 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhFITQh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Jun 2021 15:16:37 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lr3ey-003xdD-IM; Wed, 09 Jun 2021 13:14:40 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lr3ew-00GPPl-Id; Wed, 09 Jun 2021 13:14:40 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     "Enrico Weigelt\, metux IT consult" <lkml@metux.net>
Cc:     Chris Down <chris@chrisdown.name>, legion@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>
References: <ac070cd90c0d45b7a554366f235262fa5c566435.1622716926.git.legion@kernel.org>
        <YLi+JoBwfLtqVGiP@chrisdown.name>
        <b8c86081-503c-3671-2ea3-dd3a0950ce25@metux.net>
Date:   Wed, 09 Jun 2021 14:14:16 -0500
In-Reply-To: <b8c86081-503c-3671-2ea3-dd3a0950ce25@metux.net> (Enrico
        Weigelt's message of "Wed, 9 Jun 2021 10:16:25 +0200")
Message-ID: <87k0n2am0n.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lr3ew-00GPPl-Id;;;mid=<87k0n2am0n.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19ky6SnPm4aIIGqshsdLeiN8WNYSU9EkMU=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_XMDrugObfuBody_08
        autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;"Enrico Weigelt\, metux IT consult" <lkml@metux.net>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1439 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.2 (0.3%), b_tie_ro: 2.9 (0.2%), parse: 1.12
        (0.1%), extract_message_metadata: 12 (0.9%), get_uri_detail_list: 2.7
        (0.2%), tests_pri_-1000: 4.2 (0.3%), tests_pri_-950: 1.03 (0.1%),
        tests_pri_-900: 0.85 (0.1%), tests_pri_-90: 77 (5.4%), check_bayes: 76
        (5.3%), b_tokenize: 6 (0.4%), b_tok_get_all: 10 (0.7%), b_comp_prob:
        2.1 (0.1%), b_tok_touch_all: 54 (3.8%), b_finish: 0.70 (0.0%),
        tests_pri_0: 1325 (92.1%), check_dkim_signature: 0.40 (0.0%),
        check_dkim_adsp: 2.5 (0.2%), poll_dns_idle: 0.57 (0.0%), tests_pri_10:
        2.8 (0.2%), tests_pri_500: 7 (0.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v1] proc: Implement /proc/self/meminfo
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"Enrico Weigelt, metux IT consult" <lkml@metux.net> writes:

> On 03.06.21 13:33, Chris Down wrote:
>
> Hi folks,
>
>
>> Putting stuff in /proc to get around the problem of "some other metric I need
>> might not be exported to a container" is not a very compelling argument. If
>> they want it, then export it to the container...
>>
>> Ultimately, if they're going to have to add support for a new
>> /proc/self/meminfo file anyway, these use cases should just do it properly
>> through the already supported APIs.
>
> It's even a bit more complex ...
>
> /proc/meminfo always tells what the *machine* has available, not what a
> process can eat up. That has been this way even long before cgroups.
> (eg. ulimits).
>
> Even if you want a container look more like a VM - /proc/meminfo showing
> what the container (instead of the machine) has available - just looking
> at the calling task's cgroup is also wrong. Because there're cgroups
> outside containers (that really shouldn't be affected) and there're even
> other cgroups inside the container (that further restrict below the
> container's limits).
>
> BTW: applications trying to autotune themselves by looking at
> /proc/meminfo are broken-by-design anyways. This never has been a valid
> metric on how much memory invididual processes can or should eat.

Which brings us to the problem.

Using /proc/meminfo is not valid unless your application can know it has
the machine to itself.  Something that is becoming increasing less
common.

Unless something has changed in the last couple of years, reading values
out of the cgroup filesystem is both difficult (v1 and v2 have some
gratuitous differences) and is actively discouraged.

So what should applications do?

Alex has found applications that are trying to do something with
meminfo, and the fields that those applications care about.  I don't see
anyone making the case that specifically what the applications are
trying to do is buggy.

Alex's suggest is to have a /proc/self/meminfo that has the information
that applications want, which would be something that would be easy
to switch applications to.  The patch to userspace at that point is
as simple as 3 lines of code.  I can imagine people take that patch into
their userspace programs.

The simple fact that people are using /proc/meminfo when it doesn't make
sense for anything except system monitoring tools is a pretty solid bug
report on the existing linux apis.

So how do people suggest these applications get the information they
need?

Alex perhaps I missed it, but I didn't see a lot of description on why
the individual applications are using meminfo.  Can you provide a bit
more detail?  At least for a several of them, so we can see the trends
and say yes this kind of information makes sense to provide to
applications.  I think that would help move forward the discussion about
the best way to provide that information to userspace.

Eric
