Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF2815038B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2020 10:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgBCJqL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Feb 2020 04:46:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:37520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727225AbgBCJqL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Feb 2020 04:46:11 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0C7F20661;
        Mon,  3 Feb 2020 09:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580723169;
        bh=cpHcIJWnPoW9Yc4NIdLt3pSB5DRMOPWeMU4+QtlXytI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VPi54hf79xB31jQGtnplBbvd91IGSz6Obahowwq55VPERR9JttFzlbdh6bZ2nATDe
         XDSHv9/N6WVxdVUn7oCBXpsVpBYAwlIoz6USaJJNZYghQ00c9q/4cDlt5h6RlGZIaq
         N5w3uSg4aKtbsGfZWgDkARjyKR4T/IE+Ga5VTURg=
Date:   Mon, 3 Feb 2020 09:46:01 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.mitsubishielectric.co.jp>,
        devel@driverdev.osuosl.org,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Mori.Takahiro@ab.mitsubishielectric.co.jp,
        linux-kernel@vger.kernel.org,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: exfat: remove DOSNAMEs.
Message-ID: <20200203094601.GA3040887@kroah.com>
References: <20200203163118.31332-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
 <20200203080532.GF8731@bombadil.infradead.org>
 <20200203081559.GA3038628@kroah.com>
 <20200203082938.GG8731@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203082938.GG8731@bombadil.infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 03, 2020 at 12:29:38AM -0800, Matthew Wilcox wrote:
> On Mon, Feb 03, 2020 at 08:15:59AM +0000, Greg Kroah-Hartman wrote:
> > On Mon, Feb 03, 2020 at 12:05:32AM -0800, Matthew Wilcox wrote:
> > > On Tue, Feb 04, 2020 at 01:31:17AM +0900, Tetsuhiro Kohada wrote:
> > > > remove 'dos_name','ShortName' and related definitions.
> > > > 
> > > > 'dos_name' and 'ShortName' are definitions before VFAT.
> > > > These are never used in exFAT.
> > > 
> > > Why are we still seeing patches for the exfat in staging?
> > 
> > Because people like doing cleanup patches :)
> 
> Sure, but I think people also like to believe that their cleanup patches
> are making a difference.  In this case, they're just churning code that's
> only weeks away from deletion.
> 
> > > Why are people not working on the Samsung code base?
> > 
> > They are, see the patches on the list, hopefully they get merged after
> > -rc1 is out.
> 
> I meant the cleanup people.  Obviously _some_ people are working on the
> Samsung codebase.

We can't tell people to work on :)
