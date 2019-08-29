Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67AABA123D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 09:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfH2HCj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 03:02:39 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3953 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725881AbfH2HCj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 03:02:39 -0400
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 6612FD7DAFD70E48869C;
        Thu, 29 Aug 2019 15:02:37 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 29 Aug 2019 15:02:36 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Thu, 29 Aug 2019 15:02:36 +0800
Date:   Thu, 29 Aug 2019 15:01:49 +0800
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
Message-ID: <20190829070149.GA155353@architecture4>
References: <20190828160817.6250-1-gregkh@linuxfoundation.org>
 <20190828170022.GA7873@kroah.com>
 <20190829062340.GB3047@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190829062340.GB3047@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme717-chm.china.huawei.com (10.1.199.113) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph,

On Wed, Aug 28, 2019 at 11:23:40PM -0700, Christoph Hellwig wrote:
> Can we please just review the damn thing and get it into the proper
> tree?  That whole concept of staging file systems just has been one
> fricking disaster, including Greg just moving not fully reviewed ones
> over like erofs just because he feels like it.  I'm getting sick and
> tired of this scheme.

I just want to a word on EROFS stuff (I'm not suitable to comment
on the current exfat implementation). Since EROFS stuff has been
in staging tree for more than a year, anyone who wants to review
it can review this filesystem at any time.

EROFS is not just a homebrew or experimental fs for now, it has been
widely used for many commerical smartphones, and we will upstream it
to AOSP for more Android smartphones after it gets merged to upstream.
I personally cc-ed you for a month, and I didn't get any objection
from others (including Linus) for about 2 months. That isn't because
of someone likes it, rather we cannot make no progress compared with
some exist fs community because this is our love work.

And it's self-contained driver at least, and it's disabled by default,
It cannot be stayed in staging tree to do a lot of EROFS feature
improvements itself forever (since it is cleaned enough).
It has proven its validity as well.

Thanks,
Gao Xiang

