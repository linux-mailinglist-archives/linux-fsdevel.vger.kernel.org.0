Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F9031A871
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Feb 2021 00:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbhBLXta (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Feb 2021 18:49:30 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:38418 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbhBLXtU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Feb 2021 18:49:20 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lAiAw-001KYF-6b; Fri, 12 Feb 2021 16:48:38 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lAiAs-00AAwv-BU; Fri, 12 Feb 2021 16:48:37 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <85ff6fd6b26aafdf6087666629bad3acc29258d8.camel@perches.com>
        <m1im6x0wtv.fsf@fess.ebiederm.org>
        <20210212221918.GA2858050@casper.infradead.org>
Date:   Fri, 12 Feb 2021 17:48:16 -0600
In-Reply-To: <20210212221918.GA2858050@casper.infradead.org> (Matthew Wilcox's
        message of "Fri, 12 Feb 2021 22:19:18 +0000")
Message-ID: <m1ft20zw3j.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lAiAs-00AAwv-BU;;;mid=<m1ft20zw3j.fsf@fess.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/kBYeaNDremxU4TaUBAJy1fsy5iUdwbQQ=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,T_TooManySym_02 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4898]
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Matthew Wilcox <willy@infradead.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 3303 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 12 (0.4%), b_tie_ro: 10 (0.3%), parse: 1.07
        (0.0%), extract_message_metadata: 20 (0.6%), get_uri_detail_list: 2.5
        (0.1%), tests_pri_-1000: 12 (0.4%), tests_pri_-950: 1.19 (0.0%),
        tests_pri_-900: 0.98 (0.0%), tests_pri_-90: 89 (2.7%), check_bayes: 86
        (2.6%), b_tokenize: 8 (0.2%), b_tok_get_all: 9 (0.3%), b_comp_prob:
        3.1 (0.1%), b_tok_touch_all: 63 (1.9%), b_finish: 0.96 (0.0%),
        tests_pri_0: 267 (8.1%), check_dkim_signature: 0.50 (0.0%),
        check_dkim_adsp: 2.3 (0.1%), poll_dns_idle: 2865 (86.7%),
        tests_pri_10: 2.2 (0.1%), tests_pri_500: 2894 (87.6%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH] proc: Convert S_<FOO> permission uses to octal
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

> On Fri, Feb 12, 2021 at 04:01:48PM -0600, Eric W. Biederman wrote:
>> Joe Perches <joe@perches.com> writes:
>> 
>> > Convert S_<FOO> permissions to the more readable octal.
>> >
>> > Done using:
>> > $ ./scripts/checkpatch.pl -f --fix-inplace --types=SYMBOLIC_PERMS fs/proc/*.[ch]
>> >
>> > No difference in generated .o files allyesconfig x86-64
>> >
>> > Link:
>> > https://lore.kernel.org/lkml/CA+55aFw5v23T-zvDZp-MmD_EYxF8WbafwwB59934FV7g21uMGQ@mail.gmail.com/
>> 
>> 
>> I will be frank.  I don't know what 0644 means.  I can never remember
>> which bit is read, write or execute.  So I like symbolic constants.
>
> Heh, I'm the other way, I can't remember what S_IRUGO means.
>
> but I think there's another way which improves the information
> density:
>
> #define DIR_RO_ALL(NAME, iops, fops)	DIR(NAME, 0555, iops, fops)
> ...
> (or S_IRUGO or whatever expands to 0555)
>
> There's really only a few combinations --
> 	root read-only,
> 	everybody read-only
> 	root-write, others-read
> 	everybody-write
>
> and execute is only used by proc for directories, not files, so I think
> there's only 8 combinations we'd need (and everybody-write is almost
> unused ...)

I guess it depends on which part of proc.  For fs/proc/base.c and it's
per process relatives something like that seems reasonable.

I don't know about fs/proc/generic.c where everyone from all over the
kernel registers new proc entries.

>> Perhaps we can do something like:
>> 
>> #define S_IRWX 7
>> #define S_IRW_ 6
>> #define S_IR_X 5
>> #define S_IR__ 4
>> #define S_I_WX 3
>> #define S_I_W_ 2
>> #define S_I__X 1
>> #define S_I___ 0
>> 
>> #define MODE(TYPE, USER, GROUP, OTHER) \
>> 	(((S_IF##TYPE) << 9) | \
>>          ((S_I##USER)  << 6) | \
>>          ((S_I##GROUP) << 3) | \
>>          (S_I##OTHER))
>> 
>> Which would be used something like:
>> MODE(DIR, RWX, R_X, R_X)
>> MODE(REG, RWX, R__, R__)
>> 
>> Something like that should be able to address the readability while
>> still using symbolic constants.
>
> I think that's been proposed before.

I don't think it has ever been shot down.  Just no one care enough to
implement it.

Come to think of it, that has the nice property that if we cared we
could make it type safe as well.  Something we can't do with the octal
for obvious reasons.

Eric

