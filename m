Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59C04A11DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 08:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbfH2Gj7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 02:39:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:51762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbfH2Gj6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 02:39:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86B682073F;
        Thu, 29 Aug 2019 06:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567060798;
        bh=VNuUc6IyKWx85KyY61iMOgz8tWUh22jdpJcnZlZWmt8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WoridwAuLrsfYOsar6PHvzlckR8Kx9ShOS0CE1gdrXsTtUSNcUeU2RwVKRHkBEvjT
         o1/KkXc7Ocj9Hg2uaHsCSxe8HvHyV0r5vyHVtZ/scTcMklU6Ss9z5UjIrPiN1bTHtU
         0QwzQ0A0YbSfQTVEynKjAQ3t/QxbEjRNJiu1C2yQ=
Date:   Thu, 29 Aug 2019 08:39:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to staging
Message-ID: <20190829063955.GA30193@kroah.com>
References: <20190828160817.6250-1-gregkh@linuxfoundation.org>
 <20190828170022.GA7873@kroah.com>
 <20190829062340.GB3047@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829062340.GB3047@infradead.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 28, 2019 at 11:23:40PM -0700, Christoph Hellwig wrote:
> Can we please just review the damn thing and get it into the proper
> tree?  That whole concept of staging file systems just has been one
> fricking disaster, including Greg just moving not fully reviewed ones
> over like erofs just because he feels like it.  I'm getting sick and
> tired of this scheme.

For this filesystem, it's going to be a _lot_ of work before that can
happen, and I'd really like to have lots of people help out with it
instead of it living in random github trees for long periods of time.

Putting it in the kernel lets all of the people that have been spending
time on this work together in one place.

Given that the vfs apis change so infrequently, I don't really
understand the objection here.  If you change apis in the rest of the
kernel, don't worry about anything in drivers/staging/ I will fix that
up.  This code has a much smaller api-interaction-level than lots of the
drivers that are currently living in staging.

thanks,

greg k-h
