Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A889F3773A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2019 16:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbfFFOzZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jun 2019 10:55:25 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:52002 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728682AbfFFOzZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jun 2019 10:55:25 -0400
Received: (qmail 3851 invoked by uid 2102); 6 Jun 2019 10:55:24 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Jun 2019 10:55:24 -0400
Date:   Thu, 6 Jun 2019 10:55:24 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     David Howells <dhowells@redhat.com>, <viro@zeniv.linux.org.uk>,
        <linux-usb@vger.kernel.org>, <raven@themaw.net>,
        <linux-fsdevel@vger.kernel.org>, <linux-api@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <keyrings@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 09/10] usb: Add USB subsystem notifications [ver #3]
In-Reply-To: <20190606143306.GA11294@kroah.com>
Message-ID: <Pine.LNX.4.44L0.1906061051310.1641-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 6 Jun 2019, Greg Kroah-Hartman wrote:

> On Thu, Jun 06, 2019 at 10:24:18AM -0400, Alan Stern wrote:
> > On Thu, 6 Jun 2019, David Howells wrote:
> > 
> > > Add a USB subsystem notification mechanism whereby notifications about
> > > hardware events such as device connection, disconnection, reset and I/O
> > > errors, can be reported to a monitoring process asynchronously.
> > 
> > USB I/O errors covers an awfully large and vague field.  Do we really
> > want to include them?  I'm doubtful.
> 
> See the other patch on the linux-usb list that wanted to start adding
> KOBJ_CHANGE notifications about USB "i/o errors".

That patch wanted to add notifications only for enumeration failures
(assuming you're talking about the patch from Eugeniu Rosca), not I/O
errors in general.

> So for "severe" issues, yes, we should do this, but perhaps not for all
> of the "normal" things we see when a device is yanked out of the system
> and the like.

Then what counts as a "severe" issue?  Anything besides enumeration 
failure?

Alan Stern

