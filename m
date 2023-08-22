Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D956784935
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Aug 2023 20:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjHVSFd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Aug 2023 14:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjHVSFd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Aug 2023 14:05:33 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DB010EB;
        Tue, 22 Aug 2023 11:04:58 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 562A7320082A;
        Tue, 22 Aug 2023 14:03:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 22 Aug 2023 14:03:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1692727433; x=1692813833; bh=1H
        tTCgJc0ZUa0k/Dq5F5KRBm+gk3KHx/7qQeQ8kY1jM=; b=nZsyCCnnMgdO1jntrd
        hhIoQVgbVRN4XBA7ltAGNkUrqy6b+VhnySBUbnekQiw9pBHQacvqDvnyI96uTRsZ
        ThRwMZFMkZexR0EQAjEVuylVFrJp+w7hF+g9edswmi9ftBUEwp4gySC/qtGW4SeS
        4sn0Pm5frk/7Zr5UMU7waweSB66nhckmHvi4/QHolythKXnRResiQV7TlZuW3Z4k
        vLoGn7AaeFG0pPhIjGKfb/MuRF5UaAPXjnAWWOo4pHzemA22bEM3JiaQHhLz0vJP
        IRq9iWBPlh2xBxfUOPn3FpcIgHOpZr2ceF4iuA6LYMkNKMOfa+yCsiAyTWFJFn/j
        LTNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1692727433; x=1692813833; bh=1HtTCgJc0ZUa0
        k/Dq5F5KRBm+gk3KHx/7qQeQ8kY1jM=; b=EHkCF1bJhw7orL/GQThs6FpRSO6Pd
        rimPKj40oFxjzbXvEw1SN+vifDkMOqwTenLz+s0YaT8wzBfJjc+VYP2IoHMPlLYH
        AuTDJQJipFeH9UCUy0BPs5Ypm3u5bf2xTOk7+h4xhp/cDkwklMHyEbjdigHUiSN4
        IW2ycjD7ZYWSEFDG1BfsEePcy82S5GnNVQpVEuqJy+DG585Hfrk8bxDfRz4TrsCr
        qp8Cnj1ZMBm2Neq6c/EH9rSlLX5CH+FZXdi9zdwlhx9CCxesvw/cDO47h9HMb4A5
        tI8lxHjsLbq0cGp4ubhF8egANB7fzh9XGuA5rjHP8Kg4Q86/CAGccJAtA==
X-ME-Sender: <xms:ifjkZBV_G5vQJGesHNKERPGm5tpaBqSo2rTb533HnPLJjQACNW4_gQ>
    <xme:ifjkZBkWNGR-G9yshgovFpjowo7BHdjvY1mLswIGVCo1lWuhhXbXxj93WZZt94jAE
    QvOkHXWgch4tkvI_5E>
X-ME-Received: <xmr:ifjkZNY2dHpAN4uqSsFqB4EkwcrUvYptmacC1CWtDK4iXYMsLZm8RIQUVDetalO6asvfCVhMlQMmTsA5IoPmYAhLmKGH6AX-mkimqb25PY8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddvuddguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpehffgfhvfevufffjgfkgggtsehttdertddtredtnecuhfhrohhmpefuthgv
    fhgrnhcutfhovghstghhuceoshhhrhesuggvvhhkvghrnhgvlhdrihhoqeenucggtffrrg
    htthgvrhhnpeevlefggffhheduiedtheejveehtdfhtedvhfeludetvdegieekgeeggfdu
    geeutdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hshhhrseguvghvkhgvrhhnvghlrdhioh
X-ME-Proxy: <xmx:ifjkZEUJ6_LYlHRsLpH2OQuXffwe3f1k9NqjtbrDZScskjHWe4dzQA>
    <xmx:ifjkZLm0Rjbb-i8qP-g_5x9i9RPB88X5-CV2SXOFfxmVqr_j0ETcUg>
    <xmx:ifjkZBfF6yuz5XHgCkWO0L8osObItaBOtfaALjzaYj3X7j3KawEzww>
    <xmx:ifjkZJbT6rnEE3N7VLSZciPZTqKe1DT2T_zZKJ7M5A2-eflWfnIYMg>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Aug 2023 14:03:52 -0400 (EDT)
References: <20230817162301.3472457-1-shr@devkernel.io>
 <886b6a56-8acb-e975-b5f3-d8098a2285ab@redhat.com>
User-agent: mu4e 1.10.1; emacs 28.2.50
From:   Stefan Roesch <shr@devkernel.io>
To:     David Hildenbrand <david@redhat.com>
Cc:     kernel-team@fb.com, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
        riel@surriel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3] proc/ksm: add ksm stats to /proc/pid/smaps
Date:   Tue, 22 Aug 2023 11:03:16 -0700
In-reply-to: <886b6a56-8acb-e975-b5f3-d8098a2285ab@redhat.com>
Message-ID: <qvqw350b2buj.fsf@devbig1114.prn1.facebook.com>
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

> On 17.08.23 18:23, Stefan Roesch wrote:
>> With madvise and prctl KSM can be enabled for different VMA's. Once it
>> is enabled we can query how effective KSM is overall. However we cannot
>> easily query if an individual VMA benefits from KSM.
>> This commit adds a KSM section to the /prod/<pid>/smaps file. It reports
>> how many of the pages are KSM pages. The returned value for KSM is
>> independent of the use of the shared zeropage.
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
>>   Documentation/filesystems/proc.rst | 4 ++++
>>   fs/proc/task_mmu.c                 | 5 +++++
>>   2 files changed, 9 insertions(+)
>> diff --git a/Documentation/filesystems/proc.rst
>> b/Documentation/filesystems/proc.rst
>> index 7897a7dafcbc..d5bdfd59f5b0 100644
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
>> @@ -501,6 +502,9 @@ accessed.
>>   a mapping associated with a file may contain anonymous pages: when MAP_PRIVATE
>>   and a page is modified, the file page is replaced by a private anonymous copy.
>>   +"KSM" shows the amount of anonymous memory that has been de-duplicated. The
>> +value is independent of the use of shared zeropage.
>> +
>>   "LazyFree" shows the amount of memory which is marked by madvise(MADV_FREE).
>>   The memory isn't freed immediately with madvise(). It's freed in memory
>>   pressure if the memory is clean. Please note that the printed value might
>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>> index 51315133cdc2..f591c750ffda 100644
>> --- a/fs/proc/task_mmu.c
>> +++ b/fs/proc/task_mmu.c
>> @@ -396,6 +396,7 @@ struct mem_size_stats {
>>   	unsigned long swap;
>>   	unsigned long shared_hugetlb;
>>   	unsigned long private_hugetlb;
>> +	unsigned long ksm;
>>   	u64 pss;
>>   	u64 pss_anon;
>>   	u64 pss_file;
>> @@ -452,6 +453,9 @@ static void smaps_account(struct mem_size_stats *mss, struct page *page,
>>   			mss->lazyfree += size;
>>   	}
>>   +	if (PageKsm(page))
>> +		mss->ksm += size;
>> +
>
> Did you accidentally not include handling of the KSM-shared zeropage?
>
> Or did I misinterpret "independent of the use of the shared zeropage."

I think I misunderstood your review comment. I'll address it in the next version.
