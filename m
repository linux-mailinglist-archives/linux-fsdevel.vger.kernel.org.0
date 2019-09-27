Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC41FC0199
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2019 10:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbfI0I7r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Sep 2019 04:59:47 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43700 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726016AbfI0I7q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Sep 2019 04:59:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569574783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=II3hY1ojlbH7mcDIiok9FU/BW4Ej5AAWtYmZMOZbzmU=;
        b=PeLDWMnSGhVRxxJL2v+j+V+pxZ8uDQNTyUG4xWowuspanINLE43sgf8dUvVDZbZ2HMieFj
        5xAcTkkUyIkJzzQjzg1OJoepksHy4HTpauCeyAgqftSGlwqQcW6rel8+PrLQ5QhfVdunhI
        p4qTYa896/AIll0843FCGeXbC+piZyw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-niGWJCuUPDqwtv8HKK2WjA-1; Fri, 27 Sep 2019 04:59:15 -0400
Received: by mail-wr1-f70.google.com with SMTP id l6so748956wrn.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2019 01:59:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=M7RzZPIeLxK4KZiZsIRnRxtH08/YDwmOKgHCIoGzHd8=;
        b=uaAeZWHAK3QQxaojRPSJ2fFtpQEir5OSWg4AD1OO31XjhMoCAOwMvm9yfr3dMZwUtG
         xSqzzX7Oq8g2gLW1mTjxTJby9SszJIu+uKWJ7JDxiIKf6VYXUwai8zi8Z9PTt12E4v7A
         4uZz1DnrTduIzdr7mX9EYk3jgSy9Q1/TEvnvVaK3jcnbKfOoSb8S/+RB9FfpG68MSF9z
         oHtqDvtmNNM4bEs3ZLRiGnTF+7O5XZjSQ/xJHLqnIJYI4bOUhwvbw72uEk821kwKGHWG
         ImhPwJTDgG6oXngkbebixm5YyGcz+0uKpM+DWqDkzc4fWIIWSLm0j8u+RLaEtGOX98ux
         zdfw==
X-Gm-Message-State: APjAAAU3YvaXtpgjY65TpeABRnjCXUJkqcJ5nDejpUuRpXauNxckOwqA
        c5d4xlNLSfcDonQdJ8EHRu/6vB/gj+IfYbMc3fTxeM1WwyQX/JLliFgWXBx1v9BEwYhxYisijBY
        DNuU4IlH5DbFsYBhILxJZbTUnSw==
X-Received: by 2002:a05:600c:1103:: with SMTP id b3mr6480192wma.3.1569574753673;
        Fri, 27 Sep 2019 01:59:13 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzBhUEiAoOW1gmrSeaiRapEO/mxHBkWXD5EQyP73gwWN9Aj962FEcp5oWptdVmf1xWkVR9ZPw==
X-Received: by 2002:a05:600c:1103:: with SMTP id b3mr6480172wma.3.1569574753440;
        Fri, 27 Sep 2019 01:59:13 -0700 (PDT)
Received: from pegasus.maiolino.io (ip-89-103-126-188.net.upcbroadband.cz. [89.103.126.188])
        by smtp.gmail.com with ESMTPSA id f143sm13332108wme.40.2019.09.27.01.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 01:59:12 -0700 (PDT)
Date:   Fri, 27 Sep 2019 10:59:10 +0200
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     hch@lst.de, adilger@dilger.ca, darrick.wong@oracle.com,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 0/9 V6] New ->fiemap infrastructure and ->bmap removal
Message-ID: <20190927085909.fexdzlrmsf6wdj4p@pegasus.maiolino.io>
Mail-Followup-To: linux-fsdevel@vger.kernel.org, hch@lst.de,
        adilger@dilger.ca, darrick.wong@oracle.com,
        linux-xfs@vger.kernel.org
References: <20190911134315.27380-1-cmaiolino@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20190911134315.27380-1-cmaiolino@redhat.com>
User-Agent: NeoMutt/20180716
X-MC-Unique: niGWJCuUPDqwtv8HKK2WjA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 11, 2019 at 03:43:06PM +0200, Carlos Maiolino wrote:

Hi Folks.

Is there anything else needed here to get a review on the remaining patches=
?


Cheeers.


> Hi.
>=20
> This is the 6th version of the complete series with the goal to deprecate=
 and
> eventually remove ->bmap() interface, in lieu if FIEMAP.
>=20
> This V6, compared with the previous one, is rebased agains next-20190904,=
 and
> addresses a few issues found by kbuild test robot, and other points discu=
ssed in
> previous version.
>=20
> Detailed information are in each patch description, but the biggest chang=
e
> in this version is the removal of FIEMAP_KERNEL_FIBMAP flag in patch 8, s=
o,
> reducing patch's complexity and avoiding any specific filesystem modifica=
tion.
>=20
> The impact of such change is further detailed in patch 8.
>=20
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
>=20
>  drivers/md/md-bitmap.c |  16 +++---
>  fs/bad_inode.c         |   3 +-
>  fs/btrfs/inode.c       |   5 +-
>  fs/cachefiles/rdwr.c   |  27 +++++-----
>  fs/cifs/cifsfs.h       |   3 +-
>  fs/cifs/inode.c        |   5 +-
>  fs/ecryptfs/mmap.c     |  16 +++---
>  fs/ext2/ext2.h         |   3 +-
>  fs/ext2/inode.c        |   6 +--
>  fs/ext4/ext4.h         |   6 +--
>  fs/ext4/extents.c      |  18 +++----
>  fs/ext4/ioctl.c        |   8 +--
>  fs/f2fs/data.c         |  21 +++++---
>  fs/f2fs/f2fs.h         |   3 +-
>  fs/gfs2/inode.c        |   5 +-
>  fs/hpfs/file.c         |   4 +-
>  fs/inode.c             | 108 +++++++++++++++++++++++++++++++++++-----
>  fs/ioctl.c             | 109 ++++++++++++++++++++++++-----------------
>  fs/iomap/fiemap.c      |   4 +-
>  fs/jbd2/journal.c      |  22 ++++++---
>  fs/nilfs2/inode.c      |   5 +-
>  fs/nilfs2/nilfs.h      |   3 +-
>  fs/ocfs2/extent_map.c  |   6 ++-
>  fs/ocfs2/extent_map.h  |   3 +-
>  fs/overlayfs/inode.c   |   5 +-
>  fs/xfs/xfs_aops.c      |  24 ---------
>  fs/xfs/xfs_iops.c      |  14 ++----
>  fs/xfs/xfs_trace.h     |   1 -
>  include/linux/fs.h     |  38 +++++++++-----
>  include/linux/iomap.h  |   2 +-
>  mm/page_io.c           |  11 +++--
>  31 files changed, 304 insertions(+), 200 deletions(-)
>=20
> --=20
> 2.20.1
>=20

--=20
Carlos

