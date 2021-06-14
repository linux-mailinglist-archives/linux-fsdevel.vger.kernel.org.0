Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27843A5CFD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 08:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbhFNG04 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 02:26:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:45242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232134AbhFNG0z (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 02:26:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 12400613AD;
        Mon, 14 Jun 2021 06:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623651893;
        bh=leqRBEwjmOVd1OQnbqL5gPOgfEZK9EuOhe27SnSwHRs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vp1LGC+ilMkPtYmbpqU0hK494fAoZ7QM989GGLRb0xrX8rXV0KuUpx3jDRW//L0v2
         2rkXprvAxC25wwOEVn/UZlQv/h0RcF290eJ8et2QqAJy34uJefCKfHFUbedSCXTHVn
         F+Af1Kcq1R3GgfDZOjPqZg8JPDi0n6/hh2POZl/E=
Date:   Mon, 14 Jun 2021 08:24:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm: require ->set_page_dirty to be explicitly wire up
Message-ID: <YMb2M3RKJF7kgp7P@kroah.com>
References: <20210614061512.3966143-1-hch@lst.de>
 <20210614061512.3966143-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614061512.3966143-4-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 14, 2021 at 08:15:12AM +0200, Christoph Hellwig wrote:
> Remove the CONFIG_BLOCK default to __set_page_dirty_buffers and just
> wire that method up for the missing instances.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/adfs/inode.c     |  1 +
>  fs/affs/file.c      |  2 ++
>  fs/bfs/file.c       |  1 +
>  fs/block_dev.c      |  1 +
>  fs/exfat/inode.c    |  1 +
>  fs/ext2/inode.c     |  2 ++
>  fs/fat/inode.c      |  1 +
>  fs/gfs2/meta_io.c   |  2 ++
>  fs/hfs/inode.c      |  2 ++
>  fs/hfsplus/inode.c  |  2 ++
>  fs/hpfs/file.c      |  1 +
>  fs/jfs/inode.c      |  1 +
>  fs/minix/inode.c    |  1 +
>  fs/nilfs2/mdt.c     |  1 +
>  fs/ocfs2/aops.c     |  1 +
>  fs/omfs/file.c      |  1 +
>  fs/sysv/itree.c     |  1 +
>  fs/udf/file.c       |  1 +
>  fs/udf/inode.c      |  1 +
>  fs/ufs/inode.c      |  1 +
>  mm/page-writeback.c | 18 ++++--------------
>  21 files changed, 29 insertions(+), 14 deletions(-)
> 


Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
