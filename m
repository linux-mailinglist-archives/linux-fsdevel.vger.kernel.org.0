Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C81C42B0DCA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Nov 2020 20:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgKLTW1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Nov 2020 14:22:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:35714 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbgKLTW1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Nov 2020 14:22:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9C79EAFF8;
        Thu, 12 Nov 2020 19:22:25 +0000 (UTC)
Date:   Thu, 12 Nov 2020 20:22:23 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Justin Sanders <justin@coraid.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Roger Pau =?iso-8859-2?Q?Monn=E9?= <roger.pau@citrix.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        drbd-dev@lists.linbit.com, nbd@other.debian.org,
        ceph-devel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 05/24] block: remove the update_bdev parameter from
 set_capacity_revalidate_and_notify
Message-ID: <20201112192223.GA17194@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20201111082658.3401686-1-hch@lst.de>
 <20201111082658.3401686-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111082658.3401686-6-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph,

> The update_bdev argument is always set to true, so remove it.  Also
> rename the function to the slighly less verbose set_capacity_and_notify,
> as propagating the disk size to the block device isn't really
> revalidation.

> Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Nice cleanup.

Kind regards,
Petr
