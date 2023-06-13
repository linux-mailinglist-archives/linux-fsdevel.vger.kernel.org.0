Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E22D72E796
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 17:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242924AbjFMPqq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 11:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241126AbjFMPqo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 11:46:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCF51A3;
        Tue, 13 Jun 2023 08:46:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A356637E5;
        Tue, 13 Jun 2023 15:46:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC45C433D9;
        Tue, 13 Jun 2023 15:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686671200;
        bh=BsWGtqdyRHXk+sbOGoYzMy0v+2aN7HtelLL5GhvlhMY=;
        h=Date:From:To:Cc:Subject:From;
        b=LTaGuFITpRayOJj2YxqVp0oK3VujgMTYi26t6/JI4iZ3nBan5PMQpNaTfO0MHGWPs
         iMljMjIf6ze71gqZ9bsKBWGpYSkYojJJiS3+X4y2mXExWrSbfLyNtPE4fbkvqOG0Bo
         5hoVLtKYXCt3d6eXrYcDSbIHkZ9C61hhqPQxmmEZjZqiYLXUWH4txR7D8XPb9RnbNK
         mEeJSik/krp5cETfAwe3aiDWxNqhLkcYnWcLGXSNEvwXtUXJti8VbC0kpvvs1NniY9
         6+qu8CTzFmaoF9Zu8SlbYdra4ds3e7sELarod0zLtLYFGgRzSCHr4o7rAH7sFf7jVW
         1IyICRLaoUjBw==
Date:   Tue, 13 Jun 2023 08:46:39 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     dchinner@redhat.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: [ANNOUNCE] xfs-linux: for-next updated to b29434999371
Message-ID: <168667107461.2567180.7349244362741585948.stg-ugh@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

The for-next branch of the xfs-linux repository at:

git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

has just been updated.  This is all that we're going to be able to
accomplish for 6.5 given the continuous trickle of bug reports within
and external to XFS has pushed all the way past rc6.  If I've missed
your patch, resend it **RIGHT NOW**.

Patches often get missed, so please check if your outstanding patches
were in this update. If they have not been in this update, please
resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
the next update.

The new head of the for-next branch is commit:

b29434999371 xfs: set FMODE_CAN_ODIRECT instead of a dummy direct_IO method

3 new commits:

Christoph Hellwig (1):
[b29434999371] xfs: set FMODE_CAN_ODIRECT instead of a dummy direct_IO method

Darrick J. Wong (2):
[06f3ef6e1705] xfs: don't deplete the reserve pool when trying to shrink the fs
[61d7e8274cd8] xfs: drop EXPERIMENTAL tag for large extent counts

Code Diffstat:

fs/xfs/xfs_aops.c  |  2 --
fs/xfs/xfs_file.c  |  2 +-
fs/xfs/xfs_fsops.c | 10 +++++++---
fs/xfs/xfs_super.c |  4 ----
4 files changed, 8 insertions(+), 10 deletions(-)
