Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 312BFDD583
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2019 01:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389780AbfJRXdF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Oct 2019 19:33:05 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44826 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387537AbfJRXdF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Oct 2019 19:33:05 -0400
Received: by mail-pg1-f196.google.com with SMTP id e10so4152101pgd.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Oct 2019 16:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=C0tqSIGPLqMU8a9ar2OTCSlzcdbR4guCF2y2hDaHGYM=;
        b=IhcfRxe+W88wN7ZmjkrisaTY9cMR7wGKN38F47xr0g9OdtjpwffV6l6MiTQJfGiTLC
         xzmuESbjmMn3cK0lYzeGB45Ja15DhGMp0ZhBf3fjLjAjhniJpiVXeqXWdL3DQ+OVMD67
         lyAgVGWaJnKw4ii83R81AuZj3vBBgpO9taJsW92n5r9kwo8wsaTQPYHcPsf7WXY2vNR1
         JxduSUuKqCVtA2DG5bEV587/UGONPs8trG35W7pIMpCmX1N3em9ujSBtvi8nduUzPm9L
         bL9+9YEYVbK9c4PpcgU3M7LQJSFu5Yal0FBp9OGBcb8bHxD0qh+0NwchEoFsgTHVRZXB
         FbsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=C0tqSIGPLqMU8a9ar2OTCSlzcdbR4guCF2y2hDaHGYM=;
        b=aEuETXy0cTZtxOa+hVp4f1/MnSZ9jrnBGsIfZbSXEsD8nR6A+6lXUZd5yg5ZJbjFQ0
         Vl39H5QpFOI+41wwufC9+pVppG0XaEnR/eRE7Wy3Xmn1FK1gYH+CHyxpf/0GgOgZd5N+
         5TGh4f58E57pWpSzsAUZHKbZiGKXArJUpWTzhCn+HOjIgU1OAlSFnPOpwyI6MdACFTot
         cdcMV2eUAWKr/ymwtnLjmHlawmdhSMOtHByDb/6ZSKh7X/FvADCDd9CsUZBgF3qfPQtN
         L94lVkFxda+sfONjioW9NZLgyUwW+qKpdlkrE4+bm6oSg6rsj4GwacrRHjyuUDxp3Ska
         se9Q==
X-Gm-Message-State: APjAAAUwfVUsdNNFgC5zwhQ+iqsSJb9ZL+Kqrwwdlhax7uxL2LtHzIyT
        ltz5nWgh1vaC/op/73uM5Q7wkN9XABA=
X-Google-Smtp-Source: APXvYqyi34jIC88zsF8IfK7OC6l20pv/Q1hrY5efokEK+QEQaUzZwIdmFjB9nep2vXyL71uon3Uirw==
X-Received: by 2002:a63:4852:: with SMTP id x18mr13087162pgk.345.1571441582263;
        Fri, 18 Oct 2019 16:33:02 -0700 (PDT)
Received: from vader ([2620:10d:c090:200::2:cf85])
        by smtp.gmail.com with ESMTPSA id e184sm7966540pfa.87.2019.10.18.16.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 16:33:01 -0700 (PDT)
Date:   Fri, 18 Oct 2019 16:33:00 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-team@fb.com, Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>, linux-api@vger.kernel.org
Subject: Re: [RFC PATCH v2 5/5] btrfs: implement RWF_ENCODED writes
Message-ID: <20191018233300.GE59713@vader>
References: <cover.1571164762.git.osandov@fb.com>
 <904de93d9bbe630aff7f725fd587810c6eb48344.1571164762.git.osandov@fb.com>
 <0da91628-7f54-7d24-bf58-6807eb9535a5@suse.com>
 <20191018225513.GD59713@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191018225513.GD59713@vader>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 18, 2019 at 03:55:13PM -0700, Omar Sandoval wrote:
> On Wed, Oct 16, 2019 at 01:44:56PM +0300, Nikolay Borisov wrote:
> > 
> > 
> > On 15.10.19 г. 21:42 ч., Omar Sandoval wrote:
> > > From: Omar Sandoval <osandov@fb.com>
> > > 
> > > The implementation resembles direct I/O: we have to flush any ordered
> > > extents, invalidate the page cache, and do the io tree/delalloc/extent
> > > map/ordered extent dance. From there, we can reuse the compression code
> > > with a minor modification to distinguish the write from writeback.
> > > 
> > > Now that read and write are implemented, this also sets the
> > > FMODE_ENCODED_IO flag in btrfs_file_open().
> > > 
> > > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > > ---
> > >  fs/btrfs/compression.c |   6 +-
> > >  fs/btrfs/compression.h |   5 +-
> > >  fs/btrfs/ctree.h       |   2 +
> > >  fs/btrfs/file.c        |  40 +++++++--
> > >  fs/btrfs/inode.c       | 197 ++++++++++++++++++++++++++++++++++++++++-
> > >  5 files changed, 237 insertions(+), 13 deletions(-)
> > > 

