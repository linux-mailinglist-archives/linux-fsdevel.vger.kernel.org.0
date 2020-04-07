Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7085F1A126D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Apr 2020 19:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgDGRFZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Apr 2020 13:05:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44700 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgDGRFZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Apr 2020 13:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2RHgwpDIANz+TnMNAY7gYzCe9oaoHGyUcHrh9dYnfQI=; b=nRLhE7RHKiQWV33FNNNB6YDjwi
        sCMLN+xJvEET/eGBKdjulxTCOD+ldjCeEIkGL+dTtKljo5URT4hKnu60KsKRid3MskHAyNiwIW0Qa
        HOXXam0y98jy0GBJZh4cRuwkWzjNUBN6OhuqP5UZ61g8K3GJXUcFfL5rzJLXgWH9dkIgJqDbQx1HN
        PPOb9zPczF8M3GwqBhcMOMBZjfgX6bdtpx5Kh3L4aag7sNkVzbKXx/HOTVKpKL5ZfWaW3kPLdj+ad
        T9+TuPGOVHvnINMeh2oaewHBXyCGS4OIXkJu49n4L0iqTgyDyCMQWORIVKskyKce4hhBMMTEcA3NL
        BCcgn94g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLrfA-0001JV-MB; Tue, 07 Apr 2020 17:05:24 +0000
Date:   Tue, 7 Apr 2020 10:05:24 -0700
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
Subject: Re: [PATCH v4 08/10] null_blk: Support REQ_OP_ZONE_APPEND
Message-ID: <20200407170524.GG13893@infradead.org>
References: <20200403101250.33245-1-johannes.thumshirn@wdc.com>
 <20200403101250.33245-9-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403101250.33245-9-johannes.thumshirn@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 03, 2020 at 07:12:48PM +0900, Johannes Thumshirn wrote:
> From: Damien Le Moal <damien.lemoal@wdc.com>
> 
> Support REQ_OP_ZONE_APPEND requests for null_blk devices with zoned
> mode enabled. Use the internally tracked zone write pointer position
> as the actual write position and return it using the command request
> __sector field in the case of an mq device and using the command BIO
> sector in the case of a BIO device.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
