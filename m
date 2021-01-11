Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3A52F1FBF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 20:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403775AbhAKTsK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 14:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391128AbhAKTsK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:48:10 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2D4C061794
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Jan 2021 11:47:29 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id c7so648982qke.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Jan 2021 11:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5lBtEYiIuyDpkn580so2o0MKfXnt8d1SY83rV91WVek=;
        b=gaB8QJuAv3JjaKbID8UYwJa5ALw573Ic8rHebFTnp0HrTbYcxTzhBtp3ckQiWMSck+
         gWPP1F4qnguqf19IJAhxDFpgUjuhrvk5wINAfIlPqEwYyLwUCNwyjQYttOqXkHWTHKIB
         SPBb9QsrxYjSGSnrd/7gfStEP+dHjHrD4gNeb0VTTXscjCjmhF8jzaY1jXKvUM+/pcAm
         BKa4NqRpgXy5UuJATpdkN3uAD2hkEpYNJt9spU9f2zuxNNL2LXxG5EaLokerFaPBkRZG
         yVIYymmMN9RISeRAVFRMMcYsbbH1s4HivkLkP3UtVeKqWmrgGLiMeRllmeqUVjl/qniT
         FTbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5lBtEYiIuyDpkn580so2o0MKfXnt8d1SY83rV91WVek=;
        b=HklcHNAc4StD0f6XpakWA5eIFRmdCm15SPGhPLXytgymYcSfTCVcAvf4eGOi2hma1P
         TjDm0LNu2cA50mG2YLRtrtlVSQFnctCfpE0tDFeTdEfe8daoiXnrwWraeFzhhcDj0E8o
         RA/Bwn5R8SC7E4ujUItYShUO/nLLri4dQomMjrNJRmGbxR6717125UFpwNXZHdZ/0U/H
         96VcgS/vFgf4HbDzZObx9krzrHSHTF3XL1PkB4QlAZ4PGucNFNR4h9SI1qxsAU7bg1V+
         KKoIjrL7UT0VtXP5d3he6nUN+UIgkWriAjZTXSjpv/39MgUTAukGcnipXLWIX95f+V2k
         pVdA==
X-Gm-Message-State: AOAM533nNR2LuwVTWbMmCodgWx2IYyQkYBkkeyUQZPAy8nV6rl3GzqCB
        5sYly5KPijFeHIunAWVuoBfxIw==
X-Google-Smtp-Source: ABdhPJw5pHYCaxPhuLsOv0uhHXJGsVmGF8y+ND8jYZNHwVB+NwjjNhkvlDHKgVUpYq1aO2YMloX8bw==
X-Received: by 2002:ae9:d801:: with SMTP id u1mr949350qkf.79.1610394448719;
        Mon, 11 Jan 2021 11:47:28 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d25sm426544qkl.97.2021.01.11.11.47.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 11:47:27 -0800 (PST)
Subject: Re: [PATCH v11 04/40] btrfs: change superblock location on
 conventional zone
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
 <42c1712556e6865837151ad58252fb5f6ecff8f7.1608608848.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <83c5e084-dbee-a0ae-4a1b-38fa271701a2@toxicpanda.com>
Date:   Mon, 11 Jan 2021 14:47:26 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <42c1712556e6865837151ad58252fb5f6ecff8f7.1608608848.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/21/20 10:48 PM, Naohiro Aota wrote:
> We cannot use log-structured superblock writing in conventional zones since
> there is no write pointer to determine the last written superblock
> position. So, we write a superblock at a static location in a conventional
> zone.
> 
> The written position is at the beginning of a zone, which is different from
> an SB position of regular btrfs. This difference causes a "chicken-and-egg
> problem" when supporting zoned emulation on a regular device. To know if
> btrfs is (emulated) zoned btrfs, we need to load an SB and check the
> feature flag. However, to load an SB, we need to know that it is zoned
> btrfs to load it from a different position.
> 
> This patch moves the SB location on conventional zones so that the first SB
> location will be the same as regular btrfs.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>   fs/btrfs/zoned.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 90b8d1d5369f..e5619c8bcebb 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -465,7 +465,8 @@ static int sb_log_location(struct block_device *bdev, struct blk_zone *zones,
>   	int ret;
>   
>   	if (zones[0].type == BLK_ZONE_TYPE_CONVENTIONAL) {
> -		*bytenr_ret = zones[0].start << SECTOR_SHIFT;
> +		*bytenr_ret = (zones[0].start << SECTOR_SHIFT) +
> +			btrfs_sb_offset(0);
>   		return 0;
>   	}
>   

I'm confused, we call btrfs_sb_log_location_bdev(), which does

         if (!bdev_is_zoned(bdev)) {
                 *bytenr_ret = btrfs_sb_offset(mirror);
                 return 0;
         }

so how does the emulation work, if we short circuit this if the block device 
isn't zoned?  And then why does it matter where in the conventional zone that we 
put the super block?  Can't we just emulate a conventional zone that starts at 
offset 0, and then the btrfs_sb_offset() will be the same as zones[0].start + 
btrfs_sb_offset(0)?  Thanks,

Josef
