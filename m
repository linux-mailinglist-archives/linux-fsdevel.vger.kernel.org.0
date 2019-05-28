Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57AC72D28D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 01:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfE1X6M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 May 2019 19:58:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:47246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbfE1X6M (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 May 2019 19:58:12 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92D2D206A2;
        Tue, 28 May 2019 23:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559087891;
        bh=2/9Fxe21+aSpbnetaRujBaWdJtuoEjDDkYN8K88SIFk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WG2LdxJyprEyxX57qo3pc4GeSrD1bjohQDzHZ8JGZCCCb8p9opJf8UZTn/Als63Ww
         gIYK+hmpYUySg112uWTnR9XNdYTs1yGdVoC3jca2USk9yRLvoboFFb69J08kMjYXgp
         JkJlpiZsacDuiWEYHJ6WhxvIP9kjs+62ZS7qqayI=
Date:   Tue, 28 May 2019 16:58:10 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, raven@themaw.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 0/7] Mount, FS, Block and Keyrings notifications
Message-ID: <20190528235810.GA5776@kroah.com>
References: <155905930702.7587.7100265859075976147.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155905930702.7587.7100265859075976147.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 28, 2019 at 05:01:47PM +0100, David Howells wrote:
> Things I want to avoid:
> 
>  (1) Introducing features that make the core VFS dependent on the network
>      stack or networking namespaces (ie. usage of netlink).
> 
>  (2) Dumping all this stuff into dmesg and having a daemon that sits there
>      parsing the output and distributing it as this then puts the
>      responsibility for security into userspace and makes handling
>      namespaces tricky.  Further, dmesg might not exist or might be
>      inaccessible inside a container.
> 
>  (3) Letting users see events they shouldn't be able to see.

How are you handling namespaces then?  Are they determined by the
namespace of the process that opened the original device handle, or the
namespace that made the new syscall for the events to "start flowing"?

Am I missing the logic that determines this in the patches, or is that
not implemented yet?

thanks,

greg k-h
