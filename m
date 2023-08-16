Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA3777E642
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 18:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344647AbjHPQWs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 12:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344667AbjHPQWa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 12:22:30 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E031C1;
        Wed, 16 Aug 2023 09:22:29 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 9B0EF5C00A9;
        Wed, 16 Aug 2023 12:22:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 16 Aug 2023 12:22:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1692202948; x=1692289348; bh=ls
        RtaTNVobWQ1QYQuf1PXHLidC8c/K56+tUwFDf+W1s=; b=LweUZTQitbkPkyPv+P
        AUoeEO8q8DAWpXFs39CnFzS0yPT6yEdBYwSfaj2UFCwQVPDLNAA14DA5Nlk6Il7m
        FvLQawh57P75apVu662fOa9r3u29VKtDuJVLA26KOzH2icptGh1VTG5suki6yKUJ
        SH6bWLRYlMKAzOT8s0xdTZjDOJ7s/hUZcZVBG46GNdIHjCpMwmUsYIUUUkkYVwwT
        cvbSVdYTFdAXZXK3fUffKaiRF1R2XBJe5qfEp4NwYgWEAL5ZiZkPf6/ArNd/cIPu
        kDV3zujGlvKY2tVFLeOWroVlW6hV2sePmB7dSRFhYQjOGBkpD82b/XgS8LNuk9+z
        33bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1692202948; x=1692289348; bh=lsRtaTNVobWQ1
        QYQuf1PXHLidC8c/K56+tUwFDf+W1s=; b=fVPFI/k3HxbxqvvKOssjyYK/I8/tY
        y7cXXizRSmm4/xoqgsHRIIoGrxUk+jDfy3gycjySI7yyd3CVSc+eFzk42d2AdeDp
        xzPrx7cCqfsf4LPCuRNqDCGKXzFvI5QrDgfPMfhIBdjgQyd76KuqDLkM0b0sZWWj
        xYV5jPfoDBcJ/VvABK8yO7OUqtR3LEcOOTX8Liwm2NecBoYma5sNYdMlvPat+oIs
        PinrrWQcuJf8IoNC8w3GZVzuYMA1G7y0xgxtp+ozaI5t3WutIGInXJGFeAR28mHG
        dMEVYHelmeSQQxVKGL/xS6r2NetrcG9tO34VcP9bcxhIy7RnsZoWV1+Aw==
X-ME-Sender: <xms:w_fcZPRtBf-RBIZGhPO0yHthLzClstEYcPVlLokspEpVMDxLyxk0uw>
    <xme:w_fcZAwl_7JyvWJQluztpzwt_h3fi-VL5jprp7SgyY69GVCu1wydkmahc-1-qhcEn
    q7WkL9H7NsO5BZXL54>
X-ME-Received: <xmr:w_fcZE3mW_hKGfGUVXMd-VtGZF0xtBVCOU6Zk4iHEuzo1HthJzcQ7bShAyeqTFzZWGFLTZ2j-ijRoiSWEBBcRp7ce2LtI3rfvMwbOcP95dwn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddtledguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpehffgfhvfevufffjgfkgggtsehttdfotddtredtnecuhfhrohhmpefuthgv
    fhgrnhcutfhovghstghhuceoshhhrhesuggvvhhkvghrnhgvlhdrihhoqeenucggtffrrg
    htthgvrhhnpeefledufefhgedvffeiuefhvddutedvteefgfeigeffudfhgeffueduveek
    ieeuudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hshhhrseguvghvkhgvrhhnvghlrdhioh
X-ME-Proxy: <xmx:xPfcZPCo6anFrryfvacNsUbSWArInIRyGjqhhHQGccNjx2l5tF0tWg>
    <xmx:xPfcZIhSyF8JzU8NYbL05W4tNK-2vqXU5ZL-6KsomXQPCg3aZq6cfw>
    <xmx:xPfcZDrwt0jfWH0ygpjU4KG5trfVpa0zV_vzpCHB3_Iz8nWX5sC0_w>
    <xmx:xPfcZDU4Osmoss4YW6i7R-cBMhCvX-Q1KjGoYl1A9ymVnP006OmyBw>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Aug 2023 12:22:27 -0400 (EDT)
References: <20230811162803.1361989-1-shr@devkernel.io>
 <43d64aee-4bd9-bba0-9434-55cec26bd9dc@redhat.com>
 <qvqwmsysdy3p.fsf@devbig1114.prn1.facebook.com>
 <ad33c7f1-8c7c-27b6-7c2e-adbb349f2dff@redhat.com>
User-agent: mu4e 1.10.1; emacs 28.2.50
From:   Stefan Roesch <shr@devkernel.io>
To:     David Hildenbrand <david@redhat.com>
Cc:     kernel-team@fb.com, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
        riel@surriel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] proc/ksm: add ksm stats to /proc/pid/smaps
