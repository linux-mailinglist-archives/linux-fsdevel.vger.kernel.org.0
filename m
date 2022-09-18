Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3E15BC046
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Sep 2022 00:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiIRWFA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Sep 2022 18:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiIRWE6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Sep 2022 18:04:58 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324BCBF70;
        Sun, 18 Sep 2022 15:04:57 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:48816)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oa2PI-00H78e-0b; Sun, 18 Sep 2022 16:04:56 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:50464 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oa2PH-000O86-13; Sun, 18 Sep 2022 16:04:55 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Florian Mayer <fmayer@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Evgenii Stepanov <eugenis@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, linux-api@vger.kernel.org
References: <20220909180617.374238-1-fmayer@google.com>
        <87v8pw8bkx.fsf@email.froward.int.ebiederm.org>
        <CAJAyTCCcecgqeMfs9W8=U4wi-6O+DaRktUsyJuStYy-JgKQCdg@mail.gmail.com>
Date:   Sun, 18 Sep 2022 17:04:48 -0500
In-Reply-To: <CAJAyTCCcecgqeMfs9W8=U4wi-6O+DaRktUsyJuStYy-JgKQCdg@mail.gmail.com>
        (Florian Mayer's message of "Fri, 9 Sep 2022 16:05:34 -0700")
Message-ID: <875yhk730f.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1oa2PH-000O86-13;;;mid=<875yhk730f.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1+GH9uiilgu5nUbYPntWwWcfiqEPCTLJ20=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Florian Mayer <fmayer@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 441 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 12 (2.7%), b_tie_ro: 10 (2.3%), parse: 1.09
        (0.2%), extract_message_metadata: 14 (3.1%), get_uri_detail_list: 2.1
        (0.5%), tests_pri_-1000: 14 (3.1%), tests_pri_-950: 1.22 (0.3%),
        tests_pri_-900: 1.00 (0.2%), tests_pri_-90: 63 (14.2%), check_bayes:
        61 (13.8%), b_tokenize: 8 (1.8%), b_tok_get_all: 8 (1.9%),
        b_comp_prob: 2.8 (0.6%), b_tok_touch_all: 38 (8.7%), b_finish: 1.06
        (0.2%), tests_pri_0: 323 (73.2%), check_dkim_signature: 0.51 (0.1%),
        check_dkim_adsp: 4.0 (0.9%), poll_dns_idle: 2.1 (0.5%), tests_pri_10:
        2.1 (0.5%), tests_pri_500: 8 (1.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH RESEND] Add sicode to /proc/<PID>/stat.
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Florian Mayer <fmayer@google.com> writes:

> On Fri, 9 Sept 2022 at 14:47, Eric W. Biederman <ebiederm@xmission.com> wrote:
>> Added linux-api because you are changing the api.
>
> Thanks.
>
>> Several things.  First you are messing with /proc/<pid>/stat which is
>> heavily used.  You do add the value to the end of the list which is
>> good.  You don't talk about how many userspace applications you have
>> tested to be certain that it is actually safe to add something to this
>> file, nor do you talk about measuring performance.
>
> Makes sense. Given this and Kees comment above, it seems like status
> instead is a better place. That should deal with the compatibility
> issue given it's a key-value pair file. Do you have the same
> performance concerns for that file as well?

They are a general concern.  It is worth checking to see if the
performance of the proc file you modify changes measurably.

>> This implementation seems very fragile.  How long until you need the
>> full siginfo of the signal that caused the process to exit somewhere?
>
> For our use case probably never. I don't know if someone else will
> eventually need everything.
>
>> There are two ways to get this information with existing APIs.
>> - Catch the signal in the process and give it to someone.
>
> This would involve establishing a back-channel from the child process
> to init, which is not impossible but also not particularly
> architecturally nice.
>
>> - Debug the process and stop in PTRACE_EVENT_EXIT and read
>>   the signal with PTRACE_PEEKSIGINFO.
>
> This will not work with the SELinux rules we want to enforce on Android.
>
>> I know people have wanted the full siginfo on exit before, but we have
>> not gotten there yet.
>
> That sounds like a much bigger change. How would that look? A new
> sys-call to get the siginfo from a zombie? A new wait API?

Another proc file.  It is more that we have gotten requests for that
in the past.

I will toss out one more possibility that seems like a good solution
with existing facilities.  Have the coredump helper (aka the process
that coredumps are piped to) read the signal state from the coredump.
At which point the coredump helper can back channel to init or whatever
needs this information.

I am probably missing something obvious but the consumer of all
coredumps seems like the right place to add functionality for debugging
like this as it can tell everything about the dead userspace process.

Eric
