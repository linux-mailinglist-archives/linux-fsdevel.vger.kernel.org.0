Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789F84B7E64
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Feb 2022 04:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343925AbiBPCzb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 21:55:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343937AbiBPCz3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 21:55:29 -0500
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 11700FE424;
        Tue, 15 Feb 2022 18:55:11 -0800 (PST)
IronPort-Data: =?us-ascii?q?A9a23=3A9m4MRKosA63eGElO6wDbt+atkHxeBmJzZBIvgKr?=
 =?us-ascii?q?LsJaIsI5as4F+vmscWjrQM/+Mamr2fNl3YYnj/UJQ7cSByYA2Tgs9+SozQiMRo?=
 =?us-ascii?q?6IpJ/zDcB6oYHn6wu4v7a5fx5xHLIGGdajYd1eEzvuWGuWn/SkUOZ2gHOKmUra?=
 =?us-ascii?q?eYnkpHGeIdQ964f5ds79g6mJXqYjha++9kYuaT/z3YDdJ6RYtWo4nw/7rRCdUg?=
 =?us-ascii?q?RjHkGhwUmrSyhx8lAS2e3E9VPrzLEwqRpfyatE88uWSH44vwFwll1418SvBCvv?=
 =?us-ascii?q?9+lr6WkYMBLDPPwmSkWcQUK+n6vRAjnVqlP9la7xHMgEK49mKt4kZJNFlr4G5T?=
 =?us-ascii?q?xw4eKPKg/g1XQRaEj1lIOtN/7qvzX2X6JbKkh2fLie0qxlpJARsVWECwc57CH9?=
 =?us-ascii?q?P+dQWMjcIaQqJhv7wy7W+IsFsjcQLLc/lJooTt3hsizbDAp4OTZnFBaeM+t5c2?=
 =?us-ascii?q?DY5g9tmHPDCas5fYj1qBDzMYQJIPFg/C58kmuqswH7lfFVwrFOTuLpy5m37zxJ?=
 =?us-ascii?q?427urN8DaEvSMW8lUm0OwomPd43+/BhAcKczZxTebmlquj+nC2yj7RaoVDrSz8?=
 =?us-ascii?q?vMsi1qWrkQXCRsLRR61uvW0lEO6c8xQJlZS+Sc0q6U2skuxQbHVWxy+vW7BvRM?=
 =?us-ascii?q?GXddUO/M15RvLyafO5QudQG8eQVZpbN0gqd9zVTIx/kGGksmvBjF1trCRD3WH+?=
 =?us-ascii?q?d+pQZmaUcQOBTZaI3ZaEk1euJ++yLzfRynnFr5LeJNZRPWvcd0o/w23kQ=3D?=
 =?us-ascii?q?=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A4u2axqqY7pE+olBxeO5FQmsaV5oXeYIsimQD?=
 =?us-ascii?q?101hICG9E/bo8/xG+c536faaslgssQ4b8+xoVJPgfZq+z+8R3WByB8bAYOCOgg?=
 =?us-ascii?q?LBQ72KhrGSoQEIdRefysdtkY9kc4VbTOb7FEVGi6/BizWQIpINx8am/cmT6dvj?=
 =?us-ascii?q?8w=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="121581540"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 16 Feb 2022 10:55:10 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 6E8234D140C6;
        Wed, 16 Feb 2022 10:55:07 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Wed, 16 Feb 2022 10:55:06 +0800
