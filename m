Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0BF2B8C98
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Nov 2020 08:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbgKSHwa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Nov 2020 02:52:30 -0500
Received: from verein.lst.de ([213.95.11.211]:37875 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbgKSHwa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Nov 2020 02:52:30 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id E541867373; Thu, 19 Nov 2020 08:52:25 +0100 (CET)
Date:   Thu, 19 Nov 2020 08:52:25 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com, Richard Weinberger <richard@nod.at>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 07/20] init: refactor name_to_dev_t
Message-ID: <20201119075225.GA15815@lst.de>
References: <20201118084800.2339180-1-hch@lst.de> <20201118084800.2339180-8-hch@lst.de> <20201118143747.GL1981@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118143747.GL1981@quack2.suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 18, 2020 at 03:37:47PM +0100, Jan Kara wrote:
> > -static inline dev_t blk_lookup_devt(const char *name, int partno)
> > -{
> > -	dev_t devt = MKDEV(0, 0);
> > -	return devt;
> > -}
> >  #endif /* CONFIG_BLOCK */
> 
> This hunk looks unrelated to the change? Also why you move the declaration
> outside the CONFIG_BLOCK ifdef? AFAICS blk_lookup_devt() still exists only
> when CONFIG_BLOCK is defined? Otherwise the patch looks good to me.

blk_lookup_devt is a hack only for name_to_dev_t only referenced from
code under CONFIG_BLOCK now, as it didn't do anything before when
blk_lookup_devt returned 0.  I guess I'll need to update the commit log
a little to mention this.
