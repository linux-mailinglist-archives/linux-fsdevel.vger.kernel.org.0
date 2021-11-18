Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 892E745636D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Nov 2021 20:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233659AbhKRTZ2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Nov 2021 14:25:28 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:35404 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbhKRTZ1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Nov 2021 14:25:27 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:57172)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mnmzJ-000lSE-22; Thu, 18 Nov 2021 12:22:25 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:48176 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mnmzH-003iYF-Is; Thu, 18 Nov 2021 12:22:24 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Yordan Karadzhov \(VMware\)" <y.karadz@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, mingo@redhat.com, hagen@jauu.net,
        rppt@kernel.org, James.Bottomley@HansenPartnership.com,
        akpm@linux-foundation.org, vvs@virtuozzo.com, shakeelb@google.com,
        christian.brauner@ubuntu.com, mkoutny@suse.com,
        Linux Containers <containers@lists.linux.dev>
References: <20211118181210.281359-1-y.karadz@gmail.com>
        <87a6i1xpis.fsf@email.froward.int.ebiederm.org>
        <20211118140211.7d7673fb@gandalf.local.home>
Date:   Thu, 18 Nov 2021 13:22:16 -0600
In-Reply-To: <20211118140211.7d7673fb@gandalf.local.home> (Steven Rostedt's
        message of "Thu, 18 Nov 2021 14:02:11 -0500")
Message-ID: <87pmqxuv4n.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mnmzH-003iYF-Is;;;mid=<87pmqxuv4n.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18gQzuWpaBgAEXLLCGhz+F3zKEDvRmChIA=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4804]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Steven Rostedt <rostedt@goodmis.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 452 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (2.4%), b_tie_ro: 9 (2.0%), parse: 0.87 (0.2%),
         extract_message_metadata: 15 (3.2%), get_uri_detail_list: 1.65 (0.4%),
         tests_pri_-1000: 15 (3.3%), tests_pri_-950: 1.29 (0.3%),
        tests_pri_-900: 1.03 (0.2%), tests_pri_-90: 116 (25.7%), check_bayes:
        109 (24.2%), b_tokenize: 7 (1.6%), b_tok_get_all: 8 (1.8%),
        b_comp_prob: 2.5 (0.5%), b_tok_touch_all: 88 (19.6%), b_finish: 0.81
        (0.2%), tests_pri_0: 279 (61.8%), check_dkim_signature: 0.51 (0.1%),
        check_dkim_adsp: 2.5 (0.6%), poll_dns_idle: 0.76 (0.2%), tests_pri_10:
        2.1 (0.5%), tests_pri_500: 8 (1.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC PATCH 0/4] namespacefs: Proof-of-Concept
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> writes:

> On Thu, 18 Nov 2021 12:55:07 -0600
> ebiederm@xmission.com (Eric W. Biederman) wrote:
>
>> Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
>> 
>> Eric
>
> Eric, 
>
> As you can see, the subject says "Proof-of-Concept" and every patch in the
> the series says "RFC". All you did was point out problems with no help in
> fixing those problems, and then gave a nasty Nacked-by before it even got
> into a conversation.
>
> From this response, I have to say:
>
>   It is not correct to nack a proof of concept that is asking for
>   discussion.
>
> So, I nack your nack, because it's way to early to nack this.

I am refreshing my nack on the concept.  My nack has been in place for
good technical reasons since about 2006.

I see no way forward.  I do not see a compelling use case.

There have been many conversations in the past attempt to implement
something that requires a namespace of namespaces and they have never
gotten anywhere.

I see no attempt a due diligence or of actually understanding what
hierarchy already exists in namespaces.

I don't mean to be nasty but I do mean to be clear.  Without a
compelling new idea in this space I see no hope of an implementation.

What they are attempting to do makes it impossible to migrate a set of
process that uses this feature from one machine to another.  AKA this
would be a breaking change and a regression if merged.

The breaking and regression are caused by assigning names to namespaces
without putting those names into a namespace of their own.   That
appears fundamental to the concept not to the implementation.

Since the concept if merged would cause a regression it qualifies for
a nack.

We can explore what problems they are trying to solve with this and
explore other ways to solve those problems.  All I saw was a comment
about monitoring tools and wanting a global view.  I did not see
any comments about dealing with all of the reasons why a global view
tends to be a bad idea.

I should have added that we have to some extent a way to walk through
namespaces using ioctls on nsfs inodes.

Eric

