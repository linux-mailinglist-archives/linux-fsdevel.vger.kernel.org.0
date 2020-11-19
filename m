Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A382B9CFC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Nov 2020 22:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgKSVdQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Nov 2020 16:33:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:49644 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbgKSVdQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Nov 2020 16:33:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 05156AD4A;
        Thu, 19 Nov 2020 21:33:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7F3E2DA701; Thu, 19 Nov 2020 22:31:27 +0100 (CET)
Date:   Thu, 19 Nov 2020 22:31:27 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Anand Jain <anand.jain@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v10 03/41] btrfs: introduce ZONED feature flag
Message-ID: <20201119213127.GS20563@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Anand Jain <anand.jain@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
 <5abeb08ecb3fe5776b359d318641ef5078467070.1605007036.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5abeb08ecb3fe5776b359d318641ef5078467070.1605007036.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 10, 2020 at 08:26:06PM +0900, Naohiro Aota wrote:
> This patch introduces the ZONED incompat flag. The flag indicates that the
> volume management will satisfy the constraints imposed by host-managed
> zoned block devices.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> Reviewed-by: Anand Jain <anand.jain@oracle.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/sysfs.c           | 2 ++
>  include/uapi/linux/btrfs.h | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 279d9262b676..828006020bbd 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -263,6 +263,7 @@ BTRFS_FEAT_ATTR_INCOMPAT(no_holes, NO_HOLES);
>  BTRFS_FEAT_ATTR_INCOMPAT(metadata_uuid, METADATA_UUID);
>  BTRFS_FEAT_ATTR_COMPAT_RO(free_space_tree, FREE_SPACE_TREE);
>  BTRFS_FEAT_ATTR_INCOMPAT(raid1c34, RAID1C34);
> +BTRFS_FEAT_ATTR_INCOMPAT(zoned, ZONED);

> +	BTRFS_FEAT_ATTR_PTR(zoned),

As we're going to add zoned support incrementally, we can't advertise
the support in sysfs until it's feature complete. Until then it's going
to be under CONFIG_BTRFS_DEBUG. This has been folded to this patch and
changelog updated.
