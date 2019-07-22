Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C22E96F8AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2019 07:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfGVFF0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jul 2019 01:05:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:35214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbfGVFF0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jul 2019 01:05:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22D7021BF6;
        Mon, 22 Jul 2019 05:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563771925;
        bh=WmJFcTVoRpT2HfWty1TJul+l+Y+NTZtVLnXF68wNGu4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ak4mYg1UNsFiHfLnKlHXXnNOcAWp3v+nzRjM9leUCIgt89qe+qhkmLoan3VmrsYiH
         EMz6kdjmwweOgO/RfvTxxUGp5pBcxUjNKIiAEsGilqmDmgxxyuxKQmeQXe+QhH73E8
         NACTwYpXXbzg05gtviLXQIgLM9U6xTUQfuWUn5vE=
Date:   Mon, 22 Jul 2019 07:05:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Gao Xiang <gaoxiang25@huawei.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>
Subject: Re: [PATCH v3 01/24] erofs: add on-disk layout
Message-ID: <20190722050522.GA11993@kroah.com>
References: <20190722025043.166344-1-gaoxiang25@huawei.com>
 <20190722025043.166344-2-gaoxiang25@huawei.com>
 <20190722132616.60edd141@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722132616.60edd141@canb.auug.org.au>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 22, 2019 at 01:26:16PM +1000, Stephen Rothwell wrote:
> Hi Gao,
> 
> On Mon, 22 Jul 2019 10:50:20 +0800 Gao Xiang <gaoxiang25@huawei.com> wrote:
> >
> > diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
> > new file mode 100644
> > index 000000000000..e418725abfd6
> > --- /dev/null
> > +++ b/fs/erofs/erofs_fs.h
> > @@ -0,0 +1,316 @@
> > +/* SPDX-License-Identifier: GPL-2.0 OR Apache-2.0 */
> 
> I think the preferred tag is now GPL-2.0-only (assuming that is what is
> intended).

Either is fine, see the LICENSE/preferred/GPL-2.0 file for the list of
valid ones.

thanks,

greg k-h
