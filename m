Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B78492C38EF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 07:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgKYGH7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Nov 2020 01:07:59 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:7981 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgKYGH7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Nov 2020 01:07:59 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Cgr5m3R7Vzhh8Q;
        Wed, 25 Nov 2020 14:07:40 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 25 Nov
 2020 14:07:42 +0800
Subject: Re: [PATCH 04/45] fs: simplify freeze_bdev/thaw_bdev
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, "Mike Snitzer" <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        <dm-devel@redhat.com>, Richard Weinberger <richard@nod.at>,
        Jan Kara <jack@suse.com>, <linux-block@vger.kernel.org>,
        <xen-devel@lists.xenproject.org>, <linux-bcache@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-mm@kvack.org>
References: <20201124132751.3747337-1-hch@lst.de>
 <20201124132751.3747337-5-hch@lst.de>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <4ae2d8ca-e858-e5df-67ef-d14852978976@huawei.com>
Date:   Wed, 25 Nov 2020 14:07:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20201124132751.3747337-5-hch@lst.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/11/24 21:27, Christoph Hellwig wrote:
> Store the frozen superblock in struct block_device to avoid the awkward
> interface that can return a sb only used a cookie, an ERR_PTR or NULL.
> 
> Signed-off-by: Christoph Hellwig<hch@lst.de>
> ---
>   drivers/md/dm-core.h      |  5 -----
>   drivers/md/dm.c           | 20 ++++++--------------
>   fs/block_dev.c            | 39 ++++++++++++++++-----------------------
>   fs/buffer.c               |  2 +-
>   fs/ext4/ioctl.c           |  2 +-
>   fs/f2fs/file.c            | 14 +++++---------

For f2fs part,

Acked-by: Chao Yu <yuchao0@huawei.com>

Thanks,

>   fs/xfs/xfs_fsops.c        |  7 ++-----
>   include/linux/blk_types.h |  1 +
>   include/linux/blkdev.h    |  4 ++--
>   9 files changed, 34 insertions(+), 60 deletions(-)
