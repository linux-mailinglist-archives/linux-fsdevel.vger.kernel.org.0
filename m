Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC7D77D0BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Aug 2023 19:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238688AbjHORSA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Aug 2023 13:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238730AbjHORRm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Aug 2023 13:17:42 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2945A19B5;
        Tue, 15 Aug 2023 10:17:23 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 276F93200927;
        Tue, 15 Aug 2023 13:17:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 15 Aug 2023 13:17:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1692119839; x=1692206239; bh=3Y
        Va9SLafbAppolvaU0gOB/8rD3tfIXlrgSkLKnfB8Y=; b=YUIGkNI61be5H3tfus
        iHULantyHkns1KFWmB7QbSj2jlBI/43ex2LjoimptigzKEA2091tP4nHePhDlRbc
        McqGkeqlOgR/i8+DLk/7mKsgcC0UrVyUkcaEVknLEP8hMCHbYW5fBsJ+0roI8RzO
        D48ayd/NjyLDrXJqzjK1qEtWY7LsQ3PKVhp//JLdl/mqQB4ZXd95lrgOL5GWUQSc
        V69XU9IiiKFdbwdnEIy7KXrXRjCvYc5IogbaE450SjQPBcik/uqtVcc15b5fock1
        8wdiG0RHFQZbSo1NxnOIqUMqhxQrJBz4wQPBMWitbLIM6yIrhUiHCtsVM52El3iH
        VNmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1692119839; x=1692206239; bh=3YVa9SLafbApp
        olvaU0gOB/8rD3tfIXlrgSkLKnfB8Y=; b=UnNWA4GGhDaLfvAUjXw17Uy0Ld52N
        6gCfwIZ1B75jBvJjh3OWEAlXFutO16XUyDPjpQAguXsrJMfgbmWm8PXuVTBLglFT
        J7vugOmDvKeDrENQG2jSJkMeTonnx6CJ4RlvgthnsRvxaIEQIGPYxAMR5vbCBQZ6
        /YYij/Te5zSF7i+wG0mkiy2A5nXrwLmfASOP+GVrxhcTyxWGtWHalQZSGRZ5ZcvW
        fFAMiRJ2UX2vzD2XVFKW5vI0Tsn36pwuobN2DyvIriLlQlaXXLG6WH+hJiYumwu0
        sHFHNj451bMDdEh+vj3OaSaitgNvwu55lk22yoh0BVuSVNKfDxJjk0L0Q==
X-ME-Sender: <xms:H7PbZOB4w2w2Ig_-GbHret7dwYJqG46bcENqBkdtp1XeyBuujGnE4g>
    <xme:H7PbZIjTSeS5Cz3DFdkEb8W72nJtaOlJNX74U-1B9XJhZHWS0ewO6PL88SwRZcSSX
    8Pcb2K3QSLInWMmrNw>
X-ME-Received: <xmr:H7PbZBmZO3Bm7nOIsPYfITP2V-w7H3wxyx2H25MqN8249RMnvxPrns36wlcTJbnKvPSH5JIdjJ9ztAYI2LkujhInmCOUehbD-luH1B6u-TpF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddtjedgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpehffgfhvfevufffjgfkgggtsehttdertddtredtnecuhfhrohhmpefuthgv
    fhgrnhcutfhovghstghhuceoshhhrhesuggvvhhkvghrnhgvlhdrihhoqeenucggtffrrg
    htthgvrhhnpeevlefggffhheduiedtheejveehtdfhtedvhfeludetvdegieekgeeggfdu
    geeutdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hshhhrseguvghvkhgvrhhnvghlrdhioh
X-ME-Proxy: <xmx:H7PbZMwR3Gou9-6boagvl9gEf1PyBtV96nVG_HBYDIe4OLj3p8756A>
    <xmx:H7PbZDSgBMRAu1zJ-NKbX0xXgz9puQdsMXrP0C0Nnnr2adCrDTYK0Q>
    <xmx:H7PbZHaKveZQkv017C_Bl6_MvXWb6lwwaKnSVf3Gq-9qenD2vSD8wA>
    <xmx:H7PbZCHWgJWwfo4rDIv6sq2XvOJl1iA7G3C4tkOEw-80KO7NLK_mew>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Aug 2023 13:17:18 -0400 (EDT)
