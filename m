Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1C7C419EA8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 20:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235694AbhI0SyP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 14:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234211AbhI0SyO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 14:54:14 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF672C061604;
        Mon, 27 Sep 2021 11:52:35 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id x27so81796930lfu.5;
        Mon, 27 Sep 2021 11:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s39cDjSBaWlllB2Z8PSXWuKit3Q+ksAwHMo69k6Autc=;
        b=pveXqgUlG4WQuZIQwhP7FTq2a32cwrhpuOFQ1ybSULcJLZ8Jrc8yH+FKtU3A/OJhsU
         idO/eWMHggDffotYZB4umKl8UJEySBzgqesd/LVf2oTJPwepH/TM5LtZsGy5EtfEbyb5
         cr0PYqGyP0xqnvT2Jjqq/CRaNokIQRW+uv5OqkegJ24n1ZBJ9aWLW4sgjpREyv6b8bqf
         q9MBSbde9oQgRgpsZomJLeUDgljDRxjnroIc3Kbcs0/h3Ql328j0NhKQaVv0ZD/oSb4s
         f7ymJFSYjbrY29ZQqnTBuVq766gJbuEO3hhJ1VefuAMDln8PyBHULOmTB8tEIHtOPovc
         MAoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s39cDjSBaWlllB2Z8PSXWuKit3Q+ksAwHMo69k6Autc=;
        b=CP+X+237T1GvXMkrBMfFDmPZoJ9gUici3VuXawg3lNJWVuvmLSjr0y4fnoV6ciWzrm
         bjoUYws56GKcd/74nD0UZuTsVUK4t92cEYF0IxR3/kuwNBXEr9LXu0TqDKjozh5s0IIj
         b0ZF/HeMWBoKizRFOeLnBMXk7NgqaqeN9Ne/Qgc6tRFppFMj8lQ1q5iUQ5lEriQJ4yk0
         Tp+iJjzqtBkPmgTQlW1kbtNLDL9sGqEDqseYrbaEvS+DHI2g6wHmi6i/WYpWEotpdAet
         3KNv0Palf3crQvjUpQJ5Sxdb0cPbLFHIcUghn5zRWSCP4s8IH/2hEae/Bu1J39f90xal
         g2EA==
X-Gm-Message-State: AOAM533aYDs6+aRHrs4nTbNjyexWMefgO3vFYW8rQbsER0Qq+19goE/N
        hZ3kBiXbIUR6pLeUaC5GSbY=
X-Google-Smtp-Source: ABdhPJz1J8r48Z40P6HelVkj/yBHbKWCrbSCxUQ3I0TXN+mttFXGG14tDgzPSO4Ti9GPtpOwgfIDSw==
X-Received: by 2002:ac2:5c46:: with SMTP id s6mr1232283lfp.634.1632768754195;
        Mon, 27 Sep 2021 11:52:34 -0700 (PDT)
Received: from kari-VirtualBox ([31.132.12.44])
        by smtp.gmail.com with ESMTPSA id v27sm1680177lfd.127.2021.09.27.11.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 11:52:33 -0700 (PDT)
Date:   Mon, 27 Sep 2021 21:52:31 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] fs/ntfs3: Refactoring of ntfs_init_from_boot
Message-ID: <20210927185231.mbtzua6zgknktavu@kari-VirtualBox>
References: <16cbff75-f705-37cb-ad3f-43d433352f6b@paragon-software.com>
 <aa2b5ad6-dd9e-3feb-d3bd-248cb311d050@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa2b5ad6-dd9e-3feb-d3bd-248cb311d050@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 27, 2021 at 06:48:38PM +0300, Konstantin Komarov wrote:
> Remove ntfs_sb_info members sector_size and sector_bits.
> Print details why mount failed.
> 
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

Like the changes. Some thing below.

Reviewed-by: Kari Argillander <kari.argillander@gmail.com>

