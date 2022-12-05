Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBF96422DA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Dec 2022 06:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbiLEF4r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Dec 2022 00:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbiLEF4k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Dec 2022 00:56:40 -0500
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F6BDF10;
        Sun,  4 Dec 2022 21:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1670219796; i=@fujitsu.com;
        bh=tsULHP0IlQLfDHqLIXze7Yj4nJkeFJmjEoOpk9YqPNw=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=M9tZr6QKnwdcqPjVEflWWGtGz/1N76WJoEOpKivb1CrUjwApeZ8IJ2u3xfuh6tVH1
         XbxP0YHR6XHC4TjyrGaTqP+br4Mk059ZEhBf4neO/v8+M1BoAQL/IBx5CtBYAJ207o
         R36fL9lvkQ8241u1mW9SxsISmNAPfcCWH3DLyFyfK32EHHTXEcFoWetftQggm1+kpM
         4YpQkzT7pVj8g2eiRn9xT5AtC9dzIVgY3bVEfdIO2pX9oyGYQE4N2zRLsq1B33Td/6
         ExKGhaXiUjMxKMQyF2U2lABoiTNlDi25i7zwaO4H4ub7lI6T9an1Wf2MNLxiionzPe
         R/P54ssxpCDgA==
X-Brightmail-Tracker: H4sIAAAAAAAAA1VSfUgTYRj33W3zLM/OzfJV+tBpUemOIoozQrS
  iFlQUFkZEepund7XNdTdrFYUViomrBHNujjRn0iQ0l4r5gWmfWsg0TAuyL6P5UQT1x0D72Lky
  ++/3PL+vF54XRWRWSSRKm4w0p6e0Cuk8ceImVK2UF5g1a+o84aS9/paUtFx1A7Lx0Qggn4+Gk
  O0dPWLyeatdSrZOtwSSTu+0JAlV9VZBlaN9TKRy1V6Uqp6UTYlVnjtWoPrmWrpHelDC6tXZpn
  QJM+LxAMNkvGm4mMkF12MLwTxUhjcA2NLfKPYP1SI48eC7yD80AdjQapYUgiAUwxNhybu+GSz
  GY2Hn1JjUvw+FPdZRsYAX4hp46bJ1Zi/H98OyobYZfRgeB4vtXYgQiuAPASzvb/5T1wGg40pX
  oKCS4vHQXfljxhGE74CtwwNAwAhOQsekX4Pgy+CFpnJEwBCPhrlv7CI/NkGbLf8PXgEH+1zIF
  SCzzXmgbU6UbU5UJUBqwQae5o7TnDKBUHNsFmPUUayWoE4pKYLOUeqzOSOjXEtQJ3iC5nmCP6
  nTaDMIPW10Ad/FMvgsXQsYqJkmukEEKlIsxKh8s0YWos7OOMlQPJPG5WhpvhssRlEFxFx5Pi6
  Uo7NoUyar9d39Lw3RYEUYxglWjDdQOp7N8lO9IDoyHLsn+HCBYHL0s7a/P2YALImUYyAgIEAW
  bKA5HWv8nx8H4ShQyLEzQnwwqzfOpo/7ikW+4oYFhUKxkfpHReaKdoeO/9zZGHjm1bbyzREU3
  nv4wYJVqNn9tn15WkXmueakdO0vgzW9oKkfWuazNlxU5LHdDeqqT1u+LnDfIjN2lFi/10G/dj
  5jHB+/xcjdUy+aT/cYvnqVcdGKmqFr5q3OwvtRjkfNy15m3L1dcr0vL7zMMgSqnMkxD3OiDiE
  HrjUebXGnfg72njUuLthjWTnBdx3frk70tpmS37DDExrX44ralF2DwFO1LqZCV1xasmYw/8OJ
  sLaQLZKo4dSQw+eLMu/TX1K2FMUfe1pXfwB8sivHbiriTMmV45Pvn/ZWISPejXhp0pHqzo8Jo
  6XTN9xOMABg99u4YxE/f1QkBFgUYp6h1q5GOJ76DW0HXjmsAwAA
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-6.tower-732.messagelabs.com!1670219794!133009!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 6269 invoked from network); 5 Dec 2022 05:56:35 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-6.tower-732.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 5 Dec 2022 05:56:35 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id C56331AF;
        Mon,  5 Dec 2022 05:56:34 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id B9C031AD;
        Mon,  5 Dec 2022 05:56:34 +0000 (GMT)
