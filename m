Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE9E72E79F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 17:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237109AbjFMPu4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 11:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235653AbjFMPuz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 11:50:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7348018C;
        Tue, 13 Jun 2023 08:50:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8023762FB0;
        Tue, 13 Jun 2023 15:50:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF18C433F0;
        Tue, 13 Jun 2023 15:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686671452;
        bh=eGtYzSC5vhQwDpz62uhZQHJIh1/WE3onYC23E6qI+Go=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=SnE2B+3uM0L84ENFnLRg/TRle5R2lfrPy/Xe5+XBqvR88/14Uq3UOMk7CIjuxQ4QY
         09bDY3C9Fg4kQLSPvsKX3VKTNtsNbcGTawyv8evk9demreez3Og43aTu5Zpe3FT9j5
         QWxTw+7VRKc6jVpSSZFwkUyBQUQYLy8/I5hlMxgs2dtMbLdZyiFs5nmPiGbggY7bXE
         JIxRRPPP/Ava4qxup490uCv+WxposN8oWgK+Q0wTDByDaz/wwFxXTYgfdiOd542f+k
         v4Kq1/AA4P9nUxAVgGiTwaX6SUU2nuZvYZwnseQM/GrTDL1hspsjJaxVW1XuHgOb5P
         nyQJMvdfxcEJA==
Date:   Tue, 13 Jun 2023 08:50:52 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     dchinner@redhat.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [ANNOUNCE] xfs-linux: for-next updated to b29434999371
Message-ID: <20230613155052.GK11441@frogsfrogsfrogs>
References: <168667107461.2567180.7349244362741585948.stg-ugh@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168667107461.2567180.7349244362741585948.stg-ugh@frogsfrogsfrogs>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 13, 2023 at 08:46:39AM -0700, Darrick J. Wong wrote:
> Hi folks,
> 
> The for-next branch of the xfs-linux repository at:
> 
> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
> 
> has just been updated.  This is all that we're going to be able to
> accomplish for 6.5 given the continuous trickle of bug reports within
> and external to XFS has pushed all the way past rc6.  If I've missed
> your patch, resend it **RIGHT NOW**.

...unless your patch is "[PATCH v4] xfs: fix ag count overflow during
growfs".  I missed that one, so I'll throw that into the branch and
probably push it by the end of the week.

--D

> Patches often get missed, so please check if your outstanding patches
> were in this update. If they have not been in this update, please
> resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
> the next update.
> 
> The new head of the for-next branch is commit:
> 
> b29434999371 xfs: set FMODE_CAN_ODIRECT instead of a dummy direct_IO method
> 
> 3 new commits:
> 
> Christoph Hellwig (1):
> [b29434999371] xfs: set FMODE_CAN_ODIRECT instead of a dummy direct_IO method
> 
> Darrick J. Wong (2):
> [06f3ef6e1705] xfs: don't deplete the reserve pool when trying to shrink the fs
> [61d7e8274cd8] xfs: drop EXPERIMENTAL tag for large extent counts
> 
> Code Diffstat:
> 
> fs/xfs/xfs_aops.c  |  2 --
> fs/xfs/xfs_file.c  |  2 +-
> fs/xfs/xfs_fsops.c | 10 +++++++---
> fs/xfs/xfs_super.c |  4 ----
> 4 files changed, 8 insertions(+), 10 deletions(-)
