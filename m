Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C73A91577
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Aug 2019 10:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbfHRIQz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Aug 2019 04:16:55 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:51072 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfHRIQz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Aug 2019 04:16:55 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 8558A608311C;
        Sun, 18 Aug 2019 10:16:52 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id dLQLHM2VGAbe; Sun, 18 Aug 2019 10:16:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 3071B6083139;
        Sun, 18 Aug 2019 10:16:52 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HNzNTCQoIICw; Sun, 18 Aug 2019 10:16:52 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id E7E00608311C;
        Sun, 18 Aug 2019 10:16:50 +0200 (CEST)
Date:   Sun, 18 Aug 2019 10:16:50 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Gao Xiang <hsiangkao@aol.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        devel <devel@driverdev.osuosl.org>,
        linux-erofs <linux-erofs@lists.ozlabs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, tytso <tytso@mit.edu>,
        Pavel Machek <pavel@denx.de>, David Sterba <dsterba@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Darrick <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
        torvalds <torvalds@linux-foundation.org>,
        Chao Yu <yuchao0@huawei.com>, Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <1405781266.69008.1566116210649.JavaMail.zimbra@nod.at>
In-Reply-To: <20190817233843.GA16991@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20190817082313.21040-1-hsiangkao@aol.com> <1746679415.68815.1566076790942.JavaMail.zimbra@nod.at> <20190817220706.GA11443@hsiangkao-HP-ZHAN-66-Pro-G1> <1163995781.68824.1566084358245.JavaMail.zimbra@nod.at> <20190817233843.GA16991@hsiangkao-HP-ZHAN-66-Pro-G1>
Subject: Re: [PATCH] erofs: move erofs out of staging
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF60 (Linux)/8.8.12_GA_3809)
Thread-Topic: erofs: move erofs out of staging
Thread-Index: ruyGuw+zrtJwjCvvrW6JXcct54lOmw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

----- Ursprüngliche Mail -----
>> While digging a little into the code I noticed that you have very few
>> checks of the on-disk data.
>> For example ->u.i_blkaddr. I gave it a try and created a
>> malformed filesystem where u.i_blkaddr is 0xdeadbeef, it causes the kernel
>> to loop forever around erofs_read_raw_page().
> 
> I don't fuzz all the on-disk fields for EROFS, I will do later..
> You can see many in-kernel filesystems are still hardening the related
> stuff. Anyway, I will dig into this field you mentioned recently, but
> I think it can be fixed easily later.

This is no excuse to redo all these bugs. :-)

I know that many in-kernel filesystems trust the disk ultimately, this is a
problem and huge attack vector.

Thanks,
//richard
