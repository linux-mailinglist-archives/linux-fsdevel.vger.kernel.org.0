Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC98F75633
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2019 19:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730045AbfGYRuZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jul 2019 13:50:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49808 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbfGYRuY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jul 2019 13:50:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gA09uTP520+DTF2hbvI/7yy94RH4p4YdpNEly2D3hiE=; b=NlXL42m+P8l20ZGmxozAfD9AW
        KRKxSJOkUTvQl10MfwL7pToTFDZOhRnUh9xZJx1Md+VqUy8Rkb+/OTWH7XSWYuz0qRtM22S+bQtez
        fpJlt0Pu0QvTeaDzT0vIJxqqfy7TU5K7HdmHWriIA6hcd7wXEHROIPtyJ0RfiSsC+y5cZ55oUmNez
        +ZBtZgdXnwSqJKwcBjldQ9Yenq+7GnuBD+uKntEAT7Mi5dR/Vxce/12OtAeUDwl8DDvwJfNW01+qf
        YxgZ3Wxo8z2/UzaqBVWWr7ZGcSCJCT+JjhyFPAmZFcu2gQrsVFJzNcKH6LMX2EpD/KkqOswXnaEop
        TKsPQdOfw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hqhsl-00028P-Mb; Thu, 25 Jul 2019 17:50:23 +0000
Date:   Thu, 25 Jul 2019 10:50:23 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH v6 04/16] nvme-core: introduce nvme_get_by_path()
Message-ID: <20190725175023.GA30641@bombadil.infradead.org>
References: <20190725172335.6825-1-logang@deltatee.com>
 <20190725172335.6825-5-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725172335.6825-5-logang@deltatee.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 25, 2019 at 11:23:23AM -0600, Logan Gunthorpe wrote:
> nvme_get_by_path() is analagous to blkdev_get_by_path() except it
> gets a struct nvme_ctrl from the path to its char dev (/dev/nvme0).
> 
> The purpose of this function is to support NVMe-OF target passthru.

I can't find anywhere that you use this in this patchset.
