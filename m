Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6816467A081
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 18:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbjAXRue (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 12:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232320AbjAXRud (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 12:50:33 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362F24C6D8;
        Tue, 24 Jan 2023 09:49:52 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 606D7320099F;
        Tue, 24 Jan 2023 12:49:21 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 24 Jan 2023 12:49:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1674582560; x=1674668960; bh=TiAYhPCl6q
        NczcRfD1WrZ3PWj1k4oktdgxFxtN95dnU=; b=qZLbKJY5rDjyOtK1FNm8R4Fj57
        V3fKol44bNw8vQU4lWZq8gHjeyA97xkCLFNivRLk9oUAffvedCNLJJzwRsbijZsJ
        oO920iWMTlA6g2Kjek1K2vBEqKYoR/xlTXCTVf2+q29h/Em1GeDeRy5qd5ErmInG
        SPa3wYa35HecBTnaP9CjTYA6ThgqIV7HerGIwfRuAayk5MCA9M8XXHHJ5zI70NEF
        HTi4pn2XSlDIT9iATdGwNkGdD2pkrfN8JDy0uq0np0NyY6dRAUirBlgl8hmE8Ejw
        +nKx385ive0/obXdxOby+8jyKwTj8Im+udbbc+B1GrNHzfuhWGkyHuOZ6sAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674582560; x=1674668960; bh=TiAYhPCl6qNczcRfD1WrZ3PWj1k4
        oktdgxFxtN95dnU=; b=PbjZfprjNETCkGCacq3BVexyZqsNXtT6+90L1ZGvzxyG
        4bQqaJnYmCZViLnix24fmr+raoMK6NX8/8Chqvx0b/K1qBNHYJNAS69n4E2Zm7zh
        Uy8sl0YLYP4/Xy9dqFI+g8OfOl53Y5dWR2IfVl5zG5yIvzYO4UV2NSTiLumbjzPU
        NikTLWXKviuctxEXSF5fnko9XgmOio9zhR+LAGFEiYm6knUc72WZht8V8/Yf7WJw
        xAUTvzBYXa6fznBDgzoTGy6Ve0ZMFTcXWbXubwkuNTSaybAX2ij3HV/Wzc0FrniG
        bBAjjsJy/NP1ovT+u4H3W0+xz04+2g+iPvsfWB4lTg==
X-ME-Sender: <xms:IBrQY8_M9mxcPDIVoNLf77xtisnl8Y5MXKrbcx-sAFJynKABdeBFHw>
    <xme:IBrQY0tK4blNKFsfVAkiq3BGL0D2_0kIVs8OxqbgitB8JEp-xYekP9fBZ6dXWqEac
    BLr2Bv7gzkX0dWv3mQ>
X-ME-Received: <xmr:IBrQYyBcMAwRQOX818Yf__ESIXhxHHRk7cp8j4u5WTzo7aLyrvvqF8L6uNIbhlN4YoDSUT-nokFGITnAU12QZxkrsXzaRqk2q4hvPU80>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvtddguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpehffgfhvfevufffjgfkgggtsehttdertddtredtnecuhfhrohhmpefuthgv
    fhgrnhcutfhovghstghhuceoshhhrhesuggvvhhkvghrnhgvlhdrihhoqeenucggtffrrg
    htthgvrhhnpefhgfejveduudehvdduvefguddvffefgffhieeuudefudfhhfeijeefjeff
    heelvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepshhhrhesuggvvhhkvghrnhgvlhdrihho
X-ME-Proxy: <xmx:IBrQY8dlv5U7D9D4KA-S-ZRBHiPEary6JoeQSO3XFV6RuIaeQtTb4Q>
    <xmx:IBrQYxPkpllkDctEYfqujUo3SbDDPKHvGd2KAzvJnUUdndkKGIdLQw>
    <xmx:IBrQY2nKYlmQ3TR0hy1lXCvhcxT7mTHDsjP5eD4VXXNyMXb39cvs5g>
    <xmx:IBrQY6iMLm81xJNgCD_I0O1GI2qjDoWbVOy8Pb7ZoLSCKKJ6foM0YQ>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Jan 2023 12:49:19 -0500 (EST)
References: <20230123173748.1734238-1-shr@devkernel.io>
 <5844ee9f-1992-a62a-2141-3b694a1e1915@redhat.com>
User-agent: mu4e 1.6.11; emacs 28.2.50
From:   Stefan Roesch <shr@devkernel.io>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, CGEL <cgel.zte@gmail.com>,
        Michal Hocko <mhocko@kernel.org>, Jann Horn <jannh@google.com>
Subject: Re: [RESEND RFC PATCH v1 00/20] mm: process/cgroup ksm support
Date:   Tue, 24 Jan 2023 09:37:33 -0800
In-reply-to: <5844ee9f-1992-a62a-2141-3b694a1e1915@redhat.com>
Message-ID: <qvqwbkmnj014.fsf@dev0134.prn3.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


David Hildenbrand <david@redhat.com> writes:

> On 23.01.23 18:37, Stefan Roesch wrote:
>> So far KSM can only be enabled by calling madvise for memory regions. What is
>> required to enable KSM for more workloads is to enable / disable it at the
>> process / cgroup level.
>
> Did you stumble over the proposals from last year to enable this per-process [1]
> and system-wide [2]? I remember there was also regarding enabling it
> system-wide.
>
I saw the earlier proposals. Enabling it at the system level doesn't
seem to be the right choice. You generally want to enable it at a more
fine-grained level. Therefore this enables it at the process level with
prctl.

> I'm going to point out the security aspect, and that e.g., Windows used to
> enable it system-wide before getting taught by security experts otherwise.
> Details on KSM and security aspects can be found in that thread.
>
If I'm not mistaken the security aspect exists today. When KSM is
enabled with madvise this is the same.

> Long story short: one has to be very careful with that and only enable it for
> very carefully selected worklads. Letting a workload opt-in on a VMA level is
> most probably safer than an admin blindly turning this on for random processes
> ...
>
Thats why this is enabled with prctl. Its a deliberate choice to enable
it for a process.

> Last attempts got nacked ...
>
> [1] https://lore.kernel.org/all/20220517092701.1662641-1-xu.xin16@zte.com.cn/
> [2] https://lore.kernel.org/all/20220609055658.703472-1-xu.xin16@zte.com.cn/
>
My understanding is that there were problems with the patch and how it
exposed KSM. The other objection was the enable-all configuration
option.

>> 1. New options for prctl system command
>> This patch series adds two new options to the prctl system call. The first
>> one allows to enable KSM at the process level and the second one to query the
>> setting.
>> The setting will be inherited by child processes.
>> With the above setting, KSM can be enabled for the seed process of a cgroup
>> and all processes in the cgroup will inherit the setting.
>> 2. Changes to KSM processing
>> When KSM is enabled at the process level, the KSM code will iterate over all
>> the VMA's and enable KSM for the eligible VMA's.
>> When forking a process that has KSM enabled, the setting will be inherited by
>> the new child process.
>> In addition when KSM is disabled for a process, KSM will be disabled for the
>> VMA's where KSM has been enabled.
>> 3. Add tracepoints to KSM
>> Currently KSM has no tracepoints. This adds tracepoints to the key KSM functions
>> to make it easier to debug KSM.
>> 4. Add general_profit metric
>> The general_profit metric of KSM is specified in the documentation, but not
>> calculated. This adds the general profit metric to /sys/kernel/debug/mm/ksm.
>> 5. Add more metrics to ksm_stat
>> This adds the process profit and ksm type metric to /proc/<pid>/ksm_stat.
>> 6. Add more tests to ksm_tests
>> This adds an option to specify the merge type to the ksm_tests. This allows to
>> test madvise and prctl KSM. It also adds a new option to query if prctl KSM has
>> been enabled. It adds a fork test to verify that the KSM process setting is
>> inherited by client processes.
>> Stefan Roesch (20):
>>    mm: add new flag to enable ksm per process
>>    mm: add flag to __ksm_enter
>>    mm: add flag to __ksm_exit call
>>    mm: invoke madvise for all vmas in scan_get_next_rmap_item
>>    mm: support disabling of ksm for a process
>>    mm: add new prctl option to get and set ksm for a process
>>    mm: add tracepoints to ksm
>>    mm: split off pages_volatile function
>>    mm: expose general_profit metric
>>    docs: document general_profit sysfs knob
>>    mm: calculate ksm process profit metric
>>    mm: add ksm_merge_type() function
>>    mm: expose ksm process profit metric in ksm_stat
>>    mm: expose ksm merge type in ksm_stat
>>    docs: document new procfs ksm knobs
>>    tools: add new prctl flags to prctl in tools dir
>>    selftests/vm: add KSM prctl merge test
>>    selftests/vm: add KSM get merge type test
>>    selftests/vm: add KSM fork test
>>    selftests/vm: add two functions for debugging merge outcome
>>   Documentation/ABI/testing/sysfs-kernel-mm-ksm |   8 +
>>   Documentation/admin-guide/mm/ksm.rst          |   8 +-
>>   MAINTAINERS                                   |   1 +
>>   fs/proc/base.c                                |   5 +
>>   include/linux/ksm.h                           |  19 +-
>>   include/linux/sched/coredump.h                |   1 +
>>   include/trace/events/ksm.h                    | 257 ++++++++++++++++++
>>   include/uapi/linux/prctl.h                    |   2 +
>>   kernel/sys.c                                  |  29 ++
>>   mm/ksm.c                                      | 134 ++++++++-
>>   tools/include/uapi/linux/prctl.h              |   2 +
>>   tools/testing/selftests/vm/Makefile           |   3 +-
>>   tools/testing/selftests/vm/ksm_tests.c        | 254 ++++++++++++++---
>>   13 files changed, 665 insertions(+), 58 deletions(-)
>>   create mode 100644 include/trace/events/ksm.h
>> base-commit: c1649ec55708ae42091a2f1bca1ab49ecd722d55
