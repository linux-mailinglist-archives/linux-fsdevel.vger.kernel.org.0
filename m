Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9DC77453B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 20:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbjHHSjJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 14:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjHHSir (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:38:47 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4954F28949
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Aug 2023 10:52:26 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id CFDF55C0114;
        Tue,  8 Aug 2023 13:52:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 08 Aug 2023 13:52:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1691517143; x=1691603543; bh=gs
        RzqsPv0D50dYYvXCyt8FH+bEkTzZQKhUQ82O4Gc/8=; b=MMy2PWim3Y4wSGGjcH
        gShZzBcpxNGohr/t5dU0Zxh4dqeXR4OPNPWiHJjPUWi8eFN5cu3m3aG0kzaWMJMM
        wPg2KT1z9LjtCEbP8VfcroNVfkusLJPPMsNZNDEO0Auz3H3RtwBjtKpx140F4IQ4
        C5RzMNJysoLPZIOvb7tYpQRulaCJ6wxH4hXiuMZXMGWRpChv+c7rGkKTbvVophZq
        1yWEQ0MQsDdiBTcwV0G5T3pRibRODVo0s1y+CSITvzKEmXqM055bj6p7PaO83w3R
        WDp/E8769V6+QwY9XJVOqPnaKXbl1lskRogWnCsnTEdA85eDA2Xd/YeNoKXByAmH
        h38A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1691517143; x=1691603543; bh=gsRzqsPv0D50d
        YYvXCyt8FH+bEkTzZQKhUQ82O4Gc/8=; b=NDelgJiGKbDAuOcEoWE2qhXjWTE9F
        UG3MqxIDI70NBC51M34GJt67D1QaipmGoJQqftLJdcaGI3sNxrkSA5t/ACQ7clNB
        FLuFO78f2waLReIzzuISdoX9WZukFzVgp/tVl35NgFZiUuHI0kej/3PWW9Itz1tP
        eelA9fFkFwP4iXRBDtBaeAs/48hz8vBj6VwTabYoaB2YJ39olUmEcXbXmGoj2FFd
        WlKotb+mFv/IJh1GC3gFJAzkdeSUcQIri10PBL8BM+7ycMJIkP1V/KGrBZRy67B2
        q6zzzngJ/mzSA5i2CGLo5FqE1y6LiosX8OD5OaAhTwlrxq1aCdaoOTPzQ==
X-ME-Sender: <xms:14DSZMbi-NdLVQ6vAH-tyJ-F3VoFqCNi147wTXiIBb8Rs6vYThRRIg>
    <xme:14DSZHaONJs95kejzgK5JIu0juE2PtW1iBabHTdjW0Pol-wI5Fs92g5aBY5kN3jwb
    lOOcPRRJ7kWdWMgaoo>
X-ME-Received: <xmr:14DSZG8Eh-31WyV-QkkA3NVz3gjgGVGmdxEEeqtt1QQ7I9Ntrj3xhKGF3Np1PLKN0e9p4R9owFttsVniks32-IlgrxdKD7nPsEbDxSRoA5nq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrledvgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpehffgfhvfevufffjgfkgggtsehttd
    ertddtredtnecuhfhrohhmpefuthgvfhgrnhcutfhovghstghhuceoshhhrhesuggvvhhk
    vghrnhgvlhdrihhoqeenucggtffrrghtthgvrhhnpeevlefggffhheduiedtheejveehtd
    fhtedvhfeludetvdegieekgeeggfdugeeutdenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehshhhrseguvghvkhgvrhhnvghlrdhioh
X-ME-Proxy: <xmx:14DSZGoJsA2hc1t1_qzJF3qeHxEbFLz-WnciCDp1AhwOpkaAI5ml_g>
    <xmx:14DSZHoCZdK5IZ65W7yw9Q65v7DYwB8wVX9NnTJm_KSfz8RpSm6j8Q>
    <xmx:14DSZERGmuq92skfcbKJ5f5xxGM9aNuUenEpcmbJrvBMeLm3M_C5pg>
    <xmx:14DSZIl4vEI7OLfiLNWjK7QAlOYbLGMsO1OXdJfHReS-kSjRxhkAsQ>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Aug 2023 13:52:22 -0400 (EDT)
References: <20230808170858.397542-1-shr@devkernel.io>
 <20230808101713.766c270cc0465c3938f24182@linux-foundation.org>
User-agent: mu4e 1.10.1; emacs 28.2.50
From:   Stefan Roesch <shr@devkernel.io>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-team@fb.com, david@redhat.com,
        linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org, riel@surriel.com
Subject: Re: [PATCH v1] proc/ksm: add ksm stats to /proc/pid/smaps
Date:   Tue, 08 Aug 2023 10:51:22 -0700
In-reply-to: <20230808101713.766c270cc0465c3938f24182@linux-foundation.org>
Message-ID: <qvqw7cq5pgkr.fsf@devbig1114.prn1.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Andrew Morton <akpm@linux-foundation.org> writes:

> On Tue,  8 Aug 2023 10:08:58 -0700 Stefan Roesch <shr@devkernel.io> wrote:
>
>> With madvise and prctl KSM can be enabled for different VMA's. Once it
>> is enabled we can query how effective KSM is overall. However we cannot
>> easily query if an individual VMA benefits from KSM.
>>
>> This commit adds a KSM section to the /prod/<pid>/smaps file. It reports
>> how many of the pages are KSM pages.
>>
>> Here is a typical output:
>>
>> 7f420a000000-7f421a000000 rw-p 00000000 00:00 0
>> Size:             262144 kB
>> KernelPageSize:        4 kB
>> MMUPageSize:           4 kB
>> Rss:               51212 kB
>> Pss:                8276 kB
>> Shared_Clean:        172 kB
>> Shared_Dirty:      42996 kB
>> Private_Clean:       196 kB
>> Private_Dirty:      7848 kB
>> Referenced:        15388 kB
>> Anonymous:         51212 kB
>> KSM:               41376 kB
>> LazyFree:              0 kB
>> AnonHugePages:         0 kB
>> ShmemPmdMapped:        0 kB
>> FilePmdMapped:         0 kB
>> Shared_Hugetlb:        0 kB
>> Private_Hugetlb:       0 kB
>> Swap:             202016 kB
>> SwapPss:            3882 kB
>> Locked:                0 kB
>> THPeligible:    0
>> ProtectionKey:         0
>> ksm_state:          0
>> ksm_skip_base:      0
>> ksm_skip_count:     0
>> VmFlags: rd wr mr mw me nr mg anon
>>
>> This information also helps with the following workflow:
>> - First enable KSM for all the VMA's of a process with prctl.
>> - Then analyze with the above smaps report which VMA's benefit the most
>> - Change the application (if possible) to add the corresponding madvise
>> calls for the VMA's that benefit the most
>
> smaps is documented in Documentation/filesystems/proc.rst, please.
> (And it looks a bit out of date).
>
> Did you consider adding this info to smaps_rollup as well?

The smaps_rollup is covered. Under the covers it uses the same code as smaps.
