Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6A4B305B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Sep 2019 15:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbfIONyO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Sep 2019 09:54:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:36602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbfIONyO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Sep 2019 09:54:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93D66214C6;
        Sun, 15 Sep 2019 13:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568555653;
        bh=TTUvGOD0UCo60psVmhopm9Jg7Es3S99N+IPaJwsltd4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KHc0lMPRfRStYGmvkeGU+eB74IQ8Tsvmad8+ieeCxRY6R9w9bFic71B3b3DelmXmC
         wwWnyfmwO1eBN2bAh+KIwYlA2uMIbW8oAmpZ575CCz6DtwK0MjLlBz/9iSlgKJPAy1
         yAHsaT1JRYkngxgtt87RK/h2LkcIQj6iveffNxuQ=
Date:   Sun, 15 Sep 2019 15:54:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Park Ju Hyung <qkrwngud825@gmail.com>
Cc:     alexander.levin@microsoft.com, devel@driverdev.osuosl.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        valdis.kletnieks@vt.edu
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to
Message-ID: <20190915135409.GA553917@kroah.com>
References: <20190828160817.6250-1-gregkh@linuxfoundation.org>
 <20190914133951.16501-1-qkrwngud825@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190914133951.16501-1-qkrwngud825@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 14, 2019 at 10:39:51PM +0900, Park Ju Hyung wrote:
> Hi.
> 
> I just noticed that this exfat-staging drivers are based on the old 
> Samsung's 1.x exFAT drivers.
> 
> I've been working to get the newer Samsung's driver(now named "sdFAT") 
> to fit better for general Linux users, and I believe it can provide a 
> better base for the community to work on(and hopefully complies better 
> to the mainline coding standard).
> 
> GitHub link
> https://github.com/arter97/exfat-linux
> 
> I also included some rudimentary benchmark results.
> 
> I encourage mainline developers to explore this driver base and see if 
> it's worth to switch, since it's the early days of exfat-staging.

Note, this just showed up publically on August 12, where were you with
all of this new code before then?  :)

> To others watching this thread:
> It's more than likely that you can start using exFAT reliably right 
> away by following the link above. It's tested on all major LTS kernels 
> ranging from 3.4 to 4.19 and the ones Canonical uses for Ubuntu: 3.4, 
> 3.10, 3.18, 4.1, 4.4, 4.9, 4.14, 4.19 and 4.15, 5.0, 5.2, and 5.3-rc.

For the in-kernel code, we would have to rip out all of the work you did
for all older kernels, so that's a non-starter right there.

As for what codebase to work off of, I don't want to say it is too late,
but really, this shows up from nowhere and we had to pick something so
we found the best we could at that point in time.

Is there anything specific in the codebase you have now, that is lacking
in the in-kernel code?  Old-kernel-support doesn't count here, as we
don't care about that as it is not applicable.  But functionality does
matter, what has been added here that we can make use of?

And do you have any "real" development history to look at instead of the
"one giant commit" of the initial code drop?  That is where we could
actually learn what has changed over time.  Your repo as-is shows none
of the interesting bits :(

thanks,

greg kh
