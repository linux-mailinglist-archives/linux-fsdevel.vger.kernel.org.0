Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1143CD97DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2019 18:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405923AbfJPQuJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 12:50:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:42606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405336AbfJPQuJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 12:50:09 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 131FF2168B;
        Wed, 16 Oct 2019 16:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571244608;
        bh=sqgHreqTi1i3Tx4fYKNWwFE1NCar570i6YUyioSamHs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y3KxXTSgx0HNgc35dznykNn4WPs1cwbSSyV+Q1ROXqEcuEFScltR+kjzdA2h+9Axi
         cqWgql0vuRPvZUZ6PEIJ0aoWK9dsazJYz5R58UeQSGUJDGnCXZMvwzb6qIn1mu+jVc
         NRC+CMy1wZpIRpf2cY0QchC8+5TcfEdz7W4AF528=
Date:   Wed, 16 Oct 2019 09:50:01 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     Sasha Levin <sashal@kernel.org>, devel@driverdev.osuosl.org,
        Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to staging
Message-ID: <20191016165001.GA639209@kroah.com>
References: <20190828160817.6250-1-gregkh@linuxfoundation.org>
 <20190829205631.uhz6jdboneej3j3c@pali>
 <184209.1567120696@turing-police>
 <20190829233506.GT5281@sasha-vm>
 <20190830075647.wvhrx4asnkrfkkwk@pali>
 <20191016140353.4hrncxa5wkx47oau@pali>
 <20191016143113.GS31224@sasha-vm>
 <20191016160349.pwghlg566hh2o7id@pali>
 <20191016162211.GA505532@kroah.com>
 <20191016163231.dgvurzdqcifunw35@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191016163231.dgvurzdqcifunw35@pali>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 16, 2019 at 06:32:31PM +0200, Pali Rohár wrote:
> On Wednesday 16 October 2019 09:22:11 Greg Kroah-Hartman wrote:
> > On Wed, Oct 16, 2019 at 06:03:49PM +0200, Pali Rohár wrote:
> > > > Can I assume you will be implementing TexFAT support once the spec is
> > > > available?
> > > 
> > > I cannot promise that I would implement something which I do not know
> > > how is working... It depends on how complicated TexFAT is and also how
> > > future exfat support in kernel would look like.
> > > 
> > > But I'm interesting in implementing it.
> > 
> > What devices need TexFAT?  I thought it the old devices that used it are
> > long obsolete and gone.  How is this feature going to be tested/used?
> 
> Hi Greg! Per 3.1.16 of exFAT specification [1], TexFAT extension is the
> only way how to use more FAT tables, like in FAT32 (where you normally
> have two FATs). Secondary FAT table can be used e.g. for redundancy or
> data recovery. For FAT32 volumes, e.g. fsck.fat uses secondary FAT table
> when first one is corrupted.
> 
> Usage of just one FAT table in exFAT is just step backward from FAT32 as
> secondary FAT table is sometimes the only way how to recover broken FAT
> fs. So I do not think that exFAT is for old devices, but rather
> non-exFAT is for old devices. Modern filesystems have journal or other
> technique to do (fast|some) recovery, exFAT has nothing.
> 
> And how is this feature going to be used? That depends on specification.
> 
> [1] - https://docs.microsoft.com/en-us/windows/win32/fileio/exfat-specification#3116-numberoffats-field

Ok, but given that the "only" os that can read/write the TexFAT
extension is WinCE, and that os is obsolete these days, it might be hard
to find images to test/validate against :)

But hey, I'll take the patch if you write it, no objection!

thanks,

greg k-h
