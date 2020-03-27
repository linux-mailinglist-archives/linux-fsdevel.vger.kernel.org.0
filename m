Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3383D195C08
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Mar 2020 18:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbgC0RKY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Mar 2020 13:10:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50026 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgC0RKY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Mar 2020 13:10:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XJvMD9j5zk0OC/aZRfkm557u41RXjoamon7TMxfYje8=; b=Q6MbwLlMuBhAVPlRXC+m9HK7kz
        XBCm3dOOPZDgUaL6JlVWVi44TbZet93CfrAFC4862RovZqzs0HGYnAdksskFuSTQOjZy9FOV5s8E4
        XauBoj+ShWytrRKSAnLL5fcBt12hw4cFVmjr0/kHZFAT4BvZju/2LXUrEfPVfwVW7oNDuaiQi1BZv
        9ebRjA9tjVSU3wFEZY10M3OSdWmKDYlYuHfNb4TOJIcUjhtgAv+eDC6fWyBtNVfi/PLh3nvtnVHpG
        JYgF8MfpYhX5X7lAOaRCFoLOoM6n7EXdDe4h8itYXAz0oBwcW5iDYV7nhbODyyNGtdCSdUG1KmMZx
        XE3e6FZA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHsUw-0004yt-QS; Fri, 27 Mar 2020 17:10:22 +0000
Date:   Fri, 27 Mar 2020 10:10:22 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 01/10] block: provide fallbacks for
 blk_queue_zone_is_seq and blk_queue_zone_no
Message-ID: <20200327171022.GC11524@infradead.org>
References: <20200327165012.34443-1-johannes.thumshirn@wdc.com>
 <20200327165012.34443-2-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327165012.34443-2-johannes.thumshirn@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 28, 2020 at 01:50:03AM +0900, Johannes Thumshirn wrote:
> blk_queue_zone_is_seq() and blk_queue_zone_no() have not been called with
> CONFIG_BLK_DEV_ZONED disabled until now.
> 
> The introduction of REQ_OP_ZONE_APPEND will change this, so we need to
> provide noop fallbacks for the !CONFIG_BLK_DEV_ZONED case.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
