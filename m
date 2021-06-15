Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2B13A83A7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 17:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbhFOPIx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 11:08:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:60838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231589AbhFOPIu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 11:08:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8FC2261107;
        Tue, 15 Jun 2021 15:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623769606;
        bh=cJWTxsGDRuwIy31V9tXmkrMiXXwbFHDF/rR/uTuaxDk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oSqSxbPHW+0U7cN5XSNYJp3T8mXkT0J9vJIkRzrbdBfR1MZle9Xs67eshW6CgcBer
         0aoo+XK40/Ut2vxV8yGJH32cBWqivUrLfQB6RzCbKfPmp0vljoKxDD2RyBO6O4zSUh
         M4iMMxajwSQFDV8q4Xk8keCW8W5jazDDXSrdPNnc=
Date:   Tue, 15 Jun 2021 17:06:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ian Kent <raven@themaw.net>
Cc:     Tejun Heo <tj@kernel.org>, Eric Sandeen <sandeen@sandeen.net>,
        Fox Chen <foxhlchen@gmail.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 1/6] kernfs: move revalidate to be near lookup
Message-ID: <YMjCA6sgzOThbt6Z@kroah.com>
References: <162375263398.232295.14755578426619198534.stgit@web.messagingengine.com>
 <162375275365.232295.8995526416263659926.stgit@web.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162375275365.232295.8995526416263659926.stgit@web.messagingengine.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 15, 2021 at 06:25:53PM +0800, Ian Kent wrote:
> While the dentry operation kernfs_dop_revalidate() is grouped with
> dentry type functions it also has a strong affinity to the inode
> operation ->lookup().
> 
> It makes sense to locate this function near to kernfs_iop_lookup()
> because we will be adding VFS negative dentry caching to reduce path
> lookup overhead for non-existent paths.
> 
> There's no functional change from this patch.
> 
> Signed-off-by: Ian Kent <raven@themaw.net>
> Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/kernfs/dir.c |   86 ++++++++++++++++++++++++++++---------------------------
>  1 file changed, 43 insertions(+), 43 deletions(-)

As everyone has agreed this patch does nothing wrong, I've applied this
one for now while everyone reviews the other ones :)

thanks,

greg k-h
