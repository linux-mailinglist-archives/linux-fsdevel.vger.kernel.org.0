Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D25C92A3972
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 02:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbgKCBZk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 20:25:40 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:39117 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbgKCBZh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 20:25:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604366737; x=1635902737;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gkBoV3icl+ZFoQ+k0gd6K22e3ThdGprzDDoSMAxG8Jw=;
  b=fKE4IW/U+Jf+kOWPrRRDF04Z3aeAZRqqRnMc+h2m1Wsf1/JguX/a+FE5
   +c8UydPYiVWmaBHT1IuZDn7fp/sy/hZ4mNddzSKUUFCA0Hzxy7iyfZtAh
   lG4IHyVtH1CTemY7NGzRtnkvo1ad4l948/G8iPL1OH1M/REHLInbJR4vc
   JeD0m20SemvUzB/zpwv5bLGUDZr55wADjXBAI/qS115kjxmg3TZfrbfj8
   RRs8mlEI6VZJ7Nyq37LvtHq+KBjhmy09ndiyRLQIYyiZfs8HzdVg1WJtw
   d7fm09KjnNd/Pq0D2Cn7eut8ppSWqiCn8BZN7blp9cybushesjReh950h
   A==;
IronPort-SDR: VNhhS+9R2LKc3+k2OXcpcXo1k5OYwj9/QmyAIGsFPlP8GFyJ+WoQWfGgWWy+g/8oh8mIBg3eoa
 GABtCBxnwsaGEWRAG0pcLDWIrf/Q8QoNxtTnW+cd7y68+nzDhMZNW245p6286803NAmCOOefRa
 gctEL4b1dhztXIxY2LeIP6DFyF6kzI4tVJCd5/JZuvHh8JUNZs0IkkDP7s0QebdlQtL2wsS+OW
 NeRBiWQUB4ilmbvq4mXQO4qIu0cWLQxplL3c95tCr7NFAjbBuTc89SM574Ke90lUZJ0wz5W2Gn
 zXA=
X-IronPort-AV: E=Sophos;i="5.77,446,1596470400"; 
   d="scan'208";a="261550077"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2020 09:25:36 +0800
IronPort-SDR: 9iKeeSO3BDNNwEXyOaPT32a6NTvMkWlN/sy6IleFplj5X53TqXzJCP5EpAv/PI70mMpwUZxluG
 wb83r95JPbT4JGguapgCQ6diKfuI3IVfz2WNfo06mSQRPXNDKmkd1IRXFYADz0Fxa8Bw8VjERu
 4go97ExOLq8Q3BDWU3rGVf0xDNWcm+rZrNJ4vUtrr7kwNnPcNeyJG1pCut+k3JFU4IipT/eNJo
 Ec87oV+m5L+knPAPaO/y87rC2OM0j5/h1JrPd+jqDyvIM5uITlDE5J7C/n0xFmd6+XSiAgJBUR
 ShhC2R9M6bzin0kXu2NiGYBK
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2020 17:10:36 -0800
IronPort-SDR: TQvpCFQ8SdnwtiNvloDLqt67KJVC5ciOyv8a4F048HOV/Rig69shu1aGExKiFJ08n1eVzAHSsK
 WVHssYZHA+AgDRJwmtQEWZXjLUWmk7hpq+VENaphfcaiS6i/KjXKzNmHlofQEi0UM5hOLoXrdK
 b+EAf8YhHXgPf8fG7EOohL2KD+WGkPPFvDMb8xCw6dD/WBbo9YffG5o2S/Bmr3ik/JZuAy1JMX
 ewvi1638lm0UqMiExZKACEZ3zzSJnqYTqsIo/LVc9nFWXzVh42c450nKr8UugcHykGqYhMlYJV
 lxI=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with SMTP; 02 Nov 2020 17:25:36 -0800
Received: (nullmailer pid 4102434 invoked by uid 1000);
        Tue, 03 Nov 2020 01:25:35 -0000
Date:   Tue, 3 Nov 2020 10:25:35 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v9 15/41] btrfs: emulate write pointer for conventional
 zones
Message-ID: <20201103012535.6coor2tar2su6b7m@naota.dhcp.fujisawa.hgst.com>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
 <af1830174f9dd9e2651dab213c0b984d90811138.1604065695.git.naohiro.aota@wdc.com>
 <a96ef4d1-b020-a467-bd26-863bc7117e64@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <a96ef4d1-b020-a467-bd26-863bc7117e64@toxicpanda.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 02, 2020 at 03:37:35PM -0500, Josef Bacik wrote:
>On 10/30/20 9:51 AM, Naohiro Aota wrote:
>>Conventional zones do not have a write pointer, so we cannot use it to
>>determine the allocation offset if a block group contains a conventional
>>zone.
>>
>>But instead, we can consider the end of the last allocated extent in the
>>block group as an allocation offset.
>>
>>Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>>---
>>  fs/btrfs/zoned.c | 119 ++++++++++++++++++++++++++++++++++++++++++++---
>>  1 file changed, 113 insertions(+), 6 deletions(-)
>>
>>diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
>>index 0aa821893a51..8f58d0853cc3 100644
>>--- a/fs/btrfs/zoned.c
>>+++ b/fs/btrfs/zoned.c
>>@@ -740,6 +740,104 @@ int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size)
>>  	return 0;
>>  }
>>+static int emulate_write_pointer(struct btrfs_block_group *cache,
>>+				 u64 *offset_ret)
>>+{
>>+	struct btrfs_fs_info *fs_info = cache->fs_info;
>>+	struct btrfs_root *root = fs_info->extent_root;
>>+	struct btrfs_path *path;
>>+	struct extent_buffer *leaf;
>>+	struct btrfs_key search_key;
>>+	struct btrfs_key found_key;
>>+	int slot;
>>+	int ret;
>>+	u64 length;
>>+
>>+	path = btrfs_alloc_path();
>>+	if (!path)
>>+		return -ENOMEM;
>>+
>>+	search_key.objectid = cache->start + cache->length;
>>+	search_key.type = 0;
>>+	search_key.offset = 0;
>>+
>
>You can just use 'key', don't have to use 'search_key'.

Fixed.

>
>Also you don't check for things like BTRFS_TREE_BLOCK_REF_KEY or 
>whatever in the case that we don't have an inline extent ref, so this 
>could error out with a fs with lots of snapshots and different 
>references.  What you need is to search back until you hit an 
>BTRFS_METADATA_ITEM_KEY or a BTRFS_EXTENT_ITEM_KEY, and then check the 
>offset of that thing.  Otherwise this will screw up.  Thanks,
>
>Josef

I overlooked that case. And, I just noticed we can use
btrfs_previous_extent_item() here. It looks much simpler now. Thanks.
