Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 187FB155493
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 10:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgBGJZX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 04:25:23 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:13439 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgBGJZX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 04:25:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581067523; x=1612603523;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Gybe9ztNbIlkMdUN8dHYwN2XFQVqCi/v420XxbuDY6g=;
  b=R3gWvDh71cDWPiMmdrqZxkNG41ta8E0CKmtRiupXT7Bx8NExWOxxeV4e
   7c0uQbZRCzUrw0WKKOZ9gW5dA1zsfeSCEUfdgPWKLW4ukdFGjhgpWeem6
   nVnsUTxxKLKp0F4i16PvwbOUBoBZmC8aMEOnM2DF2gy+wlVdsza1GrNEL
   NGPjSMnzMJ2S9XUCYFcC+eDU+82oCPhYjegTeVzkKFieVv333rfVMOob5
   h1sxC3dVhGbGNr9rFTHM4kC9MHyNeAqjgOlTTCm2PGiGXagVjr5kkQe6t
   etQL5xZw7mPDP2zT31tAqybkgn1S6YF5uuWnDTejpDpU7S/yeHtmGdTs2
   g==;
IronPort-SDR: IIROQ+TMWE+pLEBtP/2T5ZBtxzu/jZqZvuKS8ExzYvWtU6qNqFW0egWcYT0otVsmaIXIL/AF2j
 oP7INnomY+gkGg83bd/7rO7DTkOoZnCPLLO10k32dUqU6fgdrmaNlYIKo3uVl2cZ9ESZ306bLq
 KGS8PS1tpWy88NRdp8FI5YHsxUgkCVV4zV/AlCiCkdCdWirtQkc3y0WPy60lR0QYkjV3ZhL2eg
 wgNE9ntVItuJS9VA8g8SPamgTmimL5S+xRvdNgCHMr/NgpZVlsEA0aJP8oQju1KbE9WlCJeXL+
 dFw=
X-IronPort-AV: E=Sophos;i="5.70,412,1574092800"; 
   d="scan'208";a="129891777"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Feb 2020 17:25:23 +0800
IronPort-SDR: RhhA0tgdvlu+ISNUkhKnNBXwxTfL1wLUYtls5c9VxLmiR5X1OQSFet1Gw/RxYlwsVC8CqsHkVa
 XXCne/sh3Uga0WaAKk30mntq3B085g+UZwB99gC3ZIIUyDca6nLFOxqSyoTyyxpy7c1BXWSIYS
 vXUefRWx7hGU60wz2F7P6acwbyPNGdoFDcagSwcVEaT5diiCpPNK95yYXNC/lAAQ76sgoNJhjF
 TrfqrtUP2UiLt2GU+FdFFEjYn2UZzAp+mwYcwK3EDpqhBzpZcKwAggMc4YTWKfCFrwuIRsFvix
 qRCIb2IGPebPLUPIFCIwM4rK
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2020 01:18:20 -0800
IronPort-SDR: rOyQ+qfh9f1umUPuEath/cRR6WSs6E5F6Aglr38AiY0rhk6rvEOWxza9We/engNbe5+kqEb+DM
 q8u5b1Nx/fXGavA38kTb7r7QnP8LjvfCiDDxP23Lh6Zr8Cy9OKyYItEvZmJV1S7o5RFtxTiOae
 wEhD+zeFMSwPB1RTc8h6/v6SLgfEXgFYMexx4R3c+jPgWsuTuz3BqDrwLRTCFIH3BXkCX73QxF
 GDZVO6KOjQrwOhYuhZRdCvU08Xes8LHhhg460wD+6MKcVaSG6p+MDTEUVD0Ymvjp+89nu9D4IP
 axA=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with SMTP; 07 Feb 2020 01:25:20 -0800
Received: (nullmailer pid 949814 invoked by uid 1000);
        Fri, 07 Feb 2020 09:25:20 -0000
Date:   Fri, 7 Feb 2020 18:25:20 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Su Yue <Damenly_Su@gmx.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 12/20] btrfs: introduce clustered_alloc_info
Message-ID: <20200207092520.txwn4vbqjnt5sqsm@naota.dhcp.fujisawa.hgst.com>
References: <20200206104214.400857-1-naohiro.aota@wdc.com>
 <20200206104214.400857-13-naohiro.aota@wdc.com>
 <c235054d-49b1-28b5-0f3b-d7bc1cecd766@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <c235054d-49b1-28b5-0f3b-d7bc1cecd766@gmx.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 06, 2020 at 08:44:51PM +0800, Su Yue wrote:
