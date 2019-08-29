Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0F99A1393
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 10:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfH2IZB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 04:25:01 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3537 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725782AbfH2IZA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 04:25:00 -0400
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 66BEA57C469BD2F7E54A;
        Thu, 29 Aug 2019 16:24:57 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 29 Aug 2019 16:24:56 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Thu, 29 Aug 2019 16:24:56 +0800
Date:   Thu, 29 Aug 2019 16:24:09 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, <linux-fsdevel@vger.kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Valdis =?gbk?Q?Kl=A8=A5tnieks?= <valdis.kletnieks@vt.edu>,
        <linux-kernel@vger.kernel.org>, <yuchao0@huawei.com>,
        <miaoxie@huawei.com>, "Theodore Y. Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers@kernel.org>,
        Zefan Li <lizefan@huawei.com>
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to staging
Message-ID: <20190829082409.GA83154@architecture4>
References: <20190828160817.6250-1-gregkh@linuxfoundation.org>
 <20190828170022.GA7873@kroah.com>
 <20190829062340.GB3047@infradead.org>
 <20190829070149.GA155353@architecture4>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190829070149.GA155353@architecture4>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme718-chm.china.huawei.com (10.1.199.114) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph,

On Thu, Aug 29, 2019 at 03:01:49PM +0800, Gao Xiang wrote:
> Hi Christoph,
> 
> On Wed, Aug 28, 2019 at 11:23:40PM -0700, Christoph Hellwig wrote:
> > Can we please just review the damn thing and get it into the proper
> > tree?  That whole concept of staging file systems just has been one
> > fricking disaster, including Greg just moving not fully reviewed ones
> > over like erofs just because he feels like it.  I'm getting sick and
> > tired of this scheme.
> 
> I just want to a word on EROFS stuff (I'm not suitable to comment
> on the current exfat implementation). Since EROFS stuff has been
> in staging tree for more than a year, anyone who wants to review
> it can review this filesystem at any time.
> 
> EROFS is not just a homebrew or experimental fs for now, it has been
> widely used for many commerical smartphones, and we will upstream it
> to AOSP for more Android smartphones after it gets merged to upstream.
> I personally cc-ed you for a month, and I didn't get any objection
> from others (including Linus) for about 2 months. That isn't because
> of someone likes it, rather we cannot make no progress compared with
> some exist fs community because this is our love work.
> 
> And it's self-contained driver at least, and it's disabled by default,
> It cannot be stayed in staging tree to do a lot of EROFS feature
> improvements itself forever (since it is cleaned enough).
> It has proven its validity as well.

It seems I misunderstood your idea, sorry about that... EROFS
properly uses vfs interfaces (e.g. we also considered RCU symlink
lookup path at the very beginning of our design as Al said [1],
except for mount interface as Al mentioned [2] (thanks him for
taking some time on it), it was used for our debugging use),
and it didn't cause any extra burden to vfs or other subsystems.

[1] https://lore.kernel.org/r/20190325045744.GK2217@ZenIV.linux.org.uk/
[2] https://lore.kernel.org/r/20190720224955.GD17978@ZenIV.linux.org.uk/

Thanks,
Gao Xiang

> 
> Thanks,
> Gao Xiang
> 
