Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF47A1525
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 11:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfH2JuX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 05:50:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:37626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbfH2JuX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 05:50:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FB47233A1;
        Thu, 29 Aug 2019 09:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567072222;
        bh=YDdsum+qhuDxQlXkQh1jgcwFqVQTWLCuOHt3KTVyJKw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fe3cYth+gCYjtMMhkM4ZXG9SjtEc2qsZhNaJdn+1iJ4QonaeJAtVwsOOkTavtNzBW
         559hW6GeJdnBDp8i8kXno7t/3PFHqDrV7SxzDEBEwu/WWJ12aEf7LTcsS0epSNYvHu
         uZRfd9v+PUCrGHh4n7uh6uEGyD8VLidiSH0temrQ=
Date:   Thu, 29 Aug 2019 11:50:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     devel@driverdev.osuosl.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to staging
Message-ID: <20190829095019.GA13557@kroah.com>
References: <20190828160817.6250-1-gregkh@linuxfoundation.org>
 <20190828170022.GA7873@kroah.com>
 <20190829062340.GB3047@infradead.org>
 <20190829063955.GA30193@kroah.com>
 <20190829094136.GA28643@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829094136.GA28643@infradead.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 29, 2019 at 02:41:36AM -0700, Christoph Hellwig wrote:
> On Thu, Aug 29, 2019 at 08:39:55AM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Aug 28, 2019 at 11:23:40PM -0700, Christoph Hellwig wrote:
> > > Can we please just review the damn thing and get it into the proper
> > > tree?  That whole concept of staging file systems just has been one
> > > fricking disaster, including Greg just moving not fully reviewed ones
> > > over like erofs just because he feels like it.  I'm getting sick and
> > > tired of this scheme.
> > 
> > For this filesystem, it's going to be a _lot_ of work before that can
> > happen, and I'd really like to have lots of people help out with it
> > instead of it living in random github trees for long periods of time.
> 
> Did you actually look at the thing instead of blindly applying some
> pile of crap?
> 
> It basically is a reimplementation of fs/fat/ not up to kernel standards
> with a few indirections thrown in to also support exfat.  So no amount
> of work on this codebase is really going to bring us forward.  Instead
> someone how can spend a couple days on this and actually has file
> systems to test it just needs to bring the low-level format bits over
> to our well tested fs/fat codebase instead of duplicating it.

I did try just that, a few years ago, and gave up on it.  I don't think
it can be added to the existing vfat code base but I am willing to be
proven wrong.

Now that we have the specs, it might be easier, and the vfat spec is a
subset of the exfat spec, but to get stuff working today, for users,
it's good to have it in staging.  We can do the normal, "keep it in
stable, get a clean-room implementation merged like usual, and then
delete the staging version" three step process like we have done a
number of times already as well.

I know the code is horrible, but I will gladly take horrible code into
staging.  If it bothers you, just please ignore it.  That's what staging
is there for :)

thanks,

greg k-h
