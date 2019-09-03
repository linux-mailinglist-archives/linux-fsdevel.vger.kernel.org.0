Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE600A6178
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 08:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfICGbJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 02:31:09 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34858 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725888AbfICGbJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 02:31:09 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7037E8B6A2F31DF55807;
        Tue,  3 Sep 2019 14:31:07 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 3 Sep 2019
 14:30:56 +0800
Subject: Re: [PATCH v8 11/24] erofs: introduce xattr & posixacl support
To:     <dsterba@suse.cz>, Chao Yu <chao@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Gao Xiang <gaoxiang25@huawei.com>,
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
        <linux-erofs@lists.ozlabs.org>, Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>
References: <20190815044155.88483-1-gaoxiang25@huawei.com>
 <20190815044155.88483-12-gaoxiang25@huawei.com>
 <20190902125711.GA23462@infradead.org> <20190902130644.GT2752@suse.cz>
 <813e1b65-e6ba-631c-6506-f356738c477f@kernel.org>
 <20190902142037.GW2752@twin.jikos.cz>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <12d37c63-dd0e-04fb-91f8-f4b930e867e5@huawei.com>
Date:   Tue, 3 Sep 2019 14:30:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190902142037.GW2752@twin.jikos.cz>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/9/2 22:20, David Sterba wrote:
> Oh right, I think the reasons are historical and that we can remove the
> options nowadays. From the compatibility POV this should be safe, with
> ACLs compiled out, no tool would use them, and no harm done when the
> code is present but not used.
> 
> There were some efforts by embedded guys to make parts of kernel more
> configurable to allow removing subsystems to reduce the final image
> size. In this case I don't think it would make any noticeable
> difference, eg. the size of fs/btrfs/acl.o on release config is 1.6KiB,
> while the whole module is over 1.3MiB.

Actually, btrfs's LOC is about 20 times larger than erofs's, acl part's LOC
could be very small one in btrfs.

EROFS can be slimmed about 10% size if we disable XATTR/ACL config, which is
worth to keep that, at least for now.

Thanks,


