Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE91294D15
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Oct 2020 14:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442688AbgJUMzO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Oct 2020 08:55:14 -0400
Received: from mx2.veeam.com ([64.129.123.6]:40766 "EHLO mx2.veeam.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408370AbgJUMzN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Oct 2020 08:55:13 -0400
Received: from mail.veeam.com (spbmbx01.amust.local [172.17.17.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id 661E941522;
        Wed, 21 Oct 2020 08:55:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com; s=mx2;
        t=1603284909; bh=2WNQUIxgOW2iFvaa4bExrsGr7EjcAQp8DYCCLGE7JMM=;
        h=Date:From:To:CC:Subject:References:In-Reply-To:From;
        b=rf3ZDaAfuvv3l21JLrs05Gxqw/IPsjDjtfvmOoECBJKxS8ovF8zs+KV/k20jv8zWg
         wkDyl1Ks62gC+mvsqU6YX+5DxgEpGF091/fNDJiffeYGVhRxlndv2f/kZgjpxnQ+Wc
         6WxeXS+YlEVLntMnIl+A65OwqBihPpIlwH55KjG8=
Received: from veeam.com (172.24.14.5) by spbmbx01.amust.local (172.17.17.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.595.3; Wed, 21 Oct 2020
 15:55:06 +0300
Date:   Wed, 21 Oct 2020 15:55:55 +0300
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "hch@infradead.org" <hch@infradead.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "jack@suse.cz" <jack@suse.cz>, "tj@kernel.org" <tj@kernel.org>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "osandov@fb.com" <osandov@fb.com>,
        "koct9i@gmail.com" <koct9i@gmail.com>,
        "steve@sk2.org" <steve@sk2.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 1/2] Block layer filter - second version
Message-ID: <20201021125555.GE20749@veeam.com>
References: <1603271049-20681-1-git-send-email-sergei.shtepa@veeam.com>
 <1603271049-20681-2-git-send-email-sergei.shtepa@veeam.com>
 <BL0PR04MB65141320C7BF75B7142CA30CE71C0@BL0PR04MB6514.namprd04.prod.outlook.com>
 <20201021114438.GK20115@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20201021114438.GK20115@casper.infradead.org>
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: spbmbx01.amust.local (172.17.17.171) To
 spbmbx01.amust.local (172.17.17.171)
X-EsetResult: clean, is OK
X-EsetId: 37303A295605D26A677566
X-Veeam-MMEX: True
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The 10/21/2020 14:44, Matthew Wilcox wrote:
> On Wed, Oct 21, 2020 at 09:21:36AM +0000, Damien Le Moal wrote:
> > > + * submit_bio_direct - submit a bio to the block device layer for I/O
> > > + * bypass filter.
> > > + * @bio:  The bio describing the location in memory and on the device.
> > >   *
> > > + * Description:
> 
> You don't need this line.
> 
> > > + *    This is a version of submit_bio() that shall only be used for I/O
> > > + *    that cannot be intercepted by block layer filters.
> > > + *    All file systems and other upper level users of the block layer
> > > + *    should use submit_bio() instead.
> > > + *    Use this function to access the swap partition and directly access
> > > + *    the block device file.
> 
> I don't understand why O_DIRECT gets to bypass the block filter.  Nor do
> I understand why anybody would place a block filter on the swap device.
> But if somebody did place a filter on the swap device, why should swap
> be able to bypass the filter?
> 

I am very happy to hear such a question. You are really trying to
understand the algorithm.

Yes, intercepting the swap partition is absurd. But we can't guarantee
that the filter won't intercept swap.

Swap operation is related to the memory allocation logic. If a swap on
the block device are accessed during memory allocation from filter,
a deadlock occurs. We can allow filters to occasionally shoot off their
feet, especially under high load. But I think it's better not to do it.

"directly access" - it is not O_DIRECT. This means (I think) direct
reading from the device file, like "dd if=/dev/sda1".
As for intercepting direct reading, I don't know how to do the right thing.

The problem here is that in fs/block_dev.c in function __blkdev_direct_IO()
uses the qc - value returned by the submit_bio() function.
This value is used below when calling 
blk_poll(bdev_get_queue(dev), qc, true).
The filter cannot return a meaningful value of the blk_qc_t type when
intercepting a request, because at that time it does not know which queue
the request will fall into.

If function submit_bio() will always return BLK_QC_T_NONE - I think the
algorithm of the __blk dev_direct_IO() will not work correctly.
If we need to intercept direct access to a block device, we need to at
least redo the __blkdev_direct_IO function, getting rid of blk_pool.
I'm not sure it's necessary yet.

-- 
Sergei Shtepa
Veeam Software developer.
