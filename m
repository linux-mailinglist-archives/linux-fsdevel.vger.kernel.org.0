Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE240165B56
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 11:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgBTKUi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 05:20:38 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:31555 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbgBTKUh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 05:20:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582194036; x=1613730036;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zPIopc4hc9wGtddw/CRNjqDtmaOzXzN+cAoSSvPhd5Y=;
  b=KT6jBCNbpoDzHIvImi8LRZk4rXv9+hxzTCAdKQpk4TfhYjQ53dyR1m5E
   Tu9bSpeLjaA0w1Y/7grueieL+0Vul8Bf1R7NJtQmtoRdUHqNfqih5PERK
   6IkPMr6utSwr6atzYAtaz1usVx2Y611CeDwIxL/A6CUcD5fh26Yf16lPj
   xc5xtRwI7oJkBH7cWf3Ft5HFBrQKsJNJb0NVM/ZSVWKOnZ7Ueo9Dwqq5b
   naBNl0clXD+Gvo7wQfzxAOh05MQJ05usuNX+S/Tyy6Ap+AuLukfy1sDmU
   +sLgJeQXYEwz+U0e8YQRYrv3FKD86Wbgv3J+noHo6yremIiAlG34AP6D8
   A==;
IronPort-SDR: yh4vWmd81RIS7DyThAClZb9RCtBlUeeJ5/5iNToTLmYcewl7yKg9SCX7u8JrqjjIachuJNUy2B
 sOpNwUDxlpe9PK6+JuHmbC3IfCCzWQFr7+t137+GZUkWfhSGPR0T5mEd9YsFISgZd3xyu/cbPp
 ftaPMpm/3pqHZCFn6qc0IDd5kbJ8yjsdikSpDRh1+g0ILvwPJnNzCprSepw52vHRIR4Y3b2u6i
 +iL4NlvEOM4eV4W9J0NnRocU1LHyOygcjt3dgC3NHAtGC+pt+/J9hRw2pFe/vyeePosTKocB71
 o4k=
X-IronPort-AV: E=Sophos;i="5.70,464,1574092800"; 
   d="scan'208";a="130792440"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Feb 2020 18:17:26 +0800
IronPort-SDR: +bLrpsWeDprzGqhvwjqBn/aOMSlevnBRXkAMsOGyjV5JS/D4P/aCGSKi2JBo4td41tZqb2iIUx
 D3spfdCcNP14lQCKgsNN0M37QSlEa+mWKGZvEUA9JiCp80kSJ1+t5o+B8G0drncT25cyXcnFhi
 Ih2y0iRRaanf35Xctfi1bo34HfIIKvtMpt8553qtj+orxPu7V+/mN73ZIUIPYO3lmsa/7UJUhH
 Kcb8NlaXJgFWXRjFblqZjq/d1Pb9CbR3M7BaHVRw2oyOJnRa2inLOn83w88egY9qM9bBIdYOvX
 zRwMH1VmigmhqVjnKsa+kBbh
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 02:10:01 -0800
IronPort-SDR: grRjqvjTB5QpQgPGip3ZGDKqykzQva++X5C2OuLyDtTAR53/rcfNVlbnxjBdzqOnaxHDRxKsUY
 et34175jl67zjkf5Q+P7/c1A8/TYNrHo/4l8Sa3bWq8+zNEOVcHCATwwviAJTyG2yv/vsVYYbd
 sNwZaGZx0TwOBgtjvVY+Dp8/j8tObuD0/wpHA5h83dWgWqhMFcKV/fjmWds6/Uade5l53LGWkp
 M8kh1MELAE2JfnffglzogTHo/QfCOgRHmNZ+oOzF31CFIMlhZwGHf7RQIfhrKR/1ZfE25eVNPv
 vOc=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with SMTP; 20 Feb 2020 02:17:23 -0800
Received: (nullmailer pid 2544450 invoked by uid 1000);
        Thu, 20 Feb 2020 10:17:23 -0000
Date:   Thu, 20 Feb 2020 19:17:23 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 09/21] btrfs: factor out create_chunk()
Message-ID: <20200220101723.5wpidi3wd2a7wvgn@naota.dhcp.fujisawa.hgst.com>
References: <20200212072048.629856-1-naohiro.aota@wdc.com>
 <20200212072048.629856-10-naohiro.aota@wdc.com>
 <7514070d-b7a8-be1c-c23a-f01b9ee3c7ce@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <7514070d-b7a8-be1c-c23a-f01b9ee3c7ce@toxicpanda.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 13, 2020 at 11:24:57AM -0500, Josef Bacik wrote:
