Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6169E150482
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2020 11:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgBCKqK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Feb 2020 05:46:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:48754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbgBCKqK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Feb 2020 05:46:10 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D81DC20661;
        Mon,  3 Feb 2020 10:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580726769;
        bh=/paHcOi+xB86rjIjYyLdXCYTLMIaivBy8llnLyFh7pU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P/T7npADd7+0nzPxCVf9hGGeVcTdpJBqO5uAxFzyN+utq6YrZCUAzwkhQMpNn9yNf
         JoEMFQthG5Jp/5FPIEPkiIDIeh8uDXT1SUYfqp3ZiJ2Q0B8M6247UtJ//J42Un4ot8
         dYtB7NuiAcXLTc9v3CxxskDU3lZ2VnpKE5h7fT2Q=
Date:   Mon, 3 Feb 2020 10:46:07 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.mitsubishielectric.co.jp>,
        devel@driverdev.osuosl.org,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Mori.Takahiro@ab.mitsubishielectric.co.jp,
        linux-kernel@vger.kernel.org,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: exfat: remove DOSNAMEs.
Message-ID: <20200203104607.GA3130629@kroah.com>
References: <20200203163118.31332-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
 <20200203080532.GF8731@bombadil.infradead.org>
 <20200203081559.GA3038628@kroah.com>
 <20200203082938.GG8731@bombadil.infradead.org>
 <20200203094601.GA3040887@kroah.com>
 <5f67af4339e0b9b56b43fb78ebab73e05009e307.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f67af4339e0b9b56b43fb78ebab73e05009e307.camel@perches.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 03, 2020 at 02:40:43AM -0800, Joe Perches wrote:
> On Mon, 2020-02-03 at 09:46 +0000, Greg Kroah-Hartman wrote:
> > On Mon, Feb 03, 2020 at 12:29:38AM -0800, Matthew Wilcox wrote:
> > > On Mon, Feb 03, 2020 at 08:15:59AM +0000, Greg Kroah-Hartman wrote:
> > > > On Mon, Feb 03, 2020 at 12:05:32AM -0800, Matthew Wilcox wrote:
> > > > > On Tue, Feb 04, 2020 at 01:31:17AM +0900, Tetsuhiro Kohada wrote:
> > > > > > remove 'dos_name','ShortName' and related definitions.
> > > > > > 
> > > > > > 'dos_name' and 'ShortName' are definitions before VFAT.
> > > > > > These are never used in exFAT.
> > > > > 
> > > > > Why are we still seeing patches for the exfat in staging?
> > > > 
> > > > Because people like doing cleanup patches :)
> > > 
> > > Sure, but I think people also like to believe that their cleanup patches
> > > are making a difference.  In this case, they're just churning code that's
> > > only weeks away from deletion.
> > > 
> > > > > Why are people not working on the Samsung code base?
> > > > 
> > > > They are, see the patches on the list, hopefully they get merged after
> > > > -rc1 is out.
> > > 
> > > I meant the cleanup people.  Obviously _some_ people are working on the
> > > Samsung codebase.
> > 
> > We can't tell people to work on :)
> 
> That's more an argument to remove exfat from staging
> sooner than later.

I will remove it when the other patchset is merged, let's not remove
code that is being used, that's not how we do things, you all know
this...

greg k-h