Received: from [192.168.22.28] (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Wed, 16 Feb 2022 10:55:06 +0800
Message-ID: <ff0f0d8c-a4a3-6dbf-8358-67c3bb11c2d6@fujitsu.com>
Date:   Wed, 16 Feb 2022 10:55:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v10 9/9] fsdax: set a CoW flag when associate reflink
 mappings
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, david <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jane Chu <jane.chu@oracle.com>
References: <20220127124058.1172422-1-ruansy.fnst@fujitsu.com>
 <20220127124058.1172422-10-ruansy.fnst@fujitsu.com>
 <CAPcyv4iTO55BX+_v2yHRBjSppPgT23JsHg-Oagb6RwHMj-W+Ug@mail.gmail.com>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <CAPcyv4iTO55BX+_v2yHRBjSppPgT23JsHg-Oagb6RwHMj-W+Ug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-yoursite-MailScanner-ID: 6E8234D140C6.AF700
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2022/2/16 10:09, Dan Williams 写道:
> On Thu, Jan 27, 2022 at 4:41 AM Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:
>>
>> Introduce a PAGE_MAPPING_DAX_COW flag to support association with CoW file
>> mappings.  In this case, the dax-RMAP already takes the responsibility
>> to look up for shared files by given dax page.  The page->mapping is no
>> longer to used for rmap but for marking that this dax page is shared.
>> And to make sure disassociation works fine, we use page->index as
>> refcount, and clear page->mapping to the initial state when page->index
>> is decreased to 0.
>>
>> With the help of this new flag, it is able to distinguish normal case
>> and CoW case, and keep the warning in normal case.
>>
>> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
>> ---
>>   fs/dax.c                   | 65 ++++++++++++++++++++++++++++++++------
>>   include/linux/page-flags.h |  6 ++++
>>   2 files changed, 62 insertions(+), 9 deletions(-)
>>
>> diff --git a/fs/dax.c b/fs/dax.c
>> index 250794a5b789..88879c579c1f 100644
>> --- a/fs/dax.c
>> +++ b/fs/dax.c
>> @@ -334,13 +334,46 @@ static unsigned long dax_end_pfn(void *entry)
>>          for (pfn = dax_to_pfn(entry); \
>>                          pfn < dax_end_pfn(entry); pfn++)
>>
>> +static inline void dax_mapping_set_cow_flag(struct address_space *mapping)
>> +{
>> +       mapping = (struct address_space *)PAGE_MAPPING_DAX_COW;
>> +}
>> +
>> +static inline bool dax_mapping_is_cow(struct address_space *mapping)
>> +{
>> +       return (unsigned long)mapping == PAGE_MAPPING_DAX_COW;
>> +}
>> +
>>   /*
>> - * TODO: for reflink+dax we need a way to associate a single page with
>> - * multiple address_space instances at different linear_page_index()
>> - * offsets.
>> + * Set or Update the page->mapping with FS_DAX_MAPPING_COW flag.
>> + * Return true if it is an Update.
>> + */
>> +static inline bool dax_mapping_set_cow(struct page *page)
>> +{
>> +       if (page->mapping) {
>> +               /* flag already set */
>> +               if (dax_mapping_is_cow(page->mapping))
>> +                       return false;
>> +
>> +               /*
>> +                * This page has been mapped even before it is shared, just
>> +                * need to set this FS_DAX_MAPPING_COW flag.
>> +                */
>> +               dax_mapping_set_cow_flag(page->mapping);
>> +               return true;
>> +       }
>> +       /* Newly associate CoW mapping */
>> +       dax_mapping_set_cow_flag(page->mapping);
>> +       return false;
>> +}
>> +
>> +/*
>> + * When it is called in dax_insert_entry(), the cow flag will indicate that
>> + * whether this entry is shared by multiple files.  If so, set the page->mapping
>> + * to be FS_DAX_MAPPING_COW, and use page->index as refcount.
>>    */
>>   static void dax_associate_entry(void *entry, struct address_space *mapping,
>> -               struct vm_area_struct *vma, unsigned long address)
>> +               struct vm_area_struct *vma, unsigned long address, bool cow)
>>   {
>>          unsigned long size = dax_entry_size(entry), pfn, index;
>>          int i = 0;
>> @@ -352,9 +385,17 @@ static void dax_associate_entry(void *entry, struct address_space *mapping,
>>          for_each_mapped_pfn(entry, pfn) {
>>                  struct page *page = pfn_to_page(pfn);
>>
>> -               WARN_ON_ONCE(page->mapping);
>> -               page->mapping = mapping;
>> -               page->index = index + i++;
>> +               if (cow) {
>> +                       if (dax_mapping_set_cow(page)) {
>> +                               /* Was normal, now updated to CoW */
>> +                               page->index = 2;
>> +                       } else
>> +                               page->index++;
>> +               } else {
>> +                       WARN_ON_ONCE(page->mapping);
>> +                       page->mapping = mapping;
>> +                       page->index = index + i++;
>> +               }
>>          }
>>   }
>>
>> @@ -370,7 +411,12 @@ static void dax_disassociate_entry(void *entry, struct address_space *mapping,
>>                  struct page *page = pfn_to_page(pfn);
>>
>>                  WARN_ON_ONCE(trunc && page_ref_count(page) > 1);
>> -               WARN_ON_ONCE(page->mapping && page->mapping != mapping);
>> +               if (!dax_mapping_is_cow(page->mapping)) {
>> +                       /* keep the CoW flag if this page is still shared */
>> +                       if (page->index-- > 0)
>> +                               continue;
>> +               } else
>> +                       WARN_ON_ONCE(page->mapping && page->mapping != mapping);
>>                  page->mapping = NULL;
>>                  page->index = 0;
>>          }
>> @@ -810,7 +856,8 @@ static void *dax_insert_entry(struct xa_state *xas,
>>                  void *old;
>>
>>                  dax_disassociate_entry(entry, mapping, false);
>> -               dax_associate_entry(new_entry, mapping, vmf->vma, vmf->address);
>> +               dax_associate_entry(new_entry, mapping, vmf->vma, vmf->address,
>> +                               false);
> 
> Where is the caller that passes 'true'? Also when that caller arrives
> introduce a separate dax_associate_cow_entry() as that's easier to
> read than dax_associate_entry(..., true) in case someone does not
> remember what that boolean flag means.

This flag is supposed to be used when CoW support is introduced.  When 
it is a CoW operation, which is decided by iomap & srcmap's flag, this 
flag will be set true.

I think I should describe it in detail in the commit message.

> 
> However, it's not clear to me that this approach is a good idea given
> that the filesystem is the source of truth for how many address_spaces
> this page mapping might be duplicated. What about a iomap_page_ops for
> fsdax to ask the filesystem when it is ok to clear the mapping
> association for a page?

I'll think how to implement it in this way.


--
Thanks,
Ruan.

> 
>>                  /*
>>                   * Only swap our new entry into the page cache if the current
>>                   * entry is a zero page or an empty entry.  If a normal PTE or
>> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
>> index 1c3b6e5c8bfd..6370d279795a 100644
>> --- a/include/linux/page-flags.h
>> +++ b/include/linux/page-flags.h
>> @@ -572,6 +572,12 @@ __PAGEFLAG(Reported, reported, PF_NO_COMPOUND)
>>   #define PAGE_MAPPING_KSM       (PAGE_MAPPING_ANON | PAGE_MAPPING_MOVABLE)
>>   #define PAGE_MAPPING_FLAGS     (PAGE_MAPPING_ANON | PAGE_MAPPING_MOVABLE)
>>
>> +/*
>> + * Different with flags above, this flag is used only for fsdax mode.  It
>> + * indicates that this page->mapping is now under reflink case.
>> + */
>> +#define PAGE_MAPPING_DAX_COW   0x1
>> +
>>   static __always_inline int PageMappingFlags(struct page *page)
>>   {
>>          return ((unsigned long)page->mapping & PAGE_MAPPING_FLAGS) != 0;
>> --
>> 2.34.1
>>
>>
>>


