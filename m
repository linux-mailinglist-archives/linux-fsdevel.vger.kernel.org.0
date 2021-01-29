Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31D2E3082F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Jan 2021 02:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbhA2BHN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 20:07:13 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11217 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhA2BFE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 20:05:04 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DRfFy4p1VzlCJD;
        Fri, 29 Jan 2021 09:02:46 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.498.0; Fri, 29 Jan
 2021 09:04:19 +0800
Subject: Re: [f2fs-dev] [PATCH 08/17] f2fs: remove FAULT_ALLOC_BIO
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Song Liu <song@kernel.org>
CC:     Mike Snitzer <snitzer@redhat.com>, <linux-mm@kvack.org>,
        <dm-devel@redhat.com>, <drbd-dev@lists.linbit.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        <linux-nilfs@vger.kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        <linux-nfs@vger.kernel.org>, Coly Li <colyli@suse.de>,
        <linux-raid@vger.kernel.org>, <linux-bcache@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        <linux-block@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-fsdevel@vger.kernel.org>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        <linux-btrfs@vger.kernel.org>
References: <20210126145247.1964410-1-hch@lst.de>
 <20210126145247.1964410-9-hch@lst.de>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <3301f2da-60c5-79ca-ab3b-0fe3345f0731@huawei.com>
Date:   Fri, 29 Jan 2021 09:04:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210126145247.1964410-9-hch@lst.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/1/26 22:52, Christoph Hellwig wrote:
> Sleeping bio allocations do not fail, which means that injecting an error
> into sleeping bio allocations is a little silly.
> 
> Signed-off-by: Christoph Hellwig<hch@lst.de>

Acked-by: Chao Yu <yuchao0@huawei.com>

Thanks,

