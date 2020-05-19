Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74DC31D8DB4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 04:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgESCnU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 May 2020 22:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgESCnU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 May 2020 22:43:20 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D70FC061A0C;
        Mon, 18 May 2020 19:43:20 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id z15so638821pjb.0;
        Mon, 18 May 2020 19:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cFdKWhemCr8tqvr3h+vuaX6m9GdwfIHQ43GFK/Jf/pI=;
        b=Y/bDmEULPyPvMeyR/Vt/m7qXOIFlc53jGiI1lzonVc1dCAUvMOdnCAswQHMgdriesL
         1BlDn0J48UxSX8XRve1lKIZSz0gOIo1cppxRAyWm48W4e9ndjVhxnau/Y0LTBC8kWuU4
         CZs4d6t4v1RC2xw2QqHsq3dw6nPlbuCCLGt/Encf/UQdSK6pyMLcMULqfNSZHtK3Ma98
         foyfQpDSeQHHDrbeByiN17jblCXLcZxcOco8Bio8nJ5ccU/AIK1r/z1g0zYCUcZsh8xp
         NbjKn7FckTQPzoaGOSK6h7N6FOlkc2zbq/6W+m/WdLeQIfclUuA6gr2mMWU1e1Byt1E4
         XLAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cFdKWhemCr8tqvr3h+vuaX6m9GdwfIHQ43GFK/Jf/pI=;
        b=Uxzqj4ITDXw4/sS5nh+pBnzwfb3W4je/sB6g62iD2uDWBgSOsWQpTo/JzENYeW2UaP
         q4rsFWC8el7k+XuAD0dY8g8KZDNxLzsPtwiytQ/zXYjWr5r1DbShuy8IHvMtwCUD8yPq
         40iifJUxYubK+SHrRCH3ta3cowCXipLb+seMAPZGT9AyIoTUNDSxQv/FUmtN4Z7hqveu
         MZQvAFaDcKkKfO1qRPRw4dnhS2sOzwjiTzb0iUjeKJVg+DmEtKoEpLVvub/a14PEtiLq
         LcNHi6/zNZS1SjFtHaqR70cmfkZvvsHQIZxR+e55u+ySM8r9VSR2ONGs/P+WKi9blqfV
         6bzw==
X-Gm-Message-State: AOAM533BmVqIzQJVZcPx6g+AhhqxKu9OrCMO/QUni8SmlCZMHoEqw597
        6RA4Lgx4xiKm8tKSW37XGZjuM6S0
X-Google-Smtp-Source: ABdhPJzHKm8Iv95u53qNRmM8TJYZElKqpCnOzCWpdYNTq6J0gexIshdTEmOipMnHMhB+FGMH6A30aQ==
X-Received: by 2002:a17:90a:d78e:: with SMTP id z14mr2583854pju.155.1589856199982;
        Mon, 18 May 2020 19:43:19 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id z20sm5555472pgv.52.2020.05.18.19.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 19:43:19 -0700 (PDT)
Date:   Tue, 19 May 2020 10:43:11 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, jack@suse.cz, tytso@mit.edu,
        adilger@dilger.ca, darrick.wong@oracle.com, hch@infradead.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Murphy Zhou <jencce.kernel@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH 0/5] ext4/overlayfs: fiemap related fixes
Message-ID: <20200519024311.7bkxi2fkxboon2ig@xzhoux.usersys.redhat.com>
References: <cover.1587555962.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1587555962.git.riteshh@linux.ibm.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 23, 2020 at 04:17:52PM +0530, Ritesh Harjani wrote:
> Hello All,
> 
> Here are some changes, which as I understand, takes the right approach in fixing
> the offset/length bounds check problem reported in threads [1]-[2].
> These warnings in iomap_apply/ext4 path are reported after ext4_fiemap()
> was moved to use iomap framework and when overlayfs is mounted on top of ext4.
> Though the issues were identified after ext4 moved to iomap framework, but
> these changes tries to fix the problem which are anyways present in current code
> irrespective of ext4 using iomap framework for fiemap or not.

Ping?

> 
> Patch 1 & 4 commit msg may give more details of the problem.
> 
> Tests done
> ==========
> 1. Tested xfstest-suite with "-g quick" & "-overlay -g quick" configuration
> on a 4k blocksize on x86 & Power. There were no new failures reported
> due to these changes.
> 2. Tested syzcaller reported problem with this change. [1]
> 3. Tested below change which was reported by Murphy. [2]
> 	The minimal reproducer is:
> 	-------------------------------------
> 	fallocate -l 256M test.img
> 	mkfs.ext4 -Fq -b 4096 -I 256 test.img
> 	mkdir -p test
> 	mount -o loop test.img test || exit
> 	pushd test
> 	rm -rf l u w m
> 	mkdir -p l u w m
> 	mount -t overlay -o lowerdir=l,upperdir=u,workdir=w overlay m || exit
> 	xfs_io -f -c "pwrite 0 4096" -c "fiemap"  m/tf
> 	umount m
> 	rm -rf l u w m
> 	popd
> 	umount -d test
> 	rm -rf test test.img
> 	-------------------------------------
> 
> Comments/feedback are much welcome!!
> 
> References
> ==========
> [1]: https://lkml.org/lkml/2020/4/11/46
> [2]: https://patchwork.ozlabs.org/project/linux-ext4/patch/20200418233231.z767yvfiupy7hwgp@xzhoux.usersys.redhat.com/ 
> 
> 
> Ritesh Harjani (5):
>   ext4: Fix EXT4_MAX_LOGICAL_BLOCK macro
>   ext4: Rename fiemap_check_ranges() to make it ext4 specific
>   vfs: EXPORT_SYMBOL for fiemap_check_ranges()
>   overlayfs: Check for range bounds before calling i_op->fiemap()
>   ext4: Get rid of ext4_fiemap_check_ranges
> 
>  fs/ext4/ext4.h       |  2 +-
>  fs/ext4/ioctl.c      | 23 -----------------------
>  fs/ioctl.c           |  5 +++--
>  fs/overlayfs/inode.c |  7 ++++++-
>  include/linux/fs.h   |  2 ++
>  5 files changed, 12 insertions(+), 27 deletions(-)
> 
> -- 
> 2.21.0
> 

-- 
Murphy
