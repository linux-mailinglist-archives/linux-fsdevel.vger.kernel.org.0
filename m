Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3732891E7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Aug 2019 15:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfHKNti (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Aug 2019 09:49:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:44346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726424AbfHKNti (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Aug 2019 09:49:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC2B02084D;
        Sun, 11 Aug 2019 13:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565531377;
        bh=AarOZVmkF9EBh/dxzQ25Lx0SrzGtpLfLDrGltdb/w7Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0NOgUTW3QoOAJxxkdsIhBMUxqrrxcBqjE5pccPEOzVZMRwU3xjepVCQsIxeGg1zex
         ReP696CEE4Lo75IiDg6ZwMXSf3vCxY/c0G4u5KDtKYj77zFZkNqCa7cRXLKr/vregg
         DyNpiIzqNAehxb7uKO4MPQRar32/qF7umvxYzKoY=
Date:   Sun, 11 Aug 2019 15:49:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: Merging virtualbox shared-folder VFS driver through
 drivers/staging?
Message-ID: <20190811134934.GA22129@kroah.com>
References: <f2a9c3c0-62da-0d70-4062-47d00ab530e0@redhat.com>
 <20190811074005.GA4765@kroah.com>
 <20190811074348.GA13485@infradead.org>
 <20190811075042.GA6308@kroah.com>
 <56acdce2-b9b2-b078-b1cd-3f025e63a435@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56acdce2-b9b2-b078-b1cd-3f025e63a435@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 11, 2019 at 03:43:01PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 8/11/19 9:50 AM, Greg Kroah-Hartman wrote:
> > On Sun, Aug 11, 2019 at 12:43:48AM -0700, Christoph Hellwig wrote:
> > > On Sun, Aug 11, 2019 at 09:40:05AM +0200, Greg Kroah-Hartman wrote:
> > > > > Since I do not see the lack of reviewing capacity problem get solved
> > > > > anytime soon, I was wondering if you are ok with putting the code
> > > > > in drivers/staging/vboxsf for now, until someone can review it and ack it
> > > > > for moving over to sf/vboxsf ?
> > > > 
> > > > I have no objection to that if the vfs developers do not mind.
> > > 
> > > We had really bad experiences with fs code in staging.  I think it is
> > > a bad idea that should not be repeated.
> > 
> > Lustre was a mistake.  erofs is better in that there are active
> > developers working to get it out of staging.  We would also need that
> > here for this to be successful.
> > 
> > Hans, is it just review that is keeping this from being merged or is
> > there "real work" that has to be done?
> 
> AFAIK it is just the reveiw which is keeping this from being merged.
> 
> During the first few revision Al Viro made some very good suggestions
> which have all been addressed, v10 was reviewed by David Howell, and the
> main thing to fix for that was switching over to the new mountfd APIs,
> v11 was also revieded by David and had some minor issues with the use
> of the new mountfd APIs. Those were all addressed for v12. So currently
> the TODO list for this fs code is empty.

Then in that case it doesn't sound like putting it in staging makes any
sense.  It should just be merged to the "correct" place right away as
nothing is left to be done on it.

thanks,

greg k-h
