Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0042A495854
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jan 2022 03:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378543AbiAUCeG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jan 2022 21:34:06 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:45919 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1378483AbiAUCeF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jan 2022 21:34:05 -0500
IronPort-Data: =?us-ascii?q?A9a23=3A8jWpIK8vHuEnOF7kREpCDrUD63+TJUtcMsCJ2f8?=
 =?us-ascii?q?bfWQNrUp33zxSxmFKXWjSP6uKa2Cje9F0PITn8UIG65CDzNJiSVdlrnsFo1Bi8?=
 =?us-ascii?q?5ScXYvDRqvT04J+FuWaFQQ/qZx2huDodKjYdVeB4Ef9WlTdhSMkj/vQH+CkULW?=
 =?us-ascii?q?s1h1ZHmeIdg9w0HqPpMZp2uaEsfDha++8kYuaT//3YTdJ6BYoWo4g0J9vnTs01?=
 =?us-ascii?q?BjEVJz0iXRlDRxDlAe2e3D4l/vzL4npR5fzatE88uJX24/+IL+FEmPxp3/BC/u?=
 =?us-ascii?q?ulPD1b08LXqXPewOJjxK6WYD72l4b+HN0if19aZLwam8O49mNt8pswdNWpNq+T?=
 =?us-ascii?q?xw1FqPRmuUBSAQeGCZ7VUFD0OadeSbi6JLPkCUqdFOpmZ2CFnoeMYQG++pfD3t?=
 =?us-ascii?q?J8PsCIjERKBuEgoqewLm7YuhqiN4qIMTiMMUYoH4I5T3QC7AkB4/CR6HL7NpD9?=
 =?us-ascii?q?DY2ms1KW/3ZYqIxZThwaxLPSx5CIFEaDNQ5hujArn3+dSBI7VeQjakp6mPQigt?=
 =?us-ascii?q?r39DFNsTZe9mPbcFUhVqD4GbH+XnpRB0XKrS3yzOD/zSnhvLnmjnyU4YfUra/8?=
 =?us-ascii?q?5ZChFyV23xWBgYaWEW2pdGnhUOkHdFSMUoZ/mwpt6da3EiqSMTtGh61uniJujY?=
 =?us-ascii?q?CVNdKVe438geAzuzT+QnxLmwFSCNRLcwor+coSjEwkFyEhdXkAXpoqrL9dJ433?=
 =?us-ascii?q?t94thvrYW5MczBEPnRCEGM4DxDYiNlbpnryohxLScZZVuHIJAw=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AW6esQatRAK2MUU2DkOwCCOZ77skDStV00zEX?=
 =?us-ascii?q?/kB9WHVpm62j5qSTdZEguCMc5wx+ZJheo7q90cW7IE80lqQFhLX5X43SPzUO0V?=
 =?us-ascii?q?HARO5fBODZsl/d8kPFltJ15ONJdqhSLJnKB0FmsMCS2mKFOudl7N6Z0K3Av4vj?=
 =?us-ascii?q?80s=3D?=
X-IronPort-AV: E=Sophos;i="5.88,303,1635177600"; 
   d="scan'208";a="120651647"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 21 Jan 2022 10:34:03 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id C8E454D15A5C;
        Fri, 21 Jan 2022 10:33:58 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 21 Jan 2022 10:33:56 +0800
Received: from [192.168.22.28] (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 21 Jan 2022 10:33:56 +0800
Message-ID: <70a24c20-d7ee-064c-e863-9f012422a2f5@fujitsu.com>
Date:   Fri, 21 Jan 2022 10:33:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v9 10/10] fsdax: set a CoW flag when associate reflink
 mappings
To:     Christoph Hellwig <hch@infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <djwong@kernel.org>,
        <dan.j.williams@intel.com>, <david@fromorbit.com>,
        <jane.chu@oracle.com>
References: <20211226143439.3985960-1-ruansy.fnst@fujitsu.com>
 <20211226143439.3985960-11-ruansy.fnst@fujitsu.com>
 <YekkYAJ+QegoDKCJ@infradead.org>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <YekkYAJ+QegoDKCJ@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-yoursite-MailScanner-ID: C8E454D15A5C.A13C7
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2022/1/20 16:59, Christoph Hellwig 写道:
> On Sun, Dec 26, 2021 at 10:34:39PM +0800, Shiyang Ruan wrote:
>> +#define FS_DAX_MAPPING_COW	1UL
>> +
>> +#define MAPPING_SET_COW(m)	(m = (struct address_space *)FS_DAX_MAPPING_COW)
>> +#define MAPPING_TEST_COW(m)	(((unsigned long)m & FS_DAX_MAPPING_COW) == \
>> +					FS_DAX_MAPPING_COW)
> 
> These really should be inline functions and probably use lower case
> names.

OK.

> 
> But different question, how does this not conflict with:
> 
> #define PAGE_MAPPING_ANON       0x1
> 
> in page-flags.h?

Now we are treating dax pages, so I think its flags should be different 
from normal page.  In another word, PAGE_MAPPING_ANON is a flag of rmap 
mechanism for normal page, it doesn't work for dax page.  And now, we 
have dax rmap for dax page.  So, I think this two kinds of flags are 
supposed to be used in different mechanisms and won't conflect.

> 
> Either way I think this flag should move to page-flags.h and be
> integrated with the PAGE_MAPPING_FLAGS infrastucture.

And that's why I keep them in this dax.c file.


--
Thanks,
Ruan.


