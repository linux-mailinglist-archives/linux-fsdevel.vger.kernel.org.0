Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C39E91DF1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2019 09:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfHSHfq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Aug 2019 03:35:46 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:47376 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfHSHfq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Aug 2019 03:35:46 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 5048C6058367;
        Mon, 19 Aug 2019 09:35:44 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 0XdjHdbH5XpF; Mon, 19 Aug 2019 09:35:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 03B9B621FCDF;
        Mon, 19 Aug 2019 09:35:44 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qijkGJoX6WqQ; Mon, 19 Aug 2019 09:35:43 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 82E09621FCDC;
        Mon, 19 Aug 2019 09:35:43 +0200 (CEST)
Date:   Mon, 19 Aug 2019 09:35:43 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Gao Xiang <hsiangkao@aol.com>
Cc:     Christoph Hellwig <hch@infradead.org>, tytso <tytso@mit.edu>,
        Eric Biggers <ebiggers@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>, Chao Yu <yuchao0@huawei.com>,
        Dave Chinner <david@fromorbit.com>,
        David Sterba <dsterba@suse.cz>, Miao Xie <miaoxie@huawei.com>,
        devel <devel@driverdev.osuosl.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Darrick <darrick.wong@oracle.com>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-erofs <linux-erofs@lists.ozlabs.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>, Pavel Machek <pavel@denx.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds <torvalds@linux-foundation.org>
Message-ID: <1559833874.69649.1566200143457.JavaMail.zimbra@nod.at>
In-Reply-To: <20190818201405.GA27398@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <1133002215.69049.1566119033047.JavaMail.zimbra@nod.at> <20190818155812.GB13230@infradead.org> <20190818161638.GE1118@sol.localdomain> <20190818162201.GA16269@infradead.org> <20190818172938.GA14413@sol.localdomain> <20190818174702.GA17633@infradead.org> <20190818181654.GA1617@hsiangkao-HP-ZHAN-66-Pro-G1> <20190818201405.GA27398@hsiangkao-HP-ZHAN-66-Pro-G1>
Subject: Re: [PATCH] erofs: move erofs out of staging
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF60 (Linux)/8.8.12_GA_3809)
Thread-Topic: erofs: move erofs out of staging
Thread-Index: 1ZpA5j1RyTrBeMZ7+BlWtUtc9zQNDw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

----- Ursprüngliche Mail -----
> I have made a simple fuzzer to inject messy in inode metadata,
> dir data, compressed indexes and super block,
> https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/commit/?h=experimental-fuzzer
> 
> I am testing with some given dirs and the following script.
> Does it look reasonable?

I think that's a very good start. :-)

Thanks,
//richard
