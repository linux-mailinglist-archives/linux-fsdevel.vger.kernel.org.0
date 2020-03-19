Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5DE518B9CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Mar 2020 15:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbgCSOxh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Mar 2020 10:53:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:37172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727095AbgCSOxh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Mar 2020 10:53:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9792E20782;
        Thu, 19 Mar 2020 14:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584629615;
        bh=JE2qa3Ql7pc+/2N++R3hBXArgNKfwamDcdjikVhQKuw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MbaqvIp3NeZ2Ts7YM4honKltBarCX3PMmsuxj4gAimXlWBEbsvyKqW2ypSAQRiuqZ
         P/fLPpxQ+YS3EyouageK93NAsvKoOeXLnKinW9DYy1rgw59jhlSM50pLEbUgp7vqH6
         E/hLjm/ZGkkCPB0FuulF+2khHHLU4NznbDr5ataU=
Date:   Thu, 19 Mar 2020 15:53:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Aravind Ceyardass <aravind.pub@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        valdis.kletnieks@vt.edu
Subject: Re: [PATCH] staging: exfat: Fix checkpatch.pl camelcase issues
Message-ID: <20200319145332.GA92193@kroah.com>
References: <20200319140647.3926-1-aravind.pub@gmail.com>
 <20200319141243.GA30888@kroah.com>
 <1fed9204-59fb-8a1e-5adf-28183b3651e4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fed9204-59fb-8a1e-5adf-28183b3651e4@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 19, 2020 at 10:31:05AM -0400, Aravind Ceyardass wrote:
> 
> 
> On 3/19/20 10:12 AM, Greg KH wrote:
> > On Thu, Mar 19, 2020 at 10:06:47AM -0400, Aravind Ceyardass wrote:
> >> Fix ffsCamelCase function names and mixed case enums
> >>
> >> Signed-off-by: Aravind Ceyardass <aravind.pub@gmail.com>
> >> ---
> >>  drivers/staging/exfat/TODO          |   1 -
> >>  drivers/staging/exfat/exfat.h       |  12 +-
> >>  drivers/staging/exfat/exfat_super.c | 222 ++++++++++++++--------------
> >>  3 files changed, 117 insertions(+), 118 deletions(-)
> > 
> > These files are not in linux-next, or in my tree, anymore.
> > 
> > Please always work against the latest development tree so you do not
> > waste duplicated effort.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> As a very beginner, I used the staging(git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git) tree based on what I read on kernelnewbies.org
> 
> What tree or branch should I use instead?

That's the correct tree, but you probably forgot to use the staging-next
branch, right?

hope this helps,

greg k-h
