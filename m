Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0BB51279F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Apr 2022 01:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbiD0Xmu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 19:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbiD0Xmq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 19:42:46 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6295F266
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Apr 2022 16:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651102774; x=1682638774;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MKuYv4XGK8HdnYkTj9llLnq6WFfSVxaVrJlMmCv+wiQ=;
  b=oTb2Up8MEGpiX1c3vfH+BVJRPb6lY5/nH/bsFjHJ/zGQ1NSAKtVxUJxY
   zDcYOmNZ7gAV7Y+AhJcBE19Zr110aE1v2yj1ayKYCpiCnnYudFrcgmwwm
   zNtoiogB6z57998xhiFBMB8i/GLB57dYhQn+eW2ruLJ7gR1emM9VFfm3w
   URv5Dtd0hoB5Lmf7t25+Pe2aNmzJO/LKw0snL6MlwstMDCLfyotpaykFD
   J1C8qcvOu22hOkK+pIsHmb9Wu5y5QA12CT3/eU7etI8+mrb1WdTmE2DzD
   Lju7mb2vBJFyVdaU1MeRRypK/eMCzMDaL/7o4+xeCCIUbfFPcjXHeRelg
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,294,1643644800"; 
   d="scan'208";a="199893625"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2022 07:39:33 +0800
IronPort-SDR: h6QGS8sANiYXpDUPPxIf71XiGIto9Sm/0/7TZZngHX6ugkqkFDowpn02fHJKwJ5KBc0fbOybSr
 FyuJ18C9uy9MPWYgTJ5xo/LiVyF720LDhFMMO3WCrhfY0ZOuult4PSuPQ1a8Sxh2PkacReFnyp
 p8MEb4iUc9o7n33grK6smhjQ20PYSyfij/tjc9WrnHFAv7+MnqGfCDGMw+hL0OTkrDDh+gLpfY
 Z8FINg0ewUBsQnIUG1LECzqcPpvtEpYtqnkoh1Na4rogpzFnxrXHe/PkYjbQEtk9XYCh8s5U1i
 lWBhembe+MAStKOPncdFqN7x
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Apr 2022 16:10:24 -0700
IronPort-SDR: GUDhr/s+/FOlctbnZ0VvbiCDHurwKb3WFPUzcsXbPMmELMwf9UYZvyF1FgJy8qhUKxkTIsQwOf
 yH+rzV1heH7KuR22lRj3PXaBNuflZQDzUF4ZjJGl8goybIECiwC6oYeKbonlFVvsxbLfxW9V9N
 Fr1u8Qhk+bfEn3g9a9182tVrw7RqJCkvifj8TtEi1QhZ0NAaO8nw2E+eg1gk5SohkKa8GTdV+k
 JE72r/9YSAGWqVqGgiEQGWczzi8XjL2DcY9Sz1XiO7ToaB/Ntq8dWyUMbfEMc2XGJiZ5SVNDYr
 qqE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Apr 2022 16:39:33 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KpZwM6Hy5z1SVnx
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Apr 2022 16:39:31 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1651102770; x=1653694771; bh=MKuYv4XGK8HdnYkTj9llLnq6WFfSVxaVrJl
        MmCv+wiQ=; b=F5aK313D/33i58L2HhyWZlmIYLxYFRau6pifLJL1hYJrhXiCZ8a
        QUlDThdd2S3jmMYxAnQGrk3uOInkmqWWXkmRW3ymLN1LfKOS5+bY79RzMlQL1w3p
        byr+W7KlfQmvdAdTOFjqy4Bvd6pxExnVEQWWyxoWm8P74hjVHX/Vm9LlwbazeVIZ
        wJ7tVTr0brCKfrteamJp89kRredPxEKv83eWrlHtbe+v5l92MU36wBYsIEFDv/Kv
        dXViO7aRNsJw2ghY9ipJqj+m8Fo9xYv4zTR8q40gyecTBz59xhum1EvNku7fAoNM
        dMuWLLgJcGyyRSZREN2s2w7PK2MFxbc5f1g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id B5BEF02IUIa7 for <linux-fsdevel@vger.kernel.org>;
        Wed, 27 Apr 2022 16:39:30 -0700 (PDT)
Received: from [10.225.163.27] (unknown [10.225.163.27])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KpZwF5hMDz1Rvlc;
        Wed, 27 Apr 2022 16:39:25 -0700 (PDT)
