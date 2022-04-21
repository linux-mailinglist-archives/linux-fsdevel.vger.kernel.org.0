Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED82D509A4C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 10:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386565AbiDUINJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 04:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386558AbiDUINC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:13:02 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 48418167D1;
        Thu, 21 Apr 2022 01:10:12 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3AY/H+3qoHaQWaOJZTSW6YX/fDBHNeBmIOZBIvgKr?=
 =?us-ascii?q?LsJaIsI5as4F+vmoWCmuHbqmOMWH1eNxzaIm1pBkGsZXXzYdmTlNspHg3QiMRo?=
 =?us-ascii?q?6IpJ/zDcB6oYHn6wu4v7a5fx5xHLIGGdajYd1eEzvuWGuWn/SkUOZ2gHOKmUra?=
 =?us-ascii?q?eYnkpHGeIdQ964f5ds79g6mJXqYjha++9kYuaT/z3YDdJ6RYtWo4nw/7rRCdUg?=
 =?us-ascii?q?RjHkGhwUmrSyhx8lAS2e3E9VPrzLEwqRpfyatE88uWSH44vwFwll1418SvBCvv?=
 =?us-ascii?q?9+lr6WkYMBLDPPwmSkWcQUK+n6vRAjnVqlP9la7xHMgEK49mKt4kZJNFlr4G5T?=
 =?us-ascii?q?xw4eKPKg/g1XQRaEj1lIOtN/7qvzX2X6JbIkBeZLSW9qxlpJARsVWECwc57CH9?=
 =?us-ascii?q?P+dQWMjcIaQqJhv7wy7W+IsFsjcQLLc/lJooTt3hsizbDAp4OTZnFBaeM+t5c2?=
 =?us-ascii?q?DY5g9tmHPDCas5fYj1qBDzMYQJIPFg/C58kmuqswH7lfFVwrFOTuLpy5m37zxJ?=
 =?us-ascii?q?427urN8DaEvSMW8lUm0OwomPd43+/BhAcKczZxTebmlqsje/nmTjnHo4ffJW+/?=
 =?us-ascii?q?/l7iRuTwXYSBwAdVVqTp/SyzEW5Xrp3KUUS92wlrbUa81aiRd3wGRa/pRasuh8?=
 =?us-ascii?q?aRsoVHfY25R+AzoLK7AuDQGsJVDhMbJohrsBebTgr0EKZ2tDkHzpitJWLRn+Hs?=
 =?us-ascii?q?LSZtzW/PW4SN2BqTSsFSxYVpsntu6ktgR/VCNVuCqi4ipvyAz6Y/twghEDSnJ1?=
 =?us-ascii?q?K1YhSifr9pguB3lqRSlHyZlZdzm3qsqiNtWuVvLKYWrE=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AxTKq7qkEOHZg80dk9grC0W0QV93pDfLI3DAb?=
 =?us-ascii?q?v31ZSRFFG/Fxl6iV7ZYmPHjP+U8ssRAb6La90ca7Lk80maQFhbX5eI3SOzUO21?=
 =?us-ascii?q?HHEGgB1+ffKlTbckWUnINgPOVbAs1D4bbLbWSS4/yKgzVQX+xA/DCYytHUuc7u?=
 =?us-ascii?q?i2dqURpxa7xtqyNwCgOgGEVwQwVcbKBJb6a0145WoSa6Y3QLYoCeDnkBZeLKoN?=
 =?us-ascii?q?rGj9bIehgDbiRXkjWmvHe57qLgCRiE0lM7WzNL+70r9m/IiEjYy8yYwomG9iM?=
 =?us-ascii?q?=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="123727669"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 21 Apr 2022 16:10:11 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 0E35C4D17172;
        Thu, 21 Apr 2022 16:10:09 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 21 Apr 2022 16:10:09 +0800
Received: from [192.168.22.28] (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 21 Apr 2022 16:10:06 +0800
Message-ID: <685f3191-d454-88c0-277a-05b65b831dc5@fujitsu.com>
Date:   Thu, 21 Apr 2022 16:10:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v13 2/7] mm: factor helpers for memory_failure_dev_pagemap
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "jane.chu@oracle.com" <jane.chu@oracle.com>,
        Christoph Hellwig <hch@lst.de>