References: <20230811162803.1361989-1-shr@devkernel.io>
 <43d64aee-4bd9-bba0-9434-55cec26bd9dc@redhat.com>
User-agent: mu4e 1.10.1; emacs 28.2.50
From:   Stefan Roesch <shr@devkernel.io>
To:     David Hildenbrand <david@redhat.com>
Cc:     kernel-team@fb.com, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
        riel@surriel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] proc/ksm: add ksm stats to /proc/pid/smaps
Date:   Tue, 15 Aug 2023 10:10:55 -0700
In-reply-to: <43d64aee-4bd9-bba0-9434-55cec26bd9dc@redhat.com>
Message-ID: <qvqwmsysdy3p.fsf@devbig1114.prn1.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


David Hildenbrand <david@redhat.com> writes:

> Sorry for the late reply, Gmail once again decided to classify your mails as
> spam (for whatever reason).
>
> On 11.08.23 18:28, Stefan Roesch wrote:
>> With madvise and prctl KSM can be enabled for different VMA's. Once it
>> is enabled we can query how effective KSM is overall. However we cannot
>> easily query if an individual VMA benefits from KSM.
>> This commit adds a KSM section to the /prod/<pid>/smaps file. It reports
>> how many of the pages are KSM pages.
>> Here is a typical output:
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
>> This information also helps with the following workflow:
>> - First enable KSM for all the VMA's of a process with prctl.
>> - Then analyze with the above smaps report which VMA's benefit the most
>> - Change the application (if possible) to add the corresponding madvise
>> calls for the VMA's that benefit the most
>> Signed-off-by: Stefan Roesch <shr@devkernel.io>
>> ---
>>   Documentation/filesystems/proc.rst | 3 +++
>>   fs/proc/task_mmu.c                 | 5 +++++
>>   2 files changed, 8 insertions(+)
>> diff --git a/Documentation/filesystems/proc.rst
>> b/Documentation/filesystems/proc.rst
>> index 7897a7dafcbc..4ef3c0bbf16a 100644
>> --- a/Documentation/filesystems/proc.rst
>> +++ b/Documentation/filesystems/proc.rst
>> @@ -461,6 +461,7 @@ Memory Area, or VMA) there is a series of lines such as the following::
>>       Private_Dirty:         0 kB
>>       Referenced:          892 kB
>>       Anonymous:             0 kB
>> +    KSM:                   0 kB
>>       LazyFree:              0 kB
>>       AnonHugePages:         0 kB
>>       ShmemPmdMapped:        0 kB
>> @@ -501,6 +502,8 @@ accessed.
>>   a mapping associated with a file may contain anonymous pages: when MAP_PRIVATE
>>   and a page is modified, the file page is replaced by a private anonymous copy.
>>   +"KSM" shows the amount of anonymous memory that has been de-duplicated.
>
>
> How do we want to treat memory that has been deduplicated into the shared
> zeropage?
>
> It would also match this description.
>
> See in mm-stable:
>
> commit 30ff6ed9a65c7e73545319fc15f7bcf9c52457eb
> Author: xu xin <xu.xin16@zte.com.cn>
> Date:   Tue Jun 13 11:09:28 2023 +0800
>
>     ksm: support unsharing KSM-placed zero pages
>
>     Patch series "ksm: support tracking KSM-placed zero-pages", v10.

I see two approaches how to deal with zero page:
 - If zero page is not enabled, it works as is
 - If enabled
    - Document that zero page is accounted for the current vma or
    - Pass in the pte from smaps_pte_entry() to smaps_account() so we can
    determine if this is a zero page.
    I'm not sure what to do about smaps_pmd_entry in that case. We
    probably don't care about compund pages.