Message-ID: <bfc1ddc3-5db3-6879-b6ab-210a00b82c6b@opensource.wdc.com>
Date:   Thu, 28 Apr 2022 08:39:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 12/16] zonefs: allow non power of 2 zoned devices
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, jaegeuk@kernel.org,
        axboe@kernel.dk, snitzer@kernel.org, hch@lst.de, mcgrof@kernel.org,
        naohiro.aota@wdc.com, sagi@grimberg.me, dsterba@suse.com,
        johannes.thumshirn@wdc.com
Cc:     linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        clm@fb.com, gost.dev@samsung.com, chao@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, josef@toxicpanda.com,
        jonathan.derrick@linux.dev, agk@redhat.com, kbusch@kernel.org,
        kch@nvidia.com, linux-nvme@lists.infradead.org,
        dm-devel@redhat.com, bvanassche@acm.org, jiangbo.365@bytedance.com,
        linux-fsdevel@vger.kernel.org, matias.bjorling@wdc.com,
        linux-block@vger.kernel.org
References: <20220427160255.300418-1-p.raghav@samsung.com>
 <CGME20220427160309eucas1p2f677c8db581616f994473f17c4a5bd44@eucas1p2.samsung.com>
 <20220427160255.300418-13-p.raghav@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220427160255.300418-13-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/28/22 01:02, Pankaj Raghav wrote:
> The zone size shift variable is useful only if the zone sizes are known
> to be power of 2. Remove that variable and use generic helpers from
> block layer to calculate zone index in zonefs

Period missing at the end of the sentence.

What about zonefs-tools and its test suite ? Is everything still OK on
that front ? I suspect not...

> 
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  fs/zonefs/super.c  | 6 ++----
>  fs/zonefs/zonefs.h | 1 -
>  2 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> index 3614c7834007..5422be2ca570 100644
> --- a/fs/zonefs/super.c
> +++ b/fs/zonefs/super.c
> @@ -401,10 +401,9 @@ static void __zonefs_io_error(struct inode *inode, bool write)
>  {
>  	struct zonefs_inode_info *zi = ZONEFS_I(inode);
>  	struct super_block *sb = inode->i_sb;
> -	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
>  	unsigned int noio_flag;
>  	unsigned int nr_zones =
> -		zi->i_zone_size >> (sbi->s_zone_sectors_shift + SECTOR_SHIFT);
> +		bdev_zone_no(sb->s_bdev, zi->i_zone_size >> SECTOR_SHIFT);
>  	struct zonefs_ioerr_data err = {
>  		.inode = inode,
>  		.write = write,
> @@ -1300,7 +1299,7 @@ static void zonefs_init_file_inode(struct inode *inode, struct blk_zone *zone,
>  	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
>  	struct zonefs_inode_info *zi = ZONEFS_I(inode);
>  
> -	inode->i_ino = zone->start >> sbi->s_zone_sectors_shift;
> +	inode->i_ino = bdev_zone_no(sb->s_bdev, zone->start);
>  	inode->i_mode = S_IFREG | sbi->s_perm;
>  
>  	zi->i_ztype = type;
> @@ -1647,7 +1646,6 @@ static int zonefs_fill_super(struct super_block *sb, void *data, int silent)
>  	 * interface constraints.
>  	 */
>  	sb_set_blocksize(sb, bdev_zone_write_granularity(sb->s_bdev));
> -	sbi->s_zone_sectors_shift = ilog2(bdev_zone_sectors(sb->s_bdev));
>  	sbi->s_uid = GLOBAL_ROOT_UID;
>  	sbi->s_gid = GLOBAL_ROOT_GID;
>  	sbi->s_perm = 0640;
> diff --git a/fs/zonefs/zonefs.h b/fs/zonefs/zonefs.h
> index 7b147907c328..2d5ea3be3a8e 100644
> --- a/fs/zonefs/zonefs.h
> +++ b/fs/zonefs/zonefs.h
> @@ -175,7 +175,6 @@ struct zonefs_sb_info {
>  	kgid_t			s_gid;
>  	umode_t			s_perm;
>  	uuid_t			s_uuid;
> -	unsigned int		s_zone_sectors_shift;
>  
>  	unsigned int		s_nr_files[ZONEFS_ZTYPE_MAX];
>  


-- 
Damien Le Moal
Western Digital Research
