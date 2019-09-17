Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B825B46F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2019 07:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfIQFra (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Sep 2019 01:47:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:51486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbfIQFr3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Sep 2019 01:47:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77F6521670;
        Tue, 17 Sep 2019 05:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568699249;
        bh=AVcvkAscp3almTt+ZEb5Om2XnT1GXYzgOvOjeTLhP5Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v9wfoakWHsdeotJc5pXYISTjrwqZexbCiTIuhdOrQtvMNg4XTUMr/k3LcnJeVOupj
         Sv6ly9dTXs3uYL37+wVwcYdQj+o+SXRS+8t82/j2zAdCGkTYbpp8qg7anTE1ivyEMr
         pRnEYQ/X09TIK+rzlkpGmQhl0VCYl0XrXoscPzgs=
Date:   Tue, 17 Sep 2019 07:47:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Park Ju Hyung <qkrwngud825@gmail.com>
Cc:     valdis.kletnieks@vt.edu, namjae.jeon@samsung.com,
        devel@driverdev.osuosl.org, linkinjeon@gmail.com,
        linux-kernel@vger.kernel.org, alexander.levin@microsoft.com,
        sergey.senozhatsky@gmail.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to
Message-ID: <20190917054726.GA2058532@kroah.com>
References: <8998.1568693976@turing-police>
 <20190917053134.27926-1-qkrwngud825@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190917053134.27926-1-qkrwngud825@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 17, 2019 at 02:31:34PM +0900, Park Ju Hyung wrote:
> On Tue, 17 Sep 2019 00:19:36 -0400, "Valdis Klētnieks" said:
> > I'm working off a somewhat cleaned up copy of Samsung's original driver,
> > because that's what I had knowledge of.  If the sdfat driver is closer to being
> > mergeable, I'd not object if that got merged instead.
> 
> Greg, as Valdis mentioned here, the staging tree driver is just another exFAT fork
> from Samsung.
> What's the point of using a much older driver?

It's the fact that it actually was in a form that could be merged, no
one has done that with the sdfat code :)

> sdFAT is clearly more matured and been put into more recent production softwares.
> And as I wrote in previous email, it does include some real fixes.

What fixes?  That's what I'm asking here.

How do we "know" that this is better than what we currently have today?
We don't, so it's a bit hard to tell someone, "delete the work you did
and replace it with this other random chunk of code, causing you a bunch
more work in the process for no specific reason other than it looks
'newer'." :(

> As Namjae said too, Samsung would be more interested in merging sdFAT to upstream.
> If we diverge, Samsung will have less reasons to contribute their patches to upstream.

Are they going to do this if we do take the sdfat code?  If so, great,
but I need to get someone to agree that this will happen.

> Also, I think it makes much more sense to make Samsung the maintainer of this driver
> (if they're willing to put in the manpower to do so). Asking them would be the first
> step in doing so.

They are more than willing to start contributing and being a
co-maintainer of it, it needs all the help it can get.

But "someone" from samsung, or anywhere else, has to be willing to step
up here and do this work.  Without that happening, I don't see a reason
to change at this point in time.

Rembember, kernel development happens because people do the work, which
Valdis did, and continues to do.  Throwing that away because of the
thought that someone else might do some work in the future is not how we
work.

I recommend looking at what we have in the tree now, and seeing what is
missing compared to "sdfat".  I know a lot of places in the exfat code
that needs to be fixed up, odds are they are the same stuff that needs
to be resolved in sdfat as well.

thanks,

greg k-h
