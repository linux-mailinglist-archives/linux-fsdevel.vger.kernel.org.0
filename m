Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2C1785D68
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 18:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237578AbjHWQnn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 12:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbjHWQnn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 12:43:43 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D4D11F;
        Wed, 23 Aug 2023 09:43:40 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id BC8B45C00C7;
        Wed, 23 Aug 2023 12:43:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 23 Aug 2023 12:43:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1692809017; x=1692895417; bh=Ck
        dE8+B7DSfWbcYZjDLUGWPBGo+THho9cEGj+3Fl/JI=; b=wMAuenXU7uAMxJQ+un
        Z0vNs0efonN27DruxHcazveEKvpryFrrmFlavrLxVJ+XYWjjArwfWyCdsh3h8Oa6
        vojoExie7hh5F+l0wXSd8IPz/krxMdNUqPFiq7t3jgtCIN3cJdHa5p4WJj46XhpC
        /pYkLtvJVnmnD4R0NSqyjaBodgvCuwuqxrbfYouU2cKV5PffBF4FmT8mgYfhU6nP
        FyFWlHSsRNUQBvK3HNtgoXYD1RirJlhSMmyx8tpKHyVWwYhDp0v+gKZN1F3/dZLn
        5xSC8bTSw48o1yGxtOhowQNmZYb327nOjci0C23fT8QRzHPXfqXgskn7UUdikRZI
        5JSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1692809017; x=1692895417; bh=CkdE8+B7DSfWb
        cYZjDLUGWPBGo+THho9cEGj+3Fl/JI=; b=Ddvvybt+6xTafibd//Y3R/QocKM39
        d0j6Z4aYbtMnvzZ9mqfxpAX3wFVQm5MclxZeJiHxjnVU2isbrcAsbbMDhrk1cP/Z
        Lhr2Sq5xkJToRgXvqSrB+TLJjIl1m5l8XNIdobmoyM4Ee6tHcBAIiyHQAGwAkXQh
        7TjjvkdDGvAB5DPV/StL+ZAmKoGEZByvnL3XBnHUvNezvQIc+t7gucR6JFq+Ff/3
        749ViiarHfg4p97C6rTOAIqxj4Jdq+fzaNFlhDdiQxwxexqWnFoMbIJnbA9NGKRi
        7kWU3BgB0mbIJws8AtWG3jzLpFoy1UzjT46aIz1YHLFnkHSUpn9tJOTNA==
X-ME-Sender: <xms:OTfmZCvydLF3rJE5nmiDqUuNjM61p6yO8J9c4p8tNzOzWuwzacvF9Q>
    <xme:OTfmZHfa93GNEItZrBSXpQL-qggkZ5EC1mMXLFT7f1ILQIO8atsy4WijbaEwO3kZZ
    IPCJni1eK3oDM9UjOo>
X-ME-Received: <xmr:OTfmZNxG48P3jKvKHl8Blkg1u5PclhnxgxI5W-q8wZ6pA35LPlEydkvnZ_Hjf456FGJUucy5bnbtW77h3QhtxQHj3t5Xl_oq-6rl89SutJEZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddvgedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpehffgfhvfevufffjgfkgggtsehttdertddtredtnecuhfhrohhmpefuthgv
    fhgrnhcutfhovghstghhuceoshhhrhesuggvvhhkvghrnhgvlhdrihhoqeenucggtffrrg
    htthgvrhhnpeevlefggffhheduiedtheejveehtdfhtedvhfeludetvdegieekgeeggfdu
    geeutdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hshhhrseguvghvkhgvrhhnvghlrdhioh
X-ME-Proxy: <xmx:OTfmZNM_IvnWudsQzxiEzwwE-XmA0BXLUzJEJgIFqnPXx5tjgQ-gZw>
    <xmx:OTfmZC-DtOUnqU8HPU0RXwIVc9uYQ06ZalBuna_fUmY4YIhZkNTNJQ>
    <xmx:OTfmZFWx8i0v4PS-kBg3qhtr7dZ8GGpobqAQjnUr7mNjlx6Ld_AN1Q>
    <xmx:OTfmZCw4f39lRwlZz9EzUeX7dDe1jDMtm9CcD9xt1zQgpXeY_PQu2g>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Aug 2023 12:43:36 -0400 (EDT)
References: <20230822180539.1424843-1-shr@devkernel.io>
 <b380a853-4466-d060-1084-dcdd65a5ce13@redhat.com>
User-agent: mu4e 1.10.1; emacs 28.2.50
From:   Stefan Roesch <shr@devkernel.io>
To:     David Hildenbrand <david@redhat.com>
Cc:     kernel-team@fb.com, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
        riel@surriel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4] proc/ksm: add ksm stats to /proc/pid/smaps
