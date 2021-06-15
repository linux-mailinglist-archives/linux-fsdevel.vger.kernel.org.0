Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872153A860C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 18:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbhFOQI1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 12:08:27 -0400
Received: from verein.lst.de ([213.95.11.211]:50106 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229488AbhFOQI1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 12:08:27 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id AB5D067373; Tue, 15 Jun 2021 18:06:19 +0200 (CEST)
Date:   Tue, 15 Jun 2021 18:06:19 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Wunderlich, Mark" <mark.wunderlich@intel.com>,
        "Vasudevan, Anil" <anil.vasudevan@intel.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: switch block layer polling to a bio based model v4
Message-ID: <20210615160619.GA32435@lst.de>
References: <20210615131034.752623-1-hch@lst.de> <20210615143706.GB646237@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615143706.GB646237@dhcp-10-100-145-180.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 15, 2021 at 07:37:06AM -0700, Keith Busch wrote:
> On Tue, Jun 15, 2021 at 03:10:18PM +0200, Christoph Hellwig wrote:
> > Chances since v3:
> >  - rebased to the latests for-5.14/block tree
> >  - fix the refcount logic in __blkdev_direct_IO
> >  - split up a patch to make it easier to review
> >  - grab a queue reference in bio_poll
> >  - better document the RCU assumptions in bio_poll
> 
> It still doesn't look like a failover will work when polling through
> pvsync2. We previously discussed that here:
> 
>   https://marc.info/?l=linux-block&m=162100971816071&w=2

Yes, sorry for losing this.  I'll resend with that added after a short
delay to see if anything else needs attention.
