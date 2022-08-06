Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1852658B4A2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Aug 2022 10:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238941AbiHFI4Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 Aug 2022 04:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiHFI4Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 Aug 2022 04:56:24 -0400
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D941F1276A;
        Sat,  6 Aug 2022 01:56:22 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 1EAC5C01C; Sat,  6 Aug 2022 10:56:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1659776181; bh=hCPs0hF3V5Rf9V+E1F9Ydwq3hmn8QXJCJt/HUNiS+nI=;
        h=Date:From:To:Cc:Subject:From;
        b=cQOJBrbBBWVY5pNz/9Qp78blIS/C4dcEopjiSsECKdHXVCZ1ZpX9+tEkM6tQsFaHl
         gaJ/CmFbveCK0aBUBoalDWIObkFBGUxVEtXJaFIt+QRrLMc5PFe59PIq69HAk4nt6A
         koDMuaiAXbJ1wwZgo3mOnqOUlLLBJdGjB3FhVQ21wo1rnFXMuLw/mM6rB4L9j5Y/FZ
         ce0W97cSzX6lgPbIfWn2kNu40ms4iXDH5X+CmxnBu+X6d6oIVSUVeyXn6H5slxK/hs
         mBtNGXwzd9eNsOSgHAlAM/QMfUioBTP0DyS7qyM6Vfw8AKxZjifo0JHKIOAxrkeOYY
         0GV5+3trYBqzQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 259C3C009;
        Sat,  6 Aug 2022 10:56:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1659776180; bh=hCPs0hF3V5Rf9V+E1F9Ydwq3hmn8QXJCJt/HUNiS+nI=;
        h=Date:From:To:Cc:Subject:From;
        b=MrKI9DMvvKnIgRZIYmdhtVhS71L7HCShPD+yvdvB3OgDRoeUVGSP2DazCgl2SHhBu
         yYfBCMNVxpDqNGpsfaygzPrQMi3tY5EGUBfoAcrOJNgKZoUwPt2Z8cfotcMoqSJHAD
         dfT12huYLleFxWPxAxkpG5C2Cc0QJHQN3nuCLgHtM4a+4htZ0Ofo7Q1dzMOxU+mxWA
         WJycMqBT4hQAeLzE8/4Z6k0Y3tXG3Xd1eHpDq2X6LBXh5BFxbxQ6dktHoR5vuN5cGJ
         IVPzT/MiyBEtvJKvNzhWS461GpQ58i1qxgSkSiST28fGBzcGCIdy4TdgD03/vOcHnS
         z5zaOoDxXuWcg==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 11a5f395;
        Sat, 6 Aug 2022 08:56:15 +0000 (UTC)
Date:   Sat, 6 Aug 2022 17:56:00 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] 9p for 5.20 (or 6.0)
Message-ID: <Yu4soPL07+/xDd3D@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,


Note this will conflict with Al Viro's "9p: convert to advancing variant
of iov_iter_get_pages_alloc()" that I believe he hasn't sent yet, but it
should be simple enough to untangle.

I also had a few more improvements tested locally I forgot to push to
-next, so I guess they'll wait for next cycle :/ Sorry Christian...



The following changes since commit 03c765b0e3b4cb5063276b086c76f7a612856a9a:

  Linux 5.19-rc4 (2022-06-26 14:22:10 -0700)

are available in the Git repository at:

  https://github.com/martinetd/linux tags/9p-for-5.20

for you to fetch changes up to aa7aeee169480e98cf41d83c01290a37e569be6d:

  net/9p: Initialize the iounit field during fid creation (2022-07-16 07:16:55 +0900)

----------------------------------------------------------------
9p-for-5.20

- a couple of fixes
- add a tracepoint for fid refcounting
- some cleanup/followup on fid lookup
- some cleanup around req refcounting

----------------------------------------------------------------
Dominique Martinet (4):
      9p fid refcount: add p9_fid_get/put wrappers
      9p fid refcount: add a 9p_fid_ref tracepoint
      9p fid refcount: cleanup p9_fid_put calls
      9p: roll p9_tag_remove into p9_req_put

Hangyu Hua (1):
      net: 9p: fix refcount leak in p9_read_work() error handling

Kent Overstreet (2):
      9p: Drop kref usage
      9p: Add client parameter to p9_req_put()

Tyler Hicks (5):
      9p: Track the root fid with its own variable during lookups
      9p: Make the path walk logic more clear about when cloning is required
      9p: Remove unnecessary variable for old fids while walking from d_parent
      9p: Fix minor typo in code comment
      net/9p: Initialize the iounit field during fid creation

Yang Li (1):
      9p: Fix some kernel-doc comments

 fs/9p/fid.c               |  61 ++++++++++++++-----------
 fs/9p/fid.h               |   6 +--
 fs/9p/vfs_addr.c          |   4 +-
 fs/9p/vfs_dentry.c        |   4 +-
 fs/9p/vfs_dir.c           |   2 +-
 fs/9p/vfs_file.c          |   9 ++--
 fs/9p/vfs_inode.c         |  89 ++++++++++++++++---------------------
 fs/9p/vfs_inode_dotl.c    |  82 +++++++++++++---------------------
 fs/9p/vfs_super.c         |   8 ++--
 fs/9p/xattr.c             |   8 ++--
 include/net/9p/client.h   |  49 ++++++++++++++++++--
 include/trace/events/9p.h |  48 ++++++++++++++++++++
 net/9p/client.c           | 168 +++++++++++++++++++++++++++++++++++----------------------------------
 net/9p/trans_fd.c         |  13 +++---
 net/9p/trans_rdma.c       |   2 +-
 net/9p/trans_virtio.c     |   4 +-
 net/9p/trans_xen.c        |   2 +-
 17 files changed, 314 insertions(+), 245 deletions(-)

-- 
Dominique
