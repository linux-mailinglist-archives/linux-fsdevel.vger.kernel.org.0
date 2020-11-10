Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB3CF2AD3F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 11:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgKJKkR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 05:40:17 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:15418 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgKJKkQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 05:40:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605004816; x=1636540816;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KRik9TsieL0zDHLRaNMjc1xupMtRza0FrrGHU2hwDOw=;
  b=g40rkMdvRXkO5i1jxVhfvho02gYZOBzHlZ2nIlPcCGgcLUYcyPYD6489
   1hWgrtwPUrFv6I19MGz/+ipjqbXc47UFBsWf5hTiZhsg1tPafB5JjiYZh
   KBnLouzMN6g+AVowv53mxiSullkf2ws+Lag5PWV8bih3Pc1n65x0CBCCa
   nfByGItvRpolEJ14xVew4jfc8q26iDK2b3aK7rQWTg8UDOqU9JHuX+CXF
   FrGWtQPrHEVC0qMWHTeRAJys/QABlLbslaLCLYyIWAXGyqywC9uU2iwEy
   BiOFaMTPr8kgu67MyGvZxK4c7P08lvEwfK2x9fnEw/4JBtNSTtywzys36
   Q==;
IronPort-SDR: Ft9YUrxMdD8Hg/0KfWDRZMgie0czFJrHabfLoI1gRxHupkj1rDu8E8LQjDB6R4tanByWDdKQll
 xlKvPNNWt8C1P91l/xaUR2vHN0KUYvRkUQJ3eSXLoPTxd9WSyH4C/BSY2V3tRTnms5J7vQ5d/j
 hej6n9jIgMaBpzEmkbp9JqeQNummekXmVc+HfYh9KG7xrM+Eg7rxOLG+444CUeDwq4vM4kigQB
 xGAvZmimf7582wIwQkyNR0BUWJxpZR+ZqVrtXFmRZk05iS/vBy2Y1o3sFoBz14w3qu5c7iD2YT
 N+Q=
X-IronPort-AV: E=Sophos;i="5.77,466,1596470400"; 
   d="scan'208";a="156751859"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 18:40:15 +0800
IronPort-SDR: WxTC52HafalDt47lf038ddcoexQHCfAkdO2ysqIsLRXIgcjd41/j7XMdOQq0j908Xl9khr/i85
 sEAEiMfcOpAKySe7T04qokZL6mjRAWpHobE/Ci/aMbO/D9i3qH3TNalFs0GClfhWrPW9Ydg83K
 eK4lK6XdE2cm1ZecxqtRBRrE5dj9LCK4aoHkYUJahiqSWDIpVGWpQpG1MeU+BEhIxcuFqUM25T
 f3Y9TqelzbvL3CFikeXDP+5c3agLSXlFuVOZs0NRMB20lWTXermUKVFSM8sEMJeB93v/cV7S2H
 ZBVK2uWIvD+2kGkLPFG4htYV
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 02:25:03 -0800
IronPort-SDR: bcGFf9FANijL4lj1Z3oz7PNuCMo9pEgDqsx0FzAjg1ZuuPFSdH47vE5mM+hAj0QlTvseADAbDE
 MAb7WR8pNwKQTdtg/no+0we+USGjkiEYCGePabnwfU7A/GgKuTSrW+oqC1mRRI6jM3WeIdVDAu
 ThyhMLaVOTlLoaBLNkXJ3TmNYMdMwOuyS9GVWsgAD3xqIlY97ZjzTKGYLrjyOx+nzQB//aiywf
 DCkWMlju0KPQ/NDkvSjRP+8QDAydi1hutuPli7bvfkTqQbYmQU0yivNzCWwPVefda9BfbDO3rW
 DAQ=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with SMTP; 10 Nov 2020 02:40:13 -0800
Received: (nullmailer pid 1896666 invoked by uid 1000);
        Tue, 10 Nov 2020 10:40:14 -0000
