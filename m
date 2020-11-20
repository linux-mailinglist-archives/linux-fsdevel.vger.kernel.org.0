Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A393E2BA377
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 08:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbgKTHfg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 02:35:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:57910 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbgKTHfg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 02:35:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7837DAB3D;
        Fri, 20 Nov 2020 07:35:34 +0000 (UTC)
Subject: Re: [PATCH 59/78] mtip32xx: remove the call to fsync_bdev on removal
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Justin Sanders <justin@coraid.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        drbd-dev@lists.linbit.com, nbd@other.debian.org,
        ceph-devel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20201116145809.410558-1-hch@lst.de>
 <20201116145809.410558-60-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <5ee8dd18-f420-280c-84b9-78b70f528e26@suse.de>
Date:   Fri, 20 Nov 2020 08:35:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201116145809.410558-60-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/16/20 3:57 PM, Christoph Hellwig wrote:
> del_gendisk already calls fsync_bdev for every partition, no need
> to do this twice.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/block/mtip32xx/mtip32xx.c | 15 ---------------
>   drivers/block/mtip32xx/mtip32xx.h |  2 --
>   2 files changed, 17 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
