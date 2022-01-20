Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A17C349498D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jan 2022 09:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359219AbiATIeQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jan 2022 03:34:16 -0500
Received: from verein.lst.de ([213.95.11.211]:43542 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234116AbiATIeM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jan 2022 03:34:12 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id E093568AA6; Thu, 20 Jan 2022 09:34:07 +0100 (CET)
Date:   Thu, 20 Jan 2022 09:34:07 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Md . Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.co>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-nilfs@vger.kernel.org" <linux-nilfs@vger.kernel.org>,
        "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>
Subject: Re: [PATCH 14/19] block: pass a block_device and opf to
 blk_next_bio
Message-ID: <20220120083407.GA5321@lst.de>
References: <20220118071952.1243143-1-hch@lst.de> <20220118071952.1243143-15-hch@lst.de> <245eaa0a-0796-0227-4abf-d1b78953557e@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <245eaa0a-0796-0227-4abf-d1b78953557e@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 18, 2022 at 10:11:06PM +0000, Chaitanya Kulkarni wrote:
> On 1/17/22 11:19 PM, Christoph Hellwig wrote:
> > All callers need to set the block_device and operation, so lift that into
> > the common code.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> 
> I sent out the exact patch for this one, anyways looks good.
> 
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

I'll switch attribution to you.
