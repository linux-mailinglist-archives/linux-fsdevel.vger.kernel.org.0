Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C773479D750
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 19:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234211AbjILRM3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Sep 2023 13:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235804AbjILRM1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:12:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8991702;
        Tue, 12 Sep 2023 10:12:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD35EC433C8;
        Tue, 12 Sep 2023 17:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694538743;
        bh=CnTeVSCSftGPKnUW2TdqTKpAWopq3fyTXAOWl/GCd2w=;
        h=Date:From:To:Cc:Subject:From;
        b=Q99UBnWQVeKAtwyndUmWW8BTp73oU/RfVbmGEkYjtRGTtqkkKdKuYWPZxuZ7juaXa
         DWkCrXRKIPp3MEKeF4r4rEe3LlvLoFcCVZsXwwpxsLuQit4eiAy+7vqInaCwwyyNf0
         /odKFFEENPPaRPi6h/bRp4MQoiFU+voGx6oITsDjROrKxaRGDqP7KKsjZwN2wyLemM
         mCBeqsPI40syUrTULehlP9ajp3x8PL5l8upWWZCqi49+/xopxNvwVT4oGTK2UIBWGE
         VyWuGjYeei3STQRXifxEGqZzVux6ermYcmLDpsIDenAn3k8Ltq1Kkjui+9g8Y9PTgK
         /JKOMxhiHR5/Q==
Date:   Tue, 12 Sep 2023 10:12:23 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     david@fromorbit.com, djwong@kernel.org
Cc:     dlemoal@kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org,
        syzbot+4a08ffdf3667b36650a1@syzkaller.appspotmail.com
Subject: [ANNOUNCE] xfs-linux: iomap-for-next updated to 4aa8cdd5e523
Message-ID: <169453870377.3386711.11069925599324555600.stg-ugh@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

4aa8cdd5e523 iomap: handle error conditions more gracefully in iomap_to_bh

1 new commit:

Christoph Hellwig (1):
[4aa8cdd5e523] iomap: handle error conditions more gracefully in iomap_to_bh

Code Diffstat:

fs/buffer.c | 25 ++++++++++++++-----------
1 file changed, 14 insertions(+), 11 deletions(-)
