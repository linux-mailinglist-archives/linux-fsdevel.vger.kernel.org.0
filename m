Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D02DDA2C9F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2019 04:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbfH3CG4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 22:06:56 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5696 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727270AbfH3CGz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 22:06:55 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0EC28CB0385988FD9438;
        Fri, 30 Aug 2019 10:06:42 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 30 Aug
 2019 10:06:31 +0800
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to staging
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Gao Xiang <gaoxiang25@huawei.com>
CC:     <devel@driverdev.osuosl.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        =?UTF-8?Q?Valdis_Kl=c4=93tnieks?= <valdis.kletnieks@vt.edu>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        <linux-fsdevel@vger.kernel.org>,
        "OGAWA Hirofumi" <hirofumi@mail.parknet.co.jp>
References: <20190828160817.6250-1-gregkh@linuxfoundation.org>
 <20190828170022.GA7873@kroah.com> <20190829062340.GB3047@infradead.org>
 <20190829063955.GA30193@kroah.com> <20190829094136.GA28643@infradead.org>
 <20190829095019.GA13557@kroah.com> <20190829103749.GA13661@infradead.org>
 <20190829111810.GA23393@kroah.com> <20190829151144.GJ23584@kadam>
 <20190829152757.GA125003@architecture4> <20190829154346.GK23584@kadam>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <cd38b645-2930-3e02-6c6a-5972ea02b537@huawei.com>
Date:   Fri, 30 Aug 2019 10:06:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190829154346.GK23584@kadam>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/8/29 23:43, Dan Carpenter wrote:
>> p.s. There are 2947 (un)likely places in fs/ directory.
> 
> I was complaining about you adding new pointless ones, not existing
> ones.  The likely/unlikely annotations are supposed to be functional and
> not decorative.  I explained this very clearly.
> 
> Probably most of the annotations in fs/ are wrong but they are also
> harmless except for the slight messiness.  However there are definitely
> some which are important so removing them all isn't a good idea.

Hi Dan,

Could you please pick up one positive example using likely and unlikely
correctly? so we can follow the example, rather than removing them all blindly.

Thanks,

> 
>> If you like, I will delete them all.
> 
> But for erofs, I don't think that any of the likely/unlikely calls have
> been thought about so I'm fine with removing all of them in one go.
> 
> regards,
> dan carpenter
> 
> .
> 
