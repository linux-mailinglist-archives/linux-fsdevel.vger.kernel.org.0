Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 427282AD474
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 12:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgKJLJj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 06:09:39 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:8145 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgKJLJj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 06:09:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605007550; x=1636543550;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CqWvjkY2K2Bmu4IdcfnmGVtiN695X6ZiT0iocmK2Rr4=;
  b=jqQGWLZfuj8QbwWKru6P1v6cL1YEzgsmAbLll7URQaxpCkDVNHBz1Bi7
   aQvn4uf/LhXhlWZUlKtnT2aNIHV1VdlCzd4EPzz/mUJbfw3wnh1VADzpF
   Jr1dyp+JXfo/ELZq65AnIKZ/76dDCDqw8rvInzwniB0gCYIOgzhCptkzc
   weV0hMe4bPY35jI5s/bc5P0c2p77A7qyeKGjZ5GFDfNNV8vTgk2Kf99+f
   sEvLY2NwyZYVVceFTc9b8hYB/jYqraXujjE9055Fp8PmZx6KNPtqIX/1T
   rsJHjXe5TXuyVG+wGEfdrx4XvEylymT9aujbJ5AB1crgLTGMt+u+axekD
   Q==;
IronPort-SDR: u0oZhJxChaFNLDcMqN2CcpIlWAzUzvMLGFjwx3naezPm94viLp2OqvooQMp/VtU1Ho3UNsWNwB
 pzT9/FpF+C3Wv6K6BDEb2OIYIlNOYYg64s9rF6BNTvlaPYNySIDfzNhcPkEVOqnf8vi/fAprzO
 19lmP1dTpJkOT6GzyDcNYaAIOIiSwYjjauSvoZyfyjBurndHbHMfSxnzSLrKm4iOt1h59YoE0+
 AonVEa7fIkhbx00oDEk9Ny6s19uS0KEhM5My980nblaRjMQwslRSIETFdlcnMqvdxtPoCAU/gF
 9Hg=
X-IronPort-AV: E=Sophos;i="5.77,466,1596470400"; 
   d="scan'208";a="255832336"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 19:25:50 +0800
IronPort-SDR: WRmBYEWsBqac3HA4KoiHkD7caXsWnmaejjShnz7Ui89iFOWfM6KLc3tMFrLzvVnlPnRUnsUo8P
 eH0WGJZQliNGGp0+ERycdBrUpuaWvLfEO7IFOpZPve6A3du8hJSc3jwWeHm91p30WY976b0AN1
 pNVe7b/ekyZB5iRSGn6W+9U9PT+AinJbfLNp4eEabgDLu4m0z1f/T6bQ+kulKajd4mBKHJnHS7
 xF4gkafMd4qiCGRHdUl+roFN/P7coATmmv+kb8a0Kfd0cpKk4rCHfEkGXT0hDLt08rR8iPvyqH
 TyFRooDvFFny08b4P8O6jGOX
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 02:54:25 -0800
IronPort-SDR: 9kd4D87zohY5jSK7Cju5SEr1e6nj8oxnm4VHBeCXkJK3fMMeGYs7LFPzDOS/9MXhu+MPCTqYbc
 PONOEOcXRYObV2yq5o+RDInjohdICnvM8uVn74iZk7OK813aIpmQJ8QemaURtaHmgEJDfbCa+s
 vlsr64+/eE7C2qk9swvBTM46U8O6Z4dAqS2uKWJhnMIXsY6p6jXfrJsXmORGJFQoVbtivg7mlG
 iEbefL5vYELEJz+H9BINRwQaGZFWwj9i37ZXFDMofsc92Tk4GF/n7uBVbfoqwqH6wHOTfs96kE
 eiA=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with SMTP; 10 Nov 2020 03:09:37 -0800
Received: (nullmailer pid 1964258 invoked by uid 1000);
        Tue, 10 Nov 2020 11:09:36 -0000
Date:   Tue, 10 Nov 2020 20:09:36 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v9 33/41] btrfs: implement copying for ZONED
 device-replace
Message-ID: <20201110110936.dtf6bx3uqdupuhk5@naota.dhcp.fujisawa.hgst.com>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
 <2370c99060300c9438ca1727215d398592f52434.1604065695.git.naohiro.aota@wdc.com>
 <b15a7c94-97e3-e6b3-0f83-c02433992d47@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <b15a7c94-97e3-e6b3-0f83-c02433992d47@toxicpanda.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 03, 2020 at 12:19:41PM -0500, Josef Bacik wrote:
