Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6732C366F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 03:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgKYB5o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 20:57:44 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:57492 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgKYB5n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 20:57:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606269462; x=1637805462;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lSKwv7No8laJfLk5T3vzxS3dxAytBoC6Q+68IuCrSCE=;
  b=oSOQ/5P89jkFjpRTtZaN6r72VfZvBtvrqnnzssH2RwfGmI4Rwz9kQhR9
   4YUAP3aEEwOHXGBGDjHiNqjPxjF/LOKGi/g1SZtK95uy9JBmb9/TpI6iR
   SU0LMMAuFWZST45eSoW7a0StNp4ZVWTZHo9dqrFAZo8ud324iIO0BkeRd
   xWvTj4iyVQVk9vrYZwOKzYwTeiL7bh4ndaR7ZVs9dqI3nyp+cq+eo4ckQ
   dp7am3k7JxqetlnBeSLC8ObsQ6QMyXaUIHySFXNd9pmHr5d9ba1+C4oBT
   o9c+PGtm5wX8TS8G/3Kpe+0ibe2udEySQxVEbStiycCvekDwpLTbcWmFY
   w==;
IronPort-SDR: QT7GHZKfF/b0jZvnP7p1C2g0Pg4SrzQsBZ1oZNo+Eas+mgwJzG4T6/tI77oe6MhVVuLTi6awYu
 PCWpabXeStBNoaS4iW1cOMfZsdID1gm52d4kCKIWqAEf/1jIsgvUUJEqgAdKctRwTspq+L4jMV
 zsKo1e74t5mec3CNvhdIdtBPuybUJUuQbuOmjjLVkjjgFXz13QgtoGA3IzOdepojEExHgIpFCq
 LyejZkmVHFNEBKWCF0VNyP9zfJuY1gBxf67g6Duo7GPF3sPKh7+9gUqrs2dcYj1oKnZiYVMkP4
 bTk=
X-IronPort-AV: E=Sophos;i="5.78,367,1599494400"; 
   d="scan'208";a="263482987"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Nov 2020 09:57:42 +0800
IronPort-SDR: pKav8hQRAZucIdFC56g9ABYHrtaB15iUyP6YJyY4uD5aqe2/MGuQnJ0E6bf9Aui3t2R8GtBLsf
 /FGQ7IO4eS4RSXBTVnwg6781OaUhcwIwI=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 17:43:26 -0800
IronPort-SDR: HnoCA9NDn2MR8EwPNVmPtujVT8kSje90gspSgwZKBHbifbwz9aPFNchvc4N8StJXZxlZ6zuewl
 O5dgmwfIgQuA==
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with SMTP; 24 Nov 2020 17:57:41 -0800
Received: (nullmailer pid 2939947 invoked by uid 1000);
        Wed, 25 Nov 2020 01:57:40 -0000
Date:   Wed, 25 Nov 2020 10:57:40 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v10 12/41] btrfs: implement zoned chunk allocator
Message-ID: <20201125015740.conrettvmrgwebus@naota.dhcp.fujisawa.hgst.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
 <e7896fe18651e3ad12a96ff3ec3255e3127c8239.1605007036.git.naohiro.aota@wdc.com>
 <9cec3af1-4f2c-c94c-1506-07db2c66cc90@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <9cec3af1-4f2c-c94c-1506-07db2c66cc90@oracle.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 24, 2020 at 07:36:18PM +0800, Anand Jain wrote:
>On 10/11/20 7:26 pm, Naohiro Aota wrote:
>>This commit implements a zoned chunk/dev_extent allocator. The zoned
>>allocator aligns the device extents to zone boundaries, so that a zone
>>reset affects only the device extent and does not change the state of
>>blocks in the neighbor device extents.
>>
>>Also, it checks that a region allocation is not overlapping any of the
>>super block zones, and ensures the region is empty.
>>
>>Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>
>Looks good.
>
>Chunks and stripes are aligned to the zone_size. I guess zone_size won't
>change after the block device has been formatted with it? For testing,
>what if the device image is dumped onto another zoned device with a
>different zone_size?

Zone size is a drive characteristic, so it never change on the same device.

Dump/restore on another device with a different zone_size should be banned,
because we cannot ensure device extents are aligned to zone boundaries.

>
>A small nit is below.
>
>>+static void init_alloc_chunk_ctl_policy_zoned(
>>+				      struct btrfs_fs_devices *fs_devices,
>>+				      struct alloc_chunk_ctl *ctl)
>>+{
>>+	u64 zone_size = fs_devices->fs_info->zone_size;
>>+	u64 limit;
>>+	int min_num_stripes = ctl->devs_min * ctl->dev_stripes;
>>+	int min_data_stripes = (min_num_stripes - ctl->nparity) / ctl->ncopies;
>>+	u64 min_chunk_size = min_data_stripes * zone_size;
>>+	u64 type = ctl->type;
>>+
>>+	ctl->max_stripe_size = zone_size;
>>+	if (type & BTRFS_BLOCK_GROUP_DATA) {
>>+		ctl->max_chunk_size = round_down(BTRFS_MAX_DATA_CHUNK_SIZE,
>>+						 zone_size);
>>+	} else if (type & BTRFS_BLOCK_GROUP_METADATA) {
>>+		ctl->max_chunk_size = ctl->max_stripe_size;
>>+	} else if (type & BTRFS_BLOCK_GROUP_SYSTEM) {
>>+		ctl->max_chunk_size = 2 * ctl->max_stripe_size;
>>+		ctl->devs_max = min_t(int, ctl->devs_max,
>>+				      BTRFS_MAX_DEVS_SYS_CHUNK);
>>+	}
>>+
>
>
>>+	/* We don't want a chunk larger than 10% of writable space */
>>+	limit = max(round_down(div_factor(fs_devices->total_rw_bytes, 1),
>
> What's the purpose of dev_factor here?

This one follows the same limitation as in regular allocator
(init_alloc_chunk_ctl_policy_regular).

>
>Thanks.
>
