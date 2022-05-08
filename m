Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F9D51F07A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 21:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbiEHThg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 15:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiEHThg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 15:37:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB9C3A7;
        Sun,  8 May 2022 12:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=4mLftaBBuTjP2XTniAvnLGikepUJRhX9xUhDsG68+dk=; b=fMEWDhl58fiO1/+d8N6FaYkaD7
        XNLSZ4b9AQLY/KI5Ld2YVwYIJaMsVKcbpuY8ukTjXjzQiQAPsot1+ovdBsbBrkrTdWmMTwxKdC/MJ
        3JLDyhd5Pm9iZzI2aDndtHNxDwMcJfI++Q+LK91DTDQzC1Ju45mGrhoKwsNq3FBYo29VMN9wSkpG7
        Zkr+Ts+Qfqi+5WcLIZpk8rOeeQvSg87Mt79DeXhrN44ocz0HbdywluvtIBwjEMDsQdI96X0fWa2gx
        4h1zPmx0ipIX/BNrQoq2Vlp7YHcmYh+h4bE9DRE40t+QXBl+JQ/KT7QCrH6dHPtypmcz1cv3/Nxw/
        zSFzROpQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnmf0-002lOD-OI; Sun, 08 May 2022 19:33:42 +0000
Date:   Sun, 8 May 2022 20:33:42 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT UPDATE] pagecache tree
Message-ID: <YngbFluT9ftR5dqf@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


I've just finished going through my email from last week, fixing up
various patches and adding new R-b lines.  You can find the git tree
here: git://git.infradead.org/users/willy/pagecache.git for-next
or https://git.infradead.org/users/willy/pagecache.git/shortlog/refs/heads/for-next

I'll send out some separate series as a reply to this mail, but here's
the shortlog:

Matthew Wilcox (Oracle) (105):
      scsicam: Fix use of page cache
      ext4: Use page_symlink() instead of __page_symlink()
      namei: Merge page_symlink() and __page_symlink()
      namei: Convert page_symlink() to use memalloc_nofs_save()
      f2fs: Convert f2fs_grab_cache_page() to use scoped memory APIs
      ext4: Allow GFP_FS allocations in ext4_da_convert_inline_data_to_extent()
      ext4: Use scoped memory API in mext_page_double_lock()
      ext4: Use scoped memory APIs in ext4_da_write_begin()
      ext4: Use scoped memory APIs in ext4_write_begin()
      fs: Remove AOP_FLAG_NOFS
      fs: Remove aop_flags parameter from netfs_write_begin()
      fs: Remove aop flags parameter from block_write_begin()
      fs: Remove aop flags parameter from cont_write_begin()
      fs: Remove aop flags parameter from grab_cache_page_write_begin()
      fs: Remove aop flags parameter from nobh_write_begin()
      fs: Remove flags parameter from aops->write_begin
      buffer: Call aops write_begin() and write_end() directly
      namei: Call aops write_begin() and write_end() directly
      ntfs3: Call ntfs_write_begin() and ntfs_write_end() directly
      ntfs3: Remove fsdata parameter from ntfs_extend_initialized_size()
      hfs: Call hfs_write_begin() and generic_write_end() directly
      hfsplus: Call hfsplus_write_begin() and generic_write_end() directly
      ext4: Call aops write_begin() and write_end() directly
      f2fs: Call aops write_begin() and write_end() directly
      i915: Call aops write_begin() and write_end() directly
      fs: Remove pagecache_write_begin() and pagecache_write_end()
      filemap: Update the folio_lock documentation
      filemap: Update the folio_mark_dirty documentation
      readahead: Use a folio in read_pages()
      fs: Convert is_dirty_writeback() to take a folio
      mm/readahead: Convert page_cache_async_readahead to take a folio
      buffer: Rewrite nobh_truncate_page() to use folios
      fs: Introduce aops->read_folio
      fs: Add read_folio documentation
      fs: Convert netfs_readpage to netfs_read_folio
      fs: Convert iomap_readpage to iomap_read_folio
      fs: Convert block_read_full_page() to block_read_full_folio()
      fs: Convert mpage_readpage to mpage_read_folio
      fs: Convert simple_readpage to simple_read_folio
      affs: Convert affs to read_folio
      afs: Convert afs_symlink_readpage to afs_symlink_read_folio
      befs: Convert befs to read_folio
      btrfs: Convert btrfs to read_folio
      cifs: Convert cifs to read_folio
      coda: Convert coda to read_folio
      cramfs: Convert cramfs to read_folio
      ecryptfs: Convert ecryptfs to read_folio
      efs: Convert efs symlinks to read_folio
      erofs: Convert erofs zdata to read_folio
      ext4: Convert ext4 to read_folio
      f2fs: Convert f2fs to read_folio
      freevxfs: Convert vxfs_immed to read_folio
      fuse: Convert fuse to read_folio
      hostfs: Convert hostfs to read_folio
      hpfs: Convert symlinks to read_folio
      isofs: Convert symlinks and zisofs to read_folio
      jffs2: Convert jffs2 to read_folio
      jfs: Convert metadata pages to read_folio
      nfs: Convert nfs to read_folio
      ntfs: Convert ntfs to read_folio
      ocfs2: Convert ocfs2 to read_folio
      orangefs: Convert orangefs to read_folio
      romfs: Convert romfs to read_folio
      squashfs: Convert squashfs to read_folio
      ubifs: Convert ubifs to read_folio
      udf: Convert adinicb and symlinks to read_folio
      vboxsf: Convert vboxsf to read_folio
      mm: Convert swap_readpage to call read_folio instead of readpage
      mm,fs: Remove aops->readpage
      jffs2: Pass the file pointer to jffs2_do_readpage_unlock()
      nfs: Pass the file pointer to nfs_symlink_filler()
      fs: Change the type of filler_t
      mm/filemap: Hoist filler_t decision to the top of do_read_cache_folio()
      fs: Add aops->release_folio
      iomap: Convert to release_folio
      9p: Convert to release_folio
      afs: Convert to release_folio
      btrfs: Convert to release_folio
      ceph: Convert to release_folio
      cifs: Convert to release_folio
      erofs: Convert to release_folio
      ext4: Convert to release_folio
      f2fs: Convert to release_folio
      gfs2: Convert to release_folio
      hfs: Convert to release_folio
      hfsplus: Convert to release_folio
      jfs: Convert to release_folio
      nfs: Convert to release_folio
      nilfs2: Remove comment about releasepage
      ocfs2: Convert to release_folio
      orangefs: Convert to release_folio
      reiserfs: Convert to release_folio
      ubifs: Convert to release_folio
      fs: Remove last vestiges of releasepage
      reiserfs: Convert release_buffer_page() to use a folio
      jbd2: Convert jbd2_journal_try_to_free_buffers to take a folio
      jbd2: Convert release_buffer_page() to use a folio
      fs: Change try_to_free_buffers() to take a folio
      fs: Convert drop_buffers() to use a folio
      fs: Add free_folio address space operation
      orangefs: Convert to free_folio
      nfs: Convert to free_folio
      secretmem: Convert to free_folio
      fs: Remove aops->freepage
      Appoint myself page cache maintainer

Miaohe Lin (1):
      filemap: Remove obsolete comment in lock_page

