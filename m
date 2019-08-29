Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB0D5A2007
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 17:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbfH2PwX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 11:52:23 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3958 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728374AbfH2PwT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 11:52:19 -0400
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 0C6C9E086C35E691A811;
        Thu, 29 Aug 2019 23:52:15 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 29 Aug 2019 23:52:14 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Thu, 29 Aug 2019 23:52:14 +0800
Date:   Thu, 29 Aug 2019 23:51:27 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     <devel@driverdev.osuosl.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Valdis =?gbk?Q?Kl=A8=A5tnieks?= <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        <linux-fsdevel@vger.kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to staging
Message-ID: <20190829155127.GA136563@architecture4>
References: <20190828170022.GA7873@kroah.com>
 <20190829062340.GB3047@infradead.org>
 <20190829063955.GA30193@kroah.com>
 <20190829094136.GA28643@infradead.org>
 <20190829095019.GA13557@kroah.com>
 <20190829103749.GA13661@infradead.org>
 <20190829111810.GA23393@kroah.com>
 <20190829151144.GJ23584@kadam>
 <20190829152757.GA125003@architecture4>
 <20190829154346.GK23584@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190829154346.GK23584@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme703-chm.china.huawei.com (10.1.199.99) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Dan,

On Thu, Aug 29, 2019 at 06:43:46PM +0300, Dan Carpenter wrote:
> > p.s. There are 2947 (un)likely places in fs/ directory.
> 
> I was complaining about you adding new pointless ones, not existing
> ones.  The likely/unlikely annotations are supposed to be functional and
> not decorative.  I explained this very clearly.

I don't think that is mostly pointless. I think it has functional use
because all error handling paths are rarely happened, or can you remove
the unlikely in IS_ERR as well?

> 
> Probably most of the annotations in fs/ are wrong but they are also
> harmless except for the slight messiness.  However there are definitely
> some which are important so removing them all isn't a good idea.
> 
> > If you like, I will delete them all.
> 
> But for erofs, I don't think that any of the likely/unlikely calls have
> been thought about so I'm fine with removing all of them in one go.

Maybe some misuse but rare, I will show you case by case. Wait a minute.

Thanks,
Gao Xiang

> 
> regards,
> dan carpenter
> 
