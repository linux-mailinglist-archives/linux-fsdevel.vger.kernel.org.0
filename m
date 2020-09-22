Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D62EB27449F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Sep 2020 16:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgIVOpi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Sep 2020 10:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbgIVOpi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Sep 2020 10:45:38 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DE0C0613CF
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2020 07:45:38 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id w16so19255334qkj.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2020 07:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DvyaDMg2K/8qSOou1l5vaan+mVQdcCN/3PTnRZ/n718=;
        b=DgbGAjMIucPsmGxwsfiNyNv0vHE8RtXmXXi3qAj+B/jtmQ7C2O4CzHeMj3lsnxwIMv
         +x9F7dw8IpeqOUzRC291aFDHHlKMSIUQa/4PZEJKqCsdglcXLt9viRfmeQ7ClIN2d+9S
         tCLpA8TjZdxZQ0NAeR/ulXXBhJAxSsVsqomHAg0rwElFdZpjeu98WaCSkRpDA7zAl1nX
         Idd+hcEWRh9hwrW5y5Q4faIoo2yQdmsKOJ7BVaNvyH3uO7YQyGCzrLeue1CsRE2jUszR
         1uN8nf1EAa1RwAWIg11eJNI7W8lIqT5v8xsyQi3X3MS8SGLu+3TCTh0Mp2cfSL0kuEHV
         GEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DvyaDMg2K/8qSOou1l5vaan+mVQdcCN/3PTnRZ/n718=;
        b=Wjpyf1jFmsPYGMWgCTXnJfpFy6k4tNq9Nt+PycvELmvpgx+uwibU4CSEheMoxranVL
         UQIsAFv93cLzaDP8dTk1jx6Bqvi/U+1JQBSWUtnV/mUIJCc5a9BqLUAoEUAwUwjezjtY
         8059sshs/MJfvDRHSqcAwUrpHt0FRPFwFzNBpBX7xCVgNvpc5lgU72E1gpI9jzR4AaBc
         THWqLotMOItAZ1VcpJPW0011hRQYGE9Z4nJ/ysU1IXJ86sMd4Ri8ZZAYL+G+1CFi7S38
         54JYBJMvoUQStSe/wS8GPpBGD1K15HWvfd3l+G2He8Sepsb2d27N/6TFhXLcr31K5x7s
         dQ/A==
X-Gm-Message-State: AOAM531jXv37+XYZQGIpe0kqqmgf1uEZw+b7ShleeXKtdd1Ja0SfTjX1
        V4HQ7bWyCd6oamoAKniH3hRMfQ==
X-Google-Smtp-Source: ABdhPJzszkAjrxBpQqJz8y2zso4OY1Nqpwx2s57CErsCL3X7Fk5goEE2+i2Idw8GzczzecefI7uGew==
X-Received: by 2002:a05:620a:12f3:: with SMTP id f19mr5237335qkl.110.1600785937152;
        Tue, 22 Sep 2020 07:45:37 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j88sm12295943qte.96.2020.09.22.07.45.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 07:45:35 -0700 (PDT)
Subject: Re: [PATCH 09/15] btrfs: Introduce btrfs_inode_lock()/unlock()
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, david@fromorbit.com, hch@lst.de,
        johannes.thumshirn@wdc.com, dsterba@suse.com,
        darrick.wong@oracle.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <20200921144353.31319-1-rgoldwyn@suse.de>
 <20200921144353.31319-10-rgoldwyn@suse.de>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <23fd8fff-ecc1-8a8f-0813-af3eb05dc796@toxicpanda.com>
