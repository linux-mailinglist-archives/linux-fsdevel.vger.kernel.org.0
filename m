Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9BB7B2264
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 18:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjI1Qbf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 12:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbjI1QbT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 12:31:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF93CD4;
        Thu, 28 Sep 2023 09:31:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE6CC433C9;
        Thu, 28 Sep 2023 16:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695918672;
        bh=OpxRQ8HoPKyTqpTkR2r+Bxz6oBQzCmSl/N1wHjv0Rs0=;
        h=Date:From:To:Cc:Subject:From;
        b=gm/IaDkmZ6srkR7Vh4uYVaP/BGFCAOPzZU9VJ7bt5rOCe4C098sqPjiA9Dc4mGdz9
         KiRsIRAWqGIf7wn7TAJDBqkuymJgyEEtXz1QOesY7wm0yrn38633SyVErivSwAkX/c
         HujEFMRAwATWIqbXJqMsmLwg7ejYDwKuYGwlYBFxTSQBI35d9uEZw6SqnOIEuhIMo3
         rOUvwXc1zxvO750URR2D313HXSvLmrLf6/hUnUJRCKElDKfcisUKyXlvIDkZG+iBln
         6ievWkP5JswioUGCigVLEoeKjeSzLHeSQNXfrK1rG+BUDTNYfcLb1UaETQ+m4k3CSk
         9JG0w9YHHXZiw==
Date:   Thu, 28 Sep 2023 09:31:12 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     bodonnel@redhat.com, geert+renesas@glider.be, hch@lst.de,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        syzbot+1fa947e7f09e136925b8@syzkaller.appspotmail.com
Subject: [ANNOUNCE] xfs-linux: iomap-for-next updated to 684f7e6d28e8
Message-ID: <169591855904.1033762.9330299516240907704.stg-ugh@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

684f7e6d28e8 iomap: Spelling s/preceeding/preceding/g

2 new commits:

Christoph Hellwig (1):
[381c043233e6] iomap: add a workaround for racy i_size updates on block devices

Geert Uytterhoeven (1):
[684f7e6d28e8] iomap: Spelling s/preceeding/preceding/g

Code Diffstat:

fs/buffer.c            | 11 ++++++++++-
fs/iomap/buffered-io.c |  2 +-
2 files changed, 11 insertions(+), 2 deletions(-)
