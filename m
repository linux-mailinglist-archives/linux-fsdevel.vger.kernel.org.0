Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23F9BA3CF6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2019 19:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbfH3RYv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Aug 2019 13:24:51 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:52380 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727791AbfH3RYv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Aug 2019 13:24:51 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id DED08EE13AF279517FC9;
        Sat, 31 Aug 2019 01:24:48 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 31 Aug 2019 01:24:48 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Sat, 31 Aug 2019 01:24:47 +0800
Date:   Sat, 31 Aug 2019 01:23:59 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Theodore Ts'o <tytso@mit.edu>, "Pavel Machek" <pavel@denx.de>,
        David Sterba <dsterba@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        "Dave Chinner" <david@fromorbit.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        <linux-fsdevel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, Chao Yu <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>
Subject: Re: [PATCH v6 04/24] erofs: add raw address_space operations
Message-ID: <20190830172359.GD107220@architecture4>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190802125347.166018-5-gaoxiang25@huawei.com>
 <20190829101721.GD20598@infradead.org>
 <20190829114610.GF64893@architecture4>
 <20190830164013.GC29603@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190830164013.GC29603@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme702-chm.china.huawei.com (10.1.199.98) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph,

On Fri, Aug 30, 2019 at 09:40:13AM -0700, Christoph Hellwig wrote:
> On Thu, Aug 29, 2019 at 07:46:11PM +0800, Gao Xiang wrote:
> > Hi Christoph,
> > 
> > On Thu, Aug 29, 2019 at 03:17:21AM -0700, Christoph Hellwig wrote:
> > > The actual address_space operations seem to largely duplicate
> > > the iomap versions.  Please use those instead.  Also I don't think
> > > any new file system should write up ->bmap these days.
> > 
> > iomap doesn't support tail-end packing inline data till now,
> > I think Chao and I told you and Andreas before [1].
> > 
> > Since EROFS keeps a self-contained driver for now, we will use
> > iomap if it supports tail-end packing inline data later.
> 
> Well, so work with the maintainers to enhance the core kernel.  That
> is how Linux development works.  We've added various iomap enhancements
> for gfs in the last merge windows, and we've added more for the brand
> new zonefs file system we plan to merge for 5.4.

That is a good idea, I think Chao will continue working on this
(adding tail-end packing inline approach into iomap, thus we can
 have few code in data.c.)

Thanks,
Gao Xiang

