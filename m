Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36E98E721B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2019 13:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbfJ1Mul (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Oct 2019 08:50:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:42728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726940AbfJ1Mul (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Oct 2019 08:50:41 -0400
Received: from localhost (unknown [91.217.168.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 180E420873;
        Mon, 28 Oct 2019 12:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572267040;
        bh=spK40+H3cQpvOVWI4gd7Amk1DPujXsJJrHzp96i1hRo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iTVRaot0Ih8qtyMS/GPUdkJeIh/LEztBESPXMuSb0JO8swZbPw/Paws4t6PcalK3V
         RrN6VuG8yeQKeU0OHE3IxQ68i7JTE2ddiTqhDanzUeM/1eAQcAqjGJR7pZM9i81lfj
         V81Xbmc2aT6Z+3NmJhrfKPslTwK6nVy66OddFsWA=
Date:   Mon, 28 Oct 2019 12:41:59 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v17 0/1] staging: Add VirtualBox guest shared folder
 (vboxsf) support
Message-ID: <20191028114159.GA6961@kroah.com>
References: <20191028111744.143863-1-hdegoede@redhat.com>
 <20191028113950.GA2406@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028113950.GA2406@infradead.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 28, 2019 at 04:39:50AM -0700, Christoph Hellwig wrote:
> On Mon, Oct 28, 2019 at 12:17:43PM +0100, Hans de Goede wrote:
> > Hi Greg,
> > 
> > As discussed previously can you please take vboxsf upstream through
> > drivers/staging?
> > 
> > It has seen many revisions on the fsdevel list, but it seems that the
> > fsdevel people are to busy to pick it up.
> > 
> > Previous versions of this patch have been reviewed by Al Viro, David Howells
> > and Christoph Hellwig (all in the Cc) and I believe that the current
> > version addresses all their review remarks.
> 
> Please just send it to Linus directly.  This is the equivalent of
> consumer hardware enablement and it is in a state as clean as it gets
> for the rather messed up protocol.

I can add it to my patches to go to Linus for 5.4-final if you don't
object to it going into drivers/staging/

thanks,

greg k-h
