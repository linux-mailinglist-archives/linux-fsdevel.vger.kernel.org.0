Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42E55A42E2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2019 08:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfHaGtq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Aug 2019 02:49:46 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3985 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725953AbfHaGtp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Aug 2019 02:49:45 -0400
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 9D52E350C09520126B0B;
        Sat, 31 Aug 2019 14:49:43 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 31 Aug 2019 14:49:43 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Sat, 31 Aug 2019 14:49:42 +0800
Date:   Sat, 31 Aug 2019 14:48:53 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Amir Goldstein <amir73il@gmail.com>
CC:     Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Theodore Ts'o <tytso@mit.edu>, Pavel Machek <pavel@denx.de>,
        David Sterba <dsterba@suse.cz>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, Chao Yu <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>
Subject: Re: [PATCH v6 03/24] erofs: add super block operations
Message-ID: <20190831064853.GA162401@architecture4>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190802125347.166018-4-gaoxiang25@huawei.com>
 <20190829101545.GC20598@infradead.org>
 <20190829105048.GB64893@architecture4>
 <20190830163910.GB29603@infradead.org>
 <20190830171510.GC107220@architecture4>
 <CAOQ4uxichLUsPyg5Fqg-pSL85oqoDFcQHZbzdrkXX_-kK=CjDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAOQ4uxichLUsPyg5Fqg-pSL85oqoDFcQHZbzdrkXX_-kK=CjDQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme707-chm.china.huawei.com (10.1.199.103) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 31, 2019 at 09:34:44AM +0300, Amir Goldstein wrote:
> On Fri, Aug 30, 2019 at 8:16 PM Gao Xiang <gaoxiang25@huawei.com> wrote:
> >
> > Hi Christoph,
> >
> > On Fri, Aug 30, 2019 at 09:39:10AM -0700, Christoph Hellwig wrote:
> > > On Thu, Aug 29, 2019 at 06:50:48PM +0800, Gao Xiang wrote:
> > > > > Please use an erofs_ prefix for all your functions.
> > > >
> > > > It is already a static function, I have no idea what is wrong here.
> > >
> > > Which part of all wasn't clear?  Have you looked at the prefixes for
> > > most functions in the various other big filesystems?
> >
> > I will add erofs prefix to free_inode as you said.
> >
> > At least, all non-prefix functions in erofs are all static functions,
> > it won't pollute namespace... I will add "erofs_" to other meaningful
> > callbacks...And as you can see...
> >
> > cifs/cifsfs.c
> > 1303:cifs_init_inodecache(void)
> > 1509:   rc = cifs_init_inodecache();
> >
> > hpfs/super.c
> > 254:static int init_inodecache(void)
> > 771:    int err = init_inodecache();
> >
> > minix/inode.c
> > 84:static int __init init_inodecache(void)
> > 665:    int err = init_inodecache();
> >
> 
> Hi Gao,
> 
> "They did it first" is never a good reply for code review comments.
> Nobody cares if you copy&paste code with init_inodecache().
> I understand why you thought static function names do not pollute
> the (linker) namespace, but they do pollute the global namespace.
> 
> free_inode() as a local function name is one of the worst examples
> for VFS namespace pollution.
> 
> VFS code uses function names like those a lot in the global namespace, e.g.:
> clear_inode(),new_inode().
> 
> For example from recent history of namespace collision caused by your line
> of thinking, see:
> e6fd2093a85d md: namespace private helper names
> 
> Besides, you really have nothing to loose from prefixing everything
> with erofs_, do you? It's better for review, for debugging...

Hi Amir,

Thanks for you kind reply...

Yes, I understand that some generic header files
could have the same function names and cause bad
behaviors...

I will fix them, my only one question is "if all
function/variable names are prefixed with "erofs_"
(including all inline helpers in header files),
it seems somewhat strange... (too many statements
start "erofs_" in the source code...)"

I will fix common and short names at once...

Thanks,
Gao Xiang

> 
> Thanks,
> Amir.