[snip]

> > > +	for (;;) {
> > > +		struct btrfs_ordered_extent *ordered;
> > > +
> > > +		ret = btrfs_wait_ordered_range(inode, start, end - start + 1);
> > > +		if (ret)
> > > +			goto out_pages;
> > > +		ret = invalidate_inode_pages2_range(inode->i_mapping,
> > > +						    start >> PAGE_SHIFT,
> > > +						    end >> PAGE_SHIFT);
> > > +		if (ret)
> > > +			goto out_pages;
> > > +		lock_extent_bits(io_tree, start, end, &cached_state);
> > > +		ordered = btrfs_lookup_ordered_range(BTRFS_I(inode), start,
> > > +						     end - start + 1);
> > > +		if (!ordered &&
> > > +		    !filemap_range_has_page(inode->i_mapping, start, end))
> > > +			break;
> > > +		if (ordered)
> > > +			btrfs_put_ordered_extent(ordered);
> > > +		unlock_extent_cached(io_tree, start, end, &cached_state);
> > > +		cond_resched();
> > > +	}
> > > +
> > > +	ret = btrfs_delalloc_reserve_space(inode, &data_reserved, start,
> > > +					   num_bytes);
> > > +	if (ret)
> > > +		goto out_unlock;
> > > +
> > > +	ret = btrfs_reserve_extent(root, num_bytes, disk_num_bytes,
> > > +				   disk_num_bytes, 0, 0, &ins, 1, 1);
> > > +	if (ret)
> > > +		goto out_delalloc_release;
> > > +
> > > +	em = create_io_em(inode, start, num_bytes, start, ins.objectid,
> > > +			  ins.offset, ins.offset, num_bytes, compression,
> > > +			  BTRFS_ORDERED_COMPRESSED);
> > > +	if (IS_ERR(em)) {
> > > +		ret = PTR_ERR(em);
> > > +		goto out_free_reserve;
> > > +	}
> > > +	free_extent_map(em);
> > > +
> > > +	ret = btrfs_add_ordered_extent_compress(inode, start, ins.objectid,
> > > +						num_bytes, ins.offset,
> > > +						BTRFS_ORDERED_COMPRESSED,
> > > +						compression);
> > > +	if (ret) {
> > > +		btrfs_drop_extent_cache(BTRFS_I(inode), start, end, 0);
> > > +		goto out_free_reserve;
> > > +	}
> > > +	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
> > > +
> > > +	if (start + encoded->len > inode->i_size)
> > > +		i_size_write(inode, start + encoded->len);
> > 
> > Don't we want the inode size to be updated once data hits disk and
> > btrfs_finish_ordered_io is called?
> 
> Yup, you're right, this is too early.

Actually, no, this part is fine. Compare to the call to i_size_write()
in btrfs_get_blocks_direct_write(): we lock the extent in the io_tree,
create the ordered extent, update i_size, then unlock the extent. Anyone
else who comes in is going to find the ordered extent and wait on that.

> > > +
> > > +	unlock_extent_cached(io_tree, start, end, &cached_state);
> > > +
> > > +	btrfs_delalloc_release_extents(BTRFS_I(inode), num_bytes, false);
> > > +
> > > +	if (btrfs_submit_compressed_write(inode, start, num_bytes, ins.objectid,
> > > +					  ins.offset, pages, nr_pages, 0,
> > > +					  false)) {
> > > +		struct page *page = pages[0];
> > > +
> > > +		page->mapping = inode->i_mapping;
> > > +		btrfs_writepage_endio_finish_ordered(page, start, end, 0);
> > > +		page->mapping = NULL;
> > > +		ret = -EIO;
> > > +		goto out_pages;
> > > +	}
> 
> I also need to wait for the I/O to finish here.
> 
> > > +	iocb->ki_pos += encoded->len;
> > > +	return orig_count;
> > > +
> > > +out_free_reserve:
> > > +	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
> > > +	btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset, 1);
> > > +out_delalloc_release:
> > > +	btrfs_delalloc_release_space(inode, data_reserved, start, num_bytes,
> > > +				     true);
> > > +out_unlock:
> > > +	unlock_extent_cached(io_tree, start, end, &cached_state);
> > > +out_pages:
> > > +	for (i = 0; i < nr_pages; i++) {
> > > +		if (pages[i])
> > > +			put_page(pages[i]);
> > > +	}
> > > +	kvfree(pages);
> > > +	return ret;
> > > +}
> > > +
> > >  #ifdef CONFIG_SWAP
> > >  /*
> > >   * Add an entry indicating a block group or device which is pinned by a
> > > 
