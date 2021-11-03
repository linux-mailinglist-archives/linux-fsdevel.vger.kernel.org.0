Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0167D443DA5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Nov 2021 08:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhKCHZE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Nov 2021 03:25:04 -0400
Received: from verein.lst.de ([213.95.11.211]:58531 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232034AbhKCHZD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Nov 2021 03:25:03 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D56F168AA6; Wed,  3 Nov 2021 08:22:23 +0100 (CET)
Date:   Wed, 3 Nov 2021 08:22:23 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "chenxiang (M)" <chenxiang66@hisilicon.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Wunderlich, Mark" <mark.wunderlich@intel.com>,
        "Vasudevan, Anil" <anil.vasudevan@intel.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH 14/16] block: switch polling to be bio based
Message-ID: <20211103072223.GB31003@lst.de>
References: <20211012111226.760968-1-hch@lst.de> <20211012111226.760968-15-hch@lst.de> <beb633f4-4508-ea53-4a34-adf0f20cda85@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <beb633f4-4508-ea53-4a34-adf0f20cda85@hisilicon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 03, 2021 at 03:11:25PM +0800, chenxiang (M) wrote:
> For some scsi command sent by function __scsi_execute() without data, it 
> has request but no bio (bufflen = 0),
> then how to use bio_poll() for them ?

You can't send these requests as polled.  Note that these are passthrough
requests only.
