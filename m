Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F10E6A507D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 02:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjB1BCT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Feb 2023 20:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjB1BCK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Feb 2023 20:02:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5ED29E2A;
        Mon, 27 Feb 2023 17:01:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7587CB80DD4;
        Tue, 28 Feb 2023 01:01:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A490C4339B;
        Tue, 28 Feb 2023 01:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677546115;
        bh=0MyrhP8zxv6k33rgc7qfdjiKkOYxKugd6Y5yIm+G+iw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=TrpxKXLHDJRZmtxPellg2R2e0LwhTmG2M11tD4m4F8F5sKa+ry/nGM6/NDBChHoSD
         j+YaN0hFzU38PKpe17cqCZbGiwewOAiZERVYOj+LVc+zb+jt+6wDtD4bw9ZY6ZPna5
         065r5y/ntPdrttGXnI3ygAbmSEG2s9nsuyYdZPPvc3oEf0eJPU9GIxZ27JxeQH239M
         eIP+6uHS95fWDDm7rwjzBKHQryPRBHRS4JkIq4xsHici3XYcI9wSHemkzlMeag11Ao
         CyNrHEzQkd0ZOa/GCfBP9ibpQQKBD4VlH0bx1VPvcM/70InEGg8VvhrbOZQC5RFlmL
         wAFn4/77eBcag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ED819C41676;
        Tue, 28 Feb 2023 01:01:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v5 00/23] Convert to filemap_get_folios_tag()
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <167754611496.27916.17463541946406622753.git-patchwork-notify@kernel.org>
Date:   Tue, 28 Feb 2023 01:01:54 +0000
References: <20230104211448.4804-1-vishal.moola@gmail.com>
In-Reply-To: <20230104211448.4804-1-vishal.moola@gmail.com>
To:     Vishal Moola (Oracle) <vishal.moola@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-mm@kvack.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-btrfs@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Andrew Morton <akpm@linux-foundation.org>:

On Wed,  4 Jan 2023 13:14:25 -0800 you wrote:
> This patch series replaces find_get_pages_range_tag() with
> filemap_get_folios_tag(). This also allows the removal of multiple
> calls to compound_head() throughout.
> It also makes a good chunk of the straightforward conversions to folios,
> and takes the opportunity to introduce a function that grabs a folio
> from the pagecache.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v5,01/23] pagemap: Add filemap_grab_folio()
    https://git.kernel.org/jaegeuk/f2fs/c/ee7a5906ff08
  - [f2fs-dev,v5,02/23] filemap: Added filemap_get_folios_tag()
    https://git.kernel.org/jaegeuk/f2fs/c/247f9e1feef4
  - [f2fs-dev,v5,03/23] filemap: Convert __filemap_fdatawait_range() to use filemap_get_folios_tag()
    https://git.kernel.org/jaegeuk/f2fs/c/6817ef514e1a
  - [f2fs-dev,v5,04/23] page-writeback: Convert write_cache_pages() to use filemap_get_folios_tag()
    https://git.kernel.org/jaegeuk/f2fs/c/0fff435f060c
  - [f2fs-dev,v5,05/23] afs: Convert afs_writepages_region() to use filemap_get_folios_tag()
    https://git.kernel.org/jaegeuk/f2fs/c/acc8d8588cb7
  - [f2fs-dev,v5,06/23] btrfs: Convert btree_write_cache_pages() to use filemap_get_folio_tag()
    https://git.kernel.org/jaegeuk/f2fs/c/51c5cd3bafe5
  - [f2fs-dev,v5,07/23] btrfs: Convert extent_write_cache_pages() to use filemap_get_folios_tag()
    https://git.kernel.org/jaegeuk/f2fs/c/9f50fd2e92e3
  - [f2fs-dev,v5,08/23] ceph: Convert ceph_writepages_start() to use filemap_get_folios_tag()
    https://git.kernel.org/jaegeuk/f2fs/c/590a2b5f0a9b
  - [f2fs-dev,v5,09/23] cifs: Convert wdata_alloc_and_fillpages() to use filemap_get_folios_tag()
    https://git.kernel.org/jaegeuk/f2fs/c/4cda80f3a7a5
  - [f2fs-dev,v5,10/23] ext4: Convert mpage_prepare_extent_to_map() to use filemap_get_folios_tag()
    https://git.kernel.org/jaegeuk/f2fs/c/50ead2537441
  - [f2fs-dev,v5,11/23] f2fs: Convert f2fs_fsync_node_pages() to use filemap_get_folios_tag()
    https://git.kernel.org/jaegeuk/f2fs/c/e6e46e1eb7ce
  - [f2fs-dev,v5,12/23] f2fs: Convert f2fs_flush_inline_data() to use filemap_get_folios_tag()
    https://git.kernel.org/jaegeuk/f2fs/c/a40a4ad1186a
  - [f2fs-dev,v5,13/23] f2fs: Convert f2fs_sync_node_pages() to use filemap_get_folios_tag()
    https://git.kernel.org/jaegeuk/f2fs/c/7525486affa5
  - [f2fs-dev,v5,14/23] f2fs: Convert f2fs_write_cache_pages() to use filemap_get_folios_tag()
    https://git.kernel.org/jaegeuk/f2fs/c/1cd98ee747cf
  - [f2fs-dev,v5,15/23] f2fs: Convert last_fsync_dnode() to use filemap_get_folios_tag()
    https://git.kernel.org/jaegeuk/f2fs/c/4f4a4f0febe6
  - [f2fs-dev,v5,16/23] f2fs: Convert f2fs_sync_meta_pages() to use filemap_get_folios_tag()
    https://git.kernel.org/jaegeuk/f2fs/c/580e7a492608
  - [f2fs-dev,v5,17/23] gfs2: Convert gfs2_write_cache_jdata() to use filemap_get_folios_tag()
    https://git.kernel.org/jaegeuk/f2fs/c/87ed37e66dfd
  - [f2fs-dev,v5,18/23] nilfs2: Convert nilfs_lookup_dirty_data_buffers() to use filemap_get_folios_tag()
    https://git.kernel.org/jaegeuk/f2fs/c/5ee4b25cb730
  - [f2fs-dev,v5,19/23] nilfs2: Convert nilfs_lookup_dirty_node_buffers() to use filemap_get_folios_tag()
    https://git.kernel.org/jaegeuk/f2fs/c/a24586583169
  - [f2fs-dev,v5,20/23] nilfs2: Convert nilfs_btree_lookup_dirty_buffers() to use filemap_get_folios_tag()
    https://git.kernel.org/jaegeuk/f2fs/c/41f3f3b5373e
  - [f2fs-dev,v5,21/23] nilfs2: Convert nilfs_copy_dirty_pages() to use filemap_get_folios_tag()
    https://git.kernel.org/jaegeuk/f2fs/c/d4a16d31334e
  - [f2fs-dev,v5,22/23] nilfs2: Convert nilfs_clear_dirty_pages() to use filemap_get_folios_tag()
    https://git.kernel.org/jaegeuk/f2fs/c/243c5ea4f783
  - [f2fs-dev,v5,23/23] filemap: Remove find_get_pages_range_tag()
    https://git.kernel.org/jaegeuk/f2fs/c/c5792d938411

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