Date:   Wed, 23 Aug 2023 09:41:56 -0700
In-reply-to: <b380a853-4466-d060-1084-dcdd65a5ce13@redhat.com>
Message-ID: <qvqwzg2hr9oq.fsf@devbig1114.prn1.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


David Hildenbrand <david@redhat.com> writes:

> On 22.08.23 20:05, Stefan Roesch wrote:
>> With madvise and prctl KSM can be enabled for different VMA's. Once it
>> is enabled we can query how effective KSM is overall. However we cannot
>> easily query if an individual VMA benefits from KSM.
>> This commit adds a KSM section to the /prod/<pid>/smaps file. It reports
>> how many of the pages are KSM pages. The returned value for KSM is
>> independent of the use of the shared zeropage.
>
> Maybe phrase that to something like "The returned value for KSM includes
> KSM-placed zeropages, so we can observe the actual KSM benefit independent
> of the usage of the shared zeropage for KSM.".
>
> But thinking about it (see below), maybe we really just let any user figure that out by
> temporarily disabling the shared zeropage.
>
> So this would be
>
> "It reports how many of the pages are KSM pages. Note that KSM-placed zeropages
> are not included, only actual KSM pages."
>

I'll replace the commit message and the documentation with the above
sentence.

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
>>   Documentation/filesystems/proc.rst |  4 ++++
>>   fs/proc/task_mmu.c                 | 16 +++++++++++-----
>>   2 files changed, 15 insertions(+), 5 deletions(-)
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
>
> Maybe here as well.
>
>> +
>>   "LazyFree" shows the amount of memory which is marked by madvise(MADV_FREE).
>>   The memory isn't freed immediately with madvise(). It's freed in memory
>>   pressure if the memory is clean. Please note that the printed value might
>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>> index 51315133cdc2..4532caa8011c 100644
>> --- a/fs/proc/task_mmu.c
>> +++ b/fs/proc/task_mmu.c
>> @@ -4,6 +4,7 @@
>>   #include <linux/hugetlb.h>
>>   #include <linux/huge_mm.h>
>>   #include <linux/mount.h>
>> +#include <linux/ksm.h>
>>   #include <linux/seq_file.h>
>>   #include <linux/highmem.h>
>>   #include <linux/ptrace.h>
>> @@ -396,6 +397,7 @@ struct mem_size_stats {
>>   	unsigned long swap;
>>   	unsigned long shared_hugetlb;
>>   	unsigned long private_hugetlb;
>> +	unsigned long ksm;
>>   	u64 pss;
>>   	u64 pss_anon;
>>   	u64 pss_file;
>> @@ -435,9 +437,9 @@ static void smaps_page_accumulate(struct mem_size_stats *mss,
>>   	}
>>   }
>>   -static void smaps_account(struct mem_size_stats *mss, struct page *page,
>> -		bool compound, bool young, bool dirty, bool locked,
>> -		bool migration)
>> +static void smaps_account(struct mem_size_stats *mss, pte_t *pte,
>> +		struct page *page, bool compound, bool young, bool dirty,
>> +		bool locked, bool migration)
>>   {
>>   	int i, nr = compound ? compound_nr(page) : 1;
>>   	unsigned long size = nr * PAGE_SIZE;
>> @@ -452,6 +454,9 @@ static void smaps_account(struct mem_size_stats *mss, struct page *page,
>>   			mss->lazyfree += size;
>>   	}
>>   +	if (PageKsm(page) && (!pte || !is_ksm_zero_pte(*pte)))
>
> I think this won't work either way, because smaps_pte_entry() never ends up calling
> this function with !page. And the shared zeropage here always gives us !page.
>
> What would work is:
>
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 15ddf4653a19..ef6f39d7c5a2 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -528,6 +528,9 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
>                 page = vm_normal_page(vma, addr, ptent);
>                 young = pte_young(ptent);
>                 dirty = pte_dirty(ptent);
> +
> +               if (!page && is_ksm_zero_pte(ptent))
> +                       mss->ksm += size;
>         } else if (is_swap_pte(ptent)) {
>                 swp_entry_t swpent = pte_to_swp_entry(ptent);
>  That means that "KSM" can be bigger than "Anonymous" and "RSS" when the shared
> zeropage is used.
>
> Interestingly, right now we account each KSM page individually towards
> "Anonymous" and "RSS".
>
> So if we have 100 times the same KSM page in a VMA, we will have 100 times anon
> and 100 times rss.
>
> Thinking about it, I guess considering the KSM-placed zeropage indeed adds more
> confusion to that. Eventually, we might just want separate "Shared-zeropages" count.
>
>
> So maybe v3 is better, clarifying the documentation a bit, that the
> KSM-placed zeropage is not considered.
>
o
> Sorry for changing my mind :D Thoughts?

I agree I think v3 is better, I'll revert to v3 and add the above
documentation change.
