Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 633DF1ACF70
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 20:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbgDPSRS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 14:17:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:45962 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbgDPSRS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 14:17:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 865D5AB71;
        Thu, 16 Apr 2020 18:17:15 +0000 (UTC)
Date:   Thu, 16 Apr 2020 20:17:14 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v6 03/11] block: rename __bio_add_pc_page to
 bio_add_hw_page
Message-ID: <20200416181714.yjzqg3x6nlxzqfbt@carbon>
References: <20200415090513.5133-1-johannes.thumshirn@wdc.com>
 <20200415090513.5133-4-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415090513.5133-4-johannes.thumshirn@wdc.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 15, 2020 at 06:05:05PM +0900, Johannes Thumshirn wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> Rename __bio_add_pc_page() to bio_add_hw_page() and explicitly pass in a
> max_sectors argument.
> 
> This max_sectors argument can be used to specify constraints from the
> hardware.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> [ jth: rebased and made public for blk-map.c ]
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

As far as I can tell, it looks good.

Reviewed-by: Daniel Wagner <dwagner@suse.de>
