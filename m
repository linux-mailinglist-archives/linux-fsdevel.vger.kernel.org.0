Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8E4615A1AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 08:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbgBLHU4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 02:20:56 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:31626 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728234AbgBLHU4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 02:20:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581492099; x=1613028099;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IT7FA9ji/SmSNpqNLKBz7saQuq/9BPl6QOaLXZJYA3s=;
  b=feEjUqfT6NPNxqla81Rxtv7FRQyWffW96WB1iUvqd9m9Kw5c27F8aKE+
   pVfeq1EMYjJoorYOp19DeSbLGCIxdYuF6xjRUT1H5DTfCqR/Es96LnuAy
   wICBTgt9SUDddDeaX5NDreo3jM166EtqviDmntbsyeR5XQkz6U9sWtLmk
   +U9mxE9awuZGG2AkpS26oleNRWieiZvNJT0Zg+CNo2/aVgdF94XnM9bw3
   Cz++/Xz1KTRqie1Ym8hdjU49Q/syfpSCflw3Js5UgtMK6quzzXo/dxnxy
   JRe7/WEIhPYTBp4WULdjvdlrQOR/xE+BCgydEHpbcJz8M7SBOVvDhVjO6
   Q==;
IronPort-SDR: L9iHCVfY2wBkQLkMnxlZinTaV5yv5rw9s0VPEw841WcXZpIdfOaaKrQ1sCvxf3yJQZN44gYBFM
 IHUFLkd6V2f1siTqVfwtkAS71FswyweCJivBRAWS33lr3qAe/qo4BiEbW1sXWEmUNdjP0XFvGN
 Uk70RfOeGk8QJtuXBJi938FpFGFEfNokSUjXNRcOaPgA5zHySrfhxCh6Z9R7ZLNKGoIzpH1zPY
 RGHpF1mFoMRTqyOXHhoXSXgRmpxrcTDV0R8LmAO1fUv+okrlkeplQKMWnBTIi1rDkHbg0u12Br
 YyQ=
X-IronPort-AV: E=Sophos;i="5.70,428,1574092800"; 
   d="scan'208";a="231448887"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2020 15:21:39 +0800
IronPort-SDR: d9i4lFQEpHOF3AeN4YkeNBBhdzz/u1yMeh7UI88axrHLfwKwrRJ6yVcA8EjFzSrld3of9IEqHN
 rMpPFXX4l8JOJ1/O3oB5HbOyyLXLWFoP0bb0WTl9ZfmmvkRgHYQbFOOunfA+ijEA+z2c3Yr17E
 a9IcFA/mXo2f6Uhn5FNTvHgCAKCHMP+urbY9bankllscpd+Hy62uLsz+M23yIAI/PU3PRUDO1e
 cuP5HVL0gaK2eQ6JUKnpBu88ff0utk3nuJUHgJsmIij6Myfj5KPYLqxXAUndHeZNOz/g/g555b
 nXqKdw6CKrQy01CkCn6RaLo8
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 23:13:45 -0800
IronPort-SDR: U3JT+P1urQRiejHXY4Zgb22LAz0q3/OsdbslY40i2FHRSXsnmwAthMbZBlEHu24RuVzxd8F1RL
 06ha44Zw5vXBVjpca5Ab+D2QdIv76sDvPHA+SlBtWXSGdfYeQ5v7HGEVuA/mUEK9DhqKfcfMQE
 PJzP+2wZcaveVBILjZXmZwtYHdZpAY0Et8RZLDI+9wEEQy6lVIxihakqLX4UJDAGVAtgRywQ3J
 bHMHpDQ2lkEVg2N66vtuELAebZryUU/QsUU/fPiIKZKOGV320wpqC4VRTFm/ubz0G6dss/v5h2
 Aeo=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Feb 2020 23:20:54 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 00/21] btrfs: refactor and generalize chunk/dev_extent/extent allocation
Date:   Wed, 12 Feb 2020 16:20:27 +0900
Message-Id: <20200212072048.629856-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series refactors chunk allocation, device_extent allocation and
extent allocation functions and make them generalized to be able to
implement other allocation policy easily.

