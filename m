Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B56443E54
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 17:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389236AbfFMPsw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 11:48:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:45638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731709AbfFMJOd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jun 2019 05:14:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EF0D2133D;
        Thu, 13 Jun 2019 09:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560417272;
        bh=YHsBlYY6tsrVcysOLrS4tUMHlZFvYKYdWz8QfYHbYF0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aWKMs2qselRXwjVuccRgFuwYdWSJG9elv1+wDvNoy3snAq8CN1VPvkgRhEyAHNx7R
         /grEVBUAKWwzzK+buGMkQHcXsHuJriEn2gbOqTolAQKs/XCDEF4K11idIYljbvfHnp
         T9sRFlavEToI0bbB0gO8Ddn2fWDn1ExlbSmjQcEA=
Date:   Thu, 13 Jun 2019 11:14:30 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Stephen Bates <sbates@raithlin.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shhuiw@foxmail.com" <shhuiw@foxmail.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] io_uring: fix SQPOLL cpu check
Message-ID: <20190613091430.GA28704@kroah.com>
References: <5D2859FE-DB39-48F5-BBB5-6EDD3791B6C3@raithlin.com>
 <20190612092403.GA38578@lakrids.cambridge.arm.com>
 <DCE71F95-F72A-414C-8A02-98CC81237F40@raithlin.com>
 <b3c9138e-bf3b-0851-a63e-f52f926d5ed8@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b3c9138e-bf3b-0851-a63e-f52f926d5ed8@kernel.dk>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 13, 2019 at 02:54:45AM -0600, Jens Axboe wrote:
> On 6/12/19 3:47 AM, Stephen  Bates wrote:
> >> Aargh. My original patch [1] handled that correctly, and this case was
> >> explicitly called out in the commit message, which was retained even
> >> when the patch was "simplified". That's rather disappointing. :/
> >    
> > It looks like Jens did a fix for this (44a9bd18a0f06bba
> > " io_uring: fix failure to verify SQ_AFF cpu") which is in the 5.2-rc series
> > but which hasn’t been applied to the stable series yet. I am not sure how
> > I missed that but it makes my patch redundant.
> > 
> > Jens, will 44a9bd18a0f06bba be applied to stable kernels?
> 
> Yes, we can get it flagged for stable. Greg, can you pull in the above
> commit for 5.1 stable?

Now snuck in for the next 5.1.y release, thanks.

greg k-h
