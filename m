Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2515A2B7A22
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 10:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725767AbgKRJN1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 04:13:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:44562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbgKRJN1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 04:13:27 -0500
Received: from localhost (unknown [89.205.136.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 080C124656;
        Wed, 18 Nov 2020 09:13:24 +0000 (UTC)
Date:   Wed, 18 Nov 2020 10:13:21 +0100
From:   Greg KH <greg@kroah.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com, Richard Weinberger <richard@nod.at>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: merge struct block_device and struct hd_struct
Message-ID: <X7TlsaY2vWQceNAI@kroah.com>
References: <20201118084800.2339180-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118084800.2339180-1-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 18, 2020 at 09:47:40AM +0100, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series cleans up our main per-device node data structure by merging
> the block_device and hd_struct data structures that have the same scope,
> but different life times.  The main effect (besides removing lots of
> code) is that instead of having two device sizes that need complex
> synchronization there is just one now.
> 
> Note that it depends on the previous "misc cleanups" series.
> 
> A git tree is available here:
> 
>     git://git.infradead.org/users/hch/block.git bdev-lookup
> 
> Gitweb:
> 
>     http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/bdev-lookup

Nice cleanups, thanks for doing this.

Series is:
	Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
