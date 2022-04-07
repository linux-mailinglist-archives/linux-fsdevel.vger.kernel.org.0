Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2E34F8324
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 17:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344777AbiDGP3T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Apr 2022 11:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344728AbiDGP3Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Apr 2022 11:29:16 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6730F1D8313;
        Thu,  7 Apr 2022 08:27:04 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id AE08468AFE; Thu,  7 Apr 2022 17:26:59 +0200 (CEST)
Date:   Thu, 7 Apr 2022 17:26:59 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, dm-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-um@lists.infradead.org, linux-block@vger.kernel.org,
        drbd-dev@lists.linbit.com, nbd@other.debian.org,
        ceph-devel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, jfs-discussion@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
        ocfs2-devel@oss.oracle.com, linux-mm@kvack.org
Subject: Re: [PATCH 07/27] btrfs: use bdev_max_active_zones instead of open
 coding it
Message-ID: <20220407152659.GA15200@lst.de>
References: <20220406060516.409838-1-hch@lst.de> <20220406060516.409838-8-hch@lst.de> <20220407152049.GH15609@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407152049.GH15609@twin.jikos.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 07, 2022 at 05:20:49PM +0200, David Sterba wrote:
> On Wed, Apr 06, 2022 at 08:04:56AM +0200, Christoph Hellwig wrote:
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> As it's a standalone patch I can take it (possibly with other similar
> prep btrfs patches) in current development cycle to relieve the
> inter-tree dependencies.

Unless there's a conflict in other btrfs patches it would probably be
easiest to merge everything through the block tree.
