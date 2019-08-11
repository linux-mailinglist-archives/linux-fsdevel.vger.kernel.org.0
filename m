Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF4F89039
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Aug 2019 09:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfHKHkJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Aug 2019 03:40:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:54800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbfHKHkJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Aug 2019 03:40:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACA67216F4;
        Sun, 11 Aug 2019 07:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565509208;
        bh=/1gjey0TqRaRx3ZGdIl2e5tjjFIwmD7J8Bw4iEC1N80=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kU9dGSeSLajH1Z9LyMlIjdBTOEiiRYqEFgLn4OMt/zqu2FwiTpPV6O4v0T9Rw7EfA
         l6nHGmOPcXgYY5/tltQdWVbrYwdltTgRIWUgQ0l53Oq5rIGIZbOlW9CCAiC/7Sig7L
         zNgU50o907xl8CTkxFKQuEOK/9SPTOzSX++LBDuQ=
Date:   Sun, 11 Aug 2019 09:40:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: Merging virtualbox shared-folder VFS driver through
 drivers/staging?
Message-ID: <20190811074005.GA4765@kroah.com>
References: <f2a9c3c0-62da-0d70-4062-47d00ab530e0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2a9c3c0-62da-0d70-4062-47d00ab530e0@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 11, 2019 at 12:25:03AM +0200, Hans de Goede wrote:
> Hi Al,
> 
> I've been trying to get the vboxsf fs code upstream for 1.5 years now,
> it seems (to me) that the main problem is that no-one has time to
> review it. You're reviewed it a couple of times and David Howells
> has reviewed it 2 times. Al reviews have lead to various improvments
> and have definitely been useful, so thank you for that.
> 
> But ATM, since posting v12 of the patch, it has again been quiet for
> 2 months again. Since this driver is already being used as addon /
> our of tree driver by various distros, I would really like to get it
> into mainline, to make live easier for distros and to make sure that
> they use the latest version.
> 
> Since I do not see the lack of reviewing capacity problem get solved
> anytime soon, I was wondering if you are ok with putting the code
> in drivers/staging/vboxsf for now, until someone can review it and ack it
> for moving over to sf/vboxsf ?

I have no objection to that if the vfs developers do not mind.

thanks,

greg k-h
