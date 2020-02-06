Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D10E715420F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 11:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbgBFKoR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 05:44:17 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:50006 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728119AbgBFKoR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 05:44:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580985856; x=1612521856;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UCcQ4uA331GaOTcJI6RHwX1lMm/fbi7IbyqUvEl31lg=;
  b=FZSSuvG5cLis8j3snUAE4KGSqqKfQvENB6FdHZq6ZSeoK7RfpKma40bW
   m2hYaVq/xHqzjsKx+mlo+Tx40REHT0gZveh+RcsUB5twr6Smwt6G/UerH
   0a7EXQe8gn/xpyYIDsICOCqBh/0tGbJw0V/s6ok8Fsl4+ahMUh5W4O6yZ
   rOXvRPQLw2ZNjcJ+VTwNTQP3Wnk+uBBsZR1dFu+Cg47hTZnpsw7mCN7O9
   dW52slPGpqz1jjx3VrHZJMs4uV6MMsa25VGcoGRXHcFvuSdyuIGgi/eAL
   7lhq5VAUJS42NFfIAefi3orFMt/FhomoK+G8W3dwLPy+KczPxXutI0JQ0
   g==;
IronPort-SDR: 0j0uNXClz5Mc4/uRhq0t6Jcqn5uTlhZT473dRmEs80Xc/l8t0sM3Bq5XCloCl91cc6wBv3xdw6
 nUNGcyWJ5nBxnOEIT/qy9pHXYc32N/PQ/OSuQotM9381qmWZRoFYwFT4dItdM1ClJg+fUwUlf+
 3lF5LXEYQ5QmfIJf2sgaDYv879rV5r4eDH3LeswN6Hx+jL3JZz2fl6GKBcBh+GdqkEZBWqnBjO
 gSnTysB4/tVdgF0Cz/6QRmZHsySQhaimCJWFNKLWE684QOiWjhJ9QBRf1R6AxAv4o5L7ymKTMV
 hGQ=
X-IronPort-AV: E=Sophos;i="5.70,409,1574092800"; 
   d="scan'208";a="237209474"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2020 18:44:16 +0800
IronPort-SDR: WK4F+qTz8UpeCtCO3IjK0kacjGddMaehhon6t0cnIdteku+oVHzeVWyGtwZff6EE4pg7FBznPz
 hrPHamnVNmOWmzwWMlV9strjATJQGsvUIr/x+n0t8xhSCftCaM6RGylh7EyeD4hw4oV8t+VpJV
 M/0nepuny5YDMQWNe5WMvwUaZ0tTt9NLl9QF8/yW0xwywMoowS0Jql2DkQ70XuW908yolAfEGi
 bMRmYXBPDv22Y3UUf5+2lbMST8xP3ePSFRVkKKPC+nwckyQxsMiS/u6MC+Tk+w+ybMKbJzcMnb
 EMrbTT76pskUgAcFvNNyFW7A
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 02:37:16 -0800
IronPort-SDR: +1EK7c8e+rq7zQDC8LFjCcU+WOGynWvTHnYuHd2aNDb2nFIM8JU4OdljkQdegQj1+EFCZIbnxd
 3EBPLL9D5/AAU76BvmJ9VmXKKx9KZR48r/3kokT1rFJ0J0xxcJUUm3rVZ/gEfRRaBCmpeuYP7B
 /H6w5/DRz5Mceeh3x7sAM8O02WWBci8Y7JD60C2N/NB6A8FuONWoIQ8GWdBaMq7DWNkNjESV6j
 S+daNnO2Zw/pmyMbMwSuCEM4LffrkEdsh/foYjHYgBv2w4dWuWZEvCQx/m73yH1KUW5uAxt3c7
 AKc=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Feb 2020 02:44:14 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 00/20] btrfs: refactor and generalize chunk/dev_extent/extent allocation
Date:   Thu,  6 Feb 2020 19:41:54 +0900
Message-Id: <20200206104214.400857-1-naohiro.aota@wdc.com>
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

Patches 2-9 refactors chunk and device_extent allocation functions:
find_free_dev_extent_start() and __btrfs_alloc_chunk().

Patches 10-20 refactors extent allocation function: find_free_extent()
and find_free_extent_update_loop().

Naohiro Aota (20):
  btrfs: change type of full_search to bool
  btrfs: introduce chunk allocation policy
  btrfs: refactor find_free_dev_extent_start()
  btrfs: introduce alloc_chunk_ctl
  btrfs: factor out set_parameters()
  btrfs: factor out gather_device_info()
  btrfs: factor out decide_stripe_size()
  btrfs: factor out create_chunk()
  btrfs: parameterize dev_extent_min
  btrfs: introduce extent allocation policy
  btrfs: move hint_byte into find_free_extent_ctl
  btrfs: introduce clustered_alloc_info
  btrfs: factor out do_allocation()
  btrfs: drop unnecessary arguments from clustered allocation functions
  btrfs: factor out release_block_group()
  btrfs: factor out found_extent()
  btrfs: drop unnecessary arguments from find_free_extent_update_loop()
  btrfs: factor out chunk_allocation_failed()
  btrfs: add assertion on LOOP_NO_EMPTY_SIZE stage
  btrfs: factor out prepare_allocation()

 fs/btrfs/extent-tree.c | 378 ++++++++++++++++++++++++++-------------
 fs/btrfs/volumes.c     | 397 +++++++++++++++++++++++++++--------------
 fs/btrfs/volumes.h     |   6 +
 3 files changed, 525 insertions(+), 256 deletions(-)

-- 
2.25.0

