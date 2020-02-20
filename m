Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1476165AAB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 10:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgBTJ56 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 04:57:58 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:16938 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbgBTJ55 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 04:57:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582192678; x=1613728678;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R7COHsEbPJkbvNsFM3SeZ26n111RwKe8QQdalKWtIIQ=;
  b=QQNPOfaUHlqxZ7p0mnQwpFoIq+b/BEdU6Ye3jszxzNP8VokyVvGIF2qp
   F+Ik18N8BOmOimLpPJJpZVOGi69l+OI5A+4Vww6ae/dKcNa4kR0+ubkRw
   BvMgvhL5m5Bk6MMeKs74jAIJdhJgLHhJRmoPKSu1BgUBXJ79vFSLdBeD/
   PX6e9k4U15DOFT7mI9eViG2/sYT3bLay1G5sZY8PFUaM5SmQZm/64F1h9
   2t62YVu9L4yt9WGR08jxWkczHqR8HZT6NVk5m7ijACeU/IdRIbhd1cKz3
   Z4MaboAF5BmtAf+Yox+tGcwWMVp8DRyc0CcphxL2+hLJPr0XUkRQTl1Fx
   w==;
IronPort-SDR: NGhsRiMfgf2laecjkoMviPlgXmynXidPEalZc0puwXj/8avd6lm3gaKlTYh1ZikdOEXhPTNzos
 EVxRujqsTYHfOniQj/tfyLrwWLCtR7LRD61iJjjHUGgvPlMA8c1qjb1ymN4SmU8X16dSU7BaCI
 aNSv1aZ9nWWAU5wy6+ShlUKpMh2jZaUd8QERmfDkgyCP1P2I1X+4XNfZ2qYgWfKlfB2+36CZWX
 zShosAAd/EAOsOuHnLO3hZDK0zltBlUgalZEzAnT1IWFVHnDOz1nW6chDXuokkXdHLzB9kSOFp
 Ulc=
X-IronPort-AV: E=Sophos;i="5.70,464,1574092800"; 
   d="scan'208";a="134633033"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Feb 2020 17:57:57 +0800
IronPort-SDR: 8dbBxfxXKMUnbGxiL2xb1bHe3AAeUpCwRLzFxhT1/Wu2reGCRmJ6DtXsIV3X4wFyk2GFoYUD7z
 0OK1ujJybyJ2n4lXxSpaVD/nSI1hgfCdMNOELF8BbJ0MuyTwW9KZOmO08rzJAaffvou/vVmc0T
 28O8g78shq8cJMQ604897wUwCg5T5zg2LEAJyL+c8swdop5nYtj/HCZHyYeex7+A47hYNG9Bch
 T8dl3M2St0/zqX+SISccQ8y1zeYx692J7gz4qgNaY6xUX5MyfOWzXww5ck/gDPVxbwZvdi9sGZ
 yUXTdeBmbvZLOLfJUMFb8Ilj
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 01:50:32 -0800
IronPort-SDR: koV8Y9059vMDCSAALLU/czC8TXRVPKC7u+wO40ETCS0ioHVT+S47uOX5VYjOXesTEOHZxHGHlN
 ooznRaNScMqqfkDOntiIUu2SP0ZUVrPqefwN5DYFkotSdMuxcN5laQLm2+qAH5uUtEKBTZ/OFc
 +FIw2TzPtPhg19cC9m7KCC2LqMKM3fhmeXcy8Lul9wbbnLQPSP43Y9SHkntLwNS1zo9KVAMRjA
 2YUkxgVWSoDG1zvfXBuaY7+aOWVRKkCqcbnfyjmzzgwCXaFXJr3uAQVwP1AYPeN/H9cG1lIXYg
 w50=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with SMTP; 20 Feb 2020 01:57:54 -0800
Received: (nullmailer pid 2494832 invoked by uid 1000);
        Thu, 20 Feb 2020 09:57:54 -0000
Date:   Thu, 20 Feb 2020 18:57:54 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 19/21] btrfs: factor out chunk_allocation_failed()
Message-ID: <20200220095754.hqdqlnuueea2nny6@naota.dhcp.fujisawa.hgst.com>
References: <20200212072048.629856-1-naohiro.aota@wdc.com>
 <20200212072048.629856-20-naohiro.aota@wdc.com>
 <b9579637-fb57-6b02-48fa-46878136cf8c@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <b9579637-fb57-6b02-48fa-46878136cf8c@toxicpanda.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 13, 2020 at 02:52:08PM -0500, Josef Bacik wrote:
>On 2/12/20 2:20 AM, Naohiro Aota wrote:
>>Factor out chunk_allocation_failed() from find_free_extent_update_loop().
>>This function is called when it failed to allocate a chunk. The function
>>can modify "ffe_ctl->loop" and return 0 to continue with the next stage.
>>Or, it can return -ENOSPC to give up here.
>>
>>Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>>---
>>  fs/btrfs/extent-tree.c | 24 ++++++++++++++++--------
>>  1 file changed, 16 insertions(+), 8 deletions(-)
>>
>>diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
>>index efc653e6be29..8f0d489f76fa 100644
>>--- a/fs/btrfs/extent-tree.c
>>+++ b/fs/btrfs/extent-tree.c
>>@@ -3748,6 +3748,21 @@ static void found_extent(struct find_free_extent_ctl *ffe_ctl,
>>  	}
>>  }
>>+static int chunk_allocation_failed(struct find_free_extent_ctl *ffe_ctl)
>>+{
>>+	switch (ffe_ctl->policy) {
>>+	case BTRFS_EXTENT_ALLOC_CLUSTERED:
>>+		/*
>>+		 * If we can't allocate a new chunk we've already looped through
>>+		 * at least once, move on to the NO_EMPTY_SIZE case.
>>+		 */
>>+		ffe_ctl->loop = LOOP_NO_EMPTY_SIZE;
>>+		return 0;
>>+	default:
>>+		BUG();
>>+	}
>>+}
>>+
>>  /*
>>   * Return >0 means caller needs to re-search for free extent
>>   * Return 0 means we have the needed free extent.
>>@@ -3819,19 +3834,12 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
>>  			ret = btrfs_chunk_alloc(trans, ffe_ctl->flags,
>>  						CHUNK_ALLOC_FORCE);
>>-			/*
>>-			 * If we can't allocate a new chunk we've already looped
>>-			 * through at least once, move on to the NO_EMPTY_SIZE
>>-			 * case.
>>-			 */
>>  			if (ret == -ENOSPC)
>>-				ffe_ctl->loop = LOOP_NO_EMPTY_SIZE;
>>+				ret = chunk_allocation_failed(ffe_ctl);
>>  			/* Do not bail out on ENOSPC since we can do more. */
>>  			if (ret < 0 && ret != -ENOSPC)
>>  				btrfs_abort_transaction(trans, ret);
>>-			else
>>-				ret = 0;
>
>You can't delete this, btrfs_chunk_alloc() will return 1 if it 
>succeeded, and we'll leak that out somewhere and bad things will 
>happen.  Thanks,
>
>Josef

Ah, I missed that case... I'll fix in the next series.

Thanks,
