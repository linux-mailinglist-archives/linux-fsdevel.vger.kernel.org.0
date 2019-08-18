Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCAAC9188F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Aug 2019 20:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfHRSAg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Aug 2019 14:00:36 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:35312 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfHRSAf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Aug 2019 14:00:35 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id BE1ED608311C;
        Sun, 18 Aug 2019 20:00:32 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 4gGs7GazpkF2; Sun, 18 Aug 2019 20:00:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 7F2846083139;
        Sun, 18 Aug 2019 20:00:29 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Uj_qxmxjUq0m; Sun, 18 Aug 2019 20:00:29 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 097BB608311C;
        Sun, 18 Aug 2019 20:00:29 +0200 (CEST)
Date:   Sun, 18 Aug 2019 20:00:28 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     tytso <tytso@mit.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gao Xiang <hsiangkao@aol.com>, Jan Kara <jack@suse.cz>,
        Chao Yu <yuchao0@huawei.com>,
        Dave Chinner <david@fromorbit.com>,
        David Sterba <dsterba@suse.cz>, Miao Xie <miaoxie@huawei.com>,
        devel <devel@driverdev.osuosl.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Darrick <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
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
Message-ID: <538856932.69442.1566151228866.JavaMail.zimbra@nod.at>
In-Reply-To: <20190818174621.GB12940@mit.edu>
References: <20190817082313.21040-1-hsiangkao@aol.com> <20190818084521.GA17909@hsiangkao-HP-ZHAN-66-Pro-G1> <1133002215.69049.1566119033047.JavaMail.zimbra@nod.at> <20190818090949.GA30276@kroah.com> <790210571.69061.1566120073465.JavaMail.zimbra@nod.at> <20190818151154.GA32157@mit.edu> <1897345637.69314.1566148000847.JavaMail.zimbra@nod.at> <20190818174621.GB12940@mit.edu>
Subject: Re: [PATCH] erofs: move erofs out of staging
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF60 (Linux)/8.8.12_GA_3809)
Thread-Topic: erofs: move erofs out of staging
Thread-Index: sAbiegKjjTKQmAd1TwyH6s3S7iROUA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "tytso" <tytso@mit.edu>
> An: "richard" <richard@nod.at>
> CC: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Gao Xiang" <hsiangkao@aol.com>, "Jan Kara" <jack@suse.cz>, "Chao
> Yu" <yuchao0@huawei.com>, "Dave Chinner" <david@fromorbit.com>, "David Sterba" <dsterba@suse.cz>, "Miao Xie"
> <miaoxie@huawei.com>, "devel" <devel@driverdev.osuosl.org>, "Stephen Rothwell" <sfr@canb.auug.org.au>, "Darrick"
> <darrick.wong@oracle.com>, "Christoph Hellwig" <hch@infradead.org>, "Amir Goldstein" <amir73il@gmail.com>,
> "linux-erofs" <linux-erofs@lists.ozlabs.org>, "Al Viro" <viro@zeniv.linux.org.uk>, "Jaegeuk Kim" <jaegeuk@kernel.org>,
> "linux-kernel" <linux-kernel@vger.kernel.org>, "Li Guifu" <bluce.liguifu@huawei.com>, "Fang Wei" <fangwei1@huawei.com>,
> "Pavel Machek" <pavel@denx.de>, "linux-fsdevel" <linux-fsdevel@vger.kernel.org>, "Andrew Morton"
> <akpm@linux-foundation.org>, "torvalds" <torvalds@linux-foundation.org>
> Gesendet: Sonntag, 18. August 2019 19:46:21
> Betreff: Re: [PATCH] erofs: move erofs out of staging

> On Sun, Aug 18, 2019 at 07:06:40PM +0200, Richard Weinberger wrote:
>> > So holding a file system like EROFS to a higher standard than say,
>> > ext4, xfs, or btrfs hardly seems fair.
>> 
>> Nobody claimed that.
> 
> Pointing out that erofs has issues in this area when Gao Xiang is
> asking if erofs can be moved out of staging and join the "official
> clubhouse" of file systems could certainly be reasonable interpreted
> as such.  Reporting such vulnerablities are a good thing, and
> hopefully all file system maintainers will welcome them.  Doing them
> on a e-mail thread about promoting out of erofs is certainly going to
> lead to inferences of a double standard.

Well, this was not at all my intention.
erofs raised my attention and instead of wasting a new thread
I answered here and reported what I found while looking at it.
That's all.

Thanks,
//richard
