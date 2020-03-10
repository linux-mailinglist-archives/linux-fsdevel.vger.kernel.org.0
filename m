Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1FF317F12D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Mar 2020 08:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgCJHkX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Mar 2020 03:40:23 -0400
Received: from verein.lst.de ([213.95.11.211]:51806 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbgCJHkX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Mar 2020 03:40:23 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E77ED68B20; Tue, 10 Mar 2020 08:40:18 +0100 (CET)
Date:   Tue, 10 Mar 2020 08:40:18 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     He Zhe <zhe.he@windriver.com>
Cc:     Christoph Hellwig <hch@lst.de>, jack@suse.cz,
        Jens Axboe <axboe@kernel.dk>, viro@zeniv.linux.org.uk,
        bvanassche@acm.org, keith.busch@intel.com, tglx@linutronix.de,
        mwilck@suse.com, yuyufen@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: disk revalidation updates and OOM
Message-ID: <20200310074018.GB26381@lst.de>
References: <93b395e6-5c3f-0157-9572-af0f9094dbd7@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93b395e6-5c3f-0157-9572-af0f9094dbd7@windriver.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 02, 2020 at 11:55:44AM +0800, He Zhe wrote:
> Hi,
> 
> Since the following commit
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-5.5/disk-revalidate&id=6917d0689993f46d97d40dd66c601d0fd5b1dbdd
> until now(v5.6-rc4),
> 
> If we start udisksd service of systemd(v244), systemd-udevd will scan /dev/hdc
> (the cdrom device created by default in qemu(v4.2.0)). systemd-udevd will
> endlessly run and cause OOM.
> 
> 
> 
> It works well by reverting the following series of commits.
> 
> 979c690d block: move clearing bd_invalidated into check_disk_size_change
> f0b870d block: remove (__)blkdev_reread_part as an exported API
> 142fe8f block: fix bdev_disk_changed for non-partitioned devices
> a1548b6 block: move rescan_partitions to fs/block_dev.c
> 6917d06 block: merge invalidate_partitions into rescan_partitions

So this is the exact requirement of commits to be reverted from a bisect
or just a first guess?
