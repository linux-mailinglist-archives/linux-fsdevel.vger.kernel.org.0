Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18CD053B64A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jun 2022 11:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbiFBJm0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jun 2022 05:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbiFBJmY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jun 2022 05:42:24 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4353BF33BB;
        Thu,  2 Jun 2022 02:42:21 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3AXP+JQqsvcKFyK0XUAcscBwnRvOfnVKtfMUV32f8?=
 =?us-ascii?q?akzHdYEJGY0x3y2pMC2+FaKmPNDSmLd91b9i/90MB6MODzYJnHABvrStgHilAw?=
 =?us-ascii?q?SbnLY7Hdx+vZUt+DSFioHpPtpxYMp+ZRCwNZie0SiyFb/6x/RGQ6YnSHuCmULS?=
 =?us-ascii?q?cY3goLeNZYHxJZSxLyrdRbrFA0YDR7zOl4bsekuWHULOX82cc3lE8t8pvnChSU?=
 =?us-ascii?q?MHa41v0iLCRicdj5zcyn1FNZH4WyDrYw3HQGuG4FcbiLwrPIS3Qw4/Xw/stIov?=
 =?us-ascii?q?NfrfTeUtMTKPQPBSVlzxdXK3Kbhpq/3R0i/hkcqFHLxo/ZzahxridzP1XqJW2U?=
 =?us-ascii?q?hZvMKvXhMwTThtZDzpje6ZB/dcrJFDm65DNkRycKSWEL/JGSRte0Zcj0up+H2B?=
 =?us-ascii?q?C3fICLzUKdBqCm6S9x7fTYu1tgMEiJc7rMasfp3h/wDCfBvEjKbjDSKXi5NlWx?=
 =?us-ascii?q?j48i8lCW/HEaKIxdjtraAXoYhtBIF4bBZsy2uCyiRHXfzRe7lDTuqsz52nayRd?=
 =?us-ascii?q?Z0b7xPd6TcduPLe1ZnFmfoG3u/GnjBBwectuFxlKt9nOqm/+KmCbTW5wbH77+8?=
 =?us-ascii?q?eRl6HWaxXQWIBkXU0ar5Pe+l0iyUs5eLEpS/TAhxYA06kCqS9zVWxyjvGXCuh8?=
 =?us-ascii?q?aRsoWH+AkgCmLw63F6kCZAXIFQSNKaN0OssI9Azct0zehndrvCHpksKC9TmiU/?=
 =?us-ascii?q?bOZ6zi1PEA9N2AFYSMbXA0t+MT4rcc/g3rnStdlDb7wgMb5FC/9xxiUoyUkwbY?=
 =?us-ascii?q?el8gG0+O851+vqzatoIXZCw04/APaWkq74Q5jIo2ofYql7R7c9/koBIKYSESR+?=
 =?us-ascii?q?WgKgOCA4+0US5KAjiqARKMKBr7Bz+iEKjr0k1NpHodn8zWr5m7leppfpix9THq?=
 =?us-ascii?q?FmO5slSTBOReV4F0OosQIeibCUEO+WKrpY+xC8EQqPY2NuijoU+dz?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AkyN+ZalgwJcnTNgcMWV+2UpRr4HpDfO+imdD?=
 =?us-ascii?q?5ihNYBxZY6Wkfp+V8cjzhCWftN9OYhodcLC7V5Voj0mskKKdxbNhRYtKOzOWw1?=
 =?us-ascii?q?dATbsSlLcKpgeNJ8SQzI5gPMtbAstD4ZjLfCJHZKXBkXaF+rQbsb66GcmT7I+x?=
 =?us-ascii?q?rkuFDzsaDZ2Ihz0JdjpzeXcGIDWua6BJdqZ1saF81kedkDksH42GL0hAe9KGi8?=
 =?us-ascii?q?zAlZrgbxJDLxk76DOWhTftzLLhCRCX0joXTjsKmN4ZgCP4uj28wp/mn+Cwyxfa?=
 =?us-ascii?q?2WOWx5NKmOH5wt8GIMCXkMAaJhjllw7tToV8XL+puiwzvYiUmR4XueiJhy1lE9?=
 =?us-ascii?q?V46nvXcG3wiRzx2zP42DJr0HPmwU/wuwqWneXJABYBT+ZRj4NQdRXUr2A6ustn?=
 =?us-ascii?q?7a5N12WF87JKEBLphk3Glpf1fiAvsnDxjWspkOYVgXAae5AZcqVtoYsW+14QOI?=
 =?us-ascii?q?scHRj99JssHIBVfY3hDc5tABKnhk3izylSKITGZAVxIv7GeDlOhiWt6UkZoJgj?=
 =?us-ascii?q?pHFohvD2nR87hecAotd/lqH5259T5cBzp/8tHNxA7dg6MLuK40z2MGXx2TGpUC?=
 =?us-ascii?q?La/J9uAQO/l7fHpJMI2cqNRLskiLMPpbWpaiIriYd1QTOlNfGz?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="124669226"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 02 Jun 2022 17:42:20 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 13CB54D17192;
        Thu,  2 Jun 2022 17:42:15 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 2 Jun 2022 17:42:13 +0800
