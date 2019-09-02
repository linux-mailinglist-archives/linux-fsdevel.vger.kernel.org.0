Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A392A5724
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 15:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730484AbfIBNGC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 09:06:02 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3550 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729761AbfIBNGC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 09:06:02 -0400
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id B0E7417AA2BAFB15C99;
        Mon,  2 Sep 2019 21:06:00 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 2 Sep 2019 21:06:00 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 2 Sep 2019 21:05:59 +0800
Date:   Mon, 2 Sep 2019 21:05:08 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     <linux-fsdevel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        "Alexander Viro" <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Theodore Ts'o <tytso@mit.edu>, Pavel Machek <pavel@denx.de>,
        David Sterba <dsterba@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
        Richard Weinberger <richard@nod.at>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        <linux-erofs@lists.ozlabs.org>, Chao Yu <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>
Subject: Re: [PATCH v8 11/24] erofs: introduce xattr & posixacl support
Message-ID: <20190902130508.GD17916@architecture4>
References: <20190815044155.88483-1-gaoxiang25@huawei.com>
 <20190815044155.88483-12-gaoxiang25@huawei.com>
 <20190902125711.GA23462@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190902125711.GA23462@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme707-chm.china.huawei.com (10.1.199.103) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph,

On Mon, Sep 02, 2019 at 05:57:11AM -0700, Christoph Hellwig wrote:
> > +config EROFS_FS_XATTR
> > +	bool "EROFS extended attributes"
> > +	depends on EROFS_FS
> > +	default y
> > +	help
> > +	  Extended attributes are name:value pairs associated with inodes by
> > +	  the kernel or by users (see the attr(5) manual page, or visit
> > +	  <http://acl.bestbits.at/> for details).
> > +
> > +	  If unsure, say N.
> > +
> > +config EROFS_FS_POSIX_ACL
> > +	bool "EROFS Access Control Lists"
> > +	depends on EROFS_FS_XATTR
> > +	select FS_POSIX_ACL
> > +	default y
> 
> Is there any good reason to make these optional these days?

...Android (like smartphones) will not use it at least
   (just my personal thought, an option though...)

Thanks,
Gao Xiang

