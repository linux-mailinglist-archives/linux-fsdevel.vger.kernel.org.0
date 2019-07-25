Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0DD757D3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2019 21:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfGYT0Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jul 2019 15:26:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39936 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbfGYT0Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jul 2019 15:26:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BvJfAiV7y1bt1QsTdKGqKWc9bBWeOKVa3Zdi7n7uICU=; b=GEemGIEUXmry2MJXAjVXQDGF0
        XF3FT3klB2ey0oBCEDsN72DpYlo8141rse50i45Eq6a3jFCCwbCg/eIV5t7Gc6uAT7VBxVGGD4F0F
        RtMsUtkuhKTWfBA6VXNvNjfMfjcF7qbl3/Rxc9VSt62GWBO23HCrbN0lwsC+1KyfQAP5IPGEhUnYj
        KO8yzpJig7ZG3LTI+Zo7V+1yfmcHeh2Wu1xA5q20foCnUJ038vvLBBQfXSoSYEKKFFwXniYYsO9kH
        3pOKNvyV6Em7Vnc+UT0DoTTSdy9kTa7a39bhtEgVbkuuk+GgFMEEV+2BhwO9e1PIAocHYP+mQ6Tl/
        vp7uGtzFg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hqjNZ-0002S1-WB; Thu, 25 Jul 2019 19:26:18 +0000
Date:   Thu, 25 Jul 2019 12:26:17 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Stephen Bates <sbates@raithlin.com>,
        linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Max Gurtovoy <maxg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v6 02/16] chardev: introduce cdev_get_by_path()
Message-ID: <20190725192613.GF30641@bombadil.infradead.org>
References: <20190725172335.6825-3-logang@deltatee.com>
 <20190725174032.GA27818@kroah.com>
 <682ff89f-04e0-7a94-5aeb-895ac65ee7c9@deltatee.com>
 <20190725180816.GA32305@kroah.com>
 <da0eacb7-3738-ddf3-8c61-7ffc61aa41f4@deltatee.com>
 <20190725182701.GA11547@kroah.com>
 <20190725190024.GD30641@bombadil.infradead.org>
 <27943e06-a503-162e-356b-abb9e106ab2e@grimberg.me>
 <20190725191124.GE30641@bombadil.infradead.org>
 <425dd2ac-333d-a8c4-ce49-870c8dadf436@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425dd2ac-333d-a8c4-ce49-870c8dadf436@deltatee.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 25, 2019 at 01:24:22PM -0600, Logan Gunthorpe wrote:
> >> Assuming that there is a open handle somewhere out there...
> 
> Yes, that would be a step backwards from an interface. The user would
> then need a special process to open the fd and pass it through configfs.
> They couldn't just do it with basic bash commands.

echo 3 3</dev/nvme3 >/configfs/foor/bar/whatever