References: <20220419045045.1664996-1-ruansy.fnst@fujitsu.com>
 <20220419045045.1664996-3-ruansy.fnst@fujitsu.com>
 <20220421061344.GA3607858@hori.linux.bs1.fc.nec.co.jp>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <20220421061344.GA3607858@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-yoursite-MailScanner-ID: 0E35C4D17172.A4D4C
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2022/4/21 14:13, HORIGUCHI NAOYA(堀口 直也) 写道:
> On Tue, Apr 19, 2022 at 12:50:40PM +0800, Shiyang Ruan wrote:
>> memory_failure_dev_pagemap code is a bit complex before introduce RMAP
>> feature for fsdax.  So it is needed to factor some helper functions to
>> simplify these code.
>>
>> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
>> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> 
> Thanks for the refactoring.  As I commented to 0/7, the conflict with
> "mm/hwpoison: fix race between hugetlb free/demotion and memory_failure_hugetlb()"
> can be trivially resolved.
> 
> Another few comment below ...
> 
>> ---
>>   mm/memory-failure.c | 157 ++++++++++++++++++++++++--------------------
>>   1 file changed, 87 insertions(+), 70 deletions(-)
>>
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index e3fbff5bd467..7c8c047bfdc8 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -1498,6 +1498,90 @@ static int try_to_split_thp_page(struct page *page, const char *msg)
>>   	return 0;
>>   }
>>
>> +static void unmap_and_kill(struct list_head *to_kill, unsigned long pfn,
>> +		struct address_space *mapping, pgoff_t index, int flags)
>> +{
>> +	struct to_kill *tk;
>> +	unsigned long size = 0;
>> +
>> +	list_for_each_entry(tk, to_kill, nd)
>> +		if (tk->size_shift)
>> +			size = max(size, 1UL << tk->size_shift);
>> +
>> +	if (size) {
>> +		/*
>> +		 * Unmap the largest mapping to avoid breaking up device-dax
>> +		 * mappings which are constant size. The actual size of the
>> +		 * mapping being torn down is communicated in siginfo, see
>> +		 * kill_proc()
>> +		 */
>> +		loff_t start = (index << PAGE_SHIFT) & ~(size - 1);
>> +
>> +		unmap_mapping_range(mapping, start, size, 0);
>> +	}
>> +
>> +	kill_procs(to_kill, flags & MF_MUST_KILL, false, pfn, flags);
>> +}
>> +
>> +static int mf_generic_kill_procs(unsigned long long pfn, int flags,
>> +		struct dev_pagemap *pgmap)
>> +{
>> +	struct page *page = pfn_to_page(pfn);
>> +	LIST_HEAD(to_kill);
>> +	dax_entry_t cookie;
>> +	int rc = 0;
>> +
>> +	/*
>> +	 * Pages instantiated by device-dax (not filesystem-dax)
>> +	 * may be compound pages.
>> +	 */
>> +	page = compound_head(page);
>> +
>> +	/*
>> +	 * Prevent the inode from being freed while we are interrogating
>> +	 * the address_space, typically this would be handled by
>> +	 * lock_page(), but dax pages do not use the page lock. This
>> +	 * also prevents changes to the mapping of this pfn until
>> +	 * poison signaling is complete.
>> +	 */
>> +	cookie = dax_lock_page(page);
>> +	if (!cookie)
>> +		return -EBUSY;
>> +
>> +	if (hwpoison_filter(page)) {
>> +		rc = -EOPNOTSUPP;
>> +		goto unlock;
>> +	}
>> +
>> +	if (pgmap->type == MEMORY_DEVICE_PRIVATE) {
>> +		/*
>> +		 * TODO: Handle HMM pages which may need coordination
>> +		 * with device-side memory.
>> +		 */
>> +		return -EBUSY;
> 
> Don't we need to go to dax_unlock_page() as the origincal code do?
> 
>> +	}
>> +
>> +	/*
>> +	 * Use this flag as an indication that the dax page has been
>> +	 * remapped UC to prevent speculative consumption of poison.
>> +	 */
>> +	SetPageHWPoison(page);
>> +
>> +	/*
>> +	 * Unlike System-RAM there is no possibility to swap in a
>> +	 * different physical page at a given virtual address, so all
>> +	 * userspace consumption of ZONE_DEVICE memory necessitates
>> +	 * SIGBUS (i.e. MF_MUST_KILL)
>> +	 */
>> +	flags |= MF_ACTION_REQUIRED | MF_MUST_KILL;
>> +	collect_procs(page, &to_kill, true);
>> +
>> +	unmap_and_kill(&to_kill, pfn, page->mapping, page->index, flags);
>> +unlock:
>> +	dax_unlock_page(page, cookie);
>> +	return rc;
>> +}
>> +
>>   /*
>>    * Called from hugetlb code with hugetlb_lock held.
>>    *
>> @@ -1644,12 +1728,8 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
>>   		struct dev_pagemap *pgmap)
>>   {
>>   	struct page *page = pfn_to_page(pfn);
>> -	unsigned long size = 0;
>> -	struct to_kill *tk;
>>   	LIST_HEAD(tokill);
> 
> Is this variable unused in this function?

Yes, this one and the one above are mistakes I didn't notice when I 
resolving conflicts with the newer next- branch.  I'll fix them in next 
version.


--
Thanks,
Ruan.

> 
> Thanks,
> Naoya Horiguchi


