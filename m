Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB7A030EE4C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 09:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234886AbhBDI0n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 03:26:43 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:34343 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbhBDI0l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 03:26:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612427200; x=1643963200;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=GtdY8LtyTR9VUmf4SBTpHa/Kososx3pGVqasa7L3upw=;
  b=O/p9bA7PL2eRFL9nnEk+IJnC/21PlNR8eKAfnrw5+OEVxwd2WXmmT126
   kZxhjVck05bKPDQFTVrheyVCrl/dKPIBjO7Z0b0hLIz3un1w7aYlt241Y
   nLoUZ1+jUwzqsF+ydSbfybUgWFDpRXdKvRMYgBHBd6ohmLr6IGgv9oSrM
   OQftAiWtzKE2edbasUBD3uECgHCHuSqyrAd3FrWMokFQc+aNlnVt06f/Y
   C0a8k2WSZXU19EdhM8MqaP80UuKblsC1TPmLSezexV+X6lvok9n09b2uH
   Z2d3erTr56x9C8QH4yQ/9WyF7YI1Gc19rOScplycb4XsNGVvkZrPxGc+f
   A==;
IronPort-SDR: JEV6O0hUYtO2Wn0XsG7UlCSCNTE5OBnUTVp5Qf/TgzfMAcM/UfkvVP2p5my1cXZ7gYDDAaAjZU
 NJrJUns7+A62NzFS4h8b/v28Ct4Pii17QLDxYvfY2jYAGAeVO/PtwWa6Of2CwpQHuJp25yV/CH
 /q8Epuhm20+dMEWVYD1QIGbCP2PzioQ1ZqW/xGRW55SBk1apRNoF9Xhm1PxGsJZZuWo4uld6tw
 oA8OhRcypBJwVbhPnZopNFHavfjT54jf5k4nCmFI1ew1a9g1aPMQV93fCYHDDugSG0K/OS5GJV
 Nic=
X-IronPort-AV: E=Sophos;i="5.79,400,1602518400"; 
   d="scan'208";a="269527913"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2021 16:25:34 +0800
IronPort-SDR: INL2Vsu8nw0TnRK7BBvkPRK72lgOUCzvrXJ0wqUAr4qPpbCMOf4xRz6Ir9pdXivfqXUS+FCF1y
 Yop8/Qb1rblVzQsgqANlWDx/rQbZDRN4AucXJZkNozsaX75xro4sQU0RghGQq6chxkwwSYudME
 j2li30esH85Vsb9ZSlfaeTAKpfAxkmHEpyt++rElRGH1SGRGV4CzKxei8oqVhbYjNucmcm/mNf
 ruxOtRfBe7FXehdUJlh/21y+7q8QWki6Tq3K1KVBbqz5g/oi1E23PRPDkJGuf0AN7po+9GIC7c
 mhSZ857i5Gg1MjDjFKWjFuTb
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 00:07:38 -0800
IronPort-SDR: fn/zU2u4FnEBE2zzzTbalQiz2PvTVBgRfs21HVlRvr/5FkHs6VAT6c6Uasj4iSER8zR2O7QSVD
 w50MMqS8/zwbhCiOtI+rLhDL1VclGMao6YODg7ijzttM38g3OGfS+s2xlKdnQVksUsqmZcDktF
 qq+E+Vs94MbUXsp4gZpH7RxPtTvM7qrHYkm+WG8UG377KNzgA8tbz4jFC2RZc2RQXEZQ8vQik/
 dQMw7hMQoRfmOoeYwkpJjgxfCkbtkvH7o7K6N5Lal4Vj13eVpnUYvPqpTzCxWf98auqBSWG9V3
 iDw=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with SMTP; 04 Feb 2021 00:25:34 -0800
Received: (nullmailer pid 969874 invoked by uid 1000);
        Thu, 04 Feb 2021 08:25:32 -0000
Date:   Thu, 4 Feb 2021 17:25:32 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, dsterba@suse.com,
        hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v14 29/42] btrfs: introduce dedicated data write path for
 ZONED mode
Message-ID: <20210204082532.ljbe2bpjkbxtmsim@naota.dhcp.fujisawa.hgst.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
 <698bfc6446634e06a9399fa819d0f19aba3b4196.1611627788.git.naohiro.aota@wdc.com>
 <20210202150045.GY1993@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210202150045.GY1993@twin.jikos.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 02, 2021 at 04:00:45PM +0100, David Sterba wrote:
