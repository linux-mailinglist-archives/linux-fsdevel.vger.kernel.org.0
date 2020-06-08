Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDD21F1301
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jun 2020 08:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728906AbgFHGoF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jun 2020 02:44:05 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43376 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728334AbgFHGoF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jun 2020 02:44:05 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 28BD040B08E9AF0A973B;
        Mon,  8 Jun 2020 14:44:02 +0800 (CST)
Received: from [127.0.0.1] (10.166.213.7) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Mon, 8 Jun 2020
 14:43:53 +0800
Subject: Re: [PATCH v4] block: Fix use-after-free in blkdev_get()
To:     Christoph Hellwig <hch@lst.de>
CC:     <viro@zeniv.linux.org.uk>, <axboe@kernel.dk>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-block@vger.kernel.org>, Ming Lei <ming.lei@redhat.com>,
        Jan Kara <jack@suse.cz>, Hulk Robot <hulkci@huawei.com>
References: <20200608020557.31668-1-yanaijie@huawei.com>
 <20200608061502.GB17366@lst.de>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <0f43671d-c583-e5ec-f0a3-a919d300301f@huawei.com>
Date:   Mon, 8 Jun 2020 14:43:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200608061502.GB17366@lst.de>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.166.213.7]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph,

ÔÚ 2020/6/8 14:15, Christoph Hellwig Ð´µÀ:
> Looks good,
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Can you dig into the history for a proper fixes tag?
> 

This one started to accessing bdev after __blkdev_get(). So I think it 
may be a proper fixes tag:

Fixes: e525fd89d380 ("block: make blkdev_get/put() handle exclusive access")

Thanks,
Jason

> .
> 