>On 2/12/20 2:20 AM, Naohiro Aota wrote:
>>Factor out create_chunk() from __btrfs_alloc_chunk(). This function finally
>>creates a chunk. There is no functional changes.
>>
>>Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>>---
>>  fs/btrfs/volumes.c | 130 ++++++++++++++++++++++++---------------------
>>  1 file changed, 70 insertions(+), 60 deletions(-)
>>
>>diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>index 00085943e4dd..3e2e3896d72a 100644
>>--- a/fs/btrfs/volumes.c
>>+++ b/fs/btrfs/volumes.c
>>@@ -5052,90 +5052,53 @@ static int decide_stripe_size(struct btrfs_fs_devices *fs_devices,
>>  	}
>>  }
>>-static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
>>-			       u64 start, u64 type)
>>+static int create_chunk(struct btrfs_trans_handle *trans,
>>+			struct alloc_chunk_ctl *ctl,
>>+			struct btrfs_device_info *devices_info)
>>  {
>>  	struct btrfs_fs_info *info = trans->fs_info;
>>-	struct btrfs_fs_devices *fs_devices = info->fs_devices;
>>  	struct map_lookup *map = NULL;
>>  	struct extent_map_tree *em_tree;
>>  	struct extent_map *em;
>>-	struct btrfs_device_info *devices_info = NULL;
>>-	struct alloc_chunk_ctl ctl;
>>+	u64 start = ctl->start;
>>+	u64 type = ctl->type;
>>  	int ret;
>>  	int i;
>>  	int j;
>>-	if (!alloc_profile_is_valid(type, 0)) {
>>-		ASSERT(0);
>>-		return -EINVAL;
>>-	}
>>-
>>-	if (list_empty(&fs_devices->alloc_list)) {
>>-		if (btrfs_test_opt(info, ENOSPC_DEBUG))
>>-			btrfs_debug(info, "%s: no writable device", __func__);
>>-		return -ENOSPC;
>>-	}
>>-
>>-	if (!(type & BTRFS_BLOCK_GROUP_TYPE_MASK)) {
>>-		btrfs_err(info, "invalid chunk type 0x%llx requested", type);
>>-		BUG();
>>-	}
>>-
>>-	ctl.start = start;
>>-	ctl.type = type;
>>-	init_alloc_chunk_ctl(fs_devices, &ctl);
>>-
>>-	devices_info = kcalloc(fs_devices->rw_devices, sizeof(*devices_info),
>>-			       GFP_NOFS);
>>-	if (!devices_info)
>>+	map = kmalloc(map_lookup_size(ctl->num_stripes), GFP_NOFS);
>>+	if (!map)
>>  		return -ENOMEM;
>>+	map->num_stripes = ctl->num_stripes;
>>-	ret = gather_device_info(fs_devices, &ctl, devices_info);
>>-	if (ret < 0)
>>-		goto error;
>>-
>>-	ret = decide_stripe_size(fs_devices, &ctl, devices_info);
>>-	if (ret < 0)
>>-		goto error;
>>-
>>-	map = kmalloc(map_lookup_size(ctl.num_stripes), GFP_NOFS);
>>-	if (!map) {
>>-		ret = -ENOMEM;
>>-		goto error;
>>-	}
>>-
>>-	map->num_stripes = ctl.num_stripes;
>>-
>>-	for (i = 0; i < ctl.ndevs; ++i) {
>>-		for (j = 0; j < ctl.dev_stripes; ++j) {
>>-			int s = i * ctl.dev_stripes + j;
>>+	for (i = 0; i < ctl->ndevs; ++i) {
>>+		for (j = 0; j < ctl->dev_stripes; ++j) {
>>+			int s = i * ctl->dev_stripes + j;
>>  			map->stripes[s].dev = devices_info[i].dev;
>>  			map->stripes[s].physical = devices_info[i].dev_offset +
>>-						   j * ctl.stripe_size;
>>+						   j * ctl->stripe_size;
>>  		}
>>  	}
>>  	map->stripe_len = BTRFS_STRIPE_LEN;
>>  	map->io_align = BTRFS_STRIPE_LEN;
>>  	map->io_width = BTRFS_STRIPE_LEN;
>>  	map->type = type;
>>-	map->sub_stripes = ctl.sub_stripes;
>>+	map->sub_stripes = ctl->sub_stripes;
>>-	trace_btrfs_chunk_alloc(info, map, start, ctl.chunk_size);
>>+	trace_btrfs_chunk_alloc(info, map, start, ctl->chunk_size);
>>  	em = alloc_extent_map();
>>  	if (!em) {
>>  		kfree(map);
>>-		ret = -ENOMEM;
>>-		goto error;
>>+		return -ENOMEM;
>>  	}
>>  	set_bit(EXTENT_FLAG_FS_MAPPING, &em->flags);
>>  	em->map_lookup = map;
>>  	em->start = start;
>>-	em->len = ctl.chunk_size;
>>+	em->len = ctl->chunk_size;
>>  	em->block_start = 0;
>>  	em->block_len = em->len;
>>-	em->orig_block_len = ctl.stripe_size;
>>+	em->orig_block_len = ctl->stripe_size;
>>  	em_tree = &info->mapping_tree;
>>  	write_lock(&em_tree->lock);
>>@@ -5143,11 +5106,11 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
>>  	if (ret) {
>>  		write_unlock(&em_tree->lock);
>>  		free_extent_map(em);
>>-		goto error;
>>+		return ret;
>>  	}
>>  	write_unlock(&em_tree->lock);
>>-	ret = btrfs_make_block_group(trans, 0, type, start, ctl.chunk_size);
>>+	ret = btrfs_make_block_group(trans, 0, type, start, ctl->chunk_size);
>>  	if (ret)
>>  		goto error_del_extent;
>>@@ -5155,20 +5118,19 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
>>  		struct btrfs_device *dev = map->stripes[i].dev;
>>  		btrfs_device_set_bytes_used(dev,
>>-					    dev->bytes_used + ctl.stripe_size);
>>+					    dev->bytes_used + ctl->stripe_size);
>>  		if (list_empty(&dev->post_commit_list))
>>  			list_add_tail(&dev->post_commit_list,
>>  				      &trans->transaction->dev_update_list);
>>  	}
>>-	atomic64_sub(ctl.stripe_size * map->num_stripes,
>>+	atomic64_sub(ctl->stripe_size * map->num_stripes,
>>  		     &info->free_chunk_space);
>>  	free_extent_map(em);
>>  	check_raid56_incompat_flag(info, type);
>>  	check_raid1c34_incompat_flag(info, type);
>>-	kfree(devices_info);
>>  	return 0;
>>  error_del_extent:
>>@@ -5180,7 +5142,55 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
>>  	free_extent_map(em);
>>  	/* One for the tree reference */
>>  	free_extent_map(em);
>>-error:
>>+
>>+	return ret;
>>+}
>>+
>>+static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
>>+			       u64 start, u64 type)
>>+{
>>+	struct btrfs_fs_info *info = trans->fs_info;
>>+	struct btrfs_fs_devices *fs_devices = info->fs_devices;
>>+	struct btrfs_device_info *devices_info = NULL;
>>+	struct alloc_chunk_ctl ctl;
>>+	int ret;
>>+
>>+	if (!alloc_profile_is_valid(type, 0)) {
>>+		ASSERT(0);
>>+		return -EINVAL;
>>+	}
>>+
>>+	if (list_empty(&fs_devices->alloc_list)) {
>>+		if (btrfs_test_opt(info, ENOSPC_DEBUG))
>>+			btrfs_debug(info, "%s: no writable device", __func__);
>>+		return -ENOSPC;
>>+	}
>>+
>>+	if (!(type & BTRFS_BLOCK_GROUP_TYPE_MASK)) {
>>+		btrfs_err(info, "invalid chunk type 0x%llx requested", type);
>>+		BUG();
>>+	}
>
>This is superfluous, alloc_profile_is_valid() handles this check.  Thanks,
>
>Josef

This checks if at least one block group type (data, metadata or
system) flag is set. OTOH, alloc_profile_is_valid() checks if profile
bits are valid.

Maybe, we can move this check into alloc_profile_is_valid()?

Thanks,
