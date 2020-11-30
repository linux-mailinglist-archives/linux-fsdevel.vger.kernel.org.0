Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48E4D2C7ED6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 08:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgK3Hi5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 02:38:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:51862 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbgK3Hi5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 02:38:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 22488AD2B;
        Mon, 30 Nov 2020 07:38:15 +0000 (UTC)
Subject: Re: [PATCH 28/45] block: simplify part_to_disk
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
References: <20201128161510.347752-1-hch@lst.de>
 <20201128161510.347752-29-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <e5139146-f464-d5cc-cdef-ff67ca7c1f05@suse.de>
Date:   Mon, 30 Nov 2020 08:38:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201128161510.347752-29-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/28/20 5:14 PM, Christoph Hellwig wrote:
> Now that struct hd_struct has a block_device pointer use that to
> find the disk.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Acked-by: Tejun Heo <tj@kernel.org>
> ---
>   include/linux/genhd.h | 10 +++-------
>   1 file changed, 3 insertions(+), 7 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
