Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19358A17AC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 13:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfH2LFe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 07:05:34 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:54658 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727080AbfH2LFd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 07:05:33 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 16F821B307E7087152BD;
        Thu, 29 Aug 2019 19:05:31 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 29 Aug 2019 19:05:30 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Thu, 29 Aug 2019 19:05:30 +0800
Date:   Thu, 29 Aug 2019 19:04:43 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Valdis =?gbk?Q?Kl=A8=A5tnieks?= <valdis.kletnieks@vt.edu>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        "OGAWA Hirofumi" <hirofumi@mail.parknet.co.jp>
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to staging
Message-ID: <20190829110443.GD64893@architecture4>
References: <20190828160817.6250-1-gregkh@linuxfoundation.org>
 <20190828170022.GA7873@kroah.com>
 <20190829062340.GB3047@infradead.org>
 <20190829063955.GA30193@kroah.com>
 <20190829094136.GA28643@infradead.org>
 <20190829095019.GA13557@kroah.com>
 <20190829103749.GA13661@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190829103749.GA13661@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme707-chm.china.huawei.com (10.1.199.103) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 29, 2019 at 03:37:49AM -0700, Christoph Hellwig wrote:
> On Thu, Aug 29, 2019 at 11:50:19AM +0200, Greg Kroah-Hartman wrote:
> > I did try just that, a few years ago, and gave up on it.  I don't think
> > it can be added to the existing vfat code base but I am willing to be
> > proven wrong.
> 
> And what exactly was the problem?
> 
> > 
> > Now that we have the specs, it might be easier, and the vfat spec is a
> > subset of the exfat spec, but to get stuff working today, for users,
> > it's good to have it in staging.  We can do the normal, "keep it in
> > stable, get a clean-room implementation merged like usual, and then
> > delete the staging version" three step process like we have done a
> > number of times already as well.
> > 
> > I know the code is horrible, but I will gladly take horrible code into
> > staging.  If it bothers you, just please ignore it.  That's what staging
> > is there for :)
> 
> And then after a while you decide it's been long enough and force move
> it out of staging like the POS erofs code?

The problem is that EROFS has been there for a year and
I sent v1-v8 patches here, You didn't review or reply it
once until now.

And I have no idea what is the relationship between EROFS
and the current exfat implementation.

Thanks,
Gao Xiang

