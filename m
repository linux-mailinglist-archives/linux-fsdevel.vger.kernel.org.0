Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2580740D4FB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Sep 2021 10:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235290AbhIPIut (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Sep 2021 04:50:49 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:8573 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235295AbhIPIus (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Sep 2021 04:50:48 -0400
IronPort-Data: =?us-ascii?q?A9a23=3A4RFknata6+LEC8JdMQgqKSy4i+fnVEZfMUV32f8?=
 =?us-ascii?q?akzHdYEJGY0x3zGAYWm6HPv3Za2SmL99/boy/9ktQuJGGx4c2TQBvqS9gHilAw?=
 =?us-ascii?q?SbnLY7Hdx+vZUt+DSFioHpPtpxYMp+ZRCwNZie0SiyFb/6x8BGQ6YnSHuClUL+?=
 =?us-ascii?q?dZHgoLeNZYHxJZSxLyrdRbrFA0YDR7zOl4bsekuWHULOX82cc3lE8t8pvnChSU?=
 =?us-ascii?q?MHa41v0iLCRicdj5zcyn1FNZH4WyDrYw3HQGuG4FcbiLwrPIS3Qw4/Xw/stIov?=
 =?us-ascii?q?NfrfTeUtMTKPQPBSVlzxdXK3Kbhpq/3R0i/hkcqFHLxo/ZzahxridzP1XqJW2U?=
 =?us-ascii?q?hZvMKvXhMwTThtZDzpje6ZB/dcrJFDm6JDOkRGbKyWEL/JGSRte0Zcj0up+H2B?=
 =?us-ascii?q?C3fICLzUKdBqCm6S9x7fTYvZtgsAyBMjtMpkWtnxpwXfeF/lOaZzKRePIo8BZ2?=
 =?us-ascii?q?DMxj8VVNffYe8cdLzFoaXzobx9QPVEYIJEzhuGlgj/4aTIwgEiUuacs42j7yA1?=
 =?us-ascii?q?3zairMdDQPNeNQK19mFiUp2fD12D4GQ0BctiezyeVtH6hmIfnnSj7cIYJCPu0+?=
 =?us-ascii?q?5ZCmlKUwmAMGRs+TkagrL+1hyaWX9NZNlxR9DEioLY/8GS1QdTnGR61uniJulg?=
 =?us-ascii?q?bQdU4O+k77hydj6nZ+QCUAkAaQTNbLt8rrsk7QXotzFDht9foAyF/9a2bUlqD+?=
 =?us-ascii?q?bqO6zC/Iy4YKSkFfyBsZRUE+d7Lsow1jwyJStdlDb7zicf6Xyzzqw1mBgBWa64?=
 =?us-ascii?q?71JZNjvvkuwucxW/Em3QAdSZtji2/Y45vxloRiFaZWrGV?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ATIgbQa5lZdAbEfTAlwPXwPTXdLJyesId70hD?=
 =?us-ascii?q?6qkRc20wTiX8ra2TdZsguyMc9wx6ZJhNo7G90cq7MBbhHPxOkOos1N6ZNWGIhI?=
 =?us-ascii?q?LCFvAB0WKN+V3dMhy73utc+IMlSKJmFeD3ZGIQse/KpCW+DPYsqePqzJyV?=
X-IronPort-AV: E=Sophos;i="5.85,297,1624291200"; 
   d="scan'208";a="114564506"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 16 Sep 2021 16:49:26 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id D7E564D0DC71;
        Thu, 16 Sep 2021 16:49:21 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 16 Sep 2021 16:49:22 +0800
Received: from [127.0.0.1] (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 16 Sep 2021 16:49:20 +0800
Subject: Re: [PATCH v9 5/8] fsdax: Add dax_iomap_cow_copy() for dax_iomap_zero
To:     Christoph Hellwig <hch@lst.de>
CC:     <djwong@kernel.org>, <linux-xfs@vger.kernel.org>,
        <dan.j.williams@intel.com>, <david@fromorbit.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <rgoldwyn@suse.de>,
        <viro@zeniv.linux.org.uk>, <willy@infradead.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>
References: <20210915104501.4146910-1-ruansy.fnst@fujitsu.com>
 <20210915104501.4146910-6-ruansy.fnst@fujitsu.com>
 <20210916061654.GB13306@lst.de>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
Message-ID: <9fb0c82f-b2ae-82e3-62df-f0a473ed6395@fujitsu.com>
Date:   Thu, 16 Sep 2021 16:49:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210916061654.GB13306@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-yoursite-MailScanner-ID: D7E564D0DC71.A0D63
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2021/9/16 14:16, Christoph Hellwig wrote:
> On Wed, Sep 15, 2021 at 06:44:58PM +0800, Shiyang Ruan wrote:
>> +	rc = dax_direct_access(iomap->dax_dev, pgoff, 1, &kaddr, NULL);
>> +	if (rc < 0)
>> +		goto out;
>> +	memset(kaddr + offset, 0, size);
>> +	if (srcmap->addr != IOMAP_HOLE && srcmap->addr != iomap->addr) {
> 
> Should we also check that ->dax_dev for iomap and srcmap are different
> first to deal with case of file system with multiple devices?

I have not thought of this case.  Isn't it possible to CoW between 
different devices?


--
Thanks,
Ruan

> 
> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 


