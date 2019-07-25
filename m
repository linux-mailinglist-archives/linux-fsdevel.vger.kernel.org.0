Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 029BF75889
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2019 22:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfGYUBa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jul 2019 16:01:30 -0400
Received: from mga12.intel.com ([192.55.52.136]:18882 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726166AbfGYUBa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jul 2019 16:01:30 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2019 13:01:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,307,1559545200"; 
   d="scan'208";a="175361989"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga006.jf.intel.com with ESMTP; 25 Jul 2019 13:01:28 -0700
Date:   Thu, 25 Jul 2019 13:58:35 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH v6 04/16] nvme-core: introduce nvme_get_by_path()
Message-ID: <20190725195835.GA7317@localhost.localdomain>
References: <20190725172335.6825-1-logang@deltatee.com>
 <20190725172335.6825-5-logang@deltatee.com>
 <20190725175023.GA30641@bombadil.infradead.org>
 <da58f91e-6cfa-02e0-dd89-3cfa23764a0e@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da58f91e-6cfa-02e0-dd89-3cfa23764a0e@deltatee.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 25, 2019 at 11:54:18AM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2019-07-25 11:50 a.m., Matthew Wilcox wrote:
> > On Thu, Jul 25, 2019 at 11:23:23AM -0600, Logan Gunthorpe wrote:
> >> nvme_get_by_path() is analagous to blkdev_get_by_path() except it
> >> gets a struct nvme_ctrl from the path to its char dev (/dev/nvme0).
> >>
> >> The purpose of this function is to support NVMe-OF target passthru.
> > 
> > I can't find anywhere that you use this in this patchset.
> > 
> 
> Oh sorry, the commit message is out of date the function was actually
> called nvme_ctrl_get_by_path() and it's used in Patch 10.

Instead of by path, could we have configfs take something else, like
the unique controller instance or serial number? I know that's different
than how we handle blocks and files, but that way nvme core can lookup
the cooresponding controller without adding new cdev dependencies.
