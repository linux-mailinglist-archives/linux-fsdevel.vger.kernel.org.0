Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEE942F212
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 15:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235848AbhJON1A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 09:27:00 -0400
Received: from verein.lst.de ([213.95.11.211]:54515 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232572AbhJON06 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 09:26:58 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6D9E668BEB; Fri, 15 Oct 2021 15:24:49 +0200 (CEST)
Date:   Fri, 15 Oct 2021 15:24:49 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Pankaj Raghav <pankydev8@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Wunderlich, Mark" <mark.wunderlich@intel.com>,
        "Vasudevan, Anil" <anil.vasudevan@intel.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 14/16] block: switch polling to be bio based
Message-ID: <20211015132449.GA30212@lst.de>
References: <20211012111226.760968-1-hch@lst.de> <20211012111226.760968-15-hch@lst.de> <20211015083026.3geaix6r6kcnncu7@quentin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015083026.3geaix6r6kcnncu7@quentin>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 15, 2021 at 10:30:26AM +0200, Pankaj Raghav wrote:
> > @@ -568,7 +569,8 @@ blk_status_t errno_to_blk_status(int errno);
> >  #define BLK_POLL_ONESHOT		(1 << 0)
> >  /* do not sleep to wait for the expected completion time */
> >  #define BLK_POLL_NOSLEEP		(1 << 1)
> Minor comment: Could we also have a flag #define BLK_POLL_SPIN 0?
> It can improve the readability from the caller side instead of having
> just a 0 to indicate spinning.

The above are flags, so adding a define for a value is a bit counter
productive.
