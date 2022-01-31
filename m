Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFB84A4D6E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 18:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381067AbiAaRkc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 12:40:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350348AbiAaRkb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 12:40:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB699C061714;
        Mon, 31 Jan 2022 09:40:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 011E9B82BD9;
        Mon, 31 Jan 2022 17:40:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D8A0C340E8;
        Mon, 31 Jan 2022 17:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643650827;
        bh=7gaHDKzMLcuJaZXsIPIudbe8FRjTrQEWRT/5bqBsGMg=;
        h=Date:From:To:Cc:Subject:From;
        b=gZkzZlCTSwHoyTguiHVsKfGGX6DRn4cKfLjnFJJhQGAOCbImJxApqlANR04as5Lmz
         ugdHXF8OoLUizK/u72Ay/hEltLjZvqwJyb8m32b2LrE99Js8jJSJ5SjCENzynSQ72c
         WRFWIPIlA1PFzrGvsab22hEStegwQDcxO+l3LYSJwT+8dLat7Na35Ua2uqyWLWmkNf
         cwyvlqt0hxnJq6g5lxn838gAv4V66oKVC3C/9umn9hHy3vvx8hVEPto7i513gioVfJ
         KHUy7a0vKd5k/KtEm3Gv7pKlfScIvE8l9XTDEKBzU7/IYMBcBsnzL1K+h0BYg6LUIy
         PiP3lNGvDUpSA==
Date:   Mon, 31 Jan 2022 09:40:27 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, jack@suse.cz,
        hch@lst.de
Subject: [ANNOUNCE] xfs-linux: vfs-for-next updated to 2d86293c7075
Message-ID: <20220131174027.GE8313@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

The vfs-for-next branch of the xfs-linux repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

has just been updated.

Patches often get missed, so please check if your outstanding patches
were in this update. If they have not been in this update, please
resubmit them to linux-fsdevel@vger.kernel.org so they can be picked up
in the next update.  Granted, this /is/ merely my tree of random vfs
stuff...

The new head of the vfs-for-next branch is commit:

2d86293c7075 xfs: return errors in xfs_fs_sync_fs

4 new commits:

Darrick J. Wong (4):
      [2719c7160dcf] vfs: make freeze_super abort when sync_filesystem returns error
      [5679897eb104] vfs: make sync_filesystem return errors from ->sync_fs
      [dd5532a4994b] quota: make dquot_quota_sync return errors from ->sync_fs
      [2d86293c7075] xfs: return errors in xfs_fs_sync_fs

Code Diffstat:

 fs/quota/dquot.c   | 11 ++++++++---
 fs/super.c         | 19 ++++++++++++-------
 fs/sync.c          | 18 ++++++++++++------
 fs/xfs/xfs_super.c |  6 +++++-
 4 files changed, 37 insertions(+), 17 deletions(-)
