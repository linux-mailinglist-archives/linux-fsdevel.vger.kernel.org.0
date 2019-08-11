Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9BE8903E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Aug 2019 09:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbfHKHuq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Aug 2019 03:50:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:56052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbfHKHuq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Aug 2019 03:50:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D06DD216F4;
        Sun, 11 Aug 2019 07:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565509845;
        bh=horouIeBkokBTcfwVlD6AMK3cmi0ExWMDGVCM0OQzcQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1m2Ro1NUCdv7f0cmOz1PuOD4rTr/h4SEZzLOEoxSoRSVNH47/0YJY0lcOKaP0L/6W
         J+LyEsHZMuy+sv/FcblfnOtLX9HSSNtws6CHvbhLGVChlHXgdE+Wy8PGAuVcDS9nr1
         2OdCKAFsF2NjJTWbhS8EkzwNHGMpqY6dr6YxePtg=
Date:   Sun, 11 Aug 2019 09:50:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: Merging virtualbox shared-folder VFS driver through
 drivers/staging?
Message-ID: <20190811075042.GA6308@kroah.com>
References: <f2a9c3c0-62da-0d70-4062-47d00ab530e0@redhat.com>
 <20190811074005.GA4765@kroah.com>
 <20190811074348.GA13485@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190811074348.GA13485@infradead.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 11, 2019 at 12:43:48AM -0700, Christoph Hellwig wrote:
> On Sun, Aug 11, 2019 at 09:40:05AM +0200, Greg Kroah-Hartman wrote:
> > > Since I do not see the lack of reviewing capacity problem get solved
> > > anytime soon, I was wondering if you are ok with putting the code
> > > in drivers/staging/vboxsf for now, until someone can review it and ack it
> > > for moving over to sf/vboxsf ?
> > 
> > I have no objection to that if the vfs developers do not mind.
> 
> We had really bad experiences with fs code in staging.  I think it is
> a bad idea that should not be repeated.

Lustre was a mistake.  erofs is better in that there are active
developers working to get it out of staging.  We would also need that
here for this to be successful.

Hans, is it just review that is keeping this from being merged or is
there "real work" that has to be done?

thanks,

greg k-h
