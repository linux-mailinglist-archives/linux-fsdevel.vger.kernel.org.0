Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 362472C3902
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 07:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgKYGM6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Nov 2020 01:12:58 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8582 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbgKYGM6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Nov 2020 01:12:58 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CgrCH57LvzLtxm;
        Wed, 25 Nov 2020 14:12:27 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 25 Nov
 2020 14:12:51 +0800
Subject: Re: [PATCH 43/45] f2fs: remove a few bd_part checks
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
 <20201124132751.3747337-44-hch@lst.de>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <2c7a8f2a-37a3-38c2-9256-6aae2c7a45c1@huawei.com>
Date:   Wed, 25 Nov 2020 14:12:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20201124132751.3747337-44-hch@lst.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/11/24 21:27, Christoph Hellwig wrote:
> bd_part is never NULL for a block device in use by a file system, so
> remove the checks.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