Received: from [192.168.22.78] (10.167.225.141) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 2 Jun 2022 17:42:14 +0800
Message-ID: <1007e895-a0e3-9a82-2524-bb7e8a0b6b8c@fujitsu.com>
Date:   Thu, 2 Jun 2022 17:42:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCHSETS] v14 fsdax-rmap + v11 fsdax-reflink
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jane Chu <jane.chu@oracle.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Al Viro <viro@zeniv.linux.org.uk>, <linmiaohe@huawei.com>
References: <20220508143620.1775214-1-ruansy.fnst@fujitsu.com>
 <20220511000352.GY27195@magnolia>
 <20220511014818.GE1098723@dread.disaster.area>
 <CAPcyv4h0a3aT3XH9qCBW3nbT4K3EwQvBSD_oX5W=55_x24-wFA@mail.gmail.com>
 <20220510192853.410ea7587f04694038cd01de@linux-foundation.org>
 <20220511024301.GD27195@magnolia>
 <20220510222428.0cc8a50bd007474c97b050b2@linux-foundation.org>
 <20220511151955.GC27212@magnolia>
 <CAPcyv4gwV5ReuCUbJHZPVPUJjnaGFWibCLLsH-XEgyvbn9RkWA@mail.gmail.com>
 <32f51223-c671-1dc0-e14a-8887863d9071@fujitsu.com>
In-Reply-To: <32f51223-c671-1dc0-e14a-8887863d9071@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-yoursite-MailScanner-ID: 13CB54D17192.A2D79
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Is there any other work I should do with these two patchsets?  I think 
they are good for now.  So... since the 5.19-rc1 is coming, could the 
notify_failure() part be merged as your plan?


--
Thanks,
Ruan.


在 2022/5/12 20:27, Shiyang Ruan 写道:
> 
> 
> 在 2022/5/11 23:46, Dan Williams 写道:
>> On Wed, May 11, 2022 at 8:21 AM Darrick J. Wong <djwong@kernel.org> 
>> wrote:
>>>
>>> Oan Tue, May 10, 2022 at 10:24:28PM -0700, Andrew Morton wrote:
>>>> On Tue, 10 May 2022 19:43:01 -0700 "Darrick J. Wong" 
>>>> <djwong@kernel.org> wrote:
>>>>
>>>>> On Tue, May 10, 2022 at 07:28:53PM -0700, Andrew Morton wrote:
>>>>>> On Tue, 10 May 2022 18:55:50 -0700 Dan Williams 
>>>>>> <dan.j.williams@intel.com> wrote:
>>>>>>
>>>>>>>> It'll need to be a stable branch somewhere, but I don't think it
>>>>>>>> really matters where al long as it's merged into the xfs for-next
>>>>>>>> tree so it gets filesystem test coverage...
>>>>>>>
>>>>>>> So how about let the notify_failure() bits go through -mm this 
>>>>>>> cycle,
>>>>>>> if Andrew will have it, and then the reflnk work has a clean 
>>>>>>> v5.19-rc1
>>>>>>> baseline to build from?
>>>>>>
>>>>>> What are we referring to here?  I think a minimal thing would be the
>>>>>> memremap.h and memory-failure.c changes from
>>>>>> https://lkml.kernel.org/r/20220508143620.1775214-4-ruansy.fnst@fujitsu.com 
>>>>>> ?
>>>>>>
>>>>>> Sure, I can scoot that into 5.19-rc1 if you think that's best.  It
>>>>>> would probably be straining things to slip it into 5.19.
>>>>>>
>>>>>> The use of EOPNOTSUPP is a bit suspect, btw.  It *sounds* like the
>>>>>> right thing, but it's a networking errno.  I suppose livable with 
>>>>>> if it
>>>>>> never escapes the kernel, but if it can get back to userspace then a
>>>>>> user would be justified in wondering how the heck a filesystem
>>>>>> operation generated a networking errno?
>>>>>
>>>>> <shrug> most filesystems return EOPNOTSUPP rather enthusiastically 
>>>>> when
>>>>> they don't know how to do something...
>>>>
>>>> Can it propagate back to userspace?
>>>
>>> AFAICT, the new code falls back to the current (mf_generic_kill_procs)
>>> failure code if the filesystem doesn't provide a ->memory_failure
>>> function or if it returns -EOPNOSUPP.  mf_generic_kill_procs can also
>>> return -EOPNOTSUPP, but all the memory_failure() callers (madvise, etc.)
>>> convert that to 0 before returning it to userspace.
>>>
>>> I suppose the weirder question is going to be what happens when madvise
>>> starts returning filesystem errors like EIO or EFSCORRUPTED when pmem
>>> loses half its brains and even the fs can't deal with it.
>>
>> Even then that notification is not in a system call context so it
>> would still result in a SIGBUS notification not a EOPNOTSUPP return
>> code. The only potential gap I see are what are the possible error
>> codes that MADV_SOFT_OFFLINE might see? The man page is silent on soft
>> offline failure codes. Shiyang, that's something to check / update if
>> necessary.
> 
> According to the code around MADV_SOFT_OFFLINE, it will return -EIO when 
> the backend is NVDIMM.
> 
> Here is the logic:
>   madvise_inject_error() {
>       ...
>       if (MADV_SOFT_OFFLINE) {
>           ret = soft_offline_page() {
>               ...
>               /* Only online pages can be soft-offlined (esp., not 
> ZONE_DEVICE). */
>               page = pfn_to_online_page(pfn);
>               if (!page) {
>                   put_ref_page(ref_page);
>                   return -EIO;
>               }
>               ...
>           }
>       } else {
>           ret = memory_failure()
>       }
>       return ret
>   }
> 
> 
> -- 
> Thanks,
> Ruan.
> 
> 


