Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E898740C021
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 09:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236517AbhIOHIx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 03:08:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:53864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231305AbhIOHIw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 03:08:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B932461178;
        Wed, 15 Sep 2021 07:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631689654;
        bh=7z7Mazz8BLgGjouZIDVxIflsK7icf1h/qdtmII0eixg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LCojtIhXy/qUMIEOJqeqqFKLYrQ/LAg9g3nhSpz1Tb17caxZiQbGMm8Go9sVfrrIC
         JMmd3mJ2uNiYW6d21z5Jv6GAIEO1AL3Di77DszWHd6j34A0DrMAmfeTM4popRLD5ts
         PNpzBv0KHsD7ZiVbWSGaP8e4o350E6KO7P2Pt/xo=
Date:   Wed, 15 Sep 2021 09:07:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/13] xfs: convert xfs_sysfs attrs to use ->seq_show
Message-ID: <YUGbruik5nGJIBKk@kroah.com>
References: <20210913054121.616001-1-hch@lst.de>
 <20210913054121.616001-14-hch@lst.de>
 <YT7vZthsMCM1uKxm@kroah.com>
 <20210914073003.GA31077@lst.de>
 <YUC/iH9yLlxblM09@kroah.com>
 <20210914153011.GA815@lst.de>
 <YUDCsXXNFfUyiMCk@kroah.com>
 <20210915070445.GA17384@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915070445.GA17384@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 15, 2021 at 09:04:45AM +0200, Christoph Hellwig wrote:
> On Tue, Sep 14, 2021 at 05:41:37PM +0200, Greg Kroah-Hartman wrote:
> > They huge majority of sysfs attributes are "trivial".  So for maybe at
> > least 95% of the users, if not more, using sysfs_emit() is just fine as
> > all you "should" be doing is emitting a single value.
> 
> It is just fine if no one does the obvious mistakes that an interface
> with a char * pointer leads to.  And 5% of all attributes is still a huge
> attack surface.

It is probably less, I just pulled that number out of the air.  With the
other work we are doing to make sure we have documentation for all sysfs
attributes in the kernel, we will soon know the real number.

thanks,

greg k-h