> ---
>  fs/ntfs3/ntfs_fs.h |  2 --
>  fs/ntfs3/super.c   | 32 +++++++++++++++++++-------------
>  2 files changed, 19 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
> index 6731b5d9e2d8..38b7c1a9dc52 100644
> --- a/fs/ntfs3/ntfs_fs.h
> +++ b/fs/ntfs3/ntfs_fs.h
> @@ -211,10 +211,8 @@ struct ntfs_sb_info {
>  	u32 blocks_per_cluster; // cluster_size / sb->s_blocksize
>  
>  	u32 record_size;
> -	u32 sector_size;
>  	u32 index_size;
>  
> -	u8 sector_bits;
>  	u8 cluster_bits;
>  	u8 record_bits;
>  
> diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
> index 193f9a98f6ab..5fe9484c6781 100644
> --- a/fs/ntfs3/super.c
> +++ b/fs/ntfs3/super.c
> @@ -682,7 +682,7 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
>  	struct ntfs_sb_info *sbi = sb->s_fs_info;
>  	int err;
>  	u32 mb, gb, boot_sector_size, sct_per_clst, record_size;
> -	u64 sectors, clusters, fs_size, mlcn, mlcn2;
> +	u64 sectors, clusters, mlcn, mlcn2;
>  	struct NTFS_BOOT *boot;
>  	struct buffer_head *bh;
>  	struct MFT_REC *rec;
> @@ -740,20 +740,20 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
>  		goto out;
>  	}
>  
> -	sbi->sector_size = boot_sector_size;
> -	sbi->sector_bits = blksize_bits(boot_sector_size);
> -	fs_size = (sectors + 1) << sbi->sector_bits;
> +	sbi->volume.size = sectors * boot_sector_size;
>  
> -	gb = format_size_gb(fs_size, &mb);
> +	gb = format_size_gb(sbi->volume.size + boot_sector_size, &mb);
>  
>  	/*
>  	 * - Volume formatted and mounted with the same sector size.
>  	 * - Volume formatted 4K and mounted as 512.
>  	 * - Volume formatted 512 and mounted as 4K.
>  	 */
> -	if (sbi->sector_size != sector_size) {
> -		ntfs_warn(sb,
> -			  "Different NTFS' sector size and media sector size");
> +	if (boot_sector_size != sector_size) {
> +		ntfs_warn(
> +			sb,
> +			"Different NTFS' sector size (%u) and media sector size (%u)",
> +			boot_sector_size, sector_size);

>  		dev_size += sector_size - 1;
>  	}
>  
> @@ -764,12 +764,19 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
>  	sbi->mft.lbo2 = mlcn2 << sbi->cluster_bits;
>  
>  	/* Compare boot's cluster and sector. */
> -	if (sbi->cluster_size < sbi->sector_size)
> +	if (sbi->cluster_size < boot_sector_size)
>  		goto out;
>  
>  	/* Compare boot's cluster and media sector. */
> -	if (sbi->cluster_size < sector_size)
> -		goto out; /* No way to use ntfs_get_block in this case. */
> +	if (sbi->cluster_size < sector_size) {
> +		/* No way to use ntfs_get_block in this case. */
> +		ntfs_err(
> +			sb,
> +			"Failed to mount 'cause NTFS's cluster size (%u) is "
> +			"less than media sector size (%u)",

This is first time I see splitted string like this in ntfs3. No need to
split like this. Small nit for that this chunk should already could be
in patch 2/3.

> +			sbi->cluster_size, sector_size);
> +		goto out;
> +	}
>  
>  	sbi->cluster_mask = sbi->cluster_size - 1;
>  	sbi->cluster_mask_inv = ~(u64)sbi->cluster_mask;
> @@ -794,10 +801,9 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
>  				  : (u32)boot->index_size << sbi->cluster_bits;
>  
>  	sbi->volume.ser_num = le64_to_cpu(boot->serial_num);
> -	sbi->volume.size = sectors << sbi->sector_bits;
>  
>  	/* Warning if RAW volume. */
> -	if (dev_size < fs_size) {
> +	if (dev_size < sbi->volume.size + boot_sector_size) {
>  		u32 mb0, gb0;
>  
>  		gb0 = format_size_gb(dev_size, &mb0);
> -- 
> 2.33.0
> 
> 
