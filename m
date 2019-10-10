Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D30FD26E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2019 12:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387505AbfJJKGG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Oct 2019 06:06:06 -0400
Received: from verein.lst.de ([213.95.11.211]:57364 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727770AbfJJKGG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Oct 2019 06:06:06 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id EA25668C65; Thu, 10 Oct 2019 12:06:02 +0200 (CEST)
Date:   Thu, 10 Oct 2019 12:06:02 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH v9 11/12] block: call blk_account_io_start() in
 blk_execute_rq_nowait()
Message-ID: <20191010100602.GB27209@lst.de>
References: <20191009192530.13079-1-logang@deltatee.com> <20191009192530.13079-13-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009192530.13079-13-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 09, 2019 at 01:25:29PM -0600, Logan Gunthorpe wrote:
> All existing users of blk_execute_rq[_nowait]() are for passthrough
> commands and will thus be rejected by blk_do_io_stat().
> 
> This allows passthrough requests to opt-in to IO accounting by setting
> RQF_IO_STAT.

This kinda goes along with the previous patch, so I suggest you
merge them.  I also think you just want to send that merged patch off
directly to Jens ASAP.
