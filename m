Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5005D77455D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 20:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjHHSmI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 14:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbjHHSlp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:41:45 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E849418BA6E
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Aug 2023 10:32:56 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 5E28E5C0108;
        Tue,  8 Aug 2023 13:32:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 08 Aug 2023 13:32:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1691515976; x=1691602376; bh=iP
        j0exuBEF3AqLS1VgI/T9f95tOgJca9fEdSmiFmSZ0=; b=JLZUaYZVjUsspA1vVk
        uZETgz3FkI7t6Mqp7pGDl2HZf6TzcktLJLz5gFII867IQomLxWzlqMsAyuLZP3Q8
        VcepS29hOvCRZhw55hFtVAlIDeFl92mHlKUGpgolTwwlUVRfrUfPvvPs5/PthbcS
        vp+r2DseqxWHNCyNukKONS0UBr3K2Cn83VjC5jlm1in8TMUyXEkxuqtf01wmAQ2+
        D4ZspvgZEXdBKeflBHYkfoACmJq0WaGvfdBemzlESdZt4XxZbmkwZKnq4agjS94v
        4Me+XPsg7HL4ois9hBLgs3GuxPdWFVGAiJTDE+0CpQNxU9oWYoJcj1IalaLVmXfB
        641A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1691515976; x=1691602376; bh=iPj0exuBEF3Aq
        LS1VgI/T9f95tOgJca9fEdSmiFmSZ0=; b=hilm+9wWZU+33upO/JONIyTiv1sRW
        lNutY8WgiyF8t8uwZ71GUmLVtODvCRgj6tk9sqeTWyaXhVjtJQidY/u90CnkM+NP
        +QChNrW3iT+PQb68fhaduQ6KgIty3qyxZwgdBBOIF+yy914/Y0jMEscTMz+YLHKU
        M/CI0ZBWM5bT5rOrww6NadN8ijgg7Ey8TCP/RqXl+3YVnbM6Dh9QS/zB7Sh8XASA
        BB2S7/4b7IwQrZiacLkTKGXkrHyLmixXcOaxcy1NxSXMhfbMrjCfDFvHdnPXRz5D
        grDysqC2whjY0Jv3y1rWEROo0A5q2uMxrF/n47rGxFaqzHEczhxYBKV7A==
X-ME-Sender: <xms:R3zSZJbGV0VYu2clbopvMfItsZ7WYJcDNaaGKh_Jd24_cMQ3pLRfHw>
    <xme:R3zSZAZuCNE7eEEQC45Fjv1lkWFDZep1vcYiL43297T4z6twETyDQchCYIoNjC_Zc
    _F0p50_QVMvbiQHTsE>
X-ME-Received: <xmr:R3zSZL-UWCxU1D4l4PFtbBW6VVJX_Zg7MjPQrrVo-drsO5pTlvleHeyifd3spo8CYtc4FwvlUQfW5OvhF2z9aC_z0nraL0RW20EEJ8cCbl1->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrledvgdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpehffgfhvfevufffjgfkgggtsehttd
    ertddtredtnecuhfhrohhmpefuthgvfhgrnhcutfhovghstghhuceoshhhrhesuggvvhhk
    vghrnhgvlhdrihhoqeenucggtffrrghtthgvrhhnpeevlefggffhheduiedtheejveehtd
    fhtedvhfeludetvdegieekgeeggfdugeeutdenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehshhhrseguvghvkhgvrhhnvghlrdhioh
X-ME-Proxy: <xmx:R3zSZHpbUn4DzR1Tt9Mkvgqj2RsOKxclq6jSDvrjZZTmHJGbzi-Aog>
    <xmx:R3zSZEpT_COC9uITZatbYiYChLIuCkmegJTWXhhciuJM9erCmkQjNg>
    <xmx:R3zSZNSOYnrm1CY1KkXza_zqYaa5w7_k7BdT15xHdEpmDSB7eR6wMg>
    <xmx:SHzSZNkXmp96Ws4xNZVzAYPkR4FQePfTaqm697PuqAJYjarSJhHVIA>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Aug 2023 13:32:55 -0400 (EDT)
References: <20230808170858.397542-1-shr@devkernel.io>
 <20230808101713.766c270cc0465c3938f24182@linux-foundation.org>
User-agent: mu4e 1.10.1; emacs 28.2.50
From:   Stefan Roesch <shr@devkernel.io>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-team@fb.com, david@redhat.com,
        linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org, riel@surriel.com
Subject: Re: [PATCH v1] proc/ksm: add ksm stats to /proc/pid/smaps
Date:   Tue, 08 Aug 2023 10:32:27 -0700
In-reply-to: <20230808101713.766c270cc0465c3938f24182@linux-foundation.org>
Message-ID: <qvqwbkfhphh6.fsf@devbig1114.prn1.facebook.com>
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

I'll add the documentation of the knob.

> Did you consider adding this info to smaps_rollup as well?

I'll have a look.