>On 10/30/20 9:51 AM, Naohiro Aota wrote:
>>This is 3/4 patch to implement device-replace on ZONED mode.
>>
>>This commit implement copying. So, it track the write pointer during device
>>replace process. Device-replace's copying is smart to copy only used
>>extents on source device, we have to fill the gap to honor the sequential
>>write rule in the target device.
>>
>>Device-replace process in ZONED mode must copy or clone all the extents in
>>the source device exactly once.  So, we need to use to ensure allocations
>>started just before the dev-replace process to have their corresponding
>>extent information in the B-trees. finish_extent_writes_for_zoned()
>>implements that functionality, which basically is the removed code in the
>>commit 042528f8d840 ("Btrfs: fix block group remaining RO forever after
>>error during device replace").
>>
>>Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>>---
>>  fs/btrfs/scrub.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  fs/btrfs/zoned.c | 12 +++++++
>>  fs/btrfs/zoned.h |  7 ++++
>>  3 files changed, 105 insertions(+)
>>
>>diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
>>index 371bb6437cab..aaf7882dee06 100644
>>--- a/fs/btrfs/scrub.c
>>+++ b/fs/btrfs/scrub.c
>>@@ -169,6 +169,7 @@ struct scrub_ctx {
>>  	int			pages_per_rd_bio;
>>  	int			is_dev_replace;
>>+	u64			write_pointer;
>>  	struct scrub_bio        *wr_curr_bio;
>>  	struct mutex            wr_lock;
>>@@ -1623,6 +1624,25 @@ static int scrub_write_page_to_dev_replace(struct scrub_block *sblock,
>>  	return scrub_add_page_to_wr_bio(sblock->sctx, spage);
>>  }
>>+static int fill_writer_pointer_gap(struct scrub_ctx *sctx, u64 physical)
>>+{
>>+	int ret = 0;
>>+	u64 length;
>>+
>>+	if (!btrfs_is_zoned(sctx->fs_info))
>>+		return 0;
>>+
>>+	if (sctx->write_pointer < physical) {
>>+		length = physical - sctx->write_pointer;
>>+
>>+		ret = btrfs_zoned_issue_zeroout(sctx->wr_tgtdev,
>>+						sctx->write_pointer, length);
>>+		if (!ret)
>>+			sctx->write_pointer = physical;
>>+	}
>>+	return ret;
>>+}
>>+
>>  static int scrub_add_page_to_wr_bio(struct scrub_ctx *sctx,
>>  				    struct scrub_page *spage)
>>  {
>>@@ -1645,6 +1665,13 @@ static int scrub_add_page_to_wr_bio(struct scrub_ctx *sctx,
>>  	if (sbio->page_count == 0) {
>>  		struct bio *bio;
>>+		ret = fill_writer_pointer_gap(sctx,
>>+					      spage->physical_for_dev_replace);
>>+		if (ret) {
>>+			mutex_unlock(&sctx->wr_lock);
>>+			return ret;
>>+		}
>>+
>>  		sbio->physical = spage->physical_for_dev_replace;
>>  		sbio->logical = spage->logical;
>>  		sbio->dev = sctx->wr_tgtdev;
>>@@ -1706,6 +1733,10 @@ static void scrub_wr_submit(struct scrub_ctx *sctx)
>>  	 * doubled the write performance on spinning disks when measured
>>  	 * with Linux 3.5 */
>>  	btrfsic_submit_bio(sbio->bio);
>>+
>>+	if (btrfs_is_zoned(sctx->fs_info))
>>+		sctx->write_pointer = sbio->physical +
>>+			sbio->page_count * PAGE_SIZE;
>>  }
>>  static void scrub_wr_bio_end_io(struct bio *bio)
>>@@ -2973,6 +3004,21 @@ static noinline_for_stack int scrub_raid56_parity(struct scrub_ctx *sctx,
>>  	return ret < 0 ? ret : 0;
>>  }
>>+static void sync_replace_for_zoned(struct scrub_ctx *sctx)
>>+{
>>+	if (!btrfs_is_zoned(sctx->fs_info))
>>+		return;
>>+
>>+	sctx->flush_all_writes = true;
>>+	scrub_submit(sctx);
>>+	mutex_lock(&sctx->wr_lock);
>>+	scrub_wr_submit(sctx);
>>+	mutex_unlock(&sctx->wr_lock);
>>+
>>+	wait_event(sctx->list_wait,
>>+		   atomic_read(&sctx->bios_in_flight) == 0);
>>+}
>>+
>>  static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
>>  					   struct map_lookup *map,
>>  					   struct btrfs_device *scrub_dev,
>>@@ -3105,6 +3151,14 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
>>  	 */
>>  	blk_start_plug(&plug);
>>+	if (sctx->is_dev_replace &&
>>+	    btrfs_dev_is_sequential(sctx->wr_tgtdev, physical)) {
>>+		mutex_lock(&sctx->wr_lock);
>>+		sctx->write_pointer = physical;
>>+		mutex_unlock(&sctx->wr_lock);
>>+		sctx->flush_all_writes = true;
>>+	}
>>+
>>  	/*
>>  	 * now find all extents for each stripe and scrub them
>>  	 */
>>@@ -3292,6 +3346,9 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
>>  			if (ret)
>>  				goto out;
>>+			if (sctx->is_dev_replace)
>>+				sync_replace_for_zoned(sctx);
>>+
>>  			if (extent_logical + extent_len <
>>  			    key.objectid + bytes) {
>>  				if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
>>@@ -3414,6 +3471,25 @@ static noinline_for_stack int scrub_chunk(struct scrub_ctx *sctx,
>>  	return ret;
>>  }
>>+static int finish_extent_writes_for_zoned(struct btrfs_root *root,
>>+					  struct btrfs_block_group *cache)
>>+{
>>+	struct btrfs_fs_info *fs_info = cache->fs_info;
>>+	struct btrfs_trans_handle *trans;
>>+
>>+	if (!btrfs_is_zoned(fs_info))
>>+		return 0;
>>+
>>+	btrfs_wait_block_group_reservations(cache);
>>+	btrfs_wait_nocow_writers(cache);
>>+	btrfs_wait_ordered_roots(fs_info, U64_MAX, cache->start, cache->length);
>>+
>>+	trans = btrfs_join_transaction(root);
>>+	if (IS_ERR(trans))
>>+		return PTR_ERR(trans);
>>+	return btrfs_commit_transaction(trans);
>>+}
>>+
>>  static noinline_for_stack
>>  int scrub_enumerate_chunks(struct scrub_ctx *sctx,
>>  			   struct btrfs_device *scrub_dev, u64 start, u64 end)
>>@@ -3569,6 +3645,16 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
>>  		 * group is not RO.
>>  		 */
>>  		ret = btrfs_inc_block_group_ro(cache, sctx->is_dev_replace);
>>+		if (!ret && sctx->is_dev_replace) {
>>+			ret = finish_extent_writes_for_zoned(root, cache);
>>+			if (ret) {
>>+				btrfs_dec_block_group_ro(cache);
>>+				scrub_pause_off(fs_info);
>>+				btrfs_put_block_group(cache);
>>+				break;
>>+			}
>>+		}
>>+
>>  		if (ret == 0) {
>>  			ro_set = 1;
>>  		} else if (ret == -ENOSPC && !sctx->is_dev_replace) {
>>diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
>>index f672465d1bb1..1b080184440d 100644
>>--- a/fs/btrfs/zoned.c
>>+++ b/fs/btrfs/zoned.c
>>@@ -1181,3 +1181,15 @@ void btrfs_revert_meta_write_pointer(struct btrfs_block_group *cache,
>>  	ASSERT(cache->meta_write_pointer == eb->start + eb->len);
>>  	cache->meta_write_pointer = eb->start;
>>  }
>>+
>>+int btrfs_zoned_issue_zeroout(struct btrfs_device *device, u64 physical,
>>+			      u64 length)
>>+{
>>+	if (!btrfs_dev_is_sequential(device, physical))
>>+		return -EOPNOTSUPP;
>>+
>
>This is going to result in a bunch of scrub errors.  Is this unlikely 
>to happen?  And if it isn't, should we do something different?  If 
>it's not sequential then we can probably just write to whatever offset 
>we want right?  So do we need an error here at all?  Thanks,
>
>Josef

I'm intended to use this to synchronize the write pointer.  For
conventional zones, we don't need to synchronize it anyway. We can just
skip the unwritten area in the source device and continue the writing at
the different location.
