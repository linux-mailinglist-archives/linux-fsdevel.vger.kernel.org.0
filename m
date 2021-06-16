Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B61D83AA118
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 18:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235084AbhFPQT4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 12:19:56 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:39070 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbhFPQTx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 12:19:53 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ltYEc-009lYc-Aw; Wed, 16 Jun 2021 10:17:46 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ltYEb-000Wks-3W; Wed, 16 Jun 2021 10:17:45 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Alexey Gladkov <legion@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Chris Down <chris@chrisdown.name>,
        Cgroups <cgroups@vger.kernel.org>
References: <ac070cd90c0d45b7a554366f235262fa5c566435.1622716926.git.legion@kernel.org>
        <20210615113222.edzkaqfvrris4nth@wittgenstein>
        <20210615124715.nzd5we5tl7xc2n2p@example.org>
        <CALvZod7po_fK9JpcUNVrN6PyyP9k=hdcyRfZmHjSVE5r_8Laqw@mail.gmail.com>
Date:   Wed, 16 Jun 2021 11:17:38 -0500
In-Reply-To: <CALvZod7po_fK9JpcUNVrN6PyyP9k=hdcyRfZmHjSVE5r_8Laqw@mail.gmail.com>
        (Shakeel Butt's message of "Tue, 15 Jun 2021 18:09:49 -0700")
Message-ID: <87zgvpg4wt.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ltYEb-000Wks-3W;;;mid=<87zgvpg4wt.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/oAPIcVGnPayS1n8LJJbfvRL5ngyGBE/A=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=8.0 tests=ALL_TRUSTED,BAYES_40,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_XMDrugObfuBody_08
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.3277]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Shakeel Butt <shakeelb@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 652 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 10 (1.6%), b_tie_ro: 9 (1.3%), parse: 1.62 (0.2%),
         extract_message_metadata: 20 (3.0%), get_uri_detail_list: 5.0 (0.8%),
        tests_pri_-1000: 6 (0.9%), tests_pri_-950: 1.27 (0.2%),
        tests_pri_-900: 1.09 (0.2%), tests_pri_-90: 109 (16.7%), check_bayes:
        100 (15.3%), b_tokenize: 14 (2.1%), b_tok_get_all: 11 (1.7%),
        b_comp_prob: 3.5 (0.5%), b_tok_touch_all: 67 (10.3%), b_finish: 1.03
        (0.2%), tests_pri_0: 483 (74.1%), check_dkim_signature: 0.55 (0.1%),
        check_dkim_adsp: 3.5 (0.5%), poll_dns_idle: 0.17 (0.0%), tests_pri_10:
        2.3 (0.4%), tests_pri_500: 13 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v1] proc: Implement /proc/self/meminfo
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Shakeel Butt <shakeelb@google.com> writes:

> On Tue, Jun 15, 2021 at 5:47 AM Alexey Gladkov <legion@kernel.org> wrote:
>>
> [...]
>>
>> I made the second version of the patch [1], but then I had a conversation
>> with Eric W. Biederman offlist. He convinced me that it is a bad idea to
>> change all the values in meminfo to accommodate cgroups. But we agreed
>> that MemAvailable in /proc/meminfo should respect cgroups limits. This
>> field was created to hide implementation details when calculating
>> available memory. You can see that it is quite widely used [2].
>> So I want to try to move in that direction.
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/legion/linux.git/log/?h=patchset/meminfo/v2.0
>> [2] https://codesearch.debian.net/search?q=MemAvailable%3A
>>
>
> Please see following two links on the previous discussion on having
> per-memcg MemAvailable stat.
>
> [1] https://lore.kernel.org/linux-mm/alpine.DEB.2.22.394.2006281445210.855265@chino.kir.corp.google.com/
> [2] https://lore.kernel.org/linux-mm/alpine.DEB.2.23.453.2007142018150.2667860@chino.kir.corp.google.com/
>
> MemAvailable itself is an imprecise metric and involving memcg makes
> this metric even more weird. The difference of semantics of swap
> accounting of v1 and v2 is one source of this weirdness (I have not
> checked your patch if it is handling this weirdness). The lazyfree and
> deferred split pages are another source.
>
> So, I am not sure if complicating an already imprecise metric will
> make it more useful.

Making a good guess at how much memory can be allocated without
triggering swapping or otherwise stressing the system is something that
requires understanding our mm internals.

To be able to continue changing the mm or even mm policy without
introducing regressions in userspace we need to export values that
userspace can use.

At a first approximation that seems to look like MemAvailable.

MemAvailable seems to have a good definition.  Roughly the amount of
memory that can be allocated without triggering swapping.  Updated
to include not trigger memory cgroup based swapping and I sounds good.

I don't know if it will work in practice but I think it is worth
exploring.

I do know that hiding the implementation details and providing userspace
with information it can directly use seems like the programming model
that needs to be explored.  Most programs should not care if they are in
a memory cgroup, etc.  Programs, load management systems, and even
balloon drivers have a legitimately interest in how much additional load
can be placed on a systems memory.


A version of this that I remember working fairly well is free space
on compressed filesystems.  As I recall compressed filesystems report
the amount of uncompressed space that is available (an underestimate).
This results in the amount of space consumed going up faster than the
free space goes down.

We can't do exactly the same thing with our memory usability estimate,
but having our estimate be a reliable underestimate might be enough
to avoid problems with reporting too much memory as available to
userspace.

I know that MemAvailable already does that /2 so maybe it is already
aiming at being an underestimate.  Perhaps we need some additional
accounting to help create a useful metric for userspace as well.


I don't know the final answer.  I do know that not designing an
interface that userspace can use to deal with it's legitimate concerns
is sticking our collective heads in the sand and wishing the problem
will go away.

Eric