>On Tue, Jan 26, 2021 at 11:25:07AM +0900, Naohiro Aota wrote:
>> If more than one IO is issued for one file extent, these IO can be written
>> to separate regions on a device. Since we cannot map one file extent to
>> such a separate area, we need to follow the "one IO == one ordered extent"
>> rule.
>>
>> The Normal buffered, uncompressed, not pre-allocated write path (used by
>> cow_file_range()) sometimes does not follow this rule. It can write a part
>> of an ordered extent when specified a region to write e.g., when its
>> called from fdatasync().
>>
>> Introduces a dedicated (uncompressed buffered) data write path for ZONED
>> mode. This write path will CoW the region and write it at once.
>>
>> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>> ---
>>  fs/btrfs/inode.c | 34 ++++++++++++++++++++++++++++++++--
>>  1 file changed, 32 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>> index a9bf78eaed42..6d43aaa1f537 100644
>> --- a/fs/btrfs/inode.c
>> +++ b/fs/btrfs/inode.c
>> @@ -1400,6 +1400,29 @@ static int cow_file_range_async(struct btrfs_inode *inode,
>>  	return 0;
>>  }
>>
>> +static noinline int run_delalloc_zoned(struct btrfs_inode *inode,
>> +				       struct page *locked_page, u64 start,
>> +				       u64 end, int *page_started,
>> +				       unsigned long *nr_written)
>> +{
>> +	int ret;
>> +
>> +	ret = cow_file_range(inode, locked_page, start, end,
>> +			     page_started, nr_written, 0);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (*page_started)
>> +		return 0;
>> +
>> +	__set_page_dirty_nobuffers(locked_page);
>> +	account_page_redirty(locked_page);
>> +	extent_write_locked_range(&inode->vfs_inode, start, end, WB_SYNC_ALL);
>> +	*page_started = 1;
>> +
>> +	return 0;
>> +}
>> +
>>  static noinline int csum_exist_in_range(struct btrfs_fs_info *fs_info,
>>  					u64 bytenr, u64 num_bytes)
>>  {
>> @@ -1879,17 +1902,24 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
>>  {
>>  	int ret;
>>  	int force_cow = need_force_cow(inode, start, end);
>> +	const bool do_compress = inode_can_compress(inode) &&
>> +		inode_need_compress(inode, start, end);
>
>This would make sense to cache the values, but inode_need_compress is
>quite heavy as it runs the compression heuristic. This would affect all
>cases and drop some perf.
>
>> +	const bool zoned = btrfs_is_zoned(inode->root->fs_info);
>>
>>  	if (inode->flags & BTRFS_INODE_NODATACOW && !force_cow) {
>> +		ASSERT(!zoned);
>>  		ret = run_delalloc_nocow(inode, locked_page, start, end,
>>  					 page_started, 1, nr_written);
>>  	} else if (inode->flags & BTRFS_INODE_PREALLOC && !force_cow) {
>> +		ASSERT(!zoned);
>>  		ret = run_delalloc_nocow(inode, locked_page, start, end,
>>  					 page_started, 0, nr_written);
>> -	} else if (!inode_can_compress(inode) ||
>> -		   !inode_need_compress(inode, start, end)) {
>> +	} else if (!do_compress && !zoned) {
>>  		ret = cow_file_range(inode, locked_page, start, end,
>>  				     page_started, nr_written, 1);
>> +	} else if (!do_compress && zoned) {
>> +		ret = run_delalloc_zoned(inode, locked_page, start, end,
>> +					 page_started, nr_written);
>
>The part of the condition is shared so it should be structured lik
>
>	} else if (!<the compression checks>) {
>		if (zoned)
>			run_delalloc_zoned
>		else
>			cow_file_range
>	} ...
>

Sure. I'll rewrite the code like this in v15.

Thanks,

>>  	} else {
>>  		set_bit(BTRFS_INODE_HAS_ASYNC_EXTENT, &inode->runtime_flags);
>>  		ret = cow_file_range_async(inode, wbc, locked_page, start, end,
>> --
>> 2.27.0
