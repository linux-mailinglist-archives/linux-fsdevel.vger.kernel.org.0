Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C791F2C6328
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Nov 2020 11:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgK0KgS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Nov 2020 05:36:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:40288 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726417AbgK0KgS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Nov 2020 05:36:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A2770AC75;
        Fri, 27 Nov 2020 10:36:16 +0000 (UTC)
Subject: Re: [PATCH 09/44] dm: remove the block_device reference in struct
 mapped_device
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Jan Kara <jack@suse.com>,
        linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <20201126130422.92945-1-hch@lst.de>
 <20201126130422.92945-10-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <38aa5185-1b96-f32f-9234-0d3a54a61119@suse.de>
Date:   Fri, 27 Nov 2020 11:36:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201126130422.92945-10-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/26/20 2:03 PM, Christoph Hellwig wrote:
> Get rid of the long-lasting struct block_device reference in
> struct mapped_device.  The only remaining user is the freeze code,
> where we can trivially look up the block device at freeze time
> and release the reference at thaw time.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Mike Snitzer <snitzer@redhat.com>
> ---
>   drivers/md/dm-core.h |  2 --
>   drivers/md/dm.c      | 25 ++++++++++++++-----------
>   2 files changed, 14 insertions(+), 13 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
