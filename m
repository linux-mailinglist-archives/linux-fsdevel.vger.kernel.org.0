Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE5C7A869F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 16:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbjITOdV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 10:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234713AbjITOdV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 10:33:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C066AF;
        Wed, 20 Sep 2023 07:33:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17CA2C433C7;
        Wed, 20 Sep 2023 14:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695220395;
        bh=OfPM2VjEMxxB2Al87Fb7g/5rfRN0JdLaPjh7Id1vWHE=;
        h=Date:From:To:Cc:Subject:From;
        b=TKgaYgwIX2PA1xwcW8tYFceDXxsj2N3ktAMYEAGndSF6dtGy7LlzXTEDC6JPPuxQP
         hLpm+MW0wkiGkcLl/c21Lsf3YzuzyWqNtuGRrggFXf1WnChV25dwLspru752mTxltu
         fcskwhLRcc6s3+J4mw8x3q8AZOL54L0aIKCHYaqMMC434DoxBDV6cS+JHoPVUdPdC1
         4YbLUDHGsk4pgK3scytHkCJBfpsoBrEXIHyc8uvoRrnsx2yhmyGFmlrdA2boQslW0A
         3tX9OjlcA+da4j9Lm0hCLIrS01o9lohRP1JMymowMvj91RuPDaPja/Jab47n4o12UU
         3A6GgvDYrpQiw==
Date:   Wed, 20 Sep 2023 07:33:14 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     dlemoal@kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
        willy@infradead.org,
        syzbot+4a08ffdf3667b36650a1@syzkaller.appspotmail.com
Subject: [ANNOUNCE] xfs-linux: iomap-for-next updated to a5f31a5028d1
Message-ID: <169522033601.2411704.6101112461828724666.stg-ugh@frogsfrogsfrogs>
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

a5f31a5028d1 iomap: convert iomap_unshare_iter to use large folios

3 new commits:

Christoph Hellwig (1):
[4aa8cdd5e523] iomap: handle error conditions more gracefully in iomap_to_bh

Darrick J. Wong (2):
[35d30c9cf127] iomap: don't skip reading in !uptodate folios when unsharing a range
[a5f31a5028d1] iomap: convert iomap_unshare_iter to use large folios

Code Diffstat:

fs/buffer.c            | 25 ++++++++++++++-----------
fs/iomap/buffered-io.c | 30 ++++++++++++++++++------------
2 files changed, 32 insertions(+), 23 deletions(-)
