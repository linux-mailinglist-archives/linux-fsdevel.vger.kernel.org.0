Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A3B7B0850
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 17:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbjI0PdD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 11:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbjI0PdC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:33:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE43121;
        Wed, 27 Sep 2023 08:33:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F40C433C7;
        Wed, 27 Sep 2023 15:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695828781;
        bh=rt/2P04R2n7tW9nb07C4FNQ4nl+kAW5+aLPzMfmR1qQ=;
        h=Date:From:To:Cc:Subject:From;
        b=c1CBkNTeQWHEjsq2Y5+6rBCjdNaugn4rKGlzRJfjykqcjZalJAnxnOVoAZGPzwM1T
         DurzUvYnXAx1IVkWwMvPFtS8+1MiN3kdqNZTSNMKQnIjDWT3ylouO2/CL2wQd10I66
         RefFXZKOAb+9mbfoB4qPIFJRn/7amM/kL0HVrXh25RMXFH7t4LeOi0//vQSnicabtV
         y5RlBzaUrGqSiGA4j9MDk31Dnp757cXj6LgpOQtBJmvGBcTNLWzg9JvP/6zH5lTlb3
         32658+pOktg8Xkc1PKqsqRqzoO7tyoMHLfJoOvcCnHxSqZuNiJ29XExJeA1kogPvhe
         U9+IiXBbaZAUg==
Date:   Wed, 27 Sep 2023 08:33:00 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     hch@lst.de, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org,
        syzbot+1fa947e7f09e136925b8@syzkaller.appspotmail.com
Subject: [ANNOUNCE] xfs-linux: iomap-for-next updated to 381c043233e6
Message-ID: <169582868033.102441.6749790940521233576.stg-ugh@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

The iomap-for-next branch of the xfs-linux repository at:

https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

has just been updated.

Patches often get missed, so please check if your outstanding patches
were in this update. If they have not been in this update, please
resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
the next update.

The new head of the iomap-for-next branch is commit:

381c043233e6 iomap: add a workaround for racy i_size updates on block devices

1 new commit:

Christoph Hellwig (1):
[381c043233e6] iomap: add a workaround for racy i_size updates on block devices

Code Diffstat:

fs/buffer.c | 11 ++++++++++-
1 file changed, 10 insertions(+), 1 deletion(-)
