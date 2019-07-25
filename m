Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEC8E7577D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2019 21:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfGYTA0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jul 2019 15:00:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56428 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbfGYTAZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jul 2019 15:00:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=T12SANXJfFYGAgoypYepvPduiF69NIPuQswfYpT9irw=; b=l8FB5LIMV6v7FUzlsTxEQEgEt
        sYro009Akgm0ixWwNSlGthAnEQgNl1iQFyHCu1a3RgQlxVxqBANR1p9gZ2y7GEywWQ9aDahvzUiVP
        Zs7V6DPQm1qPQIzYhov0+BhUQ52M02dK3QuPm3HzGlFZU3Y7xR7qV8f3xR7QqSiwVikvwTV6pI6Am
        mWOOyyRp0q8dTEpuomnAvNgjREwacnPoB/C/PNOBkQ3nbEEVz2inA+QEhT/cZrAE9D0dqwpksdM+n
        SFhQ2eKPAajA9RgBLos3BC0H7I/y2iOFuCevwBD3y5NogKUmK1M8VGzAQMg2nGEWO0vdbiA92btPP
        9FihCjsVg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hqiyW-0001Cp-7l; Thu, 25 Jul 2019 19:00:24 +0000
Date:   Thu, 25 Jul 2019 12:00:24 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v6 02/16] chardev: introduce cdev_get_by_path()
Message-ID: <20190725190024.GD30641@bombadil.infradead.org>
References: <20190725172335.6825-1-logang@deltatee.com>
 <20190725172335.6825-3-logang@deltatee.com>
 <20190725174032.GA27818@kroah.com>
 <682ff89f-04e0-7a94-5aeb-895ac65ee7c9@deltatee.com>
 <20190725180816.GA32305@kroah.com>
 <da0eacb7-3738-ddf3-8c61-7ffc61aa41f4@deltatee.com>
 <20190725182701.GA11547@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725182701.GA11547@kroah.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 25, 2019 at 08:27:01PM +0200, Greg Kroah-Hartman wrote:
> > NVMe-OF is configured using configfs. The target is specified by the
> > user writing a path to a configfs attribute. This is the way it works
> > today but with blkdev_get_by_path()[1]. For the passthru code, we need
> > to get a nvme_ctrl instead of a block_device, but the principal is the same.
> 
> Why isn't a fd being passed in there instead of a random string?

I suppose we could echo a string of the file descriptor number there,
and look up the fd in the process' file descriptor table ...

I'll get my coat.

