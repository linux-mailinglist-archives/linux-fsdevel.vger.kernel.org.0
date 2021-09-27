Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACEF419EB7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 20:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbhI0S6V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 14:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235853AbhI0S6N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 14:58:13 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C011C061575;
        Mon, 27 Sep 2021 11:56:35 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id e15so81907529lfr.10;
        Mon, 27 Sep 2021 11:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=55NNLkzh4OV0HaDhGAfkYTMJbrnWOQ8oEUJeJ/f86gw=;
        b=qAqVdxNXLK14ymGl3fh1f9w/ojIt5TaWdSHoV3mWcV/j8nZqm2VpqUarXQT8NfWHVU
         lrui9mpdAGz2aGk9gOEkCwfenG2w6HX8ck+enjShoXKeZ0ZVsXr/q+tpU+i5SxZxc8Hu
         eu/TRAdmTVv3xL7G3XTVCujP87ArhYTYnXfUsqKQp5IV+K/SbWmRT/Eh9JEKMXID58/R
         8PAyrDm1U48hR5lFjhEdkJrPB4QENWmZ/kr+g/iXyVGm97+/XTVTQU5d6KGZACaa0v4g
         XF3fN0kqm5GmgEeW1vBKmDT48yE5oS9Xa+728o6P2FmdQbzK8wzBPNqd5YdM2JsmowGx
         WcEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=55NNLkzh4OV0HaDhGAfkYTMJbrnWOQ8oEUJeJ/f86gw=;
        b=sIKiLeX3Wu0IxNwrPKyP0anC39tgEnzbTE2eCkR7tPfq0EaEHBpoushQhS3wACSAME
         sG9pupTQnUvzZ66Gpu0MBNmq8CpURp4lDMlT/W3D5zXQEpVrTJ9M3S8Tfv6Sn16Wzf1K
         QfyJbpccc0uQWP6v3+IVx7CfOOcyDlE5Uitze1Hqv9aiL7gIyLM2Qgs0YmjEhSHvY1u5
         R9TafHHYtjvpOkWKfiJkYXi8ql3DGMNXFUPjfTwUcylEzhmEVjpUhxP38hdP9/TwdHbe
         3bbyNdtjjW3BOmSXZ2Evg8hQZgOjq+BN4bQBTU2LC+EuZwJ0cwDXDu0ipP+wzCo1b87y
         AoHA==
X-Gm-Message-State: AOAM532lHaZjqzraKAnHf1lS/ZinOoIT6yAjgYT8mGQQ31Zx5gGYu5+s
        99ZaRCRU1ouTXta+u+vAxSZdzPqIZeI=
X-Google-Smtp-Source: ABdhPJz20UD8kziRnhnOjCTNqYNd/ZDhoWteKL22IT3u5/CC/UtxU/e85F6Cwyzu1Le3mymQ+1mjmQ==
X-Received: by 2002:a05:651c:178e:: with SMTP id bn14mr1414191ljb.521.1632768983055;
        Mon, 27 Sep 2021 11:56:23 -0700 (PDT)
Received: from kari-VirtualBox ([31.132.12.44])
        by smtp.gmail.com with ESMTPSA id 8sm2075331ljf.39.2021.09.27.11.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 11:56:22 -0700 (PDT)
Date:   Mon, 27 Sep 2021 21:56:21 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] fs/ntfs3: Reject mount if boot's cluster size <
 media sector size
Message-ID: <20210927185621.2wkznecc4jndja6b@kari-VirtualBox>
References: <16cbff75-f705-37cb-ad3f-43d433352f6b@paragon-software.com>
 <6036b141-56e2-0d08-b9ff-641c3451f45a@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6036b141-56e2-0d08-b9ff-641c3451f45a@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 27, 2021 at 06:48:00PM +0300, Konstantin Komarov wrote:
> If we continue to work in this case, then we can corrupt fs.
> 

Should have fixes tag.

> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> ---
>  fs/ntfs3/super.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
> index 7099d9b1f3aa..193f9a98f6ab 100644
> --- a/fs/ntfs3/super.c
> +++ b/fs/ntfs3/super.c
> @@ -763,9 +763,14 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
>  	sbi->mft.lbo = mlcn << sbi->cluster_bits;
>  	sbi->mft.lbo2 = mlcn2 << sbi->cluster_bits;
>  
> +	/* Compare boot's cluster and sector. */

Pretty random obvious comment and I do not know what this does in this
patch.

>  	if (sbi->cluster_size < sbi->sector_size)
>  		goto out;
>  
> +	/* Compare boot's cluster and media sector. */
> +	if (sbi->cluster_size < sector_size)
> +		goto out; /* No way to use ntfs_get_block in this case. */

Usually comment should not go after line. If you take chunk from patch
3/3 then this is not issue.

> +
>  	sbi->cluster_mask = sbi->cluster_size - 1;
>  	sbi->cluster_mask_inv = ~(u64)sbi->cluster_mask;
>  	sbi->record_size = record_size = boot->record_size < 0
> -- 
> 2.33.0
> 
> 
> 