Date:   Wed, 16 Aug 2023 09:22:03 -0700
In-reply-to: <ad33c7f1-8c7c-27b6-7c2e-adbb349f2dff@redhat.com>
Message-ID: <qvqwmsyrgdof.fsf@devbig1114.prn1.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


David Hildenbrand <david@redhat.com> writes:

> On 15.08.23 19:10, Stefan Roesch wrote:
>> David Hildenbrand <david@redhat.com> writes:
>>
>>> Sorry for the late reply, Gmail once again decided to classify your mails as
>>> spam (for whatever reason).
>>>
>>> On 11.08.23 18:28, Stefan Roesch wrote:
>>>> With madvise and prctl KSM can be enabled for different VMA's. Once it
>>>> is enabled we can query how effective KSM is overall. However we cannot
>>>> easily query if an individual VMA benefits from KSM.
>>>> This commit adds a KSM section to the /prod/<pid>/smaps file. It reports
>>>> how many of the pages are KSM pages.
>>>> Here is a typical output:
>>>> 7f420a000000-7f421a000000 rw-p 00000000 00:00 0
>>>> Size:             262144 kB
>>>> KernelPageSize:        4 kB
>>>> MMUPageSize:           4 kB
>>>> Rss:               51212 kB
>>>> Pss:                8276 kB
>>>> Shared_Clean:        172 kB
>>>> Shared_Dirty:      42996 kB
>>>> Private_Clean:       196 kB
>>>> Private_Dirty:      7848 kB
>>>> Referenced:        15388 kB
>>>> Anonymous:         51212 kB
>>>> KSM:               41376 kB
>>>> LazyFree:              0 kB
>>>> AnonHugePages:         0 kB
>>>> ShmemPmdMapped:        0 kB
>>>> FilePmdMapped:         0 kB
>>>> Shared_Hugetlb:        0 kB
>>>> Private_Hugetlb:       0 kB
>>>> Swap:             202016 kB
>>>> SwapPss:            3882 kB
>>>> Locked:                0 kB
>>>> THPeligible:    0
>>>> ProtectionKey:         0
>>>> ksm_state:          0
>>>> ksm_skip_base:      0
>>>> ksm_skip_count:     0
>>>> VmFlags: rd wr mr mw me nr mg anon
>>>> This information also helps with the following workflow:
>>>> - First enable KSM for all the VMA's of a process with prctl.
>>>> - Then analyze with the above smaps report which VMA's benefit the most
>>>> - Change the application (if possible) to add the corresponding madvise
>>>> calls for the VMA's that benefit the most
>>>> Signed-off-by: Stefan Roesch <shr@devkernel.io>
>>>> ---
>>>>    Documentation/filesystems/proc.rst | 3 +++
>>>>    fs/proc/task_mmu.c                 | 5 +++++
>>>>    2 files changed, 8 insertions(+)
>>>> diff --git a/Documentation/filesystems/proc.rst
>>>> b/Documentation/filesystems/proc.rst
>>>> index 7897a7dafcbc..4ef3c0bbf16a 100644
>>>> --- a/Documentation/filesystems/proc.rst
>>>> +++ b/Documentation/filesystems/proc.rst
>>>> @@ -461,6 +461,7 @@ Memory Area, or VMA) there is a series of lines such as the following::
>>>>        Private_Dirty:         0 kB
>>>>        Referenced:          892 kB
>>>>        Anonymous:             0 kB
>>>> +    KSM:                   0 kB
>>>>        LazyFree:              0 kB
>>>>        AnonHugePages:         0 kB
>>>>        ShmemPmdMapped:        0 kB
>>>> @@ -501,6 +502,8 @@ accessed.
>>>>    a mapping associated with a file may contain anonymous pages: when MAP_PRIVATE
>>>>    and a page is modified, the file page is replaced by a private anonymous copy.
>>>>    +"KSM" shows the amount of anonymous memory that has been de-duplicated.
>>>
>>>
>>> How do we want to treat memory that has been deduplicated into the shared
>>> zeropage?
>>>
>>> It would also match this description.
>>>
>>> See in mm-stable:
>>>
>>> commit 30ff6ed9a65c7e73545319fc15f7bcf9c52457eb
>>> Author: xu xin <xu.xin16@zte.com.cn>
>>> Date:   Tue Jun 13 11:09:28 2023 +0800
>>>
>>>      ksm: support unsharing KSM-placed zero pages
>>>
>>>      Patch series "ksm: support tracking KSM-placed zero-pages", v10.
>> I see two approaches how to deal with zero page:
>>   - If zero page is not enabled, it works as is
>>   - If enabled
>>      - Document that zero page is accounted for the current vma or
>>      - Pass in the pte from smaps_pte_entry() to smaps_account() so we can
>>      determine if this is a zero page.
>
> That's probably the right thing to do: make the stat return the same value
> independent of the usage of the shared zeropage.
>

I'll update the documentation accordingly.

>>      I'm not sure what to do about smaps_pmd_entry in that case. We
>>      probably don't care about compund pages.
>
> No, KSM only places the shared zeropage for PTEs, no need to handle PMDs.
