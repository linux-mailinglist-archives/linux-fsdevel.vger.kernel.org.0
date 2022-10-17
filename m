Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F3E6019AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 22:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbiJQU1E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 16:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbiJQU0m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 16:26:42 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AA2326CF;
        Mon, 17 Oct 2022 13:24:56 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id i3so12108430pfc.11;
        Mon, 17 Oct 2022 13:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GDF0HteevzYNLv2uN0Cib6K7paWLvmyKD/8WXFsjE5M=;
        b=aY4b63NZqQCKvU20ZoDK++qZhACS2e4aeBRsuuopLKG1Ytlt2bf9tD+JujcCPXLwaZ
         Sc/sT6V3+o3kVy28NBqwCDqZZrw6g9Fs5MQlfvUWn3V1lSG2rAI2su5+aaHC5Bk54jld
         mValP1FoKNSZ7hECNNOhR50m1PC55zjwk4nMgeoqCE9b0x+D0KWvwxgyobqS9JUMepUM
         zoylWXqCOD4Erjg4B4JH20iK300YiMzqbUBmkV8B6s3BWy8zw1Q4HVQBjXeu7RvRa4oK
         JxMpnpHEjCRLimm43OE5MLtZsYG5G/gI4dWGzotWFSr9mYgloWVKNp5Nq+BYtExGElaC
         bqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GDF0HteevzYNLv2uN0Cib6K7paWLvmyKD/8WXFsjE5M=;
        b=qU1O1IPiDKPW1b8XGiKtO4A9gtJg+dGwwWif5f9k9dcjm/Hdj1fGGwuMuUK8qR5vCQ
         c72nG4h2JxBSx56zM+ZWA4K968M4aptDJLk8/LgnoJ53+ZKsDS4Oal2dGTLpJS18HaoP
         fU0/hipzrzOQbUkdI9Cm0TutfWfaYLJxTVYhDhhp0bVINThQPhuYX9oWJUh9/Lltdj+b
         LvYKUo6LwaGJKXZouxK1XrztF8H3FXEQUXVfrnWDqkp6Gpfy4zusNj+h89+yIJyiYZue
         argBVcqIRVK8w7RgFfO0NZAWGiORGkhMUKi71m/a46OP7ZeU9EvG1OBds619/OrGlzzR
         JQkA==
X-Gm-Message-State: ACrzQf2Ok+kLjXkUtyvynqPe4686iL19LdwSts7VnhFFpdvC/gnb9BFt
        QW+kGtIkMzGWrl7WQLS1vAjhM2nRxrCscA==
X-Google-Smtp-Source: AMsMyM5ZBQ4ulLEerblhN4dY+KgGrViyV8tdaDAbkTMfDdZ5KC19A4m0FrTCeDWfYdUkGvRrnROusw==
X-Received: by 2002:a05:6a00:2402:b0:52c:81cf:8df8 with SMTP id z2-20020a056a00240200b0052c81cf8df8mr14608634pfh.60.1666038294629;
        Mon, 17 Oct 2022 13:24:54 -0700 (PDT)
Received: from vmfolio.. (c-76-102-73-225.hsd1.ca.comcast.net. [76.102.73.225])
        by smtp.googlemail.com with ESMTPSA id pj12-20020a17090b4f4c00b00200b12f2bf5sm145037pjb.1.2022.10.17.13.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 13:24:54 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v3 00/23] Convert to filemap_get_folios_tag()
Date:   Mon, 17 Oct 2022 13:24:28 -0700
Message-Id: <20221017202451.4951-1-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch series replaces find_get_pages_range_tag() with
filemap_get_folios_tag(). This also allows the removal of multiple
calls to compound_head() throughout.
It also makes a good chunk of the straightforward conversions to folios,
and takes the opportunity to introduce a function that grabs a folio
from the pagecache.

F2fs and Ceph have quite alot of work to be done regarding folios, so
for now those patches only have the changes necessary for the removal of
find_get_pages_range_tag(), and only support folios of size 1 (which is
all they use right now anyways).

