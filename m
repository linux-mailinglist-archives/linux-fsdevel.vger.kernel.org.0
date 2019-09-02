Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4C0A55C0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 14:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731390AbfIBMT2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 08:19:28 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:35360 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731362AbfIBMT2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 08:19:28 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 90FEE4A06E9169645A6E;
        Mon,  2 Sep 2019 20:19:26 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 2 Sep 2019 20:19:26 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 2 Sep 2019 20:19:25 +0800
Date:   Mon, 2 Sep 2019 20:18:34 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Gao Xiang <hsiangkao@aol.com>, Chao Yu <yuchao0@huawei.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <linux-fsdevel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <linux-erofs@lists.ozlabs.org>, Chao Yu <chao@kernel.org>
Subject: Re: [PATCH 12/21] erofs: kill verbose debug info in erofs_fill_super
Message-ID: <20190902121834.GC2664@architecture4>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190901055130.30572-1-hsiangkao@aol.com>
 <20190901055130.30572-13-hsiangkao@aol.com>
 <20190902121424.GK15931@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190902121424.GK15931@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme713-chm.china.huawei.com (10.1.199.109) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph,

On Mon, Sep 02, 2019 at 05:14:24AM -0700, Christoph Hellwig wrote:
> On Sun, Sep 01, 2019 at 01:51:21PM +0800, Gao Xiang wrote:
> > From: Gao Xiang <gaoxiang25@huawei.com>
> > 
> > As Christoph said [1], "That is some very verbose
> > debug info.  We usually don't add that and let
> > people trace the function instead. "
> 
> Note that this applies to most of the infoln users as far as
> I can tell.  And if you want to keep some of those I think you
> should converted them to use pr_info directly, and also print
> sb->s_id as a prefix before the actual message so that the user
> knows which file system is affected.

Thanks for your suggestion...

I think I will turn them into erofs_errln and etc...
and print sb->s_id as a prefix...

Thanks,
Gao Xiang


