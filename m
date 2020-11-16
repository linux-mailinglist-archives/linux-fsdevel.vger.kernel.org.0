Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0572B4878
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Nov 2020 16:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731423AbgKPPF3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Nov 2020 10:05:29 -0500
Received: from verein.lst.de ([213.95.11.211]:54709 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730107AbgKPPF3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Nov 2020 10:05:29 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id C42D56736F; Mon, 16 Nov 2020 16:05:24 +0100 (CET)
Date:   Mon, 16 Nov 2020 16:05:24 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Justin Sanders <justin@coraid.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        linux-nvme@lists.infradead.org, Song Liu <song@kernel.org>,
        dm-devel@redhat.com, drbd-dev@lists.linbit.com,
        linux-scsi@vger.kernel.org, xen-devel@lists.xenproject.org,
        Ilya Dryomov <idryomov@gmail.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org,
        linux-raid@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
        ceph-devel@vger.kernel.org, linux-block@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Minchan Kim <minchan@kernel.org>,
        linux-fsdevel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Subject: Re: cleanup updating the size of block devices v3
Message-ID: <20201116150524.GA13367@lst.de>
References: <20201116145809.410558-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116145809.410558-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Oops,

this is a bigger patch bomb than intended.  Only patches 1-23 are this
series which should be ready to be applied once for-5.11/block pulles in
5.10-rc4.

After that follow patches already in for-5.11/block and my current hot
off the press development branch.
