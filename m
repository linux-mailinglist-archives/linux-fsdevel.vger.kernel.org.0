Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC252F2CAB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 11:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406094AbhALKX7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 05:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406091AbhALKX6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 05:23:58 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EB8C061575;
        Tue, 12 Jan 2021 02:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hNtqFD8/nqiSPk3hsMuqIwdqqr3vWdhwVU0SrPjpPJM=; b=F/q7BqwLVwyv7P3lWPVQq7VOVd
        e6NVgGooEHfK8Nkzo1q4J7V+uTvLdgAq/8gyAYqLagLgleLmTr1BDFbeXEmitcNO1+K1ddQqOpAh0
        Jtn1AvaWQ5O2IJQ9A5bDS9M265BHO/6kQvhYMOqsF7zAM7XCJIoVcFYgNCCo2B5iyVNtVgXBY2QDv
        YM5cHs63NvuOXH9iZMIvExPKu3MGR1pF3k5VRWg1QpkrzAbkLW5yQ1dc8Wx2qz/kIsM2uYudFoTVV
        /AMiPBjn6UjjyhKDHQurphSSqnrRi1t0UzAbZbME70Y6v601jmkA0WmwKATTqKMSj15n2uI/Sn2YT
        LbaC6J1Q==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1kzGpL-004dQv-9i; Tue, 12 Jan 2021 10:23:03 +0000
Date:   Tue, 12 Jan 2021 10:23:03 +0000
From:   "hch@infradead.org" <hch@infradead.org>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v11 00/40] btrfs: zoned block device support
Message-ID: <20210112102303.GA1104499@infradead.org>
References: <cover.1608515994.git.naohiro.aota@wdc.com>
 <20201222133805.GA6778@infradead.org>
 <SN4PR0401MB35987859AE05E238BE2221669BAB0@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB35987859AE05E238BE2221669BAB0@SN4PR0401MB3598.namprd04.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 11, 2021 at 10:17:53AM +0000, Johannes Thumshirn wrote:
> On 22/12/2020 14:40, Christoph Hellwig wrote:
> > I just did a very quick look, but didn't see anything (based on the
> > subjects) that deals with ITER_BVEC direct I/O.  Is the support for that
> > hidden somewhere?
> 
> I couldn't reproduce the problem you reported and asked for a reproducer. Probably
> the mail got lost somewhere.
> 
> Do you have a reproducer for me that triggers the problem? fio with --ioengine=io_uring
> didn't do the job on my end.

I've only found this by auditing the code.  But the reproducer should
be io_uring with fixed buffers, alternatively using the nvme target
driver with a btrfs file as the backend.
