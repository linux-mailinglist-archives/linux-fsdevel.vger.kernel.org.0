Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9BCE180338
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Mar 2020 17:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgCJQ0v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Mar 2020 12:26:51 -0400
Received: from verein.lst.de ([213.95.11.211]:53864 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbgCJQ0v (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Mar 2020 12:26:51 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9499D68BE1; Tue, 10 Mar 2020 17:26:47 +0100 (CET)
Date:   Tue, 10 Mar 2020 17:26:47 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     He Zhe <zhe.he@windriver.com>
Cc:     Christoph Hellwig <hch@lst.de>, jack@suse.cz,
        Jens Axboe <axboe@kernel.dk>, viro@zeniv.linux.org.uk,
        bvanassche@acm.org, keith.busch@intel.com, tglx@linutronix.de,
        mwilck@suse.com, yuyufen@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: disk revalidation updates and OOM
Message-ID: <20200310162647.GA6361@lst.de>
References: <93b395e6-5c3f-0157-9572-af0f9094dbd7@windriver.com> <20200310074018.GB26381@lst.de> <75865e17-48f8-a63a-3a29-f995115ffcfc@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75865e17-48f8-a63a-3a29-f995115ffcfc@windriver.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 10, 2020 at 11:30:27PM +0800, He Zhe wrote:
> > So this is the exact requirement of commits to be reverted from a bisect
> > or just a first guess?
> 
> Many commits failed to build or boot during bisection.
> 
> At least the following four have to be reverted to make it work.
> 
> 979c690d block: move clearing bd_invalidated into check_disk_size_change
> f0b870d block: remove (__)blkdev_reread_part as an exported API
> 142fe8f block: fix bdev_disk_changed for non-partitioned devices
> a1548b6 block: move rescan_partitions to fs/block_dev.c

Just to make sure we are on the same page:  if you revert all four it
works, if you rever all but

a1548b6 block: move rescan_partitions to fs/block_dev.c

it doesn't?
