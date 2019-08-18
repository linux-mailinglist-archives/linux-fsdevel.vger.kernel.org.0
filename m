Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C801A917B6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Aug 2019 18:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbfHRQQm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Aug 2019 12:16:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:48316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbfHRQQl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Aug 2019 12:16:41 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31EFF20644;
        Sun, 18 Aug 2019 16:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566145000;
        bh=NSSy4mA2IcwfuYQPcB9hX5r00sDDMr1GAhaImAFrjmk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TJuDeqIz1AOUrfjI4tJ2s99hzAlFWk84d4zcmb/BVNJEFYVx2WKrptDAGwtmkk2TK
         LnxnxmgqgQCUC4un3j70hQ1g7AfuNzkiHyG12ZIyk04RrJz3+ahO8wpJ1G5gmacEA1
         fl36zAQND7Sp3qSvk1n1LO8kcK1bjbBoAOftLsAg=
Date:   Sun, 18 Aug 2019 09:16:38 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Richard Weinberger <richard@nod.at>,
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
Subject: Re: [PATCH] erofs: move erofs out of staging
Message-ID: <20190818161638.GE1118@sol.localdomain>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Richard Weinberger <richard@nod.at>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gao Xiang <hsiangkao@aol.com>, Jan Kara <jack@suse.cz>,
        Chao Yu <yuchao0@huawei.com>, Dave Chinner <david@fromorbit.com>,
        David Sterba <dsterba@suse.cz>, Miao Xie <miaoxie@huawei.com>,
        devel <devel@driverdev.osuosl.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Darrick <darrick.wong@oracle.com>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-erofs <linux-erofs@lists.ozlabs.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Li Guifu <bluce.liguifu@huawei.com>, Fang Wei <fangwei1@huawei.com>,
        Pavel Machek <pavel@denx.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds <torvalds@linux-foundation.org>
References: <20190817220706.GA11443@hsiangkao-HP-ZHAN-66-Pro-G1>
 <1163995781.68824.1566084358245.JavaMail.zimbra@nod.at>
 <20190817233843.GA16991@hsiangkao-HP-ZHAN-66-Pro-G1>
 <1405781266.69008.1566116210649.JavaMail.zimbra@nod.at>
 <20190818084521.GA17909@hsiangkao-HP-ZHAN-66-Pro-G1>
 <1133002215.69049.1566119033047.JavaMail.zimbra@nod.at>
 <20190818090949.GA30276@kroah.com>
 <790210571.69061.1566120073465.JavaMail.zimbra@nod.at>
 <20190818151154.GA32157@mit.edu>
 <20190818155812.GB13230@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190818155812.GB13230@infradead.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 18, 2019 at 08:58:12AM -0700, Christoph Hellwig wrote:
> On Sun, Aug 18, 2019 at 11:11:54AM -0400, Theodore Y. Ts'o wrote:
> > Note that of the mainstream file systems, ext4 and xfs don't guarantee
> > that it's safe to blindly take maliciously provided file systems, such
> > as those provided by a untrusted container, and mount it on a file
> > system without problems.  As I recall, one of the XFS developers
> > described file system fuzzing reports as a denial of service attack on
> > the developers.
> 
> I think this greatly misrepresents the general attitute of the XFS
> developers.  We take sanity checks for the modern v5 on disk format
> very series, and put a lot of effort into handling corrupted file
> systems as good as possible, although there are of course no guaranteeѕ.
> 
> The quote that you've taken out of context is for the legacy v4 format
> that has no checksums and other integrity features.

Ted's observation was about maliciously-crafted filesystems, though, so
integrity-only features such as metadata checksums are irrelevant.  Also the
filesystem version is irrelevant; anything accepted by the kernel code (even if
it's legacy/deprecated) is open attack surface.

I personally consider it *mandatory* that we deal with this stuff.  But I can
understand that we don't do a good job at it, so we shouldn't hold a new
filesystem to an unfairly high standard relative to other filesystems...

- Eric