Date:   Tue, 10 Nov 2020 19:40:14 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v9 18/41] btrfs: reset zones of unused block groups
Message-ID: <20201110104014.drw776gqibt4sqn3@naota.dhcp.fujisawa.hgst.com>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
 <575e495d534c44aded9e6ae042a9d6bda5c84162.1604065695.git.naohiro.aota@wdc.com>
 <7b48d9f1-53d8-2526-e628-13331e4fe344@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <7b48d9f1-53d8-2526-e628-13331e4fe344@toxicpanda.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 03, 2020 at 09:34:19AM -0500, Josef Bacik wrote:
>On 10/30/20 9:51 AM, Naohiro Aota wrote:
>>For an ZONED volume, a block group maps to a zone of the device. For
>>deleted unused block groups, the zone of the block group can be reset to
>>rewind the zone write pointer at the start of the zone.
>>
>>Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>>---
>>  fs/btrfs/block-group.c |  8 ++++++--
>>  fs/btrfs/extent-tree.c | 17 ++++++++++++-----
>>  fs/btrfs/zoned.h       | 16 ++++++++++++++++
>>  3 files changed, 34 insertions(+), 7 deletions(-)
>>
>>diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
>>index d67f9cabe5c1..82d556368c85 100644
>>--- a/fs/btrfs/block-group.c
>>+++ b/fs/btrfs/block-group.c
>>@@ -1468,8 +1468,12 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
>>  		if (!async_trim_enabled && btrfs_test_opt(fs_info, DISCARD_ASYNC))
>>  			goto flip_async;
>>-		/* DISCARD can flip during remount */
>>-		trimming = btrfs_test_opt(fs_info, DISCARD_SYNC);
>>+		/*
>>+		 * DISCARD can flip during remount. In ZONED mode, we need
>>+		 * to reset sequential required zones.
>>+		 */
>>+		trimming = btrfs_test_opt(fs_info, DISCARD_SYNC) ||
>>+				btrfs_is_zoned(fs_info);
>>  		/* Implicit trim during transaction commit. */
>>  		if (trimming)
>>diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
>>index 5e6b4d1712f2..c134746d7417 100644
>>--- a/fs/btrfs/extent-tree.c
>>+++ b/fs/btrfs/extent-tree.c
>>@@ -1331,6 +1331,9 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
>>  		stripe = bbio->stripes;
>>  		for (i = 0; i < bbio->num_stripes; i++, stripe++) {
>>+			struct btrfs_device *dev = stripe->dev;
>>+			u64 physical = stripe->physical;
>>+			u64 length = stripe->length;
>>  			u64 bytes;
>>  			struct request_queue *req_q;
>>@@ -1338,14 +1341,18 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
>>  				ASSERT(btrfs_test_opt(fs_info, DEGRADED));
>>  				continue;
>>  			}
>>+
>>  			req_q = bdev_get_queue(stripe->dev->bdev);
>>-			if (!blk_queue_discard(req_q))
>>+			/* zone reset in ZONED mode */
>>+			if (btrfs_can_zone_reset(dev, physical, length))
>>+				ret = btrfs_reset_device_zone(dev, physical,
>>+							      length, &bytes);
>>+			else if (blk_queue_discard(req_q))
>>+				ret = btrfs_issue_discard(dev->bdev, physical,
>>+							  length, &bytes);
>>+			else
>>  				continue;
>>-			ret = btrfs_issue_discard(stripe->dev->bdev,
>>-						  stripe->physical,
>>-						  stripe->length,
>>-						  &bytes);
>
>The problem is you have
>
>if (btrfs_test_opt(fs_info, DISCARD_SYNC))
>	ret = btrfs_discard_extent(fs_info, start,
>				   end + 1 - start, NULL);
>
>in btrfs_finish_extent_commit, so even if you add support here, you 
>aren't actually discarding anything because the transaction commit 
>won't call discard for this range.

btrfs_discard_extent() is called for each deleted_bg on the BG area,
regardless of the above pinned_extent's range.

>
>You're going to have to rework this logic to allow for discard to be 
>called everywhere it checks DISCARD_SYNC, but then you also need to go 
>and make sure you don't actually allow discards to happen at non-bg 
>aligned ranges.  Thanks,
>
>Josef

We already ignore btrfs_discard_extent() which is not aligned to zone. So,
I confirmed it worked fine with DISCARD_SYNC.