On top of this series, we can simplify some part of the "btrfs: zoned
block device support" series as adding a new type of chunk allocator
and extent allocator for zoned block devices. Furthermore, we will be
able to implement and test some other allocator in the idea page of
the wiki e.g. SSD caching, dedicated metadata drive, chunk allocation
groups, and so on.

This series has no functional changes except introducing "enum
btrfs_chunk_allocation_policy" and "enum
btrfs_extent_allocation_policy".

* Refactoring chunk/dev_extent allocator

Two functions are separated from find_free_dev_extent_start().
dev_extent_search_start() decides the starting position of the search.
dev_extent_hole_check() checks if a hole found is suitable for device
extent allocation.

__btrfs_alloc_chunk() is split into four functions. set_parameters()
initializes the parameters of an allocation. gather_device_info()
loops over devices and gather information of
them. decide_stripe_size() decides the size of chunk and
device_extent. And, create_chunk() creates a chunk and device extents.

* Refactoring extent allocator

Three functions are introduced in
find_free_extent(). prepare_allocation() initializes the parameters
and gives a hint byte to start the allocation with. do_allocation()
handles the actual allocation in a given block group.
release_block_group() is called when it gives up an allocation from a
block group, so the allocation context should be reset.

Two functions are introduced in find_free_extent_update_loop().
found_extent() is called when the allocator finally find a proper
extent. chunk_allocation_failed() is called when it failed to allocate
a new chunk. An allocator implementation can use this hook to set the
next stage to try e.g. LOOP_NO_EMPTY_SIZE.

Furthermore, LOOP_NO_EMPTY_SIZE stage is tweaked so that other
allocator than the current clustered allocator skips this stage.

* Patch organization

Patch 1 is a trivial patch to fix the type of an argument of
find_free_extent_update_loop().

Patch 2 removes a BUG_ON from __btrfs_alloc_chunk().

Patches 3-10 refactors chunk and device_extent allocation functions:
find_free_dev_extent_start() and __btrfs_alloc_chunk().

Patches 11-21 refactors extent allocation function: find_free_extent()
and find_free_extent_update_loop().

* Changelog

 - v2
   - Stop separating "clustered_alloc_info" from find_free_extent_ctl
   - Change return type of dev_extent_hole_check() to bool
   - Rename set_parameters() to init_alloc_chunk_ctl()
   - Add a patch to remove BUG_ON from __btrfs_alloc_chunk()

Naohiro Aota (21):
  btrfs: change type of full_search to bool
  btrfs: do not BUG_ON with invalid profile
  btrfs: introduce chunk allocation policy
  btrfs: refactor find_free_dev_extent_start()
  btrfs: introduce alloc_chunk_ctl
  btrfs: factor out init_alloc_chunk_ctl
  btrfs: factor out gather_device_info()
  btrfs: factor out decide_stripe_size()
  btrfs: factor out create_chunk()
  btrfs: parameterize dev_extent_min
  btrfs: introduce extent allocation policy
  btrfs: move hint_byte into find_free_extent_ctl
  btrfs: move vairalbes for clustered allocation into
    find_free_extent_ctl
  btrfs: factor out do_allocation()
  btrfs: drop unnecessary arguments from clustered allocation functions
  btrfs: factor out release_block_group()
  btrfs: factor out found_extent()
  btrfs: drop unnecessary arguments from find_free_extent_update_loop()
  btrfs: factor out chunk_allocation_failed()
  btrfs: skip LOOP_NO_EMPTY_SIZE if not clustered allocation
  btrfs: factor out prepare_allocation()

 fs/btrfs/extent-tree.c | 313 +++++++++++++++++++++-----------
 fs/btrfs/volumes.c     | 398 +++++++++++++++++++++++++++--------------
 fs/btrfs/volumes.h     |   6 +
 3 files changed, 481 insertions(+), 236 deletions(-)

-- 
2.25.0

