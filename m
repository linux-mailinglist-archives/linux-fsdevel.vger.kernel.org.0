Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7D85B6031
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 20:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiILSZY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 14:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiILSZW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 14:25:22 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B0A1276E;
        Mon, 12 Sep 2022 11:25:21 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id q9-20020a17090a178900b0020265d92ae3so13181603pja.5;
        Mon, 12 Sep 2022 11:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=jinrTf2dRXCM8P7beDGhcdymXhWilSgCNRAiFQeNJHI=;
        b=mLMtjbzG1Kl+0NHJzKAxbllsuBufduMNF2LO9iIaeSIwdabQAHzY6k1ExlrHjBbQ3b
         5Ek8x+gOY9qsai4wca5CayyELpfftgvEGk6LfP6oka3EzZll/EmV533QU3P7IFXouFCf
         cJeJKlEzBYjyYGcPOEHfG0y3Jv1EYtZx06IidZtpY/PqdJm61eR+KtWvr0pNEQezNvEu
         pFzkoOMvpUyHjk+sBH0Tjhr2kErcS9rXwIAF4/QuotmYMkJOC+XpiPqyqRRB177xZq4d
         caSw8M6mKHirkEV6wHnYvUKeI8Qc2RnoK7f9RHWvkM+Feqcfmz5JThhG20mxA0JX18zd
         681Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=jinrTf2dRXCM8P7beDGhcdymXhWilSgCNRAiFQeNJHI=;
        b=A4v3HuxOD3Z+JXbTX2pG4oWFlR/L2rYFmU1tpfhA96/DQCi+inUGnLEI2uBSM5QaWV
         G2wnNv8C87mh8bYgtR6+3tHgidTAMZrW9tA1HNWKFp+sHZWRPCLO/Sc38J+marm4dKAF
         3COF/32LflCEX+YDi+o0y+SygMa3nA23JlW5qhLHVP9IojeJhANfSm67YAdwT3E+LOWd
         5D6Vnpsxyud1/noej1n5mx8vYvh7/FyIyCSO1BEPxbmmV1mKq8AwbWj31A5X+mE452mq
         gXQ7KlAlpPqKeQie/cfCjAzXvpKsILBi2nG/8lS3LuH9zsKIT+9QtaJEj5jrlsVMn3fk
         EcKA==
X-Gm-Message-State: ACgBeo2a69zEp+6r3Ju6NMk1Qr7VfBXbNHTAv1NIoK8S8MoiMsgOwRQe
        5M8W6ZoV+Qk8amDsxqBtURpWK2AJLSlyvg==
X-Google-Smtp-Source: AA6agR7TErEeniLb8NygdX/YotrQEVmapgtPdEtpEWF/iOvuOSsfvdyhlVfrcnUmKBhBkPJIGioMFA==
X-Received: by 2002:a17:90b:180e:b0:202:a0c3:6da with SMTP id lw14-20020a17090b180e00b00202a0c306damr14093608pjb.94.1663007120382;
        Mon, 12 Sep 2022 11:25:20 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
        by smtp.googlemail.com with ESMTPSA id x127-20020a626385000000b0053b2681b0e0sm5916894pfb.39.2022.09.12.11.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 11:25:19 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 00/23] Convert to filemap_get_folios_tag()
Date:   Mon, 12 Sep 2022 11:22:01 -0700
Message-Id: <20220912182224.514561-1-vishal.moola@gmail.com>
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
---
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

 fs/afs/write.c          | 114 +++++++++++++++++----------------
 fs/btrfs/extent_io.c    |  57 +++++++++--------
 fs/ceph/addr.c          | 138 ++++++++++++++++++++--------------------
 fs/cifs/file.c          |  33 +++++++++-
 fs/ext4/inode.c         |  55 ++++++++--------
 fs/f2fs/checkpoint.c    |  49 +++++++-------
 fs/f2fs/compress.c      |  13 ++--
 fs/f2fs/data.c          |  69 ++++++++++----------
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
 19 files changed, 507 insertions(+), 460 deletions(-)

-- 
2.36.1

