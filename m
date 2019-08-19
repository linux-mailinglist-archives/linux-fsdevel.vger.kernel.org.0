Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2409491E02
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2019 09:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfHSHhP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Aug 2019 03:37:15 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:47466 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfHSHhP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Aug 2019 03:37:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 118A16058367;
        Mon, 19 Aug 2019 09:37:13 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Gh0H5-M7pMI1; Mon, 19 Aug 2019 09:37:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id B7A976058372;
        Mon, 19 Aug 2019 09:37:12 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id X0QRCQyW7zBU; Mon, 19 Aug 2019 09:37:12 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 5557F6058367;
        Mon, 19 Aug 2019 09:37:12 +0200 (CEST)
Date:   Mon, 19 Aug 2019 09:37:12 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     tytso <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gao Xiang <hsiangkao@aol.com>, Jan Kara <jack@suse.cz>,
        Chao Yu <yuchao0@huawei.com>,
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
Message-ID: <1608410274.69654.1566200232285.JavaMail.zimbra@nod.at>
In-Reply-To: <20190818174702.GA17633@infradead.org>
References: <1405781266.69008.1566116210649.JavaMail.zimbra@nod.at> <790210571.69061.1566120073465.JavaMail.zimbra@nod.at> <20190818151154.GA32157@mit.edu> <20190818155812.GB13230@infradead.org> <20190818161638.GE1118@sol.localdomain> <20190818162201.GA16269@infradead.org> <20190818172938.GA14413@sol.localdomain> <20190818174702.GA17633@infradead.org>
Subject: Re: [PATCH] erofs: move erofs out of staging
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF60 (Linux)/8.8.12_GA_3809)
Thread-Topic: erofs: move erofs out of staging
Thread-Index: J92t0JNToP0kTJc8zt++O7kugCUZWw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

----- Ursprüngliche Mail -----
> On Sun, Aug 18, 2019 at 10:29:38AM -0700, Eric Biggers wrote:
>> Not sure what you're even disagreeing with, as I *do* expect new filesystems to
>> be held to a high standard, and to be written with the assumption that the
>> on-disk data may be corrupted or malicious.  We just can't expect the bar to be
>> so high (e.g. no bugs) that it's never been attained by *any* filesystem even
>> after years/decades of active development.  If the developers were careful, the
>> code generally looks robust, and they are willing to address such bugs as they
>> are found, realistically that's as good as we can expect to get...
> 
> Well, the impression I got from Richards quick look and the reply to it is
> that there is very little attempt to validate the ondisk data structure
> and there is absolutely no priority to do so.  Which is very different
> from there is a bug or two here and there.

On the plus side, everything I reported got fixed within hours.

Thanks,
//richard