I've run xfstests on btrfs, ext4, f2fs, and nilfs2, but more testing may be
beneficial. The page-writeback and filemap changes implicitly work. Testing
and review of the other changes (afs, ceph, cifs, gfs2) would be appreciated.

---
v3:
  Rebased onto upstream 6.1
  Simplified the ceph patch to only necessary changes
  Changed commit messages throughout to be clearer
  Got an Acked-by for another nilfs patch
  Got Tested-by for afs

v2:
  Got Acked-By tags for nilfs and btrfs changes
  Fixed an error arising in f2fs
  - Reported-by: kernel test robot <lkp@intel.com>

Vishal Moola (Oracle) (23):
  pagemap: Add filemap_grab_folio()
  filemap: Added filemap_get_folios_tag()
  filemap: Convert __filemap_fdatawait_range() to use
    filemap_get_folios_tag()
  page-writeback: Convert write_cache_pages() to use
    filemap_get_folios_tag()
  afs: Convert afs_writepages_region() to use filemap_get_folios_tag()
  btrfs: Convert btree_write_cache_pages() to use
    filemap_get_folio_tag()
  btrfs: Convert extent_write_cache_pages() to use
    filemap_get_folios_tag()
  ceph: Convert ceph_writepages_start() to use filemap_get_folios_tag()
  cifs: Convert wdata_alloc_and_fillpages() to use
    filemap_get_folios_tag()
  ext4: Convert mpage_prepare_extent_to_map() to use
    filemap_get_folios_tag()
  f2fs: Convert f2fs_fsync_node_pages() to use filemap_get_folios_tag()
  f2fs: Convert f2fs_flush_inline_data() to use filemap_get_folios_tag()
  f2fs: Convert f2fs_sync_node_pages() to use filemap_get_folios_tag()
  f2fs: Convert f2fs_write_cache_pages() to use filemap_get_folios_tag()
  f2fs: Convert last_fsync_dnode() to use filemap_get_folios_tag()
  f2fs: Convert f2fs_sync_meta_pages() to use filemap_get_folios_tag()
  gfs2: Convert gfs2_write_cache_jdata() to use filemap_get_folios_tag()
  nilfs2: Convert nilfs_lookup_dirty_data_buffers() to use
    filemap_get_folios_tag()
  nilfs2: Convert nilfs_lookup_dirty_node_buffers() to use
    filemap_get_folios_tag()
  nilfs2: Convert nilfs_btree_lookup_dirty_buffers() to use
    filemap_get_folios_tag()
  nilfs2: Convert nilfs_copy_dirty_pages() to use
    filemap_get_folios_tag()
  nilfs2: Convert nilfs_clear_dirty_pages() to use
    filemap_get_folios_tag()
  filemap: Remove find_get_pages_range_tag()

 fs/afs/write.c          | 114 +++++++++++++++++++++-------------------
 fs/btrfs/extent_io.c    |  57 ++++++++++----------
 fs/ceph/addr.c          |  58 ++++++++++----------
 fs/cifs/file.c          |  33 ++++++++++--
 fs/ext4/inode.c         |  55 ++++++++++---------
 fs/f2fs/checkpoint.c    |  49 +++++++++--------
 fs/f2fs/compress.c      |  13 ++---
 fs/f2fs/data.c          |  69 +++++++++++++-----------
 fs/f2fs/f2fs.h          |   5 +-
 fs/f2fs/node.c          |  72 +++++++++++++------------
 fs/gfs2/aops.c          |  64 ++++++++++++----------
 fs/nilfs2/btree.c       |  14 ++---
 fs/nilfs2/page.c        |  59 +++++++++++----------
 fs/nilfs2/segment.c     |  44 ++++++++--------
 include/linux/pagemap.h |  32 +++++++----
 include/linux/pagevec.h |   8 ---
 mm/filemap.c            |  87 +++++++++++++++---------------
 mm/page-writeback.c     |  44 ++++++++--------
 mm/swap.c               |  10 ----
 19 files changed, 467 insertions(+), 420 deletions(-)

-- 
2.36.1

