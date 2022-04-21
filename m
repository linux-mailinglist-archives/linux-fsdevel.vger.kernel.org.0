Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770BF5094D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 03:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383706AbiDUBu4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Apr 2022 21:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383702AbiDUBuz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Apr 2022 21:50:55 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B9F6063E0;
        Wed, 20 Apr 2022 18:48:04 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3AYxJFiK5MLoE8rJvEOpSj9wxRtFPGchMFZxGqfqr?=
 =?us-ascii?q?LsXjdYENS1zABxzEfWGjTOKnYNGWmKdt/PIy1phkH7JLUmNYyTFE5pCpnJ55og?=
 =?us-ascii?q?ZCbXIzGdC8cHM8zwvXrFRsht4NHAjX5BJhcokT0+1H9YtANkVEmjfvSHuCkUba?=
 =?us-ascii?q?dUsxMbVQMpBkJ2EsLd9ER0tYAbeiRW2thiPuqyyHtEAbNNw1cbgr435m+RCZH5?=
 =?us-ascii?q?5wejt+3UmsWPpintHeG/5Uc4Ql2yauZdxMUSaEMdgK2qnqq8V23wo/Z109F5tK?=
 =?us-ascii?q?NmbC9fFAIQ6LJIE6FjX8+t6qK20AE/3JtlP1gcqd0hUR/0l1lm/hr1dxLro32R?=
 =?us-ascii?q?wEyIoXCheYcTwJFVSp5OMWq/ZeeeyPg6JzIkROun3zEhq8G4FsNFYER5Od7KW9?=
 =?us-ascii?q?U8vkfMjoMclaIgOfe6LKwSsFtgMo5JcXmNY9ZvWtvpRnVBPBgQ9bcQqHO5NZdx?=
 =?us-ascii?q?x8xgNxDGbDVYM9xQTZtcxPGbDVMN00RBZZ4m/2n7lH7cjtFuBeQoII0/WHYz0p?=
 =?us-ascii?q?2yreFGNzLdt2PQO1Rn12EvSTC/mLkElcWOcL34TiM9H/qje/StSThUYkWGfuz8?=
 =?us-ascii?q?fsCqFmSwHEDTRMNWValrP2RlEGzQZRcJlYS9y5oqrI9nGSvT9/gT1i7rWSCsxo?=
 =?us-ascii?q?0RdVdCas55RuLx66S5ByWbkAATzhceJk2utQeWzMnzBmKksnvCDgpt6eaIU9xX?=
 =?us-ascii?q?J/8QSiaYHBTdDFdI3RfC1Zt3jUqm6lr5jqnczqpOPfdYgXJJAzN?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AYU9x3KosP4hr3ye9/0JzzcoaV5rPeYIsimQD?=
 =?us-ascii?q?101hICG8cqSj5qKTdZMgpGbJYVcqKRcdcL+7V5VoLUmskaKdpLNhWotKPzOJhI?=
 =?us-ascii?q?LLFu1fBOLZqlWKcUDDH6xmpMJdmsNFaOEYY2IK7voSrDPYLz8/+qj7zImYwffZ?=
 =?us-ascii?q?02x2TRxnL4Vp7wJCAA6dFUFsLTM2fqYRJd6N4NZdvTq8dTAyZsS/PHMMWO/OvJ?=
 =?us-ascii?q?nlj5TjCCR2fSIP2U2fiy+y8r7mH1y91hcaaTlGxrAv6izkvmXCl92ej80=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="123718366"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 21 Apr 2022 09:48:03 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id C89D94D68A22;
        Thu, 21 Apr 2022 09:48:00 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 21 Apr 2022 09:47:58 +0800
Received: from [192.168.22.28] (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 21 Apr 2022 09:47:58 +0800
Message-ID: <86cb0ada-208c-02de-dbc9-53c6014892c3@fujitsu.com>
Date:   Thu, 21 Apr 2022 09:48:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v13 0/7] fsdax: introduce fs query to support reflink
To:     Dave Chinner <david@fromorbit.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <djwong@kernel.org>,
        <dan.j.williams@intel.com>, <hch@infradead.org>,
        <jane.chu@oracle.com>
References: <20220419045045.1664996-1-ruansy.fnst@fujitsu.com>
 <20220421012045.GR1544202@dread.disaster.area>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <20220421012045.GR1544202@dread.disaster.area>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-yoursite-MailScanner-ID: C89D94D68A22.A0BAE
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

Hi Dave,

在 2022/4/21 9:20, Dave Chinner 写道:
> Hi Ruan,
> 
> On Tue, Apr 19, 2022 at 12:50:38PM +0800, Shiyang Ruan wrote:
>> This patchset is aimed to support shared pages tracking for fsdax.
> 
> Now that this is largely reviewed, it's time to work out the
> logistics of merging it.

Thanks!

> 
>> Changes since V12:
>>    - Rebased onto next-20220414
> 
> What does this depend on that is in the linux-next kernel?
> 
> i.e. can this be applied successfully to a v5.18-rc2 kernel without
> needing to drag in any other patchsets/commits/trees?

Firstly, I tried to apply to v5.18-rc2 but it failed.

There are some changes in memory-failure.c, which besides my Patch-02
   "mm/hwpoison: fix race between hugetlb free/demotion and 
memory_failure_hugetlb()"
 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=423228ce93c6a283132be38d442120c8e4cdb061

Then, why it is on linux-next is: I was told[1] there is a better fix 
about "pgoff_address()" in linux-next:
   "mm: rmap: introduce pfn_mkclean_range() to cleans PTEs"
 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=65c9605009f8317bb3983519874d755a0b2ca746
so I rebased my patches to it and dropped one of mine.

[1] https://lore.kernel.org/linux-xfs/YkPuooGD139Wpg1v@infradead.org/

> 
> What are your plans for the followup patches that enable
> reflink+fsdax in XFS? AFAICT that patchset hasn't been posted for
> while so I don't know what it's status is. Is that patchset anywhere
> near ready for merge in this cycle?
> 
> If that patchset is not a candidate for this cycle, then it largely
> doesn't matter what tree this is merged through as there shouldn't
> be any major XFS or dax dependencies being built on top of it during
> this cycle. The filesystem side changes are isolated and won't
> conflict with other work in XFS, either, so this could easily go
> through Dan's tree.
> 
> However, if the reflink enablement is ready to go, then this all
> needs to be in the XFS tree so that we can run it through filesystem
> level DAX+reflink testing. That will mean we need this in a stable
> shared topic branch and tighter co-ordination between the trees.
> 
> So before we go any further we need to know if the dax+reflink
> enablement patchset is near being ready to merge....

The "reflink+fsdax" patchset is here:
 
https://lore.kernel.org/linux-xfs/20210928062311.4012070-1-ruansy.fnst@fujitsu.com/

It was based on v5.15-rc3, I think I should do a rebase.


--
Thanks,
Ruan.

> 
> Cheers,
> 
> Dave.


