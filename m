Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3EBAA57AF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 15:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730441AbfIBNd5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 09:33:57 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3988 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730417AbfIBNd5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 09:33:57 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 325AC2557631AFB90083;
        Mon,  2 Sep 2019 21:33:54 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 2 Sep 2019 21:33:53 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 2 Sep 2019 21:33:53 +0800
Date:   Mon, 2 Sep 2019 21:33:02 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Gao Xiang <hsiangkao@aol.com>, Chao Yu <yuchao0@huawei.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <linux-fsdevel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <linux-erofs@lists.ozlabs.org>, Chao Yu <chao@kernel.org>
Subject: Re: [PATCH 07/21] erofs: use erofs_inode naming
Message-ID: <20190902133302.GA63268@architecture4>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190901055130.30572-1-hsiangkao@aol.com>
 <20190901055130.30572-8-hsiangkao@aol.com>
 <20190902121021.GG15931@infradead.org>
 <20190902121306.GA2664@architecture4>
 <20190902124737.GB8369@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190902124737.GB8369@infradead.org>
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

On Mon, Sep 02, 2019 at 05:47:37AM -0700, Christoph Hellwig wrote:
> On Mon, Sep 02, 2019 at 08:13:06PM +0800, Gao Xiang wrote:
> > Hi Christoph,
> > 
> > On Mon, Sep 02, 2019 at 05:10:21AM -0700, Christoph Hellwig wrote:
> > > >  {
> > > > -	struct erofs_vnode *vi = ptr;
> > > > -
> > > > -	inode_init_once(&vi->vfs_inode);
> > > > +	inode_init_once(&((struct erofs_inode *)ptr)->vfs_inode);
> > > 
> > > Why doesn't this use EROFS_I?  This looks a little odd.
> > 
> > Thanks for your reply and suggestion...
> > EROFS_I seems the revert direction ---> inode to erofs_inode
> > here we need "erofs_inode" to inode...
> > 
> > Am I missing something?.... Hope not....
> 
> No, you are not.  But the cast still looks odd.  Why not:
> 
> 	struct erofs_inode *ei = ptr;
> 
> 	inode_init_once(&ei->vfs_inode);

That is the old way, I thought you don't like the extra variable...
https://lore.kernel.org/linux-erofs/20190830154551.GA11571@infradead.org/
I am ok with either form, anyway, let me use the old way....

Thanks,
Gao Xiang

