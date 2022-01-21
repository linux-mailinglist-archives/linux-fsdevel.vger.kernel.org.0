Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8FDB495C00
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jan 2022 09:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbiAUIfE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jan 2022 03:35:04 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:2637 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234198AbiAUIeV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jan 2022 03:34:21 -0500
IronPort-Data: =?us-ascii?q?A9a23=3ATGEFKqh5CkSoF7MEZqgz4YuZX161CxEKZh0ujC4?=
 =?us-ascii?q?5NGQNrF6WrkUAy2YXUD+ObvyMZzCmLot/bojn9h8Av8XTnIJkHgtqqnw8FHgiR?=
 =?us-ascii?q?ejtX4rAdhiqV8+xwmwvdGo+toNGLICowPkcFhcwnT/wdOixxZVA/fvQHOCkUbS?=
 =?us-ascii?q?dYnkZqTJME0/NtzoywobVvaY42bBVMyvV0T/Di5W31G2NglaYAUpIg063ky6Di?=
 =?us-ascii?q?dyp0N8uUvPSUtgQ1LPWvyF94JvyvshdJVOgKmVfNrbSq+ouUNiEEm3lExcFUrt?=
 =?us-ascii?q?Jk57wdAsEX7zTIROTzHFRXsBOgDAb/mprjPl9b6FaNC+7iB3Q9zx14M9QvJqrW?=
 =?us-ascii?q?EEnOLbQsOoAURhECDw4NqpDkFPCCSHl6ZLNlhKaKhMAxN0rVinaJ7Yw9u9pAG1?=
 =?us-ascii?q?m++YfLTcXZBGfwemxxdqTSuJsrsUlItPiMI4Wtjdn1z6xJfovR9bBBbrL4dtZ1?=
 =?us-ascii?q?TIrrsFIAfvaIcEebFJHYBbfZBtAElQaEpQzmKGvnHaXWzlZrk+F4K8yy2vNxQd?=
 =?us-ascii?q?ylr/3P7L9fMKGRMBQtkKZvX7duWD4BAwKctCS11Kt8Huqi6nEnT7TX5gbH7m1s?=
 =?us-ascii?q?PVthTW7wm0VFQ1TW0C3rOe0jmagVN9FbU8Z4Cwjqe417kPDZt38WQCo5X2JpBg?=
 =?us-ascii?q?RX/JOHOAgrgKA0KzZ50CeHGdsZjpAbsE28d84XhQ02VKT2dDkHzpitPuSU331y?=
 =?us-ascii?q?1s+hVteIgBMdSlbO3BCFlBDvrHeTEgIpkqnZr5e/GSd17UZwQ3N/g0=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AmS58S6/PRHT7JJgFU+puk+C9I+orL9Y04lQ7?=
 =?us-ascii?q?vn2ZKCY0TiX2ra2TdZggvyMc6wxxZJhDo7+90cC7KBu2yXcc2/hzAV7IZmXbUQ?=
 =?us-ascii?q?WTQr1f0Q=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,304,1635177600"; 
   d="scan'208";a="120661741"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 21 Jan 2022 16:34:20 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 10D3A4D15A58;
        Fri, 21 Jan 2022 16:34:19 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 21 Jan 2022 16:34:19 +0800
Received: from [192.168.22.28] (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 21 Jan 2022 16:34:16 +0800
Message-ID: <b928a8cd-e9b5-46fa-20d0-e91fe53ed861@fujitsu.com>
Date:   Fri, 21 Jan 2022 16:34:18 +0800
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
 <70a24c20-d7ee-064c-e863-9f012422a2f5@fujitsu.com>
 <YepdxZ+XrAZYv1dX@infradead.org>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <YepdxZ+XrAZYv1dX@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-yoursite-MailScanner-ID: 10D3A4D15A58.A4165
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2022/1/21 15:16, Christoph Hellwig 写道:
> On Fri, Jan 21, 2022 at 10:33:58AM +0800, Shiyang Ruan wrote:
>>>
>>> But different question, how does this not conflict with:
>>>
>>> #define PAGE_MAPPING_ANON       0x1
>>>
>>> in page-flags.h?
>>
>> Now we are treating dax pages, so I think its flags should be different from
>> normal page.  In another word, PAGE_MAPPING_ANON is a flag of rmap mechanism
>> for normal page, it doesn't work for dax page.  And now, we have dax rmap
>> for dax page.  So, I think this two kinds of flags are supposed to be used
>> in different mechanisms and won't conflect.
> 
> It just needs someone to use folio_test_anon in a place where a DAX
> folio can be passed.  This probably should not happen, but we need to
> clearly document that.
> 
>>> Either way I think this flag should move to page-flags.h and be
>>> integrated with the PAGE_MAPPING_FLAGS infrastucture.
>>
>> And that's why I keep them in this dax.c file.
> 
> But that does not integrate it with the infrastructure.  For people
> to debug things it needs to be next to PAGE_MAPPING_ANON and have
> documentation explaining why they are exclusive.

Ok, understood.


--
Thanks,
Ruan.


