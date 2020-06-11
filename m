Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC011F623F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jun 2020 09:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbgFKH1F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jun 2020 03:27:05 -0400
Received: from verein.lst.de ([213.95.11.211]:49572 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbgFKH1F (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jun 2020 03:27:05 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 74AEE68AFE; Thu, 11 Jun 2020 09:27:03 +0200 (CEST)
Date:   Thu, 11 Jun 2020 09:27:03 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Brian Foster <bfoster@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] fs/fs-writeback.c: not WARN on unregistered BDI
Message-ID: <20200611072703.GA4876@lst.de>
References: <20200611072251.474246-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611072251.474246-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 11, 2020 at 03:22:51PM +0800, Ming Lei wrote:
> BDI is unregistered from del_gendisk() which is usually done in device's
> release handler from device hotplug or error handling context, so BDI
> can be unregistered anytime.
> 
> It should be normal for __mark_inode_dirty to see un-registered BDI,
> so kill the WARN().

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
