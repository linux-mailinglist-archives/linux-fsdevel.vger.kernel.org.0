Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4236B3A5CFB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 08:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbhFNG0d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 02:26:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:45130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232413AbhFNG03 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 02:26:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E98836120E;
        Mon, 14 Jun 2021 06:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623651867;
        bh=H1IHf6ck++Wvq42Mk+SFlMV2cACHd9GpelqGgW+vUBE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FlGS91eCSeQZSUm3acSX+eEu5LS1yKDZqA8Hl0D9QAryulKbvhwh94+ZLy2ZcoBUm
         Tga+cpg6gkfu9faG9vsr9DTfOM/ep3hyve4YIFd7HJ8i1sa16POqUv037Wfsp1vkQv
         vIiofBVx4JM5O1nuSRQmzlhvYxwO2H7gFyfeIJHU=
Date:   Mon, 14 Jun 2021 08:24:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] fs: move ramfs_aops to libfs
Message-ID: <YMb2GLLl1pfztwrT@kroah.com>
References: <20210614061512.3966143-1-hch@lst.de>
 <20210614061512.3966143-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614061512.3966143-3-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 14, 2021 at 08:15:11AM +0200, Christoph Hellwig wrote:
> Move the ramfs aops to libfs and reuse them for kernfs and configfs.
> Thosw two did not wire up ->set_page_dirty before and now get
> __set_page_dirty_no_writeback, which is the right one for no-writeback
> address_space usage.
> 
> Drop the now unused exports of the libfs helpers only used for
> ramfs-style pagecache usage.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/configfs/inode.c |  8 +-------
>  fs/kernfs/inode.c   |  8 +-------
>  fs/libfs.c          | 17 +++++++++++++----
>  fs/ramfs/inode.c    |  9 +--------
>  include/linux/fs.h  |  5 +----
>  5 files changed, 17 insertions(+), 30 deletions(-)
> 


Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
