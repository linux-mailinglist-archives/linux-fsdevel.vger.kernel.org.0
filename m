Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF386363BCE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Apr 2021 08:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbhDSGqD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Apr 2021 02:46:03 -0400
Received: from verein.lst.de ([213.95.11.211]:45308 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231433AbhDSGqB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Apr 2021 02:46:01 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8535E6736F; Mon, 19 Apr 2021 08:45:29 +0200 (CEST)
Date:   Mon, 19 Apr 2021 08:45:29 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH v2 3/3] zonefs: fix synchronous write to sequential
 zone files
Message-ID: <20210419064529.GA19041@lst.de>
References: <20210417023323.852530-1-damien.lemoal@wdc.com> <20210417023323.852530-4-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210417023323.852530-4-damien.lemoal@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 17, 2021 at 11:33:23AM +0900, Damien Le Moal wrote:
> Synchronous writes to sequential zone files cannot use zone append
> operations if the underlying zoned device queue limit
> max_zone_append_sectors is 0, indicating that the device does not
> support this operation. In this case, fall back to using regular write
> operations.

Zone append is a mandatory feature of the zoned device API.
