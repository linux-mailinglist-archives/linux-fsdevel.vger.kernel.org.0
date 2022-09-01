Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC8F5AA1E1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Sep 2022 00:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbiIAWCi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 18:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiIAWCg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 18:02:36 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C4C4F671;
        Thu,  1 Sep 2022 15:02:34 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id 199so132502pfz.2;
        Thu, 01 Sep 2022 15:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=9AhdqT0NnU3T2Py6z8gOWa0P0fDVhbOVg/CkZAFmw8w=;
        b=qqKY9adEs9TgtJmoU7MkA9KxJfs/ZTmfIPOpeAs+A4H8hVlDwQBSv2Jq3kNi9lgE6S
         8sJ+rYnWCFvuUeYVIPMMc2exsm8WDRdpvjl5fwAEJA+hLvjFfZAtjhOJ0rUOJchnBc56
         yhvalmUSmzK+izTbVuCqRNjA9nDlcTXylDL3VZlcV3KVFQb7Jua/oZo7BYKQbAaqTLSA
         0nn5TAj8h81O2WRfodLf6sJyeFFan770SoHigA/s/3I6JiZR3jJOqLuh3a2ws+xWJr7A
         6uzZs0H1SnSL3lrVxw1n/ypvvcF4KXV5Qs7Kr5OM5r1RoP7UiydsApsG1GNd8TC+k7RW
         PKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=9AhdqT0NnU3T2Py6z8gOWa0P0fDVhbOVg/CkZAFmw8w=;
        b=QF/DzVmKPZNh5CB1h/b8WlvrfHZPacKN9riz39uu/fbixL5LcJq4SsmR52S0DdAbxI
         OFdUjqYVtRtojVcOH5l9eakJ4ve7o6aPSpOEIGlwgc5ogYyGjjs9cksVY7y7w7LcWXfA
         3ttwghzazfUK2c1C6nwiXqQ+iHaRLmhAer5Zj0ie0v4UZfY9OdyoN8VLHbl+JsDbfMfF
         nZ+N9YOTRAX2kvzLf6vpSONBkvybPrZjfZ6fyubjvyN5DJBTAgqhdSMLm65O1Ok/6cf4
         bEe/rsRt3NUgS/oluk+NgajGxPnzsCeH+sFer3h3tKiM/Vwca53j0lC9FcRFMVLpSTP6
         NBvg==
X-Gm-Message-State: ACgBeo1SxaUqbNRRD8clAlUZtgNhqhT53fRkChLv2q/6AD/d9x5ydY7b
        ZHOyqpNdtZecNkjJOe5zZy/GqbG8qtJ+uw==
X-Google-Smtp-Source: AA6agR4DbAW2WPj9nw69+I1LEgmTLkTdrd7+Xqwg+w+CQfOQH0TJG5g4HJoQPF72jeEeLW1NipGm9A==
X-Received: by 2002:a65:6d89:0:b0:421:94bc:cb89 with SMTP id bc9-20020a656d89000000b0042194bccb89mr27551314pgb.129.1662069754081;
        Thu, 01 Sep 2022 15:02:34 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
        by smtp.googlemail.com with ESMTPSA id fv4-20020a17090b0e8400b001fb350026f1sm128894pjb.4.2022.09.01.15.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 15:02:33 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 00/23] Convert to filemap_get_folios_tag()
Date:   Thu,  1 Sep 2022 15:01:15 -0700
Message-Id: <20220901220138.182896-1-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

 fs/afs/write.c          | 114 +++++++++++++++++----------------
 fs/btrfs/extent_io.c    |  57 +++++++++--------
 fs/ceph/addr.c          | 138 ++++++++++++++++++++--------------------
 fs/cifs/file.c          |  33 +++++++++-
 fs/ext4/inode.c         |  55 ++++++++--------
 fs/f2fs/checkpoint.c    |  49 +++++++-------
 fs/f2fs/compress.c      |  13 ++--
 fs/f2fs/data.c          |  67 ++++++++++---------
 fs/f2fs/f2fs.h          |   5 +-
 fs/f2fs/node.c          |  72 +++++++++++----------
 fs/gfs2/aops.c          |  64 ++++++++++---------
 fs/nilfs2/btree.c       |  14 ++--
 fs/nilfs2/page.c        |  59 ++++++++---------
 fs/nilfs2/segment.c     |  44 +++++++------
 include/linux/pagemap.h |  32 +++++++---
 include/linux/pagevec.h |   8 ---
 mm/filemap.c            |  87 ++++++++++++-------------
 mm/page-writeback.c     |  44 +++++++------
 mm/swap.c               |  10 ---
 19 files changed, 506 insertions(+), 459 deletions(-)

-- 
2.36.1