Date:   Tue, 22 Sep 2020 10:45:35 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200921144353.31319-10-rgoldwyn@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/21/20 10:43 AM, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Helper functions for locking/unlocking i_rwsem.
> btrfs_inode_lock/unlock() acquires the inode->i_rwsem depending on the
> flags passed. ilock_flags determines the type of lock to be taken:
> 
> BTRFS_ILOCK_SHARED - for shared locks, for possible parallel DIO
> BTRFS_ILOCK_TRY - for the RWF_NOWAIT sequence
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>   fs/btrfs/ctree.h |  7 +++++++
>   fs/btrfs/file.c  | 31 ++++++++++++++++---------------
>   fs/btrfs/inode.c | 31 +++++++++++++++++++++++++++++++
>   3 files changed, 54 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index b47a8dcff028..ea15771bf3da 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3053,6 +3053,13 @@ extern const struct iomap_ops btrfs_dio_iomap_ops;
>   extern const struct iomap_dio_ops btrfs_dio_ops;
>   extern const struct iomap_dio_ops btrfs_sync_dops;
>   
> +/* ilock flags definition */
> +#define BTRFS_ILOCK_SHARED	(1 << 0)
> +#define BTRFS_ILOCK_TRY 	(1 << 1)
> +
> +int btrfs_inode_lock(struct inode *inode, int ilock_flags);
> +void btrfs_inode_unlock(struct inode *inode, int ilock_flags);
> +
>   /* ioctl.c */
>   long btrfs_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
>   long btrfs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 0f961ce1fa98..7e18334e8121 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1974,7 +1974,7 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
>   	 * not unlock the i_mutex at this case.
>   	 */
>   	if (pos + iov_iter_count(from) <= inode->i_size) {
> -		inode_unlock(inode);
> +		btrfs_inode_unlock(inode, 0);
>   		relock = true;
>   	}
>   	down_read(&BTRFS_I(inode)->dio_sem);
> @@ -1995,7 +1995,7 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
>   
>   	up_read(&BTRFS_I(inode)->dio_sem);
>   	if (relock)
> -		inode_lock(inode);
> +		btrfs_inode_lock(inode, 0);
>   
>   	if (written < 0 || !iov_iter_count(from))
>   		return written;
> @@ -2036,6 +2036,7 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
>   	ssize_t num_written = 0;
>   	const bool sync = iocb->ki_flags & IOCB_DSYNC;
>   	ssize_t err;
> +	int ilock_flags = 0;
>   
>   	/*
>   	 * If BTRFS flips readonly due to some impossible error
> @@ -2050,16 +2051,16 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
>   	    (iocb->ki_flags & IOCB_NOWAIT))
>   		return -EOPNOTSUPP;
>   
> -	if (iocb->ki_flags & IOCB_NOWAIT) {
> -		if (!inode_trylock(inode))
> -			return -EAGAIN;
> -	} else {
> -		inode_lock(inode);
> -	}
> +	if (iocb->ki_flags & IOCB_NOWAIT)
> +		ilock_flags |= BTRFS_ILOCK_TRY;
> +
> +	err = btrfs_inode_lock(inode, ilock_flags);
> +	if (err < 0)
> +		return err;
>   
>   	err = btrfs_write_check(iocb, from);
>   	if (err <= 0) {
> -		inode_unlock(inode);
> +		btrfs_inode_unlock(inode, ilock_flags);
>   		return err;
>   	}
>   
> @@ -2105,7 +2106,7 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
>   		num_written = btrfs_buffered_write(iocb, from);
>   	}
>   
> -	inode_unlock(inode);
> +	btrfs_inode_unlock(inode, ilock_flags);
>   
>   	/*
>   	 * We also have to set last_sub_trans to the current log transid,
> @@ -3405,7 +3406,7 @@ static long btrfs_fallocate(struct file *file, int mode,
>   			return ret;
>   	}
>   
> -	inode_lock(inode);
> +	btrfs_inode_lock(inode, 0);
>   
>   	if (!(mode & FALLOC_FL_KEEP_SIZE) && offset + len > inode->i_size) {
>   		ret = inode_newsize_ok(inode, offset + len);
> @@ -3644,9 +3645,9 @@ static loff_t btrfs_file_llseek(struct file *file, loff_t offset, int whence)
>   		return generic_file_llseek(file, offset, whence);
>   	case SEEK_DATA:
>   	case SEEK_HOLE:
> -		inode_lock_shared(inode);
> +		btrfs_inode_lock(inode, BTRFS_ILOCK_SHARED);
>   		offset = find_desired_extent(inode, offset, whence);
> -		inode_unlock_shared(inode);
> +		btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
>   		break;
>   	}
>   
> @@ -3690,10 +3691,10 @@ static ssize_t btrfs_direct_read(struct kiocb *iocb, struct iov_iter *to)
>   	if (check_direct_read(btrfs_sb(inode->i_sb), to, iocb->ki_pos))
>   		return 0;
>   
> -	inode_lock_shared(inode);
> +	btrfs_inode_lock(inode, BTRFS_ILOCK_SHARED);
>   	ret = iomap_dio_rw(iocb, to, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
>   			is_sync_kiocb(iocb));
> -	inode_unlock_shared(inode);
> +	btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
>   	return ret;
>   }
>   
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 0730131b6590..f305efac75ae 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -96,6 +96,37 @@ static void __endio_write_update_ordered(struct btrfs_inode *inode,
>   					 const u64 offset, const u64 bytes,
>   					 const bool uptodate);
>   
> +int btrfs_inode_lock(struct inode *inode, int ilock_flags)
> +{
> +	if (ilock_flags & BTRFS_ILOCK_SHARED) {
> +		if (ilock_flags & BTRFS_ILOCK_TRY) {
> +			if (!inode_trylock_shared(inode))
> +				return -EAGAIN;
> +			else
> +				return 0;
> +		}
> +		inode_lock_shared(inode);
> +	} else {
> +		if (ilock_flags & BTRFS_ILOCK_TRY) {
> +			if (!inode_trylock(inode))
> +				return -EAGAIN;
> +			else
> +				return 0;
> +		}
> +		inode_lock(inode);
> +	}
> +	return 0;
> +}
> +
> +void btrfs_inode_unlock(struct inode *inode, int ilock_flags)
> +{
> +	if (ilock_flags & BTRFS_ILOCK_SHARED)
> +		inode_unlock_shared(inode);
> +	else
> +		inode_unlock(inode);
> +
> +}
> +

Since you are going to have to respin anyway, function comments for these 
please.  Then you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