Received: from [10.167.216.27] (10.167.216.27) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Mon, 5 Dec 2022 05:56:31 +0000
Message-ID: <9c5528bf-b183-7e30-08e8-72ef9c0321ef@fujitsu.com>
Date:   Mon, 5 Dec 2022 13:56:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2.1 1/8] fsdax: introduce page->share for fsdax in
 reflink mode
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <djwong@kernel.org>, <david@fromorbit.com>,
        <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-fsdevel@vger.kernel.org>
References: <1669908538-55-2-git-send-email-ruansy.fnst@fujitsu.com>
 <1669972991-246-1-git-send-email-ruansy.fnst@fujitsu.com>
 <638aaf72cba2a_3cbe029479@dwillia2-xfh.jf.intel.com.notmuch>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <638aaf72cba2a_3cbe029479@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.216.27]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2022/12/3 10:07, Dan Williams 写道:
> Shiyang Ruan wrote:
>> fsdax page is used not only when CoW, but also mapread. To make the it
>> easily understood, use 'share' to indicate that the dax page is shared
>> by more than one extent.  And add helper functions to use it.
>>
>> Also, the flag needs to be renamed to PAGE_MAPPING_DAX_SHARED.
>>
>> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
>> ---
>>   fs/dax.c                   | 38 ++++++++++++++++++++++----------------
>>   include/linux/mm_types.h   |  5 ++++-
>>   include/linux/page-flags.h |  2 +-
>>   3 files changed, 27 insertions(+), 18 deletions(-)
>>
>> diff --git a/fs/dax.c b/fs/dax.c
>> index 1c6867810cbd..edbacb273ab5 100644
>> --- a/fs/dax.c
>> +++ b/fs/dax.c
>> @@ -334,35 +334,41 @@ static unsigned long dax_end_pfn(void *entry)
>>   	for (pfn = dax_to_pfn(entry); \
>>   			pfn < dax_end_pfn(entry); pfn++)
>>   
>> -static inline bool dax_mapping_is_cow(struct address_space *mapping)
>> +static inline bool dax_page_is_shared(struct page *page)
>>   {
>> -	return (unsigned long)mapping == PAGE_MAPPING_DAX_COW;
>> +	return (unsigned long)page->mapping == PAGE_MAPPING_DAX_SHARED;
>>   }
>>   
>>   /*
>> - * Set the page->mapping with FS_DAX_MAPPING_COW flag, increase the refcount.
>> + * Set the page->mapping with PAGE_MAPPING_DAX_SHARED flag, increase the
>> + * refcount.
>>    */
>> -static inline void dax_mapping_set_cow(struct page *page)
>> +static inline void dax_page_bump_sharing(struct page *page)
> 
> Similar to page_ref naming I would call this page_share_get() and the
> corresponding function page_share_put().
> 
>>   {
>> -	if ((uintptr_t)page->mapping != PAGE_MAPPING_DAX_COW) {
>> +	if ((uintptr_t)page->mapping != PAGE_MAPPING_DAX_SHARED) {
>>   		/*
>>   		 * Reset the index if the page was already mapped
>>   		 * regularly before.
>>   		 */
>>   		if (page->mapping)
>> -			page->index = 1;
>> -		page->mapping = (void *)PAGE_MAPPING_DAX_COW;
>> +			page->share = 1;
>> +		page->mapping = (void *)PAGE_MAPPING_DAX_SHARED;
> 
> Small nit, You could save a cast here by defining
> PAGE_MAPPING_DAX_SHARED as "((void *) 1)".

Ok.

> 
>>   	}
>> -	page->index++;
>> +	page->share++;
>> +}
>> +
>> +static inline unsigned long dax_page_drop_sharing(struct page *page)
>> +{
>> +	return --page->share;
>>   }
>>   
>>   /*
>> - * When it is called in dax_insert_entry(), the cow flag will indicate that
>> + * When it is called in dax_insert_entry(), the shared flag will indicate that
>>    * whether this entry is shared by multiple files.  If so, set the page->mapping
>> - * FS_DAX_MAPPING_COW, and use page->index as refcount.
>> + * PAGE_MAPPING_DAX_SHARED, and use page->share as refcount.
>>    */
>>   static void dax_associate_entry(void *entry, struct address_space *mapping,
>> -		struct vm_area_struct *vma, unsigned long address, bool cow)
>> +		struct vm_area_struct *vma, unsigned long address, bool shared)
>>   {
>>   	unsigned long size = dax_entry_size(entry), pfn, index;
>>   	int i = 0;
>> @@ -374,8 +380,8 @@ static void dax_associate_entry(void *entry, struct address_space *mapping,
>>   	for_each_mapped_pfn(entry, pfn) {
>>   		struct page *page = pfn_to_page(pfn);
>>   
>> -		if (cow) {
>> -			dax_mapping_set_cow(page);
>> +		if (shared) {
>> +			dax_page_bump_sharing(page);
>>   		} else {
>>   			WARN_ON_ONCE(page->mapping);
>>   			page->mapping = mapping;
>> @@ -396,9 +402,9 @@ static void dax_disassociate_entry(void *entry, struct address_space *mapping,
>>   		struct page *page = pfn_to_page(pfn);
>>   
>>   		WARN_ON_ONCE(trunc && page_ref_count(page) > 1);
>> -		if (dax_mapping_is_cow(page->mapping)) {
>> -			/* keep the CoW flag if this page is still shared */
>> -			if (page->index-- > 0)
>> +		if (dax_page_is_shared(page)) {
>> +			/* keep the shared flag if this page is still shared */
>> +			if (dax_page_drop_sharing(page) > 0)
>>   				continue;
> 
> I think part of what makes this hard to read is trying to preserve the
> same code paths for shared pages and typical pages.
> 
> page_share_put() should, in addition to decrementing the share, clear
> out page->mapping value.

In order to be consistent, how about naming the 3 helper functions like 
this:

bool          dax_page_is_shared(struct page *page);
void          dax_page_share_get(struct page *page);
unsigned long dax_page_share_put(struct page *page);


--
Thanks,
Ruan.

> 
>>   		} else
>>   			WARN_ON_ONCE(page->mapping && page->mapping != mapping);
>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>> index 500e536796ca..f46cac3657ad 100644
>> --- a/include/linux/mm_types.h
>> +++ b/include/linux/mm_types.h
>> @@ -103,7 +103,10 @@ struct page {
>>   			};
>>   			/* See page-flags.h for PAGE_MAPPING_FLAGS */
>>   			struct address_space *mapping;
>> -			pgoff_t index;		/* Our offset within mapping. */
>> +			union {
>> +				pgoff_t index;		/* Our offset within mapping. */
>> +				unsigned long share;	/* share count for fsdax */
>> +			};
>>   			/**
>>   			 * @private: Mapping-private opaque data.
>>   			 * Usually used for buffer_heads if PagePrivate.
>> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
>> index 0b0ae5084e60..c8a3aa02278d 100644
>> --- a/include/linux/page-flags.h
>> +++ b/include/linux/page-flags.h
>> @@ -641,7 +641,7 @@ PAGEFLAG_FALSE(VmemmapSelfHosted, vmemmap_self_hosted)
>>    * Different with flags above, this flag is used only for fsdax mode.  It
>>    * indicates that this page->mapping is now under reflink case.
>>    */
>> -#define PAGE_MAPPING_DAX_COW	0x1
>> +#define PAGE_MAPPING_DAX_SHARED	0x1
>>   
>>   static __always_inline bool folio_mapping_flags(struct folio *folio)
>>   {
>> -- 
>> 2.38.1
>>
> 
> 
