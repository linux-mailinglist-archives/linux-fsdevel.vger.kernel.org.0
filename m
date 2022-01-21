Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D556E4957B1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jan 2022 02:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241709AbiAUB1B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jan 2022 20:27:01 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:6978 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235635AbiAUB1A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jan 2022 20:27:00 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AD3gOAa2yDBqa5TPV1vbD5bhwkn2cJEfYwER7XOP?=
 =?us-ascii?q?LsXnJhz0kgzEOm2sXDGGOaP2INmH2c9EjaYS0pBsH75fRmtA2QQE+nZ1PZygU8?=
 =?us-ascii?q?JKaX7x1DatR0xu6d5SFFAQ+hyknQoGowPscEzmM9n9BDpC79SMmjfjSHuKnYAL?=
 =?us-ascii?q?5EnsZqTFMGX5JZS1Ly7ZRbr5A2bBVMivV0T/Ai5S31GyNh1aYBlkpB5er83uDi?=
 =?us-ascii?q?hhdVAQw5TTSbdgT1LPXeuJ84Jg3fcldJFOgKmVY83LTegrN8F251juxExYFAdX?=
 =?us-ascii?q?jnKv5c1ERX/jZOg3mZnh+AvDk20Yd4HdplPtT2Pk0MC+7jx2Tgtl308QLu5qrV?=
 =?us-ascii?q?S8nI6/NhP8AFRJfFkmSOIUfoueZfSng7JL7I0ruNiGEL+9VJE0/I4wU0uhtBmR?=
 =?us-ascii?q?J7/YZNHYGaRXrr+K9wJq6TOd2j8guJcWtO5kQ0llsxDefD7A5QJTHQqzP/vdZ2?=
 =?us-ascii?q?is9goZFGvO2T8Ybdj1pYzzDbgdJN1NRD4gx9M+sh3/iY3hdrXqWu6M84C7U1gM?=
 =?us-ascii?q?Z+L7zPNvQf/SORN5JhQCcp2Tb7yL1Dw9yHN6WzzfD+XKxrujVlCj/VcQZE7jQ3?=
 =?us-ascii?q?vprhkCDg2IIBBAIWF+Tv/a0kAi9VshZJkhS/TAhxYA29Uq2Xpz+Uge+rXqsoBE?=
 =?us-ascii?q?RQZxTHvc85QXLzbDbiy6dB24ZXntRZscOqsA7X3op20WPktevAiZg2IB541r1G?=
 =?us-ascii?q?qy89Gv0YHZKazRZI3JscOfM2PG7yKlbs/4FZowL/HaJs+DI?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ACrA9n6BhfpRbnSvlHemQ55DYdb4zR+YMi2TD?=
 =?us-ascii?q?tnoBLSC9F/b0qynAppomPGDP4gr5NEtApTniAtjkfZq/z+8X3WB5B97LMzUO01?=
 =?us-ascii?q?HYTr2Kg7GD/xTQXwX69sN4kZxrarVCDrTLZmRSvILX5xaZHr8brOW6zA=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,303,1635177600"; 
   d="scan'208";a="120649756"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 21 Jan 2022 09:26:58 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 1F8CD4D15A5C;
        Fri, 21 Jan 2022 09:26:54 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 21 Jan 2022 09:26:54 +0800
Received: from [192.168.22.28] (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 21 Jan 2022 09:26:51 +0800
Message-ID: <76f5ed28-2df9-890e-0674-3ef2f18e2c2f@fujitsu.com>
Date:   Fri, 21 Jan 2022 09:26:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v9 02/10] dax: Introduce holder for dax_device
To:     Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     "Darrick J. Wong" <djwong@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        david <david@fromorbit.com>, Jane Chu <jane.chu@oracle.com>
References: <20211226143439.3985960-1-ruansy.fnst@fujitsu.com>
 <20211226143439.3985960-3-ruansy.fnst@fujitsu.com>
 <20220105181230.GC398655@magnolia>
 <CAPcyv4iTaneUgdBPnqcvLr4Y_nAxQp31ZdUNkSRPsQ=9CpMWHg@mail.gmail.com>
 <20220105185626.GE398655@magnolia>
 <CAPcyv4h3M9f1-C5e9kHTfPaRYR_zN4gzQWgR+ZyhNmG_SL-u+A@mail.gmail.com>
 <20220105224727.GG398655@magnolia>
 <CAPcyv4iZ88FPeZC1rt_bNdWHDZ5oh7ua31NuET2-oZ1UcMrH2Q@mail.gmail.com>
 <20220105235407.GN656707@magnolia>
 <CAPcyv4gUmpDnGkhd+WdhcJVMP07u+CT8NXRjzcOTp5KF-5Yo5g@mail.gmail.com>
 <YekhXENAEYJJNy7e@infradead.org>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <YekhXENAEYJJNy7e@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-yoursite-MailScanner-ID: 1F8CD4D15A5C.A23A8
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2022/1/20 16:46, Christoph Hellwig 写道:
> On Wed, Jan 05, 2022 at 04:12:04PM -0800, Dan Williams wrote:
>> We ended up with explicit callbacks after hch balked at a notifier
>> call-chain, but I think we're back to that now. The partition mistake
>> might be unfixable, but at least bdev_dax_pgoff() is dead. Notifier
>> call chains have their own locking so, Ruan, this still does not need
>> to touch dax_read_lock().
> 
> I think we have a few options here:
> 
>   (1) don't allow error notifications on partitions.  And error return from
>       the holder registration with proper error handling in the file
>       system would give us that
>   (2) extent the holder mechanism to cover a range
>   (3) bite the bullet and create a new stacked dax_device for each
>       partition
> 
> I think (1) is the best option for now.  If people really do need
> partitions we'll have to go for (3)

Yes, I agree.  I'm doing it the first way right now.

I think that since we can use namespace to divide a big NVDIMM into 
multiple pmems, partition on a pmem seems not so meaningful.


--
Thanks,
Ruan.


