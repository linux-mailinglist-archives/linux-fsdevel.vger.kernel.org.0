Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 125619131D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2019 23:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbfHQVT6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Aug 2019 17:19:58 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:41538 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfHQVT6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Aug 2019 17:19:58 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 05377621FCD3;
        Sat, 17 Aug 2019 23:19:55 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id XTABcBaKQNZk; Sat, 17 Aug 2019 23:19:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 839676083139;
        Sat, 17 Aug 2019 23:19:51 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id l7v2AJV0SH0k; Sat, 17 Aug 2019 23:19:51 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 03E82621FCD3;
        Sat, 17 Aug 2019 23:19:50 +0200 (CEST)
Date:   Sat, 17 Aug 2019 23:19:50 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Gao Xiang <hsiangkao@aol.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, tytso <tytso@mit.edu>,
        Pavel Machek <pavel@denx.de>, David Sterba <dsterba@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
        torvalds <torvalds@linux-foundation.org>,
        Chao Yu <yuchao0@huawei.com>, Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <1746679415.68815.1566076790942.JavaMail.zimbra@nod.at>
In-Reply-To: <20190817082313.21040-1-hsiangkao@aol.com>
References: <20190817082313.21040-1-hsiangkao@aol.com>
Subject: Re: [PATCH] erofs: move erofs out of staging
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF60 (Linux)/8.8.12_GA_3809)
Thread-Topic: erofs: move erofs out of staging
Thread-Index: 8FsSXU2wmXCQdCGPbfgJ42ALdSe6DQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Gao Xiang" <hsiangkao@aol.com>
> An: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Al Viro" <viro@zeniv.linux.org.uk>, "linux-fsdevel"
> <linux-fsdevel@vger.kernel.org>, devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org, "linux-kernel"
> <linux-kernel@vger.kernel.org>
> CC: "Andrew Morton" <akpm@linux-foundation.org>, "Stephen Rothwell" <sfr@canb.auug.org.au>, "tytso" <tytso@mit.edu>,
> "Pavel Machek" <pavel@denx.de>, "David Sterba" <dsterba@suse.cz>, "Amir Goldstein" <amir73il@gmail.com>, "Christoph
> Hellwig" <hch@infradead.org>, "Darrick J . Wong" <darrick.wong@oracle.com>, "Dave Chinner" <david@fromorbit.com>,
> "Jaegeuk Kim" <jaegeuk@kernel.org>, "Jan Kara" <jack@suse.cz>, "richard" <richard@nod.at>, "torvalds"
> <torvalds@linux-foundation.org>, "Chao Yu" <yuchao0@huawei.com>, "Miao Xie" <miaoxie@huawei.com>, "Li Guifu"
> <bluce.liguifu@huawei.com>, "Fang Wei" <fangwei1@huawei.com>, "Gao Xiang" <gaoxiang25@huawei.com>
> Gesendet: Samstag, 17. August 2019 10:23:13
> Betreff: [PATCH] erofs: move erofs out of staging

> EROFS filesystem has been merged into linux-staging for a year.
> 
> EROFS is designed to be a better solution of saving extra storage
> space with guaranteed end-to-end performance for read-only files
> with the help of reduced metadata, fixed-sized output compression
> and decompression inplace technologies.
 
How does erofs compare to squashfs?
IIUC it is designed to be faster. Do you have numbers?
Feel free to point me older mails if you already showed numbers,
I have to admit I didn't follow the development very closely.

Thanks,
//richard
