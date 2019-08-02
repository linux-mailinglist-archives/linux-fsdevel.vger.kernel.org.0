Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E624A7F4EB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2019 12:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391333AbfHBKUs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Aug 2019 06:20:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44656 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389243AbfHBKUs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Aug 2019 06:20:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id p17so76589264wrf.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Aug 2019 03:20:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=iy64HSA6TJF7c/qxxKWqnjxtGqXugtaq1tZ3xLZLUdU=;
        b=khdEUtL0S+AgveLaxJExP88dMBtfzYxnrH6owZ4Nq9K+00bKGqj1tJv7OYPiz2TcM+
         PQKZ8TIsUSU49/3w1hevEmvA88+Gyc7rMltgy8nXBoBDAIqLWp3lnrndznImQQ6WqDOI
         FYVNjUrQ4x+ZiVCuzn7fpJNSGMj4ubyzxLXxFdp3zHLx/mjMzUV9vsCUF/8LKjARWefB
         Z46m5K+RN1c6OiS84gPIqPA0ceGdSaZd1Rwgasq0qSPdJ0rcigXLi3Js049MedFcEQCA
         oINaqtYREZwcTB32f9tdQ3zn02IbUfSHEK3Rur4BPTKDHGLduKwqgJFyQ7gEoybEZePq
         ME4A==
X-Gm-Message-State: APjAAAXYXV7eeRhRVlgIKg8K1lCM2scQNckMz9KT5IPfIlV0DZppBdyW
        8w4l8xgogO734zwrVWlIYbwCcwIMAxo=
X-Google-Smtp-Source: APXvYqyaQRuJVMZgEGgKfR+9Rk8O1Xi4ooH+GRbBerMC//R/h+plLDaMVoy848wZR6k4wHY7mNh8/A==
X-Received: by 2002:adf:e50c:: with SMTP id j12mr63740875wrm.117.1564741246098;
        Fri, 02 Aug 2019 03:20:46 -0700 (PDT)
Received: from pegasus.maiolino.io (ip-89-103-126-188.net.upcbroadband.cz. [89.103.126.188])
        by smtp.gmail.com with ESMTPSA id z25sm78121923wmf.38.2019.08.02.03.20.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 03:20:45 -0700 (PDT)
Date:   Fri, 2 Aug 2019 12:20:43 +0200
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     hch@lst.de, adilger@dilger.ca, jaegeuk@kernel.org,
        darrick.wong@oracle.com, miklos@szeredi.hu, rpeterso@redhat.com,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 0/9 V4] New ->fiemap infrastructure and ->bmap removal
Message-ID: <20190802102042.7oepvmqteh6jcxdq@pegasus.maiolino.io>
Mail-Followup-To: linux-fsdevel@vger.kernel.org, hch@lst.de,
        adilger@dilger.ca, jaegeuk@kernel.org, darrick.wong@oracle.com,
        miklos@szeredi.hu, rpeterso@redhat.com, linux-xfs@vger.kernel.org
References: <20190731141245.7230-1-cmaiolino@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731141245.7230-1-cmaiolino@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 31, 2019 at 04:12:36PM +0200, Carlos Maiolino wrote:
> Hi.

Please, disconsider this patchset, I wrongly rebased it and there are many
missing changes that should be done to properly rebase it agains 5.3

> 
> This is the 4th version of the complete series with the goal to deprecate and
> eventually remove ->bmap() interface, in lieu of FIEMAP.
> 
> Besides the rebase of the patchset against latest Linus's tree, the only changes
> in this patchset regarding to the previous version, are concentrated in patches
> 4/9 and 8/9.
> 
> In patch 4  (fibmap: Use bmap instead of ->bmap method in ioctl_fibmap), the
> difference compared with previous version, is a change in ioclt_fibmap() return
> value, I spotted while testing this new version with filesystems using data
> inlined in inodes. It now returns 0 in case of error instead an error value,
> otherwise it would be an user interface change.
> 
> 
> In patch 8 (Use FIEMAP for FIBMAP calls), there are minor changes regarding V3.
> It just contains a coding style fix pointed by Andreas in the previous version,
> but now, it also include changes to all filesystems which supports both FIEMAP
> and FIBMAP, and need some sort of special handling (like inlined data, reflinked
> inodes, etc).
> 
> Again, Patch 9 is xfs-specific removal of ->bmap() interface, without any
> changes compared to the previous version.
> 
> 
> 
> I do apologize for taking so long to rework this patchset, I've got busy with
> other stuff.
> 
> Comments are appreciated, specially regarding if the error values returned by
> ioctl_fibmap() make sense.
> 
> 
> Cheers
> 
> Carlos Maiolino (9):
>   fs: Enable bmap() function to properly return errors
>   cachefiles: drop direct usage of ->bmap method.
>   ecryptfs: drop direct calls to ->bmap
>   fibmap: Use bmap instead of ->bmap method in ioctl_fibmap
>   fs: Move start and length fiemap fields into fiemap_extent_info
>   iomap: Remove length and start fields from iomap_fiemap
>   fiemap: Use a callback to fill fiemap extents
>   Use FIEMAP for FIBMAP calls
>   xfs: Get rid of ->bmap
> 
>  drivers/md/md-bitmap.c |  16 ++++--
>  fs/bad_inode.c         |   3 +-
>  fs/btrfs/inode.c       |   5 +-
>  fs/cachefiles/rdwr.c   |  27 ++++-----
>  fs/ecryptfs/mmap.c     |  16 ++----
>  fs/ext2/ext2.h         |   3 +-
>  fs/ext2/inode.c        |   6 +-
>  fs/ext4/ext4.h         |   3 +-
>  fs/ext4/extents.c      |  15 +++--
>  fs/f2fs/data.c         |  15 ++++-
>  fs/f2fs/f2fs.h         |   3 +-
>  fs/gfs2/inode.c        |   9 ++-
>  fs/hpfs/file.c         |   4 +-
>  fs/inode.c             | 105 +++++++++++++++++++++++++++++----
>  fs/ioctl.c             | 128 ++++++++++++++++++++++++++---------------
>  fs/iomap.c             |  40 ++-----------
>  fs/jbd2/journal.c      |  22 ++++---
>  fs/nilfs2/inode.c      |   5 +-
>  fs/nilfs2/nilfs.h      |   3 +-
>  fs/ocfs2/extent_map.c  |  13 ++++-
>  fs/ocfs2/extent_map.h  |   3 +-
>  fs/overlayfs/inode.c   |   5 +-
>  fs/xfs/xfs_aops.c      |  24 --------
>  fs/xfs/xfs_iops.c      |  19 +++---
>  fs/xfs/xfs_trace.h     |   1 -
>  include/linux/fs.h     |  33 +++++++----
>  include/linux/iomap.h  |   2 +-
>  mm/page_io.c           |  11 ++--
>  28 files changed, 320 insertions(+), 219 deletions(-)
> 
> -- 
> 2.20.1
> 

-- 
Carlos