>On 2020/2/6 6:42 PM, Naohiro Aota wrote:
>>Introduce struct clustered_alloc_info to manage parameters related to
>>clustered allocation. By separating clustered_alloc_info and
>>find_free_extent_ctl, we can introduce other allocation policy. One can
>>access per-allocation policy private information from "alloc_info" of
>>struct find_free_extent_ctl.
>>
>>Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>>---
>>  fs/btrfs/extent-tree.c | 99 +++++++++++++++++++++++++-----------------
>>  1 file changed, 59 insertions(+), 40 deletions(-)
>>
>>diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
>>index b1f52eee24fe..8124a6461043 100644
>>--- a/fs/btrfs/extent-tree.c
>>+++ b/fs/btrfs/extent-tree.c
>>@@ -3456,9 +3456,6 @@ struct find_free_extent_ctl {
>>  	/* Where to start the search inside the bg */
>>  	u64 search_start;
>>
>>-	/* For clustered allocation */
>>-	u64 empty_cluster;
>>-
>>  	bool have_caching_bg;
>>  	bool orig_have_caching_bg;
>>
>>@@ -3470,18 +3467,6 @@ struct find_free_extent_ctl {
>>  	 */
>>  	int loop;
>>
>>-	/*
>>-	 * Whether we're refilling a cluster, if true we need to re-search
>>-	 * current block group but don't try to refill the cluster again.
>>-	 */
>>-	bool retry_clustered;
>>-
>>-	/*
>>-	 * Whether we're updating free space cache, if true we need to re-search
>>-	 * current block group but don't try updating free space cache again.
>>-	 */
>>-	bool retry_unclustered;
>>-
>>  	/* If current block group is cached */
>>  	int cached;
>>
>>@@ -3499,8 +3484,28 @@ struct find_free_extent_ctl {
>>
>>  	/* Allocation policy */
>>  	enum btrfs_extent_allocation_policy policy;
>>+	void *alloc_info;
>>  };
>>
>>+struct clustered_alloc_info {
>>+	/* For clustered allocation */
>>+	u64 empty_cluster;
>>+
>>+	/*
>>+	 * Whether we're refilling a cluster, if true we need to re-search
>>+	 * current block group but don't try to refill the cluster again.
>>+	 */
>>+	bool retry_clustered;
>>+
>>+	/*
>>+	 * Whether we're updating free space cache, if true we need to re-search
>>+	 * current block group but don't try updating free space cache again.
>>+	 */
>>+	bool retry_unclustered;
>>+
>>+	struct btrfs_free_cluster *last_ptr;
>>+	bool use_cluster;
>>+};
>>
>>  /*
>>   * Helper function for find_free_extent().
>>@@ -3516,6 +3521,7 @@ static int find_free_extent_clustered(struct btrfs_block_group *bg,
>>  		struct btrfs_block_group **cluster_bg_ret)
>>  {
>>  	struct btrfs_block_group *cluster_bg;
>>+	struct clustered_alloc_info *clustered = ffe_ctl->alloc_info;
>>  	u64 aligned_cluster;
>>  	u64 offset;
>>  	int ret;
>>@@ -3572,7 +3578,7 @@ static int find_free_extent_clustered(struct btrfs_block_group *bg,
>>  	}
>>
>>  	aligned_cluster = max_t(u64,
>>-			ffe_ctl->empty_cluster + ffe_ctl->empty_size,
>>+			clustered->empty_cluster + ffe_ctl->empty_size,
>>  			bg->full_stripe_len);
>>  	ret = btrfs_find_space_cluster(bg, last_ptr, ffe_ctl->search_start,
>>  			ffe_ctl->num_bytes, aligned_cluster);
>>@@ -3591,12 +3597,12 @@ static int find_free_extent_clustered(struct btrfs_block_group *bg,
>>  			return 0;
>>  		}
>>  	} else if (!ffe_ctl->cached && ffe_ctl->loop > LOOP_CACHING_NOWAIT &&
>>-		   !ffe_ctl->retry_clustered) {
>>+		   !clustered->retry_clustered) {
>>  		spin_unlock(&last_ptr->refill_lock);
>>
>>-		ffe_ctl->retry_clustered = true;
>>+		clustered->retry_clustered = true;
>>  		btrfs_wait_block_group_cache_progress(bg, ffe_ctl->num_bytes +
>>-				ffe_ctl->empty_cluster + ffe_ctl->empty_size);
>>+				clustered->empty_cluster + ffe_ctl->empty_size);
>>  		return -EAGAIN;
>>  	}
>>  	/*
>>@@ -3618,6 +3624,7 @@ static int find_free_extent_unclustered(struct btrfs_block_group *bg,
>>  		struct btrfs_free_cluster *last_ptr,
>>  		struct find_free_extent_ctl *ffe_ctl)
>>  {
>>+	struct clustered_alloc_info *clustered = ffe_ctl->alloc_info;
>>  	u64 offset;
>>
>>  	/*
>>@@ -3636,7 +3643,7 @@ static int find_free_extent_unclustered(struct btrfs_block_group *bg,
>>  		free_space_ctl = bg->free_space_ctl;
>>  		spin_lock(&free_space_ctl->tree_lock);
>>  		if (free_space_ctl->free_space <
>>-		    ffe_ctl->num_bytes + ffe_ctl->empty_cluster +
>>+		    ffe_ctl->num_bytes + clustered->empty_cluster +
>>  		    ffe_ctl->empty_size) {
>>  			ffe_ctl->total_free_space = max_t(u64,
>>  					ffe_ctl->total_free_space,
>>@@ -3660,11 +3667,11 @@ static int find_free_extent_unclustered(struct btrfs_block_group *bg,
>>  	 * If @retry_unclustered is true then we've already waited on this
>>  	 * block group once and should move on to the next block group.
>>  	 */
>>-	if (!offset && !ffe_ctl->retry_unclustered && !ffe_ctl->cached &&
>>+	if (!offset && !clustered->retry_unclustered && !ffe_ctl->cached &&
>>  	    ffe_ctl->loop > LOOP_CACHING_NOWAIT) {
>>  		btrfs_wait_block_group_cache_progress(bg, ffe_ctl->num_bytes +
>>  						      ffe_ctl->empty_size);
>>-		ffe_ctl->retry_unclustered = true;
>>+		clustered->retry_unclustered = true;
>>  		return -EAGAIN;
>>  	} else if (!offset) {
>>  		return 1;
>>@@ -3685,6 +3692,7 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
>>  					bool full_search, bool use_cluster)
>>  {
>>  	struct btrfs_root *root = fs_info->extent_root;
>>+	struct clustered_alloc_info *clustered = ffe_ctl->alloc_info;
>>  	int ret;
>>
>>  	if ((ffe_ctl->loop == LOOP_CACHING_NOWAIT) &&
>>@@ -3774,10 +3782,10 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
>>  			 * no empty_cluster.
>>  			 */
>>  			if (ffe_ctl->empty_size == 0 &&
>>-			    ffe_ctl->empty_cluster == 0)
>>+			    clustered->empty_cluster == 0)
>>  				return -ENOSPC;
>>  			ffe_ctl->empty_size = 0;
>>-			ffe_ctl->empty_cluster = 0;
>>+			clustered->empty_cluster = 0;
>>  		}
>>  		return 1;
>>  	}
>>@@ -3816,11 +3824,10 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
>>  {
>>  	int ret = 0;
>>  	int cache_block_group_error = 0;
>>-	struct btrfs_free_cluster *last_ptr = NULL;
>>  	struct btrfs_block_group *block_group = NULL;
>>  	struct find_free_extent_ctl ffe_ctl = {0};
>>  	struct btrfs_space_info *space_info;
>>-	bool use_cluster = true;
>>+	struct clustered_alloc_info *clustered = NULL;
>>  	bool full_search = false;
>>
>>  	WARN_ON(num_bytes < fs_info->sectorsize);
>>@@ -3829,8 +3836,6 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
>>  	ffe_ctl.empty_size = empty_size;
>>  	ffe_ctl.flags = flags;
>>  	ffe_ctl.search_start = 0;
>>-	ffe_ctl.retry_clustered = false;
>>-	ffe_ctl.retry_unclustered = false;
>>  	ffe_ctl.delalloc = delalloc;
>>  	ffe_ctl.index = btrfs_bg_flags_to_raid_index(flags);
>>  	ffe_ctl.have_caching_bg = false;
>>@@ -3851,6 +3856,15 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
>>  		return -ENOSPC;
>>  	}
>>
>>+	clustered = kzalloc(sizeof(*clustered), GFP_NOFS);
>>+	if (!clustered)
>>+		return -ENOMEM;
>
>NIT of coding style, please pick the kzalloc after the whole assignment
>zone.

Hm, this part will be eventually folded into
prepare_allocation_clustered() with the below part (of doing
fetch_cluster_info() etc.) in the patch 20. So, I'm not sure I really
need to move it within this patch...

>>+	clustered->last_ptr = NULL;
>>+	clustered->use_cluster = true;
>>+	clustered->retry_clustered = false;
>>+	clustered->retry_unclustered = false;
>>+	ffe_ctl.alloc_info = clustered;
>>+
>>  	/*
>>  	 * If our free space is heavily fragmented we may not be able to make
>>  	 * big contiguous allocations, so instead of doing the expensive search
>>@@ -3869,14 +3883,16 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
>>  			spin_unlock(&space_info->lock);
>>  			return -ENOSPC;
>>  		} else if (space_info->max_extent_size) {
>>-			use_cluster = false;
>>+			clustered->use_cluster = false;
>>  		}
>>  		spin_unlock(&space_info->lock);
>>  	}
>>
>>-	last_ptr = fetch_cluster_info(fs_info, space_info,
>>-				      &ffe_ctl.empty_cluster);
>>-	if (last_ptr) {
>>+	clustered->last_ptr = fetch_cluster_info(fs_info, space_info,
>>+						 &clustered->empty_cluster);
>>+	if (clustered->last_ptr) {
>>+		struct btrfs_free_cluster *last_ptr = clustered->last_ptr;
>>+
>>  		spin_lock(&last_ptr->lock);
>>  		if (last_ptr->block_group)
>>  			ffe_ctl.hint_byte = last_ptr->window_start;
>>@@ -3887,7 +3903,7 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
>>  			 * some time.
>>  			 */
>>  			ffe_ctl.hint_byte = last_ptr->window_start;
>>-			use_cluster = false;
>>+			clustered->use_cluster = false;
>>  		}
>>  		spin_unlock(&last_ptr->lock);
>>  	}
>>@@ -4000,10 +4016,11 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
>>  		 * Ok we want to try and use the cluster allocator, so
>>  		 * lets look there
>>  		 */
>>-		if (last_ptr && use_cluster) {
>>+		if (clustered->last_ptr && clustered->use_cluster) {
>>  			struct btrfs_block_group *cluster_bg = NULL;
>>
>>-			ret = find_free_extent_clustered(block_group, last_ptr,
>>+			ret = find_free_extent_clustered(block_group,
>>+							 clustered->last_ptr,
>>  							 &ffe_ctl, &cluster_bg);
>>
>>  			if (ret == 0) {
>>@@ -4021,7 +4038,8 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
>>  			/* ret == -ENOENT case falls through */
>>  		}
>>
>>-		ret = find_free_extent_unclustered(block_group, last_ptr,
>>+		ret = find_free_extent_unclustered(block_group,
>>+						   clustered->last_ptr,
>>  						   &ffe_ctl);
>>  		if (ret == -EAGAIN)
>>  			goto have_block_group;
>>@@ -4062,8 +4080,8 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
>>  		btrfs_release_block_group(block_group, delalloc);
>>  		break;
>>  loop:
>>-		ffe_ctl.retry_clustered = false;
>>-		ffe_ctl.retry_unclustered = false;
>>+		clustered->retry_clustered = false;
>>+		clustered->retry_unclustered = false;
>>  		BUG_ON(btrfs_bg_flags_to_raid_index(block_group->flags) !=
>>  		       ffe_ctl.index);
>>  		btrfs_release_block_group(block_group, delalloc);
>>@@ -4071,8 +4089,9 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
>>  	}
>>  	up_read(&space_info->groups_sem);
>>
>>-	ret = find_free_extent_update_loop(fs_info, last_ptr, ins, &ffe_ctl,
>>-					   full_search, use_cluster);
>>+	ret = find_free_extent_update_loop(fs_info, clustered->last_ptr, ins,
>>+					   &ffe_ctl, full_search,
>>+					   clustered->use_cluster);
>>  	if (ret > 0)
>>  		goto search;
>>
>>
>
