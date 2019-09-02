Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1C15A5C84
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 21:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfIBTGW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 15:06:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:37506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbfIBTGW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 15:06:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2209321883;
        Mon,  2 Sep 2019 19:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567451181;
        bh=zvRcbQCOY51GKOL5qbyTT97X2kqYQ4CVAIpuSfcp7o8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lmWXZApgoxbrSptmsO4LuoMFe+B2CSSNeTx4sy7Itg3caSDGj/n0qJmj2OuZgeYeM
         tHBHUB715zWlMS3R4s7H2lYdA9cs+/r5/fETLy4BJYDYvy6sbogNHT9q5px030ZniO
         FI/zmQ1ubYy+8XSX7RBjcc0jg0aP9Ta4QGLrrHVc=
Date:   Mon, 2 Sep 2019 21:06:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Christoph Hellwig <hch@infradead.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/staging/exfat - by default, prohibit mount of
 fat/vfat
Message-ID: <20190902190619.GA25019@kroah.com>
References: <245727.1567183359@turing-police>
 <20190830164503.GA12978@infradead.org>
 <267691.1567212516@turing-police>
 <20190831064616.GA13286@infradead.org>
 <295233.1567247121@turing-police>
 <20190902073525.GA18988@infradead.org>
 <20190902152524.GA4964@kroah.com>
 <501797.1567450817@turing-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <501797.1567450817@turing-police>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 02, 2019 at 03:00:17PM -0400, Valdis Klētnieks wrote:
> On Mon, 02 Sep 2019 17:25:24 +0200, Greg Kroah-Hartman said:
> 
> > I dug up my old discussion with the current vfat maintainer and he said
> > something to the affect of, "leave the existing code alone, make a new
> > filesystem, I don't want anything to do with exfat".
> >
> > And I don't blame them, vfat is fine as-is and stable and shouldn't be
> > touched for new things.
> >
> > We can keep non-vfat filesystems from being mounted with the exfat
> > codebase, and make things simpler for everyone involved.
> 
> Ogawa:
> 
> Is this still your position, that you want exfat to be a separate module?

Personally I agree that this should be separate at least for quite some
time to shake things out at the very least.  But I'll defer to Ogawa if
he thinks things should be merged.

thanks,

greg k-h
