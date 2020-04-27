Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C537F1B9717
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 08:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgD0GQC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 02:16:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:42184 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbgD0GQC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 02:16:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0E0A7AC6D;
        Mon, 27 Apr 2020 06:16:00 +0000 (UTC)
Subject: Re: [PATCH 1/7] block: add a cdrom_device_info pointer to struct
 gendisk
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Tim Waugh <tim@cyberelk.net>, Borislav Petkov <bp@alien8.de>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>
References: <20200425075706.721917-1-hch@lst.de>
 <20200425075706.721917-2-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <262e6cc4-a0e7-821c-9e51-03a2ed5cba86@suse.de>
Date:   Mon, 27 Apr 2020 08:15:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200425075706.721917-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/25/20 9:57 AM, Christoph Hellwig wrote:
> Add a pointer to the CDROM information structure to struct gendisk.
> This will allow various removable media file systems to call directly
> into the CDROM layer instead of abusing ioctls with kernel pointers.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>   drivers/block/paride/pcd.c | 2 +-
>   drivers/cdrom/cdrom.c      | 5 ++++-
>   drivers/cdrom/gdrom.c      | 2 +-
>   drivers/ide/ide-cd.c       | 3 +--
>   drivers/scsi/sr.c          | 3 +--
>   include/linux/cdrom.h      | 2 +-
>   include/linux/genhd.h      | 9 +++++++++
>   7 files changed, 18 insertions(+), 8 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
