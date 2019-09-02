Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D642A581F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 15:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731345AbfIBNjX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 09:39:23 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3989 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731329AbfIBNjW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 09:39:22 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 98EC5C1E173A35FF01AC;
        Mon,  2 Sep 2019 21:39:18 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 2 Sep 2019 21:39:18 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 2 Sep 2019 21:39:17 +0800
Date:   Mon, 2 Sep 2019 21:38:26 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Gao Xiang <hsiangkao@aol.com>, Chao Yu <yuchao0@huawei.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <linux-fsdevel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <linux-erofs@lists.ozlabs.org>, Chao Yu <chao@kernel.org>
Subject: Re: [PATCH 16/21] erofs: kill magic underscores
Message-ID: <20190902133826.GB63268@architecture4>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190901055130.30572-1-hsiangkao@aol.com>
 <20190901055130.30572-17-hsiangkao@aol.com>
 <20190902122627.GN15931@infradead.org>
 <20190902123937.GA17916@architecture4>
 <20190902125438.GA17750@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190902125438.GA17750@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme719-chm.china.huawei.com (10.1.199.115) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph,

On Mon, Sep 02, 2019 at 05:54:38AM -0700, Christoph Hellwig wrote:
> On Mon, Sep 02, 2019 at 08:39:37PM +0800, Gao Xiang wrote:
> > > 
> > > > +	if (erofs_inode_version(advise) == EROFS_INODE_LAYOUT_V2) {
> > > 
> > > I still need to wade through the old thread - but didn't you say this
> > > wasn't really a new vs old version but a compat vs full inode?  Maybe
> > > the names aren't that suitable either?
> > 
> > Could you kindly give some suggestions for better naming about it?
> > there are all supported by EROFS... (Actually we only mainly use v1...)
> 
> Maybe EROFS_INODE_LAYOUT_COMPACT and EROFS_INODE_LAYOUT_EXTENDED?

Okay, that is fine.

Thanks,
Gao Xiang

