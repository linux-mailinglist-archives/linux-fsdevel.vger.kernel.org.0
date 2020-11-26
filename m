Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF7F52C5B4E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 19:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404010AbgKZSC2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 13:02:28 -0500
Received: from verein.lst.de ([213.95.11.211]:35314 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391698AbgKZSC1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 13:02:27 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id B348768B05; Thu, 26 Nov 2020 19:02:23 +0100 (CET)
Date:   Thu, 26 Nov 2020 19:02:23 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Jan Kara <jack@suse.com>,
        linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 36/44] block: allocate struct hd_struct as part of
 struct bdev_inode
Message-ID: <20201126180223.GA25921@lst.de>
References: <20201126130422.92945-1-hch@lst.de> <20201126130422.92945-37-hch@lst.de> <20201126173518.GV422@quack2.suse.cz> <20201126180048.GA422@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126180048.GA422@quack2.suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 26, 2020 at 07:00:48PM +0100, Jan Kara wrote:
> > I don't think hd_struct holds a reference to block_device, does it?
> > bdev_alloc() now just assigns bdev->bd_part->bdev = bdev...
> 
> Now I understood this is probably correct - each partition (including
> gendisk as 0 partition) holds the initial bdev reference and only when
> corresponding kobject is getting destroyed we stop holding onto that
> reference. Right?

Yes.
