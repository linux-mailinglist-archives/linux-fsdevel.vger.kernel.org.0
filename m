Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8206A5A41
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 17:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731620AbfIBPLY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 11:11:24 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3991 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726447AbfIBPLY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 11:11:24 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 93A29523D8D4C3635C29;
        Mon,  2 Sep 2019 23:11:21 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 2 Sep 2019 23:11:21 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 2 Sep 2019 23:11:20 +0800
Date:   Mon, 2 Sep 2019 23:10:29 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     <dsterba@suse.cz>, Chao Yu <chao@kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Theodore Ts'o <tytso@mit.edu>, Pavel Machek <pavel@denx.de>,
        Amir Goldstein <amir73il@gmail.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        "Dave Chinner" <david@fromorbit.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
        Richard Weinberger <richard@nod.at>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        <linux-erofs@lists.ozlabs.org>, Chao Yu <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>
Subject: Re: [PATCH v8 11/24] erofs: introduce xattr & posixacl support
Message-ID: <20190902151028.GA179615@architecture4>
References: <20190815044155.88483-1-gaoxiang25@huawei.com>
 <20190815044155.88483-12-gaoxiang25@huawei.com>
 <20190902125711.GA23462@infradead.org>
 <20190902130644.GT2752@suse.cz>
 <813e1b65-e6ba-631c-6506-f356738c477f@kernel.org>
 <20190902142037.GW2752@twin.jikos.cz>
 <20190902150640.GA23089@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190902150640.GA23089@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme710-chm.china.huawei.com (10.1.199.106) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph,

On Mon, Sep 02, 2019 at 08:06:40AM -0700, Christoph Hellwig wrote:
> On Mon, Sep 02, 2019 at 04:20:37PM +0200, David Sterba wrote:
> > Oh right, I think the reasons are historical and that we can remove the
> > options nowadays. From the compatibility POV this should be safe, with
> > ACLs compiled out, no tool would use them, and no harm done when the
> > code is present but not used.
> > 
> > There were some efforts by embedded guys to make parts of kernel more
> > configurable to allow removing subsystems to reduce the final image
> > size. In this case I don't think it would make any noticeable
> > difference, eg. the size of fs/btrfs/acl.o on release config is 1.6KiB,
> > while the whole module is over 1.3MiB.
> 
> Given that the erofs folks have an actual use case for it I think
> it is fine to keep the options, I just wanted to ensure this wasn't
> copy and pasted for no good reason.  Note that for XFS we don't have
> an option for xattrs, as those are integral to a lot of file system
> features.  WE have an ACL option mostly for historic reasons.

I fully understand your starting point...

Thanks,
Gao Xiang



