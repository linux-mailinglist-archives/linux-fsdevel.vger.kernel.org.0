Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAE091841
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Aug 2019 19:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfHRRGo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Aug 2019 13:06:44 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:34030 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfHRRGo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Aug 2019 13:06:44 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id ACDE0608311C;
        Sun, 18 Aug 2019 19:06:41 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 08Dg9I0ZhxDq; Sun, 18 Aug 2019 19:06:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 5FD3D6083139;
        Sun, 18 Aug 2019 19:06:41 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id APNZI9DvhTC0; Sun, 18 Aug 2019 19:06:41 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id E967F608311C;
        Sun, 18 Aug 2019 19:06:40 +0200 (CEST)
Date:   Sun, 18 Aug 2019 19:06:40 +0200 (CEST)
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
Message-ID: <1897345637.69314.1566148000847.JavaMail.zimbra@nod.at>
In-Reply-To: <20190818151154.GA32157@mit.edu>
References: <20190817082313.21040-1-hsiangkao@aol.com> <20190817233843.GA16991@hsiangkao-HP-ZHAN-66-Pro-G1> <1405781266.69008.1566116210649.JavaMail.zimbra@nod.at> <20190818084521.GA17909@hsiangkao-HP-ZHAN-66-Pro-G1> <1133002215.69049.1566119033047.JavaMail.zimbra@nod.at> <20190818090949.GA30276@kroah.com> <790210571.69061.1566120073465.JavaMail.zimbra@nod.at> <20190818151154.GA32157@mit.edu>
Subject: Re: [PATCH] erofs: move erofs out of staging
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF60 (Linux)/8.8.12_GA_3809)
Thread-Topic: erofs: move erofs out of staging
Thread-Index: F0XqNZSXfHi4RI8aEm4VDowhkFmYng==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

----- Ursprüngliche Mail -----
> So holding a file system like EROFS to a higher standard than say,
> ext4, xfs, or btrfs hardly seems fair.

Nobody claimed that.

Thanks,
//richard
