Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C24562AC4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 07:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbiGAFO5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Jul 2022 01:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiGAFOz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jul 2022 01:14:55 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C2BD6677EE;
        Thu, 30 Jun 2022 22:14:53 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3AJLjYGq6B6cmXTrRbn3QZXwxRtJbFchMFZxGqfqr?=
 =?us-ascii?q?LsXjdYENS12RVy2McX2/UPKnYZzPxKohxPorjpBkF7JCGx4cwT1A5pCpnJ55og?=
 =?us-ascii?q?ZCbXIzGdC8cHM8zwvXrFRsht4NHAjX5BJhcokT0+1H9YtANkVEmjfvSHuCkUba?=
 =?us-ascii?q?dUsxMbVQMpBkJ2EsLd9ER0tYAbeiRW2thiPuqyyHtEAbNNw1cbgr435m+RCZH5?=
 =?us-ascii?q?5wejt+3UmsWPpintHeG/5Uc4Ql2yauZdxMUSaEMdgK2qnqq8V23wo/Z109F5tK?=
 =?us-ascii?q?NmbC9fFAIQ6LJIE6FjX8+t6qK20AE/3JtlP1gcqd0hUR/0l1lm/hr1dxLro32R?=
 =?us-ascii?q?wEyIoXCheYcTwJFVSp5OMWq/Zeeeyfn4JLPlB2un3zEhq8G4FsNFYER5Od7KW9?=
 =?us-ascii?q?U8vkfMjoMclaIgOfe6LKwSsFtgMo5JcXmNY9ZvWtvpRnVD+khR5/rQKjQ49Jcm?=
 =?us-ascii?q?jAqiahmG+jSZs8cQT5udwjbJRlOPEoHTp4zgo+Agnj5bi0dpkmZqLQ650DNwwF?=
 =?us-ascii?q?rlrvgKtzYfpqNX8o9tkKZoH/Wumf0GBcXMPSBxjeftHGhnOnCmWX8Qo16PLm58?=
 =?us-ascii?q?ON6xU2d3UQNBxAME1i2u/+0jgi5Qd03FqC+0kLCtoBrrAryEIa7BEb+/Ra5Utc?=
 =?us-ascii?q?nc4I4O4UHBMulk8I4OzqkO1U=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AKuVcIKPFYuaVXMBcTiWjsMiBIKoaSvp037Eq?=
 =?us-ascii?q?v3oBKyC9Ffbo7vxG/c5rsyMc5wx/ZJhNo6HlBEDEewK6yXcX2+cs1NWZMDUO0V?=
 =?us-ascii?q?HAROoJgLcKgQeQfhEWndQ86U4PSdkcNDS9NzlHZNjBkXSFOudl0N+a67qpmOub?=
 =?us-ascii?q?639sSDthY6Zm4xwRMHfhLmRGABlBGYEiFIeRou5Opz+bc3wRacihQlYfWeyrna?=
 =?us-ascii?q?ywqLvWJQ4BGwU86BSDyReh6LvBGRCe2RsEFxNjqI1SiVT4rw=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="127096438"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 01 Jul 2022 13:14:52 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id B88394D1719A;
        Fri,  1 Jul 2022 13:14:51 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 1 Jul 2022 13:14:50 +0800
Received: from [192.168.22.78] (10.167.225.141) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 1 Jul 2022 13:14:53 +0800
Message-ID: <07805923-6455-e046-8c0a-60ed99d1fb38@fujitsu.com>
Date:   Fri, 1 Jul 2022 13:14:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] xfs: fail dax mount if reflink is enabled on a partition
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
        <david@fromorbit.com>, <hch@infradead.org>
References: <20220609143435.393724-1-ruansy.fnst@fujitsu.com>
 <Yr5AV5HaleJXMmUm@magnolia>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <Yr5AV5HaleJXMmUm@magnolia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-yoursite-MailScanner-ID: B88394D1719A.AFAA7
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



在 2022/7/1 8:31, Darrick J. Wong 写道:
> On Thu, Jun 09, 2022 at 10:34:35PM +0800, Shiyang Ruan wrote:
>> Failure notification is not supported on partitions.  So, when we mount
>> a reflink enabled xfs on a partition with dax option, let it fail with
>> -EINVAL code.
>>
>> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> 
> Looks good to me, though I think this patch applies to ... wherever all
> those rmap+reflink+dax patches went.  I think that's akpm's tree, right?

Yes, they are in his tree, still in mm-unstable now.

> 
> Ideally this would go in through there to keep the pieces together, but
> I don't mind tossing this in at the end of the 5.20 merge window if akpm
> is unwilling.

Both are fine to me.  Thanks!


--
Ruan.

> 
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> 
> --D
> 
>> ---
>>   fs/xfs/xfs_super.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
>> index 8495ef076ffc..a3c221841fa6 100644
>> --- a/fs/xfs/xfs_super.c
>> +++ b/fs/xfs/xfs_super.c
>> @@ -348,8 +348,10 @@ xfs_setup_dax_always(
>>   		goto disable_dax;
>>   	}
>>   
>> -	if (xfs_has_reflink(mp)) {
>> -		xfs_alert(mp, "DAX and reflink cannot be used together!");
>> +	if (xfs_has_reflink(mp) &&
>> +	    bdev_is_partition(mp->m_ddev_targp->bt_bdev)) {
>> +		xfs_alert(mp,
>> +			"DAX and reflink cannot work with multi-partitions!");
>>   		return -EINVAL;
>>   	}
>>   
>> -- 
>> 2.36.1
>>
>>
>>


