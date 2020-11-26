Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 533A32C5B7C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 19:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404732AbgKZSEL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 13:04:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:33030 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404611AbgKZSEK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 13:04:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8607EAC55;
        Thu, 26 Nov 2020 18:04:08 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1FC061E10D0; Thu, 26 Nov 2020 19:04:08 +0100 (CET)
Date:   Thu, 26 Nov 2020 19:04:08 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Jan Kara <jack@suse.com>,
        linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 29/44] block: remove the nr_sects field in struct
 hd_struct
Message-ID: <20201126180408.GB422@quack2.suse.cz>
References: <20201126130422.92945-1-hch@lst.de>
 <20201126130422.92945-30-hch@lst.de>
 <20201126165036.GO422@quack2.suse.cz>
 <20201126175208.GA24843@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126175208.GA24843@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 26-11-20 18:52:08, Christoph Hellwig wrote:
> On Thu, Nov 26, 2020 at 05:50:36PM +0100, Jan Kara wrote:
> > > +	if (size == capacity ||
> > > +	    (disk->flags & (GENHD_FL_UP | GENHD_FL_HIDDEN)) != GENHD_FL_UP)
> > > +		return false;
> > > +	pr_info("%s: detected capacity change from %lld to %lld\n",
> > > +		disk->disk_name, size, capacity);
> > > +	kobject_uevent_env(&disk_to_dev(disk)->kobj, KOBJ_CHANGE, envp);
> > 
> > I think we don't want to generate resize event for changes from / to 0...
> 
> Didn't you ask for that in the last round?

I've asked for the message - which you've added :). But the udev event was
correct in the previous version IMHO...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
