Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8305270ACB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Sep 2020 07:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgISFP0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Sep 2020 01:15:26 -0400
Received: from verein.lst.de ([213.95.11.211]:34874 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbgISFP0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Sep 2020 01:15:26 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 811BE68BEB; Sat, 19 Sep 2020 07:15:20 +0200 (CEST)
Date:   Sat, 19 Sep 2020 07:15:20 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        Minchan Kim <minchan@kernel.org>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, nbd@other.debian.org,
        linux-ide@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        linux-pm@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 02/14] block: switch register_disk to use
 blkdev_get_by_dev
Message-ID: <20200919051520.GA7070@lst.de>
References: <20200917165720.3285256-1-hch@lst.de> <20200917165720.3285256-3-hch@lst.de> <091931b1-eb9c-e45e-c9e8-501554618508@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <091931b1-eb9c-e45e-c9e8-501554618508@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 18, 2020 at 11:52:39AM +0300, Sergei Shtylyov wrote:
> Hello!
>
> On 17.09.2020 19:57, Christoph Hellwig wrote:
>
>> Use blkdev_get_by_dev instead of open coding it using bdget_disk +
>> blkdev_get.
>
>    I don't see where you are removing bdget_disk() call (situated just before
> the below code?)...

Indeed.  That's what you get for a messy last minute rebase.. :(
