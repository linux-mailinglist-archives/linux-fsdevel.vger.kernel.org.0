Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD00376CC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2019 16:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbfFFOdJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jun 2019 10:33:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:42824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727133AbfFFOdJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jun 2019 10:33:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2E4620673;
        Thu,  6 Jun 2019 14:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559831588;
        bh=/2jJJ5oG2cISFINJKQe1EgAmoS+dF35UJQdmAaBdaNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vIL9tsxaJCJ6vmzNR4W5rYK5l1deky/3ctGG8Pold6Jk8WI2e71x0lSPFlLVWy+5X
         6OjNoesUKJ2twjzicbxxgesIRYfRAal2qoLQEa9SfsYJ294nTr71ci0Jj4ufRCNZ/q
         zVNjY+QFddmc9uFjoz911UcJn2YsMRxZVjUM77VY=
Date:   Thu, 6 Jun 2019 16:33:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk,
        linux-usb@vger.kernel.org, raven@themaw.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/10] usb: Add USB subsystem notifications [ver #3]
Message-ID: <20190606143306.GA11294@kroah.com>
References: <155981420247.17513.18371208824032389940.stgit@warthog.procyon.org.uk>
 <Pine.LNX.4.44L0.1906061020000.1641-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1906061020000.1641-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 06, 2019 at 10:24:18AM -0400, Alan Stern wrote:
> On Thu, 6 Jun 2019, David Howells wrote:
> 
> > Add a USB subsystem notification mechanism whereby notifications about
> > hardware events such as device connection, disconnection, reset and I/O
> > errors, can be reported to a monitoring process asynchronously.
> 
> USB I/O errors covers an awfully large and vague field.  Do we really
> want to include them?  I'm doubtful.

See the other patch on the linux-usb list that wanted to start adding
KOBJ_CHANGE notifications about USB "i/o errors".

So for "severe" issues, yes, we should do this, but perhaps not for all
of the "normal" things we see when a device is yanked out of the system
and the like.

thanks,

greg k-h
