Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC4ED443E00
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Nov 2021 09:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbhKCIIW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Nov 2021 04:08:22 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:15354 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbhKCIIV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Nov 2021 04:08:21 -0400
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HkfTT17R2z90k7;
        Wed,  3 Nov 2021 16:05:33 +0800 (CST)
Received: from [127.0.0.1] (10.40.193.166) by dggeme756-chm.china.huawei.com
 (10.3.19.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.15; Wed, 3
 Nov 2021 16:05:41 +0800
Subject: Re: [PATCH 14/16] block: switch polling to be bio based
To:     Christoph Hellwig <hch@lst.de>
References: <20211012111226.760968-1-hch@lst.de>
 <20211012111226.760968-15-hch@lst.de>
 <beb633f4-4508-ea53-4a34-adf0f20cda85@hisilicon.com>
 <20211103072223.GB31003@lst.de>
CC:     Jens Axboe <axboe@kernel.dk>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Wunderlich, Mark" <mark.wunderlich@intel.com>,
        "Vasudevan, Anil" <anil.vasudevan@intel.com>,
        <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
From:   "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <eb91f95b-4cb2-ef6f-a204-15b8b0077f81@hisilicon.com>
Date:   Wed, 3 Nov 2021 16:05:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20211103072223.GB31003@lst.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.193.166]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggeme756-chm.china.huawei.com (10.3.19.102)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2021/11/3 15:22, Christoph Hellwig 写道:
> On Wed, Nov 03, 2021 at 03:11:25PM +0800, chenxiang (M) wrote:
>> For some scsi command sent by function __scsi_execute() without data, it
>> has request but no bio (bufflen = 0),
>> then how to use bio_poll() for them ?
> You can't send these requests as polled.  Note that these are passthrough
> requests only.

Understood, thanks.

