Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 752F0915DF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Aug 2019 11:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbfHRJVR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Aug 2019 05:21:17 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:52552 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfHRJVR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Aug 2019 05:21:17 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 5CFA4608311C;
        Sun, 18 Aug 2019 11:21:14 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id JMoGDXhMUFAT; Sun, 18 Aug 2019 11:21:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 0F0626083139;
        Sun, 18 Aug 2019 11:21:14 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id i6iE3Ye2OdmJ; Sun, 18 Aug 2019 11:21:13 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 904E6608311C;
        Sun, 18 Aug 2019 11:21:13 +0200 (CEST)
Date:   Sun, 18 Aug 2019 11:21:13 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Gao Xiang <hsiangkao@aol.com>, Jan Kara <jack@suse.cz>,
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
        Jaegeuk Kim <jaegeuk@kernel.org>, tytso <tytso@mit.edu>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>, Pavel Machek <pavel@denx.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds <torvalds@linux-foundation.org>
Message-ID: <790210571.69061.1566120073465.JavaMail.zimbra@nod.at>
In-Reply-To: <20190818090949.GA30276@kroah.com>
References: <20190817082313.21040-1-hsiangkao@aol.com> <20190817220706.GA11443@hsiangkao-HP-ZHAN-66-Pro-G1> <1163995781.68824.1566084358245.JavaMail.zimbra@nod.at> <20190817233843.GA16991@hsiangkao-HP-ZHAN-66-Pro-G1> <1405781266.69008.1566116210649.JavaMail.zimbra@nod.at> <20190818084521.GA17909@hsiangkao-HP-ZHAN-66-Pro-G1> <1133002215.69049.1566119033047.JavaMail.zimbra@nod.at> <20190818090949.GA30276@kroah.com>
Subject: Re: [PATCH] erofs: move erofs out of staging
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF60 (Linux)/8.8.12_GA_3809)
Thread-Topic: erofs: move erofs out of staging
Thread-Index: ZYiHrkrOEpEEHm2sO1Mis8HFSUNWVQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

----- Ursprüngliche Mail -----
> You have looked at reiserfs lately, right?  :)

Don't remind me of that. ;-)
 
> Not to say that erofs shouldn't be worked on to fix these kinds of
> issues, just that it's not an unheard of thing to trust the disk image.
> Especially for the normal usage model of erofs, where the whole disk
> image is verfied before it is allowed to be mounted as part of the boot
> process.

For normal use I see no problem at all.
I fear distros that try to mount anything you plug into your USB.

At least SUSE already blacklists erofs:
https://github.com/openSUSE/suse-module-tools/blob/master/suse-module-tools.spec#L24

Thanks,
//richard
